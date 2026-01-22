Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56F2D63F6
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086091; cv=fail; b=jn12qdEdeshiJRCreV86+V01Q60c4n5pk/XIalOdB3DtNNOJUC4Ws7MQ9yPnhFjbkfKMX0luOJJpzwZ56pLJrrX7b/RUN7j0hyPxL1Tmqg5N4TsQy9duMNdHwfMZ0m7tYrLcsvA9VFO4L/zjwj9BUEN0sLaAs8zOM/bKxnfdApg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086091; c=relaxed/simple;
	bh=vuDXXjEph5256r+eZAYIlONKkDHQ13GOhnDa0FnYWz4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJUR7q5fvIxBIS+eOMc+T7kgfhHKH1BXSZx1ii98Z3lVLYCSFN3m9PLsGjdaYezvHzeFl+wki7TaLvwJpUkY7YjoXyn7QuBsROUujzy+2En34GZMU9Tr8giWIkVm04+lBioZSNxfQ2t0wlhRSAzu6nUtkbmH3t/C8ubact7bhNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gcHa4D2F; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gcHa4D2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJlnzRRtaTC6Ekmq8rWpkTLEHxMSfHtdqdYKmi9Z1gqxCRGUp0LV+4wxiKKQfO9vpZj3MUmVXioQFIXdEGmufDJdyIyGgj6xmX9FfbWU0n6v9CC6Tyx555z1EFDPzIGyo74y8tfJX4Mrqco3Fdq2TwBZc5hVHO7/IBkedCT4SNbfdphqURYbFjLETipjW8jkXOIslJ0fEIOmcsyGl+nehOCNQivbmsiF7hbaz7gQerjVBwL+ls4q+ZoY138v5xS/doj+D0wI1OxXQhRB1f/nk3JcIjACL6J7A3i0okJShF8fp/zJDIjqYGULG6WVqHxVdNpiijbOiZ+C602lLMDiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p35Zt2AC4p8ZdCxKSHubXefVPSXS/vxYeoLXSvVCu8A=;
 b=pXiuBK6HFjEGYKZ2bcMqC86XCop5lZUFHTtb4JyzD4J1MvzjAZTW5JJtCPscFeE3k6wOI5FKRgS5cinkCUpRmbY1gj4eTMGfc03jjeODJhQgnr9iJ3d5nB9P1culPhzo7H6VyRogFL73xv+wnW1RWrbt1aXC8o9Mwid2uUFITvUFoWnmprqacNUy1vkOIingtZyyOVz9VVQ+E2uRSgPgtVP9DgR2gTPwbT0ccDntxeWAq3EgCSp2iNThNjbev5pLmpeLVMfIsr66gByEBQJyR9tBn1yIAUJfZ4aMq7DW6xg0fnmsD3aRjT07hiylhq2yHBeGLBkwq5mmltwZc29t+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p35Zt2AC4p8ZdCxKSHubXefVPSXS/vxYeoLXSvVCu8A=;
 b=gcHa4D2F5aJzU6Z4IzeVVaU7+u/wF1LeUPhOWDKnaizRh/zLUJSIeD7f8VmpaiVWiLdWjRd3aoARf6fzoW5aDLdRTSyNl0bFRoTFoirJ/ZCdexJ3vtEaBCD6Ga9GcgzQdQPA0On1r1QOYU5RdUaKsC2+c7z1Ia+bfXleWti851gjcq8id+rj7sVQoSFv2lj4c8zuZRWtm/hU0PDclTFRZYl1BOcZiL8+q2L0fRIUBZKaJ78hAjHOPr9dZ49n/N8Jvy89OEer1CTFdSLd+k2+JdqXoUDlRDtp6/1VRe8yKizkYOEW092JEwnjCNkQ31rwOZnCaSbB03WQwY8S4HdWKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:48:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:48:07 +0000
