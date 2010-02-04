Date: Thu, 4 Feb 2010 11:57:00 +0100
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100204105700.GB20669@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Force switch back to primary domain
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

Hi all,

my scenario is as follows:

- Xenomai 2.4.10, Linux 2.6.30.10
- rtdm-driver, defining ioctl_rt and ioctl_nrt
- user space task migrated with rt_task_shadow()
	to primary domain
- user space task is in a loop calling rt_dev_ioctl()

what happens:

as long as user space task does not switch to secondary domain
user space task comes into ioctl_rt of my driver, which
waits on an event with rtdm_event_wait() - fine :-)


but, when user space task gets a Linux signal (SIGTRAP
caused by breakpoint), user space task switches
to secondary domain executing the signal handler,
which returns after handling the signal - fine up to here.

then, i would like to switch back to primary domain using:

	rt_task_set_mode(0, T_PRIMARY, NULL);

which returns without error. but, when calling rt_dev_ioctl()
again, the non realtime version function of the driver ioctl_nrt
is called (where i can't use rtdm_event_wait()).

tried to rt_task_sleep(1000000000) and calling rt_task_set_mode() again, no success,
seems like user space thread is locked into secondary domain, why?

How can i force to switch a thread back into primary mode again?
	
Thanks for your help,

	Olli


