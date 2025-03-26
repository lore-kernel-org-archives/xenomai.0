Received: from sonic322-56.consmr.mail.ne1.yahoo.com (sonic322-56.consmr.mail.ne1.yahoo.com [66.163.189.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC11A2541
	for <xenomai@lists.linux.dev>; Wed, 26 Mar 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021944; cv=none; b=oqf8knI0i9EWV595+DyEucBaIaEKIG5SZasESExQJ2uvzqBZA37WWd0r23/F4EW7cguqp0mJvY7J4kSSni9af4A3Z7MXQi98VYAOe/hTaE1/l5YHWD+93jAYNz6ZjinezT7Ija7KFyCCe6SHBwLoVc1bZl8yOOL7CI2S6GEaeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021944; c=relaxed/simple;
	bh=RVKRLac/xm1Z2UfkLC5Ux40CVknA//V0EBQnehmnfG0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dP3fOZCYK4KRODNzhlWETfw4JbKXWLeh0GMi70hdYq17541tLvxYEPLz/dwcAEeECSkfzdww14kQoLz5B/Z6pcwqMhcemR9oBIWhTgnGFAnc8cTs98tcNy9nL8NX2TuuYLeb/sEiKm66K8s40yiNzklEguT/ltbeSe/CdiVF1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hiee34CG; arc=none smtp.client-ip=66.163.189.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hiee34CG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743021936; bh=RVKRLac/xm1Z2UfkLC5Ux40CVknA//V0EBQnehmnfG0=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=hiee34CGgujyfPiZUBTpsUO6IpFFj4FzS6fIxm+7rGwlSV1Rmg9Ot4uWxwG6PML/A9nZEawwTABhMpDejshDwkltepBsQGkcR02ayjqT5U4FJ8beMgMB7FYJ+VMKUBQAUUycJ3Er1QxPumWirpC+X9VvLn15O6wDCVMxwgLWNXkrfJNnD4WRDH9klbM4iLNBhpiz++K9m9vKcKyErZaDO89xKowq7r6QbbsLU4zAjkiYn1DusxORPGJ8a2HRPHAWQJ+o4bcrPU2XsCtwO7gYQWRi0NsMbFKe2ZEzkaDsVIbeuSXH+3UrMwjk3Jlu8nWxBjVv3LXaUJKNnStTztqyTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743021936; bh=nHVr1qwfeNeIxkChHldWexDyXapS6r2TkgwJzzL1Bhg=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=BqKIH2VPvyk5PuGenbrHoJKukpJm910ikc9Fak6grLuquQTaiSQBHcuG4DQ2E/fcu3eXH/FrwNkUMT2swwLaoFhh0cSx+0TG3J2AhBnOrSHZprhlKJMgQjfm6VAwH4FE7OBsvGyuJVdNNAfxxUqhX9ZZqF674GNxWgOyD+MSFfQVNZsp+9iodJG+lNuhwEgKcsn6Q4cTsRtR7TrWXi1xYdrRtcrHVsiqjmmT6/j7bqjE3gpt1EJA++amsvepll28dmYfopglTuMkJ/YbpApXNz6m7OtwTCk4fiNGGdtw24EKlitmW1XBltH6V8uchK577IaYtnwu81FuPM4wbmUvVg==
X-YMail-OSG: 8.z0aj0VM1n7fyShK2LFo4zqKUV5.fi1dokG4jEVWcSwwvTzs.5s1n6UaMTFAgt
 SsZlUjw5vJQKtBUJ3hLRw3h2pXqN4DW5DoyzWCbbE6XNTIqYl.tMpaQp3OkgAtnc89qFHr1RQd96
 8iKKH3478Bmrq8g41xzWM_pVfvszfglw404qpsCzlorKpFwg67WYrb0R.fEAzA07SK9mA.Fpqh5m
 uW5vSnu.JvSUpdQTGdyiNNn4Lpd2vwYCOuZjD07L4OidituMZSmx1x.oGiIP3IuP44dCGJmcpgyE
 gApxBA6Vv2lvu8r3JaNNjckoSI4ILMWRmdFipEPW7FmUTRHWqe_gNtzahgDtDs6pZgdOepTgYs.N
 kwKW_SwQ93iHgK4TYNbZS6xFELfABfLELDGSTIEjrra5ATV74bOphI.ekxieP1ewRy5sNXQ8QtNA
 tgQl_ygEDrcAWeWz7eJRp0HBeP0msq0GB.3BpfpxePm24tkQe.UPTy0hgw7zmdkXR2fr8bgQxPUr
 x944VGAcmXYFxi7MjQRtiQgapN2gF9dvhvzFwnS3XKHqU9qI5Bgs6hIaMssteHFd.O5CRclAGdbl
 LSjWTUN7mC.S7V031A4JDXaxvyXfdvqd.HtPpwYeugqGaUE56Ux9JCzC3uj_vhTXBojOXSs2K6xB
 cIB2TryeZwuzuzCZJ_kpKLzQVLzCQsOSRAfC4Ni7miXi2BjjM5BQC_bvQw7RqZ5a1G.rpd4lZYS6
 MLZCRcv3so7bnK2.zYfwb4pU3_D_Y3U8MoOjKUdemvsMLaxgUaioRhrD8uUHAMCuMF.90lk6.Xra
 4EeNARagaMWSSTK1FFTheUWVRSa6hWSiyXoUZMpqPvVx2aVvI6qhVLxw3Q.ZIWEdrn71Gs63_76s
 7gqzVyLDlOOkdhDoxvORXOoWlrrjGasVsYJBo58Z_4Jkt8xXDHubgY30ML2Ts7h_vcdE1BY0KPoF
 KFjSUUJ8J0zxKx4iQrP7zm8IMxZcGUtQUee.FfguEUHXOS2FSqSl3UIM1ptaL4uRL1uL9bu3lEFF
 qqjL_plodw9phM1DjgJo9hfXuAzqvpBq41qjdyi6BxB4MFso38sVa_078Yr8Hyt3Jx.jmMiIWFDa
 tZklFGVgUU9V3eYDu48V9cWb0FhsZkUh0dVJW6zxRiAXgbS_afzrKPJqgd472tnZ.cKej9N_tVuH
 rlcv67U.j9NxPxl5w0qPQ6wNgK.Hbcccwe_vudjAUNnK1QsDkjj86firS2eIDr7Fz1Ka52PJlrUo
 ZowzrZVLouILh2ZgBSkUaID2yeSyn0IWGw_bvhcV21Ao97EnQUyQhN3GCYFyEh5IC8b0drwZGyJ7
 W34TFyfVwj0kH26kmehG2Fh5._c.M6QOzDNemn35wx2C_8.1bEAKB3I_op1qmrqTNDMSrNQIjdFV
 UKuInDQ0.Z.Fb.Q_UzDuQMQSSEeGB.2_9G8w2bjCt.2u2AFaclJ6yyEM913LMFW.K1XbV6.JTFdO
 eR915RibptBLSduaRM85RIny9Iz5n3cJh4WjlxbJp4r8ne.AOAjKglLSieHB4CRSqbE6yNkvD1Pk
 72sDV_HXvCsufTiKPenFmEw8yXiyi9hkfLADQqDLEojhTEEXbegorIckh93YdL9ZaEinBJI2hLCx
 MTdFwcsUJOBLlLoYs8yg3X1imYM1.b4k.xrTWSBlEy.JuMGagLhSv3l13VoRKibjNiH2GOSwox1H
 FkXJ6bTKsvj_lBC2QzW4GasrKildoWPSMr.VzzjImwx4GiDinQLFWsGdCABq7bA4kqedresi_iKr
 Xp3GSD0YDpwWLN4WnoLhN6kuRuUalchwtvVDQ3QJgWA0efWjTpkEA7r1MdCyl8.mSSnYN4DuPS7J
 VjcFWhMCeh8nYE7Lgb4RcLuv2ZL1_E4qHwO0LdNa9olzrBmU04UhwklwLBcNUhp1rtnpVLDzaCUr
 TJMKHN1jqN5AMUllRHze2xPEU8RIjdGL2BPSV1VHSYt0mBNI_VWEwbrhmutarBR7WJzll2C1fE1.
 XM8ael38fwBI6eJ9.suU7D6zBtZpOu081TrUcv6pfdmkGaxAblLp8rBKg6saxcpF5t0oRFebJ8q6
 IgcubRkuSJeKz.17B3Wd_zJZz3wS5VJni7F7q84tp5LXoPZq9CSpcNR.jPUcwtUxGGiWBUXWkdPC
 hl9pFRnUwhpoTADjSlexz0_09Jm1Bf9fEG16Lqr1uXkoN7MA6Lfyk4L7LaIxo7yBPVL_M344X1Rj
 jzdCLT5QRFGbrY_U0xzHDp6XeLNpSzEBBpygMgE4_4rxb_v9KKhqW6h4-
X-Sonic-MF: <ionut_n2001@yahoo.com>
X-Sonic-ID: 9e1ff16f-26cf-4bf2-b400-e69a84dfa961
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Mar 2025 20:45:36 +0000
Date: Wed, 26 Mar 2025 20:24:55 +0000 (UTC)
From: Ionut Nechita <ionut_n2001@yahoo.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Message-ID: <182707310.2311658.1743020695882@mail.yahoo.com>
In-Reply-To: <6ddc650bd0b098dc7e3eb148115ac03b65a5a947.camel@siemens.com>
References: <1086761396.1811188.1742932803430.ref@mail.yahoo.com> <1086761396.1811188.1742932803430@mail.yahoo.com> <27996af8f7c7f739afd2fc6be610457c7fafbb8a.camel@siemens.com> <6ddc650bd0b098dc7e3eb148115ac03b65a5a947.camel@siemens.com>
Subject: Re: [linux-evl 6.14] - RIP: 0010:irq_set_chip+0x92/0xb0 -
 amd_gpio_probe
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23533 YMailNorrin

Hi Florian,


Thank you for your support, I've made a small adjustment.
Now the warning message no longer appears.


diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1d7fdcdec4c8..1129068adb38 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -587,7 +587,7 @@ static const struct irq_chip amd_gpio_irqchip =3D {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the wake event. Otherwise=
 the wake event will never clear and
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* prevent the system from s=
uspending.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE | IRQC=
HIP_PIPELINE_SAFE,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIOCHIP_IRQ_RESOURCE_HELPERS,
};
=C2=A0
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 3a1e5bffaf6e..c8130e13b2b1 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -92,7 +92,7 @@ struct amd_function {
};
=C2=A0
struct amd_gpio {
- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0raw_spinlock_t =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lock;
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hard_spinlock_t =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0lock;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*base;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*iomux_base;


A good day.







---------------------------------------------------------------------------=
----------------------------------------------------------------







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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * prevent the system from suspending.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D IRQCHIP_E=
NABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
-=C2=A0 =C2=A0 =C2=A0 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+=C2=A0 =C2=A0 =C2=A0 GPIOCHIP_IRQ_RESOURCE_HELPERS | IRQCHIP_PIPELINE_SAFE=
,
};

#define PIN_IRQ_PENDING=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BIT(INTERRUPT_STS_OFF) =
| BIT(WAKE_STS_OFF))
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 3a1e5bffaf6e..531784c83d07 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -92,7 +92,7 @@ struct amd_function {
};

struct amd_gpio {
-=C2=A0 =C2=A0 =C2=A0 raw_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock=
;
+=C2=A0 =C2=A0 =C2=A0 hard_spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loc=
k;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *base;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *iomux_base;

Maybe you can try to build that, apply some intensive testing and
report back if that worked out.

Best regards,

Florian

