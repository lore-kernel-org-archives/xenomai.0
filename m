Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219D13B2B4
	for <xenomai@lists.linux.dev>; Mon, 19 Aug 2024 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724047860; cv=fail; b=L2nX+xNPa7IJl6Mg35Iw8m/GQyqF/Gzuku+NcE1eS6x6jFZwuAvjTO8XuTMW4p12dDJoDsLUSbAon8xu2oag4t2jWJCBN33LmJSIR/tdZIaqFb4/g0FxkbyU+5hG1tfvs6U0IL4SEMscpsIlK9d/jVojtGWD4VE5xTmGbBEmZVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724047860; c=relaxed/simple;
	bh=+h14dgBKjTRGrAEt9h7CVRfOrrAuo4efqBGw67l2Nrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTif93USJ0HT6YgJh+r23vOcGfvE0csoY3+XBPpMKkIFaZJGkqNuyhoP/AHxMTIXY+LNQoEJpG4++zQTdsGhJH/lal62qBO0mOrAdeX6B2DPeBi7YJqsY9UM0UoL2kHY/sAu3JBgHiyrwOGarat08n2k3s/VECtnqat8Tkz+z+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oSc7k3Bc; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oSc7k3Bc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbU3+7vWMUlGoodMhMqRG6D4FRu4A1MZMddKkcVudJbE59EX9onJtsm9FeRJ9id0Pg7Fo48oHQDA8krp217P8fQaEgHXOU1/WN8SQMjxhdCFStM9SfsVX/a74lwqTGn/4omeK2y33fDECA69crkwr+OyzLSQMU8/eDPbDRxcLl5wqKRVXMcAUJu3+rcR0McTvcX7MFm0uWlhGRdUMzWtvLiGiQqBZWOmxiCgiXe4nsAu67n6nBCb4lhg2CwzX/FYTIxvGcM6srJDllW4U6m+x/NKnMMp9gM+hYEfpF67dGTuqgQkCBHshIRkIKVMjSrF1o57cfja2foUjbV0EYqobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iIgF9aC8QPz7SlVIh0vN3OX5y9a5J+DHGSPVKqCucU=;
 b=PJNPymLaq6b5MsmfjK3tta+cOhDs0K+zMEs34vmqmhcCtUoJAEEiwG6J7yPEPm1h6CMWHZol8Ucr0G9/6dWi5JP4jKobIFzTe/SJBiE/QvDlh730sl5gcjuHY39axOBAG8UrhQmJZBOLgGNEsyxjmmUsGfabA6Fq8EZplsgavoTGGrJsmU0pJI0KSUinNx89qNTwOHStvXnLL64AgmoGbAoyKD7sdxE6Fr5AEzz1seaOiIP5jddgY65LqjPcwJs/PdO/lhjRW9Y79ZAJKxv8uJKzP2H7zcv8u24wuakFcDxi12FrpE1LPjTVzQJQ6R15cBwEu7xsf3JUts15riuXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iIgF9aC8QPz7SlVIh0vN3OX5y9a5J+DHGSPVKqCucU=;
 b=oSc7k3Bc7mBXiPtFNaBIOYU/SwJ/NO4LCBWeSDPL0+b+wtjZjtU1bQ5CuYJfAtnQUTCVrrsBlAXs4lJvxaVupHc3egl/y0jZQbJ5keLgKFfRUEmnET50GwCoQL8kyz6AqNjlVcNPc3rZEFWuWuG3iSajpW1vsJ1lHL+cHebVUyID9hnGsILsf9Ae9P5naQlSWkbYRiTxjBjI+3alKUAyBlTa2oaC6r1F8MgYn6ZrHtDfkebJOk+rEtJ4SnZ5TgL4DtAysfAnb9+9JAVwPOEn3AfTfbUrDVRWUgPETKVJOZEwAGxkDLgyqibVR/oH5kdYJSnbMJxmRYGJ2FoADPfiEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:10:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:10:54 +0000
