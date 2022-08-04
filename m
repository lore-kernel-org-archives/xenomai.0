Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C767C
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 16:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDfjJip26GfXPOENBDfGAavAAX+HUqdBXNCW294prioRyE/dsyQHZJHk5HhYdcXXJRy6xqOwAiLhD68QT9I/pOAazMNvYDE224TaPrsassxvgbypcMIEYCmXkT8S7IwTqpcwCy/QTlGEFsBKM60U2y/kiktV3wa+vCOHNfjjwAJWj93+xCIhAzPTxmi/xcstB+sbCBwIP3nUweuR/wv9ylw4v9H0lzl6QzL5a2n6JjY835c0hgQ3RtD+JSIx4ukEELsNWblUZpQL3RDeS96fB5XuHh99w13LPoxONfybSthSZ8tcHR7/v7N9amDBPzwrQdYBqUIpujVX9tvcrszjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I8emPTsRXEORVmTtCjaFzz3ymDp8AEc4/zA2wKHs7s=;
 b=HMTyfDM9yBwW3/VD7X+b8+VbOe/VeTJxORgAwYntzTfWvz3R5wt8l1AUSCRFF0BpdfizsQCbMbWrlAaivNYgVtlcRmouX1Z+SSQeobJgQYxdTNAzDtTeaHBiP366rlXtpJ2DxK0z9XmLJ1lLiirYpKdHg5spkyt7881KHtXz/wHHwi/1ptnO6N17JUySXdZqNXOUc3ZqYZGU5sCTnx0zs+ymb1gLwYQcMsbw0KWSe1N/HnKoaHrl2HhbJshw4zgp1/Yv2iRTfn16eD1MrMQ3TF4NkFi446DJFNH0wAk38InNFNKCsdURSt/DD7RF26nflyZQAlNSkQt9NOfv7q1d6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I8emPTsRXEORVmTtCjaFzz3ymDp8AEc4/zA2wKHs7s=;
 b=HJYaC3ctnUtMvO6iRrPgZ/zmKq2pkQ/mrjuurrb+GOUR/BNv90BK7dgBPUCy+weXSWf9eMQ8DNroJ4e6wdPfdGoWI+Uitlv2S+p4uHgZ7Wm2QovhocX8U3nQFI7P4Vms5LdICo6WCj4LE9DBFGBIlomX6XLJCp5PJaAC+dy4j9WOX7ObJMtZTpQ/0RSQJhx0PUkXMrOqcxXF3uKqRY8Y3K64F/E+3HU9BcXnTaWjDWIDTObBbsuzSfQ2htB8kT/Ixs+MtVfJ4kg4tk9hKpjlXmgMMmxG3OjwNVRYxOfuIyosks5EMPNbWAw4r8LO3T4HfubJZ3vqMRR/AfpF3QNuiA==
Received: from AS9PR06CA0540.eurprd06.prod.outlook.com (2603:10a6:20b:49d::32)
 by PAXPR10MB4898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:20b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 16:31:44 +0000
