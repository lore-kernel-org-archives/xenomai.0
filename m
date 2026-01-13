Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889F30FC03
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294262; cv=fail; b=bgT6FPU8Z6uzR6oWhgB9fojka/TYh2rOPMejHnQWc8Djbnt7hgg52LIN4TpgeTYswiM5Hebf+zNr1SjrTsHEOjPgRrcyLZQH2peDpcyed3npFCkyOQmFZNAHsytPo2qUtOaHU0HJP05eZdLUAvXp+ziEIoS0q7vBbsfrcQvGSnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294262; c=relaxed/simple;
	bh=qBkUow6H+Pm/psBn8Na8x+RenmTif010nI+iNV7WkA0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UetZ8JWfqpRBxAb3SnRabPvrkfEvgl12e/wjlCB4jICMBOeVsT5Cz8ml1K6kT1QDbob2CDqQvGiGNqPhzHb3GZ8NOh02CAgP2sAKzjYwVZazI3IKvJkC556JKusFtCqyHDjlXMnkY6mEgwP/HN3pSNdwBmP18ncKNbNVU35gBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oUJ1bDVm; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oUJ1bDVm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW966G56MVZu/inlzizcUf5AHGF/TZgcI8NHc4RpvLTXdqgzdcCbf8IOBRRN4FY/ATXsvRUe/ThKGpUKHFoDMNbc2k7pSFzNHtHuGH0oPxyRYf/N2dE6LuOVjTSsD54bdwtA4NlTW5n5wyD3w7YUOhCm20K9/saHl6R4WmGKeuuCdhCvO0h12Qc12bPeGjO5YQUhv4NbQhSWPRijpkXsdxGx0tSLwTFeIkRHPNOhHRZ6IBdFs68cqnnniQNb46P+6funjyn/fnByQHpyAKT54Pscic0ODVD4xmCp+ey2DDjbIDkZ7gqCHBLDixHDFZNwSl16GWXzTB8JXaW/g470Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIVBymuIpOiEaR/I5y91gxGjggL5Had26+JlnxmI0qA=;
 b=pxeZvGfEYzKEAAFRhRAB3+9NkuLao1ocDGkW+3YYS8iFgEZ+G0CoqqjJUSP1+HOZdNa9H72HSxzBpMoY8eDKHDjlh1kGtYnzATkhv3DjvNqYti2zhjc9/QGxCcn/gvNk/His2vNmfdOdXnNOzfCYsL4PduvVqmjVrOuEekk18/lRZ6Q4qlAZIMDX85QmKd7oVgf6TgjT2+l4y/YLV5DvAe5SZKejRHO0kugwPfi+ebs9bQw8bP6Pndy7G3mr+VchInn12MTU3wqZNeOvZT+C//cZekTw/iS07+lKZlkhL3xC9RjY14rQDLz1ALCOHwJqpL0fN7GZpmw6NB2m0PUrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIVBymuIpOiEaR/I5y91gxGjggL5Had26+JlnxmI0qA=;
 b=oUJ1bDVm7/5yOSxH53iyjOWcdx59rgQHa0pHfYLPMgq1n4RF8iRWDwtLO5lCJxwTQna1MbP3lj6RbzvR53PGTAXq/EmT7kGpnlAEFjDv3SeVtWKCScSFu3ad07iZHfcgbJbShUBI2CCH5gaVBBZGjQZ8v2LRCwwR/BSzzqISWoEqHji8rX6yf4p8vPzspf5PzMgmvgcJwwKnBUgxkR2lBPmHWOz0ZazjmJMGDSBCbfhBYr+l3v3SPShN6xCFKPE94CVLvR+dWErD/cqt8cMpaCpRcaFsstMD3nSEZO4mfcvx9PI6s2YtfSsOY25DEn+5KuTjQRzv6ZVM+LrsjQCZWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by MRWPR10MB9601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:50:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:50:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 0/2] Add RISC-V Architecture Support for EVL
