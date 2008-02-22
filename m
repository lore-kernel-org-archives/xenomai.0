Message-ID: <2ff1a98a0802220135t7bebcb5n56b25f9ff7519e93@domain.hid>
Date: Fri, 22 Feb 2008 10:35:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
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

On Fri, Feb 22, 2008 at 10:27 AM, Kristoffer R=F6nnblom <krro@domain.hid>=
 wrote:
>
>
>
> Hi, just wondering if the new ADEOS-patch
> adeos-ipipe-2.6.20-arm-1.8-03.patch is applied on the same way as the old
> patch, according to Gregory, in april 24 2007:

adeos-ipipe-2.6.20-arm-1.8-03.patch supports at91sam926x, but I do not
think it supports at91sam9263 either. In this patch, at91sam926x timer
works exactly the same way as at91rm9200, and in fact uses the same
files.


>  Or is the new patch improved so that the AT91-patch is unecessary, aswel=
l
> as the support for ethernet MAC B?

What support for ethernet MAC B ? If you are talking about real-time
ethernet support, it has been merged in RTnet.

--=20
                                               Gilles Chanteperdrix

