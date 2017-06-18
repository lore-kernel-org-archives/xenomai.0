From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sun, 18 Jun 2017 15:09:26 +0000
Message-ID: <DB6PR0701MB2456796DCEDA2465D1A7EDF6B5C70@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] drivers/gpio/gpio-core.c is broken on 4.4.9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

the `dev` member of `struct gpio_chip` was replaced by `parent` as of=20

commit 58383c78425e4ee1c077253cf297b641c861c02e
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Nov 4 09:56:26 2015 +0100

    gpio: change member .dev to .parent
   =20
    The name .dev in a struct is normally reserved for a struct device
    that is let us say a superclass to the thing described by the struct.
    struct gpio_chip stands out by confusingly using a struct device *dev
    to point to the parent device (such as a platform_device) that
    represents the hardware. As we want to give gpio_chip:s real devices,
    this is not working. We need to rename this member to parent.


Therefore the following patch is needed to compile drivers/xenomai/gpio/gpi=
o-core.c. on 4.9.x

Notes:
a) Unfortunately I am not able to verify that it works because I am not on =
one of the devices supported by the gpio drivers
b) you need ifdefs around the change to make sure you do not break older bu=
ilds (e.g.: on 4.4.x the original version works fine).

diff --git a/drivers/xenomai/gpio/gpio-core.c b/drivers/xenomai/gpio/gpio-c=
ore.c
index b8cb044..17d201c 100644
--- a/drivers/xenomai/gpio/gpio-core.c
+++ b/drivers/xenomai/gpio/gpio-core.c
@@ -428,7 +428,7 @@ static int match_gpio_chip(struct gpio_chip *gc, void *=
data)
 {
        struct device *dev =3D data;
=20
-       return gc->dev =3D=3D dev;
+       return gc->parent =3D=3D dev;
 }

