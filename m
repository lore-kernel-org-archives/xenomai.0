Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C9345CAB
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041446; cv=fail; b=bdOv1dYIrPF82qHCsgZHkgha0ejg/zlFdD/LbvyZgw21oWp1XJqMtb+tZkoWsEJwjN0rF4eoA/i/IhpNWebAtLYKzm+WfI9RwH1z2sWk3zjB0T00jeXmyWH6qhrmgV3RcK5uVwjD4tiId1VfbBlwKYlGlCoATX0NwddjlFUWfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041446; c=relaxed/simple;
	bh=rAHgYoMZgrTIcx45xOKtzdp6+5zLvuO++vq2RBI0Y5g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gsNpYCWkbqTypeKODiap7PoC+x16ErXuAdOv1vAf3pHQ4ZTYLjRPe/dMUNkD2KYQMfs2/yv4IPG92NL71Hl0e6XulqJbpyjsi2mfdoKc+mbxXh3d7t6eLRxTlfVdLJJ6cfMl0n1r5JJq92Unj0fvLFItqIHrRasVlLZcke7lWdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=0GD2NtY/; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="0GD2NtY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPdHJMRR6K31y19TYbWeRMZjuDSKwXDP8tuiU9N7OarkltBTy5jAERYz6MkJCgmIceGEMmiAasU6x+UlnI1iJAms9243NJ0BNukBBh7jrvyzesrgrUmgteK7Twnp9DTseLqzwOHJvRJmcj2PGOSMp7Yz77G53nh6O4hBreSnzfvKL6bQ5peqFeLxPmiI3xgguZOQHwzX3nMHu7nj0gNq81WJobCpFgrkx8Bw3KdvQzTylH+ijlW68Y357ASYGh4lwVSYowzW5yoF1qcTpWktG26HyclyQtTeDDAMzgoZneFHBx+C+9kM17oosknbEL+SL7ZuatyQuTkNtnbkxF9+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXzeIK9EV7Fe3Ua9MH7plkT3Y9yBydmfVM//vSrGoXg=;
 b=xR3f8l0o1TFIg1SYTcf6gY+OwQIldHG/lmemoUhSRPro1tD//RcATLmWRD+iBYbjiru+Ngok1lQDdUseQyQIzD4GZfmR4VAYpA/g9JeXD5kNAe/VEyxTvLrUT57NMg8pmyDz4jyA13TvnCnblVtSTL0nRXOLpZgzMYZYsoZUS9EkORIYoCeZkD+Ld90Y/tj1sjUHW+91Sd/U2lrtArVZBoqhwGD8cCFr1llfmSseUZHqEtAlmuarlGuYLVKa8ZC5bnT94krT/FfgCRBNsoXPQrXW3/l/SP3vbRciGIXIYhl8Rs+p0KEJeLgPCKVNmJqgblnXjWc7qUMDhch0p+Q5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXzeIK9EV7Fe3Ua9MH7plkT3Y9yBydmfVM//vSrGoXg=;
 b=0GD2NtY/QxY6XimqMecZlPTYK6Vgczj0htMLKDmAFkGqysmRB+kD8rjMUzVHdFndiJuAuxxBAqs3Wqxgm95IMndfo450VaW95rNL0zca+vb9AI+QvkpN1AkSRfiupHwhpwS/nttuJk6QmSkT7Zp2q6KPaVZujWrhXeCl9y+Zow/BNjlhXUUL7JZMFJFd26kez2xr9RPRhkUdotcoLgFu5+PNLZcOIAwdI3hs5be74IFdfo4f3j5zflUtdSuqrhMUIzwXhqq3TSBJ2ynlkgmXsYOD26Gm563JfyiVQdk2p6dU1e4q1DZcTvfI5pOVJXtmeHbG7aXseh8LOadTPjTnkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 21:17:21 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:17:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl] evl/latmus: fix spurious overrun on first measurement sample
