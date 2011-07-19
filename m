Message-id: <OF5F5F8716.FADBDF2A-ONC12578D2.0050F2D0-C12578D2.00525819@domain.hid>
From: rolf.magnus@domain.hid
Date: Tue, 19 Jul 2011 16:59:24 +0200
Content-type: multipart/alternative;
	boundary="=_alternative 00525817C12578D2_="
MIME-version: 1.0
Subject: [Xenomai-help] Scheduling policy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--=_alternative 00525817C12578D2_=
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

the xenomai documentation says that you can specify scheduling policies:

"The Xenomai scheduler ensures that concurrent tasks are run according to=20
one of the supported scheduling policies. Currently, the Xenomai scheduler =

supports fixed priority-based FIFO and round-robin policies."

The documentation of the function rt=5Ftask=5Fset=5Fmode says:

"Each Xenomai task has a set of internal bits determining various=20
operating conditions; the rt=5Ftask=5Fset=5Fmode() service allows to alter =
three=20
of them, respectively controlling:

whether the task locks the rescheduling procedure,
whether the task undergoes a round-robin scheduling,
whether the task blocks the delivery of signals."

but there is no way to actually set the scheduling policy. In Xenomai 2.4, =

there was the flag T=5FRRB, but in 2.5, that has been removed from the=20
documentation, and also from the interface. So how do you set the policy=20
in 2.5?


Rolf Magnus


If you are not the intended addressee, please inform us immediately that yo=
u have received this e-mail in error, and delete it. We thank you for your =
cooperation.  =
=

--=_alternative 00525817C12578D2_=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi,</font><br><br><font size=3D2 fac=
e=3D"sans-serif">the xenomai documentation says that
you can specify scheduling policies:</font><br><br><font size=3D2 face=3D"s=
ans-serif">&quot;The Xenomai scheduler ensures
that concurrent tasks are run according to one of the supported scheduling
policies. Currently, the Xenomai scheduler supports fixed priority-based
FIFO and round-robin policies.&quot;</font><br><br><font size=3D2 face=3D"s=
ans-serif">The documentation of the function rt=5Ftask=5Fset=5Fmode
says:</font><br><br><font size=3D2 face=3D"sans-serif">&quot;Each Xenomai t=
ask has a set of
internal bits determining various operating conditions; the rt=5Ftask=5Fset=
=5Fmode()
service allows to alter three of them, respectively controlling:</font><br>=
<br><font size=3D2 face=3D"sans-serif">whether the task locks the reschedul=
ing
procedure,</font><br><font size=3D2 face=3D"sans-serif">whether the task un=
dergoes a round-robin
scheduling,</font><br><font size=3D2 face=3D"sans-serif">whether the task b=
locks the delivery
of signals.&quot;</font><br><br><font size=3D2 face=3D"sans-serif">but ther=
e is no way to actually set
the scheduling policy. In Xenomai 2.4, there was the flag T=5FRRB, but in
2.5, that has been removed from the documentation, and also from the interf=
ace.
So how do you set the policy in 2.5?</font><br><br><font size=3D2 face=3D"s=
ans-serif"><br>Rolf Magnus</font><br><font face=3D"sans-serif"><font face=
=3D"sans-serif, Arial, Helvetica" size=3D"-1" color=3D"#808080"><br>If you =
are not the intended addressee, please inform us immediately that you have =
received this e-mail in error, and delete it. We thank you for your coopera=
tion.
<br></br>=20
                                                                         =20
</font></font>
=
--=_alternative 00525817C12578D2_=--

