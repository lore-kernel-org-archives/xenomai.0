From: "Jose Pascual" <josepascual@domain.hid>
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
In-Reply-To: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
Date: Thu, 12 Apr 2007 19:24:04 +0200
Message-ID: <078801c77d27$5e7cc420$1b764c60$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: es
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: 'Gregory CLEMENT' <gclement00@domain.hid>, adeos-main@gna.org, 'BOUIN Alexandre' <abouin@domain.hid>

HI,

I'm working in a at91rm9200 custom board. Can I use this patch for
at91rm9200?
what should I change for at91rm9200?

Could you send your benchmark results? (what mherz are your PLLA =
working?
and your Master Clock?)?

good job
regards


> -----Mensaje original-----
> De: adeos-main-bounces@domain.hid [mailto:adeos-main-bounces@domain.hid] En
> nombre de Gregory CLEMENT
> Enviado el: martes, 10 de abril de 2007 18:48
> Para: adeos-main@gna.org; BOUIN Alexandre
> Asunto: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
>=20
> Hello,
>=20
> We port the adeos-ipipe-2.6.19-arm-1.6-05.patch for AT91SAM9261.
>=20
> This patch must be applied on vanilla 2.6.19 with at91 patch (
> http://maxim.org.za/AT91RM9200/2.6/2.6.19-at91.patch.gz ) applied for
> supporting AT91SAM9261.
> So first get vanilla kernel, then apply at91 patch then apply our =
patch
> instead of adeos-ipipe-2.6.19-arm-1.6-05.patch.
>=20
> For now it works with Xenomai on AT91SAM9261-EK, if someone is
> intersting we can send the benchmark result.
> As AT91SAM926x are pretty similar of AT91RM9200, there is a some
> duplicate code and some common code.
> In the future it could be also work on all AT91SAM926x, we can test =
it.
> But before going ahead we would like some comment on this patch.
>=20
> The better would be working on 2.6.20 which already have support for
> AT91SAM926x, but we didn't see any arm patch on this kernel nor any
> file modified on git.
>=20
> Hope this patch will be usefull.
>=20
> PS: Would we post it on xenomai list also?
>=20
> --
> Gregory CLEMENT
> Adeneo
> 2, chemin du Ruisseau - BP21
> 69136 Ecully Cedex
> France
> Tel : +33-4 72 18 08 40
>=20
>=20
> __________ Informaci=F3n de NOD32, revisi=F3n 2176 (20070410) =
__________
>=20
> Este mensaje ha sido analizado con  NOD32 antivirus system
> http://www.nod32.com



