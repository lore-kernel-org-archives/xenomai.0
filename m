Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466117C
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 05:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AagSSTIxtWdol12msIROtc7t+rRMWQiIwR/Le6ilOkaJCjYSTNrnXp6Ch1lAZ96A/usYekR6usTyoOIgZpEby2UaXB8l3J3hNJbN3ySj9sO8VzoDD0WRXnCt4+1CZ6HQ9pFvFBVSPWjCNE8IOVUcwYl4tZD+fVhG3QI+hJSmWK8vry6hj/zOBFTJWTFDVL4KeV9pXEqy+I+n6IV//Mk4w8lBEHpgGOCMR0+Ad7ri9I+8kwOTkkaBPteVpLUk/NuOPBiHLV81QwcCtpRFGR5QprT+YyiNmgrwmLnBqutqdctUjRjFDn9iOAfh0iZPQgB4zTGH+V+PVAnsQwOISqBnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkL9Nlo00plhBUgUv9Z4SyySima2aJYJb27pwkcW08g=;
 b=FyBNnejruYqQYUwZzT3AOzTeTgMEdqdtq/xVeOSUsWqq3jXl/K+kbEm5H/8ev4biOQQSx67GIt6nSVB3RAdyfTSDii7qij3vNwb8sp0ks8+2SmOdBbgpa8dROfretZYzlU0YF/J1BkeZDZzIUgmkbfmiHwji9DiIrDZ9T/lhO1EL3pIg7hVyPJIr5IYWKzcsNeRKAghDLY1KptaKBQ0Rb2ZPKADPRozIgAlF1xonrEX/Biij8jLcHegmpUAQRJ/1iLNsVdHdcKMp+nGphAKFf/ujz+VyAHV+90ZRHJ6ze2JXDwgCBmgJB+pbdEY5eM1p1czm8MCaxFAyHZTiing3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkL9Nlo00plhBUgUv9Z4SyySima2aJYJb27pwkcW08g=;
 b=zkvdBN64hoiJalpzE6ApgGRl+SfZbXsItXwSicacrKcCiZr/bMBGmoCuqWA+0jCEEH3Ox1XaKg3BTF/+ZmMODPde59kM5Q5kOFQ8XKr2SNqppzoOpuElh81Rkrbt+kDPQjh8Wu5FHjPEFAYWtDb5J+ad9rhkLnMIPQgBgkrFp+FUSokb4Di9q6f69/UhuhfzWOXiYorgc2vrQEWA65Oe5PgNUCXo1usbAiLS2sBTK4Wza/nSeMmcEKkSkkIiNnv/B8EYhEK4qTAhygUjr0A+yVd+R3vruA9Shj/sCA/vU8x+oNUmFrrPJ4QExC2eZAxDL/4lXrdfHy/l25sybjky4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Wed, 22 Mar
 2023 05:48:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Wed, 22 Mar 2023
 05:48:32 +0000
