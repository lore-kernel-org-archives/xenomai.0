Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334126;
	b=GDs9u/1dnxADz9SqVsaXZ0T3iUFMk2PlKOQKf3T1qOgzIhTS5J5Yv8cv+ipx0Y0uFB9n
	 MMuX+DPa+uUsro1Z1Hi7YJGjPj9YPMWZJ7CcG6ij68QD4ugBVYKHzXl2UT2MU18QYFDeY
	 mTOSlE+fl+hNk9V3AcaXpFdUU3JWVuEii0+2ylIroHLWSY/k35F5o2FqEivWK+G5Uabh3
	 jwIE0ZxxwXIeCZR319eA8tnxj42z/oQOHBF2iU7htIpjT8bOm0p2frYdahUlSo8dhktNJ
	 tcRcxtfkjkud7XAXx6qoybTYYodLxPLgl5+dEdw5amF1inaAgObXd3fIfMU8yABreiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334126;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
	b=ilV3KUKSJZdXRd9jYDOoAxt1OFBiCXEn5Rc4y/8NK1tVfKlgNApb8jd1r4tFinDS/OTB
	 fShsuN3L8iLqye/cVYtA0RmKxqm78rcN6VSRbZnB9lAhn49332IMUM2EVbF8EEDPLf0ud
	 vF7OXII8wAmAi1Q8D+yckMHAaVzxB46znfpFIFhnvQhtm9jSiv6yHTnXIvLXVloS/Q+N0
	 qdLMX1GcXpcXAvSTCUovSn84iUjYUBc2fnvYiiJiPuKFbP6N3Xv8mMv/68RkMnb3B1nIC
	 Wv+KXFHUFk2lS2gIQzvBu4BKD+eYG3DNoBobKSFObu9s2+9Q4mWUWzEyJVSAL6f7VlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Db0DhAQD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B507606A334
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B507606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Db0DhAQD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKpYnTmwH/9ZMeyWoaTyi7OgAu12oAiCvuTAsPO57tqYtaGTnuyGhTqE1182fg2yQz4yZ8DYIrTplgZ9d0sctLvn+H6ZY7TCWtHEVaHmrP8Jq83oDcufgKNLHHVTHIhQmLyuGLaaVvnuXznRfr4aERDNSd4X12fXLl1PK7WjWnXWqh5AoZis9i5mXMo8Jl+EadsZb+L8O/pQDjEwVLYNHzqLyaJ+llQv94jGM/nqPH99BApkjLyKwapcc4e5XdNEPyA4h2y6obUQJYXLh4ZRYUqs7nzUnPBtcjgSaatqTYRTSkBNV92vGrMwgW0qQuAf97cnRJBhdh6N7jRfyJa2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
 b=tEISd3cseU6r2wZFJ4M9LQ5Or4aQ2wVF37ZEXyAcUmhN2EgNXNjF3UbgLJt+7p1RouHYO34tDZjJSMGWUsGBSjqbEj7Y1wlmMNhSn7ivnBQqQwr8kFZJMzcPQMGnZDjJuxjUTcKH6xjgR84PYJaDJ1rRX+X9pyuIHHnm9bdTOhOrNbRrM7mrAnerBOgT41U5pGkZ0yE9mPUWxNPLP8npHrEyBShVRhGK0FQlVTJsoGyZbv4Sm7Cc0hNBLO9L00PVHvGVZ78S1vG2Wf0Y6YxZ4f193TS0XVKejFYGe9LszVFWOXX42ZvcdFUWKhiN9eGB1aAyfBPXGpDmDY+w2/AOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
 b=Db0DhAQD+B0Sxlx6zF+CS50d6g/pqzAB+OC6TYqdYByy8cQNYZRtBBKtGQasElFqDK2aH2zdsAwFOAishlNMgveCQBt60NwZ16ePCbqRNLPg2RgSzIDtrbj1eq16YC+Onz4AOxRQdyRVQW1EM82gDV1n+PizkOOdAX+soQcD/5cSflxxvg9ABxLPEEcWN/gL24PDTyKvBh0xMfu5ZpLq0bStSlXK8khEIWRSFBc87vihJORA68SNFPxAWEUm/h/4ytaBv4V/KwZhZ+xkoh/86WRooZ6i6os5/Bh5d/lGXnElj1BM1f8D85V5HDshUFoFjCaCW1orbb6sjl14B4AOaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 5/7] rv: add oob_trap monitor
