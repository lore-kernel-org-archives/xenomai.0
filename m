Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B992DFA5B
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663817; cv=fail; b=ZF/SYoalrO/IkkZrUgEvdetZzw16HmLfZp1zxsG/XNdttUITjaItU7cFxLiOE0+KjHrgFAE5TlxefCLztaZOqUeS4p74CW5Aeumd3OikzODXzrqHvXjunRlxMJRIVyIwGc9lRqjEMt4sIO6T7RsZWG3W5Wfwa3UJ4SdIJS/WQAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663817; c=relaxed/simple;
	bh=ZVVSlJ/myfmk37ma33s8Ob9L6ob4sTIrdNJxjtrfIw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0hjfGUn6EunvyJa6vF01oWeiuKZ9jXbktMPRHrtS16iie+hfky54mxglwmvx1JINK58jVWWs9mbJZwYYot95q61MSPyOsYHRaVBg4JQOR40A+E1fX/1pZPItqP+/Bco7c3Rf368ZOlsiS+B6DuhfyX52mZiQ7dbT9z2vPr2/hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iSYxiJSZ; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iSYxiJSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3na+vza7a0HkLyyeoOizeXERLLgWmtD8i6xwspjA6sU3BKVxHc2bN6BTZiDNjaEmAvO1Uk8qa6Hlie+AoTM5ejesmu3amIzrIspRmdXnysQRJajg674pQVYTIGIIaKYcqrUb4fa64Ljqwy4OQc2AoqWNcnzdu1iAuJHkscrMVQLB2Wr+TtKEz16E/qMRxrpzU9cAzMYgbQgDkKInUu5FVg2CpDqjw33F4KMmn37exXlWm00MBsjP87fDvTFbe1FuYD4DOleFC4j3+yq+0iFNUSVcAO+T+a0BieQIfx3rvgfax1/nk/ds0us4vnScqZeeexG4AfAtX/p9OwdauR/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZLdE+1hiJV7++zqN/vy71q31+lMyQSoyPHdBeH0540=;
 b=VO2nUzcXGqfD5ny6vMUgyiK7imoVQPe/H8aglLBtnaEXSVKyayHtj6hJ2B0xOZ3bNgxAF0FCNaV1LLNWJxG1FtndsPu4akBnGTy++wfYXDz2XTiSIgH78cgbfLeb4Q6RHuFjs9UpHcFGb+nIjykNvHtcPiYz4sM05JrkiOhctrRA7B700ub1DfFr7HzzPTmpR2varQUxmuVq8LC4omlvCuyzq0OE3WM8Jfe9eOVmW8eeYiCXEEBuWgCv2EryVBHrtLd8tYG6DOw0OUx5/Eg2NTcjbqwg1dXdqOLg1D9n5FrAs4nCS+bElh8wQd2elYt2H1wQVuZSYeHQ0cT1qy/H/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZLdE+1hiJV7++zqN/vy71q31+lMyQSoyPHdBeH0540=;
 b=iSYxiJSZ3Tg9poHbxTLtGGcciUI6QBfKjfqbJpwMUI4XY2KjNv4QLoYkrdM4gbOmadrKI6RQIdaFyosoM894fwGwoTlwln/USXSYkQvlLd8idSjk6AoN49Dik0tL/a4fFvCF0s3nRsFovxAnZMikUoCFocZLYpWzAbZLlwyHyoyxnNsImLCTMAmemFaUGAlVaqQ5vg2YRx1oxIOepzpl5/mZnHSpXnPsj605jtoLnTzTcw2HDgN3JnZxvQF3DOtoSuJAx8gS3gD0wOX7MctYP18LDtuOb3AezMFyna64sk9xcGQ0YPU1y1IVND8ASOg43SCAVjNE1YvcpZWDnw7WdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:43:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:43:33 +0000
