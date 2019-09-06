Message-ID: <db08b3df5aeb7dfbde41bee64b7ff142.squirrel@mail.ige-grenoble.fr>
In-Reply-To: <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
References: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
 <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
Date: Fri, 6 Sep 2019 15:16:17 +0200
Subject: Re: Kernel compilation error
From: davy.regneau@univ-grenoble-alpes.fr
Reply-To: davy.regneau@univ-grenoble-alpes.fr
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: frederic.cazenave@ird.fr

> On 05.09.19 18:07, Davy via Xenomai wrote:
>> Hi,
>>
>> we have 4.9.90 linux kernel patched with xenomai 3.0.9 and patched with
>> ipipe  V4.x.
>
> There is no "ipipe V4.x" - what exactly do you mean?
>
>>
>> When we try to compile a simple module we have lot of errors. the first
>> one is :
>> error: 'struct ipipe_threadinfo' has no member named 'ptd'
>>
>> As mentioned by Paolo in response to a similary issue, we tryed to set
>> CONFIG_IPIPE_LEGACY=3Dy in kernel config but now we are not able to
>> compile
>> the kernel. we have the following message :
>>
>> IPIPE_ROOT_NPTDKEYS not define in sched.h
>>
>> Could you give us some clues to fix our problem?
>
> Is the build error with the kernel or with an out-of-tree kernel module?
>
> Note that 4.9 no longer receives official I-pipe updates. Current LTS
> kernels
> are 4.4 and 4.19. But even then your are on a suboptimal version with .90
> because the last release was ipipe-core-4.9.146-x86-8 (assuming we are
> talking
> about x86, not some other arch).
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>



Hi,

So, I started over with the linux kernel 4.19.66 and xenomai 3.0.9

I patched the kernel with the following command :
  ./scripts/prepare-kernel.sh --linux=3D../linux-4.19.66
--ipipe=3D../ipipe-core-4.19.66-x86-6.patch --arch=3Dx86_64

First time I do make menuconfig, I get this error:

scripts/kconfig/mconf  Kconfig
init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
scripts/kconfig/Makefile:29=A0: la recette pour la cible =AB=A0menuconfig=
=A0=BB a
=E9chou=E9e

I solved this by replace "$SRCARCH" by "x86" in init/Kconfig

I then tried to compile the kernel :
  make bzImage modules

And I got an error which I solved by disable CONFIG_HYPERV and
CONFIG_SCHED_MC (as indicated in this thread :
https://www.xenomai.org/pipermail/xenomai/2018-October/039679.html)

Now I have this error :
In file included from include/xenomai/cobalt/uapi/kernel/vdso.h:21:0,
                 from include/xenomai/cobalt/kernel/vdso.h:26,
                 from kernel/xenomai/posix/clock.c:21:
include/xenomai/cobalt/uapi/kernel/urw.h: In function =91__try_read_start=
=92:
include/xenomai/cobalt/uapi/kernel/urw.h:60:2: error: implicit declaration
of function =91ACCESS_ONCE=92 [-Werror=3Dimplicit-function-declaration]
  token =3D ACCESS_ONCE(urw->sequence);
  ^
cc1: some warnings being treated as errors

Can you help me ?
I attach my .config


Davy


-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 193635 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20190906/496f86fa/at=
tachment.obj>
