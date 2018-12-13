MIME-Version: 1.0
References: <8C8014A3-6A93-4E44-B753-49AC9FA313A3@korgrd.com>
 <58308e88-38d2-e4ea-232e-8f84dfe1fbd4@xenomai.org>
 <8AAA419E-875B-4CC7-9118-8DC45BE270A2@korgrd.com>
 <C780EA8A-B534-42F5-BE91-CC3A04010F10@korgrd.com>
In-Reply-To: <C780EA8A-B534-42F5-BE91-CC3A04010F10@korgrd.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 13 Dec 2018 15:14:43 -0500
Message-ID: <CALLqZ8Ty4F4dhY+6RCY6taA5vaH8GejY2wNXmm6wYtFS14wX9A@mail.gmail.com>
Subject: Re: ipipe-arm64 kernel issue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Steve,

On Thu, Dec 13, 2018 at 3:04 PM Steve Pavao via Xenomai
<xenomai@xenomai.org> wrote:
>
> > On Dec 13, 2018, at 7:50 AM, Steve Pavao <stevep@korgrd.com> wrote:
>
> > As I continue to bring up my app, I notice I=E2=80=99m having a segfaul=
t (SIGSEGV) trying to access the general purpose IO pins.
> >
> > I notice that /dev/gpiomem is missing from the environment.
>
> > I am using the dtb from the ipipe-arm64 build.
> >
> > Steve Pavao
> > Korg R&D
>
> I learned there is a kernel config option to load a driver for this.  The=
 config option is named CONFIG_BCM2835_DEVGPIOMEM.  It is set to Y in the c=
onfig.  In the raspberrypi-linux kernel, the driver is here https://github.=
com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom , but I don=E2=
=80=99t see the file in the ipipe-arm64 repo.

If it's not in the mainline repo then it won't be in the arm64 ipipe tree.
>
> Do the ipipe-arm repos tend to allow support for vendor-specific drivers =
for features like this, and if so, would the Xenomai team be willing to add=
 the gpiomem driver to the ipipe-arm64 kernel build?  I don=E2=80=99t know =
the policy for something like this, so thought I would ask to add support f=
or it, and see what is customary.
>
Do the pins need realtime response?  If you don't need realtime
response have you looked at using the /dev/gpiochipX character driver?
 If they need to be realtime we have a rtdm gpio driver that can be
used to control the pins.

> Steve Pavao
> Korg R&D
>
>
>

-Greg

