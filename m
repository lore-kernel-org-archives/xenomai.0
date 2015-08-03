Date: Mon, 3 Aug 2015 09:59:45 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <218613807.898000.1438595985207.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <55BC86BE.8090505@xenomai.org>
References: <55BC86BE.8090505@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
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

Sorry for previous mail with no additional content, yahoo mail client is ve=
ry sensitive apparently.

> On Saturday, 1 August 2015, 10:43, Philippe Gerum <rpm@xenomai.org> wrote=
:
>On 07/31/2015 07:54 PM, Frederik Bayart wrote:
>>> On Thursday, 30 July 2015, 18:10, Philippe Gerum <rpm@xenomai.org> wrot=
e:
>>> On 07/30/2015 05:08 PM, Frederik Bayart wrote:
>>>>> On Thursday, 30 July 2015, 16:28, Frederik Bayart <frederik_bayart@ya=
hoo.co.uk> wrote:
>>>>>
>>>>> I found already that 'select' on=C2=A0 socket(PF_UNIX, SOCK_STREAM, 0=
)=C2=A0 causes Interrupted system call (errno 4).
>>>>> If I replace 'select' with '__real_select' the problem seems to be so=
lved, and the select timeout works.
>>>>> But the select doesn't seem to react on connect. I'm looking at the p=
roblem.
>>>>
>>>>
>>>> I just notice that the flood of Interrupted system calls is only cause=
 when build with trank. When build with alchemy, Interrupted system call ju=
st happens once.
>>>
>>> libtrank is just an overlay on top of libalchemy, only consisting of
>>> fairly simple wrappers. I would suspect a difference in the flags passe=
d
>>> to xeno-config instead.
>>
>> I succeeded to start my server using alchemy directly.
>>
>> Via trank the program generates a flood of error:
>>
>> $ sudo ./ptest
>>
>> ptest.c:68 ERROR: select(4): Interrupted system call
>> ptest.c:68 ERROR: select(4): Interrupted system call
>> ptest.c:68 ERROR: select(4): Interrupted system call
>> ...
>>
>> In attachment a test file ptest.c and makefile to reproduce the problem.
>>
>> My original server uses both native and posix calls, for that I used bot=
h native and posix flags.
>>
>> XENO_CFLAGS =3D $(shell $(XENOCONFIG) --posix=C2=A0 --compat --native --=
cflags )
>> XENO_LDFLAGS =3D $(shell $(XENOCONFIG) --posix --compat --native --ldfla=
gs )
>>
>> With alchemy directly there is no problem :
>>
>> XENO_CFLAGS =3D $(shell $(XENOCONFIG) --alchemy --cflags)
>> XENO_LDFLAGS =3D $(shell $(XENOCONFIG) --alchemy --ldflags)
>>
>>
>> I noticed also that for the documentation of the transition kit at the b=
ottom http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Using_the_Trans=
ition_Kit :
>>
>> If I link with xeno-config=C2=A0 --posix --ldflags --compat, I get :
>>
>> cc -Wl,@/usr/lib/cobalt.wrappers -ltrank=C2=A0 /usr/lib/xenomai/bootstra=
p.o -Wl,--wrap=3Dmain -Wl,--dynamic-list=3D/usr/lib/dynlist.ld -L/usr/lib -=
lcobalt -lpthread -lrt=C2=A0=C2=A0=C2=A0 -lfuse -pthread=C2=A0 -o ptest pte=
st.o
>> /usr/lib/libtrank.so: undefined reference to `threadobj_set_schedparam'
>> /usr/lib/libtrank.so: undefined reference to `__current_rt_alarm_create'
>> /usr/lib/libtrank.so: undefined reference to `rt_task_self'
>...
>> /usr/lib/libtrank.so: undefined reference to `__current_rt_alarm_delete'
>> /usr/lib/libtrank.so: undefined reference to `xnmalloc'
>> collect2: error: ld returned 1 exit status
>> makefile:27: recipe for target 'ptest' failed
>> make: *** [ptest] Error 1
>>
>> With the --native flag added, this is solved because=C2=A0 -lalchemy -lc=
opperplate is then added.
>
>The issue is not between --alchemy and --native, but with --posix being
>added or not. I could not reproduce this behavior (x86, ppc or arm)
>using your exact test code (I can see timeouts triggering each 5s), but
>looking at it, I'm pretty sure this is due to passing regular linux fds
>(from socket(AF_UNIX) to RTDM services.
>
>When --posix is given, select(), socket() and friends will be routed to
>RTDM _first_, which will check whether the corresponding channels are
>connected to a real-time driver. If the fds are not managed by RTDM, the
>call will be redirected to the glibc eventually. I don't explain why
>your code receives EINTR from RTDM's select() yet, but this is most
>likely not related to libtrank. This behavior is unexpected though, so
>we have to find why Xenomai's select() behaves like this.

If I can help, let me know, then I try to make some time to look at it.
If you can't reproduce the problem, I could always run some test program on=
 my PC.
What is the best way to debug it ?
Just to exclude : could it be an installation issue ?

Have you xenomai installed in /usr/xenomai/... ?
I'm using debian installation so that could be a difference. Any hardcoded =
library paths ?

Frederik

>
>In the meantime, if you want to mix Xenomai/POSIX calls with regular
>glibc ones when --posix is in effect, you can alternatively:
>
>- tag all regular POSIX calls for which a Xenomai counterpart exist with
>__STD(call(args))
>- invoke __real_call(args)
>
>Alternatively, you can drop --posix which will disable the POSIX
>wrapping for your code, then invoke __RT(call(args)) explicitly for
>Xenomai real-time services.
>
>Philippe.

  
