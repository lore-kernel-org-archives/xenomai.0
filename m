Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47777C
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 15:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD/r/TYbhOeU9yqjTB6KC9+quM/6FM4g7fANOPs0wCBPwqgoCUquobkNeJ6Vv65XaXIhKirI1vDaUm2TCA1ab2Q3F+TPKTZdSLNFYhzD0GvUa/WJH3sJ+WjxbKJAKo3ZMdL6oOZITqa+qFiMuTMA3BuAnbg6Llm4WcAh53OidCdIcnX4MSuhNXxcMarkVJHPbbHg1asnczZWMKhqvSGSsppmvBTPgci52LrkwqAKCAtZQaFrT2989Y65rAnsFyHsNUMUx6z48+Oj7ys5r0/Dj3zaBl1rrCA/9LkqH7CdIGEsARVg7pp7YGOq8s+MHqDxeQoGA3ZIjVwG0NY1NN3GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58L+7rUkJTKNVcqbIH9KKpjE3TQwLCuC0QpQ7Zhizg0=;
 b=dcjDXiuUBZEoOR3YhQjqBQQcV63PR26ulJLoYFBEFWmi8p68SNfg47LgIcI7aPonr9ogsHKW7dqFDgeMdQU/4dfWD0AMopmcg6gthdvtj6UOI54kJ5JD9K739GKaWVxt4AWHHOUBThH9iLYXuwbMYbV3ndmzsALHB5yuGRwXSlkmX3ueGacEK5u17Vlwf3HjqsPh4rTBIDR9O+TLK/2eadicherm1qnfzrMM9eJjKmdVfrp1ZjhRGUDtWq1/cFfn0TTRJl9zv9NLy/0AsXoRx4L0NdL8D8A/xnZ10rtevDJ1r5skTqGtcldgecgRiUhTBlt++epmGYCNqoahkxf9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=sigmatek.at smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58L+7rUkJTKNVcqbIH9KKpjE3TQwLCuC0QpQ7Zhizg0=;
 b=xjSeaRlIM0+BLJeSjac3X0DWYQ5R1mk+64DLz4njIdZBsZG30eGzwuLC3k3esKOe46sJFB21TH66zHbMqXlVpzUBSLE0qWc2F+5+rqGPglX0X2f6MYwqpMdO+hK4dnneQ1aLeuazfS8Z+tfeTUtUp2xALodNGvk0cgm++MzqaM8gCaogwy1FdHUyiJBQy+n697jkN0flNg0puTLMRmRbS+TLo5ZQmr4cqnzSYJIXr6u1H3CO19N7+NMSqDtJTyRUlqgxsCMHMsIp7PIL8GS9p/9PplPvOdKd0aeMUM67GYGTq0h0XEitlA2CpPA+hqcvo+NNyZrAUb02PUUGLJDsuw==
Received: from OS6P279CA0009.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::19)
 by AS4PR10MB6037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 15:23:35 +0000
