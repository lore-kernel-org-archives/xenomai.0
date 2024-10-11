Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946239FD6
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659278; cv=fail; b=GWCpvBAfU5x9lF8gd8upf6mV95KHuMoT+l2CiK4VUYUqKUbnjbyCatpCWf3MjMD74peoQ5vsLI5O5GtbpoL5k2TeOxwYBkVNP4bA3cWNV/TQfVpXwNWoqbLMyUlLkENwqwt9CMTTAOTZVOUKxGmODfZnRaTrdklyWGxW49sh8yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659278; c=relaxed/simple;
	bh=1sZLoKxXcnvir88byjbf6jwcl110k0CHrxfOHH6rpiM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DuPvNwqvv19xPFuZkLyR8ch3CQenngZbQCUa1pRvuGYnjS+Df3PDkYuIXE/R2Wrc87njfK5EwyS0w67s3iZSu8J0uP4T2eikgeEn8B2hsrqoTBsd6HTpDGgdjtuFcp6PHF/9oU9gmuVpjD/gCTPUqBS/zZpXOTcsNftNgMiHZFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZCthyLYI; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZCthyLYI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbqEDI7LgENH3CD0smeHklt8h7LvyRS4FuaRIc+Vv+7xbnTtmnaPIjTOrOpklS0iUXOfoQMGslwABmoDJTYTZtikfokiy1lPUWXjNQc7dGfXC/MiUr/bvwkjIsF+Lv7n1ELnEok//9RmW+31f7l5BpH9sRRaFIavjRlNOieHv49rDoG78MIb4/L6wcZVPk8Hup5hu3WkyxMDc4+PDQEjVmPgsU0tkkzyABBJ+EGtQEkjh6efHwUYV2MreHrklM1X4YiZeQbteM3fUu4Lz0ZqyAkKd34ZOinxGdnXQVdjy53+qKf148Fs0O4l5VaScjGWGTMZh89fkWVNWZ+qKK404Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW2GlxO7OaO2iH6OphHI1gxCXTgkGXkoT8SYK3T6mGU=;
 b=As8Z++4BiwcvsB4FY3FZkW90UvQ8r7ICJyhQpWpEBICEpDNBdpudwmUt9kdqWRMSgHJJ3CQCfdVcIdF1DOeZHWHlDjTNy6iTHcaCYN+eSfHFH+LnLN381CVC/C3Xa1NOl78nvV7LwGZueeE7mTd5uIR9pL3p/q+Y2+kUzgnslbbLrAUNdGsDaduyxnLL0+EjHuZJxjAIkgCX8CjEjIsVHXqN8St5IChbBZrhH4y6oS9dRSvMcd0RiA8dJ7P0StxAsTdoqwf59NmRVpTZ0GpMic8fsSFACVLuPqNmm3abbozj4Kj85TZW1/RHuKExAVaxxGcMBRcLCemvbi7E7mvt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW2GlxO7OaO2iH6OphHI1gxCXTgkGXkoT8SYK3T6mGU=;
 b=ZCthyLYIQD2DKzOkzodXTuRibIUkYudTcFGUSvtuAl3Vd9IOcwgxBCcXFXpXqQU7c7sIJNKB3Am8OgF1BWEdGjXN/R1TwV/JUhOTpvB1zc2j9JJ1C9CteODkh8fhMY+SUL5Oa0hF+ntew6dVp4gYPrCWoN2b1NbQyx8XIx8Txle8/vMbf7Npnj0ZmKbDGAuE1aV+6nNACCRNRtyFeRbvBKG6tbPpJMze3HxpkTikBLTs5tcmHlNfezUYpR7uwloJCj4X8B7NTqHlIOx/YpmEJkkp7Vhv7/kBeebXTc4cPLK/hCNjddVYIIZ5CNNnnOBKwtKQ8uY8+PfaQOgATut5ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 15:07:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:07:51 +0000
