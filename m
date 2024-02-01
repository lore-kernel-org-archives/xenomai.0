Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4284157E94
	for <xenomai@lists.linux.dev>; Thu,  1 Feb 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771407; cv=fail; b=Zg/PruTrGgyAlUwf3xNRMKmtk97jAxitbKJJ7X0ZFk641Y2yMb3WnELyDW84MJFBNnVpzStPILiN0rqyW24G5ux7cp8UH4hCis1Qk7sT3+dKitLkjvvDLeNhInHDJA0oCMmMYuUAf0C8f+E83Kh4mDoYPNFvETcKXNLhGCc8Kvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771407; c=relaxed/simple;
	bh=AidylrJT3J2YOqGa7dqiJu0Gt1GbnF9eG3TrxEfTZo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OMSuvUqlgWOfhWfTPsHEmVyE72Fvc7KeTbbhw4UOf5rUjyIWFHvTeYxR5d8MnRYDX1pla0o9r0VINxcaRZBx3rD21xYH5Os5XF5IHieV2QkNXwtj+agJh0awsunZHwpJSBoSxib3O4fcwsX4mh+JUwjyNMQ4+4hIFYGwN1xSS4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AINjk8HI; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AINjk8HI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcEXwZwFqj77tusx/XeKr7oNV5uggYqNui0XF3p/+PgGQlYRUZIzxz/hBzgjOuDNRWrQpxPTH6w4cl4hMT3hPRoGCspxMCkGgy/fWB3aY14TpZahR8XmyVUKI6HEN2C9z1i/ZlGMvOW3DZg09IKi1UouzClu/9QTqNHe2CiI5Vx/GagDgavYJ+3bhMCDT8KJFtngXzONBERTeEGe6x9ruKGvDbgPDBADEcYKH5w1IrMtd8oUO3NNGNM78SO0VHF1VF8rmFTrn+DZYxSNagPaNrjpN3KhmX6xxFjcKvl1BQ+4T8KFwQA1OnZQdDmWlTNjw2sKJ8GXJ8kR7Mz1VdNhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gizNbQp3Q4/s4i17S5GlgBY952GmgXug5e41int+4L4=;
 b=BbyrVYEEYyphiY/5A4Ket82pbpxx1JAlLFrg+GFvKRb0Ovit+mUN7phFIeEHTLJd0Im2I2aMSy/0s1A/8x8arBXuBnRDtVa1pYSP8F/t3eQiYqrigBnO2pblVNaEC6+GT2pu49nJTTwF4x4btFhwZhY2ocPI/nnM3VFAlJEm1wtTx9pRpTRcPi9gbVOlHA22bnpiNCAePSLbF2vwxk/nNeh/6T7aDkHZXuhUhfMs/aeI6tZutGmhhxcyAEqFp9UxGMjDVSKuJPltd2n7bMbslJGOs9WybWm086P+3z2WuVZpRbyKkynrVXDB4Xqm/eyXd+89cQnJe/LM7L6bFE4LFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gizNbQp3Q4/s4i17S5GlgBY952GmgXug5e41int+4L4=;
 b=AINjk8HIr3J8KPofghZw+EL+RQbPUes5OKXlvWZ4jqBPOlaD1zAv/9ys1zqbPAeoSbW6Vf/pycP+6VHDeX/KXaRTrwwLBPKDXE69fdvPIVf2UDTwfE8GpK2JxqVy6FqPqcwdmBqNH1iRWtLXVCgwZMq6KPBMA6mIVT2FXcuO/swSAL0ySQ5ufn0YXJ/C0K2ddXfY6zwihLoxe4UcKGD0v3r34mG8HZ7DVi1ix0NSri1HbiTU1yCDuYw1ScY7b6qxHIB3VUqy0L0ZdhpO/8HlxYUxFPZngFMQjIyYPKvH7hWLPeQjeH98dYjBFiTSBwzI7syWlVQwxRx3xYnBbEYgGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 07:09:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 07:09:59 +0000
