Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34CA3C
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 08:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl1NFPiFLT6YvPQe2kS0jpCThClITVOrioxgvlBUPJyoAoMkVrSAfUV06rwRmMvSr4ODuoIbiwvgnXgS2NTBw1xjdcUFzOG2B+USk6RnVoAkQQwtb8773gc8ac4lA5NZzFzwPqK9glJKkOhKF9XHUFCysF3eI3zzP7nKTd0QX+yTfdMUe4SkZWpVRgs1cgR1BqTePTH3Yy1Rx9UP94kXpNU+sYGhO3rUxAiyxltFswEvdxjbz0Awdw1iv8LBXjjVsizmnOuYCFckzuJ1wBK7P6whYfwe15kDtbshcIQccOJPxWewM/KfVbMjWoR5Bp8RevTmwB4xAzrTw90tYOWZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0v4Yynggq5Q7gJ02XO+LcRG6/2XWmzKO7ra8uHtc1E=;
 b=nz7UAI8XwvQSKeKReJj/UoeSD6crw0smzu2/AMOMTj9ohFSe7rIHYXpw+YNClqwGYMuhDhoki7G2HByOkw0gOP/x46iR+e1JBQjS3VBsD+kaPXQWNFhnFlXGpPCaNxY3VScFhb24ySt2Pa0O8FaN93XcTGSRy4iV+8WNxLD6XQPJgydWj3NQPMDjrZhVQY84Pwupy+f5fbKAo3Xd+0i3QPnheWVCTg0/BSlAHk5OhBfWtz6AomboUaX2o2czsi68kW6MiCimocg+bxMNnH3pr4kcHHWZO81BVELKn2w1wI4qHd+AymRqEbXKjfI6YuMLNJICL87wCTvE5gAMjOqtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0v4Yynggq5Q7gJ02XO+LcRG6/2XWmzKO7ra8uHtc1E=;
 b=MtrarOEQpv8lXRxgZKWWkzmG5lvkBVSoqHlQlzx9d+IOX+2rNJGcDt/QCTb2B6E3OrSJ+W6SS3QBBKsEEgLpSx5vEHgZZ2+ElC0e6BVjBAfdMRJiR3AaOLXlfDE8G3aYtDWbqtHRtEpB+wqSw+i++qw5GuaJL+F4E92FdoeriDosflx3ULrXoq0RABQa1G0up1es0LZriBDizHBfET4u6hLlxJtTLUEnuidR7GF71BYP1c1d7Au1oDDJtufLK7ti1zePJU8Ssgm01K8Nj8BNvRClRerd1kzC3qMkOM7rLbiXNeothlL3SniTofSLpuPcUIX9xeMSIFr8U8mAH4UhyA==
Received: from AS9PR04CA0084.eurprd04.prod.outlook.com (2603:10a6:20b:48b::26)
 by DB7PR10MB2540.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 08:04:41 +0000
Received: from VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::7b) by AS9PR04CA0084.outlook.office365.com
 (2603:10a6:20b:48b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 08:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT022.mail.protection.outlook.com (10.152.2.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 08:04:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 5 Aug 2022 10:04:40 +0200
Received: from [167.87.13.201] (167.87.13.201) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 5 Aug 2022 10:04:40 +0200
Message-ID: <c2c8a20e-0298-60f3-be88-4477be6c95be@siemens.com>
Date: Fri, 5 Aug 2022 10:04:39 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH dovetail-5.10.y] x86: irq_pipeline: fix build error
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.13.201]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.596600-8.000000
X-TMASE-MatchedRID: 2YihSV9ltyJMqWhw3u66AjWKTvg67+YaLGmmJTL2jhwD2WXLXdz+Adi5
	W7Rf+s6Q7FgZhHZ4fUShd+Zm6Tr1PCnr01XIBwsykZOl7WKIImrvXOvQVlExsJaWKijZlsbB2bN
	x1HEv7HAqtq5d3cxkNYrzfbLGBGWN6yiCLq5ckmkFBCBFSx9gb6RPFsb7sdf3Yd/Gz/KCZJA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.596600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 4DB40C49DA9B5375469A750B2F9927A8811AA4101D6100410DB91A11B4CB30B02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec69fcb-d399-4e7d-0ed7-08da76b92686
X-MS-TrafficTypeDiagnostic: DB7PR10MB2540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nyo4QRo2q06vgkVzDgk6vQAhUolPocm78UlbY0sjub4nYWxpjZbA2AdZd5TYydpCRVLa3kgwwat13CPVLZlSWghp0jC5PI1+UcT9qXVhPygxcC40GRIb2H0IRPxV41Q6mzRT1m9YrxrDGSZHN0/mHgUKuprRfq9T2JBj+MMUe9ptM5pMmamoNIAVnsi40J7ugN/15tMqWy8xB3WTxiORgizkGLHg5qaiYkGSQIXkg2b95LmmOabmyznbHErRpg1iuEDGn35HOMn3k+qy9NUVxV8gxnDfyeGDPz+CIjANriGuhvgQF6dQESlcIAXU+FqekE5dPH7p5//gX6223rIVej5vvuRmZN/UbP8AKNITEtZ0K5S/G8AhlPKGa+hm/LXIcqqpsrbpdvVUpOOcqPn9lIiso1Y9SZ9jTbUzg8iSyxYGKiy+hjQ6tRlmmLJcHCuw8D6SjEAAeyhD+iyZbFFPkT8IQZoinrdu5SXOfzWxcplDFhnI3DyVwJJm68MiaOV+Vzi3eK2hWsmuhwLTwq7YWXT2PjtL2+fS0mnkq7qu2b+z3w6y+MqWDH6IQ+Yb/XuhwUa9u9qiFCeeGacH5boZL/yFFbSswvk/Gyl8roK5h9zTgZ/wKIOqZSLbjAB9l4ajdwQkfpcsXIIm4ENzbtgXvpOFVkkzMySOaviq5L54LC6ydxOOP4Q0SNG5+BjcQzmxitn1YwGladMy8wbpgOIwk2ds+NpOTxZUmuNbcl5S/MYcPIMCv0myL3jgkyDMMf1dNstP4LnzCg4F8JYMKohkhr3IoB9KmBRUSw29Mau3Pu3TpHq4wB6w+EK5mOQnJZUyaofT4JuhJ1C2xN9NuztCmBNOfy+LhavJj06Yfj0LqMz3XgR3OaYRG0tQiFlZ+QXJs3FSljyCo2QWCprN1CcqYw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(40470700004)(6706004)(16576012)(316002)(110136005)(36756003)(41300700001)(26005)(478600001)(31696002)(2906002)(86362001)(40480700001)(82310400005)(40460700003)(70206006)(70586007)(8676002)(8936002)(44832011)(4744005)(5660300002)(186003)(336012)(956004)(2616005)(16526019)(47076005)(81166007)(82740400003)(356005)(83380400001)(36860700001)(31686004)(82960400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 08:04:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec69fcb-d399-4e7d-0ed7-08da76b92686
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2540

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a1e7ba5e0ac6..c08c2e21c227 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -369,7 +369,7 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
 
 	flags = hard_local_irq_save();
 	add_nops(instr + off, nnops);
-	hard_local_irq_restore();
+	hard_local_irq_restore(flags);
 
 	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
 
-- 
2.35.3
