Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15D7E0
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6yOKeT3X1kubJJwEWoqsJ0zkUwr2IN0O/7SgapmNeWri9TZAun1rZc7gwD8AnqqqAEPZDwlm+vLMkhij2ySXIgjarc/AHe2/HIpJhKy15+onH12PnQlUpNJ0RjjbEqlN4AJ2BNEAcg2YoIEoGjjotG04Mmxqz3/Y2v2UzUu9qi3tcFQLnt6N0GB54QSvsq83fgij1ha9QN6HQv318WJ+6gSuF2Px8krBe8k1tee9kSwVXiz7kNQMEVoIV1aFAz+J2IBzRIQT/b/OjrK6DAbWQ+crR7JgMlkBpl4/FG7w1cKnDwjzhJPSzjhhJRiseYjSFLffp6YIyyzwzBAdR7zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uos0IB6tAWh3s8Ry6SvDRJYS49J1PgnhSdp0DWLSSZk=;
 b=DkO/Hbg1y4NSEQa9mQkXm63EIUycl4YZMp/MubI5c0GSQPWF7vzfLqGSDJIAFJravVlMnuh2zjPG5Awe8A5ANXtqCh6vF39+Ssk4BO1wU2Jdt7KKaG1D2IcFG5fGXuOIZbysy7YBEj/2lnOB4UStfK98Hkgrkwj6zGB8GUIXkCA8dYp9Zetu0OenTQ2fG2HfiDf633bPAH7Ou/JMNo3Ar9bqE5FHBYHNXl2mCRkJAGSt8cMFDnEmIZfS637aRwc3KQ/YYQSqnRW+86VPXXCBelkmaLMu0+IGXQyB7hpnCN/YV1d4n214vCvxWMbZT7IuV1Nhm3MPbERf+zLl33gr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uos0IB6tAWh3s8Ry6SvDRJYS49J1PgnhSdp0DWLSSZk=;
 b=c/gQzUWjeAX1/c08kymmoOlLt3GBsbdrKa1oEDS9p9LbDKrBc28atJ8qFrnei9x0RYF+fKeARJII63jdNzWGAQ1uc19JN3iYE8k9m4etFC5VNMepoE2prOFY8BOWzQdYkUYcbISQjnDBdVF6Ld0u07bYEhZutcZUMS/ebuSI8czTAe0fAa4G5TYlriV8whGpUL1Gi26K+shp0u1aFvf1EilvSqFegTmLcRcNSu1GfL04myO7RnEt5z7yEaOGlbzFEqH5G620m3FFR2AR7HslHWiS34pNetLOvsKDHCPn7OUwvLpTBJCcapzlNbjx0Lis4KaO/kNB/Qb8EqOsVZBF7w==
Received: from AS8PR04CA0088.eurprd04.prod.outlook.com (2603:10a6:20b:313::33)
 by DB7PR10MB2124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.20; Mon, 20 Jun 2022 06:13:42 +0000
