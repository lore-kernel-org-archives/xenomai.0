Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041A4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ0nRtho6QmqJcEEdXOrVRbm4xnDYWN8XC+uV3MYZjzoe+Bd4uY6EhdTAL694RjEpNmB+eJ6roNqZ0zBohUkzn+pfr3f0/kveYp7GdFQvyFLEQLpQFPnfx8mI/eH43NpCUlQwoGZLiFDYQDx+2YW5BovRjEz/bmvMn28RVRTFFlwMEzhNF/HpaLGMzWwMtb5bP3hyc7jmSavssUmWiPCmvGNRIFVzff3P1dXxJdqcEBobDhSPQQrBpxnvcxkqmyPu0OiPea59GJXMbfNzgEHzjvmaAZPPWUivE3jqd6lC/DowLHn+PrNO4oddyNAEvuBGd2T+Wux0ag+sfJya1t+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQAo9L0NjcWoZwFGky84je6n+kgUT9jgswrvV4d9CeA=;
 b=lWgiy2wmX3z22QCymE2HXqYBd2GfVbsg1De3yg4JALn5botGiS4ddSpK3FaNt9UjduIU4m9T37Z7jprL0tAuUlrr09hBtyRclG1K85csj/CHiUF0ueYNPoKgBcLaWOpNeZp80+h3nDYtTh5Zu2FQbE/etYx9OSazFO65YQ8/El+UYuBXTpzigqbPmBGH4sVZx4GK4CSiH9nAqPeubyEjXUkPZDj+wVy7313FfYLKo/R628b6KuH3+IKtibBF8CayCOa/kzQqVtXDF46I1BdzgoM9a8cn4jj68IJVNOny/Or0WDNaYJEKAymha/6pxsxVKYRJ+yX0YGDWzBNk3oud0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQAo9L0NjcWoZwFGky84je6n+kgUT9jgswrvV4d9CeA=;
 b=O9DRsjXmZrjGnhUAWvhVM0jRrPXH8jRh4eRP6nlPSjapq2ab+mpf38CgswRPOyeAS6jaJF2bdWOaKjzciG94ngdqIfYAVBmAZz63GLz665aL2goc+xcUIiIRB83TlbB2lWC4hL5FIGOMvVu0rFcSN2cl/Xvk2T5nH1VZYl4wsY1IEVJKf4R38GoCY1z8IsHwC9SS5jv/wx8N/7/f5Xgw2env1b1QwXlv5cKMEkv6h96KpLFH6YHLnCjl46V6CWjCcg9z7e+LFm1yaDqqEir17fqZTp9cW3pv2GGpIuAuRN167jzyaR+dGeUKT0a2KKraKl8FM1vW5UEk81AdbMwzxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:44:00 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:00 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 12/42] y2038: cobalt: Cleanup code style of time.{c,h}
