Message-ID: <b647ffbd0601100737j50909ba4u@domain.hid>
Date: Tue, 10 Jan 2006 07:37:40 -0800
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <17346.54589.751654.349370@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0601091221h5596da2fg@domain.hid>
	<17346.54589.751654.349370@domain.hid>
Subject: [Xenomai-core] Re: nucleus:shared irq, draft v.2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 09/01/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Dmitry Adamushko wrote:
>  > Hi everybody,
>  >
>  > I'm presenting it one last time as a draft, so it's a right time to gi=
ve
> all
>  > the remarks concerning design/implementation issues for all interested
>  > parties.
>  >
>  > Any feedback is wellcome.
>
> Maybe I missed some recent changes in Xenomai HAL or Adeos, in which
> case, please forget my remark, but calling xnarch_hook_irq,
> i.e. rthal_irq_request when nklock is locked, irq off, may lead to
> deadlock on multi-processor machines. The situation is (or used to be)
> as follows:
>
> CPU1
> holds the nklock
> calls rthal_irq_request, which calls ipipe_critical_enter, which:
>    triggers the critical IPI
>    spins, waiting for other CPUs to enter __ipipe_do_critical_sync
>
> CPU2
> spins on nklock, irq off
> never handles the critical IPI, because irqs are off
>

Nop, your remark is actually right to the place. I had some doubts
regarding the use of nklock here but, flankly, I didn't even consider
that possible deadlock. Thanks for a hint.

> I only skimmed over the discussion about ipipe_virtualize_irq_from. I do
> not know if it finally flushes all pending interrupts an all CPUs when
> called with a NULL handler. But if it does, the call to
> xnintr_shirq_spin seems redundant in xnintr_detach.

Well, the problem is that the shirq->handlers list, i.e. the shirq
object itself may be in use
at the moment when xnintr_detach() is called. That said, the shirq
object as well as all the elements of shirq->handlers (those that have
been removed by xnintr_detach() from the list) must remain valid as
long as there is a isr handler for the given irq running (i.e.
xnintr_irq_handler() ).

To sum it up:

xnintr_shirq_spin() is for:

o  "shirq" must be deleted only when the xnintr_irq_handler() for the
given irq has completed;

o  even if there is no need to delete the "shirq" object (there are
other intr objects in the list) the xnintr_detach() must wait until
the handler gets completed, thas keeping intr->link valid.

Ok, maybe my explanation is a bit confusing but the direct analogy is
the way used in Linux, namely the synchroize_irq() call (take a look
at how it's used in free_irq()).

This is a kind of RCU. The element is removed from the list but it's
completely freed only when all the read clients are completed (in our
case, xnintr_irq_handler() and handle_IRQ_events() in Linux).

>
> --
>
>
> =09=09=09=09=09    Gilles Chanteperdrix.
>


--
Best regards,
Dmitry Adamushko

