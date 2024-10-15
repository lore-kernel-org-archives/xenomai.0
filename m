Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8638DE9
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977424; cv=fail; b=KnLhCIb88BvM5NWaSeT4mb3rWS822OoC9NBTfGv8idUPEsufMAZLU5zrV5Xb63RQx1pP860T5xXiNygTZRIjJI6Nj6V0YJR95rxAG/lHx8mqDqOzSd0CliaIasZRujd1dkL0zPluXqTRXFircbWuQcO5YxtKskqn4mKFVjyDk6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977424; c=relaxed/simple;
	bh=IwmA+RRsBmbPo8mzcYhDepiWXp+SvcPbjTt+c7rLzOI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jrw+C5rzDOdSsWGYjE9eFziz/ddrRqOkyCPm0U7DVDGcjKZCgpRR1avcnyKBDP/7WA6Uznvwfujqaa0AWehVOazEH334BGwEBHBAlHE6k5RZIIb2v+0S+ExlwwUQ/LxbfFdKYY4j93g6BGFAl7nw8/CEgbVXD1im6VjLRgAE8dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mh7L703M; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mh7L703M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxXkEsMnSzostMlPXw4wN+O2OnYRhKOYaj0UyGC/Jyib3/wNlK/0S7GlVbY8pdZ65pADH7dE/mIY9LAIg/qgvt3xcz3MpoYJ6NAtAoV5S5utbFTLEdTSVTisw8Opc8r68aSHyyRobIL1Ffrq0TY1Qm+WbH9xrKIratOj923AhVuusVgiybhzK9A+bc6n4ls6MN2i4aOVxJQYRfiffqs1G+G0qk5KbYbbD5o13PgxOzdhPlZtXXpxsPpFHMNEff8q3YYwUwK4cR0ORQdI8xoRQK27wa/p/zwyxD3LhEvvsg7DfitcH8eubupRQTfzaslKPkpyXEco7Sj1C2q8ytUO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kA4xRnR7NBwzGXNm1YyVFog11XkFrZmMKTsUsYjEXc=;
 b=J+F2IYn51TvF3VCje7ALflBpzOIVBubd/ktzr6qfXOx89Zn+zn8ElRbFoPDfdP1Y6F77DCLP14Ixl8Vnx6SZaClJSNXKieUIMjPEKK+uPIIQUkY+//zY8MmkgSY2sLKgB0HpiZ/XVa5RTHLLot9EuDN+NAfad1cB9fq9KzZkO1UMWSFnbQUaUTHaP/Co1kulXlBA9mk1v2ph56drqcUBP2IOBEqQSXLv+G5woQVBaXJOE8IUVvB1B0/zceZWzrUEXhDpiUlSktyn6r5GezovF2vcHdZ8UPcWq+/l33Hrnw1VUPcHtTUBSToE6e0IcDNiK50Jxy4u4x5zQ4kN08u9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kA4xRnR7NBwzGXNm1YyVFog11XkFrZmMKTsUsYjEXc=;
 b=mh7L703ML8IogzBWiHe/BNIbZNkOujxlwjqm54Tl1WO3ZNXN2kp2HVFtZNGD0Eg9mHHiST6u0T4ItGIuVzwPAR7TC9HSxOWkDQJFrRN9gsbn1LrfVeacgmYF3E936jO0kTOvICwFEpL3SZSkhjAFp4SOZHcZQlnUUF6q43Bso7o5qoph+QG6jxRSsOileH0CRu3yAXHcP86SjlH9HNX8ZcsSXvytjpbL6JqUW5EXuYHG2TW+Mq0uYEGcy+O8rd5CjE4HpARYBoQ9g/EFzf3xJLVoZNhX7w0rqYsCjKIibQOPzvAFELij7Aty40zL+XTerVsNjbWdRPbOdnDl2Jr7SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.13; Tue, 15 Oct
 2024 07:30:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 07:30:14 +0000
