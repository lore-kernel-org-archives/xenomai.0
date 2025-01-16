Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C57082F
	for <xenomai@lists.linux.dev>; Thu, 16 Jan 2025 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737007721; cv=fail; b=USzO464OIq6o+bVdyZsxlfEf+OkTIx3jSZXFznJwg4xkO3bB5gfauG9P47JFGhkHlINn5Y+WLIn46uezYEVAJwLXWPuQK5E4xuGZLefiN6QaHPrADJ7CYQSLCsMMdlNFA/ySf1HHaWjcfLUXQS+QGJohZAbvVRr+i/RS5nybS7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737007721; c=relaxed/simple;
	bh=ndyzlNVXTfNaka3g6Vcp6DWI/Ospex+6zaINeVCVZPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFdkIu7rRrngTfWbNuePMwOW0ceZCno4k2I2xRMf8BImaIbxnQRfP3FbHWGsNgdgk6aXVEH/QhgMYyj5qPPrCo+yvzv7S6280FA7no1pOWEQlFxvG8AkVHulGrQUJzpk1Iv4NA6uf64X2G38yV8Fem7F/Wq2VrEPAlV3/cwGJpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JEXYOMrB; arc=fail smtp.client-ip=40.107.241.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JEXYOMrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLg51qeS5ERnH4Z39gfJIe41pXXhVwUjtF2ZXHXGRplvVc1e00xYyXYLe2FDjSD7ekmhZBRv9m4h5F3ufd42PlK6lXdrejgwVyZ8YpsFwStZb5ocmWN5R0g3sfIwc4ygCZNw5MlvUfYI2u0bF7AOek30BbDsvJihPZoVOjoBY0tyvlxj3us8iAOVeHjXUTvGj9DTF8AaDbufXlaYIBnWTFr8ksUusKzFZ3XITyG9ZTKsqCipDSpqajdqoUwRNvV/nRhPccNocHZ06UAPnZptn8M87FAxeKddV9maVtJC9M8YXyJ9d/IiM325xf744b9CUJjjzobk2VRsWOkdx+Of1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUXGOzF568gtE0Mra3Ru53X3hhmYylj98OrphIuwN0s=;
 b=LOfJuHEl4TMdn/oPdimRLZ8jR9UCU/6qACCPTVJ0HtwZsiInOGFqYh/pFRQvbmggcaaYjmFf1g5RHuSLb/iyLdyMxuEZ59WVKIUmll/m+kMfzzlW0DsRCaXNXjRHkeX28sxKNdMrVLhokkn9zDcDxqv0yNFR2rCHHrrA3UORvsdZ9wR1SlBNETmsTef1FriQQxPSd/VEggB3eSwmQchGGvHsz3TJPjpqY1YitlhMXast1+aCcFv/OX8zzYCurzbxT1IUMi14bPr9V4yc8s2t9wAFRIOCYQcjxayHG0f+xjBwt3SjfD0cA9xGKD6hvzPFgRez5VvQYCcF1Bh7z5tsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUXGOzF568gtE0Mra3Ru53X3hhmYylj98OrphIuwN0s=;
 b=JEXYOMrBzi4fGil6Ike086/8j/K8zslTczsYC/GEHJ5XqnlpaGEKEgnAdH4c7zCIhmiAq1uf10l3HY3hPUdJkbI2VgxwMIGGzDBKDhDUtxpXlXSXQd5TYiTdXfQVk6WudKMsuUMsGH7eo70YweR7qupOR3G0oKK3DGCUugJm8746Czwtd1mPtcZ0bIXHtAUESsyBAkXUcJ37/JMZthzpAlU+Uiw71kuyvECRl/rVjO4+8HHdpG89w62l6VHRkLz4QHYbB7ett0MyF/jf0pECJotTDRrUtEZ84e7zgsuGsqjo9/xmqCJvjF+TvxEK9VFTmYfbmSDAGiF09ByNlmRniQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:318::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 06:08:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:08:35 +0000
