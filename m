Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAE12C809
	for <xenomai@lists.linux.dev>; Fri, 16 Feb 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094830; cv=fail; b=vEGRfE2gS7LyHRzcuBmp7qEZNa9575pqTZ9DnndvyuXPpLljvhWCoZICcTatiIl++O/XWKcc5izT22wfElGpSbvE+YNSKhKUq1yCsVlinIrjQ6a47cSQi/RGT9W/5RB7pkwECXt5bfTt4gx77z5vFGALyEy0P69mZQvMvYDryhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094830; c=relaxed/simple;
	bh=6xSdHCWTZ/4dyriGh7DujohGq3MIxYWAQOtns7+PlXs=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=ZR+0XemgMndZwE2kzz0tv5j/xWXEOD/9asKSNXhxUFLWkAgm6ZVolPDAEUewIi4NEmlcz7lftrneWZVUmICZV7qo3GXQpJU20indFve8IZh18e/S1vPFzfMhTK1Ph76AurR7vTnHcNDClFBKY6X+CCwSxIyK7wbDyMuAgNwYFIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nCbMfe/6; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nCbMfe/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqDfrzql4C35mfqdmn8XsE5Ngq3Oru0zeEvftwV9U1clwkKWDaA8p4+AMsF/Yw1NmCv6O/lc5YKMvwDDGSP4+YabAfPYqCSJwc5a6Q1k16qOgxof0t0EInJbK0kBq1DFli8Jh7pJlX7xTWoMg3B5CWBLK3bwcShLCWUX/AdXj16S7FAhW3Q8hlyjRSpbcnGQAoksEIjqIW9R0KXUUBRuEdtdezsevjsl5hF+Pz7eWvMJyVm1jyca5BAd4rIZSFCgctLGRoWCYj1eZzfnt1C1673HQPSOg2Bl1Qy0Ft5jNTZjvDS9h8zxD3kpdYuAG1UQVua30hqGwDIv+ZJawMo7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBUJMqd6cCLr6t4CPz7dWIM9NRO02dR4wEqgnDiwcsI=;
 b=CCn/N7opQ/Au+o0JME44b56OTHX9Q1lIkUBZp2WdBbZHK446+pnpNWsXNr6BepXpGjsh/mQ9e/vxDLMhwIbfHmVRaTsUMIdbVYl3rCkT7o+ju0rMifUkKVgrhUekQbopaz1a1MyWeu/pTcpQ9R//UhiJFFQZyuPM0FOs3SR8hm53JODfVfwoWLdpKHybWiEnQ4XHpDXrZo4q4edj2JF9ziwLURC1iu8CzgDIdZKivgTFtzhDnaZK8Xja5pcB9Sq4u5tXDgp3pdvQF/gXc5g4pUyRZ3QQtFZvHKkF4uMGoQmrCx8aBMDgKrjLmomn8caDwdfqsq/m7nT61LMoA54qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBUJMqd6cCLr6t4CPz7dWIM9NRO02dR4wEqgnDiwcsI=;
 b=nCbMfe/60cYP3TrxuxkDalkORRDocH3CEl9qAT34FJsXICtlpui6fs13gR9zUjcl55TpA/v73Rg+0qpWuvJWbcxfrYj3eyaWsKj5WJNgvNoa9SIBChjExrnqe3B8S/gx1v4FMhiVLTJP1/0eF5VDLnirEVHd3+6t+bg+s3i0rsgDqcCvIYEP6W4yjilRy5XkryZ7NHl2ieeOZ4zR3uq9rRBlOK3qsUzt3Mtr+gLZb+//Uw7A8WdFnvJ7wiD4kldveMEjFVGWkFzyDk44HZP3DG2mLkfJFmsTn6PUIJYZT2D7g/IFBLdwpNEyE1t5yvD21OMezfv2wFBE0XONaPw+ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 14:47:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 14:47:04 +0000
