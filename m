Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A17F
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 21:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+q4FVgocN1VYvmOfSgFXZ2Sq65WmLE9u9zXgk1o181kfobYNXMWO+WixVvGnnEH815AijyWUZ5FvsdR3PAcDOiiFZvzfokdvIS/ae+XB6NqUjoTfbU8TV5UgkP01CMvkR3gl26bAzbclCLblgxuTKSlS9uC8AN12lIzpc2b4srcpOWeDkrt1gi4Btxyn97pnT4tixg0nsStuqI0Pp4RkqOkKKKDRq5dOYH0FvBPmW9YxC2K1vydu/GwmurFqMyW5RZDUoCMnELofrWe3h1r8dyHyc7njfmrrTNd80X0AIkEibBVFj6nPz76m+7se2IZb51/RM2uDg1jaDr9bAdiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKTdmF9LtRGeJCe0JxNMVIIcViiZwHxe4wtojZvISw0=;
 b=ZU0ZLAiNUHLsuLq2FuT3SXPki0gtULpqcn1f4kxWGz65eHFYZtSMKWmDRptAhyX9PvLQVtkMCXwc4ThJpuY9ru98qtr62Btsg6i58xa27zYkyG2pTccuIa6tpK6ao9oFEHZZVpG+5MtfUaqozjYscBpvA7F/K7YqUziuj+FzLimoNYMZ/8oNjStrfcFSmM/daji7WrtDE73n/0w8nieilbVa3bzq5BdjkFFQhqqVGpRWRsfFengVpQv0CUUbG4hawgX4RgfY/gH9NGLGT1Wz2zZZHaD7CqBiBRhtv8zRRuZPjdr/yRLK0XlOFV6lgISj8MqimBxpDndL7kIoovYZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKTdmF9LtRGeJCe0JxNMVIIcViiZwHxe4wtojZvISw0=;
 b=ZUoeRK2c4S0GXfRyBUn0o3QLy2YCV4pf+HLJnLcB9g2Nzqj4SLsaxvPJRWWgj1upVhiTeZeZC0Eiwf5GcW8l5oiMT3vtG8MQEEH7NkdTRZPutduM7kZEsg67rmWAOEd9XauNki3vPVk3wchio3uef4hsqj0aCXYwaD/GPCvm1L3DHMLCy8TwnqpL2K6FhLmYQB5DQ8nDgYi1YLW76dbh1hphv7ghL9JWdeACYsyHXS8zDaLMS2uL85oqRs9sl2KKXb2stVaY05rT1mCq7xYG4LjFiB2o1pBGS5DWhCPoCfA8w5g2dw10pUiRUkRL1SV7pU0gqwTI4ObMAmiKfOeR5A==
Received: from AM5PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:203:90::29) by DU0PR10MB6655.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:401::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 21:07:57 +0000
Received: from VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::6d) by AM5PR0402CA0019.outlook.office365.com
 (2603:10a6:203:90::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 2 Aug 2022 21:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT008.mail.protection.outlook.com (10.152.2.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 2 Aug 2022 21:07:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 23:07:51 +0200
Received: from [139.22.106.222] (139.22.106.222) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 23:07:51 +0200
Message-ID: <8e471827-95e2-da03-07d5-0fba20b582f7@siemens.com>
Date: Tue, 2 Aug 2022 23:07:50 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3.2.x] cobalt: Account for mmap lock API extension in 5.4.208
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.222]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.493100-8.000000
X-TMASE-MatchedRID: pUY+sEq1PrDnpv0OjOoz/CY7ztHObmHCLGmmJTL2jhwD2WXLXdz+AUxU
	JyPnqTyGAwAObkR2opZk0pm1AoKX557L/ATvyCqXkrwpLMBNgZUhR6lJWzYhzW1rAlJKwOBJfS0
	Ip2eEHny+qryzYw2E8Jkw8KdMzN86KrauXd3MZDXJkHrmVWhUvqyGlK//vmXcm3bUV2PfoTqOlY
	pnhIIO75z/BY3sKWE/
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.493100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 94950EFB102690E8FFF9B8F0C4C7F30C34197B22C55C464A8D63B8DF184B96012000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5460b1b2-8750-4abf-1d07-08da74cb0fed
X-MS-TrafficTypeDiagnostic: DU0PR10MB6655:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2cPBo6hm5SFiwYjB9ByLqpgtOirBscFtRh97PQAqbBPrjdg+hcXmQIkQsW3whJIxk7k89u/hoiVf+J9ctUkWdetjIhuWA8fxY+B7OiRPJBpQVyXKtyZA35mqVTPk8fzDEA8K4v8R1iaciZMmOVTvjDWHl0NQ0x4vGq2O+Em44TeWYHC8UUFd68FsK6KKZ/qJ46j8+lG5c30F5bOTnX3bv5xwUgMyMjlJ9q2qDCRzPFx9oLxW+Zroi5Kq0tATNbgpluMni3Eosd0BmY9FhXR8WGD+fCIj8ogArWO4p+dYtb0SohSLk9Hqji842INUb0toO0wBrpGtvfIl9qpIqh0u3l55i2pIl/TFbf3/029LtUdnXX52NtI6bS3CQUeTGhoZVWHLhn85xMnOnk6S4qFbZAQ+j30apu92i8sF/084x53aCAfWSK0gktDc1hqbg2dHNVx8OaVh5oxTIWIknT9h1W2hf1SuAcjvjWtwclMsPuGnYC6bDZKUULLLYPj192dkPl+SnLrgV/nz4XnGDQc0lTgRcCvisMxOG3Hpo/MPWKNuARgpxlMHycrukepPTNI02Y47Gkxe0RnhltMQ53UnRBpHpPSno26oZJ6DrFOJqNVWcy2ID8OvJDvVv0e3+1XnmQydoSDqokvCquhZeD/n5mSOsyVH8nVVJxb/miRUXBq3etl/28n/zdSJ1wVrYXM0fK5XxCtJDI7q6exDaj0nho5nlFNZXFutI6MBf2h9gVlAOguiCaUNVyTa45XWMS4WDCgEFk2qLvP7EsPwZKYsPL0UFuaHoU/v4c3tKqCxEUMe5MWsvnMK48os5jknW20f4Kfyj5zhe9eEjwn2BQ2DRvAj0bo9qQGgXNurL6qSmJKWTNRdgkOfkhBNdniJk+ONJbx+mciAfq5BExaiwHoUBg==
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(336012)(31686004)(47076005)(36860700001)(956004)(16526019)(2616005)(40460700003)(186003)(2906002)(478600001)(83380400001)(44832011)(26005)(36756003)(8936002)(8676002)(5660300002)(41300700001)(82960400001)(31696002)(70206006)(70586007)(82310400005)(86362001)(6916009)(40480700001)(6706004)(316002)(16576012)(82740400003)(356005)(81166007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 21:07:52.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5460b1b2-8750-4abf-1d07-08da74cb0fed
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6655

From: Jan Kiszka <jan.kiszka@siemens.com>

The related commit from 5.8 now got back-ported to 5.4-stable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 87ceeda800..944031cc44 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -170,7 +170,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define __kernel_old_timeval	timeval
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0) && \
+    LINUX_VERSION_CODE < KERNEL_VERSION(5,4,208)
 #define mmap_read_lock(__mm)	down_read(&mm->mmap_sem)
 #define mmap_read_unlock(__mm)	up_read(&mm->mmap_sem)
 #define mmap_write_lock(__mm)	down_write(&mm->mmap_sem)
-- 
2.35.3
