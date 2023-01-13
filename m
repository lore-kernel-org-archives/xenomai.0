Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B379CE
	for <xenomai@lists.linux.dev>; Fri, 13 Jan 2023 13:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/JSauz8nyMFAKqwz963AcJKlxiJqZSSq/kMaW/RibuYDNWVTdnBh8gan0s2eOfCU5WcJVmLVyCQQJIYxXNKQHgeqQxjAepC/6zwEoWgVw2msksPWj9cOuN6AqcXrx8AIRgXCOhLunP4orTBr9Zd40yZ+ZmLj+QRLlvNl++s83cKm4/UDaQ88vJWHtAdtIDVOGt13d8DPEZyx4LX1Xos3riQ9qgvPJ1zZo0l/T0M7zxF8gc3JdTnq3V+Ye0QT09x2jWNeV5dUFgBMXwcM3bwOVQwszfQ60JCb1Cl3qWVfLkk1wg5HwcQr/GUVWpQuKOWslBpE5TDos/MI+1NyN/zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQsGeL4y1MJV9BwvNAAoJNUsySKU+gLzuROy4J5AmDw=;
 b=k2yPHvtz6UlzcYjCxoImjhv8Ejp4AZgcLX2Mc815Vm10hVsW4KW7xz+lNCpQBP2BpWCRbl4txSNwfozkfvO1d6Accm8wC04MqjsPBsKpV+qgQ5+/TcvwUux5NnNgi3E7dnrgzwicFOxkMvCDepZYCXfpWfvijWZH2zNVsg8Kzmz69Yn/ZtX9/WX1To4Jz5Bm7rOxtKWz8N3LZvzyRWCCj5xMc/TRy8IECn5TmCkPEJQLE3yUbLBcfALLhGfW6o/0KmfGPkD1/PlidLc4p9m3ktLs7+1IkD3bhcZDkdiHa2X+cRKYB38Mzb5nHLOjil3QjudIxpNmrAYBaJsJSkurSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQsGeL4y1MJV9BwvNAAoJNUsySKU+gLzuROy4J5AmDw=;
 b=AXLSmx5vSvm7tKUbqSTBUWcjzFlPDoMRzlAyF8AaHr90BaKfDyqmRpd5257o3NVKIm56KqSUuUU7/41k7ZwkEIo3D8hLSC12bY1ntJL/a1NjhOwW0WP36BmvfZ4vIvZO8E7/guMP4F7w8pykgLJJ1IfuoPUXkG3CxhIKEXpeykeG01lKjAZRl8SYeE8Xbh0/J2fxDpj6dN1ZXoadWwV+TRXFMBXbb8mjfUdD2oNbMhOR6naGvns1V2twfhc07XEAwpGt3zaX3V0+Cl9aM1d2Gxwb5j3ILWkamx8Y7PpJVZzeE0mkco+G3vg8D74N0vuDBqsEN45GxianGtPgto3UPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 13:52:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 13:52:41 +0000
