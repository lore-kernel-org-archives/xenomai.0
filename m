Message-ID: <4EA7F601.9000101@domain.hid>
Date: Wed, 26 Oct 2011 13:58:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>	<c2a2a1a093ea9baee853.1318861193@domain.hid>	<4EA7E037.2090305@domain.hid>
	<CAAXf6LWaVORRe5g6x2vgKRuZ7XG0N8V643XxBJFTgHQZfwt7-A@mail.gmail.com>
In-Reply-To: <CAAXf6LWaVORRe5g6x2vgKRuZ7XG0N8V643XxBJFTgHQZfwt7-A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 4 of 4] psos: fix compiler warning: cprio
 could be used uninitialized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: xenomai@xenomai.org

On 10/26/2011 01:04 PM, Thomas De Schampheleire wrote:
> On Wed, Oct 26, 2011 at 12:25 PM, Philippe Gerum<rpm@xenomai.org>  wrote:
>> On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
>>>
>>> Assign default 1 to satisfy compiler (tested with gcc 4.4.3)
>>>
>>> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid>
>>> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>>>
>>> ---
>>>   lib/psos/task.c |  4 ++--
>>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/psos/task.c b/lib/psos/task.c
>>> --- a/lib/psos/task.c
>>> +++ b/lib/psos/task.c
>>> @@ -247,7 +247,7 @@ u_long t_create(const char *name, u_long
>>>         pthread_attr_t thattr;
>>>         struct syncstate syns;
>>>         struct service svc;
>>> -       int ret, cprio;
>>> +       int ret, cprio = 1;
>>>         char short_name[5];
>>>
>>>         ret = check_task_priority(prio,&cprio);
>>> @@ -414,7 +414,7 @@ u_long t_resume(u_long tid)
>>>   u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
>>>   {
>>>         struct psos_task *task;
>>> -       int ret, cprio;
>>> +       int ret, cprio = 1;
>>>
>>>         task = get_psos_task_or_self(tid,&ret);
>>>         if (task == NULL)
>>>
>>
>> Looks like 4.4.3 is wrong, 4.4.4+ does it better and does not choke. Just to
>> make sure the optimizer is given a chance to see the truth, could you try
>> without this patch, but with tagging check_task_priority() as inline
>> instead, with --disable-debug, then with --enable-debug=full switches?
>
> Without this patch, inlined check_task_prio, --disable-debug:
> /bin/sh ../../libtool  --tag=CC   --mode=compile
> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-gcc
> -DHAVE_CONFIG_H -I. -I../../lib/include  -O2 -D_GNU_SOURCE
> -D_REENTRANT -Wall -pipe -Wstrict-prototypes -Wmissing-prototypes
> -Wno-long-long -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../include   -pipe -Os  -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -MT libpsos_la-task.lo
> -MD -MP -MF .deps/libpsos_la-task.Tpo -c -o libpsos_la-task.lo `test
> -f 'task.c' || echo './'`task.c
> libtool: compile:
> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-gcc
> -DHAVE_CONFIG_H -I. -I../../lib/include -O2 -D_GNU_SOURCE -D_REENTRANT
> -Wall -pipe -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -MT libpsos_la-task.lo
> -MD -MP -MF .deps/libpsos_la-task.Tpo -c task.c  -fPIC -DPIC -o
> .libs/libpsos_la-task.o
> cc1: warnings being treated as errors
> task.c: In function 't_setpri':
> task.c:417: error: 'cprio' may be used uninitialized in this function
> make[3]: *** [libpsos_la-task.lo] Error 1
>
> Without this patch, inlined check_task_prio, --enable-debug=full
> /bin/sh ../../libtool  --tag=CC   --mode=compile
> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-gcc
> -DHAVE_CONFIG_H -I. -I../../lib/include  -g -D__XENO_DEBUG__
> -D__XENO_DEBUG_FULL__ -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../include   -pipe -Os  -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -MT libpsos_la-task.lo
> -MD -MP -MF .deps/libpsos_la-task.Tpo -c -o libpsos_la-task.lo `test
> -f 'task.c' || echo './'`task.c
> libtool: compile:
> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-gcc
> -DHAVE_CONFIG_H -I. -I../../lib/include -g -D__XENO_DEBUG__
> -D__XENO_DEBUG_FULL__ -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -MT libpsos_la-task.lo
> -MD -MP -MF .deps/libpsos_la-task.Tpo -c task.c  -fPIC -DPIC -o
> .libs/libpsos_la-task.o
> cc1: warnings being treated as errors
> task.c: In function 't_setpri':
> task.c:417: error: 'cprio' may be used uninitialized in this function
> make[3]: *** [libpsos_la-task.lo] Error 1
>
>
> So, debug or not, compiler keeps complaining.
> For your  reference, this is the change I did instead of the patch:
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -228,7 +228,7 @@ int psos_task_normalize_priority(unsigne
>          return psos_prio;
>   }
>
> -static int check_task_priority(u_long psos_prio, int *core_prio)
> +static inline int check_task_priority(u_long psos_prio, int *core_prio)
>   {
>          if (psos_prio<  1 || psos_prio>  255) /* In theory. */
>                  return ERR_PRIOR;
>
>
> powerpc-linux-gcc (crosstool-NG 1.12.1 - buildroot 2011.08-hgc55c56f04355) 4.4.3
> Copyright (C) 2010 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> ~Thomas
>

Ok, so I'll merge this.

-- 
Philippe.

