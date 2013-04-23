References: <517536B8.4080508@gmail.com> <51766F9F.6070407@xenomai.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <51766F9F.6070407@xenomai.org>
Message-Id: <E3B5BC29-0015-4473-B5F5-304EEAEC8122@gmail.com>
From: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
Date: Tue, 23 Apr 2013 14:50:15 +0200
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] How to use rtdm_(io/m)map_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



On 23 avr. 2013, at 13:25, Gilles Chanteperdrix <gilles.chanteperdrix@xenoma=
i.org> wrote:
>=20
> This is wrong. The "abstraction layer" used by an application should be
> the usual driver interface open/read/write/ioctl and mmap if there are
> high volumes of data to exchange with the application. Access to the
> registers should be confined to the driver implementation.
>=20

The hardware is a FPGA which expose 1024 registers. Currently to read or wri=
te in a register, we use mmap. How use them with read/write file operations o=
f this registers? i.e. in userspace, once mmaped on an ptr, we do : ptr[addr=
] =3D value.=20
How achieve this with write operation, because write accepts only a value ?


> This way, in order to simulate the real hardware you only have to
> implement another driver with the same interface (but with an
> implementation not using registers). And when you decide to use another
> hardware with a completely different registers interface, you do not
> have to emulate the first device registers using the second one, you
> simply implement another driver with the same interface.
>=20
> This is the way, the interface between Linux drivers and applications is
> done, and the way it can be done with Xenomai RTDM skin.
>=20
>=20
> --=20
>                                                                Gilles.
