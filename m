Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940932F21
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 14:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O36CtXYGhzHWxxyyR50J/CWV1+fvZzOjQItmLjIy9UtiOlmwr7yT5IfeKfguoZOZOz02U8b1aUbE3CYcJNFJPcXb1qFyxq0E+JorrVNS7/lhBggD/pYqOe/nOnTdG4L9LiRNsivFEDNgqz7GvwP8x2s4FuTUxFXBsUkICnLBzucGYmCT4BZHlJWO6jATStgAI613GsLu4kx3XxgFlhjlR9g4j3AVQ3WkEVoyn6ATupbIWcFQaDPQZMHMwwbZGRpZkCjQG7cKRD9tvJIsty2CgqiBBbmp4IvOJ0FhmkZWSbML1omOdF86qBrIMm2Oqmx8u0sH5lX8881afisqT1UBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6zDenyJ0MPYwWxuxcbrmVZaJdF4yrygIJw5oy4IvEU=;
 b=UT5hkva9/Iw3nUiV6j+yn+jkSZZWMmGcnHoWLFfdQz9yyYqLuKkajq7daNu6bccOEBnictjraG4eIr+qUDAIHqTgjEtazdQHjYvgMBBxzIY3YWg2ay+Fjs8ipfi9EoIcVyOiO23CseJbb1vMyiP4D402J+Mnrh2Ryn4CxLlngqFIbXGacJWTyL9l0eWIxkaoY6RrgrvVHPv097EJkW6gNYD3fjK4VV8+GQRVnvPQ8PYCWRPcvyBkf6mzm+tPCjYtWU3AlkI/UnNzgyKAzMRkN4hqGxXK9vZoNi9hcKlSFiyrYJb3XmcSX8vXovyIWE3zDnC1eWIX03X1omV66r+Icg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6zDenyJ0MPYwWxuxcbrmVZaJdF4yrygIJw5oy4IvEU=;
 b=JzJee63O5o7G3lWGgNJIWz9Ge4/66XjCbv75GTQb36+zCpEsZ4WJ0SllO9r73YI0VHgLgAvk5ggpu2BnYcMoTYL4+tlnOnUYzx7m6rWOgUqNCuqGQvB4dLNoetvYtTBm+6mt0EUAtgL1D0UT4ntWCfrvTyy2CVbLrOR36AmQtpe5Ugim2X4HkaLpnoioCYQRNbr6hAjXBEyD5qp7THqabwq7iemneZO19kqGdBwIBcHGc9UijMP5FT7IBkJg1rawCd7+7ziCuFxKtS0jS/gDQjOwdAm3E+tSq8QFLVL36U8BpHnzkLx5Vq5lns41ZY9/6fEUgMxJx4qEcnQL9Mfrmg==
Received: from FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:95::18)
 by AS2PR10MB6426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 14:58:56 +0000