Date: Tue, 10 Nov 2026 19:08:45 +0100
Message-ID: <20261110180847.633167-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180847.633167-1-tobias.schaffner@siemens.com>
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992240:EE_
X-MS-Office365-Filtering-Correlation-Id: e69aa1ff-b81a-4de3-e91f-08df3f55a6d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261021123027099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5UL7Itxq7W5j5hn3WF6POLe7ABl34YbBPdop01Sp34GPDaSaxMCu6ESuRAUsFIdHdOTe/p4Sg6p1k5GDvmJwWmBsXE3ltmpUhZsYBNX1wX0HCwmYqWdkTAc7ng83weWjrhKfmyU9s1GwPGmqew6ZuZrXbX7k7ScNBzJeA3QPCBkl+Cbl7RreH3s+4oYtocgjMbE72P2OCY7IdLSg5Me1dLVy9tQD3wd9miHpluv78PSmJ/lEAajwNJMUJwLVFWl8j2sr5l4HQTzOvYESR5V1n3aTdPArfmVBi47lUKJG4zibaLSIfhPr1ASQXU3Cld86oKGfkVLB6hdZ9c/DJ3CQCQrYeewkVLYyA+8leHuu71c40Db0j1j9vbc+FhLwbyZ+NlAfTbffI8Efk+IzLHgk3yk9Yhhu5ek10xYTyV2erACIqYamhovaHJxTIdeCF9ejYLwmFqvDZT+qP4k/nqC9zM1zscujYDt1PP/C8DCgGf4NVwh50+Rs6ZaYHrcXn2MFz9fFWbCxaJbTHYK4aeUDZBUmJAY6rT1eOb2ncyRsDdaQJOhCwNMTd2MzoOTwcpzOZZjP4SHByxnmhFueaj4jKdXdB0PO2OmgDyyFEciY/3jEx5up5Rkz1FF/DosOtahK5bqPm+3KgYdHeLO1iGQNdoLGPDwjkXGLKYDfi5b3UA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRp6Qj7Xh26I2dddYgkpEMpCjVEGQB/o4E7aaTsXc+pnGGQ4IB8a/zD78iWF?=
 =?us-ascii?Q?QAxVY2fz2xWjPLhD7EaMXR1pQskLRhSlE7JCyUnpsUsMf56I1Bdp1H4Jlibx?=
 =?us-ascii?Q?lEBN0/k984QEZpe55sjrMl+E93xlT+QrIj3ZVc2yQRj6Bphblk430AV13S0R?=
 =?us-ascii?Q?CQu4Y2YXsOyIeDywzYyxhi0snxsEJWRGRfA8feoSYsWgm6HM/BYfGvU1KxB0?=
 =?us-ascii?Q?PTB8czmyxSVGF0PM3NSoxBrn24AnTgBZluZqIROg57KIpXzyFewdz4ea7wen?=
 =?us-ascii?Q?hSIfzuVR6QhrdQaRDzD5YyEAA7YZ1Wudi1K4279epT6A7bRN6kFoYm5PPelw?=
 =?us-ascii?Q?vxz7vV32kxjipfv0sDuBiyXJ1N6jYneghgNlB9acMHSBxz74z9JPI+tV8xvi?=
 =?us-ascii?Q?kI1rYqsUg/mQLkED5c5bgJ5ua3kS7h08tiTHljGgBgn8vUm1+1OZKGMDhBT+?=
 =?us-ascii?Q?YAEElrzBiWUEOjDwz/W0eKFR2zcYyxyxAGMvxd2pFXnsJF27tigEqlXgeoxN?=
 =?us-ascii?Q?oes7xD73P6s8MANHr5dtNVrsRwSpfrwdtUcqryTDSQNj+WXinmUpSqUKzoJj?=
 =?us-ascii?Q?5P6z/nxm609ub3qbSx1M7f5/Z+xkj5TXP56AGjFdIQx83H1RdNnpCK/Qbo4D?=
 =?us-ascii?Q?FRoqpcMfPON5V5Gt0tZGKzP84igdxF3NzmRcLcfEvkXPCBoy5ZRYuB8zvXD1?=
 =?us-ascii?Q?6hIvsW1q9l0feBHvn7eP2wD1TRir8BQUUFcxff2sQksjk7QHFhLUHu0VuRfT?=
 =?us-ascii?Q?Xdg8rMydSyM2RwmvmosnBolmyJtzveEd1H3wlC2mkCfy2eg9RcX8ZbpA/HtI?=
 =?us-ascii?Q?sqUO25/qDxggDs6LRIThCv8NJQkGiKBbAkER1SGkWBq+nohRPezJTmf0HKkO?=
 =?us-ascii?Q?Wtt33rF5KzEslE4cR+gHTxWXphgQTcpprIT3a9OtA3Xqib848SPRRseEwuqU?=
 =?us-ascii?Q?M9H3VmcKErCDersz2yGccXTnz+TM6DfylBwWcg41tTssv7BN54RgTianG9c6?=
 =?us-ascii?Q?lEtzHjlFaniHTwyOuAHPOcqpXvDwvC0VICpOoqoZsMBY0oldLH2oK6QwWuHI?=
 =?us-ascii?Q?KZ3KRrKvJJeNAq31ntATMVRNu7QmHqJwgNmunl9mcSJpDLVdFHQqwvY/yyjg?=
 =?us-ascii?Q?XLSSd0nBWYTcrHG4ags6Sz//T//kMfD0q3V3r9OoDTUPgwb0ty0DXtxZO+K1?=
 =?us-ascii?Q?/4Vggf6H5l+fwQiNA3yb5LXTgiJsygcHEt49keSyYHoePvGStZWmRszURMd6?=
 =?us-ascii?Q?Li2H489H2wNrxwxzF2yFgthGqmTKjiYjcJGoY8Ttl/G0Y/3Aal0rAVTyAulA?=
 =?us-ascii?Q?T9jwWNTVHFk7YeqNCHi1ZUUMo3atkrbYataYlSffrxVYfvjDHagA9ws9Idh9?=
 =?us-ascii?Q?YlVvtDycLG0rrCJCcbIla5NoIwqbg2MiSiyFeGVz6TbSuQTZaWuwr2bNQSCj?=
 =?us-ascii?Q?bS0gV4stWNhKzqUhQXeE+KCwQ+Y/qw3iyuc9eEYy4RbOj3KthOCxeCSyyP07?=
 =?us-ascii?Q?EJZ9qcS9jzdJXyvzERtiaSM3ZBlEkr3LcEgnt0PUZrFj0CMI8D/BrjhZWOWT?=
 =?us-ascii?Q?qbTIJbB+Cg6KiHWNNJeGA8GlkifvcwAh2EIWGVbzCbjU+OTmuii5nMuCxA5H?=
 =?us-ascii?Q?SQqFcKjoPQ9pSAsZm72KpKyTcpX/HpugsTcPIyU9AIYhlb4S8UOSViXh8BRq?=
 =?us-ascii?Q?r5BwH/4v1Q96B95HO9xFoXvxhoxIGYxPYJ1bmA8BJnP5de0WWFnu8l+ZrsH8?=
 =?us-ascii?Q?W5Dfi9HddBLSnlvT/Lx6/WpJwTQkfNs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69aa1ff-b81a-4de3-e91f-08df3f55a6d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:41.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul7ec/k5BnWEPI/FnHhwG9mNB36/2yyvy3e9g7s0So7GtYRUbdceHiqFbbgzZKzQTlkyZzwVXXwti7Nr6ozuG37DZh7+PTOZObpyJ5nhKes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

