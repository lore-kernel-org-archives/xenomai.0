Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987935;
	b=y83qSBO6PRtWXLetT88N9EYF8rO1IIHYsn+AjmuZqc6tSUKcXojR5xvBJV4/DGt/ToRS
	 JYO4/EDfTUz5gtU4FrFvjz7GA9HLfEZE6ZqKPPC3vVIUpuVPhmM+n8pjC87AkVh3QrwRE
	 caeGejlpVXZwpfqQQWfH933ALbGRd7N6cOzUBV8KjjxDXQz7fTvhED8hXvDO8gi+Kmua9
	 qcKDTWeKwalPOYl9658QMrWiVOkkInlRw6XB930qhg5oA2p2xckNazxC9NxIqp7qshB0U
	 h3KIG0/cfWFHQO3L0zPrGKSXr3W1Cma8qhJV03q5DNqattSXBnUIllyFlGob1jPYyIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987935;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=w3YTrE0GDyrDcRp/Upex3UaEvjul4vtPaCYo5juN2Hw=;
	b=VN0qsLAe+SNzvmmroUSee4f5wsCP5FBK3/6vHPyL2JqqZsDfH4crMFwR8qok+Am/CWLz
	 kFgiJ/8v9uG/ye87QwJOJfMBgpOCiBx0A4Tttpw9WnrOhtVD7EWPGrBHG8Q8IyQn65xGj
	 ZfaS4rJwhXHDawjcZaoXji6mmc7mss52Dvy/qORBzcLyYt5rQtks5gQmVgaLK542413lB
	 j8zUXk8bi8W0bTYL276vdbtBFniIHuHlTL0SBgqPoFdnsv+ELzsUXxCV0LotHy1bhw2+A
	 /Ma1Ci+u9iwtwM+GL6gXWAD77JM96IOpksQKZ7WMchDKkKrqe5dU31KoEemxoJt+3VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uy2OSE2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.58
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2C606A32F
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 07:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF2C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uy2OSE2Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDH2GD4SGtMhgzrAIPnCaTflCDwTrPzF91UfZ1dOdc3aAMiVI4YvCDa5iCjy1Z49j6qlyNxJpp8Sw9555Hg7jeksaGS2Vova+NylY3NeWDhPilNtBXH68fblclzOzxf6kzy/gQAH7/o1yowd9bTL5UOmIwNRm6vOkE6fgX5YmxTOMFC/f5ksn+szC9+2cEHZq0U1PZsNiN5Aq2BwbTQFnF3MuSk+eguxzmnkduXA5Pdw5fvOxAg+7rBFCTQBU5TFqYW6SsByME8Q3qCyYoKU6qWQQ0v6cMtf8mtSAmQUOj69ch59PyjDvDbI6r2QXtrkCtjv03n4YWcvA1vIDRFMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3YTrE0GDyrDcRp/Upex3UaEvjul4vtPaCYo5juN2Hw=;
 b=GVHh2HKmlRxgR6t/L7kZ6lOJJj7+zbwL64B1oLR+USsW6Ss9q3oiWXO682IuUhwMb9F9IugnJMl/+AH2x6FDLpC+K2+oUTIO7U7ruUmRof95Gnssmp7JAGPe07Q+WKKEmxC4Jvkrws1BQj9fE58CwxObJsmqnmP75PGc3vkPKy2LMXCcvUsH1IoIaYKGt7+YpbThs5zxx396pRxm0IvD0qYf5gwkF+CznvgL6ViMjjIfVuTYrjXzDpJ7BeToG+q2BBsLGdC4SD0DP2hplE+SJ90JDF0f4V+b08GNi4zlIRdGNqGQPuzECIcWveA069IHWIE9bu/yK7AqHRZ6RGGQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3YTrE0GDyrDcRp/Upex3UaEvjul4vtPaCYo5juN2Hw=;
 b=uy2OSE2QDgsp1cJNRurq8y/u/FBijv3OyTf+7cBvHGQByoUMwwcH/QtVadw4UcTA0y7IiL2oJFir/LDDRHFT8nN18qcerxPmwW2GsEM0/kpDHBRWJY6wA8wUQVYmGNo7tqv5mG27J0Ne4ioM3W4s84twH6WeIHgoA9cpr+XKGf3Nsup2mCTBaLOTGJzhMvdBDObuuMYd7r9D+95/6nVc4eUX4wchKC0bfpofNZxHDAWtHHI/OGVyVrmbTFpJnkx61gn7IvcbvwcDAercxRGZ57kKvm0S0wJyUUgNC16QPmLLzEcKpMYKrTP9HLHYcJ8RhLJr59FShkve9asZ1n7vKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB7512.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:d8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 07:45:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 07:45:30 +0000
