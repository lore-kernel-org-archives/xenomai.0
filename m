Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F83BB21
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310150; cv=fail; b=PdjxxjPm8oJkGcVMyxdLDf6bzF8CvVT1Dq8ViXuprtMhS8YGnDTMTSzr5f5o5LHKPCNfsdJkyjl3LgRfkcSbmD1uaw1Ir8DPuHH1Qy5RROHEy1X6kJbOzxu1+PuY6NAIm3lpVEWHHtwe1PzNPfYnD+VancQJLwNGO6BZbMa+oCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310150; c=relaxed/simple;
	bh=7nNcSibRdHpqQeAqENTbx4J+96kmB30Kz22m+ykD4+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXce9mGTGDBfLxSLTdAl2sxX7CZAZzL6aWGSAIeEyKBDvytpxQ/1pFCeaW/4xJIr6q/YLwbQx+EVzM6Y8Z6dgG/Q2Vkt+fr1K6uadxyUMIk2PuupKvOlNYyKwvKOCmafePxUTT3GgBt3XjqTvsqeUVM4mVZF0mSTsbMpryHCiVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=c+hzAdpR; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="c+hzAdpR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJxZ0nZhwk4kAqWAkKVZAHVN2h02w+GvXCveMOV5CdS/poL+WSVHaoqS9ZSBLYGTFiguqOgSN9UmUgoxkjXIlsLVrluA984zquylWYgx/O/5BsCNeIuN6aPQ8W5OEjbaWea2M+MN7nxy+OznTNvukqmWt7P2HmcFUxl1kabn0kPyXnvwKG5X8TvY7MwIdeMd2YQ3R1zTASSkArCKTlMYwPDK+mUCDvoVbJvAp+F0bDDs3J1kvMVl4ak3M7wttM/84moAAGrN1XW4cxUTm3H+DldeLktzyHJykbb5s2kZWeFQo8mQIcMRXoNlVMLajHUSpXBrCSBKFomh2O9zN84nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPuK83iUUjcOcCp1L0ym+b+TmSBrlVqGrtzIHnUlW3g=;
 b=mTNucCmy3T5Y2PjFBOhpKOxYuQYgxoFkpsmFnbk2CBCHQKsJJ3h+hTuoyrfKagbqnl7yU1WrZJ+wxPt8srg0CbmPYI9/+02eCySjyy9hNxC4ZtKtpPxZ4Le96KF/1ocpCJ8abqz7Kn3jOyaqukQsF0duOtoHnvmDJgMhasCe1E1ZaN9ZO+AMaazfxYCK2JedNra0nnn/Cd2XHGTTg29LnYyTaogXKMYULxN7TQ7SXZF/iIWtSjUDYgJFzGOd7C8nosULx9jeHoHxzW/piduvA1x5Nk5Z1ZjF71epw2Yz+vD42JLTiOK3oEZkSNWIBGIu4MmAfm6L6eoHLJ7Et/dNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPuK83iUUjcOcCp1L0ym+b+TmSBrlVqGrtzIHnUlW3g=;
 b=c+hzAdpRUuotxhSJQwL4/hqdlbRsEIx5xaHAVBqqTR1qg32p896KpFndB7vovSo34Zkz+3u0MTgQAEYcwc3p5vGDM3l1nA9rSob9qsOaXLMxQc0jNT5+26oYVtZ/gGEdfHWxHlD/h+D1pH/4iEZAQiOOXfeAL2OAqn/VhjrskP6VH7DSjBjtYyvJAtnxwgosAyB7E5F0H9YO0+Ng0AZftSbUXnjDLals/Ml21XwrUGt6oHqn9BSwmBJw/NiKoX7Llxe0TRblSXoPqAzLYnbAdldnRiBLMWhIW/798ksB2NZ6MdnLbTEqwRg4HihPh/3KFzN+hKV1Qb+7H6zYy8O0CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:49:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:49:04 +0000
