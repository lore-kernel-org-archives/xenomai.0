Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FE70808
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512876; cv=fail; b=plM/iibbc0gJofBUvRZqb9AsnJs/MrrB60EMUfGHQiLLLMovQug/hNIOX1coF8MvPV/0yRELk9GFmkkf6dncqByo7NuZgirFuIy/JQZHQeEf/f0Mp9IWXtvNSLTzRfc6chbgHyFEUHAEb67tGbAQ1iPINU5vQIyP4UQ3cuIpUgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512876; c=relaxed/simple;
	bh=FbFzUR3GiXOidxSTM4X4PXVEaTRAu8lGU6IuZNc62lM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FyWcCgzoAaY84liSFAIcikYy3VXEkPa3J2hz8JqCMX7dovEeEilra5c0ANq9mqjd3exKlL2J9AWKGBOf/9o8CqAFZj5vD30uKOKIkYakUACOIvJRbM/hutyLea1Qhsqet5jC0nCBtE9pVDU0JN2rALtzDyVq/AsVNvQoxPHkhZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QhXYLS8W; arc=fail smtp.client-ip=40.107.103.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QhXYLS8W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwHsFc3ZIyZXfN3v/RMjkPdvEpOOhdG+V2yejuB3EhZjMr0vL/o6TZVfzYF4wjIS30348ZYmsRDtgLziRn/htF5CCvL2TPJyuA5E/BthZg5VMyxFDQGvOQAklGDHGzNnN/d8UVKLeCIMueaJDMyCYGEnuQ3jnO9x+PFV+P0uFQpg9iqhUXIoa5YHj6o7DvaWSm6F4oq1a8WPIM5IdF6mi7uussPq48mFZjGLIRz1YdKrfDzaJCXQkFiDywRpb/wzmM1iRnQ4QRqaWi6335W+wtaaxcnWifC8XYabkQddWuDvfrWOarGdksHCk5X2xLC6+MowSACZQMXyluIxsoUx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R31u1tISb7VlXP/ntIUxdSQkqp8/MfXRyqaliIip7zk=;
 b=ymv2O+7zZ7REGNc0+UF1d+sIKc7xgUsA8usBE8acXUaRwSwdfLLXwesFj6Ez78OYpzIybRVMxTTnpScaQXfJZOfjw9tujLDJ0ZMkaon+rb31itODnd8REMLv6GgOoGIY+M0P5Uy9V4qZ7od5gvQBJdZte0HApw4GJseSMNM1TbPkRLB89o855By6OmpSUYqAb3fiLIdm7nj0LQXeAIj+R1tdA83LJlIlCBEs7HIjP3iH5hrTWJjwgNPu7mZPiV/MkHwlvfwoFed51qmaqBF1e8RcJ9PwqaihNaQmTuHKmvZgGgtgAO1pypy4gdyTaZ6GIAwuRFInYSAAbcg9xXYqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R31u1tISb7VlXP/ntIUxdSQkqp8/MfXRyqaliIip7zk=;
 b=QhXYLS8Wnrrb8iYyBZGcNpEjsAnOxXowEBEsyXP4AcFl3A1iqwc/QPRBR6umK7nFxtgUCm5vH1q4GC+8PSqlDp5WVq+SwSHQ+tWnpdZ8RuUBV9mRF1zTMqFZpdLJp/TqeYaXIYcqoBXzi0A91xPXBRTdZnWMjSU8Pk82z9BSKJ0uIbNChMMRWUV9+YoN+HRo1u39rezGTeqXaDxprGK1N+9OjWnOjyN4HNyuSjUd7UFxzYCDeVEAFHpiaznnC6z8O8YhFZ8YYpin5+7yQsC291IF4Ty0B+XcwR+S+7BywpiQppiy4zK/ShHJM2VzNYH1nnPuie8ONqQHqkk0pHwjWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Wed, 13 Nov
 2024 15:47:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 15:47:50 +0000
