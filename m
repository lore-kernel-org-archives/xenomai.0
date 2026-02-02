Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3A29B777
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019779; cv=fail; b=mkeNZ8KC8qWyYDlC7J8APoGUeFIP9Gb7c3o7WSH4auwg96aSDT04+betWHLPfObX4BR2lPQha8/p5WkVfMQKOy67EY/hP04LjFLLtfez+QIyzREZ1IVOT/VOn5/mmf/xwA3Dle6zIdUPLA2z/a9XZQAxbzOrYplby8FS6yq9ggg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019779; c=relaxed/simple;
	bh=5MJp6xBarYTqThtw2h6KskwWFGSmAh+kHXbun3ohI88=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EM+cJSKr5y9dLnnIRvn2G5R229DEvoUcjs+Sfyt6K1mjm5Oquv9kVfE0q7cj4oUlXuP2Jjy0TeuWaR35iSEMglL4juWrqGF8UEyd43S46Og9jUeXo+ghkdVKKMtndTZq+dkMlzwCuO3Y23/x3/n7Nk6bQtMjB51cgbzFr0TqF+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ncbDp8E7; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ncbDp8E7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7CdrNtwoLB6lh/UXHXDUorIn8WZeEOU/IgGYcPL+l40t0fMLgMdbXedCp23PstqIFmwwOsd6NMJ+OB1DSu5DwhhpTILpW87ScjEwndvJgMMa7dft7KoyAipCxzqYwNBBhJt2508kxojsiWNkIQ9WxhmRKJvUt7AZ8Fr4uib4YtUn1mmNc9UZGKHLJ7hfRIs/hHGXs208z5eJrhG7x94azQxyRgoxSB2xCRExtB8lCPKT2mYQyA8EfmwjkLDf7DRne7oxb4jvJp5ZHAzP99v/EaVXg4UiGnh8fCF97OviRVkgnj3lyzQgilZv4F/zjhD/zcjDwPf5cOJFyNWk8wcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJpOTFPnfBhF/dGHx4vYekOhPBCIiq135+yZIMv9Fsg=;
 b=CX36H5FjdQ3wYGVFLI+6B+lsA8URlOuFXP9FHZYpaQCi4qXThvNHtMqiyTE+yI1aNg3SV6PnCAgdh2pFfME7paC6bgLAAKU5jVLqOtKZimrgyZiKrqxVVSfXY4N2WInUshi0z1lt4aL04VWufLaRAZqZpdn4idpvcPrakgIaRrqI6uxjh0LkTMtZkyTRgRbhPrgydL/oN7hGPwCoS25UUv0/O4MVcJ33Oz4ty7It6j9UMFFZbdVQ+Blnba6fEOD+dX0b40dnFj+0o9LJz98vYmWbQYrYfIzOq9qF30OK54djGN+WAHGcaZf9TXzY38Io0OHc1rjNeysQDv+YO1JgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJpOTFPnfBhF/dGHx4vYekOhPBCIiq135+yZIMv9Fsg=;
 b=ncbDp8E7ljccU/+0hi0tz2nxfzj9tK9cwOcQXDPRCbiLxLfXQ1f7FXvVYPsgVO0EjWnzRVoIazAvnf8czDYogqFpQkWm9cumhgzolZqt74DjZuWZoUqcvHJlnsMmTH1p+F3acSb16yue9Ft3ESx5mdMEiJ1QSlA0kdzBBaOQAh+WhOuQ7LkLBSpvw+C1+5tJQwMxq4AKgEO/sK8F+5jOnz4d/r5ba8CuoE9o8LfkFqMuxke8vIiS9Vj5KkqD8TM5TchoJBy8A9i74Hc0ZsGKyxZ1Rq32zKmEiyQjzpJGvsXxA//AhyW5q3WeG9e7Cu+uzyp82N9YWdQ0D0ZkhRPwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:09:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 08:09:34 +0000
