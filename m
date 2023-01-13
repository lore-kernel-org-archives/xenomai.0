Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73517EF
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 17:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkbLsrvapc+xFY2NbIEFwJlW1R8AFdAGTmYiQbGeQXHwvxv3F/gTy/7PcgeGuaySqXqbzRXmQX/U/Eb6ztpFRw8McJU2xDVceF8r0Db+jGdo+3k+mu9cxBIzFo/U/uiZkVTQBf6ZGqzFnCWvInplU1cCYdfFpOifnAJh5a1o5bhxs3cOgPk3QfCXgn4gKfDxfPAzHU9Q2FkpzFyLj8zO0xQu4Od9FPh1TIIEF8njOQoezKO06GXKjnbaIP17T68v7L894sb7SClhi6srBrHlDi7ODdJCKQCXwITTdM07Ro+QCdbGOnmckO91HXkykEx1ZnuAxgSeXAam1m3RwGZEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ62g2noT5ZGXrlifmAi7b7BOYlZgnHVDvY+H+8eZnk=;
 b=RG9N9LbMg8OEWcRYnx5XdXGfjrLpISp/33Gd3OWVfxiMLikK9jiY4P2mc2EC9If3e721hS3qchkPUAQoelIbpZi1ZF0EH60wxE+1YF4IVVcEGPuJ2//lu0Vlq8/ktH6r3ipvg/O+VFqls2JGVG/3tro1r94PRVZLa8Kqm4NQUGc15H9K8qyHxMXEepsBHiPft1tarS7uDR53qdEU4GsJPtcjmvigV7AVh9YQe0E/2dKkIIohByEhPUmgsdTU6/5H06dc449ICJGtgglVLdAwGSZ2rXJZjrFCdseDh2h99HJX3Mip7BFJDsysf5nMQ4Q4jfIb7fP7h3oeDXhhsKOrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ62g2noT5ZGXrlifmAi7b7BOYlZgnHVDvY+H+8eZnk=;
 b=xCB2P4+i8JQjWcCSWpMzI3HNeEGyXo9+LxdkdrMFJuJfhAxFQ0pJ/QC4sicof5ZW73u6ekTh2x4uf/NbjbXkEz+C2U/nB+GwB67rG2hB/fgUPP4Z8NRQNt9H4v8SU4u0ZzsJFX+DhcCxPdYQuuq9fKsiPjctl0a9cH7BbcQa8a97Q2gHjIDm4LAgMAf56UzxafUo3brwvv7/kinW1UH3X5g2x+LROf5+7nAaHsKY+ZeRCclzfw6mt4LiZAysAB1RmaeVj8l+bUGgwHpLbRp4GMhDDWrGg1nmGN1xLJX62O4EoDayyEQgKdIVrN8DlFo64HLOQsuW95wNkVCH46ckEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 17:15:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 17:15:19 +0000
