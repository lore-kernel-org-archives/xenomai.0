Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C22D9EF4
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229551; cv=fail; b=UIIsFIKkrcasgcvyJvh8Vl615CnrbkNAheVCJg6GW1cepcWf706THt7D/XcG+TWGOBdFld8jbD4kYVPx5wvWUsAGKN7CYOa/8nHOrY1lPVRunAZMP6j4tOBIWlm35lzuMStpdJkBFGGw5PWwD+L5eIZ8yowvh1sBM0JViZY0TFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229551; c=relaxed/simple;
	bh=Psygr+DlFnEl5UBZVaicV6SPAwI03P47soiQBx3RtZg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X70e+a8/nkWrJOgUSU6EdeBb/RjNlPCWp1WIRoWWi5hAvtn93hEmz1vU3VJ19abYgDS1VJieAxSXTXR1dMB9tMPC3FzLGnj1Cc9Y+JQSEyZuv8doWwKBZUobCfiDZG7vUGYUr5xx6HilSsh4kJBX+10Vc4P1lwc1X0edJGd/+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rJahEGBk; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rJahEGBk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFSCgHjreDvoGUFqr0PPt4ZlciQAckOHVgxxSVJ7HS3qAaGG/irg7AMO8Gl2DcCJnO4geJhDS4LzVfsEHDm7jtfCZC1s2Kj54DItKlzRUnEflG4j5V7yoCSzJI0oCbF2hEz5YcnxA2iySowdTIY+DVb3iP/04XeIF9X65mtQA81izH043RwB9nQ0eu+37r4hGRGRyAeyp/tSNRNKWF9HSeOyA1uISooTbGSBM83eFfuglFrYNC2jRkgoMh2bNwQdyP8ZB+03XiXQIDAj7EuzK0FynSDzwNeaoQVdAPz7veWjD30WW7JcIVFrGndllUtZ3REZpn+QYT7CYlcOIAD8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBayRX0e6MutZcgyVSVonZOJDjx5AbR/xRlVYaLXmyo=;
 b=Kw4DE6ZHxTLfnubnXwuio8G1ppm19Q/G1JhXRFEPravBba7SnXvnJCDvzdqE3IMUwmGlF6YIxQpD8lk94TwMAVyTPockqkGEVvT6f+6rFRsZRu9Sla/uKt900y3OTMuptbqC3JubqlkNqp88xkFFq7PhnMi0ZNLnlbMwQUpsyV+WPR6K4mUZzaJ7K2riu6eHsjhx3f2+PWdZJd08ig1Oeg4RCLKL+LxEdZAKgfHgiHN9d/wkgrIILx0HbIjbVmfpzrCOWDl/OeXIqvhIJruj0KnZ9qVLNIogn3y8RQAE9L2o5ZNt+2aq1lPZhKTSct8LfRd+8MoX3YxgFncfFlzhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBayRX0e6MutZcgyVSVonZOJDjx5AbR/xRlVYaLXmyo=;
 b=rJahEGBkMc9BTwTl67ZQYtYeb8+h1JTaB3p9BmF3WvbOt2yfY6PIGRRXQuBDNIJCn7ud9vfT85h3806aAP5iZUG9ZQnHSiJfgxmNWl7gSiuQBn/kpofqTkuU1KqXBF8gOn9TDx03zzAozB38uvKWeSsT/WIAyfZNf3G8CDTeCfChfj/dMOLc/ei1ewwT95b/A//gvAcjlaHDusohphrYtGrXlLAabPEOnChYXpaRSrjszYcOHj+M55vv7qS708OkxgaDQqYTHSzFdZ9vsgiilwBH9TmlFThYNK8Thtj8vOz0XNYspDDuItzkZjbygf16GZjB96FY7RlFgCpnw3gPpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:52:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:52:26 +0000