Received: from VE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:313:cafe::28) by AS8PR04CA0088.outlook.office365.com
 (2603:10a6:20b:313::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21 via Frontend
 Transport; Mon, 20 Jun 2022 06:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT025.mail.protection.outlook.com (10.152.2.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:13:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:13:40 +0200
Received: from [139.21.16.131] (139.21.16.131) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:13:39 +0200
Message-ID: <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
Date: Mon, 20 Jun 2022 08:13:39 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Mailing list enabled
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, <xenomai@lists.linux.dev>
References: <875yky6idl.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <875yky6idl.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.131]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.798200-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj93J2rmPVmIKlWhtF5d47grPg9yfk4YC0Yo7b5tLxYZrUhM
	UByBUHErW+83mz7I3jHldxgef1KPBur0n5nmCu6G3pvuyKOE8lAMIQP85zkv2/bta0OAYFzyTLZ
	B6U/YaPo1EH4lNzIZSH3kR6l0wGIGwpGJd9opianLLeDfTUXm/TN1VvnSogA62fov7TwhL8nNCi
	BItkSKfyaTNbgbq25FyHI9pvh+9W8r59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQASAHAopEd76v2iCdi3dB8OSlYB5JNvh91u/m6u4pBX2FxlUl
	OlqU8CAUk9Ra06Wcgw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.798200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 4D755D289D4410F3C1E5CD90179ACFC33C4BB0543F86E34B63A499DD934E18BF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aed8f3c-65f6-489b-ede7-08da52840600
X-MS-TrafficTypeDiagnostic: DB7PR10MB2124:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR10MB21248A0F5039C037C216058595B09@DB7PR10MB2124.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LaGKIGFd/2eWW6HqNy3KwB4MLwG7s5jFs/KsQ0ppHBsI8zP2EXViKmNUABwqhGNNatcXQOXEuUF1h2nmKExLiPxr7cDwjr4kkPipIRoKrlmCsWWD9u95Kqoar9gS2T+o2+eQevsxVcyNYNmAfbgSFWWO8GmtKKHzgYc8tLIk/Axc3zB+fRaAHDZuOzDa6q6sHEYrdLo2/4KIo9azITpxOChAz8G6ua6za6lP7E2sn2BTdBbsJoyyciMoJ+nLoLoRyh0O1ywpq5F76dTwS6mX5ghXY015ZHEYWyam/QEjPTx+/BFswQMSUroWL3tJ9yb/rE0rnQoLYqcaUEDhBGSqtdgRHtwoKIVOPGOkgUR+brgbScphNKBYChEj9BV4MNi1L5fCwYUXs7gsPPUSKOMD/mOz8Y7IGWJWfSOU+1+HWSGqLeRCkw1JrypqnZh2ZYdh9HKjgNOvFU5o1Hr2JCgAk3rDEnfo128fD4HmECrgGfq+TD7ANHv22a0pYbSKAsnztgXTecSeUyRfDmqHNE/XxOdncWX0VuEelz7gzko7TaAE7CrltTiM4l4ijAgZzSMtCCz9dAoacqN0kz5iCvnd5zHKEZK9POyanQfxlzmk1JawECCnAyKi1Z3EF/7g/JOrNOWJiuJClyC0f5CdBXarwF4L61IgDWl34FIJjUm/ZFIft3Qf83Wl4ytNzPfQ4cTaWDa84PNeYiA1fCU6R3rRg8gUtl4dxWJgK+/eXy0dQwzogyx7ANLnwLzGwANXiqyR3Bh0BH8Jl8I7oALisWzxcRicNzJdqAeFB447byFxXWjZt1qIJAO6U7+U+ImHycheACIW4ANDRdpzJ2IA1jggTBldulUHXtohIU+nOsfwKyGN15yPF6fWiBl5fMRPpiR8z52l2eoAHocDl8HMF6XeELErhfNIkNyVuWYLo+FBYAU=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(40470700004)(36840700001)(3480700007)(82960400001)(44832011)(82740400003)(83380400001)(8936002)(5660300002)(70586007)(53546011)(2906002)(36860700001)(86362001)(4744005)(31696002)(70206006)(7116003)(36756003)(186003)(110136005)(6706004)(26005)(16576012)(316002)(8676002)(47076005)(82310400005)(336012)(41300700001)(16526019)(356005)(31686004)(40460700003)(40480700001)(478600001)(81166007)(956004)(2616005)(3940600001)(36900700001)(130980200001)(223123001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:13:41.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aed8f3c-65f6-489b-ede7-08da52840600
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2124

On 18.06.22 18:11, Philippe Gerum wrote:
> 
> The mailing list rehosting process is complete, welcome back.
> 
> Unlike I previously announced, it looks like keeping xenomai@xenomai.org
> available for posting to this list via mail forwarding is not going to
> be possible. So please switch to xenomai@lists.linux.dev for this
> purpose, the information on the website has been updated accordingly.

Fairly inconvenient. What prevents this?

Did you already updated the ipipe release script accordingly? Just
pushed a 5.4 release, and it seems the announcement is not making it.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
