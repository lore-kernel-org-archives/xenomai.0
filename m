Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158F8463
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 12:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gllgKirmUzHZzVhjgpBZOToRRVl5TMMb9Ds6YFIPUldnp2Uj19YRnngleH0DoGuNfl/0Gkka6i+24xDtgxg1X/28H91jFlCNXJX1t2KdMqe5gn0hRwSVs+ir3csm5fcvHqJbglDu/+SA8Bw+H7aabvQIQRF4YtaTrn6+in7LVY39xXRxLUMukiRqB9bAUSyD6mGSY6aN3/vh4glEBdmHNZ5ZTPj5COVVNIyOdf00w8b4sggdhh+UKl30B5Nn/YZTmhrw3DVQ0jO0q+K+3kIItT5sk3Wag0dxAASkCUem+S0HL9sBKYgEGuIhtYp/elGcVwf/Pkf+PSS9IbrXmIr9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHgi3Z124F+8N1qWL89zCsC0x2APi1yjr+xkcuyyXWg=;
 b=A6OpJ6ciWGp8ZzDwdqO9n+pgRrDyikhuLN8I0XHxd/++FS+2E+CG74QJ1u1ioksEnKl+AFwsdM09dDmCJNZLzrMcucPF0ZUpyzKEd2X15HFPXB9EqRSA2isvYEEHVyXLtPkIIfvv4910jwPoB/9wPDpo6hntk7o5FulwqHPgvfM8AdTp+zCAiz5GQoeV23FHXs0JKD5bouJeIZU7MfYMoLoJFDqwuOr/1+TsaKh1cQT5A4Ahjx4RQxjOjsBEiVhOQW5Q61ebakdvXR8i0BuuBqOs7Kmv9rDWDgKclee2k7ggSugltt+qx0QJ2uEruU+yKx17GgsLooiYP8tasponUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHgi3Z124F+8N1qWL89zCsC0x2APi1yjr+xkcuyyXWg=;
 b=zuJlkkYR9VL1Zg5HIxp/spBQhI3mnwg47xbRcaSU6wADIp5ELdTVcJpML7EtIxLkt/uIpWvyVJcRKXLmG5AJ9BaBQhsxBOLXkqNrZ0k8IIj2g4pcHAKutYXS4e7VcTQDkN9sVUYFmv9wY+Mjfzwl7XtJdB6UfXFTX7n3H7OrFfRvb3mPhw4PZX59oS1VQLwjolNFgMDGlWdOX1t6sD/V4mZbKexeC4wYcehCH9cX4Wg6gtmTPIVvEFRVjzP60KQApmvAcAcV2B6YmDLEq71mU93D46pAQ+UtB9p0AlCp4WD3sJbSVbjiuf/CKIHkCqgiWdntSBP7w7CA4Oh5IsYaYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:30:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:30:49 +0000
