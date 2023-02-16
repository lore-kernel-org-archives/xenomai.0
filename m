Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227067B
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 09:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLorg5EJQ5pJXHrrU6sTVjtD1ORfgrB+/13FvAQd3LKzGemOHXrhvLjzMsNSBUVZkKktCuz8lH8R6rD3LXAmX9emd0Gu2TgIPWcfrDjUGHjSnXVTMERUsGy41GEnsymbvkJVbTZ8QkAu94M135/8YjcD8Q682Kb5TgCzzQkJJrMM2VVQBBE5raoTmRcUt7p18oQ/D7WtXa4K2ikhXda2mGiQse/ywmDLKG3hrah5iNxRKdTmz5leJD4biUAVV/+gn1L6d7A2lOOGyKql1G7mIy2loDbAF2PKCn5FiVgAkHcdeL7v+TkVvCUESND+Xy4KcZMGHcuIZjQqTVLsQ7HLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+oZfEZxLq8EkEX6J1egq0ckjfoVKAV7iij8sNaNuP0=;
 b=FtnPeG+Dhi6Hu2+s2jsrcQg5y5cLsnOlGZOyTkEF5LDrOhAia8MdJUrs8rP+dwO8tRv2rafzN71yOW4X51bHTGw5sTBiLbENMfEQyWc4oJwud3JTpZ8uLSvJcJvWBcj5OuvBx6YpohnPrCk/kNzEaDYP936NJoavf+4pn5K5u86GhHd9r+U1zsu1w+MycEKsZLLXY4eBJi5nyOiuB5trYvyfgBqF2z5aUDsLM5+/Eg4Ub5KA6zQkVDycAgzjj1S4iPvEa+PjcVPV9EwmsXEo0g1+gMmdTUihjWrIWubKBR9WI0Pc9dIzZlfq8kxwFS6q32RrM2pOjr0QEX23G0lQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+oZfEZxLq8EkEX6J1egq0ckjfoVKAV7iij8sNaNuP0=;
 b=kDAJihVS6CMUv6zkUE5C7RY9rDV/f2hqT6KcYGry3KPyXAUV8ZYMnWAKo1Xtl1TD7xJczIfIq+S2P/7BrqykVuQel1/UWatTMKnfcZs+j0IqeWZvucQ4GB3QzOLlZ0FJ/BDzY2jbaTmVQxX/+Af2wZf3NJRTvxnd0zsGQIbulu8x8MaK5IPRRxirRsT1z/x8m36Yd57augFs/aO+ntMFdEqaIOXAobLvNpPN2CZS70oBJqvy858LdJj5aXbbmd70snHBPZRuxJiR2bBBRPjRUPZS6ywUJQXkC3MX1ummVW2rR3pqxoN5WhUMpxdQYh8tN75PM1Pma1AEy46n+oYfbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 09:37:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:37:23 +0000
