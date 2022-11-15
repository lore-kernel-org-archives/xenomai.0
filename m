Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBEAD30
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 13:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9sX7XPXO0D5Tx1dibCWrn3QEJxBdVsPF/17KFghNaPHp8kq/FbR00l4d7Pfm0TJVyAMtNQQi7kwxKiJh6NLbP/0jG8qXimVp8ud36H0sOqQrcQn8UG8FZgRoLpZ3IOQzn4xxAvNB3wHdOHXuL9ZnsEOQa/+cFleZbD8SKhV6NG6teFeOM8qMmIXKogHD74Uc0m3jdz4YxwShX+nvCFNLbepOxKkox791NgnsNRYAQ72XH+mXpH6BKXNBZCecikUZupJF+bJb2nH2w+eYn1U1srnZftAt9U1TyHJUvLQCZlpSGjqPmGajK/+M+/u6BN5+xlQGSu/bYAZd+YR0CiWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrozJ5cDb4rdlckFm0sTs+jpfDbGoYghzRL4llKkkKE=;
 b=B4axjpPbkeFBEonjGNfaLpLRxLb6rWnTVbDvFs+L08BvbYWrFD6wu62qrWOT817JkmaFPeAZcEqrXa0SsTWusKm+Vv0HrGkAvl1Re5IVddlNTYF3f5T9n5vxzw0QPVBi6fYCpkAu+2m1+3KzHVeeIZfaZE1dtAnrHJQR+LhByOBMJ540dwSDLMvo1z51JAzEszGtyN+aCX1lC0Q0ftwId79PfzCi9olhIk0st1QB2P9fkvMB+ttNAVWrpxgKqHpUFBjm9ZIQD/wKFq7VN3P9cECXwiAX4BLkY/K5oONmYon9KAr70GwFV5TqwbR3jwE4HHpBBwhlZ8etaGnPH8xyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrozJ5cDb4rdlckFm0sTs+jpfDbGoYghzRL4llKkkKE=;
 b=waSkTNOhNIJ2Rzos6D9G43ee0eicJ0cy9YLrgOpg82RLAz6RZ5I7ZUJJCkZGWBwE+E2MlwBc4nT827t+z6hGh2E7y/qP874C3RAIfGqRPYZfDThiXEsY6gnwhp7kaP4BbTrXEa8hlPhcdIG7W7cCxmMdXo/uZTARm4pE7N1R2nBCsmfVs2sHvOEbLS5sHqvhlLnLOICFmznpWBW3QiKEsMEcThJKn5m6wQ6Zs1fRzO2RUkebymO4mwFRNh5LUIrex26DZiFkFDddSyZnMxRoUZSrIR+Vx0JfPIXge5024uj2BOZYZT0mAsn1wKoPCABpu0ctUkgjAFjoZgqe/ojL8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 13:34:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 13:34:39 +0000