Message-ID: <6c3240eb-896b-403b-3a36-d85fe24f8b5c@siemens.com>
Date: Tue, 8 Aug 2023 14:30:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Removal of arm OABI support possible?
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <6712560bbd3fb1b22960b14090d0a4c018f61692.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6712560bbd3fb1b22960b14090d0a4c018f61692.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:52::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f20c638-c596-4411-56c9-08db980b4c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9rXvS4SFH08GpAddPbKyay8lKWH7t+1pW5d6xnsU+xB4j+AM1AXXX5avchmsl3YCCJgw9d4nHFzTE7GJgVPefbecpJeGV3DEXuMB9mz8gAngub+nEpjZIkQpLPlv88A28oJXHmlQMU8tdAQfAdgiLwrqgOl4pWrvyhSCOZuU6ghcQmKKg1ERpqvrZyiXv1vL+Fyu2sj9QSIrsaRAfWvNfuNO4uWGV882jJcUqCXZEbZQCMD7w8tJc1M1YurWUWXD2vbZhmBE+nhiMAmfxOWcaxnUxHlyTj5rq6pLxSVfQLjzqKU67lH3Jq4oXYIo+HGTLN7PrKpinNRJ1Acfoyvha8xSaIxspiVh0ADAdKv+2Ps5hDIcJIop6k2t639Mpd9SQ6KOXKlIwYHw6JBZefuc4YyWq+JaZd9AWALILm8zl6Rgz27zw/AKF+MPoN5KMrxEUjjK00SSReP12vAlDqtSWvw0LOFNjY2kX8pE/taWMKB5KlG81aH/xhqQlY0263nY/ZmD+nNo5S7BXPCf6dES1J4GPStKbxgI7A0fQ5nG869/vIfHMHJoF8Swki631QDT7BNemEwVvr39dkc2Mlmn/RoeQZc9EVfrAVlf6X5k90UZWHPN7Ws+miRkmD7O09HB/5YQC7JWYJUabxaZF7oLEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(1800799003)(186006)(451199021)(2616005)(53546011)(6506007)(26005)(107886003)(6512007)(6486002)(6666004)(31686004)(478600001)(82960400001)(110136005)(38100700002)(36756003)(66476007)(66946007)(66556008)(4326008)(316002)(66899021)(41300700001)(8676002)(8936002)(5660300002)(44832011)(2906002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVBjRjkzUUZDYUhsSFU1UGpiZzhBQmppRE1BSHdBV1VZNisvYndmK2hhdXFP?=
 =?utf-8?B?V0w5YzZqeUpyWG95dm96elJwQ2paSDVhR0JaTm1lNTYrYnFkbUlnYnpXUy82?=
 =?utf-8?B?UEd1bC9qaUZxWHRSOEZOU01WN3JjamFuU3NFUXRmVFQvbC9VWXZ0eUlkZlQz?=
 =?utf-8?B?SkRmaThkRWMxWm9URm5oLzRwUFlCbGNZRWZWUFF3eHFzN1ZSMURWcnBGa2dX?=
 =?utf-8?B?SXY4Z3dEejIzYjFXU0FFTERqcWdwY2lObmt2TXF0UHNhUmRvZER4RUZYZ3lo?=
 =?utf-8?B?SkRCN0t3UStWZDVyYnIwbHF5WXhFalF6Z2RrWlNpOEFiTHlXM2w5NDd2Tkg4?=
 =?utf-8?B?aytQM3ZsSCthYmF6d0o4L2gzT0FwWVNxM2dSQmJFdGF4SFRDM1UyOG5CZ0M1?=
 =?utf-8?B?RDhzZEZ1aDh2ZGJyM2FjNjI5V210bldZUXByQ0k2dTMzUFpXdEZ0Z2FiRzVF?=
 =?utf-8?B?YWVaV0s0NWNCTXFCczl5akt6ZStWcHUyQlN5cGtPYVFQSTFEbW5MWEtveXhQ?=
 =?utf-8?B?d1FVYTY1Y3RnQlFUamZTTFBLQzAzbTdtT25Xa3N2dUtUZVJMWWNSVVU1WGtj?=
 =?utf-8?B?YTlKWXhiWEhJZkZ5cnVUYUpHUWdvTTNnVlRScXlNSk1JOS9wSHFFd3hlKzVS?=
 =?utf-8?B?dmYyV2J4M1Rka0NBK3U1a2ZmSDVVL3QrMTJzUlQxd3FwdGdVc1hVTlpXVGlj?=
 =?utf-8?B?TWtMc1RUUktqRG5vbUtNV2FrMDJFSjZrZFd2Ui9tQ2NtdHFOMWJBWjZnL0dG?=
 =?utf-8?B?YW9RbVhad2FFVFZLbWo5MXBUZlRSVTRoY3kxdCtvU2xqRlRSNld2b0RCYTN4?=
 =?utf-8?B?b3VwSkw2UGE2ZGVBZjRXUnJTVE5GMjFraytTQTRZRVpodjJPYlE2Tks4OXI1?=
 =?utf-8?B?NkNCS2VsM2VYdHQ2cHB6UlErcnVkYzBQczdCQzVGOXRaL1FoTTllVzFUQWVH?=
 =?utf-8?B?NlQ1ODhsOWM1ZTI3b3EwN3FGcGFEQjBjVGtzQTBGTmRqSUJ2VzNBaTQvWHhZ?=
 =?utf-8?B?ZnRxekp6emd4dm1BK0ZBalBFZmFTMHI0K3NCQVZlenhjZTlHelN1U1RZakRH?=
 =?utf-8?B?NTIrMW1xQWpnaDU3N1ZER2RWY1FhdDJxd0loT0Z2VWQxcnkrSERTMUNQQzAz?=
 =?utf-8?B?MU01akdReFZJK29nK3FHcTZYVGgxLytZWC8xZ2ttNlVqVFQ2Kyt4bzdMclpE?=
 =?utf-8?B?WmpCYjJYWTBJY2M1VU5hV0tySnE0NUtjeFFzdnBuSjB3U2poaXBWemF1Vjdj?=
 =?utf-8?B?eHZ1blM0bUpqUE9oY0lUS3NLVlM0eXJ2ZkVDUGJEa2RKeDZmRUdQcnMvd1NX?=
 =?utf-8?B?SDV5REw0Zmh6NmlLT01NSU9LazY5b1pHL25GODhGL0R4Q0pWNHFQdDJJUVRS?=
 =?utf-8?B?ekM1clZZK1MyZnlrazZwM09WdWpxS2YxbFYrSFM1Z0o4a2NCUGU0VWxwZGVS?=
 =?utf-8?B?c1BFa1hMUkRISUI5RTJtL3Q2TWF1a0pEUGZvczl6WDFHM3RxeGxvNFg4V0k4?=
 =?utf-8?B?Slg0K1RFR2gzU3BFdW5QS1p4L3ZWbUZyVUJuaWtlZG1SeWhjMGhsT0c2RTdx?=
 =?utf-8?B?UTlCMTdWelMwVTdFczdHTjhtbkl1WEozUXpxWmJlcGVyNWhTOFBVWjlkZEJL?=
 =?utf-8?B?VjZjN2V2M1l6TzRXcHVjOGNkT0daYmt6d3luTUNLZGhqd0FaS0E5WXRySjQx?=
 =?utf-8?B?YVpBN0pRaHFnUnh6dFVqVURwbk5EbXNOUzNQVnNzVy9LRVVoOHhmeDhLeUVu?=
 =?utf-8?B?T0xoNVdEM043Z3VTeU5HZHNFOHVzQnMzMWxWSUhCN3h2M2pEeFI3bDFrRjNK?=
 =?utf-8?B?aXRzaXRYbzRaMXpIV0t2VVFxQ0dNK3VMQ1FrTE5HbzRseGNpNjN0T2xKY0hD?=
 =?utf-8?B?c0h5dVhUcmRSbmpqcUFtZDRwNjNrL0lrV1RKZFVGUEszN0hqUE8rcm1YYnRP?=
 =?utf-8?B?N1RNN1VTMXRRS2VMY2VMSk0xOVhqcDM5OWIxUm52Q0QwdTBOSndSMEk4bkIx?=
 =?utf-8?B?NnM2K3NEaFpNVkZTUFBGdTV4NGptMFNUQVRLWnRMVXR0UHFwY214dTVpbU9m?=
 =?utf-8?B?UDl3RGVmK3hwWUhJZm1idE96Q0xxZi9wSlQ3YUVQSzFGWmxuWitnaUd2MG5z?=
 =?utf-8?B?VTk1N3dVZ0N6Q1dwWVZVYXphcUZtSkZlcXpTdWlYWDIvVHFhMEtyeHh3S1hu?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20c638-c596-4411-56c9-08db980b4c3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:30:49.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHqxFhCMaaP0c44EbBR9fz/rNt0tL6KGjvCub63mw0OkQv2pvxHjvS4dRy/kjyco0QN9PgkczsWPIgpWiYLbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4035

On 07.08.23 15:29, Florian Bezdeka wrote:
> Hi all,
> 
> Clara is currently trying to enable compat support for arm64. That will
> allow us to run arm(hf) applications on arm64 kernels like we do it for
> i386 applications on x86_64 kernels.
> 
> We fixed the Xenomai arm specific register layout in a way that is
> compatible to arm64. That looks promising as the testsuite (smokey) can
> already be executed successfully in such a compat environment.
> 
> The changes we made affect the EABI only and we left the OABI interface
> untouched and expect it to be broken right now. We can't really test it
> here...
> 
> Is there still the need for OABI support in Xenomai? OABI is marked as
> obsolete since gcc > 4.6.4 (~2013) and Debian stopped shipping oabi
> toolchains long time ago. Would it be accepted if we simply drop the
> OABI support of Xenomai?

From Xenomai 3 perspective, it would be fine to finally drop that with
the 3.3 release - patch(es) welcome.

Not sure, though, how the situation of Xenomai 4 / EVL is in this regard
- Philippe?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

