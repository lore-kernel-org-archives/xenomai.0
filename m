Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE87A
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 05:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nElA34v29pyvjc7YSwCcEAg1g9+0vRWDVi4fLgEHtTWz/ke9D5vb3eKsd2xWXHaAkqnAE7pYrdZaO+HaraLv1wkoZMJytZrxj3PWh4vz2T8h6qkK4ancuH7JRZMRxjjURyLBGfbdlgEK0tRw2bkQ6Zt5qg42HPLsUzlrDk2IS83E5nbZ/7x267oxjSWsM5Ku0Vwaw5vMvhFvd/oxb20YFTeiqZm2afWhNUUMY10csmr0HUIUwn+SgsyTi1OqMmc/9mLmwe0RbzbrOp6bcbIkRMdl2syoeNNc3sKJzJ+16Yo4syBTw975zbk7SsuNO5Z72g72vMukgDQ3RhhxCGZdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG++kL0Z8YCJD2mn5RrGq6tXkh8iJemJ0uiqIlmNgks=;
 b=Q5Gz8G7CrWvKB3OE1AnZm/gZIp6Ebk0mLRWeTYyB9L7fVIkSuds7HG+JpKIwpz51PepYACSBOyO82iUbKX85R+6k6w86EGtAS0ovUKe8uAMZspgozZps20lD/5ydaghbwZAuFURxuMfceYXx9lSILSq3TAFOgANqWYXUIqVyX2+2/GtK8yjiG7pVthS5QKncYW8YMvYYzZrDKXelFpiJOW9MNBywI9Bi1ohiSldPJJxcTGXt8oxZVe+8zSVsHaLgksyYyzUVFs7tuBD1E3rCS6gqVB8US6HfnTe6ADaJ+ZnnBWPz5ya1zfdyv82m9AEetghL6TPUiG3MKJbV5PS37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG++kL0Z8YCJD2mn5RrGq6tXkh8iJemJ0uiqIlmNgks=;
 b=JWvHPw2VI5tC/tVQLxgAZMfLOEPddAiiC4Ea0e6yEOKmBSiIn76CIfqiRSrDjjGK0iEusDKTkWYvzgZWFqgpB5bjREcFolrtFf2PjOCD+vwmyi5X0BI024tIMy13IKPcfcgK69vH3kFiU413P2133BaTP5Pxw+Dy78kPtwoSPzWX/pKcDgwaulcJY60hjGRzZmU8+fsXhPU2TATN1udhH9VXPkjI3ZTGOMiIAUBtOfBpGAKF1/mJtEsCbDPNFC9BllCuVZeyr+Jg7SEZ98HIPFvdOJWY7qQA7PGZpRMTa8cE3/1QdzOGKeJ95tM6n6bdANrYvoDewT0a0cIX1yKarw==
Received: from GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::31) by
 AS8PR10MB4743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:336::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 05:53:50 +0000
