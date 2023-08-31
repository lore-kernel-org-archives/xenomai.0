Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66918182DB
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 17:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVWxh9eLrzc8SHD4nNujasAWFl9fKGz7uNaFEMy32F3zJcRorih19ED6gjwNM0+ktQ/bi0pZcUcDc8ASk/HuUey1tpgQmysPZvxGWhgnGeo6hQrfD5BUiYIQRAvxCJFDTxQehXJOI++i9czk9p4aDyX/Qx1NajZNoKkfK5/nmDu4eELSApPy83e4ZzZ9mxT+6ro6Y4CQuwkmx+znCpfbfOcVbYmSubKrqirbRqyaPCoY05M4OUvuE4FZTRrFGnqa+9fiSm8zGOmlvCbmFyxoIECu7GR5R7AGQDJm1B+mjtpGe5thjUlsohJ56PWCPFIx8qV2Pm+7PrHCkgIWeXvW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJVI2UrxxJ+L/v1rkaU+cwu7ywX45lyErin8AbZqx+c=;
 b=GMKbJsw4bTF1+xzyfIqDSTrQ0NPST4S0KIDLki5/VdriPeePJkqxkxK973XJEVnR6zzHKZ/USU4iUmEnXyshe3V/Y5odHPZZDu/auzYE56ak0x6Xdj0RVYAJd40JMSa2AcaXm1gzPkX5nGCeC1uT+ApQLDilIjgsmF6bM9J5W013gANALd/ngYRex/rY22b+De4VQiqnniKwe1ZOZPZNKiAq8bW4oiqFfLtFdk86D+/0zJY/vwn5JCx9ZNyPl3NR8MJG4AnA8HgoXH0TQp21m7MJJ2HBtYfUebbOc30ZUUh6q0jg0Fa0kQiNqfelrM+G7wgUR+0daDVv0iWbd0sRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJVI2UrxxJ+L/v1rkaU+cwu7ywX45lyErin8AbZqx+c=;
 b=d3cgE3fJyQcGaa65tCIKyvGJ/0j8EUkQKZWRx7GjF9iiM+VJDrkbEnGTqDcZPnmO+6VE+l4pUPAQLs1xmv6x1KYXD5AkF8aoKsGddr579WqzCqM1LNkhR2IvjickvdXW33crZ35fWOT4eufgPN26z2ra6IV7OmcexaZeAk3vQl/EQj2OpDTrTXiZjuS8MKqcVjHyXfKmFs4iHK5JBk31pA4ByCNQ3jrGWFNouKxiFL9NcxXNi5Moyh6fssk4NDBBeMjekhoyy0mHcLHDm4g0R6qADRbcYoP8B++hqtt/tmHc0NEd5HyOVKZdYVFZgXcgIx6TttKVFvNPdTDS68u7OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 17:02:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 17:02:38 +0000
