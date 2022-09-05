Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C413D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 12:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BabpZj6GQG0OVQWOm8LvKuKMsVr2MvPtA1CC+402zbgvpsoqmanS2WAW7ShRChjyPp0+qu6wRakItWMOnZI1RbyY1dm7xOcQd1Rn111R9Bb0e5MWY+klsmvJisddkYlJrDGwbMb29BhU2q/Ynsxgp7pK9NZXxCeoxdcb5CtmkCtGCKtir1Pyp37xfYy4gPZi4UYegWmcbzv4ViiS+PQd/uIiuWG924PIXILw5gAD4jVxb2XJ8RTuCbohhEToJvIVrOBsPJDgG2uJWJ2A8a7OvpQzoQFvvLZbkqJIch1G8rzLJVzRXSoQA3ps/MIu3Yx0obsfifrCHw6jXC7hdak/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68/bzYVPiudK1V5GL/3TaHA/WYvmh+yusNZerlljR6s=;
 b=OLNWUMwBWrZxCN/DCqbK6IBVL5eMTijrSiBB3V6fhwkl24tDhW9/d2+o0PPR5nqDlukunNvxYYkFJYAd5aOoM7y+iOUM/qOTY+XxHAv26OmWIS0Wg1jvMAIATI4DHKFvwC//zfE8Sc+wndNxtx4N04It5MCduzdapeoTUZia0Qr8W/eVBU+oq9DiTh1gsg8SNUOJt9U5F/94JRDEfWfq+P9iOYKWChHJXDwzYlJtG+cDAF1days4gdqLVWO487Vl61/jFihxl/k5IWq+8bBYIA2aQQHT5oDskrIG0cKIM70N1+hknQnUFqNYt5NLhIFz9/m1p5HG6vERdveqfvgUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68/bzYVPiudK1V5GL/3TaHA/WYvmh+yusNZerlljR6s=;
 b=Re1yphjIPlH8rJPGYMYiT7M8KyPZ9QGmjcgI3BHHFw9SEXmEz6jqdhmRifovfXSYKGdVmneDN1u5NBFIV+m0XxGuPX+aIHhto4v/kcugzLYgmgAb+kR9yoyCDMcCtEMS+uWUXMvXn9NKO5LJttrB9S7gdvP4DF9aTGixFmHEmDs3ePTisXrxzyaIW8YCW8Pe+Jorxa0vbdGPyPw+xl/zu98D//v1frVOdcHLsNMPvsQjmVOBBp1M738HKN+N76RRxaPyABHM+MlhtrSRWbK3nLTvUGVO6pJAXagLxH8icUAQ4MTpXXXd4kHRTtEXpeiR7jrGdywT45VzQrQiwvcg/w==
Received: from OS6P279CA0164.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:39::17)
 by GV1PR10MB5940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 12:00:46 +0000
Received: from HE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:39:cafe::9) by OS6P279CA0164.outlook.office365.com
 (2603:10a6:e10:39::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Mon, 5 Sep 2022 12:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT022.mail.protection.outlook.com (10.152.0.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 12:00:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 14:00:45 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 14:00:45 +0200
Message-ID: <2b643cbb-add7-fc03-7b22-fe691072d9df@siemens.com>
Date: Mon, 5 Sep 2022 14:00:44 +0200
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, <xenomai@lists.linux.dev>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <20220822011821.21283-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220822011821.21283-2-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.651200-8.000000
X-TMASE-MatchedRID: dzgRF5KJYaNmvcelz2C5QLQc5DCOw3yNPg9yfk4YC0bJkecgyZD4ON1e
	FEoaE12nh/Zinvfjw35e9tX9WdS/SkqhGu5PwZpUb8VqO5p5BOLVL/J7UhBd9l5hVZTm4dD8QX5
	CVimNCmkK1YKSPbUVZKPFjJEFr+olA9Mriq0CDAgaTOa7uOFmI9AtbEEX0MxBAB5fZ54AVbsqtq
	5d3cxkNb9tvxXjMrg6OIS33dndRvhLSK+c4A5vZtfWm7uZFSs0N0jxHjZBn3k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.651200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: D50B6F5D3452768E96C1BACE0590D8A15918D18EE0B75381A50CFD4850E2808C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e85cd999-71f1-4da3-d892-08da8f364441
X-MS-TrafficTypeDiagnostic: GV1PR10MB5940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Q028NK8phS03jMipj2sQ368cHgf1V9uF6LQ9G4duyiCN2ovylNu0Vn9ILx8T5gCCq6Hotlatg23+RwvCSOlYu38X456zKpSybzicK9/RkGrHkcYBbmIQ6hQFApp14WG0EUsfvpYuzGnNzPDpK2MiDuZVsDmbmbHwh4AF/gFURvhbIqc1jUOzVh00xbdKd/5VVbL7xC8DgDscsFbyakrA/nR+45qY+5SHxirVtZIqr44llOEXTQkW5wwGszj6vv3uPkS5jLTaNwneNP4qQ/wYVCIenwGb9XGwzCFQHnTi/SSvScUT+ANF37mI6RpSGiWM+ZFPJqwCdhXPSPGvXP7ep2HhuKA4LpEYlar/zm6YCL7fknEYAKT/WfX6VBI4ig6P+3Lah1DvB4BF5Mf0yO6ZlNVV7kJZLJsQEstGERQRUKH7evOFjtd5myIlvNiP77pSm6A8ETpHxU1Ll1O7r//J+j+RnWRJc+6bx2mH9p3XFGXgo360arurTLJPXT6WAk4rCBPyvGC+zn1jUdG37uh25Oj7EqlHE56fnrFFaGbcHuugvBgMWw3iXC6LVEU3iDyHo80SBwhuIyZVj0Q5borb3SMQZktV02m+0dkn8rAO6PDCEC+RRKn7i2lGXGoy0iNAaKHD4/m2TXAn/36vVz2JtPozMIuTJRkN5iuPbfj755b91hzwyksZ5KYyGzxHZAoU4Dpyp/CjjvDWCIAJdoFXx9eDWC+V6PqvmGmfUsySgwN7dO139rq57ndi65NV65nsvsL+oe0bziKTCmfA20tVf+fy80TfIdNKicMYqD4gFCWeaZO1K4/TgnidRk3B3CWP634mDBW22/vorN/kix6aIB+jRKxzZAGw7lI/6pev4c=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(82740400003)(31696002)(82310400005)(40460700003)(356005)(86362001)(36860700001)(81166007)(5660300002)(8936002)(82960400001)(2906002)(6706004)(110136005)(47076005)(2616005)(478600001)(8676002)(70586007)(70206006)(41300700001)(16576012)(956004)(16526019)(186003)(316002)(336012)(558084003)(40480700001)(44832011)(53546011)(26005)(31686004)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 12:00:46.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85cd999-71f1-4da3-d892-08da8f364441
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5940

On 22.08.22 03:18, Hongzhan Chen wrote:
> ported basic network function not including TSN feature.
> 

Please enable this driver in CI so that it is built regularly.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
