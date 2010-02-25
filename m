Message-ID: <4B86EADA.6080001@domain.hid>
Date: Thu, 25 Feb 2010 22:25:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> I have a xenomai application that runs without problems with
> xenomai-2.4.6.1/linux-2.6.27.7. When run under
> xenomai-2.5.1/linux-2.6.32.7 it fails with the warning: Xenomai:
> process memory not locked (missing mlockall?).  I verified that
> mlockall() is being called before any xenomai calls are made as
> follows with out error:
> 
> // lock process in memory for xenomai int err = mlockall(MCL_CURRENT
> | MCL_FUTURE); if (err) { fprintf(stderr, "TimerInit: mlockall failed
> to lock process into memory: %d\n", err); exit(1); } fprintf(stdout,
> "TimerInit: Locked process memory\n");
> 
> The relevant message in dmesg output is: Xenomai: watchdog triggered
> -- signaling runaway thread 'timerloop-2166'
> 
> This occurs when creating a native xenomai task (created by
> CanFestival library) with the following code with no errors:
> 
> void StartTimerLoop(TimerCallback_t _init_callback) { int ret = 0; 
> stop_timer = 0; init_callback = _init_callback;
> 
> char taskname[32]; snprintf(taskname, sizeof(taskname),
> "timerloop-%d", getpid());
> 
> printf("Starting timerloop task %s\n", taskname); /* create
> timerloop_task */ ret = rt_task_create(&timerloop_task, taskname, 0,
> 50, T_JOINABLE); if (ret) { printf("Failed to create timerloop_task,
> code %d\n",errno); return; }
> 
> /* start timerloop_task */ ret =
> rt_task_start(&timerloop_task,&timerloop_task_proc,NULL); if (ret) { 
> printf("Failed to start timerloop_task, code %u\n",errno); goto
> error; }
> 
> return;
> 
> error: cleanup_all(); }
> 
> Debug output is displayed from the timerloop_task indicating that the
> task starts, but the mlockall warning is displayed before those
> outputs and the application already begins to shut down.
> 
> xeno-test runs without errors.  The trivial_periodic application also
> compiles and runs without error

Please post a preferably simple, self-contained, compiling test case
which we can compile and run to reproduce the issue you are meeting.

The flags you pass to xenomai configure script and the command lines you
use when compiling the program also matter.

At first sight, your real problem is that your program has an infinite
loop in primary mode which causes the watchdog to trigger. Then, the
message printed gets it wrong. You can try and revert the commit
803ff2e093a4260054e1e9e59114bc4e656c84bd
to see if you get a more meaningful message.

-- 
					    Gilles.

