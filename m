Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E169139F
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503664; cv=fail; b=buTgg4yIDEu9ufyMwK374Z8xnDJlz60jNphNHaUsSzCbxA/0UMduNXC9MQFfgGqsAMi89/qgSR7a2FzQvd61DR3vFb1reLzuSdmkZqwVkA9CJCjFqbG8gIVKl1lyxJc++D5Jm+18fOa9HaJWSJoYsobm6GR1MLveCM3RpQ9Qzps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503664; c=relaxed/simple;
	bh=MvUX8ATRqHrAVg2AmkgXO45Tjvr3oF1z18thSDMS8/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVmL9iQ1KTnFOZxaI1NK4OzvceoNe9YYVlxD0Q5b46+zbHfIcvCjmlwda61y93GMPxOwKPjqsqTSIVYrwNt9YHh1IIIqFpRqrLRK2E3+YFiyGh2R7KCoj97eMSa62OmeFlbs5sbPIGAOCk164Q0G1FyTXpgy7bpnhCLkElBh/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KKwNvoQK; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KKwNvoQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfihFnqq494bZ94GeqZNPjAH8Czkbiivpz7bgh9feINlvQxGIBpZcURR/pgQVhn1HoH6pYzdx3ViePVYvmhjRV2dNLF37Rpi1DVcgEh8WdvKOcA0EFoMF9BXI9H4ERrOlQ3aKBPeTttq2YJ90xOJ3BUIK5NeVIC+53Ma+b/z8WyCRtX9vSCi/tckYd+1cH2cdiY9doNk1NupPr7TWnew8oWVPk2TszR6M9sjGLhyNwRIKB59br1BOz73YocL3PQpQP9uKZx9feXEZXhLp+C1/wl9LrQ+yN5hk8sUnnT6hMftCqKC4vcU655NJp649oBYIjC8kYxr1rRIve7BWvvmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivvu9ocHfN5RmXgxRRvSJVyj2w55xiJ5aeC+yDlYX/Y=;
 b=g9HQCE4TVBiH1lgQ9igh9I7ki2xP3s39cjOY+Qz+t0gnKWIVOraDq4CpNgeD7qiEL3ZPrav+J3152BOygKNFTa3ue+TpzvSoR8xDIRvFvRl465eU7LrmnaPUyPDDpeh8/pdCrUvMInwaFpqYQfQspP+Y7BfJddKkuqiJKO5aaUMv814ljw8VaZidJ+M4kfRPRpgAuKKEAZ7gpKU1aWvSqGEYgeCrunMm5Y2DWKDDsx47FpVjU3+CmjOi4j9bYwsf8bqen6LpqsAgVWkUX4HMItHF0WXFJ46OeSTmAWO9rgiQKoNcIbcG7y1sL1kMzFs1W6jL5eCir8VcIG0J29L1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivvu9ocHfN5RmXgxRRvSJVyj2w55xiJ5aeC+yDlYX/Y=;
 b=KKwNvoQKF+766sWQvn08yhSin8IUTwzNAC6fhRKV3IW4qjXeGxUh9YRQmDfNmTUIE0gBzNzwACJayeWJMhKe38ZALnd6siDk/XYMYCGtqHFw7pL5H9n0MKR62dhHoxYyRYBh5y2AUDpe+IslW1IgJhduShnXxFf3rxw0sgECubIc/NFMlSJ6wSuLfdy4fglOZQWCr6JbRoiLsB4JPi8ZL9QfgPaNEt33Bb89uNR3uEvBxJixvGOUiBpl1C5NpODYBze2fsKJQ2GGFvg/lM+YkpVO3yss3LH+kL2T9yQi2qhWg9ld3oOuh3iPlkeZWu4dlesWGl4gKr0k1hkVeDnvjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 05:40:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:40:56 +0000
