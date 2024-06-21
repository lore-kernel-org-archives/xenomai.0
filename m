Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838972BB1B
	for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980958; cv=fail; b=jq7FrVEeyPT89HcatYPqEyLjLEWD3QDVuYw6/4S0VrffRHPfqnTNIHMC4RCyq/8UOq2/r+2A0veEgriOqNDTtht6M6UMN7cdXIGXQHFciLlr9ntWVKPE+Bx765rR4phlIOYMs7ExS0c02jfMw/MgezKm0FOW9B00tYikT9vX8ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980958; c=relaxed/simple;
	bh=jaXtFRiJiInsvV2PDcPPw9LFY/ajcSrwNJ6iA5KkMD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKk7k2d6YmAFzaMegW/hqKD42kBUR8dc9yu1yA34OyLJSriCA6wEXQgECmsiz/PljEV+OngMtTTc1UjQI2bb6Hqc/fs58gt92cfoZpu1jcO6zZ/CQf7uFQ57csbvAjfnFblduX/WTOQvuAuHJn9jR3rlHFoIhO0R9HKqe+eZOrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oWXnwV2V; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oWXnwV2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhOeAKIEpxnFNhRwOLtgfamVrwIytyXkzb+CHZ8tFqrZ3rwl1xQPJXtSZD/cEj+Inkc7P2GA9uxia5EMWDdbHqtkokq57XBKMWxNwjGkkMr2Gor+7ULmPiaOxhdSAaIpZRRNQsx2SxMiI9EabP8MMWPK1S3+P4P6qQlUXQ1Opzqy98GVr9Oqi5ofFxroxBUch4VEdgtfO3wIZkCeffEbkOuczuYvm0DtG59wyeOaEgDkhOw8SJPzZUoeWqdh2WfRvthrWR9pNfp5TFrlFnhCPL2iACITnmYRXvvlgpjejwl4kbzdtdTENS5bWo0oKTjJ20Qff1XgMHeBRBRlA848AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAGc7wgvqifTtol6/KWGN65MqQvJbAjqnhAv2zWOY40=;
 b=JZpUR8Boav1xFjcm3WbSkJbL97ohlW/JgEFfVx8iC2doeW9W20qmVUHfwRHTiQ/3I80FDLPkK+hCmxoi4aTaG2kvOQnjqkIbEG+fnjr8UexJ2ylv8KIOOD8utaI4rE5sXtlqbEYYNTJhKfV0AY2Hj8KOfxBl5vkUozso+7tNL8nk0EFiIk0uIAib2h1oDNIL43s6VrMtnnHI1u7sA4zS6RHBr6vO7ogBjVL6gjBd1CvbhQXRZuejepo/XdL3xZx1+zBbvYMVDRqWtNWKsPmGz3YWCG7QdZkfOSiOBS4j2dFBJah3ahfiiLZMpX3AZeLjr8chagXd51G0LH6ihT6dHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAGc7wgvqifTtol6/KWGN65MqQvJbAjqnhAv2zWOY40=;
 b=oWXnwV2Vl7OLxnh23LStyS2t+fHYQ7hEu4ogXqAb/8HAUfeXuPGBfr6HPdx37O9Ryrv7f1nIu9Mvh0QAaqVDl3KYTs1NePDc6LIVOgzfrtjaadrTqCSPhr8jsrzqk8oQ54k/wIe9J3Qn85sCUAejMPE+R4Sl1jdFuTw04R8zym3qgLXZt8NqEO3YzpeNb1IOsVX4do35MW4CySnXg6jJ+v4YbkrgJb1ik8OlFunqY0R8szzten7SFTISQj3AAMR/E3ucxfY45V+eQFGqtcwNo4eoDetmhvOaTvWjiuRroUOLnTFJSIMokLuy3cU6Y3zdz8VGBzz2wTZ6iB0nTk5NPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 14:42:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:42:31 +0000
