Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E4344033
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445783; cv=fail; b=TfIbpKr6lpDaQUNj6A/ywp7lOo5JTFhMPX+zJWxfmqHkkj86oNQXIX8mF+8aNshc7XT7/D8Svj1Nq0maw5zb8ihhXSXMVNmvFuAYSpkvFgoxQW8KZXCG9LzsIYy12qUejm9Fqv8ngh3NE5JkqQ7zPNYVRPjZt+jnkCIvEqUED90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445783; c=relaxed/simple;
	bh=h3jegOBo4WE2GbqJX4ijXPDoH3fGR8dzTw94GgwM+rk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XcfCGA+CWvOvIqF4QkFzLYLeM+hIJO2DDh3IfUbYBp8dhzNtICed7JAiKkCCDHbCyf4xCxrrHwI7x8qA/GutIeWwc7/aaZUlLEQcd6G/xaCdTcMM3mrUw7buCLTNQdkaukZgRwvmOIs52eO5wfnPUlfSYBS2/eGxY+AbtJ0UWxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H1UNafyq; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H1UNafyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3rK/SrX8Z5WqNQhFssqjyZby05a0o4gdqRzSjAJn/zxM5Wx41W8OJv6P5KGxHFbPO3AH7vZneKM7MjQz0ilY7bMFIadMRSqj3Wzo6UNDNCRuk4Y+i5AhjR/0RFZSaAleyZJGSgu6Nn++KqW/kxE7/V47yVtib0qwYf8UTIMOBBhPsh5iYgDt1Kn11PQnsnSch08D7ZaJI+BBlGEOyd9HiET4WJ2ppX/BORo7fP7ITh9du2QQLPn+Bwv46ya2iMO/FDhgr+bgUkEmjGYijsVlLA3ZOvYbSKkyhmxzdBktzdXZ9tnd7CkuPcRAL2zSUiGSgh/wZyaJxqsJ42K+9LKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF3oEmu7flq0EIIdrRcNL/78ArHM5UJIaEY8KPVTNZo=;
 b=X/uu4P4irvpv6MDinKYLau1eX3By/kQnxFVzrrWA1+fYNF4PZ5xryYRRYjaV/yQceXI/Y3MnPjkGOBYzFPG94sQ8eZk6Pw9KSsWDRMlKO0PXPhyIPEQi50a/CLYNhK7dS4sXMOgFd/pwCMEos+PDaFNWRStLE7DthQ1hdfj/UaM/6ma3/+mc/modzTlmcoKDzR2H5NUB3dB5AaHvSvlkZ6WzFk5a35R+nYl1qdi7i6iY3dWDDaIQrEOBNjyvPGTMfUIUE5Qqkk0M3GS8/u4hGNFJPPRhhwk4aKeDfSpkXeli2yUYgv20UbdtmSpWIFDJ8Dcph31PsBYKYMPk624eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF3oEmu7flq0EIIdrRcNL/78ArHM5UJIaEY8KPVTNZo=;
 b=H1UNafyqYqXjGhQzt+yZlgmRvJekY9QIPh1opIDBX2J9GHM/n4wwKK4USCr77rEWwdTZJwW0AlyVxkW2fRoANXqOkTHlU2bjac1WMPl8G0ulCvFvWylLUrf56yVrLE0Ky/M8ywe246Wn9wsyrOWC8gE891A7R/3pC+8HLx/IFRxK8ApbiQzc2JydWVs+UV/kBL4ZcaBSgobmUcwSmfOcWv1UHtTZov9SunjahNH728o0xvgf0uORNzLM9Ecn4+1+7qUDgnVomu/ArD/9EFi+k5n9kgs5u8YLlcMkx7c3X+3xOLJO/r8XVU3x42KgKubWVKtSaR6gEo8IPr8w8nKDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:42:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:42:56 +0000
