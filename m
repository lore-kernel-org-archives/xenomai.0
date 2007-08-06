Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Aug 2007 14:25:00 +0100
Message-ID: <BCC5E4E7C20D3C4780433ADBFF20273C07C97B@GBPLESL203AMSX.gb001.siemens.net>
In-Reply-To: <46B71EC3.9010101@domain.hid>
From: "Richardson, Andy" <andy.richardson@domain.hid>
Subject: Re: [Xenomai-help] Random crash in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hi,=20
 I get an AIEE, but no oops! I have disabled the xenomai RTDM device
open in my software and the problem goes away. The standard aiee
complains and "disables interrupt handler". The system then reboots. I
am using a custom PPC board with version 2.6.14 of Linux and 2.2.4 of
Xenomai. I don't seem to be able to activate Adeos debugging: I can
compile the kernel with that option enabled, but the board won't boot
when using it! Is there an option I can use to output more printk's from
Linux when booting?

Thanks in advance,


Andy

Andy Richardson
Senior Engineer - Embedded Control
Siemens Traffic Controls
Sopers Lane, Poole, Dorset. BH17 7ER. UK.
Tel: 01202 782857
Fax: 01202 782545
www.siemenstraffic.com


-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: 06 August 2007 14:15
To: Richardson, Andy
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Random crash in Xenomai

Richardson, Andy wrote:
> Dear all,
>   I keep on getting random crashes when the RTDM system is used for
the
> first time. Looking at previous posts it may be something todo with
the
> /proc file system interface, is there any way to disable  /proc
> interaction all together in the kernel compilation?

Normally, yes (unless some other subsystem or userland depends on it):
CONFIG_PROC.

However, I would be very interested in seeing the oops dump you get (try
to capture with a serial console if the system hangs) + some information
about the versions you use. We should try to kill that gremlin first
before considering workarounds (which may only postpone the crash, BTW).

Jan


