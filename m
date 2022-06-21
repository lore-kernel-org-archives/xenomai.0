Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92DEA32
	for <xenomai@lists.linux.dev>; Tue, 21 Jun 2022 06:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwBaeo++7ezwRRWZmDsGX11DpbFbvgA/+zp3suRis/Mma9hepep+bL5mY6B2RAtgXASrSRtPXsmJMUHs0wNldadNMzmp0vEGlVfyyJ07og5dLv652dC69yno7oWrdQd8wtTXoMVTLBNz5EkvDQ3yXZqeB3IwAD0TOs+Dymez37ZSvgKPc80JuJDG4R5NBdVzWVDP5Y2DCyURabvuR5XAKBXYnII4o8PUUW/nxm2qwwh1j6DIVadbzT+AMU7IveVan6G79vGcNhm1vWZJVMGRzTkTED3UYWVouhTGsZ/jug4XoYu9ixHfTBP1CIdgx1DyUDaraSTY894YZCLAvoTDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQUA2Dx9TJwtEwNCj1VTBzltCl3XwfbSM7cK4zeoN2A=;
 b=h9t/ndwRr37XVnuDjgCradzhmKHp40rXYMOhgpzCeVwJwrSJTxf3b1PJZMjC4kaFrCgtDiVoBXvMkymRfTrQYXupGxF+i1aID43LhLm1/EIGuCM2RYwtLMRZMcaWXVI3R96/ZoLBBpKoiKd5LpotDfgnZjADVEn8Iu3aYqPDf6f41dmRJca3isRw/NTXlwWH+nGcKaq2edoZiYVtAd42I3nlNupoh+J5+0GoyJzgaE9ENlTjEYZ4rCF/9AQ5Ssd/sLNaR6mPQiJa+2ygh2iIDaoVXV1rSQz0PwlV6M6Nt3HhsGqMtCvSUp5Oku41KbLuKsENaNM2SSz4W6iwZOgeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQUA2Dx9TJwtEwNCj1VTBzltCl3XwfbSM7cK4zeoN2A=;
 b=ysbNRBZPDyghW8e7TzzhY+U6uJWU89iTSE5QbKp5IMvniWsbW7bJIVg9m996HC0haQpbWM1Qg+TDDq2alDPi/tJ3EzpIZYpKp2Vm3yDRSlXGt8GBgw4Czkqwj46ebj8rSzFGVAhMR8kSsCgaUo9Y9LhCOZRXD4A/IQJihbmNpiZjdU2ap5SOEC4jPozpYNJ0ObnYHs6rZVtUb+KCf0sMMIfZi+AWUrb2QGsV0UzQAAQoQOQfhgcH4E4X8ue0qM07MDU2oYsXskzEeO3zedei1kb7DIw+ZmqQyKl1P0GwB47Uy0Ze1VEzPIBHa/ID/D300JUGStfvCN3430ZFDtp54g==
Received: from OL1P279CA0001.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::6) by
 DB7PR10MB2090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Tue, 21 Jun 2022 06:10:38 +0000
