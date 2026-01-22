Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4E3A7E11
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082990; cv=fail; b=bNp+ybxtnRjX4+ukAM7qvzTScOuQiBTgf1/EicItN9dmqZytuPalsvs7gYUOmgM/bgEJX1KjdYmamE1wb9oHiTkxuphcKeGKG08IN9YBCJUYp77jbtdhIrN3SzjjTJv9Kq+Ft1ulxCS0S4aoUrSwaI/9LGpvieKkbAfftDj2x80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082990; c=relaxed/simple;
	bh=yGc6vLs7djy5X9fJHtRCy50c04dNxw+HoOZy9OAvh5o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTJCtwOMjZVFXOthkYLMI1VJ/g7/3y6T1tm7eI8qjNk/DKpYeD6p7BItxLgaZulFyOxueWxBtJhvbCI4tJZPGiCb3SeKj1Hp7O8vNfjBSxcZNPYDYBp2hbKR0Kbc+kxdnDC+alL7+Onpix2jny0mUay8+uSd4+EXRbIkhbIypwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kO4hlPAX; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kO4hlPAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClibZMJXnD7JXlcE/FwYkIEzhvQwOxUbK7M2C/s6C81ZEckU0yTFtFvJMHNEHQlLuFfX+xlHCn/OSJMxgzid6iDjTwUd/60WJwlslzBY7FpyM97Yaj6kJ6yr7GeB7iqjtKGo/4pcrjPczZ6bmOaHnY84z9fW2b+YugbLLMH3WE+6j2g9vHeYbyKNg7nzcHUtwZvfvk5R54IZnSfVP4nb852+vUjW8szFH9LyS1GfsbxN7/DKIo5NQDG+qVIQ/eBfV/JOwH0yxD6RJfLaUQ6sdTmhYjki+J98HjLk3xrU+GGkjEgToe1ZSDdwv4yuyUBwKp4pkK6Px2klsl5Zk/VX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CwJrM2K9O427AhX9UXpMGgi9e9Dixnw1XF7PsiKV8Q=;
 b=Xz1qR99MfnxgiwjD8MrVCnWpvRzvyqgJExLHT/xL7gP58mKQxg12cRzh4Ri5H/VyvHFbrE7ic0qHGBBfa/CSpdGd0duGX/J0A9Pm+cOhJd1LkXwmHKkGIrgPMKtGV0YIbxTB+L4mTypTQBXjTnZxNZ8JwmHUzZ5DVj1p9g5kadG2qHZ5I/7ZeGHxPrNYAmg+muFR+DcTvHH3ypMQjD0AeWfYCxQV2Kq3I9gKIIKHFfgfXcZcipbTUKmebBIbXCtbnjpsFP1J9jsjk6FILl4kE8AaVfAvcjC1X3bHQZOFKl3VAo1zrIiZ0YYpqHvISPVFK26JIvR28Wbz9FdtuDF/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CwJrM2K9O427AhX9UXpMGgi9e9Dixnw1XF7PsiKV8Q=;
 b=kO4hlPAX85cdx8DogyrHtSlt5MHrHjR6+Sg6PGsV2+yxF7DkXukxE134hZuSNd8ob6BIbvCxS0xqHIfmFPDCCN8Bsoja3DaAhQE4Ad81JgJhmCtP6Z0v3HWJ1dd4OGe9RvadsTjCZ8CS5uAVRFrsi6fHGHl0XQc7elr1oQcbsMs0DE3RBLCyuv2PPKKHV+kI604B4qc7OcHuXRd8+/XIs+TujoC6Co3PhfItNjl5aTEeYExPgGtMN1lo2FrfgSs0cyzW5H6qRW3k+FCa2vevuLpX0wvkWDIAl2ldzJq/4c0zqxKtRNYkPHbVypc8gHqNlpzleqOru+E0kSmhU38SiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:442::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:56:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:56:23 +0000