Received: from HE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::c) by GV3P280CA0118.outlook.office365.com
 (2603:10a6:150:8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 05:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT066.mail.protection.outlook.com (10.152.0.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 05:53:50 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 07:53:49 +0200
Received: from [167.87.44.42] (167.87.44.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 9 Aug 2022
 07:53:49 +0200
Message-ID: <22732737-b2fa-2561-3936-c503fb4ca57a@siemens.com>
Date: Tue, 9 Aug 2022 07:53:47 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Crash in xnclock_set_wallclock() if time/date is set early
Content-Language: en-US
To: Yuri Zaporozhets <yuri.zaporozhets@gmail.com>, <xenomai@lists.linux.dev>
References: <CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.44.42]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.428800-8.000000
X-TMASE-MatchedRID: 8xNMUprDHafPhQMrvkSA3njXAviTp2YZPg9yfk4YC0aSi82OWa7YY+D8
	veomc3zgkY8eITaSJPijiKyi/sp0JBXqeLxjyCDuhg7u0oQFj2cdYTfgzQY7ziqRJ4M9q7OveLL
	CA0PD7aip3QxRZDyTw06pgIbVd5RED3Nx13cUNzkPQj+lSK0Jjr1MabCtVw9LSHCU59h5KrEA+J
	Hhu0IR5o2cB1+t/hlelUcxGfWk0G0r59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXXJnz
	Nw42kCx2bNx1HEv7HAqtq5d3cxkNY8uVL0xheujjlIU7aZVD1psLtd6Z1k27fC8z15EtEJRVil9
	P47auLI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.428800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 712CA3548DB0144E72C40AEF7E69A812C01E914A7D6A44EF25A6953C4A6702D22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca2bf82-a554-45e0-9d3a-08da79cb889b
X-MS-TrafficTypeDiagnostic: AS8PR10MB4743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HeFoKzoBAPx7Hb/zBmWWGHHCtBdy/vnYHoXXx8i98A8aNQzIuH2TMJ7IX6m3uq3Qrg2xO7ElkxWkMxXxXgNxYcPB8fzviKsYIK3H9keiNWgku/8VDLfa7w9FzFNL8rQpJLXduO2dtFyB1oPzz/CVhdQw03TONDpVxJOpDRzOvzCl750t7ypIsKZTRW0sg+0F8meqFe9rhmnP7MnEd84P9tkH/Tkn/n2FRSwnBjUdjAlNFC/7q+dR0Ev9gT3EUZtvedKUEkOcqc6sqSjpScNAM0SohZm3QVHRUbZbipFkaJ8pMtN3RTygVU9n/eHa+NwR8zLvJdOIkg06pDlCxWDQZryQ6pHpA3JxUnwDm0TwO3OKhCBSejHi3ilov7nFrSWpJZloakzHVkZxX8rCc16hweX1w68NW7cB/rM22j7Xzr3mHyTK8QkIrCtVy6VDQL9KJb95ueAT11BrLvMF0zLB54qZ9wjONUMi7nHY5cDSMe95wMsImo1x3dVD64nmFWrMwjgAbUf1xsSVXjyXs3b0vLrunUIY/hpAgZv+5lW2W7E7efOicRD3h2AWclTh0AuRm4Xk/uw0OqIhlKZUpQe/9F7eBAhL56agS9zPppldeUGiZS3IOrYyj5Q7dGwjuX3NXWRYO+n9bZdFVlw+R9yBWkg1F+Dv7zNgiLJkKs85kEWHsYsXBtsm6DihJiK1BGS0NT27E76AhVFBA2zucbVtjmHgY6c0xEcGJDAi8TAFdw/ndTEsi7TN18nP0b2v8K1ZAy8261SgL+NvNUfgsFNYW1KyLKTz5Q5nyiHpzkfOLaDyyorXY2HOYyDqvdTd4Nlge/aEzf704cLKI0k/SexCm7vsI/UesvOsVD9ve3c0MAZ2Qy1V7nVL7OELmQmRMgX5nGG2cuN3zUOUwWLnbrc+6Q==
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(40470700004)(41300700001)(478600001)(36756003)(81166007)(82960400001)(82740400003)(44832011)(16526019)(53546011)(2616005)(356005)(83380400001)(336012)(31686004)(956004)(186003)(47076005)(110136005)(86362001)(26005)(31696002)(40460700003)(40480700001)(316002)(70586007)(4744005)(70206006)(6706004)(5660300002)(8676002)(36860700001)(2906002)(8936002)(82310400005)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 05:53:50.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca2bf82-a554-45e0-9d3a-08da79cb889b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4743

On 06.08.22 14:11, Yuri Zaporozhets wrote:
> Dear Xenomai/Dovetail developers,
> 
> I encountered the crash in xnclock_set_wallclock() (null pointer
> dereference) in a custom build of the
> Xenomai/Dovetail Linux kernel (version 5.15.32 or .51). The problem is
> that in our custom kernel the clock
> is set quite early (using do_settimeofday64()), and this implicitly
> causes calling of xnclock_set_wallclock(), but
> the whole xenomai_init / cobalt_init stuff hasn't been called at this
> point of time yet. The variable nkvdso is
> unconditionally referenced in xnclock_set_wallclock(), and, since it
> is NULL, the kernel crash happens.
> 
> Would it be possible to add the sanity check of nkvdso, and do not
> reference it if it is NULL?
> 

Sure, patch welcome.

> Thank you in advance!
> 
> P.S. We call do_setttimeofday64() in x86_init.timers.timer_init.
> 
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