Message-ID: <0ca9fece-de1b-40bf-b70d-11bd0ce55296@siemens.com>
Date: Mon, 19 Aug 2024 08:10:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Vienna in September
To: Philippe Gerum <rpm@xenomai.org>,
 Richard Weinberger <richard.weinberger@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
 <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
 <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
 <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
 <87o75q51cf.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87o75q51cf.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f7ae05-758f-4297-87aa-08dcc015af43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTRYLzRZZ1VzTitOYjZ0R09HSWI5cVJnZktoS0hiSExVTFRtYXZ3QmZjYTdo?=
 =?utf-8?B?TjBiekJxUzJ2RGxUajY0M05ZSmU0WlpxTGkwOTVFNDJKaVVYN3RCWlpPRm5x?=
 =?utf-8?B?dzdjZDluZ3RpMklVMjIzUXRlNy85b0x6SFQxby9PUEhmbzhBdmpQbHh2TFB3?=
 =?utf-8?B?REdGaS9FZFZMeWVQTTdsa2MxT0ZSRHJGTWU4ek1jc3c1S2lXQU0xcm1VMkRX?=
 =?utf-8?B?N3pXdktlUUc1eC93cnlEUEt3OXE5aTVlWDRCZFBBblNDT29ncEFmeFRhVzN0?=
 =?utf-8?B?UEY0R2VZenBZV0MyYnYyUUhLeG9SN09GclB6R0lYVlRUbU5NZFUzQkNYRXZ2?=
 =?utf-8?B?OXFvMXladC9FSk5ZbjdOV0VzcTk3bi91T2xXSkhvWWhjRVA4d1dvNmNoWGcw?=
 =?utf-8?B?MHpNdkhTQ0xoZDhoUnFQN3FBQm5qajNsVWFOWFBmM2ZsSnFyV29Iank1NmY2?=
 =?utf-8?B?Z3lndDFhV0dDeWJhZUZOMENwKzdRQWNsdFpmQS9vMU1XUWJ0WnlBS2NZdlI0?=
 =?utf-8?B?aU1YKzRBWDJWUTk4a2R1RklneFE4TG53QUh3b0l4RmdWdCtmZDJJZ28yZld5?=
 =?utf-8?B?YWNhc2l1RmJQQm40K3AyUWpHN25LdGdIUkF5bjJINW0zSFZVVTQxZFhHN2Vy?=
 =?utf-8?B?bDRjbit2NEloUnBpN09LbWFqSFc0V0ZVb0hXL1RlNmw2amRPUkJLWjE2dDdO?=
 =?utf-8?B?Yy9jbVhUME5nSVd4elk2V2NkYm9XbVhNOGI2c09jS3E3dTFqQnNDQ2lqbktC?=
 =?utf-8?B?eXZBcDAzcUdySCtxMFRmRVlIUDZUc2k2QzdqcFJpU1RmMkVkRlFLeGZiazlC?=
 =?utf-8?B?ZXcxRmRuc2RqOXI2RWhROSttUVhydllzWGpzUEJXM1MxcnB0aTQ2R3ErTDEx?=
 =?utf-8?B?SnMvNkZQSUZla1lVWDBYNDdISXlqTUd3ZWFoQXBaV2gzZDZmNVZTdmtta2tD?=
 =?utf-8?B?MUxLTklBTGszb010TzhiMUxXLzlNSjRQTnY2ci90RDNrRDB4TVNSUy83Vjkx?=
 =?utf-8?B?MmpURUtKSDVZd2l3Tm84VGh5Z013VklIQ0VPdEpRRktTQ0hlUmhsRG5mb01N?=
 =?utf-8?B?bjdsbkRyL2xqcjRnQTlRNkIzQitMRUF2M1lTMEN6aFRZTVpDcW9KMlRqcVEy?=
 =?utf-8?B?eHFZeEhDODNySHVxendpVkRVSmVCV2I3N1dscTYrV0ZWM1k1UUpJL1dzSGF0?=
 =?utf-8?B?VTZyZ2txa1dwVzdnVy8wNDQ0UEN4TkhuRVdTZVpUQ3B2aFloUFJ1TndCaUFm?=
 =?utf-8?B?b01RdGxOVlFocTloWW9PNlpCMVpuQkxIdm14aU9OeUM2SmtoaTU4Sm14VUNW?=
 =?utf-8?B?aEg4a2kralJ6Qjl5OCsxV1FjRFVDR3c3QTVTUTUvNVZCK2ozcW1ReG5NYi9m?=
 =?utf-8?B?WW9VZ0RraGFDbUszb1VhbWEvUWx3UVd2RVpUdktDdUFtTFdTcVdiVmRGWVVW?=
 =?utf-8?B?ajlKV1ZURlFhZzhEenJPWkJzdFNtblZOYmtZSmhycDZLaU1GcHNFQUVib2xI?=
 =?utf-8?B?MzhGekV0cHoybksxS2cwc2RVWW5zTmYzRDFpRGpRRm5sSmRBdnl1MWo2cDBC?=
 =?utf-8?B?OFB2eDRRSi9jZStsUVBtU095ZmxwaFg3eXdaK3R0RGsveVoySXhIUFAySzVD?=
 =?utf-8?B?QzZCMFJ1bmRHQ3UrSUJQR25mdFJXMXcySU9TRDBsVlgxWURPYmpSZnZtRTEw?=
 =?utf-8?B?WlRyQzRHWWw5bUhubzQvelVvcURRekRCR2lTK2xGVHRPOGhGMEhzL0QreXpN?=
 =?utf-8?B?N0hZOFR6UVU4c245Yy9rL3g0YUU2OUhHbFdSQllTcGF4b3ExUi8wSnduTEls?=
 =?utf-8?B?bWMwelNYaWdmN3BpdVNoUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU91a0xPR2FvRW5lSHpVcERTZGEranNKRkkwcjVKSndvNkdXRE9XcGcwdlhJ?=
 =?utf-8?B?dTNrR0Rnczd6eHJockx6K3R5Nmt2cUZaa0Evb3d3MUpsSTRoeVJ1bEFPWFZF?=
 =?utf-8?B?RHZmeW5SWnBuYTJEbWZtK1g0OFd4MlN5V1NnWXBUNmJpTVhmeVZ2UHB0cTZa?=
 =?utf-8?B?V0tmYmIvcUUwT0ZGTVRrR2RaQVphdHBJdTdrWUtaT0QyNmtvQ2FMVDR2Yjly?=
 =?utf-8?B?ZEVoNVZvYXFhR3pqSmZvTXV3aFhQQTdMS3NMMkdYVUZFV1p4T3VtTmhwTWNE?=
 =?utf-8?B?K0pWeGtPREJEcXVlTkl5N2x0WUxQTENBVE0wTlRTZXlBMTl1SDl3RVVvTzQz?=
 =?utf-8?B?dS8yUEozOTZXMkhHR0d3dFFOQmVLbVlmbEhuSXNNZHZEdlFkMWMrcVJKbEQ3?=
 =?utf-8?B?ODgxc3RTOUpZbGZMYzNyb3Q0VTdJQkJJeHhTMGJOMjN5Y3lpWms5Mjh6MEJH?=
 =?utf-8?B?N3ljQURjRVhtdFRWMm5ZSXJNOEhEeUdUZXU1RkNaWXFuaXdFbHdhUjZiNWd0?=
 =?utf-8?B?UHFGc0N6Z2ViVFNXSkk5Wm9ha25MNEpEbDdPTmdhMmpnenFCdVVFL090L3k4?=
 =?utf-8?B?bUZYTzZXR2pxNlFMNjJEL1dOZVJKNkU1ZjEyQjFaODd0dFZmN0xPbmEwU1hT?=
 =?utf-8?B?SmtJREdaRCtwNlBPSkdLeTdQL28wc2lOY09MZm5UNmw4T3VXbVhGcEU2NE45?=
 =?utf-8?B?cWFGYmlFSDZYbkJRM1Rnb1FmcSt6U2dWdlNGc2RiMG9tTE5KYWxNVkZCYm96?=
 =?utf-8?B?SkppdzJRa2t2TG9vMlBsUHBXY0ZiQ3J0TjJUdGxRcmhXbnR3THo5U3BwWkZC?=
 =?utf-8?B?bSt2RVNObjZBZ1lXazkxcXJENXcvOHdwL2RaRmhjY3lPb1FxT2g0M0FhSDFV?=
 =?utf-8?B?RWUwVXNRRG5qRitMVkVqWG5CMW1LTFltTXVKcFdRNHZybkVlbFpEWFlWZ1VW?=
 =?utf-8?B?WSsrWmRNZUxWaUtHREY0OTlYVnhSNlU3OXhQUzB0VVlNVGhoTXd6QzZzL0px?=
 =?utf-8?B?RXhvVURrVjN5WDNkZi9FeXVaWURSeVpXOHFNUjQzdy9KK29ua0gxbjdQZEpu?=
 =?utf-8?B?TVVLTXpackpPYlNyY2NyWnN3MXhCaDM5ODFRTTN1T3ZFK3ZvWDl1NGh5am83?=
 =?utf-8?B?QllLOTlUVDV2RTN1QzYzV3I1TGkxUEovVXhTbndnTUI5TklmM3JVZnFmVnFE?=
 =?utf-8?B?YVdGSzhMYUpvbFErclRxWjhrWkdybGhjTFNGV2VxeDFveWs5a3YxMjQ2dTdQ?=
 =?utf-8?B?R21HclZjSThuSGNuNHEyOGVwdGdaOVloZTBZYUhvWVFyOXZBTDFqMDVma2p6?=
 =?utf-8?B?NFZQa2IvdlMySis5emxXbDNzUDhvL2JLMUtUa0N2bGZLbnlIM0RzZEx1UkZT?=
 =?utf-8?B?aU55NkZxSTBpd0tEUVFGcWlmQTdvTEFERjVLQm9sd3NGcmU3N0Z2VFBSSXpG?=
 =?utf-8?B?WkprVy9PWlJIV2M1WnNUSjRtVXpVT2ZHOFhWS1M2dkNPaW12UlFqeGxnZG1M?=
 =?utf-8?B?ajVqZWdHZEZzeFlIcmlGVkVYejEzWVRmNkR2WjFxblVuYlo0amdKQS9ITHZq?=
 =?utf-8?B?RitHbFFCck9QTjhqTUgvbUdqZTZvTnh6YmIzRk1Sb2o0UnFhOWgwbnVaOU9E?=
 =?utf-8?B?SUdQYkJpU0ZXSUx6TjNwcG56NFNRL2hGekMxeU12aG5mcU1kVHpiTmd1VFRv?=
 =?utf-8?B?QWRCaEdLY3dKMW53M2owTmdEQ1VVaDlxc1RhU05HSW1SaHNpZVJkMHpGL2Zx?=
 =?utf-8?B?UWVmRURUMDIwUVdCNjNKdEVVVy9yeDMwR3p3Qk0zZGdrSk4wMkpsVE1ESHFQ?=
 =?utf-8?B?bUN4RkZmb2JPUktFbnhpNmtRbHNOYkVZcWNmckNOaitiY3N6RkJqN0RhV0Iw?=
 =?utf-8?B?cU5ibnZqVXd1QjJ4enhiMU84QnVsc1NBTWoyRk9nWGgzcDR0MkVDZFFmQW5I?=
 =?utf-8?B?TlV2YmlVRVJvZ2pBRDdVSkV5Q0VqWk5WK1lOUkJPbXo3N1gwUmo4cjhRMjJ0?=
 =?utf-8?B?K0oyVHMzM2NNckRUNGRtalZ5N3M0U1Fhb0tkQ1Z1OS9rSDhuT3FTd21UUGha?=
 =?utf-8?B?MURUZGVYMGxHZm9RZ2o0UmM1RXdybGtadHBBUlMrZkhGQ1J2eXpTT2Y3U0hT?=
 =?utf-8?Q?oWvX6nfIPOhqqH05+NjeLkcGE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f7ae05-758f-4297-87aa-08dcc015af43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:10:54.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T8DowZuay9NNH1rCM/VKeheAYqs8RKyxwWOkOH7KC8RDk2j4k96oOpU8pIW4eEgRIopSLB4C1T8srmDmyBJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

On 17.08.24 22:41, Philippe Gerum wrote:
> Richard Weinberger <richard.weinberger@gmail.com> writes:
> 
>> On Thu, Aug 15, 2024 at 3:36 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 15.08.24 12:08, Florian Bezdeka wrote:
>>>> Hi Richard,
>>>>
>>>> On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
>>>>> I expect that some members of the Xenomai community will be attending
>>>>> the upcoming Open Source Summit in Vienna. If there's enough interest,
>>>>> we could arrange an in-person community meeting at a local beer
>>>>> garden?
>>>>
>>>> Nice idea! I will be there and yes, there is interest to meet.
>>>>
>>>> I can already tell that Jan and me can not join on Thursday of the
>>>> conference week, 19th of September. Every other day should work on my
>>>> end (- can't speak for Jan though).
>>>>
>>>
>>> Hehe, just realized that I have a double-appointment on that Thursday
>>> now (RT and CIP). Definitely no space for Xenomai.
>>
>> I'm also blocked on Thursday (RT party).
>>
> 
> It looks like everyone is going to be at the RT party. Same here.
> 

Hey, good to see you again there! I will probably be late, after kicking
off the CIP reception that we unfortunately put on the same day.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