Message-ID: <b49d56bf-db53-48e6-8253-7217fc528eb6@siemens.com>
Date: Tue, 9 Jul 2024 07:40:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
 <875xtwcd0v.fsf@xenomai.org>
 <92516aba9b4726ac25f00731abce36d99c96ef84.camel@siemens.com>
 <98bce1fe-9669-4cda-b5af-7d2194808f79@siemens.com>
 <33a683d330571dc955b7d5f71caa9ee5cf5f31c0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <33a683d330571dc955b7d5f71caa9ee5cf5f31c0.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c95e9-3858-4350-410a-08dc9fd9b454
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am1RS2FLaHhhNGJLR3pJNUJDVjZRN3ZjSGFna0pjM0JtVVJ4UTFMMDFQZmdJ?=
 =?utf-8?B?dDJLU2tFdWhLWHBrSm9BK1RXazFnZTB6UTFmdlRPZGdDb2pqQjJiZFF0V25s?=
 =?utf-8?B?eWNSSi9IVm9YcFRYWVJ0YkNIMDFzVVNSTGtkcUxDVVlqOEJJckJVTEl0WEMz?=
 =?utf-8?B?VmRBRGJpY1c5SndiZXpZSHA5enlheE05emhOMS93R0dPdDY3Zjk3amNjTGNE?=
 =?utf-8?B?Ni82UjdkTmE2SnZqYjdhZzgraWFid3FoMFlRZ2ljOWxLZVJHVWc3OWpiRTlH?=
 =?utf-8?B?MFJ3cTgva2cvc3lITlJ5SyszTE9mS3EyeGpINUpKL0FrL1U4SFRnYWpxWHd1?=
 =?utf-8?B?cUt1bEZmNWYxZVhjS2VlZTFleTRyUEtBclZHeGVWanZhUTJMV25EbnBZdEdX?=
 =?utf-8?B?ZkZ0bitDVE9qNmVQRERhRlJha1gwZ3VmU1d2YmRxS3kvejF2VDNVekwwYjZ6?=
 =?utf-8?B?Yi9hbysyNXplcDhtMWo0YUhkc25hcmJUY25waU5DeHBWRjk2OFhmb0JWdThL?=
 =?utf-8?B?N2hDbXZOdjVCUEFFQ245ZzFXU0doYUNweUdpMjE4c1kzcWRvdGdHSDJRSWtr?=
 =?utf-8?B?M3VoM2xlRkdRd1RiR0c5Q0svNVRyWGtudDRLZjNqRWthejNMeWppd1hkRktP?=
 =?utf-8?B?V1l5bHFCaE9OUGVXdGtPV0FCdGkvL2JWeDZTWGFQeHQrTXR0OVVEdEVaLzJw?=
 =?utf-8?B?NkEzbjhFemJWbG9ZMlpHWVBDWnFDZURNSXoxZGNUbkNJV2ZLeEExTXNxbjN1?=
 =?utf-8?B?SlFJeWNRNkN2cVVWNmdiZnhTV1lLOEQ3ejhyaWVKTmpjTHZaVUhBMklTUkRQ?=
 =?utf-8?B?d3RNamcrT2F3MDhMNDJxSHBaUHFxNTdPelFjUGoyc2p4c3FzU1BLcG9tUk5k?=
 =?utf-8?B?S0FIRkJIVDRiUENzcDdzUlJveks4MEJOYTZlYmwwYUMxMzhkdGpSZjdha1Zw?=
 =?utf-8?B?WGNmWDlWY3hyTlJ4UWk2cnJlTVNyRkE3MUIxZVpDSGdybnFNQ0hlYUNEbXZr?=
 =?utf-8?B?ZGpzSDFWUi8vR3hQNnpzdExWaTE0K3A1V3JtYy9hT1JFYWxhMkhhODJ1THFJ?=
 =?utf-8?B?UTBaZDArQXA1b0RXcWRSb0hvb2Q2L2c0VUF6dWgxVXV3MDl6QkJydlFVVktk?=
 =?utf-8?B?TVJSaFFKS3laazlFbmZKSEJ4RHBOak9RZXcva3dYN1pIZFg0Z1BaM1AwVjVm?=
 =?utf-8?B?dU5tMXo4Tlp6eU9PcnI3bVRMVU9DQnA2cXhza0g4T0wxSlRFblpTaXYyQ1ZI?=
 =?utf-8?B?RnRGQnRtNXFoSmw0VEJGcFZ5RG9kczUwME1nQjdNcmF0NzhmUDg1c0xsWU9r?=
 =?utf-8?B?NUQyRENwZEUxSjltTmlEUnV2LzJ0R0NRSTRqbTU0ck5HVFJYZWJibVgzbVFL?=
 =?utf-8?B?ZFB6SmF4a3Z2MGVKWThMekloTDVwaGFOWXZLNDlmYXRaZHdmZWhkZUI5Mm1u?=
 =?utf-8?B?eXdJU2dVY0J2SjBIZEZJSUJudlhjQmM2TDQ2c20yWmlyamxnNXZvckdaYVBV?=
 =?utf-8?B?RjJJWm1GNFJYUUR0VWVHOHNKc3hWU0U0UGVhYXd2RGJCcDNrL3NSYXppMEc1?=
 =?utf-8?B?eVlJTDFaSjQza3JEaEIyRkRtSDZZelNjSHZWYzA3ZjdRckMwMGFiUWNCaXBN?=
 =?utf-8?B?MXI1MjJ4MDl6TFVqWm93QzJZMmFqTlFpQktPQ1BCUERuNXhkZzZQRkFsMlFx?=
 =?utf-8?B?Z0FlS3l0c1lTdkFQMUtKcEFFVGdJY3Vla1JybnNrVTF0Mk1IVnJpckJtK1hr?=
 =?utf-8?Q?sj+ZLYLnjUEnIIl/9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1ZTMlE3cTdzUzdtRFNYZmtyZVhScGRGV1BLSTVhU2FCazY3SG1BN0xkcHNL?=
 =?utf-8?B?U3dSajV4dkllQ2s5TjRRZjF6NmI3MGlGSnZ1U3V0dFVHbGYrYWw5M3c2YURw?=
 =?utf-8?B?d25iRTU4eElxWWxNMHNNdFRjS2NoUU1qUlJDeDYweEJQVnhnWEJwL09wNThR?=
 =?utf-8?B?bm4wRFN2SkFzNmY5TWpGcHhJNkhtNjBUN1A5Mkx3YXNwamhIeFlDcUJ2cmdn?=
 =?utf-8?B?bEhkWFNwZDVWd3FsZUJXSkhJUGpNdGdVY29MbFlxTERSeVdZb3BEUldiRVBK?=
 =?utf-8?B?elRESGlsdGtQL2ZwSUlGeEVQbk5hUXhSKzZ5SStxNzNDUzYrS1BPVTA4SXEv?=
 =?utf-8?B?OHlCdmJGbjJtamgvK0ZXZ0J3WlBCOGh1NlNtS0kzWlFILzlCdmhTVkhVMWNT?=
 =?utf-8?B?a0MwUmpyVjVrMFpaSU1GZHNDbmJFSUZNSmE1ZDJPb2FFSTRVT1gzMWZjOS9r?=
 =?utf-8?B?QXlwTGY4eTJ0U014QjNDTU1IS1dqVTVueDluMEJadk9mQjdjQkQyU0RzYWk5?=
 =?utf-8?B?UnN2bVRlcnFKVDhsNWdrNzdWTGpZS1FWbS9pYjRjMFowVzFEdTdtYktjUDNL?=
 =?utf-8?B?RnlYN1RiaS91VzQ4YzVIYmtLbC9COWVDbEJKQnY1emozOU8wMnZQdjEvUGpQ?=
 =?utf-8?B?UGErK1p0Ri9VSVJpVUY4ZTdKWitXb01BYWllK2w1NktidTF4Z2E3aFZRWHVk?=
 =?utf-8?B?c1FLSTFEbDNVYUl5VDVQdWw3NXZ3ZmJHUnVPRVBlYW9VWEJxMU1YdjVhVTYz?=
 =?utf-8?B?VzBWWlpCcUQwcEc4dWVtNnBVa010UUV3NUxYNWk0by9QdnQxVXE1cGZobndx?=
 =?utf-8?B?MG0zUkhuQW1NVnl2d0YvNXl2M3dxNDZUZmFYSnBtaFBXU2VLN1ZzZlpFa0NS?=
 =?utf-8?B?ZE9tRHpQTGRZajhaMC9wNG1uVkV2dzlNdCtkRFAvc2xkSWRYSmJEajJoZzN1?=
 =?utf-8?B?U1E5Q3dwQ0NwWkxVRUMzOTVJeW1sMDdKbythVFREQnV5OWs3c3RqWlZzMjA2?=
 =?utf-8?B?dXhWeEM5bFB5dWtlNUVrTjV2TWp1dFJ6dlJUWDQ4V0V1d0JDT2V2THdVZi9v?=
 =?utf-8?B?YXdDWjcvUmFuYTF2dVJmY1dITjdiU3YwOWozbDV4eWxackVkSFFlWTUxMWk5?=
 =?utf-8?B?OTlkV3RLVUgvR05rdkVmc3E1U0w3RDZkSHEzb3Y1dG5wREV4VmJEMU1aNWVD?=
 =?utf-8?B?bElhanBPZlpxQ01KWXU5aVd2ajNGb3E4a2J3UEFkdS9weWdtN1dCU1BTNHUz?=
 =?utf-8?B?cXRNUEEwYVNmS1BPTmNTcERneFVtdFhkanpnUHRNczBKRmhIMEYySGowTmwr?=
 =?utf-8?B?VDZYTm5qUERJTkQyUDZKV21nQ21oVjlwalg2dy9WY1plQUhIakptVmVobEwy?=
 =?utf-8?B?djR2Ujg5OTQxYTJxMnl0NU13cmdmb3NpTFJCdzZCM05oRkxacU1BTDlNZ1Zn?=
 =?utf-8?B?UkFjZE1IUm1oTHVOb0tHbjlTZHcyUG5ObXNUYXQvSDVGNTErdlNmUjBpQmts?=
 =?utf-8?B?aGhUNDErZE1NVHNCaWMrSWVIV2Z2U3pkQkRWSVNZcDV3MjFsTU9iRC8wTkww?=
 =?utf-8?B?dXJ5WFhuS3hZQmRwNVNuREM4U1NZeEZyTWI2eTRhdlhmYmlNM0p3Rmh3RkZG?=
 =?utf-8?B?eWVHM0E1bzU4QkdFcHhYa1NrSW5SK2VESjV2V1h3TDZwU3MwUC9UejRsZCtM?=
 =?utf-8?B?K2ZPbkJYZnFISklsZGZKelJNUXl4THJJc0FoMVVjQ1c1UU1NUUV1TCtYaHIz?=
 =?utf-8?B?eS9GN2N3SC94eGZXeFptK1FrWVB5WHl3ZzNRYW9IZEFtU21oSWh6ZXpXSUI1?=
 =?utf-8?B?SUQ3TXZ0M0xUN21hN1Yzd0lPd2diQ21QZERVdjdmYkRsSmhSRS9yVDUrSURV?=
 =?utf-8?B?emZjQWV2TnhvOTc2RFN5MnNDSDRGcWFobUplWUZMUFpkemtDS3FVY1FWUm8x?=
 =?utf-8?B?RXU0RU9qRm5MemU5U210R1JTcUxoSHJLdVVRZ08yQ1Z4L3l0MnQ4SEFqd09t?=
 =?utf-8?B?cld0MjI1cTE4U0FGMkM1OUxDT2svOHMxUzkrTTJqaUNZMlpOMW15MTBDaEJE?=
 =?utf-8?B?UFp2ZnFuODFGdXBVN3hoUzk0MjVQeEd0ejA0OGxLeHdFeUlWSUtLY3FldGhw?=
 =?utf-8?B?RU5DTFlTMVdHMEtQb01KcDdocmx6dDVnRHVtNkpoaFhoUWkrK3BhWmpLak5h?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c95e9-3858-4350-410a-08dc9fd9b454
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:40:56.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EME9Fh+E1ejZObj9ZkEQypYhg/ylkQ5Iwlfn21TtBT5DtvCjSkJfbRP+hBrBpoP2x1aLhyHAFuVIyLAcZGr6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6987

