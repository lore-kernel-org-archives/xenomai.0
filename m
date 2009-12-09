From: Josh Karch <JKarch@domain.hid>
Date: Wed, 9 Dec 2009 12:34:10 -0800
Message-ID: <843773D242212C4882D4EDFFBF665F7F0155A93AAA@FW-SBS.fw.local>
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>,
	<4B1FEF97.9000509@domain.hid>
In-Reply-To: <4B1FEF97.9000509@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
	parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Jan,

I did a complete make mrproper on the system and recompiled without debuggi=
ng parameters, which took a few hours on the machine because the modules ta=
ke up a lot. I probably should prune all unused modules (eg video, pcmcia, =
sound, etc) that I'm not using.

I guess I will have to back up my current /lib/modules/2.6.30.8 when I reco=
mpile with all debug support for that experiment, grab the data, and then g=
et that to you once my testing (hopefully) is successful on this change wit=
hout kernel debugging options.

Cheers,

Joshua Karch
________________________________________
From: Jan Kiszka [jan.kiszka@domain.hid]
Sent: Wednesday, December 09, 2009 10:42 AM
To: Josh Karch
Cc: xenomai@xenomai.org
Subject: Re: Xenomai scheduling while atomic bug--debugging   parameters

Josh Karch wrote:
> Gilles,
>
> sounds good-- for now I'm recompiling the kernel with all debug options d=
isabled to see if my program will run stable, but I can make another compil=
ing with all options enabled for kernel debugging, ipipe debugging, and xen=
omai debugging, run it, send a config.  I have a couple of questions:
> 1) is it possible to disable all of these debugging parameters in the ker=
nel boot parameter or do I have to recompile

No for most of them. You can compile some tracing features in and leave
them disabled during runtime until needed, but e.g. frame pointers are
too basic.

> 2) What is the best way to collect a trace?  Right now I have copied from=
 kern.log, messages, and syslog (in /var/log), although they are all simila=
r.

As long as dmesg works or syslogd/klogd is able to grab the kernel
console, one of such sources suffices. If the system somehow behaves
strange, drops the first oops, or even hard-locks, collect them via
serial console/netconsole on a remote system.

> 3) Is there a quick way to recompile the kernel with these options withou=
t having to rebuild all the kernel modules or do I need to do a clean and r=
ebuild?

Don't do that, always rebuild properly or you create a bunch of
additional sources for troubles. Some config changes do allow this, but
unless you know them and their restrictions, better don't try to "find"
them. Having a proper build environment, rebuilding a tailored embedded
kernel + modules shouldn't take longer than a few minutes.

Jan

--
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

