Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09D20C029
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680010; cv=fail; b=O0Ivx/c2hbK4MOlyeKxPXxQetKUzgEEyu+Y5vlVU3bGsQy9DPlBDiZx3LA43UNg7UUPn4lKT5Byq6+dtCHQhbQG1zwljYajnvR0nfw6W5BwwUPpHco0crxT+U1q3YYRpffa9FCd0cR0AAHyjk5ZZaebVAkkeHbVb3C0NdxsF6WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680010; c=relaxed/simple;
	bh=hvfOlplqGMBpe/Rr/oriyUDzQOrDaUyTC1C9uARLdHE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNe6HA3PzXkFWSKkFP6kHvaftBLNU4kZi1nTpSx+bVnDE5bxqrz9LXz0sMZNuJJDKhXS1HLgm0HBbjPDloUDqtXHWkbSw2usha1o5cftOb//pH7qYoTlfoofuxPNvTtlKqnvNbxQFXJJE3OdVk9MeqqwPJOnXn/PNOC2ILMv5Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bRdahGyg; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bRdahGyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOYxR8WK8+tkoZI/jUeEw6EAGwljKOdUbSxWZFaoHC8TNmJjQ7AShc3m37xruAhzRSWcIOXv/IdDwCgmTOBP3lIQmvZeH6ZWml4RX7a8qRqlt5/pMYmbBURb9ZCkxl5SRjMuKuttioP3Y9Sg9ZcNcujYK7ksqnodMbI510e4loCKMSRXCtDSvxktxX310y/Y3dO/NziWfHx3/WlPrkSxkwu+vF+iRnV/QGyGTXMz/K0rPI32X0FIOeXIA6Xca7xVl1bDT7IvayXdFNty6o11wt+U5tZeGirI8mHz0GacdbQq6l3D5C8r89UWwtJ+Y5xzqUPA2bcXCktl7vDJZj4Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da5QmA/6sdADmu/zgJM7G4lw06V2BkBpHbn2Xwr55kY=;
 b=nqTh8KeyUVpi3P4CCYRO+0zH4Ao4gKU6vCbW0ksOgb0+jOTqxP9xHIEUHtNdHwCuF7tQ8O/zL0dYfdODJYYxlNvsuqUrJMiRWtKCkHvgF/CH/x+HtlEf0Jnp3iCFfnY/s+f6vmDJvfLMkPYpcFNuIPpvD5fRZ1QnxmQ2tClDaWirb7YkKl66zr9UldpXwzMxIL3qTSEg4otHGJNmBa5WXJr90BJmrnl5rYwbZPgttHOEn5YnPXRHO+Uskn5x0eTITBKTjadFcra8Aykd6YrcaXSjvwgtw0m49p2Bo++Fi6Yg2jKuCV8DsEzTQgVvVrV66bfFw+SKZJab89Yjp4hAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da5QmA/6sdADmu/zgJM7G4lw06V2BkBpHbn2Xwr55kY=;
 b=bRdahGygitF5DZFPmCaVuQA2R9S5V1U93MuWZuAHEgHRU7exCpn7U54dI2BbCd8RpWKhIdQOVntUwsQ74/rxYjfnIx3sp8ZdJsEYtZ92mKPSufmmB6v3hZ1+jiWWlZb2yfi5RVmSfjSzKtM77G+F1EPYEc/k6+lvN5Y/UyI/eAqSlMiUSj/OXE6wG/4sAE0vgcCOPfnHhpFE3f81DzXMLXqAy7zu8COT3mTN2QYicLvDwuQrF6MffzJiFXIS2BZOdvtlpay8m0oQDj2++CLaYXkq8EmN+yannQMDcU15C58aR96z9aLY+BhYh4kFrQy7rEG39UDL3L1VdixnnEeqBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 13:46:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:46:45 +0000
