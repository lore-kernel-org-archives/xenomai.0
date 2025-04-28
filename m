Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701931C84D6
	for <xenomai@lists.linux.dev>; Mon, 28 Apr 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824958; cv=fail; b=XwWW1V7C9VUUplS8GDhJeQgMFE4jNBXLw/BtTzuts4o4HJfr2gR/CcE3U/47c4YbTBZk4+CwTNS//WM7EKwk72TGIkVH19V/i4kpzUbEmtyJbhwgwNPC6+vOU5dA+kDYlIwH82GKrLan9WefzYSZt23JX1FtozYyffK75ALsdHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824958; c=relaxed/simple;
	bh=TwxxZCRDKe5bumheO3Up3Rk197w6f9JHGh7zXnuHXlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YseZhGYtUSXzfa3iysCtvNbL5GimasQ/lkwQ1XDpn3Y7ffeYJxwUnROhg7COwuhHqL3CV+zTWXaJeknQpwP4H0tV8+kdq60o4Ob26Rcua0SHYI4eXkG/tRjeRsYPYi2WRSOTCDVBNTxgiPvTai4RYx37ISAdcp28lhJJpLC3FV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FUSoqcrV; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FUSoqcrV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cClR2yFqJMHt1OzpXe4BVpi4G4iWf1oRm/kzk/MaG9B62kOMN8G6X6tcQDB9DWFOfwyEx6Of5zwqwO/VViGetIV/BNG4wRe8WqsDMPYNeWz5P7mStzzU9urKW/8apYoojRFoLLwSe0uT4xmynvSqXW5L/NCPePej5FdazedqYNHCdPanJ6fvoMGEzYblQcWqOni8rzq5pUxUj2R54bKFGEC1SKY+W6gaAJ1ModMNWJXeeselzhEpXyfGQQ6i2BS1iqTQpUbxVRB2vcCERYMXsNw6dbr8nNsLzN1UERIPGho2eX7qwiY01N5NRZAN/xLvoCRCm4yO8uBsJ9+yYTdBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlpozEgjrgMP1sfrbzvZcZj8wC1vXJy6OnAxcKrGVdw=;
 b=exoSi8GXNhag8vh4YQtE1vyXSLUihmfw/LvkpHthUIHklkjh8WIdVD+joUGm7xoF635qpJuKQVvcbUtmzDSr0bfKER2X1dVuQZ9kaVdqvqdGAfLwujNM9IaRv97wIZsusRwbdksq+gNs5h0B0hVCK1TOjnfcOio5w+nHz71lVYBLwDt6QzKuBxYmrF1IyevfeRodcyG3mvp5Ii6XNYbJuUNto4bMz+M8l/PfIFBM5VCz/vdCnoAOS89gzZmRStPXvLKGSYulrXu9h7U4kjVkMGEIJeUudGjEp5OBcMfIhOu3bFl974viotMkVcdd5i+3wa3X4PhEoaEGwvZcrFJNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlpozEgjrgMP1sfrbzvZcZj8wC1vXJy6OnAxcKrGVdw=;
 b=FUSoqcrV8q94TQEKrs/QZfbp5Em/T5xZscc5lIr/T9rSk5UySNHEdl/8R4mqbaBTgQwNtA/0YXxTVS9h8XO9ExHHs08nTnFOgdKKYeMTrLu8IdZF54t1C8Zf4tLjNHd3W6iTj+DU5yt51tQd9FS2Kc/NFKv/M7XLOZdRTFgMPF/l+JmTCP1M7ZCkFKkOuEgPueSFVd1xlx/4P9PPr26/nbM2i1iD71+l38wXpZ2nB2wuxxJKqAQ+gfzmLzRgIbGtpfAiwcIbR1ZMcmhD6NJwcQsHpfe4icAFXrzzogis3cMz38CZdSwPtrf0eyzVahuBsexbtryc6ePrQ63PhJGrvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:22:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:22:31 +0000
