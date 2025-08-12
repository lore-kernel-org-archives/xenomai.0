Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF52E716C
	for <xenomai@lists.linux.dev>; Tue, 12 Aug 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999876; cv=fail; b=PxY1zX6mQEyJHU1UOF9ElAb6NPCMEk1lXb2f9sn3+ciwcx5hahOrIkglDFf/ywwhoKItSkqkLZJEk0GlKyZz6ih3TVqllGAIBfod1DhLOPpm8OZsZ6SIP25ISFChaDZz8PqAYxZ9+fTwzJyI+5uCE0wss8Y9K4zXPYHxpkZUwvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999876; c=relaxed/simple;
	bh=K2zI2yfAEtgJQI4O1x0cohosmViATYXRnUXNloJw+g4=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=rVJ5lO6KgQuBPVJk8DWG5t91r9YFXp/s8tXTgGrQJS654tG2x+dnJqs37jIoyo9yoaajiGqt6h+y0CPLa8p3t8EJks4X/ZGUOWAYg3EjBcNoNWq4Byn2FA/Re3ccBp0DMp3jp20sfBgZ07aDNNrg3h+sfui7juJ8bB6RNEUnSm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kkLfB8P1; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kkLfB8P1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSIUaLImcd8BW97CWjWPa72/6RZSG7Kd7zLJF/R4LIPT3QInI9rS40qmk+58tUq0GLr0hg8lrmVkeo4jSZO7NkjxYJmKSR4YQkULmj7sdw3rOvpcOv7PD03pWA2NxE/ZKyFSiIZJMBP1fiHYZj0FeKMnIhxwAJByDMBvMY4QXZcbqLFsn8hjv193dfo1qmScxmeV4+5ZcEGsquHQ+QN9ZiQWA+n3TakycJvmNY4mYTx8z2utVA03Kta5uiwWLvz657P7oOldT096BLJkFDceQsdQmeMKwNoa4sYPt2J3j8plQQV++9h56v5Lq7eCbfJvjSxnELu5g+A5kkvTIeV+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbSsObfpe9TIOw+5gjckSErawyswa8UETiwPgNZ8d+4=;
 b=bmEN/naWQpSzo4rGxAZf2EGtU6XZrBx5XIgRGcGGuQsV5e3PllinCBsgYgz7t22dYcoLqx29nvMz/FYQcgVSaFAxAUGxqIRM0dGZxnGHM/DGvy8KfgHGITv8R7AHkwzuAgW2m3NwTj05AzhC02de6XPWmjR96QPhqN/Cu6qWvNRiviArxjOvJaP8iG35emD1XuampEwiZCCXtsTNmoAJBa2Ug1BebZtcEuYSLK4UL6X1Q9s5ckllvNntu7w0Upb/9ziavHxCVEo9+wj73GmtXGNKEOjyX+wwELMR83Q9+frZUBMe/uy4VavONvSWg3ybD5o6SI5yDdLwOMSyuzH8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbSsObfpe9TIOw+5gjckSErawyswa8UETiwPgNZ8d+4=;
 b=kkLfB8P1zoinY2Kw8xpBiVsEZAXQbi9AXdCJzmaGUUVxD3vJly0TEPwPwD0C7gis+6a3J+IENj7cZ4H/JmYAemvERjnPPvHx69IPI4JMjcSswmdHSTfP4wPyfuzmpyhA4VWi3ijHQh9zSgHa5RGmPjbSZDe/j/8j1NCS9YVJKCbXpq/xA8K0ZC3LD8PM0+VqLzE7DHcp5eILoy8MAjmaXWp1dj7w0L3bumwrM9JXaJvR0XaZccni1ZXoy/C4iGxPevPmgiPb6d5z2xHNC5ogTd//SwD3xDDxkH7icSp/2qJGjanH++rLZbmNudVPKmrHxJMhH/ExXSA/nO1Y7DPVIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 11:57:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:57:50 +0000