Message-ID: <8ad846eb-c7b6-4056-818e-9e12f8a94cb2@siemens.com>
Date: Thu, 22 Jan 2026 13:48:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260122103928.424945-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3187:EE_
X-MS-Office365-Filtering-Correlation-Id: f18045cc-4d76-4855-82bf-08de59b47d98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkVEUTR1ZjRVWU95TXJsaS82NmwrU09rWE9RZlo2dy9kZE1saVFVM2NxbDB3?=
 =?utf-8?B?Q2dDRTcvb2x0aFRJSUg1YmZSMHpsQVJ1T3F6UXVTRnQ4MmY5TGFNRWwzSUp1?=
 =?utf-8?B?SDg2dHI2VmlYdmF3Tm5QTmsrMnQ0OWd3Mjhmc2k1Q0RMYTRJTlE5Y2hpNkZR?=
 =?utf-8?B?TXVLeFd4RUpTcXJDb1VoUlJSMVFKNDE0VFpjTVBnVmY4YThhbUJFTUZUL0F6?=
 =?utf-8?B?MkZXS0o4UVhUNnRmOXY4VkhrMVU3K2lBZ1g1czRkTUZsdzErZG5pZCtsQjZm?=
 =?utf-8?B?OVBkUllVVlpoelVseHhWczFwRWZDak4wNXNqWDQrZkdmTFhiRGJKTS95dHZs?=
 =?utf-8?B?NVZDUkJyRC8xQ2pIZU5GZWNXcmRQcnlIb0lSOWdsTGpLR0pXWGRzalZnK3h6?=
 =?utf-8?B?WEhPbFpVQXBCY2F2bDh1bkgreHpXbitsSlovdmdXZmhNMmUxZUJBMkR3c24r?=
 =?utf-8?B?a0V4ZGZJL2owWVhNSWxYYVhWaUV0ZERJR0RhcWRBd2pmbmU5MGZ2dGMwcmVt?=
 =?utf-8?B?SGc5ZG5SbkxOb0szN2FTcWxNZ2g5ai9FNm56Uk92bEVaUWFZQ3pTelFiOTZi?=
 =?utf-8?B?NFlnOHJtVmM2UUZXdGl4Wm9ncWtRUkNQeGRTTExxVllXSWtOd0tzSmlTdFBL?=
 =?utf-8?B?bFRmcmZPOHFXNkR6SFl6em4wTklvWE1GbFB2RmZaT3BWb2c4TUgxdnp2S1pK?=
 =?utf-8?B?UEpBbnljc1E3dkg0a24rOXhvVXZZR0tvK3hnU2puWXRHT2JpMlZxZlI5d1Y4?=
 =?utf-8?B?MFU5SGU3ZHlmS0ErdDNRSHE0UEd0cWc1OHR4TktMR1QwOFFzWHF5M0s5amFX?=
 =?utf-8?B?UTNIQkFNdmdhWEJLWXByMXJTQWNOcWNsQlFFMTVwNnlqTVZ5bnVvZ3NzOTZ5?=
 =?utf-8?B?MG82ekxUZDNhYlRUTzNXUGlRUmFXSGVwbmJnV20rRmptbXMrMzhlVi92V1RV?=
 =?utf-8?B?aSswQ0FKVmp0SWdmWFYwNGg0T0duTVM3YlVJT1B2S2dKRVBOUjM3S2l1VGk4?=
 =?utf-8?B?eG00T3g2MEVOYmNMNndSNXQ0TXJxdEg4TGNwVWF4bXJmaWdiMElEbThLbHdQ?=
 =?utf-8?B?WUs3NXZNZnJaWGFFQmhoVjZPYXppSG5UbHJDSzF5VXFUWVgwQjJyUTF1aDk5?=
 =?utf-8?B?aHpLUUlEQ2s5S3VuQ1p6SUtZanZiYmp1VEd6SlZpQzRPeHF4LzVIRHYwY1Z4?=
 =?utf-8?B?dGVjSmJyNUNoV0FlbXEzUzFtNFJHcmJVZHo3cmxsVklYRnU0N1dYd0dkR21m?=
 =?utf-8?B?SjcxMk4yZXVJQzgyUFRvNk1jd2kvV25GYXdldWtjWk43OEJiZWJWS25aRWZh?=
 =?utf-8?B?Y3RmUWVMRnROMlhYQnlHdVExWjNYVFpOQ05iNWRpTWkyZmxaYUUwWU9QNWV6?=
 =?utf-8?B?S1hiWnk5eWRSenpiNUFCemViOVpERERGa3gxd3FQbUZPVWcrM2ZleDRwbllx?=
 =?utf-8?B?M0FzeC9SdkFpSVdPUDRYeDc0N2d5c0hSTGEvZ0xEbkpzSnM4emZNWlBSL1BG?=
 =?utf-8?B?ZGRpU2xpZkdrRjlkeXZtYWs2d2FCQldqaGJhRnAwZk9DRkFHdDJwZnJ0ckx5?=
 =?utf-8?B?Z3pJdUdPZEw0NzZJQVpOOXFTNmwwR2w4TGU1Q25BbXQwVXNmWG9id0lvdFBH?=
 =?utf-8?B?cm0wL3c3Z20xMWdjd1Fmd0tEc1NBNUNGZGhTeDFBNVMybWM2ejQwVkFlUmdB?=
 =?utf-8?B?RWszalAxelNLcEVkeHl1Q1Y4ZHRqa3FNUkFkZ25JTlQrd3N1ZEtTcTNwZkc0?=
 =?utf-8?B?OUw1SVJWdWZrZlFHS3llZE16OG5aM3FqQzRpVCtUdkRWdWxISUFwQXZBUVZz?=
 =?utf-8?B?Q1E5Z1kyeHd2WlRBWWVqalpmMzVIL3IreXBjak8yMk5GcG80aGlzZ3ZzcWNI?=
 =?utf-8?B?UElaN0MrZ2FWRjNRSU16c1VCQlRMa3dnYjAwMmkrMURDQkQ4WmN6Zjh4eEty?=
 =?utf-8?B?cmpYbUtTUFlGMW1FSzQrMDJ6YlZXMFhxN3dWUlJlNDBQMkFJai8rZ3Y3Yzd2?=
 =?utf-8?B?dk5qTW1CT2xwR0NaZWZXU3BVZHorT2lVRmhaRTROcFU3QU1wWlpqazhZdTY0?=
 =?utf-8?B?N1I5Y2UxSjlqWHZ0eTVzcXlqdGlJZUdSWU5Fc2VmTkE4cGFEeXF2MUUvc01a?=
 =?utf-8?Q?Rxso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmNGa3V3eTBxdUdKMUtqbWpyd20yUDkxU2Q3Z0lCejVwZXNSUi9wR0llNGRu?=
 =?utf-8?B?Ym53Y0NWaUNDMkdETjBub3BTYXlib1luZ1QwN0NEd2dqQUg5RTJESHVCbVk3?=
 =?utf-8?B?d0ZqZ1o5cml3T1NYQnNiT3hQeFA4OEx6N1RTU3FPSHhMWUFnNHEzZTdjd3dl?=
 =?utf-8?B?OXMzM1c5cHBORy9hZHNFL01jc3B4Z1RvYjVQSFl6VDAvVTNBMW80WlhGVXBl?=
 =?utf-8?B?cWdZemNKY01tMmN0NmJwZERPbkpFajJ6cEN1MmhyaU1ZVkpXTXdlNUw5bnlS?=
 =?utf-8?B?d011UmgwR0QwZ1NQc25tRk51MlA5djNUVGJOZjJWTStha0VHdW5hRkZZWUc1?=
 =?utf-8?B?WXc3Ym5udHg5NGp2RWdIYUc0Mllibm4wRXVZd29oTCs4TTYxYmRGejZkVjRk?=
 =?utf-8?B?d1pvbkpVbEpYSmtGVDBmVGE0SWVLZmpSbU91RVlaR0ZaZ2lpTjZ4RWpIc0Y4?=
 =?utf-8?B?aGdhQnVuck9WRk5CZit4MGUwSWJwMWpkSnlTWVM4dmlnaFVKUVR3RXlYUFUv?=
 =?utf-8?B?YkVVMHVyZjk3cEVzbVFOL3pwV2IvN1B4RUVUWnF5UENGQ1hUWnNkY1gwSDll?=
 =?utf-8?B?WjNMUk9tdGlFQ0p0ZDB5YTRybHY5SDhiT2ZzRGVnZ0pSb1lnbDQvUHpwTHd3?=
 =?utf-8?B?UXRLcGxHNGw1VU05cVh5Sk9tNWVqZU14NXpEUEhrMlEzM1Nxczg4Z3djaE91?=
 =?utf-8?B?dmEvMlJkMDhkSVFsVVhWcXRtZEdtSW1TazdDM3l0T0REYkpiSFIvamF0ZFdJ?=
 =?utf-8?B?a3BiU2FCbXVnK082WDhjSGVFclNNNTVlNFJyQjd4TEx5eEQxRjUzK1M1VTJC?=
 =?utf-8?B?NzlCQUw2QTBrbVFHdmQ4SjE2elBhSFl2eTVMUm5UT1ovT29QdU5ZM3UvbHB4?=
 =?utf-8?B?SUpTdGg0QS94RUJzdnVEWnREeUN0eWNLUWdyNnQrRm5WbEJ2bHp0dHhxZ3VB?=
 =?utf-8?B?a1ppMWI1UHFlTmJTSU5rblZkU0Z2V1NyNzV6K0tManh1WVlsWnZkTnNwbUsr?=
 =?utf-8?B?cDYvZzdXd1BDaWthbHhmVDFRakoyMjJjNTY5WW1DbU41NzdGMlU5Q1l4VEtH?=
 =?utf-8?B?R0pWeUxMdHluc0JMaVdnY1pOUmNaM21BUUNEaERROWxNaU5ldFgwWVVaMEZp?=
 =?utf-8?B?ZyswZnRPMTJoNEtLLzhGbGdkc0NtUU4xR2VMQzhmUGdjVG4weTlzODNuRm5j?=
 =?utf-8?B?dFJKTXdjeVJFK1hNMkIzelZjSlJVUHNOVXU4OWllOUtpdWptN2luWklCQUdq?=
 =?utf-8?B?MjZINlRIMkYxb3BvRjBiYlk4bHlIYkZ6OGJ3OWFkZU1ndlFOV3A3bHBHZDVk?=
 =?utf-8?B?bnJDcGc4a1JBL3R5citkN0pNVEtLVFBvT1VDYVFGTThPOTBnOTVaT0xHdHJF?=
 =?utf-8?B?R2V5dlBjdG5jR0R2aVZEd2xQVlVMWlF4b241andCWTRxdVB6bnhubzlaWFY5?=
 =?utf-8?B?bVNBb3E3US9pR3pQRE5ncDBTMU1rM3lianVSOXV5Z0hJeXdqSmJrSklZRTE1?=
 =?utf-8?B?YlhNN3FvcG5ERUJsQ1ZldFRnSDFOVlgyZDRhUGsydUpHSlg4OVlvb2FmQjVu?=
 =?utf-8?B?dTVNSXRQaGpEYUlCRUNBYnV2c1ZFRUZ5ZDJ3RW9SOXZzY0VLMlU3VXBTMTA5?=
 =?utf-8?B?WjR1SE9UVDlmcEpxNjN6ZVM1RkZFd0lyUzZZSjJtQThCcC96TmZ5VHYxejFV?=
 =?utf-8?B?NERyTE5mdVBWUkZnYXZSWDVlWjBpMHk1T2JkbDJyM2Nha0trOE5tRDBkNkdr?=
 =?utf-8?B?eCt0MThMQUJPdHZJVUNwUlV1M3FReHFvczN5TmdsVDRkT1JsTTVpTU5iNnpr?=
 =?utf-8?B?bmprbTlHZGx5aDFXN0pmN0RnQ0o5bmc2d1Iwa1FYcUdIeGM0WmdoSEt5S0FQ?=
 =?utf-8?B?b3IvcVo3THFCRklsU292ZDgzcFVZa3VmMitFKytpSTNKYUNIeEFkeE5ubytw?=
 =?utf-8?B?Y2VJYjFvcDRXR1dkUXpZN2VZeVpud2Z2OXNsR2dTMDZOd0ZyVWw0UnpyQXhH?=
 =?utf-8?B?Z2tDa2MvcklHSDFQdmlPbTl3N0lvelVUamk0dCtITU9neUw1bFZPNXdvTWNJ?=
 =?utf-8?B?ZjRDNU13enc5b2RVdzlJT21oYWxwam5CTlQzOVdUYXR5dnZGTHNSYzE1Y2VQ?=
 =?utf-8?B?Zmd3azdnUnZvQ0JIVm0vR2lvN1JxRGJlbHpBQnRrQWlDSVJEcGVCbVo5ZG13?=
 =?utf-8?B?am5vVm9aNTZ3UkRLek1sOU1QOXB3QzlRZ0dNWWwyM2phRnRzTTZ4VGZ3R1dj?=
 =?utf-8?B?T29WOWdRU0pjQ3JxUitqSk95RzJ1MnllOXI0dk1vUTMyM010T0MweGhrTmty?=
 =?utf-8?B?WUdUb1pqYWFCT0VrUWZBaXdmenpuQmp0enE4aStMczVLc1R0eVdIQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18045cc-4d76-4855-82bf-08de59b47d98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:48:07.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GhO32EgAN+ip/Z2TeUzq1dspVO4yYISl1X917O2oAYr61dgf/QNcf0wbGwYzlk8I/1buCIBjSkpdKtQ9/gv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3187

On 22.01.26 11:39, Tobias Schaffner wrote:
> Run the EVL test suite for some first smoke tests.
> 
> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
> the moment this is used to disable scheduling quota tests that fail on
> virtual targets.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 5 +----
>  ci/xenomai_4_next.yml | 1 +
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 186d1cb..76e38e6 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -107,8 +107,6 @@ default:
>          - report.xml
>      expire_in: 1 week
>    rules:
> -    - if: '$XENOMAI_VERSION == "4-next"'
> -      when: never
>      - if: '$LAVA_TESTS_ENABLED == "true"'
>  
>  .test-qemu:
> @@ -116,9 +114,8 @@ default:
>    variables:
>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
>    rules:
> -    - if: '$XENOMAI_VERSION == "4-next"'
> -      when: never
>      - if: '$LAVA_TESTS_ENABLED != "true"'
>        when: never
>      - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
> index 30ca9b1..03dc233 100644
> --- a/ci/xenomai_4_next.yml
> +++ b/ci/xenomai_4_next.yml
> @@ -20,3 +20,4 @@ variables:
>    KERNEL_VERSION_WITH_QEMU: "6.12"
>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    CACHE_KERNEL: evl
> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
