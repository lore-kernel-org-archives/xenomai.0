Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B559B71
	for <xenomai@lists.linux.dev>; Mon,  3 Jun 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403511; cv=fail; b=Dl9foaFc+LweiSZWB7D8FOmIrQqRvXgQiUlTUW0cEBD4ra1OoxKub/PoW+0T/ILb7yMFroU1SZpuGiwc5WRr78Hkp+lt6otHYHgz5aNdyDCOxw4DtoO3g8qy9srNGo0/LV3r7qT1ik6SYDaaK34KXIhFOX+JBCkh1FzVlHEbKCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403511; c=relaxed/simple;
	bh=Lo7+7euhQgbKYjKMoabWfMBOd7XqS0S9WOi3Eb2n+rA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RGznFwe3cwHPDGXq4llwhizCG+0BnQbWFqWRw40G8VR1vc6Z7WXUC552M6Xdgm4dYHicKFjOiJpLIxCtHS5Og+0fuSeeoy8Dzwprq94u4+9Ss/6HAq0YIpBKcs+wIANpfACI2AL1VPKBQN2hGx0RYwcvtsa15Qk5jicT6G8XtIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SomSvG/9; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SomSvG/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqpnTX94n+WlkLwyXAtrTLIuS+k5GBJcexe/n+jCsgoQYYXQrMZkeR6Na5x2rDcqxBuPaD/si1YUcteJCAeDSTzd7qdhGPvB/7p81ODbj4ofu5MNishpZkQTU9/lnHWrm08MaYtshBRbSYgrB9v4VoQJnUoCgwebCKxoqKJmLoeQurIMOak126eU7lbVcwP9dZBXOaus5T4DonxHzopg3oivzfH/5vGT0F7AV0UXTAo/tgN9JvlsOP6+NeuyxPvOaMHKVwOn7W0NGJPULa/GbIqFvvEBoTU8qwdTUq3g0xrGF/t0NZM2xWnxUFP7RksmE+7CAweq7KWs00Q2rWkaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+cPorD8tRf2BXYtNXz4FnXhzV2qWnW+Qj3P4jBskd8=;
 b=BkuxOJCgYKb6fSGkVMHmENBqyNb1tOeXUr60RsU4Sy1Bp4wrnjYxfvdjfWmtuN6rPCI2NqK2aDxgybBrC0BTuDwBCvg9COxdagQHYaJrGZzuCWo30rsPuei+SE5eeSu1id/Tdq5gYyi+7x9MmtjtEXHOAKcAbjnhwX2ItjqQ0hAy7kjkXPwILwC1tGbqtrJF6WpzCtATN9W5kdtTZlmuT7e+LgM0gwUzo3Kv3L48mk9uQ+mrhqKgJzRLE36ogBvic4VoCMKqDx7aC9kLU1Qfpe5CMMtcLuOjptHqc3W6WCkcT56AQVhXkjMXbP24rPGeQDmeNvkxR+YlnxKEBzPjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+cPorD8tRf2BXYtNXz4FnXhzV2qWnW+Qj3P4jBskd8=;
 b=SomSvG/9xlwi/7D03Semha0J4QYYU16IHC7z1RvgIHyL9qhNNBBAY0nIlc2hO5aHjHzK89k7YVH+3AKjmzUmYS+pLwGLn//j8oMm3u3MkbBZArZC7Spcr7Zypu0WCOZdOzw3XkiBfIXOr19d/t6Hs0SXg1wlmUZTkOEYt0rOQUaaSJ3N13T8xtiBD4YuSslT0Bp+ouX8OfIrc+V2Bdy9eQoHS/GDVtpvrgdn9itloVpJ5SG7AJwya0yHuH9iG9ogguZkfigFtpXzaFai6ZUqMfh7oTznMxtNNL8DJoDEnZGMdrmq2e274od/tDRCgYfYJYgHHWYQe6vUSETYNNlwHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV1PR10MB8591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 08:31:45 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:31:45 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] README: Fix links to documentation and tarballs
