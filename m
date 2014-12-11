From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Thu, 11 Dec 2014 10:29:58 +0000
Message-ID: <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>,
 <20141211102249.GB21808@hermes.click-hack.org>
In-Reply-To: <20141211102249.GB21808@hermes.click-hack.org>
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

>> >> RT drivers are also not installed on our system.=0A=
>> >=0A=
>> > Maybe I look wrong at nucleus/shadow.c, but I see only two reasons=0A=
>> > for for xnshadow_relax being called for a secondary mode syscall:=0A=
>> >=0A=
>> > - a call requiring primary mode was made and the switchback flag is=0A=
>> > set (which itself can have two reasons, either the fact that the=0A=
>> > syscall uses it, the only one being currently rt_timer_set_mode, or=0A=
>> > the fact that the caller runs with the SCHED_OTHER policy and does=0A=
>> > not hold a mutex)=0A=
>> >=0A=
>> > - a call with the adaptive flag was made, handled in primary mode,=0A=
>> > but returned -ENOSYS, which means the call needs to be retried in=0A=
>> > secondary mode.=0A=
>> >=0A=
>>=0A=
>> You are right. We have implemented some syscalls the require primary mod=
e (since they could block) but should switch back to secondary. These sysca=
lls are using attributes=0A=
>>=0A=
>>     __xn_exec_primary | __xn_exec_switchback=0A=
>=0A=
> Well then the tasks blocked with a stack trace like what you showed=0A=
> are blocked when coming back from such syscalls. Does this happen=0A=
> often, or are these syscall seldom used?=0A=
=0A=
In this application the switchback syscalls are used rather often. =0A=
=0A=
Regards,=0A=
Christoph=