Message-ID: <78aa3c19-7226-47d2-a319-8f890c81e7ec@siemens.com>
Date: Wed, 13 Nov 2024 16:47:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/2] ci: Add scheduled job to build
 lavacli container
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
 <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
 <af9e0e0eb919c82645a4afa6334f134fecb7b163.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <af9e0e0eb919c82645a4afa6334f134fecb7b163.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8ca480-913c-4bdd-8e59-08dd03fa874d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1dIUTE4d1JFN2dHanZDUmI3NU1zVkJOUUl3ZjYvQWFlWThtbjZqS0hGY3du?=
 =?utf-8?B?bTluUjNoUWp1RWw3dW95M0p3SHBwemNUc05BM3d5MEVTcWVtRlVFaVZUUHJa?=
 =?utf-8?B?cmxjVERUREUvNEM1cWxrYUxWOTBSRlVVaEUwNzVOWlpycVJBdE1LL1Rha2c3?=
 =?utf-8?B?YnVFaEZ2ZTRrS3NjbzlvOXR3TjZMWXdnYmpGU1BXSGEzeWE4M1RiekNPSFlt?=
 =?utf-8?B?YW1GYlNlRTEwWDJZTzMyNzJlQlFYV2lrYlJRZ2I2bXNaZ1Y4V2lsanZlMlRm?=
 =?utf-8?B?TDJOZmJDOW5rcnJBd0ZLcEIzUnIzMWZpS2syUXp6Rmc5MkgyZ2E3YVM1L0p5?=
 =?utf-8?B?cXAxcnNyOFVqYm9YOEdMdVZsMkRneXR0QUJ6UFlxRlRrOVF0ajdxTnFQekhZ?=
 =?utf-8?B?VHdTNDJ3RmVPNzJiWjU1TW02YnZjRS9RczYvaXQ1QWFMMmx6SFBGWWRlRU5T?=
 =?utf-8?B?NEJJUm5xbEFBMDlqMDFvMW5OWjZ5Vkt1UTlwQWcvUXY0Rml3eFZHbnpoRE5w?=
 =?utf-8?B?dmhvVVRrbFFtRlBSNTRVWlpEcEp4UUREVG1Salh2UUNJV09MKysyN25hZFcr?=
 =?utf-8?B?blRWbjMwZmpkZStUOWFWK1JFNFdaTzE4U210WCtnV2xZUHY5eU1vU1huZ3Bk?=
 =?utf-8?B?bEZralFxNlFCQmpiMkh2bEZIUXl5YUVNaGhTVjZQTHJHdFU0cXAvN1pDYmZP?=
 =?utf-8?B?djNlc2d3aHBMbi81VnR1S0xzSFVJT1F3WC84K0R1b1ZkQTQxck1qQWZSVlRm?=
 =?utf-8?B?ckxDbU9kMTgvYW1ZTmRuMHR0VGVWRW04U1NTY29QMTRYR2FXRkxFdVk4bFpa?=
 =?utf-8?B?WjB0bGJGMVZMNWp3dCtVU0V6V0JrZldJVnltaU5KclV6bGVrRWhCTWM5dFl3?=
 =?utf-8?B?MGZYVjdGNkk1aVZna0d1ME5WV3NGYWo3MDRreWtPNUdKMjNFL1AvNW1kcG9E?=
 =?utf-8?B?eW1sVWtxRy9MOUplOWQrMER5MGFvSWtRNGx0RThJa2tGU2dkRldHWUtIbS93?=
 =?utf-8?B?d08wREZIQjBFdkNab2JKelhaVm9ZbHNUc0RoYXRCNjVzK3dCbEpMbS9lOW1J?=
 =?utf-8?B?SkU5ZDlKN0hhanNvcHNQdWp1aVg4T3dMbEQrNzYrY3IyM05leVJ1Kzh6WnFM?=
 =?utf-8?B?OEZ4RWgrMSttOTFsK2lidklKZHEySXQza0t6d2xkYmNmOURDU2JUM1JFbk84?=
 =?utf-8?B?dzNDVmRCeDF6WDZFUm1LT1dzQ2tkZTdTQ0I4YUFhSko5d3g0UGs1WGlHWllW?=
 =?utf-8?B?czQvZ2Q1M0tBaGNjNEg0VVBpU1JiNW5VdHA5UG9NQXNHcGQ4MjVVZWV2R1VV?=
 =?utf-8?B?bHVVeXdNYnBwNXlXc2lDd0ZvMnlqS0NNc0NHU1hldmpiL0dqRHI5YTBOTXB1?=
 =?utf-8?B?aVova094TnBtdDJsSEtKSUs4UzRpSXMzK3JqM0F6UkFyWjRpaHd3MFpzbmJq?=
 =?utf-8?B?SnlVSjVvWlJJakhsSjJROWZYWGRpMmxHejdyVkF2YmhKc1dSNm10Q1Zyb3hy?=
 =?utf-8?B?enpQQlZFQ3lhblRHdS9oT1FhRTlCYkZLd211VlBSM1piYW5uQlRKVklVMnJF?=
 =?utf-8?B?RlhpT0o2TmpoUVVxN1cveURKRUZxY0dRQU5qeGZZM0p0VUJJSDlEUDFpQytz?=
 =?utf-8?B?NHVOalExVlQ5YTY0a0FmeGVUc0tUVXg3WXhhK0dMeHBuSmt6eFJoVXE3SjBT?=
 =?utf-8?Q?a2xLU3XYYp8qDFHTRSwr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ZIUFZLWlBNNEhrMmVjdlU0ZjYzdUw4VDg5M0h6NHNhM08wZU4wL25mbTNa?=
 =?utf-8?B?RlBobXJ4SFY5WnVFN0ZnWG1TbTJnaFNmUUkrUXFSd2VmaHYrKzdFaGROQkh4?=
 =?utf-8?B?c2h3WXE3UlpLRFVhUTkva2FzZGMxcUlFTGhtZC9OS3pMQXdRSG5ZbGQ4V3B1?=
 =?utf-8?B?WE4xcGxSaURIVXBvSTZBMktEWVdINXpBTUI3bGNRc2JvQy85Y1UyOVRPR29k?=
 =?utf-8?B?M3ptQXpyVkVtRXllRlBsKzZOakIyQmVqZ3F1ZmV3dGoydHJEVEZ6aU1vdldC?=
 =?utf-8?B?T05lREFNTDNGTXdYa0l0YVZXZVhlK0dSZWJ1OGlGNE9ETkgvdWxLYUVXTlY5?=
 =?utf-8?B?ZkVTcFhMNitiRGdncnhnOE5ZbHpnVWxJY25yeFJ5bDdXK1N2V0hsTmtjZE1r?=
 =?utf-8?B?UWRtVzJsdTZyc2x4VzcxaXBqNHVPZk15M2tLWkFmUFBNWFdKRE82NjdkY0cv?=
 =?utf-8?B?SzVvc2pidjJ5RWlsL1l6SWRXSmpQbmNtMjV3TFI5a3M4VVc0d2YwSXltOC9Z?=
 =?utf-8?B?ZUlSeHhPbklOOG4vdEtFa1RTbVNJOURvV1V4dGZEaDcwdktjNXVXVHpsYnlZ?=
 =?utf-8?B?T2NQbXM0RFBLb05JbmNvOTByZGpMbkZFeFZpTTcrL1dIaXhkWDA4YmY5MXB0?=
 =?utf-8?B?akIweVFDT0M1bjJYTlNTWFhaeXNiaDMyamlHSHNuc0N1VnpXRGl1cThBMzQx?=
 =?utf-8?B?MThPd0d4WEhIaWRLbHh0ZFNaenFJb0Zqa3BRempsVDdVd1B2ZC9ObGpsY3BQ?=
 =?utf-8?B?em9aYVgvS1dKVjZVN2x4NDAxN3pxQzcvcitVd3lpWmhCMnRDWjR6VjVBekpW?=
 =?utf-8?B?WWg5eEk4dWY5UDhXazZMVFlDTnd2ZzVmQ29tV0dsL0RhR2ltMC93UEhhZ3dI?=
 =?utf-8?B?UzBVK0V4Mm9LU0Q0ZHZac3RIYzVud1ZtZFI5RjBFb0kyUFdublZPRTV1MVVJ?=
 =?utf-8?B?VEw0Ymljd0p4VTB1N1JsZTVWZURwTDQrN2h1eTB6UUJ1VFdGb2dmRlFJd1BF?=
 =?utf-8?B?bDl5UFRuMHRrZC9pUHB0clZGeVdCZ1ZjK3BKaDJlVmRCRVRvMG1OeUJvVFlo?=
 =?utf-8?B?cmt5ZG02NkVlcC9OMGZiazdvQWlBV25wR3NrbnM1NjVCTkplaWpBUi8weHB3?=
 =?utf-8?B?ZGdJOHk1bFR3eGt1aEFNb2xDdDB0WGxrejZaQVBURllCVnFVeUdnaGRSUi84?=
 =?utf-8?B?TWI3azlXbmVYdUFpNDQvUmhaYzNBdkU0RTVoeWFZOFJQa1pqVzhWWlZBMSsw?=
 =?utf-8?B?eE94U0xVbWxyTFlzY2RsMmw4YVBERlc2ellSR3JFOS9BN0ZXSk84ekdBcjRn?=
 =?utf-8?B?YnJGMmpNWGxVbExYS0Fwa0hnVnVCYW0rQWJISGE1b1o5aWZ0YmdWNjkxNm5V?=
 =?utf-8?B?QXlKcVoyb1RaNVJ1V2hnSkxGL3F5dUFtZjRTUGxsN0Y5M29GSmdJR2hXdklP?=
 =?utf-8?B?Q2lwQmM1QVIxcm9ZT3VTYmtMVGRnZkpGZm1LSWV3OEwveWJqUUwySU5JN21u?=
 =?utf-8?B?a0RoUWY0QWlmZzhRaHVtcTUxbzhKaXlHWVBSMVdEWS9OZG9tNWE1R1kyOEt1?=
 =?utf-8?B?U00wM2IrUHU0cE5IUUtNVjB4RUEyV3lFSFZZNzdkZmJXUi9PNHV3TFFMMzd4?=
 =?utf-8?B?eDFIT2k0b1NsQStMREIrUmZTMG5hNm1YZXFiMkZLTXpKN1pmYVRSMUpqRFgr?=
 =?utf-8?B?VGt4aFhGd1Fkdk1oTWViMWRsUjRWL2tTOTYwZjNrTkJJTHhpbEdrTkIrbXl3?=
 =?utf-8?B?ajZoSldta3JlbGZ0M1ZHKzFyZjUzeVcwNWdZbjhLMlVQUnlpOUphZmtBOFpU?=
 =?utf-8?B?OWZlSFpZVHpuVWkrbWcrT2k4SGV2VUNSa0h3VjBoUUh5bFZjM0JkclQrZmln?=
 =?utf-8?B?dEdzQXd2NVQzbW5BZm5LYlczMUxrUy9peHREZVFrQVlkb09TOWRWTm4zZkl2?=
 =?utf-8?B?RFBWTU50TVltSk5kaW5WTVV0Rk1YSFR0YnpWZFU3bEpCWk5nREFNQTg0bnoz?=
 =?utf-8?B?WVBGczRyeThZdEx4N1NPZzRSQXI5Q2ZDZWlxb0RKSHpTdnR0N092cjFWWmhx?=
 =?utf-8?B?NUlZYklGSHk0SzBMbDhpckkyNnQxTTJ6V1pSdnRZMFBOWDVBMzhodmMrbmNX?=
 =?utf-8?B?Z1RtVkxtY1hmZlpEQmJNVFhXZk5qb25JSDd0L0xnV2Q3dVlFVnYwOVVDWFZn?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8ca480-913c-4bdd-8e59-08dd03fa874d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:47:50.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4fzHikbyK1q/GvbMOka6nR32mT4QQNOwBu3SCXII1NAeSaM/XvV21IExItViJrUtfhJNwmcPn/JRpVSwmGWQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6989

