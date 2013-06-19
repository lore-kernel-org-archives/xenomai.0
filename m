Message-ID: <edab78ef9689f2f0202dcee35cbf4324.squirrel@www.xenomai.org>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
Date: Wed, 19 Jun 2013 14:06:35 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] No Rootfs after installing Xenomai !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Younes CHALABI wrote:
>      3- I tried to patch the linux-3.0.35 with :
> adeos-ipipe-3.0.36-arm-1.18-11-pre.patch |
> adeos-ipipe-3.0.36-arm-1.18-11.patch |
> adeos-ipipe-3.0.36-arm-1.18-11-post.patch
>           But I had so many rejects, that why I prefered to use the
> rel_imx_3.0.15_12.03.00 and it's advised in :
> xenomai-2.6.2.1/ksrc/arch/arm/patches/README
>                Doing the same procedure as for linux-3.5.7, I had an
> uImage that I loaded on the =B5-SD with the rootfs and u-boot
> either with the generated files from LTIB or the
> L3.0.35_4.0.0_130424_images_MX6
>                     THE KERNEL LAUNCH BUT DOESN'T START :
>                           mmc1 is current device
>
>                           MMC read: dev # 1, block # 2048, count 8192 ...
> 8192 blocks read: OK
>                           ## Booting kernel from Legacy Image at 10800000
> ...
>                              Image Name:   Linux-$ (3.0.15_12.03.00)
>                              Image Type:   ARM Linux Kernel Image
> (uncompressed)
>                              Data Size:    3813344 Bytes =3D  3.6 MB
>                              Load Address: 10800000
>                              Entry Point:  10800000
>                              Verifying Checksum ... OK
>                              XIP Kernel Image ... OK
>                            OK
>
>                            Starting kernel ...
>                            "Stops here"

Hi Younes,

this issue is different.

See:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_kernel_stops_af=
ter_the_message_.22Uncompressing_Linux..._done.2C_booting_the_kernel..22

Regards.

--=20
                    Gilles.