Message-ID: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
Date: Thu, 16 Jan 2025 07:08:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] libcobalt: Cleanup / Remove architecture specific
 syscall API
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20241012-flo-cleanup-before-release-v2-0-3e9a16780880@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241012-flo-cleanup-before-release-v2-0-3e9a16780880@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d53ee1-ccb7-4e43-8be0-08dd35f43552
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWE0RWIrSFovcy9sOUt2d2gwNE1SbEsrNmgzTnc3UHFkWmduaS9xVDEvY08z?=
 =?utf-8?B?Y0FFODUwbXdOYmttWU52eGd5YnplaEkrVDVVSmFsWWk4TlZ6VUlFZlJkcTVS?=
 =?utf-8?B?RGlhRHk2Y2QzZXZGYUYvc3F6OEFwVnc4ZktoTlR3ckc0SlN2QnlwTE9qcUZv?=
 =?utf-8?B?MUJIV205L1lWM0lUM2p2UlYrem1oYVdSbFFIL3NCRFkxaE9WL2NXTFRDTmJB?=
 =?utf-8?B?aFMzZ0RpZ2RzQVM4Z3E1d01wUlNVYWFURk9KMmpIMDFmYXF2VC8xekFkb1E4?=
 =?utf-8?B?SFphZUdGeU1aM3BBSDI1WnB1R3Q2WEl6RU1VWjFaczBad0JRdXl5Tkc1Q2l6?=
 =?utf-8?B?cVBFTGExSENEWERKeXJBNnhSLy9WUUlDT1ZmYmtuNjY2UnJJZkczdXo2RXdh?=
 =?utf-8?B?aE5veHdZOEZBUnE4bEo0bXZiSDBzVURYOHRwa2R1ME0xTzJyMWNKR21aNHN6?=
 =?utf-8?B?Z0RqNWVIT3JDV2NSU24yWCs3a1VFdk1uM0RzYzMzRUZhUVFVSi95MnJhSUg2?=
 =?utf-8?B?YUYwSWNPTGpEcVA2MG05TDZOR3Y0QWZpZGtRQlBRVzRsWFJBODBZcEdlTGRv?=
 =?utf-8?B?VnYrcDlYNEt5emdtN0oycGVINHdMV1BZVmc0ZnNabVg0cWpWbXRHR1Zvc0FB?=
 =?utf-8?B?bU1Sd2tockowdU51L0dPS0pXMUdoTnN5Qkk4ZHZjTEh5bThxQjBiZFEzNjAr?=
 =?utf-8?B?bTc0QkxtRHI4UDhkRmEvQklKeTBMSG9uU0RSV05ZVzhRMEtKTERGbmlpaE9J?=
 =?utf-8?B?U3VWU0dUdU1MN2NES2Z5V2t4cUlPaTB6ZDlpVTV6dk1xWis2c2EwMmRoTkZo?=
 =?utf-8?B?c1RsR04wNVhiVGhydGprZkFRUEFPU29sVGF2akJSM0RmaldpTUxVMkVNNUhU?=
 =?utf-8?B?Nm1JdEFLdjVaNlByZmhyUEt5THRqcUJEWjdnOEdMTDl4amJ5aEh3M0c0Ynoy?=
 =?utf-8?B?aERiaWp3UzdBcmNjQlI0Sll1eHN1NGlHUFNNME1lay9VSjNTZFkxYjg4WFU2?=
 =?utf-8?B?TnR6ZTNhVlVlV1poOG5wdXZHaHNRbXhMenZwTlVsdmtVOStGRWRiYitya1dU?=
 =?utf-8?B?b0xza1h4OHNUR2RMME9BQU9UcUE3R3RHNFdZZ0poT3hQU21SZXRGNDM1VndM?=
 =?utf-8?B?Q0dQVm9lcS9qMjlUTGdaSkVPZEEzR05mSGEzVk9GVWtBWVJjc0FTN2F1dGZo?=
 =?utf-8?B?WkMrZ1V2NFoxZDhobXNqMytYVXR0c2hDQk9PMUxTa1dFWWxjM09jRDFHUmVm?=
 =?utf-8?B?ekpoK2Z0NXdQNnJQQ3AwRDJIWTJjYjZYdTlwazZvZzJOejh6RkN6b3dlNG9O?=
 =?utf-8?B?RXZoVkhiSHBiRlJqdUZGVjNNRVBJb1ZmSG1CLzRwT1E0MTNaS2xlTTJiMXRV?=
 =?utf-8?B?T1o4Qy9HV0ZmZVBXamlXeWFtMGZPWE85cmdoQ3YrdG9nRWhWS29SL0d1bjRS?=
 =?utf-8?B?bGdoUEpGRS83WG5vRGYwTFZYa0VIV2tHL0d3VlFxLy9iTkdTUFZITnhkNUls?=
 =?utf-8?B?SDlJbm44a1dsUkFSaW1PM1cydnVEZXRRQmE1akd0SFZSSTgxUmJqRHhzWlpD?=
 =?utf-8?B?VEJNeUZqeGx6U1BCZzBKaGZTeU1lbzMzTzVobnEraVJrTFVtRHBWc0g1SGRB?=
 =?utf-8?B?NHJqcjdlNWhDYUJETlN1Vk10ejFEVk9OVFlqZTdseEorYWo3RGUzajZEUHZR?=
 =?utf-8?B?RnFqTEtMNmN6dGp4dVNYYUY3UnhCUGNIak0yMG10bmhLSXp0NjVHWmpCRlhE?=
 =?utf-8?B?Z0NNTnZiVm93UjBVV0locHJ1VTNDV0J6bmx6eDFZRWpCTHloYkF1eWs0L3o5?=
 =?utf-8?B?OExHMitoZ0syM1FwUXZ6ODBwZlU4ZjQra3FxOFV5Y3BnUS9ETi9HZWxpcVFF?=
 =?utf-8?Q?0MhqzicfMPM9F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtjclZ1dDl4bzQrMFY5ZENhZmkwT1JiVUZST3ErUVgwTmRZWkhkb3UwVkhr?=
 =?utf-8?B?WVRCdjZpeVpicnJvMGsvdmt0Z2JGd1Z3T0s3OS9QbFEybUkrMmx6NWJVRmQv?=
 =?utf-8?B?RVQ4eDNhajFNbVRzOWd1UjdLbC9kTWk2bEtJbUh5bSs0U2toR0hyMXpoZVdn?=
 =?utf-8?B?MmdUUXJqZXZtNm1Va0NiczAyY2lvM05lYXZnd0tydW1waE5NMThFeExmdkxG?=
 =?utf-8?B?NzZXL2JmWXpPK1dYZmZWQTEyWDhSZklqZGdjclByYWpFeDdFaWtXK0RJWk11?=
 =?utf-8?B?Z2kxRSthc3kvampOajRKTys5d09TY1pnbklLVVpXcUNtOVhmNzVOaTJaTTc0?=
 =?utf-8?B?RzNwZTBOa0RiaFUva3FVZ1U1Z1JxcmVJazJuTzlVWUF5S2lLU0RhYjZBeWJ1?=
 =?utf-8?B?VGJML1FDSVF4SWgwVDdKSDNHSlVIT3k5OTR5cE1QQXlEM2FqY0p4UzFSZWdi?=
 =?utf-8?B?TUFjQnZ1SzBmQk1RUytRNzZKTURpbkNzaUdHQU5xMUFtWEs5RnlvNmo3aDZC?=
 =?utf-8?B?ZCtUeU0rVUdaVk5DWnZmY1Y1RjkzWC81cG5xajcyWDVDLy9EdUNEREhNbDRa?=
 =?utf-8?B?QXNSWTVTNlFwVWMxMnJZUDA0VkIwa1o5bGtYZk5kNDU2UjJxajlSZ3crWmFG?=
 =?utf-8?B?TEtiK2Q0V3N1RlhMV240LzJKYlRCYktBUUIzTEFPYml2Mjl3MTNmTjM3cVND?=
 =?utf-8?B?ZllURVFJK3ZRQjFuQU9kelN5NGVWQ1hIK2RDaVFMZVMrbG9yRnplUFc3R0l4?=
 =?utf-8?B?ZWFIUEplRjE2Ty9zSGM2cjhUYlBnQnMzZFBzTkh0dkxVSktiQ3c0MXhVTk9V?=
 =?utf-8?B?T2srSG5wTmp6TDlkMEJBVlNtcXF6ZmI3NU5TUG5IU2VWU1I4Qi9ZemFSTk0z?=
 =?utf-8?B?QUJaRnVaSkFSc0JxZFJwdGp1UUZGYW5DdnRmeXpCbWF6UnJ2NnRROTNVbGVy?=
 =?utf-8?B?bkwwaFh1Rzd0SmgvZW9lV0tLaUpOMXlBZDhrOHQzeVBlKzlUYUQyc21YMzZQ?=
 =?utf-8?B?M0tMU1V5aFJVWUZnc3dabk1oTGFIb1J3WXBVN25aU21GRlNrelRNVjNMdkJI?=
 =?utf-8?B?NnFSYUVsbFFkN3lZSzhlSWpSQ2x3WGVBa0Q4dGlzeWt2LzNqVFRoK2RNTUpW?=
 =?utf-8?B?RHMyaXVMcFEvSko0SC94QnA0V3htdE5aYzk2blNaTkhpaklWaHUwaC9xNnF4?=
 =?utf-8?B?RmY3eUZ3N0ZGOVBUNnpORHhYTVQ4RS9NZFI2eG9JaFE4S3JNUXIxZHg4eVo3?=
 =?utf-8?B?dlg5eGZDRCt5dWNzNU82U1BUOEJUdDNTVFV1dGdWMG4zYTN2N1Y1SXdVTDJP?=
 =?utf-8?B?by9SWGFwdUdPTFNEbHVvRFprbGJ0MUU2NXFhT3JiTVRhVTRSd1RFamozdERW?=
 =?utf-8?B?V21ob0ExejB4WmtTTkd0T3JOc3dIV0QwT0NBNjV3SEdzZUtPdm5saGFEMlkz?=
 =?utf-8?B?NFJwdlErSENnRDFGRWhUMWd5QjkrV2dhVWxmZVk5cDlHS01qVWdNYUtuMkNw?=
 =?utf-8?B?Y2d5QXUweUNzUUM5Q2hzNWhqRDR4SXRnYTZuV2VSUWRMYUpFSTdKNksyRjBO?=
 =?utf-8?B?a08xK1BFUEQ1RFJwNTJvWm44UWZyRzNKSzd3Mks4akdQSW5xVXkzNkI5aEIv?=
 =?utf-8?B?NWgwbGcyTnBQRUMxTVhEU0g5Znl6U2NFd0dDRnVSTnhKb1A1UnRyVGZSWFR0?=
 =?utf-8?B?cmlGQnFlRjBXb1llOXBmWHYrUEg5WTRscWhnZ3lTVnU2TDd5bVJEQnA4dkFy?=
 =?utf-8?B?TGZHTFREcG5xaEpDSnFMZG10Qm9nK3pVREVLNXBQMzFhSGRTYUpYcTJ6QVlO?=
 =?utf-8?B?Wnh3Qk9CQTdKcVhqbnpxVTB1TUdLaFNlYUNaVnVYYVRERmZCRThyaG9od0Zh?=
 =?utf-8?B?dFg2bDk2Uno5MXdFc3d4NEVzQkdFTkxSN3VySVg2ZzZ3elF6VFZyU3EzZDM2?=
 =?utf-8?B?S1ZaekNieWNiYk5qYlVpcFE1V3gvTWlUUjZEblVpT2dNZUtOUGhzbUFCRGtt?=
 =?utf-8?B?cUdsdE82QUlZbmtmeW9PMU5VMHVGZCtibmxHRHFpQjFwb3hjWkc2WjB1d3NC?=
 =?utf-8?B?SHcvWDl0ZjdXM2ZEL3VERjByMnZhd0Y5N0dQTzV5YmUzSldqZ1NrSi82V3RE?=
 =?utf-8?B?TTIzWXlhU3dpVGVOYTkzdGJqSzNUTUdJaTNxUWpGOXRNbWllbmxPOHBSU24z?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d53ee1-ccb7-4e43-8be0-08dd35f43552
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 06:08:35.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jM6rROveaHOYvAhlyULxnxO/ZIk4FORBXJfvhK3IbEdaAVkkGQLxNFp2YUcG/TOeSGReiBj6ZmXZuYuSwGxXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5630