Message-ID: <a7ba7e08-c550-86c4-cff6-20cb85a60ca0@siemens.com>
Date: Wed, 22 Mar 2023 06:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] automake: Avoid usage of user variables CPPFLAGS and LDFLAGS
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Mauro Salvini <mau.salvi@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f1ba48-14d7-4504-3b2e-08db2a9911ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zr109pLFdhkX0q44pHux3fcH4a727iTeeO/FPp6l0LQMFkbDCTpoGgDu5FChNf2puTOXSEAd9cF0kSY/VY9c6aeEVYPtNvjH75IgvEpHOncf4tMwvdowz+weHoBjgKkEz1JKhkmgz4PFNHSvp6nm2Q1EQO6IV6m4pKy1bgwuk0kJidu6FQxnBOJymgbCmq53ajSsZ5x89F3XaB9giLeiUXxo/7D36XyfgsW8G8Lfy0FzOACXXZl58L39OBwOWWmxyBlWFxHR4PIZgoyNGdnz+RV23UyMvAKdOZIqgUZiHt+kZTpnoNAYmgpRjwYo2rV6OQgpBhgj0HqEf3VCJqmGu2x3Ee+LV/B+r0TWKiYskqsjINjEcw1VPM4DDBC97xyobmkEX5PSm2MBO6Zkcw3Eo10zcskeLasSjW5RWsljOy8nXv/Wmy9Xd1w7BYwZtuWgaYtvAojWGxNagzvHYpVFyrHMYYHPvsxFFaC1WJNnanlXl1G+1CDPyOaiv2tNLH/UMSciHhaLM3qkHO9EXsY+buNYKCUVS892wbvjXpQiucDbFJSjRTcREg880YkcueLjm5MhWMnR5u4KV7UgXnnKVv9KSlDHyNG9HCxS9RkA/OVksQIeQuxuuNftt6y5JaS6NpMPE3RQPkBpztoL01xsUHdtV5xWYwzBNlo5Qvf7c+VJKvFafcwjw9UyXi5bR1xmfx3fGEr7yVD3ItW9owj3PjnIHWHCrR4Px/4WcH2GVYd4CjrVSNLNAOkNpbR9PZpCGf1SDV5JNMtvhaXtKR7ebw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(36756003)(38100700002)(966005)(6486002)(82960400001)(6512007)(186003)(31696002)(8936002)(41300700001)(44832011)(86362001)(66556008)(8676002)(26005)(66946007)(66476007)(6916009)(4326008)(2616005)(478600001)(31686004)(5660300002)(2906002)(316002)(6506007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG83cUFucUNkbDRXWGttMUhZZGZQRWdDMVVmN1QrSmVRaDlCdTdsSjBIcmxt?=
 =?utf-8?B?L0x0bTE0QytTVUZaKzJLZnEyTW94TWdjSHVJRDRWZ2F4RnJKd1gybjdiekt1?=
 =?utf-8?B?Y1JkV1BnMmJWbm5tbVV3Z01mdU52OXBzdlpwUFZDaEVkc1dLYVRySldZc1ov?=
 =?utf-8?B?RVc4NTNDcFZTSDNxTDc1MlgxOFBFQ0wwazdka3dBcFgyWHA4b3BkenBVazJq?=
 =?utf-8?B?bHFpOGVOdHJ0WXpLRzl0THVyVVhXM3pvWGQ1TUNVdDA4Z0s2Y3B4T08yaWda?=
 =?utf-8?B?U1ZiUW1aeERsSFhyM01SdDNzZmo3WGxKb0dNQWZ3ZjM4Ynd0ZFVFUVVCWnVN?=
 =?utf-8?B?SjJsYmE5V2tSNUJQcXdBNUNDcU9jUitXNGF1TmtGUWx6S2hDQ1lqbno2OG0x?=
 =?utf-8?B?eEFuVTA4ZjQrMFNNUWxqR2lBZmNxYTRKUis5N0VCYjBDbUs0bmRQTkdGZDNq?=
 =?utf-8?B?clhiNDhFSXVyN0VNQWlVK2J5Tml4Njk2dlE5S3UvWm5sWkdvYStsOVV3d0JP?=
 =?utf-8?B?OGdLTXdCb0JrYmhud1FlcVo2YmY0YkE5WW5yS0dydVdZV053M3FBbnlUMUh4?=
 =?utf-8?B?U3lMNzJ5Z3RQLzBBeXQycjlLWkx2Z2JoeUE3M1VsdGZOSmd5eXkyc0NHRmpY?=
 =?utf-8?B?dWs2TzdaS2l1aFBGdTFKRWNjcVRSVUZyYUFuTXgyZHh2RVZsbzlmbUZscTVn?=
 =?utf-8?B?QlpWR2tYQ3hWRmZMcjN5Y3FDQzFKWVFObUZXZUZqM3VVeUZyaEhiZW91Zjl5?=
 =?utf-8?B?eWdoRDJhKzBaemtJbGQ2NVNybWplTVUyeVI2dFBMZnZML09QNWx2M3hGMFV1?=
 =?utf-8?B?bzU1YXA5MEVpaDBKd0lxN3hiajR1ZHlMelZjMnVhYVB1RVFrQW5PKzJzWkEv?=
 =?utf-8?B?enp3alR1enNBYTRteWFlZDU1Q0dXMFNnSGxlZmpTOCtaamxob0xTRTFlQjZE?=
 =?utf-8?B?WmQ1eWJuUkc4ZGczK0tsZmY1TXkwZXEyaVl4QWVKVDhYUSt5R1BBT05pWUpl?=
 =?utf-8?B?TXNmUGIzR2FYOUM2SU9BdGRZZGtFVHRPMzZpUVZXQjMyQjFTdEFnY21pREE2?=
 =?utf-8?B?NzZyQkRmTWs2TjduUHRCK1dNVWcvT2p5QXJlbmRORVEvZGM1ZjhvSlVoK2RZ?=
 =?utf-8?B?TGw1ZzdtZFRRcUJJQUJPb1ZCc3FQekdJcGZYSW5lc2lydUxZNnBBV2xoemRT?=
 =?utf-8?B?dG03UFpkU1hDRUZwNUxma2x3clM4ZUVwanVxSk9UUGhQRDcwa2xOUzU1Q3dC?=
 =?utf-8?B?SDRkcE95ZmhlUmE1RFR1S3lwcjRRNUhPNVVGcW9pQklXcW9RK2pzcnZVbk9l?=
 =?utf-8?B?cWJiZmtCREVUYkpENnlubytzc200cDZxQytaUXZrWWtXalh2Q0ZFODhyYkxu?=
 =?utf-8?B?VWNVZFVSY3hRUVhjbUw4TVcyMFNVazczR2RIaVk0bzBMM3lOSmRzRHEvSlFC?=
 =?utf-8?B?N3prRzF0Zm5XRXJqQUsyclBPWTJWSzQzRFVwUlZPbVkxbWdMd0xDaDVRY1gz?=
 =?utf-8?B?em9PTDRPaEIyNnJNbk5QUVVtakdSRHJYZ2VtblhsRXErNUJkUGlXWC9hRFpr?=
 =?utf-8?B?WEFaN24rRTlTeGVGY0ZCeXNvZE1STmFmZWtGMFNQQlNyd2lCY2tlbzY1Nzgr?=
 =?utf-8?B?R0IweHczOGRMb0ptL0xWUGxsYlhMSVMwanIvTStmRU9YWVd1TThxN1VjRXBL?=
 =?utf-8?B?SnNqbGVkSm4reVVsYzU2ZkZxdnBOaE5ULytydWlsbHRoQWpucW9VOEpuL0ky?=
 =?utf-8?B?TEpwMmJoaEd4dmdoUVhwaE5WejkrV2FnZzVpR0xNSnJQcDZKSDRlZjY3Yy9S?=
 =?utf-8?B?TnNlMUVoZEhLM08ycFJZdXpsOHIyQkdlTVNNbUlReFQ3Y0RaeFhpS08ycDRE?=
 =?utf-8?B?SDgxWVNBdElqNXhkUkFia29MYWxBWjdKVUtteXY4bTNpOFZHaVBQamtPa2FK?=
 =?utf-8?B?aXhJTlU5VVZabEdZbFJCOTBDVVBRWjZZSHljNUdIZVlVSmQyVnpPcE82UHRR?=
 =?utf-8?B?TE05OFlNWWdIS1hPZjk1V1FOOGZpb3FKNmpKU2hLSTFWVFpwdiswOUJKZEds?=
 =?utf-8?B?ZXN4UzNsZ1hhVkgwR01WVUtpQlNxU0ZDMVJSK3lLOEJNaGRib1VmeGZCWjdt?=
 =?utf-8?B?Lzc4M3ZjNzVzNk9XTzdWWkw4c2U0RWt3aU51T0h4dGoyaEUzU2xXc2Q3YXhS?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f1ba48-14d7-4504-3b2e-08db2a9911ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:32.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82AXLEKxiBVG2btJCvPSwVYchiSlGxUzZjAodggO/NEPSACqC3WekfeZeFyed0giwGG8XvBQ5bEVKnDv9GhvEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6986

From: Jan Kiszka <jan.kiszka@siemens.com>

In automake files, those should be prefixed with AM_ to avoid conflicts
with the user-controlled variables. See also

https://www.gnu.org/software/automake/manual/html_node/Flag-Variables-Ordering.html

Reported-by: Mauro Salvini <mau.salvi@yahoo.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/regd/Makefile.am | 4 ++--
 utils/analogy/Makefile.am        | 2 +-
 utils/net/Makefile.am            | 2 +-
 utils/ps/Makefile.am             | 2 +-
 utils/slackspot/Makefile.am      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/copperplate/regd/Makefile.am b/lib/copperplate/regd/Makefile.am
index 3b14e98636..5e4301bf81 100644
--- a/lib/copperplate/regd/Makefile.am
+++ b/lib/copperplate/regd/Makefile.am
@@ -1,12 +1,12 @@
 sbin_PROGRAMS = sysregd
 
-CPPFLAGS = 			\
+AM_CPPFLAGS = 			\
 	@XENO_USER_CFLAGS@	\
 	@XENO_FUSE_CFLAGS@	\
 	-I$(top_srcdir)/lib	\
 	-I$(top_srcdir)/include
 
-LDFLAGS = $(XENO_POSIX_WRAPPERS)
+AM_LDFLAGS = $(XENO_POSIX_WRAPPERS)
 
 LDADD = 			\
 	../libcopperplate@CORE@.la	\
diff --git a/utils/analogy/Makefile.am b/utils/analogy/Makefile.am
index f8a304b601..a1506de5d8 100644
--- a/utils/analogy/Makefile.am
+++ b/utils/analogy/Makefile.am
@@ -9,7 +9,7 @@ bin_PROGRAMS = \
 	insn_bits \
 	wf_generate
 
-CPPFLAGS = 						\
+AM_CPPFLAGS = 						\
 	@XENO_USER_CFLAGS@ 				\
 	-ggdb						\
 	-I$(top_srcdir)/include                         \
diff --git a/utils/net/Makefile.am b/utils/net/Makefile.am
index 3b90f8adfd..86d351ede4 100644
--- a/utils/net/Makefile.am
+++ b/utils/net/Makefile.am
@@ -2,7 +2,7 @@ nodist_sysconf_DATA = rtnet.conf
 
 dist_sysconf_DATA = tdma.conf
 
-CPPFLAGS = -I$(top_srcdir)/kernel/drivers/net/stack/include
+AM_CPPFLAGS = -I$(top_srcdir)/kernel/drivers/net/stack/include
 
 sbin_SCRIPTS = rtnet
 
diff --git a/utils/ps/Makefile.am b/utils/ps/Makefile.am
index b8930fb56d..1120e6da3f 100644
--- a/utils/ps/Makefile.am
+++ b/utils/ps/Makefile.am
@@ -1,6 +1,6 @@
 sbin_PROGRAMS = rtps
 
-CPPFLAGS = 						\
+AM_CPPFLAGS = 						\
 	@XENO_USER_CFLAGS@				\
 	-I$(top_srcdir)/include
 
diff --git a/utils/slackspot/Makefile.am b/utils/slackspot/Makefile.am
index 179243a95e..87f99e49ea 100644
--- a/utils/slackspot/Makefile.am
+++ b/utils/slackspot/Makefile.am
@@ -1,6 +1,6 @@
 sbin_PROGRAMS = slackspot
 
-CPPFLAGS = 				\
+AM_CPPFLAGS = 				\
 	@XENO_USER_CFLAGS_STDLIB@	\
 	-I$(top_srcdir)/include
 
-- 
2.35.3
