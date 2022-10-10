Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBB3209
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 16:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSYZceoayEQmY4r+w9Xa9amkxIszBdAx+QrGuc+J6Ey+z4uR43PUoSMGFPrjZDjxwkWTA1C6BVC67HFulnJkSRBzXcXJ9OqmVJWOqkmpyBiHcUsek2n6uS45gxWv6b9uA/9MbX3l5lWMZCcf5D/gW43bIj8fTekV9qjx9T7c4DH89xKhzMHs87AmUOPM7MaWuP8sXIX3RKqakk3oUkLzSVnZ28+3MQOSiLdhjF5myPPdVzxwIb+YD/jQY2jdDwQA8gJydG//qV/BTQ68/d5pSPC2/hs/AmxpXGOj9cf8DM/QOaJxp8xIHnFvRp8aqVI9epnDljIqIG7CwM101q+zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M7QgahBfbvCD0psJLPTNdDmdAz4qyNkInSEX9/RVOA=;
 b=Nmr6q2/YTmsR3+fnT72VDXpwNFR10st5RcrGgsHC4TBXDfPgn7vuceVw9hKxSuZHDvC/qGHkspr8BQIGqFGrkyXNeyNUokPtHNM1SpnCThOobbgbCZ0bJ12PsYX/wV8EgKcIuRRC0hnNVOPINpp2+6UkUxl3QSszMuIDXfi258tT78s9Y4kb/3FzHjH/zlky2HYFNuPJ6o3hAlaEuluFab+z/IdsIkgf/W2dRD9oARdBtZ1pUPSj8BHqXn68ALehGvbrYmqjOjNJ8bmXF8+UjWG7Te23OqWe7iTL7gRIxp7n7xCZKHna38vfLOfOXrJHMY0+r3SbIyPPpowOGEW8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=126.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M7QgahBfbvCD0psJLPTNdDmdAz4qyNkInSEX9/RVOA=;
 b=OZjh7hJ11kqP/AJYIWPXT4Ceogh5ZcmPNjZb1EbFfJSi0ldeTjWSQecDZ9xzUSixB70ctZl9dxX7qeRYdrnOrDciLLy/ZdwUdiMYXRcU5QvfGXzvCSDQnMGevTuJapBD9KYgq21CERdXCHWBAdtEnMmh22rzJid6HgClJscHvbkXezlybvIvtkc0DpAnn6vG1HAgQ9z1cWIK7RutfGVIJUzdWQhdpE8ImcyPzDBXYhoJoUJh1yYlujB0+OYcyC1WJBF6EhZ8TveW9zsGplIcRg8FapJd9XrIpAXbOHhhEA8jwyNp/XDIrS90cy2Fv/fzg6eMM9Asx8CQAt5wzmHm3A==
Received: from GV3P280CA0117.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::33) by
 DU0PR10MB6273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Mon, 10 Oct 2022 16:37:17 +0000