Message-ID: <fb746056-3527-4ae9-8cf1-dfc946118fd9@siemens.com>
Date: Thu, 22 Jan 2026 12:56:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
 <c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
 <ec542b43-9ddb-4211-b3cf-73360c0441b3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ec542b43-9ddb-4211-b3cf-73360c0441b3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0291.eurprd07.prod.outlook.com
 (2603:10a6:800:130::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ec3cd-0872-4571-8645-08de59ad43a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFhJL00ybnY1ZHdQT0wyUU1GUm5pSjhsWUtJdmNyTDVlMXdiK1pXOVJBYVMy?=
 =?utf-8?B?SWR6dHh4dmxGc2ZrMkxEdTk2ckxkRVQ4VldwTVRKVzBpZjNZa3Q4MHdmNzUv?=
 =?utf-8?B?RjE0bmwrd2J2L3lua3RYM3IvUDVWd3MzQjZab3VTL2F4VzRHMEhrZS9ETDF4?=
 =?utf-8?B?dS9kT01zZGVuU1FUK1RxUXlmUG0xeHV1WURwZHZBeHd4UHRUUEJHTXZPK0JI?=
 =?utf-8?B?VHdZbTRFUnJUWmZUUld6dmoydW5uUURUamczbEdMMFZ4QkxKUFR6YmpyaE4y?=
 =?utf-8?B?NVhveWhQZ1RWYWRJVGZoNHhHc0VISzdwTmhRQTFTUE5NWmNLeUU4Y0ZMaUM2?=
 =?utf-8?B?MW9DZUh6cHhYTzVWT1JZZHVtSVNNcTk3bzBZaEppeDdrQTI4RCtCVEt1UEtJ?=
 =?utf-8?B?azZGVFNkRXdzMTZ5UTVzL3gzZE1hOU1qaVJ5dVZoUVdHZlJ6Njd4R3g0M1NQ?=
 =?utf-8?B?bkI0UVUzdVVYeWJsd0RqTmhmalhPS2NkTXhINlNSMkNpQkhaN2lvU2NxZUw0?=
 =?utf-8?B?QlRRdlVBY1gwZlg5WkVVaGlEZmQ4VGkxK2c2Qnc5VEtJc3d4QnVkdjFPeGcw?=
 =?utf-8?B?K1RvbjhkQUoxS2JFTDVXQUdWenMwYm5sbFNZMUNFMlYvTUM2UUl2Qkc3N0pT?=
 =?utf-8?B?SkdvNWJmLzZRSjF3SzYvckNySW1YenkwbVRVN2xiZENLZEtlMDA1bzBxYThI?=
 =?utf-8?B?N3FYRURHNzFSdktRUy83STFwZWt6a0x6RUVvQzgyeVlUcVF2dU0wdk10ZDgy?=
 =?utf-8?B?d3grTFB3a2c5Q3h1UTVRU092OXRTeFEvVDVMam9vQUV5T2t1Z3N3Z1hlbHFn?=
 =?utf-8?B?SkpidTZ1RlMxTkE2cSt6K21sM3Rta0k3eEdlQVpzalRqZmtHSi93b3Q1bTZk?=
 =?utf-8?B?VEJtbGpMTURDZDAxK1htNERDVUg3dWp0eVlvYjRsWi81d3ZMV28reEVnaTBk?=
 =?utf-8?B?bmVEaFZpL1VvaGEvOTExb21JQTA3VWx1S3VWOWpmZ0xsM3BldDNIVHdPbStp?=
 =?utf-8?B?ci9JV3ZKTCs1dmRHQ0x1a2IzT0RCRkJWRlplc1dFaFZSdHdRZ3UzNTBPbGRB?=
 =?utf-8?B?SnVkNlh1aHJTc0I3UlU1OE15bEF0Mnl2dldGdUtNcWpUbHV6RHEvN2NWOVZI?=
 =?utf-8?B?Z3hwZHFHRjFPbGUwanFEZXgwMUgvQkpGRE1DdHJicmYvNHFOMmRyNFd1Ym14?=
 =?utf-8?B?TVIyb1d1bFNoekdVQnBVRU9NQjlMYVdiLzJjb2NLWFB1YW13UEtVL3hQcmpL?=
 =?utf-8?B?aXQzZXdrbFh1eTluWkwzZTRuM0JtMmhOVXMyRUtVNllNclJYaVJURlhTMVhO?=
 =?utf-8?B?T2NoNkNxOGlhZnJFZGw2YXdtbFNCMTc2cENzNVZVSGtucGRSM2hCNHo0Mnhv?=
 =?utf-8?B?Tkp3TXNSdWVGU2x5eW01VlU1TXM1cnFSV2JjZGNpdXYvSjBtYlZ6d2UxVi9j?=
 =?utf-8?B?dDZhcmNzY256NlQ2OUdXdUkyd0YyckhnQzNUbHB2SG80S0x4UjFnaGlyOEtM?=
 =?utf-8?B?aUMvL3UvWnhETHg2MHh5aFkzc1dJdFhmSlNkaE9XVGRYRnBOUm9LbHcwV1pz?=
 =?utf-8?B?OEVtR1lXWXdwamxnbEx2VG1lZE43elZnYzJNRjZwZEd1K0lFVTRXTHZoZW4w?=
 =?utf-8?B?alVWY0d4dVArVUJjTXlYRTNzQ28wWml2SkFCRm9jRzFwaXRkS2RjTEdGUXJn?=
 =?utf-8?B?QmV4eC9rakhRQmhUeWhDSytKRXhody92UDZTQ05HY25sUlkvNnd3L2RidlRC?=
 =?utf-8?B?Rm8wSjY2NVU1Q0tJSVJ6RFpackF1KzZZdDBFYVdWekdOU3hyUXJrTzBCaFJt?=
 =?utf-8?B?MXFZL3NpVmVvdGJnUlo2eUozVUUweXlrYXRwNjBIMlJHWWlLN0RhK1RUaDI1?=
 =?utf-8?B?dVQ3VW02NVBZQXVZbXR4MmNxVk5yMjBYS3prL2NEdjM5a2tnUnNHTjZseTBZ?=
 =?utf-8?B?OTlkUlFxT0tEK1c1cXJEQkNEQXRrU0txRDFlS29pQktCaFNjUUVuQ3FnZzJF?=
 =?utf-8?B?blBXNHl0SE9OV25FdlA5LzNDWGhsY2hDb3F1TDNYaTM0R3BQUjJMMGpRdHVD?=
 =?utf-8?B?Qm9JVHRvd1o1WkJUSmxZNnVKVis1eWZkZkU5aXFsR200bXJtdlVOdnlOVE93?=
 =?utf-8?Q?jtpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21aa1RqQnB5eUpvSWwxNGluUXRYRlFzeHZmZW15TzRQdGQwaTdpU0pSOFdh?=
 =?utf-8?B?dGtPSzQxb3R4WCs3cTNFcGZRWC93MENsYmFUU3M5V3NmeGJOd0VqZDhESmt6?=
 =?utf-8?B?VUtEdzFHRnI2OUV4YlgzdXNzQms1bnBXTERIeGdnb2FYeGNOKzFaOHhCSVMx?=
 =?utf-8?B?WVdtclRkTkZRYlZ1Q0pmbkQ0dDZ3aXFUVWpvU0xSNlRJclFDRTFSR2JQelBi?=
 =?utf-8?B?c0k2ZmJ1T3VwR3VkY3daeDJ2Sk43U3JiVDB6YWY0NWRiL1B6dDZzMkxxTW5k?=
 =?utf-8?B?UDdVMU9PeXJEbG5Lc0xCaEdpcGFSL0J3dVR6TFA4MDlSN2FFcmE0K1lmdXA4?=
 =?utf-8?B?OGdna25qVDNqNlY5MTJCUnJCdTViMlRMbmJsYVpuZU02SHFtd3Z3SWlQZG1w?=
 =?utf-8?B?TnlhbEE4RnNjbVdPVWtDek1zWmhselB1YWw3MkpmeXpEUFk4UExjYUVIZnJR?=
 =?utf-8?B?ei9CSE5UdzM0NkRaWEFjTWVkeFVoZ2s5RHZRdVM1VTBNWSsvWGQ5Uzdubk9C?=
 =?utf-8?B?Umo1M3B3MFpxbzJzODhFYWZCU2E3NDFBQXRuR0R6U2lkVk5YbHY5VDFHb01i?=
 =?utf-8?B?Q0hoQUFzRi9YN0dEYmZmYW9iTGl1dC9IZHBSNUxvUmRqKzdCSmluT01MMHBU?=
 =?utf-8?B?N2lhd1o4Yno1Qkxzdk54TGtueWx3MmJPeFFKSmgvVHFNMDUvYWlBRG9MT0t6?=
 =?utf-8?B?NjV1L2NNSWNKUkxleXJzQTBhYWJTdzZBM0ZuaHJJU255dXA4NEJUNWQvZVpq?=
 =?utf-8?B?cm1WUXJWZThWb2RCUXFTWGdoenRoRVlqSFE5cVBEU1hwT3ZxTGc2ams5SkZK?=
 =?utf-8?B?cmkvcXBjUytMNHV2OUgzWTk5Z2NORzBvdU43QXN3akRURDUyL0dKUlJhN2Zr?=
 =?utf-8?B?RjQ0QzcvOHFQeUdqT3NVOU9YME4wdlA0NjdxaGE2QVdOT0l6SWR4dFdmN0dS?=
 =?utf-8?B?R2dLYisxV2xXa2ZnWUlWUmtiSWpSL1VaQW1Pa1hUb081K0RuUE5SNEcva2hx?=
 =?utf-8?B?NTliSU5hNkYweGxIVnFqSGM5bkZRbTFZZWd0SXU0TmxXK0Y2bVo1azFZcFls?=
 =?utf-8?B?aFd4U1V1UWVNZXJsWHhpRnBJTzNUVDRGekRvKzg5b09zd0lHaFk5N3UwWkl4?=
 =?utf-8?B?d2dMR2dsb1I2TDJ4ajVXZXZROWYwcHFTc3QySllDUit3VEJ5U3QyT251U2to?=
 =?utf-8?B?ekdYRjBUWlJaS1R2ZDR0VzlTL08xcUpDSDB6SVM2L1FJUUVobnZKeDQzYVlz?=
 =?utf-8?B?cDBNSTAwL0djamtWbjdRcXNFRVVOZ1BqcWJzL29VbzlMQkpSK1V0MHZoRDNm?=
 =?utf-8?B?KzRTNDArOFB1bjZJR0tWOVpIUVlFaDUyYzJsSDM1bFV4KzQvcnV4a2tZcm5U?=
 =?utf-8?B?RzQ4YU9uYThjcVo4RTNPUWZOQjEyK0dtTGcxQ1lGb2V0K3dHUTVsUE92Qzlq?=
 =?utf-8?B?SWdhK3REUkpyWGRqc2hjMjJIMmMvTXExRkNqS2dhRXhhQzNhUGRFNSs5TFRo?=
 =?utf-8?B?QjZjZkdHUEhTd0FsTnI5R1BuRnVLQVJCN3NjU01uWXpWUjd6MkV4YnFaTWdV?=
 =?utf-8?B?dlpoMklXUU5icUswUGFkMEc5WjF2cUlFVWM2Z3VyTDRoekwzRHVjQWJyaDJ3?=
 =?utf-8?B?cGhpayt2eWJqMkpFejR2VFBENlpNckxuM3V0eHBKM3E0S3dHNzc4ZjRMb0Vl?=
 =?utf-8?B?cWRUS1VTTHpTczdjd2ZqTVJEM0tFbC95TXNsaVdzdVZlKzJQSmhLWS80TlFG?=
 =?utf-8?B?RWUraFo0aDhTajlJKzc1YXRhZVlNcHBjWFRwODBYaHdCYk9yQ2hvV2NUdlRo?=
 =?utf-8?B?YmtDUkVNVjgxV0hvSXFzSFB3QlpLdTNWZFhSRjdKZEcrRTRIdnB6QjZsL1hn?=
 =?utf-8?B?U0pkenRWL0ppRzZ1R3FHeFZYbG1NVmlQMnVMeEVvcUtiaXdkQnErMFo0d3J6?=
 =?utf-8?B?akVOTUFMUDd6K1E2aUtGay9EZVlCak5BNHNpZ1YxS3Z4SXpmWDNkTzBVUkpJ?=
 =?utf-8?B?R1pHQjRWVnhtZXIvN0pKUFFhUEppWm5rVms4aUJMMU8xVUIzdmI0Qm05aCts?=
 =?utf-8?B?alkyK3lWanZSZ2hhZERSdUZzRXppNThxeEh6bXNuQldielpkS2N1TlUrQXp1?=
 =?utf-8?B?bllmb1pGM3Q1Nk5UVUVpSW4vMyt1R29neklBQnpIUmFOTE1HQlNVeFZZcEFs?=
 =?utf-8?B?WVFVR3RxZFR2YlJzOTR3a2gxYlNOdjVkSTdFVTRTR0hjc2dkQUFuVE9vSDBl?=
 =?utf-8?B?R2QvMmcxMDZaR3JQZmFpdjAxSEpUKzlwQTZBTW9WcytIbm1kZkRMSlQ1dEE5?=
 =?utf-8?B?b2RoRjB5YmJ2U3R4SjFUUjdXN2ptNjEySnljRXJvb0M2VXNndEdyMjRKSEo3?=
 =?utf-8?Q?8mDj/to1F0bMvnYM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ec3cd-0872-4571-8645-08de59ad43a8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:56:23.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U/XcQqV4kNALGQdlaW9kr7O5jIxbQ/9VWlLbQxCBRhETu1BSCji1vVhYbQRBCEkV3q4HYnAnKl6zS20LFA4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7119

On 22.01.26 12:09, Tobias Schaffner wrote:
> 
> 
> On 1/22/26 11:46, Jan Kiszka wrote:
>> On 22.01.26 11:39, Tobias Schaffner wrote:
>>> Run the EVL test suite for some first smoke tests.
>>>
>>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>>> the moment this is used to disable scheduling quota tests that fail on
>>> virtual targets.
>>
>> And why do we disable them?
> 
> We only disable them on virtual targets not on physical ones.
> 

That is likely also the answer to my question below, right? I missed the
"...on virtual targets" on first read.

> These tests are expected to be unreliable with a virtualization layer in
> between possibly causing delays aren't they?

So, the evl testsuite is missing something like a --vm switch to relax
timing tests? Would it make sense to add that so that at least the
functional aspects of those tests are kept?

Jan

> 
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   ci/gitlab-ci-base.yml | 5 +----
>>>   ci/xenomai_4_next.yml | 1 +
>>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>> index 186d1cb..76e38e6 100644
>>> --- a/ci/gitlab-ci-base.yml
>>> +++ b/ci/gitlab-ci-base.yml
>>> @@ -107,8 +107,6 @@ default:
>>>           - report.xml
>>>       expire_in: 1 week
>>>     rules:
>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>> -      when: never
>>>       - if: '$LAVA_TESTS_ENABLED == "true"'
>>>     .test-qemu:
>>> @@ -116,9 +114,8 @@ default:
>>>     variables:
>>>       ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>>       ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>>> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|
>>> sched-tp-overrun"
>>
>> Why set this variable here, rather than close to its use?
>>
>>>     rules:
>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>> -      when: never
>>>       - if: '$LAVA_TESTS_ENABLED != "true"'
>>>         when: never
>>>       - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>>> index 30ca9b1..03dc233 100644
>>> --- a/ci/xenomai_4_next.yml
>>> +++ b/ci/xenomai_4_next.yml
>>> @@ -20,3 +20,4 @@ variables:
>>>     KERNEL_VERSION_WITH_QEMU: "6.12"
>>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>>     CACHE_KERNEL: evl
>>> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev
>>> \"${EVL_TESTS_SKIP_PATTERN}\")"
>>
>> Jan
>>
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
