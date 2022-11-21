Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B058A4F
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 09:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrxRNJPEYaMSo4MJQhyH6ZVAWPFE2i30E/tuvq3M0XDz+kIBwQKISuG3XS7oF+pzCfWj10VsNWJVto8Yn2bAl4wWnj+gcAKX2fnH/YGi/PILRWdiNX0DfURllCzepNSADGeCwhzpe1F41MPPRQLpblhgpvtk7YNBkQKz86skPO/yTLK9l/LtiaVQbJcFgucpTu2oBE7SzTXxSLSoJ+ZKw7iW5s3lX3dgZoY9isLcRJj251I8hnqTlJ6yTyyRQb/EeKlVAPJab8X0w0Wp1uEzfwPg66UbFd3rD/D6MJACn2pA/fVTsx9Ic1bam2fiDGmbecj9FUjdIO8BQqNcsw+5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfRImAf3TDCl5NOPWGmGxBYydXVd7ZPG4wn3plIfTTo=;
 b=oWQ54OZCIbyX5uLWs5fh8vv6o1yxvlRVSpZUKg8AArneIz87sbgFUWrN68ffDLwaxiHrIfPK2iSxsYi1HZK1bTJRHXSZd/g1ywDm/uFF46NQQlgLLHuqFTcQuOo2jSV3zQ4RQvZcbU1cfe5Mevab7JModIAleiLHjzSUQox0Vdv9Tgz3X5dVLDf6hale5P6GlqezJGvtnbAYniWgavT6iLpMy2/NOFnIYxp/J9EOYaXrPLBmXxZBCcqqTslXqdn+HtEHpTJ89+ANZOKTMaabs7EtEMwgnZ2CpFIIv20lPJWE36c52ZkU9EHy/yiJAEgOizmCKvWX7gOvor187g9Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfRImAf3TDCl5NOPWGmGxBYydXVd7ZPG4wn3plIfTTo=;
 b=hZAB5Dcm1qVxGxJQ2aDtR77m4QNodjdqP2GPtndzb2DBESpDwtuj9JGb+ohoxiYYum7eoOTEvp4E1skIRbdzdHSEZGlMj6cOglv8ax+Wa/yfXsBUwt8GhLDQBKFrcKku6x4HkR4DN/Hj/fo0DecF4o7BgzCXFvIdQv6XicInaBSp19qKA2UiLTfjGkqhPn1ui1Qu/F1GD6q4+u6IO2b1GwKClFHR8/8yEv5cN+oM3VNHXnWda/brKPUAd8kaaEHh6s2IDgQdzow5VEidphlPtWRswyM3ZV1xNMQAQuPvQqnRv6XenTf2ROnxR9/je6r4p+gEboYTQOilgowuvaTm8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 09:16:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 09:16:54 +0000
