Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E552F2F
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 12:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrbaDDYVgm2hwpUfWlhC3AX9VxrGdRrcfVdTWacDKHReM4qbVVpOw7XUXZDZ+PZ2DNcK043d393th7eQdGwxn/eLOwHj0pLhtd+zNr9gM7retzXFZD2RYHUdavEDK2p8DQC4vGmb/cmX2P/ogSGQulj0LM4NSBOb4Uht0I/bgJLp/VG1y1J3c7T1/2A/CwH084juk13DwURlMmR+8CFGUZSmSXJ6gQn/ZofF1bSW/GUKK/JobpJ7op9V51c/C9MxHWadw0xyS7VsHjdx0j9H/ObLuQF1JdQC54fz0fn7S+BQjyRSCAQk8RJ76o1Q8nMjPTxU9gxXDbBl9qtFX0D+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygwJmGBGl3Feo0puf3AlrOmN5Jpzw2QUI78ib9tPjhc=;
 b=VqpfJs2fPuH2m5xNrqrArMtXG2tbxWuIEIy/WPTryBS+4XCdAgrBRK1j0ydbplPwGz9Lh21RSJiuxVl77pZt4/5TJdU/KhrYLx1B5QDZohRGWGFZDl8SlgMp74YMMSHrmnaEGdrWgTWJ5orQsA1VDrKuJNsfYllxQA8S+b3QYxXSLYVS6u+9hc7kcEF2Lve2wyZspckzXvK1wqKzP4ubET3Z77VvevcMVB4CY7P15w2+gIBeENUrwd4/onDeCwaPIlJg44J9ddrsHNMDc/AUj61vORq5rXH+0WiLadZ8xidm59yl4fTnNjFclkIt63spsA7jnXe+cWpKGEud19JtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygwJmGBGl3Feo0puf3AlrOmN5Jpzw2QUI78ib9tPjhc=;
 b=av0cCI5RbE0oLJFG4eT7GrXzpFLpxKF8isrUgLck9WEVQv/Tt5V+MtUk6NgZjcfeBubif007RfV/UdnNuCWJLNAUph6Vzk3Nu3RTtyMsd0OgI54g3nwEkDLA2CmmHXXVt0WsXvEl0npDZAWNoT3kcaNDJc60udEQh41OdX88Jmh7d+j8ZZTsbH6Ue+281jfjVCoZqYCEAEHf15OlYScUOwIX9n1g2hNcywcO7i+BlMjz+U9nXenmw5mFaRLNi5xdiDpa03pzTgNHK/tE9TEUC5k41ZOyyz2puLbmrwj/pqH3/UHATrUq15KNLTbZXrRl+dgZlc/zo5i23w0RK7ZiTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:10:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:10:10 +0000
