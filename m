Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6323A4
	for <xenomai@lists.linux.dev>; Sun,  3 Jul 2022 10:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoWyFUD0znG2ofTeZCTWlXGioqJCI6g0fbTpXyjhevLr3xklUk3ZfwnvDCv3uvoJQmKmimA6fP8vNvA2Uz9yofsT4Dw5DbKI9lBhDG3WavXpKR2BakCQMW0MfeVbmd3HdlQNDMPgr3usqee7WOh0uVmJXPtrHRatLLwu2L2V/DkCWdZvfRvSohN3B7/9yNoNecrLRiKCIxYZusCclxNKrNLKmT/LtPSAhfAZE2NJpxNTWnCYKOBc7OOAhomLhRTATbHd0gWNgnR2pLRnzCzuuKIhnXvTCkqBbNY7TQPKk7OZoXEjchYL140Fq19NffVdxhxjWdbUu4RdOqa9SvE2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLzH5iIK/agVFM3zi3ZjDmAauOhCDd4+q+cvc6aCJqs=;
 b=D7JOooVp0XNvOZaRahgVsO8Jhuq6pcP+D/f5//TB1QTSoA3LEf1j0H7xUI7M6t1W6cQR4q26/DK0nGrEqS/Rvv+IV1a0rO+Vrdtaty71GW+7sN+ZdCX+Zf+kD3SLGdc+4tgYocErQNcp+UfdPO0TSCrwS/2xRAEbGbZ5BhTcXNFK2QAFP9VsxvJ7QItrmaU7EhrJeIM+ky05XH0Djl0GDiml3N/hd1wP4nsSat65kKCzgNwCBeNu7gOh+9xmHGmqreoP6IVR9IvTT+EwXUmVjDnbUQAsoGQI7NMJ0KxqoLLVnyAhvYbNaZkWS6NARC3egiL+/FGqU2pjHc22ANutlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLzH5iIK/agVFM3zi3ZjDmAauOhCDd4+q+cvc6aCJqs=;
 b=pAtO6mnVhMxH9UVmgxD7UpIK2WhWUcPiUGvlyoMFhYpLQsjQ4VCDbftPusS2GmjOZR75n8zzNGae6EdliWZuRVS9rjAZBWxYoPkrqCAVXaij53scrE4SBsHgvUpydsKoyhS1s76dbZ9gIVyLkOIDnsVwBGGXuTx/diZYHrohb/gdW9MneEe4C5zmYNS2GMbBv1p5+/p2E1UbxX1eb53p9ldDBynOwhMWubjEckc0YbKJyaUArxelOLXoZ39fBPrrfq54iZ7UoQHTx9pqLa4Vwvd1W65D5Z0zFey/jdsF2ZiUvaLw45lobiSs5R8TPpGJucShmD4Bm9P4P/dfQm9ZIQ==