Message-ID: <a65891c8-90fa-4923-946a-c6a3830dc75f@siemens.com>
Date: Mon, 12 Jan 2026 15:52:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 0/3] Trigger CI job for dovetail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
 <6648e0df-6b8f-4cac-b050-90e961d1cc49@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6648e0df-6b8f-4cac-b050-90e961d1cc49@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 74896c78-4b42-468a-ba34-08de51ea3355
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elNUZnRkd251UkcyRnhLbXJzbk85aDhPVFhHaVlXOUxvbWtGbU44RXF5Q2Jk?=
 =?utf-8?B?OHZ4UldoQS94VDFQYTVnMUEwZU9EWkowRUVzc2MrRmVNU3RldHZtSld2Umxz?=
 =?utf-8?B?U0diUUsva2hQck9rZWJERW5UOWdIai9nUWFLMTRVZVYzOW5PZ0hiRFBZUWY0?=
 =?utf-8?B?enFCU2ZhZm9LeWQ1eHJFL1Q0S2dVbHA2QmRPcHdqa0hKWStMckhmbzNKdEx1?=
 =?utf-8?B?WVZjaDdKYlFiWElWdThxd0YzVnJtUENiTzJoWGxJcllvRERBd0lVZWRmTExO?=
 =?utf-8?B?SmFNTnRkbnpMSjNTYURCZ3N5ZVF1ZmdMMVphcldEWlc1cWVRcFJmNWxIV2Rk?=
 =?utf-8?B?dDR0UWw2Mjc0aTFicXI2bmdCdTNZVzJqYkFuRkRIVmNTUFlkS0dkUklpdFh6?=
 =?utf-8?B?T2c3d2tWeVhjcmZPajdwSFdrSnMxdzRJNkhscWVodDBxZy9Nb0RTdHhTTEZD?=
 =?utf-8?B?NWVSZnpyZFNFekV3YUJBdS9nRCtkQTZxQjRkY0JoZXdUdTN4d3Zya3hPaFBO?=
 =?utf-8?B?RkdqZ2tXYVZQSTlQUmRxajRVMFp4ajB2Q2c2TENGenBjdStMb3ZOdWdRWEJV?=
 =?utf-8?B?T2pmNGdhTEtEbDM3dXBkNGhLVUtLdnJYTGJtZFRkWGoycGFXRElWMmNlQ0FV?=
 =?utf-8?B?bTBYb3ZRb2xmWGxXaHNXaUV0YTJiUTNzRUxVZUhqMTNWWU5la3g1QkM5Q0JH?=
 =?utf-8?B?RlNrclB1YWlDcWY2VVRTTFQwN3ZPL09ZeS9aMXByL0hkbFU4ZTRjMzkwdE1Q?=
 =?utf-8?B?L25jUU90OHNWUDdTSWhyOW1HaTVaOTRhSjArNENIbEhZSml3MFpFRmRTcE1u?=
 =?utf-8?B?UGZFUlZNRjFXSlM2bStBeEFvVlpPbHcyQklMeEQ0K0w4b2RLeE1RallPclZJ?=
 =?utf-8?B?TURXSVdMNjdLWXJsblgxYm5TOVJWTXZOSXh4akRIMmliY1RkTHMwbVpxNVBU?=
 =?utf-8?B?cmtoZFhJNC9nUTVtVnpYck9DT2Z2K2F6ODJiQkFneUhpWERMUjczY1ltSjQ3?=
 =?utf-8?B?ZnJvTHNSWDZzVTlLelk2MWxwRzVpNGxpOUhSbTVMaGxFckU3ZWMyUzJteHdG?=
 =?utf-8?B?UkF3a3ZESmZxVmFVR0tBMUI5L2Qzbnh6a0dKalIwUHBSZmxvZ1JULy9LSUdF?=
 =?utf-8?B?VVBDcmpDKzhYRDY3WVc2bnFYNmFsWCt5NWFNeGFRUXNoMHVDbXpIZDMwdlVy?=
 =?utf-8?B?cDdqMW1YdytITmwvRDN1RTNGeGlxZE9NcTljN0ZXYVJMd1p1M3ZoMWJRdlBm?=
 =?utf-8?B?TFNlbFRqQW4vTFlaYTZrLzYyOS9EbU01dGg5dzNDSC9KdnY5RUhEUDVtRW4r?=
 =?utf-8?B?SGNxVUEyYUdUUjhtWFAxQUpxMDdzbmlxeTAyTkYzOHFQWTN0OEJqZzViYmU0?=
 =?utf-8?B?d2w0Z0JRTFpIc1lLQm1CZmErUG95Rms4YW5QcEU3Y2wrTm95TEZWdERHcnR1?=
 =?utf-8?B?MGxDSUswV3JsRWZBV2xhYmo2WGpSUDUraXNtOEFMamtYbmJGQmhxSlJMaStq?=
 =?utf-8?B?UjRiVjZkdStEQUNFbC9EcVl0cERKa0J3enZPbFIyTCtrN1VlL3BnOXYydEk4?=
 =?utf-8?B?SG5vUW5ERXhOWTZYQ2Z3dlBtYTRkaHBZMkc0SXNxSUdMeVlwdEQzS1J6UmZx?=
 =?utf-8?B?VFlLdTI3VVU0TGF6WDVrSS95MVVwSllUSHFyUGhodG9WUWYrRG56bG5CMTdP?=
 =?utf-8?B?RjZ1VE9VTUZDUjdYQy82Mk1LajBxL0xtWGtZN2x0Zm11UlVXOElpeTZhc2Ny?=
 =?utf-8?B?bWtrblQ0clY0SzJaZ3RwZ1NvUGp4elRkN09lazkyWnYzcmJCYUdMWlF5UHNY?=
 =?utf-8?B?RTlEUWtNMlBoay9yQlI1WWYxckVqVnZ0QzRqN2lBSWdPMENNMWlXa05IVkt6?=
 =?utf-8?B?Uk9GczFGR1ExL3BzV0tkVFlCUzl0cDZtMFpQekxZWlVNcGxud21URGZIUmRY?=
 =?utf-8?B?UjBFZGh0YmdEL3BQa0ZwVXJnZFNuOVVEWXhjRTQ2elRSMFdoc3N1dkovSkha?=
 =?utf-8?B?aUdlWHFOWTdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjhkcyt5bHROWWZ2SXpxUTBFS0paL2JXdEo0UTBiQlBubEU2cDAweDNDMThF?=
 =?utf-8?B?NDVBQ3hNNFlCNG51aFkyYnVhVzNjeVNMSGJSREx3b3FOTS9WaFJIRWFlRjl4?=
 =?utf-8?B?amZsQW5odDZDTnJTNHBOT2RsYlRPUmtza2pob25zN2FYQkphOFN1eE9QbXpO?=
 =?utf-8?B?VWdwZnYxRlRKckg0NHVaZGhtTVNYbjUwN1hISVFMMGswK21PekZvQTZtQTBq?=
 =?utf-8?B?bGl6aVgxVXhXT2tEcFZUNXNjVW55OXF4dEhWNVBtZ1M5WXMxZGhjVDhZWGhk?=
 =?utf-8?B?T0NQL3kxU3liWVlGb3RkMDlNbC8zbWVDdHQwd3A2YVRidnpzTmVIK1p4aEc3?=
 =?utf-8?B?Q09Oa0xRc1JudTRwTGsrT1h3TXJWMnIvNy9WRFgxNjVtRkdVV2VJNGxkdnZB?=
 =?utf-8?B?S0tFRjNuRXd3T2trTG8raFRoUEZKSzVhVFUxSlU1Z0kwWUl0N1c4MXgwZnBK?=
 =?utf-8?B?bXo3eUVNSEhwN0x0eVhMbEFIRXlqem9WTTFMaVlaSVlySW8xZWE4VDVsRGow?=
 =?utf-8?B?bVdyQkZ1UFB5L28xRjlyY1g3ZE1CNURjSU5LczQycVpUK1c0U2VWaTJ6ZFJ0?=
 =?utf-8?B?MmlQMndLWDRvdWRURkErVGh2b0NRWjNFOGpKb21MUytGSlRieksxL1pXNTI3?=
 =?utf-8?B?N05Jb21DUXhrL0FWKzU1S1RWUWF1ZzB6M09PTUtaNmJyWWpFUVpjYjBwekdE?=
 =?utf-8?B?UHNZcGF4QmZXdWtEekg0M2ZtaVNCQ1dZcWJwUmVkRmpxSnV1ZkNTMVIzRm5N?=
 =?utf-8?B?VnZ5bFcvaVh3d04zUmRZcklVT0VzdlM4U2ZxVEZrQjlTR0U3ajZZb1BqaVdY?=
 =?utf-8?B?WE1MbHFGbXA3MU5lUk85cUloS3VJbTliOTV0U0NZM0FzNTRJYkh3bFdIZHBt?=
 =?utf-8?B?SHl4b2FqdU9OSlVPSzFHUGFmN0YrenRFQ0V4T2o4TnNkM3JwUEFGaXdrbHhK?=
 =?utf-8?B?YldER3JMNUpVTjhTTFZyTW5heGxZbFhXMW1hdndlbm5kaElPaUZxTmpmNktR?=
 =?utf-8?B?ZlE0TnhzSXlHZjJhVXpGNENacnc2TGdyMWlpOWVZZm5oNm84Y3AzaC9ITUl0?=
 =?utf-8?B?eFlLbGpuaDhhQVBWRGloRXJNdVBCK2FEb3Z2V0w5UzVUY0JjKzJJNWtsZDRo?=
 =?utf-8?B?TTcybE5VT01iU1BzQks5NVBSSEs1MkhOQUYrdEQ2dWlvU01mM2ZuRXEyd0Fn?=
 =?utf-8?B?LzVxUXhZbGhNNUJmcTcwa0RtNWdHRnlLKzZRYzZvTU1selVzVGREOHk5UG95?=
 =?utf-8?B?UWhkdHl0TU9nZFZ3NXI5NlYrbWhNd1A1NzE5eklSZ0pIN0xoRllPblJYNUlK?=
 =?utf-8?B?MlpNaS9RNDNVdmhTQWxrN0IyL2VJNlpodnVpMU9QV1RPVzcrV1pCYWI5K2xD?=
 =?utf-8?B?N1FkK2tGOW1NdGRvdWdibVB6L3VaNkVDZ3h4NzZUaWZhODU4YWE1djdCZmt3?=
 =?utf-8?B?VXQ1Snpkb1Z5SFFmMzJmVUJkN21OUkVvK0J1cS9RRWNHT3E3MFZjVktvSisz?=
 =?utf-8?B?OHU2c2svcmRXb1BsS01BNDY2b0EwcHJ0N3F2ZlFKNnhZVUxNSTI1VWtwYnY5?=
 =?utf-8?B?K09mMmhUWGFTcCtwSW9KaUJSK1JNU251TU93ckxqdmh2cEJIMEljbXVOV2la?=
 =?utf-8?B?blk2YzJuOEJCaUxuMkxCa0pyamZ2Y0VjV1JNK2NtaFc2QW1sdUNLTzN4eFBH?=
 =?utf-8?B?Z0QvcXVHUksxQXllVDVxVmVlQnU4UmkwdHBzaFpJQ3MyZjd2Mi85Z05RSUt5?=
 =?utf-8?B?NVdFMzhnZS9zNGdFdVc2MlZ3Q2NtWG9TVmMzTmpMdGlJOHF1NUdzSDl0V2Vq?=
 =?utf-8?B?eWE0VjJzSUlBZktMc3hObzVHaUMyYjk2L2U1K0VJWDVJUVQva3BNaElOYUk5?=
 =?utf-8?B?bzFYdUdMcHF6YU15YkpkSnluN1kycmdGY0dXZWk3YXdTdEprV1Q0YWdhNWZ6?=
 =?utf-8?B?T21FaytEMHU2VStTVEgrS0FQT3dEemhpdlhueXZKTHZvdUJFaXoxSFlmWmc5?=
 =?utf-8?B?QjJuRjdjc25qQnpzT2N0eWM2TlR5MnBxd3JHNGRhL25UM3VqYUxwTXo2L0tB?=
 =?utf-8?B?aXNBdkc1eVBEeTI5dmVtWVFWdWZBblpxNUxDN1FuS2c0Z1ZjUC9YV09XL2Q4?=
 =?utf-8?B?YW5sQnUrME9OSVh3c2pUUlBsdkpxTEVwbVNqVWpSNi9MZnBvZkpKNWhvOTVa?=
 =?utf-8?B?VXlhTkJIN3gwYzJuWENwaXpGamJybmFITjVSYm56L0EzMWdzR0laWWRteEds?=
 =?utf-8?B?QU96M3hkR3JOMGZ1cVZTdDlhTk9xWEk0L01qWFZHZ05LWDBWWDBjQ2cwTWRX?=
 =?utf-8?B?L2JGYjBQSlhKNXNibStkcElQK2x0SnNMQkN4MlJnenVUYTRwUW9hQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74896c78-4b42-468a-ba34-08de51ea3355
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:52:25.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En18kkrGMUHs0dQP36hdujse11HWIpGD45PMawnkNqIIPJoksZMpg5u7Gg7z0GgdnwRbImEuMuyKBO92KTTlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7401