Date: Mon,  3 Jun 2024 10:31:36 +0200
Message-Id: <20240603083136.1691504-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV1PR10MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6bcc6d-5670-416d-3937-08dc83a79a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNw09Ot7Pa17BRmhN8KS34IK5pww3YWvUy+Jv2se5MR0idh6ebfeVYmY09+/?=
 =?us-ascii?Q?/BoXEP7WcvdmhpxPMlBThXYToGUc6DYaYx6OCcYWueNlFDlGy9cwCLJbgcDg?=
 =?us-ascii?Q?wYo7bOc44N6knBhgnACZPFBdP195XrklbjP7Oa0B6KgFcRKHarVVAFuuTsZn?=
 =?us-ascii?Q?CZMQgyNmAYBM4/wOZBxfQWlVxwjWLcF+JNPNu9u5AJMzcCfMDsU/qw8eOw3q?=
 =?us-ascii?Q?fHAZmzhKQpxsPepS3pTLsHI3BkblfXT9H49L0z4BjFbssJ7tD6PSwjaN9YHs?=
 =?us-ascii?Q?Xeo14uakyT4c4zRFfhlbEAMEBe1Oo2xoV03uMvTzIBFFmAkrIXOp3fYEGqZd?=
 =?us-ascii?Q?rTzWOkierOaUMsvg7g60ikD9KEmcSCHPAmHB0tbIs9MT3JaiBbIuRiemsxAW?=
 =?us-ascii?Q?dcQJpovV2P2OmqncsvsqOWD6ObhFtx2u2cl8f0fiJ9RyCjT+usL3ik6PIjjm?=
 =?us-ascii?Q?lTQNdPGOSSh7nPIQujbch2UKLIm9F4hM745v7uiqOobFQ7FS3GtpBd0dP0aF?=
 =?us-ascii?Q?lh2AACsCA4TIO4ydfCorFUt/YQq2P+0930e2p7d0Ne611Gu0J5mzhpGm+k1j?=
 =?us-ascii?Q?0wgJGDiQeC1U6+ysFDgn0f3wvJDJPF+ZR2SutzlAOBa68X+reot6DiSmQ1xZ?=
 =?us-ascii?Q?+VLqbdGUUdzAdfL6m7HkznGhXnfBR8ngNooYmwhlg5HiN1zW2N+qN7R84unE?=
 =?us-ascii?Q?QQMV3SwcMAIlCLjouh/Oep85cMKMfDIQEwtaLOT/J2gjX9izu4FWgbOfgVPd?=
 =?us-ascii?Q?VWozan52RTk8LWIFgG4Ql5/jRDqJVZ1nEmFTKEQOem7TiCMSxj1uzoOzBqBp?=
 =?us-ascii?Q?Bizc5SCL/QF3LSGBumRppUUNawHk9UTbOlhxfsBahnDTutRWsY8tmydfwZm/?=
 =?us-ascii?Q?Au39YIuDt2WezSMek8q6wzsfdxrpVRbgUurZvFQqAjX1OMzR9ZdOk3sm6r++?=
 =?us-ascii?Q?30oWQkh9xty9KIF3J5h7YA6TELgCdMZbEgtJ9LDijoRywthSpvEVd6nGGIln?=
 =?us-ascii?Q?b07QBp4sHsGu31EK05/htIEj1+SkIPVFvcmju0fDDQegQ49gVYkdf1y0roc2?=
 =?us-ascii?Q?1O0fWDu6lad9VJH8QHwZ+A6fIyIVJWTGVsMLpz5SgcsjftutSEAFSf5q/sJz?=
 =?us-ascii?Q?Abn8lC9Xh8yuSeYDWmb1+846BcU7hNfLeltyf8zGJHkLhsflvp0qVmEJmUoV?=
 =?us-ascii?Q?wLlKWT78PViHyRfLExSb/SatS61+jlKEh+IKEJhXMMfpxjw08UK8YXD1m50?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HN2rvtwaDg4fVm3LLgxY8STW9samJXFmwVLCMyViME/bwOSKcqJ/TPF260/?=
 =?us-ascii?Q?SWJEPGvNgoBurxS0Z5X0q0w/VpzQlunOSu2cro2YYkrwlHju3PAo0eN/LJMP?=
 =?us-ascii?Q?EZGFVArLWZNk2j1W+eI5jPdyVVl9W/wKvuu5iSsgbtFYMS5fUaSbARFd5E62?=
 =?us-ascii?Q?6xG7TfOYuLEGYAz/0fIKvVrSsfw1S+A9npYZkTl6o9gHMAcfuZCPVoIZ6tHW?=
 =?us-ascii?Q?9QiFi2vph1WwOE6r5LjVeKaNQSdElFxgE3eXai7xmXgah/lFC3ny8Qw5wM0R?=
 =?us-ascii?Q?qqEMTIbiZI88vaZC67D12wQ6446DhKi3GzJmh7e+8B6qD4RG0gD0Ha9Tl6kT?=
 =?us-ascii?Q?kPhu7znG4lqmAK1r9Wy0KShbWBPFvWh1AzqTIoql1MWomzuPu515MWR2+4ME?=
 =?us-ascii?Q?FNJxV1V7lKk70iGgPDCLzionDxxaXWcCfMmYulnvXoLP6wi0zvP9RsuyoMoq?=
 =?us-ascii?Q?R8swILHCAkSONC0/Ov26fDy1KjrkdLQdEuhP62Revgj/ne/dmx67fN5+KBZk?=
 =?us-ascii?Q?ZvyhACR8U7BqzHQwKC6JvrGL7yiCyb46XuZ1Yblv/BqxXkg2SZjdSIMPoMNq?=
 =?us-ascii?Q?ZYLp2Zsy5Q1KSPErukb1GFOKGBmxEKmqbqnEZlzytHQHUiyGyI1tSDEn/Chw?=
 =?us-ascii?Q?zJNBDB6JjoXgCQnVILFINYG/mXCVKTunFYJOjSMROSFYDXiURydwbNYdK9c7?=
 =?us-ascii?Q?azKIzHJz9xvYQQBjz5GXL6B65wb+FCWGcq0obVanSVUdcbeQGOT1V6Ej3Imp?=
 =?us-ascii?Q?hIYYq++hkslrKWtRyS2F9u5KoD6yQzvVz1Ezf55Kf1Sd/vUri7uJ+1eBr6uX?=
 =?us-ascii?Q?ZiqQWKZAwuXQwlWTz5FwS8kc/s68x9PjbtrE8hf7liyH/c8x1vWXenHajcXp?=
 =?us-ascii?Q?FjHg9CnXmyX0OCk7ROl9ZcXlD4E26zheJWKJotRkWK7M1KL/RV2j62LzitnK?=
 =?us-ascii?Q?vX2PnX6e4I3OXm3xt7NO7dSeV0VecajOkEtsbf6dNfxqLn4XRhRu+CLTVxcA?=
 =?us-ascii?Q?BZfvU2/r3ulwV9bLLUI312EfXEzHoBcyclqSFml6jnWW5ejvf8VBRSRj2ax7?=
 =?us-ascii?Q?d0zIDF81JJqqmYBQELdi9mIQagm1Ye/8NXZyJmslISOETnfd19you0SiCNog?=
 =?us-ascii?Q?1HHYgn94CayMSgTORWSIm1er/ckk2lWWXWWqe53QJNE9aWSagfQc+rcB4KFY?=
 =?us-ascii?Q?ltSu1lbSLYyNx59im6iyedSebvkGm9TimqTgj3Eunds8qQ9xH+xfhw4ZjjcW?=
 =?us-ascii?Q?bLWRm/V+Ji26Caw+46Ie3cBeR0TDbTG116JUe68y5Om9YgTl8U5syGoFu0NY?=
 =?us-ascii?Q?eMgAWtWilqC6dcFtxzw4YEeOt1PXsuo+n6g63+6v5Rj6YJ7Wary2EQ/NmtOm?=
 =?us-ascii?Q?8l5bGvz5sfDK5PgUD8eMzxWiS6neiR7NRXsyIsT7e8vM5iVcaeIAplGsK3DD?=
 =?us-ascii?Q?LQLzLPUI4ZvoygedtW7FDnXE9w4W6wJveELK4LG5Ert0WmFDEztocSAaaiY4?=
 =?us-ascii?Q?vg51w7z6MXOiuoGvLpDuGmZ3XhtMiZjlWQwIiOKzCjwHwUCRRexLGsOru8L4?=
 =?us-ascii?Q?27Od/4NJzA+EwaFmvi0m9a1r+FxCKHzaXg1kLlmYNa9rjteeKWtK+AohD4N3?=
 =?us-ascii?Q?mOFF8vEY2gqF7XddfgE7V4isrcSeynreJJR6RmtnjUou8N07x80flrjolYb7?=
 =?us-ascii?Q?Oesoqw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6bcc6d-5670-416d-3937-08dc83a79a67
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:31:45.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymP7WZIv1y/jXLKkNYUqBkLbvcL+ZTdcXxCIIigeOo72PDvBPjdZlGbrvVton7zYCr5n4jqANfvtmIoRPJT/kUt/l1VWX37b5NwXKhI6ZRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8591

