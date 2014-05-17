References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org> <53679427.90603@xenomai.org>
 <1399360194.79292.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53689342.2050005@xenomai.org>
 <1399395015.38309.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Message-ID: <1400338602.75709.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 15:56:42 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1399395015.38309.YahooMailNeo@web171606.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Matthias Schneider <ma30002000@ya=
hoo.de>=0A> To: Philippe Gerum <rpm@xenomai.org>; "xenomai@xenomai.org" <xe=
nomai@xenomai.org>=0A> Cc: =0A> Sent: Tuesday, May 6, 2014 6:50 PM=0A> Subj=
ect: Re: [Xenomai] FreeRTOS skin=0A> =0A>>  From: Philippe Gerum <rpm@xenom=
ai.org>=0A>>  On 05/06/2014 09:09 AM, Matthias Schneider wrote:=0A>>>>  On =
05/05/2014 12:33 PM, Philippe Gerum wrote:=0A=0A>>>>  In addition to the ab=
ove, there are a few coding style items:=0A>>>>  - Please always take the f=
astest possible path when exiting on error,=0A>>>> =A0 =A0  so that we don'=
t have to cripple the normal processing following the=0A>>>> =A0 =A0  failu=
re point with error-specific checks. e.g. what is done with the=0A>>>> =A0 =
=A0  "task" variable in vTaskStartScheduler(), within the thread=0A>>>> =A0=
 =A0  cancellation loop, ends up being convoluted and confusing, compared=
=0A>>>> =A0 =A0  to unwinding and leaving the routine immediately after the=
 error is=0A>>>> =A0 =A0  detected.=0A>>> =A0=0A>>> =A0=0A=0A=0A> [...]=A0=
=0A> =0A> Ok let's simplify the code (and add the missing lock):=0A> =0A> w=
rite_lock_nocancel(&freertos_scheduler.lock);=0A> freertos_scheduler.state =
=3D taskSCHEDULER_NOT_STARTED;=0A> =0A> /* cancel all tasks in list */=0A> =
while (!pvlist_empty(&freertos_task_list)) {=0A> =A0 =A0 task =3D pvlist_fi=
rst_entry(&freertos_task_list, struct freertos_task, =0A> next);=0A> =A0 =
=A0 if (threadobj_lock(&task->thobj) !=3D -EINVAL) {=0A> =A0 =A0 =A0 =A0 =
=A0 =A0 if (threadobj_get_magic(&task->thobj) =3D=3D task_magic) {=0A> =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to leave freertos_scheduler.loc=
k since it is=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 taken in =
task_finalizer while we block in=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 threadobj_cancel */=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 write_unlock(&freertos_scheduler.lock);=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 threadobj_cancel(&task->thobj);=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 write_lock_nocancel(&freertos_scheduler.lock);=0A> =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;=0A> =A0 =A0 =A0 =A0 =A0 =A0 }=0A> =
=A0 =A0 =A0 =A0 =A0 =A0 threadobj_unlock(&task->thobj);=0A> =A0 =A0 }=0A> =
=A0 =A0 /* Need to release the lock for a while since a task in deletion=0A=
> =A0 =A0 =A0 =A0 may need it to unregister itself from freertos_task_list =
*/=0A> =A0 =A0 write_unlock(&freertos_scheduler.lock);=0A> =A0 =A0 struct t=
imespec rqt;=0A> =A0 =A0 clockobj_ticks_to_timeout(&freertos_clock,=0A> =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.001 * xGetTicksP=
erSecond(),=0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &rqt);=0A> =A0 =A0 threadobj_sleep(&rqt);=0A> =A0 =A0 write_lock_nocancel(=
&freertos_scheduler.lock);=0A> }=0A> write_unlock(&freertos_scheduler.lock)=
;=0A> =0A> I had used pvlist_for_each_entry_safe() originally, but due to t=
he possibility=A0=0A> having to=A0access a single task multiple times, I en=
ded up=A0with two nested loops.=0A=0A=0AI will include this implementation =
in my next patch. This patch also includes=0Achanges of comments to c-style=
 and removal of (void)-casting ignored return values.=0AAlso, I have adapte=
d the patch to the latest (warn_unused_result) attributes.=0A=0AMatthias=0A

