Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30062.outbound.protection.outlook.com [40.107.3.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C57C
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 16:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhkPJl7kUhRRn+0j3F6+otkVuO6pMJsUkqywqs62nmtiqBO3HpkCM8WaQUaZry4iP2yGLLMVFTnTSsIpX6arnysVcCE6Ms6vqVYci9x4FMYh4OU+XHCkBCPvCZIKvfp5PmRYoAeEAjk6aW5bE8sb2oQ6g9S1X9ZTfRqRrckSd5pEqsaLwkx+Td9MM2mL45N8msJgm52UFfMYoi23d0W3ZeL9S9UFkhyGYxHxNZyhmIkmfQ8C5VRU/ZZ66phCIHx6czltuMIY2tJEEqUqxth+Wh5fuYzuHfSmuDNkseMtCcHQdGPMaZB8mC3R32l+T3JnWD+wsTP6ALs9ayk43fW9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPrIMeeXrHyev+RmCbpo6Id50KWepkTdWKObYY/yrUM=;
 b=OvW+O4mDyQouG5535u5Zyf1dFKzWW1jtX/Dixr4VDexYfkn/42EUTEtBd6D4WECXCLBAWxXzy5lJf7DzHe1MZMzs+35CyyVY99PL4uBe3NY1y1KQKZlN8da0VbFdpuiMinNBGAHx8pJavZHA4HCmNIQRHM1J3paznZH7kypNDKo/WcoG5MPgMLR5fiGVY6wnVhUUgitsWF2J1sYFjTcBfgJrs9g6UDftrkrC6IyJGl8ps6Bkp/dmlcZ5ekZjwMJMPsxWPsbR5V55wgjZZnT9ja3qX8y/Cgpo9B4qq2fJdxpujIAhx7ShVJeW67zS6bw9scrFrDeQMUf/mwSjR00OlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPrIMeeXrHyev+RmCbpo6Id50KWepkTdWKObYY/yrUM=;
 b=np73/bmL/rga/W5HcF5a4JlG5yh3M9GR9zS+J32NiUq5eXS6bX2+uA7a0xQjcRpDhejtYvYWJe3GUvx1yUoSCRk1ZMqHVi/TYislVJ1dz8kCZeo2R1JGVMmlKATG6tsDA/zh32utat7GqwrD/IZwCppKjNJGyFVlS/7z+I+OQBXhRTcOW8DiddxJECEBy3TMRaUtJQuHlK19WnW5cQjsUv/gxNgsd9ab8SaGdWU4wvrEqiaQWjxAjxSHVuNE8KU4rA5765MfP+rT7t+fP/CzUeIRdGc7ESO7rXZDrXep0CLHtC/xiaFgxeNBWW49jjQDHONMmKWbgsYFgJJYZgVEgA==
Received: from OS6P279CA0019.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::19)
 by AM8PR10MB4258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 16:33:52 +0000
