Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F02B9BF
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811787; cv=fail; b=fhXR0qnfxyMlG/y7ACQTaiMEeigsz+Ke7qBj1icV/YIfxcxrqqeJuQlNBcEzAAzWwNkkzjNjmQJex+ADmERyFUBoVDqTgGJYijEn/+Qikiu1woudrB+Cmxo5Qx2tApYeh+KJLeSK0NPROkLwDgUYcyZXAEEkQYwEMhS76n+r39o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811787; c=relaxed/simple;
	bh=WO/Cb9WmFn8FZpbXZTxiDGnqeAaaezwXQTkBlY1A6nQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GP5Q9+SZL7AxHJIy+JkYifDjuNL+e0ckUIRhdRnjAElhaBlU2mj/DnotUvSPdLbDmAE/uFCQWsJCzTi61mAmtc4RUgLBoxoU6Fm30tOtMWQntF/b3aotRO05SAtlt/CEx7CpdLqr52hWA7g7DcAH0DWMFPfB8gwdoPPRaxUmjEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uTVKxVgy; arc=fail smtp.client-ip=40.107.249.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uTVKxVgy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7mnPKEE/Ai4S0syNNU3JipEWCcLEjP0P5W01Uv9XGgrjeeRQDhc8vjieuRhkKn8icQd4eihdnTyaJoH7zK8Q7mniJ0ls+/MLlMn3LaQuGP5LduyBJzvdPO+fRI+c7bm6VyFV8QGkrKLRtxPOHgGGwxWmce42ixQTAjSNVqjlYk/pxPnwPEpx07NmqdeEO7HNeyd3c9wn18xX/2uccSzsV95unHt/IGFH22NFK5ugUl7d0bDF644or2TvJLTg67kcf7+yqzkKU1A284B9RmLIxu09SPaJGeHOJ4A4J7mXz8G/IcPlTGTJ/vNtH/SADlXpw3MaLR8AXyXgU23zFtpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQitA/biawvm/owNtGu2zDjTvOLxwlsnSnjLN2KIIVI=;
 b=X7PtpqrbXRsoLawIQxhbSjMxnTTxCc5169d3X5qW75rIhbIsfDdoMh2SXSSVrSTOiOZSSA59diDyfbvVw8526oj7aJUbMU/EPEXL3Up/QpnjsuUte5g7of29uGRDwkAKqRdwrqJOVy8OKhTV5XYyMTadLjerQTs35BcuP9w2YtgtSxfzsrbXKn527CgIYsBQ9d4l8N9gaGGL7362EzLfSGyP9hscFrL1JqvcvsUDOdS13SNIiWW1Cw0Ujl/KPeJHmuFfSKQOjsEYohXj8eb+N4/VNidL4Fw33sISpYMpvcowbkue+WOQ4DztRVN1H/xeQAIQfTYt0zO3TX8u6UbcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQitA/biawvm/owNtGu2zDjTvOLxwlsnSnjLN2KIIVI=;
 b=uTVKxVgy+7CDj5D98gZ4gmNroA7K0m6TzZwBX4+JWQml1UT1e6vnr6SddQaoazm58jOPNAVprej476JQG5njHsBadZLqqi74vSUPJtvRzMIUQRjoj66KXt1sq37cnTw9dUxSoFOrGmgWXVaAdwiywJ4YTkAguLDxY9KeqCvJ4Ma/p2WEk/OeRIOTDPT6YEYQLN7DnqJ5egNvfvTM4sCFECYOLm8xOyA54xErzb8TquTxrF6LIR+SSqU7jFChEbg7Jh21muJA2s66QINnq0li7WA3csd5C02WyEHH7K3T7jg1jm47YU4DkTFRO2iDXy0xKb1iZKdZTr04zbYPyU9vEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 05:29:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 05:29:40 +0000
