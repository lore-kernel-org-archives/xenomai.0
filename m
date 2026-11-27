Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787230;
	b=UeLxpjU9rRn4T12s446Sz/ywTu2Wl1j56KjO/4mK1lRhUHKVAGQt7kakU44R/ehzkghC
	 jH6fzXbkpFqsm8RBdxD942Pa/U8aBtSKamZuALm6kiNNOLUjbtET6svWQ1CDNU0Y68dXV
	 vcvq8al4u0/KgqCwGrdrz1Fgk5d6AMES/KY/m2IYGVf1+MtfONdr6tRJTayYvWjygsBko
	 kgJ1G8BrtOxRSXKk6JlSl+X7nTh6Elpr/BmVoKsHpPdSAxkQf+26x/IoCa57eLuccz0hl
	 a7KrMY4Ib7WQDpYVrOPKVPA21nkmis7GPNP05KQjzFHimVxrA6+kp7Ag34Yq5y/ANjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787230;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yLDiZ0TMzUQfmsuaDh0i1P3qGkB1gbPyezQLAXFnXfs=;
	b=bgaPWsd5LRplbJ6ii6kE9ctPl6aQdnqcGtbusBKWEU8qFKkSDA4HogN0V4T29U/KJYeT
	 wyNGwjspm+w6jm0rCuPe79F+64aIteOTtqQRz1F0j4IY5vrzWcvVFr0mQEhgqkxlMuf2t
	 EqfN+wvafRReGty1pXIBjAsNHPkOXEmXoR6bP2udbp4pq1lT5lgQQwRpaZveukTtszc6m
	 P9SZxG/lPIlKKVAStYhbiuUfxptaKq3R7QnXfrjIL0xuXRt43NzZjLYMldfWX94QIOgBM
	 YlL+lrzJPGM8nYSCTndVR7SP7Wlhp5vg/GJfqC4xlIOy+RbOU2XD03zHOthPclqXcUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=AFtspCgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.68
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2359606A31C
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2359606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=AFtspCgl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhiHVQPPTcxH98bwFD43p+4ArVY4mKTlkOjODOMxl4tVTaz6wlW0nmxI45OlGnF/XstnjsyDxRPtz7MpXVG93kAfglnblOVkwzOYEcIMndSyrX/XQr76BjlmcbfmCoicGK/38znGWOcrgKtgq/JPXA/F/Vuh/V9j5hwbzaerU4ekfQjEenGx5mAzCLIKosKX52jCk/gFi5p7B56UprpYJmeBOt/mXVcSx6cBpT9tq7Qk8rFb0o0E0Eo8tYH0THMMkRH3gIi6uWe0zaWUK7HhV9t+W0Y+hzAgfW8VDI4dpQFCTLhIx6R1M3IVmNssT+GCo7kmA5HqtX2Lma+ASurxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLDiZ0TMzUQfmsuaDh0i1P3qGkB1gbPyezQLAXFnXfs=;
 b=Ch1eUcZ+h5KxUW3BBPv5POetv+MFuC6oKJ3uNBf7fm9hZbdV9YB8c4NxDtQNCK2xQjf+VUUpy/4o4vmeH4YRUcLAQboCoRP0UHUxGCdIRMArnnQQZKRRB6t7UNVeumLTNWuvPRq+FY3Uh3xB0MV+gjy5lfsc8PeqiFBHZpt+wOM+YHytKvku+1L0f+35hyjPJceimbJBOYp+37SiI5IRKY7U/QdJuuJLwoa6PupAPG6z0b9VSRUExy7BaFgQDJKD6FeWEMZ+epCs7UI+jwsFT09zbe8MvTkXdKIOtV6WrojQljgbQOKu/3UKMl8ZTRbge+OtL6r1z3VeUTMSoe8Jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLDiZ0TMzUQfmsuaDh0i1P3qGkB1gbPyezQLAXFnXfs=;
 b=AFtspCglRV18uHHIzl53vZdW2vTPvsPygj7fHXrGSMZoChvZbScQnjSMiUzQo+3vSozdxU29CgNQJVQkOpVTAOcOqEcKo9QYmf6xPLSspQfVOn8fBSalnymRXYnJtY0WPHngFQBh1C8p1hLwmulMl2sZEeRksmKSAptJMbD2ZijMyF3M4x7X0+Reli3dcB8NpQFb4svGYV60WBjGu4wIWmHgkrPyCeNbT3NqV5cuULXzh8HAbcQmgumSa+3qJKmkjv82YKgQcLakNF+U/lheQjh1HjsrNyTVf3qfQkiULECid2g9lesfrgoUyBQ947JlhmarubUOkvaxpFxA6l4Llg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB9640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:645::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:47:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:06 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 0/7] rv: runtime verification monitors for Dovetail
