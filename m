Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750E29AC
	for <xenomai@lists.linux.dev>; Wed, 14 Sep 2022 07:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/kkQsub+8cgg1DZm0wwHl5HIvb4A+JCGoYBglREmRhKxzNYs1EUQD+q50OdGGGbRELmVejGjWjA8BL2B4l93hdj0lm61MxhusJ83UD0O0WGZfUxCl40yb6YUxwFxlYH5PbqM3B3i7T63qlaHGlyaBA30kHSxzDN8eZpyRiKWInWl0xsJhjZcOnnNeeKkOhY2xd4FEwFKLGiICBI3dIwrhixHOVAs1XBIm9V3LOMRE/hjyyZIuK2xeD9SZb1YoTzZwEy09I6chvtqL8LtG7rZaDfKifatfu8JgiBbN/LqaZTRZ2jn1FD8gqVbdZOrCY9tXtyjZeDxpcTU1/UyOaGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiDzUKV1ErcAihMvdu8FfdaR0H3Kogpi76APQlaEBAg=;
 b=XEMPbCfTgEFuZX0al/QvfEaMtqRK2HPOhUlKFmBFa8cblYfls2ReoqdT5z9PRc7NI8IzvZZmzv6GShN7hLP9gMf16i931akoo4dDmO01NIi/mn17hzWi2uSGH+WBHa2LetfdKuBFE+IPxTL3PN4RDFEc4p4qszxKu1HbEW7Y8MRXJJs4PCdAMHscoAFbhXCE/zoj8cFDXZGjhz7IuSmRuDZXD3s8+YVtGHXQ6CijZFUXDHQbh8aBFHtcp1xV4i21ny3R4atJKXaA0fdZyzhJ3J+yLiZ+hx4EIqhixLqyxlDFoVTvvzzdEpAjQQFWBtwIRIaJQq44sjJvjM7Ce74rmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiDzUKV1ErcAihMvdu8FfdaR0H3Kogpi76APQlaEBAg=;
 b=Ck71KYLqkXluppM+1c1+OGnr5ITIbDxxs8E/y5yafQVyJORwT6NigdsurYxuL0hAeqtJbc817VxE0M/JYxetQSexOYACwrkt7+WP8Qeuu8dkda8usjYXUrAup1EsCc5Gx16ieiObz+SufSvvz8+f5TZvRVZdiO7HXdn4S66DdvxcPx4ntNTy6LCP5NZN1X1dsQqsNdGR1FjS8xBcO4P+GtYv8zy85+D4gCn1FOqF9OBZatpqbuh+TpNXyM0PnjKdeCczQOeM2+L3b4gkIc/peQv0FRIb2iUbRfCFMWU1v7/HYfgWsF3Yslt11f13czvPaTmq9Cao2nt4EBnOtrmbNQ==
Received: from AS9P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::7)
 by VE1PR10MB3854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 07:33:03 +0000
Received: from VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::1e) by AS9P250CA0001.outlook.office365.com
 (2603:10a6:20b:532::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 07:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT096.mail.protection.outlook.com (10.152.3.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 07:33:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 14 Sep 2022 09:33:00 +0200
Received: from [139.22.106.123] (139.22.106.123) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 14 Sep 2022 09:32:59 +0200
Message-ID: <c13d38df-1a4d-ec26-bd09-b811bcae15fb@siemens.com>
Date: Wed, 14 Sep 2022 08:32:58 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
To: Hongzhan Chen <hongzhan.chen@intel.com>, <xenomai@lists.linux.dev>
References: <20220914010218.15149-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220914010218.15149-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.123]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.404800-8.000000
X-TMASE-MatchedRID: 5vV0XjnGfUlmvcelz2C5QLQc5DCOw3yNPg9yfk4YC0bJkecgyZD4ON1e
	FEoaE12nMtnJCTb1F/h89K8uhU+FHEKJe74epUp2hRXAGwFGqECV76rqTtD9zC/MuWzsdN8Zy0M
	fD1GsI1ubKItl61J/ycnjLTA/UDoA+S9X7PfvVMrkwjHXXC/4IzsAVzN+Ov/s9a9lky4hUhdhOk
	jo+O23FSSzNmYSGXhp+MlcGu9ZU0mziDK3/XF+ew==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.404800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 4F4243EA06CDB8ACC981EEAF1F7377559CB01B374FCCE58D845403405B2ADDB32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT096:EE_|VE1PR10MB3854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9048e38e-2973-4a58-ebd8-08da96235acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TE2s39tKdFR6AgPfe6xCjjlbPaa32OWuvIdaISEdY1woYzzBoitrj4Ri0FYzcJIBSAioKe9FnFI22YfW3wPdtuCy0AJP4urzeQbp5WY0RmMqt+cnbImvvYlvttIQtLigoHLt0YxycvZD/eSIqxi4vbTLkML8nRAVm5NuDmLuIfv+HLBy6Lgm1n0ui1SMjgmjGGEom68nz1uy3teOKe8RPE9atidc4sbRO7pA2gvmxsKZuWqSrZKbYTEPn0A0wi3L8JD077cSpAgE2obtoTuDGQO9j9j/jVxQEZZOoGO3YcxW9JZufExdEvHSBSGsU6I3s1mItZITNrIewWRRlHeju5uZw4v6ARhGrZbfRxF3ZukMjB3EWNM57NzQco1Mw4ndykKr7v6iCkJGi/FSQ1kvIgUnNlde6LGQMoygwfKp9+KJXtVnyK7z2Vc2yjvx6M3vGNjUhryqK6NxhwBtlkWd5WD09ELBFDrALi25ht+yhjQH/kPKV97HhFRzlKnT6+t8UtDcRNXvpkuEL1m0vsOYTWDCDnn9hwJEQBR0g+e4/SZo95bMOuNdO2MeKmsSsm5yhsMzQhs+its8Wm5yPVArKgdSxnqTxtCEmq+8BKdRTpRT7VslPKLpbKm6z5jUYT0eZEu+FCFb68s9XR8hn6FRCEsPwUrvl23rfuuA6YAMDjcfaGPbwF9bseyy1Md85VryjGDK68wJOmIouobLPKYcuMVcc5Vtsp+edRkXvrDTdMvXOQPbIl4Ut78zkXrn0awS4VvFq5PnVa+2Ohwu75783byfqyBSEMH0phimXAnwgoyfjBvN3nwGWpuYsX+/XbtjsWRVA5p5DFM65Fjxc1A8tSpERgetKn6WmhgUoYHXkEY=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(31686004)(47076005)(40460700003)(44832011)(2616005)(558084003)(478600001)(2906002)(53546011)(40480700001)(336012)(31696002)(41300700001)(26005)(110136005)(8676002)(36756003)(86362001)(16576012)(8936002)(316002)(956004)(186003)(70586007)(36860700001)(356005)(70206006)(5660300002)(6706004)(16526019)(82740400003)(81166007)(82960400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:33:01.7343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9048e38e-2973-4a58-ebd8-08da96235acd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3854

On 14.09.22 02:02, Hongzhan Chen wrote:
> ported basic network function not including TSN feature.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---

Thanks, applied (adding CI once again).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
