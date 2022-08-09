Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC87A
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 05:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T205owMlF5PxezXs7nVauCgurB3v1jAJXdV+mskAJWfrUECLqmRJWBngY6wPVtJSf0zvYOMhwdZ2ibjm8cW0tUAzwzoYx0s43xY95hUe/eFvNPD2kEC1u7gaUOFZcSDs/qcW0c4YqvjCmqN6bxQUr8BRv/X2XqAnxEcNKEi3dqInSMAS7ABAhQyJ0r/qoM3PwPSGgOFClbneqrFaRQyvvaj+1pFpIbU1Th5LovnMmXmCo4mHWagnykAXxBUF8MvapSeOEA2Ou2A+vBS8W+iQ/ZvgJlyiu+P79w8HgeWnSIRjN/gWGD3TNdmfQUIxnW/CCRzS+0wRygsvNe9orjRLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnQ5HNtPiq0NlYUbuh4tfZ2fvI7xiV4CwPEP8OFxhMM=;
 b=VhlEbk7/AMsB7z+CPwWe/9ZnMXm7lf4c942PDXMN1KYjn5gcPXBjAv9VWrbIQjsLe4wW5H/ZS1XUpa9TgiRRje3HKCvyYgAfePfTp3o8QMEpMkW+PKpn5e3MLuZO3avfbEaepjsEnOy4mgAuyusAecrv/yn03ACg5VK+UsKJE7YetDpWYq7vVFi2C/M/h6OK3E0sJNXYlPYCZTsVuVJW60YZ2eMaLYSwJLfjsERKhAUJcBtpdOtgTwdAtbZrUB4bk8t7KdBGTAW2V/uqwXxDZI/ffw3akgHRVo7CGEWVbHQwv8C6Y0D5akh+Pg34bOKdgiUZ8G+BWpxCDwsRvnrqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.76) smtp.rcpttodomain=thom.fr.eu.org smtp.mailfrom=siemens.com;
 dmarc=temperror action=none header.from=siemens.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnQ5HNtPiq0NlYUbuh4tfZ2fvI7xiV4CwPEP8OFxhMM=;
 b=RjKcHJXyWYEzxAp2oqclu3PtSJhiuaJFlyv6yxo0rtrlj+AD88r8mrGRIItEn5adUJFwQVZ8VVwysUZWNGLBuFDtAVRamPjMrlFK/wsOgxegosYy7MV6mSKGIbA6EVDB0yxHUrivQD+f2Beih0D9jk8JdyMMlujWIqyeb12pryktpwgu85RzSpVo4Zd2UJmIQr/LmQQt3KMmj45mIkqmFzV6w2MpHG7SvgVW60SBVhA3OiQbbgdMTgfwbdTtSqnMu+vAZXZ3eveUv/Ihqans+aeWg9EI5EobTSWjH6eLRWKvbmiaMVYO6F1Rabdv+kWxMAhKT8O/bnfbDAz06ummEA==
Received: from GV3P280CA0065.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::23) by
 AM0PR10MB2882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 05:56:37 +0000
