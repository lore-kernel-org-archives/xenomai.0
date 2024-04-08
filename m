Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A061145FE6
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605342; cv=fail; b=RZ/ccwx/0NVVCeWtFfDsUb52FxOPeS6UDYgC0zlV/eyNOPOizAlNqACHBc+hm76YxGaPy/UzcJjbzYCnHHw9TXcgouKf68rZz4XteS2ffcIKTooZreu0PipTmftoh0EbpwyufuxuX9AkUAS/vNe+/RxDScJ23+8k8Uzip1BDI14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605342; c=relaxed/simple;
	bh=BHhYDnzEWgb9t17TYK9urzdcl/UpO1B+D8loLCAPIlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWkOX8jwG4NC9sDf3cfNGHAISMeRFGteLuKzHz18YBrDYgeaJXbfqE8nFz49NMSCa5rZoyhxcy/XbZYFKmZMm20A2fRsnqpG3XcxXIdFKjyxQUj4U3oa62+gGo+CisMwnL/ENui/Iv8t9T0yBcieHLHpYuTXeb8CgEOG3N0Lirg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Yq/K+PSI; arc=fail smtp.client-ip=40.107.21.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Yq/K+PSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgdDl6pih7gp3IakjXATJxx1wMh+rS4lNfBNQUfIyKyfLV6XmXS7VB+79/jGCKg6oNnkmTvJZa6QtIVodNPa3+Q44fcTj9LgiGGtu+5KkrOm5Ut7hnMeqNqcgvh2PnhPYhkbu/keTM8fEk6vMqxV9p1799lDCmMk1cBXPeEOB+PQKaU1me1V96bjrqJPvdT2BvbBF44hyWava82GpQQljFWmjTBvyHok8kMG6c613UAmgf78Z+a3SOco1mA8FR8B1Ymp6ve2kMecoFEfxvoaAXjjqU+JK0lVrV5/cm0MCELCNjnV1os2AVWraDnXSB1FiZUCiNpCNUkShVoyiXgCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTMGvKiLjPjVizXhzBbymMwJ6PdyhKIDRz6q15GAsLY=;
 b=DlQZdVo/fYX9hT2RCY2A3GbiOyNrIiZVGw982YB3B2dolCZQdYsgj9tObSoIIC9az85oi0IVgnjGw2Ff390lnUR89Cxc1FBxUXs2aE1BDwVOpXR0YNIFpdkB9XS4JEiXrVwXj+m/y9Q9sVxsDDSSMPsQWXwjuP0Rzp4u5aWKQrx0rgxp/UwgoxrvIh4VyqeDVx9spG8JlIcDKmUEXpX8puWxrZSm/sOwOqky1Iebl4t+MkmesC5iA1w5Jy4ysEQxxIr3yYPmrlDgwjgx8WP37f8cRH+lsxkvM+s3ymqnh/9uT6LuL4AaBYPxVWrozsFuY3yo9MOH66jKhs/EneZ+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTMGvKiLjPjVizXhzBbymMwJ6PdyhKIDRz6q15GAsLY=;
 b=Yq/K+PSI5XhpurQ5sQ15DsjpAjlHwIBUYCGmXmILCHFJGVWk3xTt8og7S2gdze4FnyltfJRcyhOI4KxtMQVc9vMFjV6oitPxMV/XVQlPjYX4UoNkgE1wYPP93otSC6+zFaB7qNVdzDK8X2bnwZZGlIuMU/lWB6y0sHdhF4z9n1aNAOUyVPPEQ2/fcCTLStaWAelc0oO9SnFMMUjbs/HLZYFqnWZlSok5rO1sx1DNy5uBWthp96uUq4gP4rIfX1atdwfUdfS+qTe3wv/A1H6iRT1HI/cjM5/0eRl9g4+O6IBxkku58xt1/SjCd0cZKj38zk/XNA7trSLdPE/DsgRraw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 19:42:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 19:42:17 +0000
