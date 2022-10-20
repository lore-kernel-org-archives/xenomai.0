Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4A17C4
	for <xenomai@lists.linux.dev>; Thu, 20 Oct 2022 06:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnR6aG9Sgal5+pGJhwjiyVYJgkqG5q8xUaX7FOJJ6QG+CflZ9mOt3x8yGlFb8fvM4nBoln6Tlw+/Sz0IiXB5MFvioBV9WcS5q/vchsjoddJw8ueiF7JKezD5RqBoJgkUkUDKcw7LmA4ue0Dd7OZX1u/7g3cathfS6Zpyy9vdZDiEiIrtWkgH2jcnwQN4CHnbkmeXXLYbRnuqT+YXnZFc4kZaSL3xoyAMaAZqN8GUfyHdiKz6rS6XALrqcgUlCr2q+YHTveUc/yrUNw0zRAHnl/2VTLMeXwvly2QCsG2Vbl+qk/bg6IxH4eg0nMei09L49/9EK2d6wZM7T5uLOypZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tnzcm78AoZovSjxD6H6E9HZ7EQU/ggz3xBWx3bVHgg=;
 b=Oi05TCpJy48p5JqC7Nloo4Jj4DZTx2H3a9fxkhSMBME6OxdD8/xEVrG4+3+0BCuPqPl+HUez1J+U86NNRxVj1Qn9otBMB3ns7AWKEuwz8CByiOxkcF5/En6ElTAaQWuECQPwrA769uGUqoWQ8tSsOj6Lld3QBAurT8xnFoOgBpy4svnsq4gKUMrg9rfbFpABvJcAkOzlMbGrVfNCeuSuaMAm+Xpi+uJ44sBodb105AAhM7XcJGU2lVOqGSzLfbUft/qEb1kVfeArZscbbvCcHecr39uppqoJ4j22BnQyK4i20ITpro7ltxFYfG2/QwDRtimPIkEPz5n+6Nk9Uz3mRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tnzcm78AoZovSjxD6H6E9HZ7EQU/ggz3xBWx3bVHgg=;
 b=by7nHJjLeBOo8+Lkfq3XDQeXKRxbNLuikLbpy6hEOZJcJTElE4Iq7jeKGrjKKPyEZN7vPHbgS23UXUtPTKt+7n+u+7TDSb8eazR736HmFB7ARobZO6fUJthpcEwyXnAtLvGI8GNnlWgeGyiX7uho2Fx69Im8BLDfI9rwsN307WgBs8Em/egjoDYAWrb1K05SrdO/7Jmc/JypQzkmd9fuOQaPRRsmaN4MtmDgi4vW+Mb0s+k5GGxURv8UbdreyEzEqums+QtUPkcIC/gThREvd0Zj/vmr2/TGVeb5tzqAVIoh3dv/bUhVReeEq0DmDYbW+oOKxSVcYc8qY7XgpLytbg==