Received: from VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:49d:cafe::98) by AS9PR06CA0540.outlook.office365.com
 (2603:10a6:20b:49d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 16:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT008.mail.protection.outlook.com (10.152.2.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 16:31:43 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 4 Aug 2022 18:31:43 +0200
Received: from [167.87.44.170] (167.87.44.170) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 18:31:42 +0200
Message-ID: <ed3dc04d-929d-7368-61e6-152346e2bd6a@siemens.com>
Date: Thu, 4 Aug 2022 18:31:41 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.3 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.44.170]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.626700-8.000000
X-TMASE-MatchedRID: kmNpBCcb0ywgfbOvI+p9gwDlq7aot+TqGadU3UAvu3Qa0WSA6oYLIBpx
	mKWTfsQIiiKPXbEds+4byHGmSgIGYVwGOeBNk8edufB5TaYMPuK24cRwPAxMJx1kSRHxj+Z5/Ou
	UJVcMZhuLxWuV11DGxp1bYL8THayD68A42xyye191/UECdxQMB492x80Zf16UcaD+wPaBYtZK0Y
	CCYqpa5SHOX6v+B+P3f6O+FEJQpgBXz00x6cV6P2jN205Cw2eJKl7ih+SW4+wAPmNKDWsW0HpxI
	zIwLRlu1u7dOF4xi0nIcj2m+H71byvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1
	ofVlaoJlgn288nW9IGnuoSGaY+DLjoczmuoPCq3GYVLW2wrJin84f+/D9dmgHI/sfxgStYg86x2
	7r3/uhbByrRo9qAUp
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.626700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 08533B69547975010B5AF038FD80977FCABF0C15C550B00E586CB33DB95C69E72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f6f0a9-c14d-4275-5108-08da7636d13f
X-MS-TrafficTypeDiagnostic: PAXPR10MB4898:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	syoz8dvtE8Pyk5qjKsJILR+LUl0DPOV6y762vbvTGS9Z/17ovpqbYK4XG/wn/4NLj9OjIA/ceHbkITweIDlaCgvhfUzekfEqiEEjj1wk4XFM7yCjUwMAtsfky5dLoY/wUC8NMqtM3pZ1Ja7Io9Wi5yF3OB3TKrbIoiJfjdigWX0eymrDz+nqxTUGN0ui8RmHakcdyCoIX0xhX/BPIsY16AnVrofhGIDwd+wvIuMyXVKhrEvYb8Yc1udzMpeosAo+qBYVTGJwXfmxYA7x8OMVQzYmiaJB3DslhGBuJmUo9Mt6TYEcJEU55IDYzp1W0UGXi7TUqiu5mJVOTm8bCnzHRpMrKFgOeSMKDCBoH9zusR+WCvv6l2jLolHOHdanO7RK2+FXSjVE1+X0xvYAf7dwG1Up/VucmvBupWa6IWZM9nqWSciNCTW17sU5yfAqdaJVBRG6+ehivxGmq8wL+3yxrjrPHJxUP44IL/LnhckAkj455pXaP2jq78HUIqIb+jYgCYq5pcNHWIZ9bQ36HrKmrZtx5m9JkHHv3x8WvPYAQ4cCJP0bTDlrC3u0tQ2pDEVcDZVwGjiTaUiydDyiG6AmQEUTyz80kJvDaaVOURYkbEOmjBRqgCBulgnO8cNdcMV+ulgc5dsChvcnJ24jPzaf8VSBq/cY824pA+xnT1ItillFRBNbsawJcQ1B/nmJ5rC6qmfXjV43BxAa2whMtqqGSZlwTBgU0EWQtjwB5ExHrh/7W9X93jZApHnAobgtna/T4HaSNYF7S7YZy+DlkhDuH9NaCw2RXIY2UUf4NFORoETB9nC3SZFMmaWhJ0o+GhK/kbp5ED+68Vmk/D9l9KNLtSgpC4QnRParLKOfB7zXLF8PnSUuNZP4mJZPeeGnVBujqcBc8/Gq/B6GTxw5Ke0dgg==
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(336012)(16526019)(83380400001)(956004)(36860700001)(41300700001)(186003)(82310400005)(40480700001)(31686004)(44832011)(47076005)(36756003)(26005)(5660300002)(2906002)(8936002)(31696002)(82740400003)(86362001)(356005)(8676002)(6706004)(82960400001)(6916009)(16576012)(478600001)(81166007)(70206006)(316002)(70586007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:31:43.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f6f0a9-c14d-4275-5108-08da7636d13f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4898

Changes since 3.1.2:

Dario Binacchi (1):
      drivers/can: fix updating of tx_count statistics

Florian Bezdeka (4):
      lib: Fix fallback signature of pthread_mutexattr_setrobust
      cobalt: Fix resource leak of cobalt_monitor
      x86: cobalt/switchtest: Fix testing issue due to uninitialized FPU
      x86: cobalt/switchtest: Enable FPU tests unconditionally

Gunter Grau (1):
      atomic: Use __typeof__ to be compatible with c++

Hongzhan Chen (1):
      process: update clockfreq when receive corresponding event.

Jan Kiszka (10):
      lib/{cobalt,copperplate}: Use valid addresses for pthread_setspecific
      lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub into inline function
      lib: Switch to pthread_mutexattr_setrobust
      drivers/can: Fix lock initialization
      cobalt/thread: Export __xnthread_discard
      lib/cobalt: x86: Fix include guard names
      debian: Update to compat level 10, resolve deprecation warnings
      lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub
      cobalt/x86: Account for changes to switch_fpu_finish in 5.4.182
      config: Bump version number

Richard Weinberger (1):
      cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