On 16.01.25 00:10, Florian Bezdeka wrote:
> Hi all,
> 
> This is a cleanup that is now possible after the armv8 compat
> implementation done by Clara. All architecutres are now following the
> Linux syscall ABI, so that we can clean up a lot of our own SYSCALL_
> stuff and switch to syscall() provided by libc.
> 
> All functional tests are looking fine, so I'm reaching out for early
> feedback now.
> 
> Comparing the old implementation - assembly wise - with this series
> shows some (minor) differences in register restore operations. That's 
> mainly because syscall() is a function call that can not be inlined 
> into the caller. Looking at the mass of code that we can delete now,
> I think that is worth it. Other opinions and performance comparisions
> welcome.

In v1, I was requesting some numbers comparing these approaches,
specifically as the outlined syscall way is also different from how
glibc calls into the kernel. I would like to have them first, and that
not only from a 32-core Xeon, before adding an extra trampoline function
into every RT syscall path.

Jan

>  
> In addition this series is a good first step in the direction of moving
> to prctl() based syscalls - like evl does. There is some more work to do
> of course. One problem that was already identified is the number of
> arguments passed to the kernel. Especially select() would not fit into a
> prctl() call.
> 
> Best regards,
> Florian
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Rebased on top of current next
> - Rewording of patch/series subjects
> - Link to v1: https://lore.kernel.org/r/20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com
> 
> ---
> Florian Bezdeka (3):
>       libcobalt: sycall API: Remove architecture specific implementations
>       libcobalt: sycall API: Reformat all XENOMAI_SYSCALLx call sites
>       cobalt: syscall API: Remove architecture specific parts
> 
>  include/cobalt/Makefile.am                         |   3 +-
>  .../kernel/dovetail/pipeline/vdso_fallback.h       |  19 +-
>  include/cobalt/kernel/rtdm/fd.h                    |   1 -
>  include/cobalt/syscall.h                           |  56 ++++++
>  include/cobalt/uapi/asm-generic/syscall.h          |   1 -
>  .../cobalt/arch/arm/include/asm/xenomai/syscall.h  |  51 +----
>  .../arch/arm/include/asm/xenomai/uapi/syscall.h    |  28 ---
>  .../arch/arm64/include/asm/xenomai/syscall.h       |  47 +----
>  .../arch/arm64/include/asm/xenomai/uapi/syscall.h  |  28 ---
>  .../cobalt/arch/x86/include/asm/xenomai/syscall.h  |  53 +----
>  .../arch/x86/include/asm/xenomai/uapi/syscall.h    |  23 ---
>  kernel/cobalt/dovetail/syscall.c                   |  34 +++-
>  .../cobalt/include/asm-generic/xenomai/syscall.h   |  26 +++
>  .../cobalt/include/asm-generic/xenomai/syscall32.h |  20 +-
>  kernel/cobalt/posix/syscall.c                      |  70 ++++---
>  kernel/cobalt/posix/syscall.h                      |   7 +-
>  kernel/cobalt/rtdm/fd.c                            |   7 +-
>  .../arch/arm/include/asm/xenomai/Makefile.am       |   3 +-
>  lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  | 122 ------------
>  .../arch/arm64/include/asm/xenomai/Makefile.am     |   3 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h       | 104 ----------
>  .../arch/x86/include/asm/xenomai/Makefile.am       |   3 +-
>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h  | 216 ---------------------
>  lib/cobalt/clock.c                                 |  11 +-
>  lib/cobalt/cond.c                                  |  11 +-
>  lib/cobalt/current.c                               |   3 +-
>  lib/cobalt/init.c                                  |   5 +-
>  lib/cobalt/internal.c                              |  23 +--
>  lib/cobalt/mq.c                                    |   2 +-
>  lib/cobalt/mutex.c                                 |   3 +-
>  lib/cobalt/rtdm.c                                  |  20 +-
>  lib/cobalt/sched.c                                 |  24 +--
>  lib/cobalt/select.c                                |   6 +-
>  lib/cobalt/semaphore.c                             |  14 +-
>  lib/cobalt/signal.c                                |   2 +-
>  lib/cobalt/sigshadow.c                             |   3 +-
>  lib/cobalt/thread.c                                |  24 +--
>  lib/cobalt/timer.c                                 |   5 +-
>  lib/cobalt/timerfd.c                               |   3 +-
>  lib/cobalt/trace.c                                 |  10 +-
>  testsuite/smokey/y2038/syscall-tests.c             |   6 +-
>  testsuite/switchtest/switchtest.c                  |   2 +-
>  42 files changed, 276 insertions(+), 826 deletions(-)
> ---
> base-commit: 7a6453b25b3c1341fd1a5abd553bfca99d0ef77b
> change-id: 20241012-flo-cleanup-before-release-a90d9df08d07
> 
> Best regards,

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
