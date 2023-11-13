Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01C2231F
	for <xenomai@lists.linux.dev>; Mon, 13 Nov 2023 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xV679KUG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXLZ8yTu2kzA8DEzzEi2vzkMWscqt9wZc9iaJc0JIQft9vz5Ciq6RDaqoXKLb/sTHRsBUaxXZGuq5xPpHjcYNFzq/lku5PITdEpIFqTShCAFYEvhRfYxYHAJaIEWj8HqvaEo+Vbzya5BYaPlyGTPqwCMoCHfqHV23KVKETmk5TpL41XYSZQCx2I1EBosXdT9fa/Z5VJMqpl0uV0oe+5Nw2iZ0LUK7KpwzbX+e8ylRWYryk4z9p+gBuqeciTa0eBwfVpBfcS22NAFCtrjsqMsONFYLCU2HsyUBHUYVRURfcXXlxtajonSEqRI78fagLf3oeZf71Tk3XVEOVoqf/OlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTMsWIIq/Bf7StoJcwcpAdjpqmpuVw25Nn5fYAh1IKk=;
 b=fab6p9Em0qYVFAaCGX3D2DxIdlRcM8zM9+HqHC/Aazhjs++rD/rilX9fF+gvGHyg5zxjhwpWEmbFfji/g1JAwmbweg1ULPJnt42Xzfjd2VEV1oD5o8L67MFIafu28JpfOEh8+UwR8n6YkgZaQ5Xz3uwgYQKeqCnqS6aSmS5wkfhU3tTgUiosWplEQttq32Eb310K6EzPBQeXuzPfauoUb1pBja2keIp2fhxFrX6eGhjANweA6DhYtZVc+Xilsa34CU9G8CRxJIF6BNTN8si5MOyyVFcf4kIrNbGzzp9347JVonGYk0Hvdk6QduypPY7pCdfgs5Lr+OUVxQBvJ0rSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTMsWIIq/Bf7StoJcwcpAdjpqmpuVw25Nn5fYAh1IKk=;
 b=xV679KUGeirZPMB8yRd0uUf/rq6k6g1vTNB3D5SX+YFzuw+2ezHV7zShZ8rs5wHAOuxy+V0zh6voYDyVQEOB3h6lZfE4K1tt97gkel2VA+HOli3aDDHfoltgOnu9kqjl02vmYYeUvSuUIHtmxHpQWZMWlvVzKTRgHIwOdaEuz6PLTKeoEq+EBkgo3qABI7tmM/7zy8BmEbrG/KzI7f5ZnvtxzjCjX9onrQc6uAS40XaMiErFUscU6wc27h2Vl4Nwe6Zo9JJVkUzAWVDQJqNaPVT3whhJl74/3N/ATij7s0Q+xT4pIoL4mS8K8ZDXlFWOMpMDR9AGP81R139Vy3DPrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 18:02:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 18:02:32 +0000
