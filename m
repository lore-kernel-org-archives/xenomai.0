From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Fri, 13 Jul 2012 11:41:03 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658302FEBCEB@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<4FFFEB98.7060106@xenomai.org>
In-Reply-To: <4FFFEB98.7060106@xenomai.org>
Content-Language: es-ES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sure, I agree with the implementation issue. Makes a lot of sense (I think =
Gilles also posted on this)



But now thinking about your response ('getting away from violation' caught =
my eye J), it seems to me that RTDM (or its implementation, or my interpret=
ation!) might be somehow inconsistent.



To the application developer, RTDM provides a unified interface for request=
s to the driver: the client ignores upfront whether the call will be handle=
d in real-time or non-real-time context. Looking at the RTDM skin as the fr=
ont door to the real-time software framework, RTDM is telling the client no=
t to worry, "we will handle your request in the right context for you: just=
 send them our way". Which is actually quite nice and provides a lot of dat=
a and flexibility to the driver designer.

Similarly, we can look at interrupts as the backdoor to that same framework=
; to the driver developer  RTDM provides only _one_ interface (rtdm_request=
_irq) to that backdoor. Just like it does to the front door.



So, from the __system__  perspective, I don't see any reasons why that back=
door  - the interrupt handler- couldn't do the same and handle/delegate the=
 notification of the non-realtime paths that were allowed in via the front =
door. And I am only talking from an architecture point of view of the frame=
work



Anyhow, thanks for the details and the patch.





-----Mensaje original-----
De: Philippe Gerum [mailto:rpm@xenomai.org]
Enviado el: 13 July 2012 10:34
Para: Jorge Ramirez Ortiz, HCL Europe
CC: Gilles Chanteperdrix; xenomai@xenomai.org
Asunto: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - switch=
ing to ROOT



On 07/12/2012 11:29 PM, Jorge Ramirez Ortiz, HCL Europe wrote:

> Hi Gilles

>

> Information and context below.

>

> kernel: 2.6.35.9

> xenomai:2.6.0

> ipipe:2.8-04

> cpu atom z530 1.6HH

>

> Error

>>>> [  242.962195] BUG: Unhandled exception over domain Xenomai at 0x89216=
0 - switching to ROOT

>>>> [  242.990052] Pid: 972, comm: InterruptTest Not tainted 2.6.35.9-prot=
-xeno-atom #4

>>>> [  243.015979] Call Trace:

>>>> [  243.025121]  [<c041b0b3>] __ipipe_handle_exception+0x203/0x210

>>>> [  243.048691]  [<c07ef4fb>] error_code+0x63/0x70

>

> System:

> 1. Xenomai thread calling ~9000 PCI writes in a loop. Each of these 9000 =
IOCTLs is processed in the realtime path of the RTDM driver.

> 2. A library has an interrupt notifier on the same RTDM device.

>     The interrupt notifier is a wait queue in the non-realtime path of th=
e RTDM driver. Events are raised from the RTDM interrupt handler to notify =
the sleeping threads.

>     The interrupt notifier is a timed wait every 100ms. When it times out=
, the linux application reads (msgrcv) from a queue in a shared memory segm=
ent (shmget created).

>

> The problem with the design is obvious and the issue above solved by modi=
fying the library.

> The interrupt notifier should be sleeping in an rtdm_event_t in the realt=
ime path of the device instead of a linux wait queue.

>

> However, the other design, even if wrong, shouldnt have caused exceptions=
.



Your assumption is wrong: you cannot parry a real-time context

reentering the regular linux kernel from an unsafe place through a plain

function call, absolutely none. We can only detect this situation after

the facts to give some debug hints, hopefully before the complete crash,

by instrumenting code paths which may be spuriously called that way, e.g:



diff --git a/kernel/sched.c b/kernel/sched.c

index 2d1e23a..2e0ba74 100644

--- a/kernel/sched.c

+++ b/kernel/sched.c

@@ -3819,6 +3819,8 @@ static void __wake_up_common(wait_queue_head_t *q,

unsigned int mode,

  {

                wait_queue_t *curr, *next;



+             ipipe_check_context(ipipe_root_domain);

+

                list_for_each_entry_safe(curr, next, &q->task_list, task_li=
st) {

                                unsigned flags =3D curr->flags;



At any rate, you should not expect the system to help you getting away

with violations of basic dual kernel programming rules from kernel

space, this won't happen.



>

> Anyhow, I am as impressed as always with this piece of software. This is =
the toolkit that any embedded developer needs. And RTDM has been a great ad=
dition.

>

> thanks

> Jorge

>

> ________________________________________

> From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]

> Sent: 12 July 2012 09:31

> To: Jorge Ramirez Ortiz,  HCL Europe

> Cc: xenomai@xenomai.org

> Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - swi=
tching to ROOT

>

> On 07/12/2012 10:16 AM, Jorge Ramirez Ortiz, HCL Europe wrote:

>> Thanks Gilles. Yes unfortunately I cant recompile this kernel so I

>> was wondering about the system context of this fault within Xenomai.

>> BTW how come the stack frame is not printed by default.

>

> Because it may not be safe to use show_stack() from RT context (for

> instance, the print_symbol function to print symbol names need to take a

> spinlock when a symbol is defined by a kernel module, and this spinlock

> is not rt-safe). Anyway, the error message normally prints the PC of the

> error.

>

> Could you give us the exact error messsage? The version of Xenomai, the

> Linux kernel, the version of the I-pipe patch you use?

>

> --

>                                              Gilles.

>

>

> ::DISCLAIMER::

> -------------------------------------------------------------------------=
---------------------------------------------------------------------------

>

> The contents of this e-mail and any attachment(s) are confidential and in=
tended for the named recipient(s) only.

> E-mail transmission is not guaranteed to be secure or error-free as infor=
mation could be intercepted, corrupted,

> lost, destroyed, arrive late or incomplete, or may contain viruses in tra=
nsmission. The e mail and its contents

> (with or without referred errors) shall therefore not attach any liabilit=
y on the originator or HCL or its affiliates.

> Views or opinions, if any, presented in this email are solely those of th=
e author and may not necessarily reflect the

> views or opinions of HCL or its affiliates. Any form of reproduction, dis=
semination, copying, disclosure, modification,

> distribution and / or publication of this message without the prior writt=
en consent of authorized representative of

> HCL is strictly prohibited. If you have received this email in error plea=
se delete it and notify the sender immediately.

> Before opening any email and/or attachments, please check them for viruse=
s and other defects.

>

> -------------------------------------------------------------------------=
---------------------------------------------------------------------------

>

>

> _______________________________________________

> Xenomai mailing list

> Xenomai@xenomai.org

> http://www.xenomai.org/mailman/listinfo/xenomai

>





--

Philippe.




