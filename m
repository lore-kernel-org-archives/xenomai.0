Received: from mx08-00111701.pphosted.com (mx08-00111701.pphosted.com [66.159.247.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078502F30
	for <xenomai@lists.linux.dev>; Fri, 25 Sep 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.159.247.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342225; cv=none; b=KdnddR58F8/uEJZcLZcqRwNvtffGPVr2C9Mrz7WPJY/Iwfz6mzd08PHjM/rPBj7O7KZGDRqfzbYzF2HM1/tMRVbzu3GoSFV5b5I9tXPetsvs3O+L3IqMldNz8VBlAje/Hf/ZmgexTyWt4YSuXWII9XSGq85IqSTYXqtgPMQI0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342225; c=relaxed/simple;
	bh=/H/TQ/9M/sKqKptwXgS4Z5iK4RjVL92oY7irW6mncus=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k52vkLxDiSxXv+nxT0O6wYNaXxey1Q0sG+fvRfWp/gr37BspNzgjjaKZ4mUSPNU+L9ifaI1gw/06nSO+tzEjrCNagvWxIuo7bpLnz+ycVwwOJu3I4ii/NKJCgCYD2ZL+HHhJ/TESn+G7CZROrdNK4MQNhvmQUfIpnROtIW/Kw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; arc=none smtp.client-ip=66.159.247.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Received: from pps.filterd (m0501993.ppops.net [127.0.0.1])
	by mx08-00111701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4kvk22192867
	for <xenomai@lists.linux.dev>; Fri, 25 Sep 2026 12:55:07 GMT
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11020143.outbound.protection.outlook.com [52.101.69.143])
	by mx08-00111701.pphosted.com (PPS) with ESMTPS id 4gwebc9f6b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Fri, 25 Sep 2026 12:55:07 +0000 (GMT)
Received: from DB5PR05MB10855.eurprd05.prod.outlook.com (2603:10a6:10:4a8::11)
 by GVUPR05MB13028.eurprd05.prod.outlook.com (2603:10a6:150:349::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:55:03 +0000
Received: from DB5PR05MB10855.eurprd05.prod.outlook.com
 ([fe80::8183:3aae:fba1:a48a]) by DB5PR05MB10855.eurprd05.prod.outlook.com
 ([fe80::8183:3aae:fba1:a48a%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:55:03 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: unbind or not unbind Linux driver, before accessing registers of same
 device (BBB polling FIFO UART without IT)
Thread-Topic: unbind or not unbind Linux driver, before accessing registers of
 same device (BBB polling FIFO UART without IT)
Thread-Index: Ad1M7JxHYfjcTXs/Qiu9PuHfpxQ8cA==
Date: Fri, 25 Sep 2026 12:55:03 +0000
Message-ID:
 <DB5PR05MB10855CECAE2594DE7C8748478AD802@DB5PR05MB10855.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR05MB10855:EE_|GVUPR05MB13028:EE_
x-ms-office365-filtering-correlation-id: c16d04db-46ea-49ca-5f5f-08df1b0437a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|5023799004|3023799007|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info:
 noO2bioHqiGZ2DBGar0i4QccziSkgej4cifGGXrmSTWuN6ZANquMKQqqnK3jDjtxxspaWgpNZ5KuobN0ihWHlMCkjAdt/AVDHcP0pm2cdwigm/4XbjLnhjKupfuOJHj+JBLoQv1htFO1tBsIXWonhqsUYWEA2NNplJdYa+6M+GEbtFs0rdo+Hnf0LKjuwBdBH9Vw/Y8S3poqsihJK/4gjrbCcD1XuoJ5MILypjsw6heaUQ4ff0ZTgcRErUESf7aYK0MlnOIg6QCfsVDoCYqDvg3iqQTCUa7kznsX6FCPLhYXhWwdVVNZ6Ds5JBV2Eoj0ecHfh5ZFVAjEv12KqxE38z8+FVQ8Y2lyE+/gcnD759pA3QBpYeoMqQfLaQ1ta/Q8aUXPMBWrdFtNC+fQeBQGy8c4UT33hpchClU0Dkkj4oGfNTtG8TdJHyjAWWwmSBSkjczKuNF45i9TEaLeF93YKbQSZ58abMGipV4DTHqhsewYZNUiBmMQAnSOCBafcHzGgLUiNqrg3BFi/5FXsG3b5jpwWOPvUpNAfgolUIuFasEUMEmv+POwZK9b1w7t/FmTpHzFCtgBiLy22I0le7I78tTJGmes25cJldZ+tzi1tsSrldJCZjv4/SdgfqpGYOKxyX3k+lpbwjWn8FK2W4+vQqwmSmr4aPUMmMHqKtR5HQWA8Qz14Tbt6jnj3G8kxT/9OTyw+8NvT8s/Y084vWe/nWJnJF2r+4ANnAcf/2W+CWA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR05MB10855.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(5023799004)(3023799007)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zHkqHGnRFFcXLWpuU3qpVi430o+/yjkFw6DVhQDI9VPmWN91Raht3t3lPk?=
 =?iso-8859-1?Q?ssV20myO0H5g2ms1pp+duHSdYWkHp3HF8EXg/2mi9/sqd5RFI/IfRKFAED?=
 =?iso-8859-1?Q?fq6NqAjR0rzNh6vz6cy7RLzNBkMFfzQnziE3xJ5CeSgNG2rITWMqItq0Yb?=
 =?iso-8859-1?Q?Og5hqi8HnxFqFIQrNtvmekWYFYXE68MOsvAxngFOr0EEM8F/5CRV4AbyI9?=
 =?iso-8859-1?Q?Osic1uKTDm7euA1FdeEYyVpI4qF5ZSQINIMwQGy46g20svvtHZVFm/IfPS?=
 =?iso-8859-1?Q?kNQheHF1mmiSORPhSltBAmCfo70GI8cKIvOfdHDOBDF5XWI10DnfQ4PsvC?=
 =?iso-8859-1?Q?XDOykvjfv+aVUH6u4eCicZTgxPlA3jh6Gj7OgoPuykWiK++8VwklJfpRPp?=
 =?iso-8859-1?Q?/lnGOci0i23i3Lb5uEFS0gByhrBn2aV6DR2xV1pJjqQPpSXJpQ1/UVERc+?=
 =?iso-8859-1?Q?hC9orJG3Utpkpuo4kliT4MdyZRjlIbWvGKst1K0AFXSP5bkjmjL0eJWUlN?=
 =?iso-8859-1?Q?uFi0PaBW7LpgW5UBlniFblp4CZHmLFLaEaTm2w1Q51rBUgvGlMfEGUQZgZ?=
 =?iso-8859-1?Q?UYb2iV9rfu5SVujBY9LuCmbs4KBGizggQYjUZ1Zxi4dhg0dD0OFR8T/esc?=
 =?iso-8859-1?Q?K5d+5nuDli0ePx2bCAemVmv7JfEpY2xjf3Kg9xsOjY10ntNhF7PwZGw6bG?=
 =?iso-8859-1?Q?N7WW7ym3lnycJ2g7vG8VrSRJYHwGq2NkozDcVPrB6RDhFJo4dZvEfce9Q6?=
 =?iso-8859-1?Q?s3m7OntxfDu5lHL7+5QRd8wwcV2Meo+NOkGLGN5p8Vx1g0oYQN7GIwO9aV?=
 =?iso-8859-1?Q?YYbK3zEiSftnNfcK+6n3WsPdr3Lb/8oqsuzLaTIur2DPEdDN3jO+RFbBWr?=
 =?iso-8859-1?Q?d4BEGZR5xkiYOq6/YYcgxRd6gXKf6/H2Kb0syywpgyEQdrRj/XVRx1+MZM?=
 =?iso-8859-1?Q?bBo68t1PR/TynXSkO3k/iwuAOAcL5n4KpUt1v67M53m9EVEY/r3MUoE06l?=
 =?iso-8859-1?Q?HcAOf1c/r8OnW0i5Rs0/xCUtG5B0n8xs5D2pQwgluH6SIFaksVKpn0/e0f?=
 =?iso-8859-1?Q?z9HDrVSxOP/lJZCljB4Re1yte2XO/ncQPU6lRE10j3xCpqdTsqLSMiTksL?=
 =?iso-8859-1?Q?LzIRr8FHICbGsg5F8lvra/9gXYezZhr5qFmihMh6G2JFC332tYYoW1VxV5?=
 =?iso-8859-1?Q?SgKF7bauiQE2pXUjBFR7bn9FZ5UqRj2vH57GudS30c3z2faHt/aELNCx3N?=
 =?iso-8859-1?Q?TScnFXYU8al+27plCsVlGwJH1m0CYq7Ni/UJbMWW03IPwR9HzuI4pifvzP?=
 =?iso-8859-1?Q?V3Ugp31fRfGagq00L+hKRh8T09cU8cftSq7T8WEhROGv8ec/S3soktr4rf?=
 =?iso-8859-1?Q?OQjZKlBwMfSeV6lFhgExzB6j8riS5n7vEoHSmTaCG1Rw9vIzeLUU88CMOL?=
 =?iso-8859-1?Q?1lHBlJ6LMhnh8PodkEjNGJcsGY/jRpSsDka2zUEjUMUVnVrz3hIdyC501n?=
 =?iso-8859-1?Q?YTFmfoEqNn9TxXk889uvrHXMVMa2HBonRvWLyelYn7X+rKIEvI/CDGjpui?=
 =?iso-8859-1?Q?VhtKW4Fj0FMiodu+UBukli3hu9KGHqvG849iyepj/CMRh/7JCaheTbQ3fT?=
 =?iso-8859-1?Q?YjkdIQ9g4oDx/0OLOWx76J9LoTjGoYQKVxkGxRGK6fyhFtr6x26IgAVMKl?=
 =?iso-8859-1?Q?N2Vjnk5kSKy32vv/3n/nVz9mbRbpH52L9rGmDhwxljXWfOMDMoPP32gbC3?=
 =?iso-8859-1?Q?ad6yH2zvm1z2h2LIQRjEDOttEaNImEBnhbN9KSKnmiBzNcYvh8wzbg9umq?=
 =?iso-8859-1?Q?+DKv3QeLvUmz2gtyRJNHcVNin2WPzm8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	40ZerXpcqwQLbTwqTGJLhHPh26UPy99TvoI0ao24Ya/3tN+CGHFqpKSIgBWu9IWF/kEqNY09vqs0skDvmT97AJmrqoePpWL5yBuLp/FQ5V7buzfR4MQd5lBR+04jEx3KI9j5AHvthXQUXEYkFbDF/6bG5Wk/RAhBXK6fHDMuefxqz3jfjXgxC0drp5hW7Q8fUTEOotgEKZmarFbErUiqx659RBSu20/jxcQDVmNLLugFK48s0Gn1TKb+IlefFPOxrScCckqXQjtd8RLSUzwzLefLkMXMe27TOh3SRg9vsIEPz3f9EEQx/HtngpHd6yBVORYPLZs7mDXV+L+lKQzf+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrNWzxrDdkVaT+Qtz+tt/Cma3/KiZ16Ze0HrSHJYsoAFmplGaKf4znWXC77rBe8Oa6QvI2B3XfzUDDYY5VNbZ+pBbTsnzGOkqHi/VwbKkx5JQiXHk/aPuXbJWx0kGmmCAvlVLRno4F5ktziacCQKw8nmKJvwZDcnxmGYGeh5lEBfEbUXdO/Nbu1mAyDi0IYucq2Agn0OZuO/laq5QKAwHdEWLk58K1COinExZMx0SLBMsKZnse5H2xoOZfXOvbYKMIYTc5qFCAbvw38uN7YK8Ys2ZOqNeA0/7SdYq6ibelWToDYFwBS/Y4zSiThOxQkO61nQMJZu5Qb1sLfIbHvOR6lpy4Zewiurx/Lpm3mvz2Bd5PFqOI8t5pZ84hNG9ZtxCGl6ACfYCHzcaY9DdYufLmJq+iF4NrwZpa6IRHEyQFX3BqEKjOLl6l35IJ4aXqdEj0ZghQj2KozGuNBINr4ZpD9dGS+aIRYrtU1wB7yrS5lVNOq/0RjhdnreO7BdXi7/EwwUZjhC8nS+ZxK+BiHCZWZcGnhTDaaVe0RVhdoOIoEnIViV2hplthFMCLKoLp7H6Xh5XKiN+5m0YMzvJ/xfOg6IAVcdnIWKrbQ919ZJScHgi52G47QF4KaVlGBlH5SzILwn/gHOWliwDXvoWPY98w==
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR05MB10855.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16d04db-46ea-49ca-5f5f-08df1b0437a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 12:55:03.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6p0eA7rc2FRP0n3Z0Xq+rF2zVaaY26asw9fstAkufc/H3YktZydinpVq0reY1h3mQiDOvArbioSx4mqw7dGlqrACyVF6TNfqHr3y21V/Ous=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR05MB13028
X-Proofpoint-ORIG-GUID: _aDRHABuhO2uHZLNWCXEfJLefwEi8lsq
X-Proofpoint-GUID: _aDRHABuhO2uHZLNWCXEfJLefwEi8lsq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX726Mkb/vXkCQ
 QTng0IHcb36/T7dT7fTRxGAVF7eogcDhNY8j04/2vN1Z0A1VsO9BXgd/iH1t1YwyeKwr3yfKuyx
 AqwH9cV2P2ULqRcHEal3uvBNOqYmZg4=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ab66f2b cx=c_pps
 a=sG7gRiXFddCOwi3ClRJdjQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=3pO5eeZPQkuvD7nv:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=9PY2npKyfOMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=scitCSCTAArpb1kBHIah:22 a=p_L1_8G2-e5tVNZeU-K-:22
 a=wWTPQ8FWuC57MGc2ZewA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX8PFB8SVVfGcm
 CvZuU39LrPTov8dofd1BBhoiGjyujDknyqBo89kMQrMnodur/VQkP1hwTpxSAgvWSIjxRp6dMW4
 sxz/nzHXSWR/9zVC4Lnxxls3ng/2WqLX5cTfsqxXCe1qpAVRugZSWkEhPF+jAdlt1tMBnDjPQOd
 EUNczXjpaWN+551FuvNZJo2T073xevna8Gss+uBpC5vBccaCWEpbqB5kM1ZY9dntbaXp2P9UDct
 In4UNuSJvtF21UQqOpp9SDOiMiair6qynm4kgILIzeFp9jPG/S0hzUlr0EJ9y3FgWiEkd3tzJAy
 /4ebUGeLrZeWWEj8Itt0hyO86KWhOpsHjoVknqsxTyQsLyl8Y6Be8lEtJ7h5Xd49dWx5bGfsFk6
 hYlPxiB/6IhXAuX2OdF1UnUU99qXEb2ZlZWj10myRU6AJ6Pf0rBjFcSiJvuus+LXH8BiTj5/Tlw
 pgLKQqXrjX9KYihI1eQ==

Hello,

I am doing some tests with Xenomai 3 to use the UART4 on a BeagleBoneBlack =
just in polling mode without any interrupt, in a real-time thread
(for a simple polling protocol with short frames, and sufficient FIFO size,=
 it's actually quite well suited)
The UARTs on BBB are an 'extended' compatible 16550 well-known (on OMAP T.I=
. AM335x).

I have seen that it seems not really necessary to unbind the UART Linux dri=
ver, before polling registers of the same UART in the real-time user applic=
ation (/dev/mem).
(of course the serial port on Linux side is not used at the same time).
It's interesting to have the serial Linux driver per-default (pinmuxing + d=
river in devicetree), for basic hardware tests at the start and also becaus=
e the driver is activating the UART clock (else 'bus error' when accessing =
UART registers)=A0! And when unbinding the driver, the clock is also disabl=
ed immediately !

So my question is this : is it really annoying in principle to leave driver=
 enabled on Linux side in that case ?

Compared to the standard 16550, I've also discovered the important MDR1 reg=
ister which has a =AB=A0disable=A0=BB mode as default state (OMAP extension=
) that needs to be changed before Rx/Tx...

Thanks.

