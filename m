Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445C17AB1
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 15:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyDOSt50cTFz5WzGjl0N0Se7n6iyfJM29tIvz/s9sUoy7/CNgpETWvdkh74mJ2fNle/pqHOJ5u4nxvaK/hYGbhN6seIksmu2qFpzuK5KbBZELU0G8xI9VbQCpiF81Pz3II9IefjxQJPAatRpg5n3S7QjZwoLwmyePgsADSVzjf6fvWfnVohhMaqzDhP6w1+FP/cA2g/f+fajn1tGDG9MbaOPX0BafHNbxWIVscW7wDmt8zlWdm3IBj86bnSMghxWDAzqdiknkajvMSlsxZkslqN9eaqZemh0lZ4TZro+erfX7RWSITcaoJvh6X53XheGH8JGU/WoySE+oLsK58XISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x00JedqS2tc9TryeDQRbifsxvxuKjEJYNt9I3rzOvV4=;
 b=DHKeLy20DkGwmXYURZ/zO4dcQ+OFnfMcXFeewpFzjPKr4xQGLU4BhA+oRnR5m4Ea/z7i+7rc1/e/vBY765yLbDb07cw3Q/o0Ww0vGTLAoTpPOjOZfFvCc7DCfwCzMUxtkoEqQPkx1LgbCY3d/sjv++W8yr+F+ds3SA+doUJ4KWO0zrphfgbI1jxeVm2MZTYERx3n913cAd1GOPTULddcuVbo9s8bN5/9AiaHJlxRVZhB95qe7jfq4HOznoZvXU4m9luerhkwTZKAak4HtrBiUCnyRwNNp1sYb3XGCShuFxEkDrXaSX776vtRr12CWdJxcR5zdQIf1axCjaNvkNZccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x00JedqS2tc9TryeDQRbifsxvxuKjEJYNt9I3rzOvV4=;
 b=muuQ7CBUuXaTyyPtUHWn02ZpAftZxLj1KVuIdEyLQJ5Y81dtlG4KBeAbbVY6mjeQnoesEtQoJvJidISLqIpdfFctBoEejMs2ssxl+um2GDx9AJ0Jdst8O0UEosuT/z1ybhGWTPnXdZ+/9X6PTh4rOH0MXm42HWoPVeaTTSIpDcVavCdEGevdr9xZJXA8xzqKtfJhbe+fXJWZnME59CZCT+4tvcSzruHql32low7MZbsc644NYFl2+pIm8EVU8QJUw/LMWdLKPV1eXjHoAe1JS2BD2Ygb+PsccnGffEyOazqaxlaf+mh2j8lOEqOg5GFhp33Aha+NOINZrfoKDd7ZKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 15:37:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:37:21 +0000