Message-ID: <9987f77a-ad10-4e85-bf54-41bcd3220531@siemens.com>
Date: Fri, 16 Feb 2024 15:47:02 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] demo-image: Add systemd-timesyncd
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b59087c-955b-4b40-02af-08dc2efe240f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t/dX/4t2h3Qwn+5d4HfgXpnoX8AF/X9JrH/TVO5X/Zd/kV6Oj3oOcE5ZaxmJ0NRkNG39bO/n0IxUiYSAdZAOffkNANIvpHvFUwzYvVU9CfV8Cv/x1CLfI+2T2qSqoKV8TTz5ZZyWUnEvmha10aMcSgvNP34xghq8e0OmUGmSd43gbBaeQ7BtPspAhwHQi8p6b/RHtS+xJx5ZiWmIPn1DiUaTAvHjnOYRCZBjb4c1iajE4XwbagZBtkkPL9DBwVarwN7iXefgVgGCEdQGXezBsEfByH/nLVU2+M24/pKopEH1mNJ3l0qNl1DwkpIh0TjATOpKOgRAY7kdujCIkUEo09MSpmcuYaOqV2Lr3Llk2HBMPtZVExvrK96ESrJaEq1jnc/Wq4YbDTCbFrevJXvUWwDFORnWS6vPxRQ3gfTs/XIMhZIkEyHeyxcjwUcOg1UzvDKStmWUmZjAgx/1UNKqRHs2IcJKTww1eWV0ucmTWKoZvjFbUBAztxaxAfyyvS0EZo/z1NAqLPcZRM6YBSRLKYFf+NrbtgCmgpxIFUFF/CtzjuVmcBru3BnUo8ZB/hJF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(316002)(478600001)(6512007)(6506007)(6486002)(5660300002)(26005)(4744005)(83380400001)(44832011)(8676002)(41300700001)(8936002)(6916009)(2616005)(66556008)(36756003)(38100700002)(31696002)(82960400001)(86362001)(31686004)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlkNUNnN1FjcXJjQjA3SXpQZy9VNGh1TEVERXlOZHNHekFnVXR6OEZveStP?=
 =?utf-8?B?M0RtL2dJSitoUnNNcVZEZDBNVkJmRm1UWHN2Ri9nZlVJUXM1UDIxQXdBc01R?=
 =?utf-8?B?dk9QU3p5Yk1sc2ZIL0wyeWZXdXhpb0ZNc0QwUjVWeUEyQWRKSUNhNGJ2N2FG?=
 =?utf-8?B?VlJjZHA1MzJqRWdIb3lhL0NTOGVOR2R1VEZiaEpKOUdhZEE4MWQ2Rk8wOU1X?=
 =?utf-8?B?S2VoQWVoYURsQlJnTDBGK0FWb3ViSFowM2RidlZCdk91cXlNaU5sdVNNU0tK?=
 =?utf-8?B?VzFPSjMwcE1KYUMwYnhka2hhVmJqeUlwVVZJOWpwZ3RyZkRnMFlxSDNUMlNx?=
 =?utf-8?B?TmE2RDFUNmp4alZtZVliQjNhUUhzbFNDWExJOHBUemt1Q01nWG5rMW5JOXZM?=
 =?utf-8?B?U1BCQ1l3M2sra1hVVlpMc25HQ3FpcS9UVSt1cjBQYXZrUVk1dkxYRTdhN29h?=
 =?utf-8?B?cGpuYjhzK3dQR0JqNXl1dVZlR1NYR3lST0RqV2tQZ2FzbGtKeDNHcDlJV09v?=
 =?utf-8?B?SjdSVU9lL3dESU1DYndkTXBoTWkxOGNVWHdLU1I0cXhXdUQvbk5pVmQ3NlM4?=
 =?utf-8?B?MDc4YjZBT2RrcHdtR3duRnpYL1lFc0wzZ09yckN5N25aaittT1dHWUVSRlNn?=
 =?utf-8?B?YUdZUXlCeHFDYUQ5OGNQN2w3Rk8xUUZXRnI3dGRIOTFRd2FHRi8yWjBXNE81?=
 =?utf-8?B?WmlmY2RYd3BJVFpERnpKMnd2WTRyMWJnS284ZVh4TkFseWt1R2liaEs4ZUFm?=
 =?utf-8?B?Sk9DSE1Ja2l2R3paZVRXQXlhUkh3YUlQV0lpR25jYi85dnFqMUkxNnp0NEgy?=
 =?utf-8?B?RXg1US8vVW1PYTJJOGtzaU1LNEFjbmM1L0themU5MmUrUGsrY2drZzltM202?=
 =?utf-8?B?YTB4eE9EdEgxRjEzYVJSdWM4QksyZlE0NGhYcFdlNkZ3OThSOWc5TmkwUHJL?=
 =?utf-8?B?ZVRTaVgvRW9qZ0VLb0sxQ2pGVnJ1QkcybTRucXZnOEZ6YjMzQWtIWkZOR3l4?=
 =?utf-8?B?WHcwTHBxTmppMzJjRnA0Y0l0dSt6eXJqZncyUFRyNzZwMTMvY0wvWDBpMXFx?=
 =?utf-8?B?OXFNMGJtUHdSL2JMek02SmhjdjN0MzJnNDA3YmJiUExXTlFLTzh5M2ZwcytG?=
 =?utf-8?B?bFRMM1p1aE1lbVhKL3dsU0h5byt1N2pNWHlvRStXSXRFNW1jckdZNkVIOVBB?=
 =?utf-8?B?bnVnMTBWdnFUSWpGOVJvQWRPVDBUZGh6NEFFbnEzNVpBU21wN0Vtam5qRDBO?=
 =?utf-8?B?SThWanpIQXo0Z1BMZUZCWlZ1Rkp4TFQzc2pjemwzcUpFM3pWeTBSdE1NVTZ0?=
 =?utf-8?B?WFNFVjZDZk16bFNMSE4ybTErclNKOG5LdHZXQ3EveEIvTy94WU9JaHAxZ0VR?=
 =?utf-8?B?OXcra3pScGFXZzJyay8xMVV0K2NyVzRRcmxkTDBTV3lMUVUvNFRYb2F1RExh?=
 =?utf-8?B?Z3BmU3gxS0xjSjBPaWtENEE2VzRVOC9vV1I3U1dCZHpQZlNGalI1czRnQVVL?=
 =?utf-8?B?M1R6WGo3MlA0aHZrVFJDNmUzNThtVlBONzBueGEwcG53RGVYMjg0eDVneVhq?=
 =?utf-8?B?VWRMVVZMdEFxVU0zVVd1ZkdQVExZcUh1QnZJOEVkRnVyRElYV1cxT1oxQTF6?=
 =?utf-8?B?VEZLVit3Z3dPS1gvWEg1M0s5dUNFbXlhU21WRWtYTmdVSnJzUEViVnNwdldE?=
 =?utf-8?B?Zkx0TTFJVlloNDEwQ0RWUnFYUDRuRXRnOWhaV04zcUdMTTQ1ZHNkck9HQStW?=
 =?utf-8?B?UWVXT0NvQlZxMmpoOGJvNEVXVm1HRndBam1yZlRnVHNsVUN3am0xN1lUUmx4?=
 =?utf-8?B?cFpuNXdTK0xZNmMzQUx0czlOdkVjbVdSUlRXQzg3SUcyZ3I4MGMxTGdzbmgw?=
 =?utf-8?B?UUMzR0FKSFZndmFpZE1uUnhPM1hReHpkRWNLVDlhTk5XREZJUjRrWEI2bXV5?=
 =?utf-8?B?ZmdZN2xRZjA0Zjg0dkFQbjkwelhxdFdjQkttRnJyUjdCV2R4MVRIN0ZudEM2?=
 =?utf-8?B?R1VqNFBycHJtRTRPTkhlT09CL1dTNEprQW1PRXNxVS96VnhzUDRKODA2NjR4?=
 =?utf-8?B?eXQ1SXphOHVNc2hQZ3NNNEFDeVZzZm1aemNkd0poS0RGYmJBTC92ZUh1NkJh?=
 =?utf-8?B?R1gzWHJhSVJzc05BRjhSdGpBTjdyRkEvbVJSeEVVbWkzUDhFc3h6ZVNJVFJj?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b59087c-955b-4b40-02af-08dc2efe240f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 14:47:04.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaA01t382R2vei4UllAOZuAtRjlj/2BFGQpoF2+dWRlxO/8wG6r+iMOwq6SFGK3ay+UXQ9ZQwOoZgYtzWgIFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3712

From: Jan Kiszka <jan.kiszka@siemens.com>

Gives a synchronized clocks on non-RTC targets with network access. The
testsuite can handle the NTP presence, simply by disabling it during the
test run, so no problems from that side.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/demo-image.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 69067ed..50b6827 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -45,7 +45,7 @@ IMAGE_PREINSTALL:append:xenomai3 = " ${@ 'gdb' if not has_testsuite_package(d) e
 IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
-    iw wireless-tools wpasupplicant dbus \
+    iw wireless-tools wpasupplicant systemd-timesyncd dbus \
     lsb-release"
 
 IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
-- 
2.35.3
