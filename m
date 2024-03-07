Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F891B813
	for <xenomai@lists.linux.dev>; Thu,  7 Mar 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798862; cv=fail; b=iQDFBUMSrJif40yWbDSpzGjoTZUTIrGPohfBS10ZGpEDdMGtg01DXs107ucXhbwlyiDvsnw9tzGee5sTBs9f8eAgjkcshUcCn/9krYskkh225Pi5ll5N+2zVj+INw/oYu5sJl5UT5CY3x4/VxClW0iTA8fzeLCRJ/81RsfjfHsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798862; c=relaxed/simple;
	bh=xvyxdBHPBCowvLzm3BEaPnuEtggSyolq4fs/I04ulK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ripLWkNnFKddXQXTr+Bko1ma0FA7jXwHc79BUdueCMZMmuRcrGNXdL9OgU4dm5LZ2dOv6J4uIfpiY3UzkAXp7sWVdm1IxaugquiFybr3RuMOKc1yViYHs3LCptf9rJOxhaLwLpuS/BwCquLNTiTweSaSrTlJTANDcbjAxEd5sYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SQoP5DGT; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SQoP5DGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqcesD3aW26BcYJQe/18IlfueAI+UojeE5glJwtzgbCqKFy4K64Q1bWwgTry1/s6qI0ok4VMIKSyQK//5udcLxdmMW3Un/zM1wYZF1xheTxHHbxfLdpD+5W3Ta+jDsvLzcWASBkm/ViphN5aRfCp/LtEzBWFSGh8s0BO57ZRKGRcDL0Thy9jprEfYIux+z/VM9hw1Z/xwj22gU9Fh3dUEylN/c2XugyN0IterpPoxFvDE4KcWeF/1RkgwRW9JjFa/wfEGqE934uZso74Iyg17u/mwAcylqJYffltyo2H+K3K/Ou5028WssqQ6aeXUCjCU9kbNZ3ZHkBggMD7WFTjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSzc7VT4k3w0CQQ2Mex7Oe6yX2RoLEMFCNZYXi0Iono=;
 b=c7t8jJWxFDHK/SxeUzY3N1li//hDgI86czFdI6fd5fnjAF/Zr8MtcAXDTMv4/etgzI2vAZRB481bHn1WJ0YPDwBEec8z7jdOTObvr+qX2I+SU5fS4Xv7XXR+KC/asGNbPJBow4BNWqHN4L9m7AU3LC3df++SyTP2GXErrHjfORwB5gCDPOM+/Kpq9dXJgk0kLWyIDvliQfaoCUSyXskiBTG5fk8exqzgv7kzHMTlMhPg2LBRoJwbfPcFAp9u+yXKCBlY8aehTOc7tF5Q9o8/7k1Pt98QKANSZwWo1f7i+9bbkGzqo4G+Nuj3bn9cYssb47zZEf2lgOsKlCbV/L7sCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSzc7VT4k3w0CQQ2Mex7Oe6yX2RoLEMFCNZYXi0Iono=;
 b=SQoP5DGTKUwfa2NindG7zpgflEMTqeN9qxRHpoIWDA6ZnzJ++ySRF+3nd9dwKamcj0iybntZL+F2OIE3/RHOFAA++DFxRTNV9jAsz0c9DijhG/TLq1FaDISrymea2etshxV0zoF539wf58VhivEyf163xpRvY1esvl/Hs52rTB4od598I6VLXld8KSUMv2J6YfoGNB8EZlCq94bHrX1lEAr7d8wc9suIEdVTPx3eTC9UxOHNwFTJIzF4nOQRXWvyM93j1DpiCpUVtJhcIdW00cIE+Pjtda8AOuy/s2j14nEpi3gdSGsEdaBPC5Vnd9EQ2+0dSCLhXt8ZWNDZPy0zAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 08:07:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 08:07:36 +0000