Received: from DB6P18901CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::33)
 by VI1PR1001MB1197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Sun, 3 Jul
 2022 10:59:37 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::c) by DB6P18901CA0023.outlook.office365.com
 (2603:10a6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Sun, 3 Jul 2022 10:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Sun, 3 Jul 2022 10:59:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 3 Jul 2022 12:59:36 +0200
Received: from [167.87.38.136] (167.87.38.136) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 3 Jul 2022 12:59:35 +0200
Message-ID: <a8c7f093-4b5d-fbf8-cb4d-01d64d0c2746@siemens.com>
Date: Sun, 3 Jul 2022 12:59:35 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm64: dovetail: Fix cast-function-type warning
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.38.136]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.978100-8.000000
X-TMASE-MatchedRID: WqAHBEqGRNxtoWjVt1YIZkO7BmxRNfswyEmFyV1v7QzvZFvZsQkL7ff6
	ZSoNZQrIq4++j0vqJohTHuQZZKa8u1vUH9+4Cp3hgF2CU61NPqS/WXZS/HqJ2gtuKBGekqUpI/N
	GWt0UYPAkdoUoTyX/Hlsfob7LXfYLiKAgbQP2DIcwtXoUeVLaF1EH9I1XOTtm
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.978100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 3559E6B07CBA4D578873F08A7BF680B055A268CCCA320F8139486AD048226B802000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1246f895-e156-4d46-29ca-08da5ce31ea9
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fl+Gt3IBfBxAG3YicB/CcyaeFpxlQaui7FmWNmB0GmwvPO6Tq9zgP1TY+cVHStNP8F4OFG49j0HjPU6KThqu3O+HjmVASuLAQL37hbVHtB9XkCfXfXwJQk56Rflt4V+trro0Rc0tqJ1+AFtTWJMhXd9uVkKm5KP1iax/0G2IdOFXyBonFkzWzqTdnGi9l84N2dSMvnv0QqT9DysUU7DffAGC6QfeyF+onJGq6rvqw4tYR9hENcAQnio7sA4KFNUdG0LkbGGiDmhA+wFe0vnQRHs9XpPLhPJ/ONO25gzkV/PyKpDpmpMRNTfHsqn9lvEqxAaBHbu+IttBkdmEnoTARu4XdB/LTQwD6uv2OqWxM5ZIs64ixr6Eu6pWZsPXrwVCHWBPkVmn+lH7tPe3S2kRkl/SO2GoPDXezKiHxntjzwdgWsLz8ZGwHcyvht4wNta/Md6HxhBhJoUiW9dnG4CC/mWgGHiAVlzswSlflsqWPmxS1aqhJwg6ebCSTycfmEJjdk2htY0GdJemy/YReFTJmyQmDPHwZ00UhDUsom+8dWsUpScigE3Mgkhjh6rksFFeAlkkNVYZeSwQqSsQFEp9Qyw2kkD8xii9U2Z70ejZcOO+jvEGoEZQ88FfvAs9ZnzJx/hY4uuv82G+9GnSXRZEwAEbQtg1RXwKK3pdruPgg/BewG06WvpkVLIpY/QpP534HbnANusbfnMQVwKCHK9moB+XMqQdw/PhccoVPX9hAm965fkzwG9LjiO98pjdgBUcQYIPX9Zh40UGZiabxcgpUVWgD6JTMZ1Y/QNO35yYN1vY5q/wElsTvKwZzA865V2sCm6Wz9xIuu5aG0lpksay/bLJgRKqGFgegkzEj4JSw8ogEkgSAR5KbqfFMdrzc4Cc
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(70586007)(70206006)(6706004)(110136005)(5660300002)(40480700001)(8936002)(40460700003)(16576012)(316002)(86362001)(31696002)(82740400003)(82960400001)(356005)(7596003)(7636003)(26005)(8676002)(83380400001)(82310400005)(186003)(16526019)(2616005)(956004)(336012)(47076005)(478600001)(41300700001)(44832011)(36860700001)(36756003)(2906002)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 10:59:36.7372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246f895-e156-4d46-29ca-08da5ce31ea9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1197

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves

../arch/arm64/kernel/entry-common.c: In function ‘do_interrupt_handler’:
../arch/arm64/kernel/entry-common.c:434:13: warning: cast between incompatible function types from ‘int (*)(struct pt_regs *)’ to ‘void (*)(struct pt_regs *)’ [-Wcast-function-type]
  434 |   handler = (void (*)(struct pt_regs *))handle_irq_pipelined;
      |             ^

which is harmless in this context.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/entry-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 9e7f424aa00b..525e13be728f 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -431,7 +431,7 @@ static bool do_interrupt_handler(struct pt_regs *regs,
 	struct pt_regs *old_regs = set_irq_regs(regs); /* need this for FIQs */
 
 	if (handler == handle_arch_irq)
-		handler = (void (*)(struct pt_regs *))handle_irq_pipelined;
+		handler = (typeof(handler))(void (*)(void))handle_irq_pipelined;
 
 	__do_interrupt_handler(regs, handler);
 
-- 
2.35.3
