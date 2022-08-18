Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B523C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tiyd0Lb+pvIGe78knx4WSf/iMpTu1k3Lw77R7JakSZNupKn0UgDYMOxY7Oiv+Jic0KWK4XZ5GW7R2QmrFtRpqfXs1KQ3UZ1G7ENOudvq08GMqJfTwunxyVIH7PSnyw+vTobPzPyRL8NY+VSucgL1CTKdNUNFVi6AfhNnor5+c0G3o42cbMrc+qHY8UsXjkcgjTbDIwuPMWCVQTy8lfiXiRt5pF50K40jTSja1+7/Z9wtV/EfPO6g+BZ1H+wglX9hXxBy+eK7n5ONvrGeXvhn6hlyreAS70RVhFJEB9MhctZaxTHcbHPJmP0GqC6Xvy1rmo34b66ef4HXlQi74DcOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUCZ8KGjS7EF2jY0KWhOtry8lejGpXtb+uqo5CuYFNQ=;
 b=eSqpYM85enK8k4l/8z+LWWe5UKpRtbAs8ZguKBxEkkqThcpVZZl4vY0jDN1D6D4j2qFcjN0Mvm7eVMRrBMSB2EFuUHaUC35qIH/tnKUmx2G9GaLsItdPLG3Lwtaepl68P0PgnW38+3nrTVZ4h5Y8Ng4sCNi9PQwUIeYOnlHt2n1zgaImv3E/XL00c1uumZpq66dW2hhnEMVuOnIHFab3TlRKSFdEufCxTBA9lYEB3IPdeHaX9UJS/rnqpNdSjwO/9E4aiCjDG5eSaDNCVE9U3NvUd3yI5z2ylNfcSZTIvTIXCNcH7R3oiZvGt2Nm1sPOSgjt1edrDeClpMrFRIppug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUCZ8KGjS7EF2jY0KWhOtry8lejGpXtb+uqo5CuYFNQ=;
 b=BreQxm4yyzirwC7DEKBq8lUoYli3SZ3M7X7RnnYYRCpFN7U4NsOZFkPSGf2MmWmU0DkXp2PCTHxxWIoBsuTW1Lezcuy+G9ziLw6Gz5hBvQJZEEzJRSZ74LPcJUgpSH+mpX6txYsPi08KttbgGw28cqafGoqtEC6sM0vB3NeHGzIwKnHHjNp50SJ5L+cRcDx9u7yYnXl7rVDuFLJmqjpyA9HXcJ6xE/JH6MLqwhJj+ArNT1soXaShQlYhgTyjBgiyDPccX7PzKZHiybqAEBYWqHLkDtWZyvuKz61LKlf0AEbwQ6gHxpAIfGYrP8zts9tPpXNrYqDx0fL2+csFMHR40w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU2PR10MB5126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 07:14:56 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:14:55 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/3] rtnet: Enable compat ioctl interface
