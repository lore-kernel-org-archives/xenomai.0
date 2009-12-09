Message-ID: <4B1FEF97.9000509@domain.hid>
Date: Wed, 09 Dec 2009 19:42:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>
In-Reply-To: <843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Josh Karch <JKarch@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Josh Karch wrote:
> Gilles,
> 
> sounds good-- for now I'm recompiling the kernel with all debug options disabled to see if my program will run stable, but I can make another compiling with all options enabled for kernel debugging, ipipe debugging, and xenomai debugging, run it, send a config.  I have a couple of questions:
> 1) is it possible to disable all of these debugging parameters in the kernel boot parameter or do I have to recompile

No for most of them. You can compile some tracing features in and leave
them disabled during runtime until needed, but e.g. frame pointers are
too basic.

> 2) What is the best way to collect a trace?  Right now I have copied from kern.log, messages, and syslog (in /var/log), although they are all similar.

As long as dmesg works or syslogd/klogd is able to grab the kernel
console, one of such sources suffices. If the system somehow behaves
strange, drops the first oops, or even hard-locks, collect them via
serial console/netconsole on a remote system.

> 3) Is there a quick way to recompile the kernel with these options without having to rebuild all the kernel modules or do I need to do a clean and rebuild?

Don't do that, always rebuild properly or you create a bunch of
additional sources for troubles. Some config changes do allow this, but
unless you know them and their restrictions, better don't try to "find"
them. Having a proper build environment, rebuilding a tailored embedded
kernel + modules shouldn't take longer than a few minutes.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

