Message-ID: <60766.155.98.4.150.1155759747.squirrel@domain.hid>
In-Reply-To: <44E37321.1010400@domain.hid>
References: <20060816190510.20935.qmail@domain.hid>
	<49365.155.98.4.150.1155755874.squirrel@domain.hid>
	<44E37321.1010400@domain.hid>
Date: Wed, 16 Aug 2006 14:22:27 -0600 (MDT)
Subject: Re: [Xenomai-help] problem with installation
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

> Good that someone read the real error...
>
> Was this issues related to Xenomai or the Adeos patch? Or were there
> just some drivers missing in the kernel directly or initfs?
>
> It is typically fine to derive the Xenomai kernel .config from an
> existing one (e.g. that your your distro), just switching of the
> features listed as problematic.
>
> Jan

The setup I'm using is ubuntu 6.06 on an Athlon XP 2100+.  As to whether
it was adeos or xenomai that causes/caused the error I can't say.  I
compiled the kernel using the ubuntu kernel configuration as a base and
enabling periodic timer support.  When the system had grub installed on a
separate boot partition, I got that same error when trying to boot from
the xenomai version of the kernel.  However, when there was no boot
partition, the system booted just fine.  I used the same .deb in both
cases, so that was the only difference in setup.

Consequently, when the system had a separate boot partition but period
timer support was not enabled, it also booted just fine.  However, I need
the timer for my work so that wasn't particularly useful for me.
-Brandt


