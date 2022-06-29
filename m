Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EE7B
	for <xenomai@lists.linux.dev>; Wed, 29 Jun 2022 16:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czobpwIkjlUj6GgBhwFcmEhu/283Rr8cimrXQxdpwGeraw/kcuLFsk+exvrKPEmSd5Wob0gcbrHo0yrfL1HOaPXeW8wMU00WApomgEz0dq2LQ1LBLGyMa6mO9KX3U3I0lfVp+7lPbeChZIDYhIm+rJsjbe8gcbbqtc19PKdMTZnoda5T44j+u8ynhqKVk2cpX8WQ/J12QRqqgJIhpfR0Dg2LQ/Y946zy+8Lxe0iqYYeEF1ljH3OhSZ8JauuYXKJjVtWXhjKzSN//8lmYl3keCXZmlaXf0KMNnmxxaCjwgxgDsGPF+5tYuaoWTt7auH5hQgqzyyyOAp7rzZPLNNUTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPBgexnlq/IJVpFWGiIhDymQLdKPj8+UpIIOKl2S1CQ=;
 b=K53AMK9Q6oo2GJ/es7xEQuEV84l0jDQ4rYX6oDXu03tosZQBRud7SLeJS5GCZrcGaqF775otpagf7jvk+PT/q1iAidlQlOPAEW7gD3VoWcgYvvZntE8gVUrXajE1lxvqse/25uTiG66HjncE7LneoXhvaOJltBB8CXA84wJowx9AzGikKlAfJ90WCop/HSmaMn9gX4frX66TI7lnkZqA29Ift5JN5+GSAULsw+jvTqS3al/Q3ABSCWL74IhqpSKxBqYelAmXYGVFtDiEawH0DjinoDTVC59CFvloHJ3dlYVUL1KFqMatXX9L1qsNsM5Uz4G125pteVqqTY8aO926bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPBgexnlq/IJVpFWGiIhDymQLdKPj8+UpIIOKl2S1CQ=;
 b=bF0AYKI8S5VUdx5ZwCTocWCKmkPzIXZ/qGezZ2E3PRCQAxE1hGU0cvQ+83FMHxIDTAbd0xyRLyBhrjZD2TcZqcM59O/LB/rjZIlcaDgS/pC89EE8/zSWAq6LAnVoQqgf/GtxpW4ldijN8fTQJw98fGZyEjIDOj2+CiV1niNX4HTdnZQrITtvYnN8VxN/1N6+Gq4F3+8s4x4nH0Hm35CnD2xSIEZbIFUlUkJ01FXCTlWUMhZuM6asq1KRdceNThaLNIxD9zBytrfq4OybkQ2VzK+Ioq8zsR1TaSvQEvJbQRpdVNVrdOWlGIW4G7jecBfEjLvkQfqEtH6Ra4PEqxlXUw==
Received: from FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::19)
 by PR3PR10MB3898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:56:39 +0000