Date: Fri, 27 Nov 2026 14:47:18 +0100
Message-ID: <cover.1795786695.git.tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: e14c3b19-40d1-4c24-643e-08df4c8ced2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|366016|6133799003|18002099003|20046099003|55112099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rXNle6e8CAUkqLZnpBc+ozuGX9GADQhrrcpd30NFXq45Nce2T3PSWbZuRreuX9IEhHO4boYOmjt+4L0XLjh854qAE20blu+KmyishDwf1WfxKAaMXgYk4tRQDPVUBOj0A3JTJllFN/hltG6aWJhBevDXov2IDu5Q+t+kTX0wXh5mY8XKr4YjROr+zxSyxhn6eGxhPuQgKQgA8QTSFrx4bj3lzX3A5OMjX272WWBw9ypoAOvKiK8X1yKmZEhfJCFoyX3HqDiGANcurWS55S0/6Is47BL3ML9t974zvcpMXFgXqpVITymukX1iToWDRNiiHIXmFhk5y0hKQh2mqIJ3uiYAPJvcjVrnoOQfYPLIqULMXZChlfb6ZV5O1E5cn5t2myem+wGp/tU1uhlnhiX0OG5AK9PWzsB5F/Pk7JqIbKklhCoz064MWUhzSE61nWcprnCC+f9ujFh0vCqq6ex5VhE2gI9uqqIh8S3tlD8j+lPLEKPoU7fzomb6IOQkJLYu7QG1WsxyigPWMFsG0lqg/70k9FYO4RBofLshsPCqiYJfd30uJLci83ct3fRO0sFV6eqZF9Asc7OGMDBiTPaSkL91jAQTVSX2KeD8iXfB7j/aNXaJprNisOr+PgFs2r4d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(6133799003)(18002099003)(20046099003)(55112099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jcFnP4EPU4fYsy2DDWkTjWInFcrqDfb9CVGtBdHqpbvVjMQZ7gvUYWbpM7F?=
 =?us-ascii?Q?8bZOi4PcbH4NQgWZl/VsvDrqATKEtzHSaeDdrmuJNOr+G8gxKzmMXrjp+fEh?=
 =?us-ascii?Q?EMKudKjmXTsbJhXlcp7quBaCldxxyWlrQBqQMdYPPHWkrVK7lpCLZNU5EDr0?=
 =?us-ascii?Q?DyUIWPmgqwRvTpV01Lif9QiEyMWxXLx6ivU6jcQBQXMu4328527tnqB3X0e0?=
 =?us-ascii?Q?DKerWSFJ8YQ822w8N3DQT3MAYFAFc0gxFytpoI/IQ3bxsfsZOk392pJ8xsiv?=
 =?us-ascii?Q?Ud4fwrEL6+uajJyud3VWb1WAX8qEP3M3uyTyPlYyAuLe/+lNqHHnJ0m7Gl+X?=
 =?us-ascii?Q?RcB+zg6c9e57R1b4RDO0z6citeAdtYc+SnS9+C8szAd3fkjlPxr8JSMYD5LS?=
 =?us-ascii?Q?ls2j3lntLHzUf7/gr1uoq49zvycAM7gi89b38DbGeEUxYv5oBTnWhALFQH/1?=
 =?us-ascii?Q?Zr8DcVVOMkGD0tm0ZjLjEZUkqLEMPOI36iSCw2ZAoHAHfWnnTsG23/WTS32a?=
 =?us-ascii?Q?BpKwWafxtlvVXkP6VhV+4OdyRchhSIdIj2va1oyb0Pw2xThw2JP15KEmf/Jp?=
 =?us-ascii?Q?e4be4ljRsE7sEt1qDhgEgqJ1cyLDNB6tgWNt1ntp9fHp/cYe7gleTBU7ocB3?=
 =?us-ascii?Q?wHyHjO2NKK2nRdBmk/FKmZPL5aziwJ0oP0/y2puK07SclSSmCR9KtBNkma/l?=
 =?us-ascii?Q?19viF6iHztFzHrvMEGBteuB+RA4gLeEJDeWNjh7uV06LVWDrP6JBSKWJmI3h?=
 =?us-ascii?Q?B3WbJImMLvWYU7I2GJeb8NzuIe0dOv7Exr+4PLCZWDUs5bE2jgAK/B9Ob0u5?=
 =?us-ascii?Q?GuY0Wixc45owPPLZ6Ptix0l+6zMoTwPZhR524JJGehrV7SgdVbDFHyKWtWsJ?=
 =?us-ascii?Q?g/toX/9JsMjGH/bXJtVliEVp2a1m8uvPKdzhyPiHTff3ONK/Uyty/EWtN8Mx?=
 =?us-ascii?Q?mMUH+ovU5kN4vJJTimy05yymnpp8RL5lk9wVoi8V+zqDVIBofAHGKorP5B7y?=
 =?us-ascii?Q?SQmWVvnZOKvRkSzm5Fed9F1XNXdy2mISDk6eOv4T5J0F7u8PmbMkDn3rca7V?=
 =?us-ascii?Q?xU1Uhd7QnhMZJpHG5x0c0edpNKen22xHTt/xBFNGoGvLknWKbdJTP2cWJRLN?=
 =?us-ascii?Q?atv82LSBYM0ESjxx1bdEcJXpAyZoqc3kz1LtukHRIxrsDd+t3Bq6RgJ11w1G?=
 =?us-ascii?Q?tdUL20YeGQH0CZQQXrVhAjoKqlw3veaPuxFZDaF+6mce2PGHyPmVL7+lo5Yg?=
 =?us-ascii?Q?Jv7+rPmGQ/hUeUzW46mTSwl2cOs4cqQZmMWXzDArgdXuf9KjYcI6/mYZ/iuc?=
 =?us-ascii?Q?UODxXiSvTXvD82Y8eVrTdcuFwZU51ttXyVwRd+bKG+/ndsv0F7MPLMK+6Yan?=
 =?us-ascii?Q?HTU3gtGeQ2kGDLwQmM+evTKux+h4GN3pK1jnDM6KhjorDZO0STZNgB0HdhDw?=
 =?us-ascii?Q?Y06hWePAzgKNaMWusG/MXqJnRRgEf1o7UuNLa+9klgH0aQci7Vn7ZL4V4Yw1?=
 =?us-ascii?Q?1p/JFdWAzdnnvS5i3h+Ulbqj8qcq0pZnxgwUHq3OLyU3sNdFtScHsCcGECJr?=
 =?us-ascii?Q?afnzeYZLcS7GzX2k8Ej5HGBbqgR47G1r4Nm8nPyxv+JcCXLHj4g2ngB65rDl?=
 =?us-ascii?Q?FZ3oaYzBQHWh9hHJAO4Q/V8dcH2t6EdRv8RKQ4uPCx+2HHE7gj95B/P9dtZz?=
 =?us-ascii?Q?kp4g8bInJKy/c5GDtcihMaiPWg4jNETMOtDTAnFKk80pESeJrfvD6XC0IMpa?=
 =?us-ascii?Q?9hckghVhIvaWmLxdW48wVFnjEi481Pk0pkpTGkLioxkCY8binO8DUYBRxF7E?=
X-MS-Exchange-AntiSpam-MessageData-1: Mh9hgspRfes+IGSVudGjlc6PISusr+mM/qE=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14c3b19-40d1-4c24-643e-08df4c8ced2a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:06.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQVZw4dwld6KBU4Jda1gfl3Gin7m1ECY7vM0i4GvGnjuEW5F2sKMd4h3JQFrJJZME0roZKE1r+HnKbToKtADrmR/vOj7m7vaF2OJ/XsDuco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9640

Hi all,

with this RFC I would like to propose using the Linux kernel Runtime
Verification (RV) system [1] for runtime verification of Dovetail based
cokernels.

Running a system with RV monitors active should ensure that the system
behaves as described in the model. As this is checked at runtime we can
verify if the system is even behaving as inteded when it is running the
real workload.

My ultimate goal is not only to use it for verification but also for wakeup
latency tracing and decomposition in EVL by describing the whole wakeup
path. I am working on upstreaming dwell time measurements in the RV system
in parallel for that [2].

This would allow us not only to get a worst case latency and decomposition
for a latency evaluation tool like latmus but to get a worst case latency
for any load applied to the system (e.g. the real application of the user).

This patch set proposes three Dovetail monitors bundled in one container:

 * offstage checks that Linux leaves a task alone while it runs out-of-band. It
must neither schedule the task nor let it raise a signal on itself.

 * oob_trap checks that every out-of-band trap notification is unwound for the
same trap before the task goes out-of-band again.

 * oob_signal checks that a task receiving a signal out-of-band is kicked
in-band. Once the cokernel handled the notification, the task must not return
to user mode out-of-band without a mayday pending. I think his monitor found
a present bug in EVL: since "evl/sched: get rid of this_evl_rq_thread()"
evl_kick_thread() skips the mayday for a thread running out-of-band on a
remote CPU, so the thread ignores all signals, even SIGKILL.

For the monitors the series adds a few bare tracepoints to Dovetail. They are
not exposed in tracefs.

The monitors can be built by setting CONFIG_RV_DOVETAIL, which enables RV,
the monitors and the printk reactor. oob_signal is not available on 32-bit
arm yet, as the out-of-band syscall fast path there is written in assembly.

To execute them:

  # cd /sys/kernel/tracing/rv
  # echo printk > monitors/dovetail/reactors
  # echo 1 > monitors/dovetail/enable

Looking forward to your feedback, input and ideas on how to use and improve
this further.

Changes in v2:
 * call the dovetail_leave_inband tracepoint directly from
   dovetail_leave_inband() and drop its helper

Best,
Tobias

[1] https://docs.kernel.org/trace/rv/runtime-verification.html
[2] https://lore.kernel.org/linux-trace-kernel/20260827072400.45734-1-tobias.schaffner@siemens.com

Tobias Schaffner (7):
  dovetail: factor out the mayday check on return to user mode
  dovetail: trace stage switches
  rv: add dovetail container and offstage monitor
  dovetail: trace out-of-band trap notifications
  rv: add oob_trap monitor
  dovetail: trace signal notifications and out-of-band returns
  rv: add oob_signal monitor

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_dovetail.rst   | 124 +++++++++++++++
 include/linux/dovetail.h                      |  16 +-
 include/trace/events/dovetail.h               |  40 +++++
 kernel/Kconfig.dovetail                       |  14 ++
 kernel/dovetail.c                             |  30 +++-
 kernel/irq/pipeline.c                         |   4 +-
 kernel/sched/core.c                           |   3 +
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   4 +
 kernel/trace/rv/monitors/dovetail/Kconfig     |  13 ++
 kernel/trace/rv/monitors/dovetail/dovetail.c  |  41 +++++
 kernel/trace/rv/monitors/dovetail/dovetail.h  |   3 +
 kernel/trace/rv/monitors/offstage/Kconfig     |  15 ++
 kernel/trace/rv/monitors/offstage/offstage.c  | 114 ++++++++++++++
 kernel/trace/rv/monitors/offstage/offstage.h  |  61 ++++++++
 .../rv/monitors/offstage/offstage_trace.h     |  15 ++
 kernel/trace/rv/monitors/oob_signal/Kconfig   |  16 ++
 .../trace/rv/monitors/oob_signal/oob_signal.c | 114 ++++++++++++++
 .../trace/rv/monitors/oob_signal/oob_signal.h |  74 +++++++++
 .../rv/monitors/oob_signal/oob_signal_trace.h |  15 ++
 kernel/trace/rv/monitors/oob_trap/Kconfig     |  14 ++
 kernel/trace/rv/monitors/oob_trap/oob_trap.c  | 144 ++++++++++++++++++
 kernel/trace/rv/monitors/oob_trap/oob_trap.h  |  61 ++++++++
 .../rv/monitors/oob_trap/oob_trap_trace.h     |  19 +++
 kernel/trace/rv/rv_trace.h                    |   3 +
 tools/verification/models/offstage.dot        |  14 ++
 tools/verification/models/oob_signal.dot      |  23 +++
 tools/verification/models/oob_trap.dot        |  14 ++
 29 files changed, 1006 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_dovetail.rst
 create mode 100644 include/trace/events/dovetail.h
 create mode 100644 kernel/trace/rv/monitors/dovetail/Kconfig
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.c
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.h
 create mode 100644 kernel/trace/rv/monitors/offstage/Kconfig
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.c
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.h
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage_trace.h
 create mode 100644 kernel/trace/rv/monitors/oob_signal/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.c
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.h
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.c
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
 create mode 100644 tools/verification/models/offstage.dot
 create mode 100644 tools/verification/models/oob_signal.dot
 create mode 100644 tools/verification/models/oob_trap.dot


base-commit: a3ad77d7ba3eac8a73f64026272747c01dd84fc6
-- 
2.53.0

