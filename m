Message-ID: <497883B1.6030005@domain.hid>
Date: Thu, 22 Jan 2009 14:33:21 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01776D54@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01776D54@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
 Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
>>> Please correct me if I am wrong: In your replacement=20
>>> pthread_getschedparam would read scheduling parameters which
>>> should have been set with sched_setscheduler before(!) your
>> replacement gets
>>> active. Is this possible at all ? Wouldn=B4t I have to call=20
>>> sched_setscheduler (in "sysup") before I fork? And if calling
>>> after the fork it realy would be racy. So this isn=B4t a very
>>> feasible solution, isn=B4t it? Changing the scheduling paramters of
>>> a running Xenoami task probably isn=B4t possible (probably there is
>>> nothing to recognize the change ?)?
>> You are just repeating what I said. So, I have not much more to
>> say.
>>=20
>=20
> Yes, but with my own words, so you can tell me whether I understood
> you or not ;-).

Yes you understood.

>=20
>>> Linux and Linux is the lowest priority task in Xenomai. So, as
>>> soon as a task is in secondary mode every(!) Xenomai primary mode
>>> task would be scheduled in front of a secondary mode task, I
>>> thought. So, if your statement is right, I can=B4t see the
>>> difference between primary and secondary mode any more as a
>>> higher prioritized task obviously allways(!?) runs in front of a
>>> lower prioritized one independend whether it runs in primary or
>>> secondary mode? Is there some documenation I could read for
>>> better understanding ? Is this behaviour connected to the Xenomai
>>> "priority coupling" option?
>> Yes, it is what priority coupling means. But it really is the most
>> sane behaviour: you choose a priority and both Linux and Xenomai
>> schedulers cooperate to enfore this priority.
>=20
> How are Linux tasks treated which are not linked with any Xenomay
> library, but whose scheduling is set to SCHED_FIFO and whose priority
> is set to some value higher than a Xenomai tasks (with
> sched_setscheduler). When do they run ?

They can prevent a Xenomai task running in secondary mode from running,
but not a Xenomai task running in primary mode.

--=20
                                                 Gilles.


