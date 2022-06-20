Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150054.outbound.protection.outlook.com [40.107.15.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F97E0
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWZFIihVLjkOkNt6DiQWuaeX8Yk5hyQ59sM1RqhjlE5IcJk/GLo0wIhbCEJYeO5HHm1MPkmOM3A3r5P9VODOLggyY7oNu8qp5/qs7NwTmtGGlDt7x0iMdatx/+HzRAvvhtvhev8Ea764cMlLfp+N3SPYXwC9FT/qq1Oz78X4QJPR1XIdCa+C1ckUUrO31yBPLOaud5qgwOjqzS6Q2th4FjkiqpPjCje/FtFAJFUICTabj97M9Jynb4g30APo/zX6X+9pMQJJjhCCRXuRqUqtQcaxtbjGWWW2C9fZm8MHQa+SlKzUjjNHhSxVCX91VLu2LqUbQqQdWgy4NnciWA6nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6gwCwjnYTPzuIOl5ooyLoYqzVRHWP3Qk9G7Tx4M9Ds=;
 b=K+VpU1cl7PEN4kBE61kwpKMLHXRX/ZaDWx/fxfUwnoSxra0IXFHHExXTA7G+eP333VYqc3RjAkCHDscbUUXWJ/qeBq24aYQe/m+6Z87hZDehUtiJacfKk0RGev9Kr/BfLGO1fglJ2NSn75rYyjqpKqvoQgaQe/YgnYP4vI3bEANGNJAeV3dSALoNsBgERJzPaZSzce49AkdwCqhFxk2jI6icd+ITcMFurt8FF3yBVDnHQYvZg1x8lRG1glmEWj8FYxmji7UPwI7OFj77gqWofq7tbP4jaORTd/Pk61CgwlClR9o5j8dfNkOmcsvNgpI2otelmrKM4F+zs/RYss2DPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6gwCwjnYTPzuIOl5ooyLoYqzVRHWP3Qk9G7Tx4M9Ds=;
 b=MmW0DAnG1V5ons30a710PWMjQnonHNt8ZL2t1WdRzG0T+MQKsDnyYAe4FOhVbwh7tvMXSXe6DghJR/lsei4HclMfn1F3haF5Spjht0P3XCj02kWpSZCQ15mRZqdRdagocatTBBPLbOdjAcRIcntN35/l/of3ypwIuYmHWqvEySxv3Da41N0mbHFt7wE7Lha7Vimts8rmeyG/dRZDJj4ASJ27N54RGOad5oaIDERjPiqEg6bsr8JSYMdagvqwKsNgs0UxS0a/W2Y8EOrY1c8vPGxFwOQBXAUbcr+7V0hoFpYInL5dgNcEXAND8waRReNv2XIb5TDBHmhPX3xamSFmwA==
Received: from DB6PR07CA0182.eurprd07.prod.outlook.com (2603:10a6:6:42::12) by
 DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Mon, 20 Jun 2022 06:16:37 +0000
Received: from DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::6e) by DB6PR07CA0182.outlook.office365.com
 (2603:10a6:6:42::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Mon, 20 Jun 2022 06:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT034.mail.protection.outlook.com (10.152.4.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:16:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:16:36 +0200
Received: from [139.21.16.131] (139.21.16.131) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:16:35 +0200
Message-ID: <e644a78c-b8cb-edc6-7caa-9d6dde48fd20@siemens.com>
Date: Mon, 20 Jun 2022 08:16:35 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, <xenomai@lists.linux.dev>
References: <875yky6idl.fsf@xenomai.org>
 <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
In-Reply-To: <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.131]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.877000-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKB3J2rmPVmIKlWhtF5d47grPg9yfk4YC0Yo7b5tLxYZrUhM
	UByBUHErW+83mz7I3jHldxgef1KPBur0n5nmCu6G3pvuyKOE8lAMIQP85zkv2/bta0OAYFzyTLZ
	B6U/YaPo1EH4lNzIZSH3kR6l0wGIGwpGJd9opianLLeDfTUXm/TN1VvnSogA62fov7TwhL8nNCi
	BItkSKfyaTNbgbq25Fs1KtER6ri6ZytqtNUbeYNSZni+XcxY3ioqesYRoqSFmmAgeB6dclcki8r
	gutezVpB1j59po+6ETRlUK52SaiHitn1VzQVpr+LxxHBMdDc7oy7wvC8Uc6HZ4CIKY/Hg3AtOt1
	ofVlaoI7lDGytTXSz/oLR4+zsDTtjoczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.877000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 F08F5D3DA05A407A3E71FA97F00FC91C6900F751EAD0A41E92802F7DB09AFA962000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b305a4d-ff5a-4b66-46a9-08da52846e4b
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1222:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR1001MB12228924F6917BC0010DEF2295B09@DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aZkpeaWThpKcuYEy4HZDe6jgBVQqBbZaEe+N4Z8IgRTO4hcnpigyJlGS5xUmnu3YEXndcloYAYwiRAUBEV73Uo3jpJZH1gAbWmcUGSvWNzKD9WZ2znimPPN0xMottU4RDHDdAPrrNBmOzWA6KZSarB+q1k0x7YOJMbeZXLYi+DYUHJ4rjsEXi70sooZJrqFJx/FwHsH/zFCzzNjhJX5xFyvb2sahmYxQU2wIN4S5iQZXDtNCQBDk4gDJudYuCBJ0cclS3hLkK0NL/FGVvAOSbtLkGop/BDdOOktINlNC5baVtSe/UJf+cN7BuzWVgZ/bkY1ANeDU5H8ktWCZHTvqfBMtvXBpR5qpIHMWZihD59dBq1NrBadnHf5aTm0Xmg4XX6fzCuOzNkyGDsDnAsCWFq9j+92agp1F1Qwzsm3397jc8Cf9GW9Wh20jIBYGP8NiuU7P84hmQjl4NjupWBFj4uQfavyJ0z0sLveH/GeeGCyVSK4ugp7jPhFu4GAVyokg3b99wdUXibYGo2mqSjwxRElP6M9Sv8cz0TPmyvSpXBh8MVkv9rq1mi/lVfj5NN3Fp7CS1ZWjHhos8XYTFqgaTe9+/aDn6UCbeJadcmAO8cX6tqFK/g4+iQvAO6iV/dlWzdNvLcEWc0xnjQrnqa8Bhxt4Jdr15+bqcIUMmekvyo1oI5yCb4AQ7KgfnFtXnzBCflddhKAa4SxPvckAWk/S1EpYqb8lRGhXjc0osBjw7FgkcFs3J0umYiQGuq8QoSEb1qKgOXjBpQ/PuSrzgQKNduEBai1EhI25wraRfAHvH4L8vZfZLKGCC5VC+G7zBNqu
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(8676002)(70586007)(70206006)(47076005)(186003)(7116003)(26005)(2906002)(40460700003)(956004)(31696002)(53546011)(2616005)(336012)(16526019)(8936002)(5660300002)(498600001)(86362001)(44832011)(3480700007)(31686004)(4744005)(356005)(82960400001)(36756003)(82310400005)(6706004)(36860700001)(110136005)(16576012)(7596003)(316002)(7636003)(3940600001)(43740500002)(223123001)(130980200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:16:36.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b305a4d-ff5a-4b66-46a9-08da52846e4b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1222

On 20.06.22 08:13, Jan Kiszka wrote:
> On 18.06.22 18:11, Philippe Gerum wrote:
>>
>> The mailing list rehosting process is complete, welcome back.
>>
>> Unlike I previously announced, it looks like keeping xenomai@xenomai.org
>> available for posting to this list via mail forwarding is not going to
>> be possible. So please switch to xenomai@lists.linux.dev for this
>> purpose, the information on the website has been updated accordingly.
> 
> Fairly inconvenient. What prevents this?
> 
> Did you already updated the ipipe release script accordingly? Just
> pushed a 5.4 release, and it seems the announcement is not making it.
> 
> Thanks,
> Jan
> 

Another question in this context: Will it be possible to migrate the
archive? Would allow to retrieve the whole history from one source.

Jan

PS: Those reading lists via nntp: nntp.lore.kernel.org now provides
dev.linux.lists.xenomai.

-- 
Siemens AG, Technology
Competence Center Embedded Linux
