MIME-Version: 1.0
References: <20200529041233.536263-1-greg@embeddedgreg.com>
 <530a8c03-8367-6adb-800a-a7a63d60b795@siemens.com>
In-Reply-To: <530a8c03-8367-6adb-800a-a7a63d60b795@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 29 May 2020 13:27:43 -0400
Message-ID: <CALLqZ8TSXsDA0evbe1QxHKbgvk1CW7cKpsSY1dQSoMP2P3tPtA@mail.gmail.com>
Subject: Re: [PATCH] Enable zynq gpio and xilinx gpio support for the Zynq MP
 platform.
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Joshua Karch <jkarch48@hotmail.com>

On Fri, May 29, 2020 at 1:04 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 29.05.20 06:12, Greg Gallagher via Xenomai wrote:
> > Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> > Signed-off-by: Joshua Karch <jkarch48@hotmail.com>
>
> Did you mean "Reported-by: Joshua" or should "From:" be rather Josh?
>
> Jan
Good catch, I based this off of code that was sent via email, so it
should be from Josh signed off by me.  I'll fix that.

thanks

Greg
>
> > ---
> >  kernel/drivers/gpio/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
> > index dbc862754..44f41688c 100644
> > --- a/kernel/drivers/gpio/Kconfig
> > +++ b/kernel/drivers/gpio/Kconfig
> > @@ -34,7 +34,7 @@ config XENO_DRIVERS_GPIO_SUN8I_H3
> >       SoC, as found on the NanoPI boards.
> >
> >  config XENO_DRIVERS_GPIO_ZYNQ7000
> > -     depends on ARCH_ZYNQ
> > +     depends on ARCH_ZYNQ || ARCH_ZYNQMP
> >       tristate "Support for Zynq7000 GPIOs"
> >       help
> >
> > @@ -42,7 +42,7 @@ config XENO_DRIVERS_GPIO_ZYNQ7000
> >       Xilinx's Zynq7000 SoC.
> >
> >  config XENO_DRIVERS_GPIO_XILINX
> > -     depends on ARCH_ZYNQ
> > +     depends on ARCH_ZYNQ || ARCH_ZYNQMP
> >       tristate "Support for Xilinx GPIOs"
> >       help
> >
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

