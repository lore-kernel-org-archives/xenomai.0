MIME-Version: 1.0
References: <20220210153313.2229625-1-gunter.grau@philips.com>
In-Reply-To: <20220210153313.2229625-1-gunter.grau@philips.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 10 Feb 2022 10:39:34 -0500
Message-ID: <CALLqZ8Rhf-nXwT8qoshtWZhJ-=UDe=o=gkKbs0Yg0uodaw2GMg@mail.gmail.com>
Subject: Re: Issue with linux threaded level triggered interrupts
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
To: Gunter Grau <gunter.grau@philips.com>
Cc: xenomai@xenomai.org

On Thu, Feb 10, 2022 at 10:34 AM Gunter Grau via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> during our development on imx6 with kernel 5.4 and Xenomai 3.1 we
> discovered complete system stalls when using phylib with phy irqs level
> triggerd. This irq is connected on the imx-gpio.
>
> Investigation showed that it seems to be an issue in the ipipe irq end
> function for level interrupts. Please review the patch proposal.
> I am not sure if just calling unmask_irq() is ok here since this functin
> also does some locking. The other way would be to just call additionally
> the irq_state_clr_masked(desc) in the level end function itself.
>
> The patch applies on ipipe/master in ipipe-arm.
> It looks like this is an issue in all ipipe patches, but is triggered
> by the introduction of a check in unmask_irq().
>
> Thanks in advance,
> Gunter Grau
>
>
>
>
> ________________________________
> The information contained in this message may be confidential and legally
> protected under applicable law. The message is intended solely for the
> addressee(s). If you are not the intended recipient, you are hereby
> notified that any use, forwarding, dissemination, or reproduction of this
> message is strictly prohibited and may be unlawful. If you are not the
> intended recipient, please contact the sender by return e-mail and destro=
y
> all copies of the original message.
>

I=E2=80=99ll integrate and test this patch out over the weekend, I can=E2=
=80=99t say off
the top of my head what is the better solution. I=E2=80=99ll have feedback =
in a few
days.

Thanks for the patch :)

Greg

>
>
