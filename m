Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A2431483
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110769; cv=fail; b=DE0dj30FvjQ+sgy5ouum+XtlBrtuIYrR14c+Sv+7E6I8QYCc4Tlc59+2AaWFSKq/P9Wx8b8Y9rp9Mw/rdZWRcZLr/mCcJ4qT9LmCeWLOTDtlOaapawUW8GFgLJLb8d14I/6JD1ddaQ/xDRaRWr/qVHCdK8lyACwshkVf93xJtg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110769; c=relaxed/simple;
	bh=OyN26rLZRJjRjy9etZRNphzcjiDQolTyhso+NJO77jI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXaIzhMV/3MDi4ivfQks3CkWiq9S/C+odqcC7DhDtJ8NhPWFU/NnCxbt0IP9ogfqNaLoGljPhsmdGspcaNAMoVJnhKWpLUCIz75UwFyb5t9R3wjg3KXgaYytBUG577Nfro+eaDGa2lGj1w0hYSk5kuByvF5QR52ol0PrfLURee0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UFZsNX+9; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UFZsNX+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcWK2LnR5roEDWitnikO07g+8NBlgy2LVth6WoV6b+P0wHjmBPHFykmYf/a2cFkAoLtEtc7CcRd7G4Ozr8ZQ1ko0843KTKumFkAKuppEmFEX8DhTptzyax0esxnHDMjaLMvKqkOt7U/whLvwr2bhP2QkhrWBL4ecocCqAnu8b++i4i4uM2mY4RjJSigHtwr2oCCpJXMn5m5kjEtud4LCTrQ83FFPKMm6M5pUdzUsoRkptxH/YthdI+63XfFfKlpT5ocjgPXRFl17Eg85Sq1UzNywqRxsn2gBjP7RAMZgl7ycgNYsP3iXVhALlbwzgAY2+aslQgm4N7Byn8KM0auNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHmWp/dc49QQ9IABb0NQXvnXTtZrV8dJF0RS4wWFJK0=;
 b=zDwr4ixAdt72ZvWx29J0mY3wmGhrLJKDe5M0L/4efs5ws4aUTldvQF7xBt+pb6OM6UNKL/yP9+CljNT6BtJU/6+BinC057QNQMENuhMQxqxDsS6wgAq+7qEGPFKiG5/RhYjfP91Fyv04++oUl9DHS2hoCKumUK5aUhEQVCrk9ZOtV8fyA2m0JgX1ziOnOZDkJjHc/oyTFRNs4FEQexJeeAPu28zBbtsybJdsvrWOd/y+1vpGk6ihNKpTslFJU/s7car6xmVd4BZfdjcmOCKekJqYG/4LNChG3UM4Glg6gFnH+VpKqJSlgF0FrE5xfXM7mwZtDmsCZcGbB3uUdiywPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHmWp/dc49QQ9IABb0NQXvnXTtZrV8dJF0RS4wWFJK0=;
 b=UFZsNX+9apR72aBVlR4GIRqipmHDNBp6y4sQDbUzzRNy1bhfAKZxt06s5tQpSKvbyKnvsXaiQtSYPG1sB4rTmZOPxRduuQvZgvq2djujZaFJfV481IYp2diVcnDlAi8jBC1dX8eD+jtsDkpXjw4G+vY+vP8jovGg0StjeB5MijZvsBfq0GD/ETenZBgTRN33VQb+8aiu86GagBGaCdNAwLq8SXtTj5Bdly/DRszpwoNOx+l/Nr3wkFsy1Ju0Xq15QUotnmj5rQuj2xHV2picv5nrXbkVlhBjc+nK8e/elvBIti8BQZlKvj+9u7o4Q7SBG0VsqXDMTdlJUDgGwujdDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 10:19:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 10:19:23 +0000
