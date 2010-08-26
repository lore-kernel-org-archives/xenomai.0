Message-ID: <4C76A037.1020904@domain.hid>
Date: Thu, 26 Aug 2010 19:11:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282841967.2867.28.camel@domain.hid>
In-Reply-To: <1282841967.2867.28.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] USB task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: John Wojnaroski <castle@domain.hid>
Cc: xenomai@xenomai.org

John Wojnaroski wrote:
> Hi,
> 
> I'm writing a task to control an A2D conversion chip via a USB port. The
> task will run at 100Hz to convert and read up to 8 channels with a setup
> time of 10us between channels.  Using a usb_control_msg(....) to control
> and talk to the chip(s) in user space.
> 
> here is the real time task wrapper that calls the 3 modules
> 
> void smc_task( void *cookie) {
>   rt_task_set_periodic(NULL, TM_NOW, smc_period_ns);
>   while (!end) {
>         rt_task_wait_period(NULL); // 100Hz
>         p_rtMCP->Polling(); // this calls the pUSB->Scan() method
>         pFltCtrls->Scan();
>         pSMC->Execute();
>   }
> }
> 
> can the task be treated as "atomic" in that all three modules will run
> to completion in order without being prempted? or would signals need
> blocking as in  
> 
>   /* Block signals to make transaction atomic */
>   memset( &set, 0xFF, sizeof(sigset_t) );
>   sigprocmask(SIG_BLOCK, &set, &oldset);

Xenomai itself only sends signals to tasks in rare conditions (namely,
if you ask for some debug features, such as the T_WARNSW bit, or arm the
watchdog). But if you are running under gdb, or if you send a SIGTERM to
the process, Linux may send a signal, and you may want it to handle it
gracefully. And again, this would be exceptional conditions.

-- 
					    Gilles.

