Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605792F2C
	for <xenomai@lists.linux.dev>; Wed, 14 Sep 2022 07:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3sEEeVs9HFkS6RP69na3t8AQcvSOuyrBnN9AcGLZvt3dFokgPaWNqhRDqZiulEWwXvvhR8BSqk1YDj5WRENRYPZ0Rxsu+3zW5uixXQHSlfFQDnLmm57s+41q6r8hTs8oJUkIA7b892fofx5RMvTY2bwm5b4cIOKvXMA77Hfdf9yQOtF19bGZ/y7RyZMX/NWdc8i3y0ttyfSUt+g13EUHsnyEnY4XuoluivJu1/3lotmdq+XIuLydqAH7ZlhzX+lJIGX1IsavG7250Kd/xLWkU5YsJpuzT34asODxmXVmzzrABiUffZsRl2EP0lsTcp9jWBVsUen1RZ5qGmHu/TjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjE6F2KPdQiBcloJsBBibjZXnbI9JH1nGbaw8RfilCM=;
 b=Q/Js8dDsZDwYNsRPRemWcDel+PhOfL+istEMmVmq1tBf1qqgPmRqj81pNyHkkHoePc1Brx02HCJ4iaY+wAWUlLzQULBHqL6HgR6IXoyxtKcdzimOSqUS91Z7N86nVzziL1kdWYHcOc4olZmXhApTWo2eMwr9uswQSfc08RIv1nPpagoNDT5oK9z8He0qHz40HKjQv4qYd84rFFS2qi1f/N065L2AnytNx9DdQCf8DS5xgL5/td5Q0gW7nXoLQLvr4z/f2+BqweW+RcX0nmVEQQiDFc7kVfxolJTosr8SyE2817q7kYZl9P7Oj4L3RL0jqkG394s2OJLBSmjWrpUSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjE6F2KPdQiBcloJsBBibjZXnbI9JH1nGbaw8RfilCM=;
 b=J+Hn1ntc/BOob9Qtmvbz158Eu6P5UlnaR4fZs2mOjQ6G6EnLrOc2sjOMBe4EOov4p6ZNiQOxOth9gjw+jwrOSTONWzXyyUrHWmSiRq8HqhbAp6dkUkTdZoUTpPLhpakCHXoV+ckFvHpC8nzdOrEoH44jar0sJn14u0AcrG5mTxV1PMPPpON9SV3NVTeDYHcfmCJH9FRwBL6mFue78Rv660C0pMZ6S1/Y4ry8QJoruLPBU2iuBuPhh1CaPzu/+XGUY6cIIIoMNJy6LU41eAL6VMXw9xK2Js93cVDRgPhXArFSy1pohb8KAJKjNO+nggwGYBvETZ+iEVXbzG+VoirNvw==
Received: from DU2P251CA0013.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::17)
 by DB4PR10MB7037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 07:37:40 +0000
Received: from DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::ec) by DU2P251CA0013.outlook.office365.com
 (2603:10a6:10:230::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 07:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT029.mail.protection.outlook.com (10.152.4.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 07:37:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 14 Sep 2022 09:37:39 +0200
Received: from [139.22.106.123] (139.22.106.123) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 14 Sep 2022 09:37:39 +0200
Message-ID: <42c19645-fe3d-71ad-dc94-91b54fad973e@siemens.com>
Date: Wed, 14 Sep 2022 08:37:38 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Have a chat at OSSEU/ELC-E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.123]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.010100-8.000000
X-TMASE-MatchedRID: nlklOuxk9sVmO3JaSv5Dehbno+otwiQIk3+L/4zTFEP0hv/rD7WVZPaF
	QCjAYqKnYoFeU+06qpc8lLW76k/zbCvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt
	1ofVlaoJlgn288nW9INJpKYXlUKN05MIx11wv+CM7AFczfjr/7CRmGyJdkpmHIrgb3j3s/cPMml
	JvQ/YKGOmKozBfWeugEajfG7WH6Dw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.010100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: C5F1AB2781E9E63463142B9080D1D19D99D4572698220709DD28FB20D8E76E872000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT029:EE_|DB4PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fad6be-ae38-463f-8a7f-08da962400a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSND6IXYoeH9j8aPktlPkIKyCc9YkqF63REpT14nOPJrvQJvdeOUD8zNuCXM3Qvwb/TTVK9FiV/yd+zR4MgLRs77yLE6ySv1/8htq7itEDLrRsQJjJeaYuaQHFhM1JyG5SeHbsOAj4TWWA/Ks7Jwqc2emcwmWHi2BX1/hljTQx6LZVII04WLOww+q+Qq3dxJQkivUwA1ImV5sK1BBbvyVz3779ChAOAhpQRAHDPltdedivast9XhEYGPg4gXPv9YBI2oB4ebNG0zFbdz/yXRx9mAZCUqcay9QvfeBkq3kYkGHZHqoA/DED++yWCpVT7AvPsocWSm65gaL9GQXapWPcBEImaKcvezbbzBa7BirIMARGcPlA0O8AtrzRxCSHlz69bhQw2pxUpFKnBCxokwZpiQc+t5nACS9SRV6d/t0R2LoS8lPtLKf1+RFGFvHiP7/Uz8UoVj+We6r/Wd+IVie19OiRZYgZsuSgDyNh7lCBZYJJ31mteNzPDW1RE/yAA9bcotlYLTf2amukp9TrhppdK+t58yvxLUJCpNMLAcboUHm9/swnWOxkbJWij4Uyo4QO/4NVFJkz83FDg85VM7jnBTo0e2OL5ILoiHsZXhwkdoj1Afe/DCidfELQ167lWVkH+NlOd/Rb0fLGGbL5R4ceR/k73qAOmvL1RUDMqYC3cYgbFnjhrFz9JcaEUhp2vjw8A8uxrY5PLRuukea8UDNe77JV+n64TTMigfOgwNPTYLn3n+M3Xr1X/dsPyfrcTRjFRTQNv5Hi4PefXXoo5AUDzVeGXUmkyE0ALDNFujcVbUMXaIT6Rg4vGXv16ywGI9BOuI+FrHfp+iufZwOVz62A==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82960400001)(8936002)(44832011)(82740400003)(558084003)(36860700001)(6916009)(31696002)(40460700003)(26005)(6706004)(8676002)(70206006)(478600001)(16576012)(86362001)(16526019)(70586007)(186003)(7636003)(40480700001)(5660300002)(2616005)(82310400005)(47076005)(36756003)(956004)(31686004)(2906002)(7596003)(336012)(316002)(41300700001)(356005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:37:39.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fad6be-ae38-463f-8a7f-08da962400a4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7037

Hi all,

if you happen to be around in Dublin as well and would like to have an
in-person chat on Xenomai, drop me a note, and we can meet. I'm still
here until Friday.

Cheers,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
