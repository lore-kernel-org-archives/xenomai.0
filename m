MIME-Version: 1.0
Date: Tue, 21 Aug 2012 13:58:33 +0430
Message-ID: <CAKKWdtfX7f-c7ZK5JXcPGFxK=cJDGK10sMz7JXY_AgO2qkxETQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] a question about "life-with-adeos" manual
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

I have copied part of  "life-with-adeos"  document:

------------------------------
Sharing=A0interrupts=A0between=A0domains
void realtime_eth_handler (unsigned irq, void *cookie)
{
/*
This interrupt handler has been installed using
rthal_irq_request(), so it will always be invoked on behalf of
the Xenomai (primary) domain.
*/
rthal_irq_disable(irq);
/* The Xenomai domain won't receive this irq anymore */
rthal_irq_host_pend(irq);
/* This irq has been marked as pending for Linux */
}

In=A0the=A0non=ADworking=A0example=A0above,=A0since=A0Xenomai=A0always=A0us=
es=A0the
explicit=A0propagation
mode=A0for=A0all=A0interrupts=A0it=A0intercepts,=A0the=A0next=A0ethernet=A0=
interrupt
will=A0be=A0marked=A0as=A0pending
in=A0the=A0Xenomai=A0log=A0only,=A0waiting=A0for=A0the=A0Xenomai=A0handler=
=A0to=A0possibly
propagate=A0it
manually=A0down=A0to=A0Linux.
------------------------------

We know that calling rthal_irq_disable(irq), makes that interrupt
disabled at PIC level and also stops enabling to propagate it.
If that interrupt is disabled in hardware, how the manual says that
the next ethernet interrupt will be marked in the interrupt xenomai
log only?

