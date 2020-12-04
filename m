MIME-Version: 1.0
References: <CADx0-8DU+evLr-SduY9ru9zKBuhqjYOHPZ=5U4wFnMZAhE5irA@mail.gmail.com>
 <7786a8bf14ab25145e468bba2b567da76e9fd048.camel@siemens.com>
 <CADx0-8C7CW4i+O7g4zAGE0uXtD+bnNr4oR8HF-_tNArpteSDmQ@mail.gmail.com>
 <3afd98886487b064501e173f4e8d811f3f1a61f1.camel@siemens.com>
 <abe234e7-b15d-d257-69bc-c9e1ccd6898a@siemens.com>
In-Reply-To: <abe234e7-b15d-d257-69bc-c9e1ccd6898a@siemens.com>
From: Mohamed Irfanulla Mohamed Abdulla <m.mohamedirfanulla@gmail.com>
Date: Fri, 4 Dec 2020 16:13:21 +0100
Message-ID: <CADx0-8C=wk6yWgUt63AxSQ1zeFH6syGHV4MNPcstVxDFT6onkQ@mail.gmail.com>
Subject: Re: [xenomai patch with kernel 5.4.77] Error building the kernel
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
Cc: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Thank you for your reply. I encountered another error.

Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "__ipipe_dispatch_irq" [drivers/pinctrl/intel/pinctrl-intel.ko]
undefined!
make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
make: *** [Makefile:1319: modules] Error 2

Is it good to exclude CONFIG_PINCTRL?

Thanks,

On Mon, Nov 30, 2020 at 2:27 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 30.11.20 13:41, florian.bezdeka--- via Xenomai wrote:
> > On Mon, 2020-11-30 at 12:16 +0100, Mohamed Irfanulla Mohamed Abdulla
> > wrote:
> >> Thank you for your reply.
> >> I find that I use the wrong branch. Could you please suggest a good
> >> branch that I can use?
> >>
> >
> > I'm quite new to the Xenomai project, so don't trust me ;-)
> >
> > The problem you are facing was "fixed" in commit
> > 608c23297c4d ("cobalt/x86: Account for FPU changes in kernel 5.2")
> > which is part of the "next" branch.
> >
> > It looks like kernels >= 5.2 are not supported in official releases /
> > branches yet.
>
> Correct. Next 3.1.x release will include that. Until then you need a
> version from git.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