Date: Tue, 13 Jan 2026 09:50:46 +0100
Message-ID: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|MRWPR10MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb15d42-ce30-4c07-c4ab-08de5280de21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysy+VegmtmoKdI8Ya6WU6gWs6p1ozI7HAxT9FjuGU9OsUM2kUtoL0H11gdDD?=
 =?us-ascii?Q?vEHgBoJ7qlQ4GvPONUEVE+SMDy5RBxFsc0ECbfgORZBeFIqXnly7uk0qL110?=
 =?us-ascii?Q?PuqvUXgTkn8rvkWEzcVRIsKZ8WUoBcO3+72Qc+tfqezhDKsWaxGEU5KDfkBX?=
 =?us-ascii?Q?7wtp3J7nPOWOrufPSqrBk/bHBi8Q4DfkFQEU0iWCj649OsX2/Kt/ALJGGhAJ?=
 =?us-ascii?Q?s8RLsMqtlj+6FTID3vCj2iWDM5VytOKODep+3k0hnQ3cloaYQ6Eu+HaNrP2D?=
 =?us-ascii?Q?eCOKltDZZCMUjkEgjU40x2To5KSLCTLGoMAG+euo0IaF0wdQbwyCQgWLQxWC?=
 =?us-ascii?Q?Awoe5Lq6xwErIK3BInyF8EfJ0CJEaUlqeA4nLQaotqbFlKBmT43XIT9DStp6?=
 =?us-ascii?Q?TpLPcUgIWNZCNLN1zilrGMB68Bw6G2kEhhCOLuI5RXjFuSWJ7n6einvhErvU?=
 =?us-ascii?Q?xlg47jA1E5LApLbYOwZSgtpRyvmwr7Q7eL/cNA7KbeKL0PkzXeegdFCXV9K0?=
 =?us-ascii?Q?/pUFDQSmCS6UgPm9DELJO9wwgwoV4M8tweZamu0GwUSQENER+9ajvCf+bIMH?=
 =?us-ascii?Q?LtrAszVfWNNdUtwWLQ4A8K0FYs+cg3ug94bXXYntjZ0GL0x/purifGZOLgiX?=
 =?us-ascii?Q?FYdsle3i7tvrX51hjXPcttzO6CEIbmVzLCsrxnLRo+hO/VVKrIopi9NNYdnr?=
 =?us-ascii?Q?UAw/2U3YHuTESqfPf9qdO0/IqZo0oWVuxQOJRiMaWMeztwYQCTxqETS8Z3K3?=
 =?us-ascii?Q?dbfSzYNDm9kmIJegA3y9YkJzrk478ZCfAGs036A+L5faUYgmwluvAsNyLJXv?=
 =?us-ascii?Q?jKT1JluCNH9mQiDWpcpqE/j/imh4uI/0ypTjO24CpP9CpZztOCJiahA4EW9E?=
 =?us-ascii?Q?aq1QUZ4eIFEkyPkML1yo4uR4omglfLYAWENeG4Yd25fTF73gmcreqwIf//pi?=
 =?us-ascii?Q?CdkXIR7CJ43fQo5s3ivKPC5YEggUxA97wNNV3lzEGWHvRIyYrm1u97rv7yQH?=
 =?us-ascii?Q?rar3lagFq/qOZgqBp4yhn7GVonW9UDMzMZi+VSs0p3b6oZrt9FszijU7lBiH?=
 =?us-ascii?Q?9tN3TfoE8OEljcj3OCwAecTErEoAFFROQcVOjM8nK912pj7Ohp6f/2ojoqHj?=
 =?us-ascii?Q?FnSllgBuuE5BqzYndcXBvscZ3HUHzP2wUaSLfiMgIwcUlTVTZbEnW6XixZNV?=
 =?us-ascii?Q?50mUFm6bvSBCPsWSFtgzekn+Hft1/X1vgZp8g72hwLmgf4z4c7ZSUQcVtHvw?=
 =?us-ascii?Q?du+ABaVlB652Pg/S8svJvXfqq+SIa+k2c4nWaQxTqwcs+a9JLOnPn7lkgt6/?=
 =?us-ascii?Q?dmZzQiXTYxPVjOEMP+Nl4QPsBj2L9iq+OkeA1Sy1UcqillQCiIZyPxYGty6k?=
 =?us-ascii?Q?LNR8ROZ7AjZrlQ3pdYdApaVQdsmeWVM8xaEoMWX6d8g9Wmt+kboV723n0caz?=
 =?us-ascii?Q?X4gBlAZjmbyBKSgc3u8NqZ6sGM8skQ76?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+B4LcCtJhMZAjHS3+2BXEWyBG4OHDbDdLj0lAZ3H1jP6nCKMZ89e+tocbCX?=
 =?us-ascii?Q?ReTGNE490t9O8Cka64DXqYEghTjzlprSO5eNPKANLASAFnwlxkQbJ1zeLcaH?=
 =?us-ascii?Q?qzv2TX3ebil8VwY2MOwwZ28GaUZjvxiCIF3pWGlz/3UbiAWKr2RRidW+YTVQ?=
 =?us-ascii?Q?dKI0lh2yCrxdTfvci1dlvm7UkfpAtGwtBDjGUkSZgTk71uxM4XNWIiUztAqN?=
 =?us-ascii?Q?eKP91p7FZkdmTa33CdNqZiDVh2EbPmIDWxxQprrYMqTGvR22bw71o3j3YlR5?=
 =?us-ascii?Q?9zUdrJDQW2YEDNlVBrIxJ/FNX54yf7X5VWYnxeJwKnvEHXPSZ0+ID1zoYEgD?=
 =?us-ascii?Q?xZA9EWhu9fgoq5D5M9FDBeSgnykF0us5SUkMIIfG7xSP3hr1kEGqlwJ0EvBS?=
 =?us-ascii?Q?G49qcRU+U77BGIseBEBhzpr/WQKqNJopt3/DkQBt5HnUjMW3ipK0of0f7fix?=
 =?us-ascii?Q?5hjVwxaavMDKGZuhz95s3oyibykCYV99P25VRF/SW8i3CkAdwWpKNGP0pb+U?=
 =?us-ascii?Q?sliDoQssneZ+Jgb6Z1cSibj6QrAcXiDnooG0TbBHcHx7O8tQn94ZtGR2bfzm?=
 =?us-ascii?Q?iutOD/vuS4JNSgtGCBqK31oEDi9WipWv+WIR+6AUBOtCgnaIEacEwBnrE3Rt?=
 =?us-ascii?Q?CTsOV1xTTDYd4rHRSsdziFRy5MCUK4pxaf/B2jE4IOwz6l5FH1kA00UsQgmg?=
 =?us-ascii?Q?vwhqtZHn3KpwBmfYnfW6h9KYE9Jyttt4HclPCnROdZKnI3IPC/CgYgER+6No?=
 =?us-ascii?Q?FbjVXObPH7ro3uNH//PhDB+R9QFn+PizADfJJ41PH+/PXwvN/yyHy493LKBp?=
 =?us-ascii?Q?MXCVKDi5f/eQmbBEc5TsIbg7I8UwmIkvKuzVrFscKDjP4M0hei/7SP2VeDUM?=
 =?us-ascii?Q?qBlH188NzNYyV9nzSC8R9TIDDUwHeLONpL86MQWgBrYfKIXVlDkTSnhyA9jT?=
 =?us-ascii?Q?od27bGAmiRgauiO69x6QQc9ghOVWydWArSw/s86gvYmTeTK6a515R1lUuLzP?=
 =?us-ascii?Q?46brv0p2ti2lL3VyX6RQpg09ivDXniiGuWDzXpJnEN7gzVI4DLFSU6cldbbd?=
 =?us-ascii?Q?9govygKef8DRL5ZGSTfuF5CYMA/fQ512GWI8kr942sHtyYmg4CazdTrwB2ee?=
 =?us-ascii?Q?iOfemMnhKXlnrUiSbRB3bnfVw6VJc5zvCB5V9u0FIRxEUPhaKP+Yz5cFVDQN?=
 =?us-ascii?Q?vIeN9D2KKmqvphr8QHhWPJ71SbmZj3Cz7LDEAwrPgyyksi75PoCDHBoQuxho?=
 =?us-ascii?Q?pr3+xX3DwrU/GVKtUj+xxjczo7WIhHzEYge3WgyHjU70qOnahBBYrFc4foTE?=
 =?us-ascii?Q?BL2blugXmU91vzFFiODWJ0XuQHjdGpU2UPzs80HomPhhXj0/qR96HzGWzOHC?=
 =?us-ascii?Q?+MhBhrtiU9WpdQNVjRnc/Kh4wshvuRN7sA8pxEAfUbSlJjIMMES3U6Z/e4jA?=
 =?us-ascii?Q?P6mp8Vc94tXkXmghBm9gVvdyLuUk7a6La3F/ZmX9LjBamOzyLcV5S03+SE+a?=
 =?us-ascii?Q?JCMSIkoOMkHQk0Iz5xqJIWuPitTF9n3SzqSXY83Reet4fiO/bVHSkPGED8j9?=
 =?us-ascii?Q?ZtMzJAbXBi3GqvTXUXvWeNSpScNTFPEYVbP9AzH+Yn4OSYABlMWr4Gkg5Rmr?=
 =?us-ascii?Q?qBf6wJ+vn9mHMOIf873XFtChvy2YF+zpA54R6DNYG/Sv0tLc2BEppIVnyBM3?=
 =?us-ascii?Q?EUhPOEiiHdM3ILUo0/YFLLTES4pvK5UdM3fAlAZKeWiuluxKBTYjuGn4pwBz?=
 =?us-ascii?Q?t7LoRyQoHZydWb4A4BUJsYTVi+uCPTk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb15d42-ce30-4c07-c4ab-08de5280de21
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:50:57.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YsL5S8AJjO70J7HJUoGACZLzZ8afIG8lRcX+rQtetQpFHSirApmDUItJyCtvqhvY4UuMckzDPrFdyEiMkAj7vI8oAg6XXPNREpvvWA2Nm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9601

These patches add the necessary changes to build EVL for the RISC-V
architecture and to boot the image in QEMU.

The patch set is intended for developers who want to experiment with
the current state of the RISC-V port.

Until the RISC-V port of EVL is fully integrated, custom branches with
the EVL and libevl RISC-V ports need to be used.

Changes since v1:
- Do not provide a custom config and let isar fall back to the riscv defconfig
  with the xenomai-images debug and evl config snippets applied.
- Use depends on in Kconfig to filter allowed configurations.

Tobias Schaffner (2):
  riscv64: Add support for RISC-V architecture
  start-qemu: add support for riscv64 target

 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 kas/opt/libevl-next.yaml                        |  1 +
 kas/opt/linux-6.12-head.yaml                    |  1 +
 .../linux/linux-xenomai-4_6.12-riscv.bb         | 15 +++++++++++++++
 recipes-xenomai/libevl/libevl_riscv.bb          | 17 +++++++++++++++++
 start-qemu.sh                                   | 17 +++++++++++++++++
 9 files changed, 109 insertions(+)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
 create mode 100644 kas/board/qemu-riscv64.yaml
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
 create mode 100644 recipes-xenomai/libevl/libevl_riscv.bb

-- 
2.43.0

