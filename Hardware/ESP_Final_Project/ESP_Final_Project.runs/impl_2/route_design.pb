
d
Command: %s
53*	vivadotcl23
route_design -directive Explore2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
Rule violation (%s) %s - %s
20*drc2
PLIO-72default:default2B
.Placement Constraints Check for IO constraints2default:default2�
�An IO Bus sw[15:0] with more than one IO standard is found. Components associated with this bus are: LVCMOS18 (sw[9], sw[8]); LVCMOS33 (sw[15], sw[14], sw[13], sw[12], sw[11], sw[10], sw[7], sw[6], sw[5], sw[4], sw[3], sw[2], sw[1], sw[0]); 2default:defaultZ23-20h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
[
Using Router directive '%s'.
104*route2
Explore2default:defaultZ35-270h px� 
y
BMultithreading enabled for route_design using a maximum of %s CPUs97*route2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
B
-Phase 1 Build RT Design | Checksum: 2aec150b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:52 ; elapsed = 00:00:44 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
A
,Phase 2.1 Create Timer | Checksum: 2aec150b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:52 ; elapsed = 00:00:44 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
M
8Phase 2.2 Fix Topology Constraints | Checksum: 2aec150b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:52 ; elapsed = 00:00:44 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
F
1Phase 2.3 Pre Route Cleanup | Checksum: 2aec150b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:52 ; elapsed = 00:00:44 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
B
-Phase 2.4 Update Timing | Checksum: e4267041
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
�
Intermediate Timing Summary %s164*route2K
7| WNS=2.358  | TNS=0.000  | WHS=-0.262 | THS=-251.996|
2default:defaultZ35-416h px� 
I
4Phase 2 Router Initialization | Checksum: 17ba6ca29
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:02 ; elapsed = 00:00:50 . Memory (MB): peak = 1171.938 ; gain = 38.4692default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
B
-Phase 3 Initial Routing | Checksum: eae559d3
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:08 ; elapsed = 00:00:53 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
4.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 4.1.1 Update Timing | Checksum: 1e980ad96
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:16 ; elapsed = 00:00:58 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=1.958  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.1 Global Iteration 0 | Checksum: 172428a5a
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:16 ; elapsed = 00:00:58 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
F
1Phase 4 Rip-up And Reroute | Checksum: 172428a5a
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:16 ; elapsed = 00:00:58 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 111dfe04c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:18 ; elapsed = 00:00:59 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=1.961  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
C
.Phase 5.1 Delay CleanUp | Checksum: 111dfe04c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:18 ; elapsed = 00:00:59 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 111dfe04c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:18 ; elapsed = 00:00:59 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
O
:Phase 5 Delay and Skew Optimization | Checksum: 111dfe04c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:18 ; elapsed = 00:00:59 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 6.1.1 Update Timing | Checksum: 169eac560
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:20 ; elapsed = 00:01:00 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=1.961  | TNS=0.000  | WHS=0.021  | THS=0.000  |
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 16e8a258a
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:20 ; elapsed = 00:01:00 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
A
,Phase 6 Post Hold Fix | Checksum: 16e8a258a
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:20 ; elapsed = 00:01:00 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
t

Phase %s%s
101*constraints2
7 2default:default2'
Timing Verification2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
7.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
C
.Phase 7.1 Update Timing | Checksum: 10140d628
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:22 ; elapsed = 00:01:01 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=1.961  | TNS=0.000  | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
G
2Phase 7 Timing Verification | Checksum: 10140d628
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:22 ; elapsed = 00:01:01 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
o

Phase %s%s
101*constraints2
8 2default:default2"
Route finalize2default:defaultZ18-101h px� 
B
-Phase 8 Route finalize | Checksum: 10140d628
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:22 ; elapsed = 00:01:01 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
v

Phase %s%s
101*constraints2
9 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
I
4Phase 9 Verifying routed nets | Checksum: 10140d628
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:22 ; elapsed = 00:01:01 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
s

Phase %s%s
101*constraints2
10 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
F
1Phase 10 Depositing Routes | Checksum: 149792520
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:23 ; elapsed = 00:01:02 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
t

Phase %s%s
101*constraints2
11 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Post Routing Timing Summary %s
20*route2J
6| WNS=1.964  | TNS=0.000  | WHS=0.028  | THS=0.000  |
2default:defaultZ35-20h px� 
F
'The design met the timing requirement.
61*routeZ35-61h px� 
G
2Phase 11 Post Router Timing | Checksum: 1325a8916
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:30 ; elapsed = 00:01:06 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
=
Router Completed Successfully
16*routeZ35-16h px� 
�

%s
*constraints2p
\Time (s): cpu = 00:01:30 ; elapsed = 00:01:06 . Memory (MB): peak = 1180.914 ; gain = 47.4452default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
682default:default2
312default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:01:312default:default2
00:01:072default:default2
1180.9142default:default2
47.4452default:defaultZ17-268h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:052default:default2
00:00:022default:default2
1180.9142default:default2
0.0002default:defaultZ17-268h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
TC:/Users/Vatsa/ESP_Final_Project/ESP_Final_Project.runs/impl_2/n4fpga_drc_routed.rptTC:/Users/Vatsa/ESP_Final_Project/ESP_Final_Project.runs/impl_2/n4fpga_drc_routed.rpt2default:default8Z2-168h px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
�Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px� 


End Record