Date: Thu, 18 Aug 2022 09:14:40 +0200
Message-Id: <20220818071442.16567-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818071442.16567-1-florian.bezdeka@siemens.com>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08e5e5c8-bbed-4f31-ec20-08da80e95a53
X-MS-TrafficTypeDiagnostic: DU2PR10MB5126:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ag84W83F3YyXtItfb8iRx+SZDHVGbSK9PeqOimTecd0cLOKbSxh6gSOPmmd+SrPpZfw9igEZaY8KooN5gIgWSXAlhqVtn2obbb9w5IOUKABcOFY70sYwUg3FKzdx5+q61uuWkSHzuWBVxpi5Z3hq7mzrJQNDQxR0wmoA6ZRbAtdX30Fg4MuT4IIhtjUN1Tdvu/CT+1ZKvE787gUpE/j1GLli4bQrUR6ekSyxxFj4SgbydrtOR2f/cXAZrSmOtpUFDIPjlNksKYbWa7+LJzxWfWYXxGt//j8joneeGMrwo40ujViidvSofx6KWZZ2TQSg1I7g8YVof5xixWzgwt74sxIolDSuCy2Qq6i1iJxDBI22tfd+crsnhaCE1gKHkZh7H2Dtk/BKa4SJKyGpYmah22f0u2xThEZbfOmCaPUIDDHg1G1mA1f90aGHgxsLCqWbeV8snCRQXDiYL4gZ7bvMquwAiDlUQUdX/Tr4+H99tZVy9RcDsswDklAWDApifRI0z2um09I78wy/zYxjBMgqRA91jZKx1i/d3VoAb+Gby2WiBhtCk/TPLzi9J9atEuPqxLZYhUYNjr8O2+qtMg2rn+otoTkmvI23OSgXvq5sybINa8HauC8sQ/7R5BYUDPMN52j7T8JJsJIBNCOApH0LqwLOoi+neomk2N2vyY/vOMb36uD1h4l/pvDTg2/Kptx0QRQUKEAdlfo9KqAw5smIFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6916009)(41300700001)(4744005)(316002)(478600001)(4326008)(38100700002)(6486002)(5660300002)(8676002)(66946007)(66476007)(8936002)(66556008)(44832011)(2906002)(107886003)(36756003)(186003)(86362001)(6506007)(1076003)(82960400001)(6666004)(2616005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hfWH41D0+diDOnhcdZtxOpww3GznIIdzNvAbyCw9JfP4NHxSPggQmMH079/p?=
 =?us-ascii?Q?s40QlfniC3sN2uplxWf5CAcIKN/wZUHEt934lHoC9g4QzcwfHnjsZQYmwP2u?=
 =?us-ascii?Q?+g6YsjZVqto3gAnaXJzzJR4jxKkvq4jC8SOWh7EUNB5E8oxKfG5Mpf8fpWEn?=
 =?us-ascii?Q?cUUem/XM8L0Iq87GlByi21KUg94KPrU/0fGDIFvmfvFABjPEtGwovZ81IY2r?=
 =?us-ascii?Q?hBPfwum88SD6WJsStbqSY/Byr4AIy0Waot8dnFr1iUaIGXMD0sQ2ST2LgvSx?=
 =?us-ascii?Q?kXv4yJUzUrKfwFq2oJ5USA2gfpdjrXbxAKuIpCJ/OspTZAg5bpIT2TM0Ewo4?=
 =?us-ascii?Q?2+eewb6dlltLCs9GWzGR73dZIrVu2pTfHIMOW4E4EHdyBk9xKL2Pc5IGS7p+?=
 =?us-ascii?Q?NU+N3NO6vjznGA1DAasCjBjlmPtnPgkp7cGnBeiq/W7D7eaGj9smlWMsKPMJ?=
 =?us-ascii?Q?Ia8y6hHaKKLaor2Of2+/4Ga9xW9esuZ08O7SqBhdsPKz/oOBbvjXuVA0fpWt?=
 =?us-ascii?Q?7bBl1DFrsVpqZaggx3K8YQHGoOWkpAwGMDsKD4m6259rrUi2HcLEqd8aRe3H?=
 =?us-ascii?Q?7+fIQdhs72ycPus69xYOSTCddQQmKzB75H5tpd/8OLUWhjWiJDO2drMQoLvq?=
 =?us-ascii?Q?IiqPTl38HoHcAEpfybPCov8Mxzwc7VsWcTho57nJma3D8OvDsdTW9ACK9q+1?=
 =?us-ascii?Q?LXgfHXbBjf1WeoOMS09DZApLhfyhw+MFRluhezXddhpXWZLB6iC5sjeYVZIO?=
 =?us-ascii?Q?QpaJKnnFQoJi760FHCYkxfxCBGmwU/71UF+lqXhf84PstBHuI/APIcNkB84/?=
 =?us-ascii?Q?LbvVvhySgcxVsV6S4WpeNEAffOpBxQHBdDrd2aZDeP3njoMjL4Nyx0DuUXe2?=
 =?us-ascii?Q?/I+N8BnwFtQZrgsHRU0nsl1KqUuH1NuEdmvqoP7gC07sSaNrznE6a/97x0oX?=
 =?us-ascii?Q?Al/4Nk7uArbqdMALir0zZtatT2cE3V1YSlYeToYtiRg/vtJk1NZmOizhvKyi?=
 =?us-ascii?Q?fSm6NIq1qChrP6sBhawNp2mKkwejZUvvOghF4mbysh2KBo7qrjk3RSVRMaJi?=
 =?us-ascii?Q?jGaWfh/ik5ql8Z9NeXz6/RCP4OlzJPcVGuH+Hl2XtX879E5rwimiMnyWSFOl?=
 =?us-ascii?Q?E1RuHaBjdJh6Hgg+BzLj9hKH418QgZZeBT7I9G8bc4fPgUXIaVny8RsSuhdE?=
 =?us-ascii?Q?rVgcp4Xx+FRZ+ivQmcIF106l09DmWMv8jF7MRwiL6iKwxcOrZTruGDitpw5l?=
 =?us-ascii?Q?PLaoHvJIsLgyWhqL5PMRIA7w9RX/38WUDOatpWc9qhSOAADgglF2X+0XlwyO?=
 =?us-ascii?Q?u3EGSAOYHmDk2o3nzz//SRKbpJcJlTyznjUc6Uql7boloRdy2fkllCFs49Z7?=
 =?us-ascii?Q?OEy7TAPGCeagLR1SOL5s/Ps3S/y3LsdJTnO3xpQu0aVwmlofQYdeHdZ1eQ1Q?=
 =?us-ascii?Q?YXR595wIe1viITF2vMLw/xOxYqSd9hi/t/NQVVfohtw3eYg/ocbbP6EEa31H?=
 =?us-ascii?Q?53VhIv1tJPX1aHLsLY34EzDH3AZT/Galb7PgOTnUmrAsHVBAtenTBXoOP8LN?=
 =?us-ascii?Q?ILT0f5yf0XNmDFCKt/SqgTNTYbVnegjyPe3K/7l/0sbOexB7X5BITP3ZfjSr?=
 =?us-ascii?Q?GRCcEhj9t9ZNdPUW/ZSE39JIeCgXpjUgFm32CgdPJI/6aNcaIndKrZLSgDMG?=
 =?us-ascii?Q?mAdc7w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e5e5c8-bbed-4f31-ec20-08da80e95a53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:14:55.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiGfuSINFk42h11ZwWNdWPLZQQVItlhs/DFMIJXJCOntI+BjnUIGwfpT7MuEd5JEseUgz4JUOfjaMwjfGsME/WKO4yZDvVXnCGADpNjpkjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5126

Running rtnet for compat applications failed because the compat ioctl
interface was not activated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/rtnet_chrdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index 9457661a1..fa859c3bc 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -195,6 +195,7 @@ void rtnet_unregister_ioctls(struct rtnet_ioctls *ioctls)
 static struct file_operations rtnet_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = rtnet_ioctl,
+	.compat_ioctl = rtnet_ioctl,
 };
 
 static struct miscdevice rtnet_chr_misc_dev = {
-- 
2.37.2

