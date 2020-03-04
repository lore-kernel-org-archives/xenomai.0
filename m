MIME-Version: 1.0
References: <7231-5e5f6e00-9-3b6a0580@56070809>
In-Reply-To: <7231-5e5f6e00-9-3b6a0580@56070809>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 4 Mar 2020 08:57:46 -0500
Message-ID: <CALLqZ8RJxbjTL8kbhc_vHvta5fpqTd0PmMea1wnb5Q_cGWMCYw@mail.gmail.com>
Subject: Re: GPIO interrupt not working on Zynq7000
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

Hi,

On Wed, Mar 4, 2020 at 4:01 AM Fran=C3=A7ois Legal via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
>
> trying to diagnose an interrupt problem on a Zynq 7000 hardware. The
> environment is linux 4.4.189, xenomai 3.0.9.
>
> I'm trying to trig some realtime thread pending on a gpio read.
>
> At the beginning, the system would freeze if the GPIO pin was toggled,
> because the GPIO int pending status was never cleared by the existing cod=
e.

how do you clear it? Do you call one of the irqchip functions?

>
> So now I don't get the system freeze anymore, however, the RTDM gpio  irq
> handler never gets called whenever the interrupt is raised.
>
It=E2=80=99s possible what you called to clear the irq has also masked the
interrupt and requires a unmask. Can you post a patch of what you did?


> I'm not sure how to diagnose that. For what I could see, the IRQ is
> registered in ipipe domain "xnsched_realtime_domain", and I'm not sure if
> that matches "ipipe_head_domain" that is


Are you using the rtdm gpio driver? Or is this a custom rtdm driver using
the gpio directly?


>
> Any help appreciated
>
> Fran=C3=A7ois
>

Greg

>
>
>
