Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2118.outbound.protection.outlook.com [40.107.7.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538313E88F
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592594; cv=fail; b=jZUCpJC33McHCKv4L9P1nZoHwSSsu+JYcfR8nJo0lqRYFPTIvaShQkLRaYZzs2EU1AL01gO972P8kjOHZM5tegDuwj9PP8SD2OtAOb8gorLQgKMprE2o04o0ys8g/VJ6ASk/R76b9uDm0mEjWZUfMyDe3UowjcQkZVoKZWHLkWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592594; c=relaxed/simple;
	bh=QkLt11s5wcxcEGAhDlBPjAbM2k7/SsvKqrhkyFIDFdQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLrWpgzxdoaCw8qBRnOa86BAR9jBJQqo8XwEr4/RzY+rmk0wBKdbHTnYCy6CnQNmXQQzAqwBzN9LKB8UVqHAn9i4Yh1F+VCbxO7zYvF8W43E8uGj9E/3UN5fIJZOrPFWs16SnxEfsCd81M93VB042xICoBIl6g3VQq3YFqk5NjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kovC92Lv; arc=fail smtp.client-ip=40.107.7.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kovC92Lv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBOtqJ+ISg9CrvDHwOCwZx0QPTWHXrBaXF/ZqCi4gcEJbpdLmQKMyaQSEFC/9gijH/L0o5FU/1UpwQMJBFDibVID8102uTdl8Q43DHvMdcjGcHPLQH7mrJv/gdshfY84YyyyM1+nl6yNIOWntOufYD6kfTb4+a/EN9J/5Hu/j9LW/swPm4STb+Md0/Aw9R2m+b3Oz1CorxjML4cuO4LvKSOfzSEeK5NTOBf6lpn5urJLM5DBBhASoDA2kJHcGHidq/5oeIlOCcLSKYCN5OtVXE7kAvRcpHuxTjndMcLFofqGSO6/ds0bqTrMEmvC6pyylELL+RzWZO/T626wp30Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ypQb/mFl9Jl9m6XfWX7PpdVPH8jOrMo2/n+NUmPp4=;
 b=E0rihUHLfyriIGLa1qll8CIxugjPoDM9fJdbM+ka/2mLiQ01avrfYwZfnhhIXqEIjCznWg9Rpt+tARuttbjq0DnqYmhuIBYKAD0v8AJvhR+/B9apBN55/WIXWmG0e5kTn27qCGRDP8E9/ERxauehWYrINcbOA0doOAPieY1WSMiSs30VCsLeCKsNfnNtOOVGgDSPxI4Nmb4nRlDWfGRSZsXRK9FvsmujwRZahxDfumPoBb+ppLePjAaHtFAUWAdAIrks4s3feVhdHBJU/hxgJqTA76k2IHjWQmwl6lNncqvpA8p7TFgFenu5QYLyIccx6D1ppolY3dDoGY04t+OfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ypQb/mFl9Jl9m6XfWX7PpdVPH8jOrMo2/n+NUmPp4=;
 b=kovC92LvHIvPiv+L8lgCrKpv8/TjIH74xpcciT6SAJUszje7Z8O2L+j0e9fcwmwFP5MZD/POAJ/8Xk/0rnlaFXzG8ngFAhOzVmPNpGnfHaehOEIMt5HZpM2LUtQYwDEMJpoVYOiLs+81BkH1/42J04L+U48DK/iHJEbQT0E6koUOsWZypRxe1ACZXyBlmjO4Z8dcNtN6kv+AbD4xGHOyaii7dmw9zWvk7Q1/uPyaRdHy1Q4KKNAxu/TDwFrqcCtlkV73hVfGCqXOjeandNU8JrHYNNPP7b2toPk9xkymbN5pMTZpkZHCzfNh0Hp3s2nVbH+tzL+ERhbSiVbvkn5WtQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:09:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 16:09:48 +0000
Message-ID: <ac7c4a4a-b3c2-4759-9669-6d788e3c0538@siemens.com>
Date: Mon, 8 Apr 2024 18:09:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] prepare-kernel.sh: Remove patch_ed function
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240403214811.8979-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240403214811.8979-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1m7Ejk3EXHCl0dRyVOSb5LZrbyy3dOQMQF1yA5/BKwrX1mT/idGWv5EWc8c30HsuE9wOPvOwZHBot0Viem5Kaz8ikUylkdu9EzXxh90wYduB3RlCK/qE1alL1f/1ZQWTpAg5RXujeIUGZNIyiqRz9w5FoQXzMdbq9AsAdCKJ60cdPpnJazOWFu4D/MtbfY3DSv+VpoJ6xeBwU7i8QcRMs+jpBFy4GtP38bb7WP3J2s6j3vH36PojG13ClhqD+vPJ/0eOFB3QW0EpQIYBrWQwL0M5+HXn1aFN32uWRndWvTmQlfDPgR8UiIGxz3ipeI8wT/hbHlcWROs74HS5r2ZcPW523xyFPG/62nWP82SmSfY+ZiH7CcD+9ZRbvIbefsmTtNyUetdfX6QCaVj58mwbxbBCuz6ZWUqRjYSbvzUbPZjeUcrHxMuxifFM2PJ5DK5izobhuXu9azI+MNK2D0Y6dL1XWjH7EJYzfKibBNxlsYGBkXL6VnmKSDmhOLRuQ5qkVoNBmtGYdllLuYdzIjqJhoBD9VDkgW+DkY//+ZG6H0ZUCNT16JoDb5KwEZbn0hQg4Jr03w16es1DNAQ6/8cSQE8qJzRY/AqeH9z5BPHz04zW1/sY5qV+9z31cFtv0vxAHi/Kj7q6mB5EWmyhs5zhAoLz0i0Z/YOgWg7U0yLKzHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUQ3SU5GRDNGeW9SVUt4M2tyVTMwdUU4bThPWDlxS0pWRU9PdExKbi8vRVhm?=
 =?utf-8?B?VHA3NkZ5aUZlZHVzMDZZeFFsQ2E5YmVCeml6N0ZXOTJ1WHhib0V4VmphdlBn?=
 =?utf-8?B?SGg2UXVyTzlXVDU1TkxJSXVpY2lYYUhvenZRWGZ5UUt6bWFHekVUTHZpTXZu?=
 =?utf-8?B?dkdvZmdrZlhSbGtwOXM0YnZibmpKZVFOYTFjZko5SWJ5L3I5WE94VWtOeGt3?=
 =?utf-8?B?VHFFOFRGZDdQMUYxeFUydmJTMG9ZdnlQZktrWENnTXg2Q2RKR1BLeUszUDF6?=
 =?utf-8?B?RXA1WVpPeHdBeTA0aGhjUitFUGlmYjBydDhqNDdHSHJCZjQ0bjI4anlhN3Fn?=
 =?utf-8?B?VkMvRlpFdkNHbGJiTjFKTUF5aGhRVjh0SEZNYkd3U2Z1ZUZsQnFzOHJKdHh0?=
 =?utf-8?B?ZXQ5OTZNRVJ3aUFCOU4xejR6Nm9telgzc3h6a0MyQWNwMTZweUVZZVRDZE5C?=
 =?utf-8?B?WjR6dkxqOVE5MHR6WEp1V0xWWlVnZml5Vzd3NHFYYzYvWnorbXh5bWRjM2J2?=
 =?utf-8?B?UWZNbnBITEpsN2l6Mng1WHZLOUl5VjJ6bFcvVUgrdkttQXRvSzFCNW13Rmor?=
 =?utf-8?B?c3ZOVkNTVjlVSlcvWDEzVjI2N2FHdWNib3drc0pxTitpZTZXK1lLZ096Tzh5?=
 =?utf-8?B?QXpwR2QzbUdNMzlHV0EzcFdrVVkxTFpvR2Y0NHNwcTVIY2NYMnlud21vZ21p?=
 =?utf-8?B?VUZ0aVFTSm9wbmxNOFZJQVpJWWNGTVc4eWJDL0RBOHlCYUExeS9oRURYYlNm?=
 =?utf-8?B?NGlWQ2hjb1RSZzVxczArY3g2STBrYUIyUHFveGpNUGF6WW4xMVlXRlBlcWo3?=
 =?utf-8?B?TWJRRVNaVGpzTzBrbHRwMG5vaUpUL3M1ZGtkeXViZmJteGwySXhrNjJzUnhJ?=
 =?utf-8?B?blEyeEJGMzZKOHpuU3gwMHF1Rk5OTTFWU2RmK3JxYzUrcXNsTk5ISzJGRHNt?=
 =?utf-8?B?a3Y5Mk81bUd3eU90K0hRWDNPRm1qSHV5MU9aK0owWVF2ZUpJVEZBUTA4aEJ3?=
 =?utf-8?B?OVNkRUxncEhSZGtIZ3RWTERvbzRUOEZ0RXFveW10VXlJeGNkczJRSmZZcmRu?=
 =?utf-8?B?cmJLNHFNZjd0dTV1S1JBbTQ3Znp2Z3NuWGFwM0IyZnc5Wm9ubjhySGN2VU5m?=
 =?utf-8?B?NzNhSzk3TlFzTzd5MjYyYkpXc1RvZFFhOEZLMlU5OHZtc3YxbjJmU3JxbUJj?=
 =?utf-8?B?TUViVzZ6YTQ1d0hlTG14dXNQSlVVbVJHNUswNmg4VHlKL2NpWHk0bm1WYTRn?=
 =?utf-8?B?YjNWS1BIbk1uSS9RNUJPcStIckp0dFFqS1JNaDVsVkpwWG9ieUdUaCtsVWVO?=
 =?utf-8?B?ei9GclNWUzZsUEpNeFpWS211Q0tNeTl1WldrTlE3UW1KUnBXa1ZFNHFqT29X?=
 =?utf-8?B?S0tRa3BPbVZ1VUR4UW1FV1NwOExqNTBjWXFVLzBiSzg4N3dMa3FZVWExanhm?=
 =?utf-8?B?NDQ3a1RaSXVXSFdjOGcwM2VmeTh6QTBUSTZoUkRIWFEwRlc4N3IrMXJYbUpx?=
 =?utf-8?B?V0lqRWozU1poWDV0VXByd2JJTXRrV2FLSjU1OHZOdDQvTnVyclduVEJ5VzAw?=
 =?utf-8?B?YUFuRFowblJlNkc3d0FkSzhJMzdwN1c1dmw4UytHREVYRUxnSHJPUXJsOEJo?=
 =?utf-8?B?ZU84TU9hSEwwNC9vbW9KajlrSWY5V1ZnTjFOZHdjTUhnSGozNVRVaVNPblJ0?=
 =?utf-8?B?bEE4QnhvaTN3OTRLc1JXZFlBWlUwYkF1L0NlMlZYTkxMeENQV3MrcFpaTWxC?=
 =?utf-8?B?cGJxUlZZN0pXUkxnUGx5dzhiUGp0cGRUd29MMlFGRkp4ZXhNbmZRZlNEOXJu?=
 =?utf-8?B?SFpFdEh6cVgwa01zcHRRVXNDRmlzT0poSWY5WmthbzZuVHVyTC9Qclg0eVY4?=
 =?utf-8?B?K1dFRHFwUzg2N3RqNXJJei9oVDlKNlpqSEdlSTNMcC8vcXZscEhDWkxzSUxn?=
 =?utf-8?B?Vmx1cjNySENwbitDUk5SRnlkanlaUkxqcjdiLzNzV0R6cFNqN3d3VXFSOEpi?=
 =?utf-8?B?NEhkTFJXNWFjcXhpZVRoZENHbTJYSi8wYkYxT0VFN1YzMS9RdDdxb0dRNkxF?=
 =?utf-8?B?b1pKWGZRNTVQWk83VDliMXE0YmRlR2czN2J2QlVBUlIyZlJ1VUlIdGFWN24v?=
 =?utf-8?B?UjNKR3lzSHk0eHNwL0QxdVBRZDlZcldQU3JjNUtCNk5NbmxwVXZtMHAvN21r?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eb918e-12a7-4155-c169-08dc57e65052
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:09:48.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ub47JUpYc57EiFaNvznpg/x+fIxuCIuet/JJXp6saX5twOVg0laAedp+6KqgjBKq7h86/L/dtkQDVNcylTKsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6831

On 03.04.24 23:48, Richard Weinberger wrote:
> The function is unused since 09f8992a55be ("ksrc: rename as kernel").
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index c9aeeb4fad8d..ed168773247f 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -66,18 +66,6 @@ patch_append() {
>      fi
>  }
>  
> -patch_ed() {
> -    file="$1"
> -    if test "x$output_patch" = "x"; then
> -        ed -s "$linux_tree/$file" > /dev/null
> -    else
> -        if test `check_filter $file` = "ok"; then
> -            patch_copytempfile "$file"
> -            ed -s "$temp_tree/$file" > /dev/null
> -        fi
> -    fi
> -}
> -
>  patch_link() {
>      recursive="$1"         # "r" or "n"
>      link_file="$2"         # "m", "n" or some file (basename) from $target_dir

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

