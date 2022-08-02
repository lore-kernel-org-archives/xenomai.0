Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AE7F
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 21:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNxrGm0VgVAOaSkAUGloam/Fejf9dViXrDh0GESjQVDyrKAeN3WsdZ9kBo3Q2Q+31D4bt9mSscISCiMC/ioU7j3MLJG8EHKmKnBRq6UeDAwxzWb7qXLO3zXnC5QIphgLr2Ue9kZO3LGipipDYkAbWp+Ws5asKnxw9YVkgvw3SXDtXQfitSUx0QycR4Eu1+ZUwyOVCB08XDsdfty+y5eiYSlAl+6nyDmHh0NPVz8iEO7uvPXssMa/b8ZCf0XUWvxbvCzY9X+f5OElbKk1c2/tEaecHYF+1XqjIA3vCnQSE69z3nE9RjvfqHp7VAfNjSVa2oQCWjNk8eCjViMJvJS37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p93O9pfnhhHvIAX/zynbSsFg8sw+s3ZdmgAVJlU2BnM=;
 b=MTcEgeI3ygr5LMhO+sAJ1Eca80z8vdBCsmJ+57kDq7jrNHE2mffmC56GIMThN+mT/P+1ERRIJicR2N6MJppn/EWYf8nAD1nMVOnHXiwpolABKxVlzo/MAQTaqd3C/VwOSbUkCTlPvsTg3Qk1Nkh3CeCDiYtYxJyVHvB4Q6156aqollFFN1vlue7Aw5/Sbz4vum9nQfWlsL2P92tM3Bj1BitkkT3odydZkYQRrmyljBtjGTzXr15pdNbkICrpZiD8LL4z5HWyjUvtZi9KjYP68Ugpj06KRfry7804wydAFcma9ZetBJYEW0oyeTBDKYur4xHbI8Pd9GzAWhiI9MH6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p93O9pfnhhHvIAX/zynbSsFg8sw+s3ZdmgAVJlU2BnM=;
 b=ORkjntnVziMCTT1taY1Iy0vkCOjls3rt1k9riYMZVUfZhaT2bDfweaQ84wsl2jkSQqzXKVISu/E5nD80JymFvWk5c9cx5TsOjedCteRJP8K2TNGfGGcEfJ7WwmRZ6aaq3Jgs55aSrm+c1mlmB/3U4FfcXRxfPzcS3pizR3A3OvqTnpCFuM6AVK3j7sED6IIbUoj8wlt7WsV8v10PnZVKmqUhgA8l6ZG3e6Q9nXYWxR6Slji//bD03yNlUz9EMHml0CR2nQnAx3VgksMGu2XNOSDLJVeFoS8c26fWmIPeZXb2uEH/Ui4Jas6w6F3dwJVfq8eyKuY0gYzll+qplJNN6A==
Received: from FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::6) by
 AM0PR10MB3299.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 21:13:33 +0000
