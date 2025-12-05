Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BC327C1D
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764934123; cv=fail; b=FTBGfxJagXV0IPBgepucI2/Ib0S4YxAUUj/ylXhSE1JfwPnflAptlXY79HpPzWr8QtAa/09SeV6rDGHK9yNNm/5o8WUF6XFMGX8ZOFs4vCiEVOeOBMSzbhM0U8+RvztUtwjIzGcZdTeU13n94iIVS3R0IHgOzncH0X1y4w0gfk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764934123; c=relaxed/simple;
	bh=jPRv69jKe7y9a21p7PWKYSmYyFgwijJljlaqc54m6Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqUEDAG4RR4yBtdATpHa0xBbioIjzvhfrOiwOWktaF54wh6qYkaT3WUm+g86aQC7kMXHFACa4F78hKDwbGS2zQYrx2pKJ9//Y4zBrNHBFHsb+kFxjKTLPNakGyCXUkFhhZY5x691Vus4KU/AfAx+7ln4YRGzDbvKIhwif4BJxfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=l78T/5op; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="l78T/5op"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJOhvBIrI61j5RUA5d+ZFPKjd3E7iUhE7TYGG6AMD48GfVkZpIJ5+jmhKmg66Y3nADH2rfVQfD7rzOkYt33vdBcANig7fw6LTwg4L542QJVdHlvadaifFXCrHP+4WDkZPdk5fSGTHGThuYkycMBB/Hn4qlmSbe7GMnltbucnGx7qaXcFxzR8PgMImmuIKNF3VD2pZW6buHt4YbLFfckZwzIdJq5yJjqPE13Q67UWpjQMuELzmEKwafDFod8UJPzQgy5OItYZQoCM0VZYgtzG6xyGd20dYMfyBgWFKZPip5M3v4nMc0kkxsqKFSpx0K9k8G9OEvVlAXAxu6mlf7Uiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKcSSXNB4FjZJFvN4ubc4aL3hL/GSt2xdqdwBkDzZao=;
 b=jjTZeKjHkZBxfUGLdi7OHL/D27Md2b/jXiCrEh/daPG0qHkSCzx8sXb9Xd1aVhtCcdP94+lvGZ9Da+ZNyWlDYEO3vhCDETkz7oOT114pf87nIZe1R2RnH4JyYtm3aVx0TBRMwRjc+/O9KyN5AHac6LhjPsBt7cY8TWTa/yEwrtoBv/s8v8MEG6RLyOfxDd8UKVQQxUYXeQziBgPobJ5fkPL3f1toGC37Y7x2yn8U1riNqcm5PCJEg/mfKDX2T4KuFiryih/ZFpNmEtv3oUIjZRL0nnhFzdyNQ9a7PpMRPVqrq1MGvp3DUr7Nw9cZ+fVD5xiyxmcsSALk8TWLzopxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKcSSXNB4FjZJFvN4ubc4aL3hL/GSt2xdqdwBkDzZao=;
 b=l78T/5opedtoLh9Nhc6MlnMOqZB9f9qGlOhckFrGb9dcNOKwUGIBJ385SoQQMiNkEVywDNvlPiWaVOuYjmjDr1kc2Vyuzn+qWr5XmevQ6Xro+jHDETgQy1MkXW8nAjqkPVr3fM6x2hYcMqUaJIPrV6n8Q/6KHiP3KSx/dKA6XaMmC29CyhKR6buyEAfNRZGzjR6Pkaaj+RHuvzlsRBwrQsssxQIEq8LF1ll7h3ey7oTwSzyoRbIuwImxR0zmBpNoy5hT98U0nPOzxT2WHOVKqbI3ahuNgZV62o3hy7LzhIEJMYY8fVJBVbPOBOcreFgZO1Ki2d/EM2+oJ3iHZ7cHRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 11:28:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 11:28:35 +0000