Message-ID: <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
Date: Thu, 1 Feb 2024 08:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: NX-protected page
Content-Language: en-US
To: JerryJun <jerryjun123@163.com>, Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai <xenomai@lists.linux.dev>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
 <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
 <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1fa15c-25f1-4a2d-2f8c-08dc22f4cd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1JyxQ7yudi67dKJvQqm8dOreMRV24c4Y/uop8DW1hfSWpUGLXDIdPet1zc/vXgZ9qLkYTpHq7W/lToo5IAvBYYiirvsOnfgZ+VRXl2uadyamKgOiFHZ+rsFwus0Tbjn9Z8PT9s15WlObMJ63oHrjWJvimTBGUaQcmgzvdaG6tg+m82J5XG4dvwGLeD+V8hfB0vYZ/1kx+Do6BPdqq8sc/y1KG/D0VSBkH7htWogUW32TJQ33CvERKLCbjc6BTfj11QOnZJruT+qK3gCpOgIDEzwwnp9gCI2vhSt+0qJYusRayOxtnLwoUi6Mu0/OC626XeCqUs+EJAREmxO7QWJZkCbHtCexajsHonNRoBuNfokCBiYG1UB3RTr6rP+WeCoTCJD1Ks8bymHfMUHuphwa02W6xNr71+4cPxjIN6yXI4s2dyUi+drLtEPaxMp9PPX8puD3IFliIweBNkuEFJiePAwnOVabLyAV8Jg3Vwu4O0Xg/5nsUvzWPKd0oEwbreIULoiqofq7ThXVyYw0Bkhkb3n8eUkwseH4CVvfXUf4O0euIYzKQ/QV0QpAQnLRyZxc8wSNI/6E6Pxa3R+vEStNyncdHPT8LJiK64BW0W4syQ6tdYTsnpMz69RqnXkmDi3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6486002)(66476007)(66556008)(66946007)(110136005)(31686004)(4326008)(3480700007)(44832011)(6512007)(478600001)(8936002)(53546011)(6506007)(8676002)(316002)(2616005)(38100700002)(2906002)(83380400001)(5660300002)(26005)(36756003)(41300700001)(82960400001)(86362001)(45080400002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFRqWnBSS01tS0JHeG96N0xtSlVjR3A2K2FMV3kvOXYrbzdjeElUSXRiWWlx?=
 =?utf-8?B?NzVEK0NGakJuaEpPK2NEd0lScHZnam04b0pTb0ZSOUtIMGZNeDArMmxYMzZ6?=
 =?utf-8?B?TDdSYUp2Sm5kM0VmbjZIOElLYndKbWU1L1ZpdGJMUC83dEltanVpOE1mYjly?=
 =?utf-8?B?a0ZkNXF2NzlMczNkaGxxL2lqMEtnbXgxdXdDaEFmQUFzWUgxWDFJOGs3eDBB?=
 =?utf-8?B?TUJmaHNqd2M3ZXJGcjd1OE85NVl6SUxXS0g3TER4MURQOGRqZi84U0NyM2li?=
 =?utf-8?B?K3ZtVTJid3FZUmJXV3dPZ3BFQko0eHE4dTRmVnN2WUgrK2w2STdUaXh5OW1M?=
 =?utf-8?B?R1dXaGh1Z21CajFGcEEwT3ArdHVaUEtuVlkvaS9jamFaRnRZZis2aFJUWnkr?=
 =?utf-8?B?dDdtOXpaRmx3V1Z1UGxQRjhwSWdUUHlDckkrcUFvNWpVbXF4UjJzTTRvNWI3?=
 =?utf-8?B?YWZKSkQyU1pVcEN3bEoraVc1Nlo3RlZnVjhkUnFqak43MWt0bHVBSWgyd2p4?=
 =?utf-8?B?aVZUUVJiWUVTalVhSVo5QlZnUEMwMjRFNmpXNGJwNTUwdE53dmxPOS9laTBS?=
 =?utf-8?B?R1RLNVhUUlVKUXdCMUI4MmZwb1NuNDBrK05ycXlZWnJNaCttRFNvZDFrMTFi?=
 =?utf-8?B?VXpaSk9ZUlZrVFlFenorRitJVGlDTHdKU0wzekl1Z252bERjZTFUUy9SWDBJ?=
 =?utf-8?B?Nm9UTjhTZWdxT25RR0xsWWlmZGp4bGtFcUY3UE9UemRUdno5ZmRzTHZBcThG?=
 =?utf-8?B?L0V5OGdVc0w5MU4vaGpqcms2cGRmbGlxbnBWSkpZc09uZHJFOEM5VUJRZWxw?=
 =?utf-8?B?ZGxuQUMxK2I1WjY3OG92MlVEQ29VMVVJWlUrS2NqakVNUTNQalZZSjhGU3lC?=
 =?utf-8?B?QXJuQmlsUlp5RktMdFd3a29kNk1SWld1N0U0YUQ4SWNSSkZwdFpvc0hyMkJ0?=
 =?utf-8?B?Qzl1OFRLcENZakVVOEJSaFNsMGtvMU0yOGlENmI3bk5GY0Q2R0Y4a2plM1hS?=
 =?utf-8?B?RlNVNzl6RW1sdVdrTk9DT3ZaaXVYZVY3RFV3emdqWXFYUHBza3JtRmZINDZv?=
 =?utf-8?B?L1loZWdpRldBRFdOSHAwUDRkOWpPQk9uL3JyN08rVnJhRjBITVVEQWk1cCtz?=
 =?utf-8?B?U0p1OE1IUDFhd1RUeTV6bEtHWUV3MHV4STVPN1ljQ0UwK3dvS08xZVhtNDRy?=
 =?utf-8?B?ZVpXTkNGUk5VVTNOVjlOTXBNM1QzbnMrMGtYL2tGcUVUdmJnQ29hRXBRb1RO?=
 =?utf-8?B?V1dVc2U5NWpqSWtXRkM4c0YxMmZmRGZoUFNYRHBqd3ExWG9QcWI2eWhpaUJL?=
 =?utf-8?B?WGFzdVF0SVNyOVNkQldleEIvcGl5Z1lZamNrVDd6VUVnOU5xQTVXcnMwRWxY?=
 =?utf-8?B?NTg0bWRPdUNKQysvZ1RBYUVXaFRmOXA0aThsSnZ3WVEwanlkUE9XL3hCVFZT?=
 =?utf-8?B?OTByQU1wRWpXRzJXWUxjMm02elVtRGdGeS8ySCtmYlJ4bzgwQ01HT09NdzJI?=
 =?utf-8?B?OEFoeHhuQ1B2MDdCWlN5VVhHR3RnM01XTFUvOGM2ZlU1NmJLYXVpa3JvdzhJ?=
 =?utf-8?B?OVJhRWQ0RmhwSU1TUW8ySFhZcmZENTcvYzFjWTR0V0phNVcrUlo0ajZaWnpD?=
 =?utf-8?B?ZnpMN1Z5UkxlZ3BaeFBaLzhPY3lMV3VhVm1lcmUzZGhnZ21lemk2N2FpWEIv?=
 =?utf-8?B?NmhDaEVzVy8wY0dLM1NYaDNkWUZZK052TnBhRnJnNVJmUGp2K2VQNzZDMWQ5?=
 =?utf-8?B?LzFoRHlUTFNDdkVvZUtpcW9pNnJodnhLbzk4bWwwWUxXQS9iNEFxenRVenRU?=
 =?utf-8?B?Qm9Cc29vMmU2Z2tkc1FsQU8rZEVPM0cvM3Y3cjFLdGlaVGlJZ0YwazhpenBM?=
 =?utf-8?B?eFBtSFg1aXlSbWw0SlBrZktVa1RlOG1BSHNXbUhPd05KYzYvOUxLWmtvblA2?=
 =?utf-8?B?eDByVnB1cXBzTTBzZXQ0L0R6eFhDczA2bVRxQ2JMYlFFWXN5TXF1T0t4QVlT?=
 =?utf-8?B?RnZyT3V0Szk2ZUhtamRkcWt6eTFyU0ErZVFzTmlETXZGc3dPRkxCK05iaHdW?=
 =?utf-8?B?U2xwRlg1d29Qb0tIc0srUlZsc0p6bzNSd2VpbmZEQXJwb2RaK0I0RHZiK0VW?=
 =?utf-8?B?ajlLOFV0ZXU3b05reVZXbytVa1FTWitiM2xTVVpFbncxSHdkcU92UXNVdVBp?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1fa15c-25f1-4a2d-2f8c-08dc22f4cd5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 07:09:59.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr8sfoW0YW/vIsSnNRSgO7aNX/17Tgs3VJVlXwvlsSk8bL34z2ZSuBBcch+fBRjs2fckr02YFCTx8zkLaS82ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7442

On 31.01.24 08:25, JerryJun wrote:
> yet， you just do make in the project to product the binary of oop-test, run kill_test.sh , and finally wait kernel oop .
> we get the same results of kernel oop in the qemu-amd64, which use the config from xenomai-images ,"https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads", as follow.
> [ 6191.671953] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 6191.671955] #PF: supervisor instruction fetch in kernel mode
> [ 6191.671956] #PF: error_code(0x0010) - not-present page
> [ 6191.671956] PGD 0 P4D 0
> [ 6191.671958] Oops: 0010 [#1] PREEMPT SMP PTI IRQ_PIPELINE
> [ 6191.671959] CPU: 3 PID: 7047 Comm: oop-test Kdump: loaded Not tainted 5.10.199-devo-3.2.4-20240130 #1
> [ 6191.671960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [ 6191.671961] IRQ stage: Linux
> [ 6191.671961] RIP: 0010:0x0
> [ 6191.671962] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [ 6191.671962] RSP: 0018:ffffc90000118f80 EFLAGS: 00010246
> [ 6191.671963] RAX: 0000000000000000 RBX: ffff888108d3d730 RCX: 0000000000000000
> [ 6191.671964] RDX: ffff888108d3d738 RSI: ffffffff82516284 RDI: ffff888108d3d730
> [ 6191.671965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> [ 6191.671965] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [ 6191.671966] R13: 0000000000000018 R14: ffffffff811d37e0 R15: 0000000000000000
> [ 6191.671967] FS:  00007fc6e83ea780(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
> [ 6191.671967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6191.671968] CR2: ffffffffffffffd6 CR3: 0000000106750005 CR4: 0000000000170ee0
> [ 6191.671968] Call Trace:
> [ 6191.671968]  <IRQ>
> [ 6191.671969]  ? show_trace_log_lvl+0x1c2/0x2c9
> [ 6191.671969]  ? irq_work_single+0x42/0x80
> [ 6191.671969]  ? __die_body.cold+0x8/0xd
> [ 6191.671970]  ? no_context+0x13a/0x270
> [ 6191.671970]  ? exc_page_fault+0x6f/0x200
> [ 6191.671970]  ? asm_exc_page_fault+0x1e/0x30
> [ 6191.671970]  ? handle_oob_irq+0x90/0x90
> [ 6191.671971]  irq_work_single+0x42/0x80
> [ 6191.671971]  irq_work_run_list+0x2d/0x40
> [ 6191.671971]  irq_work_run+0x26/0x40
> [ 6191.671972]  inband_work_interrupt+0xa/0x20
> [ 6191.671972]  handle_synthetic_irq+0xb1/0x210
> [ 6191.671972]  asm_call_irq_on_stack+0x12/0x20
> [ 6191.671973]  </IRQ>
> [ 6191.671973]  arch_do_IRQ_pipelined+0x15d/0x2a0
> [ 6191.671973]  sync_current_irq_stage+0x157/0x1f0
> [ 6191.671974]  __inband_irq_enable+0x4b/0x70
> [ 6191.671974]  _raw_spin_unlock_irqrestore+0x35/0x70
> [ 6191.671974]  __set_cpus_allowed_ptr+0xbf/0x230
> [ 6191.671975]  sched_setaffinity+0x383/0x6b0
> [ 6191.671975]  __x64_sys_sched_setaffinity+0x45/0x80
> [ 6191.671975]  do_syscall_64+0x39/0x50
> [ 6191.671978]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
> [ 6191.671979] RIP: 0033:0x7fc6e84d6617
> [ 6191.671979] Code: 1f 40 00 48 8b 15 79 c8 0e 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44 89 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00
> [ 6191.671980] RSP: 002b:00007ffd574dfde8 EFLAGS: 00000206 ORIG_RAX: 00000000000000cb
> [ 6191.671981] RAX: ffffffffffffffda RBX: 00007fc6e7b985c8 RCX: 00007fc6e84d6617
> [ 6191.671982] RDX: 00007fc6e7b985f0 RSI: 0000000000000080 RDI: 0000000000001b8d
> [ 6191.671982] RBP: 00007ffd574dfe70 R08: 00007fc6e83ea780 R09: 00000000ffffffff
> [ 6191.671983] R10: fffffffffffffdca R11: 0000000000000206 R12: 000055a818eb61c0
> [ 6191.671983] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 6191.671984] Modules linked in:
> [ 6191.671985] CR2: 0000000000000000
> 

Okay... that is "good" news - looking for some time slot to reproduce
and debug myself now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

