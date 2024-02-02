Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD51757D
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856602; cv=fail; b=k2/kIYBosn4h0SzQ/BWpCeuzM0yWsgVb+k4NIOoamXYpxzS5kyiWViEQWo9wUgM/1HmY/hielx4oazqNThLaLpWBYz4DQX6LXyNHZZiZtnVT3ZzyZADjWhdmRtDbCicAVlEETB8BYnqft8ksEgk7MDSQSDBqDnDbqemhIwYd7fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856602; c=relaxed/simple;
	bh=/fAliT8aTnqfVDbpCRpm5xEOZj/BvNFkCD+la7MIcBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DpCJSo3qZhrmkczrl4QLnitaUWhzla4GxrYSu7jcOrs4BOVCz6H5oOiw/T9pSVRWWMD4TY4tFyVoMcTy6c6i6AxkRpUx8+7sQRvWErd8gIi2eaMr/EXAEKHecC7p8a6d/0gQyOOEGXO7wah3uwd94pfmD4ef9cAx+N3UP4+EE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lw4tIlCz; arc=fail smtp.client-ip=40.107.15.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lw4tIlCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuLAKPmM0k6XaoDhqogqUPHuBaUMV99ex9LcuAc69FcMJfrQ9GOLmBC5HYq8wyroC1RezHM1jiSFh6DrCYAQ/BtgjBsi79U/CqoixYxq9U++H0Mq+FnZ3YT5FnPWNKK+e+Jp/J/mCtPzZLJLjlUV+ar3bxtxgG0lze2vfocivY4IyGzdXxkXKAeIbX4pHs6GXLt7kvzF1OLZEciRg8rfT5XOKFSoODcznsxKWvWq/3vTP/PavJlUsUjCIcgaMYXxPDReWO75ReyBgWMUEvR1IG/z8x0nMlDENZerXqbRbYxWLs37QQnFbaag0HPOgJFNFpB4oAWK6GtFWgvSo1yr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIl+hTwQE2U2rJ7wjVXmOOJmNw1HQE2j4E3oZqZDN08=;
 b=mZCaJqD8uwXgiIeJ57k89dibUm1/N8S4/IFhwUJ7X3oHuxgWLa83g4ZcOcjJZisreSB38+e/eNgLlC/IUQh8n8CWJ76gwGrq2FzPCoLFC87FkQDzrvrlMNvwrQHfsYs5vGbWXzrJj2rF4WRVRhwuHLtD1XsmpMdw0162lj7KoxC6Tmcs/eIqepm70AFxlsy5I7DaPMjnukWZkAxQzY30iuKOLYZiS+1sJAODrtq7QxhGL4AO/i2WqOoJ2ggmLrNcgcPjZe/YX8Ksjqv7WfXUmYT41lK1Cm9oQGqIsGB173mVa4WM04Bpqd5nlxBqe2wytcHMByTP8RBwrbAyMtvdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIl+hTwQE2U2rJ7wjVXmOOJmNw1HQE2j4E3oZqZDN08=;
 b=Lw4tIlCzTP4ZUg77r9YnE+U5Bc1S7SlUTJcLOQuOtdzUrmRjr3RZsD0/XgzpOsXA4LhfCt1F5tsg2lsdCKwWIECda7VutsTWbjlLif2CQKdbian1tbHpR/yGkJgR2dH8AUgfsLoH53cFO3Bt5IaLI/TgeKuIwEokwljgIu8aWo+jfIj9JklIvowi4HTcliaAoKTD+Nweql20M6GJFtUjC4KdY+q8atvOvRW5K4sfv0UDTsOazke7nZs1PrXnusW9PQmWp7CtP0J32V+1GrC9Nob2Nn16J8qk1NHRX/qoxjG96PLN88Eml7egmRK6EIM8FUZDilpIz4aosmPpHYG1EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 06:49:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 06:49:55 +0000
