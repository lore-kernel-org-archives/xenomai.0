Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2092.outbound.protection.outlook.com [40.107.103.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07F10E6
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 06:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KztiyxYSJ1gEBr2lJChg+22w7FHSxAbiNQw5D07J2nv/Jnn+Ig2zUQRuO12M1XRUpRZPKmMA2jjgU01yAgc/JcaSpodU1wd+Rno+EGX6ms6VGrFfbE1cl2OvBMxTLLs1eJY3GuW+G3ewBFrEJT8StYDDV6ZaYTgiNbmjvtpXgyteezr5Uiw5iqbW0aOEWzCQmqDWC9FN87dgsPnNwpuRtiCjoHCDJ54WyM8pa8gcqFMTV04sbLqda5d1OITUK5Bjx30pJyw9f6zSSLac6NXqIdqvcPx4cLO6PYGsQrv7cpwh2Ze3vov6RfJhMXVkgNj0HHuveC9F+B0sccqUSCwjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7haT44ox1JgBON92bhlrVp97PusBI2Mz+WPngOxD1uM=;
 b=ehBJZZ+bpurymESPdGaPUEE8REvFW/pwLGEO0ldzThrUDy0NuNDB3sznKMqwOL8popeir9ddMolMezRnPa7UYtAgliT9oEjE0AaNPkX2MuG2UbxpG5K4m8w4ZIMtWh1+Es6KeMKXdWjKdiYTAg2FU3Ajxw5vYkfOwY4dMmxgTunLD2Mb4FGCDi4Riz20MLdwTEBT1nQM1RQfRYGmUMAifra2g6k1giTPtAAzulUKjgrQ/rvcTim7IWsVjViWhSRzWpSEierTgaiBH//8pvWA+1MLxpbz+fQYZhokKDqr0TUGbtOzA5xlsA2dxXUsMqWax+Q6yRcVOi+24uRf29jD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7haT44ox1JgBON92bhlrVp97PusBI2Mz+WPngOxD1uM=;
 b=LejSdygDV/jBX/tWiwG66+fHwPn3g0SZUNRRhqKk3Mr6VdkoQqZIpxJopvJvRrYt1KLXD6GAkaU4eSRcnnjE6g75RDn7wyXBj1R4V/YML3HoZNaHaEK7BdlcWA5pd7bm1+CzauGrhwcKhcqe6rOdgawBb2EYkVgyDPA+yjq7N2A=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PR3PR08MB5739.eurprd08.prod.outlook.com (2603:10a6:102:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 06:29:16 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 06:29:16 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] fix oob_trap_unwind call in SME handler
Thread-Topic: [PATCH] fix oob_trap_unwind call in SME handler
Thread-Index: AQHY4fG6eVZFPUL92ke3zdhwYE9/Gq4SH6Cg
Date: Mon, 17 Oct 2022 06:29:16 +0000
Message-ID:
 <VE1PR08MB4909F06FC4CA8F02081EF97E92299@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20221017062827.2589013-1-johannes.kirchmair@sigmatek.at>
In-Reply-To: <20221017062827.2589013-1-johannes.kirchmair@sigmatek.at>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|PR3PR08MB5739:EE_
x-ms-office365-filtering-correlation-id: 2b79380a-5aec-4a5a-f54a-08dab008ea2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dl293Qjvqp5SdrUuTe4gVbw77VXBht28W/Bj7ksc26FWUrVOqq1Gqt4zW0TzkjAIFaTzCPPHHWofSPvqj5H6lG9wCS9xARNk/vfXCEKWFfwMoZRZWt32xFX1AYedlLDxUFzFVAJJe4TNLySQv2ymR8jJgHy+dHQYNg2Uw3twfzzxE6ldHtz8w3QM0qHdaPLbjzg2NXGBLQ6gAXbNIrX/s7yiUaMRnyOFYVKNgiQpkMbkuOgXVPc6v8YO+fD25x53mYXA6u0WJYMndOtwKcBru1g73fY0zng3EE+1Mei7P5EhoNoxbmJ0+gjhpwlwfWMX9p506I+eQcj/o6GO7kLETm4PDnR8zb2Tu7GKWuGHqVYub8CUcPvN+OTbUehAFiHy55D1x/4jfdTVipp8+HNPiYdyQjHECRhqk4NP5CuMeXlmi8wvKFVur6UoNc3D/qAF/fujOO9SFvhOYmgN3mU4WLoncyCx3NYXl8G4ojNOJvzVGKK3KHjFbxoxI5D8VyXMmN19YvHViJ9JVGtE27DkNeGcJbGLc/wp7qEHAz1dNDFizendv3NUwB33Mo1KFSjD+MyZJRqqNwhXUwzXNaeEzOeVyvqkVCNgo/z7iBun1EjgZgaLYQzd/w+v5DFEQXkfAcUJnoO/433QtZIspbfdB/pIRh+fiGKgpTqIMDtaYQOfycmtwtH5fYjCXaE4o8k5j6zXkz0q3IL4i8PBtCt/2k8ys+O366KzHYzrx1pv8EKTkiT+LPbHT6ubF5cN9w4gh5p8T0lpK6AhXI6Js5h+xb/PVC/RsfekBBfoZy723p4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39840400004)(346002)(451199015)(38100700002)(966005)(478600001)(71200400001)(38070700005)(122000001)(186003)(33656002)(316002)(8676002)(64756008)(66446008)(66946007)(66556008)(66476007)(6916009)(76116006)(6506007)(5660300002)(7696005)(26005)(53546011)(41300700001)(52536014)(8936002)(9686003)(55016003)(86362001)(44832011)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iZnNwMTY2hgmEIeQ10AMSjXT+1wd+lMO0oG1Edtx2um5rcuVUI5ZdroaZH5m?=
 =?us-ascii?Q?hLX9sRM3R6PdPA2CLNGw471pfozAuL9+3YcXcyC4oiIbZPKomzK6/Ki6QlD7?=
 =?us-ascii?Q?u2fLug5hvZ31Qgz//lGx4si6jxZD8VfkEIi+qHL6bsqIk88UPidAAfrO+Jjz?=
 =?us-ascii?Q?PFQKE3MHR7AFoArRJynTC2EJqIydhvYtVeelJzw4olQGl1HId3Vg3J6JG64Q?=
 =?us-ascii?Q?sazh/DTAcNChIfpmhVQIEX85zsjB+eWmsDxFby9miAgialVDLEV00WC7D00I?=
 =?us-ascii?Q?3V7zS69p8h1RTVEP3pH0CP9BEbsmpHks+oyjFJd+QFJKAV0ycHoeoqgEkz3Q?=
 =?us-ascii?Q?n3fmIioDyuVs4vpqWTcdcphA6SKwB6h6e8i03AUr9pkgqsD5qsSwt1kCCPbg?=
 =?us-ascii?Q?U8TsdTRjwt/S8+XsxGZPtWGMRiCe/InMcG8cDmTVP0MZae1E9N/XulgmvTBO?=
 =?us-ascii?Q?T0cjZ3pQ4otd1fMC9i/7OKbizD5GPRvbl+Tu6pezoGhVo8ouzZwuSkD0oe0d?=
 =?us-ascii?Q?VDXwbZAqM/TyhMHo6jO+NSvOzMiGZjVGO0cMyj9kH+rfSuGRa4/VW0J+OBI7?=
 =?us-ascii?Q?7aCDnHH8kdEWm/Hla9Wsa+Ga1fKzNVtMSsskw2F2JO8H4dZD1BsxcKbe/DB+?=
 =?us-ascii?Q?UJ0R+i+kMf5yrOm0ttDQ33G6J925qy19GhxSJ3H7PfKSCt8guFzgAzNe3AN9?=
 =?us-ascii?Q?bbcDpQFFms30h/NXDgUSCSZQP+QQoePksJVOgXC8yKPeJ9urBodz9e9B4GAr?=
 =?us-ascii?Q?maKhAscfa2KVRgmb6xX3Cvg5fsru+lq+tLpbdmI6bysWQGmJMjC9F3mHT3Tj?=
 =?us-ascii?Q?RmL5t2hefQm5peG6iZWGM7ynzZqBRcSF1EbH0NXggBJ2s17Dyi/ULzJzKwjQ?=
 =?us-ascii?Q?yhCusw03EVKt0ESGMZU+1Zcflcb5dlMbw5TFxr+U1JvdGQlWPhcFbvcnEnIX?=
 =?us-ascii?Q?MYDyArklJu4g1yYOAG5q3KQKYduapYSprKPyv14cET7Lsi5HmqcGwssx28u/?=
 =?us-ascii?Q?LwWvdcYyQTaYnsUuahqgRRm2LaxjnHvIpPTKkRDe+nKN09SIBT31FwrfFsjr?=
 =?us-ascii?Q?ScMWMzd9nXAihcWyB9a90xYBHVIxiswyCcFodEbqSOQ+PdLKld3VxUNppcOo?=
 =?us-ascii?Q?+63vfT4fXHp7xtF6SvUIV2/UCCZr24YjkpUfZsJca723hBC9kVhlgWIvJj1v?=
 =?us-ascii?Q?8hkK9nJP0CY+IJ8nFlrLZQFy1msg/TMBxWN5xpQDBvelmhoY3IphiDCZ897P?=
 =?us-ascii?Q?vrQ9+HnIa9WioQnT7tFKGvrvD6Cr+l87+R9ROa2cxTF8zBZBs5LCyfnuD1Yh?=
 =?us-ascii?Q?yYdhWAIZLMJwjx2JVUoi9RdFZckbId/vf2TS2xzg5tX6iRje799qqofTFQxk?=
 =?us-ascii?Q?z1K4cle3LPcGKpnrNKqQy8rBE14OOKZv30IrPTw4McyMNkfTh0ID/DBj+lJ2?=
 =?us-ascii?Q?bZdvEOadtI+g5cgYGs38eg6H2AMRPCZAdugv1SZZtzoBKOeA/pbg1/0BOg8E?=
 =?us-ascii?Q?iafQretXVd8k9ErurzKg1a1/kOKrNoBb+jJBIcoD+F6Zx1lXUHy/I28U7+Uf?=
 =?us-ascii?Q?EsgLNB8u7cBgn5C2KGTCtl3SyY9aMR9L6jz6rLf5wDiggXisWC/0GtZnnVi8?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b79380a-5aec-4a5a-f54a-08dab008ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 06:29:16.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV8/SiUP9qwmENnmNbASkzUJMb5vgCQ1h27aEm4FIccCDdc0MQehqFp9IxPgUWEbkFW2A/ghzh8V/nZ37hTGHnXntrYlpjiBAL41VUMpK1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5739

Hello,

I stumbled upon the fact that in the SME handler the calls for oob_trap_not=
ify and oob_trap_unwind do not match.
The fist has ARM64_TRAP_SME, the second ARM64_TRAP_SVE as an argument.

I am not 100% sure if this is a problem. But I think it should be fixed.

This patch is for https://source.denx.de/Xenomai/linux-dovetail v5.19-dovet=
ail-rebase

Best regards=20
Johannes
> -----Original Message-----
> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Sent: Montag, 17. Oktober 2022 08:28
> To: xenomai@lists.linux.dev
> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Subject: [PATCH] fix oob_trap_unwind call in SME handler
>=20
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 72e5cb8e99116..be2e3ca8ce877 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1542,7 +1542,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs
> *regs)
>=20
>  	put_cpu_fpsimd_context(flags);
>  out:
> -	oob_trap_unwind(ARM64_TRAP_SVE, regs);
> +	oob_trap_unwind(ARM64_TRAP_SME, regs);
>  }
>=20
>  /*
> --
> 2.25.1

