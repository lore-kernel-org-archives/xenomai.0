Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B832562
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 13:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKchpVEvWiUckm0KuhKgWtfsPjbAEe8GEWHwc2BID00ZTj/403UHW7HknEEgg61V4LOKcFEYkq6mZ5H3IFMeSdaDRwusZLaJy+ztBPyh/ebD8PZq9MHResL2KXVXBIBtitznlypEHaIlyYteWr1cjYfkJeAfyyu9zO/9p8/gKl6Cm5L7lOdpGZCCd7/KFlkhba1BLUvFKgRHXzNYEHh0cWyVK2v10OZTeb4eyYlcDeN4q5Tjuvi+o14DxRk9JL/JRvhIl29wGDuYDdGl/lCGzfmEqfyqAIF9q8cdywJKn+QXER5TaGpdmD2iksrjPGhzSlWVbZc4zA30wJ2FZjtmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfT8DSXLhD6rYKmky4vC82wZNR4iTzxYDJaShLarw00=;
 b=Jp4vc26ZKJ6R190EuQWrugopqMErV8kfe2jWdv67Bpho7b938zz4OSo0a5P4L1ulbbiH6J+sw0QNYVDyFYRu/SBSTdFn0ruRDnaNGrNXZRScL/0qfhQXINBhGWVxm3oLaXA6XqfHnzVY6qb/sGMAup82DxQRPzgOPb5LjBur8w3jRYUpmh2hCzMhM+54Vflkr59N34CwkhhUFs4Ks6cjPf12mPM91zR0enQQPJiNCTrkof4fit+SKMAtmvUN6obybUWG8oIqFqQAbDw7I+/liu2r8iCx9BVgmbPFqtBJuS9zCs/GvY4BnPab9tmB3NYZBVWny71BahRoHEq3Y2N/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfT8DSXLhD6rYKmky4vC82wZNR4iTzxYDJaShLarw00=;
 b=h2N6vtBjYbxBxAP27F7FQP5+IgP7zdVpLzKBRk4sBJ7z4v1JxbjqP1FaDagJTMoPw+zjG+yVkiwtZIb1suHzv/I8qQqYg7Qh7TChGfQpNv3pZN1IK+8Kq2s/Zgo5pZE35pxmEhmOTuI6dljYmifWB4KplQrfP3Qc+1DeI/cbt/3s7awj7MaAnJVt95EcmUQ13kTvjqd6grqAxs62KcoeyXcvcMSk6fhO0VxMM+/jlPu6BBUZj06G4/rRjNgteTS/wBcV9uk8wmqmAltOtuWrLTHcN8vC1zXHkzUzhJCP4QZXND/2Odcm936uTCsHZQyHCh5zeC35gADhnu50WipVsQ==
Received: from OS6P279CA0045.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::18)
 by DB6PR1001MB1285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 13:37:18 +0000