Message-ID: <f651ef6a-011e-4054-a847-86ec857188c1@siemens.com>
Date: Fri, 5 Dec 2025 12:28:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] y2038: lib/cobalt: select: Normalize timeout value in
 the y2038 case
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <20251204-flo-fix-select-syscall-v1-1-7f9c545a63ce@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251204-flo-fix-select-syscall-v1-1-7f9c545a63ce@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed2ab50-d4cf-4dd5-1d9d-08de33f16dc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEFyT0s5K05wV2IwcUlKL2xWd0tXeXVxNml2K0hFeXFLR0h1ZFNDN3VnNlcy?=
 =?utf-8?B?SmtYWTlFYTFpVFYyODBIdThjTitLTDdCK1FwdzY1SlFFVTZaaGNHWjZTL0NN?=
 =?utf-8?B?Z0ozRGNiMXpJTktLSDhlaDdpWThRUlBtYkJSZEhSNUZzYkZ3ZVljbVU4SGlu?=
 =?utf-8?B?d0xmbGk1QU5RNlVoOVZqc0V6QkJZL0d4WDJHbi9rVC9Zd0RuOWZVWVNkQUZ1?=
 =?utf-8?B?aFBUN2Nndi9vR3FxTU1Ja3Z1WFNiY1BpMnFLZ0VhTVoyOTdEdWsrUmQwdURn?=
 =?utf-8?B?WnIvYlArcTcxWVhiVG5KZ3ljUklpajNWU1JhZ2NvMk1aSHI0SG1aQlQxeEFV?=
 =?utf-8?B?eDFlRHlsRUE3QTJsNHRRTTVaQVJhUEVLdm5kNm5JeE5sdUEwQUxSV0VqV1lu?=
 =?utf-8?B?NGZ4blEyRmhPbFU5VDVHQkdSZ1hsRFZmZjQ4M2xGbWd0VWVZeEFTbEdaREdj?=
 =?utf-8?B?UkU1S1ZVQzQxOWFXSWVwWUVSN2dGUUpMUUJEeE9BS0p2TWZDM1p3d1NNUkh3?=
 =?utf-8?B?WlFnMGhzbGtpa0VobG5VbWJaVDhIai9sWFpQYmdZRTdwcXlGaGNscVF2VWdT?=
 =?utf-8?B?N25jbHptdHZ0MUgrZUhXb0hwcDVXUU9qNFJmd1huRkNWeEl0aFdkSVd5Q1JZ?=
 =?utf-8?B?MTVKWXNhbTJUQWp0aVlsWVRVOXdKNjRkeExGdWFDa1hWbUVUb3VzWG9MSUdk?=
 =?utf-8?B?M0hqbjRjZDRGaUhIV0d6WFNzQUJBZWZPYXJuMWlBbm1yd1Z5RERkQkRWNmFl?=
 =?utf-8?B?MlplbVVaZzdCamw4VlRDcUJ0bHZkbUdmQUVTS1U2azFzNjdWYVNWSlhGblVt?=
 =?utf-8?B?Z3pRNkFMMXJEM0Ztc3NCOWdKbnJYYkE1RTBvcGJBT1FvZFBydlVMdVlsdFN5?=
 =?utf-8?B?djc1MnY3SXo3UFZqZXNLdWVvNVlsdUFpc3lRQ2VmQWdaN3JDQjZ6YXB6djMr?=
 =?utf-8?B?SG9SMlhBRjZiR2FCQkpmdUhvanJhU1F2aEdYcTB0NWxxQ05hYnNoSXVMc1BT?=
 =?utf-8?B?MUJsZDVkbGxzUi9EWjlIQVdydEtWRi9aMWgvclNRMkl5MlVpTEx5Q3pHakRV?=
 =?utf-8?B?NERBMWFCWFdKdFA3RXlTZnlXYk1HbG83Zjl4U0FYcFdOS2VtU3JZb1RNTDZP?=
 =?utf-8?B?c0xSUk94TFRyQ2dmRnphMGVtQmttRFVuWDJIWVA1M3dLeFZLQUZuS2lhZjlw?=
 =?utf-8?B?alY2YTFOd1I1WVJpYk9YQ1lXend0aCtXcExkRHZabDRpZXkxM3c2WkxPOWlw?=
 =?utf-8?B?NHFhb1U0aDJMc3dEN2o2WWhOQ0xyWVc5WDY2QU5hbzl2clVFSGt6VDlPUGlq?=
 =?utf-8?B?MmlkYkJKSjhrNHFSMTMrUURCTklWbll2alBFVVdkNzh3bHhUTDVHbGlwd2lD?=
 =?utf-8?B?aENlSGE3djRBcDBoRFF5cmpRTVRyajNpb1NQb1JySkF4azJqM09jQ3hTR0Fz?=
 =?utf-8?B?VFNQdzhpM1hoVUVPMGdGQXFheDdJMmJ3UzhQRDFBMy8rdFl1R2ZrODl6ajZZ?=
 =?utf-8?B?QUl4N2QzQXpBQWxwY1dWSlZ3QldFTjVJeWJLUjBhNFlOaUpndWp6WSthOC8x?=
 =?utf-8?B?WnprdHhlbWtHMFVHN1RRUGxUbktNRE83TXNBRnlOZXpYS1dQWXkvSlNFYWFO?=
 =?utf-8?B?WUxsNUxGVGpLU1hGWm9UNUZLNjBydEZtUEpaWExKd2YxRHh1ZUd4eTB0WTln?=
 =?utf-8?B?VjkwdGV0QXR3UkMwWWtFV3d4NFd5TzFKM2ZvU2MrTWtCN0J0SzJiaGJSVU1h?=
 =?utf-8?B?NjZsWUNyazBZcEkwazVaaG5GR2tQRzZGcWt6Wnd2TDhUby9abE5JZFZDTEpa?=
 =?utf-8?B?Q2ZNWUxldk16SjlwZy9TdFI1UnhObTQ5TU1NdmlCeGFKSkRkZHhhZklWNGlu?=
 =?utf-8?B?L1Q4WmwzcHRkUTNsbkpEU24zVllOQWMvc3VJUGU1SUdWSWhhNGFLUXd6eS93?=
 =?utf-8?Q?virFLdeGTe5btneFoqhn0ed4sIIDUtgc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJFeUc0T2ZLQ3lXZzJwcUh4MmhuLzhFVGdReEFKc3k4UWVyRUJUd2RJVk4r?=
 =?utf-8?B?L3F4SGhQUW5zdi9vY3NXU0lES2c1dHFYcVF1Um9yM3c0MTlBaDRUK0FmV1Fq?=
 =?utf-8?B?cktYeHVRVTVkdGpDQlpMMkMyaW5lanlNNkxYUXJJVjRzeXJDYzhTNzhlSGJM?=
 =?utf-8?B?LzlGYW1uY1hhc3dMTjVCSXJlY1U1Y2Y1YjErTFpNd000U3BkWEdxZlh5czBH?=
 =?utf-8?B?T0w4M3FUbTRmVFFMMHNLNFh5QzltWDB5SUZBVFNkTEs1OVpiYThCVEdSTUl2?=
 =?utf-8?B?Z0k4YzRNeThEWDB5NEgrL1JXb2ZzMko1NStSNnVzQnVKNVlwajVXckRUYWR1?=
 =?utf-8?B?V0VTR05TZ2dTZGhjN3JORktPQXdZWkFQL3JaaTRBWHZ6ei9iUnRyczUvQkg0?=
 =?utf-8?B?dkZreTU0d2doNGlwbHRZMERPUTNSMUcvTnFPbzBaODg5eEFCR21iVHYzMS9o?=
 =?utf-8?B?Vm9kRFlxNG1aalhzLzBza09yd0IwUXFZVGYxMHNqT0JFS1RhUTZVejFTaG1L?=
 =?utf-8?B?YVA0eE5SeDIwN25YbXhvK1BmVXVuZ2haNkRHdkVkVUxyUTNQeTJMUlJ3aU5q?=
 =?utf-8?B?YWZUVkJIaTQxNXZpMEFzMXVKcmdIYVNHeFRjbS9DQW52ZjU4RU8yTzVmcXJC?=
 =?utf-8?B?SS8rNjRBMzZsNUxSK2RIREtlYlo3bk1zUWJQalhwcGF4Y1V5VjNTWWp0UkZx?=
 =?utf-8?B?aTRZV3oyZngxTm1IR3JPWmRXL3VNckxGYW42cHp1ajRkbGNGdXM5NXRPdmZm?=
 =?utf-8?B?Y2FodGlvNXBibjVySzkwTkVNMkVDT01Ldmd6RDRjOVhJUjNkNEdDNDhLbnFy?=
 =?utf-8?B?MkpEZjExL0MzNjArUjRDRDk3eWdvekhmT3lQNTZEWDNpYlQvSjRRL2NGUkFl?=
 =?utf-8?B?WDlubksrcEhsMWQyM2R3L3lKRWFPQlBnQ1ArRUY4MXd0T0M2cDdOME1kZmxB?=
 =?utf-8?B?VDZRdVgxbkMvMjR6eHZwZ2QvVk1oRWwxQ1N3N2lodGhSVnE5Mm4vN2twUGdr?=
 =?utf-8?B?Z1RFZWdEdmJLQndKbzUvWjE3akxCdG1aUFVwYmlHUnBmcWtiT09PWEFBaTg4?=
 =?utf-8?B?M1BwTU40VmZOVzlmQ1V3T2dQb1JsbzBlUng0QnNsN1Z1NlpDOWRIS3hJVUR1?=
 =?utf-8?B?dVNFK2RQUEhNSHQ0NWtkcWlJZDJYQWdCWFc0L2thTktaT0IxZ0tRckFNTDF4?=
 =?utf-8?B?VTBQZmVDL3dMTG9ONWJWYVd2Q211ait6RFNhbENWdGd5YTMxdXBkV0NpOWVt?=
 =?utf-8?B?UHFjazVaMlRhVytZektJZVZQMldFTmVVWjVEMnV4ME56ZEtiOVFlTXBaNFRC?=
 =?utf-8?B?UGFKSzFVVENNSE42YVVyRzFYT0psZ3E2NUhTL0xjQ2pTNExVTW52V3J2OHdM?=
 =?utf-8?B?TEpmZnc0WFRQeWdOVkFZWGo3Qy9nMWQ5YnJyRVJGdmY0c3dHcjBTNTlDUUNH?=
 =?utf-8?B?SVNMUXRmaEhQVFRpVWZIYmtvcTNlWWtDM2lxMlhSMm9UWmpESFJkUmhOYWdZ?=
 =?utf-8?B?SHNvVUd4d1gzbHJQQmtTYitlcGtMQm1FN1NOZWk1bTdpZUhuTEdhTWQ4aFIv?=
 =?utf-8?B?eC9wdVdubFhBd2Y2QkR5cmQ1Y2FlbXFFWGtTMWI2dFJqd0VMSHFtVUwybjkv?=
 =?utf-8?B?Tm5iM0FyUlRJWnI3VVQvbFk3RHdWV2J3bm1CV29IRG9EaWRTNFk2d3Q5bmJM?=
 =?utf-8?B?MU1VVEdUK2FxeGluVExXMFh0NXgvYm9YenUzcmlONHNKSThJajlSNFpuS25R?=
 =?utf-8?B?bjdYbFRwQitKdklHRG53d1NSSU9Sb3VUMWQzcXdRc0hRQ1hRWGN4eGlvVXJF?=
 =?utf-8?B?a1JYOGwzU2ZJU1pubTNrOWU3V001UTRkdHVtcCszMHZNYTNLQUVOcllDbVlr?=
 =?utf-8?B?bXhGUHk5N3JJQS9MMThlWjRZcFhiVXJPdjhIS1NtSUNuKzRNMWVFVnNLQW9t?=
 =?utf-8?B?VDQ3MFg3UVcyWGtENEVuUmF2SkNlOStGR0pPYnd4M3BqMG5LMER2ZUdObHBM?=
 =?utf-8?B?b1crdzlxTHYySjlGckhqZGFibUh2bSs0S29GZjF2V3ZIVmJoV1RGYzdNL0ZR?=
 =?utf-8?B?bzJ5MUJHdWF2clRGR2V4OTBxWXQ5Snhhc3FhclNzK3dJUXc2VnBROExxK1NB?=
 =?utf-8?B?a0E2MjM4Nk05NjlrVGF0bCtDWmlmam1vSFAxenhabXE4UStndEJWV2dJNkxh?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed2ab50-d4cf-4dd5-1d9d-08de33f16dc6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:28:35.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0cbAnmT0Wn/s22nsFEIAGm5Ra5/gTmorINhZndP10Y23ZJZ8l3uwcnP1Ha3dYRj4VqPMArmS9YsRgDVyRCaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5984