Message-ID: <22ffd839-af5c-48f0-a3c8-136be591302d@siemens.com>
Date: Thu, 31 Aug 2023 19:02:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: ipipe: Protect ARCH_SET_GS and ARCH_SET_FS sections
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>,
 "Heber, Stefan" <Stefan.Heber@zwickroell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b0e698-6a31-4bed-7b4e-08dbaa44140d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uyl9SVvYCpKr2gPxD5J+Ec5TubgJZQqhdmft+6PaO+2XqdZMtq2bqMzFsldFbdVFPdBksD7RhOGkKo809gUOp0poBFtRkop0+mXj5bELfMKxTY0NOBnZsytnwu9t4FXv2byx/qXO8xVWdXtg0NrzcrTh7yBbr0yvU2NeIJhK8XxRUv39vM6S0/CG0Co1eVObMaeBBRSiNz7IunPoYB/g+3g7ZYXMmiq0vUHdXURwjdFcCXfdeSZiIRFI4ZDv1VcM/Q0H5LsdLcMnB+kGLX3KsBccDLmvdDFez3+J/whHexpdEKVEPzGITqvx+PEimAGfkTdqlcfOOzYtu/4eBywJiz+sjHE6MhJ8Vv7irhmatU/G9/mnteGed48CPpelcySeAp7oU1mBJRwr5swcY52qaat5oAXjSLjPbCYtPpR5BbYdsCx7F3m0xlVB4GI2AEeiimsFjAqr93/z/cMjTJ9tC5dQ3hhuOV3SEUcmBvCwmBFMBuom5jTCIvwlIobM6m9pjK6J2lnv7lLRnMcLNUHWbv7vRCJoWvDLWwDmqt8G32+VnQRFtgyRSPuUVAxqWz6WxspnbSd1qPQ0bzfC8XiiXviEf23TaKriiajBqzdnlAmQF1DH1SOIlBBVXtASoZh87zc/lnvCsWpCUFIVPDGrlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(186009)(1800799009)(451199024)(110136005)(83380400001)(82960400001)(316002)(66946007)(66476007)(66556008)(478600001)(38100700002)(2906002)(8936002)(41300700001)(86362001)(8676002)(31696002)(44832011)(5660300002)(26005)(6666004)(6512007)(6486002)(2616005)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFhWcHdkTGRtemE4Y1lvSjM5YkM1TlZDd1NrQndYY0VlQzlxbjhGZzJQNWls?=
 =?utf-8?B?TVVaemp4ZFd3ZW1mZkhZVmpPSmdvOGxtOWVZbHN0b2V2TFZJdXBtaUJQcHBG?=
 =?utf-8?B?dVRKZzNPdEFKeklLM1Fmbm5HdkNwVHlHay9PSnN6MGg4Wmw3c0FMVXRmK0hF?=
 =?utf-8?B?aUYyVW5JdUp5MWlndkZnVitLdFVqOVphWE9CNncxTkdTWU13VUhmTlkrN3F0?=
 =?utf-8?B?WllZSlVRdWN3c0Nnd29wSVJmUDh1aHQ2VWl5eUlrblNhWURNcjcvQ21EL0tz?=
 =?utf-8?B?cTZ4TEhRdjcwQjRJYk4wdjVJMWlOSU44NnRoYVN0dG1IcUhjZHFReEkxNXhk?=
 =?utf-8?B?NkJBaXRYbTBhUkZDRWF2TXJlNmdwTTdub0tQZjhzenF0cENwYmg0L3NqaFhM?=
 =?utf-8?B?T3VraUpOSGwxL1BRWXNnb01wR05vUlV1cnlPNHI4bDIwN0RzZFpRQ1ZjeFJ5?=
 =?utf-8?B?ODJIaWdkUlRXcEhVVXk1OTBYT0NKWURrY2dJTzhmdTd0YXdQTmhNTm00Q09E?=
 =?utf-8?B?a3gyS2tVZTFKckIvZkkzUDN2K1JpUGpXWmRXL3Y0Qy9WSE9uVUFkd0RjUlE2?=
 =?utf-8?B?c0lXMDlKc2l2aTE0RE8yekdpbnlYNjQ5Y0Nqb1c2OXU0T2dPUUZ0d2ZKQUl0?=
 =?utf-8?B?eU55OVBOMkNsQVRhTnhtV0pCLzJaVUE5WTY3VzJJOTdEN1FscXFVcStDOTJH?=
 =?utf-8?B?aG1NWHF5K0FiTlhhb2FxRmJVV3NRTmhtMFRsbEFxb0FiT2NhSkdYQUNXbFlV?=
 =?utf-8?B?TmlsdjdxdVExWE1TYnNyZW9aTktvWEFNK253OE4xd2RhZ2EraXJsc3dUUENC?=
 =?utf-8?B?NlJUWGhyT1d3RG45RjN5bkg3TVdwWmp4T2FpbTlOdzRONzVVRjg2b1hwVWFS?=
 =?utf-8?B?Z1hLeUZoakdKK2w4UDkzZHNXcjUwdkFla2l4WWVEd3NCMXFVQjM5eng3SGo0?=
 =?utf-8?B?cnNMSWNLZnFuUnk2aDNFa2g3aDdUVlVUZDRMQ3VlQk9sRVZVLysrMEc4SXVG?=
 =?utf-8?B?bUl0cEE3Ty92SGpLdUk1ak42SUdvSjFIVTdhYjlSNERKMVpyOTRYNjhFeVBB?=
 =?utf-8?B?ZGNoL2lieTJmZWpwTnRVTStqNG03U3ZDUlppNGRqTC9MekVoWTVVc09ub2Ix?=
 =?utf-8?B?UjJ2OUZRdDhzaEpXNStLak1MOWVzTVU5SFdzN3Y1ZWJPUk1CUU1Oa2t0ZnJN?=
 =?utf-8?B?RE1Vd1B4WU5LTWhjRTR0ZkJ5TUJ1aUZCRzdMcTdqaGZhaTdMd2RGbzJvV3Fm?=
 =?utf-8?B?eUxzcW9WK2FiMFBPS2ZDRjBSSlJoZzBXSm5EaDh1dXBybTJ4VTVJeGdhamc1?=
 =?utf-8?B?blY0OFdCQUxjMGk0ZURrWGtpSmJuKzVoVjNiTU9HTURydG4va29OOTZYSjFn?=
 =?utf-8?B?aEd1TzFiY0NjS3c2VExRRnRZL0wxaEJ3N2xUNDVvMXZXSWxkWGl1dG84NXY4?=
 =?utf-8?B?bmNrTDVpa0VtT3ZTVUVQalZVVHRaaFZTNEZSeUpaYXEvRFo4T3djY2dQaHFy?=
 =?utf-8?B?UlRxb3JsOGZHS2FOQkhhZFdWc2FOd0liWDhWbFZsUG8wK0drNEd6M1FtcjJq?=
 =?utf-8?B?VlFZVkdVR21CQ1lpRTdLZXZCV3YvcnhxRzhmREVlem96S1ZWMVBHYWl1Uktr?=
 =?utf-8?B?WmMxUDJ4eW1SeGQ3SVFqUm5xQkRRS1ozanVBZ0xYcUtnd1RkNGxuRk1wNjNC?=
 =?utf-8?B?Q3JQM2ZEbGJqNzBBQk1rWmgvWDFiVVRNTVBZOUFoY3gzUlZOZEZEQ0JmSGlT?=
 =?utf-8?B?bjVBSXgrNWZaOFY5QnRlY2JsK1BCTjd3bk51VDg0QjJLNTg0SC9rbG9FZ2hj?=
 =?utf-8?B?VnU1SFA4ODJTdW5NSEZGeVNLQVZGVlFlRUV6OW03RDBBczVVanZYMkZ4UDJQ?=
 =?utf-8?B?RkpQRG5vN3RjdWNtNlNLYVRPaE5nUW9sOHZVNTJtS0RIcUl2aUpQNXNKYVZJ?=
 =?utf-8?B?QXcvZnVkcTRkSXVENCtXUVdSNE0zUjFyNzgvdHpZb0hFMmFwTmlPbXIrTnh0?=
 =?utf-8?B?akppUUtVdHlueFNoN1grVTIybkhFS0NhY0p3bnpHNUUwcU5DNE15dHFEK0Zy?=
 =?utf-8?B?em9VeVUxbVBLdzdGTmphYm9CbmhKYm41eEU5Sy9LWlNKSFIrUi9jV1EzelB4?=
 =?utf-8?B?MytFUmRUVGllZUliZkFtQkYrVytxVUdYUDl4LzRBL3dwVVQvNm15THFuMmhF?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b0e698-6a31-4bed-7b4e-08dbaa44140d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:02:37.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ao9pE95d4Xr1+GuQdfwyJSUjalPAs6CDHCSlzSZvP0txKfBqMoMkBq/HoVDPysjJZEFcVdUKH0IvSEjEtcyw3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5834

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to make the update of the register and its task-specific cache
atomic, or the head stage can preempt and restore the wrong state on
return. Caused crashes of Linux applications during their startup if the
race condition was met.