A trap handler missing oob_trap_unwind() leaves _TLF_OOBTRAP set and the
companion core is no longer notified about traps of that task.

Add a monitor checking that every out-of-band trap is unwound for the same
trap, by number and frame, before the task resumes out-of-band.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Documentation/trace/rv/monitor_dovetail.rst   |  26 ++++
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/oob_trap/Kconfig     |  14 ++
 kernel/trace/rv/monitors/oob_trap/oob_trap.c  | 144 ++++++++++++++++++
 kernel/trace/rv/monitors/oob_trap/oob_trap.h  |  61 ++++++++
 .../rv/monitors/oob_trap/oob_trap_trace.h     |  19 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/oob_trap.dot        |  14 ++
 9 files changed, 281 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/oob_trap/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.c
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
 create mode 100644 tools/verification/models/oob_trap.dot

diff --git a/Documentation/trace/rv/monitor_dovetail.rst b/Documentation/trace/rv/monitor_dovetail.rst
index e46cd0ab0b8d..e660b5c9a1ea 100644
--- a/Documentation/trace/rv/monitor_dovetail.rst
+++ b/Documentation/trace/rv/monitor_dovetail.rst
@@ -27,6 +27,8 @@ dovetail_leave_inband_tp    oob     after a successful switch; oob stage
                                     stalled, hard IRQs off, the core may hold
                                     its runqueue lock
 dovetail_leave_oob_tp       oob     before the switch to in-band, in the core
+dovetail_trap_notify_tp     oob     hard IRQs off, before the core is notified
+dovetail_trap_unwind_tp     either  hard IRQs off, before the core is notified
 ==========================  ======  ============================================
 
 Monitor offstage