Received: from HE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:32:cafe::7c) by OS6P279CA0045.outlook.office365.com
 (2603:10a6:e10:32::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Mon, 20 Jun 2022 13:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT072.mail.protection.outlook.com (10.152.1.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 13:37:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 15:37:17 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 20 Jun
 2022 15:37:17 +0200
Message-ID: <3dc03baf-12fb-60f3-0284-6631db21acad@siemens.com>
Date: Mon, 20 Jun 2022 15:37:16 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
Content-Language: en-US
To: "Grau, Gunter" <gunter.grau@philips.com>, Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
 <59e12ca2-6c6f-09ff-5365-985586dc4e4e@siemens.com>
 <87fsk6pddt.fsf@xenomai.org>
 <06fc6d18-891c-e0b0-51a7-4b21f49e2add@siemens.com>
 <87bkuupad5.fsf@xenomai.org>
 <b6d70f96-0e67-241b-fb4f-4d822933d05e@siemens.com>
 <e876977a-4f17-d075-b9e7-1a096ea29949@siemens.com>
 <cd3fcfaa-0432-feaa-b69e-f3983f200529@siemens.com>
 <AM7P122MB02294E1A0DF3037F0F3C929DF2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <AM7P122MB0229933887662FDFFF9A43C0F2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB0229933887662FDFFF9A43C0F2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.748600-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj85QaOxwNGfvo9bHfxDWoib8lboxuXXyrOwWQIt565820GY
	gKYjJIUiSStniYWNNsPPZfQwEWwXgxk3xM4O3AM12zHC8Qmm/Ym1j71uqD+zcnV7tdtvoibaHrG
	KYrD0dhD23CzozEI96eUy+mqQdw7K68YKBzsXUtHGJxoLkkBDpFzhU0/oppo2+ACG5oWJ7tInnd
	cbw87B+p92lMIzF88/ieTBGDqVFDtCIghmpBp0PS8cRwTHQ3O6Mu8LwvFHOh2eAiCmPx4NwLTrd
	aH1ZWqCGtkvK5L7RXEXvQkGi3tjz46HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.748600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 EC6C20E2232ED5524F8283B6AE5F222168FF3A84C7481CA0F3949488D7583E252000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e9e5ac-79a7-4a98-2297-08da52c1feaa
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1285:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR1001MB128583D2577A1D3C94616ACC95B09@DB6PR1001MB1285.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QS6CvOfcmEOT9qOPgk1WVaRCxZriGPjkrrw6c3qIjuqJZg8zmWRigx9PSrU4+EoYEiPbYC/qCImfS3R+NKb45siZ94txKAhoIt+fJ0sKKo0ZvFI5NBM6EQ2LPggEwYM/oMZiU/8s4kshKZst89i4etioS51VaihaSh+dNPVFK55sVMRCrE3T+XL/WKFSJaZO7nL77lMJ4UZQJasOQc/0pbzWia46Rn07eWpEwIgk+/8Y5pR81eVAYxUmUMw8qml8Am2EUI7UvFtvsZIY2OA0S2lidEcAzpPvT6diSfXOc7bVLLfuwb750XVqi1vijw9hfCAlh7e9hCuzd1txF5SrPR/59fOtffD44/rarJTgcCOnhwP9qp8P4IuYLGpINyUmcpRyiBC1gdpQxu8y9rxi3OBanTWjLk6k5J0mtG5m/u4dK8YA2MDzuGJ/JbVXbKXYpDbQyLZV76s8zjJjK5ldSrcj2KqeU4MHFb0XJgoFzWC9mSS5b+zF/roQ12XIc0r+cu3nkq5jZdDw5qj0mWg7eQWt0v+S1356CgGOwBmwRSBVCwbC860X4/r2R3oUz1bplOJ9SoP/HoTYJmDQeCbGolgdr4rIHkqW3WfM+fJyHkr+50oZMF58oxUolbIyqT08jsZn6z7UatE6Cl3W3XCcowZUs+cURCg4q2Rl3GNBDbrKJJ7N6FrpVS2R7+GQJDH/ojgy/FIC2DafstjLT1IrKLqLWGa8AKNlysd/qBkGso1t78Xw0EtHhr9bZsGoIGfC0W+pl+b6NtYnJrr2WEX0oA56ThY0b5OpC8LjX6LD1F2rA4CGQCg9+VoIbsRuTozI
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(44832011)(356005)(36860700001)(53546011)(86362001)(2906002)(82310400005)(26005)(6706004)(70206006)(40480700001)(316002)(16576012)(478600001)(956004)(47076005)(2616005)(36756003)(82740400003)(110136005)(31696002)(186003)(31686004)(296002)(82960400001)(8676002)(70586007)(5660300002)(81166007)(4326008)(336012)(8936002)(40460700003)(16526019)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:37:18.0137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e9e5ac-79a7-4a98-2297-08da52c1feaa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1285

On 20.06.22 12:44, Grau, Gunter wrote:
> Hi,
> 
> I added a dump_stack() in cobalt_assert_nrt() where the XCPU signal is generated.
> Maybe you can give me advice if you need better information.
> 
> [   13.690407] CPU: 1 PID: 581 Comm: UT1  Tainted: G           O      5.4.191-00703-gbfba1d43d087-dirty #23
> [   13.699901] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   13.714083] I-pipe domain: Linux
> [   13.717347] [<8010f314>] (unwind_backtrace) from [<8010b824>] (show_stack+0x10/0x14)
> [   13.725118] [<8010b824>] (show_stack) from [<8084604c>] (dump_stack+0xd8/0xf4)
> [   13.732365] [<8084604c>] (dump_stack) from [<801d8318>] (ipipe_trap_hook+0x1b0/0x33c)
> [   13.748287] [<801d8318>] (ipipe_trap_hook) from [<801be9d0>] (__ipipe_notify_trap+0x98/0xdc)
> [   13.748304] [<801be9d0>] (__ipipe_notify_trap) from [<80114114>] (do_page_fault+0x20/0x444)
> [   13.748317] [<80114114>] (do_page_fault) from [<80114800>] (do_DataAbort+0x3c/0xe0)
> [   13.782231] [<80114800>] (do_DataAbort) from [<80101f7c>] (__dabt_usr+0x3c/0x40)
> [   13.789655] Exception stack(0xc2129fb0 to 0xc2129ff8)
> [   13.794735] 9fa0:                                     6c1d7000 00000600 72c61910 0000013c
> [   13.802954] 9fc0: 72bff024 72c618e8 004247c8 76ba5000 ffffffff 00000000 004247c8 6a87da3c
> [   13.811155] 9fe0: 6c1d9000 6a87da20 00020000 72bb5c68 20010010 ffffffff

OK, a regular page fault that the out-of-band code in I-pipe was not
able to fix up. The question is whether we lack some logic there to do
that or if that fixup really requires Linux.

Can you trace which resolution Linux applies to this after switching to
non-RT? Or do you already have a suspicion, Philippe?

Can this be reproduced in qemu-arm as well? With some dummy device and
driver? Would allow to examine it also with Dovetail.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
