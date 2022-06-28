Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00132.outbound.protection.outlook.com [40.107.0.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D064624
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 08:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV84I4XCbvVgPcWRNus/5qkh2N6BR5X/+L965ilAAEZIUdUQWr7XeTsJRhEvB6d0Dv4c9jiSOGyOAkSZBdychTCRQgqCN6ZbQdTM+h8KGq1QtUWONk3xmdh/nB1ZHaGytooHSGiawPD9TaDe+Mo+Mh7n1KSLwp2isYjdo2O1e6XUvD3FyR3mEine6OB/LIsJsgZEh6Rhgiw+tE4NqvOFanRlvoDENqeISxduOgnnyn/6inQJO0eVOasaO/SpHEe5YSNMDURf3Mdt1BKv3zYUyzwFlqtd55ie2ovnaJQ/Uk+DlnxyDmBWbG7QhUlVmYKWmVfsCo2sPVnFMCpYcYLuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MML7XRsUWq9X5C6pU7Qd91++dwA937KCE4JVaPIZChw=;
 b=WVc/1+Ti564c1ZHlWE+1dszE5wA0isw74LNasDyfxstYsT3dPSRk7GNVdQbinTuWluNfFYAD2BKIUzrNHh9FChCpT42qNxwgmWWXcEDdonMZKql1azm1iELkP2bnkdM86IGZXUnrFmGri45bNSz8inb9sjoKlp5JCxI/CANWKcQkXbZmVNV9DLc2i0uGkN9RqZRT0XQGCTuMmU8hHro78wPeCh3rZJBZx1lIqbG+QvQKLiEnnrB6Gti6c+PHf5fBKdWbOofJmEiHMTk9YSK2TOSNwDftY+AljiTWPZKWJE5EUJgDAA9sWN1mX5mZITtX0V3BjuU6eu11mZVVaXEVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MML7XRsUWq9X5C6pU7Qd91++dwA937KCE4JVaPIZChw=;
 b=Ht7v5Ch34h2xpoSKn1Ojlm/AR3OHxbxwAk6RrKqEZyeKJzDZIam2ix8B+86P3zbet74z4UpMwZTkBE6WLHoUPrMKfQjiLEhkF4eUrMDdOGqwxcW5lhJssaEqQ0z1+XVj4AieK/bJlUu8k3//0TLHHLy9gHonygXqbLMnt1dplKs=
Received: from AS8P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::25)
 by DB6P122MB0039.EURP122.PROD.OUTLOOK.COM (2603:10a6:24:2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 08:01:14 +0000
Received: from VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::f9) by AS8P189CA0021.outlook.office365.com
 (2603:10a6:20b:31f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 08:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT029.mail.protection.outlook.com (10.152.2.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 08:01:13 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id 60X7od1iml9Zi669poS8yB; Tue, 28 Jun 2022 10:01:13 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id 669poazHVBXNN669poVBJq; Tue, 28 Jun 2022 10:01:13 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xgg1.bbl.ms.philips.com (bbl2xgg1.bbl.ms.philips.com [130.143.223.142])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 6BD49183392
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 10:01:13 +0200 (CEST)
Received: by bbl2xgg1.bbl.ms.philips.com (Postfix, from userid 1992)
	id 6836F1C004C; Tue, 28 Jun 2022 10:01:13 +0200 (CEST)
From: Gunter Grau <gunter.grau@bbl.ms.philips.com>
To: xenomai@lists.linux.dev
Subject: [Xenomai PATCH] atomic: Use __typeof__ to be compatible with c++
Date: Tue, 28 Jun 2022 10:01:13 +0200
Message-Id: <20220628080113.2527683-1-gunter.grau@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <56f788c9-f7c1-a88d-6018-c5de0aaa3a76@siemens.com>
References: <56f788c9-f7c1-a88d-6018-c5de0aaa3a76@siemens.com>
Reply-To: Gunter Grau <gunter.grau@philips.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96a71d3e-1a22-4ba9-4ef5-08da58dc5f11
X-MS-TrafficTypeDiagnostic: DB6P122MB0039:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/5Eq2GgDkBhkWJL3A35Ex+rk/Wz5Pti4zH6WasjNskEQe54xUmUx1pLB4zr39No7mYcjdgr9YZEEQV4wcAz1L73D1VFbGEwnCo7wr6Vxtqo7mnTPGLYhhkNpG09qX1Nn7GA2vajYgLNPFtUihatZekiWb6n8E7QgPNlmsbiBYRhDFc2lyOp9rfqTN/n5moQw3qPNtQywy8mOh595F5wv1G0DNI+mSewdnSuD3gupbx+BYd3uYQ3XHaDAPFImpEY+E4w+SWLcz+xxIOnLNyqzVFLgzKUdQ9lCFVdZr86LLFQOC99duCFkoORlDRQDuUs0ekJuhkoGDyFVJayo+52Q1P0POOJC4Y4F3mZq+0Dt1ozLzX12ny5u8LixkZHbZ1ufcLW1syecuCRdhbTsH9vqX17QQkagxWiEWHR2FrNhzO10E/nPs8EGVYtAV5/UOo91P/tpfB77sinzr/5dKDX9ABIbqis17MZprQzfogEz+6QPunyVZipAIEAL7a+fV1ZGrTSNclA5TNCA5hUH2otSgaYa+nc29BHY2Y3Xsr4wOjWW62hHTYzySDJe7rW2WBP1vDvQQatOyzg2f1dIWL9mxCOvWEfjNi9wc+VgEJekNdXnZl3vHLtbVk8czukWrr8mR3BiErier+/2HYYUSKBgVsa6nU4Pu/ZYpVpb08jBh2cr/G8g9uhxUyagPSl8pLxkeN25C16jhCZlFA/fliQ3ec9u8mKyq/LMaEvwwjImcF17ntr1YXEq/euMxllB2HL3vj/hwiOXEGL8kwvy7Tt2trEUHtHjuaOk8obhiD/t+aQQfLorskAlUkC+UGnT/DND
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(26005)(8936002)(356005)(82310400005)(7636003)(7596003)(82960400001)(82740400003)(44832011)(6266002)(4744005)(40460700003)(478600001)(5660300002)(2906002)(70586007)(41300700001)(336012)(2616005)(36860700001)(1076003)(120186005)(6916009)(47076005)(40480700001)(426003)(42186006)(316002)(83380400001)(8676002)(70206006)(186003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 08:01:13.6584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a71d3e-1a22-4ba9-4ef5-08da58dc5f11
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P122MB0039

From: Gunter Grau <gunter.grau@philips.com>

When compiling C++ programs with e.g. std=c++11 compile switch the
compiler refuses to understand typeof since it is not part of the
c++ standard. Since Xenomai 3.2 the atomic.h header is pulled via
dependencies also when compiling userspace applications.
To keep the possibility to use higher c++ standards use
__typeof__ here instead which is also accepted there.
---
 include/boilerplate/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/boilerplate/atomic.h b/include/boilerplate/atomic.h
index 731961e3b..4ee5f3930 100644
--- a/include/boilerplate/atomic.h
+++ b/include/boilerplate/atomic.h
@@ -78,7 +78,7 @@ static inline void atomic_set(atomic_t *ptr, long v)
 #define smp_wmb()	do { } while (0)
 #endif /* !CONFIG_SMP */
 
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define ACCESS_ONCE(x) (*(volatile __typeof__(x) *)&(x))
 
 #define compiler_barrier()	__asm__ __volatile__("": : :"memory")
 
-- 
2.25.1

