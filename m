Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84F23C6
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 07:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+X2mCr604/J3kHlLvL3WIr2gnPGxmLDcmVT0YX+ZHoXIP+Q/e9BOM966zjPnBzVKq+ijC6UMT1eliEnJvITeS3EL3F47GgctIC5cU2i75xjaIz7yt5vyDbrq7s5I/lgt+vOzlcFPU8ID1pxuHcXfa7JZ+KVwEYoeIzsr7B1M5wiiJqoipciaMl4KvonfMW8fufWzUjdvPdss44htVjYR9Xl2QuMkFhSuAa2QNGVr0/oooRr4S2YqDESJbuS+wGy+pDMBHB3uVf9/CUBFFdGyBSkWN7cbRXi4hdpIUESou8LgcBx3UiP2kLvDQV1r7h4osHCoQSpjY7FCEfdZajZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPa9aAaFtq4d3nS1P+V64f4/t3w/kPdW1FheAoMA6Es=;
 b=LZdDLuUQ3MxgdwKEMB0Wv2+AAGEyzGuc3dcgl6gRMZZzeaFahBvecJk/h+uK57f7P/OsPqd0W6FOE5/qTrmunN8kurtB2pbYQjNOesyEpOUSV/mvqspPhBdvUt5M07G1i8vzWXJuejkTGwWzKeJBC9ndbxJ0ETrm0k/f/neSBtZq2pN26+ALZ0g3HntthqD5Hrv3HAuL4it2YcpqDdI1IhTZ+kQFhq+MpVjUOlq1BxkpRKih4EzoKyeITClgryJhxUPw1KIzlsh8EfS03g8Z7BGiPxdpiovBL3Pjz47NFIcvxlfg3uGwuAGP4H3mP25yhn2TZn/K5YWHAUvhCKh1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPa9aAaFtq4d3nS1P+V64f4/t3w/kPdW1FheAoMA6Es=;
 b=tyK1UHkEkYvB4AaeEdQHDZ9g27nBjLw9/8WNy+wZX+v7ChnImEPG1/hTGylLf3F5R+vvLoDmpBRmX/eUlfE1h9Kv/c1dP1ZzJi0Wsq1gCxpqEXzKKEiD9hlkUS6CHecXD4r7/kbm80H000xIfZpMcVaqb6nuqZDjX1MJLgvpOMdo/vI5tAog/zwW6Mf/4d6pCZkPjpBQidO4My9QYzPke4bUGm0cMarpOcAAhgImrGDXqBDTPo5xCU3LkDD8+vgYwf4luo3qC11nORMbpPLCR1qYtjBQGQY0H/yG5leC5F+wBo+mVD/riBVZcYKVw8D89j/o2E6mszBK9ycSHT+CsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 07:02:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:02:07 +0000
