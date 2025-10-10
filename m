Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95A230BCC
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091446; cv=fail; b=uzby8MaM/tsAZVrUU0BXuaoAQJRmb6WD5SfBhJFcRtkMgKNUQn37e36zh0tB1XvuYnBB/PolifzqYSZUXVgT63CfgdrfTHoNfs0ry91+UM7U6HlVb02MvSInIXWZgZW9FqUcnYDwmHj5nq4sZXOtQfI/4jQ8eNlcILd+xw/egCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091446; c=relaxed/simple;
	bh=AFf9qyanxr4MZDXNxg5rRT6G3LpGgqwcbj4XalvsaKM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SnP6x5HNssFXHsi14rfoT/vgVGa+0qTTpjb7uqZW6343jIj/CKKFRUfqChrhNJy3v2q0FRza/RsMDqPl0CvQGix66emfSLx2kK4WVvFjElqsDif6dnTlcpWBkuu/cO0wcHnLmlYMr0oKKzLvI4nww16gRcbnY3RdqZzscUAMnE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EzYSqRpb; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EzYSqRpb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwqY24yE61EUf43jw2zSliB2IZ/c9xS2aXqsvDNNK+zI9LbzdC4lRa4s0XLkbtygybN4BHLmK3SaceeFU0ToAE0SpLEwxMfRJTO0pbqorDavyTEua7RSgSXEAOmqMOi+VFDTEZF8ZC6KJPZP9/JaDeJdXmMmDo9RdGmHvN0ekJeOTv4BAdWRf1xUy4Uy8Ftnt2yZTplCh2EQeK0AsciHZ+rgOU70SbIH3QsUQVs3rGIH6cIECZEmZanCjeITPOAlX7lm1TP55GBc4JpqlasZYq0HdlEZG5shtKfKz69yI1kHgr1wyqOQrEFJKU0LgQ9chBPtuwuTsRmQpe0F9/X1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1Xhwzt0jfB1MIU7g7Kx/BMAkdp+m123tlkNUdvafG0=;
 b=vR08rxlucmPH5SVorAUdsI5kYkxW1b3qV5af8d5SPGec2uOqMqBYD5oQ9a7z7eeQbub+/fj8McfUYvDKcrJdfAw9M7jCklo+fCUV4sFH+YzaNGhRT6m0oKiA0D5UxCIYa17cEPb0f2WZ4T+aehXsUBb/Km8L8bbJ9sws3sMwDFoS2jtedaBYJmIQsZpZLT5jNvs0tTs6Xhb3qr20viNmOGf1CJwest/JJgcRhm/udrcS6jdcoP0UR3Y1HnSkIX7KYwvLtpNVyhcuCz8kXfhuNvLtfkHtmY1ZL6L47Bty8ckQ4obLh5tlyGhnVC63mPesZfwq9IAPgJXgrvEm4O/Lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Xhwzt0jfB1MIU7g7Kx/BMAkdp+m123tlkNUdvafG0=;
 b=EzYSqRpbTs2t8M6KsGmkSXAPWy1mXS/FhzKbq+GZu+07tQqso7BxMYIERk8mif/EsnuaIM/4i9+vBM14gM8jQ1O1EdQuvB3582I5NhcnfP/FTs80XdaPBiWjVp78BHQ+zHFdZ+b+ABao5+gJqADpEphi+ZzjFNBYwJtRm3XNI1qt0StCgooPW77Ls1nxwvmz2ghHKNULaz9FtYkA2unrTvaxwLtNMO7gKfnrvTTLg/WpRwsGvC3IfNWy18ZOD4jk8+51oIZGh5mLdSripdiN0Sv3Tk7yOvB7NncJx3jmAUTtYaXCNPguIT/XG2xvRoauLAoD6Upc4Kn4f5lfuHscPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 10:17:22 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:17:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images 0/2] Add RISC-V Architecture Support for EVL
