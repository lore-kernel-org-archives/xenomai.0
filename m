Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4072F47
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 14:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXlA7JFqlyoQ6l1rrS/ThDt6lP880bw5Nn9JasEpBZb8yFK/XbZAGCPfR8qui0P5tLZE5D8dh7nUO0yqS7M5YAXdkOFv9zDsDb3sxg+iEk10sb0QP3yJbLutNewskjDIrzxndxDM0Fb7LXvxteZQM/6W2zQtM5Ohl0EpE2UjLXWF5cawLh3lVKzi667g3FqtcRZurt5YsIT1xrc/D66UNFaEDe6b/c3jTrL6dw3WqA3GS6jGaAP1+UGvGdNXFRp+1u7i5C0BDrOwak66BIWJ09yEsn0iDt+W3mGRaKylm5VcWXVMKtYWNtEwyB44iHwtRZtMILe8SW7OJUvCiO7dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgIRFnLDwenQdJ6P5a+IYiYMEjNdWQz6XbCw7XK0JoM=;
 b=KfDYQoyB0BkSyzoAR1SIGm0HbetUbh66YKYOA4imaS/yhdC3YBEF2WhmuhjJd2xrynVd9BMXt1UwsXN31nYLc/NQAVHp6rXZIOiWjSNo1zkGQV7gMvJPJSrYnLQkxIhxwCi6ZIMENmn4ir46vBqiYDeGj06Bj+srz8f3YPtT8sujOAR9TpWG3T7aJuhRZWufDlKbok5AAIrLcIfGh306af656XMiDeQzVpSZZdQe/8ECZXWtQPC7yXfku8xD0wQkfYTV9A2OaK13g4qzZR9HzcWNT0IjrtpQ6h44t2KqIky/SKiIFcV49IdnvKFIujq3NySkP4ApyqNTdzyOqR/wgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=126.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgIRFnLDwenQdJ6P5a+IYiYMEjNdWQz6XbCw7XK0JoM=;
 b=wp7JQyDAHbT8+hCg0CNo3fdBObVukxE3GsGgC3DdO093jSNyibOBfLVM3FjeMnkrd0pytRx2XEhejYdvnL4zmO9XfIaUfc7ipm1Gp8nbie1d3YJWmS6O8dkH7BFbola5f/Gt6RHYRkRPvGMmPD1skiou+ngKboYXCR1z+ZCXMhzQ/Zv0gflpxfMKeTPqIZ6qDQ5P8FOdrMnrM/CXtnoTcE5IrbcIvaOOzH1bAA9pG9OCwt6EmhveNCAFhxIhwnsYTeAL8j6OJuxrTT+yqudZXODADLgqLm0xZygkjnlwedk3tV3Y7wZEfkx+CJXqnpQZWk8lqWXkTDVGz6jxkaxDJA==
Received: from AS9PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:20b:467::20)
 by PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 14:54:47 +0000