Message-ID: <2d9e6024-545e-4f3c-a786-2443b6ae064d@siemens.com>
Date: Wed, 18 Nov 2026 08:45:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: move downloads cache to S3
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20261117160551.357134-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261117160551.357134-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a437c9-beb1-4791-5f04-08df4547eb93
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|55112099003|3023799007|11063799006|260925022911599003|260925021911599003|260925021311599003|56012099006|261102123227099003|261102130727099003|261028144727099003|10067099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022115727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	6MY0fEbulibQbKpXMrufV+lrELYNFlN8QqA6VL4mEyXmguOpzpMiSfp2l3oIQzjQE5Hxyps3zQtNT3exyn1JXGW9bZ8jagAtx8+cO4373gqoqewsXlVChIM2iLp55HjZcg7dQqduNNJbdTJlotq0Qgjef0mBVnP5reINk/w/NZOHx+orHcQBTvClyeW5IyQXPSJ0PVByW6wcDcZa437LfRCXFmDVzrZQFe7OWx8CfgmRu3Vg6BNQK08fM9unGxYYvrY6MVPggcklm3WR+cAx6HXy3uneK6Y2l/pjKwxm2qmeZ4S8djH875oqQjTkUnfyEB3Cy7u64UglL2ggdUyd8Cv6gT94d+KD1Or2Gb94IMmlyGvbeQ3H8oPerchXHtyBH0FODge5riUKgsypLVQZaUbSfUuGoQkiHJNc0XowaJfxirzaSrkeC49+8ub7sOaPB3KLA//mxvk++PPal/n8yhAOrlZHSTfwmk9VirvZpyScW7+9CAlRHQN+1qC5Ph9Uly1CLB9JLPIuXmxDMonsbIZuPDobjmWUuCi0N5DL3phXgKr+0s2SGnjYEM0RV0DNfDTtiXl/9znOGi6twb91SAsE+uy63AzYfFhJ7Us2nOJ2IDNvqP4UXzmoILOpOU9t5R9do/ujGnejkwp2VrQrhDKyF67X4Him5/mSMR3yP/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(55112099003)(3023799007)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261102123227099003)(261102130727099003)(261028144727099003)(10067099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pDVkhVa2RTQXhqempGUFg3VGdYTC91L0Nwc3Urc3V0SVdqOUlFNnM3V3Q5?=
 =?utf-8?B?UlR4SHN2NWtxUEJ1TnY2TUdtMWdwVGJNczNFVEhnVkVST0RLNElsSW9iaThQ?=
 =?utf-8?B?aVA3Zy9Oc0tVMVQwWEY1MjZnSzU4OXZ3Tk9NbEVvTng3VXJtcjUyYlluckZs?=
 =?utf-8?B?UEQ1WHJMOGwwVXhXRHdrVG5uTnNKdTB1YlBNNHBES2hmQ2hKS1VaZkxjTFRl?=
 =?utf-8?B?K2MwYm9FaDR5ZmFqR01JZkpzK0Rpenl0c1FmUzdlZWQwbnhLS1oxOWUzTHhX?=
 =?utf-8?B?RndGM0RvSlFBR1BvOVFSRUU5dDBGZDRzUzlMUldWWjR0Syt0NFVqbUpLalVv?=
 =?utf-8?B?RnJyZ1BaTkl0c1VYbkF1dmlrMnBXN1EwL2NBL0xuMzI0WVM1ZVVCZ0gzRzdu?=
 =?utf-8?B?a3ZpZFh0ODRLZ21zZjJoMEQ3VTQyZ2h3UzhxR2tpdTBveVNzUFFOOTZrcWgz?=
 =?utf-8?B?QjBvZnltV0huMHNoMHAxYUhWUkJUNGMxRC9oclI0d2RNWnM1RUhqVEZuNzlm?=
 =?utf-8?B?MlVlNHVsVXQrME5vbFNDRnhnOVFBZHFoUS9TUUlRWVdKa1RXMDVjNGV4emIz?=
 =?utf-8?B?Q0VYeDg5bGd0MExsUkEzOVMvTWJ6MlAzUHVVc2NRenAydFRrOTJoMk45UUdk?=
 =?utf-8?B?czVrWEg2VEdBd1lRb2hhaEYyTTlPUVVsaEx0eXZleHZOMWVTQmVBRHdNU3p4?=
 =?utf-8?B?Sk1qbDVodUpBdVhFakVrY1pLUGI4eDhaWEdWSmJyUWVzTFB0amRQeEkwWUJ3?=
 =?utf-8?B?bFlkSXdEUlVJNm9xUTZDUHpURG02N3gwM1dZMno5cUxCT3M1RThGdGwrSFB1?=
 =?utf-8?B?ODBMUG9IUWNQVTI4c1hqNWNUbTExZS9lbWg4b1ZzU1BRT0hUZkQ5MzdZQXEx?=
 =?utf-8?B?bmlQSWF3dWRraVhnWGlaeGN5Ymt3VUU0c2lqZUtmMjE2TTRWbEZOSEpUNnd3?=
 =?utf-8?B?UFIzbiswdDRRSU5mdFZjcUtKN1NtdDRMRFM4KzhNang0RHpnRmFydHU3Zkd4?=
 =?utf-8?B?WGRDdm9xMXZIUk9SU0JEQ3VJVndnOTBMdjVVYnNZWHJ0aFVGOElDK1ZQUTJC?=
 =?utf-8?B?ckd6aDVWNUo1OWdwdFJ3TjhaemF3a3puVUw5WS92d0h3TXNydkpjSWFFakxh?=
 =?utf-8?B?R0pkMnYyNnZBb21LWk10K1NibkJFYmdlUmlEa0VYWFlhbTU5R0ZvcldiQXRC?=
 =?utf-8?B?NXdUSTV3LzIvd243REpsdGpMZ0VKZHFUTkJjL3kzd1NjYWlUZm1adHFFZFB0?=
 =?utf-8?B?VTYrRVBGOHRHSEs5OW9IRmxqMDh5bW1FRXRIRkJYZnJ0QkFjeTd5aUtqQ2RE?=
 =?utf-8?B?MlBscGptVHQ3ajcxaFlObGJ5WFg4a3hTbEFHNm9WclkybHFTWkh5Z0dwcEJ1?=
 =?utf-8?B?alZ1S3ZZbUU0ZTlKNXBLRGQ0WThNdVZ5ZUZvR0Q3VG5xcCtrTm1hUUozWS9u?=
 =?utf-8?B?L1pQbmxpUFhqS0hCN2NvVTJ2VzdXUU1BczZkWDlPYWZWNC9tRXdMMDF2UCs1?=
 =?utf-8?B?dUZtekdnTnFzYTlyWDc2K2h4T09pSTlIcDgzY0dHSnhtUU1OUVp3VTFhbmk1?=
 =?utf-8?B?M2RpRGJiTUM1R3RjT3F6dk9WQ1kwNm9NM0tHbzFhU0JCNzc3cjFQN0xNZ0pI?=
 =?utf-8?B?Q0k2TVlEdG5jSmEwcUVRMVJHS1JoaXplTlpVaXNsajRsOVNVMVg1WmJFTGw1?=
 =?utf-8?B?czFLNEE5bWh0aGliVmxJemloQ3ZqZENmaW82alN2V21qQXNoOTVXa1VHVCtT?=
 =?utf-8?B?c2t5MVovcXN1UUlqS3ZGV0lhNGp0d1NRVHA5cytYczRLaENUMy9GU1lKRjhI?=
 =?utf-8?B?TVJDeTl3cmhlbjJZdklMa0w4SWM2dDNGMlc0aWhsWStXc2IxSDF5dmIxeDdZ?=
 =?utf-8?B?TFFsOURQM1JJNmlXbVBvUDE3UVpTWHF6em1iTmw0TUNMaUh2MVdQT1JFUnVB?=
 =?utf-8?B?QWRuRFNGSnhuL2RhbnpFNk1JWlkyVlBrdUxsUEdTc1NnWTJyWGdyc1hTRkxD?=
 =?utf-8?B?TG9BTDJkSkRJaE9TRm93VnpYNk1nSDF5SktsKzdYNEhXNExvTlhDbkkxcDZj?=
 =?utf-8?B?d0VKWnA2UE1JTG55N3pnMVl4alNtR3FkTWtGUDdXdEdEaSt6d09jUytqWnhK?=
 =?utf-8?B?UWxNdk8yZEFsaGhMQ05CL0U5WUtDTHU5SXU1Sm8rb1JTU01pSW1zaTFMTkxY?=
 =?utf-8?B?MGxqQWJSSi93dm90U2duaithcEZLSUo4VlkxUWhsa0tRdURtM1FMb2N1Wml3?=
 =?utf-8?B?d25zTndkaUVUT2J0U20vbk1UcWx4QWZEbm82M04ySzBqYlF4c0Q5Tkd4WTNu?=
 =?utf-8?B?N2lzdEx4ZnNhWmhQM2YrbGovODBwai9QOVd4UlhmSXZQWDIrWkVaZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a437c9-beb1-4791-5f04-08df4547eb93
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:45:30.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOcoP+ogOrGJmMB87kQMKH2ibvgeC4c99q7j+r5jgWRnQi3wt98QqD+UxJ10Yy1XhlePPQPLBIofP1tzrXqe6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7512

