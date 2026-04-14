Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C049282F3D
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143714; cv=fail; b=XqT/vGkNpq1/0eiGuNfzl6K19+o3k3+isqFD/Z7QUvuusxh0cTmGAkH7aT9snFF1BbfoaBvgvOJULJA8ERa4tLAVIIX+fnHrqFQBwINmAuyu+ELpERTQnPYHhg4wUSYu6qmojj/tt8NX38PyNfuc6n5kES0HvGVe+GlT3zpM654=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143714; c=relaxed/simple;
	bh=S25zI5LscEMed4+3MugtPBVz0+oEA7fa1H/ch5Jcomw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+WKI4VoXqn3vSH2w5cKRQfsQTEtfQTBRCBmSakG/9w4/ZGAXdMsfkkeXP/l/XeJCcMQoYlJpGQRWGoZEACN23tC7XhI4L4efKloJo/wUcK+j9wAOIRxNA57UlkhsHa3R+0ocxucmyq74txUv3diE/DgOdeuBiKVL814ACKDLPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gd5RnMaA; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gd5RnMaA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgQRmXxVAro3jhECxeF0MLUv8LXMC+7/tnwL3FnTjzPDq+NxdwdeNWU6Y+rcM8vGdKK9VhrrhhII4OKufWwYwH0sw9eK68HdGIDxuiKIrftU+aJft1QveJt4WkloKp0OMwZZDHn6bQgE8f4Ie758dwiXkvS2QxbrCoIGtYQ6mkcu4kQrgbJL93OFYxGyq8z7+J1MGKct4QqGQfpArMpD8vXQArsXEvYd/XBMMwtyf8fOSmWhlV968uhEGuRMVvQjacsPB5e/eOlsyMIKc7oT7csWrZTiqNJ//1wGQjkgA1ARE8/GHlpXL9EQjmF40CX6EgUI2v8ACEa3jML9kToxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cbYGTUMImlnUSzBetOiAeNg+0biMwEwJvxioQd/8UQ=;
 b=UxCBcrC/gAgrwq/J5FJ8yxkQEgmramXnz7ZG7jkmJ8oqYFm/QKxM9A0NUSdiMdw7P/Ry5W8xjLA8ZJIjhHBZB6j3cGUJpdFhnmOF3BtrAjA5wCMuoVIvhb3I5cXyfGc3xUlmY445K2RIC51p38+BAvsIpBhtXDZs2gVBSEuzkqW6wIFdtoep6jUMbZXFOPKbMx+ZrYAfM2neJR0+X9+0MZP1KncAV5SVFqpf0ibK6fQpPPWJgo60K/7mYniZ90N7xHb0cb+EaNCx3Sj64p4VO0+u44saYmW6pt3IoHa5y0IBvJcpD6kjYyMY7xx0HRlvONq8rluH9MBBWvFi1nf7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cbYGTUMImlnUSzBetOiAeNg+0biMwEwJvxioQd/8UQ=;
 b=gd5RnMaA6sCoicXUd68LrBauFN2yDJ2mwXySjfmr7GsO2Pb4FAP15tycVWtqTwjELnLTC9uR2hNnxyHMxXfxDubW3hRfzcj+d6fZix4A1qm7HL7AxRH43rPjf0bXJzixJFUVdgQ10RUADfMi+TseANzCGXzOgMqr8aF27x+IxM9+IMwbHzT9huO026LgDfMV4JQ0ZAQfuNA5wp585T5AGkg2gpgB+ePKn25VLAD3D8LqFhjWNbMZwf8YIErbFQM7g1h+ts6ZkmwJEXFrbSem/BOyJ28O8t1pECKoVQvFIb4XRejbwGgkiy27zZ9D5+Vx1irPiQRmLaSVrbA4Img/fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:554::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 05:15:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 05:15:05 +0000
