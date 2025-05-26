Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F171A255C
	for <xenomai@lists.linux.dev>; Mon, 26 May 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237795; cv=fail; b=jy0w38zbX0rftHSBSWUotG7DydmjrKDJd4GdoIA1r3JwnTosZs2xh2f99TIPHpEQKBRe8FHfLQb8p9n5yNU0pe8XYtSKEUD0ZreEDqRM3Mzu+C/QIkQySP9ljBg/hzBPL//sfghRouMO4nVC6IC7YZ7cl0KomEnTnu1h7B+ys1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237795; c=relaxed/simple;
	bh=YYMNwxH9wiKiAxc5W/KTYFrJsBTpJtoYjJcikVirarQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mJZmqbuBA2QTGqv8ZSFFwMFaq3I28SAa+MPd7v+mrWMfs4zbWUPkla/QmY2uFyfzAIDg/zXFdc7TZ2yci5i3sT0C9zTs31PAvCsNJFpBQcXJVmji2t3YnP4YGAgW2hvrI0SjxxAQNiG8vkZxFlYjJ/d1wZT66XPC/d0Z5DlDwPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JY7oSLpI; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JY7oSLpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNtR52qGuqzAjMAcp/nsKfhrWd1wiAxu7lGBxxNScAjmI0WNDPwuhTzFdvXG85ShSMSBjKVynAjxa+H6yDQm5WUAyvGHlUOnq7AJJFBRuGZmKzCnggzJsMTk1PI2GD6zZ9NNFXGziGuY2bHKnAwExGXCIfAghcAI5mJZhmHITbBLs6Y/NNyka9pBJcpGP99DwKrYNQq67h0YhMnWDrPUHgqOqIaqDIrbVDCuy7pmnzPzhVpaF9JmhfUdnQ8k6hq6Y7MKDNaP8REMswSuqpfyE+rSFwakqaltmkJ67gK3izPo86B7X+dQZLApRnHIcyPeanT0DXtSz7B7nK9NSWUKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1qfLEFnHuY6XSL1tFw7XzBM4GXDsD4vEIwEfiuMNds=;
 b=Ba8h1F/XcNrb6zkt8ZZTXcYqn6E1ZtkdQbfArBm5/4LB0a8l0jpI2UzkApNJGF3ZrVxeMh2GPLSEQS2NJ6ygqWc+EMQZmSoarWhajJQOOXlYmbbgyWd8uETo/b7hQ9ILggj71+3/6NwccTK29NnV0+A0RejuP0ksJcZ2dGj+x8etXdyWZFqD16Y6kPndsuIkfQvFJAM+rPTSdOQhR54mSXV3GaHWQgX0c03ZFUlzy5iIz0uD2AWT3Dwmqq6NiJ9Ga2JTYBjXPveSWNvTGqo5YTP3fJlkyfken9bCS8Itb70V8eS0YAuWdQ4/X5xpxx3D78LqMSBOV+y8VkFJ5AwCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1qfLEFnHuY6XSL1tFw7XzBM4GXDsD4vEIwEfiuMNds=;
 b=JY7oSLpIGIcVFaYnkt59zmJWVdg7KLz5cw3Hsa4vS5VhwRQUuJL+oYVEyr3ylIyle1vFTIAfiteLJLBbnPHKMASeE44qg1qF1gko89nEFs82uCi6c2TXlNTW3VklKjD7CGF/u13RkUpGr+3xgKaTu/ZPgnG1jeKvBJ4tBP811daGD/bZ/e0sUotb7k9lfKTWJvbTQzoBMNj2xBKOBUSwWcz3a/Y06yoSPqpm7OHM4lAiDvuJcYisrqDo47E/vUHV+n4s06H4YkQH587XBnfuwVb5brDbQ5IaCw+rj06oZI+nBS//gAGp07Gc+XGtVqf7RCHwMVhPI1nZerPr7cb1uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:549::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 05:36:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 05:36:30 +0000