@@ -48,6 +50,29 @@ the companion core demoted the task would::
 ``sched_in`` is a ``sched_switch`` to the task, ``signal_self`` a
 ``signal_generate`` by the task for itself.
 
+Monitor oob_trap
+++++++++++++++++
+
+Every out-of-band trap notification is unwound for the same trap before the
+task goes out-of-band again. A handler missing the unwind leaves
+``_TLF_OOBTRAP`` set, and the companion core is no longer told about the
+traps of that task::
+
+                  trap_notify; reset(same_trap)
+          +-------+   ------------------------>   +---------+
+          | idle  |                               | trapped |
+          +-------+   <------------------------   +---------+
+           |     ^    trap_unwind; same_trap == 1
+           +-----+
+         leave_inband
+
+A trap is identified by its number and register frame, so an unwind with the
+wrong number, and the unwind of a trap nested in the in-band handling of
+another one, are reported too. A leak is only seen once the task goes
+out-of-band again. Traps taken in NMI context are ignored. The model uses no
+clock, so the hybrid automaton core arms no timer and is safe on the
+out-of-band stage.
+
 Usage
 -----
 
@@ -59,6 +84,7 @@ Usage
   # cat enabled_monitors
   dovetail
   dovetail:offstage
+  dovetail:oob_trap
 
 Violations are reported by the selected reactor and as ``error_*`` events in
 ``events/rv``. The models are in ``tools/verification/models/``.
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3f43cdfcbb32..d7207d7e9892 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -86,6 +86,7 @@ source "kernel/trace/rv/monitors/nomiss/Kconfig"
 
 source "kernel/trace/rv/monitors/dovetail/Kconfig"
 source "kernel/trace/rv/monitors/offstage/Kconfig"
+source "kernel/trace/rv/monitors/oob_trap/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index a684b0c9af2f..c5848be60f5b 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_DOVETAIL) += monitors/dovetail/dovetail.o
 obj-$(CONFIG_RV_MON_OFFSTAGE) += monitors/offstage/offstage.o
