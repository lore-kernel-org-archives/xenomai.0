Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AB10A20
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 12:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srpx2maLoVhA6b10jED/QTh1JC3+ZfBiQBYy3ys7su3qiFepcu2WCKpyHB5ET0YsZx9GEZ55wmMEnkOHGBu+CmBjVjnsvXrfezVzQM3jsqXUHgxlwpVeKXGH3gfmicTBkft+c+gbt+DY7xwSkGI33gnvDi+SCIprQGoaqvGSpVWOExGY+gj3NdQLLn/w4zaaIDXiBMkwZCnaGXiOIsj/T+EzA16BrQ8e2/Y6DjnJCZEsWEw7VTbLETIievpsGMLAYsJSeqIR+/cInfXHR6x91rCAiZMZu7Qk7khyJKxHm6prqWVuF7+e+6CgD0WNwcpNjdOEvMT2WlvqAYg4WKWJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MzH7KhiYOjLkJdsF9N0SBcrAxBDx/xH/WhX46nm9wo=;
 b=ioAQI79KOkosGQx9n1QvO8L5o/yY15wL8B4R0bbFAEnnpw+37kIdImlTBLfxoMBqBZt3N3ioHMgH1uiv51Oajg2QRuARph9QcvxmD69kTMOkv8W0Ypfkv++Kqp9QoQjCMIkjP+SN8I6ph4ZwDEaFQB/Lj4F3Qgwv29HEqUVy1xPBHS8k5BcIueGqNO2Hhr9xLUzBBAtB0Xly1K+pT5bLEj9kE83pQGsXEJCiBiFSBrXUhRZhR4Rm4aEFcWB5//esME9F4iiplSaE7MQzw0oTgHTNrdQR9GifP7c7PzUqeAPeJaa8fClzwCpcXIxBvwo6MHeYNfJm01Jx1IfiPzXgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MzH7KhiYOjLkJdsF9N0SBcrAxBDx/xH/WhX46nm9wo=;
 b=lAhi211dMnNgGEFavpewMWF5PDym1PJ2dBqkitCRqJG/84A0IHpA370ExQjaJGQ8cORcX+SM0EJWq0jNmyvLCVN9DA1ZUMmLBy0QseYiRv/16bZL+y+xHVbBeAEzi9cfHEGyg0FGSB1LPnczfurr5rCF6B76QJR5qB114Vc0ICWTVdkYlzHbV3VAnveKNY7Q01mEN5A85o63/L8PNdw7VB1dRRVbT67z16v/CEOBo4NhDCCYj/bsW7AFniCkaVvco3clvyOnMRV/t7KxY51jCVT26w9SvkNfmKkZBsPTyxQdevwe52UmgMKqap4xw0a9/owJ2Hrz+GNdSgDkfLOT/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 12:28:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 12:28:10 +0000