Received: from HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::74) by OL1P279CA0001.outlook.office365.com
 (2603:10a6:e10:12::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Tue, 21 Jun 2022 06:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT076.mail.protection.outlook.com (10.152.0.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 06:10:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 08:10:37 +0200
Received: from [139.22.105.48] (139.22.105.48) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 08:10:37 +0200
Message-ID: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
Date: Tue, 21 Jun 2022 08:10:35 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: 5.15-dovetail or mainline regression?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.105.48]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.865500-8.000000
X-TMASE-MatchedRID: CsB4N4gC1/SSgQ9/1HCvXMNTaOEhHpvyqZRMh1bQJ0VQI3p1Pnc402Dm
	3C/FJwHxKBVvFbsUM5Wn++u0XvvTeLGsE+aDBEFlYCzqBmyXvQIdj9vNGYhpkYS/TV9k6ppAfrT
	t+hmA5bIrQckxu8nkYQTgsjIJUJZIv40TUEOkx4531h6amwSfKgo+JH62xMnWbl4CKqupkMr0VP
	vT0zx0mKfub87GOZijeub7fte8p4p8PzbCA5csepGTpe1iiCJq71zr0FZRMbBwK7mZ44aKbkp0O
	DI8GjvXKrauXd3MZDV2EHmbm9v91OXDrLwLuvWCqO0LIvuhJxCSsSndGdOfsO1O6i8SbXzj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.865500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 BE4FAD13556F4F7C6877A57ADAC3B9816FCA9C7107A3521637EE2081D063E1EE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f81b79-ebcc-452e-b124-08da534cc328
X-MS-TrafficTypeDiagnostic: DB7PR10MB2090:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR10MB2090C731BE3C96180F4A987795B39@DB7PR10MB2090.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8kcR0sri7xxE+545qeRL5Q4zBXlym+L9H6PX7NyrgXQQ4BinoAdBPT9aQdEpBlu819HpmtGLpcgQYrUM5RfK0eDnstEnp+aDWOEehuFgRYSoWlShHDTi+tjsKytxpEwWprXvpHpf1o8f7uR73j+uJzCILaSGArmW99U30iI0PBBs2kzlLjF0mIz7b1OMLGpxfrJgyIZz4OMwbPg4WH5ZfvvjIMRZOQRCD35R59UnvYtAFXcU+dkZyQ7FSI82we+Jh4ajDeduulEx72oNh6KLXC3U4l7Vstff7EFSH12zhAdIghCUNeuX14RK+0LCwgFtX6snIJbEWsAaS/zZAetcDfX5G6h/Pu7R9nN20oldL/t2Z7RXbTwxjhjQpUqnKU11ghrWp+kWK5rVz9xYXZXi6c0dkBnWABN5C6mSxD/9hNwKfK898aptFINkMpxtPQPH3Kl4hNAD/ppocNB8mtDzuV6L8uTzIDJBTyP0R20ZUrx+yBLhjFOad91XIuIUWRkhAGxVHAToteACp01C2v5P7JIMJ44djnyOVFhyXNNKKlY7PxbEDsN9ALgP8Soc50AoeL7sZ8epeXE6+Z7KV1ro9h7uMspsoiIctNywjvIMCta/Ik2ICmGiMT25dB4islA0QMtl0Kwq1bADkXIcmCDbcENN80dwgUHOifyo6dDU1V2rggKgoTS02b95vCGEsbHcy5Jog/xnoOIp8fQPRzL1gQplzeT8cX7egcni+j5EPjqUaEqNgwdi/Etr8PO3uBx2ImoEohLu054w1pMEZkMQg0uvv3yQiXipeKbVZoCxSkd1D9zqdNQ2Mox8hTmugNlofv7TsWbLU28gy6w9BRDAh4v9lvw+jU68589heAmukPb/qr7/L91F3H1YT39tsMV1
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(44832011)(8936002)(40480700001)(966005)(110136005)(6706004)(316002)(36756003)(16576012)(356005)(81166007)(478600001)(41300700001)(31686004)(82960400001)(186003)(26005)(16526019)(956004)(2616005)(336012)(83380400001)(82740400003)(86362001)(36860700001)(40460700003)(31696002)(70206006)(70586007)(8676002)(82310400005)(47076005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 06:10:38.2391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f81b79-ebcc-452e-b124-08da534cc328
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2090

https://source.denx.de/Xenomai/xenomai-images/-/jobs/452968 (qemu-arm64) 

2022-06-20T23:57:39 [    0.337643] printk: console [ttyAMA0] enabled
2022-06-20T23:57:39 [    0.349807] Unable to handle kernel paging request at virtual address ffff80003675c000
...
2022-06-20T23:57:39 [    0.359334] Call trace:
2022-06-20T23:57:39 [    0.359508]  locked_inode_to_wb_and_lock_list+0x60/0x180
2022-06-20T23:57:39 [    0.359577]  __mark_inode_dirty+0x2e0/0x430
2022-06-20T23:57:39 [    0.359603]  simple_setattr+0x50/0x80
2022-06-20T23:57:39 [    0.359617]  notify_change+0x37c/0x3f0
2022-06-20T23:57:39 [    0.359636]  handle_create+0x1b0/0x21c
2022-06-20T23:57:39 [    0.359669]  devtmpfsd+0x80/0xd0
2022-06-20T23:57:39 [    0.359688]  kthread+0x150/0x160
2022-06-20T23:57:39 [    0.359707]  ret_from_fork+0x10/0x20
2022-06-20T23:57:39 [    0.360029] Code: 11000421 b90012a1 d538d081 8b010000 (c85f7c03) 
2022-06-20T23:57:39 [    0.369411] ---[ end trace 91ca49b5035e8050 ]---

Hitting retry now to see if it sticks. The real arm64 target was stuck 
in u-boot (tftp), so I cannot tell yet if it is only a side-effect of 
emulation.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