+obj-$(CONFIG_RV_MON_OOB_TRAP) += monitors/oob_trap/oob_trap.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/oob_trap/Kconfig b/kernel/trace/rv/monitors/oob_trap/Kconfig
new file mode 100644
index 000000000000..7a1709d3a8f3
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_OOB_TRAP
+	depends on RV
+	depends on RV_MON_DOVETAIL
+	default y
+	select HA_MON_EVENTS_ID
+	bool "oob_trap monitor"
+	help
+	  Per-task monitor checking that every out-of-band trap notification
+	  is unwound for the same trap before the task goes out-of-band again.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap.c b/kernel/trace/rv/monitors/oob_trap/oob_trap.c
new file mode 100644
index 000000000000..47e7ddd95aa1
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * oob_trap: out-of-band trap notifications are balanced.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "oob_trap"
+
+#include <trace/events/dovetail.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/dovetail/dovetail.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "oob_trap.h"
+#include <rv/ha_monitor.h>
+
+/*
+ * Both trap tracepoints fire with hard IRQs off, and NMIs are ignored. A trap
+ * is identified by its number and frame; on 64-bit, kernel addresses share
+ * their top byte.
+ */
+static DEFINE_PER_CPU(u64, oob_trap_key);
+
+static u64 oob_trap_key_of(unsigned int trapnr, struct pt_regs *regs)
+{
+	return ((u64)trapnr << 56) ^ (unsigned long)regs;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_oob_trap env, u64 time_ns)
+{
+	if (env == same_trap_oob_trap)
+		return READ_ONCE(ha_mon->env_store[env]) == __this_cpu_read(oob_trap_key);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_oob_trap env, u64 time_ns)
+{
+	if (env == same_trap_oob_trap)
+		WRITE_ONCE(ha_mon->env_store[env], __this_cpu_read(oob_trap_key));
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_oob_trap && event == trap_notify_oob_trap)
+		ha_reset_env(ha_mon, same_trap_oob_trap, time_ns);
+	else if (curr_state == trapped_oob_trap && event == trap_unwind_oob_trap)
+		res = ha_monitor_env_invalid(ha_mon, same_trap_oob_trap) ||
+		      ha_get_env(ha_mon, same_trap_oob_trap, time_ns) == 1ull;
+	return res;
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns);
+}
+
+static void handle_trap_notify(void *data, unsigned int trapnr, struct pt_regs *regs)
+{
+	if (in_nmi())
+		return;
+	__this_cpu_write(oob_trap_key, oob_trap_key_of(trapnr, regs));
+	da_handle_start_run_event(current, trap_notify_oob_trap);
+}
+
+static void handle_trap_unwind(void *data, unsigned int trapnr, struct pt_regs *regs)
+{
+	if (in_nmi())
+		return;
+	__this_cpu_write(oob_trap_key, oob_trap_key_of(trapnr, regs));
+	da_handle_event(current, trap_unwind_oob_trap);
+}
+
+static void handle_leave_inband(void *data, struct task_struct *p)
+{
+	da_handle_start_run_event(p, leave_inband_oob_trap);
+}
+
+static int enable_oob_trap(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("oob_trap", dovetail_trap_notify_tp, handle_trap_notify);
+	rv_attach_trace_probe("oob_trap", dovetail_trap_unwind_tp, handle_trap_unwind);
+	rv_attach_trace_probe("oob_trap", dovetail_leave_inband_tp, handle_leave_inband);
+
+	return 0;
+}
+
+static void disable_oob_trap(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("oob_trap", dovetail_trap_notify_tp, handle_trap_notify);
+	rv_detach_trace_probe("oob_trap", dovetail_trap_unwind_tp, handle_trap_unwind);
+	rv_detach_trace_probe("oob_trap", dovetail_leave_inband_tp, handle_leave_inband);
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "oob_trap",
+	.description = "out-of-band trap notifications are balanced",
+	.enable = enable_oob_trap,
+	.disable = disable_oob_trap,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_oob_trap(void)
+{
+	return rv_register_monitor(&rv_this, &rv_dovetail);
+}
+
+static void __exit unregister_oob_trap(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_oob_trap);
+module_exit(unregister_oob_trap);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Schaffner <tobias.schaffner@siemens.com>");
+MODULE_DESCRIPTION("oob_trap: out-of-band trap notifications are balanced");
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap.h b/kernel/trace/rv/monitors/oob_trap/oob_trap.h
new file mode 100644
index 000000000000..7d73dc10560f
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of oob_trap automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME oob_trap
+
+enum states_oob_trap {
+	idle_oob_trap,
+	trapped_oob_trap,
+	state_max_oob_trap,
+};
+
+#define INVALID_STATE state_max_oob_trap
+
+enum events_oob_trap {
+	leave_inband_oob_trap,
+	trap_notify_oob_trap,
+	trap_unwind_oob_trap,
+	event_max_oob_trap,
+};
+
+enum envs_oob_trap {
+	same_trap_oob_trap,
+	env_max_oob_trap,
+	env_max_stored_oob_trap = env_max_oob_trap,
+};
+
+_Static_assert(env_max_stored_oob_trap <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_oob_trap {
+	char *state_names[state_max_oob_trap];
+	char *event_names[event_max_oob_trap];
+	char *env_names[env_max_oob_trap];
+	unsigned char function[state_max_oob_trap][event_max_oob_trap];
+	unsigned char initial_state;
+	bool final_states[state_max_oob_trap];
+};
+
+static const struct automaton_oob_trap automaton_oob_trap = {
+	.state_names = {
+		"idle",
+		"trapped",
+	},
+	.event_names = {
+		"leave_inband",
+		"trap_notify",
+		"trap_unwind",
+	},
+	.env_names = {
+		"same_trap",
+	},
+	.function = {
+		{          idle_oob_trap,       trapped_oob_trap,          INVALID_STATE },
+		{          INVALID_STATE,          INVALID_STATE,          idle_oob_trap },
+	},
+	.initial_state = idle_oob_trap,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h b/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
new file mode 100644
index 000000000000..fcb2f5bc6965
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_OOB_TRAP
+DEFINE_EVENT(event_da_monitor_id, event_oob_trap,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_oob_trap,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_oob_trap,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_OOB_TRAP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9bda8ef3b96f..bcd7ee424e89 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -190,6 +190,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/oob_trap/oob_trap_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/oob_trap.dot b/tools/verification/models/oob_trap.dot
new file mode 100644
index 000000000000..97ef5c3b9431
--- /dev/null
+++ b/tools/verification/models/oob_trap.dot
@@ -0,0 +1,14 @@
+digraph state_automaton {
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = ellipse] "idle"};
+	{node [shape = plaintext] "trapped"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "trapped" [ label = "trap_notify;reset(same_trap)" ];
+	"trapped" -> "idle" [ label = "trap_unwind;same_trap == 1" ];
+	"idle" -> "idle" [ label = "leave_inband" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.53.0

