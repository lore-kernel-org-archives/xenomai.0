Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43A35F163
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163777; cv=fail; b=YXhmswT8epDXTFZtrimOQFWoUL4amuMvNNMH7vpX6NvAt+tiBVJVR5ngHtgrZdY5u/hqoNqb9icFJyfOp2TYoD+v1NCWjD8JbutMFrjOlVwuvRQJ22Ph+P3LE4EUDk3wevfrPwyoO7j9v56Y9QuPPe+j6wGkskBCzVxNp/qycdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163777; c=relaxed/simple;
	bh=aWxohMoYYlXpfR2J6iZeKa8THaNk2oIZwsNtAG3ZJKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S8ssvfoJEsQ0jSe78krQ9VTmA0EBaYNdFguleNSA4jJxiGYcw7zca5fnAtd7lguhu1TmJOl4/KMgBelhQ33yZntT2V2471nEmeRR6TshtAHZ8GMk7BORaOo/kTTHLTam0cqLV5lrj86AHi1DdS0958H8pi3vzSFByu2TmGUm/Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dGDSFO+e; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dGDSFO+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxsasVpA9+nKSNBm/2ATeJB+SBNRKiizijDp6tzjpJSJbqWAbqbby3Q6/XSm8vBNV+3b86mpzfk6mZn9CXolWjoeeSpkngzACqtFD19W37mf9LL+YBkA3+kuDmqFX1NKGUjD7ppaBBeapkHDGTC5kGOZsXJH1nZu9loYP5LhmbQ/uE6ZNuibl9C4B3ULqsB8zUs+vdHEKTlmcBTsyZn8At8lhwCw8ZWuQ9hRy8u+b0AJ+NpOqLhxlqTyTnYKnBxY+j9LR1v+fevB4bgkSm8hCR76dmeckNNXVpHR1H030fdZe8anGwaG5I+rNKJXukYPYrNZFllGWnDtKJFehFhwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv0LwbkvWgNfnRSq54FAEAS79AfqSjr9eh7igxbLcBg=;
 b=e84GaflW9GszliUI1uwmzgL3mrYaSJPBgPCIf0gYvT4+TZkbufNxF5kOlh/pT9HGFw/93roaMs6dJZ6t5J3Iht8jx0CY5afuMurxrRsdOM3IH667mYhSDwsvoX/aD48nBXS2mrRbnGScwSxM15MmQS/LkYd/5hsmUvpIljOi1qosz8XsHcYBGi/kDj3yRT+p5tW5Aqr0EbqWc3g0VoTY/RhZa0zt6oVm8W6lO2rTB0dtCr1lMwh26vAi/9LpjM8V8QHrfDIOmUV99Be2/EOq3PZmM+UddLO/Wz08K+6hwG+4uzvpbHI3cgMFNmYmYs509jq+djViWzbMHhhkVgWoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv0LwbkvWgNfnRSq54FAEAS79AfqSjr9eh7igxbLcBg=;
 b=dGDSFO+eH8SIYYqOd3Atm0izD6qQivibzfpyN2fCHGSWLb4H5UeJYudgEWsQEQRaKUQR+VJszKkR3gdKNySp/KXCmdePvQGT+NGGcLGGmLNgYoWnGGS63C4W8cwUZb0S5XoVSdOjcsDK/7uityKUtlkyX6Lzh7KJm61lS4zrrPD7ye8m17+HEA7tWnbTXLWXlUd3D8HBwZ15l53KFl7G2EhFM/uHJV8s/Vmfq60bxildwSpIDx/AhlHUtHe/au2cCfGuwyO9zTTzcmJEMiR0eHlGtEVrafu3aYFC3OSCyHMwlyPcwDnXfefCHN2nDu9GJro8RjIw8W3ugmiEamSJag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 07:42:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 07:42:52 +0000
