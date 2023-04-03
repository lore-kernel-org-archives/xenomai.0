Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FD631
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 05:29:59 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id B2BDF240002
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 05:29:51 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9C3B2D8042B
	for <Xenomai@xenomai.org>; Mon,  3 Apr 2023 05:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzAxCaZl16huxnJojBIJaOs3RPbJpgGRtvVnkZEg6VFv85+vUj2owUdu/0TZ4LMKzsLeThb6EzK4UXm6oAQkh8JgV0p2NPI2GNsGhzB2cYC5HoZcH0xYPmUWd8qWktFeN3dBNVcqXQbqhOYM1Vk/jKjcbUREjyxqPpiBPvSXCeSfdIngP6umUr9XSD0Qo9WRpz8Jq5xeiruS/+yl4DvClSyXGG06KVLGW1ZfYjYAWGxjhIyVQlfi7e2Y6JMx+plvnBTdtg+lOfc62mKgZZ9jgGgEKGoY9nk4nGSC0OMipaZ4Jpx3koH3zhJ6q+VI32V0Kq2R9Oc7prp2VcHSmvQjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8zHieBsD74zIOKv8uCquI1SHuB01HA/uQ6MVAJ6zKw=;
 b=TK37Ln7VTkJczrNHpVAV51HCv01qg3JZoL4KzBe16sTHZ/wisJC0azipNP+Wbqsmakp13E7aKBIJ3BsHjHZ9aCVC7uBtdCEzX1VdsGQDSXVynA6RpbWsW3Wc2uK2IyBUgs2jvksZOOyEUXsCbzODIo6SIzy2prmBoCTFFH+bJmssCsPWHFVV8TFvBEGt7ubGXtq2wdsqw+cBJQzfzJlVA5F4jfI6SGRC5CG0YsrXIacQjGrSOcwrx6saDe/G6Gic6hXf9yD189sQULGRzv7Yoi+jDk8uqIIFr8G/fqKzheNsVJfsv4jDRnlgvFNAnzljyobZzuLucD7ajO0jVL9B+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8zHieBsD74zIOKv8uCquI1SHuB01HA/uQ6MVAJ6zKw=;
 b=iIj2WEobEjOaHQx9WiP5TILfNAIwWndwciWGq2lhXtzUSm2DSTNe3FoMUCel1KA9n600gkEnIXIfi6Nlz15d0vzFhnw+Tvz2YEt04BBdTUtB4bg4wa5Zi8ltcaXfVZ+lW+yma+D0MwBF0lwmCufzh1SXhOA18c++pAk9iSTy74hsxTxvBadA9cDukZ7w0kG41uXL5VUBRF7AKX2uNES3O24BQFWPSTn310XwTr+hOatD6WxRUT/uF06nprOwQyKNci2oz3w5GWbf5K4TxWUNLYl1il7yNzv9AovlAWmKkjxcqjKEC9TD+izGq/uqS7CwmpfcfRP6hjZAXQBNQqVDsA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Mon, 3 Apr
 2023 05:29:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 05:29:49 +0000
Message-ID: <cd7f3ef0-d8a8-012b-f755-d4fe1d3d13e6@siemens.com>
Date: Mon, 3 Apr 2023 07:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: flexcan irq error on kernel >= 5.10
To: Julien Blanc <julien.blanc@sprinte.eu>,
 "Xenomai@xenomai.org" <Xenomai@xenomai.org>
