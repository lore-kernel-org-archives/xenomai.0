References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
Date: Tue, 9 Oct 2018 18:24:59 +0200
MIME-Version: 1.0
In-Reply-To: <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe-4.14: planned release date
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.10.18 10:59, Schrenkhammer, Martin wrote:
> Hello Jan,
>=20
> unfortunately I got build errors with 4.14-split
> I used xenomai-next and prepared kernel with scripts/prepare-kernel.sh --=
linux=3D../ipipe-x86-wip-4.14-split --arch=3Dx86_64
>=20
> make results in:
>=20
> arch/x86/kernel/process.c: In function =91mwait_idle=92:
> arch/x86/kernel/process.c:626:4: error: implicit declaration of function =
=91__ipipe_halt_root=92; did you mean =91ipipe_test_root=92? [-Werror=3Dimp=
licit-function-declaration]
>      __ipipe_halt_root(1);
>      ^~~~~~~~~~~~~~~~~
>      ipipe_test_root
> cc1: some warnings being treeated as errors
> scripts/Makefile.build:328: recipe for target 'arch/x86/kernel/process.o'=
 failed
> make[2]: *** [arch/x86/kernel/process.o] Error 1
> scripts/Makefile.build:587: recipe for target 'arch/x86/kernel' failed
> make[1]: *** [arch/x86/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
>=20
> and
>=20
> kernel/ipipe/core.c: In function =91__ipipe_spin_lock_irqsave=92:
> kernel/ipipe/core.c:548:9: error: implicit declaration of function =91arc=
h_mangle_irq_bits=92; did you mean =91arch_early_irq_init=92? [-Werror=3Dim=
plicit-function-declaration]
>    return arch_mangle_irq_bits(s, flags);
>           ^~~~~~~~~~~~~~~~~~~~
>           arch_early_irq_init
> kernel/ipipe/core.c: In function =91__ipipe_spin_unlock_irqrestore=92:
> kernel/ipipe/core.c:575:7: error: implicit declaration of function =91arc=
h_demangle_irq_bits=92; did you mean =91arch_early_irq_init=92? [-Werror=3D=
implicit-function-declaration]
>    if (!arch_demangle_irq_bits(&x))
>         ^~~~~~~~~~~~~~~~~~~~~~
>         arch_early_irq_init
>    CC      fs/filesystems.o
> kernel/ipipe/core.c: In function =91ipipe_critical_enter.part.6=92:
> kernel/ipipe/core.c:1713:1: warning: the frame size of 2064 bytes is larg=
er than 1024 bytes [-Wframe-larger-than=3D]
>   }
>   ^
>    CC      mm/page_vma_mapped.o
>    CC      kernel/events/uprobes.o
> cc1: some warnings being treated as errors
> scripts/Makefile.build:328: recipe for target 'kernel/ipipe/core.o' failed
> make[2]: *** [kernel/ipipe/core.o] Error 1
> scripts/Makefile.build:587: recipe for target 'kernel/ipipe' failed
> make[1]: *** [kernel/ipipe] Error 2
> make[1]: *** Waiting for unfinished jobs....
>=20

Cannot reproduce both issues. Are you on c5540da91865? Then please share yo=
ur=20
.config.

Thanks,
Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

