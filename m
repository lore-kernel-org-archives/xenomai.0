Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA386D38
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 07:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb7yB/HGYMgl9shP1+5JYwZuChphWXZ6E3Ma4PKSvn869YxF1eLXo3QNJYHjRm1yFp3BtFxoO7oAaU2fFfE7SfoA2woW+mUca+N5+QwDKW+U9UcnlUcX1BuBDaC+2SBHsTbVf4y/JcmpLppOu/7UOJYOYPhu48++8UAaoi9Zm5oDJVW/BaXH6GdoIs80KI49BgD5tzN7mzrAbuH25MAP+rIWK9yNWRk7rSHJRqmWGmJGlR6alRjpuVly0/YKfOAcR2pst8/oiH+zeqMoKuaFy42guHZHbJUk9aO/84dK/64gGuzn+feadKi5ZMAKKudB5v9ciSFEuflSd7UvIEXFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZGFsYVqnhON1hdpbEo5/9GzirLenpKospo5usceHT4=;
 b=UdiE0hsQRyGRtunDHztTQAvQ6+dYFHt3FL6E1ROtRbXn9O3KFjnaTGo0acNI1TwoEGgwR8IRxY3RlF59IeBYAmVu1aSxJsKmhj0Rh42rNmoXBGIP1q0RZHJ2RpJo+t94HgussllDlS+uFjD6YLpdWs6gU9dx7wueB8IT174iTGL7PIWq60Qtyune13EemkAu3dWhBHa0foB4Hxp8E5kTdKBx1qYrmCX7bYpPKEy0Y3Q4hS46qn7t/9A8CWpEnadiBjry2dUa0jfRxMychZJnx86Kfpbxbef+53fcrscsERXoHVhQvUCF5lEYIFaBree6a1M8GvzwRHHB7zy1EvlOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZGFsYVqnhON1hdpbEo5/9GzirLenpKospo5usceHT4=;
 b=ZMm4qABnBX8zaIpifIie4VT06UFYQ1TQlS5BXipTq/47BA1IsgpO97133lmZqxg9lvdFHpE77ygVbqQkffO4uVi7rvQq+sxopA8ci+4Z4H+Bs+aXiLSmxtPLxCIsS/l2GEnDyHOl6QF0kByA6Kt6kGsKa4ygVp56e/3M+w92SJU+9u2BGqWIpapPM70OvoLMVsH1r2mL/P3U6nUHl+kLYZuE8oyqowpG7vtDNOi9PaVBSXXpDA+N6W8ekTGBvLamMlpjrAtotWdE/C5I10Drx0v7h0vqDxE9YVgvz7ONg7Bef+bKMrzQ51oupMMWBNnvJoDaWWsf9fDaqT04N8ISUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:390::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 07:49:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 07:49:24 +0000