Message-ID: <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
Date: Fri, 13 Jan 2023 14:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Process hangs after upgrade
Content-Language: en-US
To: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 Philippe Gerum <rpm@xenomai.org>
References: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1e4ddf-0c27-4ccb-517c-08daf56d705c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qrkUbbkevcNYkxWKEvuHwmreJZQ1gw38aEnEFl+MiIEiwo9qaAFHprKnyIwGgstK1FzTed6ieI7TZgi3C12bXKlpuApN51kcLal6Q8vXUipwxLXnBH8nwzaiRqzaUEid07iomY8TpLC1mGLjl5IPTfQE9sFBih3AnNnREzbmd5t7Xi6ih32HmTcwx6i3o9eO/p5p4GDKlxfWr51N0kdHF5y5v/BIW6rtIB97SXzpd5pxgu2KSWiVUL8+mbnHsY6mI+qKj4zQDNAI/5z9NSe+h1f4ZsGvU4WBqlZ5ul3lXgGL3GLnjzRImrZ8HWK91B+LX8U35DmwiKcrVg44X8NjrFVyHJgzX/fH31mdAVh6SCKbqkE/aR642swpW7DAvW3uM6Q/+Shi7S74m8VzIU1CXJU1zNeSFFjWLhmDWoeMbSugbQlQ2V1P+2vXj8LNfz/bhpH+zCq09Te41ri0RiRzd1i4wo1vvS4geRhsH57GjQi3Tgghl34YSZ48lRaOJ+eRhAZULVB4vcc8twqDA+G2jWpNJcenZEye/sxCmSPPwLUkPds6+OjPZyIetvsgaJ30GbrPmuhTdy9LqTRJkjoq0xCbVaMwAVNh3II0u70QuqOE2CYq9OkzTaedWUf2BnxO/iBgiIgdVqOvglrewQg2RVsKOuBZPQjKAoKNrT3zhILkbvyQEx0VJNlaQA1Fqy1ZQ+5lu7DPlTHzZZ0N74dXer6HtO8GGQIYEi6hacZYYgu1lL5jgEE5rbg3tSY6AL4bztU/+j/F7fogEyzP8DuxN+zOHauPLZEFXSCkdtTJVOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(66556008)(41300700001)(36756003)(110136005)(45080400002)(8676002)(2616005)(66946007)(316002)(66476007)(31696002)(86362001)(8936002)(5660300002)(83380400001)(38100700002)(82960400001)(44832011)(2906002)(3480700007)(6506007)(53546011)(31686004)(6486002)(966005)(186003)(478600001)(26005)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEZwQVY1dCtIZ3QwWFEwRUpLZXBEUVEzUndCTG1LOS9odDFmU1pxaENmdm9m?=
 =?utf-8?B?YkdHWUl1V3orK29iUWJ4ZU5TOUJnZWNNUzIxcldpMThDZEpVdG5lM1FjREQx?=
 =?utf-8?B?RzdGWVVudDRlUnNpLytQNGs2WmI4UWlwNWp1Z2hsRWlqLzN4UjkrMHpxcnQ1?=
 =?utf-8?B?U3c2QmlwYWpyTENnVVUvb2FCYjE5anhDT20zUk5MeFJheGVreWZQQy81REdz?=
 =?utf-8?B?TW5MYUFncUpLMVU3aEtOV2V2Q3BCQ1VFNkFZdStWY0Rzb1hNdG1vdFltM3pz?=
 =?utf-8?B?c3c1SGVGc3FJY0JJOVhzY2JpRTRwc243ekR4UGZNNFJERzNTVCtrL3ZiMDVO?=
 =?utf-8?B?Q2JnZjRjdmk4UUdjdVNkdUtzOTdrakJ0Rkc5SG1TeWtFeEI4c0FHL2VRaTNG?=
 =?utf-8?B?ZW9DQU8xWGxlNWVCMmlTRHNVYmUzRTY1TThvVDFUclRVbXdOcHk3OE9nUTFk?=
 =?utf-8?B?S0VVWWJVd0tIWmRZY0VGOTFwdFBZVy9hTUZZK3FkcVFWMHRvS1RPVzI4VEJO?=
 =?utf-8?B?eVJxclZVWlplZHloWXJGQnkzOEsvUjMzTlRvd2xyR3Z3RGhOQWlMS3NoUUJK?=
 =?utf-8?B?VzR3bXFhOENyUWd6Y0FabmFrTHd4OFZ1UFIyQmcwRjk5eWtkUTZ1eEh4U0ov?=
 =?utf-8?B?cFBzamFVdWQ1eEROR0hXd04xV1Y0OTdjWlZZZFhQT3VkeTZXVVFscHBBVGhx?=
 =?utf-8?B?b3QxTlBKSGFkWlFoL0daMkZJSitka1dBdGpGT016bnMrV2VHSVRzc1Q1RU1m?=
 =?utf-8?B?VWFKSWxobTBsS0JDMG5zWTZBZXFHREwxdjNOQWluYStZZWRnLzJST0dGU2xr?=
 =?utf-8?B?TmR1VWpSeXpzT3JPYllOU3VLQWtUWUsvdFNxZC8wSmMyMkFlc3BRVDJpSU1V?=
 =?utf-8?B?eVZtMXFLa3dHekZKajdLMHRmeVFNZzhSa0o2cVRza0FVcG1jWE5UMGpMeXRy?=
 =?utf-8?B?dzBhOCtWTzI4Ty8zQzFQaUtERkhxcGtVa1pXU0ZNaXAvbng4Q0lSU1Z5dnA5?=
 =?utf-8?B?VTVjaWlReXZQcndxQVpDT0s4WmVpTkFjUUc4b2huRS9BVVIwNzJ4TjlKNFRm?=
 =?utf-8?B?RFRGL3Z1SVJDOTZETUxyMzloR3VwUVVmUmN1R1E1VURBTHZmMFErVkhyTE9C?=
 =?utf-8?B?WU1pVmJTTkRCdklESXZEVFdWbTlFT0VSK3p6Qyt5eTBDUGthVVZ0YnNBbFdo?=
 =?utf-8?B?anF3aHU0U1VRbEFCOFhJSVY1MGtOMnJpSWdweDN6QWVOL3k2b0pleHUrM3dN?=
 =?utf-8?B?QzJlK2h1MFJGODc0ME9RelFJVHdseGlRbi9LQTk3R2dhSHo3UFZOQmxJRUQv?=
 =?utf-8?B?dU41ekxoa25iVUx2WisvRHM2ekQ1RTNhdEdjaThwaUF1Y3RmMUVOS2xKaDI0?=
 =?utf-8?B?NTJ2ZEFRSnpLSzRFMHhCYmtUNDZWb3ppaVpBcTd4aWsrUW5CK0JXQ3lUajVZ?=
 =?utf-8?B?SUljOXFmd2Z5VTU0aXMvNm9GdTJobHJVSTFIOE1oOExUdjlKTktjSGdMbi9E?=
 =?utf-8?B?MHE2cVd0VkQ0MkxtaFVScE1kMGpnVHFlc2o4NUxhMDlMdEd5RnZTTmlYWHkv?=
 =?utf-8?B?OCtiTE9QTGUrK2RXay9iOEpLb3pDUzVGZW1tK3lmTUd4dk5iRFgwcWkrODNB?=
 =?utf-8?B?WmlrZXJXZlorWUJlbzcxb21PcnBxeVRic0JaYnQ3cFZBdDhVaDY5R3U2cVFO?=
 =?utf-8?B?QzVraXFRZUtiZmlzcFRaT0haNEtnUWFmVEIzbnRnaktWSlJ1S1JiUjNhQWJx?=
 =?utf-8?B?b213dGJ1dm4wUFNUQ0xrRmoxdjlVWDBiRCs2TVRpdExTanJxeVJLbDFWcGIy?=
 =?utf-8?B?UEpTZjdSbEhGSWFRQU5vM0o3eHJJYkNDOHVobzFtMmREajJVV2RFeVFJODFh?=
 =?utf-8?B?OVpQb1VBL0QrbElrTkJHUHVYclR4ZkMvN2lvVFNsa3c5Z3BuQkt1OXduSFVh?=
 =?utf-8?B?NUFBNW53UDNYYVZJOWZzTXEzUkU4ajd4aTZvNUxMb3F0amxtMDI1Z3hhZzFC?=
 =?utf-8?B?ZElBWVphZ2daQXVRbHJMbDhOVFc0M3pOMG5MdGJVWEVXdG91RndDTjNvcGtY?=
 =?utf-8?B?KzVKa0l1M3gxQmpxKzRxY2piOWxrT0szQ1R3OThGa1o3SXhpQ1ZWTEZCVTJJ?=
 =?utf-8?B?NW1zMnpHVTl2a2tLdlRjQ2s3Uk9PNW8zaXRFRUdzMlZhd1gxeGV1dDMvc2g2?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1e4ddf-0c27-4ccb-517c-08daf56d705c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:52:41.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYd+GQDXXclXY5KfS7Hioj8x5+lt4A/vDt9Nk/kLViZZ33MPLph9sireQFq/MXuaomylRWMqoVnS5VoN9GQQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6065