Received: from DB3PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:8::23) by
 GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 06:10:42 +0000
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::1f) by DB3PR08CA0010.outlook.office365.com
 (2603:10a6:8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 20 Oct 2022 06:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT013.mail.protection.outlook.com (10.152.4.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 06:10:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Thu, 20 Oct 2022 08:10:40 +0200
Received: from [139.22.107.40] (139.22.107.40) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 20 Oct 2022 08:10:40 +0200
Message-ID: <78d8bbfd-99e9-2832-1cc7-3fac3f7452d2@siemens.com>
Date: Thu, 20 Oct 2022 08:10:26 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Zhang, Qiang1"
	<qiang1.zhang@intel.com>, "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
References: <FR2P281MB2654CD4536C1F2D3592D874EFC249@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB5880489EA92CEF39E1EED88BDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
 <MN2PR11MB42855402C55DCF4E97183C4BF22A9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42855402C55DCF4E97183C4BF22A9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.107.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.376800-8.000000
X-TMASE-MatchedRID: UgbjIbm2QqZmvcelz2C5QLQc5DCOw3yNPg9yfk4YC0bM1jffIgQXhtGO
	cAfHKa6u1RGH3qe0s6Yzx4jD+JkFVjSal1tQWGGz9qBsnuQtanhpXn+0Usaqnh1kSRHxj+Z51X0
	C/DlEJwdM+b8yxBqvA6f4O0AyJYLdNpHxqDB4Ba1cJF3xZlAsjZPVGcoTX9e4/03t7eXCTBunZS
	/aYgjrzntTo0P1ssT+NrzAfV3mWQWw+UXxHp2zZFBD41meIySfaLoDnvMTTHDxWp8B+pjaLFuiH
	QC7x/FTi7p9NckzZOvUizka+GYZvCvn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdWQy9
	YC5qGvz6APa9i04WGCq2rl3dzGQ1qnV6LAWEz3MaYT5x4fF7XaAOEYC8q6U4G+F8GPByRjqUVl0
	VdMUJuw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.376800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: EFDDFD0D0E88E20298C609AFB68FFFC3B227C8A316C52C0AF1EF9A1369973D422000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT013:EE_|GV1PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b8fa2d-d98b-4129-6269-08dab261d123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	32fiCx8Su3vz4GU26r7WaJLnxeNsAS0uyAzFXqNGIxgp+KNGcR/rYwD9+W7z0+d2pP85WJadilHmxzw4AS8s0wUhA7haMQ4cK2ejF8rQvy5COJfunuSjZA12Xa8ETSRS0a7MtOc7+7vdsDVNNL6eWVitzMmw7mgdbTDD2sdlJky7Xqck0RR3S9TApAzWp3SGCxN+TOiGDqzl3DXisA+U+zwMLs3t4QwOcfwXsOgE+7eG1aclYOXva8kxs4dXHhrl+zjqyqpfhbPm/gIkKy2516sadC3I2ic7mPTXl9G2dJmcBhoo/yqS8Chnxt+384NPUX2s+UjhYwvsNceqaPAp+EDhssI7ZFd1H5hr83MOi5Z7vgb1UyiNQERglw0W4hpmFRE1N2Br/h5GqGqWtgE7f8A+DY5m6sCTS3QqH5e+25P7c5etyNuJsy4efU/ge6XS1XN8sLOfj3g4jort+eMyc3RBmVfRIPG5daUnB8U3jpcfzAI/4WLyWhTiKo3NUqwcgJqnYtaNfN16S7AKNwkQbNF/ceOGnALYye4kl+7t5w84Y43erc+2aJEIf42bDnD3/XMmRSzOcx/ZODJU5Qggg6zD0/NDwP3r99PW0SqCK3ToNvdm7vfnESTBcU9Mq4HbwQD/IW21/yYFQJC3EFSPGvSGNuptIBh/ue7rcsPSjyDE+9MIi4ab2Ohye4GBwx6NvCOFkclMKfg2U1rfNlmBNnnFwm7GD5vQKGSjrt1twNho2Ig0eNTGmWIe6wJzRoB2Jqw/Z/dhz+ArHcmkC3+v7ug3ls7GVcjsB/D3OnWbiTQRmhU/O5movmlo7okRHkhQNDhORkK9Yacff+hTbDbj8IV8TUu/8gH4pzURGbdeRBq6eO2L88DAcKmfEMfnNCn9LVbX5bEuwamPij2PeYa7fw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(53546011)(34020700004)(36860700001)(41300700001)(40480700001)(40460700003)(8676002)(4326008)(26005)(44832011)(86362001)(82310400005)(47076005)(70586007)(83380400001)(70206006)(2906002)(5660300002)(356005)(81166007)(8936002)(186003)(31686004)(478600001)(6666004)(316002)(16576012)(2616005)(36756003)(16526019)(336012)(110136005)(54906003)(6706004)(82960400001)(31696002)(956004)(82740400003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 06:10:41.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8fa2d-d98b-4129-6269-08dab261d123
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6563

On 20.10.22 02:41, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Zhang, Qiang1 <qiang1.zhang@intel.com>
>> Sent: Monday, October 17, 2022 4:44 PM
>> To: Heber, Stefan <Stefan.Heber@zwickroell.com>; Kiszka, Jan
>> <jan.kiszka@siemens.com>; rpm@xenomai.org
>> Cc: Wang, Rick Y <rick.y.wang@intel.com>; Chen, Hongzhan
>> <hongzhan.chen@intel.com>; xenomai@lists.linux.dev
>> Subject: RE: Memory corruptions upon strcpy and similar when being
>> interrupted by scheduler
>>
>> Hi Stefan
>>
>> I also use xenomai-v3.2 and linux-v5.10.y-dovetail to test it.
>> This problem does not trigger whether we use memcpy or strcpy
>> (not need to change txr19391test  code).
>>
>> It seems likely that the problem is related to i-pipe.
> 
> I found it write wrong own stack address into alloced memory when issue happen.
> For example after run txr19391test
> cat its /proc/pid/maps. Its stack address is from  7ffdad88e000 - 7ffdad8af000 like following.
> 
> 7ff784727000-7ff784728000 rw-p 00000000 00:00 0
> 7ffdad88e000-7ffdad8af000 rw-p 00000000 00:00 0                          [stack]
> 7ffdad96a000-7ffdad96d000 r--p 00000000 00:00 0                          [vvar]
> 7ffdad96d000-7ffdad96e000 r-xp 00000000 00:00 0                          [vdso]
> 
> After print 16 bytes of the corrupted data  in txr19391test, we can see 
> data like following:
> 
> 0x78 0xcb 0x8a 0xad 0xfd 0x7f 0x0 0x0
> 0xb0 0xcb 0x8a 0xad 0xfd 0x 7f 0x0 0x0
> 

Is the stack pointer of the related thread invalid in that case as well?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

