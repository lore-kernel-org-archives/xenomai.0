Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20075.outbound.protection.outlook.com [40.107.2.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564402F32
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 14:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDZ7Bl1XOrxXY/UrvHgRIQBBoWrMMHotzUZx1msWPR+SLzGsW8ezYbUcUg4bVJV78sxPHopsFTmtFYVRKB38ws5zyt0jnb2ADQKUdKUMvwhBcF7aQk0oKbDdZtz63REnucxAMYrdbhhoZkpVbNlp5HL0aBS9y6J0GIaTW+Zlhs6o3RMy9tK//XgMcNTTVH/UU5J6H+gxPHJL7GJ8qq0mLoVhuV8QRb5I3bnIh85k7DCafgoZfO54oJrGYEezQC1JA52l+QWaMijzRImspeJF2i5vr1duueCINa5jpgYas83E4fTSW/o/+uQH9STnzd/o+R0qoWXCPfVukZrozDfRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8cOlQ/veG7DWG3Bl4Ta/2sU7R0hrfYjtpjQHw7dMA8=;
 b=RpXJUGs9jE6IkhBfsfGjFgwaFEjTEfyeED1B66hndzWgWie+2GTUMvOo/jxCAayWHRtG9m+9VLeXNCoBIB3ybQ9i4GX3C6fjfw5NrXedTbSiksyk5icczeOw8nuZfeKRLbPddT71VUBsWmp5sJhjZ8Jgo13KRGtxCexzBEAPzkkXo8wvPsovEYupT7i7TGjpNseVSrkKnsCHHrxrNoeN6efcmFo4Nk/OG931WTNyqxHkIwBRppvTlHE7YO9K6dM3TFhqFN+Ldc0pkqoH03X5e5tKIqoKx9FgITkkmW+R0+1xp3ZmbU378/yFB11zfL4yzvT2RzuPYsq4mXdk6inivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=126.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8cOlQ/veG7DWG3Bl4Ta/2sU7R0hrfYjtpjQHw7dMA8=;
 b=qmkwsaIJ5EOC/lcVz8MluZr8yki4NJK0eNsrA9nbYH2wyqvfYHtrQX+zPFKXk3V54WfhdzXFXjwFL5W/RJ5mKyRvk9ot/Mb2BzCMy5MO6QMkicGYEz7EUaUhUDxFdeq28ziMl63G9AlicpQb8p8atBMDlJ198Cjs9dbv3vV7UlbWxClgG8QKUNulZ4hKwy5tvdERD5O0p3VCEPHBSO5FsQtR0V+C0lpKUAvzSFtB02xRRL0d2sUkWJT4vmDik/uI0gGPTnTMOFeWXYrm2pclhZJx6Nz7aTSuHGijyN55TDJP41IHyZKEGFc4V//QFERvCgQMJZ5xNC0DmHfcSHkrUw==
Received: from DB6P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::28) by
 PA4PR10MB5635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 14:13:53 +0000
