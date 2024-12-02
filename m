Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0B17E
	for <xenomai@lists.linux.dev>; Mon,  2 Dec 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140428; cv=fail; b=YhcsQ/cM25D7ceDYfL3GrovxjvRxFTI9T0xXbbBhVw0AToprmSdW0Mh7ppWI0r9A3CL8I1LRX3nkuaypuh5yTBUbwdGzN4zEvqHQVHLMR67oTDnsplz7lJ2hR1SfUI1cyI7ZM5850j2JC3JBqDTuWsdAEYzL9sq3voWSKVjXnQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140428; c=relaxed/simple;
	bh=TIfOf3ezDeyJ5cJ0kNhCqeNLHSB6vzVTigUKHZBcCkA=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=WaDE+xMhYo+xx7ZDLTodDxuq69tUcrZXe/5JHp9mTLDvHiCrN/yE1PPNZaRq5cBhyiuSmVvJn18fJt6vlRso6cLOO3w+WCxtaRAq2UcE3dLKyFyWW0/bXHQ3OyGVli1VK/4L4hguhkm5DO72v0WQ3JKRWUZE5qxx0iiwRMEQPA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w2IDFZok; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w2IDFZok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r51rzTaFCA5HY0shbWK6cXOZSBoAwuyWyGPjSQ1JTu6KcrS6J1XCEE2uu0ta7UZlu5zdUm1aa6mu/AZkuwPqrER5dGoEqTL0gKx4bAzz5p95qSwE2IxUmVAEDsjQHjRACQcED7jNulmcwOl8IM9DlBAm4xFqkUm5AK3kCSwE4OMs3swgvcfO8wy3PFzTExUpTZ7lN3AVqoppMsiPzlEVht7UferULTysEQqeChndfVR3hknC0jmF2OFubkW6ANe+52NwC6F/TFzvnCeXZWNtWH3VvanY2ofM1HnX3EIIJVqbdzWXXwO/xm/trw1yL5B6VsC2kVNoYPMbmr1m9r/+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wIRb95bSUQseeuJxAwEX0yMe2KLs0YiEG7Qzupy8c8=;
 b=k5J5G+KuQ+ca9U4QupTWe3FmNRHmd2VZ7FBnZysDDpOEOZH8eWiqYdAy189oH02yallpBQJX/Xari2fX8VIStqnwoGjIybmnY/9tXC0Fi6uK68F/CBfTpAAlFyTQmdXI9fmxlYxwBZpq98eZts/slV630imoxVh0Rua5vOQOb0UnOo4ezWHjswPcUAzGSuhBNLJpU7nSDH5RywMebyDa746OKkL+TRBS7dQt48F4VoRoIW5ymY09sFv6emo/I7OqklQTSszCqNKcC1vErvXuU1o5EcXmpS9eYuoZ1/fTGDeRy7pw6TgXcGPWxPdRD4iFt7KeQ9U0US3x29u7f9F0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wIRb95bSUQseeuJxAwEX0yMe2KLs0YiEG7Qzupy8c8=;
 b=w2IDFZokFy45ng9sbIqELJY1fV8G0VRjQB6ha07XxVRjWWGxzcxgakZ8s8qg6kWtGZbLaJcoFR0dzORz1eIr6n+SzJ8OXsMIcnjpqbNibT/hGE5PixvROAWiUC2bVFhcU6fT64STcl/gax0tEL5T6bzZz9L4sYVxMvOIePSHtkkFwQJHENjVv1Lt8zL6nXB6QPlAe3khVd9iaq6SbrbpD5vKt/ua0F670hD2Qb+MlGx1b9qERQ3JLI7ddp81rvCMcGxt3cDPy36b/SmlJX/3/6Cq3v4K1GfozgX6DzS9fDUov0/WZI+uJGjXrUOaCtfNR1qJRGpJo9St6KAfwGWBzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Mon, 2 Dec
 2024 11:53:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Mon, 2 Dec 2024
 11:53:43 +0000
