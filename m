Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2116.outbound.protection.outlook.com [40.107.21.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FF11CAD
	for <xenomai@lists.linux.dev>; Mon,  9 Oct 2023 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="VnXFBAGz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CziNBpsM68nYOWtFiAWLgH6lMbEvl14LE0DtFkeSBuYjdPZlM3SuxxCYuCiMngxMem39MtEWpjjSHZG1UiarIrkG9fRu9cYzWLg798joECunX54sCYYcet2ry21ZpUAhk4m88Rzsju2y2nt8KwpBlV9QKyIgmgu5BcLPvJ+0iD14rQp5c4KfKpfJq1wzwoZoVkHnlNnjMkD9NKL+driEnsD668/RP+m6/tH8k//FI1LpNaS/jK4ASnLwtqrEKcE5JStLSrTzZOvMjazSNKIaLeRtKOKMHaMR046CBJi09a06GFGUTm4GkY8xCfHazNJTiXRA+KRWmyXRvsmxJnzHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQTuwvfjZkYQIcunqi4Srj7/v22IXmXUp57/Ps7BQGc=;
 b=SJJjNM1cwWkOTh44JTAofMFry2T3vzYnBbEo0gkIhynV/mVCa7GjfqrbaiXZUYXyQMVgvcD12kN5nVZX19qjdVEBdC7JRczVeKv2/R2IC/lPCnF6UZJIrqj75Reo2t6qWjJYAHEqNnOWj4JYwdvLE4Di6mqTXxlBR9R6VCGUqTSbSF8Pv8zQKZ8NYz0Y89OQicwt91aA2gw9qYvxdQStT9shCz3VxpFPneWJ7Os2A7gojBZcVoNJ5Cpt8n5kC2wXmUepkYywucwoKnBddPrHk2YfIAD4xuxdRLjLa8rNonqbabsvDLed3w08YDgkfodzFtp3TpkTIWypGhgseFv6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQTuwvfjZkYQIcunqi4Srj7/v22IXmXUp57/Ps7BQGc=;
 b=VnXFBAGzvGMREhs1pirhxwFgVrDHM8uSo55VyyhGnfukExlheSJuAgrnfe7Poqjd+OyRdRX8dzet3p0n95XcKZkK88cQIECw40Wye+JCVSOGoSLU+uvnPuKQt4sS9U7K6LJpkCl6eZjQyZ4XaS0WaMPuWX9C/oxikOLZu5WbgPo=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DB9PR08MB6345.eurprd08.prod.outlook.com (2603:10a6:10:252::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 12:44:35 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::e52d:fd86:88e3:8ad9]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::e52d:fd86:88e3:8ad9%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 12:44:35 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: RE: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap
 handling
Thread-Topic: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap
 handling
Thread-Index: AQHZ+EH+2bOuBkWV60WkTqffPPGGg7BBaWaA
Date: Mon, 9 Oct 2023 12:44:35 +0000
Message-ID:
 <VE1PR08MB4909ACFB96F3BEBA2D813FD092CEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
 <20231006104304.3813326-2-clara.kowalsky@siemens.com>
In-Reply-To: <20231006104304.3813326-2-clara.kowalsky@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|DB9PR08MB6345:EE_
x-ms-office365-filtering-correlation-id: e08b3f15-56fb-4ba5-9c31-08dbc8c57e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WR+PgivRCF/TpZZJduCUZnERGxiL7YfEpXbt/1I1cEZ1Ia72lcXPc9gcaQlicudKr37vR3uUlAw76YZTYNh7StyZ2TflgxtMBgt/fJVLkBD5fgUfbWvy5TCxltKMgIScuwymY/caYCEJCGaSYZZj4R4jsdUoFxjgLylNj/lE8xXoA7XEfXZt+YLAVH13trtKz96qWfBFk398FmPt4vRb2sSlTec8N9/7f4fuFa+08tIAkXlozWRva7SK/X2AR+Hz1h3MzLaNO28GDoLq1hLLH+Hi0lWJiErNDjh2+6zmMlu5s9VOqXcmxneV07wA3sqX2+BrvAnVgiQk+pqKiv2sXCcn22BfmvrIy88zjkwmtNhvqWqiQozpJfruzZU7K6pY6LFbp9h3H1qt0HPLV9WAV3/CgBDgIKlyM56EJcw1tly20lQVAx/xHtM14IFbY+YjviM7tzQ5KQo9Sxr3QRLvBKR8i2Z5OHKT9XRZ8WESZUcyr4quqDkuSyk+TY1znW4eSuY1rQbIxSwbvDovv8j+UIHYtTg3Tf5g1ZcodO5nfhsfVw4oWCxNqIIf4clVCYd2hS+vXUoyeuYjDXNK1cMNEtl1rIZYerQHAO/uZQj1EjSoljhCe27uD9hDN0O055St
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(53546011)(71200400001)(26005)(7696005)(478600001)(66574015)(8676002)(83380400001)(4326008)(2906002)(6506007)(54906003)(66446008)(66556008)(110136005)(66476007)(64756008)(66946007)(41300700001)(5660300002)(44832011)(52536014)(76116006)(316002)(966005)(8936002)(55016003)(38100700002)(122000001)(86362001)(38070700005)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O1yvDMj12cBAdh94EbeV0opnDZ+dEhrJV4/Nv4q2KBpdx/5nxh93QbMnUP?=
 =?iso-8859-1?Q?Rf3EF6YS2bDefM+kQC/4ewSP8w1KUB4GJy2mdg5NbemXuSt2Ti0HkHqtQX?=
 =?iso-8859-1?Q?4Nq5f0JojDhy4XkwRgPSaeqYf205eU1Db17rfLNRms7tCQFdTWtRmyBGO1?=
 =?iso-8859-1?Q?KX4bLwQKOiueky0GJJR0ft6DClAdJWipR2Ybrfy2tA99Mb0re4D2X+S6O5?=
 =?iso-8859-1?Q?ytTBJiKSIuJirClV5vc4cfE2HaFgUPIGhd8/E6nT/Csu4+mHscEpjTEa3c?=
 =?iso-8859-1?Q?o1gGfMlXn1TkNNU3HUNB7UsjwWd9yPqvwJNblQucd5JnMx8KU5CHWul4Np?=
 =?iso-8859-1?Q?GOA4e8G/yUveqAakFKwGsGkN0sanbtbCZkaY69aOCBy3QifTyhMMfflwDo?=
 =?iso-8859-1?Q?cjcCD7r2490xDcsEmt8Pm/giJZb+IslSKBF4WeVfP15O1gpsB6/vZmtglb?=
 =?iso-8859-1?Q?NaVoRIl/K7odra2AOHG8iyQoDCbbBp3ovD4OhsJA1jogmT7IJvV9UeGkyT?=
 =?iso-8859-1?Q?9Lk8F1tpKJqfRdsZF4YoX0Am4N/VtQOkNdvDDEMDXP2/7GLwgm4Y+7dE/2?=
 =?iso-8859-1?Q?9pNiOtNgj2Q0+xVQiKJ05rNljDLjNFRpbsO5jC+h2HlooE4wc4L/DzwBTD?=
 =?iso-8859-1?Q?TEQKozO5ni5ao2PxhqKNpR4g5V2mfvp5PfOyEOqZXUr3c+Eokx6mCFzJy7?=
 =?iso-8859-1?Q?8/jXbnFePJEGIlIuMHPCIlIsYbfHMB9AzuQgs7VJ/IGY6t0fZTweaXpTDG?=
 =?iso-8859-1?Q?7Y98SeQAhMzS8t73E77lEojGmJ9yu/FKtLLK5Sp9pabDks49zf64tnIBRz?=
 =?iso-8859-1?Q?tRuUKFyBnncChnLpFOIxxLtqa63xrGIGz/54iTEF9N4x/9mUkaIYPtH+wa?=
 =?iso-8859-1?Q?vDP8ADJLoxzBq6JguaEWUHeZBmgcVvQNyfaWfRtURtzjIb6djwFPoHhXXA?=
 =?iso-8859-1?Q?qbopvTxG2UEnnExRWK9xVdpRvKlG2FssXHaJGulnpJRnhbWURAk3kbDJwj?=
 =?iso-8859-1?Q?K85XOmoEA2819oqKSvk9jkLOyHpzWRtUWau2Q3BOaAnFU01nclkn3kRuSd?=
 =?iso-8859-1?Q?xDJYVlMYfxFL5WNdG3V5KcN4B+fZ+i3MY6BIgbrO+U0x9GS/mrK6g3ABkU?=
 =?iso-8859-1?Q?XYm7v269J1rp/h1+j2bdzxCm37ZzwZqKnd/QnHlvAjrgTKGuR9ThjkTj9u?=
 =?iso-8859-1?Q?3cgYAfmX6nZHK8Ak+ohgrb4eomCmAO4FYEv7mMf3yn6ICHiY4AcSkNYWGE?=
 =?iso-8859-1?Q?g8qe/WqQWx9jLcpFoHHdfD1j8rav9qBbLhijoe1UoIv5nnKVcSE6vMRoXV?=
 =?iso-8859-1?Q?D5MTdRK0dupZd1nO1nhvNhvMHygkyEL5qoBNfEhq0LYLmjdNkmTx77pE6+?=
 =?iso-8859-1?Q?NipzItF41xQQjosfuGfKVhYyHsUlDFt4IJ6J5IIjKOuPpb+O+/pT6zlJNT?=
 =?iso-8859-1?Q?4IB/gn4D7w0ZU3XfU8hS/WlsS620zC3UbKlwRmjv9d49CjudxaxZa/0FoY?=
 =?iso-8859-1?Q?GjTlaa0VKAJ1IBatRSqONz7XEfJdD9FGsvzPPgVHHneY3NuKCq4GaJWi3P?=
 =?iso-8859-1?Q?lukVTMJSkfN25iz0mZqBAcvhlY1PfIX3H3Cw09EczbCV059gZ4S5IQ5wjK?=
 =?iso-8859-1?Q?5mA6En2NH7JSOdYW4P2mMF6B1Q+Le9g7Ppzl2yHswx1Xgv9Vi663gqhQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08b3f15-56fb-4ba5-9c31-08dbc8c57e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 12:44:35.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdYRYut6I9y8VCzhM8JNIYg8s8NKcLQt7w0nama+hw4kzwHSy55qm6Ji4/tpPLWUt6Cm92xIB8t6Afew5j5kxDUYaLsm2ZbzC9VfrBpeIDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6345

Hey Clara,

> -----Original Message-----
> From: Clara Kowalsky <clara.kowalsky@siemens.com>
> Sent: Freitag, 6. Oktober 2023 12:43
> To: xenomai@lists.linux.dev
> Cc: jan.kiszka@siemens.com; florian.bezdeka@siemens.com; Clara Kowalsky
> <clara.kowalsky@siemens.com>
> Subject: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap ha=
ndling
>=20
> [Sie erhalten nicht h=E4ufig E-Mails von clara.kowalsky@siemens.com. Weit=
ere
> Informationen, warum dies wichtig ist, finden Sie unter
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> CAUTION: External E-Mail !
>=20
> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>=20
> When running an compat RT application on arm64 the break trap is
> handled via the undefined instruction trap.
>=20
> A possible call stack looks like this:
>=20
> Call trace:
>   handle_inband_event+0x2d0/0x320
>   inband_event_notify+0x28/0x50
>   signal_wake_up_state+0x7c/0xa4
>   complete_signal+0x104/0x2d0
>   __send_signal_locked+0x1d0/0x3e4
>   send_signal_locked+0xf0/0x140
>   force_sig_info_to_task+0xa0/0x164
>   force_sig_fault+0x64/0x94
>   arm64_force_sig_fault+0x48/0x80
>   send_user_sigtrap+0x50/0x8c
>   aarch32_break_handler+0xac/0x1d0
>   do_undefinstr+0x6c/0x360
>   el0_undef+0x4c/0xd0
>   el0t_32_sync_handler+0xd0/0x140
>   el0t_32_sync+0x190/0x194
>=20
> The trap is never reported to the companion core at that stage so
> running_oob() in do_undefinstr() will always return true. As the
> following bailout happens before calling the compat breakpoint
> detection (aarch32_break_handler()) debugging the compat
> application does not work.
>=20
> In addition aarch32_break_handler() has to report the trap entry to the
> companion core.
>=20
> Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 2 ++
>  arch/arm64/kernel/traps.c          | 7 -------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug=
-
> monitors.c
> index 32271ed24ef5..8157496bea62 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -373,7 +373,9 @@ int aarch32_break_handler(struct pt_regs *regs)
>         if (!bp)
>                 return -EFAULT;
>=20
> +       mark_trap_entry(ARM64_TRAP_UNDI, regs);
>         send_user_sigtrap(TRAP_BRKPT);
> +       mark_trap_entry(ARM64_TRAP_UNDI, regs);
Should this be a mark_trap_exit?


>         return 0;
>  }
>  NOKPROBE_SYMBOL(aarch32_break_handler);
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b0db35eda8f5..a8c3642c61dc 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -456,13 +456,6 @@ void do_el0_undef(struct pt_regs *regs, unsigned lon=
g
> esr)
>  {
>         u32 insn;
>=20
> -       /*
> -        * If the companion core did not switched us to in-band
> -        * context, we may assume that it has handled the trap.
> -        */
> -       if (running_oob())
> -               return;
Shouldn't this be moved below the mark_trap_entry?
If the companion core decides to handle the undefined instructions, we will=
 be running_oob after mark_trap_entry and we should not emit an signal in t=
hat case.

Best regards
Johannes
> -
>         /* check for AArch32 breakpoint instructions */
>         if (!aarch32_break_handler(regs))
>                 return;
> --
> 2.39.2
>=20