Message-ID: <e22a4a1d-05db-4d4c-8b81-1bd1c9f7fb1c@siemens.com>
Date: Mon, 20 Apr 2026 07:43:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] evl: Add the new CONFIG_EVL_NET switch to
 evl config
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260417205537.2290111-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417205537.2290111-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fac5d1-bd93-4d6d-af6d-08de9e9fc271
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	79a0CHwJWSb+pkIP2hBE9pyZxqnJdYQPpnIv1wIfX1wMMc4DqkRf15UUn21Jj7qvBDo4+sj+HWOFhMpvlpk1iQBjXV6ZBFxaiu1VTAio9lXfyLhVDdbdO3ZGUuwH/70hzSrZOVaJXwiw7LIzshfNlrs2DcQVWzsL4sv0fQISziTvXBxhk24VFxrS6aAB6cTZ7dssqTrovED5xOH49IYEHYrX+JE8duqgv2ziU2eefDZSzlVEslFuc8343v3xW+u9+G9WX4dhtuux0g6qX/lnE7PJG+WlfvpmSXc0gpKgtRRbdKCV8AKU43UxtiimbDZLufGf1lVNzvixwvE49ry0K+E99FsXaxgYNpOhZ6FD/lccAipNz9N4SbOoUl9oUBXxN2Qu81kIJJkpikjDMSodp5buwzR2OALwE6ZN+iMWHiKCsGS2iBQzWX9Na0+lTMFma+u9bEj1EUd627SPq4AKvh4jgux4bmRwa3sbZyWK7R52CU+Ai9toLCUiQMTDe4cO9piDyo0e19JNobAr4cjY+wQYvraI/AjsgJVg5NIJM8bfy46QPf774OU7tSrnec8ou7uaJUCKrOFZPnS+xyBox4++fHqELnNV2E/ViUaIkvPFKAfDIo9aVJRTjExsEW9fQJN3Vs1jlC3/PFO/QbvTe+X0d7rf01aKykn0u2sW18H8d8lS96wrEhzcf4NBp8lLMYa22WRHDE/GPw5OW6lui4SbqNRoZg/7sKtDeH0yP/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUhGZ2RGK2FCenJQY1pNSnh2SFo2YVZyaTd5VVdFM2cwTUVYWm95a1Q5THln?=
 =?utf-8?B?bm90ZXlpc2dQOEkzT1lGNVdnZnY5SUNnQTFRa2xmTE5IaUZUWm9ZeGQxNnVM?=
 =?utf-8?B?dkVBVHdVaHlveElyN2Q2My9qYUNJU0JXSnpHdTBuaXMvTTdJWThrM0JCdXpE?=
 =?utf-8?B?Q3dRV3VIcm1ucHg0bUMySDVSRzZYditOVDlldklLQzV4WG1sVGdGbmo5WGlZ?=
 =?utf-8?B?U0l0bnBGTVhCcDRwYmdLU1JQMFlvSXNpYldGMUd2cEw5c3JMWFZVZ2pXcEVi?=
 =?utf-8?B?TFU0a2dwbXlMZ0NpTDNXZG5YaVg4NW1qQVFiMUxsWFBEOS9VUW5UN0xDRFJ1?=
 =?utf-8?B?cm5tdklIL2JPYnJhdk1oU0lTZGxNdG9YMUQxYjk1V25jTDBZdGJXdzhmbnhP?=
 =?utf-8?B?SDVHQXpHMVhJUGtidGozSGRsMVBxRW52UGFEdWZnZ2JQcllUTk9mUEc5M1RC?=
 =?utf-8?B?Tk9KSmRCOHVBbzZCczFON1IzbWE5dVFBZ004Ym1NUWROQTFxUFp0VDR0UVQ3?=
 =?utf-8?B?aFBUd0V4QldBdm9ZS1AwWXhiaEdRMGp0elJ4dWMveEdIdWRjcUkwbGhYSTlM?=
 =?utf-8?B?cEZURTJDUXN1bk1TdEJQeEV3SVBFV1ZJWTNDYjFCVkNzM0VvOVRLTFVrS21y?=
 =?utf-8?B?OStWa251dnZKYk5vRGRXTWF6bzh1ZkdSMHRuNys0MEpweHlIR0NSbE9VTEkr?=
 =?utf-8?B?MTI4dWlia2RRRnhZR3lOVGtobEovNmpWWmprM1hleEZaYUUyL3o3L2s5UkVx?=
 =?utf-8?B?MTZpbWIrb0hsblFSUjBWcWYwaERwYTRrdmRHRGNOUVRyd0hlT0RQd3dQMXFN?=
 =?utf-8?B?UG1Yb0Z6Ym1pMFB2S2dDaVVCeUNyejBnc3RVazhYMEhjZFJoZXhjSm5SclVM?=
 =?utf-8?B?YjR2TlltNXJDMG9wakVKd0JtaWVndm9XQnBXemdKVUQwN1NnZDZ1eE0zMGpm?=
 =?utf-8?B?a3Jra2pPZHpXeVhkM3BvREdjVjlBRXQ4amp2NGZiN21Ubm1FTWxUSWhDWkdB?=
 =?utf-8?B?RnVZUUw2VlhETWJudUppRjQ2OWxaZU5PelIzWVNkRER6SEN5MStSQUdRU2sy?=
 =?utf-8?B?dlpzTDRSMHBEU2RZNDNWZUgzVW9PQzBxTU1HUTAyZVljTGcrZG1adHdZZy8z?=
 =?utf-8?B?bXl4Ris3cjBVTCtsN2V5ZkpaQTllV3RPTHhRak96K1prdUZZMzIzdjc4elI5?=
 =?utf-8?B?RUU1bEVIdXc2d01vZVBZYTd4bW8zNXF4SmJTa0hzdHdGM1Nhbk45NTFlR3J0?=
 =?utf-8?B?V2k5cE9tb1dyajVDNCtnbEtoTysxaUF0R0VXZ29jcVM3ZUhzV3MydnJLck50?=
 =?utf-8?B?UjB3ZE5wcjUraVBaWWNNR3F5YnREeDh3cHdvUVlHVkZxcEpLeDZTSWFOQjVS?=
 =?utf-8?B?Vnp1d1pOVklaUTdEbW54cFoxcHk3VVV1ek4yZ2dtNlZsY2p0YVRIcnN5K1JI?=
 =?utf-8?B?UEY3MmhteGIxc0dzL3hCVmk0bHpBd2ZJUHF1b2tOOGhMYXVTV2ZSSUdRN2da?=
 =?utf-8?B?WDI5N1VEWnFRV1JjNEFWSVdYaXZUQkwxOE9nSXREK2l2SGRvMHVSaTZUT3NE?=
 =?utf-8?B?c25WZDd5cFBvUFZjSVpZU2t4cHJZbTZEN3I0dnQvak5NcWIxWUhZZEQzYkVr?=
 =?utf-8?B?eElwS3A0QVpSeHRMMkdhS3FyVnNoOW5HaFp6djZYckJkbldQbWNyWXdiVjJV?=
 =?utf-8?B?UlVpeXRjN1VKbDJON3Z1bEordU9LdUZLeW1xVHdsd1p2bG5rQmZFN2NML3M2?=
 =?utf-8?B?TVVSbS9TUmUyQzdkRFVVOW1tRFpRdzBwaWpZeTJ1ZjlPWHlzWDE4YzN2a0RG?=
 =?utf-8?B?eEY2a3FUWlNGYUFHOEFvZEpKRVZjN2VvUGhPbzZKNVRCNXlkV1lCTzExbDdD?=
 =?utf-8?B?RmlhZW5oczFKZTVGVERKRElWZ0tOekVJZ0cwREY4aWRMOTlEaUJGZ1Vrc0lk?=
 =?utf-8?B?L2JiRkhIRjBKdDRvNlFjSWRidmR1SDAxMXpsNytvNENKdU81TDFXTmRBdjE2?=
 =?utf-8?B?ZUV0WUNtOWY4aGJKNVhOenJkY2QxamU4MVErbEdEdjIrbjBHeTZpQ3MrRW5w?=
 =?utf-8?B?K0cvTWdtdGtnOXpLemJtVi80eERGSVFKUGEvUG9yb2JZV2ZSWnVwM3JtL1oy?=
 =?utf-8?B?L1R5ZlZYdlEycHk1cTM4Qjd6OWIwOXE3V3BUZXNwQ21BU0JXcXRlanUvMTdx?=
 =?utf-8?B?NXRVTEFEZ3pSL2lLckp3empFM2FQNEQrbXZ4b2sybmJxUG9LRTU0TnVqRGFS?=
 =?utf-8?B?WHMxbGhMZElDcDhkK2Q4aGJOVUVpeU4zZGJQaFR5WUNBWXV6a0lqdFpUQ1Z3?=
 =?utf-8?B?VTNyQVhHNnBmRmgyMVBGQmlNKzU4blE1ZWpMcm5XVjBBMk1KK1pKQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fac5d1-bd93-4d6d-af6d-08de9e9fc271
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:43:33.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yHkcuZ95I1qhstma689A3ufmKPojpFTXz54xapO7XuJZ3biCJh/Iv998677gzB01fT4ZEdCSw5A58ypC0cZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125

On 17.04.26 22:55, Tobias Schaffner wrote:
> Enable CONFIG_EVL_NET to at least test the build in CI.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/files/evl.cfg | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/files/evl.cfg b/recipes-kernel/linux/files/evl.cfg
> index 65d9b33..a56e4ae 100644
> --- a/recipes-kernel/linux/files/evl.cfg
> +++ b/recipes-kernel/linux/files/evl.cfg
> @@ -1,3 +1,4 @@
>  CONFIG_EVL=y
>  CONFIG_EVL_SCHED_QUOTA=y
>  CONFIG_EVL_SCHED_TP=y
> +CONFIG_EVL_NET=y

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
