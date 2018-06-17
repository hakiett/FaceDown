@interface SBIdleTimerGlobalCoordinator
@end

@interface SBPocketStateMonitor : NSObject
@end

@interface SpringBoard : NBObject
- (void)_simulateLockButtonPress;
- (void)_simulateHomeButtonPress;
@end

static BOOL screenUp;

%hook SBIdleTimerGlobalCoordinator

- (void)pocketStateMonitor:(SBPocketStateMonitor *)arg1 pocketStateDidChangeFrom:(long long)arg2 to:(long long)arg3 {
  
  %orig;
  
  if ((arg3 == 2) && screenUp) {
   [((SpringBoard *)[%c(UIApplication) sharedApplication]) _simulateLockButtonPress];
    }
    
  if ((arg3 == 0) && !screenUp) {
   [((SpringBoard *)[%c(UIApplication) sharedApplication]) _simulateHomeButtonPress];
    }
}   
%end
