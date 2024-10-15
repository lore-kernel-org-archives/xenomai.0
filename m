Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC11D5144
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005858; cv=fail; b=PyZGEDYofFmlR1418Q5dq/sCqXSnYER43tUYdUSO9GbxCUJpanWe8IQmMdmxgQqumqlQmeUl9S6j7Nc8RQDTUeSHDX7O2+/1MkcuzHq4fcoYvhWhccPZrbCjN28yFONai4/kJMnPwcNW+MRbFTtfg58kzBK/GrhgQA5we3Xw4KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005858; c=relaxed/simple;
	bh=/uteg63rA2FBPvJda3cScD+WEMbRa3qFdaobz8JWWBI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O74BgD/jTYr7G6yeOB3X25ulnIAoN3FNPAdSsmtQCpwkFX4KT9avX7bhdW5BvtCyWSQPnvZIsMkmANzBu3maPWlDofm9leuQPMP2Hi6nj5cGtIFA90YEScqz7DXtzvdSVLIMuw8pYmogFZyldUWNod/rsUBpQU5ROu3/i/QEG0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tRt7daAw; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tRt7daAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzKreCfpmVvtGN8Vprsaw3JA0Iix1SouQp65bzkxg2fKct0JDKx9ww76Mkiotlg5CDVUnheCq6kKiucGVunvzz2lSS+OAQ4GCSepxWa/Y9hYZOebbiVU+kfLxXamFODpQm6jH5pM/5Cza1Pri+10EInVIXj8Q2B9URkns7bSNt9DbQM1zVf1gNl3Mz3JWil8fi+V5CkEOJ43UyuqKPQ463SY8zAnxHejOM52Xk1QSnT3ieQfk2awzovJhD2fSnXjisFFzBagVqfOwXwnQJPgbZIaGEEO3gILFYuT911Q/edD4wGqUUZ6i6uHkULR6MSAEVtSDCoaIvBymxhyUItoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h38eSA7Fh4gKJ+LK3GfMe+V0zCvtT78nadWoHbXZ1sA=;
 b=LC4jUMt7mD0aTSULClxXJIY1Guberea6FWMxJwTmgtXo7Ejsy7lbpSfrxskwYXTzKJKk6lac2ZiTJ7GojrhBLQcDt5XaV6r8ITOdNoIDoC6cbJfUzO480Dp7kMoOlmbgiVyr4q+32a4P+hnqHyMvSjNM7RlxallEaJq4V9G91CMDkaP2O23SnqreKOLEgKsT2vrcrepFHWHOohDT2igRv/gnzwA0Frt/sO+RoXyEurcKznlk+uBz/zyrfZLF22h5a+hMgwFW55th2kJULLp5pYiMJSBBmCe6EdkIYOfeul+gkvb6ZJqT0zVgKR8QjqPbLlppaGE0oNbNKwOM3KlQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h38eSA7Fh4gKJ+LK3GfMe+V0zCvtT78nadWoHbXZ1sA=;
 b=tRt7daAwMVhcIgnGir3uNMq9mk3yogxCLE/c2Xq7+rf5Rc0v0W/WJgIUoClsL6z5p7ekSN/3o31RkjUg8GBGmrd0B8olMtLDGvfUjpBtX/HcvlHcDdArls2Pa0sXZ6GHzout9oXqYZEAO9/frOLCHk2VNFI6HUQ2i1X1j9pg35qRg6oiObT6m5hXpf3o9NXEvgr0xvDcZvrtQT6Oz4eayAuK0YskrIE0BmW/z/xhlY6uQv0m9yghUj08EXJc27I7iD6B2nsEJ9HziIa0qDSLaHuFD6QlK4fvcts0uCBGAyFbYJM4UZkr7r9Exee0NWSK3+xU8ZPwhYCZutam99x8PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Tue, 15 Oct
 2024 15:24:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 15:24:13 +0000
