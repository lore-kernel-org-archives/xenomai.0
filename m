Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1581C03
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 12:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N60aOcWNNF8gQDRcxUqreK/NCS66VXt/5mt5Mfz2oXg8dlCTJ8DgMvHe1NQ4hZot4+yf4CEo5piz3T8rVDh99Ca3T/zLzy5EKzqgAf3c7yJEflzQd/pW85cEqQ7gCOrdPeQJGuLpyFWT42GYes67wmhBToS+IRNDqqIrT9TewcIFW8ht6YoXNdAUqZd6GzTq6KYMPn3QSY8doP4rtKWLixegutNdnrJHSKU2kDc4rZVTXfkdZiIn9b7q2EjIR+z+cFRveBTMjriXtqUm85zsUDDVijhSq1fWU7P9bGi/9y+1sLOhmutcMn46A9IC8Epl6iOHjIvtyCFuoEB9ZQFc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCwkT0MnMsuT1Dqscwk2l5mlxkatijdYH3GlgsCxEYw=;
 b=IuxmOpHYZFPmtP5o+TxqSWZqGDWMUmKCmM0WtdaMqVIgfKhdqbKLtWqt3J0lEcM5wSxzuNn4aB6woVFydFfMtOe9enAEDxupX1dzkKcIxj+Ypry+WFH6F/eBhzbuF1RRc6R6S0a4F1Xm3t/Af4qDQ1KdZp2UWMPKRhbI2pYdaY3mBHe3po6dLmBNVzEukHeB3hGVSM4okom9xo6WT6asyeysC5E4deE0sOB4Ubv/bK8DrwGgk3n7r6hd64PeD50yM53vPeDhQlgL2XRAyQadZXcdee3jahaFnXkijvLJZxSM0fwTLLdsdeQRkNR7mjwhzKHnpg1pms3EgC+e2i71rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCwkT0MnMsuT1Dqscwk2l5mlxkatijdYH3GlgsCxEYw=;
 b=u3FlNueleiWH7xbgeNeltiy3EsRiHho2VEhC2yCwdOTO7qwi6enbl/p4O0REwuFHBAiOydbxdu1xaTcbf4N9msxneIT9Yk1bfcaWb4b5l78CpYnBxUGq8kygbacJ1k3AN6RWrtiE2Npxs9TePtPeCtkcSWWZWxHzjYq+FvjWrxwDiO3W+BUEDHGrWSVgoHlxQx8gwb0UVZWxvYEkrlEohmCgfyiT3s3tfVzTlD2pb/cKEqd05EHLdKUm1AOyYqF38ysNfhbnCwn7Dp61r8a7xy5k37B5u3RtElQffqeKXX5PIQtCWIaAWTmJh7HtkmYAHi209OoiN34e2Zy/MQaa3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:25:07 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 12:25:07 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/4] Enablement of compat tests in CI