Message-ID: <8637b67d-ec5f-4dac-a53d-a473d3f89cfc@siemens.com>
Date: Sat, 23 Sep 2023 14:28:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail 5.15.129 and 6.1.54: New kernel warning on ARM
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
 <878r8ymqzp.fsf@xenomai.org>
 <544dee0a-c072-4f7d-b5e3-84e6d50df093@siemens.com>
 <87pm29xkon.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87pm29xkon.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2c04b8-63e8-477f-f2b4-08dbbc308c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	csQOJsj7IayAcdtzQTk7Rl7O1zhR7A2Q/a3t17E/6WqTw2UxNf4ntBJ2iYkE6qg5L3bYyZHqlpeDE/9xbTvi+l+/yXn1qNZTJBCUVtqtkOqLRkNZc7i1KbTURNaysjFsGRw59lJe7xZI7TZisIwwOIL4uIWLZyM8MK9uyJ9IVaUikFYMUMdhInckJAecNyzs1kqrTm7aU/9VTMc3AmndY0vvgmHzXpvsHtrNPSQKn8korcyyp0n8SThP+XvE4zpSn9HiAwAV+He1z3+Na1YD/Hb+aEbjWA/renrw8dMdve3XOiwdFy9Z18orX8qCs556vhJNDWVrrMN5kFZgP3OuXdyl11h9724wBaaDJELpslq6QwANe4B1d4V26hAwbfDoZY+f2d7Q8pVYHEWasnSmHze0dfQoAkYkoBwCE7NIPfO5ee6SOlJZ1fw7szM5CsTa0jwGY5n80Hg/nuZgq3gQ15eCQjt0VLWCugmGP85sNy/kfQzUnLsv4Eqi8QwSUVwzHO1f66fmady+IuySYlaL06pdccUgwGOGLNbzyP/rb/iAaP0GmQY+3kCIJRMfhCaiZ7efzEA1YQ9gHdjBufInqnuTA2dpcRDj0wlPegtQ488O201yuGcI3cxXE9mXujVtOdm302Ciu6crHklL2znieQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(44832011)(8676002)(8936002)(31686004)(4326008)(316002)(5660300002)(45080400002)(6666004)(6916009)(53546011)(966005)(478600001)(2906002)(6506007)(6486002)(2616005)(66946007)(66476007)(66556008)(6512007)(26005)(41300700001)(83380400001)(36756003)(38100700002)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFWbjVUdEZQajZSb2orZXJsOEFLV3ZKbDJwWmcrQzZ4UURRYWtoQVVsM2tu?=
 =?utf-8?B?bUNWL0ZzeG43ekpWOUJIeXZJVzVJMjRRcE9DWlljVDBjUHREWks2cm9md3Yy?=
 =?utf-8?B?ejJLcllHNUZPVSs2ZXp5aEorSU1VM3R0MHhVNzNtNEZ5VEFOMjlrZnBLMFhR?=
 =?utf-8?B?WUFYL0JNdzkzUnpEMVRRQ0hkS2pUWGF2MmpiZ2tEZHIwTjYzejNzRSs2am10?=
 =?utf-8?B?T3l6ZTdQb1RCQWZKaDN4K0JQa3NpdGFSZm1UMXF4Rk9nOUVhYzNPYkpQZitH?=
 =?utf-8?B?eHA4QXozcE5ldWc4aEkzQ0QxakQyQzJkYWJ2bXY1QmgzeEZZTTg3UENZbEVZ?=
 =?utf-8?B?MUtiQjVxK1M2ZklCcUpBeSs3UVNTUzFic3h6V0FHWkhSYVkyRzdYcG5WUVM3?=
 =?utf-8?B?aElHZWUxVUgyWGY0Y2M2MFp2MTFrUTZLN0hseFI5SHpzSW9EcXYwTWNuNzZx?=
 =?utf-8?B?cHQxcDduMUl0WEs2ZXREM0NOMSs0RmRTY3BEQVplSnk3YUtBWFMzZGc1Sm1L?=
 =?utf-8?B?b2RpWUJWaFlHQ1hPcXcvVjYxQ0pVTFB4RW94K3ZwYTVyY1htRW01ZjR2c20v?=
 =?utf-8?B?WXFvbHZXRThaNXZvcHRkVjJxWU9tUzBUWnpRRzZST21NMEptb2pOOXhncjhu?=
 =?utf-8?B?eHFJbkwrSG5MTS9YL1ZBRk1Tdm85VStuTzFlMkR1ck9SM3dIdnBMaWNScmJZ?=
 =?utf-8?B?NVNzT0o4Z2JKZVFxZmZ3ZGRoZGc1cTNhR2lMMmNhdXJCREVtZ3QwZUVGNDdR?=
 =?utf-8?B?RUZSU3FJSzJlMFpiTmtxbHZoSXArZkJZU1Rjak5wbGorYU5EMURWVDZoSnNP?=
 =?utf-8?B?TVJXa2FJcDFDRU1xSmpjdWljR2JzNjdFOURTdHFLWEkzTU5XZnFEeHVzZ3Rt?=
 =?utf-8?B?WXdRWjl1Q0FVQUJiVjVDbU4wWmNhTDRTQ1hxbmtjZHFsMnB6cy8wblFtaFlv?=
 =?utf-8?B?eXlZc09Ua2hSM2k2VlhQd2F5VXB2cDFzM2J1bFpvVWQ1WWI5aHZYdHB4Y3My?=
 =?utf-8?B?U0JuWVlJeGd1UkJtdnZ4YVljSG03YUVINE1Lb3dvYi9VNFBIaU1YM0RXRlFa?=
 =?utf-8?B?SncyemVBVUgxbnNlc2R3RldQMndHQllCQ1cyaWlBcVZZNjlGZ09TU3l0MXJW?=
 =?utf-8?B?YTNEdGtZdytLMElPTmR3aFNlSVBiTGdBdUI2Mk9UQjY3WllsODhtTi9xbTNy?=
 =?utf-8?B?QzBxN3ozeFdnK2djNFJVNzByYTdxM2U5eFhZQk5BZXBvOVROZ0VvdWc5eEw2?=
 =?utf-8?B?dDZGMUFNczFhV2NiNit2NzZxNkdJU0FVaXpCblVITE9ZOEpSMVIzTnp0TjR0?=
 =?utf-8?B?TFVIV0U4TUFDZm9zZmNIclc3Vng1MkpXVXAzWHVUdG8zTTdxOGVyRnUyR1Q5?=
 =?utf-8?B?aURqN2VuOXQ0V0pRcFZVRkVpRTlQeXVWWUQ2VllHekNwd29RV3hRY3J2ZHJh?=
 =?utf-8?B?dXpzNEJSVUNHTVJ3MmhOeFJxZ2JOK2FITUFMT1JpUUcvUG5tVDBnUm5ubTVu?=
 =?utf-8?B?aTZHU1NIVGliK0o5elhFMGJjRUNzQzQ5VUdkYmNwelNpVE03cFdyUFBCYW1I?=
 =?utf-8?B?LzJLcHE4M1BTejRqZmFOajFuWDlmaW9PM3hLS0lWQURqUG4vdjZNQTFsbHFO?=
 =?utf-8?B?SC9zWU4yeFNFamp1emIxMSt1QWJEQVN3Ym5ncjJOcTk2bUVyclA1ZDNSN1Ny?=
 =?utf-8?B?U015ZERRTmM5TDJPdFdsSkJyeXM2M2lZUmlHR3FuZDBURkI4eTdHckEvNS9B?=
 =?utf-8?B?MFdKVWUySEZOMUU3WG9nTVJtbXNwRXRjTDJzZHhEQ0hyTWNVRTBlOUwrVm91?=
 =?utf-8?B?TDVaaTdzcVJFK3lMQ0t1bTJTUFZKK2ZJYkwwbVIzWWtxdU13b3Q5QWJ3cUwy?=
 =?utf-8?B?RzJQS0VJNGs2TEhqekZ6RDNNeDVLTlEzNTlsRzF2K0sxdkFxRHB3OURXUXFN?=
 =?utf-8?B?QTVON0NTSktMbHM1SzFEb29GY2ptZ1k0d1ZJMTdMYk1yU0M4RHErdHBTc295?=
 =?utf-8?B?SGZnTjl2Z2VJMXlwTEx4ZDJ5NVJFN2ozRDRLbXRHNTdqZDdneElMNEZKeExa?=
 =?utf-8?B?emRRcCtnQWw4a1d1bXdqa0NtemdjNFFoZmlGY0JWamNWL0dFbHFSaGNmZk5Q?=
 =?utf-8?B?Mi9wa0JEYWhBeWhNMTY2Qk0yUHhpWkhqazlVQ1ZBajBQR1huL2ZMenRiN2RH?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2c04b8-63e8-477f-f2b4-08dbbc308c13
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 12:28:09.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UFKDpcxbDfYW1GOBH7zNrT477E8XjmdqbPCN0004LPyMLEGDYj6Chst8bg49SQS8cYgrKe/k8DFEwBrTFn7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5874