Message-ID: <30671ec8-7867-c2e4-f409-5e8a8e44214c@siemens.com>
Date: Tue, 10 Jan 2023 08:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Fix several sign-conversion warnings in interface headers
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: ce63ab16-8bb6-4f42-1580-08daf2d89633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5NGgtqjDCm6Nb9eqLJpHqAn1wC6M9Lld8M618vdU0panLXvH7vUhUX5yIrIAmZiNui5kS+39jMSD17VlordC46m2Qhp+49wDEoFpDEuB9lcgbHO8oRJ25sYeuZtr2ZFjRLBO2gk4DAKMZSuENDHhtRXJK1DzLSy4ksKHQ0Wa6LBZ5d2kVvQvBxA6AQdQaPI4lhmmRzEafdylimz4iqJv4zOwlu7JgL3uSfm918DpvvT3kUGqbq4MT9UDJ35mg+K8zVpjRr+FtYW0IUBodrZ5lQWemIUfyLAXsi6ZqoNSAhwD4Mkdc8Hgxv5W3jdLA4Cs4xKrRqU/LfNYU/Rwaq15DtpGnwXeziqds36z1Zl3ngp9BBR/VX3gg5p9m0xElWGHII1/QbQcr2+NgPRLj7s6Wb8Y/rRh80jca+r93ypjVxaObmkeLilweo7ikIerfGfTS142kLS4lwi97Ptm9BvVx5aEgXlphS4HNz/3X+o4a/lOP4YqBfCfoxzxQ5Nx93u325+DlQTvKSM1jg5O6f/psaC9y+wA9BX36mIGuino/sETfNIgfC8gQfwqUDb3O+nfzPN1FDU1V5CLYqK2ygXjEP1s4WxUz5AxU9UcYHXgGEGt0PFwp2Fkj+aM208JSBjGTRfAqoqnxVUq3go8+QZ+luNb/FoTZUEH3Ankt5O4ZDR8F9yKpR6WTYtXJ34S55kgRZ5n6GSOAxt0U5MMqTe4voWfqr9ZZXy7XZOup76SF7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(41300700001)(2616005)(6916009)(8676002)(36756003)(66476007)(66946007)(66556008)(86362001)(31696002)(82960400001)(38100700002)(44832011)(8936002)(83380400001)(5660300002)(316002)(2906002)(6506007)(31686004)(6486002)(186003)(6512007)(478600001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmM3bnJnNFhxRW9VSW5Bei9YdUwxZ0JJOGVSdldjUGcvY0k2MHErVXpZeGJN?=
 =?utf-8?B?K3BwMTlCUzVvYWNickpoQXJLSS90Sm9raC9FamQ3L01zY0YyU0h3MmkrYjZZ?=
 =?utf-8?B?TGl0NUJuN084TzRDT3VXb0JFQk5oSk5YdHZDNEZFeFpFYTZkQXdmdFlZM2ZQ?=
 =?utf-8?B?TCs1N2ZLd0FhQzlsb3JZcDhOdjJyVXFrNktoSUxOTFYzU2dJK3lWWDJDZ1Ji?=
 =?utf-8?B?Tkd5bUZwdXRmelVGSXpUL2hWRTNwYng1Y1RuM0hnNUlaaC8zQ2pzVFNLbHBz?=
 =?utf-8?B?NFdmYW5MTmsxU3poamtJeUxNUHAyTXFSZzhuTy9iTVVPdmxPOVJKSDVuSHNX?=
 =?utf-8?B?MDlGNnZMaGRSeTRvYVZRTnViY1g5QkFRTlFvY09JUUJRRlBHdGFLd2FBdUF1?=
 =?utf-8?B?VlVqWER6VjJHV016TkNTcnBUVEpQR1JLVVoxVEtFZEhwUnFvSE85MUNYTGZ3?=
 =?utf-8?B?R2NqUkdjbEFMeWt3dHlxaGJuMmZaeEI4dWV5SVZtL0l2MnhNdnlnMUJhNWxH?=
 =?utf-8?B?VSsvbXJHVjJHSndNcjdkWG5oMGE1RkkxWUc3bDBxTm5WNUJadTQ2UzdYc1J6?=
 =?utf-8?B?MGZBQlNYd0VCWjhKdElqNUhpblJaWjZLb25VQklWQWFNK2djcU81cXY0STlW?=
 =?utf-8?B?VUt5NGwwYXBycXFMMDI1ODZvYnRsZnZkdUg5bU5EYmFOYm1pOW1wQlhjVlVR?=
 =?utf-8?B?eWVTa3V5dWJBb0pla1F0T0lrdno5QlRoSmFWMjJFWEthRUh6UExSaEEyVjV3?=
 =?utf-8?B?bzU5Y1hreGtHUE8zejY4ZzJmaytYQndXOVQ2RkhjdURyRlBFMEtMNnkrQk5q?=
 =?utf-8?B?ck96bi9pZ1R2VCtFTXBnRHdJVzd6S0RpYWxjWDBaNGhSejl6MzR6anZOcStZ?=
 =?utf-8?B?VXZYL3JseE82V3VtNmZmT04xbTQ2M1JwMlN5SzN5K3l5K1BLcXhzcXBid1l5?=
 =?utf-8?B?N3JudTY1NU8rZjV5WmpMTlloa3Q5NllTRExzWlBuNGtJV1BjanU1MUx5d1h3?=
 =?utf-8?B?NEdoZnZKZjl1bzZQejc3cHliZUtRK1pxVm40MENUWTEwM2xJRHlmMDdDcEIz?=
 =?utf-8?B?bWpJMGFZQklDMHF0eVdWd2dFd3BQMHdyN2FHNmp1Y212eWFmdHkwTGVsak00?=
 =?utf-8?B?anJRVkVuQ0RYZlNBdHc0VHdLdHJPS3VxUmZKMnI3VXBETjlQeVNLTmdRS0tQ?=
 =?utf-8?B?aWp4a3RBUHIrbHpIbkJRaXZ1MXd2VXJZMGJtOFBIcWJxbG5sbk44SndZNlU2?=
 =?utf-8?B?ekpFSkJBUkNRUzdUWWdlZ01hTkYzN3JXZTJWTmJxS2MzSFhBdUxnWXp6eXJw?=
 =?utf-8?B?QW5BZkNGYmt4cGdTanA0L0dlanVCUGhOaE0vRzM5bWNvWFNTUkIvUXNIZ3Ew?=
 =?utf-8?B?RlAxWHZZa3NCWGlwUDNsZGFtY3g4bHAzUEpHS2pFZm53akJNdlBtK25WeExl?=
 =?utf-8?B?NE82RkZGQ0o5RVh2Uk8wWUVUbEpNa3REMFhZSWpLbVVybUZZZjlJUG1rRkRr?=
 =?utf-8?B?NkNqUGJJNFFRMzhVVFVneHgxWGM3UWRqVGd0b1BMQU5iSDdXSTFaVnhSSENq?=
 =?utf-8?B?Q01rR2J0RFpydXN5NkVBSUxQRVovcnlLcDRWNjJPajU5WDFOTnNWY1AzcjJy?=
 =?utf-8?B?c21xYktQb1FFQmN5N043eHRMb2VJSDRDVUJ1NEM5VTFTUi9BVHhXa0pMVWRT?=
 =?utf-8?B?UjJlQXRqQ1N2VjNzUjFneU9YSHVBditRWHZVaC8yOTNLeXQ4N214RTF6Q1Bx?=
 =?utf-8?B?V3pXWkp4ejRNbE1pQjlpc0c1bk50UFpRZWZlVDZjSSs1NEJrUk9WbGlhNDQv?=
 =?utf-8?B?MzlEQ3p4QWxoelNhWnB5SWtwMklQZDlKUU5sWlBzTytETldhNVhUMmN5V0cx?=
 =?utf-8?B?TmY4aEdRSnI5TjEvektvaGV2b0F5QTVuLzVLVnRUU2krN2JCZ3lxSXJweWlZ?=
 =?utf-8?B?andWZldkVzU3OTdkay92aURONFZ1UEs1NlJ0c2hyVk01M2srMjNUQUhiZXVt?=
 =?utf-8?B?RFNIdzRRTHYxZlZ6Y3V6dTgvYWJZRktpR0hEUFphNmxFZ0NWWVV1WXdtWlo5?=
 =?utf-8?B?RFp5KzA1d1FRbnZUTmxYZTZCUVhicXJiZnRmYll1TmxueE90VWxLNk5jMUxN?=
 =?utf-8?B?enRHaytSdzBjQitZVDJ6UVk3QllYRVFiTVU5MUVxUis5NjU4d2hPUzdKTklF?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce63ab16-8bb6-4f42-1580-08daf2d89633
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 07:02:07.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RC/ettn+4zKSf2x9sElTsMQTk6qD7w808g6Gn7hxFy0mQ3kpfd6EArZAsLdmTtWv4E7tshO8ptKypi0eob70Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6983

From: Jan Kiszka <jan.kiszka@siemens.com>

This includes can trigger warnings when -Wsign-conversion is set. All
conversions are fine, so silence them by explicit casts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/boilerplate/debug.h        | 3 ++-
 include/cobalt/uapi/kernel/synch.h | 4 ++--
 include/copperplate/clockobj.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/boilerplate/debug.h b/include/boilerplate/debug.h
index d3ab0ef80a..927db3351e 100644
--- a/include/boilerplate/debug.h
+++ b/include/boilerplate/debug.h
@@ -135,7 +135,8 @@ struct backtrace_data {
 
 static inline int bad_pointer(const void *ptr)
 {
-	return ptr == NULL || ((intptr_t)ptr & (sizeof(intptr_t)-1)) != 0;
+	return ptr == NULL ||
+		((intptr_t)ptr & (intptr_t)(sizeof(intptr_t))) != 0;
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