Message-ID: <f8050b7f-6866-4075-bb2f-b752446a6971@siemens.com>
Date: Wed, 15 Jul 2026 12:19:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images 0/3] longterm EVL testing under load
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260715092822.223712-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa88704-66b3-4967-e570-08dee25a8a66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	279eBIq2pQdQF+eRcYwoCMwqCQqvVzFKHdz+bUdeYbFF8+ylXQJv7LVXG+WVGMXp6mS3ClfdavfScvEiRkeGZr0n3oipyooZ6ZSiVI+D5q4ii81MrDaPpATlitulrMHvwhYh98Zsbk5UrJ4qxxfZqtvQEX7PzHunLNm8hzTugKx4T7BBhVK6yAGlTG6S+3i8DYoHo5HIv0jQzjwQoEU7YlpHrAbIiZO/9m5JPud1Ec4G2lGmC8wEVpxUD2xEYc1e7GowtbSE4u+DKO9DWdcmfB/vbLApoSNPOX8IeS4x54runF/Ws8HeNwJv9O0zKIDHBDUQgGcusEZB6LrqV1t4KC+2aXg0L9yJWMN1EWZ/FLYrK9jkwcZjV/O/MNVvsVjgqS4FRa8Mo/qsbuYHlaTZ1CVSHVTu2pXu9xBxZrgxkN9Iznr8m3cEtZh6y8EbxC3UxqBYoqzIs0NYq3PimAH9j2kFVqIffNHXR1M3sbAMoRIlKD9E7S0eBsZebr5noCh/T0iZxoZ0ijFsv40XoR/kU0rt3tXpXCYDpamTwjHG+OATh7+d11EyhW+z248Ry+rw1AXxHk2RqWA3fAvFloYDBHZ4awDkCrtV/9hAfVIbuf3RnyE5x8Qifr6sXrdDmIX3odNasdgBUM4T3FSn/SRetpEIqZeB7efEnPwGqtsHaaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJ3VnN1VUNSdlUyZ010NXhGK2JhWE9xNWVwYWxWOG1VTVJyUGJzdHI5OU9x?=
 =?utf-8?B?bFBGMVpNaXBYTGR4NlhkZmVQNmI4ZnB2YW5MazlNWlFPdHE5M1ZaLy9qT1ZN?=
 =?utf-8?B?YXFvc0hwTk4vaGxUWU9DVFNqTTRXbkV1bGFOejgvQVYyY3lqVE5WcDhtdDBo?=
 =?utf-8?B?TkVXeHNCSzJWQVB5b2VHWlhkY0xyNkZ0NmN4eUpNMW96VFVNdTg0WUlEUVU4?=
 =?utf-8?B?K3AxQ0pjVmwxNG1UWVBGRHBtd0I0WkZkLzF3N0pUYjFFYmxFRTU0Y0tLb3pJ?=
 =?utf-8?B?QlIzU05iWHJPQlNRMXA2UU5lS2xQaHJKekQ4aHNuVUV6MkhoeTJpdlZscUZP?=
 =?utf-8?B?bThtWTBaQ05pWkJnZU5vK3pzblpTT0U0TUFOTlVkWjhVUUJzNlJZOVAwZklQ?=
 =?utf-8?B?S0pMSjVtZms0cC8vRFZ0WWZHdnNBb0xrZVVQRmdHTHZsU3RleUZyZkc2RWUy?=
 =?utf-8?B?QXBjR2tnbzl2d3d0QmIyMnF3RXA1ZUNsMURSeG9mUzc5cDRuSXBpQmNCT2pt?=
 =?utf-8?B?QTFDK1dhWDkxNjkwN0l3czlhU1pEd2hSTmpHRVhUKzlVYkVUQld5a014NUp2?=
 =?utf-8?B?U1d5bVB2WmFrKzdhLytDQWluUXJrS0Z6UWREdmtqdk5BMlVpUytiS3d4UjZL?=
 =?utf-8?B?ZWtETzJxaEc4UUFoZm01SXdBT3QxMjdWSWI3bzMxL0p6Y3V2Z0Vxc2JGNERZ?=
 =?utf-8?B?emxweHRxb0xaTGdVQk1CM2dHYVo4eTVBWXJnZ051bTJQZzRZQVV2MXpQUlMr?=
 =?utf-8?B?OG5PSUdIeDRJVVZjMTdteW1mZjlQeER6NTZIMUREaTlvK2MwUUdycWFqTjlw?=
 =?utf-8?B?a2xYS1BmM21kemRlQzd6aHNqYUk1Y2FvMy9VSjBaUC9qYUtJK3o2VTlzd0VI?=
 =?utf-8?B?Z0lJRENTcHJqUGREb0cwMjFVTXZqZjlBN29WTE5DU0lqekptVkZ0MXFmZjhQ?=
 =?utf-8?B?bDREQThlS1RFS2JzMUxoZmRQM1g2MC9heEZJN1c1VGtrQTQva0NiTVU4OWF4?=
 =?utf-8?B?K25CbGlXUnFIM3dVTWVldFZhamRTeDkzcERwdkVFdnc1NEwvMzdwYzVKaWx4?=
 =?utf-8?B?dWxncXI4YUYzcTliOEprOVBXeFlpUnFhNWVLKzk1dm9jTGs0SHJ6aVpuTFNs?=
 =?utf-8?B?RFNDWXFwY1BPdHQ2Rzh1VkZVN1hzVlpYemJiNkdkTFNOQ05YeUhKa2hkcnBR?=
 =?utf-8?B?emhtemhRSlVLSm02RlFFRTlHK2ZXUEovZXN2UnhhaU9KT3JSSEF4dk5XNCth?=
 =?utf-8?B?RER0SUdCQ1NDTnUybVV4bkU4WngzOXp1bzdUelJKd3F3OTJDWXpvZEhqZ0JT?=
 =?utf-8?B?bWQrVU5DMU05RC9zdXV3elgwM0xyMlJDREJNYjFiM0R5NWNjd2JGOTAwbzFC?=
 =?utf-8?B?ZG1TeklKczJodkFsbnVxSjUzYWplSU9tVjlGWmwyU1dQMkxDRkRzL3hsdmgr?=
 =?utf-8?B?QURSTEpmeDZFQVQybnpnRW8rR0JDSDlIU3l2YXJieEZYNmJnSEgrbXF4MVpH?=
 =?utf-8?B?THVCbVFnaXE2Zlp2VkJGZ0lJTksvK2ZnbWxhNmpKenlNdVFXM0dNMTJoTmY4?=
 =?utf-8?B?Q3h0VFd6SUMvSGZiRzRDUkNnazNIN1FvUzN2RTliV043d1lHejdpamsxb2c0?=
 =?utf-8?B?L3F5ODhXdVJla2N3LzJTMnN1TTZyeW50Mkx4VTBvT2NqM2xqMzdDUFZQN0RJ?=
 =?utf-8?B?TzZaeFE1NFBjNXh1eE52Z09VQ083TlpXYmRmV2ZVTmVvTG8ra3V6VmdGMGFJ?=
 =?utf-8?B?T05KZlZrVTRuM2hmbElMbGFJWGxvMlNyamVWL2dRNHFyQ09TMkUrZC9Mek5B?=
 =?utf-8?B?YVAraGhsQ3ZaRUtwL0xjNkhuY3p3NTBLTVBBU0hEYjV5Nzdsci8vVm9KcUZw?=
 =?utf-8?B?YXN6OEs5NTRJN1k2YjhVajJSUkNmbGZzbVhsN242WGNkMktzQ3N5V2M5dE04?=
 =?utf-8?B?My9qV0dobG9hNGhkQ2xYMUhxSTlDeDJTU3JJaUpPNjloV2RqWVN1OTQ4WHEz?=
 =?utf-8?B?SkVHdSthL25SamtlT21lMTYxeUNiSkI0WTBkdHJQVFB5UEtkcnEzTzI4MG91?=
 =?utf-8?B?ejVXaGtXN3c4L1NuSHVtbWo3ci90T0tkUzRCWmpEb2wzWnVqOUJkNDcwYW9H?=
 =?utf-8?B?ZGdhYTlua3lmSDRyN2x3MWtlWitPc2d0d1VyNXBjaC80K2NGT3pabStyNmdv?=
 =?utf-8?B?QzBJcE5Qa0N2S1M5bnM5cTY3TUltWnZIQUFTM0JXdDZuZ2NPYm9pV0pyL3VX?=
 =?utf-8?B?Mlh2MWpZbmhQM2g5dXJlY29Xb2tSL0JWcWxhRDlLb3lRSFQ3ekNYclNJd0pu?=
 =?utf-8?B?QzVxWkNlS3dzVVdXcWd1VW9YY0U2bVQ5dDlCTU5ZanVsYXZCMTRydz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa88704-66b3-4967-e570-08dee25a8a66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:19:23.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cemmj1NvRiuF/Cm0BtaBWJg1QJpgg6exhiBCBwf+K0qvtsl+vrbUmP0yeTfRvI6UkXwLer2JJkm/QHgU4CWy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7974

On 15.07.26 11:28, Tobias Schaffner wrote:
> Hi all,
> 
> This series introduces EVL test runs with additional stress applied via
> stress-ng, as well as long-term testing. Along the way, I also updated the
> long-term kernel under test from 6.12 to 6.18.
> 
> Please note:
>  * The clock-timer-periodic test currently fails as soon as stress is
>    applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
>    to address this.
>  * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
>    threshold with debugging disabled:
>    latency threshold is exceeded (150000 >= 163.951), aborting.
>    https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174

That is 150 ms?! Sounds like a real bug - unless we enforce some thermal
throttling on the hardware. But we haven't seen that with xenomai 3 so far.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