Received: from HE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:33:cafe::2f) by OS6P279CA0019.outlook.office365.com
 (2603:10a6:e10:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 16:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT107.mail.protection.outlook.com (10.152.0.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 16:33:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 18:33:51 +0200
Received: from [167.87.44.170] (167.87.44.170) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 18:33:48 +0200
Message-ID: <cad2cfc5-0102-ac50-8f9d-8846ff41a85a@siemens.com>
Date: Thu, 4 Aug 2022 18:33:44 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.13 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.44.170]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.728500-8.000000
X-TMASE-MatchedRID: XMldhql/r89h7poVrgVUBOUOT1BD3midzHTv2iNHI6IBnSWdyp4eoVM8
	G40owbvKuuEV0kS1ukUJ3+SWYfjBlcfXZGkvUTlWBPz0I1fTs6a24cRwPAxMJx1kSRHxj+Z5/Ou
	UJVcMZhu5K2LUGgeo9vqnWOWEsAkCp7vpULqxGgpHPmHy6OeVI+GMXGf+9XJ6iVJZi91I9JgEa8
	g1x8eqF9bu3TheMYtJyHI9pvh+9W8r59u/gzv5MLUzq8RBkJuGcNYIRle9ggeeAiCmPx4NwLTrd
	aH1ZWqCO5QxsrU10s/6C0ePs7A07fcUt5lc1lLgkU6UkIr/V+20QRlrBF3eZQqdC8PFYocmWUqK
	QMzO+nwECsfeKUOCOEPCxrZ161lv4qS5y975+RM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.728500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 279889F2333AE98F0835C57C37CA5B85899C7E3673B36E52398B12667597217C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9374b09a-efd1-497f-0504-08da76371dc2
X-MS-TrafficTypeDiagnostic: AM8PR10MB4258:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHV8STxVQSKZBPbfw6Q5I/QoQ4AfCQHD7i3IZi2n46H/IEZ9m15zjjyXgegcTJTxtPRErhNzX7RPJ+0DWPGSwoBZJ0+As6rnBEU9rz6IKO+X8uIMiWLrA/m3lcqJxKVD0wwNTZtzPcO4zn64YVVEO3v1aFWxMj8o0CCkVj0Y2Giv6W1nhD6o+pnMWPb2PqnaVFCTq/zkLfXVX86l0ytlqR4qVP7pYcaGJi1RoP1g2gv/oAV0SWQ2XQ/WeSrZS8SDy/n0GMvMpuj2vUVfolyRIlbaAyvYZ90dKUniQe0BDD9oa5grfyRAWePxTZVsUXH7fMoWxIva5JSJPe6PoQKt+RrQymM3IfWXMj7FEMJz4AzqWnKXioj60siXq8KPsM/WL/w6lo/aPLYXBQdXo6Rkfe5up8lZoBbso/wRjqUw5jIBvLJs6mbRmDjHhRskq+nvYtC4M5qbx2gToqRZDYLQp76kX/gSOTjp0psmCHcRp8BJOWKZQqZisHSarqH4R1IkJjfoPRV3THaq3cMjFBHiGC6bKu1v1ohYrGDvsQ9hgCIeAGpF7qqLzAY3eNRZnII5V0K9oB6rTKlc4Px3G8vUlGZ/iuQrf/kN0/BiGjWyZ41FZYO5V9vbUmVZOMWAoVoZ3iaiPMMsZffK/dCsPOrV0AXkSQVQc5yAB52PT/5Q5qv28Ztv60B+1WkHOYooCrWfi2e2qyUYuoQZgttXZDEm1He8KydhnjdNTSPPfu1Oqe2QbAXqXZrFwLmYMS2nl9tXx2+8WXoxU7BrdFUYv+dFLB7nwCIVowiNlDhCuOVrxRC+3eHP2eg3pJ00xzl7/3DwxvyNGE3RPIgcGGq3bofe6vbcb7nGUu71lcLm7XzCzLECf2L6q97PXIbNO9QoTEsnF7438VQB5iu1w6aWRnqsAQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(41300700001)(26005)(6666004)(82310400005)(2906002)(31696002)(82960400001)(47076005)(356005)(81166007)(83380400001)(956004)(36860700001)(2616005)(16526019)(8676002)(186003)(31686004)(336012)(70586007)(36756003)(40480700001)(478600001)(8936002)(70206006)(4744005)(40460700003)(6706004)(44832011)(316002)(16576012)(6916009)(5660300002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:33:52.0098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9374b09a-efd1-497f-0504-08da76371dc2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4258

This line may slowly reach its EOL: changes getting less, and the interest I hear about as well. Let me know if you still depend on it.

Changes since 3.0.12:

Dario Binacchi (1):
      drivers/can: fix updating of tx_count statistics

Florian Bezdeka (3):
      cobalt: Fix resource leak of cobalt_monitor
      x86: cobalt/switchtest: Fix testing issue due to uninitialized FPU
      x86: cobalt/switchtest: Enable FPU tests unconditionally

Hongzhan Chen (1):
      process: update clockfreq when receive corresponding event.

Jan Kiszka (4):
      drivers/can: Fix lock initialization
      cobalt/thread: Export __xnthread_discard
      lib/cobalt: x86: Fix include guard names
      config: Bump version number

Richard Weinberger (2):
      kernel: syscall: Correctly check for x32
      cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


