Message-ID: <494A8F3E.9090906@domain.hid>
Date: Thu, 18 Dec 2008 17:58:22 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e0812180831n6ebf4ff1gcb990864ba112eab@domain.hid>	
	<494A7ED0.8090008@domain.hid>
	<8b216e9e0812180943v1ecc3fcasb45732cd9a58cde2@domain.hid>
In-Reply-To: <8b216e9e0812180943v1ecc3fcasb45732cd9a58cde2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Gumstix (ARM XScale PXA270)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Felipe Brand=E3o Cavalcanti wrote:
> Thanks - the -p option worked fine. I will try to improve the latencies=
 with
> a bit of kernel configuration tweaking, but 100us is still fine for my
> appliation (anything around 500us will do, actually).
>=20
> Now, is there a good guide on real time programming with xenomai? Now t=
hat I
> know its working, I can go on into the actual programming portion of th=
e
> project.

Please do not forget to CC the mailing list.

You now have the choice between two APIs:
- the native API, for which a guide exists:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf
- the posix API, which has no guide, but should be close enough to the
usual Linux programing, differences being documented here:
http://svn.gna.org/viewcvs/xenomai/trunk/doc/txt/pse51-skin.txt?rev=3D&vi=
ew=3Dauto

Both APIs are documented with Doxygen, and the generated documentation
is available both in the source tarball and on-line on Xenomai wiki:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__nati=
ve.html
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posi=
x.html

--=20
                                                 Gilles.


