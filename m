Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F11F936
	for <xenomai@lists.linux.dev>; Fri, 31 Oct 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922755; cv=fail; b=VHYZYoE1uQe/HwdHEsTrk/7jmJH0nzOQrg5He/KzF4CG6UU5RIqewqxZCAZ9oF8Z0LCmMx4OMk5aeCfKwVYXF8GZIlZQZ4oBRP/i+cfIGsY22kHd+snc/V8yqFdy6JG7r7azET7BXM/yD8tHNyfEbx8f5jc572FpX93QXtYFzpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922755; c=relaxed/simple;
	bh=R3dXCSYfgEtzq/DN8pQFXm8Faqh6qRdX5aw+Kh3Vk7U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8tbhm95xOc3ohSFGsvSvmYjcuAXCZkX8RTe/YFP6Cy30FKBnYtRLNS68oc8FSehLorz25W47Mwx1mOmML0LNgqv3kx0TFY4MfdhErp6BodI1HDfbDqwMT2dYHAJacaDOzhjBF5gsiQDeJSfpWDYXA3X0e8WpsCfvp/hfTcK20U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qetBkrgK; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qetBkrgK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX/luemFyb31XwNJBGAtC94G6FN+B8Ke7v7hcaeVAdILat8kf03Ex6nL6lHuPpCLggoD8knf8x+QGXdzGRTl7MPWw5xrL4yAuUUZg2/33dBJoejMA5DeA4VPYYCRd954bGSgy7m92ABSb4mrCL0xuFDJheXj5XsGZm/Q3qQVc63MMK5z/GJTXpNoTniCjDAy/eYOE5a787YYTUku3WESIek6YBX2PztVYB31JSBVC6DYhIorrqb41LKU8EcIxwj+MBIjAtoy4+CoqIDPxLB5tkg/dnhUPVkVIvOntDM92YoZH+UmWH+xhHbAnUaitSeS4WVs9mJHItw5BX4w+egu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ybLDSoyiQ3y/AtyFt4L2FkbJDByzT3sFJHYvmhaClI=;
 b=cq/oKG085fLDO9C9ENi5fxE7hg+sIyBo1xlrKOP15n6e7MArpqhnFGUuip67SlF/7zov9Mddff4dPgJ3+dMh7cfG2IZixSNuME91f8JZDdCnk524dV+m2YFoC20iCf2gs430UmLT93UzwkSqA0IoAV/rBJBtyxZLMX0XDuodL56qafYOSV+ymiCOWDkfHvo91VavahT+l/5huWJPlWh4ZswlQjAQmUluS7e6h80+xLPSXqU7z9f+DbjkJYFkWKO9lE4MGYr7PY+0CNu29sZaLjJrRPaVDVag/WDCHTxZ/wdhJ+UEnRZkVSSpb4V02XQlVlGZzV5yIXUbRK4jV1iCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ybLDSoyiQ3y/AtyFt4L2FkbJDByzT3sFJHYvmhaClI=;
 b=qetBkrgKDaQM7fpxy5JGmacf93fxRA6q4GQsj2tSe3K7AyAUkQeXPku3HlvNB/cIqHt0IkpTlVooBv47LKUGmzUeqCqK2vtQzq06zHancmFxb1lnVf6TgRvB2fbopwlrJ403aMS7fdrIi6wv13cBI5df315RK3P8flHOz7+hGJGdMidkzSbwY3TSfr6DsN0GfGUNgR2aP/jFLWXBkQo3qUqT0drmGnVOb7ieCI/losAS9nfJrgJOd+QlNMenKD8nOLJbu62qggKqieiMQMcK1jJf90ajdgOFFFCxfTp/6261oNVocJhMWZuv4K00M3rdingj7yGTKO8ahlCuVVcwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:59:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:59:08 +0000
