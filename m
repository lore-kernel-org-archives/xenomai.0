Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3867200B7
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357629; cv=fail; b=RCDxrAd6GFVxb1dP+bPl+p5f9wZnizLy1dXas7P7TQrVb6fLzCfmIQoM6PnCTgmGTM67K1Td1OtKVjMfSk4HP71e8YktoQ/P3PANLwPWEBcKI/8FSrSmYuguoof27aZl0T3h7qOtmPL8ybYkQz9UccfLS8E43rQGwtfd9scGfEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357629; c=relaxed/simple;
	bh=mzw79NGnLHMj0CYzLDs94YWTVEAo4Iu1c9Bq3xkYozc=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=TaHfIl5f381o71eKPdHWKxU2aMj2dZHQyZLi8vhdiqJxJwcjjGh7ag0jv7l8wQrTdMZ0pTRSg+shaRPe1kahzX3JU85uzwjoNPT+uiPhiYMxToGzhBqZaHk3uWHVLoqVJtfLlwdJsT9LUqhEbsUxrl/k85i0kqA7lWQig0aqHfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=m69ckYpm; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="m69ckYpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+Pm2y4xvit6EntanL3d0KJM//IRhD1NrAaQ3jXRkocTifcb7pL5jFitdWMf+m1DA7o2et5gCI/o/KpMKbIFWC9rghQVlLTmq8P41rGQEQEJYh7DGda73JVuhwM6MbXIS5IV2kD86sMuHvhFaX2hKkZ5QsRI99hEY8Hfgo0cNd99lzV9owgh1edn4P/nQ2BCfgEApDCHAHxEQuK5/eQvBdpwexLEYUbd63xg9YZMn5N/dLr2uTGDm/A96Rg/+rkyF9s4m8htdO4sIw8rBXj45AZcvf7zzZhK070v/EpK3b6fCR16HG/+TuIgSgBA2DoV9IxfIaS+79uoQbIHRgMnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ez474SYu2uEdX2+C0DD3gBXB+f6VuDyJHn0WE2fGek=;
 b=bMBVbmEmz1Md3B3gVufD31O8auw73m3icqB+CzJ0jbahziX93lYWSBZ6b3JFzswKeDQWMrxDtmmF6QNdoP8DDMBxDBylFVfEj+m7EwPa5doeITJ56+EJrVpTR/6FLYPzMGoqSTwXMB+g6Y93i5m1OOIvncTB5i857dxFitsgfYIdwggqnMaHhxmrPq/t31W2nxASgu2yfenhEczb2zEwpwabTA33bZ10sw0pi+SFJ96sg1Cps0zAB1ruaevrGeBoM4k9Zym3cwIbJIDsMzKR8C/GB8ByppjCFhVeu8/eKD/K9K2kwVnrJWPFC5yKvc+ACEdJgj5RoDAqsyexwqPakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ez474SYu2uEdX2+C0DD3gBXB+f6VuDyJHn0WE2fGek=;
 b=m69ckYpmoIr+0EU17Wo/bR8nazPEKJx2DL22IELUrUZQZbCwgyzUknC2X0iH7oR42kluBkIjuspFuyKwll7s6hXo8k4JfEsVvdl87fRgUwcpfL3q8Qzoj7PKx4neESlwpOThH9BZhHC1I/kqVjf4KIYtFF80cRVmShl2HWHcYZDP09KXFqG7XQZc7oE/6WuOow69rJkckgXZ3WvLitK480gS/9IV1u502Ml3AzZuvryQfvn9D2jhnhND4PhauDbAxCGzNhRod37qnlXe3TUqOqIQzMnQiZMU0aJhLDpvT3YPvru6nCELS7bLKd4wvefdcLkzA8cRnRfctKe4exBX/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:00:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 06:00:22 +0000
