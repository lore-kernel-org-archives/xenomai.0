From: Patrick Roberts <patrick.m.roberts@domain.hid>
Date: Wed, 25 Aug 2010 15:01:45 +0000 (UTC)
Message-ID: <loom.20100825T165507-176@domain.hid>
References: <AANLkTikeCvjxZW5xjxMKf3atZO-A=t7AFDCr4oRtHoVz@domain.hid>
	<4C743D5C.3020004@domain.hid>
	<AANLkTinGZRptSbQPPF-NBiipx2jyt=oz_QHxfftWxMvx@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai on intel core i7
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

Gajamohan Mohanarajah <gajamohan.m <at> gmail.com> writes:

> 
> I still have not tried. Just checking any known issues since the
> processor is relatively new.
> 
> Best Regards,
> Gajan
> 
> On 24 August 2010 23:45, Gilles Chanteperdrix
> <gilles.chanteperdrix <at> xenomai.org> wrote:
> > Gajamohan Mohanarajah wrote:
> >> Hi,
> >>
> >> Is there any problems when using Xenomai on an i7 (-880 / Dell
> >> Precision T1500).
> >> Any tips/suggestions/experiences are most welcome.
> >
> > Why do you ask? Did you have any issue when trying it?
> >
> > --
> >                                            Gilles.
> >
>

 I tried Xenomai on several platforms with the following results:
 
1) Dell laptop with i7 processors, multicore
    Typical latency was around 5 usec,  but at least once per second had a 
long pass of approximately 700 usec.   Tried the xenomai SMI work around with 
no noticable change in results.   Many iterations of kernel settings, periodic 
high latency passes in all.  For a very good paper on i7 xenomai see:
http://download.intel.com/design/intarch/papers/322386.pdf  they had more luck 
than I did.
 
 
2) Atom processor laptop
    Typical latency around 5 usec,  this machine would run 10 minutes or so 
with low latency but would eventually give a single sporadic high latency pass.
 
3)   PC/104 atom processor
    This was our desired target from the start the other two were just 
experiments.
    Very good success.  Ran four test for two hours each.  1) Non-reatime side 
unloaded, 2) flood ping to generate interrupts, 3) cpuBurn to load processor, 
and 4) combination of both cpuBurn and flood ping.
 
Our conclusion is the results are very hardware dependent.       Can't really 
tell you which processor to use.  I can only give you our results.

Patrick Roberts





