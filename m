Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E01A0BDB
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994028; cv=none; b=FwK5X7uX4/+pajcH6O8AU00CPPoVHtjqlLnPVCvKke/XkkPzucEm49iWfMnnDRd+r4KaYB77Cc10awydrVbzegQ7hOcIlOdIafoQn12KaA/TnmRygxfcclD/9cu/sqFqb3JZeJ6Hzy2L1DbLoAWBKCAoMlrlApyGHoetI4y+sL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994028; c=relaxed/simple;
	bh=JUyCTd4oPhrMEoqw0IG3UHSw0XWVFMBsd8xgX3ulKVo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7p3vSnnlffcm1uhqY1vMPrybbHArGw9vf9BIkKXqrptIDVZBFSyUlC251jLUc2m6qoI07NhXHw3L0eqrysb2JmlGD1R1ggm/qmbuP57atvEreTBipTnkiwOwc0z+LB8HaNC/ZCBinmqBBp4ONtmXt4GaJsTHLy0NpesxVf7cTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cyZRVn5r; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cyZRVn5r"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250326130020b7020bc4c0738015a2
        for <xenomai@lists.linux.dev>;
        Wed, 26 Mar 2025 14:00:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=B7oY4ijin11VoliqcD0uThjXVxN/LU5gzYALKfWaEps=;
 b=cyZRVn5rpgwesracx69sT5EBzmjtnhlWJ2bHG/zcUnvM/VMGbNokGADdlMHDPprNf98x1B
 I0n2qFb2IwTt6gBaxj9PtyK36EPD3PM8iqsdMPngEn2FkHWeUK6t6HxFQvV7GBX9v6izFLS1
 vYwSnhit7ZCunRbMLmK+itUOOPoazVPHgnfts+3DSrsCmPCM5Etwvv2/BSVdKQ1gLmGIxvxT
 w6jWp/EOpkzDY4nfg5roiRQKmW1oQp0qq/KgP5BDOuBx2OE7RUIA/O7cgTiYgTpvHwbKxcCY
 vk1IgQFrM0I88LjIXHXm7lIPjHb6JntqsozkPKriobc9RpewsLKkLd5Q==;
Message-ID: <6ddc650bd0b098dc7e3eb148115ac03b65a5a947.camel@siemens.com>
Subject: Re: [linux-evl 6.14] - RIP: 0010:irq_set_chip+0x92/0xb0 -
 amd_gpio_probe
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Ionut Nechita <ionut_n2001@yahoo.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 26 Mar 2025 14:00:16 +0100
In-Reply-To: <27996af8f7c7f739afd2fc6be610457c7fafbb8a.camel@siemens.com>
References: <1086761396.1811188.1742932803430.ref@mail.yahoo.com>
		 <1086761396.1811188.1742932803430@mail.yahoo.com>
	 <27996af8f7c7f739afd2fc6be610457c7fafbb8a.camel@siemens.com>
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

On Wed, 2025-03-26 at 13:51 +0100, Florian Bezdeka wrote:
> On Tue, 2025-03-25 at 20:00 +0000, Ionut Nechita wrote:
> > Hello Xenomai Team,
> >=20
> > I notice today this:
> >=20
> > [ =C2=A0=C2=A0=C2=A00.556966]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =
------------[ cut here ]------------
> > [ =C2=A0=C2=A0=C2=A00.556968]=C2=A0[ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1] =
irqchip amd_gpio is not pipeline-safe!
>=20
> As written here the amd_gpio irq chip is not marked as pipeline safe.
>=20
> See https://v4.xenomai.org/dovetail/porting/irqflow/#irqchip-fixup
>=20
> That is not a 6.14 specific problem.
>=20
> As nobody complained so far you might be the first user of that driver.
> This driver has to be adjusted to become pipeline safe.
> I don't have the necessary hardware at hand, so I cannot look into it.
>=20
> Florian

A try into the blue:

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1d7fdcdec4c8..7968cdaf8679 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -588,7 +588,7 @@ static const struct irq_chip amd_gpio_irqchip =3D {
         * prevent the system from suspending.
         */
        .flags        =3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTA=
BLE,
-       GPIOCHIP_IRQ_RESOURCE_HELPERS,
+       GPIOCHIP_IRQ_RESOURCE_HELPERS | IRQCHIP_PIPELINE_SAFE,
 };
=20
 #define PIN_IRQ_PENDING        (BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF)=
)
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 3a1e5bffaf6e..531784c83d07 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -92,7 +92,7 @@ struct amd_function {
 };
=20
 struct amd_gpio {
-       raw_spinlock_t          lock;
+       hard_spinlock_t          lock;
        void __iomem            *base;
        void __iomem            *iomux_base;

Maybe you can try to build that, apply some intensive testing and
report back if that worked out.

Best regards,
Florian

