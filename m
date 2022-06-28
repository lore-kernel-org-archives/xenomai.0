Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80133.outbound.protection.outlook.com [40.107.8.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1833257A
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 11:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5YW3yVL1VopgVvH50apfxU+Ad+/Bl5ulhzB8iLaa5+C9xvgJPO+gSV2mAYTC22cqLwDQBBNnaZS6IFs6Aogxxfvcy9mYekiGzurBoOWwzbchZqyZs5DN1o5HBz7et3pNC1WwYYXqOfH0KhKqGSEgss49ANQ7v8QK7llyQt/g7GWAty4Ca9jdaCPx2127jZI3y46xW2d8dzV4U3U34Gg9buYHgdOXwZVtssnFykqxMx9aZjuIqlXTZF/+c5cqDKnooegRUPb9NcO6r8UJ6EM8XoQcm0CAAf7bHQTCX3Ru/C5Ey+Ppz9Dv7gT09O9x6Nfrlykh3eaYD3JxJ0go45+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFZTaXZ8EH0ACvS4DOUHwenjcgDHHY/OwPPd+f6k9h4=;
 b=I75WzTFiyN7UnBS/kIfRK2fGkYcm60RbNLumwrA5Lnyqv8T7V8YyAnPhPwbQlkDrvtW1ekY/oO/xBgH5gwGu7pc+j6myUgXdREnQsbVMwlSsv0eMrujBgnkAbDBh1kd1SwVCS3vmN1bv27zEN+HR1XhSgY6hZ2WM9AB6dcGGwoTAVy52i+GqLoLgpxg4tjBtJvq/nLbxzoCNaGqGXcfyGoFtNiB18CN8c+656LNBRXhYhRcHnNaOpyixp+IqmBz31NvhYywXHjLalpFDp8zWcpjTmflhiERGdrG3/xJEq5lxdbMp3KvdebKjhaq6/W1sYZhJvpNunfd9z3XCZs/sJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFZTaXZ8EH0ACvS4DOUHwenjcgDHHY/OwPPd+f6k9h4=;
 b=J7mfB6xkA/zFnpNeG6e7kAa+abZ7rMiIV8Em26XW2nynZMTd9V8S+BqmM/m1oZ02jpUkJhvrYlATu0TWS7903yDjqgYTFC/Wcpbco1vcqtwoD4gJxQpHZaYCGXi0dm2BWmAe8YoGPjRDSFs7LZ0ejijAj2UJp8KxXvjraJs1CUQ=
Received: from DB8PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:110::30)
 by AM6P122MB0133.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 11:02:53 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::55) by DB8PR04CA0020.outlook.office365.com
 (2603:10a6:10:110::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 11:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 11:02:53 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id 64Grod8Rfl9Zi68zdoSW2h; Tue, 28 Jun 2022 13:02:53 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id 68zdobBemBXNN68zdoVTka; Tue, 28 Jun 2022 13:02:53 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xgg1.bbl.ms.philips.com (bbl2xgg1.bbl.ms.philips.com [130.143.223.142])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 4F5D51833D4
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 13:02:53 +0200 (CEST)
Received: by bbl2xgg1.bbl.ms.philips.com (Postfix, from userid 1992)
	id 48E961C004C; Tue, 28 Jun 2022 13:02:53 +0200 (CEST)
From: Gunter Grau <gunter.grau@bbl.ms.philips.com>
To: xenomai@lists.linux.dev
Subject: [Xenomai PATCH] atomic: Use __typeof__ to be compatible with c++
Date: Tue, 28 Jun 2022 13:02:53 +0200
Message-Id: <20220628110253.2577276-1-gunter.grau@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
References: <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 672edd9a-9fea-452d-cf11-08da58f5bfde
X-MS-TrafficTypeDiagnostic: AM6P122MB0133:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vzz+ozPuZu4U2L/0X5mZdwXsPDRJFczzgNF3VYNqW0bS4La6DHd8kOBgbDFblCCZWDxwKMUdeV1B79OliJ/He4nofxowXtDDKa/XTyFhOCLorHG3xMx/tT7zPp3aJ+iY9likxM5DnndkXlXBB9XNc26x9L/nNi9FN/kR5kN0jDp+FpTHezDLhmIA7QQw1TLBzUr9imRjljhrYhbOmn3ELnq6R0oJgtWvQYqKfdZ4zz7OMzuZBnTSrbj8/fPK1o66ep3k2UEnGXEXGKI3Xg+FwpysR0r24QBeLzNJAK536AFBvY4cvYn6z3q4Zm0uSo5iyV5wM4+Iq/mviPVp5wPlAj3ZQt9bpsY5I8gFwnVlxYB0KUXvLhmPo74k2mufB1mw9FVks6Q7+SboI+dr8hu8CWetME3Pp+SYabDzN/7r5RU4Z21tc9qgXT+sxfHPw5tRbqFpvgTLlJzSlGWd5UjQM3aKZ5wAAljYo+1ziRfOHW+LTuvbUnZ2fiM+evmz+Ek0Q+30Dhpyh8sy7ayFqWS3sGTo7dQxQaEPNZXRORZDuWpCguflE3OMFyhykOn5cbmwnNrY+jdyl6Ml1+aMxLFw71S2DzwtOCuVN7Fa9XFVfhl5S19OolSJQcvSpRqso9MmpBVKzkkT0VFJfopsBLvOf8ZkTlN9wBJ2qqpiMiJIVFq5lvbhgGNX1a/PJFYAr4aWYCGTHNAS7jP3gqx13+V+nSa0FrgH+N+EXTt8ox/nTXQkfaHdX0MGcQMwW0BnrBPomBO4W59zkWgQF5vuTQm/xGsBWppogv8HRscBI1rjyymahHnfMA5PW6g0xXwRYuXT
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(82310400005)(44832011)(7596003)(8676002)(5660300002)(42186006)(36860700001)(83380400001)(82960400001)(6266002)(82740400003)(40460700003)(2906002)(7636003)(356005)(426003)(120186005)(8936002)(47076005)(336012)(2616005)(6916009)(41300700001)(186003)(316002)(1076003)(70586007)(70206006)(478600001)(40480700001)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 11:02:53.4847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672edd9a-9fea-452d-cf11-08da58f5bfde
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P122MB0133

From: Gunter Grau <gunter.grau@philips.com>

When compiling C++ programs with e.g. std=c++11 compile switch the
compiler refuses to understand typeof since it is not part of the
c++ standard. Since Xenomai 3.2 the atomic.h header is pulled via
dependencies also when compiling userspace applications.
To keep the possibility to use higher c++ standards use
__typeof__ here instead which is also accepted there.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
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