Received: from VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:95:cafe::36) by FR3P281CA0146.outlook.office365.com
 (2603:10a6:d10:95::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14 via Frontend
 Transport; Mon, 26 Sep 2022 14:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT037.mail.protection.outlook.com (10.152.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.19 via Frontend Transport; Mon, 26 Sep 2022 14:58:56 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 16:58:55 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 16:58:55 +0200
Message-ID: <a8005a9a-9d43-514d-20ec-3bee801c5b48@siemens.com>
Date: Mon, 26 Sep 2022 16:58:53 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/4] Enablement of compat tests in CI
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
 <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
 <da16ff7b5550d7a6fd2bb2aa67f6e194534282d8.camel@siemens.com>
 <b1cb0aa4-7707-b2af-72ad-723d98d500e3@siemens.com>
In-Reply-To: <b1cb0aa4-7707-b2af-72ad-723d98d500e3@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.190100-8.000000
X-TMASE-MatchedRID: 5kZRuoL5N6g5QaOxwNGfvo9bHfxDWoibUlQrLabIzZMSEYfcJF0pRQD4
	keG7QhHmsendljuCrd1kcTXUAfcQr13e8fvsLTLzcV66GZiJADylSLM56aAmmMVbb3pjW5Mnjp+
	gEx9nJ9JjLp8Cm8vwF7Phm3TYvhYisC15ejuhiruZOKGKkgujy+IBO2YnOJez3nHtGkYl/VoCC8
	zqHvcG2jkdBgb2aCv8e/cQkmt0G7FvndOzYqDCnOqxCs2uEMsFYlAr3AgnbbWiVU7u7I4INUupr
	1fvkyppWAuSz3ewb21/Z0vkofu1LbiW7TGfzwPNlqH5IeVX+taeziiX8KrRqitPpXoicS5XY9Jl
	LwL1dg3DOS0FhcAXSkdLAHmJr315Go/uijI4kyjf8Oiw/x5PVnxBTfdlzOBw5Qo03mEdwAEujMj
	6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfpGTpe1iiCJq71zr0FZRMbBWdFebWIc3VsRB0b
	sfrpPIfiAqrjYtFiR2z/EWOzSHQLSzLMRLH6o9esU9+/8Lid1zvvNT+bmKEn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.190100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 2BE4C2B4D7813AAFF71C8BE1023F52AB7DF4031F243D9400AEEDBF61E39680B22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT037:EE_|AS2PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a895a3-03fb-4731-8dbf-08da9fcfa28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QRG4nF6NhP/cfi4C320+cI1D03LeGVbSrzGJaOGCl9UAMyDkJx9g5lP/vMFqKBaNCLYyMrOtv8etEl2IfQ/G5c+Xhr9aG8Dg3huRDNhsj5Ijx5+iwHzhJUbW2BQqgVRj+scr4/RAFGMi2xBoDWbEyarpuGlh+MJZFBKHrfHvEop1cSkRNx+AFVb3rBGpi2xBflAOIxbwcobUB8IBCKHwfiqbsfd7i55CTpN+8KdopMovZoyoiZcb5Sw2BepRbhAFmWzriQZPq33uKGZZgNklWTr1cShfQVEzsWmPQs4HoV4g+EuXijysO49sUQryukcikwJarwqHB+6g+eYEB/gPSO8ps6kqtsf6ITOSF9y0zOmt0xDuAinQyGss2WOQ1MovaSDTvPWYVenvzpneaisFfNJnA1g2c22t3NY2cpnOzJ+oJhUfT+yYEEnCG1PfdH2zewyzCHGqb6iLz9z5T0JrunDS863HKdl3+iez5WTDWIIsKHDgIC+mrZmHarYTgfh8KToQXwjGQ0sUK21wP8NzNU7In2cduPkrr3Aw/+hGtA/tqMwPLzU4uMCp2dqm+pYjyixYdTj3E0dX1S54P9+9plbkjCqcrg50l6com5zhwyS/waVGNtu8aPWvmdJrQW50c6rithOxgCf/jIdMDQjjjErlNeMPaaXM3vN11GyaqPbkfhLMHP4mYJEFAIB2KBbgbYQw7cHD8r2BKVKMPm9MG0YlftDhZPG+qBigN6R0O8BLvqWlLW7OmO9Bs0980FeiPq1zKZzipwLR3R1/vN27eV3F+6bDiKYUyIXk98hOMQo4EulPAp3prsaSkEnrkhplJyuHSru9dsNv2WeuFnwlW2LW1s5RroorNO2mdG1cRp8=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(82960400001)(82740400003)(82310400005)(81166007)(31686004)(31696002)(478600001)(356005)(36860700001)(16576012)(8936002)(83380400001)(110136005)(316002)(53546011)(5660300002)(26005)(336012)(2906002)(47076005)(44832011)(6706004)(40460700003)(8676002)(40480700001)(956004)(2616005)(70206006)(36756003)(70586007)(41300700001)(186003)(16526019)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 14:58:56.0241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a895a3-03fb-4731-8dbf-08da9fcfa28f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6426

On 26.09.22 16:57, Jan Kiszka wrote:
> On 26.09.22 16:21, Bezdeka, Florian (T CED SES-DE) wrote:
>> On Mon, 2022-09-26 at 16:12 +0200, Jan Kiszka wrote:
>>> On 20.09.22 14:24, Florian Bezdeka wrote:
>>>> Changes in v2:
>>>>   - Removed patch 1 (already merged)
>>>>   - Splitted patch 2 into 2 parts (addressing review comments)
>>>>     - rtdm extension (now in patch 1)
>>>>     - compat support for rt_can (patch 2)
>>>>   - Added patch 4 (helps to separate CI logs)
>>>>
>>>
>>> How about using patch 1 on other drivers than thouse you address in
>>> patch 2 and 3? Not needed? Or not possible?
>>
>> No (failing) tests available. That's the main reason. There might be
>> more that is missing regarding compat support in those drivers. As this
>> is more compat than y2038 related I didn't spent to much time on that
>> for now.
>>
>> If you like we could add potential compat problematic drivers to some
>> kind of todo / issue list.
> 
> I'm picking on this to ensure that the new RTDM APIs have at least been
> validated against all potential in-tree users. So, could you have a look if
> 
> kernel/drivers/ipc/*
> kernel/drivers/net/stack/iovec.c
> kernel/drivers/net/stack/ipv4/tcp/tcp.c
> kernel/drivers/net/stack/packet/af_packet.c
> 
> may have a need AND could make use of the functions? Actually writing
> patches could still be done later.
> 
> Thanks,
> Jan
> 

Thanks said, I'm merging the series into next now as it fixes issues and
allows to progress. But we should validate the API before things move on
into master.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

