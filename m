From: John Wojnaroski <castle@domain.hid>
Content-Type: text/plain
Date: Thu, 26 Aug 2010 09:59:27 -0700
Message-Id: <1282841967.2867.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] USB task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm writing a task to control an A2D conversion chip via a USB port. The
task will run at 100Hz to convert and read up to 8 channels with a setup
time of 10us between channels.  Using a usb_control_msg(....) to control
and talk to the chip(s) in user space.

here is the real time task wrapper that calls the 3 modules

void smc_task( void *cookie) {
  rt_task_set_periodic(NULL, TM_NOW, smc_period_ns);
  while (!end) {
        rt_task_wait_period(NULL); // 100Hz
        p_rtMCP->Polling(); // this calls the pUSB->Scan() method
        pFltCtrls->Scan();
        pSMC->Execute();
  }
}

can the task be treated as "atomic" in that all three modules will run
to completion in order without being prempted? or would signals need
blocking as in  

  /* Block signals to make transaction atomic */
  memset( &set, 0xFF, sizeof(sigset_t) );
  sigprocmask(SIG_BLOCK, &set, &oldset);

or would this make matters worse.  ATM the task is up and running and
*seems* to be working and am assuming the pUSB->Scan() is dropping into
kernel space to communicate via the USB port.

If it is not violating some basic rules and tenets of rt programming
with Xenomai would be happy to leave it as is....

Any thoughts, comments, critiques much appreciated
John




