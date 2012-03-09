Message-ID: <4F59C92B.5080705@domain.hid>
Date: Fri, 09 Mar 2012 10:11:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
	<4F58788F.5070103@domain.hid>
	<000601ccfdba$c36b8650$4a4292f0$@q@domain.hid>
In-Reply-To: <000601ccfdba$c36b8650$4a4292f0$@q@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai stop working
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6ams5by6?= <ma.q@domain.hid>
Cc: xenomai@xenomai.org

On 03/09/2012 07:06 AM, =E9=A9=AC=E5=BC=BA wrote:
> Hi Gilles,
>=20
> I have changed mxc_min_delay as follow
> mxc_min_delay =3D ((__ipipe_cpu_freq + 500000) / 1000000) ?: 1;
> ->
> mxc_min_delay =3D ((__ipipe_cpu_freq + 250000) / 500000) ?: 1;
> means make min delay form 1us to 2us, and it seems to work well. I need=
 a longer test to check it out.
>=20
> Another issue about this change is whether 2us is long enough? In other=
 words, Is 2us a threshold value that due to hardware or an assumed value=
 that make the possibility smaller? if it is the later one, 2us and someo=
ne bigger seems not to be a perfect solution.

You can try mxc_min_delay =3D 0xff, since it is what linux does in the
latest release.

--=20
                                                                Gilles.


