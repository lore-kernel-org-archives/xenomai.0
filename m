Message-ID: <50335C18.1090202@xenomai.org>
Date: Tue, 21 Aug 2012 11:59:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfX7f-c7ZK5JXcPGFxK=cJDGK10sMz7JXY_AgO2qkxETQ@mail.gmail.com>
In-Reply-To: <CAKKWdtfX7f-c7ZK5JXcPGFxK=cJDGK10sMz7JXY_AgO2qkxETQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] a question about "life-with-adeos" manual
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/21/2012 11:28 AM, ali hagigat wrote:
> I have copied part of  "life-with-adeos"  document:
>
> ------------------------------
> Sharing interrupts between domains
> void realtime_eth_handler (unsigned irq, void *cookie)
> {
> /*
> This interrupt handler has been installed using
> rthal_irq_request(), so it will always be invoked on behalf of
> the Xenomai (primary) domain.
> */
> rthal_irq_disable(irq);
> /* The Xenomai domain won't receive this irq anymore */
> rthal_irq_host_pend(irq);
> /* This irq has been marked as pending for Linux */
> }
>
> In the non=ADworking example above, since Xenomai always uses the
> explicit propagation
> mode for all interrupts it intercepts, the next ethernet interrupt
> will be marked as pending
> in the Xenomai log only, waiting for the Xenomai handler to possibly
> propagate it
> manually down to Linux.
> ------------------------------
>
> We know that calling rthal_irq_disable(irq), makes that interrupt
> disabled at PIC level and also stops enabling to propagate it.

No, this does not stop propagation. It stops internal delivery by the=20
log syncer to the target domain, which is different.

> If that interrupt is disabled in hardware, how the manual says that
> the next ethernet interrupt will be marked in the interrupt xenomai
> log only?

"next" in this context means the "after you read this code", not "after=20
this code has run".

>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


--=20
Philippe.

