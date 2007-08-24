From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46CE7B9F.1040607@domain.hid>
References: <1187901933.6009.20.camel@domain.hid>  <46CE7B9F.1040607@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Aug 2007 10:45:10 +0200
Message-Id: <1187945110.6009.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai degrades syscall time on PPC405
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
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2007-08-24 at 08:33 +0200, Dirk Eibach wrote:
> Hello Philippe,
> 
> tank you for your detailed answer.
> 
> >> Hello,
> >>
> >> I am trying to understand some performance problems I ran into on my 
> >> xenomai system.
> >>
> >> The testcode I attached performs a syscall(gettimeofday). Measuring time on 
> >> a vanilla Kernel gives the following output:
> >>
> >> ticks for ppc_getccounter: 116, for gettimeofday: 1479
> >>
> >> The same kernel with xenomai patched in gives this:
> >>
> >> ticks for ppc_getccounter: 116, for gettimeofday: 4278
> >>
> >> Is this the expected behaviour? Why is the time for a system call nearly 3 
> >> times as much?
> >>
> > 
> > When reporting figures, please report all of them. Here is your test ran
> > on a 405GPr, linux-2.6.14, I-pipe 1.5-03, with full output:
> > 
> > bash-3.00# ./ppc405_rt 
> > ticks for ppc_getccounter: 122, for gettimeofday: 7337
> > ticks for ppc_getccounter: 208, for gettimeofday: 2816
> > ticks for ppc_getccounter: 210, for gettimeofday: 2512
> > ticks for ppc_getccounter: 174, for gettimeofday: 2622
> > ticks for ppc_getccounter: 174, for gettimeofday: 2320
> > ticks for ppc_getccounter: 208, for gettimeofday: 2634
> > ticks for ppc_getccounter: 174, for gettimeofday: 2344
> > ticks for ppc_getccounter: 208, for gettimeofday: 2660
> > ticks for ppc_getccounter: 174, for gettimeofday: 2320
> > ticks for ppc_getccounter: 208, for gettimeofday: 2816
> > ticks for ppc_getccounter: 208, for gettimeofday: 2734
> > ticks for ppc_getccounter: 208, for gettimeofday: 2802
> > ...
> 
> I certainly tried to pick a representative sample. Here is the full series 
> with xenomai patched in:
> # ./syscall-test
> ticks for ppc_getccounter: 92, for gettimeofday: 18375
> ticks for ppc_getccounter: 116, for gettimeofday: 4250
> ticks for ppc_getccounter: 116, for gettimeofday: 4416
> ticks for ppc_getccounter: 116, for gettimeofday: 4372
> ticks for ppc_getccounter: 116, for gettimeofday: 4486
> ticks for ppc_getccounter: 116, for gettimeofday: 4376
> ticks for ppc_getccounter: 116, for gettimeofday: 4446
> ticks for ppc_getccounter: 116, for gettimeofday: 4434
> ticks for ppc_getccounter: 116, for gettimeofday: 4368
> ticks for ppc_getccounter: 116, for gettimeofday: 4418
> ticks for ppc_getccounter: 116, for gettimeofday: 4404
> ticks for ppc_getccounter: 116, for gettimeofday: 4384
> ...
> 
> 
> And here we go without:
> # ./syscall-test
> ticks for ppc_getccounter: 92, for gettimeofday: 6761
> ticks for ppc_getccounter: 116, for gettimeofday: 1768
> ticks for ppc_getccounter: 116, for gettimeofday: 1594

I have comparable values on the 405GPr in the vanilla case:

ticks for ppc_getccounter: 127, for gettimeofday: 6851
ticks for ppc_getccounter: 177, for gettimeofday: 1733
ticks for ppc_getccounter: 153, for gettimeofday: 1455
ticks for ppc_getccounter: 153, for gettimeofday: 1401

but still much lower values than you have in the Xenomai case.
The answer is either:

- in your kernel configuration,
- in the I-pipe patch,
- in the Xenomai version you are currently using

Btw, where does the I-pipe patch 2.6.18 1.5-00 you seem to be using come
from? Where did you pick it?

> ticks for ppc_getccounter: 116, for gettimeofday: 1560
> ticks for ppc_getccounter: 116, for gettimeofday: 1600
> ticks for ppc_getccounter: 116, for gettimeofday: 1574
> ticks for ppc_getccounter: 116, for gettimeofday: 1618
> ticks for ppc_getccounter: 116, for gettimeofday: 1560
> ticks for ppc_getccounter: 116, for gettimeofday: 1600
> ticks for ppc_getccounter: 116, for gettimeofday: 1540
> ticks for ppc_getccounter: 116, for gettimeofday: 1618
> ticks for ppc_getccounter: 116, for gettimeofday: 1566
> ticks for ppc_getccounter: 116, for gettimeofday: 1608
> ...
> 

-- 
Philippe.