Message-ID: <41ce2ea0-5e13-4c4d-ada9-9c9f5c296e0a@siemens.com>
Date: Tue, 26 Sep 2023 09:49:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB13309086E38D6FFB0E59C2A2D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Cc: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB13309086E38D6FFB0E59C2A2D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:610:74::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: fef9aa36-0252-47c2-437b-08dbbe651a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lVheskmWJUcsb7ed4i6+1M/hcnNC983uyfFRepL7rrvmjXYN/79adMZGePk+Tk92eAoWDBbtk6V4FkUwgC33Ql8LbB9nn6n8EzVjDUbA/W7lWBVs1kz2lW2KTcNN8Nq4hs2Jt6cQXCz8XB2pGm6iSGqWQr1YCFTY6qbBEyuFkR0CrcAIBSnOmQb7RYQfrz33wULAZnxVKJpNi16jxRdXE3gNKTUPi2CYlXShH8mPa/Jp9FOvW2AmghPW+kFk0aX7tLqrtJmg/30rTRA53q0YfoqiKbm2Gh6k6E7Az82B66GSWtwbJyFR9KPVqyjYD4M66Hdp6NpEVZToH7Dz0Q8WJtRmbIuap2bYKrbKaA2xHxfqqTV0s4KaigF35wpKg3Bmh8zsi0N7xD6yGFXvexC7prJckBjBUSDsbO7LGlojpRxqEuy2DUOIJry4nqh7dJS64huMc3Gjzk+JzbA2PWqz03Qes44Wxl4f9phSQDUqtU/VdkldLHE+GefJwQagsmO2uET9HCHOpIYVsgMab79B8RDZVWObUfsL5Senh8umued7mx8xE8sidvlzifkjHEdAuc8tajs4Q67+2z6jnahKS8cqZt65d5HieKuEI2XvBnzK17ljaXl3O1/8V83QxG3MkDhbVSt9wFn/+5XLK7GOKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(84040400005)(230922051799003)(186009)(451199024)(1800799009)(2906002)(31696002)(86362001)(2616005)(53546011)(26005)(6506007)(36756003)(6666004)(6486002)(6512007)(83380400001)(82960400001)(966005)(38100700002)(478600001)(66946007)(5660300002)(66476007)(66556008)(8936002)(44832011)(6916009)(316002)(8676002)(4326008)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anpNZFc4MUt6dXFuaGUyTUtZR21BcUN5eGRIaW9yVm9Od1Btb0R4VFNMMFJG?=
 =?utf-8?B?d0pYd1k2bS9zNWpxRmw3UURhbit1cHprK3pJb0F5OUpVOTdILzNrTkFlZ1RK?=
 =?utf-8?B?WjJuWlBwUzk2aUNvckZRT2YzOUhEL3hwMUxZMm43UCsweXdXTE53bDBuY1h0?=
 =?utf-8?B?dEdDK1NWV3pCaTFpcDhoNy82T0YxbXNTT2xsa3U0ZldsZTdVR3pOZkhzL1dB?=
 =?utf-8?B?a2pCREFRTzRqU0dEa3pRYTlZcnRzZTBMSzZaUGVEdEJpVjFRckg4YXBGLzdo?=
 =?utf-8?B?b256cVlEeUcyUzRreEcvYi9hLy9LamZNaEMvcHZ3Vm1NRVJsSXQ3WmdYcmxC?=
 =?utf-8?B?REhIUXVNa2ZVSTh2TjJPTjlqQ3NyR0YrMGhxOFlXdjhKRGlUN1JmUkh5NVVY?=
 =?utf-8?B?aGZLaHIyWGVwaVVpVk5PZG9pczZQTWw3cmNTR2Z4SWo3ak02VTVuM3lrUFhU?=
 =?utf-8?B?N1pVbjdQTDlIbHcySUJpeVduandVVXFkUDVsQU1GZzBSdVFzSFNnYkRYN0p4?=
 =?utf-8?B?V1h6RWpvLzVRMktmbnhWNkhVbkhqdXFZUEs4bFB3MzArWHpNSjY0emZtNjRI?=
 =?utf-8?B?TlhkRlhmeFpteVprS3lEQ3JaWkNXdHhIVUJGN3dkYmwvQmp6NExpcmlZTVYw?=
 =?utf-8?B?VjlOQjBwU29RTW5xWThyeGpHNHNCTnNyVnRsUU5oeTNQYVRaaTg3Z0ljR2hp?=
 =?utf-8?B?K1FoRmJpa2I4RTNCZ21yeFZtdTgrTkVET3M3N0YrWVl0c2M0YzZKcjFPdFZV?=
 =?utf-8?B?Tlg4aTlmRThHVGVMdklYbDAvcW9qTGtKVGhpenRKZTJBUEpQMDlLMitxTWk0?=
 =?utf-8?B?THRONTFqbjJDL3lsUDhNd0I5MUdyeDY0WWcyQy9nMU02UE04N3pLSUNwaFFz?=
 =?utf-8?B?bXFQZk9yZWZ3YnBydUE3WW9TVWtZVkQwOE5PUHdGVjEzV1ZLZEkzbE1FTXd3?=
 =?utf-8?B?bkJNcjdkYW9UL3Q0d25vSzlTbnBRYi9zeE9SYVZidFBNRGdhWmFDN0hLaTFF?=
 =?utf-8?B?bTNISFZ6bERXRUc5SCtyN1FFZFowQlJ2bGZRMHh1ai9LemN5M0R1UG83ZkpL?=
 =?utf-8?B?ZXYwb25BVU94MFVJc1pxVkl3bnp6SlpxVXM2NWRkbmlrNE55OUszbnh6RTBv?=
 =?utf-8?B?NGRBWkxNVmtjZVZCOWJpeVU5c0lkOHBSeW9ZL0JzbWR0b0ZwSWpBMjZuUWJ5?=
 =?utf-8?B?ZWg5bVhlMVlpQ2k4eTlFRXkxUitobmplWU1FL2hjSGg5WTRtWlpzdFgwOE12?=
 =?utf-8?B?ZWRvdzAyZ2JGaDFHT0Vkem5oSnJaZTlBMkd0Ull4RFN6aUM4UndTaGlJTk83?=
 =?utf-8?B?VC9lY1pSWVk5VW82OU1hcmliUGhUNklrNVloQWJxNlgxVlZNSmtIbUhxMmJW?=
 =?utf-8?B?ellyZ2VHSldKQkI3cjYwMXh4eC9zVFFFZmRvd0pUeCtYU2dEQWoyQjJQMXVq?=
 =?utf-8?B?NU1pVCtSaGNLcnhGOFVJekozNTMzYmtRdFdYbm15UjNBdVJSMk9MRXFCeGJF?=
 =?utf-8?B?RHFQRzgydndHeHViTGRFbm5jUTRrSlYyZkJZUjV0bkh1TEVPdXVwWFo3a2dm?=
 =?utf-8?B?cFc1dFdTYWZkcnJ2VDRPZ0xpcE9LbWRMRkpqUHp0YTZKbElIZGE5UzRBVFE1?=
 =?utf-8?B?TGIvazNpNEFLNXdSQWliekxiNERSZHpxRm5PRzZRRVJ2NmVhZS9hS1BOTGlv?=
 =?utf-8?B?QStZNDJEQ2xubVZ0SFZYSUNWLzFacTdCTEhKa2dxVEpoY3pIYXJzcG1uWGx5?=
 =?utf-8?B?SG92TllWaS9rcnFldnowbWlBWjdYQkFrNkFmSUo2SFp4R0hQUWRsT1FEazhn?=
 =?utf-8?B?Ymw1TGxzc0NtOEJlZitpK2pKTGdkOGtDMUtyK1E2MXl0dXBVOEFaSzFBODND?=
 =?utf-8?B?RGMyVkNaMEN6K2lPQUlydG1VeE1qTCtIN29tcU5MQVA3aVQ3SlRJV3dXWVdy?=
 =?utf-8?B?U2hjMVZwVWR2SmR6bzZ6dlN1ZEtmRWZ5aTRnY0gzczlic3FjNDY3aFJ6Yk1j?=
 =?utf-8?B?OVNadExEc2tGc2hPbXo2MWFFVVRJRjVpeU1aUTdMQmJtVVczOGE1L1hIaXNG?=
 =?utf-8?B?a0lTVlliWGNqSUhmOVFJY0wxWDYxdHlaSFZneWR2STRCL1ltY3VQTDQ1S0Y4?=
 =?utf-8?B?ZjVxMnRqMTNTQ1Q0dGxrRXgyRFc4QmJaYWx4K2NtM0l1QVN4ZXp5Q0crL0J2?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef9aa36-0252-47c2-437b-08dbbe651a1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:49:24.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1ddJPCm1S8RvnjFAsX6/b7IGf+/oQdBrRokBu0OnImOgn82D/dUrMQsdBKI3oMUsEV2zk8riaKWduvrNHvSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5833