Received: from DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::56) by DB6P193CA0018.outlook.office365.com
 (2603:10a6:6:29::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 14:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT028.mail.protection.outlook.com (10.152.4.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 14:13:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 10 Oct 2022 16:13:52 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 10 Oct
 2022 16:13:52 +0200
Message-ID: <ae43e7c9-e35f-6f9a-ca2e-baceec231a50@siemens.com>
Date: Mon, 10 Oct 2022 16:13:51 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <76f26fbc.727a.183c23b0834.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.130300-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/Q5QaOxwNGfvvy6J2sQ40CSPg9yfk4YC0aJUlmL3Uj0mAv/
	9UzFeXITFxWwVm4vHRT1WUYGMIOdyMG34NV1LokEY1gqwRMUc44kinkyECdW86btlVLKF4zpa2M
	h+MYVtv82/UwdvFG5Inz0ry6FT4UcimyY0YAT/KlYQP62QpRT7H5uUfhNvnKz5wXI1oONVuAujM
	j6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfl+24nCsUSFNt5CrqYXZLj+x5amWK2anSPoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.130300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: F299122A6C87BDAD094543110B23702961CE113E240827CB329F701C557305242000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT028:EE_|PA4PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: db4930f5-795a-461b-ead3-08daaac9a934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fAasdlAyijeElw8PwxlMI7o0Wm+lKs3BYTU+gcQ9c3pxhODPlLXdZ9zE2Inax2aUm/TGB2oO22G8WPqIouS4ZrZzih93u03iR8K4PMpeuDVHTeAJS92yaXsKBSaPhHp4yZOB9yIv4kuhRsRY+MW/IfqlKz9l7wg3yNpkXoWpnNMGsWZUeoGqpBc2GtFm3DDk+IwSYQse1Jm4d3gPKgk7c8gtmBvKq79twOQAf9zIXxN6mI48zImPM07Y6Zd7rCbMLsUTNYe6m1MokeVeT/j7rksJUocrhjPdGStbXI+eOUHwzn6cpoDWi/xAthWP+ihTI1MafN1VMYO9A6SNvdgtV8TYiczADg/o0v9Kemj3DwOCEAHvr088C/pFesGLXv8BVMREiz8CvmRg7E4QyctALQM8WnQ9UOgq7nHxK3qRCbF3ZNv6klCaD3cToYhOf0koWWDKDxweQR1E+gUxAfxJTTsdE69vWrGoD5jNIpvMjsDiSlszV30/zcA1AZ3Yepnuy5iNb4De8aYno6DD7AMIAGbcNAIIU6aLe2m4SzdObEW2MmW81u/knK2xZGijtGxZ12aWxoyPY5XSSPNL0BGJ6cUs1ps74irXIfw8ju+h4MfXLlW/O9pOrGqf53wOU0wYA50Ol+hgH3R0UllVSF1urP7eznsb7CJO516w1sSLku8liBlE40SOzlMVrBkZIGAjNaG3Hgmp+ohzMcxE4KHju6aQlJ4JRSuZvJCWeLdpPyfYiTejf9hrFQ1Jav0q5rjGlQrxdVfUUNH6+dwjzC5ZG7hHvjEsrji26IwhFMXiFDxVn3z2aDiuzLvGGPI96DeSGY7WMY9HBJa4aQICC5YW3JBq9FL4caVCJ71rSRPL1bA=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(6916009)(6706004)(31696002)(82310400005)(7116003)(2616005)(478600001)(82960400001)(8676002)(316002)(53546011)(40480700001)(3480700007)(16576012)(86362001)(82740400003)(356005)(336012)(4326008)(36756003)(40460700003)(83380400001)(81166007)(70586007)(47076005)(36860700001)(16526019)(956004)(186003)(70206006)(31686004)(26005)(41300700001)(5660300002)(2906002)(8936002)(44832011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:13:52.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4930f5-795a-461b-ead3-08daaac9a934
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5635

On 10.10.22 16:09, Yxian.Yao wrote:
> 
> Hi Jan,
> 
> 
> This is the only kernel version. Besides, these problems are hard to reproduce.
> Whether some configurations related to perf are enabled in the kernel？

No, I meant of you are calling "perf" in order to profile some
applications. The pure activation of the related kernel features is not
considered problematic, but some "perf" feature are if actively used.

> The following are the configuration items for perf:
> 
> 
> CONFIG_CGROUP_PERF=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> CONFIG_HAVE_PERF_EVENTS=y
> # Kernel Performance Events And Counters
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # Performance monitoring
> CONFIG_PERF_EVENTS_INTEL_UNCORE=m
> CONFIG_PERF_EVENTS_INTEL_RAPL=m
> CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_CLS_U32_PERF=y
> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> # Performance monitor support
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> # CONFIG_RCU_PERF_TEST is not set

If you do not need those features, you may also try disabling them, if
that changes the picture. Also compare your config in this regard to the
config we test in xenomai-images (just a reference, not as the only
possibly valid config, by far).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