On 17.11.26 17:05, Quirin Gylstorff wrote:
> The runner's native S3 cache fails for uploads larger than 5G.

5 or 50G? https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html
talks about 50 in the context of --expected-size.

> Replace the GitLab cache: for build/downloads with a single tar.zst
> per arch/kernel stored in S3, restored before and saved after the
> build.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Tested with:
>  - https://gitlab.com/Xenomai/xenomai-images/-/jobs/18111617260
>  - https://gitlab.com/Xenomai/xenomai-images/-/jobs/18112103215
> 
> 
>  .gitignore                |  1 +
>  ci/lib/gitlab-ci-base.yml | 14 ++++--
>  scripts/s3-cache.sh       | 95 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 4 deletions(-)
>  create mode 100755 scripts/s3-cache.sh
> 
> diff --git a/.gitignore b/.gitignore
> index a796dba..c85555f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
>  build
>  isar
>  .config.yaml*
> +.s3-cache/
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index 7e15321..3516ab3 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -54,6 +54,14 @@ default:
>      - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>      - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>  
> +.s3-cache-restore:
> +  script:
> +    - scripts/s3-cache.sh restore
> +
> +.s3-cache-save:
> +  script:
> +    - scripts/s3-cache.sh save
> +
>  .common-config:
>    script:
>      - if [ -n "$ALT_DNS_SERVER" ]; then
> @@ -71,6 +79,7 @@ default:
>      - build
>    before_script:
>      - !reference [.common-config, script]
> +    - !reference [.s3-cache-restore, script]
>      - !reference [.sstate-prepare, script]
>    script:
>      - echo "Building kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml"
> @@ -80,10 +89,7 @@ default:
>    after_script:
>      - !reference [.sstate-lint, script]
>      - !reference [.sstate-upload, script]
> -  cache:
> -    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> -      paths:
> -        - build/downloads
> +    - !reference [.s3-cache-save, script]
>  
>  .build-qemu-rules: &build-qemu-rules
>    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> diff --git a/scripts/s3-cache.sh b/scripts/s3-cache.sh
> new file mode 100755
> index 0000000..2525ff8
> --- /dev/null
> +++ b/scripts/s3-cache.sh
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# Best-effort build/downloads cache in S3, authenticated with the static
> +# AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY CI/CD variables.
> +# Usage: s3-cache.sh restore|save
> +#
> +# Defaults are built in; each can be overridden by a CI/CD variable:
> +#   AWS_CACHE_BUCKET, AWS_REGION
> +# Provided by the job: CACHE_ARCH, CACHE_KERNEL
> +# Any failure only warns: the cache must never fail a build.
> +set -o pipefail
> +
> +action="$1"
> +downloads_dir="${CACHE_DOWNLOADS_DIR:-build/downloads}"
> +state_dir="${CI_PROJECT_DIR:-.}/.s3-cache"
> +expected_size="${CACHE_EXPECTED_SIZE:-107374182400}"