Message-ID: <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com>
Date: Fri, 13 Jan 2023 18:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Process hangs after upgrade
Content-Language: en-US
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 Philippe Gerum <rpm@xenomai.org>
References: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
 <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d868e6b-0916-4de1-9de2-08daf589bf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RsZ8GnBD1kwKcoO6FB2F/QdRhv2SinoaN7GTcCCzx17EvAkqDopprAlwpiGjgb9QIKvEu70h5uBL15RQNOcNWQ9DTAzn4pfm6UiWoUBbKhl/176pTZosechnmrHGpA2wuF294zyGFfoXQBw/f+Y1WEwTDlmoF95jqXc3h2XSrUe7U2q5eyPNRsb9x2hxmP7cLLxZOXtF9z2jT9A3QO3F4RmWcpXCOGICRLcP2Yx+HMNQ5pg3OW3Y0faz3LHreW4tzDU5GQEya4LXwho6MBUTGgcQcFRx2JK5+b/HvxZ4wB/6EXgr72T2+W0WSKFlITWoYblwkwGFi6cO99rdYbyijw76QEES++D4QO2Y90qjJqc7UqeKuftBrOFxpz8wL5NY9k9PkoQd5jYZiyMlu4aPCkOCGABn6PLnHufF74+/pXghJo95J00JOjKQaSUvsyo25buZOSgyfdB8peFSdXIi2xiy2H/eZ7qiz59DcEaLZOrDa3Foc5RRly6Z01gcR7EcJ/inLZfnZTyX9/32ckLUoRfxd+x3Xdw6uzd0Qj5b5zJ5b+rH8X4byA5jhJUg87tk2RiljJ8q18DC/K0FqvDqtoxdunOjJQYAY4M4aKBNKv+EzpVOdSJKCnWEuq/SDOn7olV8aP3vQvGAy1nAKcMsW2cxyZHjaQl1FuFt0IMM6IFdiGKKiOv7tYpH07bbC6W246siWnDxsAoa2BBSUFs2q8Cnnfrx5JEKwh0ZPqwpb2s6jw2f/eLiNmYuvl3GWzalZCXI6Yo8ryHjIVZbey8oWN3/Ta3fkYVm1atuv/4awx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(82960400001)(31696002)(86362001)(2616005)(316002)(31686004)(54906003)(6486002)(8676002)(66946007)(66556008)(66476007)(6916009)(478600001)(26005)(186003)(966005)(6512007)(53546011)(45080400002)(6506007)(38100700002)(36756003)(83380400001)(44832011)(41300700001)(2906002)(4326008)(3480700007)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVwWkx1Z1pCbGF5UEZjNmFJejhObTdiZ0xwajdxRXExelUzOURJODVVSzI2?=
 =?utf-8?B?dlVaV2RKTHJCaXdBcTZVMTI5NDVGOG9mSHVqdWxpN1BLQklOdDhRTUR4cWU4?=
 =?utf-8?B?eFZwTTlWYld2Q1NTN3JkZ2tUTHkrZ3VPM3lXVWI1U3VQZXMrS2hFditXV2Mr?=
 =?utf-8?B?eUIrK090VlVpUW1UMWxNVzdwRCtwUWVqNUxGUWxuYUZEdHgyOTUyVHJ1eXpl?=
 =?utf-8?B?VFk3V2VIRVBhKy9pdmE2eXZjOWJITk5EUWdwRFNpdk1JQTJhZW1qckt3VGtB?=
 =?utf-8?B?RXlCais1S0dKbDREZ2VtMFVrK3lGa3FLbWRyQ3V2Ni9vb3drM1RFdjFLbnpy?=
 =?utf-8?B?bHRMMndSclRmRWNBTm9IWHJZUVFGb2NOL2kxK3Z6SHZDblFSYm95eWdxTTB2?=
 =?utf-8?B?eTFHaFBoYTRPbXB4aFVESDFvTWdPZVN0eVFUVFViL1JleFJKNEc1UC9LMzli?=
 =?utf-8?B?bzJXaFdLY2E2Y2hwVExBZ3Jwam1EZzJLaFJZYWMxWTlKa3dlNnpCcGdXM1lN?=
 =?utf-8?B?WmkyZEFsL04xSGw1Z2VSMTlzb05kTjlEemdGeGl1Y3ZsWnF0WDM1QU1uOXp4?=
 =?utf-8?B?U2xiOGRvVndUbEZjNENFMDgvdUpPZUxxT0VjTS9rRlVlV3liWHc5UUkyRjli?=
 =?utf-8?B?N0o3c0VYQWFEMWhZM0dSMW1GK1NGVWo5N1JqN29ZcXJBZTVRZ04yNDJlRXRu?=
 =?utf-8?B?RlY0ZW9TS2FiN1p1NTFsVjhJTmpob2hMU3drd25ocWdIbkVZdDdYbzN6N3Qx?=
 =?utf-8?B?cmlQS0FFK01ibHc4QWQvVldzVko4WEVvZHFROWtJb0xSb0JycFUyZFJ0VHEr?=
 =?utf-8?B?aDBBVXNPMEEvT0RsaEs4WTViMDRRYXVoMVRrZzJUd2dFMW50TXFuVUp3R1M0?=
 =?utf-8?B?L2IrRzZ2cUhjVElGaHlnaDJSOVIxQVBXK0ZsMGpSQ0xweEZrWGlicFd3K04z?=
 =?utf-8?B?MmlEVG9FditJSnBOU0FoTDVxTWoraU5XcjJuZWl5c1Bzb0Z1OWk2MXVqU2ZO?=
 =?utf-8?B?Snc4MkpKWituakc5UGVLM0NWZkloOHpUalJMR0R1WFhaUXpDWW1OTm5tUFdR?=
 =?utf-8?B?MytRUmt3T2c2S3p0NGlraVk2L0hwcUxoZTF6V0xZbXIrdTMyU3lzS1JML0hr?=
 =?utf-8?B?cW9xWkVEZVJmZ0VuMTZ6ZGhyK3JHTVhkWHpscGtxWmY5aVdlMkFMek1DZUdZ?=
 =?utf-8?B?cGE3TytJbmNqRnpVd2NORStiUDF4NGpDUlNPYlJDVjdiNVlObDUvZzhkQzZQ?=
 =?utf-8?B?ZXRtQXRxWmdISHhGVFRMenQwRkM1bTlYRXMyU0xiLzhOeHliOXN3VjZEcHhQ?=
 =?utf-8?B?ckgvUXNLUnpBV3JacjM3OFlva0RPSTRMa1hIbEN0Qy9zSXhrL3NlOUxSSWsv?=
 =?utf-8?B?Qkxoc2xWQXJVN21xUHdDSyt0V05weDFGNDVyV3Njb3h4NHZ2RHRVbnh0eWRX?=
 =?utf-8?B?NVI3MUxCT1FsY1hHb1dyTmo1K1lraUo3ZUZuR1ovVlJZWGRyMWtvblg1K3ZJ?=
 =?utf-8?B?MHB1ZTI4SmFXVjZEamt5Q1BaaUlnOTFsKzBpRXA1YndnajgyRVMzZzh5N2ha?=
 =?utf-8?B?dUdJWWxoeUNCdmMvMVY3LzB1ZHEwdkxpZGgrcWZUaGFqWEZPYjY2UTY5bmZW?=
 =?utf-8?B?RDhIeXRmc01PaE16UEl6ZGQ0dFJIM2pDbThwWmJkRk0zUWFLSVJVdTZkOGE4?=
 =?utf-8?B?T1lFODVKYnBCRVhxN2xEdlNwVXNGSVpLbHpFUFAvb25taHZZcGJwTng3ekpr?=
 =?utf-8?B?N3MrRmdLWmtvTnVrYTdJd3dKUjhyNmNBWDMxNGplTmZVVDFTdHp6bUhnSTRn?=
 =?utf-8?B?Q29ERGJ2SnArejI3Vys3RUk2aDFHYjlqVXhFODJhWmZ6M0Q3eC9nU2M4TkRs?=
 =?utf-8?B?VkI1K2xEOVlWZ0NmNTA1UCtBT0pKbG1TOGVRdGNWNXcxdW5NKzB0cEMyUE5k?=
 =?utf-8?B?MTAyRnE1U1JYcGFFTlRzR1N1ZS90TktyUVc1ejI4by9ZaVh6U2Z3bGx6dmxl?=
 =?utf-8?B?bnVnZHZSZEdRclVuRWxHeGxWR0tKdXJJSW1XU0dHblUyMWIzbko1MXNVMWdo?=
 =?utf-8?B?YkZTTUx2MUkyRS9yQWorM3JKeitBTkxJeFdmNng3ekYvSmxGUWVLb1NjR1Nj?=
 =?utf-8?B?RVZZckJmaEFCZ1hHdUNBaHl2c1hiTmlhdEJVdkV1Zk9qVWptWTNhbjBoQlNI?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d868e6b-0916-4de1-9de2-08daf589bf63
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 17:15:19.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3WXInWGtyeUIfg0k2R+Y3vWuAkc+N95iyh/klQcmAAVogymn3zKyAs1uy+89vJh1xu/CzBUuRHVf/yXhC5KEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3890