Message-ID: <2460b105-370d-4cf5-8cb6-e40809763cd3@siemens.com>
Date: Thu, 11 Jun 2026 09:42:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
 <87cxxxcz0n.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87cxxxcz0n.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: e05b80ae-c703-48bc-4c50-08dec78d0acb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|55112099003|6133799003|56012099006|11063799006|3023799007|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WvSHiH8SPcQPCnPieSRfNXwgR17abFMw/ISPOw78Cg3IXTxxPCVg5E4H5xVppnNxSBKVrlmoRg/oaCg+1Beg6vVobaGB/BlZfDfBq3vx3+vn1yKXQyioF2jch5if8+gW4Rf0kDlAv2M7EArM+lW5YrRBEEebirFdy1v9wSX/tXNS+o7g8QxUepV2ZD7SzyRAkWnQpnYEpea8o9dahIgdl98s6giNiv/HAKpP8rB3zSuU2/rgvyvqF3OtMR8iNyzbSDn+NhWrgOs66iBJKvuiKkU5Y0/pDOkLPQAMBmqi8vvVpFY0GkiFAqwCqqYM0sJtls7z8/W4c6mV8IP+nqSsBERIjksbLiTgcrw3DJiGL1q81Pf3YLU5LZQrS/TDSN7dkf7ns+lSKbDZZaXcFthe5beZzl4MkTarUrrOh7+AAD1oWadtGCHKHPyHwSld8FWay0Ua7cHSxQX7gEj/82JoIuPdTLAarONmcO0ktC37pWqwdIL0RTLRD5jIBBzOKKNtKZM0DHgfDnTaKPKMKamOuvSBJ8+LxW/20nVDWdU28Y9AKv2lMda/UXw968LOonWRJkeXWSdlnytYuGa7EaAKx21Ijp/U+52NV+9mo91NsgRNHezakQ+lUy6H+WNqM09Sy4BaB9mXDmjbyF7AOpR2o15bxJtipXmCbtDent5gBpUZLSwHwCnmA82lXhxaThOv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(55112099003)(6133799003)(56012099006)(11063799006)(3023799007)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2lWZ29DZ1dlWlI4emtBTlM3a1pwRmxSQ2tyc3hZTndCVFR2UUM5dUkycFZF?=
 =?utf-8?B?VzJCU25CLzIrSFVqVEp1dFRtT3R3eDREZ1JLQVFMeXdsUWNoZHBsVDh0UjFZ?=
 =?utf-8?B?cTBuREh2SDNhRkE5eHE1TWhDamFUdGZlbXl0RWhLeVJiVnJEeUhrSTFHRW1u?=
 =?utf-8?B?M05kWFpadzBJMDF3OXI2Q3E5ZjlRY3pZcjljZmg1TGdMa3NybmlWeitRaGVT?=
 =?utf-8?B?YVJ2N25xa3prR3poRnVFQVpZeGlNVnV1d0E2MTNXNFR6OEhiVm9TdS9KeGY5?=
 =?utf-8?B?YWZWMUxtRmZOeFBhd1dQWXNnZS9Eb1E4MDd1TnFPbmEvRFArcGdNYk5EeU5V?=
 =?utf-8?B?SWRQOGRjV3dXdzJ1OHQ3VVF0KzhhdUNUWEh4WEJleVZnV0o0bEFPTVRLamdT?=
 =?utf-8?B?TFJrcG5tUkoxUXg2WGxsNVNSVTVHWk93a2pTajM0blMwQnpOVW5oTnRmQWRQ?=
 =?utf-8?B?TjdDZzJxL0t1VGhxcEljQm13bkw1bnRhVTB6M01WYVBzT0pyUHdoZGZhZS94?=
 =?utf-8?B?Ny90ODdwdDdSWnZMck5NdjIxS3VjcFI1V0VaOFBOR3pOUEM0TUptNmFBUDhE?=
 =?utf-8?B?ZWNuNllYb2RrZ2tpNjg0SkVyYWVwYVZ2cGZIOXBNNVBKYzFxUVVvOWsrcXZx?=
 =?utf-8?B?S2I5SVFFUFRVcVc4N2xUT0M1ejNEc241RU1GRi9odThyYktLbk9hVUtTSnpX?=
 =?utf-8?B?b3h5eTlEY2diaFlSOHlxUUpOY3M4ZVpmZVRrSnRIWDhOMGhCcEV3M3hDeCtK?=
 =?utf-8?B?SEs5K01uR1JuL01uV3lBM2lMR1FWdEhOaXdnd0tQRXZKYnZzdDZLRUswK0kv?=
 =?utf-8?B?K2kya1lKL2dFOGlSbTNYL1R2bmxZeFovaTZrVFNOUGUyMmUreVV0SHg4WGdJ?=
 =?utf-8?B?WGlDT2ZrbVRsR0I5RU1tRlAwd2pYNENNa2I2cU91VkpyNzYxOXhqYms5bjhL?=
 =?utf-8?B?N3h3bkxPYyt1K0RTSk0vZGR2VFZ2bDJVY05wQWpwaHNPUTMzR3dEWUQ2aHY4?=
 =?utf-8?B?R0IwQWgwY3h2dnQ1eFFzNVdHWFFFdy9FRnIyRmd5dUgwVCtrS0d0N3g4Z3Ji?=
 =?utf-8?B?N2xVRzRqOTRMT3g1amlyWTZMZGw3aUM2RFNkYmFEaHdIUHgvMkFaTVhhck5L?=
 =?utf-8?B?eitiZ1J0Q2M5QlBJWDlNUEQ2QTVTRERrc0N4cVowMmZHNE9uaTc5cDdkQVda?=
 =?utf-8?B?MkZvMGxrU2JtdnJoUDJRSkphOXg3LzFHSFNhd3ZCNDdRcWhmQ2FhN2xjdlNp?=
 =?utf-8?B?VElTVi9kVFNYTHpseTd0V0tZcXBYSUVYcVpyUTRZSG5pRVhSeDRSNnJub1hB?=
 =?utf-8?B?RHdZeFB0alo4L2xFMGtxY05RS1g5TW0vektsTDNxOEhERE9LQjVWMWZrRDNR?=
 =?utf-8?B?cllRU1k3b3RuSzJ6Ym0yL1FySFhFcHBrRzhBL2hqVTdsY25YdGRsREFIYzhz?=
 =?utf-8?B?V0VSSTBBYjUzMENpRUQ0QWM1QTZDd0gvMlpqUFdlZUxnem53MXRyK0RwRm53?=
 =?utf-8?B?QXJlcDBBcTVNODJWVWNBNWFMMU1tTUdDNU1UNWxwTHFuZVl5L2Iwd1dXaFJv?=
 =?utf-8?B?RU40ekFFdDJTZHhUTG9GUS9obEtxNUIzRHFOZ3kzQ2QyaVRVdkc5QVpuaE5U?=
 =?utf-8?B?QU9aeHpwRXA1QVZKellSUENXUWM5Z2htWTVZNGdMd3VRano3K25CUnBzQ05x?=
 =?utf-8?B?VUhwNGMyTGhSejJJUFRTeHdXWlpxbUdSRkVaK3J4S3h2TmQ5OEtyR1Q2bmN6?=
 =?utf-8?B?eGQvUTF6Rlc1elZ4MFBLdmNCVmw4YTh4V292MXJ2MWRvcmQzM2VKbGlEZEVR?=
 =?utf-8?B?cFVtSXo2emJQSGNPeU1TQVp6SDJ5c0hnY1FVbUFiaE1jaGc0WnNmeC9IOVlk?=
 =?utf-8?B?ZHNzd3BoOWpiTlRCQ21OcFg3d0tvNitjM3JjWGRYVG9YZzU4aDBtUGV5NUQz?=
 =?utf-8?B?WmhZNUZCbDd1VHhoRUR1R0Z5eHFhcjBwcklxdGU4dm5ieHlDdmJPaEh2bC9I?=
 =?utf-8?B?bU1GWUpwdUpCMnJBSXl5bTRIYzJJSlpjdERQVUlqRTdablhKeWdPeVhEeVJB?=
 =?utf-8?B?dG50aUkrMWhla3dmaUVYRHBqcmN3ZEJOSlNWanFMVmxqTzhDZVBTTFk4aWZn?=
 =?utf-8?B?ejBEMm9iSm9sUTh3OU9EbGdCRzlJdXkzNUUvaDcrMTFqSk5mZjFQVFhGQ2ZJ?=
 =?utf-8?B?QU0vZWVQSVNaM2ZtVUFFU2d2dlh1TXJld1NJS2cyaUd2WmE0VXEyZXFmL0Nq?=
 =?utf-8?B?YUVtZUcwdHV2RDVmNjhGSE9Jb0FPMTV4S1U2RVVWYWhTMjhKU2hhNTdkcTdJ?=
 =?utf-8?B?aXRyTW1udFNVQ2Q1N2tGdWRSdnZmcWRRaHU4YmxGT083K3pSUGY2QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05b80ae-c703-48bc-4c50-08dec78d0acb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:42:52.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yfZppyuNxI0HtLZ2L/ovjUv8124jUPDRodpCjyz68si03D1j/66ND89J8dZbpv2FT/PC6w8NKnkQiWuXbMIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965

On 11.06.26 09:33, Philippe Gerum wrote:
> 
> Hi Jan,
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>> into XNHELD, a state only existing there. I suppose that was once
>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>
>> Turned out it was never documented, not even linked to the POSIX
>> standard. But it also slightly differs from it (low_prio = -1 -> suspend
>> on depletion). There is also no test case, so I asked an AI for one.
>> That worked fairly well as it seems to have revealed an issue:
>>
>> Could it be that we are not properly suspending the budget tracking when
>> a higher-prio task from a different scheduling class is preempting a
>> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
>> if a thread is selected from a higher-prio class first, namely sched-rt
>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>> limitation/misconfiguration? Is that issue even affecting other
>> time-slicing classes as well??
> 
> Yes, this is a systemic bug. We need to tell classes that some thread of
> theirs is scheduling out.
> 

OK, then please have a look of my proposal from today. If it makes
sense, I'm happy to submit it for x3 as well as linux-evl patch.

>>
>> That furthermore makes me wonder if we actually have users of
>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>> limitation should have been observed earlier under real workload...
>>
> 
> I only know of one user, back in 2009. Never received any feedback since
> then.
> 

Hmm, I'm inclined to retire it then.
@all: If there are users today, please speak up now!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
