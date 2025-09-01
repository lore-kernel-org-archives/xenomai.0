Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD0469D
	for <xenomai@lists.linux.dev>; Mon,  1 Sep 2025 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752403; cv=fail; b=Euo1WzIj82o+JNEx1LrNpxj3WMVDmkqx7PFI/z/C+Gy5S5Azse49baWVNbWoDCHMm4dc18yzQ4kN7ZblexvsEvu+U/YF6gdmjURpMBEBA6gDVSBV0rNn+FlxPiHQryaz28/LVnYmkbgmzAH3WeUycgQ0y5fpJUVzm5P6BsXALV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752403; c=relaxed/simple;
	bh=uVicyRx1CsGiUye6cwzBMXGOOIEuU41VhWbKnNlsVCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNPbsciM3Cm2c/m/+kGML9NOED4LrQsBC07bzycv+QtHyOMhCimiPkdBp2BgRwp+MxCLnLYQ7Igni8zi4CzVCQNuv/qlp4I+nECVBhqZbex6JswQcydTU65C7SM/V9ehBcybSV5lHtzlyXg4PuXuN7AcgBzPEOEH1XB2Su2+myU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AdFImiPz; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AdFImiPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVGmBDgeEHO2vD+FyIHOAldMf5fpSodM7bWS1r2M+R+1m+hFnILJ44xQqHdv6vmcPX0Mc0WbJpFi+wPpgA5sO0p+NcTNXQ3pYQxYkxNEBoqkee5YqQnTASUerdozZ/SFQLzwTH17RhcOUoOUY89RtW65leWMepgWN2p8M8efIXZi/+fkmb/8xRroKpbfFu12YpcSfOz5Mx7Yf83VS//8+zd7weTvMcdN4eJYrrT5DAjyK3yqDvb4opAODntAK8JuvT3MqLquuVYNrQs0SFcxFmDbNk07Ju2Qy4fK+4+VcveNecburkIjWOSxHnQZwHCBD8AUGkVOmPbSa3n1iIe3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ4Rn+wl/UTEfMBVJwdH3kSHu5Or+VoO8z6wd1mc6Tc=;
 b=laappLRzr6R3f3wX1wVdHuwLBFz69HH1ir+ZBj4fppM7TkM0AA6Extxjd/ZO9/2Qfn7g+VwKFmW85UJKLPuYHIwJ5+n5bonzDMfSdzjNIqfHP6qHCRKitFhcwuVXNMfe3IY5PXdSLRJ0ytITsz8DJByLZH3AJqEvU6zF5/plU3Zcso7MREeujd4HZg9Fu+KlpNnwSRydED2e2UNfVwskGvDZWhSv/5Q8lUz2vdCMwQiJNjkoswW3qnWuBaFXvBf0qGtIqyLzHtStXMPk0T615LsMtZyFEfGd8Vsk0pdv4ha0MekgvNsccgRvejUT9AyZ4DSPGBj2XnkiHE0/QDLBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ4Rn+wl/UTEfMBVJwdH3kSHu5Or+VoO8z6wd1mc6Tc=;
 b=AdFImiPz4wq66T/8p9gFSF8n3Z21rZa/vGmojsG1hGDlqsuW3S1cyyfu0dutsituj7ifTfQHaP9tUMFoM+TPqmahWoyscwmN6ewOYSwXDcuYran8iPRiQuTXigxJud6MGj94QCn4gKNWyB8sqdsYCVIhNJ+YTX9b7rW3Z/JmAC75GV3WtQwZ9HIuh6OlSX27l6xU8NHrs/0heD+0F0vVdh9MTlwManjp9T/5essK4wM8HJ+OPeal9HyTp3Ry3TjJsobsT+1PoQD7fnUFTi/t0cotq9uagpuPdq7c+v3H0iafsAfMgiSzpg61baJuSm7qnbiX7YU6kHoLSYeTXf8lzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 18:46:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 18:46:38 +0000
