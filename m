Date: Thu, 18 Dec 2014 15:05:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141218140529.GM2012@hermes.click-hack.org>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Thu, Dec 18, 2014 at 12:30:40PM +0100, Huy Cong Vu wrote:
> Hello everyone, I recently ran a comparison test between Xemai
> native & posix skin, the goal is to see if its possible of using a
> full standard posix program instead of inserting some native
> functions. I'm not familiar with the Xenomai Posix skin so I may
> lack a lot of things, if you can give me some hints, I would be
> very grateful. Test run in xenomai 2.6.3 patched in linux 3.8.13.

You should be using xenomai latest version, which is 2.6.4, not an
older version, especially if you have not yet chosen a particular version

> My program only have 1 task who use the soem library (which use rtdm) to send a message broadcast in order to detect EtherCAT slave through a real-time port RTNet. 
> I have 2 test files which use native & posix skin respectively. Here some cuts of the main() function: 
> Native: 
> mlockall(MCL_CURRENT | MCL_FUTURE); 
> rt_print_auto_init(1); 
> rt_task_spawn(&rt_task_desc_1,NULL,0,98,T_JOINABLE|T_WARNSW,&mini,NULL); 
> rt_task_join(&rt_task_desc_1); 
> rt_task_delete(&rt_task_desc_1); 
> Posix: 
> mlockall(MCL_CURRENT | MCL_FUTURE); 
> pthread_attr_init(&p_attr1); 
> pthread_attr_setschedpolicy(&p_attr1,SCHED_FIFO); 
> pthread_attr_setdetachstate(&p_attr1, PTHREAD_CREATE_JOINABLE); 
> param.sched_priority = 98; 
> pthread_attr_setschedparam(&p_attr1, &param); 
> pthread_create( &thread1, &p_attr1, (void *) &mini, NULL); 
> pthread_join(thread1, 0); 
> pthread_exit(&thread1); 
> pthread_attr_destroy(&p_attr1); 
> 
> in mini(): pthread_set_mode_np(0,PTHREAD_PRIMARY|PTHREAD_WARNSW); 

You do not need PTHREAD_PRIMARY, a xenomai thread will always start
in primary mode, and anyway the switch to primary or secondary mode
will  happen as needed.

> 
> in which mini() is my task. 
> 
> I activated WARNSW bit to detect spurious relaxes, according to this: http://xenomai.org/2014/06/finding-spurious-relaxes/ 
> 
> The mode switch occurs at socket level, but in differents ways: 
> With native: 
> Mode switch (reason invoked syscall), aborting. Backtrace: 
> ./testcase_native[0x40152f] 
> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7eff44375cb0] 
> /usr/xenomai/lib/librtdm.so.1(rt_dev_socket+0x1d)[0x7eff43d5480d 

rt_dev_socket may cause a switch to secondary mode, yes, this is
perfectly normal, only sending and receiving data is guaranteed to
not cause a switch to secondary mode.

> 
> With posix: 
> Critical errors: Mode switch (reason latency:received SIXCPU for unknown reason), aborting. Backtrace: 

Unknown reason is suspicious, if you have used the sigdebug example,
you should not that there is now an additional reason for receiving
SIGXCPU.

> ./testcase_posix[0x401570] 
> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f40ddb7acb0] 
> /usr/xenomai/lib/librtdm.so.1(rt_dev_sendmsg+0x16)[0x7f40dd5598f6] 
> 
> These 2 programs use the same functions call, compiled with same
> flags (rtdm, native & posix mixed): 

Most likely, rt_dev_sendmsg is passed a non real-time socket. You
can use either native or posix services to create and handle
sockets, but you can not mix the call. It meansa socket created with
rt_dev_socket (the native service) should be passed to
rt_dev_sendmsg, whereas socket created with the posix service
(socket) can only be passed to posix services (sendmsg). Is not it
what is happening here?

> The only different is the portion I mentioned above. 

Compiling for the xenomai skin causes changes in the services called
even without changing the code. So, for instance, if you use the
"socket" service, when compiling for the native skin, it will create
a plain linux socket, whereas when compiled for the posix skin, it
will try and create an RTDM socket.

To help you more, we would need more details, such as for instance a
reduced, self-contained test case allowing us to reproduce the issue
you observe.

-- 
					    Gilles.

