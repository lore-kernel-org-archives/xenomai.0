Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58112F5A3
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966130; cv=fail; b=J7ILAl/1Vp6jM7nFHYJ1Td77Es3oR51s5A69H97Gq38TutrhulhjoW4Zh4clyoji7BoA++RtU8XrLAdjoUkbjOEaT4H//2X3ZZyb17zLb4Ovrf8zGY+UUA9M0ezG+oWxdkPXOINbRLr+XQEThTtcH/ZWozrHaAH1Br0fe8WF5SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966130; c=relaxed/simple;
	bh=qTFySMZ11GQlV8E5NE3MjYhuTD4hXJBf7bPa/EOCFGY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qU8Wo8i5T3Q8mf973AT5W0z8C/55fD/7fvOINpuP1E5/7+6sn11VlkKnwM5O/kQq7a40hYwiBcQSGTpkwdOXAlwuJum8x9FEZRdliuF/gX+x1X/cS0RQPV888qVkITZSpbFWJPuDXvzYwbsScd45WAVF9PLMLiTJThr59ViawSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DNkfxze2; arc=fail smtp.client-ip=40.107.6.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DNkfxze2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNDv+xSj95To+BC1JmM0vRhbL2PNgCX33cCuRXs5DGHgYv0mga1Egfgky92m9jGYSytpvMxRMkUvWjcOl9WoInmsGkHbwOusSzhZAj9CsWRveXSJC7Xxs8CvuD/UHAJ/WFYGXOOXasYcuWXL/ttozrHJjTmtXDxi/jn4REfl8WaI6Aj+0Ios+WNyO4awFB1Hv2OA+i1mUtJNSCP0VIz9oJDoqjbF0RMqrJVqFkxsi1lM/aRvKbHOMbht3o4jvj9v+ZGiaqmIBFDMyiMxhuRGSbxOJg0NMc0eardsO9Tz+nQhkMlAqG3FpyRE/SKlLlbiedzEJ6ZqQB0vZmQn4LaeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stGneYhKb7j7UQGM+3rqPjOUf36sJk4Vh0tq8BFS7TM=;
 b=GC02wZ5wFcLQ4D/LB4ynFxlWzSEtn1iCZDoAtokKl8P4ZvunSke+/RtJS9kwZfxk4tKbA7dj3c2VWybNRYFDzKsLB94UzpTWuGAGkQ2oR7XvQ2sl5zZML566LHUI7gHuTNaGRZfRKDPf89OhFsZnGV57JaAuH126l+spowtuOPZv/EUa5sSvymHs20V9s2wJnFpT1A9dYUxVgo7srgQBs91TNrQcsldEu5gq5/Z0b+YWb9T6jCOwZ3HMh+u1shQbRgpMeicWx0fuba8+1nxjJ8Yne4j2RF0W5Gz4RtD1//dhOD0BUyRCSzVZB+Kfkuf1c6pXnPLOqRFHEYBOzF57QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stGneYhKb7j7UQGM+3rqPjOUf36sJk4Vh0tq8BFS7TM=;
 b=DNkfxze2WulfXQLPm5ax5h1eGOOfKOZppH3SkK5hxQSmYw75Aow2Hj4Z/+KMY6osbj301olMrUD/c9fM0apgF7dIsRhbX7IdKilx02kOdAeDLbtExPFDIoOBb5YFvXpz5mVQR1US5QUNDcFAEfdH3AAXzayPUQg9OiB/5T36jTT2VN3CrLUAs0dgsnyRSh73G72tpHRKDW663wde5u3HBjdz0MHyqlbPiSfMdSW34t3PUF/Xpn3tDxc+DLfJ2UZSBl2fG7IaGDJyx/XYSJvd43XmLUU0xItQBhJ8kbEjSHpmml0w+DZJB6HZ6hpVytC7zdNP8gkvKMFCFepTgmBZew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 17:15:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 17:15:25 +0000
