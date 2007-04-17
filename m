From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4625115C.6070007@domain.hid>
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221037@domain.hid>
	<4624D71E.3040008@domain.hid>  <4625115C.6070007@domain.hid>
Content-Type: text/plain
Date: Tue, 17 Apr 2007 21:40:03 +0200
Message-Id: <1176838803.5014.43.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Perfs and rt alarms questions.
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>

On Tue, 2007-04-17 at 20:26 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > RAKOTOSALAMA, Nirilanto wrote:
> >> Hello everybody.
> >>
> >> I managed to compile a stable kernel (the Scalability O(1) scheduler options seems to make my system freeze)
> > 
> > That's not good. What precisely did you do? Applied the .config you
> > posted, just enabling CONFIG_XENO_OPT_SCALABLE_SCHED? And what test
> > case, latency?
> 
> Hmm, maybe related: Philippe, I once posted you an oops under
> qemu-system-x86_64 which we explained with a probably broken toolchain.
> 
> I just pulled out that config again, updated everything
> (crosstools-0.43: gcc-4.1.1-glibc-2.3.6-tls + tiny patch [1], Xenomai
> trunk, adeos-ipipe-2.6.19-x86_64-1.0-06) - and still got that crash on
> "latency" startup. The oops still happens around [2]. Interesting is
> that turning off CONFIG_XENO_OPT_SCALABLE_SCHED makes it go away.
> 

I'm still having the same breakage on qemu with the scalable scheduling
option disabled. Looking at the generated x86_64 code, there's really
something fishy with both 3.4.5 and 4.1.0 stock.

> Given that I now tested my setup with gcc4 (instead of the earlier gcc3
> run), there may be some code that "confuses" compilers (or it's simply
> broken). I failed to reproduce the issue on x86, and cross debugging
> somehow still don't work for me, so I can't tell more.
> 

I have only reproduced it on qemu x86_64; the issue goes away with 3.4.6
20060404 (Red Hat 3.4.6-3) on real hw.

> Jan
> 
> [1]https://www.x86-64.org/pipermail/discuss/2006-November/009546.html
> [2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#225
> 
> 
-- 
Philippe.



