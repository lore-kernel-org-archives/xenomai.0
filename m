From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Sat, 2 Jul 2011 22:47:14 -0300
References: <201106301212.47433.carlosnov@domain.hid>
	<201107011423.18553.carlosnov@domain.hid>
	<4E0F7C03.20304@domain.hid>
In-Reply-To: <4E0F7C03.20304@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201107022247.15543.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Writing a new driver, Skin differences.
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

Thank you very much, I got it now. I had found out those points on xenomai =
3.x=20
and rtdm, so I must be a little more carefull on reading before asking. Sor=
ry=20
for that.

I am starting working on it, at first I think that using rt_dev_read shoud =
do=20
the work, its easy to set up and there are examples over the net, but I can=
t=20
find any (online) example on using rtdm_mmap_to_user and also could not fig=
ure=20
out the parameters to get it working. Can you point me any other resource o=
r=20
example on using it?

The rtdm skin sens to be well documented but its very poor on examples and=
=20
detailed description, at least I cant find any resource as informative as t=
hose=20
related to the native api.


Thank you,

Carlos Novaes

Em s=C3=A1b 02 jul 2011, =C3=A0s 17:13:55, Gilles Chanteperdrix escreveu:
> On 07/01/2011 07:23 PM, Carlos Eduardo de Brito Novaes wrote:
> > Hello,
> >=20
> > I think I the question on using memory mapped are solved. Now I was
> > wondering and cant find a big difference over the four skins, at least
> > for a new project with no previous code written on the past. Is there
> > any advantage in using the rtdm skin over the navive one?
>=20
> The RTDM is meant for writing drivers in kernel-space and continuity
> will be ensured in Xenomai 3.x, whereas the other kernel-space skins
> will no longer be available in Xenomai 3.x. Writing drivers in
> kernel-space with either the native or the posix skin is deprecated.