Message-ID: <76a58ce2-6848-41e6-b22d-b8c1d8a4ec4a@siemens.com>
Date: Mon, 2 Dec 2024 12:53:42 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] linux-xenomai-3: Switch latest 5.10 to cip
 branch
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0062.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 684ca7e3-18da-4f31-90ec-08dd12c7f86e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXV2d3puUnFLN1YvaWxiOGRnMmxxQUdLd01jeUx2UWM4cUI3dk5tbXY2b0I4?=
 =?utf-8?B?emE2cGp4cmVrNHRHQjIzaGlKenF6UFpMQ1FVZWNoMjBDUHRFK25sQ2RIaSt6?=
 =?utf-8?B?QlhyYUhRYnlhV0FLWE9hNm5CNlgwaHdLeGU0ckVKOTl3bUcwVnhPNStmNVhX?=
 =?utf-8?B?Q2dwb0RYdXFOZThDL0VBRFpucVllRUFJRDY3clV6K2dLM3VwMUFxTTV2NGo0?=
 =?utf-8?B?L2VqbFpQS3F1dFppZzdsd3drbUdGU2R4SjVlNllFOHo5cmJBMkdkblUzRTZ6?=
 =?utf-8?B?ME1mU2RsdU1vMkNSSE9JL3BIdi8xbS8yVzVIS0lvelVZQ1NsdDk0RzlNUnNr?=
 =?utf-8?B?dklDbzdFL29ucVZTbjBqQ1NraUpxZWlQeE1ZQlZtSXlnRmNQbVBTY0hHakl2?=
 =?utf-8?B?TWQ1MUZaa0NyVXlIRXo5VTA2N0Q2d21pbnJBZEg4VEpCNjZBUGN4ZVhsY3VO?=
 =?utf-8?B?RWV0QjlEeXhXajhTYkVpM1g4R1Z3ZE40WDFRVm9BLzB2UU80Tm9FNysyYmJD?=
 =?utf-8?B?M1JHZTJFU1pjaWtJQktyaWdyYzRkTnkwUEhkbWY2a05NN0lpa3FPUFJXM3Jr?=
 =?utf-8?B?TWJ1a3BtM2JRL2ZzaE90Ri8xNEo5NjVVZVZNZkV3OXI2YkN5eVRyRGFJTUNV?=
 =?utf-8?B?cTh6U3loQ1M4TWs2UVRpdVgrZWxOdFUyd2R6Tm9SRXV5QjhtY1dxT1MyOWEr?=
 =?utf-8?B?TEw0R0hIQzE3dHJhWlpIb0dnS0Y3OTdXeFd5bjdIZWRDSDVQc1N5Q09tdTIw?=
 =?utf-8?B?WXJZYkpzZEtmVHVLa2xmakFDU1BHZzdxMVpkT0ZuYk0yWURMWmFpYWhLNWxD?=
 =?utf-8?B?bzcwaG5oOVZPYTF4c1VDTFlOOHRKT0VXZ1ZZRkNlcU5ib3gza09iTG9OSFlI?=
 =?utf-8?B?Q2lyMjlQNWhIczhNbjVGdC9WWVBCU3JGd1VyWlpmSDdOVi9sY09rd0pYREN3?=
 =?utf-8?B?SVFqZ29KcTVwY05vS050K1NNdEZLZm51dUUzckR2NHBBR1Mxa2FUQnk1VEtF?=
 =?utf-8?B?eXNpTDJiRVlCOVF5ekE1bEIzRUdyZ2pRUm90UEpLcDdXQWR3WGUwMS9WbmlI?=
 =?utf-8?B?UXg1MTJYUTlzTlVON2hMMkNjVllxRjR4bDRZaSs1NSswT1hSeGF6Rk9NNHd5?=
 =?utf-8?B?TDZyNy95REhvdGlqcjk4cGVmajgwVzVwOVhBdys0UDlTWlRiREdoc0JNbmtZ?=
 =?utf-8?B?K1NDYnZ5ZlpwcSt3NVEvYkVESmdoSFFyMTZ5aHBYZ0ZqY1I1QmRqVG1yQTd4?=
 =?utf-8?B?UmV3ZUprZjNzV3hFMlJhNUU4eWVHaEluaVVBbmtrNUtSWXVyYUpYT2x1Q2Vs?=
 =?utf-8?B?V1RMY3pQeFNzUWZjNTdIUE83RXVaQ1E2Q21YVHdIQVJXV0d0L2JDN0RSY2tU?=
 =?utf-8?B?ZUNwNVR6bVFJYndWWmJqcTNwWWlsdUVJbU5DRHVKKzR6dWhLL3Q3QlJ5blFz?=
 =?utf-8?B?U1VjTHIxdkdjK1ptRmgrcUhuQk1rVkFjY2I0TU5vWHlYN2tIYU1qSWJtVjkv?=
 =?utf-8?B?S2p5RmNsMkdXTGZsRDMwZGdPUzRMNlR6V3VkWWFaVlFGNkZ3MVJnS09qWmVr?=
 =?utf-8?B?dS9UYjJXQnJONVNVeDhQQVNSMmM2NTM3RXg0S2IrS0RwOE5IYUJqYkJ5UHg1?=
 =?utf-8?B?c3d5SWRrNFdoRXNITlJxMjM1cktxNmFxUlBQUUcwMWEzSDJ0cnNraVlzdk5n?=
 =?utf-8?B?OG9BWU9GR2E3TUh3NmROZi9wRlFLRHNRMnZ6SUJhaWhKcFRLSXVhU291aXBK?=
 =?utf-8?B?M01tQ20zM2lIcU9naXk4R21iSG45bXpuYVR2YitwS0FFTmppVElJMHJPaWl4?=
 =?utf-8?B?MHpTVlM1YjczdTRtZGowZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amk1VUFoWnA5SFI4bHFtL3RBbDllZlZ1RUFLSTJDVHFRL0RoN2xaWkM4OTB4?=
 =?utf-8?B?dyttaUNrVzFndFpFcVB4bXhzZFNubkZycGxxSDFrQmNvZlg3djlJUXRwMmFO?=
 =?utf-8?B?MzB3RHM4VEMzTmd4K2dXUG5Yd3puQ3A2QXpzK1BXakV5U1ZYK0lwK3REVlJk?=
 =?utf-8?B?S0hranRzQVhXaHpDNDNaSmtMS1ZrMlVpSHhLWnZFYmxFRHNYSmQ4OGpTbG1a?=
 =?utf-8?B?VGxjVnhDUlpLSEgrZWM3V1FiL2hYa0l5R2g2OHpYc1NmcW1NeXBQM0N1NVNY?=
 =?utf-8?B?R09GVUJqTFYxZDRva05jM2pqM3pSR2twUjBoTUtvNHFzUjZtMFJ1R2dYcXRl?=
 =?utf-8?B?eHZXVFA5UjhrUGtqdUdiWmc0RkE5QWZ0Q1NaeGVlUnFHV0xzWnFMMlV5eUJM?=
 =?utf-8?B?bjRQY2psbWdhaXg2U2RUdzlHK0kxL2U2RlBEMWJSRTkycmM4ZVZQRUtwQUw1?=
 =?utf-8?B?QWJ1dXBsS2JUQUxVS1c4UG5sZkcrVUFVTVBmY3NpYjFsRVkrYUFFc2R5ODRK?=
 =?utf-8?B?RmQ3RXY3OTdVeHFvNUVIZXN4czZSdGs5MVZZaHdOQ3NlbWg4Wk1xNUt3ZzBW?=
 =?utf-8?B?OFUyOTZnVjZtZEVDNm9pbHc0MThucnpZdDV2d0tLd2wwNkVHdzAwUXBIY2x3?=
 =?utf-8?B?WVI2Vm1SUCs1dDFhTkdBVitnNDJZVUhsUDV6cWdsYzJoTEFkQnYvNExyWURF?=
 =?utf-8?B?OVEzdmt3d0NBUXcrV3l5TmZ1RHdUZ2hNYzh5NFA3a3lqS3U0NnZIZ0IrT3pT?=
 =?utf-8?B?QnpyMXdNSW1COVZFOGNiTEJ5NXhabmlsUEdhN0dtdGhscis1ckhjN0QvaGwx?=
 =?utf-8?B?SUI1Ylg1ejYra2hpdC9Va3BpbzhIMm82OTI5aGNQWVlzY0p5QlM3QXBIV1Nj?=
 =?utf-8?B?ODNNYnYwN1MzWkVpdWQ2NEJ6eGR1aXpXOG9FRURIZlJiZ09qZllaT1VSV3JD?=
 =?utf-8?B?dGVEVDM1SXNjZUdVVVBNRWUyU1ZIRXVzUjAwUTJ3ci9mc2QxUzBOQTZXQ1Ex?=
 =?utf-8?B?c3NVT3UwSHhsTWowWVZqVjhldUZ1QlFDdGtLdFNHVEw2NUFKRTFIS0x5K0lT?=
 =?utf-8?B?amhBVExlekZDWGdESkE1YVE2Umt3cFd2Ui9DWjBOT3hURFRobWpxeEI0dkNW?=
 =?utf-8?B?cEFOczlXcXZJT2tSOXc3a2UvL1pLeUsrV25PcE9TZzJXUXlRakhmcFByK2hq?=
 =?utf-8?B?R3J6V1pYdXlRKzJpNTVhbW1rNHJJS3Y4Ty9XQUFWUEFtQkxhVUlLRXRxeHFp?=
 =?utf-8?B?OFpxV1MyYTRsaTYwd1ZEV3A4WU45MzFUQmxTT1M2NjJnZ2wyd0owSk5adEdw?=
 =?utf-8?B?NXZFOVVoK3Z0dHZWbm1GUXFKN2w3d2szeTJIcElkNUMxbUUwSVZESFdMUWJV?=
 =?utf-8?B?Y3hxVGcrV01xQWhwc3UzZnRXSUMzZW0xc296OGxpVUNMbU5VMVozSFZNZVVh?=
 =?utf-8?B?UVVsaWFqLy9lTmRaL0IxbXJiTWRmL096aHRHYjNLWXFmY3BXSXh6Q04wOWMx?=
 =?utf-8?B?L05BYzFwaTVZOTZxclNON2RoTjRocW5qOVN4ZnE0VGcvL2hvSVhiaEUzQjR0?=
 =?utf-8?B?ck9xY3JoT0Vsc2U2YS9YQzVFTkZlN1lDbjF3alQvZWFtSHFZaVNKakNtVU42?=
 =?utf-8?B?a3RFcE40RjM2bk1ORjkyMEdFWk44SEtic0haSnBOT1poU0t3RGVyVnRadFEr?=
 =?utf-8?B?YzdLN1Nvb2xpRzI1UlJZWmNsaTNiTXIzRk9ocmxPY3FSTEVENWoyOTFJZzI0?=
 =?utf-8?B?QktzM0J5NURTNnQ0UVo5d2FjeFRnSzgxSmx0TUUwcmh5QXFrYlFJaGJrUlM4?=
 =?utf-8?B?SlVFUEl1Q1JzMEJEeWRUZlFOL1JyL0QrdkZQbHhJenRXd0FoSXd4cFlCMGUx?=
 =?utf-8?B?TEVRVmxKOWNRQXZCdlkraGtyTzI3WWQyRFB5TGd3aVFOWEVGdXUrUDBjMGxM?=
 =?utf-8?B?YUpWZVJrVnZkU1ExT1FXdmhnbG9nbHZad1hya2NFWk45Qk85WUdMRHlMa0JJ?=
 =?utf-8?B?S1M4TVZaUHB5VkdQc1l3QnBXbmJXWVNDcXVwN3FXcmNUbGRqTWY1ajMxbm5I?=
 =?utf-8?B?TEkvQkFwQnJRNUhISTNwcmlGZmk4cFNxekcyY3duUDdQaThFeDFqZEZNbHRK?=
 =?utf-8?B?MU9FT0RTZm9aWjN0aXlEb3lHYWE3NEtod2VKZkVWT2xUYWdqSTQzVldGMUI4?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684ca7e3-18da-4f31-90ec-08dd12c7f86e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:53:43.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/mI/pmeFABg9NEDt6DJwTaxgCQdFvc+iNjdFOOuPXMomD9bS3tjck3VSuZXJA7UZ9XbOo5yTOjgYxmtPzzETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6903

From: Jan Kiszka <jan.kiszka@siemens.com>

Maintenance for 5.10 will continue over the CIP kernel now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index c65c28d..ab13897 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -44,7 +44,7 @@ GIT_BRANCH = "${@ \
     'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
     else 'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
@@ -58,7 +58,7 @@ GIT_BRANCH:armhf = "${@ \
     'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
     else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
@@ -70,7 +70,7 @@ GIT_REPO:arm64 = "${@ \
 GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
-    else 'v5.10.y-dovetail-rebase' if is_kernel(d, '5.10') \
+    else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.6.y-dovetail-rebase' if is_kernel(d, '6.6') \
-- 
2.43.0
