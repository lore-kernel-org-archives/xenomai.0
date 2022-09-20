Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96B1C14
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 13:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfI+EQWO75nGj+rq0QCMjPegBeo6KzYWZ6Fre9XG4benRyeJfo3CaiFpgJ6+2fpM26CWkVc8NWCRdS/FcbVxwViMlx1uR/naoFw5WuxaQqqty4AQE9CBN/Fao+qlUar6eBRLxK3rRwhTk1Zz6JcMkSugsclkLcCvm3co0+tm1lZtwDqGhol+A9hQShOoPRi0+DfhGvPdiOihogtwdqEHukCBGky8afdqWhnmZrge+/a0njHl50TZciBHt8QJ43ozTDtDYiBRAjBsV+s2f5/wRFGgIsarUJX3PpqckQARdKQvRIxjkXcNhOfTlXEqiqqfsHB3WeIxLlSyGzBfvlcBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpCVpuOt1o++nck6rf6WV21AuRC4EAsvgZOegrbsCwM=;
 b=Z05IDeXWlblh4WOev/l+v3i532+1ngT2pbHh1XanJJsw4cgEQp3b0V4WGi9HhoAQ3fXbDA8X4YTywpDAZLOxUTweUXiDeQcXL4VdJEC6JDQGAd/VbcprrEJ6/AUherbudegfLrKrWIaxLruFmjk26Mrqp/Q7WyD4t1c+uP+eCRAMdWti5sonrrhfmL8N+FuWg8swTvGZIQeSDPW1TwW3DvfP8jzCpJ5voFU6gb20DHwwcpL2ceZ0pvoidOh9lcrDrj7PSllCI8jFJfz/SAnqkaJ3+sCbCUdDGst/INbvsIj1DBqtEfbcUcohxFE19dmntVb1nNm0IFYag/63UuWc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpCVpuOt1o++nck6rf6WV21AuRC4EAsvgZOegrbsCwM=;
 b=j2aKXGW7cF5P7D2rzYFJI7w41M5Mrp1SJ2bIMVwsjlm5YHo1eO8s0hjSX86K4aaZhe9ZTi7gvdWViucf9cM5GBJLN7ltq7z8Dq9JOPXggizZFsZ+XP2Y40rmySFnUHk+V8eRheqshauKZoLfGkUOY4G92LA9mBX1Fw0RdYZx1Hxrjipcnrq4hRp7fmSMK1Vzvb7MQBzYtc0hHceut93xGEr90zJSbZ6A3QAydhxukOUK0pgsxKd5PcCVK59f5H0rfOjYO3hdgcQU74ZttFbkdM5P1tMPavfrJGkmIMc98lLTSb+UDYhngPcnxbU0xrcw00x9dDiF9wsgTFFYBjjsBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GV1PR10MB6217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 13:15:02 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 13:15:02 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH v2 4/4] kconfig: Add compat build option
