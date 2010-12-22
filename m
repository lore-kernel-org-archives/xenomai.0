Date: Wed, 22 Dec 2010 10:30:29 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D110810.1090504@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221012270.10955@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

>> 154     int r = rt_task_create(&thread, thread_name.c_str(), 128*1024, prio, T_FPU|T_JOINABLE);
> Is there any trace on the serial console?

Hasn't been, but I now after I enabled Xenomai debugging and watchdog, at least there's some indication what's going wrong. The "last words" of the application are

...
> Xenomai: registered exported object  (mutexes)
> Xenomai: registered exported object  (mutexes)
> Xenomai: watchdog triggered -- signaling runaway thread 'pfda'
> Backtrace: 0xbcdcc6, 0, 0, 0

And in gdb it shows up as a SIGXCPU:

Program received signal SIGXCPU, CPU time limit exceeded.
...
(gdb) bt
#0  pthread_setcanceltype (type=0, oldtype=0x0) at libpthread/linuxthreads.old/forward.c:161
#1  0x00f35450 in __wrap_pthread_cond_wait (cond=<value optimized out>, mutex=<value optimized out>)
     at ../../../../xenomai-2.5.5.2/src/skins/posix/cond.c:123
#2  0x00be72c6 in consume_socket (ctx=0x837788, sp=0x1778240) at mongoose.c:3871
#3  0x00be753a in worker_thread (ctx=0x837788) at mongoose.c:3914
...


Kolja

