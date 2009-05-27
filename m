From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A1D6ED4.3060104@domain.hid>
References: <abaf774b0905270831q6c8aeb44mb2cf10f7ca3b926f@domain.hid>
	<4A1D6ED4.3060104@domain.hid>
Content-Type: text/plain
Date: Wed, 27 May 2009 19:00:36 +0200
Message-Id: <1243443636.22014.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test hangs during latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2009-05-27 at 18:48 +0200, Gilles Chanteperdrix wrote:
> Steve wrote:
> > After installing the latest version of Xenomai last week I have
> > encountered a problem with Xenomai applications hanging linux
> > completely, requiring restart.  This has also occured while running
> > xeno-test, during the latency tests.
> > 
> > I have tried to follow the various suggestions on this board about
> > preventing hanging of Xenomai, however I am still experiencing the
> > problem.
> > 
> > I am using:
> > Vanilla Linux Kernel 2.6.24
> > Adeos Patch 2.6.24-x86-2.0-07

^^^^^

> > Xenomai Patch 2.4.X (from 19th May 2009)
> > Ubuntu 8.04
> > 
> > I have attached my kernel config file, and the output from one
> > instance of 'busybox sh xeno-test'.
> > 
> > Importantly CONFIG_CPU_FREQ, CONFIG_CPU_IDLE, and ACPI_PROCESSOR are
> > not set, while ACPI is enabled and APM does not occur in my config.
> > Also, CONFIG_PREEMPT_NONE = y.
> > 
> > As always, if you need me to try anything or need more info then let me know,
> 
> Could you try and disable the audit and selinux things? Also, could you
> use a serial cable to get the kernel console, or use netconsole if that
> is not possible? If what happens is a kernel oops, you will get the
> information on the console.
> 
> I do not see anything else suspicious in your .config.
> 
-- 
Philippe.