Message-ID: <356d1791-2c42-419d-becc-76ab8da73d70@siemens.com>
Date: Mon, 28 Apr 2025 09:22:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: Add watchdog_timeout param for Cobalt kernel
To: Haiyang He <aspirestro@163.com>
Cc: xenomai@lists.linux.dev
References: <20250426021511.2349657-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250426021511.2349657-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d3da9f-27bc-481a-88f8-08dd8625705d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEVsOWh4NUlwelppYzAvSmdVUnVRcjI3ZTVXZExsRE1oOWU5bGNMVTEySmNX?=
 =?utf-8?B?SmRUeUw0RWl5Z0ZISFY0Sk9KYjlmNS9VWkhUZ2lSanNlZGJBMDVxUVNkMldB?=
 =?utf-8?B?WUZwbXNwcjhXVW1VUFY4RmhKLytPa2MxTHRvbHA3cWw1MG9RTVJRT0VUVUpH?=
 =?utf-8?B?dS83K0JOdWw4OTdua3pkQ1dZSEVETk52TUNheHgwUmF6QzBITkw4bmt2S1Jw?=
 =?utf-8?B?Sm1hV3kwQ0FNUGVOU2FNQVR1bXBlYzgxYUdLbGZPaU5ObTdTU0x4RlRUdDFH?=
 =?utf-8?B?RWlPOWRiMUF2UFk2K2g0aERZaWJoaTNuRHgyR3B2Z3RIYmxRMFlIcy9IeW5R?=
 =?utf-8?B?a21Gb1ZaYlg2N0JraUxnVEhEOG9VclMwU05uWWMxTjd4WmtEc2xNTDNBS3Fr?=
 =?utf-8?B?VFRoc1QwMmFRM3BIK0RySG5JMDBpQ0ErUEpCRXhLN0dFNmdPQWdIaThhNFpK?=
 =?utf-8?B?cjVRTis0bWM3dWZRaHJ5MEJKalF1LzNKOEYwS25XMVBMSy9LRnZweW0rOUJ0?=
 =?utf-8?B?Z2Fza2dMNmQ3eS9zV3BzRXVMUjZFQnVlS3pxMnlCVmlNUXBidHVwLy9IYkw0?=
 =?utf-8?B?a08rYnpMbUt5L3BwSkllbXV6QmxQQ0t1RDlPUFlVVTBtUnp4ZVQwNkIyZ2hG?=
 =?utf-8?B?WEhuaWVYbjBjV0w3VjBTeHg1ZmlpbGJTVWhxTUNpeS8xSTRwbnM4SHR5MjJP?=
 =?utf-8?B?QnZtZTdnU29reG5FZEtPeVpzQXV1cjNEaWhwNHlRVWlEeUFzYmNqM2twZ0h4?=
 =?utf-8?B?VUxnb21tZG1RMWVtZkIvbnc3K1hZYlQ5N1RxNHB3QndLTEpyR2lzUXFHTGc1?=
 =?utf-8?B?SnhMaUswbzEvcmtzc2F1amJiU2QwVDVzdVB4aWt5Q0RkWmEvSUNFTVZvZ3Fh?=
 =?utf-8?B?Y0RCd3UyMnNJZGRRa1lKWjRVWU9xNkVzdzI2VXh2Y2tpbm5CSVQ0VTBIWFFB?=
 =?utf-8?B?VEt0VGJLWGgxNkVReTFYUGZXQllEdi8rY1pHemZiWDJFYzF2bFQvZzJEdlpr?=
 =?utf-8?B?Z1M3SGttR3NiMElGWngzYTg3UWhKdmI5L3cvK1pTbVJsRmZpY0FGcGFGQVBB?=
 =?utf-8?B?bXduWnhZaVFqSXR0RE5KWjhyckFqZU1xOWZianlyRUtnZTdFSlllNXAyVlBY?=
 =?utf-8?B?WjBnMENybDd6S1h5S3h0Q2QyUUZpcENSM095SWJtY0JCRGpWOUs1VE95UFRU?=
 =?utf-8?B?RjZOUGlUL1dUL2FhNFlyanNyMGV3QWxuWUhKSTFVbWM2eVVMWTgrbnRicEFQ?=
 =?utf-8?B?eWxETVRQSGtJVE4zaEkxY0dkUXo3eVduL0Q5S3JxWEVGVnRPSUNEbWhEcFJv?=
 =?utf-8?B?SlhvS2FFWVYzcEVvQVp5aUhEb3lEWVZ6ak9DREFkWGc3NS8rZ05reHhFUWZ2?=
 =?utf-8?B?SjB5UlZQWnpmVXBCNUd1UDRCWXo0UnRiM1BKRldVbEh0emgzREV5S1VXUVBu?=
 =?utf-8?B?U2ZSNE4rY2VxTkpYMzZ1Vyt2OUpaZm9BUmpXODdkODFLaGZBZTBqa1AzYkJr?=
 =?utf-8?B?TTdFb1lFMkVZdzF0NFVTVTE5dUtVdlEvQ0l4VnBpLzF6LzVlTjluZmVsZ21C?=
 =?utf-8?B?Mkl6YlN1TW5oRFRtQ1Yzd3RlbXh4UVV5ckN3RHdWeTVudFczYlNBQzZ4SGpr?=
 =?utf-8?B?ZFg4L2gyM2o3cEdpQkFPOFd4SitQWmdrUG5iTTI0SUErTVhvQ0NlQkVjalg3?=
 =?utf-8?B?S0RXL0lFNVI0YjdoS2hpZksxOU4zT2dEOGFMTE40dUFWOE9EYm55VXZ0RlRO?=
 =?utf-8?B?b1lpRitXV09FVytQZzQ0ckQ1RWVHcE9ScnFieXdUa2pDRnlLVXYvYmlCL0Jt?=
 =?utf-8?B?bTAxNDNPZ0wrUzIyQ1ZYa1I4MSs4S2ZZRkJPM3FzSUtHZzBLQWhldUFyZlM4?=
 =?utf-8?B?UXJEZWR1ODJKdkkxb3A1TG5SNTA0dldmcW40dmxnbUFrcG15UzdwSEh2UnVC?=
 =?utf-8?Q?S3pnGBCBYKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnVDUnhRNkRHYThtdjEzdkxiRHpGekZsSmgwU2NnMU9SNjlYSVZhZTl0TW5N?=
 =?utf-8?B?UWNGTUNDSDFHUmpHU1dwaGFLelZkRmxmYUFOSDhlZWl6OVZJY0FsVGIvZE9K?=
 =?utf-8?B?UHZVTkdiM214Q20xSGYwcWluUGMrUWwxOVRjSWJtaGk5WmhVMERkMWd6a2l4?=
 =?utf-8?B?WXY1d3hVWm1zT2txRW0yUXVWTndLVE5VTUJiUlQvaWMwZk12RjdzbTRnMkQy?=
 =?utf-8?B?NXpLTUpGRUhIYUFIQmR0S05kSm5YZVB0USsxQzVtd3l3UTRsOVB4OG5Qc01S?=
 =?utf-8?B?UHNldWI3VDZUSGVYdjM3dDFkMzh3VnB6WUNteXVIZXNvQzdKaFE2SVhzSzZp?=
 =?utf-8?B?Sk95bEc4ZkJwV2ZZb1NZQ3AyaGl2dkRKd2M3bVlMWXZLcHNnSHRIcTU3WkFX?=
 =?utf-8?B?NUNtbVVBUGVPdHRSc0g1SVFONkNmL1VSYlJxYXRJaTBDZUN5bUlUbXRYVnQy?=
 =?utf-8?B?R0NGSEsyeCsyaWp6eWE2UGVFWU5oaVNNM29XWmhZSjYzc0ZBb3pDcEJUZlNV?=
 =?utf-8?B?MW84clNZNmdENlJKcWh2aVNEZTYxUm5yd2FyVmIyWThhZEpuRmV5KzNWRkNt?=
 =?utf-8?B?VzVpVWlmMVpJMG90UCtnR3RhQmtoOVhTekxCYzF4eUdSdThiSURBeC9OZEZz?=
 =?utf-8?B?QTVUK0p6cEx6ampBdEtPRCtkZkxZTWZaSUxiaXFtNzlQWVpzQTJ3ejJ4YVVO?=
 =?utf-8?B?em82bjliNk13ZFVtbjZCQjVjWE8yK2VrLzhnRHBTWkVRSGU0QTBRZ3hpM2hG?=
 =?utf-8?B?V25NeHV4RmM3TFgvcmJsTmIrN2xwVkVWeDBLVGdXam5xQXF6R0VmdUJYcmoz?=
 =?utf-8?B?SkFxTlVWU083akpYUFl4ZHc3Q3lEeFlROHJha0RoZDAzN21xd2ZoeDlSbWg4?=
 =?utf-8?B?MVlCQWlrOG55K1pZNnVZK3NERkhybkNtWG5pejkwOUF5V2RsZmU2dUQ5MWhm?=
 =?utf-8?B?bm53dy92N0F2aUREUGNqQitGSUk2aGtMRUYvYWsvOEQ4KzBQL2RlZWpzd3pa?=
 =?utf-8?B?Z3lTREdoN1ZWVjFZTFNqaDBqSExzTVVyYmNRZUdiVXVFdnBGcWhST0ozK0tr?=
 =?utf-8?B?clNhR0lVUVV5dFpSS09sa3dhQndRZWdsSFl4MjZWM0lmbWI0cFpFN2hDa0JF?=
 =?utf-8?B?QXpJcml3enEwdXlzNWoveGVqRkNsQW1RNVV0Wmx1bVdDQVlRSnJJVHZwRWZk?=
 =?utf-8?B?cUNMVlE0RFNPTzlmcE1PUFZTS09sc3ZtMlJUckZnRGhVN0hoTGVOaUp2NUJG?=
 =?utf-8?B?UHZVWHNzbDkwRTVJd1dyc05naWVIY1h3ZkRKeU1TckNraU5RQ081S0JsQ2I1?=
 =?utf-8?B?S3NLZnMzazljOHVrVzRIMEh2MTBKZjBHUThBYzBLeTVEVHpBdG10ZDJvM1Nw?=
 =?utf-8?B?M0FyNUNoaVIzM1ppeFJUblVpKzJSMlRrYXd0Z05DVExOVytRM0ZXN2dsRDlz?=
 =?utf-8?B?czM0ZGxRQitCOXpJWmFFMTh3YUZHZmNnVW4rZEYyQ3lWWjZHWk9MVEF2WnNz?=
 =?utf-8?B?YTJJNUtpdW9SOWhMU1Y0NHhPTzNNcXRtditYK1VjMTRVZ2VVRXZoUUwrUjNY?=
 =?utf-8?B?RDZBM3RDZW1Vck45b21WUkl2Yy8wLzFrVjV3T0NpdzdPNFF2MTJPblBoZHFD?=
 =?utf-8?B?blBDKzNzTDRRYVJzeFpycnRCeEdMYmVHWWkveXRBVHU1UkxXcEh4TXkwU3pv?=
 =?utf-8?B?Mm5QaHNqNlp0NExQU2EzL0NFZCtISHRZU2I1REhnam9aNHZnYmtoeE1sY01E?=
 =?utf-8?B?em9zcm81Z2JKR29sU1dwZ01IVlVFcDhRdlBaQTZPazRHSXV6bktTQi9IcVA0?=
 =?utf-8?B?QVZJU0hNYXZwbzVwR3NxNVQ4SEQvVVNtWXg0WE5hazhzUlZtSE1Ma1lWVEU1?=
 =?utf-8?B?VEs3TzN6cHlJT1UvUXVXcVU1MHZrMEljajl4RC9DK3ZXM0Uvdkp3N01IZlRH?=
 =?utf-8?B?WVF6SUVVdTJqbVI4TXFlWHVuaHRBekV6aklVNHM4dGJOM0U4bnZiaWd3d2N2?=
 =?utf-8?B?b2lnYThUa2g2M1NCOVp6dXA2d2J1T1NoQmx4NXFRcTI4QlhjRG5tVmZLbHhu?=
 =?utf-8?B?eDBDTnF3TWh6ZWllRTgxY3pkeElRUi9tN2xBM3B5aU55bkZIb29PdzF5K0xq?=
 =?utf-8?Q?7sNlx/66wU5qZHhhpeJQoOvEW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d3da9f-27bc-481a-88f8-08dd8625705d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:22:31.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rmoR5lEcgvG8uFRTeqNF1RiE2MRz6WCiNj3e0jSGrbjQO9+27A5RbeeyRqzKOPpwijOVh78RNHP/anNiuOmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5268

On 26.04.25 04:15, Haiyang He wrote:
> Add table entry for the xenomai.watchdog_timeout parameter, defined in
> kernel/cobalt/sched.c.
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  doc/asciidoc/README.INSTALL.adoc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> index 508e9b43d..b74079dc2 100644
> --- a/doc/asciidoc/README.INSTALL.adoc
> +++ b/doc/asciidoc/README.INSTALL.adoc
> @@ -144,6 +144,12 @@ documentation about the
>  link:../man1/corectl/index.html[corectl(1)]
>  utility for a description of these states. | enabled
>  
> +|xenomai.watchdog_timeout=<seconds> | Watchdog timeout value in seconds.
> +Requires CONFIG_XENO_OPT_WATCHDOG to be enabled in kernel configuration.
> +This option activates a watchdog aimed at detecting runaway Cobalt threads.
> +Timeout value can be set via CONFIG_XENO_OPT_WATCHDOG_TIMEOUT, with a range
> +from 1 to 60. | 4
> +
>  |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
>  workaround. The possible values are _disabled_, _detect_ and
>  _enabled_. See the discussion about link:dealing-with-x86-SMI[SMIs]

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