A configurable that is not documented. When do I want to adjust it? And
why is it 100G?

> +
> +warn() { echo "s3-cache: $*" >&2; }
> +
> +AWS_CACHE_BUCKET="${AWS_CACHE_BUCKET:-siemens-xenomai-gitlab-cache}"
> +AWS_REGION="${AWS_REGION:-eu-central-1}"
> +
> +if [ "${CI_COMMIT_REF_PROTECTED}" = "true" ]; then
> +    scope=protected
> +else
> +    scope=unprotected
> +fi

And why this differentiation? We do not have it for the test artifacts.
Granted, they are "only" consumed by the LAVA workers and not loaded
again by future build jobs. Is that the idea behind the separation?

> +
> +for v in AWS_CACHE_BUCKET AWS_REGION AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY \
> +         CACHE_ARCH CACHE_KERNEL; do

Testing for AWS_CACHE_BUCKET and AWS_REGION is pointless here - you
assign them above.

> +    if [ -z "${!v}" ]; then
> +        warn "${v} not set - cache disabled"
> +        exit 0
> +    fi
> +done
> +for t in aws zstd tar; do
> +    command -v "${t}" >/dev/null || { warn "${t} not found - cache disabled"; exit 0; }
> +done
> +
> +key="xenomai-cache/project/${CI_PROJECT_ID}/${scope}/downloads-${CACHE_ARCH}-${CACHE_KERNEL}.tar.zst"
> +object="s3://${AWS_CACHE_BUCKET}/${key}"
> +
> +export AWS_DEFAULT_REGION="${AWS_REGION}"

