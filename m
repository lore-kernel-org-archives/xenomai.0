From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451D38BA.1070105@domain.hid>
References: <451D338A.1050407@domain.hid>  <451D38BA.1070105@domain.hid>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 17:26:20 +0200
Message-Id: <1159543580.4973.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [RFC][PATCH 2/2] detect domain
	violations
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-09-29 at 17:16 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > This patch is an RFC as the following issues need to be resolved:
> > 
> >  o The might be parts of I-pipe remaining that make use of
> >    preemp_disable even over non-root contexts. Philippe indicated the
> >    PPC PIC code would be one example.
> 
> Mmpf, first test, then post. Looks like there are more subtle scenarios
> hidden:
> 

[...]

> Namely, __switch_to->__unlazy_fpu->save_init_fpu->preempt_disable.
> Philippe, looks like killing the ipipe_preempt_guard is not trivial...
> 
> Anyway, attached version 2 of this patch enables both stack dump and
> ipipe-backtrace.
> 

No, it's not. This is the reason why we should make this disabling an
obscure I-pipe config option (like in the kernel hacking section,
default off), so that each and every platform could be validated
separately, before actually removing the whole damn thing from
linux/preempt.h.

-- 
Philippe.