Message-ID: <e4d13f78-52a7-7fbf-f0b0-e31247021dc8@siemens.com>
Date: Thu, 16 Feb 2023 10:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Lift build tests from 5.15 to 6.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: bc01fe0b-8702-4df7-4a8e-08db10016863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ga3pK60Z6pVYLieJQZ9C8+Ah8SQamTlIbpKqOA03qF87/RdfxvGGR5Lu05ncYxbxsN+qjZ6elCEJROgmryduFOCFnRuC59FTgZelKmjCWNJBpQa27tnVEjL/Hm2za3idacmsl4dTU9oxfoU8q8E27zA4sqxaRpvmZNeXbhhDjDjw8Ff+791qLJLbGExtDBymTrkRWO2SP3YJI5QKMCB3O+tbD+mYEd86wiXrG5lvdguDuiLMQzrX2BU1p7j8uOFDVMD2GFfwxx2AYy8hWRe6oveZNL12uGTcftmuIziJdK03JIbX0ZOC+cJgXXbOw9s1m6P2X44Pebgzy4Ll5of9WjeGzAvHlwb+R8NZl+aalxXh/1G3C8zenlnweHEmSQvjkAkJVQAVg9ElySWgHXpZ7FiVHxBzxuJ0l/UEkLaMMBURb3VEbB4eYZkGk0aMnRwEMTcsSoWyPjLF8igBKa46UoWTBDaBHtUZ4o20bldTYZvyRDgW3lz66oLpllHwXzWUEhPdTwvLfaychxAEF0t9FuATMb22VWpXI0SIQYoaYvnaX87m7bbWySA1rYi588Tfcfc26bGnlkTD3wR+tlj3vnObsieUhY60PUCsvooP9eZcPQY8UsczjbrjZOxo0TLqE9MttD3SC312vVDasSFJKJmYs/si1ygiZE28en28JLZZVTi8XR3cTGYiP8HLHUxJfIZzNSDofIqinwz/wfPq4JeJiYie8Uohe89GGj+24Ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(36756003)(86362001)(82960400001)(66946007)(31696002)(8676002)(66476007)(66556008)(6486002)(478600001)(6916009)(41300700001)(38100700002)(2906002)(44832011)(83380400001)(5660300002)(186003)(26005)(8936002)(6512007)(316002)(6506007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2ZxUXB6Q1Z0dkt2dlJoVHlmamVyejlrRmRibkkxOHlnMWVTZnVaUE5ldlV2?=
 =?utf-8?B?MWpsamxGTURPUHo4cjdraHdpZExsclgyTWorZXJjd2dZNHZFbnpzMnNYUmxn?=
 =?utf-8?B?T1JubGgwVE5KT0xxVFlka3pwbHZDR0VpYmRsSG8raFc0MWdHODN2WnRmSGtM?=
 =?utf-8?B?VDM3NDIwbjBjUk80eCsvSGdBTS9SZlNNQ2c3Vko0QlZiTytmelZadEpDYmZn?=
 =?utf-8?B?NHY3RU1RZmNCcDBQWmhsOVUxeUl4TGFEVk1ZVDZqWm9VQUc0VkErcDhTMVNE?=
 =?utf-8?B?Yy9QS2xyWXYzV084VXZDbGc4ajUxMkQ3dWhHUStQaFhHeUVEL1V5eEZLSFY3?=
 =?utf-8?B?czF2MFpqYkhIei9EcVk2RXFRdzYyK3BUYzAxNS9jeWtYMXZlanJRVDFhTmRs?=
 =?utf-8?B?Rms5dlY5QjBxNGp2Z04zL2c5WmpoNm9wcmtEcm8xS2hhcWw3TExqUUV5RldY?=
 =?utf-8?B?Y2dlV2tiSFVqYndRZjFTL3pyQWhUT2hPU21ucjd1Z3A4TFQrWElQUE5wbGY3?=
 =?utf-8?B?Vk1NVmQ3ZlVOZU5RTEwrczA2dGl3TVBNdEk3a0dNanVGNnNibXJVRHZZTkRH?=
 =?utf-8?B?VWg3M0hCcGxuOC9Ma0ViSmg5TXJiYTBjVkRYVys0RE1JK2lLOUxNSDYzeVNC?=
 =?utf-8?B?SXYxbkxtYWRUZTFjdGVEUThLV1dENTZ6WU5JYmU4UDgrSXVTTzBqNE9OK3BU?=
 =?utf-8?B?VytKTjV6Z2JkOUNrMWZaV3FFeHdwcm1aY21BS2p6OFlSU003YjJSNGQyN1BR?=
 =?utf-8?B?aXd6a1pWTmU3RThkTHdBNjdITFpGbUJoN1hYNm1XVmJQRis5NlhQY0JMS3dU?=
 =?utf-8?B?bitTTjhUcVJNMUlPZjlLNjNNZ1Fhb3h6L0Q3U2ZENW80RGQxL1FObXBqKzRF?=
 =?utf-8?B?MUVQemo2QmZ1Z09sUUloWm15TUhvVytqbUxBVmV6QVYrQnYyYzY4K1pxOFV4?=
 =?utf-8?B?dkhrenI4YXJ3VVhMWXNoV0QzSytiMEN5RnhVKyt6Qyt6aHR4MnV0TjVHaThL?=
 =?utf-8?B?ZnJXSGhqcTdwTVBrSWVwYjA5cXkyTi9kdFpzQUtXTUFaNjBlL01DVkM2dHJH?=
 =?utf-8?B?K0J4ZUQvZERiSk14eEkremo1S0lkLzlxQ0J5UDNXRXEyeUZNbXBuZGgwbFlq?=
 =?utf-8?B?VHNva01nRmlKSWJJUUNQTUhzZHJMNTQ2ak9oUGJwRG4yOXFZTWI1VjY3M2ZC?=
 =?utf-8?B?NHlKTk9LTjlIdGYxcmEwa1hHdDhUWmcwZGtTaGdlZllEc1RQOE9lVzdCckhk?=
 =?utf-8?B?V0J2NVpaVXhpTUU3NEMzdHFzdlRsRXdnMEdtTmRHcjE3aGl5a3p0cWUxVzV5?=
 =?utf-8?B?YlN2eUVMTTVkN2hTSzBJczUzTitnWXFFa2NTSGo1Vk9vcE5lZ1pBNTYzV0xS?=
 =?utf-8?B?WnVvV3lpdjlGNU0rVERjNDgvSDNvZGprMG84Q2I2eFZ0UFhYeTNTWlZJVVov?=
 =?utf-8?B?NEhqcGZyVnhXVThMc01LUm04WHM1V3hJTGVKY29hVTh6R1ZQRWRNTnZjdmkz?=
 =?utf-8?B?Mmk2V1QzNGhQVmVabGJtYnZwc0xtbE5tN0ptVFZMU0FWOC9xNWpzdFJuZkVV?=
 =?utf-8?B?TnNyUmNFNThxbDlnN3ZsTXhIaFppQnhmZW5XTzM2Rm9pdzNYVEcySmZtanE5?=
 =?utf-8?B?OWNaaW13MHRFVTBmOUwzNFFpamU2UXJpcExIdlg0eEJDaWcwdlVRbUI3Sk9R?=
 =?utf-8?B?VDJpZmwxdHpkNHJKb0Joc1Z4bDBnV3ZaK2hQTzRGb3FsU09BSk14UEpFUldL?=
 =?utf-8?B?aXVteHE1aVhHWkZMMFFpSVdjZUpUakpJSkxDdWZSc3NrYkMrRkZ6WXZiTGhH?=
 =?utf-8?B?U0pjNTdIWXR0Yk1oSWlPL0pKWG1KZnR0K0NodnpWTUQ2RHBrOU1Ma0NkRG1j?=
 =?utf-8?B?MWYxempaYXJzUVIyZkI1aUFRRjVnTlMreWlIQldWMlpjUFduUkxBcXZqYlZp?=
 =?utf-8?B?QjQvQ25SQVp4RUhoTGdBUERkeU9NUmEvbmN6QmFYYm02T3JCRkFWK3htcTlR?=
 =?utf-8?B?S3NJb3NvZmhtVkVxaEd1M1Frei9HZlVkUytCSHp6SGh6MG14UGFqeURnSkY2?=
 =?utf-8?B?K25ZOERJU0lDTUxOWVVNOS9kMkMzcU5YVUZIWlg3YXdNeE5Xdm1Ea3pEU1Zu?=
 =?utf-8?B?T1V1RlBEMllXTkJSWVN1b3U0M0xGcHNkODdST2xIcm44eXNteVFjeEVnam5X?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc01fe0b-8702-4df7-4a8e-08db10016863
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:37:23.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqa4oS0uOM/Vp6VMOJi9zJcbvRb9S2Q/9D/lbjqAlxqDB0k3DlsX+oTC7C6lPk3kXa/C3XUyon1Vbhrh6s5cPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7128

From: Jan Kiszka <jan.kiszka@siemens.com>

5.15 will still be covered via image tests. This is about build-testing
the lower (5.10) and upper stable kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a80b4dc277..5c8e01f098 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2022
+# Copyright (c) Siemens AG, 2020-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -188,11 +188,11 @@ arm-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-5.15-head:
+arm-6.1-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-5.10-head:
@@ -209,11 +209,11 @@ arm64-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: defconfig
 
-arm64-5.15-head:
+arm64-6.1-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
 arm64-5.10-head:
@@ -230,11 +230,11 @@ x86-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-5.15-head:
+x86-6.1-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_REV: v6.1.y-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-5.10-head:
-- 
2.35.3
