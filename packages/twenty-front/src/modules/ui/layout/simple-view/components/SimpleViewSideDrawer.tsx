import styled from '@emotion/styled';
import { AnimatePresence, motion } from 'framer-motion';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useRecoilState, useRecoilValue } from 'recoil';

import { useAuth } from '@/auth/hooks/useAuth';
import { currentWorkspaceState } from '@/auth/states/currentWorkspaceState';
import { useFilteredObjectMetadataItems } from '@/object-metadata/hooks/useFilteredObjectMetadataItems';
import { SimpleViewObjectConfig } from '@/ui/layout/simple-view/components/SimpleViewObjectConfig';
import { isSimpleViewDrawerOpenState } from '@/ui/layout/simple-view/states/isSimpleViewDrawerOpenState';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { simpleViewObjectsState } from '@/ui/layout/simple-view/states/simpleViewObjectsState';
import { useColorScheme } from '@/ui/theme/hooks/useColorScheme';
import { useLingui } from '@lingui/react/macro';
import {
  IconArrowLeft,
  IconLayoutSidebarRightCollapse,
  IconMoon,
  IconSettings,
  IconSettings2,
  IconSun,
  IconLogout,
} from 'twenty-ui/display';

const StyledOverlay = styled(motion.div)`
  background: ${({ theme }) => theme.background.overlayPrimary};
  inset: 0;
  position: fixed;
  z-index: 100;
`;

const StyledDrawer = styled(motion.div)`
  background: ${({ theme }) => theme.background.primary};
  border-right: 1px solid ${({ theme }) => theme.border.color.medium};
  display: flex;
  flex-direction: column;
  height: 100%;
  left: 0;
  max-width: 280px;
  position: fixed;
  top: 0;
  width: 80%;
  z-index: 101;
`;

const StyledDrawerHeader = styled.div`
  align-items: center;
  border-bottom: 1px solid ${({ theme }) => theme.border.color.light};
  display: flex;
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(4)};
`;

const StyledWorkspaceName = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledCloseButton = styled.button`
  align-items: center;
  background: none;
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.tertiary};
  cursor: pointer;
  display: flex;
  height: ${({ theme }) => theme.spacing(8)};
  justify-content: center;
  padding: 0;
  width: ${({ theme }) => theme.spacing(8)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    color: ${({ theme }) => theme.font.color.primary};
  }
`;

const StyledNavSection = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  overflow-y: auto;
  padding: ${({ theme }) => theme.spacing(2)} 0;
`;

const StyledNavItem = styled.button<{ isActive?: boolean }>`
  align-items: center;
  background: ${({ theme, isActive }) =>
    isActive ? theme.background.transparent.light : 'none'};
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme, isActive }) =>
    isActive ? theme.font.color.primary : theme.font.color.secondary};
  cursor: pointer;
  display: flex;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(3)};
  margin: 0 ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(3)};
  text-align: left;
  width: calc(100% - ${({ theme }) => theme.spacing(4)});

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    color: ${({ theme }) => theme.font.color.primary};
  }
`;

const StyledDivider = styled.div`
  background: ${({ theme }) => theme.border.color.light};
  height: 1px;
  margin: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(4)};
`;

const StyledFooter = styled.div`
  border-top: 1px solid ${({ theme }) => theme.border.color.light};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
  padding: ${({ theme }) => theme.spacing(2)} 0;
`;

const StyledToggleRow = styled.div`
  align-items: center;
  display: flex;
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(4)};
`;

const StyledToggleLabel = styled.span`
  align-items: center;
  color: ${({ theme }) => theme.font.color.secondary};
  display: flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  gap: ${({ theme }) => theme.spacing(1)};
`;

const StyledToggle = styled.button<{ isOn: boolean }>`
  background: ${({ theme, isOn }) =>
    isOn ? theme.color.blue : theme.background.transparent.medium};
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.pill};
  cursor: pointer;
  height: 24px;
  padding: 2px;
  position: relative;
  transition: background 0.2s;
  width: 44px;

  &::after {
    background: white;
    border-radius: 50%;
    content: '';
    height: 20px;
    left: ${({ isOn }) => (isOn ? '22px' : '2px')};
    position: absolute;
    top: 2px;
    transition: left 0.2s;
    width: 20px;
  }
`;

const StyledConfigButton = styled.button`
  align-items: center;
  background: none;
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.tertiary};
  cursor: pointer;
  display: flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  gap: ${({ theme }) => theme.spacing(2)};
  margin: 0 ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(1.5)} ${({ theme }) => theme.spacing(3)};
  text-align: left;
  width: calc(100% - ${({ theme }) => theme.spacing(4)});

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    color: ${({ theme }) => theme.font.color.secondary};
  }