Message-ID: <d338be91-40bd-4415-8969-9e8bbb9f9d4b@siemens.com>
Date: Tue, 15 Oct 2024 09:30:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v1] support F81601 PCIe CAN bus 2 ports controllers
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
References: <20241015013627.891619-1-liuyang@sinsegye.com.cn>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241015013627.891619-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: f31ce669-c4e8-4b0b-1586-08dceceb35c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlhMWUdKTFhDVWxSdDhRS3pYT3lLamlGU1pSb0ZHZTRvd1huU095WUQ1RCtY?=
 =?utf-8?B?eloxNnFtTzVhRDdiTXhJQktsR0RZUzJLTU5hYmRHbnZrZkwxa09LY0dNVnls?=
 =?utf-8?B?Z1NCNWhXNnFXMTBOVUxNNDR3NmZuczI2OUdJNUFJUE5xNjRvUm5IcDQ0T0pq?=
 =?utf-8?B?OVdYUkJaYXNUcHVnczByTkxGNENjV1cybFV1eFRUNFBoa1ZENHQ5U2pPSlpQ?=
 =?utf-8?B?bGVicFJHVXNVcmJ6Rkt2WE1xVW9USTRSS3o4alYwczc1L29UTXFYcHA0SHZL?=
 =?utf-8?B?dU1rZFZ2VDU3OHlkVHE0c3JqdEY0ZE5WZmdUeTVsbThvQ1M1anUyWklsT04r?=
 =?utf-8?B?emFsbmljd2ZPWXZjTWlFbkUzZDM4SVVwNHZ2SUthMlJPSXlIaVhjelVjWDBl?=
 =?utf-8?B?akpQMzIwb3VJK2gzRVV3d0R0cjhhVmxuK21hN0k5MXQ3WHJHdlpJWkhnVXE2?=
 =?utf-8?B?SmJxUU1nNWhvcjNrMk5Kd2IyYUlKUUhBRU1BUkRTbjJpRXhydm1sMjJxSmdm?=
 =?utf-8?B?bHNIMVpLa2hGS29NL1hTY2RjZXVoZTN5cFVkNE5Jdms3VHI2V1BGY1dVZG5p?=
 =?utf-8?B?cnFrV2RFYTQ3a0tJUUd2Zm5xM08vanA0Q1gyWlVTbXZJem5LSjBpTUtIRTVH?=
 =?utf-8?B?ODFSOUk3Nml3YlM5bHdna1BmR0NYSjE2TUgxTCtqT2NncHUzYlM5cnl5V3cz?=
 =?utf-8?B?b0JqSEpRRkkyUXdTTHVFT3A3Y2l2VDBRdWxoS0p6MEdoTm9kKzVTWkVWVjhB?=
 =?utf-8?B?Y0tvZ2xQNXArUlVNekZNamI5TkxsaDc2MnV1RG9xZkV3VENXQlkzNUtVTHBY?=
 =?utf-8?B?OUpqcHNvYTRGVng1QVZzcGZXZWRNMTdJZ01NOTFGQTlhdjdQNVNLN2hpWDhu?=
 =?utf-8?B?NFFZeWkwT2VKZ0NzNDZyOXp4VzR5VGtkME0wSlhpeHRGcDlvL05OSVFEbEdU?=
 =?utf-8?B?SHhEU0RRQzUzNW5yRGRWM2pUdmdQays3TE4rQkVxMUNsR2xlbHc0QWt0ODQ4?=
 =?utf-8?B?NVpQb0xqWVRxY0krbXh5bmxnZjF3R3Jrd0hEaXFHK3lXRnltOEg2ZUdlbHBU?=
 =?utf-8?B?dlRMakJnK2ZzMFl4aURzM2plSElmOSthd1RiQmxCTi9UYjJrSnRBYjJpRUlF?=
 =?utf-8?B?c0tmek4vWFk4V290QTNBWW94aURtc0ZDeGx5U1doaGNDZmJVTnRXNzFTMXR3?=
 =?utf-8?B?Y3JObnJrUXNqUDBEdnhFM0JXMU9VR2tyUWFhQ2JXRThKR2ZYeDdZSG01dnBl?=
 =?utf-8?B?UEZBcW9vblUxT0VweHo2ZnBnTStKcWcrUTdTZVhCbjFOQ29iR0FibUYwQkNs?=
 =?utf-8?B?NTZvY0JPUXlyanBnMEdoSFlUcldnQTdMSERKei9MU1hkbVJtSEwzVVNSTXcr?=
 =?utf-8?B?MXk2OVJDa3E2NnVhZTlkSEZPZTVZd1lIbTlrLzM3UUZRaThuV0tmZzRlRXps?=
 =?utf-8?B?WjRpcnBHRDVOdUo0aHRoQkp2Y2h3SnlNMU1rNml6YWZwOE5HRTlOMFFYUWZY?=
 =?utf-8?B?WGJMRWpPbWlvaEw4THhWTEFuY2tVNXp0RGFiaHhzd2J1OXpEd2V2SWNhMUhT?=
 =?utf-8?B?TjdYY1dGVFIvS055MWlpVXZ1VUV6UnNoNGV6TVhPdXp0cnlic25MUXAyR3dX?=
 =?utf-8?B?Y1l0N1FGbUxwc2txWFNIVmw1eG5ZWFF4eG51ZEp0TGt3Vi9FR0NzaExzSkhk?=
 =?utf-8?B?NjZUb2F6OGV0QW9BVis5RmFFSGo1M3BaVmMvVXhTQiszMzRWSGxlbDhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBpOEdoNDVoZGNhbHBCWU5EQkZBZ1YrQkFxTWFMS3V0d2trTmFRYjNTMnQ0?=
 =?utf-8?B?aFVyTGt2dkU3VE5GY1YvRi8zbWxMdW9WY2FGRHBUK0h6ZkJkVkJmeXFrWUNO?=
 =?utf-8?B?OXFGS0R0RDArOHVwMXRLUjlBR0FvWVo1eE5MZS9oWlV6eVpNS2lveHhlOWpt?=
 =?utf-8?B?Rk5tR285ZlpnbmtVaStKRW5qSlZqbC9WS1JFUWlpVStiN3p5cGJtV1RTa3dm?=
 =?utf-8?B?bC9Ba2dOYTArRWl6N1lFcmZ6b2NCV0VrN2JETDVCYWt1aVlWbGl3Z1lmVVVO?=
 =?utf-8?B?U01SMm5mbk1uVWVEZVNOTm92M1F4RW85RENhM3Fzc2NWUWoxbFhTSjA0dDMw?=
 =?utf-8?B?WEhQN1VJU0FaNTZzUlp5aFFCc25zTTl2dDlXVHBEektTdVFHK0g2TTdIeGVa?=
 =?utf-8?B?TlFWVEFNandKRmVURzlLWkNzUVVqaXNKWkU3dnRvdTRHdU9zMUFLa1JSa3Uy?=
 =?utf-8?B?Z0JpclhaQlpTaDk4QmhyMDJPZWV6RWtJRnZ6N2JXZHM5VkNTQkNvd01xekRo?=
 =?utf-8?B?WGFJbFZXcVhZTENubnZoQ05Peit6WGtOY3k2WXdZZks3S0lNNnFzNks3N0g2?=
 =?utf-8?B?MmUvSk5SdGFCcytBbTEwaGJ0QzFzdFJXOS9sOW1QN0pZeWFQN01Rbm41Znpp?=
 =?utf-8?B?bmFaWkhMempIYVgxMEZrT3ZMcmxQSTdkTmdiQk10d2UwYnVTRHc0SEpmK2lO?=
 =?utf-8?B?eUhkbkp0emw2bVZ3dlZJR1daaVhOaGFLTDJRUmNnWitEbzVKSVJSU3JxT3pJ?=
 =?utf-8?B?b3NMYVZlRkFTdnZpUXhoYzh4c0pKclU1SFR5cERJZEZKcUEwR20waGhGdEVP?=
 =?utf-8?B?SzVISVY3c0pGcWJ3VXlGTGRxMzBMOUp3bmZrbzhnZ3N0Y1llS0RFbnp5Wkhs?=
 =?utf-8?B?WU9JdkZLRXNONEY1aDZOZ3NaT0xCbmtDek5qMjFiaUJMR0VJUzF6clliclN4?=
 =?utf-8?B?Ym52Y2tnUGxKVHcrN2RaUFZQcVBsVGJxL2pZTVo0QzBRa0pTa0kydVBQeEVp?=
 =?utf-8?B?Ujl5cDNJS2Z3elk2anA5dkNzMXdURTZRNTlTWkNjOEMyaDBkb0ZxazJwOEEr?=
 =?utf-8?B?a1k3bjUvUVNnM21sV2hGRnp4RUJ0WERHK1ZzenlIYVZoTUpKREYvMXVwZDZD?=
 =?utf-8?B?d0JnMDVTNTZCZ1ltSDJQMmRxVjJMQ0sweWxvMkpxSEs4bFpQc1B6ZnRMYnhC?=
 =?utf-8?B?amNOS3V1RklZYW1ZT2diNXl0by9UMEcwWXBKdjNQVUhhTHZoL2ZPMjZRRkh2?=
 =?utf-8?B?ZnBLRzdwaFJqRkFCcnRoKzZzZkJ4UllLaGRjaEJ1ZTRHOVE5M3JESkdoM1hT?=
 =?utf-8?B?SmlHK3NJNGN2TTRKaWIvZFZmUndndCt6SG5lRDUyMmhvT2F1L2Nxbis4Mmk2?=
 =?utf-8?B?NEgzN0JRYnBkNTVleDVtOEZxcEdMQndQWm5vYi9kb0xxUGpnS3hjb1FOaHpw?=
 =?utf-8?B?aU1TVW9ocXZ1dmMxamEyNzkwdEVjV2crdmFReWxuNE5EazBCQmtrU1pHTk4x?=
 =?utf-8?B?OW9aYnFYUEVEYVp0QmpMQWFjSmtPMzdpRUFmR21uc2RsS2laOGNJcVIvenJL?=
 =?utf-8?B?LzUrRzJaTUtyNVJjSzNZTzNiQlRQSUZTVUxTRkJEUnE3UlN6Yyt3aFdwdWps?=
 =?utf-8?B?bFlSR2wvQlhyZTNiZi9IdXVGcy9HcmM3UTczSDhCbmhJVUFPaTJreXcraTFm?=
 =?utf-8?B?SW52OFg3U3dscmcxa21rWEtDaEY0RjdJNGU1ZTZla01aZVp3MmtJSDcrYmhF?=
 =?utf-8?B?bXN4NjE2ZWlMRU41MXNoTGQ1aWwreXdHeTZQZ1Y0eXVGdEF1MXBYZ0VmV3Zu?=
 =?utf-8?B?UjdaUjk3MnFIbWlRekIwekFZNUVXa1JNcjN6c0V6dUVqUFNSSGQ0eHg1MnB4?=
 =?utf-8?B?RDZMeHhwaUFrSkM3QmpiOURGWHRZS0FWRmxLTDVWUVZ4Q0MxSGZFVHdiaFNS?=
 =?utf-8?B?cjNDUERZZ29TTm55MFVvUlVGOHplempYeTBXdWdsWlVlY29kQU1OdTd3Sjk1?=
 =?utf-8?B?WUUvUHlJMG9EMlZzektkR2tCcExFUXA4R0JYOGZVK0V3KzRvak5PTmNaRlV0?=
 =?utf-8?B?QmRXb0t4R0NaTEdWakpTWG54emJGMDZFUExZOGpMUDJzcjdiOEwvekQxS0ZH?=
 =?utf-8?Q?c4ZG2+goG4S8nDfhx3afOTO+S?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31ce669-c4e8-4b0b-1586-08dceceb35c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:30:14.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU2e1hFrPT2gRirlnciUqaL027Q8F+2HINtwJVr6z0reCPOElKkCNhidLIP7tZQnO6XWv/y3PF18p6FaEJJmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7503

On 15.10.24 03:36, liuyang wrote:
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  .gitlab-ci.yml                                |   1 +
>  kernel/drivers/can/sja1000/Kconfig            |  11 +
>  kernel/drivers/can/sja1000/Makefile           |   2 +
>  kernel/drivers/can/sja1000/rtcan_f81601_pci.c | 226 ++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> 

Looks like you accidentally resent an older version of the patch - my
review comments are not addressed in this one.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
