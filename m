From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Fri, 1 Jul 2011 14:23:18 -0300
References: <201106301212.47433.carlosnov@domain.hid>
	<4E0D7DE7.50803@domain.hid>
In-Reply-To: <4E0D7DE7.50803@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201107011423.18553.carlosnov@domain.hid>
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

Hello,

I think I the question on using memory mapped are solved. Now I was wonderi=
ng=20
and cant find a big difference over the four skins, at least for a new proj=
ect=20
with no previous code written on the past. Is there any advantage in using =
the=20
rtdm skin over the navive one?

Thanks so much.

Carlos Novaes


Em sex 01 jul 2011, =C3=A0s 04:57:27, Gilles Chanteperdrix escreveu:
> On 06/30/2011 05:12 PM, Carlos Eduardo de Brito Novaes wrote:
> > Hello all!
> > Hope this question fits to the scope of the list.
> >=20
> > I got a PCI acquisition board and wish to write a xenomai driver for it.
> > I had did this before with an old ISA board and used memory heaps to
> > exchange data from kernel (configuration and mainly acquisition
> > routines) and the real time processing task.
> >=20
> > Now, I would like to know if I can use only message pipes for this kind
> > of application. I would like to use it so the entire proccess became
> > more "unix like", using memory heaps I think that the internals of the
> > driver are exposed and the any misfuncion can arise due to bad data
> > passed from programmers. Is this right?
> >=20
> > Can message pipes provide hard real time timings, about 1K/10K samples
> > per second and about 100 bytes on each sample?
>=20
> Hi,
>=20
> you probably should use the RTDM skin to write a driver. So, use the
> "read" call to get data, or if there is a big volume, use some mmaped
> aread, using rtdm_mmap_to_user.
>=20
> Regards.