Message-ID: <fd2a3821-c4e6-4866-bc65-0bbadaf603e5@siemens.com>
Date: Fri, 2 Feb 2024 07:49:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: NX-protected page
Content-Language: en-US
To: JerryJun <jerryjun123@163.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
 <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
 <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
 <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a471e64-aff4-4b03-9534-08dc23bb2a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7YW+ewqwmIt5n2YsCSjxW0b3msCRr5KK0/RRGzz6f9OJMZSWo2CaddIHf6Tg3YCOkhZDPT643kmo8D6436QBxWnAd5bhzci43bH5upOzKOP3h8dfyWbb5C4x1kmxPYFF8WzRGb98EqDibkBFlMEJ07Z7Cz15vqpzIJocBsI5+gkDF8+1igyCxzfoxlvIB3QacjUsCdTs1EuS2XF2lX5kVnSXZ5i5bLn3EUE1dg6L3qrZ6e9P02YghLxV3UjNt6ZlQaZYYi4sI1/qZ3qpOmLsGVbLaprVj8fJ30aqPpnut4YcgLIXj6No6DJF9iZVShfs3FYtKK6UW0C/kwVbnTOSB1k0K7DhDUMfr7Hhfr9XAABIPHnjifb3nRUP4QUxCM+JLkz9l+yKqZmqcxEYWejdJ+TcQI4lUbgPFTX7hYO60KhfcuGwkeT3NYTnWtxhEYyVpwUwJYQh4nsO9rOOKYolV7IMaRCJ629RPAKSPSo0D49Z5y3cQimT9WcTy3yVcgeVAkuJgTKRjyb42Kg1njhno84YERc9i4fUZmRfmWjoCH8VvsbfJA+lpZ7zhNKERVfDNd27HpJRYbwi+tUCkTedann6qD/OlX6pjHWyTyJWVu6HtEEWSNd38uSrABVGIf4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(41300700001)(83380400001)(36756003)(82960400001)(26005)(31696002)(86362001)(8936002)(6512007)(2616005)(38100700002)(3480700007)(2906002)(316002)(53546011)(45080400002)(6486002)(4326008)(66946007)(66556008)(8676002)(44832011)(66476007)(478600001)(5660300002)(6916009)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTRrRXlxOU9WeWhaaElwMXJsR1ZTcE9pdUV6V0Q4OXg0TklHSTNNb2MvM25p?=
 =?utf-8?B?S1NzZTQvR1BTa1lkeDVUK3NMU1JiQ1VPYW8xZFZaMVp1VjhERzhxRUUxbnRp?=
 =?utf-8?B?ellrSktEMk5CcCt0T3ZZU2NqakR5V1pHRGROOTZwY3pIWlVYUk5RSUxqaTQw?=
 =?utf-8?B?cGFDU0Nhb20vc1VpSUJmTlY3ZGcrYkxIZ3B4Y0hoNnJTaksvckRXUXd1WG9X?=
 =?utf-8?B?NUR6TU1qeG5Qc1NLOTBCSHpqVFJzdWQwTVNid3MxODUvb2h0aTB2UmI1VWVn?=
 =?utf-8?B?b2Q0aUd2RkliOGg4cm5pbEFBTHpzS3BNVWRPZEJJL2MyWXVQUm5wRElrQ2dW?=
 =?utf-8?B?d1NIRG12UlRpK3Y3RXUzVkxvUllQS0VPd3JjenR6T0pMYU45a1hGcGhMaEgv?=
 =?utf-8?B?RmtLNDJzUU9BdjNwZFNaa2ZGRWNMb09sblNBSlhyNUJIOHJyRzl5eVdnYW1D?=
 =?utf-8?B?aGhERGFZWGczYXY3RVg2NVJpQ1N3UU1rSk5MU1R1UU5XK0w0OEVHcStEZ2Ew?=
 =?utf-8?B?eEUvZDR2aDlpY00wMnF0K2xFTjB1cjJOdmdhckpPVGV2OXdXclFtVFhJbnJa?=
 =?utf-8?B?L3ZESzZGZ1hnTGJPYjJadHlZa2s5dXdQYXd0Zk11R0dvdDh0K1RoL2w1VXpq?=
 =?utf-8?B?eTdVaVorbU9tSGFFNkxzbVgwenNHUDZGNWE5WHh2cUdwbjRLWkt1RGw3YlNP?=
 =?utf-8?B?UElNeEd5TG8yMi9RZHc4YktZb3BwUmdtZm1mTWF3U0htTlhWTmgvOVkxRlVy?=
 =?utf-8?B?WkhXMTBISXpMUUpSNHZRK0J5NFJhVDVXTDhGYTRIYW9iQXhtcVZnNTFVY09i?=
 =?utf-8?B?ZE5tWlEvcDNRbi9CbXQxSk1rckdtVmoySjYxK2g3ZXM4cVg5UFNrSGlTRDhz?=
 =?utf-8?B?ai9qSDlQYkN2Y2J5bGtabFhoQzRDZEQxUFllNXlFVkpzZDVzMTd2aXU0ZUFv?=
 =?utf-8?B?cm5QbTN2Skx1RGxUbXRHcS9sY3IvYTBIZG1XSENDdlZ1RWR3K2dSUG5DZmhr?=
 =?utf-8?B?S0R2cVB4d2k5ckgydmtHcW9OZWd6TlF2cFN5Z05IT1JobkNOM05jT2NvcTV6?=
 =?utf-8?B?SmUzYyt6VURpOXU5L3k0SkhYMFF6RnNnR0IzNjF0d3A3cWM0MzFraU8ycUlU?=
 =?utf-8?B?dmtTbER1TnVUaTRWVzVHNUUranc0bTFVeS9tS21JdVE1RStaY3J4Y042N2ZC?=
 =?utf-8?B?eGJaNFNzME9UR3lGUndrRm1OYmlEUWJnQVFKR0UyMDFFZ2FwYmV4aVdybHRW?=
 =?utf-8?B?UnpGWlg0anRkVkxiYXUyQldjamg3NEs4TXNSNk5ISG55emxiV1NiT2xUdXB6?=
 =?utf-8?B?c0hiMGg4M1FGbVFzY1VBTU5xcGVxTWs1eCtJYUR1aEZmVDRaMTVFZWtsbjgw?=
 =?utf-8?B?a0x2RXdZdTMraVlSb0xLWURoM0FNNE1oV2xENGRxcU9PT2RGaDJYNTBBeDhu?=
 =?utf-8?B?T2lSM2tLeG9kZmZBMW5ydzhqUnZHVDdkNlR1aUxNdG1vMlBjR2QwZjFhUHZT?=
 =?utf-8?B?UCsxd1pTc1ZxUGNYRTNZdTlrUWNTR0VETnBVUTNRL0huR1FwZXdpUUFtb2N5?=
 =?utf-8?B?dlhuT2xVZ1pVc1c0eXpseXlkb2VqcGl3RkdEUWVvaU9PTk9wSTNHQzJ2Z1lM?=
 =?utf-8?B?UW5ybWNhVG9pTWU4a1JRTHpHR1pRUk1UU1ZScE1LenNVZEdXYWpSbVpzcFlT?=
 =?utf-8?B?V3lEVUN6VnNsMGJ4QkRaUlRHcVkwUlJQYjEyVElFMFRuencyeTVuT1VyTGFB?=
 =?utf-8?B?L3NKRmZ6dEdZL25kZkMzV256WVhRY2JxMnNJd2szTUJRemZ0ejA5RjFGUE4r?=
 =?utf-8?B?Q1FNUzVLemFaR1RKUkVQUmpUK1VuQTIvMHVoMlEzZ2hhTFZrc0M3SFBIcyt5?=
 =?utf-8?B?RG1TY0pqUTR5U2lFMlRZbW1KWE5LRU12NUNmUy9lSFIyWDU0TE12dzV3emNz?=
 =?utf-8?B?M0x1MGVaQzZueFhWN2wvRkVVR1V1dDBIMkdrZG1nd250WjllMkw5b2tZTGh2?=
 =?utf-8?B?dC9Ed1NrZi9zUWpRcEZxQkQyeTVaOTk2Wm0xRHprVmw3TU9kN3ZlUGxQa3dr?=
 =?utf-8?B?K29NenlwSHFYamp1UDN2MzVVa2RQTGpHTVhVWXZ5MFRkV3VsaWlDVDF6RGVq?=
 =?utf-8?B?YTJoTXE2NUxjS291SCtFZ2I3cTV0N3YrMDVOc3dEdFRDd1M1Z1pUKzl2MHQ3?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a471e64-aff4-4b03-9534-08dc23bb2a51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:49:55.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaKCbv9LVZKHjx9NvlXoxJy8rfsk7VjGNS3mau7pqu70cP0YZVFnKeiSWXQtEYMUjzDKjcqWOUGKywtX8nWRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381

