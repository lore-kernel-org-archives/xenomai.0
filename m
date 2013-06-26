From: Henry Bausley <hbausley@deltatau.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Jun 2013 07:49:48 -0700
Message-ID: <1372258188.12144.161.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel Panic not syncing kernel stack overflow on AMCC
 PowerPC 460EX upon upgrade
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



I am attempting to upgrade to Xeno 2.6.2.1 / Ipipe 3.2.21 from
a working Xeno 2.5.6 / Ipipe 2.6.30.3 configuration

I am getting a Kernel Panic not syncing kernel stack overflow errors
with the new kernel.  

The application is a kernel module that operates soley from interrupts
and communicates to user space with applications with shared memory.  It
has been running with the earlier kernels without issues for many years.
Below are the messages I get when the system crashes.

If anyone has any hints based upon the data when it crashes  below it
would be greatly appreciated.


Debian GNU/Linux 7 powerpmac
ttyS0                                              
                                                                                
powerpmac login:
root                                                           
Password:                                                                       
Last login: Thu Jan  1 00:00:28 UTC 1970 on
ttyS0                               
Linux powerpmac 3.2.21-ipipe #1 Tue Jun 25 09:04:27 PDT 2013
ppc                
                                                                                
The programs included with the Debian GNU/Linux system are free
software;       
the exact distribution terms for each program are described in
the              
individual files
in /usr/share/doc/*/copyright.                                 
                                                                                
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the
extent               
permitted by applicable
law.                                                    
root@10.34.9.214                                                                
10.34.9.213:/opt/ppmac# hrtimer: interrupt took 6180908
ns                      
BUG: scheduling while atomic:
swapper/0/0xffff0000                              
Modules linked in: usralgo(O) rtpmac(O) libppmac(O) ppmachw(O) ehci_hcd
[last un
loaded:
usralgo]                                                                
Call
Trace:                                                                     
[8049bef0] [80006c00] show_stack+0x54/0x154
(unreliable)                        
[8049bf30] [8001a26c] __schedule_bug
+0x68/0x6c                                  
[8049bf40] [80372b1c] __schedule
+0x3e8/0x430                                    
[8049bf90] [80007738] cpu_idle
+0xd8/0xdc                                        
[8049bfb0] [80001bd4] rest_init
+0x64/0x78                                       
[8049bfc0] [8044a770] start_kernel
+0x2d0/0x2e4                                  
[8049bff0] [80000044] _start
+0x44/0x88                                          
Kernel panic - not syncing: kernel stack overflow 




RNING: at 8002a4ec [verbose debug info
unavailable]                           
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
NIP: 8002a4ec LR: 802c677c CTR:
80305224                                        
REGS: 969dbc90 TRAP: 0700   Not tainted
(3.0.8-ipipe)                          
MSR: 00029000 <EE,ME,CE>  CR: 48000462  XER:
00000000                           
TASK = af2af8e0[2894] 'in.telnetd' THREAD:
969da000                             
GPR00: 00000001 969dbd40 af2af8e0 af22d980 00000000 969dbe28 00002000
00000040  
GPR08: 00000000 8048a8b0 00000000 7fc30e76 48000464 100226b4 1001a710
1001a724  
GPR16: 100217b0 1001a6b4 1001a720 00000003 00000000 00000000 00000000
00000001  
GPR24: 00000000 7fbe92fc 7fbe92f8 1001a728 00000040 969dbe28 00002000
969da000  
NIP [8002a4ec] local_bh_enable
+0x74/0xa4                                        
LR [802c677c] lock_sock_nested
+0x38/0x4c                                        
Call
Trace:                                                                     
[969dbd40] [00001388] 0x1388
(unreliable)                                       
[969dbd50] [802c677c] lock_sock_nested
+0x38/0x4c                                
[969dbd60] [8030525c] tcp_recvmsg
+0x38/0x7f0                                    
[969dbde0] [803235ac] inet_recvmsg
+0x40/0x64                                    
[969dbe00] [802c287c] sock_aio_read
+0x118/0x120                                 
[969dbe60] [800d3608] do_sync_read
+0xa4/0x118                                   
[969dbef0] [800d3f94] vfs_read
+0x164/0x16c                                      
[969dbf10] [800d3fe8] sys_read
+0x4c/0xa4                                        
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff37c60                                                 
    LR =
0x10001fb4                                                             
Instruction
dump:                                                               
813f000c 3809ffff 901f000c 80010014 83e1000c 7c0803a6 38210010
4e800020         
3d208049 3929a8b0 88090002 68000001 <0f000000> 2f800000 419effb4
38000001       
---[ end trace
50dc077355092081 ]---                                            
------------[ cut
here ]------------                                            
WARNING: at 802ca398 [verbose debug info
unavailable]                           
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
NIP: 802ca398 LR: 802cb6dc CTR:
00000000                                        
REGS: 969dbc90 TRAP: 0700   Tainted: G        W
(3.0.8-ipipe)                
MSR: 00029000 <EE,ME,CE>  CR: 48022428  XER:
20000000                           
TASK = af2af8e0[2894] 'in.telnetd' THREAD:
969da000                             
GPR00: 802c58d0 969dbd40 af2af8e0 00000000 af276241 00000001 100218ad
00000040  
GPR08: 00000000 00000001 00001045 03c30000 48000464 100226b4 00000001
804018fc  
GPR16: 804018c8 80401898 804b0000 00000000 00000000 80480000 00000000
00000001  
GPR24: 00000000 00000001 af22dc2c 00000001 97021960 969dbe28 00001fff
97021960  
NIP [802ca398] skb_release_head_state
+0x54/0x84                                 
LR [802cb6dc] __kfree_skb
+0x18/0xd0                                             
Call
Trace:                                                                     
[969dbd50] [802cb6dc] __kfree_skb
+0x18/0xd0                                     
[969dbd60] [80305780] tcp_recvmsg
+0x55c/0x7f0                                   
[969dbde0] [803235ac] inet_recvmsg
+0x40/0x64                                    
[969dbe00] [802c287c] sock_aio_read
+0x118/0x120                                 
[969dbe60] [800d3608] do_sync_read
+0xa4/0x118                                   
[969dbef0] [800d3f94] vfs_read
+0x164/0x16c                                      
[969dbf10] [800d3fe8] sys_read
+0x4c/0xa4                                        
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff37c60                                                 
    LR =
0x10001fb4                                                             
Instruction
dump:                                                               
41820054 38000000 901f0048 801f0064 2f800000 419e002c 54290024
8129000c         
752b03ff 7d200026 55291ffe 69290001 <0f090000> 7fe3fb78 7c0903a6
4e800421       
---[ end trace
50dc077355092082 ]---                                            
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969dbe90] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969dbed0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969dbee0] [80359944] __schedule
+0x480/0x4ac                                    
[969dbf40] [8000dedc] recheck
+0x0/0x24                                          
--- Exception: c01 at
0xff37c60                                                 
    LR =
0x10001fb4                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969dbe90] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969dbed0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969dbee0] [80359944] __schedule
+0x480/0x4ac                                    
[969dbf40] [8000dedc] recheck
+0x0/0x24                                          
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969dbe90] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969dbed0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969dbee0] [80359944] __schedule
+0x480/0x4ac                                    
[969dbf40] [8000dedc] recheck
+0x0/0x24                                          
--- Exception: c01 at
0xff37ce4                                                 
    LR =
0x10007c14                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969dbe90] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969dbed0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969dbee0] [80359944] __schedule
+0x480/0x4ac                                    
[969dbf40] [8000dedc] recheck
+0x0/0x24                                          
--- Exception: 901 at
0x10001ee0                                                
    LR =
0x10001ed8                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969dbe90] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969dbed0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969dbee0] [80359944] __schedule
+0x480/0x4ac                                    
[969dbf40] [8000dedc] recheck
+0x0/0x24                                          
--- Exception: c01 at
0xff40070                                                 
    LR =
0xff4002c                                                              
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969db970] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969db9b0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969db9c0] [80359944] __schedule
+0x480/0x4ac                                    
[969dba20] [8035a894] schedule_hrtimeout_range_clock
+0x1c0/0x1cc                
[969dba90] [800e4c70] poll_schedule_timeout
+0x3c/0x60                           
[969dbaa0] [800e53f4] do_select
+0x364/0x4d8                                     
[969dbda0] [800e5808] core_sys_select
+0x2a0/0x378                               
[969dbf00] [800e591c] sys_select
+0x3c/0x154                                     
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7fc30e76                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969db970] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969db9b0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969db9c0] [80359944] __schedule
+0x480/0x4ac                                    
[969dba20] [8035a894] schedule_hrtimeout_range_clock
+0x1c0/0x1cc                
[969dba90] [800e4c70] poll_schedule_timeout
+0x3c/0x60                           
[969dbaa0] [800e53f4] do_select
+0x364/0x4d8                                     
[969dbda0] [800e5808] core_sys_select
+0x2a0/0x378                               
[969dbf00] [800e591c] sys_select
+0x3c/0x154                                     
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7f863e23                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969db970] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969db9b0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969db9c0] [80359944] __schedule
+0x480/0x4ac                                    
[969dba20] [8035a894] schedule_hrtimeout_range_clock
+0x1c0/0x1cc                
[969dba90] [800e4c70] poll_schedule_timeout
+0x3c/0x60                           
[969dbaa0] [800e53f4] do_select
+0x364/0x4d8                                     
[969dbda0] [800e5808] core_sys_select
+0x2a0/0x378                               
[969dbf00] [800e591c] sys_select
+0x3c/0x154                                     
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7f863e23                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969db970] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969db9b0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969db9c0] [80359944] __schedule
+0x480/0x4ac                                    
--- Exception: 969dba80 at
0x969dba60                                           
    LR =
0x969dba70                                                             
[969dba20] [8035a894] schedule_hrtimeout_range_clock+0x1c0/0x1cc
(unreliable)   
[969dba90] [800e4c70] poll_schedule_timeout
+0x3c/0x60                           
[969dbaa0] [800e53f4] do_select
+0x364/0x4d8                                     
[969dbda0] [800e5808] core_sys_select
+0x2a0/0x378                               
[969dbf00] [800e591c] sys_select
+0x3c/0x154                                     
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
BUG: scheduling while atomic:
in.telnetd/2894/0x7f863e23                        
Modules linked in: usralgo rtpmac libppmac ppmachw ehci_hcd [last
unloaded: usr]
Call
Trace:                                                                     
[969db970] [80006adc] show_stack+0x54/0x154
(unreliable)                        
[969db9b0] [8001bc60] __schedule_bug
+0x68/0x6c                                  
[969db9c0] [80359944] __schedule
+0x480/0x4ac                                    
--- Exception: 969dba80 at
0x969dba60                                           
    LR =
0x969dba70                                                             
[969dba20] [8035a894] schedule_hrtimeout_range_clock+0x1c0/0x1cc
(unreliable)   
[969dba90] [800e4c70] poll_schedule_timeout
+0x3c/0x60                           
[969dbaa0] [800e53f4] do_select
+0x364/0x4d8                                     
[969dbda0] [800e5808] core_sys_select
+0x2a0/0x378                               
[969dbf00] [800e591c] sys_select
+0x3c/0x154                                     
[969dbf40] [8000d3e4] ret_from_syscall
+0x0/0x3c                                 
--- Exception: c01 at
0xff4144c                                                 
    LR =
0x10001d64                                                             
Kernel panic - not syncing: Aiee, killing interrupt
handler!                    
Rebooting in 1
seconds..                                                        
                         i


i






Outbound scan for Spam or Virus by Barracuda at Delta Tau


