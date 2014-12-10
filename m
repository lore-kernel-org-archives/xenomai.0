From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Wed, 10 Dec 2014 18:23:03 +0000
Message-ID: <146c26d17efd4456a8ad86ef13313aa6@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>
 <20141209205914.GQ30777@hermes.click-hack.org>
 <2a74ff40de88431da68f4922b415da89@EX132MBOX1A.de2.local>,
 <20141210162625.GL1524@hermes.click-hack.org>
In-Reply-To: <20141210162625.GL1524@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> >=0A=
>> > Anyway, is not it simply a deadlock in your application ?=0A=
>>=0A=
>> I don't think so. Here is a list of all tasks:=0A=
>>=0A=
>> ~ # cat /proc/xenomai/stat=0A=
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME=0A=
>>   0  0      0          7452       0     00500080   98.9  ROOT=0A=
>>   0  83     196        196        0     00300380    0.0  DOS4=0A=
>>   0  81     13         13         0     00300380    0.0  DOS5=0A=
>>   0  97     618        830        0     00300380    0.0  @WDG=0A=
>>   0  101    751        1127       0     00300380    0.0  HSSR=0A=
>>   0  128    1268       2186       0     00300380    0.0  DOS8=0A=
>>   0  129    1          1          0     00300380    0.0  @CGI=0A=
>>   0  130    7          10         0     00300182    0.0  LOG=0A=
>>   0  131    1          2          0     00300184    0.0  IOXP=0A=
>>   0  142    20         42         0     00300380    0.0  KTMR=0A=
>>   0  151    1652       1901       0     00300380    0.0  Sdrv=0A=
>>   0  152    383        489        0     00300380    0.0  LApp=0A=
>>   0  156    0          1          0     00300380    0.0  DOS9=0A=
>>   0  0      0          14937556   0     00000000    1.0  IRQ16: [timer]=
=0A=
>>=0A=
>> Most of them are in state 00300380, that means:=0A=
>>   XNSTARTED=0A=
>>   XNMAPPED=0A=
>>   XNRELAXED=0A=
>>   XNFPU=0A=
>>   XNSHADOW=0A=
>>=0A=
>> For a deadlock I would expect all threads must be wait for a semaphore o=
r something else (state flag XNPEND). However all tasks are freezed.=0A=
>=0A=
> Well no, XNRELAXED state means that it is suspended from xenomai=0A=
> scheduler point of view, and handled by Linux scheduler. So, if=0A=
> there is a deadlock, it happens in secondary mode.=0A=
=0A=
The callstack in /proc/[PID]/tasks/[TID]/stack of all threads shows that th=
ey are at same address in __xnpod_schedule:=0A=
=0A=
Call stack for task with TID 128:=0A=
=0A=
~ # cat /proc/128/tasks/128/stack=0A=
[<c00a8a78>] __xnpod_schedule+0x294/0x764=0A=
[<c00a92a4>] xnpod_suspend_thread+0x2c0/0x354=0A=
[<c00b6b48>] xnshadow_relax+0x94/0x168=0A=
[<c00b7384>] losyscall_event+0x240/0x26c=0A=
[<c007c6fc>] ipipe_syscall_hook+0x44/0x54=0A=
[<c0078474>] __ipipe_notify_syscall+0x70/0x1d0=0A=
[<c0016820>] __ipipe_syscall_root+0x6c/0x194=0A=
[<c000f734>] vector_swi+0x74/0x8c=0A=
[<ffffffff>] 0xffffffff=0A=
=0A=
With addr2line I have identified the if-statement as below on address c00a8=
a78 (found in kernel/xenomai/nucleus/pod.c:2256):=0A=
=0A=
  if (shadow && xnarch_root_domain_p())=0A=
=0A=
Before this line there is the call xnpod_switch_to(sched, prev, next). So I=
 assume the thread has not resumed from context switch.=0A=
=0A=
Do you have any more idea?=0A=
=0A=
Regards,=0A=
Christoph=0A=

