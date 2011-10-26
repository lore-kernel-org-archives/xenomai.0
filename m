MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <4EA7F601.9000101@domain.hid>
References: <patchbomb.1318861189@domain.hid>
	<c2a2a1a093ea9baee853.1318861193@domain.hid>
	<4EA7E037.2090305@domain.hid>
	<CAAXf6LWaVORRe5g6x2vgKRuZ7XG0N8V643XxBJFTgHQZfwt7-A@mail.gmail.com>
	<4EA7F601.9000101@domain.hid>
Date: Wed, 26 Oct 2011 14:32:47 +0200
Message-ID: <CAAXf6LXbVcpHoKOKipowYz19diJaZ0q_1wUq3BfDQi=Ne8fXZw@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Oct 26, 2011 at 1:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 10/26/2011 01:04 PM, Thomas De Schampheleire wrote:
>>
>> On Wed, Oct 26, 2011 at 12:25 PM, Philippe Gerum<rpm@xenomai.org> =A0wro=
te:
>>>
>>> On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
>>>>
>>>> Assign default 1 to satisfy compiler (tested with gcc 4.4.3)
>>>>
>>>> Signed-off-by: Thomas De
>>>> Schampheleire<thomas.de.schampheleire@domain.hid>
>>>> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>>>>
>>>> ---
>>>> =A0lib/psos/task.c | =A04 ++--
>>>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/lib/psos/task.c b/lib/psos/task.c
>>>> --- a/lib/psos/task.c
>>>> +++ b/lib/psos/task.c
>>>> @@ -247,7 +247,7 @@ u_long t_create(const char *name, u_long
>>>> =A0 =A0 =A0 =A0pthread_attr_t thattr;
>>>> =A0 =A0 =A0 =A0struct syncstate syns;
>>>> =A0 =A0 =A0 =A0struct service svc;
>>>> - =A0 =A0 =A0 int ret, cprio;
>>>> + =A0 =A0 =A0 int ret, cprio =3D 1;
>>>> =A0 =A0 =A0 =A0char short_name[5];
>>>>
>>>> =A0 =A0 =A0 =A0ret =3D check_task_priority(prio,&cprio);
>>>> @@ -414,7 +414,7 @@ u_long t_resume(u_long tid)
>>>> =A0u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0struct psos_task *task;
>>>> - =A0 =A0 =A0 int ret, cprio;
>>>> + =A0 =A0 =A0 int ret, cprio =3D 1;
>>>>
>>>> =A0 =A0 =A0 =A0task =3D get_psos_task_or_self(tid,&ret);
>>>> =A0 =A0 =A0 =A0if (task =3D=3D NULL)
>>>>
>>>
>>> Looks like 4.4.3 is wrong, 4.4.4+ does it better and does not choke. Ju=
st
>>> to
>>> make sure the optimizer is given a chance to see the truth, could you t=
ry
>>> without this patch, but with tagging check_task_priority() as inline
>>> instead, with --disable-debug, then with --enable-debug=3Dfull switches=
?
>>
>> Without this patch, inlined check_task_prio, --disable-debug:
>> /bin/sh ../../libtool =A0--tag=3DCC =A0 --mode=3Dcompile
>>
>> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-=
gcc
>> -DHAVE_CONFIG_H -I. -I../../lib/include =A0-O2 -D_GNU_SOURCE
>> -D_REENTRANT -Wall -pipe -Wstrict-prototypes -Wmissing-prototypes
>> -Wno-long-long -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
>> -Wstrict-prototypes -I../../include =A0 -pipe -Os =A0-D_LARGEFILE_SOURCE
>> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -MT libpsos_la-task.lo
>> -MD -MP -MF .deps/libpsos_la-task.Tpo -c -o libpsos_la-task.lo `test
>> -f 'task.c' || echo './'`task.c
>> libtool: compile:
>>
>> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-=
gcc
>> -DHAVE_CONFIG_H -I. -I../../lib/include -O2 -D_GNU_SOURCE -D_REENTRANT
>> -Wall -pipe -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
>> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
>> -Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
>> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -MT libpsos_la-task.lo
>> -MD -MP -MF .deps/libpsos_la-task.Tpo -c task.c =A0-fPIC -DPIC -o
>> .libs/libpsos_la-task.o
>> cc1: warnings being treated as errors
>> task.c: In function 't_setpri':
>> task.c:417: error: 'cprio' may be used uninitialized in this function
>> make[3]: *** [libpsos_la-task.lo] Error 1
>>
>> Without this patch, inlined check_task_prio, --enable-debug=3Dfull
>> /bin/sh ../../libtool =A0--tag=3DCC =A0 --mode=3Dcompile
>>
>> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-=
gcc
>> -DHAVE_CONFIG_H -I. -I../../lib/include =A0-g -D__XENO_DEBUG__
>> -D__XENO_DEBUG_FULL__ -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
>> -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
>> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
>> -Wstrict-prototypes -I../../include =A0 -pipe -Os =A0-D_LARGEFILE_SOURCE
>> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -MT libpsos_la-task.lo
>> -MD -MP -MF .deps/libpsos_la-task.Tpo -c -o libpsos_la-task.lo `test
>> -f 'task.c' || echo './'`task.c
>> libtool: compile:
>>
>> /repo/tdescham/reborn/buildroot-forge/output/host/usr/bin/powerpc-linux-=
gcc
>> -DHAVE_CONFIG_H -I. -I../../lib/include -g -D__XENO_DEBUG__
>> -D__XENO_DEBUG_FULL__ -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
>> -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
>> -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
>> -Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
>> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -MT libpsos_la-task.lo
>> -MD -MP -MF .deps/libpsos_la-task.Tpo -c task.c =A0-fPIC -DPIC -o
>> .libs/libpsos_la-task.o
>> cc1: warnings being treated as errors
>> task.c: In function 't_setpri':
>> task.c:417: error: 'cprio' may be used uninitialized in this function
>> make[3]: *** [libpsos_la-task.lo] Error 1
>>
>>
>> So, debug or not, compiler keeps complaining.
>> For your =A0reference, this is the change I did instead of the patch:
>> diff --git a/lib/psos/task.c b/lib/psos/task.c
>> --- a/lib/psos/task.c
>> +++ b/lib/psos/task.c
>> @@ -228,7 +228,7 @@ int psos_task_normalize_priority(unsigne
>> =A0 =A0 =A0 =A0 return psos_prio;
>> =A0}
>>
>> -static int check_task_priority(u_long psos_prio, int *core_prio)
>> +static inline int check_task_priority(u_long psos_prio, int *core_prio)
>> =A0{
>> =A0 =A0 =A0 =A0 if (psos_prio< =A01 || psos_prio> =A0255) /* In theory. =
*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PRIOR;
>>
>>
>> powerpc-linux-gcc (crosstool-NG 1.12.1 - buildroot 2011.08-hgc55c56f0435=
5)
>> 4.4.3
>> Copyright (C) 2010 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions. =A0There i=
s NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
>> PURPOSE.
>>
>> ~Thomas
>>
>
> Ok, so I'll merge this.
>
ok, thanks.

