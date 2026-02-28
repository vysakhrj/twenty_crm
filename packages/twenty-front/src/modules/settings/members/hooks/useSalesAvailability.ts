import { getTokenPair } from '@/apollo/utils/getTokenPair';
import { REACT_APP_SERVER_BASE_URL } from '~/config';
import { useCallback, useState } from 'react';

export type SalesStatus = 'ACTIVE' | 'INACTIVE';
export type SalesStatusReason =
  | 'AVAILABLE'
  | 'LEAVE'
  | 'UNAVAILABLE_DAY'
  | 'UNAVAILABLE_HOURS';

export type SalesUserStatusRecord = {
  workspaceMemberId: string;
  name: string;
  availabilityStartTime: string;
  availabilityEndTime: string;
  availableDays: string[];
  leaveStartDate: string | null;
  leaveEndDate: string | null;
  status: {
    status: SalesStatus;
    reason: SalesStatusReason;
  };
};

type UpdateSalesAvailabilityPayload = {
  availabilityStartTime?: string;
  availabilityEndTime?: string;
  availableDays?: string[];
};

type UpdateSalesLeavePayload = {
  leaveDate?: string;
  leaveStartDate?: string;
  leaveEndDate?: string;
  clearLeave?: boolean;
};

const SALES_API_BASE_URL = `${REACT_APP_SERVER_BASE_URL}/api/lead/create-with-person`;

const buildAuthHeaders = () => {
  const token = getTokenPair()?.accessOrWorkspaceAgnosticToken?.token;

  return {
    'Content-Type': 'application/json',
    Authorization: token ? `Bearer ${token}` : '',
  };
};

const parseResponseOrThrow = async (response: Response) => {
  const json = await response.json().catch(() => ({}));

  if (!response.ok) {
    throw new Error(
      json?.message ?? `Request failed: ${response.status} ${response.statusText}`,
    );
  }

  return json;
};

export const useSalesAvailability = () => {
  const [salesStatusesByMemberId, setSalesStatusesByMemberId] = useState<
    Record<string, SalesUserStatusRecord>
  >({});
  const [isLoadingSalesStatuses, setIsLoadingSalesStatuses] = useState(false);
  const [isSavingSalesAvailability, setIsSavingSalesAvailability] =
    useState(false);
  const [isSavingSalesLeave, setIsSavingSalesLeave] = useState(false);

  const fetchSalesUsersStatus = useCallback(async () => {
    setIsLoadingSalesStatuses(true);

    try {
      const response = await fetch(`${SALES_API_BASE_URL}/sales-users/status`, {
        method: 'GET',
        headers: buildAuthHeaders(),
      });
      const json = await parseResponseOrThrow(response);

      const salesStatuses: SalesUserStatusRecord[] = json?.data ?? [];
      const statusMap = Object.fromEntries(
        salesStatuses.map((item) => [item.workspaceMemberId, item]),
      );

      setSalesStatusesByMemberId(statusMap);

      return statusMap;
    } finally {
      setIsLoadingSalesStatuses(false);
    }
  }, []);

  const updateSalesAvailability = useCallback(
    async (
      workspaceMemberId: string,
      payload: UpdateSalesAvailabilityPayload,
    ): Promise<SalesUserStatusRecord | null> => {
      setIsSavingSalesAvailability(true);

      try {
        const response = await fetch(
          `${SALES_API_BASE_URL}/sales-users/${workspaceMemberId}/availability`,
          {
            method: 'PATCH',
            headers: buildAuthHeaders(),
            body: JSON.stringify(payload),
          },
        );
        const json = await parseResponseOrThrow(response);

        const partialResult = json?.data;

        if (!partialResult) {
          return null;
        }

        setSalesStatusesByMemberId((prev) => ({
          ...prev,
          [workspaceMemberId]: {
            ...(prev[workspaceMemberId] ?? {
              workspaceMemberId,
              name: '',
              leaveStartDate: null,
              leaveEndDate: null,
            }),
            availabilityStartTime: partialResult.availabilityStartTime,
            availabilityEndTime: partialResult.availabilityEndTime,
            availableDays: partialResult.availableDays,
            status: partialResult.status,
          },
        }));

        return null;
      } finally {
        setIsSavingSalesAvailability(false);
      }
    },
    [],
  );

  const updateSalesLeave = useCallback(
    async (
      workspaceMemberId: string,
      payload: UpdateSalesLeavePayload,
    ): Promise<SalesUserStatusRecord | null> => {
      setIsSavingSalesLeave(true);

      try {
        const response = await fetch(
          `${SALES_API_BASE_URL}/sales-users/${workspaceMemberId}/leave`,
          {
            method: 'PATCH',
            headers: buildAuthHeaders(),
            body: JSON.stringify(payload),
          },
        );
        const json = await parseResponseOrThrow(response);

        const partialResult = json?.data;

        if (!partialResult) {
          return null;
        }

        setSalesStatusesByMemberId((prev) => ({
          ...prev,
          [workspaceMemberId]: {
            ...(prev[workspaceMemberId] ?? {
              workspaceMemberId,
              name: '',
              availabilityStartTime: '00:00',
              availabilityEndTime: '24:00',
              availableDays: [],
            }),
            leaveStartDate: partialResult.leaveStartDate,
            leaveEndDate: partialResult.leaveEndDate,
            status: partialResult.status,
          },
        }));

        return null;
      } finally {
        setIsSavingSalesLeave(false);
      }
    },
    [],
  );

  return {
    salesStatusesByMemberId,
    isLoadingSalesStatuses,
    isSavingSalesAvailability,
    isSavingSalesLeave,
    fetchSalesUsersStatus,
    updateSalesAvailability,
    updateSalesLeave,
  };
};
