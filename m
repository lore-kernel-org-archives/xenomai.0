Date: Thu, 18 Dec 2014 12:30:40 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone, 
I recently ran a comparison test between Xemai native & posix skin, the goal is to see if its possible of using a full standard posix program instead of inserting some native functions. I'm not familiar with the Xenomai Posix skin so I may lack a lot of things, if you can give me some hints, I would be very grateful. 
Test run in xenomai 2.6.3 patched in linux 3.8.13. 
My program only have 1 task who use the soem library (which use rtdm) to send a message broadcast in order to detect EtherCAT slave through a real-time port RTNet. 
I have 2 test files which use native & posix skin respectively. Here some cuts of the main() function: 
Native: 
mlockall(MCL_CURRENT | MCL_FUTURE); 
rt_print_auto_init(1); 
rt_task_spawn(&rt_task_desc_1,NULL,0,98,T_JOINABLE|T_WARNSW,&mini,NULL); 
rt_task_join(&rt_task_desc_1); 
rt_task_delete(&rt_task_desc_1); 
Posix: 
mlockall(MCL_CURRENT | MCL_FUTURE); 
pthread_attr_init(&p_attr1); 
pthread_attr_setschedpolicy(&p_attr1,SCHED_FIFO); 
pthread_attr_setdetachstate(&p_attr1, PTHREAD_CREATE_JOINABLE); 
param.sched_priority = 98; 
pthread_attr_setschedparam(&p_attr1, &param); 
pthread_create( &thread1, &p_attr1, (void *) &mini, NULL); 
pthread_join(thread1, 0); 
pthread_exit(&thread1); 
pthread_attr_destroy(&p_attr1); 

in mini(): pthread_set_mode_np(0,PTHREAD_PRIMARY|PTHREAD_WARNSW); 

in which mini() is my task. 

I activated WARNSW bit to detect spurious relaxes, according to this: http://xenomai.org/2014/06/finding-spurious-relaxes/ 

The mode switch occurs at socket level, but in differents ways: 
With native: 
Mode switch (reason invoked syscall), aborting. Backtrace: 
./testcase_native[0x40152f] 
/lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7eff44375cb0] 
/usr/xenomai/lib/librtdm.so.1(rt_dev_socket+0x1d)[0x7eff43d5480d 

With posix: 
Critical errors: Mode switch (reason latency:received SIXCPU for unknown reason), aborting. Backtrace: 
./testcase_posix[0x401570] 
/lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f40ddb7acb0] 
/usr/xenomai/lib/librtdm.so.1(rt_dev_sendmsg+0x16)[0x7f40dd5598f6] 

These 2 programs use the same functions call, compiled with same flags (rtdm, native & posix mixed): 
CFLAGS += -g -O0 -ffunction-sections -DRTNET -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix 
LDFLAGS += -Wl,--gc-sections -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lrtdm -lxenomai -lpthread -lrt -lpthread_rt 

The only different is the portion I mentioned above. 

I'm trying to follow this porting guide: https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/ but there are perhaps something I went wrong. 

Thank you for any helps. 

-- 
Huy Cong 