On 23.09.23 12:07, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 22.09.23 12:21, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> something regressed:
>>>>
>>>> 2023-09-21T18:21:40 [    0.000000] ------------[ cut here ]------------
>>>> 2023-09-21T18:21:40 [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1829 irq_pipeline_init+0xbc/0xe0
>>>> 2023-09-21T18:21:40 [    0.000000] Modules linked in:
>>>> 2023-09-21T18:21:40 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.129+ #1
>>>> 2023-09-21T18:21:40 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
>>>> 2023-09-21T18:21:40 [    0.000000] IRQ stage: Linux
>>>> 2023-09-21T18:21:40 [    0.000000] [<c03117e0>] (unwind_backtrace) from [<c030bd10>] (show_stack+0x10/0x14)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c030bd10>] (show_stack) from [<c1092dd0>] (dump_stack_lvl+0x8c/0xc0)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c1092dd0>] (dump_stack_lvl) from [<c0346b00>] (__warn+0x88/0x128)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c0346b00>] (__warn) from [<c108ea28>] (warn_slowpath_fmt+0x70/0xc8)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c108ea28>] (warn_slowpath_fmt) from [<c171d37c>] (irq_pipeline_init+0xbc/0xe0)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c171d37c>] (irq_pipeline_init) from [<c1700fec>] (start_kernel+0x4ec/0x6d8)
>>>> 2023-09-21T18:21:40 [    0.000000] [<c1700fec>] (start_kernel) from [<00000000>] (0x0)
>>>> 2023-09-21T18:21:40 [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>>>>
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693461#L544
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693455#L543
>>>>
>>>> Not seeing this with latest 5.10-dovetail.
>>>>
>>>
>>> This means the CI runs a SMP kernel on this uniprocessor SoC. It's fine
>>> except for latency measurement - the impact of the SMP glue on the worst
>>> case figure is noticeable in this case (+10%). Anyway, I'll work around
>>> this.
>>
>> Yes, we are running the same kernel config on arm in xenomai-images.
>> Given that you basically can't buy new single-core SOCs anymore, it's
>> more important to test and qualify SMP than UP.
>>
> 
> You are not testing much of the SMP capabilities on a bbb anyway, but I
> get the idea. The warning is fixed upstream, including v5.10.y which
> also had the issue - SMP was most likely disabled for this one in the CI
> image.

Nope, we are using the same defconfig for all kernel versions (except
for old 4.4 on BBB).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

