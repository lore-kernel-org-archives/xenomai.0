Message-ID: <4575A941.809@domain.hid>
Date: Tue, 05 Dec 2006 18:15:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-15?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-15?Q?__Switch_mode_with_x86?=
References: <s575af89.064@domain.hid>
In-Reply-To: <s575af89.064@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF337A033C523FB09CBB1AC27"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF337A033C523FB09CBB1AC27
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
> hello Jan,
>=20
>>>>> Jan Kiszka <jan.kiszka@domain.hid> 04.12 22:06 >>>
>> Jan Kiszka wrote:
>>> ...
>>> This indicates that we face an I-pipe bug: the scheduled Linux call
> on
>>> relaxation of TASK2 and then later TASK1 somehow gets lost (there is
> no
>>> rthal_apc_handler in the remaining trace).
>> I think I got it. No I-pipe bug, but one in the HAL.
>>
>> What happened? A weird race caused by the unprotected optimisation to
>> only call rthal_schedule_irq() if there is no APC pending yet. This
> is
>> the constellation I finally worked out via instrumenting and tracing:
>>
>> PRIO 1:
>> rthal_apc_schedule()
>>  test&set rthal_apc_pending
>>  (but no rthal_schedule_irq() yet)
>>
>>                       -PREEMPTION-
>>
>>                                        PRIO 99:
>>                                        ...
>>                                        rthal_apc_schedule()
>>                                          test rthal_apc_pending
>>                                          (already set =3D> no
>>                                          rthal_schedule_irq()!)
>>
>> So, no one reported the ACP to I-pipe, and no one ever will in
> Nicolas
>> scenario - soft lock-up!
>>
>> Nicolas, please give the attached patch a try. Your test is running
> fine
>> for me now.
>=20
> I've applied your patch and it seems to run correctly ...
> congratulation.
> I've read you discussion about this problem with Gilles, but I've don't=

> really=20
> understand how you have solved the problem (and what was exactly the
> problem).
> If you have time to explain, i'm interested ...

That's a fairly long story to explain. Trying to make it short: The
essence is that your low prio thread was about to signal some soft-IRQ
to Linux on its way from primary to secondary mode. Right after storing
internally that this IRQ was sent but before actually sending it, it got
preempted by the high prio thread. That one tried the same, i.e. migrate
to secondary mode, but didn't sent out that soft-IRQ as it was already
marked as pending. Still, Linux was entered (with priority 99 of the
high prio thread), but not with any of the jobs the Xenomai threads
wanted to be worked on...

How I debugged this? You don't want to know. ;)
(It's a combination of understanding the code details + instrumenting it
via appropriate tools like the Ipipe tracer to produce a backlog of what
happened.)

>=20
>>
>> At this chance: do we need rthal_apc_schedule() returning the
> previous
>> state at all? No current caller checks the return value. If it's OK
> to
>> clean this up, I will post a combined patch.
>>
>> Jan
>=20
> An other things with switch mode, sometime i lose my i/o privilege put
> with the
> system call ioperm (in the main function of my program).

Sigh.

> My application stop with a "killed" message in the console and=20
> in /proc/xenomai/fault i've an "general fault".
> To ignore this problem, i use the call system iopl (with full
> privilege) or=20
> recall ioperm before each inb or outb.
> But there is a problem, why i/o privilege are losted ?
> I've read an similar problem in an archive of Rtai/fusion help
> mailing-list ...
> If you have an idea.

I'm not up-to-date /wrt ioperm usability. I also only vaguely recall
some older issues. Unless someone now screams "This cannot work, use
iopl!", I would suggest to create yet another nice test-case like the
last one and post it in a new thread.

Jan


--------------enigF337A033C523FB09CBB1AC27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdalBniDOoMHTA+kRAn5IAJ49J3mi/mwEZ4q6oJ1A8MeYchkb0wCdEOmd
CQCPQuC9FRwyA5+IKXqEJTM=
=t4kM
-----END PGP SIGNATURE-----

--------------enigF337A033C523FB09CBB1AC27--