On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
> Hi,
> 
> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
> 
> The IRQ pipeline torture tests run OK:
> [    0.992675] Starting IRQ pipeline tests...
> [    0.992687] IRQ pipeline: high-priority torture stage added.
> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine()
> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machine()
> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_work trigger works
> [    1.048430] irq_pipeline-torture: CPU0: stage escalation request works
> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work trigger works
> [    2.113302] CPU1: proxy tick device unregistered
> [    2.117930] CPU0: proxy tick device unregistered
> [    2.126014] IRQ pipeline: torture stage removed.
> [    2.130654] IRQ pipeline tests OK.
> 
> 
> There is a warning in the kernel logs:
> 
>      0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1742 irq_pipeline_init+0x20/0x84

This complains that hard-IRQs would be on while they must not. All that
in fairly early boot code.

> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157-xenomai #2
> [    0.000000] Hardware name: Xilinx Zynq Platform
> [    0.000000] IRQ stage: Linux
> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] (show_stack+0x10/0x14)
> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_stack+0xdc/0xfc)
> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__warn+0xa4/0xcc)
> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slowpath_fmt+0x78/0xb0)
> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>] (irq_pipeline_init+0x20/0x84)
> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>] (start_kernel+0x28c/0x4b8)
> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0)
> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
> [    0.000000] IRQ pipeline enabled
> 
> The system and applications run OK with only one core in use. 
> 
> Is there something missing in the Linux config or anything else I can try?

Not sure. We don't have a Zynq in the test lab or at least as reference
image here. It might be that dovetail is missing some bits for this SoC,
e.g. a patch analogously to [1] for drivers/gpio/gpio-zynq.c. Adding
Philippe for possibly more insights.

ARM multi-core is generically fine, see our QEMU target
(https://source.denx.de/Xenomai/xenomai-images/-/jobs/552798 e.g.). But
our only physical armhf target in the lab is a single-core beaglebone.

Jan

[1]
https://source.denx.de/Xenomai/linux-dovetail/-/commit/3d3e5a1659d69c9dc96471efa542dc05fcc58e56

-- 
Siemens AG, Technology
Competence Center Embedded Linux

