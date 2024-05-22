Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FF824AC
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381434; cv=fail; b=OzxrSmFawZq1F+Y374T9z+DrwKhDzPOAiQOOZz9goRdZxv2oGeHXo6WPdtzt8Q38Jp4u8J+IAR6LxJe93YiuKu/M+2fFJmx+QAneh3ToVatcEyBOnMMV8izRUgSqZHkTX35vdIYupZE74K21J7tC+cVw8zgTw+Lbi5iunOAAH0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381434; c=relaxed/simple;
	bh=yyR/q+g7nvwNZLOT3mhROuLXE5IfTEs8hiQhKxuFxSM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QfcaMvttUvs0vM8zHSyNDwVngLyyu2XyIk+C1qRwLhK1yHQM5uPaQDatl6/aWcshvx3aHTHg7o8E4eEpHst0j2UX02hNEH3fM3/hAIKPjaAzT3Fbrdc/RqXO1I4YQCs7YdemUoQmGxXNldCpIsp0Y7daTbFd1qCY+acd6MV7NXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J6SsNvYy; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J6SsNvYy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RANhrLkVPw7y3ySCo7Fc9PN/fbbAbOTgyVYCgX7WQYtm9zlQ09gSl/H5n1Ixsyys3qXXfPfR5VHkyXOAG0Z4NrvofKiyKDIFHgURWaJehZgCbV/0Is2ILL5tH1ZwurpNj7p+lXNJRE8PEYCaJV+NuqiYjaqfi54noOiAoO33zVtCSJUZGSL+T7NrN7G8MYS19QGc9mEuBsqVNykBpjXQqEO2HJg90fp8kCk4CxYgYSmVVmZEM6VK+u7U/BzPA3Hmadv53Q+Y6STa7MVCCu8lJylNEM/OGSHe70nzHA1sYlMaLqQllttfdNzmrrKUI+D6TleYvicA6miaMHeJKT/M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyR/q+g7nvwNZLOT3mhROuLXE5IfTEs8hiQhKxuFxSM=;
 b=Rc+GqYBYnppnbT3k8uS/HFPDGiOmYiIzNuYDQOjz6a8vg49fbQJ3yeKqVIcRrXOe6jcuNv4/BfSELtFjq+JVmAug+t23PIrrWY1ShKkFLbhhrNpHhkcRdzNYIis+McR4Ki16Ku0LUQcoGX6sMbenfri++uwrnhY6sEXJl20JYQquAAj4sTJbEmPl7yM00E75rYnVWncglPVdxYTGIsQOK1nrKkbhXQonLE20zr5sWiHIUVyLtEu3cov+FBb+AmJ2PePFQi2ZS5iY0YLdJfPGadp0qaxtEt8tTO7qijGcomQKmhLbWcmEMBluuOmqV7Q9ULanFqIsmhgY15Z1lCc6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyR/q+g7nvwNZLOT3mhROuLXE5IfTEs8hiQhKxuFxSM=;
 b=J6SsNvYywGc7J2jqhMEnZdfXukmNAyXrDSzy9Pb5dtopPLosr7QcWvtK8KLWzKsFKkdSrzUkBShVWP7aJbqur2sQmyt9zcr9u8f5UY+rV3REGjXhQ+a3Fzzg8VFpIw9kMgwcnYGmhC+KIbTBII+IefJgkm+PtEmlwWruZpGxGPAgb1g3w6R+byNHIC5cPg8B5iwGn5xv2dR20G0NR92LaMqDZ05P999Njq9d53y1cq14FDid0GdLPWjcCgowtDu140DbC2b+886yxyFUqp4P/UH/aoPQgOsGqYvmzVpA5QKgI4NszP0EaXtTf2vzLQj57lpCx0UmU4FHZDT95OWJ8A==
Received: from AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::15)
 by VI0PR10MB8714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 12:37:08 +0000
Received: from AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3715:3406:3bca:ecb4]) by AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3715:3406:3bca:ecb4%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 12:37:08 +0000
From: "Jiang, Yi" <yi.jiang@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH 3/3] rpi4: add building options, remove old kernel and
 Xenomai versions in kas menu.
Thread-Topic: [PATCH 3/3] rpi4: add building options, remove old kernel and
 Xenomai versions in kas menu.
