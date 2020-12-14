MIME-Version: 1.0
References: <87pn3mzxeh.fsf@xenomai.org>
 <5700bc80-fb99-0420-a386-13c0cab91c6e@siemens.com>
In-Reply-To: <5700bc80-fb99-0420-a386-13c0cab91c6e@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 14 Dec 2020 11:11:09 -0500
Message-ID: <CALLqZ8TdQLXAxAfDgFUZb9YhhkqZxxmrOOJ83gKYvAokJss9fg@mail.gmail.com>
Subject: Re: [CXP][RFC] Pick RTDM for the common kernel interface
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 14, 2020 at 7:45 AM Jan Kiszka via Xenomai <xenomai@xenomai.org>
wrote:

> On 06.12.20 17:56, Philippe Gerum via Xenomai wrote:
> >
> > The common Xenomai platform specification is about defining the
> > commonalities among future Xenomai releases starting from 3.3,
> > including the Xenomai 4 series based on a next generation (EVL)
> > core. A common kernel interface available for implementing
> > Xenomai-controlled drivers is part of this specification.
> >
> > Xenomai 3.x and earlier have long promoted the RTDM interface for
> > implementing drivers, which encourages a separated driver model by
> > design. Instead, the EVL core which is going to be the cornerstone of
> > Xenomai 4 promotes an integrated approach to developing real-time
> > drivers when possible, by adding so-called "out of band" capabilities
> > directly to the implementation of existing mainline drivers [1][2]. A
> > custom EVL driver which has no counterpart in the mainline kernel tree
> > is still a regular character device driver, although it must use the
> > real-time services brought by the EVL core for its time-critical
> > operations [3].
> >
> > The purpose of defining a common kernel interface as part of the CXP is
> > specifically about helping with portability of existing custom drivers
> > built for Xenomai 3.x towards Xenomai 4. Following the regular driver
> > model as promoted by EVL along with using the EVL core interface
> > directly would be the recommended way of developing drivers for Xenomai
> > 4.
> >
> > However, some RTDM features/services cannot be ported to an EVL-based
> > system, due to major differences between the Cobalt and EVL locking
> > models (e.g. RTDM_EXECUTE_ATOMICALLY(), along with any call involving
> > Cobalt's single "superlock").
> >
> >
> >
> > PROPOSAL: Adopt a large subset of the current RTDM specification as
> > the common kernel interface defined by the CXP. The exact set of RTDM
> > services which should be retained in the CXP implementation must be
> > discussed further.
> >
> > As a consequence, Xenomai 4 would provide a RTDM layer based on the EVL
> > core interface internally, which would preserve the driver taxonomy
> > ("named" / "protocol") and registration model inherited from its Xenomai
> > 3.x counterpart.
> >
> >                   drivers
> >       ....................................
> >            |                  |      |
> >            |                  |      |
> >           RTDM               RTDM    |
> >            |                  |      |
> >            v                  v      v
> >  (Cobalt core xn* API)   (EVL core evl_* API)
> >  ---------------------   --------------------
> >       Xenomai 3.x            Xenomai 4
> >
> > Applications could issue I/O requests to RTDM-based drivers via the
> > dedicated services from the common libcobalt interface also available
> > in both environments [4].
> >
> >
> > Thanks,
> >
> > [1] https://evlproject.org/core/oob-drivers/
> > [2] https://evlproject.org/core/oob-drivers/gpio/
> > [3] https://evlproject.org/core/kernel-api/
> > [4] https://xenomai.org/pipermail/xenomai/2020-December/043930.html
> >
>
> Ack regarding the commitment to RTDM compat support. How that RTDM
> version will eventually look like is not yet clear to me, though. It may
> not be 1:1 what we have today.
>
> E.g., both EVL and RTDM have to provide separate (from the kernel)
> synchronization primitives. I would see a lot of benefit in aligning
> them, rather than having yet another new set with EVL. People should be
> able to do
>
> #define rtdm_mutex_lock evl_lock_kmutex
>
> or vice versa.
>
> Jan
>

ACK.
The compatibility with RTDM I think makes a lot of sense.  I think the goal
should be if someone as a current RTDM driver there would be minimal change
to move it to a new version of Xenomai 3.x or 4.  As we start on this work
it may be a great time for people to get involved and help maintain some of
the existing drivers.

-Greg

>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
>
