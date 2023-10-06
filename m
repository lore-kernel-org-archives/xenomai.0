Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817B30FA0
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W9NWsJjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY6R/SsyWLXkASNV3GvrrwzX8elyDqpHecqCSmlr1hfXpo8aKLoYNNQJ5JJeAkZVBnXgxAKphBxd8Avdkbje7el7vtYJIFeHlv4jB+G6swXUy0qcRnNV8CkLwsf6PkK1GGqI/kDkjjpCRuiwAtuyh3ToE+MMrdT1DTo+1uYPKURLkHEpxdz+3UYcGnjZ524qAS5kPrySQohTx+JkwJbtyXW+9A+00/WD1e75rx/OT2HFatXVEbZevV6bstte+/aVIIgCx3hRw5son+OhGR++bEX0SlS4CE8gPsZH+LtulY3RBfiyXlN4TaqB+TKNbzGYDNgC9qMcPUBOWnP33OziUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aS3+ZfREcuuLZmIqs6YLo0/zcKC/umgKxtpKwF0FuI=;
 b=NkNRT14dSuDs5OwSAC9iyxTCxK+SGqcO13qIff+DKB7R2EzLuxnhLOX9PmJidr4TfFeee+52Wk0cUE0Xtomo2Fr8TrdS1YT/Ld/pt/COK9bibltg/PrI+OrcbFEJbg2WHPhp0rPY9SZcdxwBQ0H0l8dFPHhdng+Ro6+J6fkpXdHmWJIhehtn5uqbXdfDq0KLLUWXZ2/KdD0X2qgHxzcF/0tNj7FSfeWbnKALYrAdv+3pCSBmELOVtxyb8R8sbSll/pJQ9NpcgaAnslybLyEOwTFLNqcUH7cJ1qNxE0e7PAfR+9iezz41DaasffwxRs0uafcfWCKIYxEl70iHMyga6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aS3+ZfREcuuLZmIqs6YLo0/zcKC/umgKxtpKwF0FuI=;
 b=W9NWsJjgGozuI1aPDwBfZXDMpLnhrg08ouajSS2FMhKUu3+hiENxFk4EqSAcDx7Re8VbJOoa/AePilXpZWIq3RV3h9WotjP81Xjc4nFgdFYGoCUpFcPK7a2VfeZU/T1r1CdzAlN0GBiXI9Kt5IRazIIMxlBf8FSnp+eJN38MDJdDBQ9DAC7v2jh7+Ofx2ljF6gwi9n9n5ScErCZCgZkJhi2krrQQMr/k8/Bap+Ouil/owpJiyuOwuTpFQoVY8K65WAG8dlPEyt1Qw1wTzpQBoV7VRqZfrgpete+qaDiyomAsgJUttuOxeVaToNthX6ASilphPr1X7Yh+gCzKTlSbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 19:27:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 19:27:13 +0000