The links in the README were outdated. Point users to the new v3
subdomain. Only point to the essential entry point and leave it to the
website to guide to installation, troubleshooting, etc.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 README | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/README b/README
index d7241a179..90a6e107e 100644
--- a/README
+++ b/README
@@ -2,7 +2,7 @@
 Where to start from?
 ====================
 
-http://xenomai.org/start-here/ is the best place to start learning
+https://v3.xenomai.org/overview/ is the best place to start learning
 about Xenomai 3.
 
 Also, make sure to read the per-architecture README files, i.e.:
@@ -24,13 +24,11 @@ Online documentation
 The online version of the documentation is available from our website
 for the current release:
 
-http://xenomai.org/installing-xenomai-3-x/
-http://xenomai.org/building-applications-with-xenomai-3-x/
-http://xenomai.org/running-applications-with-xenomai-3-x/
-http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
-http://xenomai.org/documentation/xenomai-3/html/xeno3prm/index.html
-http://xenomai.org/troubleshooting-a-dual-kernel-configuration/
-http://xenomai.org/troubleshooting-a-single-kernel-configuration/
+https://v3.xenomai.org/
+https://doc.xenomai.org/
+
+If you want to migrate from Xenomai 2 see:
+https://v3.xenomai.org/legacy/migrating-to-xenomai3/
 
 Building from sources
 =====================
@@ -41,8 +39,7 @@ http://xenomai.org/installing-xenomai-3-x/
 - GIT clone:
 
   git://git.xenomai.org/xenomai-3.git
-  http://git.xenomai.org/xenomai-3.git
-  http://git.xenomai.org/xenomai-3.git
+  https://git.xenomai.org/xenomai-3.git
 
   Once the repository is cloned, make sure to bootstrap the autoconf
   system in the top-level directory by running scripts/bootstrap.  In
@@ -56,7 +53,7 @@ http://xenomai.org/installing-xenomai-3-x/
 
 - Tarballs:
 
-  http://xenomai.org/downloads/xenomai/
+  https://ftp.denx.de/pub/xenomai/
 
   Source tarballs are self-contained and ready for building.
 
-- 
2.40.1