References: <5ecc6e0045d7fb9e12096b2956b09595cb2f1af0.camel@sprinte.eu>
 <80f2b734fc44667d2a6f7314d52b118516996958.camel@sprinte.eu>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <80f2b734fc44667d2a6f7314d52b118516996958.camel@sprinte.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2339283d-18e4-4b55-593c-08db340471a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HZTcACtOvnHX0hAqe9IRPDDDbyPiQmn6agEoohrZoq9rv51h44lH5rX0iSEfTTDE66T4rNpCUVyWgOeMfjhDTS5078LcaoaHTzdtASG60v84rmikipwTZ9/6jqI02Xagwcg76rdo/OiTrkQ3aD25G9RToYoMll7p28jJ0o0lN6dN9OuQjS/5pnYqig4bSw4DFdAPfyAVNkBf+AvDLClymJA7UGPair/r5p135kFBKfPydOymEyK46HTXnQ6wgTNYfLemYa7uje5bSrVnzf4rpAUr6qm3xiaJM0HnfOzcnANqI7C2vg7sb4HrZ+8nM+1E+fgYYfDZMHlCJAMVRy2cTPMQgsM6vTaqBg7BYmORJbnowCUfFtiF/DJX6cmY6g2XBG7kuWWoSGiKwhK5gVpD/DIvNrj/Ef+SBpRBtQN8Sxs5Wmq9bwnyZ4YmU47aegFDEmv0uwX2m0p7OjJhrgEMiBmqiJY3HCX8BPq5UGWIDfZOyyhXoA5Zc1RjZT/LxL/QH8G0kiw0gwfUhw+nlpNbBi55pkm4j17YZ84YNIBPWrjZE+5XgAOb61dbjnVsYEG2yKi1Vj+OTn1Rt1RifabjZeXNawl5JIZlyYINYP05Mr9n1NFHpV6FaUyNca9rECYObTGJyqDWoiLCEYm3KhvvgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(41300700001)(8936002)(82960400001)(26005)(110136005)(316002)(5660300002)(31696002)(38100700002)(86362001)(44832011)(66476007)(66556008)(66946007)(31686004)(8676002)(478600001)(2906002)(66574015)(6486002)(2616005)(186003)(36756003)(53546011)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVU4OUxLRE1DblZuWkkzMGpoeUxrNUhZWVZNSytoR05LRk1wV1JNRXYzYjU0?=
 =?utf-8?B?RXVNcnUxUmRuNGdQeURQaEduSFlyblk3WCtqVU4yMGcwM1B4NVVkazJnRkxy?=
 =?utf-8?B?czg2YmxMWWF5ak1jdllQbXJ3OXVJZU4xV1FZRmkwQUlOamwwOEREeFc0N3l6?=
 =?utf-8?B?SS8yTVdjRzBKWTFxNjlNRmR3c3l1b3MyeTVsQStMSTBxS25JenovT0dvZ2ZT?=
 =?utf-8?B?T1hjTEpRSUlsQ2svdzR0Njk1UkRnQVZzejlYa3A5MUljU2ROUFQ0SGNONGtP?=
 =?utf-8?B?VDVFd21qV3M5K3pEVm80Tk5LZUhWU0JpUkVzOEh0V1NXbHpkVXlRRnZ6YjNP?=
 =?utf-8?B?bFFIdDFqUStjYy8zcVcxbGJaUXNEUWZUUlJhSkxnMTgySjUvdFhnb2RTak03?=
 =?utf-8?B?UVRFcXNYb3VJT283Yitoelc5UDRaZnNrRTJyd0F2bHlSNXFnNk9wMlIwMElp?=
 =?utf-8?B?eG56Wk9GOUN2cisybUMwSXI1VnN1WVFxUlEvMVY4Q0ZSOVZoS2RhaUVkMkRC?=
 =?utf-8?B?eEc0S0Ftb29iZUZ3dE0xYytsSnRYN3N3eGtHb09abmdxa3VZcnY1SURtazZm?=
 =?utf-8?B?cEt5TlRIaHNUWUVER2NzZmhBcnZFeVlpWmhmUUkyclBmd0JhSDRoR1pPQlll?=
 =?utf-8?B?UklGdzdhQVh3WjM0dW4rRDVTcGI4RGxrazVFTmVYY3JKeTNzaDRHNlN4VW9D?=
 =?utf-8?B?YWtZaTJzeDJBS0JiN0VQN3QzU2Jid2Q4QnlQM0x0NEtiVDBERVFHU28rbkx1?=
 =?utf-8?B?MWY3T0wvZTlrWDZ1alJTOUN5N0M3L3p5cDcwOE5Fck9taVNDZmhWZlg2Q2Rr?=
 =?utf-8?B?d1lzY3Jxa0JaM0MzTVd2amZjVDNhTGd0WTNvdVgxeGtua0hQSS9hZVFIVUVJ?=
 =?utf-8?B?NDNHaXlMcm1nbW5QbFI4ZDZYMjNTNTlTRW53YStKMGJ5OGpRb1VBeElDTWFy?=
 =?utf-8?B?L3hWWjUxZ0twK1NHSnAyQ0xhU05sZ0g3cGo5M1pWVTJ1Q2JCZnJDcDVrM3lI?=
 =?utf-8?B?aFVxVW5DUDBxZytsbm02cG9qbUFVMytLd3BndkdZTFhNTHM4b3dIUlRRVmZs?=
 =?utf-8?B?VmZIRHRIVGJ4UDJ1UFVYdC9GemFySWFsWCtXdnB6QlViUnBYeE5yaFluMjNa?=
 =?utf-8?B?WjFGN3VZMEhOL3c3OUN3d3Y2dTg1QjE0bDlLWm5hbHlmMW02b2hPdGRQS3l6?=
 =?utf-8?B?OFQyU0FPYUFuQ2dpQ3BnbThFS0M0NlNyTnhSaDBSV3ZLQ094L3hzdkhvOG5y?=
 =?utf-8?B?cWhLMnR3ZlVlNTRXSGZSb29MWHVGa3hmeC94MkwveVh6Y2pZMzdTNnFhdEky?=
 =?utf-8?B?eEZFZjBtWFBIWnhKaS93cDBtVEE1WXJOUkx1WHVFRDk5TEhFTndpMk5zc0Qr?=
 =?utf-8?B?ckZzOXRNUlBVQ09OdElhWXRGdmhBU3JYTDJoNGk2dVJOSWtEcEsyZmh1SkpL?=
 =?utf-8?B?aFpYUjIvQXd3YkJYWTNNMFV2My90WGs5cis4TERyZmZHaEVsVGsybVZROXd1?=
 =?utf-8?B?RWlaUDZ1WUVDS213WXp2d0RCMWJoc2ZJOXBXNVpoSGhWaDlIeTRkNmZJVXp6?=
 =?utf-8?B?Wm0vNFR1UDNwYWY3MWxONndQcUF3Q0FtL1NyY3NaM1gyUUhzYnUrNndwQzRh?=
 =?utf-8?B?dEJOZmFFbkNqZ3dHSFlUVEJ5U1pjRDJIUVRGRHNzQThuc2tUOHJtUURyU2Fm?=
 =?utf-8?B?Y2J6RXBwSlVrNk1aOGpYOFBQWXZ1OEtadk5aQTVyeXB6dVhnOVI2R2g3V21r?=
 =?utf-8?B?Zit0UXBITU1rUno3eWJiV0Q3cDRwV2tRVnVwQWw4a2RVS0oveWxNcUNEak1a?=
 =?utf-8?B?d0NtczBocldSMjZ1UHdBbUFacnY2Sm1QVVJwUTJ3enltSGJZWGhPaTRqWE9L?=
 =?utf-8?B?bUFzMXkxU2JyK0NQSGd6VFd4blY3U0JXb3oyaExvRi8wLzF5Y1ptMmVpQ0RB?=
 =?utf-8?B?dS9CS3R0RDRKVmw0eSttQ1ZXbXdiU0VNNEFNYUFSK2xJY3Nvc0M2bjI0M3p3?=
 =?utf-8?B?NzdNL1Z1T08zelkyR1BGYklYUFBFRkVhWlVYUVVPamtVSVR3UVd0bEZGVVMz?=
 =?utf-8?B?bXJ2VXJHSDE4TkFQU3RJK3Rtb1A4S0p1UHhZMUN6UmIweWNjWHplYlczL2RQ?=
 =?utf-8?B?eWxUSURpYVVFbHVNMm01T2sweE1ITVFERnJaT3pMSTVueFdVS1d5azBRUlJq?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2339283d-18e4-4b55-593c-08db340471a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:29:49.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnw0iez1DIqyjexXWvedEC6npb0fNvfWhvBW53fwVpxqIcnlL6ydu4BRsMuxsET522StroK899SDoGDyRFIWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7268