[please use "reply-to-all" so that the list is kept in CC]

On 26.09.23 09:46, 박경훈(Kyunghoon Park) 수석 두산로보틱스 wrote:
> Hello
> 
> Thank you for your support.
> 
> I downloaded and checked the "ipipe-core-5.4.255-x86-15" as you mentioned
> 
> This is a kernel source not ipipe patch file
> 
> Is this source ipipe patched ?
> 
> The patch file for version 5.4.255 could not be found in /pub/xenomai/ipipe/v5.x/x86/
> 

We are no longer generating regular patches, only distributing the full
git trees. You can easily generate a patch yourself if you need to, just run

git diff v5.4.255..ipipe-core-5.4.255-x86-15

Jan

> 
> 
> Thank you
>  
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Tuesday, September 26, 2023 4:07 PM
> To: 박경훈(Kyunghoon Park) 수석 두산로보틱스 <kyunghoon2.park@doosan.com>; xenomai@lists.linux.dev
> Subject: Re: Shell command segfault occurrence phenomenon when xenomai task switching running
> 
> 주의: 이 메일은 외부에서 발송 되었습니다. 링크 혹은 첨부파일 열람 시 주의하시기 바랍니다.
> 
> CAUTION: This email is sent by an external account. Please take extra caution when clicking the link or opening the attachment.
> 
> On 26.09.23 08:35, 박경훈(Kyunghoon Park) 수석 두산로보틱스 wrote:
>> Hello !
>>
>>
>> I am having difficulty developing a xenomai applications in the linux system.
>>
>> The xenomai application is implemented to create multiple RT tasks and perform their respective functions by switching between them.
>>
>> However, a phenomenon was discovered where the linux shell command 
>> crashed with a segfault when the xenomai application running (error 
>> message in the /var/log/kern.log : ps[1493445]: segfault at 28 ip 
>> 00007f18fb955304 sp 00007ffe6a76fb50 error 6 in 
>> ld-2.31.so[7f18fb952000+23000])
>>
>> It occurs in several shell commands(ps, sleep, awk, grep ...) and the symptoms of segfaults are all the same.
>> (occurrence location, occurrence library: ld-2.31.so)
>>
>> If this xenomai application doesn't run, it won't happen at all
>>
>> When I checked with GDB, it occurred at "THREAD_SET_STACK_GUARD 
>> (stack_chk_guard)" in the glibc's security_init() function(elf/rtld.c)
>>
>> I tested with the xenomai demo program(/usr/xenomai/demo/altency) instead of the xenomai application, but the same symptoms occurred.
>>
>> I don't know what the problem is(xenomai porting, xenomai and linux 
>> kernel version conflict, ....)
>>
>> I really need your help.
>>
>>
>> ## Note (enviroment)
>> xenomai : xenomai-stable.3.1.x
>> kernel : 5.4.208
> 
> You want to update, specifically to include ipipe-core-5.4.255-x86-15 because of [1].
> 
> Jan
> 
> [1]
> https://secure-web.cisco.com/1AImpxM50snQmZ8YzZQz2XlV4We1ONudRWQ9PoQa7X_aG4dRhXh00HDDBJApjd-CvaAmmaxrlK4wslrAtS_Du9_ONxGfPkEiTwkOvOR2oZKFdtHJMOJuWRIBsQBKAK127NOmEhbF4wIhCT43mm0jWvQFQheN9At7DwZCHtV-O2t_S9OjzwKM8OBtWGBaCratvRBu4zahBi3beyu_PVregH6GTjvkCjYP24jCW_NbtT_zIwyEtUypadbi7sPblnuzt94q07-150QLh5U5BPNCwinsyy7X8lVyPMVHvGUEeoGxx3GDN2QGpJppX8zyOhuGx990UdC2ckofPm8MFPP9rmg/https%3A%2F%2Fsource.denx.de%2FXenomai%2Fipipe-x86%2F-%2Fcommit%2F2c7a52ca04566c6a27dd99bb9ea81107b986c49e
> 
> --
> Siemens AG, Technology
> Linux Expert Center
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center

