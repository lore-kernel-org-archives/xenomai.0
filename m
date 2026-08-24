Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AB3655EA
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567537; cv=fail; b=SJ/57Oex9vC04Guoo7EeXC6K3T3aW6Qv6i72Md8WgTpq+H7tLeoCTkmct6GJAomRgr3BcoCFLw3clMPhZ+YspfnMBn2CjgnFCaXAvsQxCDv0/p+lPjQ9jT2n6HRSG7bmkh3NDSr3neCOcykejAqfNC86GW8mpZXk0VnhD6lEHY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567537; c=relaxed/simple;
	bh=NLfVRWEWuHBHmhgNLqXBo8w2JbUIXBtf/G72CD+6VLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VtS02fXbcrVZdWa6ahp1c9koj9h4cMnn1SmqpHhOXUIX2HCaTgmUugo2tiW+c9w5QwlgXpHadZ+46/4GoeVpAqnLiELrZ86iWRKz2LH/ew5iSjIAb1PFhQXCLwS2oao90xYQ94SxpTrsboMDTti43cGuZFNnxK+PuihMXvr/Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dXEfsy5+; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dXEfsy5+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnycNSUW4YoQHgrK2+dqffLUjU9jfECgtEI0yuBeYJu/Htv3b5ISO91gZZ2JZ2lsrucJLup+zjZ80yywtRPKuvahKJaIUjthNHbbpVwJcJ7/CArQDs7LED8UwHeo8mj82HTrQrP+83CPuI1pXNBR26dSq5Z31Z4Hx4Fp822GByaKCnnV9y0a0gx9HNH2FSOChGSYIHWTBPYWlP50AfKEYpqiPd+2rWW6Ihnk45nEoZyx/JRM4vc95VaKP27+yBktbzDFJT/7khRhoubOwcHHWKYkSXXbA1ASLcSC8PNcEuPmXMcma3E72/hyZoByUui1lURJPwei1TKNtd/JcGTJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz3g9SpEMdHigEIVy+Sk0YsSleZwrLKA2R4atjACN+A=;
 b=afy+ONn0eA85VvTtjRuwjxxJKa94P9t6TZFC3ya4FPM4lkiGwKSU6ekcsxGhUYo+Ntdag0vCDAGVMP5Kqru9gjCi2JiCBHNkybhU9N4nfBHLWE+Gwes6aZ1AMRaJapED/SkzkwN3mG6m8HdKIK6A4VB2m2GI+cDvVRj4kyzsgv7aK3c/pWH2A9efhTEgFROsXvJCmPrqmyzvoQGmY00VeyZrGzoGK6/u7gwjbqhbRPZm2eL1AFP0KWb+n+iYRsoVcqyc8OLjliRo0uVquEyLLeWY/Kq7QmdCly+i2V/TFcvFFA1/2AnY1Egh3w/lie2qH8+mGnQ2D/j/bMUnw/bnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz3g9SpEMdHigEIVy+Sk0YsSleZwrLKA2R4atjACN+A=;
 b=dXEfsy5+a9EE4lxfe8ZugSlTXBpTgfLuovKC9MEidpSMGD3qHO9x52O61mqwnJfwIusPTg69KCeQZ+LOTvUR+wqNq2T4ObU6dI1LO199+RAWz41MBNME4VCpDYaZfU+/7jX+TbV/+NmA6NtEOUOLGS84X9vkH0+x42zVkBaFSB0RwdyC9WdLJTQuZlZ04V6SeJXXkMKzXrvt3k87eKWRYMXhd/L0P6BiNWrSThZWXoI9JkDeqOqIVjo9VYemE4ZIhEYL6u+sDWPgbcEzYr77tLRmKvuhMcUspllXPMy0gEiQvKNOHVfzS+LMaAKccsjBK6K8fYNFS5p4f1FhMeJp3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:763::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:32:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:32:12 +0000
