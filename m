Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EADDD4
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 09:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3l/0yJzlW+uYtHo++It+dGLOW//SXiN9giOanZZEomvy4jqNCjWFKbFHeLZUm60iL1d2b8B2dLjTcHV35fxizUVzjdZS9IfITIunh7Oxi1Nb8VQZuLLbo3+7O9gL3PXX3gRW7JVhdkoZvPJLWU7PVWujLR1KaUo0CV4DSD91ts5Mtoez85nOG7LX8h7aKoP+Q19YS7m/V+gnQVji/A3td93kuWO/6JSEIaVS/t+IiMimE/LKLg5XjfQYRKMWd9/gK+VReJHv2BTRDbONsIh8/3DaG8jLHRdGTOh3epw6feVLOYBXlO8M7o0nEPTD28tyS6FItfJVuaOHXCCHB/34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zduMeMDPF+TafwEVKywRWVHAh6Zy+/J9tokzhsbKS4=;
 b=fP1n0EMAgNAl8kVQnutluCwWuMiPWCjJ8Q5AbEZrkIO6/mpX/eRy6z4HK2LKvZfo7Ibv8s9naWD3a/3wTxsVBZqLItWtpKGGwD4RsUfc1bRf7MBedlzDwsW/wUvOAkOyqRzKQdsq3rtRRvLx0F4GEw2oDfE+zu361SVoF7DWShkqh6TRYIcxE+7xAA4ykdxyo4D9uyA9bBdqWUFOwxCiTt8PPTXluJKiJLN7bq1DKO0ajGcLkCDYLsrsMZ4HUqUZ44XYstjytcrhusqqn7LX2lP4edQIei0tKbGJjmBQDVoIS8txgWFkGaCBvVNymZRc4UFbXpnYg0Vq1FihI7DWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zduMeMDPF+TafwEVKywRWVHAh6Zy+/J9tokzhsbKS4=;
 b=MlSTxrS0oi2A5RNhYmUKZhtHEREspHG9BUsr4/bNYcMlRywMQHeJ9nqNgrme6ccQgsMmEk24FXMQTd57aFDbairZzp2inAwArmFav25/dWolVq3M+EsE7x9dW2sj8I5JCVG+QXrl0XIlHwGonInVgddZnPYQnIGNNMZ6X86+HG4atBYMeGs/T+dDXdj7JXMeEBP25AxIZmOiryuluOp6aF5r2dHvLjkPNHiCQwh3mdlXY2/qIb1Gosw4rk46fxuQj2xdcNqTV2db3ExqJ+Z6yTJORYA0wt26plEhYP0nMQFc/0JibEFoFletr13PPFcOOBiXKm6XOxaFtEfAhxU0ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Sat, 23 Sep
 2023 09:52:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 09:52:45 +0000