Date: Tue, 20 Sep 2022 14:24:59 +0200
Message-Id: <20220920122503.115682-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae53bed-6ca9-4f34-e723-08da9b032782
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t04PqyjDPhQ61bDMFUAGmZzP1Rba7TlLK6+MABCr9HL1PvFkmhjVMZgI8/3MTwzEe8mvX5rQfKvbAXHyWF/RbuxRdEAE+6H1+zuMWDnlC8JLg93JHDHXaPoF3U34pgi0FXrBod8eHRpAXxP+4VSTH4X8PHT2A1ivz5HrACsV3UfOfmiRhtU3awn6eZo7nw0UcUKpu1ymHRos5v1pQBa0cBcwmm2/XmsYtEIgOCMZjFTGRLnoT5vSIpIf/rrss4uP5wwkqO5sZyYpn1Cxh3XmRCgdCTHSzUKPvPtgB7hyk6YWj7q6NnZyQGDxFCTpTFBIhz7eQuOfAXrhpZZwBG5SQKRExx7FM9ggQdf08X9xYYN6Xp9L77XEa76AQu4R4poCsoZZrbHskaPHen7rzaEkxmlTm3QNm5hKcIvZxMT6TBmtwt9g+qpfucmUp95BEPOAyIB/FKzOd/z6YwHCD4q8DBWj/bdCAF6qZjCDVBjX7z51xaHtXgalIzhXpkKi2wat7DjuLszaClIpDpZYP8dXcoGxPIjiGx5Orf1XuJuZXHXSmNwW2DryQ1NNbs0fAlCLHZGTKbaLj9kvmtX6nfakYoJqMVJRKO1VBoWMR9yblAK63Q04QULbwe1iog+HLrl6UeRWV0WcvjbR2/ycEqR362ZSsEaTvqVG3yBS+Gf3B6PCZm/4AU0+zRTms1pK04JpmD0HewF9Q0wur5N0/9wnWyY46JLHBM3UXNdMVn7VK9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(82960400001)(966005)(6486002)(5660300002)(38100700002)(8936002)(478600001)(107886003)(6666004)(6916009)(316002)(86362001)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6506007)(36756003)(83380400001)(2616005)(44832011)(1076003)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tkn1oF2fBUXXO7PfLRb7pMaLfHT7KVdXwc0lt8XPi8V3JwuxlwI4SjXDnFdc?=
 =?us-ascii?Q?OUPBC0DY0p0xhWk8PPxAJ0+AZ0ahslkRehV9GslvKuVwee5efCnev2X5XL8q?=
 =?us-ascii?Q?iAJO6wgrjV81mCBB3F3hgELnjWLKIFDOGXkYsdVR5Jbjxub5kQUfnIa65kWV?=
 =?us-ascii?Q?l7scBGAg1TxLEku6EBxzbH2HaCfmjvCd25Ka8kPOXOVet69gaLVQ8FsfdHlh?=
 =?us-ascii?Q?PSpxPelxcQNvbVj4W5uYXGA14kVVNtq92tvMLuZjsFXzokSSA5bt9RZp4YNP?=
 =?us-ascii?Q?xrMfmI2LORRMGZiYnETNSgQ7ywFzSym7MdoRILRMPKdpGb9y2fGZrAxPO8E9?=
 =?us-ascii?Q?i9PEg8OTrppO5h/DRylYUT5rdAbm8jD4ReUZZm1TkIw9caG1DVr2kpcmOH8L?=
 =?us-ascii?Q?34VpZlRNqNYmrVU7TdlVaELw8pumzs+5dXZc5RFDYhc+I1PJ+RO2QbttGgOH?=
 =?us-ascii?Q?e+9z/eMHhEUuq5RjxJOnI6O1U8UQOI0MCT0b9IuKPbiSUnnPiC4f2BiziZ+n?=
 =?us-ascii?Q?UHrrwNMsfsYakMTRm1jr2kmdEJ9txTB5r7mLYyGUdpv9BSwuOj8XNDvoPa3O?=
 =?us-ascii?Q?5v9fA/8DCxOjyHsif8N9dQ+9zw2Pb5X90+krKgs2TiBvClV4i2zz9yZZAi8d?=
 =?us-ascii?Q?Of57ImUALIsbZKwcicRoUja1SqxF8SLyzoxnj/ddiT3htEWGiy6Oxs+NYGst?=
 =?us-ascii?Q?wHr+8jIr5O8zId43ZIvhYDePKxGRG5qqZ+st90tf85aRJL8me3+to8X0xv7v?=
 =?us-ascii?Q?j4Dua/u3tADreSJtr8+ooApErXvmhEFckTX067HXKMtsEL7blBYqZCcsKze5?=
 =?us-ascii?Q?yksT176DB0lGHFq0MQNx70/99Onyefk8Zr+LNTp3cjhsBwI6cPF7r8FPOmBz?=
 =?us-ascii?Q?I8/s05zopptkVn7OJKsa9C23s8Bp8YesSu10KiMmerUIwukiGjfNDLqEQrsM?=
 =?us-ascii?Q?FI39JpdgB6fpMNiBZV2yq7PqN0LDj6XXCDyX6vU44kUcLpcQI0F8lglhs/ml?=
 =?us-ascii?Q?1CtxpxPNdMBRtz3zsneivUCs5aR2cVutwNYDMYTmLq01AUiwllKmJI9aFoWT?=
 =?us-ascii?Q?7DduWEWlIp70wdwN6cT0ARzz8lRLOiBF0VOcMyci2JPbDMZq5x8WD44tTHCk?=
 =?us-ascii?Q?p4h7J/So0H6d9T9/7rd9mWnOa90GF8oH4iHDsdGhGwd3r+61V6xpsFWdKWek?=
 =?us-ascii?Q?m7rp9sdTRh4IPreW15+DdFUVomKHdvLQbl8T0ElwQXra2eETE5dFLm0qjo4v?=
 =?us-ascii?Q?McK3DSMemYmgku98y4HD7FblFtQiM5ICJT97iqi8Le4swDiN9up9Q3QWnq83?=
 =?us-ascii?Q?9R3INW2MbfdvRWAALRhVvEr6X3S0omXQm5DPaw0osWwWa8342diEapZL+fQd?=
 =?us-ascii?Q?wH2j2F9JoGEulwpHLGT2V8bc80UMhtBZIXDTc34Wg1zoEIkkTpggB/r+Vbwc?=
 =?us-ascii?Q?GKrpzHzSmYAcLaPl7NyLIUy31eOpRgu1jmnYdT8ZmLq+labw6vZrUZ6S4JZJ?=
 =?us-ascii?Q?L4lO/euNxGowC3f1rJuanOG3H6M2mbjMJDD2vQA7kQquRHV7Ix5UXIoS87DR?=
 =?us-ascii?Q?2/Q6t9kiXx0j8UWgzBuDkR/PWF9ssLo9cQAKRkr4fla4g/LFdxd+y9KKMrk7?=
 =?us-ascii?Q?dSsSVwfP4NfR8aPe6/7RNTTt4CiA/eDjox/U/8BnfeBWzu955AqkhSqJti4F?=
 =?us-ascii?Q?XrdGiw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae53bed-6ca9-4f34-e723-08da9b032782
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:25:07.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcyRxsP6y6h0k2HIUrMzSvDqVGnlmj/l4A5MnmHgPQ7wNDTcTG2AbYyZqbzECalwPf9FbSpclaC6JI3eMQr7GMAtaFcpbwzwNNAjRtts20A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

