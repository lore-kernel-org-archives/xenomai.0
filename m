Message-ID: <5113D225.8030900@xenomai.org>
Date: Thu, 07 Feb 2013 17:11:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5113BFD0.7050501@hilscher.com>
In-Reply-To: <5113BFD0.7050501@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5lIExPUw==?= <slos@hilscher.com>
Cc: xenomai@xenomai.org

On 02/07/2013 03:53 PM, St=C3=A9phane LOS wrote:

> Hello Sirs,
>=20
> Hilscher is offering a Linux driver based on UIO for cifX boards.
>=20
> In my understanding, down to 1ms cycle time, a PREEMPT RT solution=20
> should be enough.
>=20
> The cifX boards can manage with bus cycle times down to 250=C2=B5s like=
 with=20
> EtherCAT or Sercos III firmwares.
>=20
> So it seems in that cases that using Xenomai would be the way to go.
> I suppose that it would be needed to modify or change the existing=20
> driver but I can't figure out how things (Xenomai / RTDM / UIO) fit=20
> together.
>=20
> UIO is the kernel module that allows the mapping of the board memory to=
=20
> user space.
>=20
> The cifX driver uses the libpciaccess to pick up the board and retrieve=
=20
> some board information from UIO before the mapping.
> Then it uses pthread and rt functions when accessing the board.
>=20
> Since UIO and libpciaccess are only used during the initialization, is =

> it a problem for a Xenomai application ?
>=20
> We have setup a Xenomai system and tried to compile the user land=20
> library with Xenomai options and flags and it seems we have been succes=
sful.
> The driver should be using the POSIX skin of Xenomai if we have been lu=
cky.
>=20
> I can't see why we would need RTDM. Any hint please ?
>=20
> I am an absolute beginner in the Xenomai arena, don't throw me to the=20
> lions...
>=20


If UIO is used to register an interrupt handler for instance, the
interrupt handler will not be called in real-time context when used with
Xenomai, so, you would have to use the (deprecated) native or posix skin
services to register a user-space interrupt handler, or more likely
write an RTDM driver. On the other hand, if what you need is simply
accessing the board registers through MMIO, then you do not need RTDM.

While accessing registers from user-space may be tempting, there is a
risk of ending up with an application where the driver code is not
clearly separated. Writing a driver separated from the application is
preferable, as it provides a sane isolation between the two. If you
change the hardware, you just have to rewrite a driver which follows the
same profile, if you want to write another application using the same
driver, you can keep the driver.

--=20
                                                                Gilles.


