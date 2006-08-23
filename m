Subject: Re: [Xenomai-help] how to port to xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1299EF3181B10F479D85C3280132852422DAF5@domain.hid>
References: <1299EF3181B10F479D85C3280132852422DAF5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 23 Aug 2006 09:52:48 +0200
Message-Id: <1156319568.4401.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-23 at 09:24 +0200, GUARDIOLA-FALCO Sebastien 204282
wrote:
> Hi,
>=20
> I'm trying to understand the better way to port my linux program to xen=
omai.
> It has only one linux syscall : mmap(). To emulate this call, can I use=
 native or posix skin? and how can I do (xxx_mmap()?)?
> Do I have to set task mode to primary after this call?
>=20
> The second issue of my code is to handle/modify task priority. In fact,=
 I want to set maximum priority for the task. How do you do this with Xen=
omai?
>=20

http://download.gna.org/xenomai/documentation/branches/v2.2.x/Native-API-=
Tour-rev-C.pdf

> Thanks a lot,
>=20
> S=E9bastien Guardiola Falco.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