Reported-by: Stefan Heber <Stefan.Heber@zwickroell.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Stefan, please confirm. I'll release a new x86 ipipe version for 5.4 if 
this solves the problem (it did for me).

 arch/x86/kernel/process_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e3022e7820015..207a27ad07182 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -700,6 +700,7 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
+	unsigned long flags;
 	int ret = 0;
 
 	switch (option) {
@@ -707,7 +708,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		if (unlikely(arg2 >= TASK_SIZE_MAX))
 			return -EPERM;
 
-		preempt_disable();
+		flags = hard_preempt_disable();
 		/*
 		 * ARCH_SET_GS has always overwritten the index
 		 * and the base. Zero is the most sensible value
@@ -728,7 +729,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			task->thread.gsindex = 0;
 			x86_gsbase_write_task(task, arg2);
 		}
-		preempt_enable();
+		hard_preempt_enable(flags);
 		break;
 	}
 	case ARCH_SET_FS: {
@@ -739,7 +740,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		if (unlikely(arg2 >= TASK_SIZE_MAX))
 			return -EPERM;
 
-		preempt_disable();
+		flags = hard_preempt_disable();
 		/*
 		 * Set the selector to 0 for the same reason
 		 * as %gs above.
@@ -757,7 +758,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			task->thread.fsindex = 0;
 			x86_fsbase_write_task(task, arg2);
 		}
-		preempt_enable();
+		hard_preempt_enable(flags);
 		break;
 	}
 	case ARCH_GET_FS: {
-- 
2.35.3