Message-ID: <fd5d5c99-9af0-4908-b49c-4fbd6206f5fb@siemens.com>
Date: Mon, 1 Sep 2025 20:46:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: xenomai@lists.linux.dev
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com> <ZyUJFhSxPyAcfSHI@trex>
 <49554ca1-4f91-4d9d-8b40-7561eca99908@siemens.com>
 <87zflxj6b4.fsf@xenomai.org>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <87zflxj6b4.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2f2d93-a106-4b47-ea30-08dde987e254
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWdMSHFSVkV1MGhFRm9KS0hBOW90WmhOTHNJcnZkTFdLd05TU2RSa0oxS05n?=
 =?utf-8?B?YjQvdEJTRk5iKzFUYnBOcHk2RGI5eVFnbkZmWmhPd2Q2Z0RDanlGUDczQ0d3?=
 =?utf-8?B?b2l5TTVDYzFuYk9aVXFHZHA4NG9BTGpnQlRVdXdNY09CWXhYRGZNL2o4WDZB?=
 =?utf-8?B?YWczdUJYemwwWEs2bEQ3Mm5rWjJIOTdpdFVqSlgwYjByZEFEMmpsUUs2SnEz?=
 =?utf-8?B?bTNlQmRTejY1Q0J2NnQwVytNNlVvUTY3MmRqTWFxbEJqRXFUQkdSLzhOS1hr?=
 =?utf-8?B?R1FaQU5wM0ZwSVBNblhZbENOSmExYkhRNEhDY0l2RG5xVFRTRFo3M3F0VHht?=
 =?utf-8?B?MWJObU5GeG9BYUUvVDRVUXpqbmI2UXVsYkxzckduWnlFUnFxTGhmR2I4TUQy?=
 =?utf-8?B?Z3NuM1BRbloyNHQ2OTFLOUVrakh6TzQ3dEdzSXRBb0Z2U3lzUFRwWlluZXBH?=
 =?utf-8?B?NjUvUVFrS0NUTE5QcGhpcVg3NWJYdkE4UXhUUXlEMGpQMjlXdSttbCtqcVFT?=
 =?utf-8?B?U3FSeVBadFdKSUhVQ1g4Nk5XbzJocVdra3QrWDFySGM4THFqTyt6WDNYZ0Vv?=
 =?utf-8?B?dGQ1bjRHUWxRZENseHJTVjV3d2s5YzhpcUVKekFNcEF2SGlZblQ3a1JudnV4?=
 =?utf-8?B?dUlVaFJsZW5uWHB5dk55Y09BMkJiSlFvcFFHejJJTFl2ajlCNEZiK21EL3Y1?=
 =?utf-8?B?eE5uMjl1WjBwTFpuVFFicEtvVHdvdDdWZ3ErODRpU1l4YmRSbmVkbk5BRnRa?=
 =?utf-8?B?UDIxV0pLdm1yV01QR0RVempVVjdQVktOSEcvR3c5d24zVXJwejhycUtrRHpl?=
 =?utf-8?B?eWhyanN3eUc0U3ZVaUNtbjBCZmdZb3dOYjlSajIrQTQ5NGN5NXpIQ0VpOG0y?=
 =?utf-8?B?b2NMQ1VlUTBTQm1OMjVjaGJrWWJ6VmhXbGxrYXp1SVJObFk3RDBXVUdCaVhO?=
 =?utf-8?B?VEhGVEpEaFcwMzRtbnBhY2lpbkJia0xWTFphNG1EanYvQ1Aya0tWaCtPN3U1?=
 =?utf-8?B?WlZxdXp1ZFE4Y2NxSnIvWXNMbk9Hc0plSmFDMVlPbXBwTzV4ZlQwWENiS1U2?=
 =?utf-8?B?b2t2TDZEQ2Jpa1FXZXRIbTRYeENYaDlrYndscEdCVzRUNVBSRStFWmNPQWhV?=
 =?utf-8?B?Q0NoVUJjc3NMQ3hsMVBwZ1FGd0dUZUxNR3hPUDhzVHJBZWlYU25BNzBCUWV6?=
 =?utf-8?B?MDY1Vm9TTncyS1RCWmxTOFh2aVpVaFF6SVBkUmF5bGFBbjV6SUdaTjFoNXo1?=
 =?utf-8?B?SlJYcFpUNHJVdXRnaWJEZVdjZ1lUUEdtaFdjOHhSNTFGV1N1MlhWSHFWejJv?=
 =?utf-8?B?aUphLzFSZjMwQTRwdzFBSU5IZ25USzR0TjhBZUVBYjFLaFgwWEFvaFZpcVBR?=
 =?utf-8?B?MWJmWUprMkZWVTZtY0xVbWYzSmRYTUl2R2ZNcjVzTVBTQklURElnbG4zQjFk?=
 =?utf-8?B?U3RTYkJ3eWl0U1diWTlWRUo5algyY3BYOWRLeWRDQ0t6NEN5RFNUbFN3WGNh?=
 =?utf-8?B?ZkRIZjBRWVFZbURKZTFqTGMrZFZMbVBiNVlKWnBaNXpkejdmVDhSRnBVdUow?=
 =?utf-8?B?SGJ2ajNiNVFtWmdpL2pkaTVxaGx5NWZQcVRXUEZuUVVxbW90UndJV2g1N3U4?=
 =?utf-8?B?Mml4SmxXUFpkeHFvMXF1dHRoa2RGTkNXSEJBNTh1cCtqd2p0ajl2QzREeWE3?=
 =?utf-8?B?TUFJdlRIYkwrYzMxR3BaLzdTaktEVVpSbWpvNFFXcDZHK1NsbW05aTJGSmFw?=
 =?utf-8?B?MHR4dis0OXVZbWJISml0TkFXS1IxN1BqSkE5dUNWTDROSzlwc2UxbXNJRHZ5?=
 =?utf-8?B?RXp6YTB6MzF6SGltZWQ4UDV2VEFWOXc4U3oyTVNEYUN5NlZBNVB3Q0crc0VI?=
 =?utf-8?B?MEtZZ2JlWjJlQ0tuUk91NmNvTWF5MDZyc09BMmRWQUp2MUNwVVdRaTMrZW00?=
 =?utf-8?Q?PJgtO4e0vZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3p2Q3YyNmNHUE4vekZIVkNyeHY4ZlhZdzd1blFBSWhtSnhGMU9ZMXJOS1g5?=
 =?utf-8?B?VkFBWFVLZmVXaVlLT3N1emErMmpoOVBUWWU2NGRBQ25jc3lOUG9QYmYwc3Ba?=
 =?utf-8?B?bTNYb2h4WlpzTlNwUjJSNjBDbVRzVjZ2dHpTRFZYazZmOE05RW9DdlNmUVBK?=
 =?utf-8?B?UXpBWkcyVG1mQzJVbVB3cDhtV0M3Y3dFNzlacldqQkVpYzFMZGlwa0d1bWpo?=
 =?utf-8?B?eThBMnZ2SUVEL0ZjQjdTRG5CSlh6SUlvYnNsU09HRGhpejZJVVlWMjBSaHk5?=
 =?utf-8?B?SW1VTTliZ1R0TVA3TGZYZytkckIzQjh3RGFDQTZMbk1pbzV0WVh6U1pLYkVL?=
 =?utf-8?B?SzBOeXdqTHhMaVBmb290Y1RKNG4yd3NqZ1FCbDFPODU3ODBYRi9DSVBNSmJP?=
 =?utf-8?B?ejgyaGJpZVN6Y2dFekU0WC83VDVGMkJxR3ozU1YzV1E2MXcwckU2a0NGVTNn?=
 =?utf-8?B?OGpydmhCcXdLUnh4d1FRQ3ZvVmZNYThlekZQNjNFaE9RdElKQ1dia2w5RDVZ?=
 =?utf-8?B?OFYzZEJBUmxsdU5laFNrMi9GT3VOZlEvOTVDY0szVERVc2pvTFkrS1RDK21w?=
 =?utf-8?B?RHBtclNDUFcrcjJ5Z01mNUFKNUVPLzdzMDRUaFBKbnVuTWNvamJHOEx1TkJ4?=
 =?utf-8?B?SS9jVVkwTFFjanR6YTVQTnV1OG9aM2tFRnd4bGFXRjVWL1l3akVGNzZmSjcy?=
 =?utf-8?B?TUgvTVc2WjVCV0xCVytzWFRBZVZKbE1Gb202V1FZaVRFOVNKanJnSTczSDk1?=
 =?utf-8?B?eUFRUXJBNDFVOWlXVmUzQjB3N1B0d3JzeDB2T1UybXpkbW1SSDhUZ0hVQWpK?=
 =?utf-8?B?NnZEZ2ZkNGUxRjJMNW5XVHMwWktBN29BN3B4ZTBFUEJxRHExRVAwVVpLT2JI?=
 =?utf-8?B?Z1h3OW5GMy9yeHJIdnMySkp2QlBIbzl3YmxBTmJwVHd1alFIZE0rMmpvM0Zo?=
 =?utf-8?B?NmRyRTM2WjFFQ1NPSEo0TjFMSW9Qb2xZdlprNDNGYjQvellXR01aUE5rcE41?=
 =?utf-8?B?bzRIYkJwYXNFUEtXMlcxK0U3aXFkMmhrYkdJRFllWkFxVWdKWFFrU1RDeUxV?=
 =?utf-8?B?Y0dsbUJNMS9sbEJvYTV3ZDRtVXFpSXhWUmdRTGlHNFNGOENUZmpGT1dzc0lS?=
 =?utf-8?B?TXlsUWVhQVEzeFFDMTdRZ3hkOVFaOTkwWnpGS3lyZXFSSmVTMWlVbUtmb3FI?=
 =?utf-8?B?K1VaU0ViZUk5VVNlbHRIZ0tuQitBRHVyTjh4RWRjbE5DUDd0eTV6L2RmdnFT?=
 =?utf-8?B?MjZKbVRuTCtSdEwwYTZvVm9vNWVMWG9hL2RzVU9UNWJ1OXNkTG90MXJJUWpC?=
 =?utf-8?B?bU4rbWZmdjRxNVo5TnhWWThvL1FUQnhVZzhEZ0hiMmwwNk11T2lFY1B5d3Vl?=
 =?utf-8?B?N3QvQlJSdG1rSHlFTFBXVGhNTFlNM0hyaTdOS3ZYRTlHMTVUUHRWb1ZJZWlT?=
 =?utf-8?B?d3RiRWtnT2hHOGJUbE5wSGlsSEh0VmgvcTY2SkpjWm90RDQ2dGVINzBhS2tP?=
 =?utf-8?B?T0JwdGFWZVRnN1g2bXNHRyt3NWZvWWF0Yi94cnVNQUZITGV4RGUyUkduUE1r?=
 =?utf-8?B?WEZqYWRJTlZ4R1ZmeVpUWEYvRm41enFwS1BzVU5EbVJwcEtGSXVtV0F5S3NB?=
 =?utf-8?B?T2JIOTFsTi9jcUthWHhPcEtPT2Y3dmN3RWJ6T2RyL3luRkd4S2FLSkVsOXE5?=
 =?utf-8?B?SjJlUWV5eWZUNWFEWVZhYnNqT1VGKzd6NFl1YTdTY0JtMklLVTNUamE5RUdk?=
 =?utf-8?B?c2h5UW9EYUNzTlBUY3M1OHhHRGplWHUrVEpWUHZhTUszUWRmUjFHSDl5VGcr?=
 =?utf-8?B?RGFla2JaRHJkMmd4aEVjakZJRVdOemhxM3VJMEVjNWxKR0ZoMWd1SFBpWEZ1?=
 =?utf-8?B?b0hQT1RjNTMwZjJ6b0tST2pQNnB5Q3BnQjF1bjdGUlB2elNvNmVBVWgybXY1?=
 =?utf-8?B?MHRBS2FMeFMyNDBzbDVRRUdTVUlXQlBiMUV2THZPaDZQc3MvTXpIdzJUYlR1?=
 =?utf-8?B?ckJZeDFpNVovRmhCN1lvMCtOeFNCcUFUZ2JielUvdVBSa2NOWmNNb29YdVpw?=
 =?utf-8?B?K0cvSllUcXJpS0twSld2T0lKSGpma0pOYUlyOFBJMTA3K1ZmbklrdmJPOWM1?=
 =?utf-8?B?WmU2a3N4MXIyZ1ZITC84d3JZRVdRTnRWOEJqTkFRcmxPWitDUUNKa1IxS1hF?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2f2d93-a106-4b47-ea30-08dde987e254
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:46:38.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aepxXTCw2930YwZvCi/fcFIOqVmlTudGcrqQqJgLdBkIL0X+OQnJYKYlfIk+Lbbi925qsnIe3AvBGr4YVzq77fgKq+G+Emaj8KmHLfAI55A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424

