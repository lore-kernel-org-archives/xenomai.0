Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549057E6
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/cccgUWSvCeXyCmGo5w2nE3sPTfcHivRnCul7j+eajN9kLDLo2+q2HubxcuMEjNFo5dzRgkloFIDINR0bmnRUxMx+CSSSnoZBZj1FI/VZ4qTgqsBHEAz4rpLC0KdSNRW4W7YiXXkIBFdVZoACOdYegFPgJhg60tO7YP6aW69ELY7aTlLlTPaHpXKLLSblORqa5msFQzGYTDfVkmU7WQkTuVSAJHLeSSvIK4SCaHmh1Tc14qwv4+CNsJOzKizwlTnBm1TaSaY2TjwernAsbLto2tQTa9Ik8APrOWt1ePQSGBjgi+1mjQ7nd8LK525CuNlMgaVxAjL86T+ViDJntIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRdZ9clvAIJg+rFaf23Aobif7aHNeRcQd/XHkREwZAk=;
 b=gSstlzhn0fQmJ7/RNP14Gy2euOm5+OkZH6yWpTCaLFRSTodpi9LKxzmWA5OvUhr00az2iCQGsIWEiLNz52hqaRqc8fo4LiYTfAmlKBAc0mq2v/Bf8b8JHqGWw4hDBKKNoIq/qh1UydqRaOaX948Hw4P/IsjMeB3mk3dc/XQfCm6BtVAf0IsQNLvEsihTwmjwA2MgUYCUt7MvwXeK9wMDgNrxeMLs3UtCnjTYKW+GE3EEvK/ZJevPStsu5EYI1MBJAm8942c918uKt92f4PG+gcTY0qq7kSzSCr5TE6mGrn2QRkMGxG1EVAmbtMq2oyAp29KznDJBY/41BoQVFsZJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRdZ9clvAIJg+rFaf23Aobif7aHNeRcQd/XHkREwZAk=;
 b=NuZHoEEfDYdI6D6HmAgppwrQlK+F2IXozDKWABEu2Wt/v941PQ74mUudYyKGijt8emYX3u9IOwSYf5Dk78o+Dgx4J1dpkRzEo43x03KaeWP9fhNNIEfVNYjmDznitewcQrmPH1BgCsdqeKlS+DcbhqIC3tlfH+qNLshags5nrdsE9h/JdTwdg5wIUnxD8Yyy5ZPjZ1wR5QaRmdSN5igcr/ox/iXW5fF4zblyqnfSyJfJtcybYd6uWrHn/PAkNCQ+l8VogBY4iGwRJDW4hqbDd2CZFk6VoN8mPKXb41e6PGMha68Jpu4mJgxXHSvGOuOPza+2L8d2vbCOWZrlEhNxFw==
Received: from AS9PR06CA0083.eurprd06.prod.outlook.com (2603:10a6:20b:464::27)
 by VI1PR10MB1870.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 06:47:32 +0000
