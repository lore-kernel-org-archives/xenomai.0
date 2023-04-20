Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD85688
	for <xenomai@lists.linux.dev>; Thu, 20 Apr 2023 13:08:30 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 810071BF208
	for <xenomai@lists.linux.dev>; Thu, 20 Apr 2023 13:08:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 41140D8108C
	for <xenomai@xenomai.org>; Thu, 20 Apr 2023 13:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NufTTu91WQjDHL4O/InS7C1ddb81OLKkSCTL5CqyxisiGXSjNfklEdO08VAbEad8AD273HK7QrpE4MRqcYwFlx8oN7zufZXy2iLWEQVsnfAAQmoKLsAZeN1/OJ2FkYEXK3BO/0O07hksawTyiPY3u0rpPGYF1MYgH86xARj3ovFdzMSM6M/w3mpOR0/KknmdibTWjVHPHJaGad3InJ8wpCBaGzN9RKxJjMGeIZ6OlG775YTrc8IZLqYPMq1Vqj6o0QEAYpFp0fI8ddFaY1OliHpXnW7Venobjmy7TnXsa0uwvwpcIhHqynEJ8LvyL6SaElhqPFbS77gzTT0ZqMhh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0LIqUBJUtxPZdyiFG3NjBrSZCxfGTWQsBRxIk4EgcM=;
 b=TAYpTxgOkBChFPa9OuTawUcwxCgB7wvO8hQ5GYseiV1Aa2aEgWbuCtu0gYfNnajP70OIP3t4F/D6FjeJOr6JwTHf7nJsJtGBPqIrEsbr9JRKxlGzyaeuZK4GtMwE2ublMFQK/jzDQySJ3TFQniSyrSxtDsQWk09aL8dgDvIVcuo7MRh8n8AUgvhlJLIUZmhgnnUaHXI5ej4C4wosuX1y5lMISWH0Kj8f3PDN64fSU8qfbvqTXg8p17Xhvgklhs7Bs2rgXL8qkVPA/PRvRyG15zdwlz31eKAr4Tet7CRsFyKJJMJr4xTuLOEa3AChAZy57ambBucC8SbO6MgkOX9Fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0LIqUBJUtxPZdyiFG3NjBrSZCxfGTWQsBRxIk4EgcM=;
 b=DC1CduspPt547AyG7rm9m4z4A12RgJctdQnepZwtgDWRrTiVbc4tc+by5B7KNHN32XgVixiiyy6lY4qKLnFQ4f5MVZf90oEoJe5JAJqZ0cVQ7YGkaVQWunZUSb+7JRQm7dlM84cU0P7clmXEEQqQ3MVCsCeTab4fcOnLLVBmRm7rSH9fpRoq+5LWvO+ZnffGjlfiSZF/gaEBILiDSmWPI70jH5F+P9zt3yHoX6xag+beuhlH0A/nxH3fl76Rydkf6zmxw0dwoSoR4b/UPkcfx9Y0Xr+N+K7zGcY3dQIuzG0vckzaJdjImCs1G65TJrPM3dxFExRdoZNG/sjge1Q5/g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 13:08:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 13:08:21 +0000