Message-ID: <ea34c26a-e3e5-609e-5af5-2ad3a45e9d96@siemens.com>
Date: Mon, 21 Nov 2022 10:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20221118154220.869584-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221118154220.869584-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 36738820-ade9-4a54-9971-08dacba121f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hDkawpRZM6Fzylr/oR+LSc/AxkksyiLW4ULOwpgFO4q891CcMTbWsUTLOiVNsDOGtoQIFwC4kBl++/qHrPvihrpip65RfWi6TyIqmXPTabHZ9MXaok33ZEF/cuTnNfKfvWWJ1PdbVviTbLZmCHfedTuf9hmqbEElhdrkBIMFVybP01nkeN1A7de157xmJfLVNL5XzRpCejMm/M3+lqf25RYJ2FNbB9swFUa8Q/vExskmBhlLFHDiwYTsDG/zXRl8azi/GTbxPjUxNQHDcnVww2K4uC89QGbz34XtAj7HcEvXRADQ8RYT8rL5bJV7zEs7U27eCisxaFgfl/pb1xsmdAHsSXGwz7TkN6uXYkLItpd/LEg60V0doL97xa1YLAzD1H+h7H7//GLk5uB+4ibtHOjTTYez/vz/AD4fqf0QskkKaCdxMIaUB7xyqiWcZCxe+Bc5iYl0bQGq+ilbnaxy8+Va+8Or1xGpzoo0LRnrX1dpjG7/lPFps80zmPuQxz9pa8qifbH85x+LK85y6NdDyLFvecR8XD22TNQZbTB90YqBdo64KD5UUA5rqNJFWgZxA2zMnUx+LGj+Tszu1FBZLt2Seys+OACgxIJS/CgnlAk+PM4hOgpY8pvwp+XQPo5XiSAiWHkcF2X7A0F8XHwirjD4J72oVEd1mSoBof9Fvl1VZR/Rk9XGFgT1JPeSUKbN5bAfbj05lpTYtBibWY582nPX8Xeu5uptEaTVfASb7hw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(8936002)(5660300002)(8676002)(66476007)(44832011)(66556008)(66946007)(41300700001)(31686004)(31696002)(86362001)(26005)(82960400001)(2616005)(2906002)(186003)(6486002)(83380400001)(38100700002)(316002)(36756003)(6512007)(6506007)(478600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFMxbGlvS0p0T2NKWmlBbTJicnl4Qi83a3QrN1lQNE42ZjA1N2ViZVFiRm9L?=
 =?utf-8?B?V0toU2VzZHR4K3JuaHA3dzRvenovSGM1ZVZOdjV4cjNFOGtibElONXZGMGdj?=
 =?utf-8?B?K2xpU3VsUjcyOFRnQ3dJa1VTTjlXWmR6U2tJNWRlNFNpUFYvUHFhbkJlRFEy?=
 =?utf-8?B?UmtXM3BVaEdsR1ZZNjBSOGNUeFFnUXFsdHMxMllTeW5IVzA5MXRGYkoyNkVW?=
 =?utf-8?B?V1Y3M2JwNk53ZFVrNVZ1eDh2S0RSWHA5cml1NVZUUFlaR0dYZGpIeUJWSk9h?=
 =?utf-8?B?eHBWRytpcWFDdEVuVEh5cUdNVnIwQ3l2OHcwYU81NHFPYzF5dms2ODV5Yk1m?=
 =?utf-8?B?eVJuNVVkT3ZsNWRLd0RPY2tLYnRsU2Z2U3pxZEp2ZEVXbVZnWTU4QjR1UnVy?=
 =?utf-8?B?N2tEZkJrYUQ0Y1o2bUNoeitZVmlrczZWbTFGbWNqWTE1cWhYVC9Dak94VldZ?=
 =?utf-8?B?eTZFZXlsMmR2em5uL0kvc0hSSWg5TUc0TmhkNmUyOUpzR0JCMFlOaWZwNUp3?=
 =?utf-8?B?WjFLNFRHZkxrc282Y3Q2OGZUNU8zNGRVWU1ISzlkdy9Od0M4U2Z2NjVLUEk0?=
 =?utf-8?B?RzdiajVTSUVtdmFTVjFPVDA3ODdKRGlvWE5INFZNMW1GZFBlbExkZlg4RHJ2?=
 =?utf-8?B?K1ZLay8wU0RxLzNaRGg1b2w2Vnk5am1vd0dVMWdualkvUkpvakZ5WnFHTjU2?=
 =?utf-8?B?d255cHdES2J0Q2prbDI4d3lELzV2c2RidHF1R1VPbDdKL3VGK280cnlIUVE3?=
 =?utf-8?B?UEE3RFN3cklGVUkyYzdzUzBuOTdsSXVXTS82aFVvM2V2em5NSWw1ZGQxRXRy?=
 =?utf-8?B?SmtzSC9ZTG5XZytaWHFmU21EN1RlRmlLY3YvM20xVEUrQkorbTB1ZVpqVWdm?=
 =?utf-8?B?aWRGQWw5TkQ4NEgrTkhPN21ES1VYYTdFTTJyS0pOb3lzSkp5clI4QVNNUDRJ?=
 =?utf-8?B?SmtPdU9UN3EzQ1NUMjdtdnA0Znh2UFNBbitrSkYrNTZkSHZDVGZQenN3cFdU?=
 =?utf-8?B?UWtQbWF3eHMwNEp2RzRTUFdRcVFLS1VJVXFjKzhELzV1UzlCcm4vQjhUemNH?=
 =?utf-8?B?T3lscUIvbmFUYURmaDFxekJYY0dTeHE4TEU3RThzVkF3S2dKQThaRVZ2NmtN?=
 =?utf-8?B?Tm5MdWM4QzNkM0V3SG10WU9yVXU3SDg0YzhYMzYxbnl4cTQyV1VadnVLWU9y?=
 =?utf-8?B?bk9Pd21yOXhWWHk2STh6MlFKZG1ReEl5RUg4QjBRLzNVam1INGQxWWtpaDRM?=
 =?utf-8?B?MXJOVlFCNEVwWk96OXhQenFJejlIS2hpUXUwT2pubTJtaHh5STV1Y0psQzFv?=
 =?utf-8?B?My9ZU1BMMk9kZjZSZ1prY3UxQjhYUVFQQmdpK2R3UWc4QUVJcU5pWHdsanpG?=
 =?utf-8?B?Q3V0SHYzOUsvWVlpM2NkY2JyMWZSM2dHTHozRW8wdE5hdXFGNC9BaytrVG5m?=
 =?utf-8?B?aDlwbHJOV1gwMnAvSm12ZDZKUFUzL2ZST2RGZk1nMVZIR0s5aW02MTJ4U2gy?=
 =?utf-8?B?cmpUMnhmbTE2dDZyMDlWaFQwQjBYckx1UzdvSkdFZUtKbi9uOTF1d3JESXFZ?=
 =?utf-8?B?eXhXaENYeFA0MXliaUxieS9Gcmh2dm1xRS9TMlU0OFo2cWdlQ1NYQjJuelQ2?=
 =?utf-8?B?SDBNemhicTFXYnZJRDRydkg3WHFYcjl1RW1Yb0hIK0ZicU5OYk1uMmxtUVVS?=
 =?utf-8?B?USsrYjk2QzAxbVVVcDRCZExsQkV3R1pCUnVUemFISTVOVzJVcjZabTllRklQ?=
 =?utf-8?B?dWQyQVVKVlpsK3d0UldnS25rcnRzdWU1R0swRzl1VmN6cVR6SVh5bmRsNWhV?=
 =?utf-8?B?VXhYUDJJK0VYTVFuRkF5TmpMUWt3RlMzWFo4eEtMV1dtYjFjbGZ5d1craFJh?=
 =?utf-8?B?Umswc21iSUxUd2czODlkUDQybDRWdk5wUzE4ekRZZEwrNjJOMi84OHYwR2FD?=
 =?utf-8?B?SithWE5ORTQvR21ZYzZLRzdGREcwdUFyeUNGSFpSL0hLbzU4aDgzajN3VXVM?=
 =?utf-8?B?bmpabW1xamxMbUxnZm9TMmYveVRIbGxHbGEyUEg1Z3RiUU0rdnZTZ2s4NDhR?=
 =?utf-8?B?QnpqSVlIL0VKVHhOTmtrL3VrbllkU296anFabVJaVC9YWGx5dHBQTWZiTERM?=
 =?utf-8?B?YVFMOWF5RTlDeU9VYUlQcVVQQTRmS0ttSWFxemJqMGxIZXJ5cHhIME41WG1D?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36738820-ade9-4a54-9971-08dacba121f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 09:16:54.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z89bs2dEJ5BgiYso7aQuv4Zq+AL0iywRY9F9+Y4J/9Jj6foqZEpd5X5RxcdWAPkKf64syHqxh4L9Y4o6Q+4hNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7369

