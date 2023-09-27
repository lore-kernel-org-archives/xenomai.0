Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F811CBC
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 05:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUjWz03NP8roxneNX/Ek6niKWZw4g4bc1bFGT99r6G5qI/3wDDv+EUC4PE/iPyPC+TS7JJE+SeAaHkb/uvc6KcmhyWaB1sSjK5RU6WDO09WGBZeh0g8BVqXPk7RO7oPVW/muH80yA7rcaG0OYsPDm0SMiXz+f+kpauuBsumXI0lgtEUKOJv/wYK4SCCKzLkt4b9+PV1BRRLAOePTQ4+f9uz0Eyc830B41DcS7nmDndxcvvsLmikZVG1HXkyFvbXhKM51kSPD/wWawopD9s1EtwaT/kVAwG/S+PASXi14jKGXXctClbLFN2exxdp8O2EekGDj29rgW5Sjcaus4mV/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPC7t4lUHHJmcCtbZjOgJaB5whbe5h1oAjIqMXFObWk=;
 b=NAtmptoMsl6MmNE7nTT6oyxMCKpzh0bxEDi+2jNjQ9m0gWN1veRTJfKnY+iIq3xKscw23sLzWDAP2IwzBDxveUE4DYzXKFgqEV8pPXQB1mKfkSPZb6T9HYs+oa7lhEiqUs6FIsHLIIdEfE957Uvzs7F/lLED657oSOt1i2h1NYTtFnVoLezNzS9dAvyRn4cNMjgJhm6JZKRVyIdvkI3PXsiNKyWoTTECjPhDUWGuKd5ujC5NfoyyeToCAaIxnCWpTt8As2BeBUW3G9gYsXZndbS2Zn9vtHlNoyOg9Sa/Z+3Xe8IhCpGuqhsANDe6b/sjRfaTjRz/Khpe1rdqsRxquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPC7t4lUHHJmcCtbZjOgJaB5whbe5h1oAjIqMXFObWk=;
 b=FdZpsNO60Bzy8q5ltPi+rfOxPYIp0HMp60Zz3CJkaSLXO809vyt7yukIKGbaUZK3SXDRo/cxJ0MeCQXeMnaFnBl/t03ypZQguhTl4Nqp2bI7Z9pVwXciMtiG1tcb+66tXawKTwLhJRwKr4o/3TL7cSaS7/Yf9taxtHv4qDuD326qwkXUMRTTu3iuIDcVJsskq4+bOR2QPzae6OkW0tqyThQZQdKIQf6ri9nR2toe3nTuAlRHUQlXNmSaV6GRAgI4Od9NJPg3rZGAB+i0CIMDHiG6EWQEklC38KJLapYA1mRx1Cq+sczUioiLOww9EZnp3j7pelJ8lTxCxH8T7fOAJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 05:51:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 05:51:19 +0000
