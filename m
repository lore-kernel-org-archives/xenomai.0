Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C362F1FD7
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046231; cv=fail; b=AL5loEqhatx04AYBpVQZboB9DSw3S5YRk6gXYJ9KYesbBEeC+wkANKicssWB0ODSkV8YtpFUbkC0LC4BDIA/v2qBqrvG5VXRBo6mHwQifJyep6hfBVHa+ujqSa5gEoQYVnCFXHFdVuX6xEpx3jh5394UVlcQdYDPledk1DzuoIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046231; c=relaxed/simple;
	bh=qDR/OnkgpWJl2E4BmsBoufvcoO8oem2JMUg222IaE+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVPrzlahAod8RXUeEqjd0zCH+u+G9NaW9GTajgvR9iJGQShoGISYBnBdiF95WP+ZeBT4ymJAsGigUgIJdAvwsZzc+VvC87My62dNoKW0zl1kTXA2Sug3hQX+uKNFKuBsvkKArtSjYlwdl9UB+el4DEXvMwObISuPwk/IIBUoB+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Na9ErnHH; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Na9ErnHH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iueIeFQL+thBKQm+CExcbi7GQ/W8B9+mK1doGdq7ig7/i8CAlFJOUjumNwLGmggQmezXHnMMfl6j46MDUf0v+bbv/AI3Fn5Kw8wgvs8mBNIztXJQH1hbZZEnVhAWtYvf+mMdATvF54apNIg5dv/YqJu7s6K6C5Q9jEHU3U3a7GCVtS+TosLEJq7DFuKhADfrdmhx1qEh1FGkjU0+bIWwNMQzTGqIOYLULQzcJPCsTYiUmepCTeKnf7NYAiShJNVAlXniQu4O/bSQXEp5Yi7Opf0dzz7ZDdNmbSfwFB+nq5VIS73agl0z6LwdGsGhxRYaPzVvN0W0FcmPK099yYvt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afEVpfEduidvqA/4Twvu94WxbzFIIHp9fx9EQnV0Yag=;
 b=ZX5Ujx7EzqZWrGX59eUwNPQ+RLItOJXZV9+e/jlg1xq5rXapgoSO8dDdqaTqSgSh8ypAkFIlR+ibf+1AbXGRO5lrDc4ZR4a6OBC9QFzBMD+QsbYYHctcdC8AYMmJwQJWBshehZR8KYNryiivoilaXKdMt2YyeSGqbcmenTZHleJ+WHdNjs4zh19OcWH46WfCOR3Z0vtbqHVse70Qu1PeCWIEZxAfDz3uZdfgqL4X2MoKy+/n0VvcuxWWsjZSQ3Wiji/F05D/HvWbo9FHHG5KWhBMtFxqhMq8RQhdpBspqYBDC26YPNWrzC6SfRG0XgybKgMZMszZuqTwbg39hXlLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afEVpfEduidvqA/4Twvu94WxbzFIIHp9fx9EQnV0Yag=;
 b=Na9ErnHHa1C6zeADNXp0YsEa+kNZ7CUuDOigEWLgejMbovqcJdFWGqDrKH9aUPXF5fv20A6SbVDVDRHqR9dT0Yv4zH8/oQn8/wcBVKVMvOBMTxhP7YNeAppY1LRvRMrtLQbwNJTrjGYXQEQKRsheVoFshuKNcx9MQyGaWAo5n2niRKHPl9J0f8XJuRe9Yl8/yRsuNDh1iVy1nmmdKmXL1WuL2hTaQ4VKfS8XH4l9EeNR86BDRVaI1XcCEuISE8YK/Y/0vyZIwE+MKxjt6656CLLh67EfB6Gh/c5yvsqNwL3r8gyFS/gnw+YfE2OgIE7BI1BRh+S/PWHAJSVWg+M5yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 05:43:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:43:46 +0000