`;

export const SimpleViewSideDrawer = () => {
  const navigate = useNavigate();
  const [isOpen, setIsOpen] = useRecoilState(isSimpleViewDrawerOpenState);
  const [isSimpleViewEnabled, setIsSimpleViewEnabled] = useRecoilState(
    isSimpleViewEnabledState,
  );
  const simpleViewObjects = useRecoilValue(simpleViewObjectsState);
  const currentWorkspace = useRecoilValue(currentWorkspaceState);
  const { alphaSortedActiveNonSystemObjectMetadataItems } =
    useFilteredObjectMetadataItems();
  const [showObjectConfig, setShowObjectConfig] = useState(false);
  const { colorScheme, setColorScheme } = useColorScheme();
  const { signOut } = useAuth();
  const { t } = useLingui();

  const currentPath = window.location.pathname;

  const simpleViewMetadataItems =
    alphaSortedActiveNonSystemObjectMetadataItems.filter((item) =>
      simpleViewObjects.includes(item.nameSingular),
    );

  const handleNavItemClick = (namePlural: string) => {
    navigate(`/objects/${namePlural}`);
    setIsOpen(false);
  };

  const handleSettingsClick = () => {
    navigate('/settings/profile');
    setIsOpen(false);
  };

  const handleToggleSimpleView = () => {
    setIsSimpleViewEnabled(!isSimpleViewEnabled);
    setIsOpen(false);
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <StyledOverlay
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.2 }}
            onClick={() => setIsOpen(false)}
          />
          <StyledDrawer
            initial={{ x: '-100%' }}
            animate={{ x: 0 }}
            exit={{ x: '-100%' }}
            transition={{ type: 'tween', duration: 0.25 }}
          >
            <StyledDrawerHeader>
              <StyledWorkspaceName>
                {currentWorkspace?.displayName ?? 'Workspace'}
              </StyledWorkspaceName>
              <StyledCloseButton onClick={() => setIsOpen(false)}>
                <IconArrowLeft size={16} />
              </StyledCloseButton>
            </StyledDrawerHeader>

            <StyledNavSection>
              {simpleViewMetadataItems.map((item) => (
                <StyledNavItem
                  key={item.id}
                  isActive={currentPath.includes(
                    `/objects/${item.namePlural}`,
                  )}
                  onClick={() => handleNavItemClick(item.namePlural)}
                >
                  {item.labelPlural}
                </StyledNavItem>
              ))}

              <StyledDivider />

              {alphaSortedActiveNonSystemObjectMetadataItems
                .filter(
                  (item) => !simpleViewObjects.includes(item.nameSingular),
                )
                .map((item) => (
                  <StyledNavItem
                    key={item.id}
                    isActive={currentPath.includes(
                      `/objects/${item.namePlural}`,
                    )}
                    onClick={() => handleNavItemClick(item.namePlural)}
                  >
                    {item.labelPlural}
                  </StyledNavItem>
                ))}
            </StyledNavSection>

            <StyledFooter>
              <StyledNavItem onClick={handleSettingsClick}>
                <IconSettings size={16} />
                Settings
              </StyledNavItem>

              <StyledNavItem onClick={signOut}>
                <IconLogout size={16} />
                {t`Log out`}
              </StyledNavItem>

              <StyledDivider />

              <StyledConfigButton
                onClick={() => setShowObjectConfig((prev) => !prev)}
              >
                <IconSettings2 size={14} />
                Configure simple view objects
              </StyledConfigButton>

              {showObjectConfig && <SimpleViewObjectConfig />}

              <StyledDivider />

              <StyledToggleRow>
                <StyledToggleLabel>
                  {colorScheme === 'Dark' ? (
                    <>
                      <IconSun size={14} /> Light mode
                    </>
                  ) : (
                    <>
                      <IconMoon size={14} /> Dark mode
                    </>
                  )}
                </StyledToggleLabel>
                <StyledToggle
                  isOn={colorScheme === 'Dark'}
                  onClick={() =>
                    setColorScheme(colorScheme === 'Dark' ? 'Light' : 'Dark')
                  }
                />
              </StyledToggleRow>

              <StyledToggleRow>
                <StyledToggleLabel>
                  <IconLayoutSidebarRightCollapse size={14} />
                  {' Simple View'}
                </StyledToggleLabel>
                <StyledToggle
                  isOn={isSimpleViewEnabled}
                  onClick={handleToggleSimpleView}
                />
              </StyledToggleRow>
            </StyledFooter>
          </StyledDrawer>
        </>
      )}
    </AnimatePresence>
  );
};
