Message-ID: <b647ffbd0604121117l6aedcf4aj504c31d92f5ea75f@domain.hid>
Date: Wed, 12 Apr 2006 21:17:46 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [draft PATCH] nested enable/disable irq calls
In-Reply-To: <443C1D29.5020105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
	<443C1D29.5020105@domain.hid>
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
Cc: xenomai@xenomai.org

> Yes, I do have some remarks: due to legacy issues (I think to remember),
> we have a lot of unbalanced irq-enable/disable code out there. IRQs are
> currently enabled after registering a handler, but are not disabled on
> detach. That's because of problems with Linux when letting it take over
> a disabled IRQ,

let's consider possible use cases one by one :

1) single interrupt object for a given IRQ in the primary mode

I guess, this is the most wide-spread use case for the legacy code.

possible problems:

o  unbalanced enable/disable calls - e.g. a few consecutive disable calls b=
ut
   a single enable call is supposed to re-enable the IRQ line afterwards.

   the only workaround - review and fix such code :)


2) a few interrupt objects in the primary domain.

new mode so there should not be too much code that use it out there.

Actually, here goes a problem.

rtdm_irq_request();=09// doesn't enable the IRQ line
...
rtdm_irq_enable();=09// explicitly enables the IRQ line


the same code is called for every ISR that share this IRQ line.

so how the internal counter is supposed to be used then?

i.e. we should avoid printing a warning when the counter becomes 0.

 int xnintr_enable (xnintr_t *intr)

 {
    int ret =3D 0;
    spl_t s;

    xnlock_get_irqsave(&nklock,s);

    switch (__xnintr_depth(intr,0))
=09{
=09case 0:
-=09    xnlogerr("xnintr_enable() : depth =3D=3D 0. "
-=09=09     "Unbalanced enable/disable calls for IRQ%d!\n",intr->irq);
=09    break;
=09case 1:
=09    ret =3D xnarch_irq_enable(intr->irq);
=09default:
=09    __xnintr_depth(intr,-1);
=09}

    xnlock_put_irqrestore(&nklock,s);
    return ret;
 }

and, in fact, in the shared mode a driver can't rely on the fact that
the IRQ line is still disabled
after attaching to the IRQ line.

driver 2:

rtdm_irq_request(..., SHARED, ...);=09// we have attached to the shared
IRQ line which is already enabled

... // this code can't expect that it's executed with the IRQ line off.

rtdm_irq_enable();=09// explicitly enables the IRQ line


does it make sense to enable the IRQ line when attaching to the line?

rtdm_irq_request();
// the line is already enabled


3) the IRQ line is shared across domains (both primary and linux).

yep, new interface doesn't fit this case well.

Maybe, it would be possible to use the same "counter" accounting scheme
for xnintr_enable/disable() in the primary domain and
enable_irq/disable_irq() in the linux one.


> Another thing I have on my mind ATM is providing an additional IRQ
> model: threaded IRQs. This is certainly not the best default model, but
> it could help in certain scenarios to reduce prio-inversions due to
> overloaded IRQ handler jobs (like we face from time to time with devices
> on the slow ISA-bus...).

In the simplest case, I guess, one may just defer part of the work to
the bottom half -
a thread of a given priority. And bottom halves (threads) for
different ISRs may have different
priorities (=3D=3D thread's priority).

Concerning the general support, RTDM layer would be likely preferable
but I'm not sure that all necessary
bits are available on this layer.

e.g.

it would be better to run the following code from xnintr_shirq_handler()
...
    while (intr)
        {
=09s |=3D intr->isr(intr) & XN_ISR_BITMASK;
        ++intr->hits;
        intr =3D intr->next;
        }
...

already from the thread context.


--
Best regards,
Dmitry Adamushko

