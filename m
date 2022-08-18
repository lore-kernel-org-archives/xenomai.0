Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF05C96
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iowMdlXW2JKpqNrgE1F4N78ARrKY9XeZ9P/PGbT1cyCxXhXeKv/bRBuwz1WlOUEI5fvdvfIgSk3qMABdf1OAXjSt5OOEO1mXF1g532rIvQ/eGgehpFwCvGu8ZJwHmboDWTQXtit0PIIANzABxtWgjn7wlijJrznb6kB65dio2z7/JBn5Z42/f0sFKW97+AyEJC9uiG66217a3J3q0hT9/Ftwra2ihMaFDm546JOVWFpAklYXBQW5D0mWrTfNsBmuHrysVM0rnQ0Fi/jyNJfJi+TbBF0Rt7bLtXk4L6FD5/ejijHAOW+UdS4Z1svqzC3mtb2XXfqd609nSBtDsrx9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYfMnNlRAkdiWUYGQDBwjaHBVwbTOBf52Rzlo7T6+HY=;
 b=SMICiQOElQyvC1/aOsqzNkgXom5XIm+p933KqojWvyij/i2Rxof1OMu15gn2R35Wy+o63KtwukmqcQYNRvlX7Mym4MDVHETVq/Uvz/7EK8rjk8mapie6xTfi4ybe23HevSKs/V8Q4wBPey38xZg7YXxiTDtP7hKkcl2FouDxT7SqLtdr5eNii9X3hBwrY6AobJ6g5H+zd4M3KdhpB371Bo1Kt5wlmZl4daInY8p6L0n42a2dQ4LUdrDUqMdECPiebw0iJN05X6zhtj/ll3dVqC8bNrwylNBGGpqsmXMVnbRtVu7PkqUyoJ2i2QyhAkQ/3d8toWIBcc31kRYSYPlyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYfMnNlRAkdiWUYGQDBwjaHBVwbTOBf52Rzlo7T6+HY=;
 b=rEqaLG7xRrS1xymDIaC5YP9Nj4Ko+p14ZeBl2FhGLnCkowZuzNDKJullke4SRSYgoMwoiEG2dCK2oTmvPri21RKeN8z7viFCDi3nD5ZMhneqy66U4Dn0R3lPEveLh44yFWMSjsKK7R6v+ZggTZhhc7689m9xUjHt4L2mK/SsLXwzeLIK51N7uJoG2j82g+Zlkjc4HlafQ8ZmyYHhVQHtRdJg4IIRNVbCG6euN0Y03Ua7JCvU5J7IgcFmWqoQ9DpUz2Y4ojGvikQ/m+V5pbu3cITOkW0a/MzdXOBXF1oYsIdimF8QDErJmPp6Y0Yn/bbLc1i7pwSO/JMHo6wNRV/1JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS4PR10MB5342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 07:31:16 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:31:16 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH 0/3] Enable compat tests