Message-ID: <428fcf0a-6471-499c-b6b5-cdf102a0f69e@siemens.com>
Date: Mon, 8 Apr 2024 21:42:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240403214811.8979-1-richard@nod.at>
 <20240403214811.8979-2-richard@nod.at>
 <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com>
 <CAFLxGvxTuEF5sseZz4_tAwA=YLj95rZzFOM+TyYEvK_K1zxn_A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvxTuEF5sseZz4_tAwA=YLj95rZzFOM+TyYEvK_K1zxn_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5329:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lZ+s2m7DJqkF5mAQrR7KRKxnvT51gFtkOMDgJxr9D1b59u7Nz7+S2kEe2s67TdY7eNLdB0THm8mLiz+X8SZX814CsKX33bC/QZ7gtk4+GvIKbrkEKPiILfpiyScgnyoBhA/d+NWxOffWrGC0A9wzG8t48VO1zYR92T4q3Z5BVJ24H/Ju0p4GcfPWhTInMuMyU1rOllNwSxmlTl5Ti1sA+S0JZRRZZsR1/6OYPOidULprzpPzQb5oc6JnaPEtkjJXTTUGVJ4/hOIurCwFHNMYvXcWc017bdXfr6dJKgTbmuVOaBR7HM8FdRsJPtuji52pPv4dOIojxgB3bW9GDDTF/Sy9VIBuh1FVuWdUvQLVjmMRbEFokAnxveszmJPacRWunpncrfEByuAQTcbrj1UNNte3P56DGozUiGcfX5+5BXT0mQkWwoJAGaCXCkIoEiecOAe/ErM3X962rMHN6IszgtGLaDmDehnHu6B1xDnjBjYfh9LAdHibNzMj/4YjG5Gs01BQYmHkF7PfzkG0SzKY4byIF22R+8N8CcmDwnSeEzVhRPkxGImi5CjmvGOlZai5XYntzcE2GPrUjUWIuL/ZhLE6wRE38LQX0cx/mBCSDB1g2OHQu0VuJEyyQXQtIGdqVxCn06fK7zRCWYGje6Zha0GKYXS6+QFc3Z3BITqEU8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUdUci9CRmx3WE03WjBKYVpFTFA3SEhyQ0VZd0QzZjBGempaQkVja0NqWlZp?=
 =?utf-8?B?clE3SHZ6K3krNlNzWUtFenlPZGRkTmFsTHVoeGxrSjhzODFrQTVUeWprcU02?=
 =?utf-8?B?ai9nSUdFT1ViMC8yNlcvQlhLUTd3Zk9WMlAwZ0ExMjVDdVZpWFFMRVI4Q0U1?=
 =?utf-8?B?MlhFK3cvVVlOZkp3VGp2UTcybmlKZm5OWVZSc3NCY1Q5cWVhZUJGMmhWWlEx?=
 =?utf-8?B?N0tnUlI3U0lzc3UrVFY2NWI5MGJiYmFQUVlpQmhnbnQ4RDdxOFZnR040Y0c1?=
 =?utf-8?B?Umw1cG9BN08zYi8veG8zNFBaQWhNdGtxbnpHSlplc09ZcUl5RlRXYUc4TDd3?=
 =?utf-8?B?SmJtSUVsZUYzZXVxbmwzT3EybVgxeHFiTGFHV0NLZkVRU1QrcTV5NkVuWXdX?=
 =?utf-8?B?T0pLYzYvbGRZaUZ4YkpFZk1Hb0pSMXova1VFRkhtRDhwRVByWkxkdW8wQVBS?=
 =?utf-8?B?V05hZG8wZHQvRlcvSW80K0JKYU9sbVJWWnJKSEtIbnJBVk9IamdCWjhXY0dJ?=
 =?utf-8?B?ang1K1VhdjRoamxOMnBmM0xqaVFLZkZUZGt4dlBWTlZmZytWazFkNDUyV3hR?=
 =?utf-8?B?TTFlUGRkaVFCa1JmamU5U01GeC8zaGxtTG1LSkF4TU9yeTZvUnRDalcxNjU0?=
 =?utf-8?B?bkFYUU9vU292eFFNSXpDM3EyRytOZ1F1YW9YNjkvM2hWT2ttdDJ1OFY5NytU?=
 =?utf-8?B?bytnYU0rSmZLOWZ6OFF2OWpkdVZadGJtOElQVHY0MVd2V1pZaEhzOWJ4Z1hC?=
 =?utf-8?B?bWFHUTFXSk5veSsrOXUrZHVzZlZTcmFSbW1TMkNQQjJzR2JoMTlUYVpiWWl6?=
 =?utf-8?B?Z2JJVU1hWXIvdTB5UHJpcXlsSW96NEhtYzVPT2hzS3hJcnYrRFF1emhKcmdp?=
 =?utf-8?B?UjJiQnd1dlNScUtjVWpIRG03aWdoYnlNSzhGSWRFVS80MzRIVUpDM3VlL2pQ?=
 =?utf-8?B?dXVoWmRNaU1LcmdmeW9vMXJucW1YVGQ0aUYvY2JCenB2MzZIa0RXT3pubDJh?=
 =?utf-8?B?MjdwZ1RqNWNHTjhzR2Y4eGFPV3A1djZhNm9mK2lwT1JZbUlNYmh6TDF1cVBy?=
 =?utf-8?B?d2F1aDBYbFJoaVFrMHBVLzArMTh3K2xJbjVvNjBQdVNtZWNCVnVSc2Y0KzNs?=
 =?utf-8?B?TXBudHNpeHQza2VJK0xMbWxVSlU5d2YveVFTTWhoSE5HaXpPTXl4UE1Xcjlo?=
 =?utf-8?B?MkdqdHp5VTMyTzZyeEkvWFFrM3ZNZmE0Y1ZnSjNFQThsM0orTHpaT2NIeG5T?=
 =?utf-8?B?UXErd1Z0SVdmT05WZkEvemkzMkUrTUtJQ2E0SlJSZytVY0hTdDRreGNjVEFu?=
 =?utf-8?B?VGZqN3BIcHVSWnAwbjQ3UEhZUkQvWnhUOFI0YXBORmZjSHMwNnByaDl0aSt0?=
 =?utf-8?B?WXZiam10MmpsQW8rYldXVUx2cjhDY01DRlI2ejFkay9JaUxmR1BFTFJTSDVa?=
 =?utf-8?B?NFNDdkJFbUdtWjE4dm5YcXJZWXZFM29JcngrbHVPaGV4YTNqV2ozUjFGSmhT?=
 =?utf-8?B?SDc3L3gxa2pnejhoRUY3LzJYdHI5bFM5SUl1cVF0eVdxLzFIWW1hRkdPa2Rk?=
 =?utf-8?B?WXZQQmd1elRubGN3NGlLQWJQTzkxRkhUS1hpSGRzVXcyY2pHYXdNNGJuVStE?=
 =?utf-8?B?WDhPM1JQdDhOOUR5dXRLZUZHMGFtSFAxT201T1JJcmllMlRLZ2c2N0FMdU12?=
 =?utf-8?B?c3phZ2RNbVBQdFZYSW9IK2FoOXRIYmNhU3l6d1dGclRlcUFSVGF4UUp6YlBw?=
 =?utf-8?B?Ui9CUVVLY0tBMERkeCtwMWtjaTRQSjZxMzJqaHVzNlNMZmVMQllHMlpIdzIw?=
 =?utf-8?B?TVNIL0w0Y3RJM1ZOSWkyZE56b1B2K3JsbitkdWFrd3ZOVDRrVER6MFgxTGRP?=
 =?utf-8?B?dkRqakJnUlM0K29IWFlBV2VqWnlRTDdua1lyT09QYUxtU3FGR3BoUWQ4MlZv?=
 =?utf-8?B?b0VldlduU1BNZW5XYWU4OGt0c2s1dThNOXhOT3k0L3FqMGlsOHJsL1VIamFL?=
 =?utf-8?B?TmtPY0V1RFZKYnhPVlQ4cmZlVHZ4N2kvM240a0RMOFdwcU1SVFFncnp3cVBn?=
 =?utf-8?B?aitMSHNBMlJCRUhobnd1NytBekM2b3kxUndMRWZkR3pDdTlhSmhSRGttVE15?=
 =?utf-8?Q?HGLhDO7MImhrrhz+0j017Vu+V?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed343457-aa97-45e3-d64d-08dc5803ff65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 19:42:17.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T0V0PgJeCdVWG20nid1YmRZfEBOVH0UZT6rS/3bfzTvUg7uvFbKFz4riDHBJDr2xETUrvVfJwUwDc2RABoU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5329

