Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2114.outbound.protection.outlook.com [40.107.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271813E88F
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592612; cv=fail; b=SJ9zNapuJUZevsoSdeJQIMPmvowTG1ByVI3MSwmhQyNJKNBxU6/wt+Vq4c10aJQ5D/ghHtaMbnh/ogmhoaGmzA+OTwjrO2yEoGxOBfJbkRBosWvkWX03R38vTQLnrxX3U9IujNRfbP773WHvGlA8twke1edJQwid6fEkTMurK6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592612; c=relaxed/simple;
	bh=i905M5a8iOTpLltghZMZHAlLCFlu2fQQJrR4SLJWS+4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2HQPFIZJ+2cdkgKsyIt2V8aHsUIPwkfw/GbddWJu5lGpn31kRtFvm/WxClS8/KsWMqccIiO1+wfJ/QNFZjtzroXMBkOzXupDGKO0eRrxLH+w7q8odDUu8V7p1yzak0J/RIp7XeyLzw39EbV71AEsMSBPGhp3/g5dS2Zj2GU2Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z+WWvG3C; arc=fail smtp.client-ip=40.107.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z+WWvG3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzqO5/+zsDOrPvbT+XpLPlCu7Fqdio4vd2VMm7SCOG+DudgGx1UYyrQ6H2CNd26pezzmo7Uju52DCqhKvlF8sdWbBtXrzfrVDL++AvmApUOTIA3m51c4Cm4FNiWflDo7kK998F/ECD0Ft19QEKtqXX49v0IedcRwZSmJMRODGIV56fNI/qRw9XhUKsvonhgXLiK0Mcr1J1lqiCBvaozY7OSaXklGpA/z17084v0JXYsd+94ol6qbQGrpinjmF8SaMJIwXTSRF5RJTgyUGOZH9PH6Fk354oA6ZgViqFHeTVsxqDpvwGHuVJYDQ9sCLY4ON972GIpBB+IQsA8TjnZRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRY6yY9x7EpEIoO+PTza+TbV2lA/VNblnRFCdRCHZgA=;
 b=TMXuRJUS9qyoHXLEaiMmosP7qmSSOLptI07WL8UFzWvRwlDfcplInHAWO2tRYQXsIi5kAyTkrHVbBJTo1+0EbqU+zh0aBRErQBFCBta+/vCcl1IV3VIQFELIQX8IzRPccPPyvYjula6mpqkfgKktnnFWdEgKTXuPSHPv47kzKb7NYVcg4aiFeZZA1uD9MtBht4OhjizLgIbbrrfpxQzXELxPifCn602GXC8eL0+uS72w35TOXzD9lPxDKDZHnE0rLHltz8HsVIJSG7fQ8c/3m85uKP2JGZiBl8SxMbCxvr3qDvyPPyCwBb82foMatXB3Ab6AlDHxpcyacBKido/RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRY6yY9x7EpEIoO+PTza+TbV2lA/VNblnRFCdRCHZgA=;
 b=z+WWvG3CoKt4sG4bRjc0U+CNAly7C6DwfmMnsusEYD8cjtEeE1UnJWhrIc/WRmMwGmZ78uK27xVuR+DwCBDoVMr77D16+BAi8WZFeIY7sPoxJ6Y89kvUOXPQcWxED0XB6wNEIdlhJLZa243N/nKYHhc+MASwwGjCc2uyT/X6Y1j8Fhe2e9XLmB5YuByHf7e82xuSjF9pgSIiv//8LpTJX6zGjD8zpQD9OgWZNDS5B/UrNTup8ueTiFl8bomwwUg6yYOKQplVdB4F9bgC4vDxmskTxOu8xSEmM3tVjjMTA0z3FB1z4fgCkTxvx0214HhgFdsyUsNStUApp0sTHCtY9A==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:10:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 16:10:07 +0000
Message-ID: <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com>
Date: Mon, 8 Apr 2024 18:10:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240403214811.8979-1-richard@nod.at>
 <20240403214811.8979-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240403214811.8979-2-richard@nod.at>
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
	tB2AcgoNFCRniW4+7JP9xVkmScX9fe2itXWfnI5tagytg+43sN7mfBkl5g9bZlfYHi4nbe8JKwUqBgDz88blPVC2cq9IeAswFrB3a6GsXO1UF7crb5dRIJF11k+twEg2iCJmAw0/WPW8CQJ05b7UPR9Aw199IcaRhjctBhquuEeBg7+sk77z83+GO6au+P5JgKeNdBb+Gj6D1dUAVmStJrDHTysggCjf8pySShsGTUyXtDXoLS6aXFMVwlDM/Q6xUPqNbqlMoF/hEnb5mwYMQPxhSWjsvkOB00tc2Gqq9pWqnsUJTOqdxFu8BuCUxVlk/PQZ1ZNKulKPP5eMPObJ/T9cpB2dkOKHAAx2smJkFwAfigyHG7lQxjHrvrIMvcVX1vUADzldjvOIqFQsX53AzwfJmrETrOAw3kmRZOqnIXW7veMK3cu7SqAX72pw5MGKfa2GpDu26dy2192ehrgW/8XP/WJrT91BHqfTvdz86EMwuvOqNg8PBv5N+l0hk0qdOGP49zELNpAy7VbD3f6WUT/2JakZ91ojLF8qDWtHY8tWQXXEWDlasryB3rFz9c8H8gmGQSkwgSO8obCw3uF3lyLNSEwCUnudRvG3BCNxgAiEAiIujwIYYVtSq99dXUfmMAg/XqarcCdl1tUWfKU4lcYVymWFwNMy6FZqbhv5Rt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clpqdlc0TGc4UkltTDgzbVlRYWdaMndpb1p2Q0ZHR3EvNXZwNmdvektPdWg2?=
 =?utf-8?B?ejNmUy80dUFQZ2pSUmgxVUl4TkNCUHNZMXZhLzdsellKMkNoWUErTEVKQUtj?=
 =?utf-8?B?d0FOdjQrUE5YejRoMnljeWpKNTZmWTJCb0JaR21waXd3Q09lSWs1L3lwSjdC?=
 =?utf-8?B?TURWUXlxbmErQWJyakh5N3NsY3dvUDhsamRZaER2OHFxV0JDcGdGdXdHUDVj?=
 =?utf-8?B?N0lqYVB0dHkxR25LVTNkY3VYVGlxek5JNm5JZFJja2tXSEYwd1hVV3ptQ3gz?=
 =?utf-8?B?WVh0SUk2L3Vjc1hENThEeEc3a3ZJS2wyQmMvajUvaXRWRVhXd3o2Rno2b01H?=
 =?utf-8?B?R0tvTkFGMG00Vng5QkNqQWxFYUlwZWVSNFAwTWMyKzhlNmpVaTB2UHdaR2Za?=
 =?utf-8?B?a09pQ1I1TkJON1N0RkF3OGVPOCtQcWh1TmovVVJzT0dnb2lvUXRST3JhYVpI?=
 =?utf-8?B?M1VqZHAzZ05BT0xYU1NCaVZYb0dldHQyZ2hNeE5hbUhvTnRpVHM2eXUrWklN?=
 =?utf-8?B?SFJ6UEpKS3pFVUlCMll6emNFbUFWMHFNcE5CM013T2t1aHFndGJUU3ZiaUds?=
 =?utf-8?B?TzRZL3ZLZnBQM0dBQkFSRFhtNWJWMzk0clFERkkzVkUwYktmTHJLWG10VHJJ?=
 =?utf-8?B?eHZkdTJQSGlFcEd5MzI2Uk9rVEZvMitoRkdDNHZwa0pINXFsOVBGWUhkeFpQ?=
 =?utf-8?B?KzIrSmVuNnRmY0FXdGJ2U3E0bk9YQ0g5eWE1TFAzcGhYVFlaSWYxQzVrVWtP?=
 =?utf-8?B?MlloNUFVRzVPWGdidVltTzhZY3RPU3Q2U0tUTzNqRGU3YlNIWFRZVzdBdjR5?=
 =?utf-8?B?N25VaURhSGJDZmxIcnB6V29OR1lMMGpPSENFSUhuY2pKamdSRmhjZVdSZngw?=
 =?utf-8?B?VWdNcFhMd2ExaXpkRDFUVjY2TkNDbGYxdFhBKzJ1NmYzZjU4YjZ3TWhtckFt?=
 =?utf-8?B?WDQ0OW1qdjJ2ejM1cWpVM1l0aHpqNDBHZi83M2tnNHJNbS95dHJmNUdab09W?=
 =?utf-8?B?R1FlbWRKRnYybmNsenBOd3NqR2REbWttWFoxRHVMeXFuUWFvVVRvSmxaTDFn?=
 =?utf-8?B?VFdxelNvNlRvMFd0TkRJN1JYK05ISVlFQVFtdHNLRHY0Tnl2Zlh1SFdIVXhO?=
 =?utf-8?B?TVdpZitLbzFEWmRFSXh0QVlZYWQwbkF4aFZtamJlM0pMYmgyME9LbVV5MEtL?=
 =?utf-8?B?Q2F4cnR0TlhJY280SkxnT0pmMm9XRVNNM3hKdzhRWHBaUGFSb01PeTFrcHNJ?=
 =?utf-8?B?dVZGWjhsUkhONnFjY3dKR0xHaFYwcXdYU1d0dUhyemlWL3crQnFoUjk3alJy?=
 =?utf-8?B?ei92alFrano3Z1paaWNJaDRKbmJ6b3pZM0lPWUZjOVVoK1dGUUdtSUdDVWhG?=
 =?utf-8?B?YWVoSWNjT1k4OGVJQ1R2NDh4U01MN1JvR0FpdkgwTmsrbjlRMmN4QkJBRlFT?=
 =?utf-8?B?cWY3TE5yOG1FSDRwL2NiQ3plb0JYUzdvZmZRdzVwVkZESUFVelBMRitZU0Qz?=
 =?utf-8?B?RDlqNWhDZEpvVEZDMWxYczhyaDhtMEJNRU54a2FyR0xzZFJRbElMY053ZDZC?=
 =?utf-8?B?ZGl1aWhyV2RIcG5mSGg1QWhVT2NYZUM4QUgrOVN4cTJuQzNhcEZzTWJjSWtX?=
 =?utf-8?B?WWVkSktRV2hlWEtheVhFN1pCUm5uMkNmSUg3SUtWU1VBUHB5ZGJBU2xlbEhD?=
 =?utf-8?B?Ni9NTUlsWEtibEVoM1hya3d3U3o2K3M1dTR6YXM5YW1xUjMyYTZ2RU9Tdk43?=
 =?utf-8?B?MFQ2NnV4ZlhNRy9KLzgwMitzNkR6b3cwNG9wVm1jdG95alp6NnBiRjQyVVVK?=
 =?utf-8?B?SlBGekNlTmNmWkZ3UTJxbDNYajdOTDMveW96bjdyb3JQUVRaQW5rUjRXOXov?=
 =?utf-8?B?K0tjcDRpMTFFUWMxUUZueFlrV3FqR2FDNGpUNUJyRnA1dEoxMTY1SkJqVFEz?=
 =?utf-8?B?WW8relEyNXZLM3p5RGxHdEh5QnBXUER2U3lNamx1b1V2NXVhL1N5Zmk4VXRM?=
 =?utf-8?B?MHozZFh2VFA1WE9BWjhKQ01Za0ZYaXRGK2hXNXRmY2l5SGNhdkdZcTltY2Vr?=
 =?utf-8?B?dFJjRVRtWDk2RDNzVHJKaDdkS2lKSm5Md0tQcENFOStBQ2ZUZnhIUUk1N3NM?=
 =?utf-8?B?WVJZUWMvNHRyVkVtOWlGbWc1c2hGMTMraTNLTHlnbSttejFQVTRIbWNkWVJX?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70597f4-e29f-4276-c27c-08dc57e65bdc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:10:07.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgMXGuJgAgSUdf3Etg4s31QfyVm/fPpFBScACOw2PGETV7bANwnFEvjBAY4uy7xAFcoMmqkWHLcao5DyPabsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6831

On 03.04.24 23:48, Richard Weinberger wrote:
> If the target Linux source tree contains stale files which
> are owned by Xenomai, the result can be defective.
> Detect such situations and warn the user to avoid crazy errors.
> 
> It happened to me twice that the resulting --outpatch was faulty
> because my kernel tree contained old Xenomail related files.
> Hopefully this saves somebody else valuable debug time.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index ed168773247f..f9cf9933da88 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -107,13 +107,18 @@ patch_link() {
>              d=`dirname $f`
>              if test "x$output_patch" = "x"; then
>                  mkdir -p $linux_tree/$link_dir/$d
> -                if test x$forcelink = x1 -o \
> -		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -		then
> +                if ! test $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f; then
> +                    if test -e $linux_tree/$link_dir/$f -a "x$forcelink" != "x1"; then
> +                        echo "$me: warning: $link_dir/$f already present in Linux kernel tree, resulting source tree might be inconsistent!" >&2
> +                        continue

Does this actually ever trigger? Aren't we deleting files from the
target directory before filling in new ones?

> +                    fi
>                      ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
>                  fi
>              else
>                  if test `check_filter $link_dir/$f` = "ok"; then
> +                    if test -e $linux_tree/$link_dir/$f; then
> +                        echo "$me: warning: $link_dir/$f already present in Linux kernel tree, output patch might be defective" >&2
> +                    fi

This one makes sense to me, though.

>                      mkdir -p $temp_tree/$link_dir/$d
>                      cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
>                  fi

Jan

-- 
Siemens AG, Technology
Linux Expert Center