Message-ID: <ae8b47a9-1336-4291-a6eb-092d24e763f7@siemens.com>
Date: Tue, 15 Oct 2024 17:24:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] alchemytests: Set cpu-affinity by env var
To: Richard Weinberger <richard@sigma-star.at>,
 Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
 <20240902131124.37844-4-simon.graber@sigma-star.at>
 <ad9d6b95-5f3d-4cf2-ad49-ede55cec7a18@siemens.com>
 <10419636.0AQdONaE2F@somecomputer>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10419636.0AQdONaE2F@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2f70d1-be86-497d-d387-08dced2d6ccf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUMzMFlZSVZHOHNjdFdKYnVjUXk1cXVCTFU5MWdiOFd3NUhGblhOTDVQcllB?=
 =?utf-8?B?Q21qUEV3bWFLczFrSUVhMGVPUndFdFp1VktOUmx6R2V6aHkwY0xJMk53aGxP?=
 =?utf-8?B?WmdjL0JwZll4SkxZaUM4TGZNbDZRNENZZHZLOGhFQzJwRko3djVUcC9ETFVK?=
 =?utf-8?B?dEhITm5uOGJ0QjAxTUNjTVFIaTZhelhTazBaZW5LNDhkbHM3b0U3MjJKbnoz?=
 =?utf-8?B?MlF6bTR4R1lQMUNiV0h1QjFjWTcwZkx6QXJDNGdjTXhOdHgxNnlDcGt6aEVq?=
 =?utf-8?B?cXB1YjB1YUJxdlFXcy91UjcyVm1LNGg1bU9aTDc5Mys4V3gwai9weXNmZUlu?=
 =?utf-8?B?ck13cmtoSnVsbUFSSWk0d2lVVGdGbGNPeFlaREtYMTdTcENWN1dxbjdTQjJK?=
 =?utf-8?B?UHYrL29pOEZDdWo0TS9MYTJ6N3lDU0NrQ3UvbllxK2l4VFdIRzgwRHdGM1hr?=
 =?utf-8?B?QmVKdWUycndQdVUzVzBndnBTNDhBb2dLUUwrNmg4OEwva0VRQlIxeUlhV0VN?=
 =?utf-8?B?QkJRSkhJNUxaS1UxSmNiV0FKUDJRLzA5ZXE2ViszUjhManpJVVZmYWdNeERF?=
 =?utf-8?B?blhRZVhQNy9jVzhZQWE0UDloUU5wUzBXK0dJYnIzTWJkK0hhblJaRTE3MlB0?=
 =?utf-8?B?NjA3SjNBcU1PY1FNVEdaVTMwOFJJeFA3SmZDU1dPWmxXRGpSYXlrWW0wTWZJ?=
 =?utf-8?B?YTlsWFNkQWdPSmpLQVZIcGh6NTMxbGtSNUk1OG1seFlWeEMzZ0tpVnZMdzFl?=
 =?utf-8?B?M1NPdm1xTGIrQUNJei9wZUhtaW9UaGNLaUtuTFczRFFlSEsxYWh0dER0QmNL?=
 =?utf-8?B?b2IwbStXcHNMNmNnVWNNZDJMT1hsL01zeEFoby93WW82c0JjOUhLd25vNmFN?=
 =?utf-8?B?dStIb0xPbzNIUW5FZWxIWXdYTSs4R28yYytGam5LY1VueWV6U0F6bjFIc3Qw?=
 =?utf-8?B?UTlaN2J2Sm5ob1dtcUdoTWhWWFN1MzYwQ0N0TXRvOE9UM01jazh1dkV6dVRP?=
 =?utf-8?B?SjZpeDBZZGtNMXpIeXdaN21rajNMZDhnOTZUaTBBRUtsL0hXdzBvLy8yVHRY?=
 =?utf-8?B?NHlGYVpOazNQQmVCZ2d5TWNjUXltcDY1SStOYmxFbEZkNTlpN0hXeHBnR1RI?=
 =?utf-8?B?TSswMUh3V3ArU0lrMjFKcm9sc09ZZlJpYlJtQjhCbGgvbk5OTkZFeG55QVFP?=
 =?utf-8?B?V0pPN3JGcGpqQWFqUVlBZlJNRWVPNmRNalFYWTM5TlRWdVhTbEdsbDBoQWR6?=
 =?utf-8?B?bVdjVDViQ215T0FLYzlyM1EvRnFsY3hXRXRlQ2l6VUF4STVRc1hHdHZQVGxn?=
 =?utf-8?B?RmVUODRJNEM1d1NtWXExY1RadWxtdnRZemZRaG1LSWhOakxVVTVSSXdNME9j?=
 =?utf-8?B?RjRPc2dlNjgwc1kvMHJPdHhJOG1JUHhSV0cwYU5HdUZDUy80bTVjZ3QvMWFv?=
 =?utf-8?B?R2ZPWlZEYUpYR0FxYjJraXM5a3lOQVhVU3lqV1VJWm83V3pnSzNLS0JjZjUv?=
 =?utf-8?B?VWd1Yld3c0RxbTFpeWlRSFZJWk5hczVrMEVaMDZGd3BXdXhwc053b3JVVk1a?=
 =?utf-8?B?RWpTcWJXR0FJTkYxczM2dHZVcVRQMWtQNjFYZENUL05WT1pWMElPN1hEZHox?=
 =?utf-8?Q?Y9M2/vTdGWQYY98RM71kdsLXcClihxnrr5nynMGdIGtw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OElUSS9wd0VvamNZMVE2dmc2V1V3QVdJbERDWWFMWjhKOEU4dDNsS0owcEhz?=
 =?utf-8?B?aXdxbW5LdVByVGE5YXJETUY5czhkYmNuai83azR1ZndEUTNWS2wvSjVJOVA0?=
 =?utf-8?B?VC81R2lVZm1qTnpYdS9aZ2IxdVk1ZzQ5K2JvckRLVjZOb3VuUEd5SFdnL0NO?=
 =?utf-8?B?eGVKVVQ0Vkk4T2YyM1NEOTk5T2ZJZDRYcGFyTkQ2SWR4enczL1NuYVV1WjUr?=
 =?utf-8?B?NC9RSGpSaCswQzlNWFM2VEQ5UnZTZzQwa0cyc2RSUEE0K1NFSUVWWitKbW15?=
 =?utf-8?B?SU5DRWgzWHlSUFpzYXV5U053R3VrVG5lcmNsaG12S0QrVThUb1FLZ3RFT0FM?=
 =?utf-8?B?UTZ0NlRyVUxmaVRaVHRJSy9aSC9vWktTZGcvTkN0QVk0bytRTEU1amI2dmZ5?=
 =?utf-8?B?T3k0VlE4U2dYcWIxL0Q5UlVkc0RWV1NLbVFCVFRNV0g3THhQWnZVbDJBaEVZ?=
 =?utf-8?B?dnBxUVhYNkRYenpKOEtkOG1BRnZNYUdEVG41SXhYUzEraU53UmcyMkEvUURF?=
 =?utf-8?B?OUl2OENzKzRGRndZRCtMNGhYeSs2VnJ0RDJrSmtOZ3MydGI3b1dmT3htYkRJ?=
 =?utf-8?B?Q1pJR3BsY0RWaG9ydmFRNjkxVVc0YWVDSklISU9IV2FIeXBmenlMR1RDRGZT?=
 =?utf-8?B?VDYrbm1sVzQvWkYxSitSN2RBU2dNK3BFOTF0TVJzcHc3OGcxT001N3Vhclp5?=
 =?utf-8?B?cXVjMUViQlc0d2dQZFJKMVRudWhadG55RmYycEwvMmUraS9jYVBLcjBGeVhM?=
 =?utf-8?B?blUzdGp1NXhoY0dTSVQ0Z1lBdGNPdEliSXVXdThCU2FOR1lCVkxVZmxhOWYy?=
 =?utf-8?B?NXZhbS9BaFEwdm1zc1ltOThHM0dBMHNpUlVSbGJXeU9HV3JlV2Y0b3BQUVZE?=
 =?utf-8?B?dXVkL0szZzZTbG5EOUlwQ29yU2hnMXpEbXVWZEpFK3h5Zlh3dk1nYTlreE1l?=
 =?utf-8?B?SWlQODh4QnY5RVJGeDVjODZzc09jRndGRGl2ODQzOExEYVg1WXgyWVVxa0hi?=
 =?utf-8?B?blhqQW5abEFjM2F5UXowVHNudlI3WFZJY0lHamlUdCtIY2M1MjRPRUN4S1pQ?=
 =?utf-8?B?NDBJWmMxMDVIQzdLSjlGNzBnaFJMUmovZGg3SkxqMWRocnZUT1JWZElFZ0Ir?=
 =?utf-8?B?dllWNTNPOXJ3MzR2THNhanJaSzRIekhzMElpZDlpUVd4d0o3aDhTR3VxcW8z?=
 =?utf-8?B?dFBKcktLL0E2N1VyQkVMYWJSbEFZRGhpMXFxR2o0dy9pb0QzU0U5OUFFU05F?=
 =?utf-8?B?ajlGQWJhQklMZmxSL2VSU2xLVkd1OEpUYnJuT0xHQ1dNdnBDVEZqVCs0VUtR?=
 =?utf-8?B?V0xhV1ZrNkI0N2RzVHJWL1FGU0NEVW1ZekNRYklQMHJoUmZxUmNmSkNyNUdJ?=
 =?utf-8?B?OWN5NUwyVTBqR2ZidWVrbG5vNzIxVGpqUHpjamVQZGsvQ1BNRUVkR0g3dUNw?=
 =?utf-8?B?ajFrZk5OV2RGL0FaTG5xMWhhTkhiK2dvd3dkNDdqT0VYdzcvcmZtdk1reHB3?=
 =?utf-8?B?dnJiOXFkQnFwbHE5bGx1bERibWhmdXJyZ2pEdXNiV0xPVlZmbzlsQkRwbnN2?=
 =?utf-8?B?YlFEUndNRGxzN3pxVURSbWZPU09QV2w4NHUxbVFzWDFWMXBOWlJJMkZnRW42?=
 =?utf-8?B?em1uN05rYkY3amtENTJ1L2I5M1NqWVZkMHJsOHJaQVVCdWNyYmtJK0xWWld3?=
 =?utf-8?B?R1gvak5tbFF4TTVJSVRVaVJsejJVcmN1bUR2UGdKRkEzS0NLZ0h1VmVtTVdV?=
 =?utf-8?B?dVRicEt1biszbjAzWU1PZkV1c1R3djlKQzhDbjhscVdST3Z2N2RCM1NPV2Qw?=
 =?utf-8?B?OHM1ZHlQOUtmMVArQVdOY0N3YU1NODM5UFFPZzVsdjFzYXEwV04rMzdId3R1?=
 =?utf-8?B?aDUvUGtSUllBbFhyZ3lObFF1MjdtaXB1ZDRMNFUrcEI1Y1BGNzd3S0pHQzlY?=
 =?utf-8?B?L0RlbENGZyt1VnN4ZG0vTUt2UDZjQ1NEb3lBL1Jlem8rTkxRR3VlQXBGeTE2?=
 =?utf-8?B?MUFnaytvdzQ5S1Z5b2FHc25NQWRrYVp6M0xXK09yUFZmaUVoNVNRcFZKMHZG?=
 =?utf-8?B?Z3FiTlB6c0hUY1hDbEFsdXEzZnR0QlFRRDduM2tDbGNnekFnSnJWK3VzOGdI?=
 =?utf-8?Q?2Ez4TjT1e7XRpcCF3sXeuu/Ct?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f70d1-be86-497d-d387-08dced2d6ccf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:24:13.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLtCjEtu1Jqam0a8IcFF3Sz/5j9ZUkUPSyjs9O/GzHkLCszga3Itamut2AFuR3aw/Aya9LP2S8cal7cNFzarDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863

On 15.10.24 12:04, Richard Weinberger wrote:
> Am Dienstag, 15. Oktober 2024, 12:02:01 CEST schrieb 'Jan Kiszka' via upstream:
>> I suspect we have some regression here as I see a lot of heap-1 tests
>> failing in qemu runners, see eg.
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/918773
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/918984
>>
>> Could you check this?
> 
> I'll. Simon was our intern this summer. :-)
> 

Looks more like another on-vm issue: We are only waiting 1 ms in
foreground_task for the background_task to run into its final
rt_heap_alloc. If the host is busy, that may not be enough.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
