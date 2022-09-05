Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6D3D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 12:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bswn0Jyw43kUk3/zJ5OPpNB4r8ievF0hXympjOMpd+rFwjvpq9FzVistHsQ+J5bTOl2gk/Eg4HoAxkXvXhqzbXf3vgoCGttLs6N2u5kuEhZxnKUWiS2ooPdGhgVdDNZGhmg2QwHXPGb55+K8rOzWuVXzTd85xVMX99XdyRzAd7pQIAqY81YZ+SpZHkBbJmHBBWCpcVi0QDdm0gOHAj4Wi9m+wU0FtjEYNzw7JyHjlD4P7NdkFF37pRVIBEShNhxil2mQmMVdzn4BI2zmOKC+AH1xu+UgZQITi1Pb2JJM/PJmLNLtXJ5kl9GBhVAU/aawZj2SXOiVhjjsJU44qk5GZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFK7tBqkf/PXSrdzypm4MlBABzKEGEhpIyM+HIqrrOE=;
 b=RElnE04JhvgFKkIGKdWL8rs9MG6/l+QB66Jsi5B7Cx4haWbD+IkgRIHs1Rr9anzpQRf+JEQJixntcgXGBtZY6MRKpwYh4yp4DRLtK/wTOHyHNyKP5MoKEXHIEOsyATBLvj4o0TM9PNuUv7bt3mGZX0AkXW0aszchp+gNKC7IdcW9gP3cxf1UCi0P61/OLS9tx+FQQrIuH9E4eBw6bnzqe+oVAiE+Yg9Q/ljLtHrBkreSJmMADZgLSbgEVL1AMnbFkaplq+HTP7KDJtw4XTqbDyRQH8bm7zILuaMxJwiAeJvNK6tqHkxMdvS5xRPO4SEyfRi8l220b27LhgMylmYeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFK7tBqkf/PXSrdzypm4MlBABzKEGEhpIyM+HIqrrOE=;
 b=S748cFm5Dakz98L1vgwPa2JL1CcGFj4HQatH4ICdLQ/zEmFbnzNNQ0PCh9QPo8akslHH5jXufawdzvPUzcRurilxbmbevtuGtJzgP2AF4yRG1EJtrY0CITLhZcSiKPnl72oQxgegzv8meQ3ZagT5GOr+kfhRTR97hnTcD8lbNVh5MTGyH9l1TfFFuwjODbiu11M8rAds82mNu/7Z1ZRjNry6AuuDRGByVtMIRwRn30+rZl3pd7b6W/R84bcAUztW6+Los0ZS5tOIK6NQLZ0JUvgUg1BkyZrV+sznJNgvyL1DIUD/g1S7FZmZEe/yXulz1Y38uWZIgFHAPAZ/c4Du4g==
