Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96955A44
	for <xenomai@lists.linux.dev>; Tue, 21 Jun 2022 06:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQKVpJQRRkuPEOrFhHx7wbmVVttjSho2M9BPyMmmCW0jX3kOGXqwdTeIeR7E4uDZnM3FWLHkBMlS4gpkZjCBpy9XLArzrpwPRUnwquE+96cYZiweJ7jT1VkGu6PHolmiRIHHHgYr0zItmWLjCVIUGBV9Db8hVuLqZOT2otBgF3zK/L79LM+usd0bqeZ6/16DeCs/l+GvJNU7bdcqPXEOyEB6ujzw4QYNbUFrCLE+lhYtKVvm0YaOTcLHsDZG8Fe+MrwPtX1p22LCzWyMmMBXsVo0XRmDnulc1PVgttZDO/NfUiLwN1VOvcL+g/KSWWdaYs51NYHmRGaTdW7cZd+gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG8WsOGs4WjK7OP3CTSc6X/ytFdBkBjpEJjE5BaTuQY=;
 b=gTkNNAexC0zgdSzQJuInossBY9Xt+5po1VQOUfKf2vtna8bRbRMeUvMMKL0BA8GxkALl2juqmsMcKJZiMsiIhDLoBcWYhAl4vR42IJS2N0pS3hq4LjJCRAa1EUZ2Tx3z+tjVyZbYXz5u0pOMU2lIFeAubrs9WJPBqBwhak8MP/fezRklQH/eklFadYdCHrIEO/Y1HgKe9+4B7T+RZWuIS+AhXmAIek+zT0W0kpqq/M5hyJqjNtQScky9h8GC4v7filxOWHrQvUcz0TN2zxwDv7AxfpkKHwYAPPAyM6uh8Xs5tySPUB9XIvLmARhKKzAfAfu44L1NHLMY6Ko/ECbcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG8WsOGs4WjK7OP3CTSc6X/ytFdBkBjpEJjE5BaTuQY=;
 b=pHeePcdSJuIKX0EdK2Qf8E0zEDQ4ZbhbI4H3NkJxwxaj0uvThvOyV/owa4Oby8xOQm1x90hARetnumbcDjPR7prqdDFrUQ50TMDEOM4kGvvd4j5TMRp10rt/5WP49EKfc2I8vQqcHJqemdzpWoW6KKq9Pdnk9F5uX/DYNeQRvyVIXPL9fUQglUvfLxiEbHUnI6nHpcU/qTTtrc+vPhxIEYtrO5oYdbhVk94EWKp8Is1AJqJu32gpAD92zU9DJz/yeLaPooRxHesOevy7odcwX75xs5NNWnrMNHEJDUFBYHd4pLxDedkRESSzzVWPM4Jhd+XsaIqasoVGgT2Sn2G7rw==
Received: from CWLP265CA0525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::13)
 by HE1PR1001MB1419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 06:47:34 +0000
