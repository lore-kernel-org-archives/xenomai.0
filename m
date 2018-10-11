From: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>
Date: Thu, 11 Oct 2018 09:21:02 +0000
Message-ID: <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>,
 <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
In-Reply-To: <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your reply.
Checked again today with your latest commit 20db5ea2eee38b123c9641003fe55c8=
95a1fd514 with same errors.
I wanted to run a first build without modifications (beside prepare-kernel.=
sh and make menuconfig to append a local version.
Maybe you can send my your actual x86 config and I can check differences an=
d adopt to my platform.
Mine .config is enclosed.

Thanks,
Martin


________________________________________
Von: Jan Kiszka [jan.kiszka@siemens.com]
Gesendet: Dienstag, 9. Oktober 2018 18:24
An: Schrenkhammer, Martin; xenomai@xenomai.org
Betreff: Re: ipipe-4.14: planned release date

On 05.10.18 10:59, Schrenkhammer, Martin wrote:
> Hello Jan,
>
> unfortunately I got build errors with 4.14-split
> I used xenomai-next and prepared kernel with scripts/prepare-kernel.sh --=
linux=3D../ipipe-x86-wip-4.14-split --arch=3Dx86_64
>
> make results in:
>
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
>
> and
>
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
>

Cannot reproduce both issues. Are you on c5540da91865? Then please share yo=
ur
.config.

Thanks,
Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

Vertrauliche E-Mail von / Confidential e-mail from: DATA MODUL AG
Vorstand / CEO: Dr. Florian Pesahl
Vorsitzende des Aufsichtsrates / Chairwoman of the Supervisory Board: Krist=
in D. Russell
Sitz der Gesellschaft / Registered Office: M=FCnchen
Registergericht / Registration Court: M=FCnchen Handelsregister B 85 591



-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 215702 bytes
Desc: config
URL: <http://xenomai.org/pipermail/xenomai/attachments/20181011/0d84c0b4/at=
tachment.obj>
