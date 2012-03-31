Message-ID: <4F775E1D.3020202@domain.hid>
Date: Sat, 31 Mar 2012 21:42:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <007601cd0da1$e79e2810$b6da7830$@imc-berlin.de>
In-Reply-To: <007601cd0da1$e79e2810$b6da7830$@imc-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai support for marvells mv78100 or mv78200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?QmrDtnJuIFNsb3Rrb3dza2k=?= <Bjoern.Slotkowski@domain.hid>
Cc: xenomai@xenomai.org

On 03/29/2012 01:48 PM, Bj=C3=B6rn Slotkowski wrote:
> Hello,
>=20
> =20
>=20
> we have a short question:
>=20
> =20
>=20
> Is there any xenomai support for marvells mv78100 or mv78200 ?
>=20
> I cannot find anything in the internet.=20
>=20
> A compilation of linux 2.6.31.8 with xenomai 2.5.4 fails with errormess=
age
> "Unsupported ARM machine".

You do not need to search the internet for the answer to this question,
simply xenomai FAQ. Actually this is xenomai FAQ number 1. You will be
redirected here:

http://xenomai.org/index.php/Embedded_Device_Support#ARM

where you will find that there is no support for this processor.

If you are going to port the I-pipe patch to this architecture, I
suggest you use an up-to-date version of xenomai, and not a random old
version such as 2.5.4.

Regards.

--=20
                                                                Gilles.