Message-ID: <9ede313e-8e45-45f5-85ee-5bfd32ebc5f4@siemens.com>
Date: Fri, 11 Oct 2024 17:07:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Preparations for Debian 13 / Trixie
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e2236b-e3e1-4582-9309-08dcea0679f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1d1TzRKMGNRWDFPSjhSemI1UHQzYUI4dktTRjNnbWZtb1huY0F4ZlppWThP?=
 =?utf-8?B?ZUg0dHlNZnlCODdLd092S05uaGg4a3ZQWXNGZzBmV3ZvOUVwTG9WdUxaQnhv?=
 =?utf-8?B?elZaZ2pEWWxuOTlwcEpmWjB1VExJNlhFanUxTjZtdDJUWGJJRnVYT1paMWVr?=
 =?utf-8?B?MDNmNGRMM2V5Nm1QSFhJZGdxbXVWSHoxV09jNTY2akhQdFcvaEJTemVaWGl2?=
 =?utf-8?B?N3N3SU1BSDRaQUZITGk4NUdmVnZDTHRmVlNFUUNGZ0dOYitDdEZocWM1L2to?=
 =?utf-8?B?RnQ1RHRLRGJ0QzBWM3BkdkFISEREZThjVFM0WHF5MCtZUjYvZFBmRXdEbEEx?=
 =?utf-8?B?S29jR0ZYVUl3L201TlB4RThLaUFZRHhad2t2dWJYYitSeWNCNGk3MEpIQVMy?=
 =?utf-8?B?Skw2Tk5XU0tCZTY2K0ZMWFpYNnZFSU9ML1NZSWFQeW12UjQ5aHFDYmx1NkNn?=
 =?utf-8?B?YlBpSDVYdDA2Q3ROdUJuWjNFUEFjaTJ0NENrUFhMcTQvSmZPa3EwUjNGSGF5?=
 =?utf-8?B?eFYwMEFVa0tPMDZGNG9XN1FmM2JKTlFYU21zK1ZQMzFNcFlzNEZVUTN0Rk9p?=
 =?utf-8?B?STFNK0NXRXM1b1pTQ2Y3d0VYUkJpclNzdFlITE50YWFiN2Y5SkdCOXBjclNq?=
 =?utf-8?B?WHBzbEpYNjJ5OE9pNHlzcTlkTlh6RkZra1VPMXl0RjB4SVU2V3o0M3lhWFgr?=
 =?utf-8?B?WGNSbHFvd0IvZU0zT3pBQWZ4NEl6QlVDSWdzT0l4OERiRlJsSER5ZEJMUXdz?=
 =?utf-8?B?aFk3UHUxbXpHYlBrTHhkbWJzQWRYMlUvSm9sVlU0Q3dnQzJpbmxITTQ1UU5u?=
 =?utf-8?B?VmdHVzYvMDFGcHBuZWtOS0hpRU5PQW1qS2tWWXNpY2lpR1dqbVZZcHN3dkx3?=
 =?utf-8?B?RThhTHkxK2R5a00ramRqSnlIcE1wOStSQWRmZExrQTJyMzFKSXdvaG9pMkVD?=
 =?utf-8?B?QlgzMWZwaDZIOG02VzBiN09paHdxWGVDVXhhSjFLNkt2blo1L0pEL3ZkbTQv?=
 =?utf-8?B?aGxZQnZnaFc0b1NlYURONG12Y3cxeE1ZQVVqMTFaY1plRjlLR0txa0dha1BI?=
 =?utf-8?B?V25RTE1kOFZUMDFIZ1lRYjU0Tk13TWxURFRYSnU5QWJaYWF5UUFXdnM5emxu?=
 =?utf-8?B?QVdkSHFLQnd0ZmMzeGRycXpKWGM5MDQxYVU5WHcrNW4rNjlYaTlYOU9ONzlV?=
 =?utf-8?B?VEpyOUNrRHFjbjFPcTM4U1FvQjQ5ekFUOVJ3Y0lCVjA4aFBVTWV4djdVSDdQ?=
 =?utf-8?B?S3FGYUNhbkpoTkswUDlSeHNMZG1oVkdDWHJ1TGxYZ2RkQjBsek1YWTJjVlQ3?=
 =?utf-8?B?aDB5NUgwazFVMmt2aW5BQkVHNTA5RTdoalpMUURnK1R6akpudjlDT2JIWmhB?=
 =?utf-8?B?QnhkN1lQZklJWGtwV3hSL2w0SllSSHBabVVTRXV1N3ZEaE1NZHUzT0lGU1pj?=
 =?utf-8?B?ZENvTkoxc05ucVlVU2phM3FBZ3M5R2xnRVU3c0FIU05Dd2VSNXhrK254c3hP?=
 =?utf-8?B?eUVDeVhQSVBsTldrQlRrTngwaUpiUEpJSm1PK1RmcEwyNDFPT0pSR25scXov?=
 =?utf-8?B?V1V4dWt2OSs2VFllYWJ1K0F4cmRwUGhHMUptbUxxOW1NYld6cXgzZUgzUjhx?=
 =?utf-8?B?QTVBOFFBcFFVRDhuWjgrVkdxODY4bFQ4YldDRG85Z1dvaEEvM0dQaWpWak40?=
 =?utf-8?B?K2E1ZXBmQ1VXeG5rZnJ6UWczWnFSQWFZNUxoY0JJOXZRSU9hQmxqU1ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVMdHJVZkFxSHNOYkxOSkFvbGJseXBHSDI5S2Y4eXc2ekpqUlhSbWZvU1Fo?=
 =?utf-8?B?ZlNEZE0zTEYrSkU2OVRHTW50S2xzUW9rS0Ruakp0UnJ6TWhaTlFrQldtN0lZ?=
 =?utf-8?B?bUVuUUt3dEsyREg3NVNic2JMSzlJVDZvbGRDeHN1VGRPK1dQNHNrU3R3N3N6?=
 =?utf-8?B?SEd0MzRPdmplUVBGRkY3N1UrdDJMay9ZNWNmcGkwZW1GWDNSeE1Za1krUEhl?=
 =?utf-8?B?K1hpVFU0aGpnUkdYaTVqNDNEbWd3a0dFQmRHUkJ0cEJESUI3N1Rrd3E4Z3li?=
 =?utf-8?B?VEhneWJ2QjhTRi9TaGNjbE1nOGJhODNwMGR5ZG9SK1cwZUN5SXJuTnVNSlhH?=
 =?utf-8?B?TGRhUHZPYmF2Qm1RanVZRlUvWlYzb0ZiUW9QRFBpeExWTU0zMnlUNU03bTZX?=
 =?utf-8?B?WG5RTDJnbm5uVHZzQ3J4dTNDazRscmV2Q3MxUm9DY29OblJhV1N4LzY0M0RF?=
 =?utf-8?B?TmV3MC9XZ25qVW5YR3ZwQWU4STR0d1BQUnhYVTB3alkvQ0xMK2owb1Jmdjhj?=
 =?utf-8?B?VmVaMXcyRERGS2N0eDlCRjRRMXlZSHhwMG83RHpDaHY3VXp4bzNNeWdsdEdL?=
 =?utf-8?B?TmhjbHpMMFM4cXBwT3JsNHFKRnNneU5hNTVwOFU1QnNmL0VvTjU2YlNkQTVy?=
 =?utf-8?B?MGIxbmo4bG14dHBhOVp6My9XdG91Q1NEVExicThxa3pVRnU3UmJ3Ri9TZTdH?=
 =?utf-8?B?VE05K2lrTW1uTzZrVGNqV01CczZFZ3Jpc1k4TEM4dGlIUXpMdlYvRnVoczBp?=
 =?utf-8?B?T3Q3SHpiVEFIc01VTXdHNEk5T3lUMmlINUtjTE5ESzB0SE9ZZzFvcXVpNG9G?=
 =?utf-8?B?VGdnZlJUUlJRb0dsWnRoUXZTRE0wdll2Z1l6MWE3QVdsQ0dsT21YT2VyY2JB?=
 =?utf-8?B?bS85MHVsaTV6ZmZybTRTN1dMRlh5VEdsdXNXRWR5Qnh3ZS9qTElBcHJzS3Iv?=
 =?utf-8?B?N2hKRzdwek9Mc0xqejZtVlJxaFZjdmgwMUh6ZFNGOXNNRzNWUFVTV3JSbUtI?=
 =?utf-8?B?NldmR2ZOWVN4a01jdURTN1pGSmU2dVFvck8wWTdnYlFpZXlLTnhoN3JEVUVZ?=
 =?utf-8?B?TGdubjdZYWx6ZUloYlpMWUdTZTNYV0pad3RZN1RQYm1OU1huMXJCM0ZPQ0cw?=
 =?utf-8?B?UDdrVnhlbU9rVlJKN2t5SkppK3k4RVlmUm1ZTjJsMVFJanlnb3VlcWdsY01L?=
 =?utf-8?B?ZVAwYStqSCtRREFqMkR4OHovT1B6OTYrb0s5UUpuRlRhZ3ptZ1lReGxIMzB2?=
 =?utf-8?B?dDA3M0x5MlRIVlVqem55OEpsMTZsMThSNXp0ZnYwRURrb0dnSE1kUm96ODV0?=
 =?utf-8?B?SStiemdCcHBNa1ZmaTVlMFFkWUdXcjJZSTRvRHI1TjIyUjM1Y1B1WW5RK2Iv?=
 =?utf-8?B?Qll3SDFtTCtlbjhzbVpJLzhsbUovNDJHd1pwN2ZiaDQ0MzVVcnBtN2I0RWx1?=
 =?utf-8?B?cHZKOGlUSVF1Vk9CM1lKRFRjU214bytmaUsxWk1weVRLK0ZHRzNWV0JBMXpD?=
 =?utf-8?B?TzdKWnFzQ1NIWXROVFdTN1lZa0lTWTBFWVdOZU01MTlRUkVBNmtGSU9lWDhP?=
 =?utf-8?B?cXBwd0RqZFBEaFhsc2ZBZUE5djkvRUJuczNjYlN3ZVZIL1R4U1g3b3djM3k3?=
 =?utf-8?B?WFNKWldpZkducWtCR0RHeFpkb3lwcjh1V2NneExDTlNkT2lKSHZBbEpEemVQ?=
 =?utf-8?B?SjE4SjR0K1YzZExucGl3cUY5QklKd2JhZ1loQW9iUXhwQVFicnpjKzQxek10?=
 =?utf-8?B?ZWVsMklBUVhpczhkQU83MlhKcjBEYmlMTHdtZzhNT3A4MWxKcEVVWXpIQ2Zp?=
 =?utf-8?B?NWtwNWlEcE9CMlgyODRIbExKNUFESjFTOTFvclBoVi9Hb25DSHVIS0trcEhz?=
 =?utf-8?B?ZWU1S3V3YW5nTlV1OEF2RkdEcFFsNHFKSmlqMGloR0xDdm9tQjhVM09Mbmdk?=
 =?utf-8?B?WkZpZXlqZC9KQVI1MVZIWVFUMGN6eTdxMlVTaFkyR1gzK1Nielppanpvdlhz?=
 =?utf-8?B?Zk1rYWpDZ0phK3RLVkNkY0NneU1XRm8xVVJaRnEyUy8yeG1FSlY5cWtzalUz?=
 =?utf-8?B?K0dUWlZkT3IzMDVKR2RFMmxKTk43dng5aGZNcmJ1YkhtWE0vR245bGNUNGdw?=
 =?utf-8?Q?/6KaleePiD/3zFKekCcvQeyZH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e2236b-e3e1-4582-9309-08dcea0679f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:07:51.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVBM+93T3dr+BAYsbln5o2yTzB/JcVKJa4LlfwyP+zQgdSAYZmmzqpEqR2xJscaR9VTGUJVtCjt2RBXgWXsqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7539