On 08.04.24 21:34, Richard Weinberger wrote:
> On Mon, Apr 8, 2024 at 6:10 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 03.04.24 23:48, Richard Weinberger wrote:
>>> If the target Linux source tree contains stale files which
>>> are owned by Xenomai, the result can be defective.
>>> Detect such situations and warn the user to avoid crazy errors.
>>>
>>> It happened to me twice that the resulting --outpatch was faulty
>>> because my kernel tree contained old Xenomail related files.
>>> Hopefully this saves somebody else valuable debug time.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  scripts/prepare-kernel.sh | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>>> index ed168773247f..f9cf9933da88 100755
>>> --- a/scripts/prepare-kernel.sh
>>> +++ b/scripts/prepare-kernel.sh
>>> @@ -107,13 +107,18 @@ patch_link() {
>>>              d=`dirname $f`
>>>              if test "x$output_patch" = "x"; then
>>>                  mkdir -p $linux_tree/$link_dir/$d
>>> -                if test x$forcelink = x1 -o \
>>> -                ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
>>> -             then
>>> +                if ! test $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f; then
>>> +                    if test -e $linux_tree/$link_dir/$f -a "x$forcelink" != "x1"; then
>>> +                        echo "$me: warning: $link_dir/$f already present in Linux kernel tree, resulting source tree might be inconsistent!" >&2
>>> +                        continue
>>
>> Does this actually ever trigger? Aren't we deleting files from the
>> target directory before filling in new ones?
> 
> It triggers, e.g.
> rw@foxxylove:~/xenomai (prepare_cleanup)> echo zonk >
> ~/linux/kernel/xenomai/lock.c
> rw@foxxylove:~/xenomai (prepare_cleanup)> ./scripts/prepare-kernel.sh
> --linux=/home/rw/linux --arch=arm64
> prepare-kernel.sh: warning: kernel/xenomai/lock.c already present in
> Linux kernel tree, resulting source tree might be inconsistent!
> 
> Only when using the --forcelink flag existing files will be overwritten.
> 

Nope, the file is overwritten without your patch. Now it is left
untouched behind, and the preparation is indeed broken. That's not
really an improvement...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