Message-ID: <dd275af8-fbb2-4e92-ad3c-a3e4712480eb@siemens.com>
Date: Fri, 31 Oct 2025 15:59:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] docs(xeno3): improve doxygen build
To: m.kurz92@gmail.com, xenomai@lists.linux.dev
References: <20251030155329.1337840-1-m.kurz92@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251030155329.1337840-1-m.kurz92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 948c30f7-a655-4081-e2ff-08de188e0b19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1pwTnBicHV0RU9Nb2VIL0JjVGNqUzZMMUE2cCtTY0RVMkxlNEVLRy9SOHJO?=
 =?utf-8?B?UzBqbGlFUFBPdG4wVy9PVFBoREFGd1NhbGhkM0xEL3d4M2cwMlJUMnZnNXlm?=
 =?utf-8?B?aFVkSURicWQ1L0FpUkZBSVRmSVZsRjVhTWxOMDIzS3BlWldpaFRPVmRsYUJJ?=
 =?utf-8?B?M05kYkd1czdmQjh5K2xBb08vQi9lV3owcnRTR2kxVzZPZWxYcDFnQUY3a2w0?=
 =?utf-8?B?OXBUdlRmeTBNdmtMbmUzWmFLVzlEZGpkYU5GdWQ4RjQrbFVkbnRBTC9MdjQw?=
 =?utf-8?B?eDhqSEllYmpzdUtDemRWRTlxTVdFL2dSQ0xRYnNZR0RMVkR0REx1UmZNUVFv?=
 =?utf-8?B?eHBsSmNZd3F2UlIrQ3FhV2swYVdEdDBiZnpEQkloTUM5bWdrVTArSDZlSmtF?=
 =?utf-8?B?dE9UWkJJRVhoeWNIUElNWUhkeWljQmxHb05HL0pFaGNJOVNBalBjeTNkWnBJ?=
 =?utf-8?B?UVN4TXB1TTlMclF0VnB0ZUpjdDhNdWRTTU4wVkNqcFplVWI2U09zaXkyWXMz?=
 =?utf-8?B?MHdXTXY0dG13WDdycDNFdlFoWi9lZ25MaVZicHc2Rmp3YkVGVDZFV1dUL2RE?=
 =?utf-8?B?ZksxZHBzVGZMWWVYV3p1cHk1bDV6dEhkbVpGQ0tyZThUTU1rbXNQL1p2VjY4?=
 =?utf-8?B?MDFPNzhLdEF6Z0d6bDJlSEx1N2psNEVodmpiekZVUFF0bW5LY2pMa2U5NDN4?=
 =?utf-8?B?ZU5WdGdPaWlrNDJ0Z1d5S0VJZTRXdy91ZEZqbEtEYmsrR1pFUm14R2UwbXFE?=
 =?utf-8?B?QmY0ZlNVazhVSURyWkJLekVCbEJqcTVQWlZWUXg4R1ZOVGNBRjZoNHZPclNQ?=
 =?utf-8?B?cXZnMEcwc1VOZzhMRytxTXpJdlBwVmJBWWJBU3hiMGl3aEV4Z1Z3NlZ4Wjh2?=
 =?utf-8?B?Y08wdTR5MjFpanRQR1hFUGp5cEo3WW43LytTYjNDVHVSOG94cTRpZkowMldQ?=
 =?utf-8?B?ODBXRy8xTGdrWk1ZTGFtQ2xEU1lIMzhRTXJFVWEvMzdjVXJ5QVZHaFNsU216?=
 =?utf-8?B?Qk00SG9zWEtyV0V5elBHN2N5bmhySis1WmJpRWpraUNYRzZ2Qm96TXhURUdv?=
 =?utf-8?B?R21jUlNTcVA2NU5mVUlDV0RDUUQwT0o4RFpxR0gyRTJNekdkNzcwYURTcWZr?=
 =?utf-8?B?dCtMMGtkdEU2c28wVUJpbm1xeHZxVGQ0cGs1dTB3L2ZJT090UkhSSGR2UE1J?=
 =?utf-8?B?VDhTMjNOWHd6WlpwVEt4bGZlRG40QXhYckpVTjc1K0tjTlZweFF0bWs0Q211?=
 =?utf-8?B?dUVybHVzbmJKZXR3QTFIeGhjeS9TTXcvVjVxTkYrN0RIaitqbDhrcXpBTlV2?=
 =?utf-8?B?RWJ5ZTZtWklYeFA1ZWxuRk03VGRRTlRvaUZGb1JuQU5rS0Zxd1Y5VWFJZit4?=
 =?utf-8?B?UGNqR3YwbXpMTWRVWlhpN0dWaGp2a0ZtQTNoS1l3MkREWlhSWVpxeFkxSXVW?=
 =?utf-8?B?QVFSeWRSVTdYb1RBWXVENFZ1SEtOejZwMFZtTDVCMm9jUXpmRGNZQ0FVODJL?=
 =?utf-8?B?TWx1bGJscWtNVEhzOXphVVBsVm9FTE5LSmM5MDVhcEF4YzlsU3BtY2o0cDhU?=
 =?utf-8?B?VDNZWWorRVA0NFpmZktIc1BQOHNRM0E2dEdVNHhPYjBnbTJkSldQM1dGUFph?=
 =?utf-8?B?bjZLMnNNZVJkY3VPUzZMQWhYZUl2NG1nSVZNWS81a0hZMzd0cVRnakc3L2ta?=
 =?utf-8?B?eG1oWlhmd2pNbTFWTTRMYnRxMXBTbk81azFPTWxBeE8xS1RUQ0J3QTV2UnJP?=
 =?utf-8?B?V1lLYm5vcDhPR3lmRWViNnJubnpSZy9aOU4wWEF3NEk5UmVlQThRVnMxamkx?=
 =?utf-8?B?WDFCWXk4SmptamV6M1lSMmd3LzBWdjZPaThscHF2NVlzTlUzMXorbEZRUDcw?=
 =?utf-8?B?WmdPa0RlUW01a28rdE4yQ3IyRXA0UC9mYmhTYi93alZUaGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FwTFQrRWRzU05rVkFFYjQzTzNHckVITWpIVDNtdEFKQVJCcGhJRHN6bzJv?=
 =?utf-8?B?STVOZDcrZGNqRHJpSXdqbEVwRVdZRUNteFFESjZaMEF4a0JrOU5OZ3lGd3Bp?=
 =?utf-8?B?Y0VoTHU5NkJ1Nm1XNmZBWHo2WmJlRnRXa2VBNHh0cytYanVKOXNRcG5nVGtG?=
 =?utf-8?B?aEFobWZnMXVhUlFBWmxtaUhKU1JxZUNUc1YxYlpjb3F0YU16bnhrWlVNNE5V?=
 =?utf-8?B?VmlmUXlOSGRsTW9yc3oyOEt3VXpOcmo3ZkE3WnhicXZUbFJ2S2dGMG5OOEUx?=
 =?utf-8?B?aHpuRWJTNS8vQkE5R1pZNFF1Y3dGWEJVYWZFbEVhTHkxVE1IQlRIYjlWWkY5?=
 =?utf-8?B?Q0VtNVp0UDQ2V2hiMldETjF4dDZuTUx6N1dZVSt0RDJJelZOQlprV05zc3E4?=
 =?utf-8?B?OUxndkJtQktxTFNNbjFtUkdJblM2cUJPV2pyUXJtcElYajA4THMwVHJ4V3F1?=
 =?utf-8?B?c2doOEhXZXpEdDk3MVFzWHJ0UjBhYlZBS1JocHlEL25TTm9kL0lyUUVpWEIx?=
 =?utf-8?B?UVFBYzg1eURIVzFWUUdYbGo2TE52bnZTdGRWMFFEdmdWNmxDUllCbmhJcnNi?=
 =?utf-8?B?WVRLNGs3S2VCOXZUWTlKWTF3S1BWeGxpM0tVSkxLSWNWQk91M3MvdENxTjdZ?=
 =?utf-8?B?OWFmbDA2bXltSTA1WTQ4MnFEUnhVTzNwdWlEU09CaXJwVkNuS21IbkV0c3dt?=
 =?utf-8?B?UWFoR0VKNDR2V2JRVkxiYzVXb3BWOEdrNHVudGt0OTZEOVJSWk15Ty9IRlBU?=
 =?utf-8?B?Zlk4QWtBYnZCcVVPVFR1T0xHNGFSUjJ1S29mUVJBV1JvdVdqUU9Xb05DamN4?=
 =?utf-8?B?cFRjeld3VVRPSTFMWk5IZDBHVWJ1aS9HY2JyU1dlcHhsazRnZkZtVzBub1FB?=
 =?utf-8?B?UlRaQUlkWFNWcVZWMGFCZ3g2MERoSExMUFB2dEt3YlUyREpTTG1Sd1hNb0No?=
 =?utf-8?B?c1VYTWJjcitDUWVwTkF5WHJVc2ZtYmdMaldrSm9tK0RQc0dlSEQ4cEF2dXRC?=
 =?utf-8?B?Y3ZLWElxRmdQMWNna0NkbHFOeUJocS9qbXkrN3J2czJGdWE5RU9WZkxEV1NJ?=
 =?utf-8?B?ZXBOd0FQKzhoSUNTcS9qWGtrbUlpSVlTZkl4Y2srS0NxV054M2ZJQkpXdzk0?=
 =?utf-8?B?WHZCNjlHUFNNeWE4aEdHdUFIR0kwT2ZwSkdZSm1MMlhWNERnaGM5R1RMTXZE?=
 =?utf-8?B?WnJxTVVLYnloL25WNWtjTk90UnFIZFNBMllIVHZoUTJxMzZBdi92dUZhalh6?=
 =?utf-8?B?WU0wUTVVRHZjWFNxdk0vWXBqNHVPZGdwQzdiM3RIWitPeGxBbXJUb1FZV3N5?=
 =?utf-8?B?MnNTTFNKNTlDdVhRbFJ5VUZCS3BwcUdXWXJaemdaLzk0dytQaStsTkswMlln?=
 =?utf-8?B?VFEveUxzQXZPSE1kajZ0L2N3M2gvL0RCbDU5YWhFV2YvQlFZOFhEeDJ2Zi9U?=
 =?utf-8?B?OUVGRE9vZitlM21rUWR5dUg2REROZDR1eVJyeFpUcjAvZGhIY0lKcjVXMG1m?=
 =?utf-8?B?aGh6b0gxYUN3Sk8wL0s3VXcreDFLdDBlczRYaUM5NFZHN2dJd2Uzd1h4Wkxr?=
 =?utf-8?B?d0JWem1zM0FyUkJJQjNVVE13amYrUWQwWU5SUkZ0REVlMUNuUm1rWE0vOEV5?=
 =?utf-8?B?Ui9VOFNOcG4zN2phbHhzNnNSNVV6VVFWeWc2cGEweHZGMmJvQ1B4ZFZTeTVm?=
 =?utf-8?B?NXhFaytuenpJTlRWR09ZSUhDMGE1MWJmS3k0OXNqNGZtSThoVDVKcEVGcit1?=
 =?utf-8?B?NzBFV2sxamJTbWowNERjVzk2WXluQVd4WE1kWmc2NWRsZXFQQ0dmcFBQcitj?=
 =?utf-8?B?cUVEbjNTRklzbEk1cWdzU2owQnF5UDV5QkJVY21xSWQ4WVp5RWxsMTJzQzdD?=
 =?utf-8?B?SE11NUxXYTRCVDlTY0ZIdUd6NkNHeXN5NjA1WUNHaENtaVJtS2NRZmpSQkdn?=
 =?utf-8?B?ZEZ2TFZJN0QybjE5bVVIdjJFbHRWRnN0NEtndFVoYnVaRjZvSGswNnZVV2VF?=
 =?utf-8?B?dVRRTVdMQXAxR2tQSm1aY1dFY29PNmZCTmxBVzVtMkRVUlllcVJ2cEUvR2Fr?=
 =?utf-8?B?RkJqT3d6V2IvazhHejV2ZXZtQm9ZMUpSS2w5RkswS2s4Wlh1d1JrOXdXejQr?=
 =?utf-8?B?Z25SYUVVNjZubUlZNG1vZURFSnIvOE9XNXNjVE95SHdaVmkyMXYrRmdSUzNa?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948c30f7-a655-4081-e2ff-08de188e0b19
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:59:08.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVi8IKrPplxPWR0qmMAWFk95x7/hp6qjiJhftMFVeWzSxPuUSlTPHB7pO7GEReDTZkpovlcN0rm/WGwe7Vnbhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6720