Message-ID: <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com>
Date: Mon, 24 Aug 2026 12:32:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
 <87h5nvl5ct.fsf@xenomai.org>
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
 <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b5772a-6337-47fe-6afb-08df01caf5b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Po1zBlYz16fk2cYnQjdpilrOBSAmcbWRIScnZjAKuWT3wmoNgCZ1N/SkHndFCLPWMpOMMFwItDvk+hSVXA3VVfbkbOY5KMev4m71Bndvbfj90jmsg5kl1cNwhP1KV+bpOXt/AoWGdRjswetG9IvnbXWt1uYSOudTKdkT4205vndbKjnlIOHIIXWlCiNwLAYejtSqbGUXNoDQX44vlFrhtg/t7yMbs+uTvMr5ZCUDnQLxC1CofqfJ1wu0kJoYM2N4luCaaxAOMi9ljUUsSZ75wRa8YcsSENCBjj/UPAzfvTawNDVg4Pm67BcjXOH8ZYtdRV3IooeLAth5QgJ3qojWmMjqFc+vXjK/508pBtjWBp/NX8lO8YOBLtYUgZfeAu79Ci03FK+BxTdZLO43iTkx4pYkf35p0IM/UD0fRE0w2/CCrpi7QERrK4q8jSkqWbgq4BjTHY+bjwGt5/OJ91ByfHm4/PvkhQ/rE1SbJJ2XbQ/ZoGVIP0FGWYMau+BjiAd0L4hS9Je8yLEWcMycsgXiOye0lWOVUSCkJq6n8dXut97wXhXUo88XkF055Rq0QHygn7czyypb0gX7UMaKpB9W8Th7U57AmXj/F1oVJePxyTGIMnmliDKwH6V/JgdrshqA/THcNnpzhBKcixzByLTHYUWI4QaD7LSSx0SAYVzx6fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpvblE3Rklqem9WOTJveXIrdkwzWWl6ZU9ONlBxOHk4Z2laQlEyaHpPN0o0?=
 =?utf-8?B?OFN5cUROcnpqdXFaOGlZcVR5b0pKUXJxeG9iRkdWSCs2eVlmUHVaNUw0eXEz?=
 =?utf-8?B?NTRmZkxBWGsrV3pRbjVlYzJHYmZSMGpLQ20vK1NYS2tja1FmQk9qbk9IQ3dN?=
 =?utf-8?B?YmpVMSsxVW5vZ1kyeXJpeHVHNnZTZlY5TDc2L3hXb04xYzBiM0ZLdG1BN29i?=
 =?utf-8?B?Q2k0a1lhNmFpd3ZnenRhQkoyTmhrYm5KVTRBaURtVkRCNmZ1M1FTYUxZNzE1?=
 =?utf-8?B?RHp2dEF0V3JDMy9Xby90U2UwSkxaWWdBbUNHM1YwNVJyc1ZrLzJ3K2FYaThE?=
 =?utf-8?B?aVJvd0NtaWFJemdZNFAwOEZFclk4RFFZTisyb2FudlZ4dERNWjBhL3hGVlpj?=
 =?utf-8?B?bDhxVjVNYW5xVjc1ZFhiQVhndDV6MGVyZ01IVzRNUFRlcWkwWFN6dGpxV2h2?=
 =?utf-8?B?V1lIa2pIZVMxKzZqRTgrdEtBSHVCZG5FQVNTVnlPQUtvWHNBa3RKU2g2WXpv?=
 =?utf-8?B?Snl3UnBzNDJwLzNiYUIybFo4MXVzTnBORVJYUmNYcjE1MTVsWEVpMmhrMk9Q?=
 =?utf-8?B?UXg1V1VNZURxb01jRkZZNFlxYVZiMXp4Y1pSNTFZL0c1d1l4MWx0QVA5dzM4?=
 =?utf-8?B?cHVOWWdFdWF1eGE2Vll4aFE2dFQraHFDR1FpY0l6QVRGTEJvUkd1U1pTS1VH?=
 =?utf-8?B?cXl2Y2d3QXhYcUxyMzVEQzNsSXBZUjdxT2JBc3Nlek1YVW9XS2pVL0pRVUln?=
 =?utf-8?B?enREOWVsamlsZGZUeXpqelM0UjBhUXFyNmlNUXhnN1FVKzhDaEVqN1NycDZI?=
 =?utf-8?B?SjVWSzFSa0ZtcEErM2JMdUJtL2tzUzZiL0tjSm41ZVNPcURNb085MTlLQW9j?=
 =?utf-8?B?Y3FKbXkrTFp2NXdPR2dScHpielNQYUtXK0kvcFYwcTdWTTh1ejh5MzI5dTFB?=
 =?utf-8?B?UlpWRjh0bDZCQ2ZpbDc2QjQvYU53THNISm83NVpoRW9pcG5sU1lLbS84cTNU?=
 =?utf-8?B?S05CRkt5ODN2N3pEOGUyR3FPM0hEd1NQVGdmcVRRcUlERVZCVVBaSlkyc0FJ?=
 =?utf-8?B?QnR1YmFLS2l3Q256UnQxd1laNms2TGZ3bUZ0bDlDeEh3QU9HRUpYcW5qUWF6?=
 =?utf-8?B?cXlCZm8yZEY5dkVrRVREYWtoZXptR3BYUGU0d1AxRTN1VzZaQndlU1NLNnp0?=
 =?utf-8?B?a1MyYWxBdWZvYStUL0txNjhGR2ozd2Z2bk1VWXlNL1ZRZGg0ZGpsQkdaclRK?=
 =?utf-8?B?N05EVjMxNCtsWituRXBtbGh2VzlMUnlYclZta0w0QllIVTlSRDYzdTlscVA4?=
 =?utf-8?B?a0FpNGJUV29qa1hPSk5ibjhjSHhMalV5TTNZTmtrUUZybFBXN1NlYlVMckhY?=
 =?utf-8?B?ZXM3eVo3cGpkUTZWU0xaOVZQaEJLcGQrR0x0cndSYTFBNUZEMXN6bzFsS3Ft?=
 =?utf-8?B?MVVUZjgwUkNZc0NTckc4bjBLbzFmd1EvQnpTRVhjTy9tN3F4UFFETlF5cmNi?=
 =?utf-8?B?N2hlYWs3TE9Xajd6eFkvV2FmSTNsejNKb2UrN01SMjBaNE05L1RYdTBSeExR?=
 =?utf-8?B?cmN3cE4yTXR1SXk1cW5sQ2tCUGpxVzdGWWJTQTh2eDNCNXFZb2N4MWl6SXI2?=
 =?utf-8?B?bVM0K0dXdkZHdEpSYmdqU0FuM1FLZ2RMeHRiODBQdHlFbk9DS0FXdm9QT3Z4?=
 =?utf-8?B?akhhSDhzelpRVzEya3lVbEMwSEhnZmN5emk5emp5T214Y1hVZWpjNGtuNTRS?=
 =?utf-8?B?SGR2T2RkT0tVTytEOWk0cGxqQTRRWkFqR1RneXpSRmE0TXNhYngrMU10ZFl4?=
 =?utf-8?B?SGJ5R05jQnZhZ2s1Z1cybkZoRmNEQzZJditRVUgzTE9DUGljeXNnMnhLN0Iv?=
 =?utf-8?B?VUIrUGJxWnRZd0hSSktXOGkxSnNpMitQS3lkd2RTaVdMRUZBSStxc3ZHeTZ3?=
 =?utf-8?B?YlN0NTlMamk3c01ncThNZnR3blRyNFJDaG9LZnR2dC9HRU5kM2dpQTExVWN6?=
 =?utf-8?B?Z3JTUnY0dldVMDN2dFVkSHVnWXUwZDUvOTFMV1hKaThaajFVVzAyWTlyV2VY?=
 =?utf-8?B?VVNaZ2EvWW5PdWpNZGVUR3ArakdkWXNpMm9keHZ1SWZmckJtdXFicnFxdGJU?=
 =?utf-8?B?cjRiRlc1MTE3UUVmT0tCNk9QVDAxWFNHWkZZZGdmdEN5V0kxekpnc2p4UWlJ?=
 =?utf-8?B?blhSM1hIWTVKMEFKWkVBN21hci81aTRpNHlSS0wxMG92VzhZcHBTN1QyaUtL?=
 =?utf-8?B?NjhDVm0vbEVXcjNMd1p4RlZxa3NrQitpbXNHWU9BU21xZzYvaGRWZjBSTkx2?=
 =?utf-8?B?cGJkVTJNMnEyLy9UWXAxZUtRZkRKbGFaempLeTdZMmtFbEFXODh5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b5772a-6337-47fe-6afb-08df01caf5b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:32:12.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhgIkLEjFSe1ZSGhLckK0msCMbkYudWKkMjVUP2qUdk6qQKmucX2WZQMd8RswBVWHGPDphi59kdQOFUDxwuyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9705

On 24.08.26 12:20, Richard Weinberger wrote:
> On Tue, May 26, 2026 at 2:39 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> Finally, there is a now a fairly exhaustive test in libevl to exercise
>>> this fix which could be easily ported to v3, see [2]. It managed to
>>> trigger several tricky issues when debugging the fix, so this may help.
>>>
>>
>> Thanks for the pointers, I need to drill through them - unless $someone
>> has more time this week (I'm hanging out at Embedded Recipes).
> 
> After some time this issue re-emerged again on my desk.
> IIUC these two patches have been dropped.
> If so, how was it finally fixed upstream?
> 

That whole thing is stuck behind the scheduler fixes for quota &
sporadic because it touches sporadic bits (or would benefit from those
being dropped). Yeah, needs to be resumed...

Jan