Thread-Index: AQHaq4Wa3aAh5XqfEEqS+BOqfQ5GxbGhxp+AgAFr2YA=
Date: Wed, 22 May 2024 12:37:08 +0000
Message-ID: <a25224be741df1e09945d05a8fca773905ae8843.camel@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
	 <20240521134841.21749-3-yi.jiang@siemens.com>
	 <7a404b5e-77b3-4f95-a088-f4a36e97ce03@siemens.com>
In-Reply-To: <7a404b5e-77b3-4f95-a088-f4a36e97ce03@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6221:EE_|VI0PR10MB8714:EE_
x-ms-office365-filtering-correlation-id: 51a99842-8538-4fbd-61ca-08dc7a5be4ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzJXNlRaYUZSWDk3cUVGNzRmNWZ5amU2czlKemdIcE9kMUtLeHZuTGFTcnov?=
 =?utf-8?B?blFEMlVFVzRqRllRcnIxWVNibk54SGQwOG0yV1VIeFZlWGNCVlJxU2NHaFdk?=
 =?utf-8?B?NlZ3bmZWV2lwRm9lREtPVzhHNEZpLzE3cmJ2YUM0TlpWZ0xheUlYVncraUF0?=
 =?utf-8?B?NVlyNDFHdUxoVG5kM1hnWUZML1NLcHVLUThTUCt0em8rbEx6Uis2QVdPdFdj?=
 =?utf-8?B?K2JvUkhVYlVNSHZPdEh4QXEzbDF6UEswNWdxWkM5UTBKQ0Fvd2hSc3dINlhY?=
 =?utf-8?B?SENWQmUzVThFbXlTeWhiejM0dTRrZStTOXNsdHRBa0V0OXBpclR2WE9RckJL?=
 =?utf-8?B?bnozaWZLWHhlUU00YTFobURadXQxaFEzSGF0RGRmWkFCMkhzb0hwMk9ySG0r?=
 =?utf-8?B?YTNvTXdoWC9LdnNLbVFrUE5RaTUzTmJFUURGOW1qUm9aZUFZU2NlZTFkTlBx?=
 =?utf-8?B?bW40YnF3Q3dXOE9LTGgvRHpueE9JQng4MTlBeWxXQm9raXNHeDUxYWN0MjJY?=
 =?utf-8?B?aERvZ1lHeW9OOWh1bWcxR1ZTelJNYjcxeHN5SnhRMzIwSmx3bkJnOHlOWnlu?=
 =?utf-8?B?ZG5BT0lSY216VmhvZHpKUXhOcG1VMEhWdmJzNUhmeFpwQURxMFM1U1VwNWJE?=
 =?utf-8?B?YXUyWCtremVuNWM2eVRCWGNnK251STJ3S3V0bGZWMWVCK0xjd1Q4bDhSSVdr?=
 =?utf-8?B?bWVTcnptTlhYbndjMjN3RFRlOG4wNG8xdy9xWmpNZ2ltejBBcXZQWDhPT1p1?=
 =?utf-8?B?MXBQcXdDSlNFaWhYVnV6QXZpbmFwcjlielQ2Vk1TTC9sM2Y5YmZhL3MyUkJ1?=
 =?utf-8?B?VWsxRUlsdE5UZmtQbE5nc2pVK0dyamdSbFlrZWpsa2dKODM2RXRGMWlvTURU?=
 =?utf-8?B?VVNGNzlYN1lubWdheURPVjZiV0s2YTdKMEhWZUhoUEhzcnRYYmtZY0piRUpx?=
 =?utf-8?B?ZFczSmF4aGRGQ1hkYU5kN1lBOVdRY1ByeW55VkpZeWZjRkU3Vm5Beit1UWpN?=
 =?utf-8?B?aGViMGRLVzRpM3gxQVU3TGhPZGVQb28wTHZjSHg3emRWdnhoOWlrSHlJUS9j?=
 =?utf-8?B?UEJQRDZJbUU1U0d4NzdZckxrNklJWTFXL1dxa21mbTJJUDZiTmJSVW5acEY0?=
 =?utf-8?B?aksxYmpNVHZ5UGtZd1ZhTTlGaGxtNkcvOHpRUlIva2NjcWZDTkJ2NWNFUXRs?=
 =?utf-8?B?eXVDVDJ6NXdBWkFYTzJleHc4MDFPVlplYklLQVhRa3pqY3ZpaFIwKzdqYTJG?=
 =?utf-8?B?SDU0ajE0akpxVmx1NGtxSjBUSE5oZHNzbWRLOUFzVDh1YVR2QTA4ck16N3VV?=
 =?utf-8?B?eFFmWXkraGYwMUVLRTh4OG5CSHh1YVgvaVlQTG9tcFMrMjFKcStYMG9CNkJY?=
 =?utf-8?B?UlZoQmZXenRPM2U3MFN3VjFsUGVOenFaSjIwUVJsS3Y2M1llb0drMVAzN3BK?=
 =?utf-8?B?Y01hdFNHSHpycGtPSURpNFY0aUh4cjh4RzZJdm5zQmxNNXRXMTM2WmZhK1Rt?=
 =?utf-8?B?ZVg2OHZxbGVoM0FKZlNNcEVjWTBySGdmaWhEd3c1YVcwekxtSDZwdXVXKzBl?=
 =?utf-8?B?ZStINHhtMFZuRklEMk9kSnUwcFFQbzhMQURLMUV5cHpROW9reU5DQ1NlV0pQ?=
 =?utf-8?B?WVJkRmZxaE0zZVVNVlZHS25Obnc5SnpKWVRuMUJTbFhuR1lCeUZOZ2FZck9S?=
 =?utf-8?B?M3EzYlpIb2JsWVZ5N3FpRGMvQWRDU0JpYmxLSkUraGo0bkd1bWwvbmJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T20waWRaalJYTHdORjMrWDdSOElOSUpyRHRnd2NOdld5YVJpNmtuWFRzMFpY?=
 =?utf-8?B?TWRVOXBrZkE5NlBEeUdMcE45a1ZOT1cyNXU1YnlTM1VEd3VDZ01wZGNweXJJ?=
 =?utf-8?B?TWlWRnNzSkNpMGpzWWlSaE1KMlc2Wlc3MkVUUTE1NHJ6NTNYdVBBUENHR1hR?=
 =?utf-8?B?N3FjU040a280bmZ6dDRaNEs5SUpyRWxtQ2tBbnN5M2tpUXlaVnVtYlRER1Mx?=
 =?utf-8?B?eDRHRFJ2M09qSnVJdDI1M3dhZDhPQWp2Z3EyU1RoaEtqVk5hMWVjc1F1U3BS?=
 =?utf-8?B?Vlp2SVdKOHlIalNKUDVaQzZYbExyaHBSY1QrdEJKRHVVT1E2RkY1aTkzYTlx?=
 =?utf-8?B?dFV6U1hPd1k1T2tVTUxKZ0FBMmo4ZmsvdWdIZGhjRVVYczRIa29FRzQ0VFpQ?=
 =?utf-8?B?VGQyWGhxZmtBZUZNdHgwNjRGTXRyTUlLY3JyQyt1L1Q1Uy9sc3FFVjhCYi9Q?=
 =?utf-8?B?MjMwcTJEVTJjZFhUSmZwZ1ZPMCtaT29VNE1XNUluQUx2U25yN2gyMFNiUi92?=
 =?utf-8?B?U1VIZjVMdmY3ZU5pV3huMlN3ZWJjL1NhRE96VW9FdFBtcVJ5eGJXWFRIVk05?=
 =?utf-8?B?K1dlRG8vVFNBdWg0dVpyQUlyQkV3ZXRadXJMMmxHRk1rQVlPa1pHSmc3dDJr?=
 =?utf-8?B?cS9kTFhlYjF5N1B4a25MM2xYSmZaaURzMU5COGUvRnNFb2dIbjkxbXJFZ2Z6?=
 =?utf-8?B?WW1HYkV6UTBrK2dIK1VsWHkzQmNubWRkT0dTS0xzaGt0dGhOc1FLQXhac2Jr?=
 =?utf-8?B?VnRKNktwVUpnNHBVMXl2eEhGb1NoRzJPUEdYcCs4MnBLN1p3MVo3RWpxNTBk?=
 =?utf-8?B?MXM4bWFZand1OHh0bWJlbzMzWGpvbnNpOGYzd29EMEFCLzRzdFJOQ2poS1o3?=
 =?utf-8?B?TXVsaDl2ak5YWWtqZmNieURTQWVNbmg0RUZNSW1VZXh0ZmNlZVlQVlk0RVRl?=
 =?utf-8?B?NUlOOGhVK2RPV25WSzlWUGpiZHBWeHZlbEpzYURydnNmMUNJUktwNkV3VWVk?=
 =?utf-8?B?YTVRYitmV3ZxbXdqSzFHUjY0a3E2ZVNxNHJKd3JOdGszblRobnNiWVhHTTRt?=
 =?utf-8?B?RFkvWlBWYlNwN0JnYzU2OHlXdEhHUDdDVzVLS0hkcmFSdjN2T3ZFNktsSWZY?=
 =?utf-8?B?cnRqRU9rejkyaVRWeXBXaGNDQjBUUC80c1paQnhGVFhVTjM4WlNqdXZMNkc3?=
 =?utf-8?B?NFl6RVlTdHdFZjMwZzdtQzBaYkZjcXhkZ2NmRmt1V0lhcEJoaXRtQWRNUXZU?=
 =?utf-8?B?REZZY2E2NGR3OEZneWdLaTFZcllHRVVvV2NSd0xMY3MwN3kxc0tubVRwRk40?=
 =?utf-8?B?Q0F6TUxRNHBCUEQwYVJOZWRBckxiNVhNRW5KYWFzT295ZWZxSFUrOUtBVm5D?=
 =?utf-8?B?U1IzVm5KeEV3QVpiSWQydlNTa0hFai83S0p1RmJzMlAwSzZEcEgxSStYVzhr?=
 =?utf-8?B?T2N2aEtzRVkza2pkWVRFOWRvb2lRbDdqR1M4bU41aFhIZXNrRkRIb0N4RFR5?=
 =?utf-8?B?Rm5ONlhlUWkreFhqbkREMGFkdTJZVjRpbCtiOTh4V0dmenNJRGxYT3VJSUc3?=
 =?utf-8?B?QmJDbXpHUTlpOFJuZmhqSStZTE9FZVphZEdBTXhSYXNISnd4STIwS2xFb2pj?=
 =?utf-8?B?dm1BSXYxZ2M5cUF0a08wUm1ydHprMWExYmQ0bUZ4NHpNblFoSXpFVE8xK2NW?=
 =?utf-8?B?aEszV1ppS3IyYVpPd1lzWXBiN255RWtXYmtEWjcwTXFtOVVaclhtR0I3Mm9J?=
 =?utf-8?B?S0djMDFYdThaMkkxZERxczBLczdZMlQwSmcrYXV3TkFDOURWUW1yL3lML0Vp?=
 =?utf-8?B?bVNKYXlQQU5Mb2dxUWdJa3laaEFybGYwWTF4UXo5cDRNeFhEbno5TWw3TUJ6?=
 =?utf-8?B?U090NnU1T3BvVjRGa0Q0VTRlK0YyNjdyQnFZbXMwcElvRFRlcDlkN0NIOGN3?=
 =?utf-8?B?aFJrdkVBNFc1YlpIS3VpNlJlbTk3SlVGeXl2bnQzUmRNNUVFVkJOTjZxZmtH?=
 =?utf-8?B?L2RtSE1tQjZCZ2N4b2ZFQmNCSFRzbTd4WDF5MjNMbVowTWtzczJ3cjRqV2cx?=
 =?utf-8?B?WE9UN0hCVkRlNGV1NE9XMjVLbjdDcytsWFpWdGJPQjZPK3M3YTlpM2tGZkg5?=
 =?utf-8?B?VkZQVzFsS0pmaFQzTWVxd3M5Wm1vSUMreXJGUHpacFJBRVlnbm1mWEN3bmVa?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704768F0560B41448DF6D05707B9DC1C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a99842-8538-4fbd-61ca-08dc7a5be4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:37:08.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjOzQ4gL5lRcmtRCNd/sr84yk7Zgy8riDc/MS7RBARsIPAR7MIo3ihP1hJ5ipUi7gKTqlzbg8fG4iwAUKGIkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8714

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDE2OjU0ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMS4wNS4yNCAxNTo0OCwgWWkgSmlhbmcgd3JvdGU6DQo+ID4gVGhlIGZvbGxvd2luZyBrZXJu
ZWwgdmVyc2lvbnMgYXJlIHJlbW92ZWQgZnJvbSBrYXMgbWVudToNCj4gPiANCj4gPiDCoC0gWGVu
b21haSAzLCBIZWFkIG9mIHN0YWJsZS92My4xLnggYnJhbmNoLg0KPiA+IA0KPiA+IFRoZSBmb2xs
b3dpbmcgWGVub21haSB2ZXJzaW9ucyBhcmUgcmVtb3ZlZCBmcm9tIGthcyBtZW51Og0KPiA+IA0K
PiA+IMKgLSBYZW5vbWFpIDMsIExhdGVzdCA0LjE5LWNpcCBJLXBpcGUgcmVsZWFzZTsNCj4gPiDC
oC0gWGVub21haSAzLCBIZWFkIG9mIDQuMTktY2lwIEktcGlwZSBicmFuY2g7DQo+ID4gwqAtIFhl
bm9tYWkgMywgTGF0ZXN0IDUuNCBJLXBpcGUgcmVsZWFzZTsNCj4gPiDCoC0gWGVub21haSAzLCBI
ZWFkIG9mIDUuNCBJLXBpcGUgYnJhbmNoLg0KPiANCj4gVGhpcyBtZXNzYWdlIGlzIGNvbmZ1c2lu
Zy4gSXQgcmVhZHMgbGlrZSB0aG9zZSBjb25maWd1cmF0aW9ucyBhcmUNCj4gcmVtb3ZlZCBpbiBn
ZW5lcmFsLiBCdXQgd2hhdCB5b3UgYXJlIHJhdGhlciBkb2luZyBpcyB0byBwcmV2ZW50IHRoYXQN
Cj4gdW5zdXBwb3J0ZWQgY29tYmluYXRpb25zIGNhbiBiZSBzZWxlY3RlZCBpbiB0aGUgbWVudS4g
UGxlYXNlIHJld29yZC4NCj4gDQo+IEphbg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJ
IHdpbGwgaW1wcm92ZSB0aGUgd29yZGluZyBpbiB0aGUgbmV4dA0KdmVyc2lvbiBvZiB0aGUgcGF0
Y2guDQoNCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWkgSmlhbmcgPHlpLmppYW5nQHNp
ZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgS2NvbmZpZyB8IDE0ICsrKysrKysrKystLS0tDQo+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvS2NvbmZpZyBiL0tjb25maWcNCj4gPiBpbmRleCA2NjllYTY1
Li4xMzY5OWJmIDEwMDY0NA0KPiA+IC0tLSBhL0tjb25maWcNCj4gPiArKysgYi9LY29uZmlnDQo+
ID4gQEAgLTQ1LDYgKzQ1LDEwIEBAIGNvbmZpZyBUQVJHRVRfSElLRVkNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgYm9vbCAiTGVNYWtlciBIaUtleSINCj4gPiDCoMKgwqDCoMKgwqDCoMKgc2VsZWN0IEFS
Q0hfQVJNNjQNCj4gPiDCoA0KPiA+ICtjb25maWcgVEFSR0VUX1JQSTQNCj4gPiArwqDCoMKgwqDC
oMKgwqBib29sICJSYXNwYmVycnkgUGkgNCINCj4gPiArwqDCoMKgwqDCoMKgwqBzZWxlY3QgQVJD
SF9BUk02NA0KPiA+ICsNCj4gPiDCoGVuZGNob2ljZQ0KPiA+IMKgDQo+ID4gwqBjb25maWcgS0FT
X0lOQ0xVREVfVEFSR0VUDQo+ID4gQEAgLTU1LDYgKzU5LDcgQEAgY29uZmlnIEtBU19JTkNMVURF
X1RBUkdFVA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBkZWZhdWx0ICJib2FyZC1iZWFnbGUtYm9uZS1i
bGFjay55bWwiIGlmIFRBUkdFVF9CQkINCj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdCAiYm9h
cmQtcWVtdS1hcm02NC55bWwiIGlmIFRBUkdFVF9RRU1VX0FSTTY0DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoGRlZmF1bHQgImJvYXJkLWhpa2V5LnltbCIgaWYgVEFSR0VUX0hJS0VZDQo+ID4gK8KgwqDC
oMKgwqDCoMKgZGVmYXVsdCAiYm9hcmQtcnBpNC55bWwiIGlmIFRBUkdFVF9SUEk0DQo+ID4gwqAN
Cj4gPiDCoGNob2ljZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBwcm9tcHQgIlhlbm9tYWkgdmVyc2lv
biINCj4gPiBAQCAtODUsNiArOTAsNyBAQCBjb25maWcgWEVOT01BSV8zXzINCj4gPiDCoA0KPiA+
IMKgY29uZmlnIFhFTk9NQUlfM18xX0xBVEVTVA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBib29sICJI
ZWFkIG9mIHN0YWJsZS92My4xLnggYnJhbmNoIg0KPiA+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMg
b24gIVRBUkdFVF9SUEk0DQo+ID4gwqANCj4gPiDCoGNvbmZpZyBYRU5PTUFJXzNfMF9MQVRFU1QN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCAiSGVhZCBvZiBzdGFibGUvdjMuMC54IGJyYW5jaCIN
Cj4gPiBAQCAtMTQxLDE5ICsxNDcsMTkgQEAgY29uZmlnIEtFUk5FTF81XzEwDQo+ID4gwqANCj4g
PiDCoGNvbmZpZyBLRVJORUxfNV80X0xBVEVTVA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBib29sICJI
ZWFkIG9mIDUuNCBJLXBpcGUgYnJhbmNoIg0KPiA+IC3CoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24g
WEVOT01BSV8zXzJfTEFURVNUIHx8IFhFTk9NQUlfM18yIHx8DQo+ID4gWEVOT01BSV8zXzFfTEFU
RVNUIHx8IFhFTk9NQUlfM18xDQo+ID4gK8KgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiAhVEFSR0VU
X1JQSTQgJiYgKFhFTk9NQUlfM18yX0xBVEVTVCB8fA0KPiA+IFhFTk9NQUlfM18yIHx8IFhFTk9N
QUlfM18xX0xBVEVTVCB8fCBYRU5PTUFJXzNfMSkNCj4gPiDCoA0KPiA+IMKgY29uZmlnIEtFUk5F
TF81XzQNCj4gPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCAiTGF0ZXN0IDUuNCBJLXBpcGUgcmVsZWFz
ZSINCj4gPiAtwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIFhFTk9NQUlfM18yX0xBVEVTVCB8fCBY
RU5PTUFJXzNfMiB8fA0KPiA+IFhFTk9NQUlfM18xX0xBVEVTVCB8fCBYRU5PTUFJXzNfMQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gIVRBUkdFVF9SUEk0ICYmIChYRU5PTUFJXzNfMl9M
QVRFU1QgfHwNCj4gPiBYRU5PTUFJXzNfMiB8fCBYRU5PTUFJXzNfMV9MQVRFU1QgfHwgWEVOT01B
SV8zXzEpDQo+ID4gwqANCj4gPiDCoGNvbmZpZyBLRVJORUxfNF8xOV9MQVRFU1QNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgYm9vbCAiSGVhZCBvZiA0LjE5LWNpcCBJLXBpcGUgYnJhbmNoIg0KPiA+IC3C
oMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gWEVOT01BSV8zXzJfTEFURVNUIHx8IFhFTk9NQUlfM18y
IHx8DQo+ID4gWEVOT01BSV8zXzFfTEFURVNUIHx8IFhFTk9NQUlfM18xDQo+ID4gK8KgwqDCoMKg
wqDCoMKgZGVwZW5kcyBvbiAhVEFSR0VUX1JQSTQgJiYgKFhFTk9NQUlfM18yX0xBVEVTVCB8fA0K
PiA+IFhFTk9NQUlfM18yIHx8IFhFTk9NQUlfM18xX0xBVEVTVCB8fCBYRU5PTUFJXzNfMSkNCj4g
PiDCoA0KPiA+IMKgY29uZmlnIEtFUk5FTF80XzE5DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGJvb2wg
IkxhdGVzdCA0LjE5LWNpcCBJLXBpcGUgcmVsZWFzZSINCj4gPiAtwqDCoMKgwqDCoMKgwqBkZXBl
bmRzIG9uIFhFTk9NQUlfM18yX0xBVEVTVCB8fCBYRU5PTUFJXzNfMiB8fA0KPiA+IFhFTk9NQUlf
M18xX0xBVEVTVCB8fCBYRU5PTUFJXzNfMQ0KPiA+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24g
IVRBUkdFVF9SUEk0ICYmIChYRU5PTUFJXzNfMl9MQVRFU1QgfHwNCj4gPiBYRU5PTUFJXzNfMiB8
fCBYRU5PTUFJXzNfMV9MQVRFU1QgfHwgWEVOT01BSV8zXzEpDQo+ID4gwqANCj4gPiDCoGNvbmZp
ZyBLRVJORUxfNF80X0xBVEVTVA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBib29sICJIZWFkIG9mIDQu
NC1jaXAgSS1waXBlIGJyYW5jaCINCj4gDQoNCi0tIA0KWWkgSmlhbmcNClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K
