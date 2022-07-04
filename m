Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924E46A3
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:51:20 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id DAFBE10001A
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:51:18 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D23BD9418CF;
	Mon,  4 Jul 2022 13:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM+bUVkADtsWkwek9FN/rM8QJ6JDTmytiuxsyZXpPO8iwIvWNOjxdg3snl9QRK2mifQHIxLveG89ahcJ6jby9k7mjZrgOeemtBUBXRYHq2v64zL65B/MEke/8pWr5JKYQt0Vs24h6cahVmNyM35lnaAtHBWnkfL++pipode9s+spQVv/AA0GU+C0cHgqfZRLV6eJuFHN3Hx7pw+y6Lr8XCZwqQBNg1WQWjpULhAeZnM4loHSnUYgRvX2cjwRLPNDH2gE14AyWUfSjN26VLlp1Lp88HL1DPpDD0bPFPxP2gkvNcqcQZYOH68H8tr/j+DA/1kMma4ekHyFI38xEFu22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAE3WhBohgtmjkA+n3SN1507kVCIr8UNrXzrdGrtttk=;
 b=dJdXs/l1ydf6ufHP6h57uf6GuzZ2XnFyh1Rga6omtT6UnIL987DwcpxBdg0CrwF/VREaHqh94ENgxmJbL/HTJcPXvixjXy5Z79LwqtwEGwJlFXUhbIKWkisW+iikXWgWz3DC+CaPlcsy4/pfUIj51OJhHdpknA8T92ylZbV1KhaREqkaT3K1XD7+ICeirsSbQjMEp+sP53qkNb4XVY+63V7ixWQ6vXdwNNLZ6aSf5GKmGcNTSPWhZaX9ElEXmi94sGnOVNBTKNeloI4ojgoAseO7Tzz8DTMonn5kT1LCqDuDoad2dBuxxXouVN37rRSJArCrY01n8VSNxeoLo+xJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAE3WhBohgtmjkA+n3SN1507kVCIr8UNrXzrdGrtttk=;
 b=CYiBcWiJ9MZnGBZ44SrvGrYt4eyGUtNxfq81VmBQF4WhOSoGQc+MSrkSxRFqV+1QWCdoEEs4Xk8/ZjpPbBPgyDrMhDgt9TAd5+jVnQIFuuztR8knL9SlbUK6uQ3sce81Cuv59FSct60Qsv63evtL6GlZjB6a3QykkGYAHm3CW0hFz7AzD9CZ+J+FnJxwEWJAUNJ7y+WMgyjEgch95YKbF+GU24ZKOSgn6XIOmFztsbyDxYltPcEvcpketme5oYtXduMQymstrkzshWb7AHTlOiIwYD10hRanf5J1vkcxNcy5fycHu40PpCPg9hmq0tHtm4FBaLrMGPC2XD7bKpp2sQ==
Received: from SV0P279CA0011.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::16)
 by AM6PR10MB1958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:51:16 +0000