Message-ID: <0b212101-486d-4334-9e03-89ed95fdfd99@siemens.com>
Date: Tue, 14 Apr 2026 07:15:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 upstream+xenomai <upstream+xenomai@sigma-star.at>
References: <20260412073425.956320-1-richard@nod.at>
 <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
 <946371069.54252.1776111069832.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <946371069.54252.1776111069832.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160104b-e44e-47b3-5461-08de99e4c999
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mr+erGIZast+zHSdWRZIRWB4DVF4xV/0pfCBB/oXtzp9p2ISbNhA9WC5aXmlKJ1/IBsV6AAUJmQ14crs29J9Eub6soYhudQbVpigEzUdepKpMKUC0kP45hWuxMoMn1okXmfY9YwIx4kEt7Gn2fXhyiQlX/DMFErnrh27ZGTHYExNT3EF3GS93ecWBd458PTI4C1zpN+cMcBaLbHiVu+nMi1W5+FgDWV2iFm0IgJ2oCRwXP4k8MEhTYk4PG8ODN284HHUvGhTDqBXn3tCnzkYIoUMUuG4DXVbPYGs7Tx6GUn61PplKX44LjzzhOBFutylNpBXtV8bj3i1G9MXbw7UZpr0WxaGNmC45jr+AzH81zg+iU7ls72ve0onj8Jun32M2cRcV6YqN8UDTRc89udlMH/cIAsVtHl8Ha9l+Ay9fWFnFdhwoRFFaKcPHTFVusjtDYGlZ4yrFYnB7j+EiaYcsMq6qGOzNOJRWAq3Fm0uJbOrDW3NSJFP0O11dJLEfHAvSM3ebMrOBwp987bxE+ioIMwhkA7kdalVOI6ZhWrYyeb7adly03JOMj0AsHyBNjJ+m3PuhtTaL/Zh/zhvha9PxwVPkAzgimADDblbna0HLHG29u0gd9Z9Jrwn5jee8wR8mryMsPzP9/tsmuLTdk6Y5DCAUcK454PsuRfKBNfITg4LlzY4+OYdVcR+JRiyiT4w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGhwRllFaldEOFNMeFV5eTNab25XM0lUNjhOajNHaXRObmluczJ5YnNXU2sy?=
 =?utf-8?B?U0JZQWZOdDR5enhidnZhckdtcGdpUlRJWUcvanJtRnVxZ0JDanJ1TCtQamZj?=
 =?utf-8?B?V2FDclNwSGZKN2RodE5nSkI0UCtUUXBJKzAxalpFZFpTNmZibTR4eklDRXpO?=
 =?utf-8?B?V1JiLzlrYVVxY3RKK0JUc0l2RXNwR1EyYWxDL0VjVWNEZ1RYZnhwQUNwSkM1?=
 =?utf-8?B?TXlGOURleTJNazBZQXRoNHkyZEVTT2szU3RPZXRjZEk0cWhsUDIzMjhma1lU?=
 =?utf-8?B?TENZcjh1NDdSSUhOanp0aXJRSWVnM0MxMWRTQlBCdGtLaTN3SVUxaGI0ZVEw?=
 =?utf-8?B?Wi9hekxBWUJ2WjdWTlRIbHltQklxanQ4Z2tMUGtyeEtLdCtNaXBSaHJ3ZEVo?=
 =?utf-8?B?MTJQcXlReklxYWxLMkdRaG5oME96LzdwemRRR3pjbXF3Ni8zSFZ4OXhjQjgw?=
 =?utf-8?B?dVFHbWdPTWg2ZmFUY1R1NFhyR09sblJPYWVzcXk4RS83SVFWaW9vUDRmaG8v?=
 =?utf-8?B?d3hONjJRb3lzeE12K014d2FHMHFFVDVHdHFIeExTRGVZQzZFT1FLR0pKR1NW?=
 =?utf-8?B?VGFOaHdTQTNOTHJ2ZHR1VHd3LzJDSm1XeDdGVWdxMkgyN1hJM2lFcFI3ZDE0?=
 =?utf-8?B?OHkxQ3lRTnVZM2duYWppdHAxcHVjeWU2WEk0T3d2aXNMa3RzR1VWbHhlMU81?=
 =?utf-8?B?QkRlazVndllUWmRlQWp0NU9XRlVBUWQzMnRtaFlzdmJadXFXNEZFck5jY1FX?=
 =?utf-8?B?aldaQnVEODZidWEwUklXenVzdjhPK2ZlNThGM3dpaEF0SEJ1RGZ2UDhoakh3?=
 =?utf-8?B?UGQxc25PL0x3eUhHdm1DeUYxcnBRc2ZueWc3SHBsYUVTbGUzN1hrQlRWcklQ?=
 =?utf-8?B?MmV2bjc1MDh4TEFGbGRKUjgyTjl2MUZJbUUwdkNlM2J5WGdITHplbEFHTHo5?=
 =?utf-8?B?NVRqOHFueDNDM0FuV1UyNThPRGRxaWxrRDZlVWV2aFRXbWF4NnpneFBaRDdL?=
 =?utf-8?B?M3pZNGl0VHM5a2FieTRUTFJ1WkhrN0ZGeXcwZmhOY2hJNmcydXBXcUsvZ0Ja?=
 =?utf-8?B?WGhDeFBqTWJKVGVzdGRuQ2tETU5nS01QRmpoMGNibUVWUjYya2Q0MWQyWUc2?=
 =?utf-8?B?T1F2Ym9PaTFmdzdiSEpSbHdOUUt1dEZHWnIyTEdzMWs1T1FMOHBGcms4aXow?=
 =?utf-8?B?VlVMUWY5TnVrb1lYZ0Rkb3llM0lvajRsVzZ0YzFiY2xJcjhrV1grRUljMVkr?=
 =?utf-8?B?Wm9NZXNoYmplUW1zeUhZNjh0R3JYbUJPV3VuK3RPQ1lIUWpPTjlsMjhESjZB?=
 =?utf-8?B?L0t5UVZxbEdaWC9SaHJaTEFNQTJtNit4Tm94OW9GWlZQR1FQcDR2a3dmcnlM?=
 =?utf-8?B?REhkZzZObnh4cGVoaG9xOEQzRHNSY3c3U3orZldObFdBdU1kWCtobC9hTmQ2?=
 =?utf-8?B?a3dKTmlLbzdUcWVCa0ZPZ2JZUUZtcnhBa1REZmVWdkNweHpuWGQrZHJOR3Zr?=
 =?utf-8?B?eTd6YmxkaTFNR0RDbEZMQjVJOHFGZllmME5jU2tMU0RjcTFnQUhKNTF2REJt?=
 =?utf-8?B?cUtjMEhPQ0FaVmxyYklHU1ZhOXl2WEIyQ2ZGc1hXT1RGNkhITWZEQWpqbTRv?=
 =?utf-8?B?WllhLzhQNW1UU2RmNThvbFpGSkhHYjBvR24wdStBK2wwYXBTd0RqSHowdG1R?=
 =?utf-8?B?U3BxeWtHMkE2UStjSFRaQ1d4RXhPZU9DTmRMc1dtR0RqeTR3dHAzV2pBSnJm?=
 =?utf-8?B?Rk5kdno1VHZLR1REM2tkRjNhYTRibXhXeGNlVUlaZFVSOEwyekF0Y25BT2Ft?=
 =?utf-8?B?MHBXSlU1OHVqSzN2NFA3SWhpcnBpU0JsbklkTERmNkdkcHJ2cWZlVHZRQmhQ?=
 =?utf-8?B?MXlIRWJveVROTFhBV0h2aEVoOUgzcmd4U2RjNWVEeksraVEwZGFXc291T3pQ?=
 =?utf-8?B?TE0vTlZBT1Z4Vmd5b2EzUHMxTHQvQmIrTHR5TndBdEVxcDVPa1BtZU53eXhs?=
 =?utf-8?B?eVh3a3ZUM2NLTWtPQW5yanpaai9YdUFMdWVWT1RPaER1cyt2ZWxoSWQvekZi?=
 =?utf-8?B?U1RmMncyOE1aamtZNVgzMXcyUTVIek1jaXRta0dBMytrNWlSVlAwV211SUsv?=
 =?utf-8?B?NVltQUh4YjhkSzh4UzUvdnFieEw0RXdPa1cvVU9YRWp1VjRCK0c5YS9oc3Aw?=
 =?utf-8?B?Sll5aXFDMzlXMUtWZFJLYmFia2wvYjFzcHlrTjI2YnJWb1hqejE1Si9nYW5q?=
 =?utf-8?B?aWNYak4rREVkcDI4VWkya3hTV1ZuTDVHb294aUgwSmlkazRLMGE0VjcwVG5r?=
 =?utf-8?B?eDVvdDZnR3NoSGlFRjduMlVLUkI2dEZ0d3YzdnNDeXNpR3VrKzBoZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160104b-e44e-47b3-5461-08de99e4c999
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 05:15:05.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9DP2rLpuKTwABGnkaxjLg2VpmNFqGcj/0DMVg6HEY5yZTOx0mauKtooGfdsiKNu69y5miB43zS8gASA7dHH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6373