Message-ID: <f03d5cd1-6702-40d7-81dd-436946215e51@siemens.com>
Date: Fri, 6 Oct 2023 21:27:11 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/net/experimental/e1000: Fix gcc-12 findings
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd54065-e3fd-4625-7901-08dbc6a23e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZmISKlT89ZqH8qPequDdS6pwEoWNX0QcLJewL/kyv1uTKHqULHTl44SPCLmS+iYltNJ1Qd0cRuDVEilMGN6QTVMEp9A4VyrStwDU/1gIrKpZkRPSrTtImnI15cYXUYHDIdV9UhL4Uq8fKhgP1IQu1AS53pvHs/+JqNkok/hrk4y6fDz+74zticIxrUP1K9Jk/8uWAXidLdVVe9ndEAiZFHY3BCOzDYbrtMMMprx86B/vagtaxObpOL7VUZQQv4PiKlde0S6/u6dGbHbzYgVS/2W+rVw7PTfveYsyzIrbt15o0Jbvmgu+klrgbq+J7ab+01v62JTQiONUJOGiXv1Uys2rfCHfChkYcEMyboDhNAHSziu0vULRc052HqP6zt5y5fT8RCWU0oE52Z2PSnjDIBQICwzvxOcTt1qYpzkg8QSZ1U4bq+Koi7W9HyO4z0+dSyLDlf4Rc6Ebg4LbDwOTyvtqypCVVYEOUPdy1ji6EdpwfB47OP4t83gizr52FC3BJE8T3qdFeakmIQhzQOUXNF981WKh+MO+cRyG0OeY974bOjLTXwprBxEw1SlR/j28JWY3lC2H8+VQF/3pngg30O7KhT2qXpPE4wn8skVTxA2P24t0QM/ORL8ElVWOVHAmIUsoXIuzO0giQOgzparNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(2906002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(66556008)(316002)(6916009)(2616005)(66476007)(66946007)(6506007)(26005)(6512007)(36756003)(82960400001)(83380400001)(31696002)(86362001)(6486002)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU0zVTl4TENyYmtvRFNWRXRGUU5sLytpeUlpNGJuNlhpR3NVSTdYYmpoMWxH?=
 =?utf-8?B?eWFrVEFnT29vdXRtMFMxUm01VTJkOW9pVldUU1dHbXgwbzErWXhxdEtNSlB2?=
 =?utf-8?B?QmZOYlVqaUVadDNrQUFzVVlaQXJIRUl0aWVHZnZ6MDg3OFNscUY4Rnp3RUZM?=
 =?utf-8?B?Y3N5VEJZMFBHNnl4OENyQWVOTFJZakRWRU1Nb3dpOEJjaUxXeW83RllUTFUr?=
 =?utf-8?B?SVY0V0hlTWU5MlprWmo5eWx1RmR3dEErYkdJOGlIRzhjWGZkblp2SXNISFZF?=
 =?utf-8?B?QnBacEdZaUJmb1NMTHNOOUdMbng5QW53MU1VazZzQklkdjdIQVpmK290QTVN?=
 =?utf-8?B?UVYvMnRhQzJkMzRsUFZtM0RzVXpMSWFSNG5DMnJDZU1jLzhTdkVQTWFnejZM?=
 =?utf-8?B?dWFXWGlENjVaTDNZeUNhSksrUkVKMFFJWEVrTUNzZ1dBamwwb1dYRjIycEwz?=
 =?utf-8?B?YjFZNmFsUVZCanZTakl3Q3JkbHNENWZGRm9FaWFKRy8rdExPR2hwTWpTdHAy?=
 =?utf-8?B?QnBXelowTmhoaE5ubXU0b0I2dkFhT0NRNjMvNzhIUWxQUzBHeVVYbHRLT0RZ?=
 =?utf-8?B?VUZreFp5RlFhcnZkakRwVFliUzFCbG9MUHcxMDMvbllBNURHdGw3eWtDWHRI?=
 =?utf-8?B?bDI2aEo1ZUpvdHEyL29GNW83YkdQemxNRlc3Y3A3TTdJdWM1L1JFNVNKeVJu?=
 =?utf-8?B?Z3FmYXFUYUs0a1d2RUw5OVVwZUZlRVp3c3U1Ynh3K0FERXVqM0hlZHZTTEJB?=
 =?utf-8?B?TDBVaktCamUxZTl0cDBEZW5CbmZTdlhMT24xTERGTGUyRW50ZjB0UjE0cWRl?=
 =?utf-8?B?a0dFMkdEWTBLdUlwZ0ZPdWErT21pK0k1YWh2UWhuSnRpMzJwWTBqVVAySmh4?=
 =?utf-8?B?R3pHaWQ3ZWpUUzAxdmNzZ1pZVEJ0Z1ZNS0lMb2UrQm5HM3RmMEVTT1ZCMkJT?=
 =?utf-8?B?UGl2MjVaT1pVV3FuQU9UMzV1STdUUWZXNnNpZ1IxSzVpWXkxYnpOVkZKNHlz?=
 =?utf-8?B?ZzA2ekV0SzA2Rk9oN0ROSnA1bVJ4Q2cwVjVaQmFyVHkwT2ZXTUlLeVFXMXUy?=
 =?utf-8?B?ZVU5ZHloYzdzL0JGSlRlZmNwNGh4bGNwMGF0U1pnbkdUVmkzNHl6U0pZNjQ5?=
 =?utf-8?B?WGtwUnQzRUk5L1QzcHIya2wwOXQxNSt2N1RwdWh3blFDOWNIQmEvUzM0eTh1?=
 =?utf-8?B?c2FrMW0zNFN1YXh4U29zaXU1TGlXdVlqOVE1My81RVdZQmh0VXFtN0dJdUpy?=
 =?utf-8?B?Z3k0WFRPY3dJM21MSWJncFBWYWtzalhQL0lqbk0zdTFneTJudXdlQnRUaFVp?=
 =?utf-8?B?WnV5aUtMTWQrNWY1MVQ5Q1BMNkdJUkwzN0d4SHJOakFUZ3NmNFNzS1E3M0M1?=
 =?utf-8?B?RUt2ZWZvRVYzVldzaTJDcTN1ZUhWRW9HWWUwYjFHNEVLVW1CZ0Z0UnpKYVdi?=
 =?utf-8?B?aHM3eStvbTNXczh0bXF6TVZoVzJ6SndEMjBUeXArVGJxRjFYaVpmaEh4dkdS?=
 =?utf-8?B?L2RVNFdzS0kvQUdOeHluRTBxVzg5R2ovR1MxMlRQODRXcWEwZ29WcER5NTRB?=
 =?utf-8?B?OTFCSmROaVBJQUlMa0RXTWJsblpGOVZGWFFEZ0llZVV6MjRqcUg3K3JiZDY1?=
 =?utf-8?B?b2ZJRUE3SE9xWUdPTXoxRWZJenhhKzhPd0FKQ3pGYVVvYldtUzJmUzc0ZFJ3?=
 =?utf-8?B?NjRKYnR6cTlUdWNiSklZWURzV25sZ3F3NURMZVhsVHdWN1B3NXJoUU91M3Rw?=
 =?utf-8?B?aDRvSVp0SUV1a1RGdWFuVFU0RStQcWoraFNMOEVPMjFIQXoxb1V2aTVkeTdw?=
 =?utf-8?B?RFpPMkM5aWlMbjRwMlY3QXhnWDBxWXN0dEhTaTFHdGNycHBha2J4MHZEZG1Y?=
 =?utf-8?B?UFVYSXZuZjZZYUV3aEczVDlsaExmbmZWanFlM25VQnNURmp1TFcxY0pRRU9r?=
 =?utf-8?B?d3M3T3dtazh6RnlLNTZGRDQ5UXdmVEx4ZVk2MDJrNytBdkJjQUM1R1hvNEZl?=
 =?utf-8?B?ZmhuQTZ1eFpnRGRxL1dwUkZNWnAwTGJUR3VsZU45R21yTTZMT2owQ1RKSzk2?=
 =?utf-8?B?dGpzRG9xdU1KL1FCSU9BUWRjaEsvVXFkSmxSbk1ucTRPakxTK0RBSmFTYkwr?=
 =?utf-8?B?RGx1ZC91MjZOM0NpekhCa0tSU00yaCtyc2dYYUVVTkVtbnZBbzRhQ0dKanBB?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd54065-e3fd-4625-7901-08dbc6a23e20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 19:27:13.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4MCUwY5wTvHO1UyowSRTQx8x+Rg23r13K41NWGfoBNVSQk/+2Gfr6FyvuIn95qe0/DpLK9MN5zT0PdUD3IAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7716

From: Jan Kiszka <jan.kiszka@siemens.com>

e1000_ich8lan.c:1053:21: error: the comparison will always evaluate as
'true' for the address of 'shadow_ram' will never be NULL
[-Werror=address]

e1000_main.c:3598:5: error: this 'if' clause does not guard...
[-Werror=misleading-indentation]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../net/drivers/experimental/e1000/e1000_ich8lan.c     |  3 +--
 .../net/drivers/experimental/e1000/e1000_main.c        | 10 +++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.c
index c341584e35..c14dbad1b2 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.c
@@ -1050,8 +1050,7 @@ static s32 e1000_read_nvm_ich8lan(struct e1000_hw *hw, u16 offset, u16 words,
 	act_offset += offset;
 
 	for (i = 0; i < words; i++) {
-		if ((dev_spec->shadow_ram) &&
-		    (dev_spec->shadow_ram[offset+i].modified)) {
+		if (dev_spec->shadow_ram[offset+i].modified) {
 			data[i] = dev_spec->shadow_ram[offset+i].value;
 		} else {
 			ret_val = e1000_read_flash_word_ich8lan(hw,
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index d76ad9c775..76cfb0dee6 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -3558,7 +3558,7 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 	struct e1000_buffer *buffer_info;
 	u32 txd_upper = 0, txd_lower = E1000_TXD_CMD_IFCS;
 	unsigned int i;
-    rtdm_lockctx_t context;
+	rtdm_lockctx_t context;
 
 	if (likely(tx_flags & E1000_TX_FLAGS_TSO)) {
 		txd_lower |= E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D |
@@ -3593,10 +3593,10 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 
 	tx_desc->lower.data |= cpu_to_le32(adapter->txd_cmd);
 
-    rtdm_lock_irqsave(context);
+	rtdm_lock_irqsave(context);
 
-    if (xmit_stamp)
-	*xmit_stamp = cpu_to_be64(rtdm_clock_read() + *xmit_stamp);
+	if (xmit_stamp)
+		*xmit_stamp = cpu_to_be64(rtdm_clock_read() + *xmit_stamp);
 
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
@@ -3607,7 +3607,7 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 	tx_ring->next_to_use = i;
 	writel(i, adapter->hw.hw_addr + tx_ring->tdt);
 
-    rtdm_lock_irqrestore(context);
+	rtdm_lock_irqrestore(context);
 }
 
 #define E1000_FIFO_HDR			0x10
-- 
2.35.3