Date: Fri, 10 Oct 2025 12:17:15 +0200
Message-ID: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e877727-0486-458f-306a-08de07e63342
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4EDFhfJjlsK0jA65LioBdEDzD/8xWVHVS4+dvk9+ee/DdqrfwoG0UrzEmCyP?=
 =?us-ascii?Q?mPSuVLhM1zZbYsFGlk/2FI6T5WpHVrvdTk0x8GsTnO9vXH7eUa2UyOCF/WHQ?=
 =?us-ascii?Q?akZPKH9YBcIgOMJTT1vU5LfjjApEBUz8Gj5EYhx/T846pvEF2xGB+G0eFETi?=
 =?us-ascii?Q?b0tGD7SOAv48hBJhYo4vrgbHd809hINTMCkPQ8iJowuvgdA0n/bNI8QHOhdh?=
 =?us-ascii?Q?phzckMQgvVc/K7L/SdISwl91OVkn7Nl7sBEDLVftXcdLk6q5ztJc9gVap2uO?=
 =?us-ascii?Q?nvxj7d5CO/FzNnLKVlUA8jYlOzJA93QW9sWRWOdDRDtcD8NPsURVT1z/au4z?=
 =?us-ascii?Q?lLfzk/HCZnEQ88qEl0x/Oe0MkCHRGFImN1FWEXOMPWhcJmT4P3B5sxBWLcZm?=
 =?us-ascii?Q?+ziTJXJhjOJakRQbEtlONLKSNpk9Kdqr8tlG8d9MOPLEvyXwELfdPnOYNRIn?=
 =?us-ascii?Q?wm4CESS7IuqCC4rXCFyKmTlKUzCXI7kqND1ALeTdh4/JAgh0AIOMYcRBl7U7?=
 =?us-ascii?Q?1+y17LVHlP7SrCBkDybRukot0324VzIbQEGBy1KFPWUz/PCXK3IbCILAsuD/?=
 =?us-ascii?Q?ONb/iZt66GkgzkpmOIEeyQGq5VqsV8qsNwKY6AgDisyospCmrKvQ6rWo/KdD?=
 =?us-ascii?Q?zhVZHWNG8maZylHL8HwrNHuDTUZzak8HQuUrWAmm+tW9jSx7wCrT+7jVzZG5?=
 =?us-ascii?Q?sFdmdwDD040xDye5xvJywQGrv0mocBnpG332uXChf9AuuexQQI8bGaGOO1w3?=
 =?us-ascii?Q?jghoB8d/uhNa+Q+YhU/vDER6Df9cGqYk3AteL52KH5UaRM0cCwktEUIE3Uj7?=
 =?us-ascii?Q?RIWc9KwDHpt7yEhrJe/AT/BdChT7Gb/JTruCqHHND1/8KmB05JnwxoGiZzye?=
 =?us-ascii?Q?JN3dNbmtN/RPgs222ktlrrRGf/pJlHWmAto4dblA/JXQ8c4TB5v4CJVxhL5x?=
 =?us-ascii?Q?PK13YN4Z0hF9jR3jpZIF4ylLKmIqBL7d9cCFoNNFK0QiwXaQAbgB+0Lsm0Lx?=
 =?us-ascii?Q?KYrsbXgByT2BcSRHtCN+SHU6gyzyU2TAv+hp17o53nXLSBstSoMlNRiCV2VG?=
 =?us-ascii?Q?IFTKciWmiZoPDLNvogqQT49865Cx+nhc0mtX434MZnAPm948FZ7RVq4aOom8?=
 =?us-ascii?Q?mheAdKVgcEzqabYq5A8+EV3UrKfGmrjPqCLs0hAIGDJBYiymNsymslsq7Tus?=
 =?us-ascii?Q?/IPYtkbzGWqJsuXxy2UPo7P4v3cC4JWS1HQvI3aTGN3KrwjGBoxNODNpdV7Y?=
 =?us-ascii?Q?PRn6yUkubRk748GBD1jZAu7TMzU2G3sVHQruLckdpnE7D0ouzfVnwMSo06fP?=
 =?us-ascii?Q?BEzgLUB5C6ZPfmipx1ZB7KqGJUQW9XXX4ReDp0kpFqir54o7PXvIj1GpKLg2?=
 =?us-ascii?Q?u6W2EaQlG5OFQVS85mmJBZ7bDCwi9X2RhNA/Z8rOi7wuzfBPTuKwGIXhq8rj?=
 =?us-ascii?Q?gj4OZJHvvqJK2L3gkO4gU6DRFSW/3VeQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9CxTXW+4x50JSZWdYZjVRpRzQtOd74hpoSkzlsUv4xTHip17vtu9fTlnRPe?=
 =?us-ascii?Q?4zyfBcDuyqQTqkT5+NvuERm4TN7VZTY5gLDjEjz1mUHmzOR+am0ZSUvSClvH?=
 =?us-ascii?Q?sPvBnH2Qa4U9vQ+AvAvyXaqs5peuC9I94Nn7yAt8TPV+Pdc85MwHcv5kPEVP?=
 =?us-ascii?Q?NbIBwD4lLTSrRK9ZHSrbpPgy8ZNpqmdfKDkxxsjlW9DvhNOI3IjMNK17CxPd?=
 =?us-ascii?Q?Hek2Q6btDjz7qYVJge8GD6p9uzVHTIMETPuEA63bMzUcMJtNKzzOL+WnD8Cq?=
 =?us-ascii?Q?9SED680aHDTdl/GaXJBmfVbgdkhA0W4JKwTuF+bTTLgUZau9lgA3pr5yGlMe?=
 =?us-ascii?Q?X1zki2/Cns2T5r40qm5RsOltUXinh17m2vvJKt7MVu96iCd9/rtUponFD63u?=
 =?us-ascii?Q?vysEeFP0WTXoFsPIimKCLQKpSz8+zKydUcFy7ImhfI4T8K+KOBD/CD1cEuXr?=
 =?us-ascii?Q?23bYv224+rcvATFTA+m9gA0Jm33Q+sO+m5eNC2RHdEPlNkWtEuXLmG569xCv?=
 =?us-ascii?Q?n1JH5Idm2mtiiC2Q8dJebgJIzsoDRx42ERNb8kbMHfwdaSqr4rcsydeC+QhZ?=
 =?us-ascii?Q?B4pxDSaJufcgZ9WzIJqHCWkQyf2gVzpQYLvkuUlwfHheMV1Jxx84WmehGeKh?=
 =?us-ascii?Q?8POfcAWnHzDP0U8ubdLvWNM/hoWsQ2SkuxiYpHhl9PHx2kgAIcRZvFlWBkXB?=
 =?us-ascii?Q?nPWjHNb9pOaRg4xuPxrEYJSUFF4Dfifk0bufc94DgyEnOHINDeUCOmGvSRnV?=
 =?us-ascii?Q?m42LsmK+sPmdZGAzMLkxymQ7nIDQCZ2oO3icLCO+gLOiyqM5YGW/L0SoQSUN?=
 =?us-ascii?Q?8MIXC4B6vWFE62WEmdczKbwA4oow+NPGLgKk5IGyu8hfOjfxOd7sobSaJkZ5?=
 =?us-ascii?Q?mLvPbYbEHPJCSOyt5jMGLBA1R5ZXXN6BoRLL+S5hhDVnvBz27HLqv0GCw5g1?=
 =?us-ascii?Q?DY+v/mqv4d08ka5u8kKujVXh2pbrg5dVdFgeVufaK35oGTmsTnNMflMea5wL?=
 =?us-ascii?Q?yzCyDSLb/nnhshYJOcq+ZxOEygJVKUdeUmjbQCkupLeysqXw+vA3SGgp39J+?=
 =?us-ascii?Q?WzueMSqQtVNwsF2Pof34q525e2LHcGbkxTC8Wi0AkPEpO7Xs+lIMYO4GUdTo?=
 =?us-ascii?Q?hRs0+rurrmc1yAS5HvHjFQgnIGP5ni+lir9luUJHaPdTTZlkZ2Y3KhXaO/6f?=
 =?us-ascii?Q?JJ6p7xcvjs+h6dDiuXD8pT4SIrxcrd/5RM2CI5Wsnm9PiXeqU15kl3fBwzks?=
 =?us-ascii?Q?gwPHxUNqNwHdyVUO1JXtqf1zRnhO0aJ9Ub0Iqy+vDXDbbzn2nUMOAZkiHOxy?=
 =?us-ascii?Q?w8GmpDYVGfPn+kPO9UHq20qJhkJ4GavOMwwXLHFhi97U8+Wb/9kAbFP+i1U5?=
 =?us-ascii?Q?Ly760MD88Vi1s+cAhuUD1gi418mJ4ZZjSkiP8qASSISBpINFbFjwOLdEk2zp?=
 =?us-ascii?Q?noiAhRlqi26DuyGTDHATet2Dow2Ug7ZgiB4i2hlSBQ874Hi+xWpIuuZFUPRA?=
 =?us-ascii?Q?xjNl8lbAtG5x1BwBfAkAgWXAAiAFJnknSmRZRqXd6AsiWWG5VKsNuXxXoYvE?=
 =?us-ascii?Q?cWSIA73PTduIxPlXF8d9dAzbZ23FPVQbHIwKwN0KaBi1cbD04cWyLAi7Y7Xe?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e877727-0486-458f-306a-08de07e63342
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:17:21.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsUD2UYgj0BH5A4O1SbMZfmV4LEffQ/cQ2OElrm+6hdLd7P6AUiC+Pt3yiX63K4tI2myTuc2sddNO9gL3OHANCngSOm8bYdrhUzXx8LJLCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3560

This patch adds the necessary changes to build EVL for the RISC-V
architecture and to boot the image in QEMU.

The patch set is intended for developers who want to experiment with
the current state of the RISC-V port.

Until the RISC-V port of EVL is fully integrated, custom branches with
the EVL and libevl RISC-V ports need to be used.

Tobias Schaffner (2):
  riscv64: Add support for RISC-V architecture
  start-qemu: add support for riscv64 target

 Kconfig                                      |   12 +
 conf/machine/qemu-riscv64.conf               |   14 +
 kas/board/qemu-riscv64.yaml                  |   15 +
 recipes-kernel/linux/files/riscv64_defconfig | 7378 ++++++++++++++++++
 start-qemu.sh                                |   15 +
 5 files changed, 7434 insertions(+)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 kas/board/qemu-riscv64.yaml
 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig

-- 
2.43.0