Received: from HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:30:cafe::7b) by OS6P279CA0009.outlook.office365.com
 (2603:10a6:e10:30::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 15:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT034.mail.protection.outlook.com (10.152.0.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 15:23:34 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 7 Jul 2022 17:23:34 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 7 Jul 2022
 17:23:34 +0200
Message-ID: <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
Date: Thu, 7 Jul 2022 17:23:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
	<xenomai@lists.linux.dev>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.887100-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/Q5QaOxwNGfvo9bHfxDWoibc1jRN8fxrOjrOLyP6vXu3WKV
	9V1SBtbOfneYraecVZtxvX+9Xe0NBAy1BDTX6W9D4c9hRRd5/qSZijY4EptTxAPZZctd3P4B2Ll
	btF/6zpCOVdQAiMmbZ+3ysWjNsapAJKiSvP/3EHjDEfqd4vu6/s4ScF7AsLMHqhcdnP91eXHsJT
	hmaEFVdJQBR+Vr4iFospdaYS9obcQLG8CBpMcXL5GTpe1iiCJq71zr0FZRMbBWdFebWIc3VsRB0
	bsfrpPIfiAqrjYtFiS7xRQQ36K3v1aZVjYwiDVpjhxhAqBorLvssulw84HnvH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.887100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 C73F0E516F7324FEA4615803D0F03FE6E9AA4BA0205C1D3AF5023E5D1B3FD7912000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c12b249-2721-4d16-fb94-08da602ca89c
X-MS-TrafficTypeDiagnostic: AS4PR10MB6037:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MBCCEl8zLk8/thhtCZ0zNKfTp0m2PR/1jfFgIHWBxwTjFZEpIVbBWKtVlY/gLZLqImNw0LToUVQ7LOQNnSORRH9TVvbKvLrmAVCBVRl137vueWu2aNYhOgAuVMVtAhMh69C/BZuZ7RrMkCj5biXZhGiHx2dtSTKWhRKe7y04menT5FO9+CEBQ1YbSpApyTpJpSruP5vEkGuDDJvJK0NPYJXZcTng+VZs0so65CWlpjnRfHfIQq67bEMQ8UMBy4y8X4kOqTTZlOCy32t5Zfsr4oFiSfK5sbw0jxVK1xEoPbhJHLzXf/8nay5oMLhswICbKdgRzUPbS9qtkdSMV92FH0LQib6JqPfxaDtOnygwh3xz6q/VvjiCta6w6/sqYK28xdspyWdQ8lLsvchoSYEaxptsQy7BLJxKcd0OcvV7I9z2+fTAaAJGdbTRtYNJOMiEJVdZDgppaWbwP9b4VuMHicTB6AUKvYDPgw1fhTzGI+1DwTYibXtVTF7IRk6X7p2enlIZLQvJ2OSEV9ac6PunaR1mApMUc6tRdCFAnIuj1CAgPrMlT1VLVcwFZoY03KJDnRgqc/qYr7gqMKnlrgJp9TQA/cwboUNoVuCwZQupUc57s35TJuOIL4gIjvC4i6jSabPQ3Y+W94e1wNJ9A1wBnVhugY+6QRod052kL8EOxjo56y0P+nojOc7W/3Z/6gqFZcKzFvIMIkW/XKMZTsnKF8D/m4A/zBj9xtfyK9mcLOAHxYIEXLJhw0cLURe0d/9QBZ+FtiHcGhKzVFOzO5uVslNTsd3t8sEOSN6Qsno3ORwYWoFu2OwCYEStSrN1h3Z/4tZ4fjd1T5t+2/gQI2Rwgr0oMhP060wPQQsAlFzKg85ILFmr+BUXQjtGdcluEgyIcHvSFKI1/yLttn70PAr23bxJ5MMTTyMzPUVrQp3sh7w=
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(36756003)(40480700001)(44832011)(8936002)(478600001)(16576012)(956004)(82310400005)(2616005)(53546011)(336012)(356005)(316002)(86362001)(41300700001)(31686004)(110136005)(47076005)(2906002)(6706004)(31696002)(186003)(8676002)(26005)(70206006)(36860700001)(16526019)(81166007)(70586007)(82740400003)(82960400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:23:34.9255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12b249-2721-4d16-fb94-08da602ca89c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6037

On 07.07.22 15:59, Johannes Kirchmair wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> Adds code for implementing signals that are handled in the real time
> domain. This is done for 32bit process under an 64bit kernel.
> It works in a similar way to signals in the Linux kernel.
> 
> Edited-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>

...

> +static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
> +				 void __user *fpstate, struct pt_regs *regs,
> +				 unsigned int mask)
> +{
> +	int err = 0;
> +
> +	put_user_try
> +	{
> +		put_user_ex(get_user_seg(gs), (unsigned int __user *)&sc->gs);
> +		put_user_ex(get_user_seg(fs), (unsigned int __user *)&sc->fs);
> +		put_user_ex(get_user_seg(ds), (unsigned int __user *)&sc->ds);
> +		put_user_ex(get_user_seg(es), (unsigned int __user *)&sc->es);
> +
> +		put_user_ex(regs->di, &sc->di);
> +		put_user_ex(regs->si, &sc->si);
> +		put_user_ex(regs->bp, &sc->bp);
> +		put_user_ex(regs->sp, &sc->sp);
> +		put_user_ex(regs->bx, &sc->bx);
> +		put_user_ex(regs->dx, &sc->dx);
> +		put_user_ex(regs->cx, &sc->cx);
> +		put_user_ex(regs->ax, &sc->ax);
> +		put_user_ex(current->thread.trap_nr, &sc->trapno);
> +		put_user_ex(current->thread.error_code, &sc->err);
> +		put_user_ex(regs->ip, &sc->ip);
> +		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
> +		put_user_ex(regs->flags, &sc->flags);
> +		put_user_ex(regs->sp, &sc->sp_at_signal);
> +		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
> +
> +		put_user_ex(ptr_to_compat(fpstate), &sc->fpstate);
> +
> +		/* non-iBCS2 extensions.. */
> +		put_user_ex(mask, &sc->oldmask);
> +		put_user_ex(current->thread.cr2, &sc->cr2);
> +	}
> +	put_user_catch(err);

Am I missing something - or did you miss to add the magic for this
get/put_user_try/catch?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
