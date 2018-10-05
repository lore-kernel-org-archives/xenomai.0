From: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>
Date: Fri, 5 Oct 2018 08:59:42 +0000
Message-ID: <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>,
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
In-Reply-To: <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
Content-Language: de-DE
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Hello Jan,

unfortunately I got build errors with 4.14-split
I used xenomai-next and prepared kernel with scripts/prepare-kernel.sh --li=
nux=3D../ipipe-x86-wip-4.14-split --arch=3Dx86_64

make results in:

arch/x86/kernel/process.c: In function =91mwait_idle=92:
arch/x86/kernel/process.c:626:4: error: implicit declaration of function =
=91__ipipe_halt_root=92; did you mean =91ipipe_test_root=92? [-Werror=3Dimp=
licit-function-declaration]
    __ipipe_halt_root(1);
    ^~~~~~~~~~~~~~~~~
    ipipe_test_root
cc1: some warnings being treeated as errors
scripts/Makefile.build:328: recipe for target 'arch/x86/kernel/process.o' f=
ailed
make[2]: *** [arch/x86/kernel/process.o] Error 1
scripts/Makefile.build:587: recipe for target 'arch/x86/kernel' failed
make[1]: *** [arch/x86/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....

and

kernel/ipipe/core.c: In function =91__ipipe_spin_lock_irqsave=92:
kernel/ipipe/core.c:548:9: error: implicit declaration of function =91arch_=
mangle_irq_bits=92; did you mean =91arch_early_irq_init=92? [-Werror=3Dimpl=
icit-function-declaration]
  return arch_mangle_irq_bits(s, flags);
         ^~~~~~~~~~~~~~~~~~~~
         arch_early_irq_init
kernel/ipipe/core.c: In function =91__ipipe_spin_unlock_irqrestore=92:
kernel/ipipe/core.c:575:7: error: implicit declaration of function =91arch_=
demangle_irq_bits=92; did you mean =91arch_early_irq_init=92? [-Werror=3Dim=
plicit-function-declaration]
  if (!arch_demangle_irq_bits(&x))
       ^~~~~~~~~~~~~~~~~~~~~~
       arch_early_irq_init
  CC      fs/filesystems.o
kernel/ipipe/core.c: In function =91ipipe_critical_enter.part.6=92:
kernel/ipipe/core.c:1713:1: warning: the frame size of 2064 bytes is larger=
 than 1024 bytes [-Wframe-larger-than=3D]
 }
 ^
  CC      mm/page_vma_mapped.o
  CC      kernel/events/uprobes.o
cc1: some warnings being treated as errors
scripts/Makefile.build:328: recipe for target 'kernel/ipipe/core.o' failed
make[2]: *** [kernel/ipipe/core.o] Error 1
scripts/Makefile.build:587: recipe for target 'kernel/ipipe' failed
make[1]: *** [kernel/ipipe] Error 2
make[1]: *** Waiting for unfinished jobs....


Do you have any hints?

Thanks,
Martin


________________________________________
Von: Jan Kiszka [jan.kiszka@siemens.com]
Gesendet: Montag, 1. Oktober 2018 12:33
An: Schrenkhammer, Martin; xenomai@xenomai.org
Betreff: Re: ipipe-4.14: planned release date

On 01.10.18 12:10, Schrenkhammer, Martin wrote:
> Hi,
>
> Do you already have a planned release date for ipipe-4.14?
> I am looking forward using xenomai on latest AMD V1000 platform. But it l=
ooks like it is not supported by ipipe-4.9

You are welcome to test already, see
https://www.xenomai.org/pipermail/xenomai/2018-September/039617.html, and
provide feedback here!

There is currently one open issue, see
https://www.xenomai.org/pipermail/xenomai/2018-September/039614.html, but m=
aybe
that does not affect your workload. Also note that x86-32 is untested, prob=
ably
broken. I'm considering to deprecate it, given that all modern CPUs come wi=
th
64-bit support, and we have compat support in Xenomai for 32-bit userland.

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




