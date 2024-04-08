Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2118.outbound.protection.outlook.com [40.107.7.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3B1422AD
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592598; cv=fail; b=W8ZEbjXrghM4P7Q/jAnBiY5ysuQNiGW5iFbPGeoEneVbijfqpaghcQOZfnI/Gp87QS8L1d3Vy6yNizaawzp6lAP3u7ap4ENZrfEIk7IIaWEabF5A5TccjB8n+812b9zW3u5rsUKMLHuQA3jHq7MxLvPlVgepJ0yWXoBFXFaqUn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592598; c=relaxed/simple;
	bh=s//eN13cqRgU3REYAerp61tpJsEv5EIAFhGc0nZkqwo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S1iDSjj1yWtt26ZW1Rg3iYx2HWyqIaLgFcQlQrNTNgpl0AyxejEYZcnD80zBJi/qj5aHJ50J6TzUnRzXoTcIGHEsJKX0j8FH2VqrnBUcdDBipB3STPffgbOocsXfL4wlT/frxGt57tcTgTmDywgIZSAmMHWGa8LSKitbe0Wr22Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ln7Av6AQ; arc=fail smtp.client-ip=40.107.7.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ln7Av6AQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4bucLounCnOvOlD1s7O+I+UaQCxZxi6iTCkufPp4FnUOeWVt881pDhoC9e2IMiqmOz/E4PS0ecUmvrNy3TFtmav0aH8W5TBqWRtiBqp5Y15KViix6necFqsrFUmJZbLmrqqZkXd83LLWbj89TOfPZjk4F2ihgi63HqIgca1cIuUF1dhn1xgapqn8jUbVsxyP0WeewcoEA7vFXBB0GQQzVs2vNFBVjp+MfpUAJbYgHrSpStUTOV8e4EfC9WlM+7kCKdWkN8ngOV3qb+38o2V63ZQ+Q1EoEqHCy/XwWzH6wDFmuyLvhyJ6poZYb/rZXThM5lBf5HX+NmeH/bKBcISLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51P1Ku/qe1dGrdmcTLsoSPYrWB0JIhx/UOrcR8tTryw=;
 b=APApcwyDBdK3PLohIAnt1vK8I13aldB/ytUNuUxvb919tdD7T+JpwvjtYB7AlqfI5nddOTFRfHxngFVYN4jH7IoI8S+FJlABnDZVRgUn+k5JynxKzAi/DM++9o/vv34FctmAVXoQx1Sx5WjPCdBLUwTlbF8aZ/XfuffvT2M9DO4XHjszqRqUKCMlrKBDtOml0QhP7vvmoF/DgWe9Vl6yJKj0KuTdFPlFG1eX/dYrGCYcx/xAg81kdpXz5SIRia+Kiay88UG7sk8gaZpSmY6HRfZcE72T/u84ZtaM1nOMVvSIuwwwETapUgsGHdkahN2OynxdOQ9qaIHfgoBwT4kTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51P1Ku/qe1dGrdmcTLsoSPYrWB0JIhx/UOrcR8tTryw=;
 b=ln7Av6AQVEMo7FU2LTZhz0EhBtnw88Bg6aUPCsNmBEdTl95r60dlIkewZ7ezeDu0H5nna6skd3pXjw5ZdzWEcqPQcN6eH7bMZF8y8qpCkPhhTRdf1XshZPdu0mAkaGeP/xVZCd9R7yJXjAzcxnb9A1nW77+7CntNPbxdHNaD9E7BAa8IRsS/gOOh+WDB1etluqB4wiUU5YBmgNW+cagqli2xnW7wu280aG1ZPGMNJT9ub0VrUmp9o1JRjXP0NhEpujhkEQhcsuWI1X1itljfY5ZyNgPehxLE1x5vkm8JD+jzQLfvBU07KitmPMPkt2Nz+Rl4LtQanPonWZcl3dStzQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:09:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 16:09:50 +0000
Message-ID: <cc9e1caa-b104-4ee0-9e22-651ec3a4de1e@siemens.com>
Date: Mon, 8 Apr 2024 18:09:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] prepare-kernel.sh: Remove dead variable
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240404093040.15605-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240404093040.15605-1-richard@nod.at>
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
	lQ0Q+PPUciQbqIiucJ2X+c0K+Add7/zC5gurhRgLCE0j9uLgo8HJW8DpY9oeRk8JXBLNHNvngqioNNWKYUs3S4x7MfJ3fINSAjWhIFxIdQAlXmkA30i6S8Zv+TKNvBPjU4zXA+wqVQpZpIfAzkGxLI0DPG42vo+mBZR4XuxeDhBT/zB3zk+LnGW5R3a39tfCtlxtUxPu0SyJ0Jp70Gut6bOpczSAzkfzZg4K73AR1xoCk/wPlDC8tSJ9OhVgOeWF4VQjUrG8Hf0DjsRzJB3Ne07Kli5PrzLiIgfm1fL/zm7JV/Rkzk2KhUXEsO24OLTmy/LmydI7wjcJq8FZXhXj5MEFM75wG0DeuXweLf7w80E41KoI+Ip8hAloAkyr5mIQt3wzK+Ek5knvQbqw0DxmFoq0+81SzdmZ6BMnG6PPoVe4CxRbD+iBU5txdmwLQXFa1LgfVxOX8WmXcnaJnbUS18rSvM6jFzdn4DRW4I1p/y+OZWY6+jX274USpqJnwaf/wGYfOStpi17DxTztxgNWpqznIsOxHzBuVsgc0eEP2yf6FQ81zbPwRm6v4/NqmryGFG74TqSei7bQBOaI87o5iJ+nrsyesSrV6fiTx1N+c8JMHAvlq/+sLFhWxrCgFo89u1PBsHVo0+owHW9A8DqvoWLxp+KudUiuGAokoiSXJy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGVsOUo5TnlCRktDS0pyMkk3bHJqN3JWalB4N2RxMGR6TkhVZHNoTVE0VzdB?=
 =?utf-8?B?WnJIai8wZjdUdnNKYlFqeURnM1JkMjRsWFVOME1ZUWNvSmxQVGU2Q1ExY0Qx?=
 =?utf-8?B?WFBCaUZXZW9nWVBaNzNVV3RtRXJDZE5KdDZ6VUZZaXNnaFJUTkY1dHhzei9n?=
 =?utf-8?B?MmNzdGtnQk5mQXlMQkJHd2ZlcHZuc2hzVlE3bWc3NmtqbjZSMGkxb2JCQlE5?=
 =?utf-8?B?WGYxMUZXcTVHYnlOM2dONWQrc0Q3aTk0S3BKbUFMbUZQWE1tWmVJUUN4V3NS?=
 =?utf-8?B?bHlXbDNmT29GSzJsK1JVR2VIUkRRYkord2pVM04xanRUNit3OHBlQldnRUM3?=
 =?utf-8?B?QUtmUTJETEszNXJkU0hURXlPcXVBZGFCNm14SGNEU2tmYSs4Qkx6Ry9oR09W?=
 =?utf-8?B?TkFaMExKY2tpOWt0djdHMTF2VStTb1V4U3ZPZ3Z6ekhEVEpZT2R6eDFzWXpl?=
 =?utf-8?B?VTMzQStKL1MrRWorKzFtcm5OeW43WFRPUTdOU0RrM21RemxYZU54WW5sY01j?=
 =?utf-8?B?ZjNVRnJuOVFDdU9tMW5kS2xVZ0dVdUprZlZQTjNwV1lwbEtmSFBIeDNHYnhn?=
 =?utf-8?B?T28xMzlSU3REOU01YWc2aEVPTjRRWDNzb2w0Wm1CUGxzUVhOalJXMmNDQlIy?=
 =?utf-8?B?eFc0Z2NwTFpEWkptVGUxTDVuRXYrdVZ1YjVJYlE3SU82KytJb3p0dlN2MlRM?=
 =?utf-8?B?VE8zNm4vTHk3ejhJNi9sL095cXUvZm1MR085Z3MrSmdZbVhyeGFkVFVzK0k1?=
 =?utf-8?B?K3Axb0MyZm5yTWdMWm41UU9TV01aR3U5NVpXOFRwZm9rb293cVZVd3QrVEVr?=
 =?utf-8?B?ZlZORVoyZUEwTnRXUHd6VGd1SnI2dk5Ya2d4VVp1SEZ5em0vL3lFWmJPWU9H?=
 =?utf-8?B?YTRON01RZUx2dGRTeHMrdUZ4MXJUMTZ5ay9YNHkxbC9EYWdnMFRYRFlFL3Nt?=
 =?utf-8?B?clRoRXNiNFJ3NHNtcjZJU1pMNkVheWovVXFuclV6ZDFqaHZlQ1BTVUVMU0J2?=
 =?utf-8?B?bldSMXVvc3Q4Y2ZFNUtmNXNZOENFaktNMW9TR0NObU81dFpBRkJidnkrajF0?=
 =?utf-8?B?ZmtNKzlyNjVncHh5bHV6REdET083RjYyL2dNdzg2Zm5SNk1rM3RqVCt0WDVY?=
 =?utf-8?B?Zk1Pbzh0RjhGL2NYM05sVml2ZkdnNnFjY2F2MjZsckh3VDI3Tnk3STZnRmFQ?=
 =?utf-8?B?b2hUQnlwTXp0TTdFNE1kY1dwcG9jSExNZWdQV3ZuR25EeDcvWHRmTjN5SHJN?=
 =?utf-8?B?bk5vN1gwOHRwenBEWElWd2VXbmROaUJaV2hYL2F0OEFyWWtub3lscGdLcWdR?=
 =?utf-8?B?OXpSTlFyME81dXRnS21qZmFZUFVNOXJwU3AzZ3pNZXNnRVZjOGppY3FacVNu?=
 =?utf-8?B?ZHh2MDByUk1wRmhwWGNRQVVCWjlMRzc1RVI1Unc4cTltUHpCVGUxbXVQeW4x?=
 =?utf-8?B?aUdodG04Rlo3SGp2a0I4YlJJdldvSThiRW40TFUxUCtGUVduNFdjUzNEcEJK?=
 =?utf-8?B?anNQKzJrN1BmZHBVRkcrZC95SmxuaTNYQWdOVzZIVno0OVVrTU9FdFdDeDcy?=
 =?utf-8?B?TXFiUDRmWkkxZWFjMDlESllKRXdFRjlJWDc1bUt3TlVPV2pJUFptdU5QaXV4?=
 =?utf-8?B?SklHQVRFMkFWU015N0xYWFZISU5WVkRVNW0rakpHbGpoczlabVhnUE9hb21M?=
 =?utf-8?B?MlB5cDUrU3c2ejVYSnF4WERTQzEvVHNaU3V2UE1lN0xCaXkrOXM0Y3MvdGtm?=
 =?utf-8?B?ZjdpZTVqanFHd3U4aVFlM3VUZ2RkTHY2RG54VlM4WjJxMUpwNmhHNHJpSzB1?=
 =?utf-8?B?VEV2TEs4VHBjNlQ2UThyTDQ0dkc5MlJtWUN0TEs5ZTcwalB5Vzc5cUNVY3VH?=
 =?utf-8?B?NHlHUW1sSGlMZzVrbkJWL1YzZjB2YzdhVXpsNmFab2xKaFJCT0llQmxBd3pw?=
 =?utf-8?B?c1ZYRnN5clJVdkt5UjBPUWhKTHQvcHVRRFR3enJobk5qc3ZpM3AxZFlpa2Nm?=
 =?utf-8?B?R21meVpGSFVTaThpR0JxMG9RaTk2akZjSjFKMkdjSVJ5S3U0SHRkRmluQi94?=
 =?utf-8?B?Q1dRQ2MzYjlhbmJNbytQUlVsNVFuTDZxSjNsamFaRGh4TzBkSHVZdU1ORjN6?=
 =?utf-8?B?WWhKNllrK1lWQUlna29TZzJ5L0dtSjVIQis4K3JNc3VobVlBN3h0UWcrZnQv?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b983a39-f208-4091-073b-08dc57e6517b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:09:50.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NX11EJyKWWMqRxqnEXWYpk919ZPjfQEsYUiApXZCwdj2zQXthPlfqX89fHv28B2twbnlycWDy2v9dIMy/3EH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6831

On 04.04.24 11:30, Richard Weinberger wrote:
> linux_out got added in 2006 via 68d0bf171 ("Allow configuration over a kernel output tree")
> but was never in use.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 64e2484e1..d50680dba 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -241,7 +241,6 @@ while test x$linux_tree = x; do
>  done
>  
>  linux_tree=`cd $linux_tree && pwd`
> -linux_out=$linux_tree
>  
>  if test \! -r $linux_tree/Makefile; then
>     echo "$me: $linux_tree is not a valid Linux kernel tree" >&2

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

