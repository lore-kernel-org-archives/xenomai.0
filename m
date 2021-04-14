MIME-Version: 1.0
References: <20210414144235.6e9d83cd@windsurf.home>
 <b72c8212-1638-891e-7a45-ffb9a5558400@siemens.com>
 <20210414203517.772ea33c@windsurf.home>
In-Reply-To: <20210414203517.772ea33c@windsurf.home>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 14 Apr 2021 14:41:29 -0400
Message-ID: <CALLqZ8RNyTP84gkchtSkaP=caMjLtPqu8K19bfPmueifuAjGuw@mail.gmail.com>
Subject: Re: ipipe 5.4.107 / 5.4.93 build issues on arm32
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
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Wed, Apr 14, 2021 at 2:35 PM Thomas Petazzoni via Xenomai <
xenomai@xenomai.org> wrote:

> Hello,
>
> On Wed, 14 Apr 2021 15:49:45 +0200
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> > Does
> >
> https://source.denx.de/Xenomai/xenomai/-/commit/18ab00b7b0c2c2d0ed1f560cf=
4fb4161f6e9bde6
> > help? Or did you build a tree that included this?
>
> This helps, but the build fails a bit later with:
>
> In file included from kernel/cpu.c:23:0:
> ./include/linux/stop_machine.h: In function =E2=80=98stop_machine_cpusloc=
ked=E2=80=99:
> ./include/linux/stop_machine.h:150:2: error: implicit declaration of
> function =E2=80=98hard_irq_enable=E2=80=99; did you mean =E2=80=98hard_ir=
q_disable=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   hard_irq_enable();
>   ^~~~~~~~~~~~~~~
>   hard_irq_disable
>
> But this makes me realize something: I am using Xenomai 3.1, together
> with the ipipe patch
> https://xenomai.org/downloads/ipipe/v5.x/arm/ipipe-core-5.4.107-arm-1.pat=
ch
> .
> Maybe this doesn't make any sense, and this very recent ipipe patch is
> only compatible with a more recent version of Xenomai ?
>
> Thomas
> --
> Thomas Petazzoni, co-owner and CEO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

Ipipe 5.4 and xenomai 3.1 are compatible, this is my mistake, I=E2=80=99ll =
fix up
and generate a new patch once the latency fix is done.
FWIW, building straight from the ipipe-arm repo on the ipipe/5.4.y branch
has been working for me.

 I=E2=80=99ll confirm the above issues and get a fix out.

Thanks

Greg


>