Message-ID: <d1a9312e-ef05-407a-9d15-58863d212c42@siemens.com>
Date: Mon, 26 May 2025 07:36:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/latency: Remove unused include of syscall.h
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250525083317.394765-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250525083317.394765-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: b796181f-8338-4bbc-fb09-08dd9c17447f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SndqZHFFWndQdi9vanJOOGIyNnVJQzUxTE1IRTJFQUhsVmdoaXB2UnBOTlMy?=
 =?utf-8?B?TmhIZUR5Z3cvWml0QVo4OHlGcHg5aEVxZG1ud0IrNitMVkZ0dXN3SjJEQUpJ?=
 =?utf-8?B?R2gwSFdSSlhPQkQwNW5yK29vVVhnVWxnOVd6UDZhS2U4STQ2TFZHUXovUUJ5?=
 =?utf-8?B?YXZRV1RIZ3VmTzhnTU9zUitsTllPWXhzV1UyR29Oc0dMbjJsS1hqbUJvaFBL?=
 =?utf-8?B?SVBEZDBlaFFtOURSUCtoOUYzaTJ0YXo1V1RQUE15VjlvMUxRYkdYWVhQMVZj?=
 =?utf-8?B?TVJmYzBMUU1reThmcS9BVlhNdmU2bmtNajhJRGdNTk52MGlCZURzcDBvTGtG?=
 =?utf-8?B?eXQybllvaUVWYzdPYnorS1JaaVVuSG00dmJLckladlZKVUFUVmVaaklLMEsy?=
 =?utf-8?B?TDZLZXdWMm1OTGxDNmdIcnVXOGRaVWNvSmh5U2EvKzNwMlpGbkhSYlNwckxL?=
 =?utf-8?B?N2VoODJRanF0SUZCd1JVa1VVUVpYdkYydmZUMGkrSUJpdjFVVjVwWnFpTTBv?=
 =?utf-8?B?TDBGQm1lSlVPUFIzNmtoRDZzaEp3T1RyRG1BdDdhNkFaVkFwck83S002ek5s?=
 =?utf-8?B?OFBQSUkyU21Hc1A2bG9SRnZiZjdnYlF6YVB1MzFjN0FXc3NFWXVEbkkvdWN5?=
 =?utf-8?B?WjQ5elpDYnkxV1VIL0R5SEZtaE1QVXYyTHNvTTdKWmRUeGVBQmRFTzNkVXd4?=
 =?utf-8?B?QXJEcDRyRmtkYnBhQ094Ym84b1BIUjdveHZ6SGlHcjJBM2Q0MFBEcmVpUFdl?=
 =?utf-8?B?ei9qWE8xd1RJWk1KbStYbzdETzRLMnM0M21Ha0d5N1gvRTdxbDFHeGFtVDFX?=
 =?utf-8?B?dnB2SVdNSHdZdHhFU0h6VE93STUxN1BiYVZ0V0V1aUNHdHlrZ2toL2FjMHRz?=
 =?utf-8?B?TlZ6anU2WkdOY3dQSDB4OEtQWEtzbXNpaHZyNG5FM3gydlFSZDd3d2F4UXNB?=
 =?utf-8?B?bFdKTHVnUWY1aVBwYURadjZ2aEp1NzJIWk9DdXB6NTJOTUJQMHVJeWNONFF6?=
 =?utf-8?B?bElkZ2hYNXNpeEVUN1FrdG96S3hsWFdPaDg5TmFCMmttYm5VVFREQTJGTWJ3?=
 =?utf-8?B?M2wxUWI0V0RJV005WHZKcks3UGxlbktvajVjSWgxUUtvYWJBRWFDZ2pVdWZI?=
 =?utf-8?B?VG1aMmhVODV4V0YxTTFHRUswd1lNSkF0a3pOTmxnZ25RWk9BTkJLUDlqcjBr?=
 =?utf-8?B?ZWRkM3NYcmY0RFFFNlMwU3lsSGg0WktVWUhjRGpybzh4VU9QQTE5dWtDS3NE?=
 =?utf-8?B?eXZhU00vSnlhbHlJdkpEcWY2L2NNZnFXVWQyQXpFdy8vUFJFUVNNQ1ZCeE1Q?=
 =?utf-8?B?VTQxSW8yQk5hNXMzdk9JY2RNNlUrK0g4TktBQUpUcVcwZXI2T1hDTGlXL1Bm?=
 =?utf-8?B?a2o2MXg0TGVsOXRQMXRZUERmalBSb1E4S29sQ2ZXOHBQVmdEeEJCMm9lRkRX?=
 =?utf-8?B?Y2ZUQWtQcVRubzRMSzZONDJ2R0FuZ2F0eG4wRndwamN6bTl1UUtBdjJuWDJP?=
 =?utf-8?B?V3dGR2dWNWxKaHREc0NHaklPUi9XQnE0c3ZHSjhpMUJrL3RiVzlqL2FrU0lt?=
 =?utf-8?B?bnk1N2FCcGE0ODh4d3BqRmx3U2o1Sk9MejlVNTIxclJ2cEl1VC94U20xYWlF?=
 =?utf-8?B?RE5rUUUzMm1DWkt4d2pRZHBQWUd4TmlQcWRxVk4vV01NK1ZFYnd1NXVJaHdP?=
 =?utf-8?B?dFMwNXN0TkJ4cDJYSk1HV1ovUWtGT1F5Qm1rbDJlZi9nL0Rnb1ZmNkF2aWYx?=
 =?utf-8?B?amhPSzBpaDN0ZzF0TU5NOHpkYzhCakFVSk5qRkFrWWtFcjdtbkQvWnpTRU9v?=
 =?utf-8?B?VGJoR1g2aklsTWR4ZVRuYXEydHJUQUFyaWhuK2plVjArSFVYc1VaZzVZY3Nz?=
 =?utf-8?B?QWpERVJMSWxkR2ZwNDFJdDkydlhwNlFFL28rYzNoNWFGQVc2NmpOOUhLa3Fp?=
 =?utf-8?Q?444VRtOawWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZNdjNHclg1MGtxUlcwcXBxcXlSL3prQWh6L0xzd2NOczQwbVJUZGI2KzhF?=
 =?utf-8?B?Y29XcU9WVEl3WFU5TG13KzQ5eUNUU1BtbGxQc0dxdHY3V1MrTSt0cUl4cy9B?=
 =?utf-8?B?QWNKVm00OEM0N2VJVmQ4elFaU1RuNmJQL3p1cm0xL041T2JRc3VIUldlNE83?=
 =?utf-8?B?RXNLRkQ1L3NHRmxSNFpIOGhzODY5dU0wZDZoWit2bE1BU1BhcWpwUjl2TlNC?=
 =?utf-8?B?WStwSVFlTnk2RDRsTXd3QnZpTFZpZDh6VVptMUhwUmFoM1FFQXhCekxKQkpL?=
 =?utf-8?B?cVBZV0JrekxwTUtmb01hTzRGb0NYbFBxL3l3V2NWNGRmTE5aT3NDZFNXdmdu?=
 =?utf-8?B?ZVR5N3ZwMXlyTjRDeTlvY2NSWFg4NVRCb1lwcVdUWTZKRVFTWGJucDgyekRT?=
 =?utf-8?B?R2xFdUZNVkdPN0ppTFBYOXlBWjNKeGZ6UmJ3WndzNVYwdTNTZmtnU0tiNmRy?=
 =?utf-8?B?RnlxbkkvQlN4Mzg1Tyt5RmFOaU9SbWVIK1YzNlV6SlpYZE5lcDhIejJ1QTVq?=
 =?utf-8?B?aUIrbklUanlYTGhPZ0lKNURWSXF3ajhwbk95S1BkWm1LSS9nQ3pQYnpHaWtW?=
 =?utf-8?B?L3lNaHAvVzR6dXNySGtva3NRT3NRcy9XN2c5QnBobGlsTE1jVmdwOThFdjdw?=
 =?utf-8?B?SEh3SjdrRFc0MENyUzNqZ29mNS9scVl3MGhja2pMeUZ6TWlwNldtZzJDUEEy?=
 =?utf-8?B?WllNTG96Uk1aaUZaNXVmYUNZUWY2QVNnUElVYnFMMlkwSlgxc0hkY1VDU0pH?=
 =?utf-8?B?SXNTcmJRbE1oaERXdTdPT0tRWkt4UWZqdDBTZmtZcXpTck1vSUNRVWtWcVZv?=
 =?utf-8?B?bUV5dk54dlJ6STlsWkRSVjhZclNJdDB2K0FiSmFqQ0FFRHNRK21uVDdzUGlF?=
 =?utf-8?B?a3BEVGVsUk9zNVpTWWs0MW8xakxyN2E4b1JEQ1lYUU9SbTRNSGtiN0I1Ym9o?=
 =?utf-8?B?WjFsYmdNUWVaejhVK2lqalpWMklOYXhsUFdhYXl1YTU0RWJFNHBuKzRGSUI0?=
 =?utf-8?B?OHFzK1pjVU83QjcxcDg5ejQ5cG92TldsaEdZWGVPQUZNK2VURGlCTjkyN0E0?=
 =?utf-8?B?Uks5cXlWMnhTMVh1MHh4S3lURDR4UGNkRC9iUnUycTZ0TTdhNFVZQmRxdkZE?=
 =?utf-8?B?OEQ2NTZ2cGJiMnZVM203UjdnR2VLSEtCVUZHTkVRRnRDUUhGVXZ1VmZOUmdQ?=
 =?utf-8?B?U095SUx1em1vRmRHTzBSUlBuRmVxN0tJSFZXMUR6SGJUcWx1bStWckowZHhw?=
 =?utf-8?B?dmJkcXU1TVlHZUkxaTRkbXU3b3RCYlNBbjJLQzljQjF3aEZ4OUJjUUZxTWFV?=
 =?utf-8?B?NHQ2ai9BT2xWTUhOWVYvSU83TVA0R0VUSXpLdjhZakFmS1hQVnRMeUlxNHUr?=
 =?utf-8?B?RXVseTN4RklOajFMZ2Z0RzBzWGM4VkpDbHkxQ2JRNDZINStDVUFmcTFTZm0r?=
 =?utf-8?B?ODRZY0dYUGZlcGFyZ2IyMGhpSFhmQWpVNjh2QVJtREFqMit0QjZORGhOSnNU?=
 =?utf-8?B?VG5vdU1salRqeHZNUzl6TTRrUm9sVHdGeDRYMSsrN09XMFZBYXdjdk5kNms0?=
 =?utf-8?B?SGlvQnB5bTZKMUhpWGpkeXk2VmpkM0FwYzFtUnlHWFhWd1lxSGxBKzlTRm9a?=
 =?utf-8?B?eHB5VC9xWjJkSDYxRExzU09NRWp5cWZOMmlBTW50NHBIUnBzd3JCNHRCZklR?=
 =?utf-8?B?SWRNeVR1dkRvSE54d1hJRU5yRjlQVVVFTVpmRmNRbmF2L0w5OVg0dGhyTlM2?=
 =?utf-8?B?cE03SHBlVmU4R29LZ1IzOVN6T1hTL3lvK24yNlptdlJjWk9nMDAybnVIbjlG?=
 =?utf-8?B?TnMyVktLNmhtaXRXdGRQWEp3eXlhb0FPYm5sMUJQMFVvbXNreFY3VEt5V2lD?=
 =?utf-8?B?SWhmLzN5aTBUOWdnOERzU2todER2clJ3ckdaVE9wZmVtZmVPcG5PQWhqQ09l?=
 =?utf-8?B?TnAvV0tlZFZmUHl4Q1lyUm5rTzFJampxSWUxUTJsSWw4WHZwdENIOHV4Z2kv?=
 =?utf-8?B?WW12VE5TUjk3aXloNHJPZnQyR05FZ3JjY1l6VEM4eHVlVGpwR0hGQkNYbDVQ?=
 =?utf-8?B?aVVDbE1GUG9ybXVBQVNSeWRZS3hUa1dvaEx1RXFlZDQxdXBMTHZPbnJBT1Iy?=
 =?utf-8?Q?3ANDxsywe9B5UI5GNRXj1SYVG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b796181f-8338-4bbc-fb09-08dd9c17447f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 05:36:30.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4QH2Ikqwt7rQ6TGefd/wzOhFhwf8/2jGCRtlOaOA7rlXnNQvKGRstQ+UEo07AuIz2Rmy1+rtCHSnn6c6tyyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6151

On 25.05.25 10:33, Haiyang He wrote:
> No functional change intended.
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  testsuite/latency/latency.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> index fe688b9b8..0b6964bb9 100644
> --- a/testsuite/latency/latency.c
> +++ b/testsuite/latency/latency.c
> @@ -556,8 +556,6 @@ static void faulthand(int sig)
>  
>  #ifdef CONFIG_XENO_COBALT
>  
> -#include <cobalt/uapi/syscall.h>
> -
>  static const char *reason_str[] = {
>  	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
>  	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",

Thanks, applied with this additional explanation:

"Since 35e291db9ba9, SIGDEBUG* definitions are coming via signal.h, so
we can drop this include."

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