Date: Tue,  9 Aug 2022 15:42:56 +0200
Message-Id: <20220809134326.23688-13-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06da9cf-02b0-411e-09d4-08da7a0d3729
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ydhkrPPEcKv0TuX0UlLlL/ffmCtkBaN/+WbguKmEDRITYdZ0oybCaS+5UwnUYJZPPAU4DdK7KvpsTk6gtjEcxyrrSZ1AWfFB2gSMkj34YVISCRK4TQ6PNMgUUYKN/rubPWHms64DXaRF4lHsQK//BsbF/oMziv0krvGeWXGo+HKOTr4djsZJmSFnvl6hx8zWOixZzo1v58SZdMfTw5+vorJT7XiZtezdzBRVNnIydEe+kR0QONsuo00X1gM7JAg8mmAGco4gT2NId7bdSDf4UYlDGoF99oDDA6igLbOUjy3OPQnhoorBEYgJe+J5m+kRd3FLsI4ZUEKiojri7IKOsLSSOonYu48WP/IGSCKZkjTTPz081J+Y7YFytvMVbOoPJ5H0Iy+ihuYZ8egzuqcYvU2Ce+TEIYgxBUsVRM9GXzno4PMYaRfSwLjDcoXV+DFu+g1CG+BaFuMO9cHMno6QFLq2NkVRXdCRYU99da34H5JTw3xRc13sBJCrZ/7QG8U2DJFtMB+xGZojS/JpZmnT+YemAg3FU4ClVmp1kJRn3GtPz25HoRMH1IgWQGTsgI3qYWW/MwsPadoek7U+dM7oXCtTGy5qKjwhQKpcTLbUEwS8drhKd0PQRRry2Dq6MuPnZ+ic7tvBUO0Hj8NI0QuZhqzW79mAGQ7w6ThIetDwWVnbwZKMTxfzXmlbeh0a4CiX+iXopOiijfePUmbwSJ6znHPlP+mI3vmTIfvPyphkHTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYeu6DXWWvTUsgyHiTc95gSGdUlFlrxnsoUYejIQbkEp4G44tVw31gxFyOv6?=
 =?us-ascii?Q?ky/3ENLw/oaMUPcCLWghOV1ZOGglWS9F9fjfa6uxDxoRMaWfZxI4986CnI2y?=
 =?us-ascii?Q?sDd4+Az1tSGXRJ0nJrDnS5pexk95KgRuoTiHYN2LBzdW+BT2w5KKlNu1MHRj?=
 =?us-ascii?Q?jzfXD3t6BWsQ7xPo5Kskxge6427JexnYKD1lsT/8GTIuHGxGXuu0O40Tme0H?=
 =?us-ascii?Q?rliHXQGeuWqI+M4uJJG3oZ+u71gXIdghqCyLXGaCtjgtZLesx1TU2uj6OxqH?=
 =?us-ascii?Q?Sfz4kdacJ9aQTXkYDUnE5vbcQPU4A2/h0xOPn7/reVbQemObzWTbbmAyWo9z?=
 =?us-ascii?Q?Oyqs07/xqbdtotUQdz9xT0FpMsBFBTqqDqFwK9qyEJKz1Rv75L/rM6hWaKKV?=
 =?us-ascii?Q?jtU7gjkb/zBij9oUYX2iVNKTzgBcJw95b3CQ+MRk8BitW2YZddJ3LOMjCe7q?=
 =?us-ascii?Q?wkJj3ho9y0LJthbg0IQcLNjHR26pVlY6YwVQvIW2tOG4nMtyQGmuVbKVj1qf?=
 =?us-ascii?Q?BLNY238138qDWr858TxGa/LMv3z3xYmxXxTo4j6ppNp/i3y0vbwOW2V8pYOP?=
 =?us-ascii?Q?cz/uGvI1DkQr3wEz0qWI2SSxuV+54qLY/8xX6Jz4LX21PZiZeA1Kt+NDr2Ss?=
 =?us-ascii?Q?SfGEBCxht+fvqF/81HRohjzm+zeUCY7nUlYVH/dOCpNd0AdFXfwDg1Ob5dfB?=
 =?us-ascii?Q?WvfmT+fXYTwQlfIl6f7XPrZ/s9vnfp8mpxolFOReUEq0W5BI3kFf/BrUujR7?=
 =?us-ascii?Q?T7LQyU5vAZ+jhR43cThHJRj5aW8YUkYaEPKavNWgVLA9neJknILnrVb8BINM?=
 =?us-ascii?Q?dnsnSeb5t8L2MYyDtm1R/El60CaeLNgZqVpZ1okPV6TlV1dwBRJzvEpoHZtY?=
 =?us-ascii?Q?QOVfl1SZ3T+fVoD8nq+eQbIG1RAP9DlX4i+T48HiQKnk+5ynttE+nM2ixarr?=
 =?us-ascii?Q?HsEGBpamtF0RusDi1w94nopFaFH27tkNjezLW/R1uVeB28DORogb+vklNp/T?=
 =?us-ascii?Q?rltTes/k7mxtVIkoMfT5TTyIWvHjdDVOUtzlQMIi2l2rc/S9CaTSaxMM6/uV?=
 =?us-ascii?Q?IdT2O9oAhraBhIZwwgTIT5fN+Z/xMB1f9RW/4d5+OW7TX0f7EwGBSwWH2P8c?=
 =?us-ascii?Q?WIH7UxwHyWpq+ZHENiTS1BpWurTtvzpMiubhngP6yVjsFlkhTRTzh6JFIWA+?=
 =?us-ascii?Q?q+UX7kA26fBrYkN72aD/wPmU3IpE7qGf9lNc8nzskMpV8k/v2/Lf2iTNgkuQ?=
 =?us-ascii?Q?m64/SUyJCP3Y9rHRkNIPx7cbmfQLuCnq7TgXYr4OPrWpbP7a+64ocUeR41Iu?=
 =?us-ascii?Q?S4s7P7+NJhrk7BeSrah3kjqLP2nQjqC49q42sHg4RqgUQKP58HzpHLqqD5nC?=
 =?us-ascii?Q?wnC6QqyXWtgmnd8jsoxPseXIjgGaK+o6a81FFYxX7mwsS/58qM0dAmXl47dY?=
 =?us-ascii?Q?NjSz4Zoy5bcFDSC4c3jmAl2natuinXwviwn7+4X3nkdCggDe5QLg5G0h5KZV?=
 =?us-ascii?Q?9unA8+4DgR1WQOeB7ONex9eDmrKGf5B3CW/FPt3KksTt4FQRnZdMXoR8nHkW?=
 =?us-ascii?Q?tzcT1hSm8pZPQkaJpowo/UfWAnuFoj51AzxzFZg9Um5JeGKFk0rIAQ2OI5Qn?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06da9cf-02b0-411e-09d4-08da7a0d3729
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:00.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QB7I/O5fTpRwaSMdjFvr1Ws1AFBBSRiJi4pmOSZNrHRAOiNwp2WxGlOZEPTQoVtKOhafGSaSD89ce9+mZCacwF2AQD/b0ilVAflYZfZZDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

No functional changes. Fixing some code style issues.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/time.h | 2 +-
 kernel/cobalt/time.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
index e48022f87..a55398068 100644
--- a/include/cobalt/kernel/time.h
+++ b/include/cobalt/kernel/time.h
@@ -26,6 +26,6 @@ int cobalt_get_timespec64(struct timespec64 *ts,
  * @return 0 on success, -EFAULT otherwise
  */
 int cobalt_put_timespec64(const struct timespec64 *ts,
-			   struct __kernel_timespec __user *uts);
+			  struct __kernel_timespec __user *uts);
 
 #endif //_COBALT_KERNEL_TIME_H
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index cb152fc7a..27dbf8290 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -27,11 +27,11 @@ int cobalt_get_timespec64(struct timespec64 *ts,
 }
 
 int cobalt_put_timespec64(const struct timespec64 *ts,
-		   struct __kernel_timespec __user *uts)
+			  struct __kernel_timespec __user *uts)
 {
 	struct __kernel_timespec kts = {
 		.tv_sec = ts->tv_sec,
-		.tv_nsec = ts->tv_nsec
+		.tv_nsec = ts->tv_nsec,
 	};
 
 	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
-- 
2.37.1