Received: from VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:15:cafe::2b) by FR0P281CA0014.outlook.office365.com
 (2603:10a6:d10:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 16:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT011.mail.protection.outlook.com (10.152.2.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 16:56:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 29 Jun 2022 18:56:37 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Wed, 29 Jun
 2022 18:56:36 +0200
Message-ID: <ff6f30d3-ae56-3d13-efb8-6d51ca231ca5@siemens.com>
Date: Wed, 29 Jun 2022 18:56:36 +0200
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
 <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
In-Reply-To: <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.138300-8.000000
X-TMASE-MatchedRID: /N/byFxmbGL/J7/cdz0rWr//VCGogePzP0DBdQeKlX0wo+sXt0rns5ho
	XhL48wE7V0rj5xi3XrhBOVMZbLi/hANjI1v/y5/0cXm2SKSBDyHjIHTY55IMSfw4wQxTs7JmTJD
	l9FKHbrl/2iy8d1BiwjSghb/pcAwySgaXHbJtjvlihfH8cTApBwwnRlHVauMMAkKD5kW4Zx/ihJ
	3Xxt2bAgg2kgWdt3qa6GBMuLMdFgCvHUrzn1Ip2UHnR1CAgdHDTBZpkDublHcRyVsAxhhjrJGAt
	645FF0SlAFH5WviIWiyl1phL2htxGyTS19XJRivtWKNR2epAFaR9GF2J2xqMzl/1fD/GopdWQy9
	YC5qGvzKU1cWyI3gWkkpbiYOUmwxIAcCikR3vq8Vs1lYr8/rzq4g4JWaF1JyBi8jXhd11IFWlo5
	VQvt5PQmByToQ72MY
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.138300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 4C621B140DFABD80EABA67EF4A89AF62595DDE83E2D719C61B22E4EFB863F1332000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42faf109-144e-4c84-0dc8-08da59f054b8
X-MS-TrafficTypeDiagnostic: PR3PR10MB3898:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnhPblBSWXZ4ZmNRRUFmelFmZXkrOUZhV0dmUUg3MFcvUHREZGZKWWlmWDgx?=
 =?utf-8?B?NjNBdC8vMUJRL28wMjBabUlrbjhqbkNIa3U4WktZM2VSQVJETmxicWcwVGFu?=
 =?utf-8?B?eWs1VmorQmRsSStEVExsVXoyanByeWE0Nkp2S2wzeEJnOC9WeFFsUUxvcFJV?=
 =?utf-8?B?akFlNHpWOERxYjF5bWF3bTRCd21tK0k5M1BvVWUxdGsva1RzcXptaEJLV2d3?=
 =?utf-8?B?dWIxdGxHOHpJN2pFc3lWMlJFWkZTK0VMeG11Y3k5NkhDS2V6Lzl5ZG5DMXYy?=
 =?utf-8?B?cmV6L0lQaFB4YVVISjNZNnI5SERtYTBVdkUyYW1QVXRrS0NPOUZhTFNneVND?=
 =?utf-8?B?MTJlVk43MEtKN3R4c00wcEtidTBsWkRZR00wRCsvS09OWTVDdlIzOVBVbU9D?=
 =?utf-8?B?d1MyL0wrTkxwZXdxTTJMRjVGMWJCem9WSk9mYmMzTENGREIxWkphVGxmUFZm?=
 =?utf-8?B?Tm1UaDJ4OW5Nb3JOaElUcWNFVHh4YzFIY3NNZ3RLZm4yZ29QWnJLU08wb1hZ?=
 =?utf-8?B?VWFQMVJvaXN4STlJZHE2OVRXZ29ZZEdiUW91ZWN5amoxWlBreFJwcDM3QWd4?=
 =?utf-8?B?cUYybGszVjJYSFY4Z0k0b0pSRGs3SzJEdzJuWmM0SHFZOWJZWi91S2owMlhR?=
 =?utf-8?B?OEJtdGtNemUvVEZWSHZ2dWEwM0VkZnI5TDRKTFcxa1RxNFRpdkVsSHU2NmlW?=
 =?utf-8?B?TzNPMldNOEFRZWRwUkRRUXpCYXREdk81RTNFcWdNZ2tnQVh6S0szNThsM3px?=
 =?utf-8?B?UDgvUWpPdGFBbWlOTVA3ZWdTMW1NWVBteHdzMTV6bm9WYTR4Y3M5bmRDeGNx?=
 =?utf-8?B?Tkd5OWxERi9ybTVJbU5oMGNlNjB0cUc3SlR0aDNhRTN5SmhwcE05YWViLzNj?=
 =?utf-8?B?MXBFb0toMlJFN1JJeXI5SjIxRVl5eWhLb3poNmR5UlJkQ3dHdTQzRkZQd1hn?=
 =?utf-8?B?ckNGc2Z2R0JlUG81ZlpJd2lhRzU2dWJtMTIxekJPbzNneXowaFlXeGpsaUMy?=
 =?utf-8?B?R3Nob05PM0QzK3dEaWpSTU96bWRwWSt6QS9GUkIrdXAyaW5BcnJuTmpjcU5I?=
 =?utf-8?B?NUJRQ0JDL2Z6akRERkdTUG5mcSs1WW41akZrYUUycHpvWm1FV1ZXUzdQYVha?=
 =?utf-8?B?NWJ0Q2xrSU9oSlFKZkZkaFJDRnVrb0tYMnpyREdOcjdPYUVLRGt6c3J5TkRL?=
 =?utf-8?B?WDhRbXY5U3ZiMENmRElabS9UUldheDhRVmF4ZXBubmtueWRSQTIxNW1CVWMr?=
 =?utf-8?B?MUlVSElIckMyeFpZUDM5ODdYcGJZQU51YnQ0czV0bnFuL1VNUT09?=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(8676002)(478600001)(70206006)(81166007)(16576012)(82310400005)(6706004)(186003)(8936002)(966005)(110136005)(40480700001)(2616005)(31696002)(70586007)(41300700001)(82960400001)(356005)(82740400003)(956004)(86362001)(316002)(26005)(2906002)(5660300002)(47076005)(44832011)(40460700003)(36756003)(336012)(83380400001)(31686004)(53546011)(16526019)(36860700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:56:37.4249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42faf109-144e-4c84-0dc8-08da59f054b8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3898

On 21.06.22 08:47, Jan Kiszka wrote:
> On 21.06.22 08:10, Jan Kiszka wrote:
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/452968 (qemu-arm64) 
>>
>> 2022-06-20T23:57:39 [    0.337643] printk: console [ttyAMA0] enabled
>> 2022-06-20T23:57:39 [    0.349807] Unable to handle kernel paging request at virtual address ffff80003675c000
>> ...
>> 2022-06-20T23:57:39 [    0.359334] Call trace:
>> 2022-06-20T23:57:39 [    0.359508]  locked_inode_to_wb_and_lock_list+0x60/0x180
>> 2022-06-20T23:57:39 [    0.359577]  __mark_inode_dirty+0x2e0/0x430
>> 2022-06-20T23:57:39 [    0.359603]  simple_setattr+0x50/0x80
>> 2022-06-20T23:57:39 [    0.359617]  notify_change+0x37c/0x3f0
>> 2022-06-20T23:57:39 [    0.359636]  handle_create+0x1b0/0x21c
>> 2022-06-20T23:57:39 [    0.359669]  devtmpfsd+0x80/0xd0
>> 2022-06-20T23:57:39 [    0.359688]  kthread+0x150/0x160
>> 2022-06-20T23:57:39 [    0.359707]  ret_from_fork+0x10/0x20
>> 2022-06-20T23:57:39 [    0.360029] Code: 11000421 b90012a1 d538d081 8b010000 (c85f7c03) 
>> 2022-06-20T23:57:39 [    0.369411] ---[ end trace 91ca49b5035e8050 ]---
>>
>> Hitting retry now to see if it sticks. The real arm64 target was stuck 
>> in u-boot (tftp), so I cannot tell yet if it is only a side-effect of 
>> emulation.
>>
> 
> The issue with QEMU sticks:
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/453115
> 
> But now CI is failing in the infrastructure, so I can't retest on hikey.
> 

Mainline stable regression of
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bafbc134f5b0948aa1ca015a0dff70b02c0152b7
(5.15.47), fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ca67881dcef04c5b586a3b122307b183babd62dc
(5.15.49).

Philippe, could you refresh v5.15.y-dovetail-rebase to consume this and
fix our CI again?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
