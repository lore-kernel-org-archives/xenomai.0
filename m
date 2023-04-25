Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E271383
	for <xenomai@lists.linux.dev>; Tue, 25 Apr 2023 09:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwMpLj6A75k9zRUmeLtNsTHiFJ+xCPKH0pJKl/2dQ0VF8zmwthQ4NqOBFirhSpovSqIyQv4oq2pPy50/iHblplIpiFnDPaFLSEzJAOPQ9KILIQYvhiMoozVS4evI4UnedzZMx7kNQfgx0teUAJL0Zp5keJrwLe8grvUHJMfVBliYH/wd/V6ZS6b6pJH2msgSv/lMX+W4qWtfUdHW2VwYrYMVPHwOuPG8RRlcmNHeb4C0nZSrshoUg0ifRmhIqviJC7g1N41IQFypWD6eNEg6WiJUoUHpy2vddLCYop0tZabqmGrhcWtp5zu9PKtaN978fG5StL9U6Zj3oryYPkAPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rGiN926qDDz34pVoyRZlucQo+/w8S3JW51geQ7Kt6o=;
 b=k9Cfw8qAJBJWqPO1jTwrC5pNlOQvf6RrXaXL8q5PwWKns+a2o4CN1LRg/Yp/Sd1DNnCnnSupoue9jXIzZpL96m1dEq/Yj0JsQqHrhLNp8sqgNDxpholNYqnczvIfc3vWa7LlJEaDurynm0zncXMpo5II809OGyhn0Dx2FzGjLcD/sZgGtwuReCP9LwkDdKfxWDf58BbbX6NNPe/mN11WuyI/xBA+nl9hypS4U5OD4eF7xNFfsKmYGLq2R4q/dzlLrAZ9cblocn5I5q97NioQVkTMTk28A8vsL2FKxXQfPh0zQuCm2kKjOkLRejfyCwrxW86ldj58Bsyt2p8ZHrW4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rGiN926qDDz34pVoyRZlucQo+/w8S3JW51geQ7Kt6o=;
 b=CATYkuTJObW4PP7zGi2JC1QB4JQgW8lviIcb2FKkdIluhQVntjpMjtJ++RinyuDM52PQSMFlKV7mATA3+p62/ej5UIJk/ftc7r5vI42nWVxyIIPcXRqFmaTFWi1dOJModf1CS/dBmKFt+NHwWI7WgENN19GGLaR1PFJ4P72KOeA=
Received: from FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:9a::11)
 by AM8P122MB0277.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 09:08:55 +0000
Received: from VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:9a:cafe::3f) by FR2P281CA0072.outlook.office365.com
 (2603:10a6:d10:9a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 09:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT007.mail.protection.outlook.com (10.152.2.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 09:08:55 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id r9sRpQA0fV2YQrEfPppLkG; Tue, 25 Apr 2023 11:08:55 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id rEfPpPOq5SwYErEfPplYBx; Tue, 25 Apr 2023 11:08:55 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xbm1.bbl.ms.philips.com (bbl2xbm1.bbl.ms.philips.com [130.143.220.186])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 36034180362
	for <xenomai@lists.linux.dev>; Tue, 25 Apr 2023 11:08:55 +0200 (CEST)
Received: by bbl2xbm1.bbl.ms.philips.com (Postfix, from userid 1992)
	id 2D4ED7580D14; Tue, 25 Apr 2023 11:08:55 +0200 (CEST)
From: Gunter Grau <guntgrau@bbl.ms.philips.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 0/1] Re: fec driver needs care
Date: Tue, 25 Apr 2023 11:08:54 +0200
Message-Id: <20230425090855.883471-1-guntgrau@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dd9c6665-ca22-b93c-c68b-75ce825119f3@siemens.com>
References: <dd9c6665-ca22-b93c-c68b-75ce825119f3@siemens.com>
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
X-MS-TrafficTypeDiagnostic: VE1EUR01FT007:EE_|AM8P122MB0277:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2f11d7d4-db83-4d3d-c818-08db456cb276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQmezMkcXzeQszWsvZQe2TDFNf9R/qeSmRmgWsdxcfp6kCDlxBDyJk7msI5InMf35CMQpYCiMykJqZHlEZBdMO7WSTTQ80F8PLbDD6tsLYQgkd88D9asPYjCDgL1XhVKeFyOQLQ6Z46c9r7t1c7qe3HA8m9IlhnY7ooYkurw6tMVgt6/qLsNxxcy5PWvGGGiNHYMnOI1z6ptmlpiJc+vVN7j0Hx+B/2Mi0la7e98x+HA8Pq3bAMiPhIOryTi46RwcT7wSqvfKXMqiZz122eMXfDQrTjqH47Yj3W5N4TJNxQruIHbGrCvx2WYIUu+FT+QA+3tVREHeoyQYE++QUQCo9svRkkyReo0kQCe3JwIXJlXNOa8EEq+nkxaXL0ysd9bhoVOlIkUQpHDsunOxiRNifz8+KKXAUakXTiHB4uhCrCtUL4KZNXuObNRJrnJj2TZCSaFvCK7pjC/3zsFiY4PETNTT3PrYXoQjKYlpjGajn1AMHE4XfyWCzXydxq1BgCwil52K+kipaLUN3OShhf7D7sUjzXOwKa7o014bpKgVOlVg7auL8YaatIvQ7MvEuXQVfCkYiAbv/AoCYzz+4n41lugtLp1m+XA5um10zEprUCPLvKXFG1eIo2F4SC3Xa3Ohq9MFgTqzj2BOKuNsPly/RbZaNrtRLJQ78Pdt+EBXUSgUFi/NBlTvDiri2XIagvPyJAmHqMUfkwKkMYeHea1WA==
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(4744005)(2906002)(186003)(6266002)(7636003)(7596003)(356005)(2616005)(82960400001)(26005)(1076003)(82740400003)(36860700001)(120186005)(83380400001)(426003)(82310400005)(336012)(47076005)(40460700003)(5660300002)(42186006)(86362001)(41300700001)(8676002)(8936002)(70206006)(70586007)(40480700001)(478600001)(316002)(6916009);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:08:55.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f11d7d4-db83-4d3d-c818-08db456cb276
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P122MB0277

From: Gunter Grau <gunter.grau@philips.com>

Hi,

we are interested to keep this driver active and so I could spend some
time for porting. 
The patch applies on origin/next and was tested with kernel 5.4 on imx6
and imx7.
With some tweaking also the new c22 path was tested on 5.4 and imx6 and
imx7.
Due to lack of HW I could not test the c45 path.
Also with kernel 6.3 only the build was tested.

Regards,
Gunter

Gunter Grau (1):
  rtnet_fec: Get build working with linux 6.3

 kernel/drivers/net/drivers/freescale/fec.h    |   5 +
 .../drivers/net/drivers/freescale/fec_main.c  | 197 +++++++++++++++++-
 2 files changed, 193 insertions(+), 9 deletions(-)

-- 
2.25.1