Message-ID: <ccad0daf-6430-415d-8322-f17ac7166ea9@siemens.com>
Date: Sat, 23 Sep 2023 11:52:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/registery: Flush only registry_proc_work on cleanup
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: de43b6e8-1e16-41ab-75dc-08dbbc1ad68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UnhaQdL0YIHIrEC5yO7d9qhV5FPkJ9yU5FOZm7Inyv2+c7FziVH9lxQLem0FTiETNlv44PwLnoEIUVjsq/f+EO3GaBo9xxkWDi0OQWTwvf/gxAnaBOZvRrGHy0TaJqcYeEyzYAzy9Yj9NU1U4eqjVUT5eFU8fJ7J0AhYk4gvickZ9O/eLNjqp8WIzKdIg1Jp/WJZ86wvSvLRHzqaE2aEyiU3xokppG7l5qQoECFGZdzKWotsd/TUNP5iNn64KJ554rJA8KvcerCwHsuWUk98zyR9DWu+1I86qAMv2iQdJ2Hkv+xuy0vq6UfpgVebw1nUZ8Tq47LgJQoHLkcw2qJ1loFA40ubZ5hsOApt7MizFyT0cezLRx0EQh6XQEJkrlFryOqcSf1Bjj4qDPDL/BdHigpQqvoL3le4lBsWNWeaUyp2jzZrzX7w2GpP+66YJPbgc/3up71RUalVMXroH/AWDcutcnng3GHpKEt5E3XUwUJDkqLQpoWIwHWIiNtpxMvx0e2dnGPX1QqzU90Iv6d43qg8PJl2f8dU7P5TGSpMe5B8jyyarckro/eexk4OrDwEGrffls9AjuivNvQCRnrCqHEsK2ADBLiEeeT5gUSGK1w7OeT1Ny33Uemd5JSYj7hNxH9mknNWIFKaelAp0bGq0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(26005)(6486002)(478600001)(41300700001)(6916009)(66476007)(316002)(6506007)(66946007)(66556008)(82960400001)(2616005)(38100700002)(6512007)(86362001)(44832011)(8676002)(4744005)(2906002)(31696002)(83380400001)(5660300002)(4326008)(8936002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZMOHRtamp4Y1IrVm9BOVlydklyVXVBZ0dQcUgwRWRDWDhIK1Qrem9rZDBj?=
 =?utf-8?B?UUo0T0lzaEErRExkVStXVXptcGZIV0RESGlaTVo2eXJPb2NraGFUdjBaeHAw?=
 =?utf-8?B?aTJzamNIRjZqRmdPajFOWit1Y3Irc3ZMTEprYVRLdUp4ZDdCeGZRcTZKQW50?=
 =?utf-8?B?OS8reE5hRk5KYzBGRk1UZ2lpRG1uMy9BelM0WFBtd01nWlFzTjlZdnpGejZL?=
 =?utf-8?B?VVBJMm9xTnBDcmQrZ1VvaUxyZ0tlMHlaemZsWERJMDYzUU5hWkNtd3R1WlZk?=
 =?utf-8?B?cWN6V2FzaExraUpuUkFGU1JYRzVaQjg1enBSL3BjWmRTR3JEWXFGYkZIcHov?=
 =?utf-8?B?MDhJTlVmbFUwZjBJSmlCRWQ3VkdGNjltTlRSOEdBa2tWZFE5VDRyTEljSWd1?=
 =?utf-8?B?d0thaTVVMHJTb2xNV2x3UGsxTVU4WjJnRENKREtMYnNNUElZU0phTU9BSEdL?=
 =?utf-8?B?dzRIeFY0ekJwNDVYNVVaY3g2VVpPMDdBZDR6ck5NcEtLVHdyc1B5dTRjMFZ6?=
 =?utf-8?B?V2tFYThkTE52bUJqQTVYUlBNTCtIQ3JSeGdKVnN3RnRTb2JIdnQ4UlZWWWpK?=
 =?utf-8?B?UVVkUlVFUUQ1RUZuWngyU0k4dG1NZkNiL1ExZUdWb283SXFPbzY2TytzYndp?=
 =?utf-8?B?RWtlaG0yNzhvM3lnL05kUnVIOVRZY2MxRWNaaWpuNDJSN2E1U1VBYnM5UzQr?=
 =?utf-8?B?Q09sZEgxS1BteEFSaHZYNUgvVTBKRDF5cW1sNGdxWHM4bHJzZlV3YU81cENB?=
 =?utf-8?B?cHZZZGQzenVIOG5CaDR2dUlpQ201SEswUjV6QitkNEc5bWZsc0kwdnRERjI0?=
 =?utf-8?B?VlpHOGxEQmpQS09tZENLTmxPOG9GWDY0NSsyZkpneW9NQ2NiaU5FUU9oaTJG?=
 =?utf-8?B?N3NXWGkwY2JKVUhlUmNFQ29xWUpXNzltUGhXVmJ5ZzdvTHlqOW1kemtMLytL?=
 =?utf-8?B?WDgvSGh3aEpBc0RuS2ZKMEJTVEpaSS8xc2s1VUhLL2RHTVRaQUluRWhDQm91?=
 =?utf-8?B?djlrbGptT0VqdUp0M0FhQlgrNllIQ1NDeXNYbWZaSEZKUkw2NnpEK2VyVGk2?=
 =?utf-8?B?alROZ0x1U3R3OWdnUlY0SngxMUorMkUwY2w0TU5Fb3hoTEhNc0FOM0QrUXhn?=
 =?utf-8?B?UW1NcFVadGRPdUtGUTJiSGExOWxuQmFkVXJ4OWhrL1NZQ1JUbWJEbTNsakR2?=
 =?utf-8?B?enpQUmlZTnk1d0Qzb2ZJRE9qTDVlUVJjQkNoSlNLT2hqZlA4RFVwbFVDNHp0?=
 =?utf-8?B?UVA1UitVcWs0SkVid000OWRNOVVoQ3pHOFo3SVkrU0ZsOEhXV2cyWUtlMWtI?=
 =?utf-8?B?RXJIeU5DZk5yRmRlUC9JZkc5cE0yNjludWxDeGpWeDNRMjB0T094dEx5TVpP?=
 =?utf-8?B?eFA1M2U0ZU93SDR2cWJGMzcxRTFkMm9aNHREaDh1c05KbEt6UkdoQ0kreVNh?=
 =?utf-8?B?L0lhdzV0OTRHMEkrZlZXTG5lQThPazJTcFRsUGlDT1VOSG1ZM2Z3VGpMSmc5?=
 =?utf-8?B?ME93OXFoUCtYZ0Qwc2V1RHZuRmsvclVwWUVNMjBwSUcrS25NZVhsQmRsTnZH?=
 =?utf-8?B?NC82azNSWTNBSEQzVC9qTHBNQWRuZTZSeUZzWkVRdVJhYVFwR0RMbkRCbFN6?=
 =?utf-8?B?R05FZkxYY3hJZ21LNjcreEc2cXBYTHZtV3c1V09QQldnRjFyV0R0c1hKbElX?=
 =?utf-8?B?Q01TS1VsYmpEUnBPbXI5bHRTTXVqMk0zWUI5NzB6SkltSTVla0xxOEhXNS9T?=
 =?utf-8?B?MGptdG9BMmVKU3p6em9YVEs1M1M4N0kyZ0d1V0hpMGVraXpaVEczNk41dStG?=
 =?utf-8?B?SVBaSUVNSVlkT09RVmtQSG1EcW80cUtXRk9MOWlpNklQU3JvcUJSS2d3VGxP?=
 =?utf-8?B?cHJqZHdBM1MyOFgyeHpTUjRYSGZDSEo3RGlwOFcxeDdQQyszRS9IQWhseC8x?=
 =?utf-8?B?TWFEeTBZc0FDR2FORGRRMzVxYVZQa3Nxd1N4R1ZDdHpWMFBGMHFTV0gxMVAr?=
 =?utf-8?B?bmppNlpXZS9HSHZENkJGS2VYNUNFZThwUjQ4emJja3pSQmgzYVErRzlGMEFh?=
 =?utf-8?B?YWhFLzZSb0NRUXZYMXlURmRCYzhTaTBCcklXeE40a2JPcXE3TnFYZUpVWUNO?=
 =?utf-8?B?YnRhbW14TDFDZnhKRG9sQy83VWpHNzMyWFg1dTdyVllGc052MWNEcWhUTmtq?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de43b6e8-1e16-41ab-75dc-08dbbc1ad68a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 09:52:45.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxp3/JUwcRpYRKyK2DNDPQbo8pY6qywq2V0MKf4jw0gZlwxd9ewqLaW284FUYM0FyS0I6jv/yqbLVz9xLksD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7692

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest kernels warn when using untargeted flush_scheduled_work,
rightfully. We can limit the flush to registry_proc_work.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/registry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 02f4ebbbae..3e4bfc4605 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -174,7 +174,7 @@ void xnregistry_cleanup(void)
 	struct xnpnode *pnode;
 	int n;
 
-	flush_scheduled_work();
+	flush_work(&registry_proc_work);
 
 	for (n = 0; n < nr_object_entries; n++)
 		hlist_for_each_entry_safe(ecurr, enext, 
@@ -200,7 +200,7 @@ void xnregistry_cleanup(void)
 
 #ifdef CONFIG_XENO_OPT_VFILE
 	pipeline_delete_inband_sirq(proc_virq);
-	flush_scheduled_work();
+	flush_work(&registry_proc_work);
 	xnvfile_destroy_regular(&usage_vfile);
 	xnvfile_destroy_dir(&registry_vfroot);
 #endif /* CONFIG_XENO_OPT_VFILE */
-- 
2.35.3
