Date: Wed, 14 Oct 2015 16:55:37 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <145395888.622970.1444841737686.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <561E4D93.4090803@xenomai.org>
References: <561E4D93.4090803@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_heap_alloc size 0 - syscall 7 denied
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>On Wednesday, 14 October 2015, 14:41, Philippe Gerum <rpm@xenomai.org> wro=
te:
>
>On 10/14/2015 02:21 PM, Frederik Bayart wrote:
>>> On Wednesday, 14 October 2015, 12:43, Philippe Gerum <rpm@xenomai.org> =
wrote:
>>> On 10/14/2015 12:22 PM, Frederik Bayart wrote:
>>>> Hallo,
>>>> I'm using xenomai 3.0 on kernel 3.18.20 (64 bit).
>>>>
>>>> When using single block heap, I'm getting memory allocation problem wh=
en calling rt_heap_alloc with size 0. I don't get the error when calling th=
e function with size used in rt_heap_create.
>>>> On the mailing list, I found there has been an issue with this in May =
: http://www.xenomai.org/pipermail/xenomai/2015-May/034165.html
>>>> Is this still an issue ?
>>>
>>> No, this one is long gone.
>>>
>>>>
>>>> In attachment a test program htest.c + makefile to generate the proble=
m :
>>>>
>>>> $ sudo ./htest 1  =3D=3D> use 0
>>>> htest.c:69: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 0
>>>> htest.c:79 ERROR: rt_heap_alloc(-12): Cannot allocate memory
>>>>
>>>> $ sudo ./htest 1  =3D=3D> use same size as in create
>>>> htest.c:69: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 0
>>>> htest.c:92: heapsize =3D 70000, usablemem =3D 70144, usedmem =3D 70144
>>>>
>>>
>>> Does this help?
>>>
>>> diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
>>> index 20531e3..146bfa1 100644
>>> --- a/lib/alchemy/heap.c
>>> +++ b/lib/alchemy/heap.c
>>> @@ -442,7 +442,9 @@ int rt_heap_alloc_timed(RT_HEAP *heap,
>>>        p =3D __mptr(hcb->sba);
>>>        if (p)
>>>            goto done;
>>> -        if (size > 0 && size !=3D hcb->size) {
>>> +        if (size =3D=3D 0)
>>> +            size =3D heapobj_size(&hcb->hobj);
>>> +        else if (size !=3D hcb->size) {
>>>            ret =3D -EINVAL;
>>>            goto done;
>>>
>>>        }
>>>
>>
>> After code reading, could it be that the exception for size =3D=3D 0 has=
 disappeared in the released code ?
>>
>
>Did you try that patch?

Sorry, I didn't understand that the patch still has to be applied.
So the patch is working, thanks for the quick fix.

However the biggest problem is the denied syscall :

[Xenomai] syscall <7> denied to sysregd[22217]

I'm running the test program as root. Also sysregd is running as root.

root     22292     1  0 16:41 ?        00:00:00 sysregd --daemon --root /va=
r/run/xenomai/root/anon@22289 --anon

So this would be sc_cobalt_thread_setschedparam_ex. So I'm thinking this is=
 called maybe for the main thread shadowing, e.g. for the priority.

If I execute :=20
# ./htest =E2=80=93main-prio=3D15

then I see in /proc/xenomai/sched/threads :

CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
0  16149  rt     cobalt      0   -             X          htest
0  16152  rt     cobalt      0   -             X          sysregd
0  16154  rt     cobalt      0   -             X          sysregd
0  16156  rt     cobalt      0   -             X          htest


so no prio 15.

The config dump :

# ./htest --dump-config
based on Xenomai/cobalt v3.0 --=20
CONFIG_MMU=3D1
CONFIG_SMP=3D1
CONFIG_XENO_BUILD_ARGS=3D" '--prefix=3D/usr' '--includedir=3D/usr/include/x=
enomai' '--mandir=3D/usr/share/man' '--with-testdir=3D/usr/lib/xenomai/test=
suite' '--with-core=3Dcobalt' '--enable-smp' '--enable-pshared' '--enable-r=
egistry' '--build' 'x86_64-linux-gnu' 'build_alias=3Dx86_64-linux-gnu'"
CONFIG_XENO_BUILD_STRING=3D"x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=3D1
CONFIG_XENO_COMPILER=3D"gcc version 4.9.2 (Debian 4.9.2-10) "
CONFIG_XENO_DEFAULT_PERIOD=3D100000
CONFIG_XENO_FORTIFY=3D1
CONFIG_XENO_HOST_STRING=3D"x86_64-pc-linux-gnu"
CONFIG_XENO_LORES_CLOCK_DISABLED=3D1
CONFIG_XENO_PREFIX=3D"/usr"
CONFIG_XENO_PSHARED=3D1
CONFIG_XENO_RAW_CLOCK_ENABLED=3D1
CONFIG_XENO_REGISTRY=3D1
CONFIG_XENO_REGISTRY_ROOT=3D"/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=3D0
CONFIG_XENO_SANITY=3D1
CONFIG_XENO_TLSF=3D1
CONFIG_XENO_TLS_MODEL=3D"initial-exec"
CONFIG_XENO_UAPI_LEVEL=3D14
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_VERSION_NAME=3D"Exact Zero"
CONFIG_XENO_VERSION_STRING=3D"3.0"
CONFIG_XENO_X86_VSYSCALL=3D1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=3D65536

Frederik

