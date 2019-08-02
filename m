MIME-Version: 1.0
References: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
In-Reply-To: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 2 Aug 2019 09:29:34 +0200
Message-ID: <CAFc1U0vT=HkGEsbh_us_Py1PJyMRkMm-j+3ffToCJGjJmUz4Sw@mail.gmail.com>
Subject: Re: Building Xenomai 3 , Kernel 4 ... for BeagleBone Black
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
To: danwe <daniel.wenninger92@gmail.com>
Cc: xenomai@xenomai.org

Hi,

I did a test with Xenomai 3 + BR for BBB.

I can send you the 'external' tree you can use for BR configuration.

$ make BR2_EXTERNAL=3D<path>/external  bbb_xeno3_defconfig
$ make

regards



Le lun. 29 juil. 2019 =C3=A0 19:24, danwe via Xenomai <xenomai@xenomai.org>=
 a
=C3=A9crit :

> Hi,
>
> Is there any different of Building Xenomai 3 with the proper Kernel for a
> BBB to any other microcomputers/computers?
> On https://xenomai.org/documentation/xenomai-3/html/README.INSTALL/ are s=
o
> many different examples and I do not understand what I need to do to buil=
d
> this.
> Is there any example to build Xenomai 3 and Kernel with Buildroot?
> Does flashing on SD-Card depend on building Xenomai with Kernel?
> I just need to run Xenomai 3 with the proper Kernel on a BeagleBone Black
>
> Thanks.
>
> Daniel
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