Message-ID: <711bb1b3-2a95-4719-8290-02a29bf547b9@siemens.com>
Date: Wed, 13 May 2026 15:46:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] utils/autotune: Fix compile error seen with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <20260513-wip-flo-gcc-16-v1-1-120ae1287401@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-gcc-16-v1-1-120ae1287401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0695748e-c756-4bcc-3ebf-08deb0f61297
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fZRRzDF9QIpOsQoc4/XMApGSVy08JNMmunOjoyO2Gmj7oKBOZkpOViETLctvmBFbBiAuLlGhgRHbB4VDSzzg6yTyvTUN69GtmNrIdBccGQ0ckLJqjH93zYg6TONamPRmt+C+WaH6xXp0qYWSRJra/TH0HKsvaZfwTZ8cAmAs4s9ysUeKRlXt44uWnY4lY0ctR1y83I7cOy61W3Ih6BHMfs06coKvuTM5xT1u+cwWc9uHcpuvCKgr2U8Zdk5VEAPiuJ331Z0RiaX1mtiSjM2kf+jq9sub1sye/mrJILwoKIJLra9MS8gPzRnGoxEkb9hL0X9KHSUCkPVjWaWmr4RTEeNQehrc6U21YNSg+PncJ80YzRyHlejdfvexOZDfmb7ll4KqtuQrAX26SCOvFzcs+bdy26ALfaUKcBsh9STdct9Fb9aDorDzJneB6zKuUiSZ63s68vnWdb7Et+CMNAQ6IATqFOy7ytF/QM2SGc88ftF1z6PDqAF3pRFiMEYoe5QnFqbYrzPzviP/PdccoZeVbWt5D97ukYK91SGj/5nF8TgjGodH6amX1kpWGfr219xxjsxNQwpaNr0VOt/vwmbZst+1/e/is1RveVo/NGswnVWFfStRgcDjTVUQ/IRLC/Ix4/v+fPZ9XbbFqsOqufbRq0W5zoX+zUotDVPmbjdFvmlP32Pur5JW6+K9T04+SW85
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3ZrblpSWXZSQlZkak93NWlZbUl6ZHY0VnV5SDlKOVYxeFd6KzNobUVwR0F6?=
 =?utf-8?B?OGc2ZDFaYlBQanFPUWQxdGcyby9TVmU5R1lySSs3d3VBWStRWkZQWTdCeGVZ?=
 =?utf-8?B?Y00zYi80L01UakdDakZoQ3QxK2x6N2VZYTl4RHdLQTZhVXZRTmQ3YjhJNXdN?=
 =?utf-8?B?cnc3bHZWTElvVThqRWVvSzRuVndEZnhiSGw2b3RJdEJpM0U4eUJiejNUcXNj?=
 =?utf-8?B?blI1YjJodXREaHdQRG1PVThDdnhjaWw2TUxFSkNIZ0pmMytpaG5YZ1B3OS9o?=
 =?utf-8?B?dVV1WUlHVS9vMVl4YkdXQkdOQ0RUNk1vL3NyQ1dRSlBmb1lFdzYzYnVEWVdP?=
 =?utf-8?B?bFdwK0VqbHpUUjNjWERmckJlVHVhamlRZFZTVWJpN1pxTStKWndWYllsaE00?=
 =?utf-8?B?VEYydTIrV2ViQTcrTW1zREpQdGF6bkU5Q3Z5amV0R29QNVo5UEs5VzNNU1Er?=
 =?utf-8?B?V1RndzRYWWJCVzQ5T2xjNWJKSzl5bnpTMWtEUGRVL09iNU9NcjUxL1dHRXVs?=
 =?utf-8?B?Mlp1amVrZWQyNEh5Q3hsajllSmtLRUo2clZWTEpnbW5FLytFbXA2VlhUclJV?=
 =?utf-8?B?eHRlYU9ZWnY0UUl2eW12M3dpdnl1UmY4Y3d2SGhSWlY1MUd0d1VHckpid2pY?=
 =?utf-8?B?RzRXMWhxUFcybVVQVGx6K3l6RGFGNHhHVVNOVW1weXpmTHRqanV2YWVsQ0U0?=
 =?utf-8?B?NG5vRXJXSkthQ3c1Z0hEVE5aRllHM2phWDRKRjhUUjRXMkllMVZnVkF5UXRE?=
 =?utf-8?B?RFl4TE1qL3dIRm8rdWxlQWN4cU80eEttWmkvbWRoREtRZGExRjgrV2J4MzJ2?=
 =?utf-8?B?RzRkZ3pTSUV1SlZ2YjYvYWgwaHA3dzJxSDZETmlEQ1VIZU5lWUl0REpxWFhy?=
 =?utf-8?B?M2djcFpJb01IakxXc1Z0RzB4bm5qVjdkU0NBdGZpRXdQSjd2bldqN1F6WkVC?=
 =?utf-8?B?VjhMd25UQ0lEZU9CQXNWTW9aY3dlbGwzZVJKejFJNXJmd1R4M2IrRGlHN1RZ?=
 =?utf-8?B?cnZMb000YUFOa3VXQU5Jb3RvVWg2M25lL1oyc0prNmtrYllWWFhmekhsK2Fr?=
 =?utf-8?B?MkhRUXFaTGplOVhLNWE2ZkJxVHRiaU9kMkV3ZFp5bWJQa2NNcXRib29DYzBC?=
 =?utf-8?B?RjJpSHpZRFBwYm9USjgydjR6K2ZKemJOREt5YkIvVHA2SldMdEoxcEFqektJ?=
 =?utf-8?B?d3FtNzBEL2E5L2I3ek1MR2pKWmZCa2ZoMzErVUZtc1RFYjJ5cmdEOTE1Z2Fj?=
 =?utf-8?B?VXBPejJBN0dOY3N4RDN5c0s2NVN3VDZnZlYvYzVET1pSR3kyUWw0elBOSmpW?=
 =?utf-8?B?UHN0TW5LNGxXSGkvTVk5b2swOVlhSkszNVh1TU1SOElSbGtwSUhSbUVqbERZ?=
 =?utf-8?B?aFhkVGI3em5NTmI1N0hLdnZjZE1kaFNKbElWcWNhZlJrYXlOUE83dEZra1VB?=
 =?utf-8?B?YktsSDZtaE44OUJyeFpabkFIRVlSVHdrc0dzdnNoZlZ3THJmSFRXUERSRVhy?=
 =?utf-8?B?MVB4TzRrcTBacGZpaUpMWVdYTXN2ZmdjamF5WkpSckZJbTRXbWJvU1JMR0NV?=
 =?utf-8?B?R2I3TDllTDFpMjczN0RFTFdtMi80MDhod3NOMUNSZG5rWHd3TjYwYTc5SC92?=
 =?utf-8?B?K0JnNEpFY25HUm9JM3MrdDdsR2xGOHl2elcybzhhN3ZPSnhxU1M0OTBRc1d0?=
 =?utf-8?B?dkFnN09RaE5IUEQzeHI0N2hWbUhHYkN3RElHYXlaRW1pZGdXd3BEYS82eVRV?=
 =?utf-8?B?eGFub3hqTWdraDVMRUtqYTRHdzFGQm5IR0xTZDJSK3hUTGhzMHdZNC9VS3Ur?=
 =?utf-8?B?Uks1V3lCcEJrcHkzRkdqQzJxZVUwSXdoa3FxUzVlR040Z2ZTVmFYUUQyVDFs?=
 =?utf-8?B?eDAxSHJBckxhM0k0bU9YaWtqVTNzNVMvTWNnS2VHZnFXUk8zZVVpZGhVMTRP?=
 =?utf-8?B?MWdQeGZqdEdGNVZCRit2V1hsQ2tJSFFyMjBZckQyMTRXY3Y0L0FLdW5Jemg3?=
 =?utf-8?B?SThmVEpiM04yUEx0NW1QQ200S0tJbkNCZU1OZGg1VE5VazdaSUJWeWNCR2pM?=
 =?utf-8?B?SkhIL2padXg1YmdIUmhYcEI3SXdzL3lrNkdSSVZCN3RxUnpLOGdFWkVHNSt0?=
 =?utf-8?B?WWd0MFppYnl3ODllU3c5WFA0V2RqWHd6a01YWjg1emY3K1ZFKzlVWURBL2Nv?=
 =?utf-8?B?QzFiTkljUFFkcUs3Rk5vYkp2WEwvdzRmSnlEdzlyb0gxUzZXODZ3U3ZsRDlF?=
 =?utf-8?B?d1gyblVLNlJ3Qnd6YS9ZTnljbHRkSXl0L015NmpXQkRPZ1RieXZWT3E0eEZZ?=
 =?utf-8?B?NWNsNG5LV0NGdmZRTnIrR2pYbDhKYVZrZ2MrM0ZSeDljYTM4RlNIUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0695748e-c756-4bcc-3ebf-08deb0f61297
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:46:45.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OZqwxWJA/5tBVh2w6r5NqZ9p6Fsaz7JwBb/+vegIEYxIn1PA6F/K+v3pYYFq0sVLMBqNUduQhqnLqKI9WWA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6689