Message-ID: <4a392bcb-b206-442f-851c-5d497f797858@siemens.com>
Date: Mon, 26 Jan 2026 17:42:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 0/3] Add CI support for dovetail head
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260126161445.349483-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260126161445.349483-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: caacbe29-8a93-4480-ad9c-08de5cf9f4f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWhLOFl2UnJOUDJFbndLWWVQSkk5QmlEZWFXcUsrRmYvZjkrNmlZUW9nRFgv?=
 =?utf-8?B?Qno3VmZlUEpZVHpQd0RZVjdnK20zbVFFZVlCcyt3bkxBV0o0V29lQ1VndUhx?=
 =?utf-8?B?TXNNaGV6d2NTOVJpb0hWVG82K1c2M21KMDdDZ2hIR2pPc3NJQ2pQV3dDM2pk?=
 =?utf-8?B?QW5HR0lva3o3Yy80TUdsNmZZcnN0allIUHdVcmUrbEgweXdyeU5xNDA5Q3BF?=
 =?utf-8?B?R0JMTytLSFkyaW9QZDJuSmxhRVpxaWJkVHhXWmZUMmt2elV1TkQ4VldEeEN6?=
 =?utf-8?B?a1l2Nm9lRlZlaGJ4S1FWMkduSUdHeGdyaEU4TEJWdkc1M0d2UFNVejJwclRy?=
 =?utf-8?B?cFNPbU5rdkFlN0h2b0VPb0pvUVZtd1VHU1ppVnhGT00wUVo4VlFWbGdXYlhJ?=
 =?utf-8?B?UHR2SVptYXlwalJteWNYNDNqbmxyQkt0NGNDcTBsRkNBNXRxRGw4elF3cGtz?=
 =?utf-8?B?RVg2NFhBNWljTE9mZEV0clRxenRoRE5xKzYydHcyZGd1VkhwRWJTOGx4VlVH?=
 =?utf-8?B?dTI0ajBkU3dTM2pRS1JIRVlwRUhWVWhOQmpmd1gzbDlVRUFBVU9Td2tOMmtP?=
 =?utf-8?B?K0daVFhGS1RCdlJOR2laTHdna1hhMjBYbjd1cW9qWDZkRHVkb1FLNXNLUnA5?=
 =?utf-8?B?QXlnOVc3bkRPSGxKd2NvSTNIWERjcitSRHFvV2pzL3NwdHBQSEFmSFB5dVVY?=
 =?utf-8?B?dkxrNHRvNWtHaGlrR2RiTGhyVldPRG5DODNhd2hlK0hjOGJ5QzlJU0I1dHlI?=
 =?utf-8?B?RklkaysvaVBLN25oYUtPTzNBTkMrWFpWSG1NcnlpZlVrSmVOZVVGd3F4REhG?=
 =?utf-8?B?emRhaEsweG1LS1k5SEZQb3V3YzdYNWNXbFo4U1B2dmZFUDhIbWQvcFBEOUJO?=
 =?utf-8?B?ejZ1aWxrQ2YwS0pnZDBNcDNwaURMMHFUTVpWQkM2elJnWWZpMUl2c0JmUXVm?=
 =?utf-8?B?QlVKcTU2K2RkdEtIbE5iYVNXdTFhem9wc0c2RVBwRDBqQkhUQzRvNGRBL296?=
 =?utf-8?B?U3JRVlhWc1VBZm9CV2J4OVhRWFE2bjR6TUVhWTFwY2huclBITXhlYnVmWFBT?=
 =?utf-8?B?dE9NZW1JcFJBSG1TbEwyUUc3RElZY0VZcXFCMkhtSnAySHU3TThEWHFsU3BY?=
 =?utf-8?B?VWU1emo0OFFKZFBxbWF1TDFhUVlkVHZ2ZVk1TyswOFBhK3JhVFI4M3BSdmZ4?=
 =?utf-8?B?QVZ0MzJ1N1laU2xmZDAyL3N1K1p3Yis0YnJ1TnJlRTFjOC9vVUpSOVpqUzlh?=
 =?utf-8?B?VDNhQ1RHMEVvMUNvU3Z0ZVBveEczdVBPWWxrcFpBeHZwUjZEUjV2ajNIc3Jp?=
 =?utf-8?B?OXVDeVhPbmFEQmhuaVM3ZE9NeXY5N0ZUcUFrWE9IcDNZcnFnNmNmNlVncW1w?=
 =?utf-8?B?MmxaWWlsZUFIWXJJc1pTazZPdjZRY3gzU2RHTEEweDgrSEVYcUh3d3ZIbmp6?=
 =?utf-8?B?REtYT2gxdXBZUWxSMWpCcXNPUlYwSE1WTW5oVEFOazA0Wk04cDkxaUlURUhM?=
 =?utf-8?B?RXZUZ25KeFgwOTVZTU5GcW12d0Z2RTJmRGtqTXlNR0NDREgvYXdYZmFNQjl4?=
 =?utf-8?B?dkNxZjBhTkFiNEg1QldmMFNCL3hKVWpnN0xmUjRiR3JKZWxTWjlZS1lMYmtP?=
 =?utf-8?B?RUZzWTNqaGN0QUZWdDR1S1M0V3lXbW50TmhBODRTWUt6dnRBbURqenJ2dncr?=
 =?utf-8?B?Yy8wcEpLMG00SmV4ZGNuMU42dUJyUXQrMEs3QW9KM1JkQzdudFp2cWhUSVFJ?=
 =?utf-8?B?bzRVRFZ2Nk9jd3BMK1hjZTNndE5QTitHM1FlRXkrZVYrWEdxSFlESitqUndm?=
 =?utf-8?B?Z0xwcm1XLy81WW1uaGZOc3doeC9zc09QUTE4RERudTBCTGFzNzNlR05mOUlD?=
 =?utf-8?B?NUFuZVN3a1dnQkw2OVlOQWtQWWgvRG9XdUtaNGx0a0hwMGRjNDNNcnZTQUFj?=
 =?utf-8?B?TUdMeWNLeEo3YnlsTmg1SjZ2THhUcjRIc1ZGalVrZUVCVWdNTmxoQk5iR1lW?=
 =?utf-8?B?cnkvbU54aCtPeGNMdzZBZ1B4STg5a091bjBYT2F5NUlRazlwaURYVmZXSlpj?=
 =?utf-8?B?WjJlV3V6OEJiYVZ3aFV6WkwvVVpHUmJRSSswcHJjek82OHVGd0o1V0hCY3Fo?=
 =?utf-8?Q?CCUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdqQ3U1NXFveDhmQzhzMHoxL1BKS3VFVUV5UFFxWWtydDJGSVlxNXhlK095?=
 =?utf-8?B?NGJNdCtOVlZlMU9ObnpMZVBsMmxLaTBwWFlUR0NRaVdmSXRiWXhNYTczb05k?=
 =?utf-8?B?SHJQNGlwOTVzRGsrQ0dybi9hOGVYeDloQVROMGp4OG5lcjNUUEVsUjkrTHMx?=
 =?utf-8?B?bnQwMXJwQ3pmaDlnNkdzWUt4NGZmeFh1SU5kOG5DbmQ4Z1U5ZzNNbEdXZ3ZM?=
 =?utf-8?B?VDllOGQrcjhQMWx1T1AxS3daTFZPaHpWMWFJMk1NOHBQQTk1and3cGJRWjNI?=
 =?utf-8?B?SHJQTnlrNXhzK2tHbWZINVJNd1ZvZkE5ZlBiOEorOXhaVzRZbGsrWEQyTy9B?=
 =?utf-8?B?cXJ2V3NiMmhWeUdJK0thNUI5LytJaFhKeHVsRmNMOFB6QS8rRFZzUHBtTUZZ?=
 =?utf-8?B?cVZ5aTVSN0ZDay90ZTEwQSt6VDhxeVhacDFwU0hhQndrV1F1ZzE5QlptcTZE?=
 =?utf-8?B?cVZ0a1FrWU50QXFwWVRhWUora0VReGNldmU0QTJ4aUFUNzNwOE5ZQ2sxT2h2?=
 =?utf-8?B?STFtY3BJeERmVmR6TnZETDBSMnhnbVUxcjBTS0RXSmoybUZGTmRDR2FYME4x?=
 =?utf-8?B?djhrT3dRQTl2Uk5mb2hZQ2NhL3hRRUpnd0RRQng4QTExYk5GU0M2TkVYYjVF?=
 =?utf-8?B?TDRjMmUzWUNDZWk1M3E0U21wZm0wQXVnd21uTm1WNmtaQW41a2hjUEZkRTFP?=
 =?utf-8?B?TURxNkNFTDY1TDZHbEMrV28zaG5JVHU1dmkzZkpUTWxYU3Bhbk5KdllLQkYv?=
 =?utf-8?B?cXROTnJpSGRTWVAvRjBXMjRuUUNuT2FTT2F4RkgyVE56dHAxLzR0YmZCK2tU?=
 =?utf-8?B?M1dLOHNpbFVydjBIcUNwNGN2MDZxMkNnRENpUHFzZUd5WDhEelV2dnkvdHlq?=
 =?utf-8?B?bmdqZlZ6VVBDWVhyY1NweHNNMWRHUlJSeUxSNGY5YjBNb0dXUUM5dEFuM0pm?=
 =?utf-8?B?SndUR1A1VXF6b2ZBejA4UzJ3bnhiSHAyOW1zWWhPVU5HMVBoWlE4UEluMnZY?=
 =?utf-8?B?WHVYeW90d1RtYjhSakRaOFlaNlZNaDdKNzZTbHFFZGprekg5QVd4aEtzbnNU?=
 =?utf-8?B?UW5lZFRLYk16b3dHYmZTN01rdnJJRlgwZ09SQk4zUldTRjhUZkMwQkEzQkpw?=
 =?utf-8?B?MGJNLzRvQnlieXg1YVAyRGp3d0d3NmRTVmpVaTd4REtmRzBFY0dyRTdHN2xr?=
 =?utf-8?B?UjVsY0g0VE1aMXduS3lnNCtEVy95a244Y3lXWFh6SlV3SndHN0NIKzAvbExK?=
 =?utf-8?B?YTlUTGVIQzJCMjBNeTFOUDdGcDNicmpEelo3enFuQmVyWDQ5TnZ0VkRJZS96?=
 =?utf-8?B?eVhXRlorSFAxRitJaGpCZTA2d1oxMWM3bDI1aHg3dW12MmpuWXI4bTVsL1h1?=
 =?utf-8?B?ZmdOWlkxRDV2czJCYUt0ejAxSHZHWXlaRUx4Z090WUQyNldzdVpOMmpmY3FO?=
 =?utf-8?B?MlJqYXE0dlFiQ3VOTEFvQ0wwajYrbnRVejRRT2dhMUdIVnJFY3ZCS3pwOUxF?=
 =?utf-8?B?eGIzRFBVSi9PSHY2eXp2dGNqbFFaV3ppbTJpeURSaXZXRjE3ZDYwVTZxNkoy?=
 =?utf-8?B?VU9CVzhrRUJLR3RvRUQyTnNoN3V1UGRLZDBJT0dxaTA1eFl2dlRmWUQvN0xj?=
 =?utf-8?B?N1E4bllTaUw5WGdDNUxvcGw1Y0g3UFFSY0FPS3k1eXdxdUQ5MlVCcThZR25E?=
 =?utf-8?B?TE5GTW4xaGo2VkUxQjBRTysrWTZHNHJTR1dZRnM3c1ZZS2dqZWF1NFBIQkhs?=
 =?utf-8?B?dkdScndaOGtxdjdWR2hEZ3JoKzg2ZERENThHRW1vWGNMb1QyUUlONVpoRzVE?=
 =?utf-8?B?UTBvOU4rTlRlbHhhWU5YVkNjZGV6Z09CT2IzUW9XbnVMbWRYbzN6ZjU4Z1VN?=
 =?utf-8?B?cTg4YjJJUjRjUFZHSHQ1YktiZTYrV09wRlZmZzY4alcvOVlEYXRoVWhYNUxH?=
 =?utf-8?B?cWFBNmVIcHVTQ3FNOFNaZEdjdkdvNnBZbStRZld0bm1SOFZMdnVLWmhXcHl3?=
 =?utf-8?B?OWc5V0h2U0gyczd4d3F5NUs5blozRXNCZW9mT1hqdmF6SDN0dysra21ybVhQ?=
 =?utf-8?B?c21HbjE4R1kzclUzajA0STVvNmRKSWlCYm4vODNvVHQ1bWhvNWxnRG05VTNK?=
 =?utf-8?B?b05OWjN1enY4NjZXVUJXRW4xM1FVMzJJbVZSLzEwb01kWENIY3pvN0RPWGM2?=
 =?utf-8?B?Uml1cTJhK0JOdXhCeUQyd2Nrak5tODdSbFRRVER5Sk5PRUhiNU5Ic3ZLK2Y1?=
 =?utf-8?B?aGtiQmlaUFExV2M3WDZHb2FjZ050ekcrREZrR1VhK2xiK2tFWGs0U2hydGN6?=
 =?utf-8?B?NlJFTjlCUmhrMXRTdnowbVBqL0hCdDJPRXNHWGI0dlEzTHMzZ0d5Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caacbe29-8a93-4480-ad9c-08de5cf9f4f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:42:56.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGJCgihwdKDMP0EE6iq9XMbUp1v5/QsurqSPFP/s4catWZjLd7KiHBwwOUZUmrq2HxXuaXN2lGdOYjllHQTFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6725

On 26.01.26 17:14, Clara Kowalsky wrote:
> Hi,
> 
> this adds the functionality that pushes to the dovetail head branch
> trigger xenomai-images CI builds using LATEST_GIT_BRANCH="latest" and
> xenomai/next.
> 
> This was tested for the dovetail branches:
> - v6.18.y-dovetail-rebase (current head)
> - v6.17-dovetail-rebase (no pipeline triggered)
> - v6.12.y-dovetail-rebase
> 
> Best regards,
> Clara
> 
> Clara Kowalsky (3):
>   ci(dovetail): Put rules into workflow section
>   ci(xenomai-images): Add build job for dovetail head
>   ci(dovetail): Trigger xenomai-images CI for dovetail head
> 
>  ci/ci-dovetail.yml        | 22 +++++++++---
>  ci/dovetail_xenomai_3.yml |  5 ++-
>  ci/kernel_head.yml        | 70 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 5 deletions(-)
>  create mode 100644 ci/kernel_head.yml
> 

Looks good. I've applied all - already to add a commit on top to have
the head kernel part of a xenomai-3-next build as well.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
