Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C02FA25
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 16:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPSEclnUw31vXxDFWNOvV307WAtOqsWDmGPkxHB1EuHabBTQWbVkE7lqtI7XFgEUU6+2sNDbI/5e1nTeHVsmR6xL/OSA+piwK0hEfngeJumsuLaDmUw6zkYnrIyfHLWuQlOMQjYwnQ+jDLJY20O1cccmD38VtIhwOd5nw6bjD46VyvLOqVhQvqrM+s2IhaEKdYlPLakQQJWlHRBeWiRO2zkpdmyTg4vrIma93aw2G9VX5dVdchUrjK7tyrjyB4MCeDlTFBHlmGEE5WTYWFA3As9kzrCgoa5+gM+V5h/apzi7Jp4pr8RPJcBYQAnOHqji2aEwyD0+2IZNntHePujUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmqvegaztUrBRH8bu65/UpC5q0brBA5y57P0Jlww5ts=;
 b=n8GjD4ktDeg9KQ1Q0mAX6Tcb3DYG5cEDbAzcLX7Ut7h6nyUQ+XnA7Sk0G+w3p6bfr2nVDFZIDCB9NIlVyHOwmN2dSg7EUxpmmKPl70uEJ11bgmK9/RLvSDLcQUQKY2v1huWsX9zB5u1R3nUEijIqB21mSfeDevilXS1wnqSWDnJsPBBx30BbfG/1BnAnIBxZmbRAyrEGpj2j0jJe7DevD+MfSz4N4pyxDHujPiQNdpJH7rqy47A/0JuQbay1w/uT2eWtAzrlqvJSQIhLcp0MysYWqmDC9uiDFN9mMt0DtMt58bu9iwaD7XBQubPmKnQBdMYyNPQ9UFlW9EjgMa/aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmqvegaztUrBRH8bu65/UpC5q0brBA5y57P0Jlww5ts=;
 b=wsLH7Rowq+azj4ykMh4qX8CIp/JS6hU1o4ZvNpBfSzOGtt15EcgzYHR776SrFlH8YB0ftFDkXsHO6dSg5Zvr5LMqaM4AeolcwuAcjUkmgsEf0W7gfy7fep6paOdU5KsH6/Xf8lZD+yDmE6RCVAGAiLFTSoIReMJtf4F4ExNN14j010vxD5cgKQ9z++GyQaJIEKhpuK+tWqk6SFBOT8c59/du9TGnbRHUsF8w71ui/1KSPSViJMSdHIkw1UlG+Gc+v9PiqEXualZxZRdceemsp3Yg65hk82/woh5xEzs5IH2EOXRx1dbAZkE3w380/lSvH6AZnaGUYe3XKr4MhdE4eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 16:47:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 16:47:18 +0000