Received-SPF: pass (spool5: domain of siemens.com designates 40.107.104.75 as permitted sender) client-ip=40.107.104.75; envelope-from=jan.kiszka@siemens.com; helo=EUR03-DBA-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=iIj2WEob;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.104.75 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 31.03.23 14:55, Julien Blanc wrote:
> Le vendredi 31 mars 2023 à 09:29 +0000, Julien Blanc a écrit :
>> Hi all,
>>
>>
>> It looks like the interrupt is not enabled at the hardware level, and
>> for some reason the driver fails to enable it.
> 
> Replying to myself, i could get it to work with the following change:
> 
> --- a/kernel/cobalt/dovetail/intr.c	2023-03-31 14:40:17.640127580
> +0200
> +++ b/kernel/cobalt/dovetail/intr.c	2023-03-31 14:39:59.048341842
> +0200
> @@ -100,9 +100,11 @@
>  		if (cpumask_empty(effective_mask))
>  			return -EINVAL;
>  	}
> +#ifdef CONFIG_SMP
>  	ret = irq_set_affinity_hint(intr->irq, effective_mask);
>  	if (ret)
>  		return ret;
> +#endif
> 
> I believe it's safe to skip irq_set_affinity_hint on non-SMP systems,
> as the affinity is nonsense on such systems. Or am I missing something?
> 

Nope, this is correct: irq_set_affinity_hint returns -EINVAL in case of
!SMP. Please send a patch, maybe also including the invocation in
xnintr_detach, for consistency reasons.

> I could also get it to work by enabling SMP (although I ran into other
> issues, and don't want to do that as my target is single core).
> 

Can you give at least some hints about that other issue?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

