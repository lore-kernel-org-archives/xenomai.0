Message-ID: <305035a40802220140y1c4c38bbq9016ca6ffb1adf14@domain.hid>
Date: Fri, 22 Feb 2008 10:40:48 +0100
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <4272986BE32B50458F5E186DBBF3392B07C20A@globen.stockholm.syntronic.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <4272986BE32B50458F5E186DBBF3392B07C20A@globen.stockholm.syntronic.se>
Subject: Re: [Adeos-main] AT91SAM9260: Necessary patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?ISO-8859-1?Q?Kristoffer_R=F6nnblom?= <krro@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

As far as I know, support for AT91SAM9260 is now in adeos, so it is
better to use the last version of adeos.
For MAC-B it is now in vanilla kernel (at least since 2.6.23), and in
2.6.24 there is also a bug fix for underrun.


--=20
Gregory CLEMENT
Adeneo
Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41

2008/2/22, Kristoffer R=F6nnblom <krro@domain.hid>:
>
>
>
> Hi, just wondering if the new ADEOS-patch
> adeos-ipipe-2.6.20-arm-1.8-03.patch is applied on the same
> way as the old patch, according to Gregory, in april 24 2007:
>
>  "Hi,
>  this is the last version of patch support for  AT91SAM926x, it now
>  support  AT91SAM9260 and  AT91SAM9261
>  To use it:
>  - take a vanilla linux
>  - apply the I-pipe patch
>  - apply the AT91 patch, then solve the three rejects by hand
>  - finally apply this patch
>
>  (as we also use NFS root on AT91SAM9260-EK, we needed to had support
>  for Ethernet MAC B, see
>  http://www.spinics.net/lists/arm/msg12707.html and
>  http://www.spinics.net/lists/arm/msg12961.html )
>
>  As there is no support for AT91SAM9263  in at91 patch in 2.6.19
>  kernel, we prefer wait for 2.6.20 (or higher) ipipe version for
>  integrate this chip.
>
>  Gregory CLEMENT"
>
>  Or is the new patch improved so that the AT91-patch is unecessary, aswel=
l
> as the support for ethernet MAC B?
>
>  /Kristoffer Roennblom
> _______________________________________________
>  Adeos-main mailing list
>  Adeos-main@domain.hid
>  https://mail.gna.org/listinfo/adeos-main
>
>


www.adetelgroup.com