On 05.12.25 10:03, Florian Bezdeka wrote:
> Andreas discovered a difference in the timeout value handling between
> the native and compat + time64_t (= y2038 support) cases.
> 
> The time64_t based select() service is internally routed to the
> pselect() service. Linux does a normalization step for the timeout
> values of select() and so does cobalt. Both, Linux and cobalt skip this
> step for the pselect() syscall. That means that we were missing one
> normalization step for select() in the y2038 case.
> 
> Reported-by: Andreas Ziegler <ziegler.andreas@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/select.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> index be8cf34b2..611994d17 100644
> --- a/lib/cobalt/select.c
> +++ b/lib/cobalt/select.c
> @@ -22,6 +22,10 @@
>  #include <asm/xenomai/syscall.h>
>  
>  #if __USE_TIME_BITS64 && __TIMESIZE == 32
> +
> +#define USEC_PER_SEC	1000000L
> +#define NSEC_PER_USEC	1000L
> +
>  /*
>   * The time64 wrapper for select() is a little different:
>   * There is no y2038 safe syscall for select() itself, but we have pselect()
> @@ -36,8 +40,10 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
>  	int err, oldtype;
>  
>  	if (__timeout) {
> -		to.tv_sec = __timeout->tv_sec;
> -		to.tv_nsec = __timeout->tv_usec * 1000;
> +		to.tv_sec =
> +			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);

Where would an overrun of tv_usec come from, only from userland? Does
posix permit that and does not require us to reject it?

Jan

> +		to.tv_nsec =
> +			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
>  	}
>  
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