On 08.07.24 22:59, Florian Bezdeka wrote:
> Hi Philippe, Hi Jan,
> 
> On Wed, 2024-06-26 at 13:29 +0200, Jan Kiszka wrote:
>> On 26.06.24 12:44, Florian Bezdeka wrote:
>>> On Wed, 2024-06-26 at 10:40 +0200, Philippe Gerum wrote:
>>>>> Florian Bezdeka (2):
>>>>>       KVM: x86: dovetail: Move handling async page faults to the inband stage
>>>>>       KVM: x86: dovetail: Allow kvm_wait() to be called from any context
>>>>>
>>>>>  arch/x86/include/asm/idtentry.h |  2 +-
>>>>>  arch/x86/kernel/irq_pipeline.c  |  6 ++++++
>>>>>  arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
>>>>>  3 files changed, 29 insertions(+), 8 deletions(-)
>>>>> ---
>>>>> base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
>>>>> change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad
>>>>>
>>>>> Best regards,
>>>>
>>>> Merged, thanks.
>>>
>>> Nice. What is the procedure now to get that into the (non-rebase) 6.1
>>> branch?
>>>
>>> As written in the cover letter, patches should apply down to 5.15, I
>>> can look into 5.10 again if necessary.
>>
>> I will take care of the 5.x updates.
>>
>> Jan
> 
> Any news about the backporting / release process? Additional help
> needed?
> 

I'm only waiting for a dovetail release of a kernel containing those
patches.

BTW, a rebase over 6.6.37 would also be nice because of
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=2ab254507c87b8ce6787caa31154e089a640dc20
vs.
https://source.denx.de/Xenomai/xenomai-images/-/commit/8d2f7d5cf008797caa28d3a064c1378274b52c63

Jan

-- 
Siemens AG, Technology
Linux Expert Center