Received: from VE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:400:18c:cafe::c4) by CWLP265CA0525.outlook.office365.com
 (2603:10a6:400:18c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Tue, 21 Jun 2022 06:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT063.mail.protection.outlook.com (10.152.2.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 06:47:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 08:47:33 +0200
Received: from [139.22.105.48] (139.22.105.48) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 08:47:32 +0200
Message-ID: <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
Date: Tue, 21 Jun 2022 08:47:31 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: 5.15-dovetail or mainline regression?
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
In-Reply-To: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.105.48]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.102100-8.000000
X-TMASE-MatchedRID: n6ZycIGaTdP/J7/cdz0rWr//VCGogePzP0DBdQeKlX0wo+sXt0rns5ho
	XhL48wE7V0rj5xi3XrhBOVMZbLi/hANjI1v/y5/0cXm2SKSBDyHjIHTY55IMSfw4wQxTs7JmTJD
	l9FKHbrl/2iy8d1BiwjSghb/pcAwySgaXHbJtjvlihfH8cTApBwwnRlHVauMMAkKD5kW4Zx/ihJ
	3Xxt2bAqRymZqZOCCtbj6AD6L0PYPTJ1jhV0BSIi8cRwTHQ3O6Mu8LwvFHOh327WtDgGBc8n0tC
	KdnhB58vqq8s2MNhPAir3kOMJmHTCYG93cCja46bdTuPa9VRGvEQdG7H66TyH4gKq42LRYkxbFI
	8DRbKVAFBL8nc4WDB3EOcyyT07Q1/Z266/kuJxh+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.102100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 25EE10CF9F819E9BC66C31367589C27762FB19CC3CD21E1274B20C741CFC61092000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6428dc21-cb7f-4415-559c-08da5351eb83
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1419:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR1001MB1419D8BB4A9273C3E77FEC9F95B39@HE1PR1001MB1419.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XNXOcjOCu0qXYjvwOafWQgfYNd34wsQBsL4hOBUJNI8MoDvlmoSFbj/ZvMnLNiYDFttjQlSiI1puO94gg42yppHioZHoTvXQumSH6wpBtumYkXzI9hgc8K5RXXmDHwxiCCMVb2VABPqMBFeDs1Ew90EOi2K1STIxq7afa1m9oepgkQ7BT5p47YSqUuiBZxQrReGZgF0gxVfVxa+iQ7oNfUeKG2dhpYtLjgPJw43nIdUxtieLtGUrYmuZamjNldogteOl1HVhcd6dNelx7DiL0c2p9+S6WdkQ3TUd6Ckx5KyuF3EW2Qw9GT6xnm2pRXbVzNKaPD+HP//MhUDhXtwBYvdH8fO+Mzfkm1Hz7F2mQIQL8ENCIJZcz3AWcPebcDBx4lZ/DCaFUv5ccSTVwNlkbzUDfLQKTYDr6Oa70E0WeR/ZfMwmOhYjRMVOBUVVbhvutq22ZvggWiYKY1xRRPfb6IM/fXW8AwN3U/psyPjCezPphoPgEk0qtu9I9OU4Tm7yLnSokMPtWrFURLsFaUROuLUKwLokZTi5CF4qxDLvlLIO5dc0o5HuF8pj5Brp1u2q6jRlCGXe9vLcyO2YwTOMSS1T/0R4kV2SGTy8JluoCAtmWPKWIlRyf4neBhkyotm1tPmLxCrTx/GTF56SqRsm7KJUk5erHipVHzKwlfuf/mu8Tb2252OTwrhUaV6+E4v7p6/c29TNgYu9xzeKBI4CT1GFwkRUjWS2Kbcinrybvkk7PlNEFLg1p93NTU8ngLupr9AaIjVe0yLUq7ncfTKK7AMqDYrwgaaNP/q59zAYHYsAD2t6lXPBA6ug+oabiXkVscdKN859ry0H8VBAD/Dxlq+JNBPS9Iq2Yy2+lPuB/50FO8RWmqxUnKqY5lPhS/YR
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(40470700004)(46966006)(478600001)(41300700001)(16576012)(6706004)(26005)(966005)(16526019)(186003)(86362001)(31686004)(70586007)(31696002)(83380400001)(47076005)(8936002)(70206006)(336012)(40460700003)(40480700001)(8676002)(82960400001)(356005)(5660300002)(82310400005)(81166007)(44832011)(36756003)(36860700001)(956004)(110136005)(2616005)(82740400003)(2906002)(53546011)(316002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 06:47:33.4430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6428dc21-cb7f-4415-559c-08da5351eb83
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1419

On 21.06.22 08:10, Jan Kiszka wrote:
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/452968 (qemu-arm64) 
> 
> 2022-06-20T23:57:39 [    0.337643] printk: console [ttyAMA0] enabled
> 2022-06-20T23:57:39 [    0.349807] Unable to handle kernel paging request at virtual address ffff80003675c000
> ...
> 2022-06-20T23:57:39 [    0.359334] Call trace:
> 2022-06-20T23:57:39 [    0.359508]  locked_inode_to_wb_and_lock_list+0x60/0x180
> 2022-06-20T23:57:39 [    0.359577]  __mark_inode_dirty+0x2e0/0x430
> 2022-06-20T23:57:39 [    0.359603]  simple_setattr+0x50/0x80
> 2022-06-20T23:57:39 [    0.359617]  notify_change+0x37c/0x3f0
> 2022-06-20T23:57:39 [    0.359636]  handle_create+0x1b0/0x21c
> 2022-06-20T23:57:39 [    0.359669]  devtmpfsd+0x80/0xd0
> 2022-06-20T23:57:39 [    0.359688]  kthread+0x150/0x160
> 2022-06-20T23:57:39 [    0.359707]  ret_from_fork+0x10/0x20
> 2022-06-20T23:57:39 [    0.360029] Code: 11000421 b90012a1 d538d081 8b010000 (c85f7c03) 
> 2022-06-20T23:57:39 [    0.369411] ---[ end trace 91ca49b5035e8050 ]---
> 
> Hitting retry now to see if it sticks. The real arm64 target was stuck 
> in u-boot (tftp), so I cannot tell yet if it is only a side-effect of 
> emulation.
> 

The issue with QEMU sticks:
https://source.denx.de/Xenomai/xenomai-images/-/jobs/453115

But now CI is failing in the infrastructure, so I can't retest on hikey.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
