Message-ID: <bf32fd5ce254f7ccd4647a159cc0ce6a.squirrel@mail.ige-grenoble.fr>
In-Reply-To: <978cbf79-06bd-3fb0-2396-b83270f8d92e@siemens.com>
References: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
 <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
 <db08b3df5aeb7dfbde41bee64b7ff142.squirrel@mail.ige-grenoble.fr>
 <978cbf79-06bd-3fb0-2396-b83270f8d92e@siemens.com>
Date: Fri, 6 Sep 2019 15:38:05 +0200
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: davy.regneau@univ-grenoble-alpes.fr, xenomai@xenomai.org, frederic.cazenave@ird.fr

> On 06.09.19 15:16, Davy via Xenomai wrote:
>> Hi,
>>
>> So, I started over with the linux kernel 4.19.66 and xenomai 3.0.9
>>
>> I patched the kernel with the following command :
>>    ./scripts/prepare-kernel.sh --linux=3D../linux-4.19.66
>> --ipipe=3D../ipipe-core-4.19.66-x86-6.patch --arch=3Dx86_64
>>
>> First time I do make menuconfig, I get this error:
>>
>> scripts/kconfig/mconf  Kconfig
>> init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
>> scripts/kconfig/Makefile:29=C2=A0: la recette pour la cible
>> =C2=AB=C2=A0menuconfig=C2=A0=C2=BB a
>> =C3=A9chou=C3=A9e
>>
>> I solved this by replace "$SRCARCH" by "x86" in init/Kconfig
>>
>> I then tried to compile the kernel :
>>    make bzImage modules
>>
>> And I got an error which I solved by disable CONFIG_HYPERV and
>> CONFIG_SCHED_MC (as indicated in this thread :
>> https://www.xenomai.org/pipermail/xenomai/2018-October/039679.html)
>>
>> Now I have this error :
>> In file included from include/xenomai/cobalt/uapi/kernel/vdso.h:21:0,
>>                   from include/xenomai/cobalt/kernel/vdso.h:26,
>>                   from kernel/xenomai/posix/clock.c:21:
>> include/xenomai/cobalt/uapi/kernel/urw.h: In function
>> '__try_read_start':
>> include/xenomai/cobalt/uapi/kernel/urw.h:60:2: error: implicit
>> declaration
>> of function 'ACCESS_ONCE' [-Werror=3Dimplicit-function-declaration]
>>    token =3D ACCESS_ONCE(urw->sequence);
>>    ^
>> cc1: some warnings being treated as errors
>>
>> Can you help me ?
>> I attach my .config
>>
>
> Yeah, one "detail": When you move to 4.19, you also need to switch to
> xenomai
> master branch.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>


Hi Jan,

Thank you for your quick reply. If I want to use the last stable release
xenomai which kernel release I need to use ?



Regards,
Davy