Message-ID: <5c5d4ccc-e6ac-4a39-a612-a34b3ba39992@siemens.com>
Date: Mon, 2 Feb 2026 09:09:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <0b60192d-053e-4ba4-96bc-2d60b5a8e464@siemens.com>
 <51f29e5883cf0adf7e671a9c6eba0668eddadc17.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <51f29e5883cf0adf7e671a9c6eba0668eddadc17.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 32100aee-8d99-4180-53ac-08de62326696
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzV6T29MZy9uaXpldnlOZ0tHMUZmVGN1cGZQRXNqUjhNOHY1YUdLQ3MxUDJl?=
 =?utf-8?B?MXc5TzhRNGtaSndpdGN5Z2pkdURYTW1yd2ZjdUd5UThYc2FWam5Zci92SGVU?=
 =?utf-8?B?ajhhd0ErQm8zbzdlQjhKclpYRVJRbnBXcVZ5bnQrY0pOR0FQRXhBN2pQblVs?=
 =?utf-8?B?Y04zSXVCb1lISEUvNFh2U1RPbXJXdmtydGVkSmVQejlxR0t3SEpOOGc5UStm?=
 =?utf-8?B?b0d2N3RTZXYwaDY4eDJjbGMvL0tVZGVxQ0xqQVRkN2hnY1VRZ1ZUbm9GQmZN?=
 =?utf-8?B?bnlEVytRYW85RllJRkgzUGFWbU83WlRUUEkxWEZHd1hRRmxIZXZRTmliNDdS?=
 =?utf-8?B?TVZxSStkUWc1enZLYkJGc1hvNVdtOUdqVUtCeHB3K1V6Tzdzd1hRUnczNmsz?=
 =?utf-8?B?Qm1tVEhsbXVMZTdVeDhqODlOOFgxVXlEYnc2MzRaZlFMSTBYOHN0UTFkSzJS?=
 =?utf-8?B?U2pJaHZmSlIvNFB3ZFUwZnkwMkZSdWJ0d0Y1bFhNUkdkc1BnZ29WbUZFN05z?=
 =?utf-8?B?eWNCQ0hKK2g4NFVSQnNjZHRIQnV0V2F1U3U0Y2JqMkpyb3NoVlNmWG1BMUhs?=
 =?utf-8?B?ZTBvb2pUU210bFdLS1RRelFnMWNrYUkyV3BHTkt2VG4zcmZCYXNLbWhSK2JH?=
 =?utf-8?B?ZVhGNGdkK24xOHFWWG5VOVMraFdZN2hoNmdvbVJsbTJKVlplUWUwZm0xZFNJ?=
 =?utf-8?B?MjRJMGlSUkRPbVM4SFNuQW1QYUdEc0RSRmx1QmZsaG9YTE9DNVVCcXRFYWNu?=
 =?utf-8?B?OVRTanVmY2JCMkZzZnkzaFFReXBTYnM2dkhteHdwb1FMS0h4cVpnUmxIUmFw?=
 =?utf-8?B?N0NueEx0TTVHWko3M1pINGR6VE0xNlpENHVLbld5a2xrQWVySERKWDBKcDcv?=
 =?utf-8?B?aWs3djhNRHlsY3QwMnBBd0ZVdHVuQUVvMEhQL3NRU09Cc2YyU3krL083OTJ5?=
 =?utf-8?B?aGJreDVVUURhUm9iUlMxNWE4ajEwK05IeWRwV3hNZjl4L3k1bi9WdjVkazVo?=
 =?utf-8?B?N05SUmtWQVZnQ1R0SnYxT3RvcWJaZmxPWnA2UW9wUDN2Qno1b3dsa0MrcHlL?=
 =?utf-8?B?b3Z0dVgrWTYxbkNNSS9ZTjJnRjlMTmV2aHJzMmkydExCcFRQYU1nSG9CZHFD?=
 =?utf-8?B?SXBrdEpQNHdmSDltQjUzTU5GaFo1dFRPYytRRGV4WjZhTnBvcWJUeTFkT3Vu?=
 =?utf-8?B?ZUd5TkVBaTJRYjlHMG5rQXc4WlpqcWhpNVZFQnJ5Q2JqSmg4bEJVK2NZMUg2?=
 =?utf-8?B?K1gvKzVHVkJGNVVnZnhKUVR1bVdwcVJsL0lQTDNkZHg3MkFlYi91RE1oaEtI?=
 =?utf-8?B?QzJoRWsvRld6b251YXZYcFNDMUw0QWw2U0V0a1o3SkQyZDBUdk9TU0hVeTRN?=
 =?utf-8?B?ZmIwRUdIY2RWQVA1L3lSY3Erc1ZQbmUxeHN2SUNOVUpQVDRlcVFaY3FkSWlG?=
 =?utf-8?B?UFE1b2xiK0p6YmsxYUl5V3l4R1NQUjNtWUJ0WW4zU1NxdUtFT1VQTFJvQlhQ?=
 =?utf-8?B?YkNZdmFrZFZmbGgzM1VlcmN1Y1Vsb0MzUENRbEZYZ3NCeW81N2VJU0drZU42?=
 =?utf-8?B?eHovUWxSUXF2QnhqWERGMUg3enhxTGhsdHRjdGhsZnc2MzdXVXc2cWRrby93?=
 =?utf-8?B?T1NxNEhoVmxKSlh2Q1o5b2dxemdaaE1jb1NTZUxldGZDbmZ4eDBSN2h1bFFv?=
 =?utf-8?B?OHhaY2lCL0cwNmhEazVoenRMRndDc2FQbCtuUGhmRlRscWZLd2J4ajd0d0pH?=
 =?utf-8?B?Q1dNTXNoUHd4Qm5jcUlEMjF5S3l3VXRkbzBxcDBUZDFzK245OEoxTEI1TjZ5?=
 =?utf-8?B?ZkF4M0YycFkySkZBb0pBTTQvcTRaR3N4MklLTktaL3NLNFp6cWRpVFNTaDVr?=
 =?utf-8?B?LzlDRFhveVRubFl3MXMxdEFwZEs0VmROVXY2RWVyQjF1NS95Wkh0RHg3TmxG?=
 =?utf-8?B?QWluNlJ1N3NKc3VWMjNFYjlmMld6M2plVGVnTTJTS0JWcE9FQ2RFSUxnZlBU?=
 =?utf-8?B?SVIzL1VtMHFqbmtUb20vNFg5NlM3L0Jwb3FmN2xXY0ZVMnJsVG9HYk9vc3pk?=
 =?utf-8?B?VENsb0QvTDZ5d05iVXh2bnczUjVnQ3FHdldRcFpSRlI0WE1OUURNT3FJejZT?=
 =?utf-8?Q?Y5KI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2hQQXByV3NSbmlnQzBLN3dNd0s4bUptOFk2b05GZzhlQ3dQRjYzaEFpVWJP?=
 =?utf-8?B?aTFGZzhOZkVKQ21RVzI2a1I3UGVOemd0RmNqSDlEWUtScnFUZVB5Z2NqRk9O?=
 =?utf-8?B?MThoWUF2WG5PNU9ySElTdFZmL1JmZUMzNGdNZExveGJaR2FWQUhybklXMjYv?=
 =?utf-8?B?OWF4NUpldTA5b3g5TXdxK2ZzK294QW9uZ2hMdExTR0JBMzY3OENmRzdvWkhP?=
 =?utf-8?B?N0N6dEl0aExsQnpvcGs4MG5FY0NRRnNmaElnWnZvTmN4OGZoN2FCZFBpOEEw?=
 =?utf-8?B?OTVXU1U5dmlDK2ZYNmNmSGJxSXVmWEs2dU9lQ1Bma3IvMmhvandXeHg2VWJu?=
 =?utf-8?B?TU9ScFZaUXNsZlNVYi9WL0RGbTNFWFlNcUE4WkJiNUNIMEwxQUZienhCZmNO?=
 =?utf-8?B?dkRFMzN0Tk16N1dJV2JOUlF4cW5Zd0hFMmU0RXdwNVJTMnlldzl2K1NCTzN1?=
 =?utf-8?B?T1pISXFoM2xrSmRpVGcwZmRWUnBKbmx6Yzc0b1NDMkRSbVVrMFpLckttbWpF?=
 =?utf-8?B?UG9jY3NzRGwwSzB1R0V0RUJTMkd6dkYyMUlqTnlSMUtyRW9HeHhIcXd6QlZN?=
 =?utf-8?B?cjU2WDh1aFlIbkFlRUJYa09JcUJIYithVFptQUZYenN1cVZFMi9hYUdJOVUw?=
 =?utf-8?B?UTlyRkpaWGJsZjArdjFxQis3VlhqT3FjaXp4cFNsdERNblFpbWJFVXJORU9w?=
 =?utf-8?B?TWNDcmJzeHlEeDNtRXJIR2x5WkhUeWNnZjBybzkxK3JzdVl6NS9TM2xIRWM3?=
 =?utf-8?B?aUo3eVdxVUlDSlJyQUJlb0NnZmpIRWlBNGh2R1ZVeENnNkxYeEQzcU5RQUpG?=
 =?utf-8?B?UGFmYlhMUUF1OGxYdVlSb1h4amxNLzhMcEQ2S3FieThUbEpJS0VzWWtyODhu?=
 =?utf-8?B?azZFbzI4QWhWTUdpTTBoSTN5L2g1Ync5V3RIS3piT0NWbkNhNDV1ZTQ1L2ZJ?=
 =?utf-8?B?UUxZcHFWWDl3L2lmK2ZESWV4T014R1FXeGF3WGVhSHdaRk9KNU5zYWQ5L3lS?=
 =?utf-8?B?dFNDb0hrN3B1MmE0SnNXVCtmNWd1cHMwUDZUN2hGamNKcGlhZ0lLTEVMaUNi?=
 =?utf-8?B?VVhiQWFJUUJpZ0pQZlNudUN0TWtYdlpuZjlZTk1HcUlDclZDQlRmNUxLQ3Jy?=
 =?utf-8?B?MUJyazNCNEZ0UGVZNXZ3TW1ySnArVldQSStlTG1ldnJ1K0FvK2w5bzA0Mk1q?=
 =?utf-8?B?ejgzRCtwbUVMaFhJYWJMaDZUV0JjZHhBNzUyMHA3cXlHcW5TTGZmT1Y5cnV4?=
 =?utf-8?B?RXVkK2R1MWxCVW41aWNOTk90amFEdWg5dGlKV0FTdTI2amtMTHVJeGllT1NZ?=
 =?utf-8?B?NXVOZkJYaE5tL3NSMjdIL3lVYVpUUCtnU0NiZmpEMHpMS0dBY1JwdHJ3eDgy?=
 =?utf-8?B?M05RcDIxY1I4MXZ2eVl6YU9DbVZaWmRuSGpsSUJnVmZXWnVVR3BuRHRUWGx4?=
 =?utf-8?B?QkJ0Y3NvNXEybmVFOUYwT0RLRHZ1TG4xbmxPeTZUN1BhdHRDc0NEUG1PbHY1?=
 =?utf-8?B?RXZDT2Q2MDNneDJ6WEt4dVRNbE1JVEFiMVlIQkNZMHlTSmx6eHpxS014WDNa?=
 =?utf-8?B?Vjc1UEhSVUJWOFRCMGhGS3ZyWDE5OGd0NExIVlYycDdZWGpnWjZISWdPUVFy?=
 =?utf-8?B?RVFuT1BiNzRVRDV4TVpjY0M4dS82b2pFTnZCUmU0ZTBUVXp4cTYrNXhWWGRR?=
 =?utf-8?B?SGxlTDB4Q3I3UGpuK1JDQjgvenY4Y2VubStnY2gzQ0o0TUUzNFVLMGNKcjdN?=
 =?utf-8?B?YmtZcHhYd2RrWStlb3NIYnNVQUZUKytmUXdPOTExSy9oRUZoczRjc0ZTSkhU?=
 =?utf-8?B?bk0yb1E4MUo2NWlzNWJEOW1MVitNckQ5UFQzSktlWjg2ejBaZ2FIOGtOVnV0?=
 =?utf-8?B?N29DdUtrR1NhajhVamg1YVkvb1FjVm9GK3Qzd3ZLOVBoQUttalVmSDM4WWNL?=
 =?utf-8?B?NzlyNVRMaW9KbjNzQ1FQU2VtVnhja2NyTzdLcFFIRXEwREJEcVBVL1JIOTJ3?=
 =?utf-8?B?My81VndYVldHNHNvbnlYUVZnb1F1aWpaU1gxYWR6SzJrVFk1TW1oaXlsY3Vm?=
 =?utf-8?B?emVMQW4vdEN2MHh2SEk3Qm04YmFXS1JKNTVYMmxhVVhDNUNZT3BaYXd5TG01?=
 =?utf-8?B?akJMWGlYZDhZWFNEMUs1S2FNZzk0OGQzN0pDRytxdG1wUDRXZ1E0MzM2Ukg3?=
 =?utf-8?B?ZU5LTHBxTzh6dkRuUEpHZlNJbWRjdXp1RDZFd01VcHE2VHh1cnVwcjB2N1Nq?=
 =?utf-8?B?c0QvRHZ1ZzluYTFPSFNwNkFZNUczM25sY09GV1RsTUFRZUtNQjk4c0ZSRHN3?=
 =?utf-8?B?UlYyNGVCTUlFZkpLTUVYZWtwRDRiZWNzYVlDeGVrVGFIVm5WOFUrQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32100aee-8d99-4180-53ac-08de62326696
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:09:34.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zYUuLO9Lmpzios2wX+LnGgthK/cNWygij8pRXe+cuRvHQG4O20ZYQUD71ua+J77ENDwHiwykVnVNjjxltokHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6909

On 01.02.26 22:11, Florian Bezdeka wrote:
> On Sun, 2026-02-01 at 10:36 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
>> glibc. The original mmap continues to expect native off_t size, i.e.
>> 32 bits on 32-bit archs.
>>
>> While we require applications to be rebuilt with the same settings
>> Xenomai was built with as well (either both _TIME_BITS and
>> _FILE_OFFSET_BITS set to 64 or both left unset) which practically
>> shadows this issue, it remains wrong to change the wrapped mmap function
>> in a was that is incompatible with glibc.
>        ^^^
> way?
> 

Oops, missed, will fix locally for v3 (unless it will take even v4).

>>
>> To avoid running into conflicts between enabling and disabling
>> _TIME_BITS=64 and, thus, also _FILE_OFFSET_BITS=64, factor out the
>> affected mmap wrappers as well as their __real stubs into a separate
>> code module.
> 
> Is mmap() the only wrapper that we implement that is affected by this?
> 

So far, I haven't found other cases.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
