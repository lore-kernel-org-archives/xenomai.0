From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17209834.21270091585450.JavaMail.root@domain.hid>
References: <17209834.21270091585450.JavaMail.root@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Apr 2010 17:45:38 +0200
Message-ID: <1270136738.2418.322.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] uITRON skin problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: qiuhj@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2010-03-31 at 23:13 -0400, qiuhj@domain.hid wrote:
> Hi
>=20
> I want to porting uitron based application to linux, and I decided to use=
 xenomai uitron skin.
>=20
> I patched the kernel, make the xenomai package and installed user space l=
ibrary and header file=20
>=20
> The application can be built , but something was wrong when I ran the pro=
gram
>=20
> The error message is =E2=80=9CXenomai uITRON skin init: shd_tsk() failed,=
 status -33=E2=80=9D
>=20

So you already know that an invalid parameter was sent to the routine,
right?

> I found the error code =E2=80=9C-33=E2=80=9D mean parameter error ,but I =
can not understood, any help?
>=20

Any code from your end to help us understand what might fail on our end?

> Any doc for uitron api ?

uITRON is a public spec. If you meant "any doc for the Xenomai uITRON
skin implementation", then -ENOPARSE. "Documentation"? No idea what it
is, sorry.

PS: please refrain from posting to xenomai-core for such inquiries in
the hope of getting an answer faster, you won't get help this way, it
was in fact "that close" to be counter-productive. As stated here:
http://www.xenomai.org/index.php/Main_Page
xenomai-help is the perfect list for this question.

>=20
> Thank you!
>=20
> =20
>=20
>=20
> --
> This message was sent on behalf of qiuhj@domain.hid at openSubscriber.co=
m
> http://opensubscriber.com/message/xenomai@xenomai.org
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