Received: from VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::c9) by FR3P281CA0167.outlook.office365.com
 (2603:10a6:d10:a0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.8 via Frontend
 Transport; Tue, 2 Aug 2022 21:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT021.mail.protection.outlook.com (10.152.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 2 Aug 2022 21:13:32 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 23:13:32 +0200
Received: from [139.22.106.222] (139.22.106.222) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 23:13:32 +0200
Message-ID: <d639bb39-a0f8-823c-db7e-54eb528e0726@siemens.com>
Date: Tue, 2 Aug 2022 23:13:31 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3.2.x v2] cobalt: Account for mmap lock API extension in
 5.4.208
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.222]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.319400-8.000000
X-TMASE-MatchedRID: meDIGDR0v96rRNXo7hDbreMWR73Vk8ZMYhV4pgaIYNmJUlmL3Uj0mAGZ
	/+APXW9kWMFR4yyN53pAHOg8qEtqyC9hGGyJxSObBujHwFlpA172frp9GTUWHPbta0OAYFzyRRJ
	xnTsac546Vn8xMTQihRG8p3DGEZCF4vM1YF6AJbZFi+KwZZttL42j49Ftap9EOwBXM346/+zCcS
	uec52R0uBFv5kJ0rL0BwPpLM3pMrBh5y9xXdB7y0G2omA8qbnW
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.319400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 04FA1718496A590F1736E729505BAF4FB577A44FBD2217699211EBC585CFCAEB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7941f5-8efc-4969-e8c5-08da74cbdb20
X-MS-TrafficTypeDiagnostic: AM0PR10MB3299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dj1B+4mrdQhs08gp14p5GJXIP7uMekPXuh5wdbfXtT5VfFlawW9J8OSiptfkwkJl+VnEbIzimXZH4UcU4zfpvTjSlIwN0vZqVlJKqq5D26SdjinHeH5qSwM58rRRIMlU5gJH28ofvvTxr5ZRQLqY8U+qKvmVsv6jZGHwkC02HIqKu4Ji5YXy7OCFxs8CJRK28MFcu9LW0wIlXJ3eHWZ442uvRdD6fsFxChuHYHXV1fOwAiq9WhaD2uNKhnBMvuv7EVaV7Rd7UP3OUiuaoqmm3VUPQ3CHA+P7s4U0c+hB42HQgdS8ONrXZ4vUCr105ARCiRn4q2etlm03fVB0gF3Ja0UaQdDZw5w8x+/NUrN/FNsWUSXeBq+uFJA34tKa8qH2m0QXjMw7hOmfSeRVqj61tE6ApLh+LNRLCOmlIDEVp/hjlaT4g62+UfvPS6ZXlbN66FvbVu0kEohcPqtLwi3CDAgNClbg578LLeIv1otvLgHjrp0emUjG+06AD4+vbz4WP1OpJmg18riBYt778xs2e6p6M3JHqLvZpnGAZU5dcEG7bNdi2j/5ssD2J3pN+sE1VIQQpcx2J3wna37t/uDep46M8+VsnMwcJNaxE12AU9s8XsO8W/1MHXaAyy1637viDSH11pEeubPD5vkpWG1IEfGzXDE6HgklFSNxnm2vA9m3fEYUAOhTFT/1mJ8A0pgdMlJvaNNxtqZVJjc+J7qp1NKbSryxJd6sob4CQCzI+ITMgRQIHoOe6BuWtQt2FX348mPPp9m9JqKVpO4FJB2t2VJGV8CHt7cPJIExd063AHU8x3U5eANr1Dba/tQb4uE3etlj8oJ+q9bGUE+Wm6RC90ec/LBVr7QLvrQ8XotUIXoXFuxytB/vSVxR9qRGyuWk
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(7636003)(7596003)(31686004)(47076005)(44832011)(82960400001)(356005)(82740400003)(82310400005)(6706004)(6916009)(26005)(336012)(36756003)(2616005)(16526019)(956004)(186003)(83380400001)(2906002)(16576012)(316002)(36860700001)(70206006)(70586007)(5660300002)(40460700003)(8676002)(478600001)(86362001)(41300700001)(8936002)(40480700001)(31696002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 21:13:32.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7941f5-8efc-4969-e8c5-08da74cbdb20
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3299

From: Jan Kiszka <jan.kiszka@siemens.com>

The related commit from 5.8 now got back-ported to 5.4-stable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Change in v2:
 - fix version selection logic for kernels >= 5.5

 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 87ceeda800..05dd6c8c57 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -170,7 +170,9 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define __kernel_old_timeval	timeval
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,208) || \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0) && \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0))
 #define mmap_read_lock(__mm)	down_read(&mm->mmap_sem)
 #define mmap_read_unlock(__mm)	up_read(&mm->mmap_sem)
 #define mmap_write_lock(__mm)	down_write(&mm->mmap_sem)
-- 
2.35.3
