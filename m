Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7225522B
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266299; cv=fail; b=l2N1gsfh+YPowjTZ/FbUxtwveZtr/Smq0byKL2vSLE2CytS/uot+j3feaShNAza60DuPYoZlGFDfA2N+0X9B/AE3Y8ItQgs9Aduet8MLUH/Vv44eIvzuYaYEBYYdMcpmWJ3u7UUEP8F3uGdQFe9eAYkv9KOQ0yNj5hy66CfRFOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266299; c=relaxed/simple;
	bh=/uWGX3bTGA1SrKD4paght6UvS1ZDtkRfglRki3cbFkY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n8CR+Xikea35GFGYiCwaQyL/cv4T34Kn047XxyM+yoWHSY5HUMGWUi+UT4zNgo4ht0HM2tkGyUpiu5vicyA7KJ22ACxGfdHB6yLEe23yEprOJlX6RdoyeAYBLFiriorpDIv5pO6OppmqCLWtOrxUzFTzQNYmFlACXi2fMElhM6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vJ6Ir0Eo; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vJ6Ir0Eo"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 293C543AD3
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 07:18:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8494D740047;
	Fri, 19 Sep 2025 07:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irVekyThGhmnGZDN6EuEsqe8a8fR2wrSAA1gVVYGGnurz6JII92ByxD9Lshave6bw0w0Tzb9edIQtLE+tiR844KBD/Zs8Tw10lOm/W2FMlm9j+NM1JmSSwwi0X7m3NkyeSfqousG59tf92CWqJT6+g/1YrTRG3wPgDU9FAw0xve7NJxrKvYXz/3wtdgrM6fSxyMI6SAcTb4yHSSPYXeWJALnlc11Kih0FOWKqMdFqvojLX5PMCL4dAmyHT7AxZKsZYg6FxCH7IgRThyWBC7mRKF/DRbMotfCcM5umTTS/ojCUwYcmgPiCAPjTAJTpKqYo2/6+U2ej/5KHN71YyxlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7dq0QeMQGIbftWNsGhL8/guIBsE6oiUrAC2+DQ5I08=;
 b=mDCrWl/XLXNecSQl8lwhrzlMCho+O1q0V3dbqpuclRCCcghSRFA1j7ycm6TocOP0i5a/lkyoYJIWCWgngixDkDwtBoi+X+pN0GDYnvR46ELcHT5VjdeG2HRNll+twQ8vBxJWwWdZKfVyQ84Hz9eLV3beMoAYq0JcCD5vZONXxxNf3I6MbVt4l9aTmrx1sU1U2nZsqZN/Tv/k6/wprcoX6eVY/pBJSgMKnH/Qr3jp24VxSNVHJB2JEL9dLvVwz3jCki27znq+QP1Dev7iYDw7CG85hvfTkQmaZtt6ozrLJB63iDeyDVqSZ78yHI9xVmOBpp9rqM9IiEiuMrpBUrOfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7dq0QeMQGIbftWNsGhL8/guIBsE6oiUrAC2+DQ5I08=;
 b=vJ6Ir0EoMekM6IW9Kky9qpynO3FFrko1Xgnvjz4jRQtLdBCbmqRXhGNvwpeGw3Cpmd3Gw35mNUohBOcuwBa/IjrVBF2iVaiuGucg59k+2I0VIUEvvCIhkpCPTcdprH3vQh6yGDURO8FzLPJpQyNOTLegBZrxAc35Pu/8p5FSoiwhhvpV6RtMYonm4ifaDY9hnMK74DQSY8brRKwp2svzH3F/YDbgeqKyeRbgRF2NXivYcoFdJLy2desBYNgp6ruXgGwdGPCfKT6xoS7Mezr99sOVFcOj4NqaG1fYU+ngJ8E19/NgRyPvMZ0L73fNREFz9nHdMYb0Sunyt5HKfQ4GFQ==
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by DU4PR10MB8711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 07:18:10 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:18:10 +0000
Message-ID: <d2758514-a501-4889-b2ab-023e0fca1982@siemens.com>
Date: Fri, 19 Sep 2025 09:18:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|DU4PR10MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: a4896b1c-bf15-4d0f-3f69-08ddf74cafd1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHAzVjR2R2wzdTNRMEdCaTNxS004eXJxeVdCNnN2MGRta3MrdVNFYlJwRkVm?=
 =?utf-8?B?a1YwT0t0MzRmL3VkeElyRkR5YTJRUGxRblFWdHh0eDRka1RSdEo3ZzhaMyt0?=
 =?utf-8?B?dTFKajR5VmdtVFpSeDJnbGkrSzhyMG91WTJQcWlRK1kvQzROMDRZbGkzWFZa?=
 =?utf-8?B?NGNmZEtJZXlsVzdnUC96OW5sYy9xdGtFMk5pL1h5ZHJlb0MxQkV5R0xXWUlk?=
 =?utf-8?B?S1J4bWFneGt0ekVjeG9tdWtCVG4vOUdkYVBidVNlb0s5Z3ZFV216Z1NYZ3Fq?=
 =?utf-8?B?M0NJNkRSUTV1TzJYTUpZaU9xN3JzMW8xSVI4eEhUa09hQVBFRVY5L2VvYmJW?=
 =?utf-8?B?L3MrRnZOdnYxSDdHNnR5akNBVmhkV2kwcHY5T1cwUDdQa01sUnd0UHMvM3FS?=
 =?utf-8?B?MjJWWG85QzQ0SDB6MGhoNGltOERUWnc2ckFpakRWYytwNGluZUFoTkFsWGhu?=
 =?utf-8?B?S2hZanZ3Q0tjTUJuNlBaYXhJaUIwNGtYWDM4TXhXRmNZTk0ybENmUzNtSnVZ?=
 =?utf-8?B?THJKN0NjZlpSY3VlaFJjaHhHdlBvdWNFRlJ5eUFudWR6QnNrVW1PbzhTZHh3?=
 =?utf-8?B?WkM3dWJXUWwxbUI5c0Jtd1drb2RXNTJrd0lkS3pjOTdUUFk2bkJ5ZElnUmMx?=
 =?utf-8?B?clFJUmxJdUFzbjBka0ZWb3lhS042Z0w1Wml5SUU1OXRoWmZCV1JhSFh1VDFK?=
 =?utf-8?B?ZHFHaGZhUUNRYXF1RG5wWjV5M1Y1UGoxeVNDOWtieFZybFcrK3d3ZHg4OW1L?=
 =?utf-8?B?dWw2LzB2ZlBTV2pQa1k1Wk9tNFlJNlJHQjlNaWZBeHpqcUxST3FVR21lRlZP?=
 =?utf-8?B?MklJQ2ZaT0MvWGhMODg4SXZzQStSbjlpOWJKODhxTkNtcWxsaC80QzZyaFNX?=
 =?utf-8?B?MWNsNTFyQmFhUS91WVBzQ0xsU1dNS2dsamFKcEVNODMyVDJYeDFLeXVGZ1oy?=
 =?utf-8?B?b1lwdWhHTFNFeERrbGpRdjdIQ0pjdzc5WlNJTDErUUZ5cGxXbjdnaWhVODBr?=
 =?utf-8?B?WmRpY04wMnJXeU1JcDl2Mi9ZODZDRGdWVkVvNFRrU1ovTUdDVUtxSDZzQ01y?=
 =?utf-8?B?K0J5NFlWN3BkQW5EbC9hSit5MHJpVWduZVNVaUo4bmtRZjBYdlRQc0lyRWNI?=
 =?utf-8?B?RkhlSDg1dmRMQzJMem9DQXZueHBVUE51N2hhSG15Wm12U1ZWbzJhYTMrN29Z?=
 =?utf-8?B?TU9MaHgvSGxLdkg2ejdOL3FjZE1PSDAvTTJHbm5EN1hMOGl1WHI2N1MyYlE5?=
 =?utf-8?B?Z0hrVXBwMlROMkNqU05WWVhCYW1jbDBzT1plSmhlbkNKdWtxWGJYa09zMUFp?=
 =?utf-8?B?aHpDNzRPZ3VhUktjTG96dmZUL0RSNFlKZXJUYkpPYmZ3NHErT0FMSnFJU1dJ?=
 =?utf-8?B?MnJUeFBnVHFOL2NScnErYXd0U0hhODEwRzZ3eUVzWENGZTdVK0NNMHd5MndS?=
 =?utf-8?B?UnprcEFzblYxRTRiWkZneHdjb1NmeHlzNEpNV3JLcGtJWUxoSzdWeFJ6VW9s?=
 =?utf-8?B?NHcrVkFKL2lZcmRJN0VFakcwU0puRXF1ZlRWbERkNXg0QmEzZTlRK1pHRnZu?=
 =?utf-8?B?RzR3dHl2K0Q4bC9qeW9SK2s0ZFdTd3ZFZ0ZMdFptZytYaHFRZGxxRHJUb21R?=
 =?utf-8?B?clZRM1VtTjY0d2pvMFQreHU2Vi9HZ0REMXdnUm1NRUkyUUZTUXh5Z1VoOEdq?=
 =?utf-8?B?SnBjMU8vL1FtUSsyUGlrc29UTGFHU0ozVWZ5Y3M5UFRNTUNhSVA1R3pBUy9i?=
 =?utf-8?B?ZHZ1S3JYK3p3ZDg1S3pka0Uya3BOWmUrY2NyUWJaeDZrelZ3WTNtWitXT2wy?=
 =?utf-8?B?UTVPcEtqWEd5OVJNTFFYNE03SU9oL2VPcTF1WUsxVTVLRmt0b29GeFhDdUFS?=
 =?utf-8?B?WGFJSUNZaTVkMnlURGRKN2VIbW5CRXMyVVhvbGhLMTdja2txR0ZqYTRpQ09R?=
 =?utf-8?Q?gZsFemmiUGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9FS0JWTWQyWUpsRGswRU55Vis1cFdnMlFWaWZWRmtTMGhSUUFaT3d4WnVk?=
 =?utf-8?B?Z1R6b2dvWCtPanhzaXFiY1VKbVBFZ1gzOTJnSkk4MFB4Q1BPR04xNTZsM3VW?=
 =?utf-8?B?NDlQUHl6RUl4eXVVK24vbFlhNk91eUlObzA4UjVVZWI0N3hmSkNaRG01eUcy?=
 =?utf-8?B?dkFZUERoZ3kyS1djQU5Xcm5JYnd5TlNoT25rZk9IMFF4OE9UbXBRTFkra3Vv?=
 =?utf-8?B?N2NOUXgzNlFMejF3VjMvQkdITEpiNzR4RGk1WmtRaW1vcEdCdVlkTHpkNElD?=
 =?utf-8?B?eGIySDlTK2lYaVg5U0g2VVFRWFJIcmpCSU9IcUprT2lsUzJKQnpRYm5qbStz?=
 =?utf-8?B?bGJ3K3I4c21vTklUTTJmUlVyM2hTV0FDSUlGYjd5NmtES0YrSGVCWXZubU8y?=
 =?utf-8?B?aHJKT09UMmF0NjFSRDAxVTBzUlFaNDlZZUg2U1FwTTc0UUhzd1NpcW1URkl0?=
 =?utf-8?B?aDV2TXV5WlZmUXc0V3BOdE9hRWNUZnB5RE0wdnVNc01iQ25QYUppS3dHNGda?=
 =?utf-8?B?ZnZtU25RN1VoM1NWVnJyZk9Sdjljb1gvZG1KUTZaVk1SRE52RHlSMUNrcUQ0?=
 =?utf-8?B?MWlFZlhoNGF4U203ZEJxK0E1Nkdmc0tya1N2YTR0TTh2dzhPLzQrUjBudmRY?=
 =?utf-8?B?WnF1UmQyYUtLdGdBbG5qZnVsaVdwL1cwZUk2Q2xjYmFzYUg0YVY5LzRqNzM0?=
 =?utf-8?B?MmNqYXJGcExsb051WmRsMDhuQjdNNUlPb2daeGxRWGlsS0ZwbU43dU9XWXNm?=
 =?utf-8?B?dkIxa3B1aDNKVjZaOTRjZnhoeTd0MTRubko2LzhFcTBvN0NqSG0wYys3UTJV?=
 =?utf-8?B?SVIxUVFVMjRYaHgxallTSWF0WnIrSFZCbCtTMzI2VXd1QXdrY2h4OXRNTVFV?=
 =?utf-8?B?cWw3NlhQRllzeGV5S2lDYjF6VS93SS84NmxtQUtRQnR5MDNjRkpMTkE2YWx1?=
 =?utf-8?B?ZmpXam9rd3FZUHN2c3QzR3ZTeTgvTjJaQytSTytpcWR1TmRTcW40cUVMNU9J?=
 =?utf-8?B?bmtpWFBRay9URy8vQmx0b3dmZ1p3byszQ1BIZDlhQm5XWUZMdEZJL2t1WHox?=
 =?utf-8?B?bVA1U2FJenBHaXFnTFlGSk1UZEhFejNraFhDVithZ1ZPbFlMbFNuOVRtdEJp?=
 =?utf-8?B?VG5nckZZRHhNaHdxMkI4WXFSdTZmSXdrZEFDSlkxSEx6VS9KaUtMby81bEF3?=
 =?utf-8?B?YWt1V2J4eXpTd25qalFoVlJSMzdPbEJ2QXRrMHVMT3ZyWHFieVdHdXlmNmxN?=
 =?utf-8?B?cm5qeStsQ2I4SHdmQWxMbDFCWEtQSFhVZlJNb28zWDN4bFI5cDI5RWdkZSsr?=
 =?utf-8?B?YzJHSmwrWlFYMDF3OVZacUxZVWtFRnd2SWdobW94bS9jR1UwZW50M2dlSTdO?=
 =?utf-8?B?WTVsNTF1LzBFaC9zekpuVi9rZ0pVVW8vVGcyVWZjaThTN1NsNzRFWklVOW51?=
 =?utf-8?B?SGR2VTFoM2JiVkFGWElBRUxPcFQzR0w3Umk2WHY0Z1BVMktmZ1BSS0cwVXhV?=
 =?utf-8?B?UmI0Y25lUHFwNkYrdUYxbFVqNnVyc3Mwb3M3N2M5M0FMNEVxN3h4NVdPbU05?=
 =?utf-8?B?dTJFNXlqa1JrM09oRW9GYmo5dTJGN0VMRmFBT3p5MzlpNE05aXN4MEUzbkNI?=
 =?utf-8?B?TS9PUHZtUVRUQ2FDTitIUGhsclFhajdnaHZML2FJUzZDblE2VHR4QTA5TWRX?=
 =?utf-8?B?eUhOb3RBSlBMS3ZQTkRtV0RBdjluRmUzSkRnVjgrV25obSt5TDZhMGpRQ1BZ?=
 =?utf-8?B?WjgvZVdvcHlaY09hUTYyVlRjeStjeFloNHVtNmFQeUExcldvWlFFa3VJMk1z?=
 =?utf-8?B?VlhiR3FjUlRJZGhyUWozcW9sRmV6ZnRJRTBIa0xpVVhYVDZIallnOEYxMU1t?=
 =?utf-8?B?TXFTVkUwMHNWWE9SN3J6aHpTRnU3Y1VIMlJ3aVVNWVJiNHowdG8zWVUzcVNT?=
 =?utf-8?B?U3VlYVJERDU4V0JwYy9IUWtBWUJUWXFZaHp6dkZqVnN0cW5ET3B4SWRrQnpV?=
 =?utf-8?B?c0Jxc3owNW9BM2o1YnlobnpKOFhTU1Jqb0h5b1ljT2tlZzBTSmJiV1RWb2Ur?=
 =?utf-8?B?UVV2NFZGdXV3cVFsUE13M0Zqay9IeXBiUEV1dmF1L24vc2ZQOTRyVkpUL2dt?=
 =?utf-8?Q?wFYxzancDEdKNEeqOSVOqJYoB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4896b1c-bf15-4d0f-3f69-08ddf74cafd1
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:18:10.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTWMkersW/DVUOA6X2edhdD/pninueRXoRbI3hJKdddEWJocnjd5D2B16jVu0t42rQjOdqBmTTs7iPebRuajTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8711
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=vJ6Ir0Eo;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 52.101.65.9) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffgfuffhvfhfjggtgfggsehtjeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepgeekkeejhedttdegueetgeegveelvdeuledujeefjefhvdetgefhleeivedvkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedrjedtrddujeekrddvuddupddviedtfeemuddtrgeimedutdemfeekieemmeduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 19.09.25 08:55, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Not all callers of this function do that themselves.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 83b8492984982..ba804fcdfdb3f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>  	if (!system_supports_fpsimd())
>  		return;
>  	WARN_ON(!hard_irqs_disabled() && preemptible());
> -	__get_cpu_fpsimd_context();
> +	get_cpu_fpsimd_context();
>  	__fpsimd_save();
>  	fpsimd_flush_cpu_state();
> -	__put_cpu_fpsimd_context();
> +	put_cpu_fpsimd_context();
>  }
>  
>  #ifdef CONFIG_KERNEL_MODE_NEON

This one is actually vanishing when rebasing over v6.1.151-cip46 which
has
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8f4dc4e54eed4bebb18390305eb1f721c00457e1.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