Message-ID: <54c97bc1-73a7-4dca-9b65-5057b6976c45@siemens.com>
Date: Fri, 21 Jun 2024 16:42:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Assorted Cleanups For prepare-kernel.sh
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240525115806.12101-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e45a67-4ee1-412e-2819-08dc920061c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBHS0oranpzWlVDUElKRnNNTXIxT0YzWU5qcUdyamhCdU5Xd0xhdTFGUmU3?=
 =?utf-8?B?YVcybkY4eVJ3K2hjakIyZ3g4TFhXVVZkNmNHK1FIbnAxQW0vNGNGNHRoVFlC?=
 =?utf-8?B?cVBlbit6VTlsTjgwM1ZNaUFQVUpZbG80RExsWkNyS3Q2Um43V2RiOWMwa3A2?=
 =?utf-8?B?UnNibEE0eC9GdDRVdy9GQ2E1ZFYxYlNWdmc3ZXJRSVlMQkpEWWtzYVV5YlBo?=
 =?utf-8?B?K2luUGErMzhsWlk5TGhUN1FBRzJCU2labEdVL1N1Q0hyamUyOXY0SFJ3WTRo?=
 =?utf-8?B?QUoxR1AzWUlHOHQrNXVFdmltRVFwMGdYUzNNY0t5THFoSU9TSjV1bmFuWnEz?=
 =?utf-8?B?VEZ4cVFwWnZuQkhGd2R6Yk8xbityYkEvVnFPazdmbVlrYytnRG41WktMTkFs?=
 =?utf-8?B?NXpJMHJrQkxYSkZkNkYrOGtLUExUdFoxQnJUWHZRTnphVVNzTCt6MW1ONjQ1?=
 =?utf-8?B?RG5DdWY4YytGVlQ0Y2F2bUh2VlJmVDdhbU5hT2x2dmZLNHpxc1lWMWhwREU5?=
 =?utf-8?B?VWJub3FCcDZQcFE1bDM3TUdwb2Z4b3lENkpIOC9LNHc0bEk5MWVNYnZoS1Er?=
 =?utf-8?B?L29GelM0Wk50ZFE5Zi94a2t5TFlIV1h5WDY5ZVZNMFNjeUEwTWIyd3NIZitq?=
 =?utf-8?B?TXZ5OGRoV3pLcFZnK1E3OFBrNjAyYzlOcjE4TGh0b2NrcVBrRjNmaTdmRWxH?=
 =?utf-8?B?QUNFb200VUdxZEk0MUtiWG9ic3BDTUtVTmUxTHFHN3hxajdMVWxrdHZkYmll?=
 =?utf-8?B?Z24wd0tFN0xzTGxwVWdRdW51VDRsS2dEdUlwVndlbDJWcW02MlhoR043NVFR?=
 =?utf-8?B?bERpcThWM3VxbzVESG8xdGlmUU1Tay9KbzgzdXNTenJ0OS9jK3krQU1QbktR?=
 =?utf-8?B?ODczMDJJUjU3Rk1vRC9mR1hFamlDYTgrT0hHdVhvRlZvVlRmb25oNmhLV3Bn?=
 =?utf-8?B?MEsvN3pac2lsWnhCNXEzenRvUnVHNjJYL1Blbk1YN0MwQjNjRVZpQURNVEJk?=
 =?utf-8?B?S3RCbWlrMGhGNjY4MzN4YUpTdy9UdVAwUVVrK0NjcW45ZitCV1pQUElrNTJl?=
 =?utf-8?B?Rlo4YjhlNWw5OXVDWnpCMmhZcE9SNGxtajkyeUg5SW5LWWdJUWRTMWY2N1Qv?=
 =?utf-8?B?ZThQdFI2T2t4UDFtU0Y5ZXkyRmltTWFWRG1wd1JWMW0xT0I5OU9scnJBemtH?=
 =?utf-8?B?M2paWkpMQnJReUc4aUpxUDFlL0grZGk0bkYvaE9WRENDTkFzV2I5WXRiMUcx?=
 =?utf-8?B?bWpQRkMzaDIvTGlxQWpHRElTR0xQcFhURy8rMnVMKzhLTEZFWEVyaEFublEr?=
 =?utf-8?B?ZlVVc0JvSms5cDIxZ3NIdm9wdVRkMmRJc2svVVJFdk5KclhnNkNVN0dRb2tR?=
 =?utf-8?B?Yk1Idk02c1NSa0pSZkczaU04U1lOaXIzNmlWcE9lOUxyUnVUM1FUZHEwS09o?=
 =?utf-8?B?RnpLbERDSUJTZjRDNUoxY05MdElkVytMaWNpdjRPWVJZZUIyMkpleEVadXRu?=
 =?utf-8?B?SjFob0V3a2RjQWxhV0szNFAzNGhacUdNdGI0MXBTMmZKcmc5bVZEUjRrNGpt?=
 =?utf-8?B?U2lCUmVHcnI0MjZOZWJFSnhkakJoMjVFaStrWWwxNURMcXpuK2lIL1NGVHhX?=
 =?utf-8?B?dGo4ZTA4TnRxaE1EVXRZZEJSR2s5S3pMSEVDaW5tamwwbmZnMWlUcVpTZ1F0?=
 =?utf-8?B?VnA1TzcxVWtBaXBVMHc3TklYT2Q4N0ROc1BwUWRCU1pMRC8ySGRKL0U1ZEdQ?=
 =?utf-8?Q?NacnNnys9AdLA+3Xup58bW6SIMTbf9jmw2ugO5h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d201WGp2blJQRjlwOThma3ZWcGhLcldFUC9xYXNUVGRIVE5kQ0tsN1BIKy82?=
 =?utf-8?B?NEJIM0FrMzNCdEpiUjJyMGFseEdsb3R4YmNrQVZNQzVGQ0MwWmdvcENIeUFD?=
 =?utf-8?B?SlNweGFjVmpWUW9Tai9HQko1TS9pYmd1NlJ6RHM0eVZoNzlvdmt5VmgyWUpH?=
 =?utf-8?B?ZkJMTkozSXhMTnBvRVBWZEduMGtmRWo2c2hGZzNMN1VPSlJkWU5QMVhIelFD?=
 =?utf-8?B?U28vNGxQVW9uenlxajRJY0JpZ3luazRnUXZKRVRkYnU1QS94ZGRVV1UxWndq?=
 =?utf-8?B?R2JxcHlmZzdOZjF1cHcwczVzWFdmVkF6ZFludElSSGw2dW84RWNYeEw2T3gv?=
 =?utf-8?B?OUNsQXBrOXBFQTBvMUhGVFZOZGRKS2tWbUdRUm1Pek5BMjRVUllXWTBWcWdy?=
 =?utf-8?B?VTJTTDVGWXk3UWZoT1VLVnRvRDRlWU41MjBpdFpVQVNMbUFVUCt2a3JHcVlE?=
 =?utf-8?B?RnNSVnpOVnNTdUZONDFJeEorOC9lRmU1OHdCVHBuN0NMeDFwSVI1M2JCVDZK?=
 =?utf-8?B?cHBVMXdScW9EU3NlZVloMFppQm94elViN0l6Q3hIZGJOWCs1T2lwK2d1S0dJ?=
 =?utf-8?B?TCswZHlYUHFzYnhab05pRkFjdmttSDBNWWZYZkFab3FIVkVxNWxhTk1JM1Na?=
 =?utf-8?B?d08wMU1IN1lzV3Y3NmhaTGR0SGFCcDdNdkRhcVJGWnltL1Z3NDFGUDhDYkRE?=
 =?utf-8?B?bWRMZllTQnN4Qy9zWXd0d3dReFlnUWhEQXcvSHNhbnJjWk81R0JnaFpTNEZz?=
 =?utf-8?B?cEFzeEd1U2dvUFJaSHhTN3ZHejhDazlOOG5EQ2ZaeHEwTnl3UWJGQkx6RDdi?=
 =?utf-8?B?S0swd045a2hXcGxjcjFIQ1Y0elZpcCtta1FmbVpyVHBodVpUU3kxS0xsOWlt?=
 =?utf-8?B?ZFJ0c0xtNEo3NlBTeTJGZTdOL0VmOW1tSW1qbFA4bm1wRWVYT3BDZkRMTDBm?=
 =?utf-8?B?SXVURktSRWtGTUozMWhlVDFYUGFYRHNrVVdZdnRhVUlrWUZwWGhXa0hITGZa?=
 =?utf-8?B?ZzFIZ3ArNVkwendoK0g5UndybzczUWt6MXNuQjdvdnRiNGU1Y0prNTFzMkxR?=
 =?utf-8?B?MVBCdFhIandTeUNIS0dDRzVHVGo2OE1zQXhvWk83QTBnZGNNK0dFWGFPZVpw?=
 =?utf-8?B?Y0I4NzZVN1pxOHBLRjNybmtUZ05RRGJNZVpadHJPR01ROFMwMVVoSzlha3Zx?=
 =?utf-8?B?ZjFzK2xJOUxmcklDQ3RPVjlGdndKa1JpSEJ1bzdORjM1K3hVUm5wN0pBUFNv?=
 =?utf-8?B?OEJoWExzbmdBb3lZUXZBQ0pzcm0yQ3FZTW5FMzcva2xsN2NyY3dHMUVKL3o4?=
 =?utf-8?B?d3d5alBwb0tCTmEwZlBuTEN2ZUY2VkdHZVplWjF6V2k0ajFWMmlCTjlKaWVN?=
 =?utf-8?B?Tlc5dXB2SlQreFZ1ZU56MWFQeHV3bERISERoendvUVd3QUdnTDBFSHRJMldY?=
 =?utf-8?B?ZXJMWk9pemR5QXNnTFg2RWRjdE1VRVJXSWx4NDc4SEdPM3hSV3dpOS9qQ0F4?=
 =?utf-8?B?MjBhWm1iY0p1V1pPSG9TMWNsODVZdXdDd3g1S0NBdVNRR0ZjMDhac0ZiQ1g5?=
 =?utf-8?B?T2Y2cVgvS2gxalBUZzF6Mi9zUE9IVjVRRnlYeG9XaSswdkxyRWlVWlJjaHlB?=
 =?utf-8?B?WEFzeTA1bDZLVm1tOFlpemt4d2pUakc3alRLS2tJYXlRaFRjQzlUWU5ncGRv?=
 =?utf-8?B?enowRmxYUmNDVm85OG1QYkJUd2ZKUFJKU1g1NXluVjJ4c3d4dXYyeDZ1RjNr?=
 =?utf-8?B?WnVldk9jQks3TDk1T1hUWHZBWTdkQXA0MkpLYTYvTkZJMHJmWGNYb3JBU0tP?=
 =?utf-8?B?SUVvbGVPbGVJSmRvbmlyTWFMb0ZmbVRDR2w0Vm8zZWxsQlVqYnUxbndPTXE4?=
 =?utf-8?B?WVhzYWQ2Smt5eUlDS3FCbjlPRzZ4cUtSR2dobGpiUXdHeXZQNXJiNldXeUZZ?=
 =?utf-8?B?SnZmNE1qVHpXS0pjMmk0VTZlNklUTS9XK1pxUy96N3o0bjArT2t6Ty9ZeTlx?=
 =?utf-8?B?SHVhY1lUaW9tT2FuTkNUbEJDM0IxTTkxTmJScXZQWXNmYndMcThueEZXMWZ5?=
 =?utf-8?B?TnZXWmd2UjNJT1djanRFRFZjTU84MFNJcDdXeGUyVnZIRE5hQjJVYVQ5cWdY?=
 =?utf-8?B?d3dLd3lFWGpUQllIWVp4Tnlrb2pJUHh3N2pnOEtrNC81QVRldndqZzhsaDRM?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e45a67-4ee1-412e-2819-08dc920061c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:42:31.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra8ZxSJWHj0TeBK+S+kUgNu8/7BLfHtrTbbNDZbiZZl0+pNGU8Dctr17M1WMj7+y47icrWMzz6ZTnVyT7lKH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8661

