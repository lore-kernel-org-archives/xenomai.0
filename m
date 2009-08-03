Date: Mon, 3 Aug 2009 19:29:54 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1249287753.4803.10.camel@domain.hid>
Message-ID: <Pine.LNX.4.62.0908031850580.29886@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid> 
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
	<Pine.LNX.4.62.0907291226390.20869@domain.hid>
	<1248883517.3532.7.camel@domain.hid>
	<alpine.DEB.2.00.0907292209410.5958@domain.hid>
	<1249287753.4803.10.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> - if the first option does not work, override the shipped Xenomai
> release with a stock one for testing:

I've now managed to use the prepare-kernel.sh (with
adeos-ipipe-2.6.28.10-blackfin.git-1.10-00.patch as it comes with
xenomai-2.4.8) on the 2.6.28.10 kernel that comes as "linux-2.6.x" with
uClinux-dist 2009R1-RC2.  Unfortunately, the three files ipipe.h,
ipipe.c and ints-priority.c therein already contain the changes from the
1.10 patch, so to apply that patch, they had to be reverted beforehand.

In userland and for my application I used stock xenomai-2.4.8; only the
xenomai-2.4.x.patch from uClinux-dist/user/xenomai had to be applied
so that /usr can be specified as a destination during configure. But
that patch doesn't change anything in the code.

Now, well, what should I say - the xnshadow call still fails. Or
whatever the real cause for this message is...

Kolja


