Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: ipipe-arm64 kernel issue
From: Steve Pavao <stevep@korgrd.com>
In-Reply-To: <8AAA419E-875B-4CC7-9118-8DC45BE270A2@korgrd.com>
Date: Thu, 13 Dec 2018 15:04:09 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <C780EA8A-B534-42F5-BE91-CC3A04010F10@korgrd.com>
References: <8C8014A3-6A93-4E44-B753-49AC9FA313A3@korgrd.com>
 <58308e88-38d2-e4ea-232e-8f84dfe1fbd4@xenomai.org>
 <8AAA419E-875B-4CC7-9118-8DC45BE270A2@korgrd.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> On Dec 13, 2018, at 7:50 AM, Steve Pavao <stevep@korgrd.com> wrote:

> As I continue to bring up my app, I notice I=E2=80=99m having a =
segfault (SIGSEGV) trying to access the general purpose IO pins.
>=20
> I notice that /dev/gpiomem is missing from the environment.

> I am using the dtb from the ipipe-arm64 build.
>=20
> Steve Pavao
> Korg R&D

I learned there is a kernel config option to load a driver for this.  =
The config option is named CONFIG_BCM2835_DEVGPIOMEM.  It is set to Y in =
the config.  In the raspberrypi-linux kernel, the driver is here =
https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom=
 , but I don=E2=80=99t see the file in the ipipe-arm64 repo.

Do the ipipe-arm repos tend to allow support for vendor-specific drivers =
for features like this, and if so, would the Xenomai team be willing to =
add the gpiomem driver to the ipipe-arm64 kernel build?  I don=E2=80=99t =
know the policy for something like this, so thought I would ask to add =
support for it, and see what is customary.

Steve Pavao
Korg R&D