Message-ID: <26f0691b-dc2e-2ebb-038a-372d122ec006@siemens.com>
Date: Tue, 13 Dec 2022 13:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Xenomai 3.1 on Debian 11
Content-Language: en-US
To: "Wielsma, Feiko" <fwielsma@e2mtechnologies.eu>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <SJ0PR04MB7405105B6192C0A4E1706DFAF0E39@SJ0PR04MB7405.namprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <SJ0PR04MB7405105B6192C0A4E1706DFAF0E39@SJ0PR04MB7405.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 996ca57f-e8f0-417c-afdb-08dadd02fafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b+TKf4hYgyaG4c/LoXnHRJzTO8F3MbQvy7ayMHoFOOV6/HiqbxW6xwXgqo0iuWR2PVKGQZp3zMLTgSva4F22x+oB8L/wpvTAaKUNNzN3MzQaaqyVrsu2FJjIfPu2Pr5zZtkTVMurQACqdTVEt4Wzpr027sUXMYheHTppbb84UGDHi1Mb8khy3fvnc7fI1AMc/LYIvj53UxHwQ/hZKvQYN2iY1TSuE6o0/t77IlVrjTTY2gYUz5aB59p0fdn7VHCmx9D+aVqw8iEm01N+fmlRx0ebCFNF1EQRT8QgRdEzbQNLrAzDh189JYtveBCA3ly3dwspDCjQYGsLHXtVi6zasZ3Mk8/hiQspqG/LxQPpeO2f+qN8JuAaZ5jdSOOSORwBa9a+MUeaUYmWtiou07u2bvMqh8XRQ3H070lwi3oshqaQcUt7m0I9HjThTuhfwPbVLWb8N2bOjtxh7mB8x8+ikGxd+4VvmKLQKSodgDcwPsL3mOhhVU65v/3KpRn3+Gv58NgeobuigsxtUDVpI5RdqnlDwbZiEPVoSO5vkAohRriH0snRJVqlJH3HZ4fV8QJR3U60Ep+Y/7vFykuLz0RkG5gF+t8yb0TXC44F70N6wW4eWJ+ByvmgJOowldid4AhDohGeJSmAxe/6XToRywFtMA6haG/ER3Rjlc7nyfq2MvKIh2tfeUnt5pmq3K3jL7YJdBO7t7QBt0NmjLmmeDWA/8ZINrrOsLTIyNX3OMsZtr6jAoLXuUzcKlaYIc9f6E2t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(83380400001)(38100700002)(44832011)(82960400001)(36756003)(8676002)(41300700001)(66556008)(66946007)(66476007)(31696002)(86362001)(5660300002)(966005)(478600001)(6486002)(8936002)(316002)(6512007)(6506007)(53546011)(26005)(186003)(31686004)(6666004)(2906002)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVFyTHZMTFBzUjAvQjFuNk8xTk5UZ1RGaXRYbEdVR3JEZkIzSm9UMjhQcUdw?=
 =?utf-8?B?dGtkUlNYWEdiN1psR2RkdTB0ellmZ0NNc1BGbytkR0JjUHp0bk1BQTBFMWJn?=
 =?utf-8?B?QklTdHR6VW5vNjFNTlBVRUpMWXdYK1ZUTFc3Y3NLQ1dUQ3o1YnFzc0FxY1ly?=
 =?utf-8?B?WkswVkpWZjB2cFdFbjhtUlJZRkk2TUxpazNYVjRMQ0JzQmhHamZkZC81Z0Vk?=
 =?utf-8?B?cmMrdVBmU2wxQUpGRXNiMHNtR3B1WFZsWW9WdDZLaThEcUUvK1pVd0FyendI?=
 =?utf-8?B?RmxVaEJ5c1Vob0R5cURGNUphczV2WTFERVNwT3I1eUpodzFmV3dsKzdBWUkx?=
 =?utf-8?B?dStoMGZLRTZVTzBKOFkvbHNiSGdsMEsyNXYwZC9Ka0xIM2FsQ2RXeWU5eFlp?=
 =?utf-8?B?WHFXcEJ3Qm9qcE5EOXV3QTlFYy9JK21DSGVqNFRBUjkyWVA5bytBNmNidjFU?=
 =?utf-8?B?U0RscXZNRTZJWEFIbXRCRE5IZ2g1N1REakZ1bml2RG5Ub2lsNThRWnZjdG9L?=
 =?utf-8?B?VGxZVFpPc1FQZWhYTTlEbjVPMnRZOURwVlhyYkRzQW55UlJBN3F1TnlaSXN6?=
 =?utf-8?B?YzgrdkFiNU5oYXBhTEdGbC9xV0ZBend1MUE3bjEydWtUby9pTmFXTFNkaWpy?=
 =?utf-8?B?b3dWSFV6T2tGNG12Y3psMTFiVVFJUzRLM3dvVHNPRElmazF2czhlRVUxZzlP?=
 =?utf-8?B?VFRJOGhtTituYXQrTE85UzRGcUpMSVB1SWtJaEhtUHZ3UUQreThwWGN1aHo1?=
 =?utf-8?B?aG0zbURuYWkrbkdSbUFTcStDc09VYmYwdFh0NlBNMHM2VjhWbzY4WkE5N2lt?=
 =?utf-8?B?c2RYZ2FpZmtBUE1oZFJLODNibTRhSW4zc0V4U0JtOTVTNHhLaFRFK2pJQ2lB?=
 =?utf-8?B?dzFIK1o1N1MyNEJOYVlNZzVSV2N2ZUpUaytxTE5lbXVWYzBQSlgvUDg1cnF1?=
 =?utf-8?B?b3R6eU4weVNkeXdRT3dxdy94VGFZZnltN3NzTUlxb0N4SHorWThBd1hLMGhm?=
 =?utf-8?B?QmU3dkZOM2xWMlFXc0NSNzdmWm1HL0wwYW9DUHJTZWtHaDE5bUQ1OUF0V2Nm?=
 =?utf-8?B?UkJ4aDRiOGhRbVJGSHR2Yzh4NEs2SDVPQ25BS0hDdUc4OWcxRzF0ejRoREIx?=
 =?utf-8?B?UDdlNHRFM0lJcTdsTEYzOStlYzB0SFZTMHVJakEwM3ZjNW9TQXJIaURyQjNp?=
 =?utf-8?B?TjVoSXRoRTNpbXlqMGJPbzF4SjB1OVJVaGt3ck9tOGRvOExSNER6UEg2RzRy?=
 =?utf-8?B?dHNiOTZidTNZUzNWV2VxN29YdjZLSU5FMnQ1THZzOHdNc3VPUXJjdmhRU2U4?=
 =?utf-8?B?MU9PdlFBeVN4NjVaUmFhM2JGSU5VZU9pZFVGbmhOOE9aQU9PRjQwNEtJbEo0?=
 =?utf-8?B?Y0x5SkdXWW9uZmZhVkdBZitDMHU3M2xTTXV4TXlvdHhiKzdKNXNUV0tWT1Br?=
 =?utf-8?B?RUJ5ZlBPM2RtRisvVENkRHVDY3oxSXhOWEwxZjVzdHRLZXZEck1uM3hJNlpZ?=
 =?utf-8?B?SVkrYnJPbVB3bGlTU1RLbDhSQi9hblZ4RExHN0Q1ajNGV1hFVFI5b1d6cXR1?=
 =?utf-8?B?ZVhmN2w4UFJGZG41bkhuVnRKeUZMK2hiWjZWbE1rNytYejYzM0w2OEVLWU9q?=
 =?utf-8?B?MncrM2VBa2hBdmtUbUM2cTVlNHZNQXRmazdFWXBhdEVJU0o2MVBnWTZVYjh0?=
 =?utf-8?B?OUU3VmM1d2FNbTBSa21uVzFLYjQ0UEVOa090dGV4dzEvOE1EbVZya1VvTUFo?=
 =?utf-8?B?akJONDhFbTUrM3ZSSkJpZ0RGYWNsZ3NMVUhZTUR4M1JnQzB6RCtuSDM5aStU?=
 =?utf-8?B?WnliREluNXBoTjd0RHRuZnRudmJsOVN6YXpPVm8wcGNUY25lU1o0UTY2NHdp?=
 =?utf-8?B?UTQ3bUQwa0Jia3ZYSENrTjNBU1pxWkg5UG4vZFpuSW4vRjN5YStNRWN4ZFVK?=
 =?utf-8?B?eW0wWWljNk1sN0xZUkcvakx4UDJmWkhydzNLWC92cnY3NEtCZ0prL1Y0NXor?=
 =?utf-8?B?YkRRRzduY2RGU1V0VUxibVhqdVdqc2NDandrT1UvUzFLVm5yUFgzeEdzVEQr?=
 =?utf-8?B?VWJFZ296YlBtc2swUDhEckdkVDVLS0cyZFk3cVROelkwd1lDWFNLVHlDTHJk?=
 =?utf-8?B?L1pUdzExYzNPVmJuaTJ0NnU0Mzdzbzc3Z2YycW1GdVpYdS9GcnNJa25SbnVR?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996ca57f-e8f0-417c-afdb-08dadd02fafb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:10:09.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMyVlha9g4bwfI4R6+nHNPO4o9HrJND6IcQDUYYU0cfaE9YJ/C+1bN7FRvAd8WceJ5R/9dyDGRZgNud1O5090w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5141

