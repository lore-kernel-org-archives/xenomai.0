MIME-Version: 1.0
References: <CAFLxGvwW583A2NoHKEETzGju13PXqSMmQ2uxSbAsBa7sRFumvQ@mail.gmail.com>
 <CAFLxGvxpLybt_mQckAjtcRsY9jMrfT1x4KsQWrZwZR2SeYm9Kg@mail.gmail.com>
 <20180918164932.79d3c86d@md1pvb1c.ad001.siemens.net>
 <1920928.FOH158oBg9@blindfold>
 <d15007e4-994b-951e-a2a3-cc464e21da95@siemens.com>
In-Reply-To: <d15007e4-994b-951e-a2a3-cc464e21da95@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 19 Sep 2018 14:17:01 +0200
Message-ID: <CAFLxGvzSLumx_vEU78HKu6F8Pq+GcXAh96M-AxwyzdfH_QUn+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe for 4.14 x86?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "J. Kiszka" <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, henning.schild@siemens.com, xenomai@xenomai.org

On Wed, Sep 19, 2018 at 1:08 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 19.09.18 12:19, Richard Weinberger wrote:
> > Am Dienstag, 18. September 2018, 16:49:32 CEST schrieb Henning Schild:
> >>> Is this repo/branch the right one when I want to give ipipe x86 a try=
?
> >>> Maybe I can help fixing issues too!
> >>> https://gitlab.denx.de/Xenomai/ipipe-x86/tree/wip/4.14-split
> >>>
> >>
> >> This one contains a few more fixes.
> >>
> >> https://gitlab.denx.de/Xenomai/ipipe-x86/tree/henning/wip/4.14-split
> >>
> >> Both are mainly tested under KVM. The 16 core Xeon i am currently
> >> testing on runs into some timer init issues and gets stuck at boot.
> >>
> >> Feedback welcome!
> >
> > Hmm, that failed a way earlier than expected.
> >
> >    AS      arch/x86/entry/vdso/vdso32/system_call.o
> > arch/x86/kernel/process_32.c: In function =E2=80=98__switch_to=E2=80=99=
:
> > arch/x86/kernel/process_32.c:238:14: error: implicit declaration of fun=
ction =E2=80=98ipipe_get_domain_slope_hook=E2=80=99; did you mean =E2=80=98=
ipipe_test_and_stall_root=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
> >    int slope =3D ipipe_get_domain_slope_hook(prev_p, next_p);
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                ipipe_test_and_stall_root
> > arch/x86/kernel/process_32.c:242:36: error: =E2=80=98slot=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98slope=E2=80=99?
> >    switch_fpu_prepare(prev_fpu, cpu, slot);
> >                                      ^~~~
> >                                      slope
> > arch/x86/kernel/process_32.c:242:36: note: each undeclared identifier i=
s reported only once for each function it appears in
> > arch/x86/kernel/process_32.c:242:2: error: too many arguments to functi=
on =E2=80=98switch_fpu_prepare=E2=80=99
> >    switch_fpu_prepare(prev_fpu, cpu, slot);
> >    ^~~~~~~~~~~~~~~~~~
> > In file included from arch/x86/kernel/process_32.c:45:0:
> > ./arch/x86/include/asm/fpu/internal.h:529:1: note: declared here
> >   switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> >   ^~~~~~~~~~~~~~~~~~
> > arch/x86/kernel/process_32.c:303:2: error: too many arguments to functi=
on =E2=80=98switch_fpu_finish=E2=80=99
> >    switch_fpu_finish(next_fpu, cpu, slope);
> >    ^~~~~~~~~~~~~~~~~
> > In file included from arch/x86/kernel/process_32.c:45:0:
> > ./arch/x86/include/asm/fpu/internal.h:551:20: note: declared here
> >   static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> >                      ^~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > Looks like some ia32 bits are missing.
>
> Yeah, 32-bit is untested. We no longer have any Xenomai-targets with 32-b=
it x86
> kernels (there is less and less hardware requiring that), so it is not th=
e
> primary priority. If you have a case, contributions - including tests - f=
or that
> would be helpful to prolong the live of this variant.

Thanks for this valuable insight. Let me check whether we can directly
jump to a x86_64 kernel.
Being the only 32-bit x86 user scares me a little. ;-)

--=20
Thanks,
//richard

