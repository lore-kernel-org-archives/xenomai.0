Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60108.outbound.protection.outlook.com [40.107.6.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053310E6
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 06:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVqCwdUT44nYyHPRT7YkzqvGHW+Wl4zz4AWgXYW0DpDnpT6gjb4jV1hVtifG38xKY27PDBfPmdXfQ+e8TVBVJF0qXszC4+Du5exjWOuj+idUGiIeLQxXscrm0EdqfiP0xxHleh+ueIZm2R7QjS7uQpael2n/pRgHyX9lKPaBPADa7AvWyuXm2XyLJibmvssu87332msL8WAsB92XKGIaydqeuAGlffwouYUzXU2J5TQDFm6VomsxH98InaKGqHnYQF2lQWFhaQ/wto2Si0KI5ExJuioOREe/dqLFQl3CWppYzGIjnNKEjpkBe5f94iOb8bweuqPiueYm3nT0RYmvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMVBjy2X5WYZRzkRoIiC3ED9baHXuf9W6gx6v81wdlI=;
 b=Z/2zwDrKNDWIMB6DMlYzUhXQBWpHIvybIvRiu0xo2jyOgeNgS6bUjOPN0g9rYs1Cphw61qN1mCQ5k7+hBdIIB9A29rJdo8labHDsRQ2DCe6WEsp++HJFyKht7g3lsFhzzucmtOTV/G+EuMN5FPu32ewoQive+6QAUClIwOexNVFA/kyFvh7VN0C/EPWpESke2xZHMlXs35O2AFPljN4UIav6WxVseqZtArCDL+cLGPc9502GAI41gdxl8kqnOQmqsVer0Gy+j7/ppoLvW8WsIedFq5nUOVlJdOpUJ7beE0ZEUBoGubLDrZn656RY+XhhhfEzCV0d8taURvcVuE8P1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMVBjy2X5WYZRzkRoIiC3ED9baHXuf9W6gx6v81wdlI=;
 b=DcemBZ/jLuRjD2z4966k9+WKC4c9xfdGVOZ482i3HSqGZtvtvM4DJyQKOPLNPWBbxgwdDTXf1rjN/WlaV6HdiTVhe5gDhA0JPvC3BSqWR8cMHu8eyu0mLGy0+4M1MrVcGGcU4HxmJN5DU2O6idnnKfT0ibnpc/oROan3j9agoX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PR3PR08MB5739.eurprd08.prod.outlook.com (2603:10a6:102:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 06:28:54 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 06:28:54 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: johannes.kirchmair@sigmatek.at
Subject: [PATCH] fix oob_trap_unwind call in SME handler
Date: Mon, 17 Oct 2022 08:28:27 +0200
Message-Id: <20221017062827.2589013-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|PR3PR08MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: ec46d606-032c-43d2-b46b-08dab008dce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gl+RlXSDrANwSozacUv6MtIKUisM0MRfcL/CzMb1Nm8YVKprEU5bE9r0dCzZ0qUK66kIEJIKClKsP7t6EqWDxmhdcQQwLvLYnZaaD7sThwq8ipSVX1UqJdKohjuiljbYgBAZD6ukj3Y0dFlXDQLmlla0XsSQ531BOhs3f6RN/2N2B61FQQKaQnTpVErMmVh0i0Z0E7echzEZejESq5Fh8el/WopIrF56b2kywd54jhLb6L+yrZSs5OWdSEtgKUz5Lr1kIxqAemnPzCeYTBvL+DCu8rZHv2kU+VfCQ7G8ya5V0gUVU6cd3y5hbpnjCCMK4LuU6ifzK2YTDsBF0BWBttnalwnzLlLFUts+z0aRTQZDlyVNJ6tHqXVIjBZ0JrnHTGcMjI71TGHVbzRfID2B4FE8M5GU7Ueu1vJ3k1GHSFQmIcyhSLgEt3iU51NLe4SaMob4tt/la9qdN+6Ef5OFmbdoyjsjOXlUzXIfG6I1Qn1HjTR3ZCGJTBQx6rFh8gUrLw/OlFFRe0+rrEVz/JohN7V1+OfP6+hOMuFrKh0JgyfqTuH++Zz5z9NMIKMuZrpIqeVdA0dz1uWc084uks1p6LKoxlff3hWgi9cct5VMXZ33PoeafpjPSa/FXjHZWnYofEfpSAigfV0ElbubwYD6OhJVoMo6DLCTDsd8kRWgz6KzQ/ujWgrOlNlWYS2HOSkSbvSV6ymllWLaDbcJ/7UMbzvCdCFep8J85tCgP53wD4Y/yhtf2KitJ8IFvTyWsULnuvszV1TNMspRuVbGgjlc9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39840400004)(346002)(451199015)(38350700002)(38100700002)(6486002)(478600001)(2616005)(186003)(1076003)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(6666004)(107886003)(6506007)(5660300002)(36756003)(26005)(52116002)(41300700001)(6512007)(8936002)(4744005)(86362001)(44832011)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEAGXoOx9sXcEmVjvwCUAnZmLNUbDKDVFMb2DA6kFFMWGky0cI3bLJWy0ySD?=
 =?us-ascii?Q?hG9EWFrl4gp4mnFCaKdBWgEtyRmBAOYEHdat7oxfOEZ+jutgTbf4aVsa/+dF?=
 =?us-ascii?Q?Lwy2MIJTzHJgwmWX1KhnFnb6xPwg9iqEaTtbRl49tkwVz3z+V0RTq5ewi3fE?=
 =?us-ascii?Q?qtcXl76f7vBm2minG6YM8EWykCqoeV8EQzOssp2SX4WDLEtLx81xmjB5Az4m?=
 =?us-ascii?Q?C1gGQF7XtBOwsUg/Lah8jAEvvnaH4bwmo08EAsc8mscrXmOPx+BtLFt5eCrk?=
 =?us-ascii?Q?DMEBv5S1U6AGRMGuQa2jUuxtX56FWa9Imu7d6UPChMCcrhdiEgQ+wQosHFwt?=
 =?us-ascii?Q?9JZ5c+OlbomGnB1MH1HEItgqoCgZHmaBGflB+WpCF9+acdy31ckeMJ4D9S9E?=
 =?us-ascii?Q?k7GAJEKWVECZUTqrgRr4dokmnWlOuYdraFh1g0OvdUoy21Vam6guRTTwnZPw?=
 =?us-ascii?Q?QoBasstXxuNy8g4ia6Cu6hK9faE8jUbWUJRrksPP+9SFH2krPgzY13Lj6u/O?=
 =?us-ascii?Q?Z8fR/yC0NValnDvyVp4pZipSjlAiqveKqfrP/Rwvgo00IxPf1QIQ01wq9vMt?=
 =?us-ascii?Q?lCs6LsqJ8JiJT+s0BMEer8YRYkLU9Z9qabMLWuJSrFBWJhyA3LiisfQXvLn+?=
 =?us-ascii?Q?DeqfvwMzFuEELTtP2QEsNssFDZtfvjSKpPesmgDaHZqGHPu6uNDp48iEZ6AE?=
 =?us-ascii?Q?116VGwrfzDkzp9oebo0aAjJGCXAd7eOnjLPaWHVb8H+0tDdXlurxlIFpy/56?=
 =?us-ascii?Q?0eu1JWK3YBRKvar/JoG4Q5Z1ETQW99zg1+mIyyQDk2DliReuHB2zSIuU+tph?=
 =?us-ascii?Q?OPX0nS5GAnnzJJx2QhJPUN1XzD4FmcVTbc3swkC6GPWq/N7+/lUn5JqjWBHI?=
 =?us-ascii?Q?OQOllPgSVKaL3GuEjNf64jJEiiWj5aJ/7Qgow7bV6EelWJ2x5zLkTtHKs8TG?=
 =?us-ascii?Q?3tu5Gfe2xkzpyu+5qBpTTnncdFdPzE8AwI0i4c6UtaNRu9f+VaCTV2wTdscs?=
 =?us-ascii?Q?/0dYMKv1Hfn0fRioiCk7pdGMYKKqqxsUTHttqpVIeY7wnJJQ6Gv4gSAJLD4c?=
 =?us-ascii?Q?1W4iMUFcgHC+1MUx3SFXbFXXdnv3yG2J2wi6cU4KAIVRdEsyY/JBSQAstWX2?=
 =?us-ascii?Q?1rQ1GZA2bYLJ9liy5OcEn0EVC3NKYRr74TntAPFyO0LW9r6enYZTCnjoDfa0?=
 =?us-ascii?Q?WNzBPvnisNGbARqza3IrM73clFy0DGlIJng+YX9HPMVOcev4RKWqwAdsFV/N?=
 =?us-ascii?Q?YyuZxw4xc+r84j/3eprjXl+HfnSBPpWMtupCpvUhxbuqnuSpoxorNXXYosWf?=
 =?us-ascii?Q?F7aH0HO0mOa+t+gsdMlaMCnLAA9LYEJoLPVM7YgxRTn2e0PAQQxpVbH0wdMQ?=
 =?us-ascii?Q?kW/v5+zqRkx3hGYtWVujh8Zawj8hzgpvviQ3SK71sl4R1jD0H+YebtJuVdy6?=
 =?us-ascii?Q?xFru5Ff5mrDKPRv2N4YDG1UkRRqPNNylkFhAGZ5DfgEJB9K8xGT9eHeUVKUU?=
 =?us-ascii?Q?V9rqdNFZsaMz0j7vLoFqxexnV09jZlLIkBHZE2OYfaAIF282p8TQ4XYhkn1i?=
 =?us-ascii?Q?1XVGIGFEt0CCpEaORty/6ypwLfLnKIByNC+eyR8bg9/1fJ3PXvTl4IacxIzE?=
 =?us-ascii?Q?0vhT6UgfWLeBzKEm1f1RjOQ=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46d606-032c-43d2-b46b-08dab008dce6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 06:28:54.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIUnb1aev19KQA7OWjydAjwJUQKe1XdHeU7F0PgJAkpavgNLhnjdcrzejLtrPI3D/KgLODaVJo26f5e9Txzoqlm2KMpamoOXeCBePshfCEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5739

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 72e5cb8e99116..be2e3ca8ce877 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1542,7 +1542,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 
 	put_cpu_fpsimd_context(flags);
 out:
-	oob_trap_unwind(ARM64_TRAP_SVE, regs);
+	oob_trap_unwind(ARM64_TRAP_SME, regs);
 }
 
 /*
-- 
2.25.1

