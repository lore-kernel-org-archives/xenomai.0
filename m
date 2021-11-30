MIME-Version: 1.0
References: <d25-61a62700-27-1ed4ee4@258913418>
 <d23-61a63c00-35-25b05b40@3897673>
In-Reply-To: <d23-61a63c00-35-25b05b40@3897673>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 30 Nov 2021 10:32:46 -0500
Message-ID: <CALLqZ8SFtM6Z-7n-DU-Z_XT7QnT7zGAy0mJCndavAo8s-k8fKQ@mail.gmail.com>
Subject: Re: IRQ not raised switching from 4.4.x to 4.19.x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On Tue, Nov 30, 2021 at 9:59 AM Fran=C3=A7ois Legal via Xenomai <
xenomai@xenomai.org> wrote:

> So I guess I have the beginning of the explanation.
> By checking the GIC registers more thoroughly, I found out the trigger
> type was not set properly (my device uses edge interrupts, and GIC was
> setup with level interrupts)
> What's not clear is that the interrupt trigger type is set, if I
> understand correctly, when one calls platform_get_irq (if IRQ flags are s=
et
> in the DT, they are setup at that moment).
> That seems to work OK for linux interrupts, but somehow, these flags get
> reset for xenomai interrupts (and that did not seem to be the case earlie=
r).
> Still digging there to find out what's going on.
>
> I found out that rtdm_irq_request can have RTDM_IRQTYPE_EDGE as flag
> argument, but I'm still not sure how this flag gets handed to ipipe and
> then to the GIC.
>
> Still searching
>
> Fran=C3=A7ois
>
> Le Mardi, Novembre 30, 2021 14:28 CET, Fran=C3=A7ois Legal via Xenomai <
> xenomai@xenomai.org> a =C3=A9crit:
>
> > Hello,
> >
> > I'm experiencing a weird issue while transitioning Xenomai 3.1 from
> linux 4.4 to 4.19.
> > Platform is Zynq 7000 ARM Cortex A9.
> > Using the exact same hardware, porting a network device driver, the
> interrupts that should trigger whenever a packet is sent or received do n=
ot
> grif any more. I can see the network packets being sent & received by
> devmem'ing to the device memory and buffers, but no interrupt ever happen=
s.
> >
> > I checked the various GIC registers, and everything seems to be OK.
> >
> > Any idea ?
> >
> > Thanks in advance
> >
> > Fran=C3=A7ois
> >
>

Hi Francois,
   I can help and take a look later tonight if you still are having issues.

Thanks

Greg

>
>
>
>
