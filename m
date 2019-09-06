Subject: Re: Kernel compilation error
References: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
 <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
 <db08b3df5aeb7dfbde41bee64b7ff142.squirrel@mail.ige-grenoble.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <978cbf79-06bd-3fb0-2396-b83270f8d92e@siemens.com>
Date: Fri, 6 Sep 2019 15:22:36 +0200
MIME-Version: 1.0
In-Reply-To: <db08b3df5aeb7dfbde41bee64b7ff142.squirrel@mail.ige-grenoble.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: davy.regneau@univ-grenoble-alpes.fr, xenomai@xenomai.org
Cc: frederic.cazenave@ird.fr

On 06.09.19 15:16, Davy via Xenomai wrote:
> Hi,
> 
> So, I started over with the linux kernel 4.19.66 and xenomai 3.0.9
> 
> I patched the kernel with the following command :
>    ./scripts/prepare-kernel.sh --linux=../linux-4.19.66
> --ipipe=../ipipe-core-4.19.66-x86-6.patch --arch=x86_64
> 
> First time I do make menuconfig, I get this error:
> 
> scripts/kconfig/mconf  Kconfig
> init/Kconfig:2056: can't open file "arch/$SRCARCH/xenomai/Kconfig"
> scripts/kconfig/Makefile:29 : la recette pour la cible « menuconfig » a
> échouée
> 
> I solved this by replace "$SRCARCH" by "x86" in init/Kconfig
> 
> I then tried to compile the kernel :
>    make bzImage modules
> 
> And I got an error which I solved by disable CONFIG_HYPERV and
> CONFIG_SCHED_MC (as indicated in this thread :
> https://www.xenomai.org/pipermail/xenomai/2018-October/039679.html)
> 
> Now I have this error :
> In file included from include/xenomai/cobalt/uapi/kernel/vdso.h:21:0,
>                   from include/xenomai/cobalt/kernel/vdso.h:26,
>                   from kernel/xenomai/posix/clock.c:21:
> include/xenomai/cobalt/uapi/kernel/urw.h: In function '__try_read_start':
> include/xenomai/cobalt/uapi/kernel/urw.h:60:2: error: implicit declaration
> of function 'ACCESS_ONCE' [-Werror=implicit-function-declaration]
>    token = ACCESS_ONCE(urw->sequence);
>    ^
> cc1: some warnings being treated as errors
> 
> Can you help me ?
> I attach my .config
> 

Yeah, one "detail": When you move to 4.19, you also need to switch to xenomai 
master branch.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