Can be combined with the AWS_REGION default assignment above.

> +
> +fingerprint() {
> +    (cd "${downloads_dir}" 2>/dev/null &&
> +        find . -type f ! -name '*.lock' -printf '%P %s\n' | LC_ALL=C sort | sha256sum | cut -d' ' -f1)
> +}
> +
> +case "${action}" in
> +restore)
> +    if ! aws s3api head-object --bucket "${AWS_CACHE_BUCKET}" --key "${key}" >/dev/null 2>&1; then
> +        warn "no cache object ${object} - cold start"
> +        exit 0
> +    fi
> +    mkdir -p "${downloads_dir}" "${state_dir}"
> +    echo "s3-cache: restoring ${object}"
> +    if aws s3 cp "${object}" - --only-show-errors |
> +            zstd -d -T0 | tar -x -C "$(dirname "${downloads_dir}")"; then
> +        fingerprint > "${state_dir}/fingerprint" 2>/dev/null
> +    else
> +        warn "restore failed - continuing with a possibly partial downloads dir"
> +        rm -f "${state_dir}/fingerprint"
> +    fi
> +    ;;
> +save)
> +    if [ "${CI_JOB_STATUS}" != "success" ]; then
> +        warn "job status ${CI_JOB_STATUS} - not saving"
> +        exit 0

Hmm, we do uploads of the sstate cache on failures as well.

> +    fi
> +    [ -d "${downloads_dir}" ] || { warn "no ${downloads_dir} - not saving"; exit 0; }
> +    new=$(fingerprint)
> +    if [ -f "${state_dir}/fingerprint" ] && [ "${new}" = "$(cat "${state_dir}/fingerprint")" ]; then
> +        warn "downloads unchanged - not saving"
> +        exit 0
> +    fi
> +    echo "s3-cache: saving ${object}"
> +    tar -c -C "$(dirname "${downloads_dir}")" --exclude='*.lock' "$(basename "${downloads_dir}")" |
> +        zstd -T0 -3 |
> +        aws s3 cp - "${object}" --expected-size "${expected_size}" --only-show-errors ||
> +        warn "upload failed"
> +    ;;
> +*)
> +    echo "usage: $0 restore|save" >&2
> +    exit 1
> +    ;;
> +esac
> +exit 0

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