Message-ID: <c6dcd8aa-f50e-633b-8b6d-7755cce2b98a@siemens.com>
Date: Thu, 20 Jul 2023 18:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct sched_param_ex
 to time64_t
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa19306-57de-4424-4c85-08db8940fb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CFRAMsedtJ/Y1WsGfnKavPSdt/rr5t4zLL7rZGE+AsJykBn6X6Atf4iN2asfBjQTAXU0xBJ/b0VzkST0RfqBNGcc2AibfAUK/H8OAJFiLd//G/kEq7+dM5dfjZFNDYfk98g3/TrL9rg2/qfRWQItgPT6sZOZfcidd04u/QPl37IIjXFxPcFh7BOW2Jp/pbvll/9WCIK5N1U15TBSRqACSYwPgfWyltNi1vg9jSUnQqeU8lEJYANHQFk3rgEB6neCVUd7/mLJAxpYAaDWRG+VserhYn+7IbV2ZOlraAud9KA57HyG8V3kWsYTr0RlNSoQvpPlMEKFWs5iV2TdzAPxFZ/eeBWdkIVGEGXbrYmZAFuJQYFU8o0xnYvqQv3OFh5OrzJc1RFY3VB7SNb4Q6y0f8I4covoiw4zm+09KSs9zr/qltuMx8wk/bANNtlbzqPbHf4QfUHrXsZhj0rs+ag29MYrN8YxRmzG/fxwyBGO83W/GrOT/ADFI5SXRbzPROic07bCvdKStrulCNbqehOqmZAa10xolgrjkWuvYmAxKHTh+74KMgFAQhTu9qZtrYmMv8FD6a2iOSBBIyx22jdfUEkxqSar7YdZweGzTBp17pXs3PHW4l5N4FL82wwMacNklB1QPHBJg5e2qxIvJuymUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(86362001)(478600001)(186003)(38100700002)(41300700001)(26005)(31696002)(31686004)(8676002)(53546011)(8936002)(316002)(2906002)(66556008)(6512007)(44832011)(66946007)(66476007)(6486002)(6506007)(82960400001)(2616005)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXNoc3VhTFRYNW42dlk3ZUo0MDV3TkJvc2o1ZEZlNDAwVk9NK2lERXJLSE42?=
 =?utf-8?B?M2JvdDUrODlnQVZtYXpCb0U2T3JXak12N0t3eWU5ak1BeHpiZVI4Z3haOWRG?=
 =?utf-8?B?dEtQblNkKzZweEdFaUJEWGJIbDVwMWhoSVZHcWF0WWtDWlY2TFU4NC84aDEx?=
 =?utf-8?B?T1ZsbVcwMDRmdnE1L0p6ZktMSjg4TUsyV1VSUmlSQTg1QS9idk9RUEdBOUkw?=
 =?utf-8?B?TTFhUUJ0QTVPUDdRNGk3MmV0N24zTzFqeVcrNndzcjdFQnVaQURXaGVTSlli?=
 =?utf-8?B?K3VnYTJ3enJjNzgxMEd1dHNJSFRockRlZUx4Tnd2d3N1ZFBqM2Y3V3psRnM1?=
 =?utf-8?B?RXZsZ1IyT1JCUVU3dzhvMExkTXVCakVJYnZoQlRBcUVsck5jMzdEckY0b25h?=
 =?utf-8?B?aGdxWE1XZFowNzdPRzY4b1ZOQ04renBKSE9TRTE0Q25Jc0pYdXZ2ZXc3UHhs?=
 =?utf-8?B?LzJkOXE2djdDOXVNQy9GVTVBUlhvQklsTituYVp6M3dzd1RXbXlvWWRLR1lV?=
 =?utf-8?B?SlA0dmdBZHBkVk5OZG8yazlnZ0VDNWdMcnd2YUIweUZMK3V0bzlsL2ErVm05?=
 =?utf-8?B?UzMrZDRpN2lkTFB4MS94ZG55R0NBVzllT2JCNHB4Sm9nWHBZQ1BhUjE2dk1i?=
 =?utf-8?B?VmpDM2hNdGtVQXZGQXAybXZQMGQ1cEJmaDc0R05zazJiYmpsVXFSd0Z0R1d0?=
 =?utf-8?B?QTZ3Q1F4ZWR2OXE2dGxnNVpRTTFsTEpwWGhDU05wQ0xRWmRJRmZCaGh4dmZN?=
 =?utf-8?B?R2p0M1JxWVdEUE5HUVVjMDhnRFNCRXVyQ3FPZUZ0ZkZ3d3lqaWVwcm41QnFN?=
 =?utf-8?B?WEVCbHhkdHlBL1pSc3NEWUtMbmxFanE1QUpCczdQNGZMR1BNWGF5NnBuMEw2?=
 =?utf-8?B?OTJPNEhRVlRhNWpZWjM3VDNMSFV6alF2UHJhblpDeFZNNWwydFF5MTN1dmlM?=
 =?utf-8?B?SDFGZmE4QTVpQm5YSkg5Sis2cHUrVmUrK1N3ZnhRa3dPdElJeUljTHNRV2Fx?=
 =?utf-8?B?eUtaYm03Y0NiK2FjQXo1Y1B3SE1qTGJuYzRlTi9JUTBpSyt0dDdrSEZpVmtU?=
 =?utf-8?B?MDdBUWxOWHhXY2t2QVByaWZyYmtHUytiTjhuNkFscTNnR1EzM0pZb2hMY3J0?=
 =?utf-8?B?bEpoTTB1cytaWldQblB2WVRLSTR6TkRUNWdORVhZb3VRc0RUNVdDNWg1cmlV?=
 =?utf-8?B?RkdKZXZ6VHp2Ky9GQnRaODkwL1E5Y1I4QkNEWFF5OFVsenAwdWkzc3V1U1Za?=
 =?utf-8?B?aE9vK0dOVnRoc2pWWXcyektWOXh3alVpNGs2VFUyRmxocEdRSWxsMmNxZk5v?=
 =?utf-8?B?bmxsb1RqVUE1amFnSTRqYzF3UXJTcGtvM0pMOGZtMitacE9YY0YxcVFSK3F3?=
 =?utf-8?B?Q3RLSk5JRDA3cjh1TFFwaHZlQ0hid2RlU0VSS2Y2UEwyUWVUTXAvTGRkcG55?=
 =?utf-8?B?M1FZOWhiUHpDaGwwcmpJUVhBdEU0bWZZaXlTSDNkVHpoc1NEdERTVUxzOGFD?=
 =?utf-8?B?WEFTdjRwQjluNEt5MS84QWQ2RXI0RkVqVFd4dmxOblFWeHpUZUpNc3pXclhP?=
 =?utf-8?B?VEswdDlMdVVWRXVZNmJ1djd4Z1V2T0I1eFlTZkpkdlE2SmMwQnRqS3N5T1Ew?=
 =?utf-8?B?MjUrMjJtZmpUMTJSTVQrN0lhZXl2TDhoUTZLU201RHBBaU9COHdXMkJ1YjJl?=
 =?utf-8?B?aWVJVnM5eEVDMGJROFZkVFdZbnh3T1BnYy80OGFJMitaYmt1a3JyemVFWS94?=
 =?utf-8?B?SnB6bFRGdVhrdWgwVDZpTEJ5YUVFQTFGd1U5R0ZzaERkaE9ma1k0YWRGNWRx?=
 =?utf-8?B?YVcySkorZ1pKUm12VE0rMkxXMlM4WDNjdlZlU0t1RDZQNG5QUm5YZVhXWWE3?=
 =?utf-8?B?aG5JYXRFVHZ6Qm1jMmRkL3JGUkN5aklhT0UzcURma3JRU05VVFhub2Z2ZXRn?=
 =?utf-8?B?NzFMa3FmOXpCZUVKOVJCdjk2ankxWXIxYmJzZ21PelBWNnpQK1pQNFBEd2o5?=
 =?utf-8?B?NWE5aWtkTVhGSERYWG5WaFA0UFI0Qys5bnIzazJGR2gyR0VQaFAwdnU4eDNz?=
 =?utf-8?B?K3ZjdWl1N0Niamc1QlgrR3RLWCt2emV6VzRWOSt6eENEQUVvc0dBWVVTK2Jv?=
 =?utf-8?B?WU1jQmE4dXJiKy81RWsvMkhacEJnbVBhbmVoZExUUWtQK0VONVQ1S3pJbk9u?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa19306-57de-4424-4c85-08db8940fb29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:47:18.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsTlK0+9U24XR8JH5dtMQ6iw1xV8HXPF3+Zd1XABKrFGSe0UODG/BTHe7zsGI0GcCnqwi+O9ef7+6G1L23tD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7153

On 17.07.23 11:10, Florian Bezdeka wrote:
> Instead of implementing time64_t based cobalt services for the
> following services we simply break the ABI and make it time64_t aware.
> 
> Affected cobalt services:
>   - cobalt_thread_create
>   - cobalt_thread_setschedparam_ex
>   - cobalt_thread_getschedparam_ex
>   - cobalt_sched_setconfig_np
>   - cobalt_sched_getconfig_np
>   - cobalt_sched_setscheduler_ex
>   - cobalt_sched_getscheduler_ex
> 
> XENOMAI_ABI_REV is incremented on all supported plattforms to express
> the ABI breakage.
> 
> The memory alignment of some data structures is changed by adding
> some anonymous paddings. This allows us to remove some compat specific
> services afterwards. The memory layout is identical on all platforms
> now.

While the cleanups are enormous, I think we need to make sure that we
are not causing subtle issues to applications.

I first thought we are only breaking the ABI for internal communication
kernel<->libcobalt. But some structs you touch here are used by
applications as well, aren't they? And then we are now exposing 64-bit
time types to them. Will they be fine with that? Recompilation is
needed, that is clear, but will applications not supporting 64-bit time
types yet nevertheless be able to use the 64-bit extended structures
without major code changes?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