Hi Jorge, hi Philippe,

On 18.11.24 09:26, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> [sorry, missed your reply]
>>
>> On 01.11.24 18:00, Jorge Ramirez-Ortiz, Gmail wrote:
>>> On 13/06/24 17:30:51, Jan Kiszka wrote:
>>>> On 13.06.24 16:16, Philippe Gerum wrote:
>>>>>
>>>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>>>>
>>>>>> Stress evl with a load command while running the tests. The load command
>>>>>> may be set to an empty string to run tests without stressing the system.
>>>>>>
>>>>>> To align with xeno-test the -l command line argument was used for the load
>>>>>> command. Listing of the unittests can now be done with --list and --List.
>>>>>>
>>>>>
>>>>> Nak. Compat with xeno-test is definitely not a requirement if this means
>>>>> breaking the existing evl command line usage. Besides, --List looks
>>>>> strange as an option. Let's pick a different option for the load command
>>>>> instead.
>>>>>
>>>>>> The load command is moved to its own process group to allow a clean
>>>>>> teardown of the load process with all its subprocesses.
>>>>>>
>>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>>> ---
>>>>>>   utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>>>>>   1 file changed, 61 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/utils/evl-test b/utils/evl-test
>>>>>> index 5c1c3da..fb85f69 100644
>>>>>> --- a/utils/evl-test
>>>>>> +++ b/utils/evl-test
>>>>>> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>>>>>>      exit 2
>>>>>>   fi
>>>>>>   
>>>>>> -usage() {
>>>>>> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>>>>>> -}
>>>>>> -
>>>>>>   keep_going=false
>>>>>>   do_list=false
>>>>>>   full_path=false
>>>>>>   unittests_only=false
>>>>>> +load_cmd="dohell 900"
>>>>>> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
>>>>>> +
>>>>>> +usage() {
>>>>>> +   cat >&2 <<EOF
>>>>>> +evl test -h
>>>>>> +
>>>>>> +This help text.
>>>>>> +
>>>>>> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
>>>>>> +
>>>>>> +Run a basic test/benchmark of evl on your platform, by first starting a
>>>>>> +few unit tests, then running the latency test under the load generated by
>>>>>> +"load-command".
>>>>>> +
>>>>>> +By default, the load command is "dohell 900", which will generate load during
>>>>>> +15 minutes. To generate a more realistic load see dohell help.
>>>>>> +
>>>>>> +This script accepts the -k option to tell the unit test loop to keep
>>>>>> +going upon a failing test. Otherwise evl test stops immediately.
>>>>>> +
>>>>>
>>>>> To be fixed wrt the comment on the previous patch.
>>>>>
>>>>>> +Use -u if you want to skip the latency test and only run the unittests.
>>>>>> +
>>>>>> +Use --list to output all the tests available. --List will print all the tests
>>>>>> +with their full path.
>>>>>> +
>>>>>> +Example:
>>>>>> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>>>>> +
>>>>>> +Will generate load including network load using the server at IP address
>>>>>> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
>>>>>> +installed under the /ltp directory, and use the latency test by measuring the
>>>>>> +timer irq latency.
>>>>>
>>>>> We should use stress-ng or something alike, instead of the obsolete
>>>>> dohell script.
>>>>
>>>> Fact is that dohell does better than stress-ng, at least in the configs
>>>> of the latter that I've seen before.
>>>
>>> just "dohell -s 192.168.0.5 -m /mnt -l /ltp" ? do you know after how
>>> long (ie, did it take a few hours or just minutes?)
>>>
>>
>> Yes, I ran what Xenomai 3 also runs, for better comparison. That was for
>> some hours (don't recall exactly anymore). Not just 10 min but also not
>> for a day or longer.
>>
>> My theory on this: With RT Preempt, it's more effective to stress the
>> common code (and locking) paths like stress-ng is triggering. For the
>> more decoupled co-kernel architecture with way less common locking, and
>> that rather short and not nested, cache load is more effective.
>>
> 
> Same conclusion here, this is where the vm stressors may come into
> play. They tend to pound the hardware pretty aggressively, in addition
> with stressors causing a high rate of context switches (L1 flush +
> mandatory hard irqs off section on mmswitch). If we could generate such
> load by using the proper stress-ng stressors, we would only depend on a
> broadly available tool suite which implements state-of-the-art testing
> techniques (Gilles wrote xeno-test 14y ago based on my testing habits
> since 2006 or so, which clearly does not qualify anymore).


I’d like to bring this up again.

Thanks, Jorge, for sharing your first results in the other subthread. 
 From my understanding, it’s still unclear whether the stress-ng vm 
stressors load the system as heavily as dohell does. Have you been able 
to confirm this in the meantime? Do you plan to continue this work, or 
are you expecting someone else to pick it up?

Best,
Tobias