Message-ID: <1117c79a-961d-77bc-48d6-6ee44e32275f@siemens.com>
Date: Tue, 15 Nov 2022 14:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Allow to set per-project
 DISTRO_APT_PREMIRRORS
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d5300c-a218-41a3-2e21-08dac70e2540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ajPyY+16YR3PLffAmMxuZ7ybKDhxNIDp7kpJ6Yeu80BDqkArjGfMDSEzLTrmfN+wUfS4O9zWltwrYXDPdH2GM0laJhl3k0au9j1vDOCn0sEI3qZk7qeFQTZP2+K+nJ0UP499fe2OXgVB1UyftH43dtOi+koi5ELRcZBNporAmkTaXkvfKLg7uBK7nF8Dn5AwFz3VVzRFnzV2RDxRkadXzw049XGu6h5WsUTuoWG6YiIrCrKssi2UPiykDE5pq62wwy1UWaD3Sf+Bl1vwGDzHj79KK4vFm5nZsgGekGO8CmY6tlwGfW87dnTLsSHDbyqL6OodzVvRKVSS3s2lzST9tNfmuiJm1Iibqhps/eOogHARp7vurHpJeRvb2+Hu+BpmVbqxXKpH/BuBPk/4FAAMcgEc4achGB1kbXuxO7kUA6YGP7AE5o9aPplVvl50Kj1siez/GtbuH7jPGSna2pbYYahIf5Ihd93p18fC/JVyGvlRF0G/Jadpg77JOBQ1jN/xa4oaK+ZMHjCq1eXIu8q2NKGS+v4Rg2t/jRIMhO9qYlw6NvH0KQT78KXHiSimUWtYumzHtL0vRijgdsUdm7GxtzMkD1IhrfskNo0FbgSivzN3kiBz5I34jSlC3jJWcUp9kD7NyLj6taITcUn3hc2GqnH0IQ6kiVw+Dm4TIlNsQTYruIUZ3IH4A7mNGBjOHb9FdpIacsi5A6m1ItEkp4R1hyzOaSUJth0GKj3Z0KrlT/4Iv5RHxOE0YOB3cHCca0PZvCNeORMppMpB/uTaLl7euhm/lW5np0WEQGY7jI8lIwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(31686004)(2906002)(8936002)(4744005)(66946007)(66556008)(41300700001)(36756003)(38100700002)(6916009)(5660300002)(66476007)(186003)(31696002)(86362001)(316002)(82960400001)(44832011)(6486002)(6512007)(26005)(6506007)(478600001)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHlmWHZ5cWlOTTJ5NnVPUHNuSUEvQStoekZHaUNrdmZDSytTVW54R2hKV1Ux?=
 =?utf-8?B?bHFleCtOQnI2aU1ZQTBzRXpzcDRMNW8ycUNQUGhXRmtvZzBPdTRBeDc3SGV0?=
 =?utf-8?B?bDhrT2dwMTNxQzhOSS8xaGR1c1Z4Zkt6VmtmczlJRmpaa2pYYURYRVhya0VT?=
 =?utf-8?B?UEhmV0NFaTNUZitxSGczQ0NOLzdLS3F5ekZVRHpDVkoveHA2bmFaRExRYUha?=
 =?utf-8?B?ZFpsUXZCK2RVbGF2OWV3bWlVYzM1N3U2clY1QS8wRkJjOGxvY0dxelk2azkx?=
 =?utf-8?B?WW02Z2VkbmYvZ1dvalhIcHQ2TDdDMlJLUlMzRVhIVm9RbXVWRUdJSGNaNk4r?=
 =?utf-8?B?TUpvV3hqaVdHRjlGVlNqSDYxVTdNek9lZWxHd3doalRhTnJkWXMvejVRcStE?=
 =?utf-8?B?NHRFb2RmUEFkVGMzaGhyaGovSElmZGx4VTVncFJ4NjNDMVFQVFFydllBM3o4?=
 =?utf-8?B?REZ3R0ppdDk1bDJEeVNCdks4aFA1eEt2RzhteTcvM0dmNHdEMUZHTEtJeEJr?=
 =?utf-8?B?YXJiV1EvVE5jUnJjWHA4cVcvanpxMHZVYmtqS2hhaU5xWDRrK0h3RVFyT2xW?=
 =?utf-8?B?bTNFQkR3WjJIRnRjSzJFeUdSc0FRM3o0VkE3WDloNzEwUHBOSTNlRk9wT1VV?=
 =?utf-8?B?bUp4QnlWOXdReHl3MGF5ZlMxbEk5QkpIYUJ6M3ZwdGJCTjFGOTN5SkZ6RGpk?=
 =?utf-8?B?Y0wvcjdyUkR3UGZhQnh1T1Uva2tDV2x5c3piaEU5TVgrRVJXSldYVytNUWJp?=
 =?utf-8?B?MkV2K0phZEM4NmxrMVRkQk1TcURVV3cxL3ppYlZqait1d0xRQ3hhWHR4VU5k?=
 =?utf-8?B?OE8xblFxYzRnZDM3Um9GVk1DWlY1bVRhYzF2QlQ1LzFyaEg1VWdvYmdOWG9G?=
 =?utf-8?B?c3hCa2pRdFY4OTd4UmIrbVp6NlBuVzNTd0FXdjYwTnA1YXMvVzZiUmM3TkJ6?=
 =?utf-8?B?WnpxTlBmRFBaWCtQZ3BiNGR0VEM1STRsWEdSRjRoaDIyWmw0UkJGVmswczBW?=
 =?utf-8?B?alVuRjR3b1JhWFV2SG03OWtXSjR5WUI3ckIza1p0Z2pNY3p6L01GMUZqZnZv?=
 =?utf-8?B?clpwaW04ZmQ1M3JtbHMxOWczTXY3bFF0K1RDWlNwck1wTFdnNWhCZnRTNDhx?=
 =?utf-8?B?QlM4TFYzREVMSHNLdjBJZnBtUWx5aFRRY1VLS2lGNUV5czFTcVIwVDZOTUMy?=
 =?utf-8?B?NHk5T0NseFdtZ0JhR3JKTFQvWkc3M01kaHNwMkdMMmpKRENnMWZBYWxwNWpx?=
 =?utf-8?B?cXpxM0dzMFMyN1NXSjdHWGZtRHZaeEI2cUozeTdOalVHSnJ5eDZXRGdFbzNs?=
 =?utf-8?B?UFQ0eURuWU9HbnhXR2UxM0F0eGV0bzVVMjFGallGNXVURGk1WEJRemxjN0xL?=
 =?utf-8?B?UGVhM1JnbkpXcUhpWGg4NjZNc1Z4YVZtaFQ4bFZ6WEVycURXS0xqRWhMTnZ3?=
 =?utf-8?B?SjVsQVAzb1hsMUY0UENRV2hZWVJsTjhsamhlNXJoSXhzOStYWHNLRXMwWDZs?=
 =?utf-8?B?bERlcUFvbHBZb3h0WWEwamZQNHhzOEUvb0dGWXZHNno2a1JVdXB6UlNsQkRn?=
 =?utf-8?B?YlQ4WWhNc2I4VWhoN2l0MlBxdExBT1hMQkU0eGd6YVNKYnA0TUtVRytBa0d1?=
 =?utf-8?B?ejM5amxZKzk5YzluNVlXUnZjUmxPYThGUmd0RWlaM2dHUzNoeDdkMHNuT2Nt?=
 =?utf-8?B?dWE1bm9zVExkd1RnSERPV1pkU29xUGNvYXgzMTZZNUFSaGQ2SDdJN0JvMDdN?=
 =?utf-8?B?L2c0ZDROUE5WMkw1U2thUmppSkI5c1AxMytmUnJHVlRqOS9adjgrVjdVN3I3?=
 =?utf-8?B?K01GaUFsZW1MMi9pQ2RYMCs4OHBqb21mdUlpMzlzWmNGUHh0Um1JZnloK2Jt?=
 =?utf-8?B?bE00QXpEemJzdnZxcVQwSklYeklEVmc0NGNYaUVsSVRhZUdWSGVzWURycGd1?=
 =?utf-8?B?NXRFVlpUcXg4TWl4NHNseG5JY1kwRjNtdUdweWZFUDhoQ1ZkWHBIVjgzdHhn?=
 =?utf-8?B?UUxuOC95RUpEODVnNGFseUdTQVVVZFUzUjZ4djJhWUR1UTRGSUlpL0R5SzlJ?=
 =?utf-8?B?cnhEU1p6SzhzZGJNODBWU1FVSFpYajI5cU1LN0crUGpLNGUwQzV2a0pTNTdu?=
 =?utf-8?B?bEJWQkZ4bGdac1dlTnFLdndTVmhYdHhpS1hsYW9LVGl5YlRPTEtYUyticWZv?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d5300c-a218-41a3-2e21-08dac70e2540
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 13:34:39.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgf9XWQ5OW3DmeMwqXTGjpA6PAHZeRXTYuIdt5Qu/Ct6VaqfeXxlJ97wJ+4JsMd6vbUxvxTzx2wgQVR1gM0Yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6955

From: Jan Kiszka <jan.kiszka@siemens.com>

Can be helpful to work around deb.debian.org glitches, specifically when
the distance of a runner to its next mirror is well known.

To allow passing this to bitbake, kas has to list this variable
explicitly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 1 +
 kas.yml               | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 065543b..b85eecb 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -18,6 +18,7 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
+  DISTRO_APT_PREMIRRORS: "$DISTRO_APT_PREMIRRORS"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   LAVA_TESTS_ENABLED: "true"
diff --git a/kas.yml b/kas.yml
index 2553c23..f8790e5 100644
--- a/kas.yml
+++ b/kas.yml
@@ -39,3 +39,6 @@ local_conf_header:
     ISAR_CROSS_COMPILE = "1"
   ccache: |
     USE_CCACHE = "1"
+
+env:
+  DISTRO_APT_PREMIRRORS: ""
-- 
2.35.3