Received: from HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::28) by GV3P280CA0065.outlook.office365.com
 (2603:10a6:150:a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 05:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.76) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT014.mail.protection.outlook.com (10.152.0.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 05:56:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 9 Aug 2022 07:56:35 +0200
Received: from [167.87.44.42] (167.87.44.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 9 Aug 2022
 07:56:34 +0200
Message-ID: <c0740fa3-b8ff-4e8d-08d3-10792dc0868f@siemens.com>
Date: Tue, 9 Aug 2022 07:56:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Using setuid to relinquish root rights
Content-Language: en-US
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>,
	<xenomai@lists.linux.dev>
References: <7eb52-62ed1200-d-65e32200@245807512>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7eb52-62ed1200-d-65e32200@245807512>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [167.87.44.42]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.701300-8.000000
X-TMASE-MatchedRID: AnkS0S6+UFrxcwVccMqxMEBu2tF/ewEwPg9yfk4YC0aiVU7u7I4INZ2/
	fsiwSEV3iKJ9ulRl1bcRabZ6+ZfTItyF7gLxQJQe07N+F7q2pmJmE7c4m3YlonnNctcK7zfFzlT
	5a6V0OSMvZMKeu0TTLgwFqajp21ReMXEzva6fGm/CfeBacBeafCUw/jz8mipWsFkCLeeufNtSDn
	PEI8clbdcUntbeUinjS2yxGRKp+k0U4y1IJPG1GSmbPptcFcCpYOAAdwiwkva84C/3iwAgxMnlJ
	e2gk8vIoguwQ+J4gZhVcXP3eMLfF683atTpX448H54QuRj/igXEAPZCs5UQ+/7FEhWgo0y8wJjn
	8yqLU6JOS1V6oZBCu9noquRwHY3BIFQ3w3ZkqyzFNsXKUk3nHXcYbeAdGHHXXmFVlObh0PwMq8t
	1qGggRJsoi2XrUn/JIq95DjCZh0xdY+ZoWiLImyAHAopEd76vSGOgrmPq+dFWRMmkGmZZiGKi6+
	OGLKSbdOxGJGbQVArBJaOGswJUMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.701300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 3BEA429FA31E879D5E551748C8A62609915C4CDD3DE3EAAC2ADD591AB491C7E82000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c707b7ed-809d-461c-cc48-08da79cbeb56
X-MS-TrafficTypeDiagnostic: AM0PR10MB2882:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H45ESEdxxLHXJ+YR1mYwwSiwDf2aKyFtOwrre2dpxev22QvmcSw86VBUs6ZZNNqx6aHcXzfT0dwQZf5zazY4epzBxp1N5LGO6D4VDa4JVOB4zfV/blGQV25t5gtB4zZ+fo9640aYO6ja2vuCORGBFq2R7tDukbv8rnR7zIMdPmGvFREEiDjFdjhrTEUmrT8/NH4AnFJDkI/lUmTXC/IxNSgNe+jcxrk8cdpvpfaTRfS6rPpp0z1j/aDhrRurWCoq7wK2hyt81/oSXhWy1/MclEarch/Jr514xwzbyaMg9HPlDk2fOcXVWeMhyZ4MOvTFGR7QXc6XO6vnj2BPkFmRwWF69DrThcqkxIyqFfOnMikhf6FaPAHCwi5GrOzn0w+rKgqHDVEI5v/Etn5fsmsOQhNG7ahkmCs/cIAUyTLsIrC+UvvCS1F5gebGf73BDqVeXdZvnqAAineRMD0fUyu5Un1DQ6+/HBRx4IQKmLM8T+yRDUmVNVopralo0TulS7uUlIoFwb/SsF5/Vmbwf4IXFTw/Zh/aUn4JoFBOzQR6/c1aiJea79INSFkb7xcuxma1SY7PplTCReva7ZpSbNyerfioEljRsuysEuFIiNeLCPlUDu7hOFZx7ZmyjrB9NtVuOqTlj8+CAY+a+o9QtsjoqzZocGkfnGmFtOl9j9rfM+S983qw2W9Fh4TE2ii0GVlwnDo9P19TuRC2BacRKo6/CmjhKH2OZYGTvgi/DKobHM7pISI1IXqEfQZlPPKweYgxm/pEQ8DyFA0/VmOPJI5703Bel5neWtKRaYlBASooPCfPmtEXuRKa3ztrLS9AcBPDoBPPmVQNmgN4wGIbZfrypyNXdB4Rufhf+4ly3SbtbPrzYJ2vcHqK1caRdec+QGe8bj9yVQOwP5+6weMOrPwR5A==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(16526019)(8936002)(70206006)(36756003)(70586007)(336012)(8676002)(478600001)(186003)(40460700003)(5660300002)(316002)(31686004)(16576012)(6706004)(31696002)(86362001)(110136005)(63350400001)(26005)(63370400001)(44832011)(53546011)(356005)(2906002)(82960400001)(81166007)(2616005)(82310400005)(66574015)(41300700001)(956004)(47076005)(82740400003)(36860700001)(40480700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 05:56:35.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c707b7ed-809d-461c-cc48-08da79cbeb56
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2882

On 05.08.22 14:50, François Legal wrote:
> Hello,
> 
> I'm running a Xenomai (3.1) app, that comprises both realtime xenomai thread and plain linux threads. The app starts as root so as to be able to bind <1024 tcp sockets.
> 
> After initialisation of the sockets and RT IPCs, I would like to reliquinsh root rights, by calling setuid.
> 
> After that call, I get lots of  syscall <56> denied to "One of my RT thread" and syscall <61> denied to "One of my RT thread".
> 
> I figured out I had to set the CAP_SYS_NICE capability to the app before, so I added 
> caps = cap_get_proc();
> cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
> cap_set_proc(caps);
> prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> 
> Without success. Morevover, the user that I set the uid to has group xenomai as primary group plus I do echo 1000 >  /sys/module/xenomai/parameters/allowed_group before running the app, but still.
> 
> Anybody can point me in the right direction.
> 

We may have regressions here as this configuration is not systematically
tested. From your description and me read-up of our current logic, this
is supposed to work fine.

Can you debug the kernel logic in more details, check, if the cap is
raised properly during the xenomai bind syscall and if we are later on
checking it correctly? Maybe some other condition that the cap if
failing, though I don't see yet which one.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