Changes in v2:
  - Removed patch 1 (already merged)
  - Splitted patch 2 into 2 parts (addressing review comments)
    - rtdm extension (now in patch 1)
    - compat support for rt_can (patch 2)
  - Added patch 4 (helps to separate CI logs)

Hi all,

this is a spin-off out of my y2038 queue. This helps to shorten the
y2038 stuff. The following 3 patches are necessary for getting the smokey 
testsuite sucessfully running in compat mode.

The necessary adjustments to the CI infrastructure (part of the
xenomai-images project) will follow soon.

At the end the following issue will be resolved: 
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21

Best regards,
Florian


Florian Bezdeka (4):
  cobalt/rtdm/fd: Adding helpers for handling compat affected data
    structures
  drivers/rtcan: Implement compat support for the rtcan driver
  drivers/net/stack/ipv4/udp: Implement compat support for the udp
    driver
  testsuite/smokey/y2038: Show sizeof(long) and sizeof(time_t) on
    startup

 include/cobalt/kernel/rtdm/fd.h         |  16 ++++
 kernel/cobalt/rtdm/drvlib.c             |  17 +---
 kernel/cobalt/rtdm/fd.c                 | 122 ++++++++++++++++++++++++
 kernel/drivers/can/rtcan_raw.c          |  42 ++++----
 kernel/drivers/net/stack/ipv4/udp/udp.c |  29 +++---
 testsuite/smokey/y2038/syscall-tests.c  |   3 +
 6 files changed, 176 insertions(+), 53 deletions(-)

-- 
2.37.3

