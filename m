Message-ID: <493E4113.3090708@domain.hid>
Date: Tue, 09 Dec 2008 10:57:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <493E3ED4.7090405@domain.hid>
In-Reply-To: <493E3ED4.7090405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debugging RT threads with GDB on ARM/PowerPC
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> I understood that GDB can be used to debug Xenomai real-time
> applications but it seems not to work with my application on PowerPC or
> ARM. The applications looses determinism quickly, mainly because RT
> threads switch to secondary mode somehow. Have I missed something? Are
> there any known issues with GDB on ARM or PowerPC?
>

Using GDB means that you lose determinism, by essence. Debugging time can't be
for free anyway. Additionally, GDB is based on ptrace(), ptrace() makes heavy
use of Linux signals to control the debuggee, so as a matter of fact, the
application under debug has to switch to secondary mode each time GDB takes
control over it, which means, most of the time as soon as you are actually
debugging it. The same goes for breakpointing, since this triggers faults, hence
needs a switch to Linux mode as well, because ptrace() would not be happy to
process the breakpoint in the middle of a primary context.

This is not a ppc or arm issue. This is common to all archs.

> Wolfgang.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