On 13.04.26 22:11, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> But XNSYNCH_PI != XNSYNCH_PRIO. PI implies PRIO, but if we enter under
>> prio-ceiling conditions, we won't bail out here, and we won't get the
>> BUG_ON anymore.
>>
>> Please check if you use prio-ceiling mutex instead what the behavior is.
>> Add that to your test case as well.
> 
> With a prio-ceiling mutex I'm unable to trigger that code path.
> 
> This is my new (hopefully proper) test case:
> https://gitlab.com/Xenomai/legacy/xenomai-hacker-space/-/commit/b35c9b37ab4beec5084aa8303d91fec2bf3b4eba
> 

Right, a prio adjustment of the lock-holder that is blocked on xddp will 
not take place with PP - prio adjustments happen already on lock entry. 
But your changes would still cause regressions to 
xnsynch_requeue_sleeper.

Let's step back: In the PI case, the lock holder will be on a FIFO queue 
while waiting for messages. So it may not be woken up first if there are 
multiple waiters - that is something we probably cannot change as we 
have no information about other waiters in that queue and their urgency.

Once woken up, my next question would be if the right prio is used from 
there on until the lock is released. That should be checked by test 
case.

Now to clarify why your changes is not yet correct: A thread is blocked 
on a PP mutex while holding a PI one. If someone tries to get the PI 
lock while have a high prio than the PP mutex, the necessary propagation 
of this prio to lock owner will no longer work. I'm not sure if we have 
such a test case in Xenomai, we definitely should, and this one would 
reveal the regression.

Maybe this is already enough and correct:

diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 70c05c1f49..33ef8ef183 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -963,7 +963,9 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
 	struct xnsynch *synch = thread->wchan;
 	struct xnthread *owner;
 
-	XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));
+	/* Nothing to do if waiting in a FIFO queue */
+	if ((synch->status & XNSYNCH_PRIO) == 0)
+		return;
 
 	/*
 	 * Update the position in the pend queue of a thread waiting


Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
