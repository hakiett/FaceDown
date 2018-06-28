@interface SBIdleTimerGlobalCoordinator
@property (nonatomic, readonly) BOOL screenUp;
@end

@interface SBPocketStateMonitor : NSObject
@end

@interface SpringBoard : NBObject
- (void)_simulateLockButtonPress;
- (void)_simulateHomeButtonPress;
@end

%hook SBIdleTimerGlobalCoordinator

- (void)pocketStateMonitor:(SBPocketStateMonitor *)arg1 pocketStateDidChangeFrom:(long long)arg2 to:(long long)arg3 {
  
  %orig;
  
  SpringBoard *springBoard = (SpringBoard *)UIApplication.sharedApplication; 
  BOOL screenUp = self.screenUp;

  if ((arg3 == 2) && screenUp) {
   [springBoard _simulateLockButtonPress];
    }
    
  if ((arg3 == 0) && !screenUp) {
   [springBoard _simulateHomeButtonPress];
    }
}  

%end
