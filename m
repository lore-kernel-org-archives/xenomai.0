From: =?utf-8?B?6ams5by6?= <ma.q@domain.hid>
References: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
	<4F58788F.5070103@domain.hid>
In-Reply-To: <4F58788F.5070103@domain.hid>
Date: Fri, 9 Mar 2012 14:06:26 +0800
Message-ID: <000601ccfdba$c36b8650$4a4292f0$@q@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

I have changed mxc_min_delay as follow
mxc_min_delay =3D ((__ipipe_cpu_freq + 500000) / 1000000) ?: 1;
->
mxc_min_delay =3D ((__ipipe_cpu_freq + 250000) / 500000) ?: 1;
means make min delay form 1us to 2us, and it seems to work well. I need =
a longer test to check it out.

Another issue about this change is whether 2us is long enough? In other =
words, Is 2us a threshold value that due to hardware or an assumed value =
that make the possibility smaller? if it is the later one, 2us and =
someone bigger seems not to be a perfect solution.

Thanks for help

																	Ma Qiang

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 2012=E5=B9=B43=E6=9C=888=E6=97=A5 17:15
To: ??
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai stop working

On 03/08/2012 04:13 AM, ?? wrote:
> Hi
>=20
>   I have installed xenomai-2.5.6 on imx53 quick start board with Linux
> 2.6.35, it works well but stop working when I do some kernel real time =
task.
>=20
>   When it stop working, system is not totally down, it will be =
recovered
> after about 8~9 minutes, which comes

This usually means that the hardware timer is programmed for a too short
delay and wraps instead of ticking right away. You need to increase, in
__ipipe_mach_set_dec for the cpu you use, the minimum delay for which an
irq is triggered.

--=20
                                                                Gilles.



