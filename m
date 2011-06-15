Message-ID: <4DF896B9.3040900@domain.hid>
Date: Wed, 15 Jun 2011 13:25:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF74D3C.4020303@domain.hid>
In-Reply-To: <4DF74D3C.4020303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd: Re:  rt_task_delete doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 06/14/2011 01:59 PM, Roberto Bielli wrote:
> 
> 
> Here is the example and the command.
> 
> RT_TASK pippo;
> RT_TASK pluto;
> 
> void test1()
> {
>      int err;
> 
>      err = rt_task_delete(&pippo );
>      if( err != 0 )
>          printf("error task delete\n");
> 
> }
> 
> int main (int argc, char *argv[])
> {
>      //    Porta di comunicazione
>      //int s;
> 
>      mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>      // gestione signal handler
>      //struct sigaction sa;
>      //sa.sa_sigaction = (void *)sigHandler;
>      //sigemptyset (&sa.sa_mask);
>      //sa.sa_flags = SA_SIGINFO;
> 
>      //sigaction(SIGTERM,&sa, NULL);
>      //sigaction(SIGINT,&sa, NULL);
>      //sigaction(SIGPIPE,&sa, NULL);
>      //sigaction(SIGFPE,&sa, NULL);
>      //sigaction(SIGSEGV,&sa, NULL);
> 
> 
>      char * namePippo = "pippo";
>      char * namePluto = "pluto";
>      int err;
>      err = rt_task_create(&pippo, namePippo, 0x2000, 20, T_FPU );
>      if( err != 0 )
>          printf("error task create %s\n", namePippo );
>      err = rt_task_create(&pluto, namePluto, 0x2000, 20, T_FPU );
>      if( err != 0 )
>          printf("error task create %s\n", namePluto );
> 
>      err = rt_task_start(&pluto, (void *)test1, NULL );
>      if( err != 0 )
>          printf("error task start %s\n", namePluto );
> 
> }
> 
> --COMMAND--
> 
> # gdb --args ./apgs -D
> GNU gdb (GDB) 6.8.50.20080821-cvs
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "arm-mv5sft-linux-gnueabi".
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>...
> (gdb) r
> `/flash/apgs' has disappeared; keeping its symbols.
> Starting program: /flash/apgs -D
> [Thread debugging using libthread_db enabled]
> [New Thread 0x2acf7490 (LWP 537)]
> [New Thread 0x2acfc490 (LWP 538)]
> 
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x2acfc490 (LWP 538)]
> 0x2aab9d74 in _dl_catch_error () from /lib/ld-linux.so.3
> (gdb)

The segfault is due to a stack overflow. The stack sizes you pass are 
too small.

Note that if you are using Xenomai on an ARMv5, if you choose to enable 
FCSE (which is really recommended for latencies anyway), the 
configuration option CONFIG_ARM_FCSE_MESSAGES will tell you when you 
likely had a stack overflow. 

Here is the traces I got when running the example you sent:

[00d22f9c] *pgd=23a50031, *pte=23d6e04f, *ppte=23d6e00e                        
                                                                               
Pid: 908, comm:                pluto                                           
CPU: 0    Not tainted  (2.6.37.6 #2)                                           
PC is at 0x89d7a4                                                              
LR is at 0x8b5000                                                              
pc : [<0089d7a4>]    lr : [<008b5000>]    psr: 60000010                        
sp : 00d22f90  ip : 00000048  fp : 00d231b4                                    
r10: 00a525ac  r9 : 00000000  r8 : 008c8ff8                                    
r7 : 80000001  r6 : 00000048  r5 : 008b5000  r4 : 00000000                     
r3 : 008a2384  r2 : 00d2318f  r1 : 00d23184  r0 : 00d23188                     
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user             
Control: 0005317f  Table: 23a68000  DAC: 00000015                              
mappings:                                                                      
0x00008000-0x00009000 r-xp 0x00000000 /usr/bin/test_task_delete                
0x00010000-0x00011000 rwxp 0x00000000 /usr/bin/test_task_delete                
0x00011000-0x00032000 rwxp 0x00011000 [heap]                                   
0x0081e000-0x0081f000 rwxp 0x0081e000                                          
0x00830000-0x00839000 r-xp 0x00000000 /usr/lib/libnative.so.3.0.0              
0x00839000-0x00840000 ---p 0x00009000 /usr/lib/libnative.so.3.0.0              
0x00840000-0x00841000 rwxp 0x00008000 /usr/lib/libnative.so.3.0.0              
0x0086e000-0x0086f000 rwxp 0x0086e000                                          
0x0088f000-0x008ad000 r-xp 0x00000000 /lib/ld-linux.so.3 <- PC                 
0x008b4000-0x008b5000 r-xp 0x0001d000 /lib/ld-linux.so.3                       
0x008b5000-0x008b6000 rwxp 0x0001e000 /lib/ld-linux.so.3                       
0x008b6000-0x008cb000 r-xp 0x00000000 /lib/libpthread.so.0                     
0x008cb000-0x008d2000 ---p 0x00015000 /lib/libpthread.so.0                     
0x008d2000-0x008d3000 r-xp 0x00014000 /lib/libpthread.so.0                     
0x008d3000-0x008d4000 rwxp 0x00015000 /lib/libpthread.so.0                     
0x008d4000-0x008d6000 rwxp 0x008d4000                                          
0x008d6000-0x008e1000 r-xp 0x00000000 /lib/libgcc_s.so.1                       
0x008e1000-0x008e9000 ---p 0x0000b000 /lib/libgcc_s.so.1                       
0x008e9000-0x008ea000 rwxp 0x0000b000 /lib/libgcc_s.so.1                       
0x008ea000-0x008eb000 rwxp 0x008ea000                                          
0x0092f000-0x00933000 r-xp 0x00000000 /usr/lib/libxenomai.so.0.0.0             
0x00933000-0x0093a000 ---p 0x00004000 /usr/lib/libxenomai.so.0.0.0             
0x0093a000-0x0093b000 rwxp 0x00003000 /usr/lib/libxenomai.so.0.0.0             
0x0093b000-0x00a79000 r-xp 0x00000000 /lib/libc.so.6                           
0x00a79000-0x00a80000 ---p 0x0013e000 /lib/libc.so.6                           
0x00a80000-0x00a82000 r-xp 0x0013d000 /lib/libc.so.6                           
0x00a82000-0x00a83000 rwxp 0x0013f000 /lib/libc.so.6                           
0x00a83000-0x00a86000 rwxp 0x00a83000                                          
0x00a86000-0x00a87000 r-xs 0xc480c000 /dev/rtheap                              
0x00af4000-0x00af5000 r-xs 0xfff7c000 /dev/mem                                 
0x00bc1000-0x00bc4000 rwxs 0x00000000 /dev/rtheap                              
0x00c6b000-0x00c6e000 rwxs 0x00000000 /dev/rtheap                              
0x00c7d000-0x00c7e000 ---p 0x00c7d000                                          
0x00c7e000-0x00c82000 rwxp 0x00c7e000                                          
0x00d22000-0x00d23000 ---p 0x00d22000  <- SP, fault                            
0x00d23000-0x00d27000 rwxp 0x00d23000                                          
0x01d8a000-0x01dac000 rw-p 0x01fde000 [stack]                                  
0xffff0000-0xffff1000 r-xp 0xffff0000 [vectors]                                
FCSE: process 908(pluto) probably overflowed stack at 0x0089d7a4.              


-- 
                                                                Gilles.

