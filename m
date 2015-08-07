Date: Fri, 7 Aug 2015 11:19:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150807091958.GA2134@hermes>
References: <BAY168-W32777B7F471AE273F0A1FFDC730@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BAY168-W32777B7F471AE273F0A1FFDC730@phx.gbl>
Subject: Re: [Xenomai] when set  CONFIG_IPIPE=y, get error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: leejason <woshidahuaidan2011@hotmail.com>
Cc: "xenomia mail l Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Aug 07, 2015 at 09:04:27AM +0000, leejason wrote:
> linux-3.4.6  SOC: ti am335x  =20
>=20
> ahead of patch xenomai patch ,my kernel can run correctly.    after patch=
 pipe-core-3.4.6-arm-4.patch ,and set CONFIG_IPIPE=3Dy.   then Kernel hangs=
 after =93Starting kernel ..."   =20
> this is my log: =20
> /**************start***************************************/NAND read: de=
vice 0 offset 0x280000, size 0x500000     5242880 bytes read: OK    ## Boot=
ing kernel from Legacy Image at 80007fc0 ...       Image Name:   Linux-3.4.=
6         Image Type:   ARM Linux Kernel Image (uncompressed)        Data S=
ize:    3205680 Bytes =3D 3.1 MiB        Load Address: 80008000      Entry =
Point:  80008000      Verifying Checksum ... OK      XIP Kernel Image ... O=
K   OK     Starting kernel ...             /******************end**********=
*************************/             =20
> open linux-tree/kernel/ipipe/Makefile  then i got                        =
                  obj-$(CONFIG_IPIPE)     +=3D core.o timer.o   =20
>=20
>                        but i do not know witch function in core.c and tim=
er.c affect my kernel .                           =20
> could u help me with that?                                 =20
>=20
> i have disable CONFIG_CPU_FREQ CONFIG_KGDB CONFIG_CPU_IDLE and enable CON=
FIG_EARLY_PRINTK.     and  set bootargs console=3DttyO0,115200n8 debug earl=
yprintk                                      =20

Since you are using Xenomai 2.6.4, could you try the latest I-pipe
patch supported by Xenomai 2.6.4, that is:
https://xenomai.org/downloads/ipipe/v3.x/arm/ipipe-core-3.14.44-arm-11.patch

Also, what kernel are you using, is it a vanilla kernel?

--=20
					    Gilles.
https://click-hack.org