Message-ID: <7d95d478-2f28-4ecb-8f59-b59758a20597@siemens.com>
Date: Thu, 7 Mar 2024 09:07:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: dovetail kernel maintenance
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
 <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
 <877cifwx8x.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <877cifwx8x.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4956a5-2c13-4619-f71d-08dc3e7da684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EOKAIkYNlC7fTl2egQyzBFMUDfZqnNac6jhRVP83jsZGdcMMAgYYalvDDUcor+fueJ+QEueK5yVp2m1JSkEhJ0LMQToQXmaoiQRp84Ccy8z+bsDYbzJdhHz2NNA06av+fRWOE+yUProDzkpm9bmIzQmFz6a6Tl2qIVIerqCGlCvyoW/Fp0kj7EK6vXiuk5MOFmBNumaoRx5tMgOX3tqjLWiajhIUDAwn+hpBrtEIsFaG7l5KcDTIy7HPS1ZpaVDDDH1alAqwq+KxF8oPeOSR3AarcKvioubJMo6CMEfgLm64/GCJnU6yM5x1s3zOzv8/GZF3vUxfJ/93o1mYFBuP6ZDy40L1hquEGSgCDFc52ZNjKQ79LOQJEbpbO4gK2syeInXoIA3xChnmcN8WtqdeGSP+5aPnlwzinXlY8PZqax1WZG/lH/CiaZbek0B04BtL8oEIeJXa8tBVQuLDc3v/yXvXsFfuKIp+/lVp2cvTK3IrWGKqQy+7FfWAlDQYt1iysXweZJ7IYKQJ4yI6VYNjQC62mAmsLpDaOrbr07Ks8l0Ybnv+cgUTt4c/C6nynzIV++reF4MGgprNxrvzBM0Zh6N4qekT31cT77sd1NwJ4VH8azMzOIDYhNfORCo/dRH7F87GDa92trwaN1sSibBC9NGXnaoWBpsAekZtCRNzJGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzc5cmpiS2lZL2lZKzVyQXlFandienJ0MVJ1c1d3UUhmZCtveDd3cUtFZWN4?=
 =?utf-8?B?NU43MVNGcXp5UFdwNjI1YXNyVkpwbUlPazFuRVB1U3BHRGxpaDJNZXl6Y1NJ?=
 =?utf-8?B?WHBzTGRXMlIwY0t6Wk91eFA1aTZaRXJyRE1lWkNhRjdjWCtIa2xxTlE0WTlu?=
 =?utf-8?B?bXFrQVVqTEYxZmkyS2p3SFdWMXpDdUVBVHdkdWJCd3h5c3NmVS9oWVNhZkxQ?=
 =?utf-8?B?UzRucDMyRjlyT2xzdmlid01VdlBRa2FVNFRtY2dsUTVQZnpGM3JCUWpSMERD?=
 =?utf-8?B?WmsrYUl5cDlRNDZlNkZmUFRiVU5rRVFENkFZdnlUWHVNVk1oenhEZTFVRWNL?=
 =?utf-8?B?Y01yR3hyYk9BVGtHK0dHOGc4NVl4Q2VvZUJ0REovZjlwZnhZa1hhMlVSU0NB?=
 =?utf-8?B?QVYxRElBK0VUeFJEN2Jtaks5RjdYdjRHVnFybnRHZU1scWM3Njc1UXk1ckRR?=
 =?utf-8?B?KzlvMHFwaVZDdnVCS0dmdkU1R0JUWkR0dndic0d3TzdESlJSZ2grcXJDWnVo?=
 =?utf-8?B?MmNHQmNad0VDSlZkOHBoZGVuYVRJUFQrUnNCVkZ0THVEaEdUVlRtZm11VWcy?=
 =?utf-8?B?andjUGpJUlFOVVZTellwRDhWWXpnOWI1NUJQNE56eU5MM0dzVk1nR1pJQlU2?=
 =?utf-8?B?emcxeUtvKzFQcGFTclplalJ6bHd0NnNmZCtIYkd1ZFJKRm5GRnFiZzZkdmlh?=
 =?utf-8?B?ZjVHREg0cWQ1L2psb0gydS9oSVhodDNKcVVielFtUlFaa1ByRVRRL25STVdh?=
 =?utf-8?B?bXpJbjZyWTZwcGhUOUtycEJGSCtvdWpGOUpTMTkzdVpob0FsRk1iMkJYMFBX?=
 =?utf-8?B?czdUT1hmckVLTVpWNWYrNVJzc3Qyd090Mi9raEhnY2R0eHBBRTFTODUyQ3hT?=
 =?utf-8?B?OWVrd2lWc1Qvam1SV01RL2pEMUlwRzA3NzdsZnFjSUVhSE1EYVNwTmVLTk1W?=
 =?utf-8?B?ZXdYZythdDRPSDRUdDJXZGdXNHRJdDNCTVBRR1poSW8yNzV5L240YzRKT1Q4?=
 =?utf-8?B?MVZGQlFiQ1lJMWRnS0srZkZnRkE5aFB0Y1F6b21wUFNZdkpaOWxIRThla0dQ?=
 =?utf-8?B?a2I5eXJBWE1URzdSVjFuNDJ4N2JmaXRiUjBETk9JWFUvb2plQkFIcy9yYU1E?=
 =?utf-8?B?TXI2dnBKemRTZVc2WXVBU3pEeC80VmphZlNpTjhjZW5QeE1icWVFaWFnNXhi?=
 =?utf-8?B?UDU3L0ZHVDdzdlY4akZHdFlScmFJQkpnUFNsaVlSd0lDNjY5cFNQclNTcjNP?=
 =?utf-8?B?Tk1iMng1OVd2S0t6dTdKUDRsckswR2h6c2F2S2ZUV2RUL0Z5N3pHSXFyYzZl?=
 =?utf-8?B?Qk5sb1Bhdlh4TXpjL2s3ekFBajRPUG1yNkpsTWI0RSt5NThFb3laeC9adWpm?=
 =?utf-8?B?K05haEZiYUd0aTJPdDBNQ3FScU93ODBEU2h3MHhLb0xNNitORTd5TUVXTXhG?=
 =?utf-8?B?aE0wU1FPdG5ra284dlRaN3RFVGtLcFY3ZDlQcFo4TkJLQXJCVjlTTE9UUUlx?=
 =?utf-8?B?K0FlUGw3WHo4ZnRLRVJXSWJNaGs0VGtqSTh2a3h3c1lOTXFTOHRQaUNIeFFy?=
 =?utf-8?B?Z0U5aTY5QWI1ZllyUURUbmxHa2xHZEZqd2RTMnFKMUU1V0RtU2V5amk0M0Uz?=
 =?utf-8?B?Y1JlODlOTXI5czR0VGZrWjN0R2JWUVptdVYxSSs3aExtaUhNZ0d2NGMvUWJa?=
 =?utf-8?B?aTRpS2xoOGk3aldkOUFjaG1qZ05Lc2Y3OHBKYkRRb1NvYWt5cjN4b0xMREpL?=
 =?utf-8?B?Z0ppMG1JaEtLR1ZxL2dsRW4wc1V4OTRyV0VEaURnTmgyRzZqUlNQVzl0VGdB?=
 =?utf-8?B?eFRoeFBad0lzREg1VmUyQ20wTzJ6aGljWE9PRE5VcGI4R3ZTZEd4VURBbzUw?=
 =?utf-8?B?eGJjb25leTdLNDMxZlhjNW5Dbm1HSVkvUHUzUWppMjVVTWFJSGt2ZjM5cStJ?=
 =?utf-8?B?WGd0dlN6QUZPMWlySnB5ZmNWT0NUSmdwWlBWTHcvTGJFbWJvcytiK08wbElN?=
 =?utf-8?B?YnlyYnkzbkNBVTF3Sm41bHlXVVJlRVE0OWI4MVF1VThiZ250akpBZWZJOURa?=
 =?utf-8?B?RjFMWlNsMWhTODFMeHZsdWM3N3orMDBsK1ZlMFZLc1B4eGVGMzB5b0dCVjRG?=
 =?utf-8?B?ZjlOOXVGZE1MNkhKUUxsZ3I2WkJ3NnNwZGNqRWhvb1dCb0hOZU9LOGF0U0tP?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4956a5-2c13-4619-f71d-08dc3e7da684
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:07:36.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U24G1pqVwaeFco2LkwfsqLHCwceK3d5EBqh5jR+H5re9Ysg9s2FDdO/Iz88DdpIHbIO0Snzf59OonLw+0JRMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6139