On 11.10.24 15:37, Florian Bezdeka wrote:
> Hi all,
> 
> as we are already in the preparation phase for a new release I took the
> task to clarify that the upcoming release is in a good shape regarding
> the upcoming Debian 13 next year.
> 
> As it turned out a couple of minor issues had to be addressed to make
> the upcoming release ready for glibc and compilers shipped by Debian 13.
> 
> The y2038 implementation needs a couple of fixes due to changes made in
> glibc. For some reason they decided to change __USE_TIME_BITS64 macro.
> The commit that introduced the change is linked in the following
> patches.
> 
> Testing on Debian 13 was done manually so far, Debian 12 was covered by
> internal CI runs.
> 
> Best regards,
> Florian
> 
> Cc: Jan Kisza <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v4:
> - Slightly adjusted patch descriptions
> - Removed probing for __select() in Patch 1, replaced by proper libc
>   macro usage.
> - Link to v3: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com
> 
> Changes in v3:
> - Integrated review comments, harmonized libc macro usage
> - Link to v2: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com
> 
> Changes in v2:
> - Seems it's too late for configuring b4 correctly... Lost one patch...
> - Link to v1: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com
> 
> ---
> Florian Bezdeka (4):
>       y2038: lib/cobalt: select: Fix compile failure observed on Debian 13
>       y2038: lib/cobalt: Fix link failure observed on Debian 13
>       y2038: lib/cobalt: vdso: Fix runtime error detected on Debian 13
>       y2038: testsuite/clocktest: Fix link compile error observed on Debian 13
> 
>  include/cobalt/wrappers.h                      | 3 ++-
>  lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
>  lib/cobalt/select.c                            | 2 +-
>  testsuite/clocktest/clocktest.c                | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> ---
> base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
> change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a
> 
> Best regards,

Thanks, that looks now even to me understandable :)

Applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
