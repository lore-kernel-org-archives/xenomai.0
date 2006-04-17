Message-ID: <4443DA12.9000503@domain.hid>
Date: Mon, 17 Apr 2006 20:10:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] MSW and CSW meanings
References: <200604171123.14192.lbocseg@domain.hid>
In-Reply-To: <200604171123.14192.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> Please, what do MSW and CSW mean on /proc/xenomai/stats?
>=20

MSW =3D Mode switches: primary->secondary/secondary->primary (actually,=20
I'm going to only leave the first one)

CSW =3D Context switches (operated by Xenomai for real-time threads,=20
kernel + user-space).

> Sorry if it is documented somewhere but I didn't find it on docs...
>=20
> Rodrigo.
>=20
> 	=09
> _______________________________________________________=20
> Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discad=
or agora!=20
> http://br.acesso.yahoo.com
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