On 13.01.23 17:51, Greg Gallagher wrote:
> On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
>>> Hi,
>>>
>>> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
>>> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
>>>
>>> The IRQ pipeline torture tests run OK:
>>> [    0.992675] Starting IRQ pipeline tests...
>>> [    0.992687] IRQ pipeline: high-priority torture stage added.
>>> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
>>> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
>>> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
>>> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
>>> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
>>> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigger works
>>> [    1.048430] irq_pipeline-torture: CPU0: stage escalation request works
>>> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
>>> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger works
>>> [    2.113302] CPU1: proxy tick device unregistered
>>> [    2.117930] CPU0: proxy tick device unregistered
>>> [    2.126014] IRQ pipeline: torture stage removed.
>>> [    2.130654] IRQ pipeline tests OK.
>>>
>>>
>>> There is a warning in the kernel logs:
>>>
>>>      0.000000] ------------[ cut here ]------------
>>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 irq_pipeline_init+0x20/0x84
>>
>> This complains that hard-IRQs would be on while they must not. All that
>> in fairly early boot code.
>>
>>> [    0.000000] Modules linked in:
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xenomai #2
>>> [    0.000000] Hardware name: Xilinx Zynq Platform
>>> [    0.000000] IRQ stage: Linux
>>> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (show_stack+0x10/0x14)
>>> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_stack+0xdc/0xfc)
>>> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0xa4/0xcc)
>>> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpath_fmt+0x78/0xb0)
>>> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (irq_pipeline_init+0x20/0x84)
>>> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (start_kernel+0x28c/0x4b8)
>>> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
>>> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>>> [    0.000000] IRQ pipeline enabled
>>>
>>> The system and applications run OK with only one core in use.
>>>
>>> Is there something missing in the Linux config or anything else I can try?
>>
>> Not sure. We don't have a Zynq in the test lab or at least as reference
>> image here. It might be that dovetail is missing some bits for this SoC,
>> e.g. a patch analogously to [1] for drivers/gpio/gpio-zynq.c. Adding
>> Philippe for possibly more insights.
>>
>> ARM multi-core is generically fine, see our QEMU target
>> (https://source.denx.de/Xenomai/xenomai-images/-/jobs/552798 e.g.). But
>> our only physical armhf target in the lab is a single-core beaglebone.
>>
>> Jan
>>
>> [1]
>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/3d3e5a1659d69c9dc96471efa542dc05fcc58e56
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
>>
>>
> 
> If Philippe doesn't have time for an immediate answer I can try one of
> my zynq boards this weekend.  I reserved some time for ipipe things, I
> can add this to the list and see if I can help.

That would be great! I have one zync board literally at my feet as well,
but setting all that up will take the usual time...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

