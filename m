From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <458032AC.4060707@domain.hid>
References: <4576842B.1090203@domain.hid> <1165398116.7218.31.camel@domain.hid>
	<458032AC.4060707@domain.hid>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 18:24:48 +0100
Message-Id: <1166030688.5360.171.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [RFC] type-based spinlock op
	selection
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-12-13 at 18:04 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-12-06 at 09:49 +0100, Jan Kiszka wrote:
> >> Hi,
> >>
> >> reading through the I-pipe patch I noticed that there are quite a few
> >> spin_lock->spin_lock_hw and similar conversions. Having the conversion
> >> mechanism of the -rt patch in mind, I wrote the attached I-pipe cleanup
> >> that applies a similar pattern on this issue. Gives more than 10k patch
> >> size reduction for x86 and a bit more safety against minor variations of
> >> the patched code. Still, review of the lock usages keeps on being
> >> required as the lock user could assume running IRQs off while I-pipe may
> >> not guarantee this.
> >>
> >> The required patch for Xenomai is attached as well.
> >>
> > 
> > I definitely like this. Queued for testing, thanks.
> > 
> 
> Small update of the ipipe part: typecasts were missing for the
> SMP||DEBUG_SPINLOCK case.

I saw this recently, thanks. I'm currently working on 1.6-02, which
includes the spinlock op selection, and yet-another-rework of the
interrupt flow. Did anything changed regarding the tracer in the
attached patch?

-- 
Philippe.