On 13.11.24 16:24, Florian Bezdeka wrote:
> On Wed, 2024-11-13 at 15:33 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We want to switch to self-built Debian containers with lavacli
>> pre-installed. That will speed-up the start of test jobs and avoid the
>> manual installation of lavacli in each of them. To keep that container
>> up to date, prepare a pipeline job that will be scheduled once a month
>> to perform a build and deployment to gitlab.com (source.denx.de lacks
>> a container registry).
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .gitlab-ci.yml        | 14 +++++++++++++-
>>  ci/Dockerfile.lavacli | 17 +++++++++++++++++
>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>  create mode 100644 ci/Dockerfile.lavacli
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index b8945bc..37d2a6d 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -15,6 +15,7 @@ variables:
>>  
>>  stages:
>>    - parent
>> +  - build
>>  
>>  .parent:
>>    stage: parent
>> @@ -56,4 +57,15 @@ xenomai-3/next-long-term:
>>      include:
>>        - local: '/ci/xenomai_3_next_long_term.yml'
>>    rules:
>> -  - if: $CI_PIPELINE_SOURCE == "schedule"
>> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
>> +
>> +lavacli-container:
>> +  image: quay.io/buildah/stable
>> +  stage: build
>> +  before_script:
>> +    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
> 
> Where are those CONTAINER_ variables coming from?
> 
> Using them as cmdline arguments can easily leak them by enabling
> something like CI_DEBUG_TRACE.
> 

They are masked vars in your gitlab-ci project if you want to build that
container. No difference here to other credentials BTW.

> We break the "fork and re-use CI configuration" workflow even more now.

Only if you actually trigger this part of the pipeline. It requires a
dedicated schedule for ONLY_RUN variable set.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