Received: from VE1EUR01FT068.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::67) by AS9PR06CA0143.outlook.office365.com
 (2603:10a6:20b:467::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 14:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT068.mail.protection.outlook.com (10.152.3.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 14:54:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 10 Oct 2022 16:54:46 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 10 Oct
 2022 16:54:45 +0200
Message-ID: <c66ea2f5-6a7b-8420-f1ee-cd8abe7ad13d@siemens.com>
Date: Mon, 10 Oct 2022 16:54:33 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6baf052f.6f75.183c25409c4.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.366500-8.000000
X-TMASE-MatchedRID: ObgwaKFsELA5QaOxwNGfvvy6J2sQ40CSPg9yfk4YC0b0VCHd+VQiHvsJ
	B65N+sbMbDD7i2QfyEfyDN4pYiEjqUSO4XGGlsmL9KfzWkSUxxMhD0HWZtqYW56N6jXWJbQ3RiP
	TMMc/MmnIPbn2oQhptSYVfTz1t48s47mKjto1oKcsAXMgUHhp7pJ/9klbxR9liH95tLFH8eeFUO
	eR/MPu5oAjsy+r+wvny7L+BxDyhaKld8eQ0OUXSh/lqr1DbPLeNtwF1IC9LrXnBcjWg41W4PaS5
	2LUPfcSIIYx1jKpmOTnPnh0/4h2vEtexEkTXvGRahSYOnv0PXag0UgUtWWBi0cvveJlm0fmT5ys
	QDj6eFlnq+k+Y5DhgI41Yiw6vZQg9ZCtKExbfRgvHEcEx0NzujLvC8LxRzodngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8Krf4HH/DANiphnH39Bu/8UUihMMSeGDqIW+EpiL
	7qu5ATmgl+jXuH3F4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.366500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 6D9B47463ED8CBD533D97E7B0A7BBC732EBFA6E32B87A234C30A3317B25F5AA62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT068:EE_|PR3PR10MB3897:EE_
X-MS-Office365-Filtering-Correlation-Id: a788c949-1544-4f60-bda2-08daaacf5fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ubmC0Q0ictQmEOe2tg4ZcVT/pubZ/V1inF0TqPPZY+79wvyLfk6QWQuhdu0PlLKfAITjh57C5fEwj5iY1Of1kYfGb/AqvTjAM9W0LGcXQLdKf511UbI3fMtg4vcO9oiVxoQMEBPu9okvShVvkxlQDPNG1AECY+PCpITgHH4vAJTTY9Cms0VUI72NBEvP/+r2IKPmnB9V8dh4MCIx+VK3TyOQbg3noItQe7Rj983KYx1gsi+19hH/QQcNM3dWdrcegqNgnWGp5s4fpppoA1eUaaIMN1wF9bm/32/goJgNU+2onFHtmTru+RIXOq65S2+y36I3v2zvpRXz6FAd1s8CjfcmEB0Q2xW+U0fdVVv4AuPHQSgZEovaSQ0zP6Fqq2GGWpQsnrpwciYtpZetQpmCq8Gq43Hujt1GM9tdZytJTjlDQwCcSu+GbsYW1og2XUXVbTpkXvRSfIL2b0Gdu+9zLq+1wZu5ZHzsPrdXsrZDL0eWSDhahNZKfMj1bzwkYiyX12aZ+AwJvwoVa8gdYsX1ibTdGRMGUs8JuLhVepI+aEjLJcD0Y8DpgRtsvVB9NvGjLqQ5Mti9roTdhBXnaNFwbRLSHIyOp682gI9jB9GRGL788vG/hiheRH9U7+Umy7/O1jJ7jLJuwml3ElpbuyiX0FiRm9G/wU9OSyB1zTSxtfPCHBCQMSN2rzlHW9+WgkbPsK7VNkNybyppeHztp12/YEwois8+1gDC6yshBAvj7chuiDkCMnNzRPmeu11aT2FbcmaLVZEDvL24cfQhg36TBwsF5GQYD+XlYB1zJoZv+sf9Ss1eh5dZFwab2YDjSKtjXTmy+gb6GOYkYP/cpz8AdxOKjotTJVOZwk8jIocCRZHsTMG2aypTEaJuAQVRu2fLO5tnSoeHYeQzeOxEN0fR1A==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(4001150100001)(6706004)(7116003)(8676002)(31696002)(2906002)(70206006)(81166007)(36756003)(70586007)(41300700001)(4326008)(86362001)(40460700003)(356005)(82960400001)(82740400003)(26005)(966005)(16526019)(336012)(956004)(2616005)(16576012)(82310400005)(6666004)(478600001)(53546011)(3480700007)(47076005)(36860700001)(8936002)(83380400001)(316002)(40480700001)(6916009)(186003)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:54:46.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a788c949-1544-4f60-bda2-08daaacf5fab
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT068.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3897

On 10.10.22 16:37, Yxian.Yao wrote:
> 
> 
> Hi Jan,
>> At 2022-10-10 22:13:51, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>
>> No, I meant of you are calling "perf" in order to profile some
>> applications. The pure activation of the related kernel features is not
>> considered problematic, but some "perf" feature are if actively used.
> 
> My application software does not use perf. 
> I update the dual kernel after installing Debian 10.3, 
> install the xenomai cobalt library, and then run my application software. 
> How can I determine whether other applications in the system use perf?

Applications usually do not call those services directly - like you
don't start the debugger from a normal application.

> Are these kernel exceptions related to perf?
> 

The warnings start with perf, but I might have been too quick to shoot
at it. The real issue is definitely the page fault. You don't have a
stack backtrace for the first one?

Also note that your kernel is not just old /wrt to its base version
(4.19), it's also not using the latest I-pipe patch for that
(ipipe-core-4.19.252-cip78-x86-23).

> 
>> If you do not need those features, you may also try disabling them, if
>> that changes the picture. Also compare your config in this regard to the
>> config we test in xenomai-images (just a reference, not as the only
>> possibly valid config, by far).
> 
> Where can I get the xenomai-images and the config?

https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig

> In addition, the kernel has a lot of configuration items. 
> How can I determine which ones should be turned on and off?
> Is there a detailed instruction manual?
> 

The key switches are warned about. But that does not exclude that some
sleeping bug is only surfaced by turning on or off some feature that
others usually do not touch.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

