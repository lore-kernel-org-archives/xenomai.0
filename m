Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C12AD02
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025767; cv=none; b=abh49M5E33Jn764UHl4z8vRfFHQ7y7l85wNt+Bu9BLHTmIg27W76c5IdSyR7ycdeX9T5mN/yC3Ie9NjmYUq6fLVoiuQy3K3qrhK/4xluUsseVy9BIn4DM5fidBtFemhIp07h6H5VLdcvEQ9gernKFWPgsmBCrizDpna3IdTNXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025767; c=relaxed/simple;
	bh=4Yi49PC6w7QujcDcHAxVM8eF9LWyK7r3eppGUtDoYvI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=my9e10W9VSC5ldLS/dr/dGUohFrp5GhuBnRHTJ5s3fqyzTVZhEdI31atFlRurdNNdVdK1kuhPs0yuiHYgD5kaciYCzwmXi68oHef4g5u4PSluzZtuadMIfKNAZ057V7czkROwmGt633qfGPAi7v0mlvNI9ikfFRkvDWxaUVPpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FXBIVRQz; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FXBIVRQz"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025032621491238f2003083df219b72
        for <xenomai@lists.linux.dev>;
        Wed, 26 Mar 2025 22:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4Yi49PC6w7QujcDcHAxVM8eF9LWyK7r3eppGUtDoYvI=;
 b=FXBIVRQzjYmsyQR+A6lw9pXMc/3lhIEseNFtZ0Q/3jJa+9Qt72KR6GmmUZPLu4Xrv+5tOZ
 wGWDQNb3g39ueDoIcW06lS4d5UXpED5b0m5u4NUr0s/AYKuwyl5efT+P19gfcMwR5nUbJ3iV
 6hFd1lrCQaEfE+Ucw2DhSUr7PNJkmr3MgLe5KxxrsDKHe/JpOl0II+7yAdXp9G49QPhP9ppT
 qAjP5GCLDcOBb5Ntz7ykRnpDJmYlU0B6aB/eRfloCa69HIJlcdbWqb5/P/DTIPJP8OljbeWH
 OXSZuhWGAg6gFLcCecJ4k/S/TOBgwSTJ3f+jbax/b3vTfqoUWD65I0EA==;
Message-ID: <1c502d8b2b693e4f505bf65f1cefea4ddf6d3530.camel@siemens.com>
Subject: Re: [linux-evl 6.14] - RIP: 0010:irq_set_chip+0x92/0xb0 -
 amd_gpio_probe
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Ionut Nechita <ionut_n2001@yahoo.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 26 Mar 2025 22:49:12 +0100
In-Reply-To: <182707310.2311658.1743020695882@mail.yahoo.com>
References: <1086761396.1811188.1742932803430.ref@mail.yahoo.com>
		 <1086761396.1811188.1742932803430@mail.yahoo.com>
		 <27996af8f7c7f739afd2fc6be610457c7fafbb8a.camel@siemens.com>
		 <6ddc650bd0b098dc7e3eb148115ac03b65a5a947.camel@siemens.com>
	 <182707310.2311658.1743020695882@mail.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2025-03-26 at 20:24 +0000, Ionut Nechita wrote:
> Hi Florian,
>=20
>=20
> Thank you for your support, I've made a small adjustment.
> Now the warning message no longer appears.

Two points:

a) That the warning goes away is only part of the story. There is no
guarantee that the driver works as expected. That's why I requested
intensive testing of that driver.

b) See below
>=20
>=20
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index 1d7fdcdec4c8..1129068adb38 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -587,7 +587,7 @@ static const struct irq_chip amd_gpio_irqchip =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the wake event. Otherwi=
se the wake event will never clear and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* prevent the system from=
 suspending.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE | I=
RQCHIP_PIPELINE_SAFE,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIOCHIP_IRQ_RESOURCE_HELPERS,

It might be late, but that doesn't make sense to me.=C2=A0

The goal is to add IRQCHIP_PIPELINE_SAFE to the flags. Which you did,
but lost GPIOCHIP_IRQ_RESOURCE_HELPERS due to the "," after
IRQCHIP_PIPELINE_SAFE.

Needs double checking...

> };
> =C2=A0
> diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.=
h
> index 3a1e5bffaf6e..c8130e13b2b1 100644
> --- a/drivers/pinctrl/pinctrl-amd.h
> +++ b/drivers/pinctrl/pinctrl-amd.h
> @@ -92,7 +92,7 @@ struct amd_function {
> };
> =C2=A0
> struct amd_gpio {
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0raw_spinlock_t =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lock;
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hard_spinlock_t =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lock;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*base;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*iomux_base;
>=20
>=20
> A good day.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
------------------------------------------------------------------
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Wed, 2025-03-26 at 13:51 +0100, Florian Bezdeka wrote:
> > On Tue, 2025-03-25 at 20:00 +0000, Ionut Nechita wrote:
> > > Hello Xenomai Team,
> > >=20
> > > I notice today this:
> > >=20
> > > [ =C2=A0=C2=A0=C2=A00.556966]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1=
] ------------[ cut here ]------------
> > > [ =C2=A0=C2=A0=C2=A00.556968]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1=
] irqchip amd_gpio is not pipeline-safe!
> >=20
> > As written here the amd_gpio irq chip is not marked as pipeline safe.
> >=20
> > See https://v4.xenomai.org/dovetail/porting/irqflow/#irqchip-fixup
> >=20
> > That is not a 6.14 specific problem.
> >=20
> > As nobody complained so far you might be the first user of that driver.
> > This driver has to be adjusted to become pipeline safe.
> > I don't have the necessary hardware at hand, so I cannot look into it.
> >=20
> > Florian
>=20
> A try into the blue:
>=20
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index 1d7fdcdec4c8..7968cdaf8679 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -588,7 +588,7 @@ static const struct irq_chip amd_gpio_irqchip =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * prevent the system from suspending.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D IRQCHIP=
_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> -=C2=A0 =C2=A0 =C2=A0 GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +=C2=A0 =C2=A0 =C2=A0 GPIOCHIP_IRQ_RESOURCE_HELPERS | IRQCHIP_PIPELINE_SA=
FE,
> };
>=20
> #define PIN_IRQ_PENDING=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BIT(INTERRUPT_STS_OFF=
) | BIT(WAKE_STS_OFF))
> diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.=
h
> index 3a1e5bffaf6e..531784c83d07 100644
> --- a/drivers/pinctrl/pinctrl-amd.h
> +++ b/drivers/pinctrl/pinctrl-amd.h
> @@ -92,7 +92,7 @@ struct amd_function {
> };
>=20
> struct amd_gpio {
> -=C2=A0 =C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lo=
ck;
> +=C2=A0 =C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l=
ock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *base;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *iomux_base;
>=20
> Maybe you can try to build that, apply some intensive testing and
> report back if that worked out.
>=20
> Best regards,
>=20
> Florian
>=20