Message-ID: <665f5fd6-2a51-4729-a04e-fb8f08e483e5@siemens.com>
Date: Mon, 13 Nov 2023 19:02:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic
Content-Language: en-US
To: Yao Yongxian <yxianyao@126.com>, xenomai@lists.linux.dev
References: <2afba52.4d46.18bc7fc33b7.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2afba52.4d46.18bc7fc33b7.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dcddf2-abd9-4d66-272b-08dbe472b5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UgrBlOvZwcy6NMBuKubeOYXfM6l1JZEL/qM0uKvjiwDnxIGt88hFBLmWm7vYlAiRk5o6zqal3tEPTupA/K04256itCyVgCK2ePJYkkmmiozojvd25uzb7pmXi1r4onG+AhYoOpM1iAamhJr+x3MG/ZpVBo5tqp1taDdBJL1bA1doY/nrls/uAm32WJwZWSmii8M2d3dZMh1/t+ccktJnbihBf13ExGLJ78/3xaD6JGlRKp9GdxhrLLm9/DVYgp8jYIg92fqENV5OSb6LH8de5nw7q1BHkNO61DQojX/k2E6oKVWl9jRiJgaxj3J0nQxPTE7dusjEVl9dg4CEtDKKHnUCiO/RN/Qkl1PMxHjfEoP9sBLfuFBmYLpLDq+dExGbEwC6YM2edsz8Xf7fX7B4CRsJ3Tck0lU3nOcixNMRnoCrdx3PHmOnEwMav9ZOA720mJBS1XnlUvCylrMfYjkibiKeXWWw81favIFi7xofeR4xw/GLfpjBqxjZF08ybj7AJeLxME3JEEDM8UJyWZ3mWAYEMsMfo7AcBB7Qw/NK7YwFX2bXuIb7TpWPhRQa8Y9kvwQFSGvtjOFYe6oC+YktsWyHlhBDxs8HHYP1anecvZJ5mWGJEcAg8NxxtCDibiKctC+2TfqzQ0KZThb4HhYdfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(31686004)(6506007)(2906002)(5660300002)(8676002)(36756003)(44832011)(8936002)(7116003)(66556008)(66476007)(316002)(66946007)(6486002)(86362001)(31696002)(53546011)(478600001)(6512007)(26005)(2616005)(38100700002)(82960400001)(3480700007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmlCdi9kTWZQbUQrd29URkQ0ZXZQVGt5NUFGc1Q5Ti9qTTFIemVZTmJpcC84?=
 =?utf-8?B?WklUNkFMMlplalppYTZFSHRMb2R4d3JaTEU5OGdXdVpJNUF1bk1sZFR0a1Y1?=
 =?utf-8?B?Q2xMeWZLdjNYTk50Skp4UnhVWGRJQ2RnKy9yc0UyZy90NmxJN2E5R1ZRWDNj?=
 =?utf-8?B?bkw2OVI4MCt6ZnFkdTFBM1JJT1pXdlUrMUl6OFdIYmMvck5GYnYyek1QTENK?=
 =?utf-8?B?dlNDbHd6N0JqSGd0YnJZYXovRWZaQXEyNXBYaFRZTXNJWmJUYk1ITmk3NjNV?=
 =?utf-8?B?SzR0RU1pOC8vQXRkaFNkdnpJKzRmVWlUdVJUSHFMS0RmdnFvNFc4dkhzRWV1?=
 =?utf-8?B?MmpyMjNiVDJpb1VPWjNBK1VINlpBWnR4ZFdoMzdPN3I3TllnS1pNaGE2ZE9C?=
 =?utf-8?B?dG1nTVJ2Rlp2Y21OWVVLQ2xzRXZBRmdoOHRCTTQxQVE3Si9LQTBEclYwOUNY?=
 =?utf-8?B?T3dXb3JEdHdVT00vSlV3M1dUN2FVT210Zk9DK3NrekJ5aTVhTEpja3ZsS3Br?=
 =?utf-8?B?ZVh4NEVIRkJHbEdlZ0F5c2VFRlVsVG9QYUpnNDQ5SEhxVXorYXdvdnh5RzYy?=
 =?utf-8?B?bVVkenQ0Tk91c0hkYWg5enBqZ3RsUERHK1F5cTAxT1RsZ25hZXJPVVZxdEIv?=
 =?utf-8?B?TWRBUVNqOCsrWUpuY0J6Mm9pMHNHYjFSN0Z1bWpjUUc3bHZPTzVra0NJSnFl?=
 =?utf-8?B?YUduY1hpYVpyMVFDbmhJWEJLV0JnM3JIMXQvVXZMZS9kditIWEY0d00ycyta?=
 =?utf-8?B?Unh4YlUydWVFdU9naDR1cWU5ZCtMMHlHYjBXU2MrU3JuY0Q3VEZZa1I2QVhs?=
 =?utf-8?B?NWxDZnhsTXd0Z3FINDM4K1VXU1dMWWFyNXdQRGg2SDFmRkFMSlVoM1YxSy8w?=
 =?utf-8?B?MW9Ea3JEeVdJcUhiOGhvOWQ3aS91R2dPcW40QS9QaGd4bnErQThHTHpFK3F1?=
 =?utf-8?B?bWlEUnIvc1JDTkdmeWV2b1FmS0M5OGYwSTg0UVU2Y2d6NDFNc0UwcGRGQTZx?=
 =?utf-8?B?RkIzUEM5ZnVyaERhNHg5dkY4L1N0azMxOTJRM0VYTzBIbWUrQnV5SnNLTjFY?=
 =?utf-8?B?aStwM0dGWkFLTVUvaXVtYXVpd2NrWHJGR2xvODBGUTN1UEc1RnpxamdUTTNT?=
 =?utf-8?B?b3FJdG03NDFqdXpTdTdoT2xNYURsaXVOa0pQL21WN2xqMkxVeUwzRWQ2cDRC?=
 =?utf-8?B?bE5tYyt2ZjUwVFhPb1UzL282bnJvTG9vTWZ6a3U1ZHpnTnoyRDUyeStMNjlP?=
 =?utf-8?B?RzRSOGxYNFhNNGlkT09QeDZXTGQwZXA1bGE5Y2k0WExOZGg3WElQT3pkRDUv?=
 =?utf-8?B?OHZvVXNtei9UaitVN3NicDBPQ0xRb0ppTEVOUVYzMzVDRzNMVStoaGhLQ1g2?=
 =?utf-8?B?RkYzM2hjQ2FDMStZTUl2NXk0YVpKVVA5UTRnemZNNnN3ZGJwK2E2UEFuVkVG?=
 =?utf-8?B?QWVXT2ZxQ2hkSUpGc2UrbGQ3aThZS3h2OEhIMDJSR1AyeWdLOEFuSk5PMVRv?=
 =?utf-8?B?WG5ZRkxvcUhHbTFyRWtFNEx0SGE2dlpmdEYwa3BXYkxCOHFSb2xicWpFY2tk?=
 =?utf-8?B?UHB6dy81TCtRMW9adExyOW9jd2NlZXlocUh2aWdDdDJkeDNMZGtaR0c0ZVQz?=
 =?utf-8?B?Wnh4bzhVeHZBdUU4WW1BMWFjbWJzVEpNUWN6K09GbU9FeWlQM2lXTVNJUStp?=
 =?utf-8?B?TkNkOXVIRkJBSXdFSWdxbWl3eUtqTEY5Q0NtTkdrVWxMOU9qQ2l3TFJiOWRO?=
 =?utf-8?B?Q3JPZndITFR4NTVOczMrVXVhSklURHhtS0Q3MFc2WUZ5Nk8wZlRlRWl6Sk1y?=
 =?utf-8?B?cTIwNSt1VFBYc09UWXBTTzFlRHJnUEx0TFhGT0F2YjNIRFBtM2ZMd05PclFN?=
 =?utf-8?B?ejJuWjJrOVBhcmtPOUxzcXFtWlFzcGxRWEpXZDBYMldPTy9JNmtwaXMxK3J6?=
 =?utf-8?B?UDhjZWVOMm90NFczUnk1K3ZML3d0SlNZU0dXdm4xemE4OTY0UW9xZzd4Sy9B?=
 =?utf-8?B?NWZFRUNPTjd2UGRIU0hVUW5kSm1WQUhkS0w5dW9wcmpzUjE1SFRpTU8zQjBs?=
 =?utf-8?B?WE9kNFEyREJ6VXdxRU9UUTFpM01ZVG82TzVMUExiVndCalJqZEZDQTByL1FQ?=
 =?utf-8?B?Nm1VZDE1SU84MTAyOGprWGl0NGpWWDBsNkx4VnBuMnB3NTVCYmpmUkJKRHNK?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dcddf2-abd9-4d66-272b-08dbe472b5a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:02:32.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFBgvqwL0e8MveM/Tvi3YC9XAVnrTHHmKoUE1mlBVeRJPFN5FjwCf0ExA6xZO4T9VpmApwt2LKDhtS8+LHcklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7618

On 13.11.23 10:21, Yao Yongxian wrote:
> 
> Hi all,
> 
> The kenel linux-4.19.89-ipipe-9-xenomai-3.1 (linux-4.19.89, ipipe-core-4.19.89-x86-9.patch, xenomai 3.1) encountered the following exception.
> 
> Is it a hardware issue or something else? Please give me some hints!
> 

If you only get that NMI, out of the blue, without other signs, this may
indeed be a hardware issue.

> Thanks.
> 
> 
> [62001.014286] Kernel panic - not syncing: NMI: Not continuing
> [62001.014286] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: P           O      4.19.89-ipipe-9-xenomai-3.1-20201027 #1
> [62001.014287] Hardware name: Supermicro Super Server/C422-SF, BIOS E906.1 04/27/2021
> [62001.014287] I-pipe domain: Linux
> [62001.014287] Call Trace:
> [62001.014288]  <NMI>
> [62001.014288]  dump_stack+0x98/0xb8
> [62001.014288]  panic+0xe7/0x236
> [62001.014288]  ? printk+0x53/0x6a
> [62001.014289]  nmi_panic.cold.10+0xc/0xc
> [62001.014289]  pci_serr_error+0x4d/0x60

This symbol /may/ point to PCI SERR#.

Jan

> [62001.014289]  default_do_nmi+0x165/0x170
> [62001.014289]  do_nmi+0x14e/0x190
> [62001.014290]  end_repeat_nmi+0x16/0x50
> [62001.014290] RIP: 0010:__ipipe_halt_root+0x2e/0x40
> [62001.014291] Code: 60 c5 01 00 65 48 8b 15 e8 75 fd 7e 48 01 d0 48 0f ba 30 00 48 83 78 08 00 75 10 85 ff 74 09 31 c0 89 c1 fb 0f 01 c9 c3 fb f4 <c3> e8 bc 14 0e 00 fb c3 66 2e 0f 1f 84 00 00 00 00 00 48 c7 87 48
> [62001.014291] RSP: 0018:ffffffff82003ea8 EFLAGS: 00000246
> [62001.014292] RAX: ffff88885fc1c560 RBX: 0000000000000000 RCX: 0000000000000246
> [62001.014292] RDX: ffff88885fc00000 RSI: ffffffff81e0f0a7 RDI: 0000000000000000
> [62001.014292] RBP: 0000000000000000 R08: ffff88885fc00000 R09: ffffc90005fc7e88
> [62001.014293] R10: 0000000000000000 R11: 000000000002b572 R12: ffffffff82011740
> [62001.014293] R13: ffffffff824f32e0 R14: 000000000000001f R15: 0000000000000000
> [62001.014293]  ? __ipipe_halt_root+0x2e/0x40
> [62001.014293]  ? __ipipe_halt_root+0x2e/0x40
> [62001.014294]  </NMI>
> [62001.014294]  default_idle+0x1e/0x170
> [62001.014294]  do_idle+0xe5/0x120
> [62001.014294]  cpu_startup_entry+0x6a/0x70
> [62001.014294]  start_kernel+0x4a1/0x4c1
> [62001.014295]  secondary_startup_64+0xa4/0xb0
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center

