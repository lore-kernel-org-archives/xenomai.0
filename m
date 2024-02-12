Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5D3B29A
	for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750757; cv=fail; b=FosgIROra6zM1EQxbQncZkv5ljQ9qWhwQSrudCtUOO4Ojx4Yl+MA5e8yEFsvhBLK7LAMorj+vWOQ//Ry+cHtPzfZx8W/LcSuthMRUvQqdoVk3zzS5lrZ6eBitFKzcc8Vx6R3nmDQSxtcoXNeEasmxcA9479Jav2z840g4uIWwRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750757; c=relaxed/simple;
	bh=Xq5kpgHnHrA00cGsZftq6HWETpYiti37UMDKdTFQS9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GVwo/IRhFBON5BHf7N4eWTk6GOGOVlK/q3nd+GYhznQhcaC1wkboC4BSYs1GfYlbMhm1uF+n6zPvCmdRBIl2PPuz+BE5m/LYqMtqdEFzFQ86OPYzvH82XjeTw0o2GQkYYTN8WL8iuT4kD7k+Euxv8RwVaXeUHyUHX8sEUJB69Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h23wRzCj; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h23wRzCj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRvSLq6utIrsKLPgBumqy9/AL8M3Ra5Rp+0Pg7qTWzj2sEQqFF33tgH36B/J8Sfv5DSy1A9Kuy2qBZUR0k+bo9avi9We2e1YQEKs3iNMNVbkj9YcP1UTnR6ka8x4wGRUAk7+tPKddCK1HF9w6Xbfcklni+S2QiFqM8nnyLmg9nIKgqoR5obHj7suBOgqNTRWhMmtYlopzbhKr8Mtu0EmkeuBVcu2rdSZtP8/VD2/N60FjiMBKUgrjHL8dkNLDA27muVE9LlpMGKpTGN+ez3ikLfWnJwhcyhap50ltAdfzttQNgy7gm8KbGMYme4FNCCRuJyFbaQBvZ5zj8glki6qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcRW4pNYFpksry1G+HZfNoN7u56MCX2bMqaVRtTM4Ak=;
 b=FyB/4Z6dQat/gXpAGcx383kH07j+kT+3vjQqccjxxkOYts+ePg7bb0sqUTucPoTFVI6Z00VEfEIwWpoQf3YV3qoFzzN/Y/6qHwUnhvv/nobM65vqH51476pUrl/he9EadAbzQ2Bg1gdee3PKKwAfuRiRB3nVP892jZgzpFAAHtwbb12soVAIycfQ60rl3GFyBDdFgBRq9C7TK6eAD5Bm1GVWEgnQinWdLiKWhkmGHHPJy4OmgzNnDYN9xLsHB4rhzTqg41ukDsROOw58AY/l6omCNeFqwZHhoQCkJRzL2BxcXGD0sAq2XH90bfNk53Y6O1OzibPBoO/w35x+Oo2f1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcRW4pNYFpksry1G+HZfNoN7u56MCX2bMqaVRtTM4Ak=;
 b=h23wRzCjK/fcnIr64/1GNGFIiBart8MaP5yLHUAbfx96R4xVwuvoCpR3drRzCIzVPDRn0tvVuMyw2s1jR4EAhsMCkBctjvrr1gbQodf0PrdnkpW7PeqfL70EdbNb90HcUFdCz8UpiLDylFL+h5vN9bUfHwXDYEukCRlUZBs28A8klG95fBJ1JEnf6wvfQak47qY2r5ZUouSuxHRz7Pa0V7oeqnawUWOgv8igR774IjqRzVKptTFgG1DwwtFwihiImxoSFfBIhmGoWalPtj7reK2Edj7kSQWAgYXc82FF4v5D4BAOZ2G1NUkgOLIsN+RhJNOJkBZMOkRg1csOS3zHaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 15:12:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 15:12:28 +0000