Message-ID: <dc8d667d-4881-480f-bcaf-c7ac3124957d@siemens.com>
Date: Fri, 17 May 2024 19:15:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] prepare-kernel.sh: Warn when result can be defective
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240517150651.30974-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240517150651.30974-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc1d4e8-d008-4faf-863b-08dc7694f117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2RXUE1nekRNQVRoZUtiRzV1bWdtQlFldG9INTZuMmh1UnJlbGVKbXRrR1pl?=
 =?utf-8?B?L1RhM29FZFBsUGRxZmZIZ2hEbDhjMUxmVWxzbWNkdHY1WkNOcGtOUFd5UTdX?=
 =?utf-8?B?eStGbERTYUVRN0orNUlmeUUyWGhhMmlsVzA1MVFSUklUS3NzR21Wa09ocXJ3?=
 =?utf-8?B?VEFpcGgyZFJEd0lyby9KTDJUVVB6cDNwUWV0UG92NDJ3UVZwNG5Ec2drUElB?=
 =?utf-8?B?K1JpQXhXRnVJZ2syWVRrRUp2bzErRXBmU21xc24vWGNlcDJidTF2T1hPcjhs?=
 =?utf-8?B?N3Jzdnc0dXhneTlkcndLMU1tbEZhazNVbjRheU9CK0tJd0tpWks0YjlwOEtE?=
 =?utf-8?B?WHlzdHVab3FYZ2tCRDFlS1lzTER2SFl5U2d2ZjBvajVHZFNYZXA1a2VTVm02?=
 =?utf-8?B?K1V5SHd2WlFnSm02bS9SMUlQQkRaWkdwM3I2MEwvbk1GaFNwanNtOE1YRGFT?=
 =?utf-8?B?TmNtWFdkQlRaMld4WERnclpWR1ByamY5emhqcmNlYkFlazRrTlJWRHVZZmc5?=
 =?utf-8?B?UnJNWVFXUlM1Qi9IelpQWmZYWU5sdENPSWZBTC9yODJYWWhlOXBlTWY4cDRN?=
 =?utf-8?B?US9mWjFMMDhlaDNKb3hwbStKVmxZVDlFQVpEZmE2N3k1NVpKTnF5a3cyT1p4?=
 =?utf-8?B?RmQwZGVHb2x6ZnVRcEhDeElnc2hxdFJPU1ozSVlyR3BRMnlCdllzKzJhWXZx?=
 =?utf-8?B?RUpjRTVweXpJNFVQVTZJbE9QUWsrbTlWTEl5M3pmVWRIMlJCdXd2Njc1M2tQ?=
 =?utf-8?B?V29ZTlRFZENsdXFLNTgxL0VWVHdxZVhoV1JhUnE1Q2tRRkxibEJDV25laXg5?=
 =?utf-8?B?U20rSjh2RkxXLy9TeVNQdTFvUzRlTHowWU5TQTN6T2lKTGZ2Q2N6Q1ZDOHYv?=
 =?utf-8?B?SVg2eU1rRGhnRStleGU0eFVxQ3VZejREa253RFFQZXVTVmlPUlI0dmZQN1p6?=
 =?utf-8?B?QUFiaElxY2RTbWlWckh2ajlHZVVXL3dqYnVTN2QzU28rR0x6djhOZko3c0gw?=
 =?utf-8?B?Ym5vMzF2RUR0MzUyWVVTdnNJeTgxSXlLdjRnVXIvUSsxdkJ0b3ZoZGhLYk1v?=
 =?utf-8?B?N3E1N0VCNXo1enVlMUo5aldUNkZmZk0rSHVFZFBHWXVkenM5TWpiZVhqN1ZL?=
 =?utf-8?B?Q3BFREM3dU1kb1ZVZ0c5OEJHV1J1bmZ4WFRiTVZlZWhhb3lRd0Y0SVpWNVBS?=
 =?utf-8?B?ZkdtenZuUkpheXAvRVpCTTUrR0tWRnk0SHVBeWtMRGlGZ1hwTUtxUTlib2Zl?=
 =?utf-8?B?emIvdHFvNG9wYXprL2pXWkl3SUFMdHJZcU1QVXZnODBRY0xuNnFJRUEyMCtM?=
 =?utf-8?B?UUFjV0x2VENVZ0xzNEQ0TDltZ2p3MFlkNmdLS3V0VnlNdXg4anpPekhteXgr?=
 =?utf-8?B?WmF0RFlPaWV2U1gyMWI4dmI1aGRtOERyeEk2MDhVeTJZcnNLMTFLcnNkZFF0?=
 =?utf-8?B?QVJENnRILzJBdkhsbGM5TTJ3aDNyZXZNU0J0UGdNeDg3TXl3Lzh2cU1laFBh?=
 =?utf-8?B?Wm5BVUpvcWl0UnFtOWMzWkZkSW9CTFAxUDczOUd0LzgxSzFzZkZRL2x4b3Vr?=
 =?utf-8?B?NXZQUWpBUTNnT1VaVThUWmNYOTNEYnFlMGR3Q3lISm9pZGdxaWVVeGV2N0VC?=
 =?utf-8?B?L0gzdmMxbVhZUWFDRzlDdG10dGlzb051WnlGY0dTazdiVE1HMzg2QmJ4ZWd6?=
 =?utf-8?B?ZUg3eGpSemRUVzdaSmk0QWJHanFDdkhoU3VtSHBsV3NLUFVrMU1VTGNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJzT2p5bWIyd1cveEIyQnN1d1JnR3BwOFdDNVRDWmE2aFF3eVk0ekFhVFhk?=
 =?utf-8?B?dU9KTUZjWTRCemNkR3dMSXhxcFhjaENFck0xZTdNeSszT2U4d1RYaHJBRDE2?=
 =?utf-8?B?WTg3c2hqRjRpKzdKWGFlVDcxdTFhc3dvKyt5M1hVcGxPWC9pMGhDckhSVDhK?=
 =?utf-8?B?K0JqY0kvZnJjeTJWK200MFN5Q01VdXNrYjRPb0U4QUtoT0Joait3VG8yeUMx?=
 =?utf-8?B?WGVPU3U4RFJXZ1llN3V1aVhFajZtMzNwS2RhVVRkVnZTNjZ3VGw1RXYxV0t2?=
 =?utf-8?B?NkZsNnBPWXBGTTFaZ0d4U0tvN2ZqK3h5ZjRxWFcwcjFSd3F0VGxXdXAzUER1?=
 =?utf-8?B?VjR5UmtzSjE2RWtxKzlXTmhObVVtRWE2SEVjdzVmQjlPVjRsMU01M0s3eWNZ?=
 =?utf-8?B?Vi9PVStacGxRNkZyYVRGbHV0L0s4K0x1WkdIbnpVaHhxSHUraEhqNVFtQ011?=
 =?utf-8?B?WWJwVFVwQUlXbkw5UFo0Y3ZSbVBhRzBER1dQSzRwNmQzT0IyR1JuRzgrMi9w?=
 =?utf-8?B?STFsaTJlTS9iYmJKdFgzWHhuaWFNckVTejJySTFDSjRITjdleGp2d1dxbWFC?=
 =?utf-8?B?SWwzVE9IUHlCQ3VCSnd4U1lxRFI2NTN1TGtSaVBmdTRxRGwvNWJGNkpJTnFm?=
 =?utf-8?B?eGEwWS81eTJDRmEyRjQ0a0xMYzQ4N1BIamJrN2tPWEN0SkVkMXBLVU9hbi82?=
 =?utf-8?B?R3NabThhcG1HMWgrV1hrd0psVGxsY0hUSzJqcG9LZTcwc3FrM3VGMzB2OXY0?=
 =?utf-8?B?VDJjQUo2UTQzemRBMEFTdnVsQXlUREppS0gyMVJYZ2ppcmVTMWxveXRVb0J6?=
 =?utf-8?B?RTBhaDRsMGMvQnFQeHRWNlh5MWVieFBFOC91NTdXYWkwbzY5UWlGdE1pTTlT?=
 =?utf-8?B?aUFGS0R4cXpocEVqazNIWkdxYVl1M1J3SXUxZGxuODRpUzBFS0ZqeFU0T3hB?=
 =?utf-8?B?QzVra3JOeGlRUEhpV2ZxaFlWeW9Ga2l4WTdIOHZ3K040bXB4WVFGanptY3c4?=
 =?utf-8?B?WWN5Y0M1Y3dhSWpzZDRldU5XdGdwUENKN2I4K0VDeFFlT1Y1NHBqTjc0QUd4?=
 =?utf-8?B?Q3dUSzR4UFp2TkY4SFJHVlN0Lzg4NnhEaEJMWkp5Z3hXSmZIMk11d0d3eDZM?=
 =?utf-8?B?Qk1oYmVBY2ZYNlYvQ0NQWjJtRGREclRPdyt6eDAxYXVka0dtdWRma0poeUJs?=
 =?utf-8?B?OXQzV05XYmxEQ28xdnNlejZyTHFjdGJySHRRNVVZYmdlUVVmYmcyMHhMd3Za?=
 =?utf-8?B?aTlpMjZ6MU9GZG1QcHFaRm1CK25hYmF2cEhkb1lvL3BBWmhIU0lNOGJ3WTM1?=
 =?utf-8?B?VC9McjRmZHZkUXU1NEFydU03dDFyRUhteHBsQWpHMUpxcmxEbExxYXRQdXFX?=
 =?utf-8?B?RW5WeDZOaER1dlkvRGk3dFdaQU1Oc1V2Lys3dXgvU1ZsWU9oK1Bjd1VYWE5z?=
 =?utf-8?B?VWZ0UXA4M3Q0RWRHa1grdjByYTdSaEZWTWkxc0Z0TnlTUnR5L3J2RFVJZTZI?=
 =?utf-8?B?eEVFOURXV0JLMk5kb0xORE1KMlptdVdLdFhIQjZjM2xJcW44QzZFQ212b1U5?=
 =?utf-8?B?b1BCZS9ER2ZFZnRtVXJMQW9mcG1uakQzUnFOUUgxWklLMW00V2NSUVdkb2lG?=
 =?utf-8?B?Y2dmamJCejFtUUQxdFJ1c1dsOXhpWVgwUjdmZ0VkYVFqNnM1QUVNbnphTGl1?=
 =?utf-8?B?UHZFRVc4MzBlS2Jnb0Y2MENwaytyVU1NZGlKZE5rNW9lQ09DVUptNzYzSXgy?=
 =?utf-8?B?ektFTWRVaFBVdGhBOTFtQTkvTG1iV3NXY1pvSFVEWEF0WmcyeDlXNDQ1NktK?=
 =?utf-8?B?Ym5EV0RWNzI0aHdCNVpRNEFETFBaSjVUd3gxajljZ2QvSWk2Z2lUamUwUmhN?=
 =?utf-8?B?ejBCUzY3WGd1MUJBVFlUaWZyWVR4Uk5OU1hOcUE0U2YzcDV3dkxrbGo4S1I1?=
 =?utf-8?B?MDNsczllTzNhTkZDWnBVNEU1YzBvWkREeEdDSldqbVR5a0NKY1ZwWnVwV0VO?=
 =?utf-8?B?OUdFVmFGbUxveWFYRFp1QkJqUmcrdXJ4ZU5MT2V0OHdObmROenNHY0ZWamV2?=
 =?utf-8?B?UUJaOHlVb1NTd0NiN2ZJbTE2NmhhN1ZXcnl5VEZhM1RBcFFPN0lscDZLQkZp?=
 =?utf-8?B?bENwdlQza0Z3QkVTZlpjbFZrcW9EVFVhTDB2TG1VcGJ0eHpqNjhEMnVxRk84?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc1d4e8-d008-4faf-863b-08dc7694f117
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:15:25.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMUanxxRrokFK511fkgLIOAPSyKgdEdHhQwMphw0tdgNMFXh8DhBglNVT8kb4k+TE/gHna6E6OnG84kBqhqvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6304

On 17.05.24 17:06, Richard Weinberger wrote:
> If the target Linux source tree contains stale files which
> are owned by Xenomai, the result can be defective when --outpatch
> is used.
> Detect such situations and warn the user to avoid crazy errors.
> 
> It happened to me twice that the resulting patch was faulty
> because my kernel tree contained old Xenomail related files.
> Hopefully this saves somebody else valuable debug time.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> v1 tried to be smart in link mode too, but made things worse,
> this version adds only a warning for outpatch mode which is
> the use case I'm actually focusing on and initially faced problems.
> ---
>  scripts/prepare-kernel.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 0b11eca66..b609d9998 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -126,6 +126,9 @@ patch_link() {
>                  fi
>              else
>                  if test `check_filter $link_dir/$f` = "ok"; then
> +                    if test -e $linux_tree/$link_dir/$f; then
> +                        echo "$me: warning: $link_dir/$f already present in Linux kernel tree, output patch might be defective" >&2
> +                    fi
>                      mkdir -p $temp_tree/$link_dir/$d
>                      cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
>                  fi

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center