On 25.05.24 13:57, Richard Weinberger wrote:
> This series contains the following improvements and cleanups.
> 
> - Implement --reverse to undo the effects of the script
> - Emit changes that work on any architecture, renders --arch= optional
> - Switch from /bin/bash to /bin/sh
> - Make shellcheck happy up to warning level, info level is still a lot of work
> - Convert the whole script to tabs
> - Remove dead and in vain code
> - Various fixes
> 
> Richard Weinberger (16):
>   prepare-kernel.sh: Add reverse mode
>   prepare-kernel.sh: Emit architecture agnostic changes
>   prepare-kernel.sh: Convert to tabs
>   prepare-kernel.sh: Improve kernel tree check
>   prepare-kernel.sh: Fix shellcheck SC2046 warnings wrt. check_filter
>   prepare-kernel.sh: Disable SC2115 warning around $linux_tree
>   prepare-kernel.sh: Don't use eval
>   prepare-kernel.sh: Don't depend on bash
>   prepare-kernel.sh: Remove --filterkvers= and --filterarch=
>   prepare-kernel.sh: Remove interactivity
>   prepare-kernel.sh: Remove --forcelink
>   prepare-kernel.sh: Fix dovetail check
>   prepare-kernel.sh: Define command line variables
>   prepare-kernel.sh: Remove dead code
>   prepare-kernel.sh: Don't allow uninitialized variables
>   prepare-kernel.sh: Remove kernel version check
> 
>  scripts/Kconfig.frag      |   2 +-
>  scripts/prepare-kernel.sh | 585 +++++++++++++++++---------------------
>  2 files changed, 267 insertions(+), 320 deletions(-)
> 

We still need some v2 of this before 3.3-rc1...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