On 30.10.25 16:53, m.kurz92@gmail.com wrote:
> From: Markus Kurz <m.kurz92@gmail.com>
> 
> 
> I adjusted the size of the search bar in the API documentation of
> xenomai 3 and also removed some obsolete configuration variables from
> the doxygen config files. Furthermore, I corrected to the correct paper
> type config.
> 
> I tested it using a fork of xenomai and xenomai-docs and deployed the
> static website to have a similar outcome to how it will be used.
> 
> The website with the applied patches can be seen here:
> https://xenomai-doc-ac7b99.gitlab.io/v3/html/xeno3prm/index.html
> 
> Markus Kurz (2):
>   docs(xeno3): adjust the size of the search bar
>   docs(xeno3): fix warnings in doxygen build
> 
>  doc/doxygen/search-style.css        | 25 +++++++++++++++++++++++++
>  doc/doxygen/xeno3prm-common.conf.in | 22 ----------------------
>  doc/doxygen/xeno3prm-html.conf.in   | 22 +++++++++++++---------
>  doc/doxygen/xeno3prm-latex.conf.in  | 10 ++++++----
>  4 files changed, 44 insertions(+), 35 deletions(-)
>  create mode 100644 doc/doxygen/search-style.css
> 
> 

Thanks, both applied. The outcome can currently be found in a new doc
staging area:

https://xenomai-doc-6176f5.gitlab.io/next/v3/html/xeno3prm/

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