Message-ID: <583b5d23-5d91-4bf8-a0ef-92d327a34dd7@siemens.com>
Date: Wed, 22 May 2024 08:00:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers/net: ipv4: Fix warning about missing prototype
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5f5204-c8ed-4690-8384-08dc7a24776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anRRTTdyWFpwbituYzlXWWVGbXRVcUpON1d5ekNQRzUyMCtNV2Q2RlZRTDNi?=
 =?utf-8?B?R0JIWFBVcGlDaHluSWxlL2FBU2ZJTlROUldkSVNHYkhiQ044c0xvTXZQVDI2?=
 =?utf-8?B?dzhSdWtWNFBaYXc3WFdhNmRIaTk0bk5tY2NHdHRIeitLVHJIUml6aWFWVFRE?=
 =?utf-8?B?YzRXbVlUTkpwbHB5L2hsVWlkTVFYMHlSQSt4L1NCN1lPNENzY0VvcVBSU0dx?=
 =?utf-8?B?MjFDWFZqSzE5b3NXanZDblltS3RTemJZYm1qeTZIQnVsZXIza2lrRWFUbnhi?=
 =?utf-8?B?NGZPVWJWRHVRNXVSQlJuOVU2ejNxR09RODFXUGJxN3M0ZE9XVi9GRzFXN1Ir?=
 =?utf-8?B?Q0MyWFZXRWgzQ3F0cEg4RS8zT3RscVcxOXR5MWVjYkRlUnpMZjdwNVZkQmYz?=
 =?utf-8?B?S21Vd2dSTXlMOEc4aTF3SHJxSXlHeXhJUHIzT1BGM1pURHZFRllaTlNhV1pQ?=
 =?utf-8?B?TW11dUJ6SFJqMFFEZTFrTGthNllxeFA5NERjdWU2YlVmNzY3dEc2STVGSGli?=
 =?utf-8?B?RGU1ZXRZaXJ3ckgrTGZpVDFyUUtEWlZUZlp3bVllSzkrbldxTko3MjFKRWZm?=
 =?utf-8?B?NTVUVHFQVmRVWWVaR1lwZ2VNdlhpbVNVcmtVckJzeERMQkJWSDdRZU9tenND?=
 =?utf-8?B?Zi8yRjJ2em1iYkNXWW9UZWg0NUtMVUV2SXRQQ3c0dmdhZ3JlNFFlSUVvR0pr?=
 =?utf-8?B?eExTaXdqR0NYT1ZSaktVVy9EWldsM2FBenE4dzV0MWIzTzFFbWVJTlVEMTdY?=
 =?utf-8?B?SUVLNmFBcXBCdUpFYUJUSnd1VWpZM1hRakJpT2d5SHkwdkkyRzA0NC9rVzZX?=
 =?utf-8?B?T2kyRGs3TG11Mm9RK1h0Qjg0bzFlczVrYTB2a2wzZ3JnU2llQ0oxR0lkaTQ3?=
 =?utf-8?B?QnkxYmdIMVNhR2MxeG1mb3RpWUZUeThPMFZVMFFVSVBRVm83Z01RRnRWQjZE?=
 =?utf-8?B?MG53YXcxQVh1dmZUSWYwYS94a2d3S0dPL1YvUkoxLzRsUUVYYmY0UTh4Ynlh?=
 =?utf-8?B?d214Y0tIN29vaDlYNkwvcXJzOEpTcnpvd1hOSWttelYrQ2JaTUhPN01oRlJu?=
 =?utf-8?B?R085VDhxSlM0eUNTbXhFcXpjOVBRdmMrVVVaMENtdlhkUjFpZlE0VVZ5WFZr?=
 =?utf-8?B?Q0tacyt2NTV4b3lDQ1NCUWdVcWt2Rm5UYzFIMm5sT0VQcUhOdlMwVmJ3UWt4?=
 =?utf-8?B?RUduQ0xrTy9lYU1LT3cxLzVSQzBNQnlKZmFqNERucndXeVQwemh5RW1KL1VR?=
 =?utf-8?B?Nm9BRVFUMHV4TVd0SnEzeExRZGRXNXJlRDdsbW1LRG4rZFUyMHdxM0x6VGY4?=
 =?utf-8?B?Z1FocHplZDRNcGlLR2VOMmpXeWIvM1FJZWFJSlJvaVlhMlBhTmdiaTJHdC92?=
 =?utf-8?B?WURHamwycUc0VERQK3B3YzZKUjluc1NMdTBmeUNyNnYxZ0h4dG9PcHpwNjll?=
 =?utf-8?B?cStHUlRBNG14Ulp1THhERUpka3c5a09kN3BlMzhpQUpzZWhLRDc2Zll0NnN0?=
 =?utf-8?B?eEFES1RMUHZMQzF3dTQ0NFhFaEswTCsrQ1FwSUR1K2EyWDdNdk9OclB5TDUy?=
 =?utf-8?B?d2l4NGJzWEgwck5pekI0Vm1oZUIwcmRBdm0zQzNHVHBVL2plMEtOZWk2cUVh?=
 =?utf-8?B?alJVZjIvbzMvdVVRZ1c3bkN3UXRQaGdadGlkSTFkTExLUUROcm0vQXE2ME1H?=
 =?utf-8?B?Q0JGTjNjMVFnT3hRYjR5Nm5VRFRaeDNoVFlIQ29mc2JaNVhmUjM3RGF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGtsTmJnWDRIbnRPMW16V2t6b0N2aDFMMGxxZ1RpTEMrMGlYVHpFRE1xWWVC?=
 =?utf-8?B?cUF2OTZMSmUwbXlwbnpTUjZnQ0N5VTM5SWw3MVJjTmorWUhRMFBDcWx5T0ps?=
 =?utf-8?B?dy85cEdsbmRwRVBaVFR5aUJjaFByaExoWHd6Q1hEOEN5OUt3ak1OZi9mVXp4?=
 =?utf-8?B?SW9NWjh0Y1VSbFRmVW1hMVZJTHBhQ0oweDJKNndsVXJaemFmZTBDbjlWVWwv?=
 =?utf-8?B?NzFvb3RlY09sa28zNUFnTEszQTg0NW9iMUdrODMvRHYzakp3WXNlOUtFdmNa?=
 =?utf-8?B?MnJuS1hseXNsYnp4ZGhiSnl3b2xzaDloV250WU5xVFRFL2d5bUExSlNhWGN0?=
 =?utf-8?B?SUNWOTZWRDlUUEcxeDEzc2pmSnIzMGU5emt2L0FBUTV4TktzU0tCMHJCb1pk?=
 =?utf-8?B?Y25FUGxTVStWZmNUU0NMT0o3WFpkdmZmM3FWMGZuN1RTVkR0aXg4dVc0VnUw?=
 =?utf-8?B?WE1qUGJjQW5YczZkVHRMVk5TN1EwMUZVcEwwYTAyNHRrUkJpNis4RWFvd1NL?=
 =?utf-8?B?UmZYTTlWengrTGhzT21oeXF3YTAzYmlMVGFRRDZ6TEg0OEtiKzYwN2VRQkk0?=
 =?utf-8?B?U3Q3cWR4MEFVcTFibC9aaXQwN29KWm0wcUxsQmtWeWtvRFN1cFRHWjJwMFpJ?=
 =?utf-8?B?NjJibEhQY2NpaGNDczZMTUEraHZQak1UZ1lQSFFFQVVHTFNlQ0hWSERvNTk2?=
 =?utf-8?B?VndRSk45MzhFMG4xQTRML1VLUGtPVDF2bEdKWlpPSmpEcGwzZktSK2x6YUFY?=
 =?utf-8?B?Y1NBTUNmSXNUYTdaUm92bUNBRElhR1FWUTJpNWhsTkJtRHBaUFYyUE9LTkpx?=
 =?utf-8?B?R25qSzROT0pkZEJvOGhhbzgvSkJaT3BESVhzcllnY3czb1dvS29pclZKc29Z?=
 =?utf-8?B?QXlHNWZmRXZIRnpwelk5VnJuZHNGUXIzRy9FMmltZi9rc1pnTU1VamtreU9u?=
 =?utf-8?B?ZUZiWk9TdVhUbEVaSlhsS1dQbnBUZXlTQVlBMTl5M0xkbXR0TEE1QmZBbnRa?=
 =?utf-8?B?bHJJWWFPMFhkdFF2YmYwdkI2T0dXN3FZc0diVm90MFZxRnc1SHVmb3cwQXZ4?=
 =?utf-8?B?aXFzYUZOSERUYUIrS29RcHRsMkoyZHZpaHhSWWs1WUliT1BibytwWWMxalZO?=
 =?utf-8?B?azcxTlYyZjg0NURkVEw3VVZYU2RHTFl4cXNmUjg1RVdyWUVnYjViUno3VCt4?=
 =?utf-8?B?aFFqMFZHN1VlSE0yakpBTXpOeG9lQlRhNVNwNDVqMXJodUhScWM1MDI4b3Iw?=
 =?utf-8?B?VHFRVnB6RGVNeGJlVmxZaXZXT0hjNUlFRE02WVpSQ1ZrazJVbVRlWTE4eUdr?=
 =?utf-8?B?Y1RieWFuVThWL0dFMUUrTmxtb2VsTENVMFJIODdCbzB4dGlDdEl3TC90MFpK?=
 =?utf-8?B?M1BoWVMwcXVDZ2laQWh1bmpZVEptY1IyVU5aR0pEdHB1ZDNsRU1KdVl4MC9y?=
 =?utf-8?B?a09tV2pmMnpHdjNkRnc3S3UxNTNDV2VjVVVUVDNFR3V0RUhIMDcxYWFkcTBB?=
 =?utf-8?B?QU9FdytVT0xoZ1ZjUFVma1JXNTZkQzRBMWZzMGp0KzFJOUZIUUxtS3dNL25Z?=
 =?utf-8?B?SXVSRVpUQndvQ0hhQWpsOE8rR1g4YUxOZ1NjZk9HT2xnTTV1YTFKMmhpdm5G?=
 =?utf-8?B?aURXbFdFa2wwY0pIOXJWRytyeU16ZDJZcTlDVURKcDZuano1WFZ2UzdIM0RG?=
 =?utf-8?B?d25xVUFNRVR1UStqb0pjdzJtOGRzejFoSnNEV3pvaDB5WFFqUjZkdEtJaFcw?=
 =?utf-8?B?V0dIYTE4SFNxV0RqWWdnamtsSGM1WnFIR2wrMXV1M1MwV0VvYWplVGp4Tjd5?=
 =?utf-8?B?OUNQRGppc0RPSzg2cUQ2NDFjTlhDVjNFblhhT3dObGFKaVRYU3NSOWdSS3hV?=
 =?utf-8?B?WEV5WS9KSzJXR1JjeWdsY0h4c0wyWFVHVUdKUFBYUisweHVEanRHS2o5N0JX?=
 =?utf-8?B?aDFwQ2RuMDh3cVVMWW5TNy9Sc0g2TXVyWFBHTWxyc3AvUzJpUjhzUWo5YU15?=
 =?utf-8?B?L2U5UXJlUG5ZSEY1eHJ0eFp4QS90QlBUaXZ1UTFZVmgwcHcyZ0d0K2lHUUIz?=
 =?utf-8?B?bHFmbzRNd1RkclpraUFoNU1zZnpKU1FudnlNQlFsRG82b2pTK1Z0b3pUZVZ6?=
 =?utf-8?Q?J4AfbaTanwVStNFBHhWJkU5id?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5f5204-c8ed-4690-8384-08dc7a24776e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:00:22.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+qQK8jSyOq/0toIadbLPQxsVi+P0L3a8YsuDVS/kgKCnGMwyEaBEstoHWx4TnJHyoGvxCSicBLpghAUn4w+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5864

From: Jan Kiszka <jan.kiszka@siemens.com>

This header is needed unconditionally to avoid

warning: no previous prototype for ‘rt_ip_rcv’ [-Wmissing-prototypes]

if CONFIG_XENO_DRIVERS_NET_ADDON_PROXY is off.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/ip_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/net/stack/ipv4/ip_input.c
index 6941e73ed3..26642ef6fe 100644
--- a/kernel/drivers/net/stack/ipv4/ip_input.c
+++ b/kernel/drivers/net/stack/ipv4/ip_input.c
@@ -29,12 +29,11 @@
 #include <rtnet_socket.h>
 #include <stack_mgr.h>
 #include <ipv4/ip_fragment.h>
+#include <ipv4/ip_input.h>
 #include <ipv4/protocol.h>
 #include <ipv4/route.h>
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ADDON_PROXY)
-#include <ipv4/ip_input.h>
-
 rt_ip_fallback_handler_t rt_ip_fallback_handler = NULL;
 EXPORT_SYMBOL_GPL(rt_ip_fallback_handler);
 #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
-- 
2.43.0