Message-ID: <4a32f6f8-2e6a-4b87-bf79-d8ecb68e83aa@siemens.com>
Date: Tue, 12 Aug 2025 13:57:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] debian: Enable parallel build
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fcc785-c18c-449f-b3ae-08ddd9977618
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtNbVJDL2pzM1Y5enNFOGlwTlhEWk5KUk1ERUhvVjRyK1Y1MDcyWUVkMUl6?=
 =?utf-8?B?d3puemJSYlZPdWNyVllyZUpneHo2aS9mLy9VdGVLbmZuWlVqa3U0bjR3bmV4?=
 =?utf-8?B?ZUphNU43blh2SHNMdmVKNmxHcFVzN2lMNDJ5djV3Nlh2QkM0M1JTS1pBdWFv?=
 =?utf-8?B?cUxTMU8zbWlIak5Gd2JuSjFodjlOMFVUS2F3dTBGNzE0YTdsbi9xWFpxQjlJ?=
 =?utf-8?B?WVczZFRUTVZzQzdtb1F6YU9US0tINCthaGFEaTBxd0kzMEpYWE5kdlBOMFBD?=
 =?utf-8?B?eVdaeHhGQ0hSNitxdGlBLzJxOHlMYy9vTWJTNkd4dUliT3ZPZURJektSY0Yw?=
 =?utf-8?B?VXJlbm9udGdSWnpSamRzamNkdnQ5WlZtL1pKREpCdFhETlBoU3dCbDc5QkI2?=
 =?utf-8?B?TG5sTGZoM0FMQjNac1ZBYnZRSU1hQkg3bys3M3FCbjN2cnZiSWJ0bmsvYit4?=
 =?utf-8?B?cVpXM2phUmxZL1A1MzZIbER5WVI4bjdpNlBXTyt1dDMxeWNGbkNkVmlzdjdm?=
 =?utf-8?B?UkJuQWpVWDlURnJwK1crS1BYZkZ1WjFROWM0S3BKNzUrbnluRVZGdDFNTTQ1?=
 =?utf-8?B?Wm5DVUwzeDRjS01iQlR1TXM2RnVrc3Z0S3pYZHU3enp6S3Q0THJaNUNIWE1H?=
 =?utf-8?B?SmdwOU1sWkdHaGY3R3hBaWxKQ0NLK1RkQmF4T0hBaUN1ckwzVEF3NU45UW9R?=
 =?utf-8?B?TnlSREVHc1JiWk8yK28vYnZCMXFXTHpUUmJpRTJheTFJK09Zbmx2M1JlbkVn?=
 =?utf-8?B?ODJKOGJvMHAvZExVU3lXcXlkUU1POVhzNDAwSEhjaWhvKzJ2Si9semtiZEda?=
 =?utf-8?B?bGNFMk1kZnFNeHp3L2JjeHE2bEE3Z1pEWFNLL2ZsWjhoaVc5S1h5eUhlejdH?=
 =?utf-8?B?R3MreFRJY0I3dXZvZFpERm1oTnJlbjVISHFlY0hINDl5bEw2UVplRS9ocDUv?=
 =?utf-8?B?MUpEeEcrNE5MbjRCWTZ5Z3pKSmFhM1ZpNHpNTllBT3dZd3dlNnVnZEo4Wk9Z?=
 =?utf-8?B?b0lyQnJlSVU0TnlIRFR6dGlOTTZhYWxOdnNYM2NIS3VVR2hLNEdnallWbzla?=
 =?utf-8?B?dXkzU0d0ZTVsRFFXZjhmekJoaUE2SVIxRHdaOFc5Zm1obWxROXpFci9FK1Fx?=
 =?utf-8?B?QzJDQk9KcVFwaDMvZzlkZDRnaGtRT1VQS3YyQjErWms3ekYwM1VHMk1jOGY5?=
 =?utf-8?B?dm1za1ZMbm14RHQ3eU9LWTFHL241UngxMjVweXRtUVF5Vlp3YzhjU0JRYnFK?=
 =?utf-8?B?OHMrY3BhSjlPSWFpRzd0bVFhcnROTEtlT01Pc1QvR3loTVdiNVpybWZVTFgz?=
 =?utf-8?B?b3hxT2hGUWQvZU5IdXU3QWF5K2VLWk9oU1NuNnJMSXNKTWxNd0JyZ3ZFODVr?=
 =?utf-8?B?OWgweXA5Yzl1aUlKb3lDZ2xuNGF5RTUySnd4dUNWc2t2Y3pIek1RRktZWDFS?=
 =?utf-8?B?UzB5NDNUNGtQanYraEZqYnpyYmJLYWJyemZoZS9mTXVQNVlBN2d2aXVhN1Zo?=
 =?utf-8?B?WDZtUS9GaHY4RXhOZWY0elAvY1NQeTQwRU9kc250RlhVY211MGpNc1pUdWNv?=
 =?utf-8?B?TjlneEhLczJLd2FVRnNiT0FoOStsUEx0ZTlJS0RKd1VGZk1iN0EzY3RFaHZH?=
 =?utf-8?B?VEhhK3YwMEszR0FNd1EzY05sOFVwa2UwSnBDOGpmdExmRFIvSVdjdVpGb0VQ?=
 =?utf-8?B?WS93bHVneFN3UlB3cnpYOHlyaDM5a0lVSkM0d0JlMjFmcnhIUSs4d3BYUkpC?=
 =?utf-8?B?NXhnMlRNSktuU0tGMXd1eUhBVkNqV2J6eWQyOUdJemhpMW8xcTM1cmV5OVZq?=
 =?utf-8?B?QkdiS3kyTHh6ek1LWmdZTU9vTzNwSlR2S04xakkwTnNaYy81WkEvbkpmUXVj?=
 =?utf-8?B?VXhvNTZsOHNIb21UM0dtNmZnczlva1lWakI2bys1N0hJSjRSdzFKWStnamVl?=
 =?utf-8?Q?1nzl5mVZcSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JXaTlDUkhka0ovV2lpeXZFSnJHc1p0aS9iYnREbmk0ZXZzb2lzek1iNy9W?=
 =?utf-8?B?Z0l4azlaVkNTeFFqWUNDTlhjYkpkcjgvLzB4TlNnZE5CSHZTaWxqNlhOMTBW?=
 =?utf-8?B?Z0JZNWZaMEhIb3MrejRpOFQ0Q0lZTXhsYmUxZGt1WGcvanRqMm5Hc0NQMDdJ?=
 =?utf-8?B?aDFXSUJLbmp0Q2oxRG12dElNTlhpZ25lN0gyajF6WHM1NTRwOGdPU1NWbXh0?=
 =?utf-8?B?WEZGcU01cTN0VG85SWdUdHpITEdHUFNFS3psdHdIVUh2NmhFd2xSR2w2Uktp?=
 =?utf-8?B?cnlMMHIxOFVYTlVqcHJ1b3lCUkhDRUx1UnFua3RzS24xN25ZOCtJNGxLc0hr?=
 =?utf-8?B?U2ZXQjlqRGQzbUlkNzJ3eUJVWEMyeHpVR2ROM0s1T3B5aDFqUFkxVy9SY3E1?=
 =?utf-8?B?WnVxSFRFalJ0WkdGYU41ZzVNaENBd1g1SCs5SGpUeGE1NmprblNXK2srdTla?=
 =?utf-8?B?VHZYUUlaK1F5b0grSXQxbldMZUUzNmpUWlQxT25CdHVWdVRUWUM1RmVXRGRs?=
 =?utf-8?B?SzI5QjRZL3JJVEtiSkJNeUpVNm1peFVucHEvTTMrNWFnQUVMWjl1ZGlLbzdE?=
 =?utf-8?B?cFBvUDlZL29iWnZIdHhkUWNuVjdLQ2piWHZXQVJ3dGxnZ2JCRHVad2M5MkNC?=
 =?utf-8?B?b3JYWGZMR3hvTGFoUFd2OW9pd1F3cDFtajRIcUZQVk5Ya01BNHVPRlVsM0hW?=
 =?utf-8?B?VHlOazVua0xlY2Y0bmQ3OFZ1dGplUGRLeEMvSWRZT3lhUDZzUm5JWHBnZzds?=
 =?utf-8?B?alFwVE5vbXNhamU2OGFHWEZHUG9Pd2p2a3d3cFI0VWRZelRZOVJuUmxWdENC?=
 =?utf-8?B?VTlrb0hLNUUrNDNmVkJUcGJ2WGQzQzRDbUYyamdqOFQyeVRXUVp4WFJWLzdi?=
 =?utf-8?B?blNxaFp2eVh0UWhUZlR4TytlRVV1aFNMM1pDTmc0UHRmYTFiYklMOVdQRjBp?=
 =?utf-8?B?UjBRd3I3NWhIYlJOZ2lwVTFEaVYxK2l3UmQ2c0QxSzRDaitqbTByUE9sSVpB?=
 =?utf-8?B?TWJzQWY0M0pVRU84WGVrUWN5M2ZhQTN6SXJUSlRmZjFBT0hPb1dJVU51YXQv?=
 =?utf-8?B?V09zdEtMb0dXUTczZ3QraW0wVExLU01Zd1JyVW9jd2pIamFMUnFkdGV6YVdN?=
 =?utf-8?B?UWQ5bVJWVThYdk4yb1FmOUR6WWVuTTlZbS9SV3dPY1JQVndXT1lsZWxTSHpU?=
 =?utf-8?B?QXpDcFFLMG1jNEFNQmt4V29qamRiQVBESnphRWdCUFhKSnZHVlpDUnVOKzhz?=
 =?utf-8?B?OWxxZWhhTTBPRXhYMTJFbWdFQmNmU3dkVVNWWGZpa1FmQnRoT3lFbVhtd0R0?=
 =?utf-8?B?T3cxdDZSWWQzU1o2MllVTzRYSkx0OVlYcWs2VlFVY0xsWUxZSWM4Sjhpa2xw?=
 =?utf-8?B?MFRtT3RiS3pJRDBNQUN6SDdIaTI1K01BVWdpVkZ6bnIwRjBNTFFJOUNyK21T?=
 =?utf-8?B?ZU9YNlMvekpqQnlIOXpQdWZSMFExYWt2K0sxd2l0NGZ0MWRxRnNXWS9MNUlv?=
 =?utf-8?B?cFFheks4QmhoVGtueW5SNGpwdklNdXJ3SHlsREVsSXF1QTNMUzVQbzAzbWdu?=
 =?utf-8?B?cEZiRUdWM3BobW5oQkZxMCs1VmJqZkQvNFo1Mlh0Y0NodkhpanJNeXpnVUcz?=
 =?utf-8?B?N0RTeEJ0dzRUcVg3d0FjdnZBdDJPcURUUiszTlhpSUNTcDZjYStrVmhWdFRO?=
 =?utf-8?B?dmN3OXhjYnFWZXR5UDhvUUpJbzczazNJaHFjWjNFaFVIamEvbk15OGtSaXE5?=
 =?utf-8?B?T0l0SHIra2ErKzRNTngxdjdDS1l3YUlPVkYzWEMyeTBUZjZxeFUwVE9KMU5W?=
 =?utf-8?B?SWpaTXpvdW5DRlhTUVdJckp1S3dlYng4YXVPa2ZMM0dWczFiZVZKSFdDc3Bn?=
 =?utf-8?B?SUpCdGg1a3h3bGFhU3B0TTMwTFc4RDBNR2R3YWsyOFpOMHM3TDUzMEc5aUtU?=
 =?utf-8?B?cTZDTlNKSzVKS0toSWVjOXRvZzAvQklWODRqejN0QVhBcGNOaERMMENmYklV?=
 =?utf-8?B?b1NDeURNVDZ5TjJ1bGFZbldOcVpJM3VJSFQ5K3pIaVdBSXh1SFNWY0lXL3Zo?=
 =?utf-8?B?c2UveG9Dd0xtUGFyWXpJWHNjTU1STVdhNWdDbExFWlYrRTd4YTQ3bnVRWkxs?=
 =?utf-8?B?aWhiNnpZT1pFSEhFMVVBeXU5ejJROWROSmFwMzdzWGdId2RCcDFKV0EyV1NS?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fcc785-c18c-449f-b3ae-08ddd9977618
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:57:50.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXyRKM9sdxOGDFUfnygnJ9cRdl3ph+XOJPax4cXdowmiuiFR7ItHYzlp5Mqd39LjhT7P0Pk3SICw5Lz58hP3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6828

From: Jan Kiszka <jan.kiszka@siemens.com>

The missing PARALLEL_MAKE was forcing our userland build to be
single-core. No need to.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 8e984acdcc..225c743c51 100755
--- a/debian/rules
+++ b/debian/rules
@@ -33,7 +33,7 @@ build: build-arch build-indep
 build-arch: build-arch-stamp
 build-arch-stamp: config.status
 	dh_testdir
-	$(MAKE)
+	$(MAKE) $(PARALLEL_MAKE)
 	touch build-arch-stamp
 
 build-indep: build-indep-stamp
-- 
2.43.0