On 13.05.26 14:50, Florian Bezdeka wrote:
> This fixes the following compile errror seen when using gcc 16 as
> compiler:
> 
> autotune.c: In function ‘sampler_thread’:
> autotune.c:95:34: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>    95 |         int fd = (long)arg, ret, n = 0;
>       |                                  ^
> cc1: all warnings being treated as errors
> 

Will probably add the note here that this variable has always been
write-only.

Jan

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  utils/autotune/autotune.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/utils/autotune/autotune.c b/utils/autotune/autotune.c
> index f52733b7ae1d5a920fc7ad79c7288001dfeb8f21..2e25daef964beb96a8744e50f5ae9c62c04b64b2 100644
> --- a/utils/autotune/autotune.c
> +++ b/utils/autotune/autotune.c
> @@ -92,7 +92,7 @@ static const struct option base_options[] = {
>  
>  static void *sampler_thread(void *arg)
>  {
> -	int fd = (long)arg, ret, n = 0;
> +	int fd = (long)arg, ret;
>  	__u64 timestamp = 0;
>  	struct timespec now;
>  
> @@ -102,9 +102,7 @@ static void *sampler_thread(void *arg)
>  			if (errno != EPIPE)
>  				error(1, errno, "pulse failed");
>  			timestamp = 0; /* Next tuning period. */
> -			n = 0;
>  		} else {
> -			n++;
>  			clock_gettime(CLOCK_MONOTONIC, &now);
>  			timestamp = (__u64)now.tv_sec * 1000000000 + now.tv_nsec;
>  		}
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