Message-ID: <8429ac85-21e0-4ebc-81af-a800326083d1@siemens.com>
Date: Mon, 1 Jul 2024 07:29:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add cleanup checks to CI pipeline
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240629134504.11148-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240629134504.11148-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 98692c26-0146-4da7-f5be-08dc998ece08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHZSbnM3VHgxQVNJRS9jL2t3VFJQSTNLemMrY04xNHg2cGRXb3hSWUZzWW4y?=
 =?utf-8?B?bWYzTWJqUE5pTzAzckRyc1ZyWUJqNU9GVG80czY0Tkx0dlZ2aDQ5RnIvamxN?=
 =?utf-8?B?UkdMU1VpV0l6SDJ0ZWI5NjBjdkJPb1BKaG5BaTNCd0kxQVZpVGc0aVNwSDBr?=
 =?utf-8?B?M2JiMDEranpiUU8wcmNIZm54dzNad25pU1IxVFlEaGExZjRwQm9tQmNqZzZ2?=
 =?utf-8?B?K0JSNnY4TU51dXJZc0R6RzlXVHpHWmV1eUhMZmlvTU5TaGJSQndmS3BHdVhz?=
 =?utf-8?B?V0VYU0ppMWRGRTl3bTZUTGd0ZVdlSkFJNkhacmdyVXE2eGxNdmI5SVBpUDY0?=
 =?utf-8?B?ZXhZQmRpSktJQzNPeWVHWFNaNHYxNjFpcThmeTdoUEQzQWZybmpvWGhPYlE3?=
 =?utf-8?B?L0N1V0wwQWxibjVzYWhzUk9sWFZmVWkyaEFINWFKY1NaZGZPeTFwbTluM3Nu?=
 =?utf-8?B?a2pHbjBKUVBiclAxQnJLZ01qcXl5anZvNURiTUNQT215d3I5VnM2NU1mOFNJ?=
 =?utf-8?B?eGJjUE8wSHlLSm1aQXVFcm1XeTVSamtVc3VvM1doaHNPeUduaTZSc0NCVHB1?=
 =?utf-8?B?bVlrMWJ1Slh1WEFWdlFNZ25aZVVNZUMyYmtSb0EyK2Z5QmxjZ1djQStYNk4x?=
 =?utf-8?B?UG1KLzM4Ky9odHlqL1Y4QmgybE9hYUFOREFURGJjMmhOc0p2aVJUWk1oZlgz?=
 =?utf-8?B?QVFJS09tSVRrYTZ4RlM1SUJxcWp0T0QvUGIremwvZnd1NG5IaHhxYk90TFpr?=
 =?utf-8?B?a1hQVWtwUmFmNC9kNlVvWjB0U0hLb0lyUndFRVRjY3BSQjMzNU5OdUR1ZUVL?=
 =?utf-8?B?Szd0am9QSGp4aUhxVGRRdjhHa0NkYi9Ub0JWcDBJRldpNHZIaG5BNHBLbng1?=
 =?utf-8?B?ZHBYYU1aaG9pZlVuTDFtSk5KbUFMd051WUNKL1A5cW56MTIxSFVsbGMrVWZm?=
 =?utf-8?B?dFFIRVNRdkRCMXloYU1EZGpDU1l0RDNlMWRVSkd2V2xsVkt2UGZCMVVGbGJm?=
 =?utf-8?B?eGd6TXhpYXpjYVpkTUNKRjdJczI1SFJUN0RRNXh1YVpoZ3RBb2llMXpoNzcz?=
 =?utf-8?B?dmRsMUY2ZVV2T3dkUjgrQXFURE5rMTVUNVpJK0pnZm92MFNmZXBId1RiZ0Fy?=
 =?utf-8?B?UnlOL2ZQMHlhbTZxN0JTbnFHNXlTRk0zR3BDT0JXR3kwdE9Ebk9qV2F3b2Fv?=
 =?utf-8?B?eHFTYlJkTFVwVFBnNTNPR1NnMEFsQXdvK09obTFwcW9JWXN3eHhTNE9lcklL?=
 =?utf-8?B?UitWdjF0b0RpWlV5VkRIOG1HSmxYMXdNUm41VmJTYTY2T3FrM0sxeHp1bWZ6?=
 =?utf-8?B?RFJGdkFHTzdRMkxJQ0lCdmFZYVRlMjc4Um5INXFzSEUzUjU2TUdQTW4yREJW?=
 =?utf-8?B?Q0xtUzM0czhmaWM3dURBVlptTmUwZTRueEhiNVcwWTloYzNaNEF0c2pRU3Nu?=
 =?utf-8?B?SktETjhDQUxEQ2dFYm1ubnI0WUFyMjFDZHNhMEFXTW5NcXRLQTg3dEl0aWhX?=
 =?utf-8?B?UkdhSG5YbTN4YmxMbDZWYytBbTNYUVBRL0hDcDB0dEtkUzVmQXBEYjBLOFZO?=
 =?utf-8?B?cTQ3eGNrUTMvaGNWSFJaalFPNnkzZ1Rvd3lRc2llMEFRQWJ4ZnlBRGlWYy9W?=
 =?utf-8?B?NmI2SFVnRWx6c3hiVzBWcGtlbzIwSTJlc1JTUWpwQ1JGcitFL1pXRFZhaHBR?=
 =?utf-8?B?Vk1EdGM4SU1oNnZjWHZlbDhEZHVpRW0wN2VDZGdpVHlzcndsMnlRS0lLcURZ?=
 =?utf-8?B?dlhsaDBMZStwRk5SYmhaSEM5NUpQUXl0WjBxQnpIOU1zWUZhRHNUVmxza2p3?=
 =?utf-8?B?NlYyVE02WVFSc0VhLy8vdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDdCS3cxdU1waStZY3FqR3IyMkRmeHhzSmdWbTNlcmFsTDFTVFBRSVNiamps?=
 =?utf-8?B?aWpWK2xkcUFHdkRXMmJVeDFaaEpGbThIN0dma2FXK2RGVnZ4SmdOY3pZMzhT?=
 =?utf-8?B?bGFadWtUZnNxRTNyOUxiUHlpZWkwNFNXeExGcnN4Z3hpL0N6OXVJL011dndM?=
 =?utf-8?B?c2xiVkN3YUFoa09PNG1RREE1emxHZnpzM3lTbWxOVmNTSGIzTmZKNlQ2d3dN?=
 =?utf-8?B?R3NwN3BlcWZkQ21uZjVMWUdidUMxTEpES2tkbThLMDVLc1N4MFUxbTBlaFI2?=
 =?utf-8?B?MTlDQ0JERzAvMUJTOGtCRmE0ZTIvNU1zdElKS0YyOTlqQ1RGcHJoV1B0ci9V?=
 =?utf-8?B?cmJyanJkSzh6ZVYwVGhTVnBFOGFuNEVwTXZUc2F1bCtKKzZJRFcwN0pRbHhz?=
 =?utf-8?B?bnlxUEIyR0gybGM2OFUxZUNnck00R28vN1owa3hZYVJZWTdnMkFubFdhT3c4?=
 =?utf-8?B?ZGJ5NHJ5VktJQ1dsN25MMUIvZUdWMmxieTM3eDFaNm9rVGRpV1hsUllQWGtq?=
 =?utf-8?B?RHZ3Mm9uVHdSUTQrTjlkbDNwcHVqSnBiQWFuSGFRN0lvaGR2YkJHTFlESEtN?=
 =?utf-8?B?azRWUnhOMW8zelQ4VXVJaGY4Q2N4cTdjZ2hWcHRaTzhjWGNSOU5HM2lYSDQw?=
 =?utf-8?B?UFEwemViYlBic3VMNFV6SURqNkZLN091dEhndEhEMkE3YnA1aW9NL3JOT2Jn?=
 =?utf-8?B?dS80NU1YUTBJM0N5Q2svLzBrbUxjM2FOakZaTzVnUTI4MFdFdVlGU0tKYjJP?=
 =?utf-8?B?L1dhWXVxQmJwRGluTnNpZml0dGxseU54VG1PS2JJWU9DY3pQUDMxbVdQd3pI?=
 =?utf-8?B?Mm10TmRxejhVNW5Oa0NsMHI4YnIxVFpSaFpzdE52cFhBV3B3cWZ4TjdFdFBy?=
 =?utf-8?B?eWZTV1dOd0JndFFzUDEyVmJkRG04T3U3QWhRSitoTXNwSXZLdm1OOWd5YmZl?=
 =?utf-8?B?MmxjbS9ONU1RRUxmaStKRHZ6NHd1MnBTK0Nyd1NzaGtIQnlXTzk5VDJPRXhq?=
 =?utf-8?B?S0s2d2VKK0Fmb1o5dExXd1J0K0JSR2hhY2dnWTNtd2tNcXk3S1NLZ0NiZDVN?=
 =?utf-8?B?SUxhV3o5dzJMWEg0NnVSMTRMcWVHOG1Ia0hRMGxiMmJsRlFWeFNNcUhJajYz?=
 =?utf-8?B?eTI5SjlKSlVqMHpDNzR5eCt4T21YSzVtMzM1aGNxRFNoQ05pell1L2xFOWVy?=
 =?utf-8?B?UHNnY1RhR3RlbFNJY3I5Ym4vSnQ4dkdyWVQzSGpycms2bTlva1ZDOWhXV28z?=
 =?utf-8?B?NGxIdE5wQXlZYndWOEE4ZXhzQzh5STlpNytvSU9nSndsaHJJNzNOdS9XcUpp?=
 =?utf-8?B?a0lTU01sNXBPSGVnUFdrczRGT2tqenV3SEZzbnBuK2lDWWlZY3U5OW5NZEJI?=
 =?utf-8?B?RFdlU3BvcmdMRFQwc3N0dzlnc0lKemJ1N01WVm1JRXIvcDk0QnFLS0RULzBW?=
 =?utf-8?B?dG9HWUxsWWlZKzd4Nmw3M2dVdDI2dm5ubWt5ejlqR2QxV1lycXhkUUgyeEZw?=
 =?utf-8?B?RktsSUVUY3cvbXJoUW4xVUZiVHBIU1RraC95WFRMOWRiZGtjQUo2ZGpaZk53?=
 =?utf-8?B?amtmOHdJSlo4aE1KZ2NGSXVjNXJkOVZZbklVSHVtTWx2UlRDQzEzVW1vQ0Za?=
 =?utf-8?B?OGhDMkZ1RytHMEJxalFqQkJMdHdzVDVBUWRTWE5JbGdDSjJORjVkZ1BTYWhZ?=
 =?utf-8?B?UGptU0FTU3RZdU5lWGVEdFpjZnl3dVhya2tlYlByUVJ1MFp6U3A2aEMvRDJj?=
 =?utf-8?B?L0p5cVdmd3hqM0RpNFNZNWYyM0F3WHU5VHRmaGtpSzVneHMzQndXYm1lRHZ0?=
 =?utf-8?B?WEoxRk85aHZDSkZhMkVVMkEwQ0pCbXE0eC9OdUpvY0w2d3JOZW9NLzNHMTlU?=
 =?utf-8?B?NFM1NGQyKzBHdWxNN2RSbkhhelBaRzR2TXpEQmdDTEMwcHNMUlJMb1l1YkF3?=
 =?utf-8?B?bmZRVW5uMzB5OFZwMUl5RlhwWnhyTlE1YlFweVA4Z250Vm1oU0FtSEJyK2lB?=
 =?utf-8?B?NENud1NHOStkUEZEM1FHRHdLRC8rSFljeU5RMUJJU2Rud1g2RHg2WXRZY1hB?=
 =?utf-8?B?bnE2K3k0Tm1idExiT1FkczhBN0g4OUpjNE1WbHJyVElnbGZYSU80TUdpcFor?=
 =?utf-8?Q?HDQFKLWcO8mgK9iRmBBJqNF92?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98692c26-0146-4da7-f5be-08dc998ece08
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 05:29:40.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNPINbXEwW5nj+qCPs4QNj1wd1y2dJfIWUpZv2vBK5mit4Cf4vLV+uU0v9ytxrkDobbra4ftvcrXZCRbn+QBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6879

On 29.06.24 15:44, Richard Weinberger wrote:
> Run make clean after building kernel and Xenomai and check whether
> no stale files exist.
> This allows also testing the --reverse feature of prepare-kernel.sh.
> 
> Since build artefacts are not used after building, at least as I understand
> the current pipelines, make clean can get executed right in the build stage.
> 
> Richard Weinberger (5):
>   gitlab-ci.yml: Use CI_PROJECT_DIR variable
>   gitlab-ci.yml: Clean and check kernel build
>   Refactor .gitignore file
>   doxygen: Remove generated config file up make clean
>   gitlab-ci.yml: Clean and check xenomai build
> 
>  .gitignore              | 56 +++++++++++++++++++++++++++++------------
>  .gitlab-ci.yml          | 11 +++++---
>  doc/doxygen/Makefile.am |  1 +
>  3 files changed, 48 insertions(+), 20 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