Message-ID: <ac826518-40a9-4620-89bb-f14f2d35cbf2@siemens.com>
Date: Wed, 27 Sep 2023 07:51:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB13309086E38D6FFB0E59C2A2D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <41ce2ea0-5e13-4c4d-ada9-9c9f5c296e0a@siemens.com>
 <PS2P216MB13302E4AB022FA29FAC6E510D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <391a0665-1236-4ace-88bb-33e206ed4b18@siemens.com>
 <PS2P216MB13302C5C07803246F00BC220D1C2A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB13302C5C07803246F00BC220D1C2A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 950d7809-5f39-447e-0e34-08dbbf1dc541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jzu3AP/xIxMZD39InfhjTZibhwBECLw8QOTguCdPwYELNzbSk6WuFWqvStDBfWjPG3BEWgW4+n1jjfBLjEQzmDSWXVKMcGsiCU7UQCo93i0qG6Nw2+5pAVYSMgtLzQ/fXaW2VOVow+YTQqWtlsLn2R1081OiVYdS2KyqHIXZjQAX1mpF1Ib7d6r7syWfY2LjZ1pzmADvriHEhxI1VzX/VCE+rHT4H/dqNuJ+qgzBpLpNDvQKIXNCyY7tV7b1mb0sdJxI0fk+DcMLpMvcOpajizQQq73+WoCln3NPQ2Fg4Uy4BT49bl82HU/iE5FHcKTnLevHRU0xk55O53rmezovBGge4gkzXMga5C5yqURuhhed9OffxOzx5HhMHDNrl425MWyULnoSXQLp4Dc3T7OYRFaetuz96X7YQkqYAK2rP6fayvxeH1HTdMKWr2UIYl0/5NQi9Z+LKYedI9qRipIZiVc5BNtJeOOp2Rlm+ps/+0612Lq7t9ypZx05SD4qZCCVi+4CL/Jigd5XNTRcgW8RnULhtDra75Fjjd6uQq1WaDDlQArdifGMv80UQjVkifzacod4TnBwIJGINpKWz2fvHSl4DBFb05eaaGlx7j28lkRswFMF4LWwWu379WNYQ2/FrphKVdv8hwXxbDMJX3TVeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(2616005)(26005)(6486002)(6506007)(53546011)(6512007)(36756003)(38100700002)(82960400001)(31696002)(86362001)(558084003)(316002)(6916009)(66476007)(41300700001)(66556008)(66946007)(8676002)(4326008)(8936002)(44832011)(5660300002)(2906002)(31686004)(6666004)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmZHemVBb05iWUdrUmM1b0t3LzgzemZRdFZNYmNVVHBGMWxrRm94ZG9XQnla?=
 =?utf-8?B?OFFoUDJkSUVuK0JYMUlYdFJsd1JZejRPenVRMjQ0UzBPMWloVGZtVWRxU2pt?=
 =?utf-8?B?VThOVUdXRVI2T3Rpd1c2NGZpQ3hBYXQ2WHlIOE9SVzJ3V0dEWlVVYUpqZ25k?=
 =?utf-8?B?VHdwbTlVMktacTRhaXh1endCNlpreTY3eVZwL05KK1ZzMEVNMmo1ZHk4NExQ?=
 =?utf-8?B?TUtwYUJPTFJMVmROdWhXZkQ4QlhNMGJjQm8zbXgwMlVrM0g4STgrVU5odVh0?=
 =?utf-8?B?ZDRkRFJGSkdtcUREdE52OEdDenZqNlF3TFprTXlZdGlkYnI4K0RBUEZobkhX?=
 =?utf-8?B?MURkLzNEbzFhRk9sL3F4VExCYVZvK3dUS1NmK293ZkJWc0tUZjhqZ1FVV05R?=
 =?utf-8?B?SnYwVnFOZERUVEthUW5OVC9TQXQxSmhpUGRpcFJoQ2RpYXZMbUF6dEdqaUYz?=
 =?utf-8?B?TTR4TkViSUJOcnFOWVN4d04wcXljdHpRVFp2UG4rWXpTUlpMS0YzVElLV1lV?=
 =?utf-8?B?b1RDcHlCbm9qRWROU09QRlNDa0lRWUNtemhPNEJ0Z0NPZEVnSUtKRFBXNjZ1?=
 =?utf-8?B?ZkxMMmFlMThKTno3dGtOMnMrdnNEWXBXSGpXbEcyKzdJd2hQYnh5MS82b0hH?=
 =?utf-8?B?OHFTOXVVeGZldFdNY0pVVHI5dksvY1N3alBhbDNuTVNFd1lkREtTRE5lM2VI?=
 =?utf-8?B?eTJwdy95QjdTQW82WUFCaG9JUkhaaGthSzZ2cENQOWE3NHMzcFNaVnEwandE?=
 =?utf-8?B?MXVyNzZ1Q2trVUVmRUtNaUV1bitLTDdyZVFteUFYWlVubDl5WW4zbmRaRWJa?=
 =?utf-8?B?K0FPeW5ZczlPYlh0ajh5RmpFcDExN0NXRi9HWjAwZGV5TFI3ekNtaVZxbDVa?=
 =?utf-8?B?QzRudnVaVWVjZ0JENU82eHE4ZVRscTBBVm5qdjd0KzVDMEgyOVZualYxbjg5?=
 =?utf-8?B?OEQvUkV2d091c3F3ZW4xNEVBeHFOQURzR25WWkRBY1dZSGJVTGsrSEhqci9w?=
 =?utf-8?B?WXF4ZWFlOFJNb3p2b1hvSkVSY3VNK2NjN1h1MmcyNTB4Q2kyT3RsY1BVR2pw?=
 =?utf-8?B?NERxNU5BZHhsMHFBZWJpWmNlY3FvK0c1VWhkRFdnTUJFNGdUUVNEUXh4dW03?=
 =?utf-8?B?azdOMXUzVFloWkV3elRZMFI3QWZodDNwNURUSFVtN042RUtyZFBHS2JxTTc0?=
 =?utf-8?B?Vjc0M2w1YUV6eEZrRkVuVTBjSGlIVk02MmxDVUk1ZG92ZmZNTERhejYwbUhl?=
 =?utf-8?B?VDQ4OHJJMFR3S0JvTW5pbVJ5SWdsUzZtSHRzWDJ4RXJUaDdvYzNZNEw1aVVu?=
 =?utf-8?B?K3JJNmJ5UmQxQlhQUTFEU1JMMEhWSzJLWTloWHV6VkFFOVd4czVNalNpYnRr?=
 =?utf-8?B?NGdGUkpVQUFsL1V3UEEyNGxCNnpQOXFxUm54THptUVAyVlcyd1ZYNllraUs4?=
 =?utf-8?B?R1RVSFJQdno5VWlMenR2UjUxcWdLQ1pjWXZ2Y3V4d1JsM3FsRUVIMWtBSzl6?=
 =?utf-8?B?bTd6MFFpNDA1U0dMV0MwQ2xEc01BLzErZmUxbUNTcWNHM0VNTEoyakFvUy9w?=
 =?utf-8?B?eEtuS3UxT1h3UEh6T3AzVmVzanVTbjhYZGgwOSs4L2FhYVdrdy91Rk5tMkVI?=
 =?utf-8?B?elVEMi9JV3pFMjFPeGE3MHdEU2pZTEZPdkE0V2FSVFB4bHJTNk9LZEZtbXph?=
 =?utf-8?B?Sk92QmxjanM0TkxUQnpvT3BpeEpRVExqUG5nVEVSVFNuTUt2SE16U2gwejBE?=
 =?utf-8?B?NWJPQnB2dWdnR2FScStWTWRRWG84akF2by9jWXpZRnZZYjJvSGxWTkFScTJr?=
 =?utf-8?B?OXVya0VCcWpOWElleUt0Y3h3RmViWmpFU053SWdOT2k4V3BSZVREY0FsNm4z?=
 =?utf-8?B?b2szaDFuMnhFSWNrSWpUT1VIcjAwanhVaTN0Y1BaRU8rck9LSjAzNTcvaVNV?=
 =?utf-8?B?K1dzQnNXeXFuTXczQU5nWlZsRlU4Q21HYnZmRm11OG5DYkFQQ1E1bUxrR1Bs?=
 =?utf-8?B?eDdyUUZCbytkOElVUVBia0hWL3FkeUg4dnpyckpuZ0k0OVlxYS9VbHB5WnZE?=
 =?utf-8?B?NVMzWHBoWWF0c3JlcDJYSjBDYmltM1htMVYxajZiRGlEMDhPRnZ6Y2NYMmQv?=
 =?utf-8?B?NFB3cm5IdzE5RmsvZ0JuNjZQSWpqcXVGQWJqNVpIU2NpK2t1OVBRank4OHZB?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950d7809-5f39-447e-0e34-08dbbf1dc541
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:51:18.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joEsWlBi9OFKV8qDbnWKYYUW+xrvEII1wGjuBmEA+GE21sr7TQ1fSRa6ZsgXdJBjXH+VwjTr6tGGMGTdr6v5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5995

On 27.09.23 02:00, 박경훈(Kyunghoon Park) 수석 두산로보틱스 wrote:
> Thank you, but there is no detailed manual
> It's so different from before that it's confusing
> 

https://v3.xenomai.org/installation/

Happy to take suggestions how to improve it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