Date: Thu, 18 Aug 2022 09:31:10 +0200
Message-Id: <20220818073113.19382-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25359664-00a5-4e47-1fc5-08da80eba2d8
X-MS-TrafficTypeDiagnostic: AS4PR10MB5342:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sBj6ZarvNtN7COu+Th/peIbanFzdLzipZNzWLXTnhLKuYBZrs8yfgxWQUwO8AMy0DUaDSl/g+ZDSNa6qOEAZeEltT8haJMGzQEzgdXAaMu3SOPnPbf46G8AZHqqwog/0g7hzS4na5mFNwAef8PvUZ9cj01E3L3DxgMw4DcGb1miXdsugWyya+88W2PIHMbCipL45DnDv/SrCK5Jp/HwlRMLztZNDCw69kEwYcfKZEesgb+2iodsCvJjBWfpVJbt5EIp70tQKbjGE+kjMfoR1q2XQDcNWpvhXngSct3G5IrGRBIaEG90Q1+kEVQHLVNLOUqn+d6HTYrXW8Fnipg5usfTrTpPa/9Ym/tiDWvXpntGVrorpz5m6IGGR5Ccpa4fMqj80EqOQTaV9IodE0UVoo8o+Oe+fuUXG8Fj6CY0Sxqe9amri2b35fDgCFFZ5OfH4ibnl5Bc1/Q7x7PVRITj/h48cSIC4pAsfFJk7lAlByoKshNtpiA9aRh0Mck95TKizefNjpBOII8n50Z77CC9DpSB/ZGjb1gB/ZOdFCMn+joh42/yiyoc6LCEKqeft8OPUn7HcqvfH3i02SNwBuJuA3jdEET++FS8N770AHmlP/1Ov0Tx38f1jOEHo55amd6wXHMB8cINzl7x0XM8521BYBipFqAR4Lsl+zzSoiMGP0ZfHewgkhHzP19wA2YN28FaYoHFoLbHT3cCDKfz+A+d0ASnmvWvoXaIpp5oBsIuFH0WgRJV4j2A1+pT3ANj9K/cW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(5660300002)(2906002)(44832011)(86362001)(6512007)(82960400001)(2616005)(1076003)(41300700001)(478600001)(6666004)(6506007)(8936002)(83380400001)(107886003)(6916009)(186003)(316002)(8676002)(66946007)(4326008)(6486002)(66556008)(38100700002)(966005)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uwziT4Vp4jXgbnHrn/lbmDxuGQjWyz1ptGxBS3Dc4ZZceMeGew1FotjoUUYW?=
 =?us-ascii?Q?/Ch/734joW1aAuloCQZ6j3sLHFS0TYRyMRKOtQPsetqYcK6oDaBcAj9Jnvxt?=
 =?us-ascii?Q?R+HfJprj6OUmfrDh14iRyxyWXXWs3CU/BuNZOW91aMCkv/im4d3yai99T/+z?=
 =?us-ascii?Q?4e9Jr1sfQqamRqw9/1GbdB6IQ1qoibI7dUG4xGduaqduXL+LtneSWpuVIpFf?=
 =?us-ascii?Q?5aXLnxlv5uuxSWWEiRzGl3RLGf+vyHWVxQPcWyUKmwjk+H1jnRKkQ5oPrfya?=
 =?us-ascii?Q?+ZZue8UGOjQNo43iGDJxPB7BUYCgJTq2OvGUFRoeIX9rdVwGGWGUquxMf4vI?=
 =?us-ascii?Q?Qm4wUfesGu1JpFLTOumPnvgYGQ+QXfB+fA+XVKkQzN6gUFEkOTgWPdP8xd2+?=
 =?us-ascii?Q?Dwa2MwRxtXCOK9eQyQUoOzNtHVgG6KX2DFqBVTk5OE3krsPfXrTG2kkXVoZJ?=
 =?us-ascii?Q?O6zNDRlNWn+ahGeXAmR2BinUh+ZY9QAk11erRf9hJ5rHal0aPcaxsWMV2XwX?=
 =?us-ascii?Q?fZOKV1Ykt1KYv1Uz4O6aYW8TrHGbxFl8CveRGKr7ulS0r8ZSX8IJOqkXAqm6?=
 =?us-ascii?Q?vOR8laTmcVjLDSIFnR2RJ2tSzneQUW7QFV2Az0Ys9vibdEb8bBnPqEHC71sL?=
 =?us-ascii?Q?cky2HAgr3Xsi6P4QvMC0uToZWVb1iVAyEmoEOixVK9zUa6YhWul4Y9o3L+Ka?=
 =?us-ascii?Q?t+QCaXmhv1D89okg5JErAqyEhKFnIPUv8ow0x0kJ99+5liXtmymAkXDi6BYq?=
 =?us-ascii?Q?B9YLXwO711gqw94MBDL8f/rhka7CVd1bKMmIgAPSjCrPntpUQKbGGhyzBffT?=
 =?us-ascii?Q?z0Pz4sc1EkDM/54mKQ1vlILzoRfiCdHy4pc5N6qxZoV1g8L07keF7vytB5Sk?=
 =?us-ascii?Q?bcZx8lbRPZ5++xEhgZUrxKbpRmLw1A7dhlNKb2JUo7BmEVg9guBfVpLeVYVO?=
 =?us-ascii?Q?IlGGH6Sb7UQNytMxb9QpoJ1eIZCo4Pq4/dKpy87kC1m94n/dMSM0XJ2z1KHp?=
 =?us-ascii?Q?cANJZNU9lE6Za0Cn2dCVgPfd6vgDMtJBlOrRPOBG2mill+x1NjU2IXkFqnkp?=
 =?us-ascii?Q?1auNTBFB3pR6GzOXF8GdTRd7Cyu7/zFDVgSLfyhJEnaEnT4jclmSmH94NrdD?=
 =?us-ascii?Q?AWjnwaqfhWDfWrHeriXiDvO7454XzuVrTtI3egHxgsj4AF2Bt4ezEqUHfi8B?=
 =?us-ascii?Q?H3QwaciD5/XJWrQ2k01+AK8mWivUv54b+dsYJAFpLUplUfz+oxCOkBlYmnRj?=
 =?us-ascii?Q?NGjiAMQ8rh522LoHotef3OdKi+KO4oxIWpc/fFrahX+6ZOvbPywiqr8GNbA9?=
 =?us-ascii?Q?GBp5pXa94rDVb+znKmgySg5VkvwKiBJD6PTjLM/gCH2ENM4Wet9NRfdj0Wox?=
 =?us-ascii?Q?2hQ1gIUfXj24ShYtJTKbHPVfsdZtJnZP8gvg5+/neZdtXIRQDWieiyiQMiZJ?=
 =?us-ascii?Q?oXTa/jVGmVwsuOK/pKNvYJ2dAePneE7ay/HMbSWkTfWQreGKEHaVGSiLwptw?=
 =?us-ascii?Q?XdQh17769xIIOpgtAXShasFSZ3DMTllOA1SKn2vEmK1appbX4kj14N5VzAlJ?=
 =?us-ascii?Q?q3G6cHuM2jAmd0s6cyfXnosFZ3UMn3H+NrZ4LN5W4K/NRJrvQUqU9A1XY01n?=
 =?us-ascii?Q?O8CnF0Qwym8uwB2aihrZJIztJXsDAKd8QWTzxcigtS4K4t6nz4YTpvj6P+3v?=
 =?us-ascii?Q?7PRA6g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25359664-00a5-4e47-1fc5-08da80eba2d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:31:16.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87M2s6U1QlNNQcTBoK4Lzfh7iLJaMyscG8ihdtGaa7inP6W8qlTnSU2sRCuFh++K57/lIuY4CaJBJL4NE12H7kHIm1un47quCWXhO+MBOII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5342

Hi all,

this series adds the build and test jobs for compat testing on x86. 

I was trying to enable compat builds for the arm64 architecutre as well 
but failed. The early Xenomai init code fails to detect the cobalt core.
Would be nice if someone could tell me if that should work and we have
bug / problem here or if that was never supported.

To get the tests green the previously submitted series targeting the 
Xenomai project itself has to be applied.

With both series applied 
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21 should be
resolved now.

Best regards,
Florian 


Florian Bezdeka (3):
  linux-xenomai: Update kernel from 5.15.9 to 5.15.57
  kas: Add option file for enabling compat builds
  ci: Add compat enabled build and testing for x86

 .gitlab-ci.yml                             |  6 ++++
 ci/xenomai_next_compat.yml                 | 41 ++++++++++++++++++++++
 opt-compat.yml                             | 17 +++++++++
 recipes-kernel/linux/linux-xenomai_5.15.bb |  4 +--
 recipes-xenomai/xenomai/xenomai.inc        |  2 ++
 5 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 ci/xenomai_next_compat.yml
 create mode 100644 opt-compat.yml

-- 
2.37.2