On 12.01.26 14:11, Jan Kiszka wrote:
> On 12.01.26 13:33, Clara Kowalsky wrote:
>> Hi,
>>
>> this adds the functionality that if new commits are pushed to dovetail,
>> the corresponding kernel builds in xenomai-images are triggered.
>> I tested this for dovetail/v6.12.y-dovetail-rebase and
>> xenomai-images/next.
>> Thanks Jan and Florian for your comments in v1.
>>
>> Changes in v2:
>> - removed 4.19 handling for now, as suggested
>> - in ci/ci-dovetail.yml, add a comment that this file is configured as
>>   CI/CD configuration file of the linux-dovetail repo
>> - in ci/ci-dovetail.yml, use a debian:trixie-slim image
>> - add commit to rename LATEST_KERNEL_VERSION to KERNEL_VERSION_WITH_QEMU
>> - in ci/xenomai_3_dovetail.yml, sort kernel versions and rename
>>   templates
>>
>> There was also an issue that the QEMU jobs were not triggered in v1. 
>> KERNEL_VERSION_WITH_QEMU is now set as pipeline variable, in order to
>> make sure that the rules in the .build-qemu job are evaluated when
>> having the variable info available (by setting KERNEL_VERSION_WITH_QEMU
>> in a template previously, KERNEL_VERSION_WITH_QEMU in the .build-qemu
>> job was still empty and the QEMU jobs were not triggered).
>>
>> Changes in v3:
>> - the v2 had my test branch in ci/ci-dovetail.yml
>>
>> Best regards,
>> Clara
>>
>> Clara Kowalsky (3):
>>   ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
>>   ci: Add build job for pipeline triggered by linux-dovetail
>>   ci: Add CI for linux-dovetail
>>
>>  .gitlab-ci.yml                  |  8 ++++++
>>  ci/ci-dovetail.yml              | 47 +++++++++++++++++++++++++++++++++
>>  ci/gitlab-ci-base.yml           |  4 +--
>>  ci/xenomai_3_3_x.yml            |  2 +-
>>  ci/xenomai_3_dovetail.yml       | 39 +++++++++++++++++++++++++++
>>  ci/xenomai_3_next.yml           |  2 +-
>>  ci/xenomai_3_next_long_term.yml |  2 +-
>>  ci/xenomai_4_next.yml           |  2 +-
>>  8 files changed, 100 insertions(+), 6 deletions(-)
>>  create mode 100644 ci/ci-dovetail.yml
>>  create mode 100644 ci/xenomai_3_dovetail.yml
>>
> 
> Thanks, applied to next, and I will soon also configure linux-dovetail
> accordingly. Let's give this some practical exposure.
> 

Ok, here is an issue already:

https://gitlab.com/Xenomai/linux-dovetail/-/pipelines/2258056311

We are currently missing a rules (and also recipes) for that kernel on
xenomai-images side. However, the same will likely happen when pushing
any of the merged branches (e.g. v6.12.y-dovetail, instead of
v6.12.y-dovetail-rebase). Those pushes should just be ignored rather
than raising alarms.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