Received: from HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::6e) by GV3P280CA0117.outlook.office365.com
 (2603:10a6:150:8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT020.mail.protection.outlook.com (10.152.0.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:37:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 10 Oct 2022 18:37:16 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 10 Oct
 2022 18:37:16 +0200
Message-ID: <f4daac37-68d6-7c76-a58b-5d28c4c96978@siemens.com>
Date: Mon, 10 Oct 2022 18:37:04 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: some kernel exceptions
Content-Language: en-US
To: Yxian.Yao <yxianyao@126.com>
CC: <xenomai@lists.linux.dev>
References: <54a0470d.7082.183c217d486.Coremail.yxianyao@126.com>
 <1ff093a6-a231-898c-aee6-3bfb19178ae1@siemens.com>
 <76f26fbc.727a.183c23b0834.Coremail.yxianyao@126.com>
 <ae43e7c9-e35f-6f9a-ca2e-baceec231a50@siemens.com>
 <6baf052f.6f75.183c25409c4.Coremail.yxianyao@126.com>
 <c66ea2f5-6a7b-8420-f1ee-cd8abe7ad13d@siemens.com>
 <16329230.7168.183c284db3e.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <16329230.7168.183c284db3e.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.567800-8.000000
X-TMASE-MatchedRID: irl7E//xM945QaOxwNGfvvy6J2sQ40CSPg9yfk4YC0aLdOs6EBREoQIL
	zOoe9wbaEt/W/Pt5w8c0EQvSVyckK7argL8XeJwHoZJhW5/fKzGCfOQxFVW1+9B5TKVn+YuXVaI
	FkbBGkf439SEkyBcGrE8UroFNOGp78+j9F4dUdEI0e/Y8iC1gE5/0X5WpCPYcbBMSu4v05tML//
	VMxXlyE7fByDgHbepjXEWXYTWtGMLxsFFIWbc6/rPRk6St5d5GgSwDI28Ufj8vLP1C8DIeOiYof
	8qPjr5VCuSPuSVW5+54Eqpd84bqfyTiMF82GcCvasq9xzykaAUiXL+V+zm5iR1kSRHxj+Z5mGhe
	EvjzATuUAUfla+IhaLKXWmEvaG3ElyyR46PvItO2qNGaLuHnvr9ZdlL8eonaVnRXm1iHN1bEQdG
	7H66TyH4gKq42LRYkQsRoz98D60JezTH+Cgtly5xTKD+A2hgEhowjEYAWqmJ+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.567800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: B9CF0145A964CE4F1024F6E1F5F2786F5D85703275DC657938A1FF8E2904B7422000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT020:EE_|DU0PR10MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 360f4b2a-c7dd-4622-fa70-08daaaddb188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i3tq+NinjbiXEfnHn0Wmgk7v5AW3qvFlplL/VYwyJ4EQGBeUSb00qvkH7OFY1EZIU2X+myDv0yiXJfv3FC9WNMHihTl/tOuLe8Bzi+D4adcAWvuCATOcDNM/uXhRf6Qf6adpRzzc6JHDuE3Sj4zq3HKRtLctk4k+cwu6bNQM9zcjeuGFf0hTc7z8Mjcgvfxz4q/6juGUgo9c/sCofi5Y+Sob/JngWCz+m7TGngmVbccXrLMEIewVdullLj+ENTVkUHCDg2MyB0U65J5Sx1LZK/LpZmppzpOBflKDAEQ+mVJjE4qjWkz4dLXv+yU6zHGMXjyvH9WuyceSicvKvc6UEYs+kgAOz6ssC1CfTXW3a8s43O1n+7toZTGjH1kyTuxNmb3Xti2BJkGQu67pbu+SyFosiC6D/haJ7wC7HmGHGAHYSr595Ryv3f9ORWDhcOyvEb2xlFo3xhGJDqCOD3ZIb6xsAkMEBaeN4mZLw8RKjH0L4ro28lW1Nb4eaQkiKokcacinrIVOtnGqiwJOcdqKsSUENcwUJx2Zc65hEJYS8KC9PrkcROUliDcbO2Qc7B4VL6h4onIcFpAJKcqp3ciJDzeH0neSlVxdWD0IblhtI7v8eZHylQnbkXjMK2MdLF+eIOOonMyE8WVTsvlF/Syl3j2Q4JjL22r/VLgJ4ca0OBrM4UVcmPmTGmM7Yjxkcyijh+ymTdEnP5qhUoXb4q7UQiLeN7iijXB/SnVFcdd8gezzwniJjSVqSGFeQET9pPpzKbhflwr19qDj6gwm9jM829tP0uUV8Yrv1uLgO940uJCtnhMqgr8HJ2eMwJyCwb8jrcL6urcjtPirBYuXdIrs86GyZ69YWw6sVXBxmKhBbGg=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2616005)(40460700003)(356005)(16526019)(956004)(82740400003)(2906002)(82960400001)(186003)(44832011)(82310400005)(4326008)(40480700001)(6666004)(86362001)(6706004)(336012)(8936002)(6916009)(31696002)(83380400001)(70206006)(36756003)(7116003)(8676002)(41300700001)(70586007)(16576012)(26005)(81166007)(316002)(53546011)(478600001)(3480700007)(31686004)(36860700001)(5660300002)(47076005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:37:16.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360f4b2a-c7dd-4622-fa70-08daaaddb188
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6273

On 10.10.22 17:30, Yxian.Yao wrote:
> 
> Hi Jan,
> 
>> The warnings start with perf, but I might have been too quick to shoot
>> at it. The real issue is definitely the page fault. You don't have a
>> stack backtrace for the first one?
> 
> No, these are the last messages that the kernel outputs. 
> The second exception is the same as the first one？
> The logs are printed with "BUG: unable to handle kernel painting request at 00000000000a22e8"
> 

The issue is that you generally cannot trust succeeding BUG messages
after the first one. They may point into the wrong direction, not to the
root cause.

> 
>> Also note that your kernel is not just old /wrt to its base version
>> (4.19), it's also not using the latest I-pipe patch for that
>> (ipipe-core-4.19.252-cip78-x86-23).
> 
> What is the difference between cip and no cip on ipipe core?
> 

At some point, we moved from 4.19-LTS to 4.19-CIP as baseline for the
I-pipe patches as the latter kernel will live longer (10 instead of 6
years). No further development was done on the 4.19-LTS branch you are
sitting on, which is also missing some bug fixes to I-pipe since then.

> 
>> The key switches are warned about. But that does not exclude that some
>> sleeping bug is only surfaced by turning on or off some feature that
>> others usually do not touch.
> 
> 
> How to further determine what caused it?

Hard to say yet. Please re-try with the latest 4.19-ipipe release if
possible and also check if something changes positively when you use the
config from xenomai-images.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

