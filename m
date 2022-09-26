Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DD2F21
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 14:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCeRhdIIubRvjRh4WfY/1fur6e8P11Gv3Avo6VMPjVapyzY2FwB7QV3Rs12/uznzURv2Zm9AoUW8hTKtxHSYrh82FF0BKQN1EcVI1dBPTxLzwBX4zFlJIM9vLBRFJw4qu0jNvIHNemqe22luvfSZd43lcsP64iw1wC3FWt/z4OX3es4osqNWUl4vhyjFwGgrre16B2SkFGeLDtKclTjzUjmCbXLElqVx3++3kROGN6n0cxQR8Fsio/Qq7hy2cZ3jl4zI6L2vXoAaXVZUqeREWWrRzyJPKEWJ04zVkLKnz47obQvZ6YYCQrF6+9u4c0gvd+qSZzNmiRkBn+Ufl4dAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcrZb/6INqHAs/4Ow9OLn9/Wub+Lhfs07nOuV4EPbq8=;
 b=E5j7nPdYHoN0jdY+NFbO7gZ05RG68aVt0i67n8zbJE7SxA28tOweuzThaRWv/zWUgK71LdIlS1bgfToHTRGLxNxzjNh5HHSuLMBzFZV6zzy4CkSn+9668Yf8TTlH+As6tQF4sGVxWGDCeRJJvXR+qtFHUZK2mwm1ikX+Cv7ZfnedPgxcV9ix7rx15r9SlltpkPtn2dGB6e0lvae2DFBTgqDI52zeGu1aHSiXOWh97+owuq8HbOVzsY2Uik8Xxge7QlTtyRhRI1BJiw4oOKCKM0ut0INEEQb6Q9ErsghPan9lsatTNPZEXOzmH8hSZ3eZ16VX4YfpEVTX30fLoC17+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcrZb/6INqHAs/4Ow9OLn9/Wub+Lhfs07nOuV4EPbq8=;
 b=ean/IIEA3PyWRg5AaKE6zdERbv4q9W5Q6lG52Fh60zMfO+T0SJUHtJV5yLdaZzmSu48dL9vqv3qAwzeIhrE7mQAc1FwBoq4gE/NXPhIkT2DNIg0zMnXKXt9G0ybkCgCf3F3XHkrSJfCbcWBed9CG9pBQfHh47rbjz9T2q3CVAXef3zA1FBv1W7itvWAEG5Bf2MvDQ6z/DdJHypvfl4TAENfzqOpzdSGdyz8AvAosPx/xp/E3j4AZDyu0QAJtWDGcXDDDhvRN7UjoudnuPlYI9z5W/8sjqjjz/zLOxxy2A8Nzqxjo0XJBAPkM6s3HEqK6WYgHhalgBfFXrT6sibQWVQ==
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by DB8PR10MB3644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 14:57:04 +0000
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::7e) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 14:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT031.mail.protection.outlook.com (10.152.4.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 14:57:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 16:57:03 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 16:57:03 +0200
Message-ID: <b1cb0aa4-7707-b2af-72ad-723d98d500e3@siemens.com>
Date: Mon, 26 Sep 2022 16:57:02 +0200
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
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
 <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
 <da16ff7b5550d7a6fd2bb2aa67f6e194534282d8.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <da16ff7b5550d7a6fd2bb2aa67f6e194534282d8.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.624700-8.000000
X-TMASE-MatchedRID: AnkS0S6+UFo5QaOxwNGfvo9bHfxDWoibUlQrLabIzZMSEYfcJF0pRQD4
	keG7QhHmsendljuCrd1kcTXUAfcQr13e8fvsLTLzcV66GZiJADylSLM56aAmmMVbb3pjW5Mnjp+
	gEx9nJ9JjLp8Cm8vwF7Phm3TYvhYisC15ejuhiruZOKGKkgujy+IBO2YnOJez3nHtGkYl/VoCC8
	zqHvcG2jkdBgb2aCv8e/cQkmt0G7FvndOzYqDCnOqxCs2uEMsFYlAr3AgnbbWiVU7u7I4INUupr
	1fvkyppWAuSz3ewb21/Z0vkofu1LbiW7TGfzwPNlqH5IeVX+taeziiX8KrRqitPpXoicS5XY9Jl
	LwL1dg3DOS0FhcAXSkdLAHmJr315heDJAd6wrjIvHEcEx0NzujLvC8LxRzod9u1rQ4BgXPJ9LQi
	nZ4QefL6qvLNjDYTwIq95DjCZh0xdY+ZoWiLImyAHAopEd76v/08lkoB4c2gqGcafdzwwk0Zyu6
	ZwSeaKCDkXzHmmeBBK8zea0ntlAw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.624700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 877C6B35D8850C8ECFAA24CE397766B32AA397CF363BE590EA32072C9F2486B12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT031:EE_|DB8PR10MB3644:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bb527b-25da-4ac2-e40f-08da9fcf6002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jT5N0cY9TF26SJPFm3CsapN/WuXaLbqUywmrnGWcQ4lTDoKq1OEetoe8k3zgUpuXnj4EMrB41vzLfnk98VvTcEHPB5m/Q2REkaykD7ABO4vwgYgF7JvVnK/TAlAzInLXt4yqYm0nTzK19XMzqzcmhobVpJ/ryBkYXWVOQryrShvW2oYvjj5fJa9lhiMyTIs/wLBXkMWRUW8MICGhHkUAVCeobCq4hS6trWnjH9555AdEhMngw9oGcBv4cwFDIMG9q5JBPTAqAkf+iOey+/KRI2UEnuUqZ+b677MX+a3ddUun/Dz+2XP6g8Ogr7KFYzldzxrAoC8ABffWR9pXxZXQ1zI4htDvCL4sZzoOLI/pGnBtyWEaYIK1isfqPzzbiw1L+S29aiSNxhrsjcV7su8zhWdIgupAx/fxDn2aE6LUaBZwEAMQa95XoPBOnCWtMD0kuvgjYY5OMBwqIzYRMlAG0s2suNviHjzO+8zAxUUgOrForSSYcPBfqDDvkQ/OMQLfMXv7m4fcpYMGFXFKoHMWZGzLTpT+hLhoXqpbNdGRaHNbUeeM5gt3XDS8X2Myahkb42NHrsWJFQWVOmjSDwZdpdLRwErsJdMHCt0v8GDZxlY+OliJXx2nUJaPlvTJbxg4hCIAmxzPimv8MaztWwiusm82F7F8wzuXgryJsvzNr5QFbjBTIw3ySQ5RKSyE9bGGFsXVlYKdhQpQDy2SQNelGDgNjeY1TqMUZItt35v7lRFQTOvCxqpccVVgCUSzv4DkSG0YX0wVe5sRl6IDj0dtGRhCzBmZE9CFhYa9xeKZvGuZXGSLW8QhMmW+SclEzGyL2J8iMc0c77ohjpoi+JRtGQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(53546011)(478600001)(41300700001)(47076005)(83380400001)(26005)(186003)(16526019)(336012)(956004)(2616005)(2906002)(44832011)(40460700003)(82310400005)(5660300002)(40480700001)(316002)(6706004)(110136005)(8936002)(70206006)(70586007)(8676002)(16576012)(82960400001)(82740400003)(86362001)(31696002)(7596003)(7636003)(356005)(36860700001)(36756003)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 14:57:04.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bb527b-25da-4ac2-e40f-08da9fcf6002
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3644

On 26.09.22 16:21, Bezdeka, Florian (T CED SES-DE) wrote:
> On Mon, 2022-09-26 at 16:12 +0200, Jan Kiszka wrote:
>> On 20.09.22 14:24, Florian Bezdeka wrote:
>>> Changes in v2:
>>>   - Removed patch 1 (already merged)
>>>   - Splitted patch 2 into 2 parts (addressing review comments)
>>>     - rtdm extension (now in patch 1)
>>>     - compat support for rt_can (patch 2)
>>>   - Added patch 4 (helps to separate CI logs)
>>>
>>
>> How about using patch 1 on other drivers than thouse you address in
>> patch 2 and 3? Not needed? Or not possible?
> 
> No (failing) tests available. That's the main reason. There might be
> more that is missing regarding compat support in those drivers. As this
> is more compat than y2038 related I didn't spent to much time on that
> for now.
> 
> If you like we could add potential compat problematic drivers to some
> kind of todo / issue list.

I'm picking on this to ensure that the new RTDM APIs have at least been
validated against all potential in-tree users. So, could you have a look if

kernel/drivers/ipc/*
kernel/drivers/net/stack/iovec.c
kernel/drivers/net/stack/ipv4/tcp/tcp.c
kernel/drivers/net/stack/packet/af_packet.c

may have a need AND could make use of the functions? Actually writing
patches could still be done later.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

