Message-ID: <47188474.5060703@domain.hid>
Date: Fri, 19 Oct 2007 12:18:28 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <op.t0fvtdsnt06gyn@domain.hid>
In-Reply-To: <op.t0fvtdsnt06gyn@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] array declaration of double values causes seg
 faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Axel Beierlein a =C3=A9crit :
> Hello,
>=20
> i try to use a simple function inside of an RT-Task in Userspace. Insid=
e =20
> of this function i only declare three array=C2=B4s of doubles with 5000=
 values =20
> in it.
> When i run the program a seg fault was shown. When i replace the array =
=20
> declaration with an printf the seg fault is away.
>=20
> Do i have memory limitations inside of an RT-Task?
>=20
> I use Xeno 2.3.1 with an 2.4.25 Kernel
>=20
> Axel
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


Hello,

I don't know what is your arch but I think it's a stack overflow problem.

Try to declare your array as static or increase the stack size value (may=
 be 4Ko on i386?)

David