Date: Fri, 20 Mar 2026 22:17:13 +0100
Message-ID: <20260320211713.2150855-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 615c7cd1-2993-4508-7936-08de86c612d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7SNFsc6Z5sVvUXnqA8j4Tkr16DY4I9LeuMRWxrhZ9m+DpZ84BY8q7WQhNCtmmUmVQpRMz5+1kxPkhR+g7ynRa87wJcSPGRh3m6wT17KNG1fCqoJWcRZ7TA44yTh3/by/PYyImro6dirzBESc+MsDB/kJ5oCWZ2BUjsp0uK0ZT9c1znYSopSQVLEnDBRZXgQklL0n5M2G6/ax+QAUTqL6ZhG+1RlF+/baEMVu0iYtCeIoFMg4xNEbbROelnycBQr/F4dSBPLHeFjePbENuVIulkQf6vTD/qtIrUeZ/lzicaBkYiQFFpPaFvsolkXTJ71WNXiF3z52GQ6Z+ghAEAT4OSbGHTdh9S5gTbB4okJC8786rVE7mwRaAeDuy45FUFagpv5CbjKUqYPdT/SndRui++y5FvwQU4EpNsmVBE/eUxEhlbMz/moN70lDVkP94PuobOWp7Q2NzqzJpFJqSUSi1kNkcf0rq1q3MAL6OD/X5XOzMOokY4Gboou2uAdSkLB43XnaU0VrNQRh0gs2ovnI206Gqgz4TDgemHjdXfiKQSFxeJ0IYjQ+CvI8kqS9IYZnjHU668JTxKOKjjOMD1kYDU0zeDBLtkM9XK+R3w9wRlavgisxcq2fBebgQRh+VuRrECzazTZYIIf1UwkYs1VQZZ2HquHsAvEFjBcmnfuRuIdVmSJpoUl+B0Tcky3qheW1MhtdsDgxo9u8RvxC72yqkEEtSpO7FRK4g7+0Eszo8/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Er2Bhjx6jMNnM5XiYRA667jA2yBkUBWWYO4iS523vatfaJLeChkvxUteQO7Q?=
 =?us-ascii?Q?9FNeCJIPyhaAiX6uEaBTwI382yfleeph5r12kXzh1tO5KJIb8jfGZSCeUOqY?=
 =?us-ascii?Q?24QMXOjEtm/wM/Li2erit5X/CAsx4q8dIwgmUuETZx8Yc2cbnBR7+7mo5Kg+?=
 =?us-ascii?Q?KdLXJRZ/YcN3rKYr4xWyJ3/Q5SEiofe3ofBFIO95G7Cytp8nSDCCrephlJLO?=
 =?us-ascii?Q?9NZ5pHamK1YZ02bGHoLIZ4dfYHEGsWemlkP7q8G62GnEyx8m0zCtq9WoN+mG?=
 =?us-ascii?Q?GqT7wygeEuDorvM4PZ3VaBOU+scrUdclUH9vKoIoKZydXOXtyidRT7EohxpU?=
 =?us-ascii?Q?bh+v2fDMXznhOBFghcbGZu426j7/p+MM+En+burnSS81qNJbqwku22OcnZCO?=
 =?us-ascii?Q?LyCSGa59czFmU+8mfxV13AtqIb+ej5B6f9+d43oM5Cj0CA9N2vMDPojIevas?=
 =?us-ascii?Q?nc89OL+d79udwvys4NLNheGIART/FCd4VwYYjbdDIkpaKbMo7yHwGz1Pbe0f?=
 =?us-ascii?Q?ndtJUN2VwfE0z1QozDxuquemXLqOqgdGad71XkP3CFfcvNj5FYycBu0azFNx?=
 =?us-ascii?Q?Azi97hyQdW7fVJdUwwu6RCAIvLZhNjSya27YxaT5G/84+0LB+ju6TSRLbOqu?=
 =?us-ascii?Q?mx3UWTOrwSGIOdOY7E26GsAqUQP1TYd48qTSzCX1GYqpen9mXDogIW1XMsWz?=
 =?us-ascii?Q?WW/LKeAqwDS8ilnKkT7PdC1d0nrWFebVgIEhzDIPNiwhOHOFLZhLxlK8dZyu?=
 =?us-ascii?Q?NR1FnB+WY7fNZrDrR7STvg/Wv+aBd+3UKFDXpVBF2u5vlXl0+qS0huHFmb4i?=
 =?us-ascii?Q?iRw4Bi+dXRnc0It954SYl1FDgXmmiv76knGZAsoluaQ6UoZrWhdkEVKYqQDY?=
 =?us-ascii?Q?JVyk0s2rKgAL5Us44DkJm9kWAwc1g6UDNN1R+5w0TGxm3wWJp5emyO+X71ii?=
 =?us-ascii?Q?uB6YlIJCJN+H3Bo3UZCD635lp14Wj1xKVXzKu1BMzTblPpyk0IUs9y9GWoyH?=
 =?us-ascii?Q?mynGK2vTxmbLqhFVhnXd/PUZprBzy7g04SdNRAqu0Eg5jhuUB+x7Q+JyXLEu?=
 =?us-ascii?Q?CrhNdhouGrgw6WNeZv37aVxzbxCr9k6NUDs/b+fGSYRG0XJ7Kd7NRKTr4Thx?=
 =?us-ascii?Q?X9bKuHiN+VbW8NgnIuM7MlOCzTDbpKp0qK8gNl/jYjqIL1+tjVbeABAfc8rH?=
 =?us-ascii?Q?yDcTS25btoIbca4d7sGj6Pk42dVxYZmroalNTouihFrrzA4BPs2wBGjJtgdH?=
 =?us-ascii?Q?xuil1+/f8eJQmlorh4Ur5My0KOCAH2/JmC25Erx1y8Qn6DuG8Q80ljEl+H44?=
 =?us-ascii?Q?JQrXAtgwn1cEVqxasbNhaLtGE0GiUa+ejywchl4gYOye/Bf9wnQqUw7jQV+x?=
 =?us-ascii?Q?iv2lPgXQ5GNr1+mdysUJ7MWchnifUGcMebdXcng+MREUn1cdbVf7lvL84JaA?=
 =?us-ascii?Q?uQ0sM6tKHZYx7YdajlfD1hZrx011D9c4afvPoY9CbFw1ot0iXQ0STlI+YRpJ?=
 =?us-ascii?Q?+hCXfUuaMOEoF3a/jap5CXuhwwhFxW6D1uWrrQuLE3xPOBmb+VqN6TgnRhW2?=
 =?us-ascii?Q?ykyh1Hrj3TdrMJkfvHSrCmgP/kB2pMC+yXdQV3BLpwqKQDMXnnAJ6gv1g78/?=
 =?us-ascii?Q?ox7NCcJewqLX2NsBp9fvXOavqxQvkW4ZP065MoDK0Oj1xih/ukNZm5G5C/WO?=
 =?us-ascii?Q?nQ0JzvITb9xNIUJJ2GDLBZVMWNOPx46Iafu8k580UWDDmjaT8W92xNw1h81x?=
 =?us-ascii?Q?Cixtjt9pokauWbF8mp4ZgvIOOZk3unc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615c7cd1-2993-4508-7936-08de86c612d9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:17:21.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xzogqA/5RWGADuXKtzIT2iFNCKjkZqQwxbSqHZhhw3MMXxTMqJxb8HaPBaqE6N3InYIqNrEKhOmXOBJgaMj1zh/SVLTf52EOWXQLwMy+20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7432