Received: from VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::37) by AS9PR06CA0083.outlook.office365.com
 (2603:10a6:20b:464::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Mon, 20 Jun 2022 06:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT096.mail.protection.outlook.com (10.152.3.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:47:31 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:47:31 +0200
Received: from [139.21.16.131] (139.21.16.131) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:47:30 +0200
Message-ID: <8d535cf2-3bb7-634e-3c73-1ea4ad2642c3@siemens.com>
Date: Mon, 20 Jun 2022 08:47:30 +0200
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
X-TM-AS-Result: No-10--15.306000-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe53J2rmPVmIKlWhtF5d47grPg9yfk4YC0Yo7b5tLxYZrUhM
	UByBUHErW+83mz7I3jHldxgef1KPBur0n5nmCu6G3pvuyKOE8lAMIQP85zkv2/bta0OAYFzyTLZ
	B6U/YaPo1EH4lNzIZSH3kR6l0wGIGwpGJd9opianLLeDfTUXm/TN1VvnSogA6Maj0jvT403kKW6
	8eInZ/hbV5fSMRD1zqe/pwbu325eo6xUU9X/TgthZeBfeAqQqSvUxpsK1XD0vece0aRiX9Whpxm
	KWTfsQIpF5rzBQB1DrnfgacbZb5+Cvn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdcmfM
	3DjaQLHEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.306000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 497C1B3E78DE0E90A651316EFC4FA0C15AE61C682E677369A70AC84AFC18C3522000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aee6ded-e508-49c0-ae0f-08da5288bfed
X-MS-TrafficTypeDiagnostic: VI1PR10MB1870:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR10MB1870D416A05E2EFA74FB582295B09@VI1PR10MB1870.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IGXO41wwsn8zo1ofLxETEugDshf3JGmVn29eTbF4Yuhekq1Iv+K4kHcW4HdxVodq7pCNMz3Akte9j7JIQdmi+wh6nMnK+1rSW9T18Az5br15+pObZ3kJS8qa7ApolDMPJSjG3TASTgF5h8AGI2bVQb0EU/Wn0ij5H+4HhLAHps7qHgZxf/rFZ4X9naoylerhjcoHMB7I999EkqmBbQcmkw9odIW46HUIelvncG/4CUpkJ+ZaaczcBTAEo/1coDmxPcUcA/HeK0YivxEL0DoBKbqjCPHexP1VOOLDHv8e3uHZtCnnSdiQ4IjgQdTC7WylCx1Gfnw5+oPI9ZlBdpPAOARodSenDJROMd/3ytWeLKDRrVBy8X6BTaWkbEdzPpl0s+uUa4QXqVk/m103p/Nh8EpPBu5qDIVZ+8PG/ECFDnnipwnvSWea5tjbvsf9A2KAt4Bqomix6WpM8IzNHbfaZmqspXQUaZlPtoBtoDXvelPl4kIKxqLEEJkcAsWXeeGlI+LHcdDgRobT8n1bsgBs0GJg9wdk1eYb0U8q/DX0HwNsPJL/bquvMlk8v2GxduPZ2dCAfHKWq3R6F9xLknL4paFEPdp/PEXbu9qarZ3T+1RXicpjr65BM2TlK3rhIUKHSm9VjS2VnHG50RsLHD8jCsCMsQUCmibGgQ8Sp/hqpSMGIt1QHjqek4uXWEnRNJdJ3DUPdtK9aE342Xo7dVjQ0LcZEUnu8IOyIFDsZtTSI6qQsC7uO5029KS5XMj0UJoLtCXxkpzSEbHfBJWv0RsUWUAl3JOM9Nd4xcFuGdsghxSF/rNjI7msru2rjIr9XZjesA5SFqa5o+Cf02UNWwQaiQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(498600001)(70206006)(70586007)(36756003)(40460700003)(86362001)(8676002)(81166007)(2616005)(36860700001)(186003)(956004)(336012)(82960400001)(2906002)(44832011)(31686004)(6706004)(26005)(31696002)(356005)(16526019)(7116003)(316002)(16576012)(3480700007)(53546011)(47076005)(5660300002)(82310400005)(83380400001)(110136005)(8936002)(3940600001)(43740500002)(223123001)(36900700001)(130980200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:47:31.4776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aee6ded-e508-49c0-ae0f-08da5288bfed
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1870

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

Is this the reason?

> This is the mlmmj program managing the <xenomai@lists.linux.dev> mailing
> list.
> 
> The message from <jan.kiszka@siemens.com> with subject "Re: [PATCH]
> rtdm/drvlib: Prevent pagefaults on arm on io mapping" was unable to be
> delivered to the list because the list address was not found in either the
> To: or CC: header.

Can't we add the old address to an exception list there? Following up on
previous posting will generate this issue, at least for a couple of
months from now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