Message-ID: <be12088e-a8e4-4944-946f-90da5ea2cd13@siemens.com>
Date: Wed, 6 May 2026 07:43:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v3 4/4] ci: run ci tests on StarFive
 VisionFive2 1.2a
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505201617.148513-1-tobias.schaffner@siemens.com>
 <20260505201617.148513-5-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505201617.148513-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 322091fb-010f-4af3-cfb4-08deab3270da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PP+dq0qwVGgHJr6QYolktCFtvtOfkXAtujNKZnp5f1MbODrGDuVwHnQccw2vPe8+kHJ8cmSfhXWbRhXEBEcIpWASSGFXT/pP5DDVDZlFhuh33WY7Hd4j9KGq/Nn/DdMGU4Tw1DryG5fogqhIkFeFbravEvakKWjtFt0skJX8Go4bjwZbNfEngs+Qhua8PlFPnqAsYgh77zyKCnfdk3v2ZwduddqKJALl69eZNmi+QD5x2pdrN29MVY+G3JHOJOegUdHDV6DOxOUar+gi/7uGqaISrl+v6DV1QFX2nHDINrSZJDsJaUe2Pqq80mz/iTXNLCCmM94TRqKsjuYFDfFv2jEx8l2F0S0ovgPHMLUQd9iHGJHukaZikzbcJg3H1tmktTdZ1IaQ5L3Jq9wDb24la1oqnViEiWQyQhiidC+ee4ogLh9GgeQkS0nZ7EKWnGt5eRljX2VPuIE0B4UlAvJuqCxBeYKiRIPP6pHeTGZbMXyNUjLwnkcSDRKxP/TVfo9Ef7DsHpc83r+jhGXL7iBZHQLXHHdUTIIlROprwy7Bt8lwlYgZ1wt8ptzFIMluf294h9xDxU2ybYcHU2F3H1XOJIsowhH0Ezl+m3vQ3I/Z9ZqZ8OCkHJ3JjyqybSlx3pvNZqQL7cKd6UgVyQiD1D/ExjCTxJi+tsx6lX4kNnu09cz1KBZU9kY5UjyMISLApBhb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEcvcDE1R0JBelBOWjFsRGNsWE5XZEthbG5jS2ZRV1BFQVdrZ2d6MEFuYThL?=
 =?utf-8?B?TEFDR0RzS04vUmlWSFF1YktrYXlJNjNOUlpNZHBjR0lXcm9kUGpNdVQzTmhw?=
 =?utf-8?B?YUZLTFBrNXlyZjZBN0QrMktEbnZmSlYwZGRRV1lQVVA3T3RkQ3huUnNtaThu?=
 =?utf-8?B?dWhGZmJyT1FrdXE0ZmRURmVOakFpaUd3dWFvYXk2N0pQaDhXUVpPWHkrL3hi?=
 =?utf-8?B?aW93ZGJOSFFyY3hLaDl0SjErRHNSSUhCbEROdkQwSlhXdW5LTXVUbElQUk5I?=
 =?utf-8?B?KzhzK2NScXJVV0RaSmNkTzRmSFlJODJManZNNkVBY1hnU0RmMDBjL0cyc3V5?=
 =?utf-8?B?TTU4d2FlemZnbU1aVGpseCtRcWJLUUNad2xnTll1Q1FSRFAvQlpkalh5WFVj?=
 =?utf-8?B?WGpoemVlMldYNlBKN2hiZWFWWFRnd1poa0VCOXBleGU5N2tCNC84bTYrSnBZ?=
 =?utf-8?B?bllMUjdxdFNTVitjOGV5UE1jNEdHYWd6N1QwVVlqamt6eStPQjBuanVkQTl5?=
 =?utf-8?B?MENUdHFVVUJRWk0yTFNiQUZVdlJqSUt5OGJHYkpKYVdaTDNBK1NuLzZRcGFh?=
 =?utf-8?B?VkZHd1VpRnhaYzF1S3IybXlzSzJJQkNTemJndlNiU0JMWWhGbXlyMXZsejVW?=
 =?utf-8?B?cWpqTkVJYUxMTGlGVzBCMGdZTWxhalF6TXhiZ1AxbExpSnd2YlhQWklESCtT?=
 =?utf-8?B?MGQzeFJvMlgxSmZpRks0TVlCZ3o4YnR0Mi9MOGMxbFZPNFlYVjNRTi9KVE43?=
 =?utf-8?B?RitxbXllZlcvTlZCNm52cVFpeTdjRy9uRXJKcnBkRjFQb3Q2VHJsYmtNdDh0?=
 =?utf-8?B?Z0tXUGZGTXZhTE1Ic1F4Rkd2bXh1OTgzWkFMNlNvQ1FJajBybUVCTXp0cUZC?=
 =?utf-8?B?emI5aXIxYThOOGZXV2xGNi92K0I0UC8rd1g5b1QrOVdGc2xYaWtuQ3pOWENk?=
 =?utf-8?B?Zk11UmJiZWwwc0s5d2J0NS9WSktzMzZYNjhKU01pb2xuUHJnMlhyWXdZNEVS?=
 =?utf-8?B?N2tFS1RhNUkyQlpxVy8va3AzaDRSTEZTYk1WRmY3SithcXpVS3ZIbHdTMEFW?=
 =?utf-8?B?aG0yckRiUVk3QmF4dnlXM1YyczUwemx3UW9EMlpvaWV0dUI5SE53d1B2ZDBU?=
 =?utf-8?B?VVdBUVZtR0V0RUxCVldWWElCVG82eW82TlJ4R1VxYXRkUnFOc0pwUWJSSWV0?=
 =?utf-8?B?alNTdTdnQjIvOEdabXo1eVFQY3pIaWFmcEpsT3Vab29vM21ZZmlFTXoydnhM?=
 =?utf-8?B?dk50d2RyT2xDNmNwVkpXcWJWZENhUWZERk9SbWFxVmY0WmNRNzgvdEJQTzRX?=
 =?utf-8?B?RmNLZkc3UEM4YXV3a3Q3ZjNoakV5TVRUN0QxSDNYZUJpTVBTVkZCVXhXTzhP?=
 =?utf-8?B?Nk5vMG1pWDNlYUxqV2xFc3d0YjNGZXR0OHhKQjFiT0FEcEw3NkRXb2Q2cFlh?=
 =?utf-8?B?Tkpqbkp5MXM4Zjk1MUFlZGs1c0MrMGVCYlhlVVkvU0V5Q0VxM0E4NTVOOGxI?=
 =?utf-8?B?dlJjRHJ2NEIwUG5ldEcwSW9kWUNOaUEzQzVISTl6VU54ZFd6ZlQ0dGpUdExB?=
 =?utf-8?B?ak0rbmdVUDVVTlVLQW5BcXJsRTBrTU9OcFF4TW02UTNCVzluYm53aG5VSnhE?=
 =?utf-8?B?MDV3bmtObm5ZMUNXQytiNzMyQzdyN0J1TmtrT1pSSjhyektjTThoVTJhYzdz?=
 =?utf-8?B?dE90a3dOMjdHbjJ3dTJGZjZyZmFRaDM2NlNiWHBVWlh2VFFWZGo4T2Fubis1?=
 =?utf-8?B?ZDVjTCtKd20wb2dkMDlReHEwdGw2VHZDbXlpVW9DSFU2QnFJVTRiSzMvNlQ3?=
 =?utf-8?B?SnhtTnJhNWVSQmZObE5VckxDMGQyMHZjK2liQlhRNjN0c3BsdmpnMnpIeVRp?=
 =?utf-8?B?a3FhdHpVRjRlV0FheGZjWXp2SS81QVlURUE1ZTVpMHNPYy93aGJqSUx0cHBX?=
 =?utf-8?B?U1lKRm44Y1JGN1JkbWNMZnR1TSswdWN3ZjZZbXhBem1OTlFSNk5wUzJXRXpk?=
 =?utf-8?B?TTFZRVh4ek1xYkZEWXp3eEw5MlVJOEg5WWJ4SWJ5RzZxUUtjd2JqSW55eDVR?=
 =?utf-8?B?Ti9Zdjd6eWxIdGx1dUhDWWZyRDBkNGwwbFhpMllqWjgwVThYKzBadkpyV0Vu?=
 =?utf-8?B?cDFiZWpPSU9BS1hSZHprS2NCTG04M0hTWWpHU2dxTXBsZi8vQ296b0orMFhQ?=
 =?utf-8?B?VUpCYWZNV2Zuc01TTW94d1YvMCsvZ0YxMUg3UTlUSW9jVXZHOFpwcTF4VC9S?=
 =?utf-8?B?RitWTGNxM0g1V2ZrM3h0a296UlU4bXBHbkFOaFlacHNBZHc1TVB3L2t3ZWhV?=
 =?utf-8?B?OHFuMzBYcCt1T1Q2YVRLTE1yR285TUJDcUxrUUxmblUvWXcyU3pnZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322091fb-010f-4af3-cfb4-08deab3270da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:43:46.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn3+IJW73maCqT5lkB85c77INyiDEdDqV55zq5Ga9qQhwHQwQIWXyqxaKuWdzQZPZ+xm+nIOTDmmHL98jo7kgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6759

On 05.05.26 22:16, Tobias Schaffner wrote:
> Add CI/LAVA build and test jobs for hardware testing on the
> StarFive VisionFive2 1.2a board in the xenomai lab.
> 
> Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
> as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
> workloads from time to time.

The second paragraph is a mismatch for this patch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