This delta is not fixed up during the warmup phase leading to spourious
overruns in the first measurement sample.

Also apply the fixup in the warmup phase.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/evl/latmus.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/evl/latmus.c b/drivers/evl/latmus.c
index 9a0295044443..9c581d80db68 100644
--- a/drivers/evl/latmus.c
+++ b/drivers/evl/latmus.c
@@ -166,14 +166,23 @@ static int add_measurement_sample(struct latmus_runner *runner,
 	ktime_t period = runner->period;
 	int delta, cell, offset_delta;
 
+	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
+	state->ideal = ktime_add(state->ideal, period);
+
+	while (delta > 0 &&
+		(unsigned int)delta > ktime_to_ns(period)) { /* period > 0 */
+		if (runner->warmup_samples >= runner->warmup_limit)
+			state->overruns++;
+		state->ideal = ktime_add(state->ideal, period);
+		delta -= ktime_to_ns(period);
+	}
+
 	/* Skip samples in warmup time. */
 	if (runner->warmup_samples < runner->warmup_limit) {
 		runner->warmup_samples++;
-		state->ideal = ktime_add(state->ideal, period);
 		return 0;
 	}
 
-	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
 	offset_delta = delta - state->offset;
 	if (offset_delta < state->min_lat)
 		state->min_lat = offset_delta;
@@ -193,14 +202,6 @@ static int add_measurement_sample(struct latmus_runner *runner,
 	}
 
 	state->sum += offset_delta;
-	state->ideal = ktime_add(state->ideal, period);
-
-	while (delta > 0 &&
-		(unsigned int)delta > ktime_to_ns(period)) { /* period > 0 */
-		state->overruns++;
-		state->ideal = ktime_add(state->ideal, period);
-		delta -= ktime_to_ns(period);
-	}
 
 	if (++state->cur_samples >= state->max_samples)
 		send_measurement(runner);
-- 
2.43.0