Date: Tue, 20 Sep 2022 15:14:54 +0200
Message-Id: <20220920131454.121225-5-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920131454.121225-1-florian.bezdeka@siemens.com>
References: <20220920131454.121225-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|GV1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3cf6f9-5d11-48ea-f8f5-08da9b0a20c4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7A5VGAWWPNO1Jk1yBfIMFYn0pTfLsCHFIrXxjO5mzuPZAVbSVqxzVWKCWQQM3dYkvE/bltlYyjflSdSmAcFxCGqYDlT0jcPQolJbFR205Rnkpnklai7Af/95Zp8wOkvcSIralLfnE6Fq/qOwbafMOgIZvZIdls1tJbG7+jRhf6ZD6JySQrGF523WFnPwDG+HRWsTsVM/2SpxPVDrUGVBekT8uauLXCIH8lmc3jzk4hmQmiRskxLi9LHyyRuaoX3XKnCnC/aJCiKEri0NiiqdLkwJWA57jwu1FmRCBzamVq1fRRn3zkEueRx9jrcs5LXGnFZBq/c1cVRgjWA+j/dVJ1bVCEdeKRr9ossqaUYowUjN0AiL+BxkywsaMXQgJNPclcDJ+DIstaoak+5Bwk3csG6cu9iyR+bFFyfKzOIMVwEg9i6JSc4fIY97t9kMkRNvSFjlya+y3TBnmt5emjoDfPmFWfuq+hYU58leZIAIhbtxB0+Uvuk9k7/+ewmnLqw50tuT661GxrQVO0tvCdD8L7bFBPnhfHmEMepk/nNLKxU5YTget3NahaFTWSD8Oy3EVtELtZTg9EDr5rHltJ4NILuctlQ770lQLE36lgKXZXumgHcruyGawtBvHJnIa5k1L/8bG5hB+DzmvpuEBXFvmLLZ/p/jdrwPuhXSGcLQeid4ewaQXxAv/n4A0IpUWEc1Mz6hnfNeQvxCB5F81UGIUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(66946007)(5660300002)(66556008)(8676002)(4326008)(86362001)(6916009)(316002)(82960400001)(38100700002)(8936002)(107886003)(41300700001)(6486002)(6506007)(478600001)(2616005)(186003)(1076003)(6512007)(6666004)(36756003)(4744005)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewgokRFnX2p0trDTZ7LcHKyvVsXmb0/3mXkKsQ3J6mcpArkqFSEztqB+Hudw?=
 =?us-ascii?Q?qdrkDoqcVhGtE2aWbujUQzvuv2al8vhQtwDNfR2v0xsFip/vN2PLZHLJHGpg?=
 =?us-ascii?Q?8dNqKL48BFONqf++uL6qXPUGsMAbT3WysuE2Ik8fiG8akdOl7tME4SKNpKRf?=
 =?us-ascii?Q?9mPqf1Z+fWej3r6j1Rt9b2YydKaa+XGRncZT+9WkXjD0fLup3Fyy9hZMnuQx?=
 =?us-ascii?Q?3AudowHiwtkhwgyYc2zCbExo0V79HInpRpC7OignqNdfJCYsuTjpJJmCM/QD?=
 =?us-ascii?Q?u8zmJP9kapq9ElgBIR2fGEYXWdydaPE4OoWJ++N7yQXgsTh+5jD1As54zEJ2?=
 =?us-ascii?Q?jvzuhAOn7bzzUopPKYrm1CrvOTaJWCZRd99/EaPWfUGIdKXH5jIMH86Tg8bJ?=
 =?us-ascii?Q?fxf94EHYzCVJEfuKk5ZOTP8Fr7YlwlquXjuz33es0wKyvgmVKBO3L//z8DXo?=
 =?us-ascii?Q?aZX8iSeLMidQalFdyVl4QyXXOgohvd6x6ifqjIo//YQyBEGYyM9cb7geWZmB?=
 =?us-ascii?Q?iqg3dsdTKW9ECftbBTkwNlzALfkPtYcNYbSSgUchxA51QGhF6exiPLGLMJvh?=
 =?us-ascii?Q?t4DhuHwe8eziOun+x713rbsdCeN0N0zTkPcH9hFKCcPgeha8fwS30Mu6xS1a?=
 =?us-ascii?Q?bbag061CFV0YLykUhWI0f/1V228WBKneaK+dSNEUuYaWbljnDQJSYwc8TDTS?=
 =?us-ascii?Q?Sx/+p0QXOll2GTDCai0U1rmecRTnY2xBIZHNI7ivCvTil/8kgHP6Kx2jElcj?=
 =?us-ascii?Q?tstFSk6gfnIowBoAI1MXrGM3mXhoz+uePiloqf18Mgjysnl9HkJ/8OHEKrjg?=
 =?us-ascii?Q?QfUSwGQghLOXlAA30KzpW4PKe+JfyWLjeTJyhJP24bdgzRy9yRaB9p8Tn9uc?=
 =?us-ascii?Q?Fr272ckZMNyw/3VyDdiJ2cz+hHTFikaVC6qa9h7liugKK/Wj6V48gaNoYkrP?=
 =?us-ascii?Q?53pZ3ZCXJxIp6v79uMPj1ytLQ0t8Tk+NwGsWnoOOol9jj/5LP9K/U8cnKQHd?=
 =?us-ascii?Q?9J0Xci/FZnOC/pho5rAUYCPjYN0LgPNdOuPLGFpcbRyZgkHSl+/ByM63VHlD?=
 =?us-ascii?Q?f/oWKi6VnqH0X8y/NbPjo8f/VTAbEEaNX7t7N5LAKOEfyfu7z2BMauylWUqg?=
 =?us-ascii?Q?/Xh+jEXW8c1XuVcOHAzJTRW0Yxk5BiqtiXYi8mf2CxEozJFAO1hssdX6LtUk?=
 =?us-ascii?Q?3WYIvrrygFmNVGURnRoRb+NhtK78VsZNLl+uaXKudeHInOlH9hWBgRV5PE2G?=
 =?us-ascii?Q?0qTU6iJuUgsmiag4tYBG1AytohF82mgU+qittYrzRYLwp2BDWFjHBkErZF1S?=
 =?us-ascii?Q?jYX9z2O6rQVyph1OXdKe06ERvzeK4o9E8S4Dzl+5DhrXkM5nAtkpNixfB3gZ?=
 =?us-ascii?Q?sED/OvpkmSMhg7u4V4wNlvaFoh/NB7XXXH0MvDm1o2aTp9SgqOxinSo856lO?=
 =?us-ascii?Q?AYxntpbpBO4ao5pHmJnHfc3rI/DHqt22sJrm2VmOQkQbcDLMt4ruTG8AnsTx?=
 =?us-ascii?Q?L8C9ifWnJqZyywIOXdmU1l1ysniX16UwccfKqSwAShbIX4y3X27Pu/8U6O0L?=
 =?us-ascii?Q?TicqacPecJUSbf8hdO4srJELdm5hT2SgAWr4ABXUzWC7LaWmIJdnJuPJprPA?=
 =?us-ascii?Q?7CpixntvcuHHKh9viU7yVvDA2M511lNOxh+YCd0CXZFZZtf2z5Rxei3e48BE?=
 =?us-ascii?Q?nz6stw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3cf6f9-5d11-48ea-f8f5-08da9b0a20c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:15:02.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhcKZXD6ZBhkeN2XoTBgsAUZrNE+4JOct10RjtyQJ49F72eSPysBXq7xY0v1HWCJpaZVBwOCdd0sY26CM9/83igyMmP23xv+ZCincFCAah0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6217

If selected the Xenomai userspace components will be build as 32 bit
(=compat) applications.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Kconfig b/Kconfig
index 1e3371e..25e6d8c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -165,3 +165,11 @@ config DEBUG
 config KAS_INCLUDE_DEBUG
 	string
 	default "opt-debug.yml" if DEBUG
+
+config COMPAT
+	bool "Build 32 bit Xenomai userspace"
+	depends on XENOMAI_LATEST && ARCH_X86
+
+config KAS_INCLUDE_COMPAT
+	string
+	default "opt-compat.yml" if COMPAT
-- 
2.37.3