On 01.02.24 08:09, Jan Kiszka wrote:
> On 31.01.24 08:25, JerryJun wrote:
>> yet， you just do make in the project to product the binary of oop-test, run kill_test.sh , and finally wait kernel oop .
>> we get the same results of kernel oop in the qemu-amd64, which use the config from xenomai-images ,"https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads", as follow.
>> [ 6191.671953] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [ 6191.671955] #PF: supervisor instruction fetch in kernel mode
>> [ 6191.671956] #PF: error_code(0x0010) - not-present page
>> [ 6191.671956] PGD 0 P4D 0
>> [ 6191.671958] Oops: 0010 [#1] PREEMPT SMP PTI IRQ_PIPELINE
>> [ 6191.671959] CPU: 3 PID: 7047 Comm: oop-test Kdump: loaded Not tainted 5.10.199-devo-3.2.4-20240130 #1
>> [ 6191.671960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>> [ 6191.671961] IRQ stage: Linux
>> [ 6191.671961] RIP: 0010:0x0
>> [ 6191.671962] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>> [ 6191.671962] RSP: 0018:ffffc90000118f80 EFLAGS: 00010246
>> [ 6191.671963] RAX: 0000000000000000 RBX: ffff888108d3d730 RCX: 0000000000000000
>> [ 6191.671964] RDX: ffff888108d3d738 RSI: ffffffff82516284 RDI: ffff888108d3d730
>> [ 6191.671965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
>> [ 6191.671965] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>> [ 6191.671966] R13: 0000000000000018 R14: ffffffff811d37e0 R15: 0000000000000000
>> [ 6191.671967] FS:  00007fc6e83ea780(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
>> [ 6191.671967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 6191.671968] CR2: ffffffffffffffd6 CR3: 0000000106750005 CR4: 0000000000170ee0
>> [ 6191.671968] Call Trace:
>> [ 6191.671968]  <IRQ>
>> [ 6191.671969]  ? show_trace_log_lvl+0x1c2/0x2c9
>> [ 6191.671969]  ? irq_work_single+0x42/0x80
>> [ 6191.671969]  ? __die_body.cold+0x8/0xd
>> [ 6191.671970]  ? no_context+0x13a/0x270
>> [ 6191.671970]  ? exc_page_fault+0x6f/0x200
>> [ 6191.671970]  ? asm_exc_page_fault+0x1e/0x30
>> [ 6191.671970]  ? handle_oob_irq+0x90/0x90
>> [ 6191.671971]  irq_work_single+0x42/0x80
>> [ 6191.671971]  irq_work_run_list+0x2d/0x40
>> [ 6191.671971]  irq_work_run+0x26/0x40
>> [ 6191.671972]  inband_work_interrupt+0xa/0x20
>> [ 6191.671972]  handle_synthetic_irq+0xb1/0x210
>> [ 6191.671972]  asm_call_irq_on_stack+0x12/0x20
>> [ 6191.671973]  </IRQ>
>> [ 6191.671973]  arch_do_IRQ_pipelined+0x15d/0x2a0
>> [ 6191.671973]  sync_current_irq_stage+0x157/0x1f0
>> [ 6191.671974]  __inband_irq_enable+0x4b/0x70
>> [ 6191.671974]  _raw_spin_unlock_irqrestore+0x35/0x70
>> [ 6191.671974]  __set_cpus_allowed_ptr+0xbf/0x230
>> [ 6191.671975]  sched_setaffinity+0x383/0x6b0
>> [ 6191.671975]  __x64_sys_sched_setaffinity+0x45/0x80
>> [ 6191.671975]  do_syscall_64+0x39/0x50
>> [ 6191.671978]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>> [ 6191.671979] RIP: 0033:0x7fc6e84d6617
>> [ 6191.671979] Code: 1f 40 00 48 8b 15 79 c8 0e 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44 89 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00
>> [ 6191.671980] RSP: 002b:00007ffd574dfde8 EFLAGS: 00000206 ORIG_RAX: 00000000000000cb
>> [ 6191.671981] RAX: ffffffffffffffda RBX: 00007fc6e7b985c8 RCX: 00007fc6e84d6617
>> [ 6191.671982] RDX: 00007fc6e7b985f0 RSI: 0000000000000080 RDI: 0000000000001b8d
>> [ 6191.671982] RBP: 00007ffd574dfe70 R08: 00007fc6e83ea780 R09: 00000000ffffffff
>> [ 6191.671983] R10: fffffffffffffdca R11: 0000000000000206 R12: 000055a818eb61c0
>> [ 6191.671983] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [ 6191.671984] Modules linked in:
>> [ 6191.671985] CR2: 0000000000000000
>>
> 
> Okay... that is "good" news - looking for some time slot to reproduce
> and debug myself now.
> 

I've tried to reproduce, using the .config.yaml below for
xenomai-images, but it does not trigger here. Do I need to run this for
hours? What exactly did you do to trigger it in the qemu image of
xenomai-images?

BTW, I assume the access of /proc/xenomai/sched/stat plays an important
role in causing the crash, right? You don't get it without them?

Jan

#
# Automatically generated by kas 4.2
#
_source_dir: /repo
build_system: isar
header:
  includes:
  - kas.yml
  - board-qemu-amd64.yml
  - opt-linux-latest-5.10.yml
  version: 16
menu_configuration:
  DEBUG: false
  KERNEL_4_19: false
  KERNEL_4_19_LATEST: false
  KERNEL_5_10: false
  KERNEL_5_10_LATEST: true
  KERNEL_5_15: false
  KERNEL_5_15_LATEST: false
  KERNEL_5_4: false
  KERNEL_5_4_LATEST: false
  KERNEL_6_1: false
  KERNEL_6_1_LATEST: false
  TARGET_BBB: false
  TARGET_HIKEY: false
  TARGET_QEMU_AMD64: true
  TARGET_QEMU_ARM: false
  TARGET_QEMU_ARM64: false
  TARGET_X86_64_EFI: false
  XENOMAI3: true
  XENOMAI4: false
  XENOMAI_3_0_LATEST: false
  XENOMAI_3_1_LATEST: false
  XENOMAI_3_2: true
  XENOMAI_3_2_LATEST: false
  XENOMAI_LATEST: false

-- 
Siemens AG, Technology
Linux Expert Center

