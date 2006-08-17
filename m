Subject: Re: [Xenomai-help] Debugging
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200608171405.44978.s.zimmermann@domain.hid>
References: <200608171405.44978.s.zimmermann@domain.hid>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 14:41:39 +0200
Message-Id: <1155818499.4366.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-08-17 at 14:05 +0200, Stephan Zimmermann wrote:
> Hello List,
> I am facing some trouble debugging my Xenomai application. When I set a 
> breakpoint in my main() task, everything works fine. If I set a breakpoint in 
> another task, the debugger won't stop the application. Is this a known 
> problem,

No.

>  or am I doing something wrong (compiler/debugger options)? I tryed 
> it within Eclipse and gdb commandline interface, both gave me the same 
> results. Can someone give me a Hint?
> 

The language used has no incidence for on the way breakpoints are
handled kernel-wise. Are you 100% sure that the code location is indeed
executed (e.g. is a breakpoint on a trace statement ignored by GDB
albeit the trace appears?); does "info breakpoints" gives you the right
output regarding your breakpoint (i.e. is it enabled, and at the right
place you expect it to be)?

In any case, we would need a simple test code reproducing the issue to
further investigate it, if any.

> My System:
> Debian 3.1 on AMD X2, running in 32bit mode
> Xenomai 2.2 on Kernel 2.6.17.6, with no other patches
> debian standard gcc 3.3.5
> (same problem on intel notebook)
> The program I'm working on is written in C++, wrapping classes around the 
> native skin.
> 
> Thanks
> Stephan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