Message-ID: <e9b00663-5b54-6bdc-448b-c760762a2904@siemens.com>
Date: Thu, 20 Apr 2023 15:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] alchemy: Correctly translate return value from
 pthread_mutex_init
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
References: <20230416193053.22092-1-richard@nod.at>
 <51bbd78e-47d3-52ff-808c-d0212b84bac7@siemens.com>
 <9e17fba5-a2f3-95ef-2f8a-2dcc64116b4e@siemens.com>
 <8fd09c15-368d-e2c0-a6be-48c07d1ef7ce@siemens.com>
 <20230420085138.c62pgvmn66qu6a5h@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230420085138.c62pgvmn66qu6a5h@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: c3deae37-c96d-4e6d-d45c-08db41a050ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hX4KtM9HMlqHLbmJx4lXzxo9i0iNyJzt8MUJSkXjV8y4Yb5Kla5gUBlzJXIXUgeP3wijyIraJtQbahmyDqP5NEx6QfAHKF4Jek+PktahonACVoXsKs1fct/6EruTiEsfRqmus95KkdDsNqk4Zx07qVjMLoFbfUnUvnYuARyQCb3ng8Tniwwpz4IB51GGK0FvfEC7TYtddoUO7Sil46m71LskjLJKE6F7tWdELbf5kLCOLyuV5w1QW2ORmd0nwgEonUnDKcqgne0Ecji4hnpwJfBYMwwRIwcYQdUmxOjD1AD/We6cYri3wNRyfe52gmwaxfKw9c3StNt3YwWEeiZ0OwxKzLwFqo8WCIh3xx46HeFbHkZcB3OaYmcY/aIYEVknMbsDRzeZ9kIWqz7Q84J47QKtH3DXxRzqsyAR1Zyy0o3NunfxDtzny4vKISgjkLTY7ALzcylZxIhxn+MPnkbQfxmTwNyZUkv10gDiYdGNLbipJhRYOeEocB86HB8KYtr1vhb1GhLqudb7aoUJAxKzlKr90RdFT0+w9a9D5rZK4GYcJ53TP1FXbh/TxEyAcCYcLYOrWyKHc5vCcniNiV2UpXDk7uuctFCSJ3BHog+T5JUCYmJXkbaGsYjyAqynHg+beGMJ4evL6w6044YHpSHEzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(6666004)(478600001)(38100700002)(966005)(6486002)(6506007)(53546011)(6512007)(186003)(26005)(316002)(82960400001)(31686004)(2616005)(8936002)(44832011)(8676002)(6916009)(5660300002)(2906002)(4744005)(66946007)(66556008)(4326008)(66476007)(41300700001)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWFLeGdMa3NveWQvcGVhU3VOZjVOVENMUEJ0NlFESXhRZnMyT0l5aDJzOU5p?=
 =?utf-8?B?UWxVWnQ3S0RSVDMyclc2QVlYOHJEWW96YVpld3ZPME5reThTZnJ4WC9Vc1RN?=
 =?utf-8?B?S2ErNjhtWWtBTmtiVUxFWnY2TU8wdlZzL05HZFd1bmt1N3RocmdQU05mWit6?=
 =?utf-8?B?ZE04VEUzd1M5QXR1d3VDOE5pZ3h4ai9MQThjUFZNRXVQeE1HbnJFVkhHVlR4?=
 =?utf-8?B?dE5ydWxBcS92aU8xQTBSR0htUE0rTDVsc3lyaWVUR0laTDVWc0xpVGZ2ZzhJ?=
 =?utf-8?B?WkljS3N5dWhvbzlNYWZRTjhITmJSZFY0NXZQN3FyYUNRVXV4OFhsLytZNnJJ?=
 =?utf-8?B?OENVV3RkQ28yN2pHT3NCRU1kNFhlRjFISjZDSW5zT3lyZ3Q2QTZmWHVjdERP?=
 =?utf-8?B?d0RLaFR6OWduelNIN1g1RzdTUFFJSEY2UVRlRzk3cmhqT3YzWHZaMXVpdklG?=
 =?utf-8?B?Nmlscm43VmJFZnRZUTFaTGhGazlXVTMzSGFjSHdySHQvSDJMLzJieFRxSjVD?=
 =?utf-8?B?OGNNOFAxZ2tsSS9aZ0VGYTFQQWxOa0JJMjhYdUdPMEsvUHhyVm9TZ2NZU0ZV?=
 =?utf-8?B?OXQvSlYvN3pCTEFCRkhBSjRmS3lKUm9sZlF0OFBQckhkSmtIanFEYWgzMVJI?=
 =?utf-8?B?ZkFpRnozTEtTNVdRbDd3ZmJiUmlRRmNEMDhuc2pPb1hCU2ZFeEpYSnM3MHJS?=
 =?utf-8?B?Z0djdkorZElRaE5DR1FtcHZRZU1uQktGeGpKNzk0N3NNS2tpV2xBNWhBa3U3?=
 =?utf-8?B?OFlzZ055SklPbGVWeENHajArckZiVSsrNVQrN2NYbmQ1emp3UW9KckRSWldv?=
 =?utf-8?B?clArbUtmLzZMYmxwS0xBR2JNU2cyTHRCU3BJTVhvdXJaQlVlWDNqZkxMNXEr?=
 =?utf-8?B?TDVFNm9FSW43OWd6dEwzWDRnSXd0Vkd1K3VnQnBmQUxudXUzcmdncnhyMFJy?=
 =?utf-8?B?Tmp3SWZKOE5tUTg0SDQvcDQ1dEc0YUxHTHYwUk83Ty9RTDhQbjRncVI2U2Z0?=
 =?utf-8?B?eEYwejI4Wk5QK1k3SDF0dktVb1QxWmNsVktrVWtpL0JUeFB5Q1JBVlBBdXlU?=
 =?utf-8?B?YncwVFZkK3lhS0JiTmsxMWhVMWVPUmVIOTJxYnVGRTIzazZkUXhXMlc1TjJ2?=
 =?utf-8?B?VHBqTGhqQmZTWDA1czVYczFmQTEzK0RMaFlMb2hIQ1hFVlc4bHJtNndBYzhm?=
 =?utf-8?B?dXpFcDdiTm9DV3ZqZXh3Zy8zajc4QUpqaWpmYjFnT0twV0dWODBoWHNHcFNY?=
 =?utf-8?B?QTYvWlpqQzlmWUROcTB4Z2dZVGt1aURiOStIYXplL0hoc3NkcW5sWUJIamk5?=
 =?utf-8?B?dFVMalNkMmcvTVJJTStzRDRTMW5TbGVveXRNUm1ReWZmWDk0TzZveWdMZG5D?=
 =?utf-8?B?QUhGNmJlNnU3Q2tLT1JHV0paR1ptTngrWGJvU0IwRW02T0dYS092ckJxNVFB?=
 =?utf-8?B?YUdKbzBYeGFZYVpleFR4dHJHOWVYZ0ZTMi9ncm9JNmpGTzg4YkRobVJpTHJF?=
 =?utf-8?B?dFloUDE0a3lSRkg4S09kZnJaRGhPcWpWVjNPV21peDA4Q0FETjRxQmlhaVdt?=
 =?utf-8?B?azFueTkzL2FkNGticDF5Tzk4aWRNcnZUQ3pMQ2hvRkMyOHBlS2xtWWxqSWxy?=
 =?utf-8?B?dk9rL3B5MWpGRzdKbUpnZHJydkpxVDBrd09kQkhETkxYN25kcU5KK2k0eEE1?=
 =?utf-8?B?dnBkSzNTUzlNZVFmMXlJMGcxOTF0L2NRY0kvLytoL0k1aFl3UytzM295MzBh?=
 =?utf-8?B?dEVlNisxZzYvd3d3cWdqVGluZ2NtbUdKSi9uVk9WWWZBMGNIUEIwa2d0S0lG?=
 =?utf-8?B?OGpPU2hSK3RaOUZ5K2ZNdlRIVHMzVnFqa3Z5ZzJSK3phZnBIa3d4cXNxU3Jk?=
 =?utf-8?B?b2dhUHVYU04yZVFrU2R4RWJXWlJaMnh3M3A0RnFTekRDd0JHTTd4cDEvQ0JX?=
 =?utf-8?B?RlFYWkVBZW9ldlFlVGU0ays4V1hiWkNBVjBscVBkeVY1YmJQTGlsWjBjRTNn?=
 =?utf-8?B?QTdVY2NiYURsc2doeGFycWlFQzZmd08zVjM2eXBnMjNxQjE4bHUyOUtjb1Nt?=
 =?utf-8?B?T3Z2Tjd3RDVFMWpwT3N2Z2Fsc3JWb3RudU5ZT2tYUlgreFlnSW5kS05DdDJK?=
 =?utf-8?Q?b3W7J6ejmbzYE3ciH2GpGwrQH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3deae37-c96d-4e6d-d45c-08db41a050ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 13:08:21.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvVk4q9EHe78HPAQ5BoUsWHs6OuEiN5ez7rpZviTFX+NoBrIAFB9Q6nhUSJRGSrpzHpw0cpvCjv+KYO2AW3nmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6532
Received-SPF: pass (spool5: domain of siemens.com designates 40.107.22.73 as permitted sender) client-ip=40.107.22.73; envelope-from=jan.kiszka@siemens.com; helo=EUR05-AM6-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=DC1Cdusp;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.22.73 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 20.04.23 10:51, Aaron Marcher wrote:
> Hi Jan,
> 
> sorry for the late answer, I was pretty busy with some other stuff.
> I tried reproducing the error in mutex-1 in alchemytests by building
> with the same options as you:
> 
> 	--enable-pshared --enable-registry
> 
> Unfortunately I cannot reproduce your issue with today's master with the
> testsuite patches ontop.
> 

Need to try again from a clean rebuild, I thought I did.

> On a sidenote: I had to apply following patch to make it build with
> `--enable-registry` under my setup:
> 
> https://lore.kernel.org/xenomai/1b7b54e5-2087-1d4d-3820-705332699cb0@yahoo.com/T/#t
> 

Builds fine here. But that snippet was also never submitted as proper
patch, was it? Please try to follow up on such build issues soon,
specifically as I'd like to roll out a few stable releases these days.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