Message-ID: <ca31f19f-af44-4e5a-86ec-a3233cec9889@siemens.com>
Date: Tue, 29 Aug 2023 17:37:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4] cobalt: Adjust dev_addr_set wrapper to 5.10 backport
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0396.namprd03.prod.outlook.com
 (2603:10b6:610:11b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3995c9b8-1b93-4750-ff66-08dba8a5d5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GFv+/53Ivp/FUr4VzYfcyZ3TrAsFfMrbGRp0on/rHWT/eCfzJ7K8rQR/N/HpIRLwaGJ3R49rQOc488q72BrItAXhIgNAAKp4j7AxnPEaW7bj8S+Dv/JtZPg+tqyXRRztltwk9UsJ1qfCM5VipWlrnie+B9gDOXta/wZXi2GlNHQB33yuM0GjtcDkc5m/fQ5eMNZ0cc5R6GYFk4qppfir8DJCNH1S4aLFOcprELvdbWhlqsox2qizmOGHsjVYw1U1csKzHEAxtpaclJ/F43ECZmYRUKI5gVcph3JWup2qGzrO343oV6zRLaVcB8pto0jeKLOp9eIAjg8uKhL56/zdvjbU3g0n1sNvsUKLh6usUr/XTpMkXHcBxcwKSIB1gCBq2axRazTq3HEMfHSwvHcEyCPoiJa6Lt+RlxiA8TtEsL6dLCbM7NKZWPAqvgMHN4fc68EP2puyxU2bKixBbbi51t8AF0q+yzKQ39e1XXKQusl6H9KGVUXL1R762cn1RSIgEUj/qUN1nrp1snguSAo9IEbqj0rjooOyFiQBI20uENg+W97GLiwspicDcQjghYL7mYY7fgAC/0eVB4FO8IqoG8rpuBLDjCu5uqmNppFSZMEnb3LyYzQN5hC4H9Rm67qBYrjnq3zLN3UvasGCto9Ezg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(36756003)(6506007)(6486002)(6666004)(83380400001)(26005)(2616005)(478600001)(6512007)(66556008)(6916009)(316002)(4326008)(44832011)(8676002)(5660300002)(107886003)(66946007)(2906002)(66476007)(8936002)(31696002)(86362001)(41300700001)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTVHa053TW9lVHVnb21Ba20wQVBQcGFKZEhwUXMyQkZYSEkvQmpJVlZHVkls?=
 =?utf-8?B?U3F3RkZzbnFyU3kxbmNacG1FQ2N2V2RjcHpHRnp4djNITGVrc01PWjI5bGdo?=
 =?utf-8?B?b1V1c3F0cVFMOXZIcnBXenROamFTNG1tVHo2UXhFcHZwdkxjVjdvZkQrR3B2?=
 =?utf-8?B?SlFjWS93YlVQcGVpSVArajY0bVNCT0syODRhQjZ0cXYyV05yWU5IdFFxZjJk?=
 =?utf-8?B?RGJHTW8zdlk4WkdxL1MyN3BUS0lLNHB6Qm9MSGVvQ05UcTBnTW5YVTlRMjA3?=
 =?utf-8?B?TEpPUzg4NThqOG4xaDNmOTdVYlM4MXVQRmxZaEtQTDVMQktsa2NFengzaWp4?=
 =?utf-8?B?eGo4WDFkUDlDbzdtL1hnK2RPN29FVW1zNzRqMVZmZTRtRW5oaWVHZHRacGE0?=
 =?utf-8?B?bzl2YWlGSU5SaUJaalpDbXJrdEJXZllNREcwdjRJdjNqVUtJMnVWUzFFdFhl?=
 =?utf-8?B?V3lITEV3Ylg3K3FQNkoxVVhCS1oyZ285elBBQks3Zjl4ZmVodytTL0FCR2NM?=
 =?utf-8?B?dnFpVURYZStudlRrMUdTbFJGUlBieTZKanl0eVpWMVFlaTBFVnBQV1Fyanpx?=
 =?utf-8?B?MjRWL2xRbGMwaEk3UStRRWt4TkZMMzVOYzd1ZE5GZ2pMKzNKQS9DYzNZL2Nw?=
 =?utf-8?B?WWZKMmJ3ZSt5VWw2ODFuVmFpWjQ3bVF5VHptdWlXeC9SOEljbWdFZ2NqeW5j?=
 =?utf-8?B?VUwrRllkWGxZSExMdVJDUlBYR2hYRHk2Z1J6VmR2eUFQajRlMXVCZ0s0YXlP?=
 =?utf-8?B?c2tVTHVHOXFKU2k1MXFPREhZejNaNGFRWUtkajB1aHRyNjFwVkQ4K3pSMWhp?=
 =?utf-8?B?SXJKWU1Cd09JeXEzUWM1Y29KUktVeFFlVVZSa2crdlFxU2hmTSt5T3ZCb2Jl?=
 =?utf-8?B?VUhxMkRHbndJZ1BhYnU1c25uUmV6LzZ2VEY1Wmdpek5iN004WWM1RVpmUE5X?=
 =?utf-8?B?ZHB6ZVp0SWtJSkNwYTN0WStTbEh3SVFqRGloSDV4NUZ2dU95Y2Y0RXREa1N6?=
 =?utf-8?B?Tnp2aDlPU2dmWDZUb2NOalViaXIwMVROa1ZsQWtCaGtPaGM2RERkcGRrOVFE?=
 =?utf-8?B?NU9UZW5QN1BBMUtiaHhGa0JIZ2FBZ2NsMGJyRVRNTzNWTndYZFpwc3ROUlRX?=
 =?utf-8?B?V3NIamFmQ1lXZjNBejd0Y0thRkdVWDR0a1o0Vk1pckxlZTJZRUMzbWI4Zml6?=
 =?utf-8?B?T1l5VGg2V084Q2h6SGs3RWJMVXdyd3VoaVhzai9IQXNaN0pqR2p5N1gxZ2o3?=
 =?utf-8?B?K250a2V3MytsNG5zamN5cXA0dlJBelBoQjNMcnROVUJUOFZEc3l1NTFyRzQw?=
 =?utf-8?B?MEM2eE1NcVk0aHp2MFJUbmdrWHp6OUprNktNbUxFSlhIelphMGFzcDFYQlNB?=
 =?utf-8?B?cWlMemh4WGlRK3VRbC9DMThONkFGdU9IZFJxTmJvYTdwOFA1amRzREVsM0Fv?=
 =?utf-8?B?MzlzTzBhVW5Pc1JzejJES0FXZlJaTUVMdVcvWmF0NmdlSUNGaUJTYXVRZDVQ?=
 =?utf-8?B?eGNYUTA5a2Jxdk1rYjVqTUJaVEpuaEJiZ1lJa0xvYk5SMFZ2VTBKbUJCVnN4?=
 =?utf-8?B?ekhWalJwOEJ4a1BBSURnZG1SYWdkRmdjY3NvbnhEWmlGallqaXFXUk56NzBU?=
 =?utf-8?B?dGRoN3ZTUE9RdzBuUVNxWW5UVnBQOGJoR2lQa1FmcWhjbEZNZTQyVlNJWmFo?=
 =?utf-8?B?eTRaRWFFcXJaRlJPZHpDR2U4QkhWMnBTVEVwdmxacWpWOG43c0Vjc25hai9p?=
 =?utf-8?B?OWh2dFh5YVY2U2NKUDc2ams1bklEdlhpaHVpQmhRd0F4TmZlMjN2TFkwRVo0?=
 =?utf-8?B?R2UySXhtWHpSdFgxbjI4dkVYNGFjOEw5VE5RellIdUx1MmtiUngvMmRIUE96?=
 =?utf-8?B?c0lWZ1kzT3dDcUdQMjVDL0ZTd0ZSb2tONHhuSkwrWlZTb01TUHMwR2N4eWxZ?=
 =?utf-8?B?cWI5Tm1vei96VlFwc2cydGtOZjJSblhwYjk0NnRtZysyYTFmTUEzV2s4K2Nv?=
 =?utf-8?B?cVNoamJ6RGtpTGFTZTlCQkV2R05UbDIvWnZHdW5JWjdQVjljUlByQjVEYk42?=
 =?utf-8?B?SlU1cW9lcjV5cHFua0FWVStrVTJ4dEVoNHRkZ2dleHpsc2QxbWFVMEJ4aThw?=
 =?utf-8?B?dnk3RTRFRVJhTVR2S0pnaU5vVERVZ1ppc2lNa2d1R1F0L3JFUkF4WUtER1FP?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3995c9b8-1b93-4750-ff66-08dba8a5d5a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:37:21.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMD/2QdaBvpOsJRqwJt2uqGxcTnMVrlZ2PafPlGJt6L+qDiMixSkeaXpYe2HzkuQIyRDWlv0OOuz+XgQrAv/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5534

From: Jan Kiszka <jan.kiszka@siemens.com>

5.10.188 gained this helper meanwhile as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

v4 is actually what was in next before as v1 but was never posted as 
such. v2 and v3 tried to address kernels < 5.10 as well, but that is 
irrelevant for master (dovetail only).

 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index ea7ed3ad56..c86ab16029 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,7 +54,9 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188))
 #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
 #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
 #endif
-- 
2.35.3