Message-ID: <3ca2aaf3-f47e-4fbf-8d46-b5da9542bc3c@siemens.com>
Date: Mon, 12 Feb 2024 16:12:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Richard Weinberger <richard@sigma-star.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <874jv7rxb2.fsf@xenomai.org> <5809272.1B3tZ46Xf9@somecomputer>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5809272.1B3tZ46Xf9@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcadd5f-6e75-4768-b793-08dc2bdd06f3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 Z+jdcWJDc3rysikmE041iruMG7k5r3l8TDr/uLQJ5I1ATgtSnuHW4t2YhsLxxrsaHTfMRd8IEs9n9+S3QiadJMnnGHX7VPtGi08iliCY48MNoPAXqXgsIkw/VsCnwkZt/Jeou7gIM1HGMTx+8y0rwP7EY0fo+x3c0YuRTxslM1i/zlhI2rRAIRpciTrGiTo1Z9rSQSH63qJZasdDuj35way8X5s3koMXPoocZ10e3RCCAS1LImjMYZ5RK4AbU9NY7yW4+HsWkaHQT8suHKoxCGhT7HvLVsjrOpbvdjgtQTw6YId6+9EgHTmeRC3dfUaYbDlXSayrumcMRCPh6rrMdFhrda9PW/eTYAL/EX2RgjbRZpgLBEEabbX+Qk794PFFTa2ee04uPeJBK2r4EeKf4pPHXHKylhIFS4+ArNaX+ljTXLmeN73qEJb4DMNHVVwNpfbyrOVBxBbd3I8vszIek1czKObv6FJBHgK3rRM3xcx9r/VgNFr0BCOTvP3TCAbf1eAhO8+qw3tdsOrxxo+Do1GRPLMY6Tih3XqEYo+1Z6rMhKGg7NaPWy8bWMmTxRIh
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(53546011)(6506007)(6486002)(66899024)(478600001)(83380400001)(26005)(2616005)(2906002)(44832011)(66946007)(66476007)(110136005)(66556008)(316002)(4326008)(8676002)(8936002)(5660300002)(36756003)(38100700002)(41300700001)(6512007)(86362001)(31696002)(82960400001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YlZVOWxHM1R4YXIvQ3gyLzFVbXdGUnd2T282SWZQY3FCOFpab3dqY3JPcGhu?=
 =?utf-8?B?NjE2azArbGk3K1BVWXc5MERJajFac1JxUlduMklEK2pkSno3U0RuOVp3VGE5?=
 =?utf-8?B?SC9YUE40SEhjWXlOTXFLMGc1VnlRaWJ4b1poeFdJQ0pZMVVuVXVrcmdxZ005?=
 =?utf-8?B?b1B3Q1lrTVVrRVFDV2pjZFBGdTBESmNJUGJVYm1wWjgvTDQvN05sczlqdGgv?=
 =?utf-8?B?NEcyeDBuMS80UGVRL3VsMWxrSWRRQVZZWHJDSVFaaGhlWWtiZ29wd294Tklz?=
 =?utf-8?B?aTlMK2dBSHRWaHlhcSsxaCs1cmpFMnJOL1ZXU0d0K0p6SktpSnhEeVhMLzZ3?=
 =?utf-8?B?ZmRaMVRUQmoxaHpNb0UvTXBSenBCRWNuZ2xyd0x3a3FyQzRkbDh5eW8rY3FX?=
 =?utf-8?B?UmxMYW5vSi9MMTdlWkFITHRkWGRFaTJuU3RGRE1DcEZPYnNKQldvUVhxNlNv?=
 =?utf-8?B?M0xKZ0h3bUxBNUlIVmRYdUdvQ2lFdDEwanN0MkdRSEp3QzlaVXR1RjZHSTZq?=
 =?utf-8?B?SEpXYjBTVENzMVgxZERERFN1R1RPZW1nN0VxMXZjcENkMlJmY2hYeFBSRzds?=
 =?utf-8?B?cTNhbFRnNUVRTEJDaTdZeDZ5K3VPcGZ6VTFwa0ZoOFBmZ21FNTM1VTZJYmFW?=
 =?utf-8?B?ek5VQlFhTmc1YjRRelRRWTJpdGkvM2d0RER5MWlSV29xWUZyWGVWOUdRU1c4?=
 =?utf-8?B?RWRoZDA3V0REV0VVZFRpQmRqckZqK2oxd2M1OXN3UWcxVElqcHI5N244ckNI?=
 =?utf-8?B?ZTNXNXgrVU1JTFNCNG45d2hpbEhRK1lVeUJKYTJ6ZnFPWitvOU9ZNXZkR1Zp?=
 =?utf-8?B?ZHJQL2I2SXpXamVIcGVIdFM4ZXRqZGVqTExBbmJySmFKUnh3NEZqbDEwaG85?=
 =?utf-8?B?UEdFa3pJRmhLUUtiS2N0VmczYW9SV05haytsL1A1bjRpY0laaW04bFloYk1o?=
 =?utf-8?B?VlV2bGc5Yit2OUtGL09DM1R0aW81TmpDR3R0N3pDQzZZcVJudmU0U1BRQkdF?=
 =?utf-8?B?YmNNZXg3MEgzN1hyVWVpS0xtUnRIeUVzVEtPd09JaHF5TyswRzNDZFllMld2?=
 =?utf-8?B?SUFGZjJtMXF4czhjclhkMlgwSGJJdWo1bXlkWmVPWDh6U2ZRQU03TXZDZVow?=
 =?utf-8?B?UHNQck9adVhpZEVla2NtZEZ3TUI3VXYzb1dJTGVrQ1V2Z1ErRkQ1VXAxUkZp?=
 =?utf-8?B?QnRuTVRtdXRsMDF1OWJYa2trUDBwTlNnZUJNZzNXK21wbXBqenQ1ZjRZU3BI?=
 =?utf-8?B?NmxGVHRCM0c3M05PYURnZ2FCUGt2NzRvSFd2RzViQnZpVmlERWQ0R2xXamxv?=
 =?utf-8?B?WDE2RUFFZHJzLzhFVWlEblFJeEJPaU1oanh4MmhrLzdPYjI1NjNseE5rMGox?=
 =?utf-8?B?T0dXYmZvSG5VQVdPWDhpR0ZOMzZJei9yWFJURENwd0g4c3k3alM5QS83czBl?=
 =?utf-8?B?SjVrK05yNVk0ekorZkc2QWwxalU1SEo4d2RsN1FyOTE4NWszU1RUVWtCWVlK?=
 =?utf-8?B?dVNQVCtveEZycGVwMG9FalFZU1BIU3ZjcHY3UHhQK3cxMDA3ZUk2RW84OWRy?=
 =?utf-8?B?Z3BWQzhkWGZvN1BtQnp1TEI2Sk9IY3NId0kyZU52dFpBV1pTSkx1dzJWeHp0?=
 =?utf-8?B?OWpzc1FKU0lqY01IRjdnc1FQejhpcHdMbWlzSEJzWUlqQzdNYmxuc28xSUFR?=
 =?utf-8?B?VjRTSDRIZDRCYzFUNEs4cjdpVGN6eFpWMTRrWUNIcy80Y0VnNFlPNXdrSWxx?=
 =?utf-8?B?VkozMWZOejFVYk11YU93OGl3VXpIVzZtdkhnNWxaZ1NON2hoOXhQVVpNNmFR?=
 =?utf-8?B?K1dpdUw5dzNNcjBydzhWY3dwM1lXelZwMlQvaWp0OVFPMFBWVUZXWGZsNlAw?=
 =?utf-8?B?d1pFWjhoT2lwZlU2UjdsYzRieklMclVMeENwNm9xRU55TEsxZDN2K2l1OWZP?=
 =?utf-8?B?djF1NitKK0l4bU1kaVcxZ0s3R09IT3FmcTJRM24zTEp5djVlQU9aMUE1aDdj?=
 =?utf-8?B?NkdIMFYrV2llQXFSS0R2bWM5cW1zcUFyNUVZV05MbXVyVEtWVCtCTWxsY2U4?=
 =?utf-8?B?dWx2Rlp2Y2c5S1RDcms0cXZxUEkzVDlyKzFucGZZeDNtSHl4QUtJOUp0MW14?=
 =?utf-8?B?ZE1Pck1JZ3VTbFZWSGtQVmVsbnBhZUJ5SCtTaXhLTHo4VjIvZk84RDEzREgv?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcadd5f-6e75-4768-b793-08dc2bdd06f3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:12:28.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilXJYZC9BBgPPpWoshVuLrW1fheW64fD9MfkUo5adQGp3TG8FY2UGWKqx7Yyj5olci6AfKlV3W0SB7d4mIgFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6642

On 12.02.24 16:04, Richard Weinberger wrote:
> Hi!
> 
> Sorry for exhuming this old mail thread.
> 
> Am Donnerstag, 10. November 2022, 10:00:33 CET schrieb Philippe Gerum:
>>>>>>> I also did some similar changes for arm64. As we also use imx8 boards.
>>>>>>> If there is interest in those, I could post them.
>>>>>>
>>>>>> Yes, please share. Then we can continue with proposing it for the latest
>>>>>> dovetail port (6.1 now).
>>>>>>
>>>>>
>>>>> There is a slightly different approach which expresses the intent of
>>>>> that notification hook Dovetail-wise:
>>>>>
>>>>> - if the real-time core switches in-band upon notification, then the
>>>>>   in-band kernel code may assume that all regular fixups need to be
>>>>>   applied next. This is the common case for most traps.
>>>>>
>>>>> - if the real-time core stays on the out-of-band stage upon
>>>>>   notification, then the in-band kernel code should assume that all
>>>>>   required fixups were done from that stage already, returning asap from
>>>>>   the outer trap handler.
>>>>>
>>>>> This gives the same flexibility than by expecting the hook to return a
>>>>> continuation status, but makes sure that regular fixups cannot be
>>>>> bypassed when/if switching to in-band mode is required to handle the
>>>>> trap. Rationale: the regular in-band trap handlers know better about the
>>>>> way to deal with those events from in-band context.
>>>>>
>>>
>>> I like that idea because as I was looking at the arm code, I was not sure what would happen if we are out of band but 
>>> indicate that the kernel should handle the exception. With your idea that’s not possible.
>>>
>>> Will have a look at my arm64 patch and try to adapt it.
>>>
>>
>> Ok, so since the idea is generally agreed, I'll push the x86 and arm
>> support for this in a couple of days.
> 
> Currently, I'm looking into implementing Johannes's RT-Signals for ARM64,
> but from what I see on the dovetail side, only x86 has gained support to declare traps handled.
> 
> At least on x86, I see that a trap is considered handled if no switch to in-band has occurred.
> Did I miss something?

Yes, I do have some first hacks here as well. ARM and ARM64 is not yet
ready for this, unfortunately.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

