Date: Wed, 14 Apr 2021 22:52:23 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: ipipe 5.4.107 / 5.4.93 build issues on arm32
Message-ID: <20210414225223.5c146b61@windsurf.home>
In-Reply-To: <CALLqZ8RNyTP84gkchtSkaP=caMjLtPqu8K19bfPmueifuAjGuw@mail.gmail.com>
References: <20210414144235.6e9d83cd@windsurf.home>
 <b72c8212-1638-891e-7a45-ffb9a5558400@siemens.com>
 <20210414203517.772ea33c@windsurf.home>
 <CALLqZ8RNyTP84gkchtSkaP=caMjLtPqu8K19bfPmueifuAjGuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Wed, 14 Apr 2021 14:41:29 -0400
Greg Gallagher <greg@embeddedgreg.com> wrote:

> Ipipe 5.4 and xenomai 3.1 are compatible, this is my mistake, I=E2=80=99l=
l fix up
> and generate a new patch once the latency fix is done.
> FWIW, building straight from the ipipe-arm repo on the ipipe/5.4.y branch
> has been working for me.

I'm afraid the HEAD of ipipe/5.4.y as of commit
ffaf274ca4cc117c2dc3f9b2ee8ea6218b50995a doesn't build for me. I'm on
this commit + I have prepared the kernel using Xenomai 3.1
./scripts/prepare-kernel.sh --linux=3D/path/to/kernel + kernel configured
with sama5_defconfig.

And same build failure:

In file included from kernel/cpu.c:23:0:
./include/linux/stop_machine.h: In function =E2=80=98stop_machine_cpuslocke=
d=E2=80=99:
./include/linux/stop_machine.h:150:2: error: implicit declaration of functi=
on =E2=80=98hard_irq_enable=E2=80=99; did you mean =E2=80=98hard_irq_disabl=
e=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  hard_irq_enable();
  ^~~~~~~~~~~~~~~
  hard_irq_disable

Best regards,

Thomas
--=20
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

