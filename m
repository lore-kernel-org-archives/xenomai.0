Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E73214
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 10:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xttt68FCnyHQ9WIuIiT6zQCfvV4ILidiflj/JeKTg7u/fYtyhbpm9tquJ8/doalIMSJVstKKAjK4TJGPjqtiw/2obD3DqallHOpOv7cVpSI5kXeSGgRzFdjT6IsWrZmXYLD7KPVS2y2TAOiUgVzgHs1siXRTJjUhKNswOrYjzycftZq9ZCMra7dEFGZrPRBxXxmMogNN9yyLNMJpFAXaVTUbpZ88COBCW0zFZG7kjTKGUClyLLRvB3woZdoQlekx17XKpUz4PmKHTFoRhL1jPh1hHZMOqHo3Qn4dFrUgT4Yc7qcLm7AulWWLmyuS8m6e6SJhM1Rq0KFr4vIX2zCbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdP8eOTmB1Pg+QvjtgeIs4eQFm9A2Wz5S9JDbzVph9o=;
 b=TigWM5o4LZJxvMApe79PBQ6fMZMzYIsh8lIZmjyFrzHY0Po+ekJi1rTuiCvYq7bI98gmHas28HSViTJcwZiF3jJ1END53LHyskDeWRmk3DyoFM3rIaakbjzQetjGWvK5IZB5PBqgCb4okJihLg4fLdej6muu1n9t92wTGWVBd5tXNEwa/OjUDtdhvzXaoboaRWBLa5I5yikl3U8BcJ/hploc90Ga2B8UhCDk5R+P1zXkHDJLEdzq07hNw3qe3YohVClzgUYiOOgz+ahc1Yn4miVzTEeOlJ14HFfB3rYKZFO2h3F3+YHdu/i7S/tERnmb8t7o6EqBXP/oJk3/LWUgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdP8eOTmB1Pg+QvjtgeIs4eQFm9A2Wz5S9JDbzVph9o=;
 b=K7NBSZAmQcgAHe76M2K9XC0JGibXKCpHHXdfS6t0Qusi5lqjQzQ4WRnQCgWKiQ2Ommd5sWyzCqCAlDR6mPTwstDnRoT92DEdSIUg0DK9tCzL5OOFHIDrG8SorBBohOfvVXwibbGCaOPgQ1G3uM5LTn6XC4daUs9x3At1MAUYqky44cfb7awsyb6Z8jQQr/FRhcAYaoT/UhcrFYoRx6YbUfU3eZzmrnzSU9OckKRnftnUHccNMzvcMf/OjyFzCKJwDro3g8Ew2vdv0BKhGSn6HwA/czz5dnlAUo0HMiGFshut28McCDcdSEpEBufIoS/S5U0AWoknRa2FhOoe0wBU9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 10:00:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 10:00:01 +0000