On 13.12.22 10:04, Wielsma, Feiko wrote:
> Hi Xenomai team,
> 
> We're already happily using Xenomai 3.1 on Debian 10 with Linux kernel 4.19.X for a while now.
> We have many such systems with these images in the field, and our current software targets Xenomai 3.1 for this reason. 
> 
> We now want to create a newer, more up to date image. Our first idea was going to Debian 11, which also has newer GCC and other packages we'd like, with the newest Dovetail version for the default Debian 11 kernel (we tried 5.10.X). Going to Dovetail meant also using Xenomai 3.2. 
> 
> The issue we found with this is that we can't use the same software compiled for our old 4.19.X / Xenomai 3.1 images on the new 5.10.X / Xenomai 3.2 images. We would like to compile our software once, and have our software run on both the newer and the older images.
> 
> As we understand it, the last kernel version supported by Xenomai 3.1 is 5.4, since there don't seem to be newer ipipe patches available at https://xenomai.org/downloads/ipipe/v5.x/x86/
> Dovetail, as we understand it, only seems to be supported from Xenomai 3.2 and onward. So even though Dovetail is available for kernel 5.10 that ships with Debian 11, it doesn't seem it will be at use for us.
> 
> We tried patching a 5.4 kernel with the latest ipipe patch, and running that on Debian 11 to still profit from newer packages, but we're running into issues with driver/package compatibility with the older kernel (it looks like Debian 11 expects at least 5.10?)
> 
> Basically, the question we have is: Is there a way to keep Xenomai 3.1 compatibility but on Debian 11?

We are building 3.1 (and even 3.0) against Debian 11 right now, see our
CI pipeline and xenomai-images [1]. That also includes using older
kernels (4.19 and 4.4) against that newer image - for standard features
not an issue, but better check with your specific application and its
package dependencies.

Indeed, if you want your application to be compatible with both older
and newer images, you need to stay on the same major Xenomai version. We
do not provide ABI stability across major releases but require a rebuild
against the newer version.

Jan

[1] https://source.denx.de/Xenomai/xenomai-images

-- 
Siemens AG, Technology
Competence Center Embedded Linux