Message-ID: <bfa82f76-dd5f-413c-9d7a-4fc42dd12368@siemens.com>
Date: Tue, 21 May 2024 18:49:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] testsuite/gpiobench: Fix calculation of maximum
 latency
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-5-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240416085911.62073-5-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e02d26-35cb-4b05-8c1a-08dc79b5ec35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjMxd3MwQ2hkdi9pZVkzcVNmdE8rYkhCN2prdXdjclFlMDBvUTB1ekRsVFg0?=
 =?utf-8?B?d0pSSldadU9vZURwU2dyOFVlTUtmVjZuT1ZMV1RjdDcyTzFrUGdudFpZNk5N?=
 =?utf-8?B?aGpmZVowbVhDNkJ6ZHpQaDA1eERCYm1McEprdnAwVFBmYTdrOVBYTU5GN1FU?=
 =?utf-8?B?ckx3bkxCdEpQMzRLM2ZlcDN1cnA3NmJ1S2ZkUmtLODc1aUxjNXp3Q3FkeHQ5?=
 =?utf-8?B?ckwyK1h4eXJyQXI5eTJoeFoyMTliZGxJbXQxVHphTlZnOUdaYzlmdk9pV0Fr?=
 =?utf-8?B?Y1c2ek1ya0xpM2txQzIvUXlIcGlkU2h1dFZpNnZ2N2grL0VYK0ZTTDFUb1VJ?=
 =?utf-8?B?azl5VnNNeHpwSEVVV1p2YUwxcVF5QmNIUXpTWnZsQ1pkL2RlNUE3d0JQZm1I?=
 =?utf-8?B?bnZnemlxaFI0ZEhsdUNtelBnK2JnNHRtbE9odEJteGtJaENIWE5kWkcydEZJ?=
 =?utf-8?B?Nyt0bWZUeEFKdjVYbkRRNFBqTUQxckJic2R4dVQ0NTY4QWcvR3NieTI2YkpW?=
 =?utf-8?B?Mzd5Y2N6Zis0QUlYVVlkeUZYYXV0TjJQV3IzQU9tQVZGeHdjYWhqb0dVempo?=
 =?utf-8?B?aHBxMVBONFJZTzU2Z3d5QkhvNDhCQ096anNSQ3FTQ0Q5RlZwS3dVZFh5UXdp?=
 =?utf-8?B?UWZHUjJKRERZL1hsU1dLWThIUnZEYWViZ3hraVFPQVpja2RGb2UzYkFXMlpy?=
 =?utf-8?B?QXdEWkJVMDJ1WmwxWlhPS0d6RVA0YlZod09HOFdJMm9KTVN2ZkpEUUFVOStY?=
 =?utf-8?B?SFdQbjRZVWRuNXZWVTlmVjRHS1VXYWFHOW9lMklNbUIyaEZmNTl3TGtmRmRr?=
 =?utf-8?B?RmVYYnlmWWlKelkvYWRaT3RqcEpxOWwrakFGaFF4cmdINmtTaWV5Ujk0dW04?=
 =?utf-8?B?Y0x3S3dVU1RVazNHaThzY29jaUVLVERtam1zZjA3U3RRUmZmSmZTeWFqVjNK?=
 =?utf-8?B?cWFSc3I5cEUvdUNsR2lBZjdTY0VLS1o2UnQxRlZTajQ4WGNpQk8vTDBUT3Q2?=
 =?utf-8?B?QTM4WW82ZkxBVUtOSFFaeWVaRWcwcUN4TmF3L0dYbkhWanRWMk5VQlR3bXZB?=
 =?utf-8?B?MEowNUozVk9nTHRFbGR3WnREMG9DVnJPdGlYTUNpQldaWTRRVElQaW9xK0s1?=
 =?utf-8?B?M2tOYUFaUjJGQkk0Zkdzakgyd1h4QmNrNW5Wd2lXdVBiSWwrZlB3Ym5Ka1l6?=
 =?utf-8?B?Qk9rZExHTWVhVE5ZcGVEeitSK0REUDVrRExIa0ZlT1BUaDFNWVdVWWRtNElY?=
 =?utf-8?B?dFFwWGNsSkMxQzkyV01ZL0xSMk1wd0FMR2kveG5GR3kwRitpdUhQY0N6bUtE?=
 =?utf-8?B?amowK0l4VldjblNmZHVmcUl4bWpRcHVqNStYZXFhYmMwSlBmMFBSaVNSdVVp?=
 =?utf-8?B?WVZXYWI2UW1EaUVpMjdUbkI0STdBSUkxTEp5MDBFd3VRZGhYeFM5bVBQYmwv?=
 =?utf-8?B?OGlDQS9sRENBdWVRY2dpN1NjUzRiTS93S2VXdmh6dnZaUzBxMDA2dmNjYW9h?=
 =?utf-8?B?QWp1NzhwRXhVbkxmUDlEM3hDYXA1M3pjRzh3UzgxazFpTzdBanExWVNkTVo1?=
 =?utf-8?B?ZGhFWklWd01JbUw1QmNNQldiRDRqUWg0RnZaemk4eG9qS0NFSW9OV0Q5Vkhl?=
 =?utf-8?B?UDJKdjhQVHB5SytPcTBsVWdaZGJiYm1oUi9BUHpJUVlHZ25wUzMzeTVuMFpq?=
 =?utf-8?B?OWpwekI3Z2ZyL0pya0JqVFVDb1FnT1FHbURlcy9SbmRITHo3dXRGVFVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxpdmFvNDJKRllVUHlFdzN2VllLc0sxMlpRbGJ2OWh3SWhxK3dLMXhvVkp2?=
 =?utf-8?B?UU9TZ3RNdnk5VW90OGVqVjVKZlg1NnhDN1ZxcmJYZ21YK1NxM21GejUxUGcr?=
 =?utf-8?B?Sjh3VmxoOGw3bXV0RUhpOFVlTFRiVnJTMkVPRnVmQWVDTjdHcTBNTi8zT21a?=
 =?utf-8?B?KzR5VVZlTi9WbEJsR1gzdEtKUEdpZDZqYTNXenJIMGMzcUpYbjNXa3Y3ZjFx?=
 =?utf-8?B?STJCVW1RVyt1ZkIvbjl6THdaL0I3aEZTMjBiZ1Jjbk1jc1lIcXZhNTBlbUVs?=
 =?utf-8?B?WDE1Q3RnMXd1dkU0RG8wa2Jtd0dLdmsrL2krbjdWQ2Nhc0Z4RGRYRDZ3U0I1?=
 =?utf-8?B?RlBWR3RVYWY3dnJsY1ZZdEJCc2lwcndvWHo5eW1EOWluSUVUbzlsa1ZacmJh?=
 =?utf-8?B?NDVFa2RyU1E0RFgwVGszbXFSMFJ3SExzMHNTM2xWMXVaak9HYW53K0ZpQzZn?=
 =?utf-8?B?cmhZNTlxNWJETnJZbEZyOTZ3aEtMK0N3L3hGaWs4NGYxakJJRjQ5L09MdnJh?=
 =?utf-8?B?OFg2VXB4NXplZ3VBU2ZyZmNtblNxaFJKdG0zajNkbGN0N0N3WVpkK3QrUkRh?=
 =?utf-8?B?Q1BDdkNhVlZQamltaGhxNDlJYnJQa1FvT09yc1NBZHZUa1FOMklHSHhMNWpQ?=
 =?utf-8?B?TE0rSnVoamdXbWgyRWN1cnpPcXZhZlJxWlFiL1JwdEQ5MUFwRTZ6ZTNyOWNZ?=
 =?utf-8?B?U1c5M01Od1ZwbGNXODFzZEd2U1A5Y05keG9OenlVSEpVRi9oTms1alNOTnhT?=
 =?utf-8?B?VUtKS3hnQjNFZFpLSkZ6OTM4YlJCbTBGdUZPemJNanFNYTgrOVJWUjZCL3o1?=
 =?utf-8?B?aXVIbVlHRmgvRWF2cEQ3ck84K29Ib085cVF0dldzS0J3Kzd4Ull2WkVXaXha?=
 =?utf-8?B?QzN4am9xay92Nk4xUDRIUlVwaVlJREN5ZFdTU3VNcW03RFVJUEVlRUhISTNI?=
 =?utf-8?B?dVVxMGIxTEYxeXhjczhKSVpVQUxqeXNrRDQxZGZ2SHFiMmlCb21jb002cVVx?=
 =?utf-8?B?dWJSUGZVLzcycU83RFpJYnhBSXd0Tm9ZZmJqcXh3L1lpVVBOZUIxTm42TmhB?=
 =?utf-8?B?UTBOSEVUY3d0eEFvei9jTFFIMlVvTkM4SnpCcVpoVXpwQ2dCNXJIWXdkMzNh?=
 =?utf-8?B?ZXhzTnJydnZ1WG5GcEZjZHp0OE1CVFBhcEhJWE1Bak0xTHdKQ1MxWTBxWkt6?=
 =?utf-8?B?YXpsSnhxcGQ1YzJ2eTdzYUc2bHdSUmRGWEo1Y2pEemJlQ2lyQkRXdy8xdGY1?=
 =?utf-8?B?ZWpYY21Xd0NFeW1jSG5RTGtMN3JScTZJd25Cem54ZnpMTGwraGduQ1I1UFVB?=
 =?utf-8?B?NjljZEcrVUN0dENtbzd4bjJISGhBcGU0SWhGRXRmTGRUM0p3enhDdFE0ckZ0?=
 =?utf-8?B?VFE2T3JZb1BCRElld3BIRXlIcXZKS3d4S0U5Q2MyR21xRFpRMDVzYnhqN01a?=
 =?utf-8?B?anZac0ljcGFPb1VLUnNZL2FaTjlXeStQMW1CbU1LcXJ4WnZSdEh1M1Z6Z0JH?=
 =?utf-8?B?TFEyeTNtbURRdENYK3A4eHdaNGREZGZ5MnlBRkdDZXZvcmJsYzAwZUREWith?=
 =?utf-8?B?Ym5qNG5lWHdnT28xUHFGaGhOekdmVlA5STJvRjhTVW5XUC8yTS9nSjROOU53?=
 =?utf-8?B?dllhcGZzNEo0cVN6aGxBRXg5MEVpMncyYk1GOTByOUpTTDZobTE3NVdxSVhT?=
 =?utf-8?B?WDFyK2ZyVEcwc2hmSnpNbzAzcWJtWkgva1FQdW1sWndCaU5JMy9hMFI1eVUy?=
 =?utf-8?B?WXFXUEh2bG82Y0dLK2l6YmZmdEI0MjMxVFFaMEVTRG9RVEpFbWlHZnhMN3Bj?=
 =?utf-8?B?eDJvbnVlcmhnUDU2ZURHeDcycHhIR3ppY0cyZU5RdlpEbVUyWGJBY2RvMTRJ?=
 =?utf-8?B?QzBzbmYxUlZtRnZtcjhnL0lTWmJIT2ttT3g4cEVKU1VMTjFldmNRajB2eVRV?=
 =?utf-8?B?aTFuZGl1aS9seG9IUWk1Qk01WXBvclR3ODJ4eXVSVzVBRkNDN0NxRFhaUThz?=
 =?utf-8?B?U1hmc1JHbU9LSTVnYjJtaG12d045WjM2SnBrbW9SY1M0N09wWjV4Y21DY0ND?=
 =?utf-8?B?b2lVMU5jNzQwM3ZxdE1BMTJoYXVWQlZZRC9DRmtVTVRNMTdPRUdkMEZxRHRm?=
 =?utf-8?Q?sMdSoc/yTc7lDDU+VXDjLRJaV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e02d26-35cb-4b05-8c1a-08dc79b5ec35
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:49:03.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhaicP3UDIuBGDIBwZLPHvAa9pRegngCGdB6n/UNNGLKW6AVFaAp6QZyjFHLpv9huLVUq0unwbFhzrO+wnpblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978

On 16.04.24 10:59, Clara Kowalsky wrote:
> Fix typo: The maximum outer latency is calculated based on the
> outer_diff.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  testsuite/gpiobench/gpiobench.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
> index 1c525269e..3cc17eff8 100644
> --- a/testsuite/gpiobench/gpiobench.c
> +++ b/testsuite/gpiobench/gpiobench.c
> @@ -334,7 +334,7 @@ static int rw_gpio(int value, int index)
>  
>  	if (outer_diff < ti.ts.outer_min)
>  		ti.ts.outer_min = outer_diff;
> -	if (inner_diff > ti.ts.outer_max)
> +	if (outer_diff > ti.ts.outer_max)
>  		ti.ts.outer_max = outer_diff;
>  	ti.ts.outer_avg += (double) outer_diff;
>  	if (outer_diff >= ti.max_histogram)

Thanks, applying this fix already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

