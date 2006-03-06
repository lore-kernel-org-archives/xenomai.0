Message-ID: <440C32E1.8020309@domain.hid>
Date: Mon, 06 Mar 2006 14:02:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Fundamental Questions
References: <5D63919D95F87E4D9D34FF7748CE2C2A2066F6@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A2066F6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE11AF2503381E83383F0C172"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE11AF2503381E83383F0C172
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Dear Gurus,
>=20
> I have 2 fundamental questions and I appologize in advance to burden yo=
u with more answering jobs stealing your precious development time, but a=
t least the first question is crutial to our project.
>=20
> 1.)
> Essentially the question deals with the problem, how long a Xenomai tas=
k in secondary mode can be delayed by normal Linux tasks.=20
> In detail : we plan to to have a lot of "near realtime" ethernet commun=
ication from within Xenomai using the normal Linux network stack (calling=
 the normal socket API). The question now is, how our network communicati=
on is influenced by other Linux tasks performing also network communicati=
on, let=B4s say an FTP transfer ?

Depending on the "normal" networking load, you will suffer from more or
less frequent (indeterministic) packet delays. Xenomai will not improve
this in any way. If your task in secondary mode tries to send some data
and requires to take a networking lock currently held by another Linux
task, it can take a real long time until this request is completed. This
gets better with PREEMPT_RT but still remains non-RT because the Linux
networking stack is not designed for hard real-time.

> (I have heard about RT-Net, but as far as I understand it needs its own=
 realtime domain and therefore a gateway to communicate with the outside =
world. We want to avoid this.)

If you communication can be soft-RT, you could indeed avoid the
separation - but you will then have to live with the side effects. All
you can do then is try to lower the number of deadline misses by keeping
the standard network traffic low and managing the bandwidth of the
participants (the Linux network stack has some support for QoS, at least
2.6 I think).

BTW, as long as your network is not separated or you have no control
over the traffic arriving at your system, picking the Linux stack in
favour of RTnet (which is compatible with non-RT networks) is indeed
generally recommended. This way you keep indeterministic load away from
the real-time subsystem.

>=20
> I have created a scheduling scenario and I would ask you to have a look=
 on it and to tell me whether it is correct or not. Thank you !
> An corresponding question about this scheduling is : are there differen=
ces between a 2.4 and 2.6 Linux kernel ? (for our PowerPC plattform we in=
tend to use the 2.4 kernel for performance reasons)
>=20
> Scheduling scenario :
> (I hope formating is not destroyed by email transfer)
>=20
> Time moves downwards
>=20
> v-Xenomai=20
>      v-Linux kernel
>           v-Linux processes
>=20
>           l1   Linux task1 running
>      s1 < l1   Linux task1 makes systemcall
>      s1        Linux task1 systemcall processed
> -------------  Linux scheduling  =20
>           l2   Linux task2 starts to run
>      s2 < l2   Linux task2 makes systemcall
>      s2        Linux task2 systemcall processed
> +++++++++++++  Xenomai scheduling
> x3             Xenomai task3 starts to run =3D> primary mode
> x3 > s3        Xenomai task3 makes systemcall =3D> secondary mode
>      s3        Xenomai task3 systemcall processed=20
> -------------  Linux scheduling =3D> Xenomai task preemted

This preemption will only happen if the target Linux task has a higher
priority or the Xenomai task on secondary mode has to block on some
resource to be become free. As I sketched above, this can actually
happen in the network stack.

>      s1        Linux task1 systemcall processed
>      s1 > l1   Linux task1 systemcall ready =3D> Linux task1 continues =

>           l1   Linux task1 continues
> -------------  Linux scheduling=20
>      s2        Linux task2 systemcall processed
>      s2 > l2   Linux task2 systemcall ready =3D> Linux task2 continues =

>           l2   Linux task2 continues
> -------------  Linux scheduling =3D> Xenomai Task3 systemcall continued=

>      s3        Xenomai Task3 systemcall continued
> x3 < s3        Xenomai Task3 systemcall ready =3D> Xenomai Task contiun=
es
> x3             but has been delayed by normal Linux tasks
>=20
>=20
> 2.)
> This question is not so crucial, but nevertheless interesting :
> Who are the people behind Xenomai (I did not find anything about this o=
n the Xenomai webpage), what is their background (University, Company)and=
 who impels /sponsors the Xenomai development (University, Company, Commu=
nity)?=20
> I think I "identified" at least 2 core developers : Philippe Gerum and =
Gilles Chanteperdrix, but I don=B4t know very much more.

I can add my/our own profile here: working at the university of Hannover
(Real-Time Systems Group) with and on Xenomai to use it on mobile
service robots and to do research on real-time security and industrial
automation. Our institute is currently developing a larger robotic
software framework on top of it. Primarily, we see Xenomai as a mature
platform for doing real-time with Linux, i.e. as a very useful tool.

> The background for this question is, to get a feeling, how future-proof=
 the xenomai development is. As far as I can see open source projects oft=
en die or stall when the initiators decide that "growing flowers" is a mu=
ch more pleasant job ;-).
>=20

We had to decide last year which way to go for our future platforms,
also with potential industrial/commercial usage in mind (e.g.
proprietary real-time algorithms as user-space applications). Based on
our experience with the RTAI (> 4 years), my own insight into
RTAI/fusion (Xenomai predecessor), and the status of PREEMPT_RT, we
selected fusion (now Xenomai) as the most matured and future-proven one.

Xenomai is enjoying an increasing acceptance in industry. Our industry
partners e.g. are either planning to start new with Xenomai or port over
from other RT-extensions - of course encouraged by our own good
experience. I talked to a lot of smaller and real large companies over
the last months, specifically here in Germany, that started new
automation/embedded projects on top of Linux/Xenomai (as usual, most of
their activities remain non-public - unfortunately). They are convinced
of the future of this project.

Moreover, I believe that Xenomai has a very healthy community. We have a
quite active crowd of contributors and "plain" users. There is
definitely more than one person knowing the internals of the system (as
in many projects, there is still one person knowing them best...). And
the code is also well documented (exceptions apart).

No one can safely predict what will happen to a project when one of the
main contributors stops working on it. But given the number of
"advanced" Xenomai users already at this comparably early project stage,
I'm convinced it would even survive such an exceptional scenario, i.e.
it has reached a critical mass. But I have no indications that Philippe
or Gilles will become gardeners. ;)

This said, the best thing one can do as a long-term user of an open
source project is to support its development actively by

 o promoting it (yes, it can already be that simple)
 o reporting problems
 o fixing minor bugs and posting the fixes
 o contributing new features and enhancements (drivers, board support,
   API extensions, ...)
 o or directly funding the development of such enhancements

>=20
> Thank you for taking time to answer these questions, which are interest=
ing to others too, I think !?
>=20

Hope I was able to provide you some helpful details and arguments.

Jan


--------------enigE11AF2503381E83383F0C172
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDDLhniDOoMHTA+kRAvTlAJ0Vz/zA60+e5QDdrvfdCPBBxZ0N4ACeIEvM
5n1xb3Ro+l8TOhwP8yvyQTQ=
=yXz9
-----END PGP SIGNATURE-----

--------------enigE11AF2503381E83383F0C172--