Message-ID: <44e92867-c7ae-0f92-6be8-edd36ef19e74@siemens.com>
Date: Tue, 10 Jan 2023 10:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] Fix several sign-conversion warnings in interface headers
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9e94b3-1488-4006-7311-08daf2f1706a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1EscPtPi3M9pko4inxFPtZG0qMyGPpbDJVRco1u0QXF5ymipGgBI+5dfmmvF5rxvM5Q5pvLm+deEsr4FVmP+FjTxj9Q0f5hwprMsrfyg1K6435Ph4IREeMvHBBcl6AXPK91UxKkAjGJwWyQQ+PJAI8ihKNmLMfJffiNpPzT+VdExv9aGrpVR7AJ6aRQPnPZc585VYwFebW1IbYy3f3WjY5nCVkzfFrTLY41vf/AMnuPFDVpY4ESjcNpfvBOR6ZWOGE8NFC3/H80kgGBDD5Oha3kRW/7W52JxkzWXKeqmcytDVidpzUezuOJojkN7ayo7aWrVyOHanmmOU6jk1Lg97/ooABAAnxpG5I9SuOHlzw1tLufcN0JdlmfLKCA7x2K/Y2MGklqQ8pL1JG8g4VbH0rh/VaEHg8NsEuVpcGclaU3GASaY5CDb9U+vOMxQsRCJPfzInS69XzUuxj+GM029t2hhnZWmjcV5JBvrtrGODflOYjYL8x6kVoYD05fXC5vw4y8IalE1cO8bXa/XeML9fx2+CUV1Hp2mMJPQzKaQjqQRZk+qY+qtVIQgKfhXkc1cHT0vlurUz7ANO+H8YwlMt6S6s/hZQ1CT09UuuIiAfbdUmh4/rm/x6vW9CaKpnfKQpeJisQq021qKO4aXdxyrddBv72B4Y8+slZaPkC6okSzE1ERaWtIqCqAPolqt9/jSHMa9QDOUkEORCvUCsAFwc3EhR6BGM67pFCyE3aAlJq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(5660300002)(316002)(6512007)(44832011)(26005)(186003)(478600001)(6486002)(2616005)(31696002)(41300700001)(66556008)(66476007)(6916009)(66946007)(8676002)(8936002)(36756003)(86362001)(83380400001)(6666004)(31686004)(6506007)(82960400001)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURiR2hNVldRRlFPaDJrTUF4SENnY1FIcjlGTC9VdEwyaWQ5N0RBbGJ2SGhT?=
 =?utf-8?B?RzJ0OTE3SnExdXNHMkdnMWhkZVM1WmVIZzF1QjNvL0daK0JRZG44bWo3MG45?=
 =?utf-8?B?RTQrcmM1VkpDYTNROTNwVkp3SkdSeUNyaXBKWkg5azFwemxkWFZwOGJRVUFP?=
 =?utf-8?B?NGFRMkFyWk9BY0poQXMwVDdYZ0JubjRGc2cyblhhc2RRYjZncHNBcHVvZTlo?=
 =?utf-8?B?UzVJc0hrTUhYTUZ0a1F2QzVuNkVJdXR6eThmVDNVOGgyR29DQnhyR3lPS1FT?=
 =?utf-8?B?TlNtYndDS3g4dXI3MWlTSkdoYSszYWdwQnhISW5LMUpIeEhwU1BGOFZYMHBv?=
 =?utf-8?B?V09qQW1tdEVLVGgweDd3d0hLRm1DU3NJZm1UWlQvRVM3SzZXRVpZaFRiM1NU?=
 =?utf-8?B?Nmtyd2ZPc09EVVZneDVaSk0zaGVWUXpjQ1dCNEU4ZnpDVDJwNHZ5SmJDN1dj?=
 =?utf-8?B?bENOZ2M0dUlhcGZSYUE0WTBhVmpOSVpLdDFtVU5Vdm4wSXVTU3cyT1NYSmhq?=
 =?utf-8?B?L3lFaXU1ZG1zZGtTaGpIZmhPd3hVbHR1NGU2WEtRUnNuNVBFR0ZpMDRhTldi?=
 =?utf-8?B?NVlURzQ2UDA2aUptVDZBcGl3cG5vM0tkdjNjVmtUam1Sc29idWRaRzJtSDI0?=
 =?utf-8?B?am1Fb2tXcDk1ZG5pUnZBRE5vWGVSV2lscFZiRWJrR3FiRXJRN0YreXR1dU1X?=
 =?utf-8?B?c2tCNWh5bmFnMUhKdGJaT1dOUVhXenpmWWw5bktLQk01d3pEUlpNd2IzK1p4?=
 =?utf-8?B?U3ppZk0yZlRNUm9HcmRtV3ZVc1BuU1hDUFN3czNFbWl4bEt1L3piVGlDL0h3?=
 =?utf-8?B?KzJMWXhyS3ZkMWpYbUxSVExyY29hL0N2SUdIZWZRVWFscWRjdG9UQ295WVgy?=
 =?utf-8?B?S3M3U2tlR2k0Ymw2ZlhIcVJ3VUU5QzV4OG5kTWpaVGU1b3NxYWlkbWxzaFFn?=
 =?utf-8?B?dmZIQjlETGlnc0owQkFrYW9RYVVxWC8xNEYvTUtmUWpIek1CeXRtTGM2d2lx?=
 =?utf-8?B?dDhicFVnbHVrR0FrdlhJa2NwOHFXTlJmSzhBNGc0ZXZkNGV4ZzhidmYyci92?=
 =?utf-8?B?c1Q4QVJmeXMxRk9HSlFxQ3k3OE8yNlI4Z0lzZDdtVXFPall3MlpDbmNvd21W?=
 =?utf-8?B?Z3RGNm5ZVUxhdWIwSkZIVFdydm9UV1BKeW1NaDh4RlZpOUYyOGVOaEFiUmdB?=
 =?utf-8?B?SlVINTQ4ZHNDUTVidnozRVpkcW1FdW5pY1RjeVUxTTRhbGtWMDZZMWVSYlhD?=
 =?utf-8?B?R2FwVFJTTjdTVG12cjZnVkJoV25wVGF1akFENm10Qmk0a2FYdkZxZWFoZm02?=
 =?utf-8?B?TDZYa1IxcWZBY1RjL1VKZnFRelhKY2duNGdheEtHK1ZOVWtzbkgxVVlEVDRq?=
 =?utf-8?B?SlZFRUE3S3FoWFJ2YzJYMkcvanJRRlpkSzdlZWgxN2VhQjBGNCtsRUdGZDUx?=
 =?utf-8?B?SG1kZUVNb3JML2RJNk9lQjNnZnExbU01WU1yTXgzeVBEcVZ2NmpCUGlKdWJG?=
 =?utf-8?B?NmZOelFnNjduVEJGOElNU3hBVi83Tmpha2dKRzk1UkFvRUFMNysxNFQrSmR6?=
 =?utf-8?B?STh5SGcrOWo2YzlzMjkvdFpnQTJkRGVwenBmNVdIbW9TUjkvcUpUNW92TVBL?=
 =?utf-8?B?THBiNmd4M3ZWOUNiWThHRWVVaUF4SHU0NjFjUnFMaEpaaHIrYzVWMDl6UUtG?=
 =?utf-8?B?a0srazJsRDNMQWxRREE4ZTI1cW1zaHE0NTZQS01HbHVkckRDTkJWN0c1UDVY?=
 =?utf-8?B?Y0VleXQ4aE9NbDZYYUs2TExHQTJsdHNqc1Q2ZEZWZGJDVEY5Z3pWUS9XQVdB?=
 =?utf-8?B?MExNUXVFWFFOeWhSNlFnTFdWWkRsanAydHAzU2g3SEUxbXRvcnhSN3h3Yk84?=
 =?utf-8?B?WWZ0TUNkRkpHeVVVRjdNejhweGpMWkM4WVVIUUtJRmluUzZoaVhsY3BZcStY?=
 =?utf-8?B?RmFFSERWanY0RHZvei9odThPL25xOTg5bk4wK1o0QlRkZ2U1Ylo1UkdxN3Vk?=
 =?utf-8?B?OTl2VGcyYm85cks4a1NFODJqK3BJYmFSVnNTRTJsWE43UjBuYnd0R2k3ZG1Z?=
 =?utf-8?B?enovalhZeGs3T2JrOUlxaE0wQXJlTFNNenhvblZpVGVZc084YjhwUnpRZ01Q?=
 =?utf-8?B?U0JIb3pBTC95blhBcGNGRnlNYVdNTlc4MGJ5djZHbWJkSXNiTlhqc3ZYaDdV?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e94b3-1488-4006-7311-08daf2f1706a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 10:00:01.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47DXEQTqYCqwS09qSF644B9mPso72IADJlHpqM3rMsWOQ8YN3dRB0rL5pMA/Eqq9dJAYQ13j8OrjY6l+Dw9WQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6145