Received: from HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::dc) by SV0P279CA0011.outlook.office365.com
 (2603:10a6:f10:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 13:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT062.mail.protection.outlook.com (10.152.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 13:51:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 4 Jul 2022 15:51:12 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 4 Jul 2022
 15:51:12 +0200
Message-ID: <a29a6cd1-9d2a-921a-9860-6126fa3a4bcd@siemens.com>
Date: Mon, 4 Jul 2022 15:51:12 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/15] Kernel 5.19 adjustments
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
CC: <xenomai@xenomai.org>, Gunter Grau <gunter.grau@philips.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
 <87ilodt2qq.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87ilodt2qq.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.951700-8.000000
X-TMASE-MatchedRID: kxpaLTp5p645QaOxwNGfvo9bHfxDWoibjtapcCTXkeCejeo11iW0Nzz3
	MFPwQ6W5oZn7hJmpbf1vGSJtubGn7bKPtkcjxQ5L1smIV73H0RncE+s8YdinI2LiVenyedyjeou
	vej40T4hQKAQSutQYXHBxcnybL6LtOPAJR2VDC9+QB+hdkOcxMd7/CnI+7e6xmS4eyDF9QUfkY1
	0aGY0Q4Qzvg1/q1MH2HTEinoKev7ML1fhv36w9UKsWzHw87v6EU/iZp2cK49xeYVWU5uHQ/EF+Q
	lYpjQppCtWCkj21FWSjxYyRBa/qJQPTK4qtAgwIEFY6gDmeXI0LbigRnpKlKSPzRlrdFGDwoqEA
	iOVMl555+iOWCq35VhlFctj5WFpje+UZFdHS6gpAKXfSCl3mbw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.951700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 AFA7561601439AD079F32377B2C2304312AC80723504EFB5FF5C9FD2D4364E332000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86378ac0-225f-413c-1306-08da5dc443f5
X-MS-TrafficTypeDiagnostic: AM6PR10MB1958:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHbMKI7aHCPmvoyGyHkfBtI3yHMksoeFGiaSDwAwoCZKyKBS6U5GFU5HaFAM1Y31j/sZ0dD55hgeAAbaHnwMh+xSgWhFmbjRJt5XKjC2gv2TwNL9ro2Ij5PUGxEbCBAaMmXJaUofBR04/BpNkmDrRiHjCjL8E6fod7iIvJ4j3m10szyygLzF2vQgNoyeckCftpMjLuJPb0aYD4dDs2joaQa+e56OAl99DoarXQ+18aKHLBoLAxOzOTenN6SVrkqhyP7rB6qj4fwF27nkirXxtANnkWRni894lhjzrlu9AlB34b77vt+9TGQSk4k2jzsy5OG+9n90WeBNLYMzzDMCToL3zvzFKK4UI39vHJIaRe3Ph/IOeEn0Gl/sxhtEB/QIVJpdKI1o5o8Bjrn/ee+Ney186ziaLkZvb3+aDD29YP7z5gnGaSCUscPQJsc+WL7zQsOyu6BocZ/UmUVQ+vblhIJVAPq7ZU4x+aoJss8xrAtT3kFG0Gh8CGE8brBP97e4e9nFg7oie73u3R6UmzLCkO8yj4g6sJ8jPJNf5tll7QKCN5qVnzdWefMfNvSo7/oFegkyMzfoGKwzyPvV/B58ZHLl61saypBq7wbD5tGGOJy4+Z2kMovy0ONT1O051LIpesqiXHiCeLPoEIz/uUAFwtarQEcx2dFh4gxFOoF43lBChUko6lSAEOImuTxpS9OJiwCcwAerVLUEiNDJtUYzT/m4vfu4ETtKr0s7pg93B8yoQL+3sGaNJsV6jY5VfV04uznEUkTbdV9LhX0JuHXXxjIvwscyUuVUXkQTCiJoBFAikg86gpCcBvDj0YJyExVPSXyCS3DHYCW4Yw/mjPpoGwRv6IubSBhjmp+BVhINXe8MCQnC2Ejq2JhRe+qLfh/M3H1vYLT0/EEhIl/gOpKes/pvil/yA5epJHHJHez7BcI=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(46966006)(36840700001)(4744005)(53546011)(26005)(44832011)(8936002)(70206006)(5660300002)(8676002)(54906003)(70586007)(4326008)(16576012)(31696002)(86362001)(6916009)(81166007)(41300700001)(356005)(82740400003)(82960400001)(6706004)(316002)(478600001)(83380400001)(47076005)(82310400005)(16526019)(186003)(40480700001)(36860700001)(40460700003)(31686004)(2906002)(36756003)(2616005)(956004)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:51:15.9891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86378ac0-225f-413c-1306-08da5dc443f5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1958
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.20.67 as permitted sender) client-ip=40.107.20.67; envelope-from=jan.kiszka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=CYiBcWiJ;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.20.67 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 04.07.22 15:35, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> This allows to compile and run Xenomai against latest 5.19-dovetail. The
>> kernel deprecated a number of APIs that forces us to move on. Luckily,
>> we can do that unconditionally in many cases as our lower limit is now
>> 5.10.
>>
>> Philippe, could you have a look at the SPI changes, specifically at
>> "drivers/spi: Convert to GPIO descriptor API"? I'm unable to test and
>> unsure if the conversion of find_cs_gpio is correct.
>>
> 
> I'll review those changes asap, but I don't have enough bandwidth for
> actually testing this code ATM. If anyone who currently depends on this
> driver and/or is willing to test it, please do not hesitate to chime in.
> 

Thanks in advance. Yes, the call should go to the whole community
regarding testing!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