Received: from AM5PR0201CA0009.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::19) by AM0PR10MB3236.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:184::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 12:03:10 +0000
Received: from VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::df) by AM5PR0201CA0009.outlook.office365.com
 (2603:10a6:203:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 12:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT036.mail.protection.outlook.com (10.152.3.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 12:03:09 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 14:03:09 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 14:03:08 +0200
Message-ID: <21a7d392-041e-05e7-3b9a-00134725f41b@siemens.com>
Date: Mon, 5 Sep 2022 14:03:08 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Hongzhan Chen <hongzhan.chen@intel.com>, <xenomai@lists.linux.dev>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <20220822011821.21283-2-hongzhan.chen@intel.com>
 <2b643cbb-add7-fc03-7b22-fe691072d9df@siemens.com>
In-Reply-To: <2b643cbb-add7-fc03-7b22-fe691072d9df@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--7.112100-8.000000
X-TMASE-MatchedRID: RfRf601lRZE5QaOxwNGfvo9bHfxDWoibEEHv4jm9YZTJkecgyZD4ON1e
	FEoaE12nh/Zinvfjw35e9tX9WdS/SkqhGu5PwZpUb8VqO5p5BOLRhEyb9f1sjpeZUDMyphfSpvD
	LLlsAH/3k6Qbi+9i6D0GzU7CKX1sdKprQFSyV+161T0CQveSi0MxAixoJws1YqJSK+HSPY+9lRz
	ZAkKRGDZQBR+Vr4iFospdaYS9obcSXLJHjo+8i07ao0Zou4ee+TX7PJ/OU3vKDGx/OQ1GV8mrz/
	G/ZSbVq+gtHj7OwNO3Dfx1dF4y1d8JBc/L707QiHHJBUJCbEfkl3YD5r8H5lMAp0QS6c/pYVlxr
	1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.112100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 01C5DB0C6C2C6FBF4AFC8B9FEDC367E4F2FDFD9019BA18D5263E9FCC541E7C352000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0daf18ce-be55-4008-c634-08da8f3699bb
X-MS-TrafficTypeDiagnostic: AM0PR10MB3236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tyQvf+92kZxsTDZn5CiKZ3xSgaveQ7athTDbICWeufoGKQe++UNofXoYZPY/WDf4FBAJdyJ4GSGlVEpFNPwVXnxPlbGoSjILE+CZ2Lg7NX0beQOBxyx4EENyqs1Yv8su+Fd+/w8WG+kTcIThvTHzFwmZx2+2Ho8+xDVBQLhM+2sMf1eJwhHc1rsaapa4uezbhL+mIN3zsVd0BHJDq3B9GtF0n+O1LVOkSvh9AY5v4DHj0GFXSeOZGcw+WuriyMRSoSnGGUs1WT2hWwQlr+LCSMYfwIe8pAq8wNI7i8F3Po0O22APolhhtGnFAG/ZFHtCVa/OerBB84AyQzzKoMWENADNtcPju+hCXsuoutGh1mU4uDI1I37EmHfQfL7xUPI+/5jFx8Loqw1BkudbnuXoAK7Km7QxxJEaBuxIaCNdbHejpKX3TNpoxAco9BwvnD5C/dA2yL+GF6kEpYtiPI//VCeLBBZDwdb7c8RFckRw7bc5RpkvN/BMYDMRrUYz2Hhj5Jb+GhXOwdvVJsJbz5OBERskupNVGMhKCT4JYeQDjBEZphf1AZMs2YEqikYJi0/GMBxBN4OWwSla1QFWovDuM2F8TyGho2HVZJGDVYFk6lZuydmdEIcmXyNsKrNinIaGuE4Apfs/IPwXS6Q9gsLCsdlOst1iCpl3dnqdXxmbU7pV78sdABZL8wcOTwMxmcbV8WN1I0VulRhJwRiukZwkdrHZ+F2GxnYv60MlifIFyEevYNpnIttIh7B9DhOaOexuOUs6FAOOZem98BIfRiLxKij0/PU1ZbIRFaDy+vQh3VMURSeU1aCBTRpl6pyl0/CpxEaNodT1VJAo/zQ8UpbYFg==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(4744005)(41300700001)(36860700001)(5660300002)(44832011)(86362001)(26005)(2906002)(6706004)(31696002)(47076005)(16576012)(316002)(110136005)(53546011)(40480700001)(40460700003)(7596003)(186003)(2616005)(70586007)(82310400005)(7636003)(956004)(336012)(82740400003)(8676002)(356005)(82960400001)(478600001)(31686004)(70206006)(36756003)(16526019)(8936002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 12:03:09.6103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daf18ce-be55-4008-c634-08da8f3699bb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3236

On 05.09.22 14:00, Jan Kiszka wrote:
> On 22.08.22 03:18, Hongzhan Chen wrote:
>> ported basic network function not including TSN feature.
>>
> 
> Please enable this driver in CI so that it is built regularly.
> 

... in the future. This time, I'll just add the following to your 
commit, crossing finger that nothing will explode:

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2d4c7635cb..03d3382117 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -129,6 +129,7 @@ variables:
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_NATSEMI
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_VIA_RHINE
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGB
+    - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGC
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_R8169
     - ./scripts/config -e XENO_DRIVERS_NET_EXP_DRIVERS
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_3C59X

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
