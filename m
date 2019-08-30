Subject: Re: missing compat version of rt_task_set_periodic
References: <CAArsGaYNRuA-=MuevVffbU63YfE4WnOKLwhRt+i4AZo77=Td+Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <59d18e9b-8bee-60ac-eddc-b227024999e4@siemens.com>
Date: Fri, 30 Aug 2019 17:10:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAArsGaYNRuA-=MuevVffbU63YfE4WnOKLwhRt+i4AZo77=Td+Q@mail.gmail.com>
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
To: Tormod Volden <lists.tormod@gmail.com>, xenomai@xenomai.org

On 30.08.19 17:00, Tormod Volden via Xenomai wrote:
> Hi,
> 
> I am porting an old RTNet / RTAI (3.8.1) application to latest xenomai
> (currently using git master). For this I chose the alchemy skin, and
> to make it as close as possible to the old API, I am also trying to
> enable the --compat transition kit. However, rt_task_set_periodic()
> disappears as soon as I add --compat. I am not sure whether it is an
> include file / macro bug or if I am not using it correctly, so I hope
> you can give me a hint.
> 
> xenomai was built from git master, with --configure --with-core=cobalt
> and installed.
> 
> $ xeno-config --skin=alchemy --compat --cflags
> 
> -I/usr/xenomai/include/trank -D__XENO_COMPAT__
> -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
> -I/usr/xenomai/include/alchemy
> 
> Here is a small compile test program:
> 
> $ cat xeno_compat_test.c
> 
> #include <alchemy/task.h>

In compat mode, the prototype comes via native/task.h again.

Jan

> void test(void)
> {
>    rt_task_set_periodic(NULL, TM_NOW, 0);
> }
> 
> Using only --alchemy works fine:
> 
> $ gcc -c xeno_compat_test.c $(xeno-config --skin=alchemy --cflags)
> $
> 
> However, with --compat it fails:
> 
> $ gcc -c xeno_compat_test.c $(xeno-config --skin=alchemy --compat --cflags)
> xeno_compat_test.c: In function ‘test’:
> xeno_compat_test.c:6:3: warning: implicit declaration of function
> ‘rt_task_set_periodic’; did you mean ‘rt_task_set_priority’?
> [-Wimplicit-function-declaration]
>     rt_task_set_periodic(NULL, TM_NOW, 0);
>     ^~~~~~~~~~~~~~~~~~~~
>     rt_task_set_priority
> 
> Using --skin=native gives the same result as --compat. I found out
> that I can use __current_rt_task_set_periodic() to force the use of
> the "new" function, but I could't get something like
> __compat_rt_task_set_periodic() to work.
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