On 18.11.22 16:42, Florian Bezdeka wrote:
> With recent glibc (at least 2.34), autoconf fails to detect
> pthread_mutexattr_setrobust_np. But that is long deprecated anyway. So
> switch to pthread_mutexattr_setrobust and only fall back to _np when
> needed.
> 
> This is a backport of the following commits from stable 3.2:
> 
> 746cbeb6ccc0 ("lib: Switch to pthread_mutexattr_setrobust")
> 3f85c174e297 ("lib: Fix fallback signature of pthread_mutexattr_setrobust")
> 2d947e6fe3f8 ("lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub")
> 
> Backporting allows the stable 3.0 branch to be build with the latest
> Debian toolchain, so we don't need a special CI setup for the 3.0
> branch.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Hi all,
> 
> would it be acceptable to apply this patch to the 3.0.x stable branch? 
> It would allow us to build this branch with the same infrastructure once 
> we like to update to the next Debian version (12).
> 
> Especially the y2038 tests require a recent glibc version the next 
> Debian stable release (bookworm, Debian 12) will ship such a version.
> 
> One alternative would be to use different build environments for
> different Xenomai stable branches. I fear that's hard to maintain -
> especially the CI configuration will likely explode.
> 
> WDYT?
> 
> This patch has been tested with both build environments, so Debian 11
> (as is now) and the upcoming Debian 12.
> 

I don't mind backporting with this use case in mind, but why can't we
cherry-pick and possibly massage the original commits?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