On 06.03.24 09:41, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 21.02.24 19:30, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> people started to ask about updates for our kernel trees, and you
>>> mentioned to me before that you would focus on the last two LTS kernels.
>>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>>> then also in 5.10 (all referring to the -rebase branches). Before taking
>>> over 5.10 and 5.15, I would like to clarify their state. But I would
>>> also like to know what is delaying the tagging of 6.1 and 6.6.
>>>
>>
>> Gentle ping for this question.
>>
> 
> Well, my posts to the mailing list from my usual address have been
> rejected a couple of weeks ago due to smtp authentication issues it
> seems, which are now (mostly) sorted out, I thought you did receive this
> reply as a direct recipient though. Looks like you did not. So here it
> is.
> 
> PS: Since this reply was written, the x86 status with respect to the
> Dovetail port to v6.8-rc7 has improved. Still in the process of
> rewriting the arm64/fpsimd stuff.
> 

Let us know where exactly help could be provided. I just want to avoid
duplicate attempts, so the development should be coordinated publicly.

>> From: Philippe Gerum <rpm@xenomai.org>
>> Subject: Re: dovetail kernel maintenance
>> To: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Xenomai <xenomai@lists.linux.dev>
>> Date: Wed, 21 Feb 2024 21:00:17 +0100
>>
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> Hi Philippe,
>>>
>>> people started to ask about updates for our kernel trees, and you
>>> mentioned to me before that you would focus on the last two LTS kernels.
>>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>>> then also in 5.10 (all referring to the -rebase branches). Before taking
>>> over 5.10 and 5.15, I would like to clarify their state.
>>
>> Dovetail ports to 5.10 and 5.15 are not maintained anymore, although I'm
>> still upgrading 5.10 from time to time for work-related reasons, but
>> nobody should expect this to last for long.
>>

I can take over those two, but we should coordinate that to avoid
parallel updates, at least of 5.10. As 5.15 is dropped already, I would
grab it now officially. Still need to decide whether I continue the
rebase branches, though.

>>> But I would
>>> also like to know what is delaying the tagging of 6.1 and 6.6.
>>>
>>
>> Those two have been tagged this afternoon. Dovetail maintenance takes
>> time I must divert from my day-to-day workload where the real-time
>> network stack for xenomai4 has precedence. The delay was mostly due to
>> lack of basic testing until recently. Btw, the situation is going to get
>> worse with 6.8 which requires a significant rewrite of the arm64/fpu
>> support for Dovetail, not to speak of breaking changes in the generic
>> entry path x86 uses.
>>

Jan

-- 
Siemens AG, Technology
Linux Expert Center

