Message-ID: <4B6ADA01.2080803@domain.hid>
Date: Thu, 04 Feb 2010 15:30:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100204105700.GB20669@domain.hid>
In-Reply-To: <20100204105700.GB20669@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

Tschaeche IT-Services wrote:
> Hi all,
> 
> my scenario is as follows:
> 
> - Xenomai 2.4.10, Linux 2.6.30.10

It would be nice if you could try Xenomai 2.5.1, the latest stable
release, to see if you are not having a problem that we already fixed.

> - rtdm-driver, defining ioctl_rt and ioctl_nrt
> - user space task migrated with rt_task_shadow()
> 	to primary domain
> - user space task is in a loop calling rt_dev_ioctl()
> 
> what happens:
> 
> as long as user space task does not switch to secondary domain
> user space task comes into ioctl_rt of my driver, which
> waits on an event with rtdm_event_wait() - fine :-)
> 
> 
> but, when user space task gets a Linux signal (SIGTRAP
> caused by breakpoint), user space task switches
> to secondary domain executing the signal handler,
> which returns after handling the signal - fine up to here.
> 
> then, i would like to switch back to primary domain using:
> 
> 	rt_task_set_mode(0, T_PRIMARY, NULL);

You do not need to do that.

> 
> which returns without error. but, when calling rt_dev_ioctl()
> again, the non realtime version function of the driver ioctl_nrt
> is called (where i can't use rtdm_event_wait()).

in ioctl_nrt, return -ENOSYS, Xenomai will switch back your task to
primary mode, and call the rt ioctl.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

