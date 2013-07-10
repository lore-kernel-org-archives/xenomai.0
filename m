From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Wed, 10 Jul 2013 13:00:31 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
In-Reply-To: <51DC560F.90805@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE : RE : No boot kernel with xenomai on i.MX6Q Sabrelite
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

Hi Gilles,

I followed your advice, using the xenomai-master, but now the kernel not bo=
ot also. It stops at :=20

## Booting kernel from Legacy Image at 10800000 ...
   Image Name:   Linux-3.0.15
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3825732 Bytes =3D  3.6 MB
   Load Address: 10008000
   Entry Point:  10008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

Sorry for disturbing you, but it's been a month since I still can not run x=
enomai on the Sabrelite board. Now I need concise answers :

1- Did you already used Xenomai on the Sabrelite board ?

2- Which kernel | xenomai version and patches for the Sabrelite board ?

3- After the build I've got two folders :=20

     1) build_root contains  : linux and xenomai=20

     2) staging_dir contains : dev and usr

All I do to transfer the images is :=20

     1) Take U-BOOT from LTIB

     2) Take ROOTFS from LTIB

     3) Take KERNEL (uImage) from build_root/linux/arch/arm/boot

Are these files all I need to have, to run Xenomai on the Sabrelite board ?=
=20

Or I still have to do something ?

Please, if you have a methodology of how to proceed step by step, for final=
ly having Xenomai on my Sabrelite board, it would be nice of you.

Thanks in advance for your precise answers.

Best regards,

Younes CHALABI

________________________________________
De : Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Date d'envoi : mardi 9 juillet 2013 20:27
=C0 : Younes CHALABI
Cc : xenomai@xenomai.org
Objet : Re: RE : [Xenomai] No boot kernel with xenomai on i.MX6Q Sabrelite

On 07/09/2013 02:18 PM, Younes CHALABI wrote:

> Hi Gilles,
>
> On git under tags, the latest version of Xenomai is 2.6.2.1 (5 months ago=
), and I think that is the same version I use.


I mean xenomai 2.6 git current head.


--
                                                                 Gilles.=