From: Jan Kiszka <jan.kiszka@siemens.com>

This includes can trigger warnings when -Wsign-conversion is set. All
conversions are fine, so silence them by explicit casts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - restore original logic of bad_pointer

 include/boilerplate/debug.h        | 3 ++-
 include/cobalt/uapi/kernel/synch.h | 4 ++--
 include/copperplate/clockobj.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/boilerplate/debug.h b/include/boilerplate/debug.h
index d3ab0ef80a..248cb908a2 100644
--- a/include/boilerplate/debug.h
+++ b/include/boilerplate/debug.h
@@ -135,7 +135,8 @@ struct backtrace_data {
 
 static inline int bad_pointer(const void *ptr)
 {
-	return ptr == NULL || ((intptr_t)ptr & (sizeof(intptr_t)-1)) != 0;
+	return ptr == NULL ||
+		((intptr_t)ptr & (intptr_t)(sizeof(intptr_t)-1)) != 0;
 }
 
 #endif /* _BOILERPLATE_DEBUG_H */
diff --git a/include/cobalt/uapi/kernel/synch.h b/include/cobalt/uapi/kernel/synch.h
index a21eb965e7..a7cb9fb099 100644
--- a/include/cobalt/uapi/kernel/synch.h
+++ b/include/cobalt/uapi/kernel/synch.h
@@ -48,7 +48,7 @@ static inline xnhandle_t xnsynch_fast_ceiling(xnhandle_t handle)
 static inline int
 xnsynch_fast_owner_check(atomic_t *fastlock, xnhandle_t ownerh)
 {
-	return (xnhandle_get_id(atomic_read(fastlock)) == ownerh) ?
+	return (xnhandle_get_id((xnhandle_t)atomic_read(fastlock)) == ownerh) ?
 		0 : -EPERM;
 }
 
@@ -57,7 +57,7 @@ int xnsynch_fast_acquire(atomic_t *fastlock, xnhandle_t new_ownerh)
 {
 	xnhandle_t h;
 
-	h = atomic_cmpxchg(fastlock, XN_NO_HANDLE, new_ownerh);
+	h = (xnhandle_t)atomic_cmpxchg(fastlock, XN_NO_HANDLE, new_ownerh);
 	if (h != XN_NO_HANDLE) {
 		if (xnhandle_get_id(h) == new_ownerh)
 			return -EBUSY;
diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index 58ec56652f..dde18bda87 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -143,7 +143,7 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 	unsigned long rem;
 
 	ts->tv_sec = (time_t)cobalt_divrem_billion(ns, &rem);
-	ts->tv_nsec = rem;
+	ts->tv_nsec = (long)rem;
 }
 
 #else /* CONFIG_XENO_MERCURY */
-- 
2.35.3
