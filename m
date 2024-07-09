Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBED27462
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514139; cv=fail; b=rS6t7wvAv7y+P+NduxkW8WGsqmAe8OwlKQ0NyLM8d9QU7E00DQdHW8+X2sSXYKEkheMV1LtXq+CSRFSq5wppDAvh4deb4xtUkir9rK6ZwXNSnAx0UQTh3lMUr4Ku3OKa7PAMBXXBGO+Mtz8TQmV/a17nlaob+rFn3AhMMqc3DFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514139; c=relaxed/simple;
	bh=om9wTfZgdN5UtEKJwPuhsW72aFyU4LjvDsxOh5JKobQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ktf19D9sMTWN5uMRj8bPJ7BbS5Bq3g/ZS3mvNM0YJ4TvhG4/XWIjfs8BudepKe6qhq5TuXYPkFOhZUr10INQmjSGBgeqOHETbz5DC0EkNLblItaVgSUPcpveOCFqXfTulYflQBBja98twZ13Lm++wMKYV7yUFgkc0/TQT5oMPu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dz007t/2; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dz007t/2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdIc3IQXlonY21cCyIMWOQ9nAxH59rEqB5R4NlIDPKjl8mQRgAB7mYsSdryym55eVaPbdQNR7egV8czK+/9LEt1DZTFeqvj2c6BE3EDTsRPaKImOM84AxGxdbUpPuENhkVn65RhUUD0WsEKAcFDFV+vswKLwPZU8JTZK9zP7qVRTqBBDJVqvVteFBSYDDqR0ETTNFb3PUyUFn3UCOwM67fnkokBQdFnMBLGrtuTtyAZSuJA4fvj5XY1IkXUKN+Jh8FXWpyeyZCvvts8mjhpizfmLK7yxYpDwWOR49eObeHOaFtA/QqZKHRUBYtsY96xgH4qqbj+QOm2ndKnAN+FeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC3KbyB1fOZPnBYpM65qn9mCuq16ac1Q4LL22PRycKQ=;
 b=XgQJ3lUplDrI1rTKpciM5TFNIdd3ZOvsJ6PHheBz3EvGtmm8Q7GN3f6Y/ShuoK3Ts80q3CbtRT82Td4gbl3n/HOP6Z0owFRGI/gGEbaBNkmIzxHlCxIOjGV//xK8DT+HhuZFg4BtNUxlOBv3lZeI80bZmN5nvyR9TKDU/p+AS7o07tb7+woxE+UqYUBG+de+Wq9bp7MssXK+wOoVXZkQba3kdnVOweDJE2x3F9uxmkrtxkWrP2yzruVlyZvRP6Fdd+g5dG3oJMSJNf2lQCB5YSH8WeHrZEkVIEfCtGVukPO9voHlB1RDUNPzGdemcBJXbCTrU66pspDA/yhON7XfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC3KbyB1fOZPnBYpM65qn9mCuq16ac1Q4LL22PRycKQ=;
 b=Dz007t/2FWzU+Kfev3eqK2CIWg3ymER4g52tWPthwGcRd35uRUMRCvB3mKS+OdReGhyFwVVfEKEQJfM0VXHGjB1bkGfDDrozFVbvreRkz8K8I68asvnPFY7U4LFAaYTngN+o0WdrvRo7978cMvSghD5iqF+iHrAc+7r8j5GdcxwNDHqFZjErAVmnsXl4swLSWYDSTwNocswh2uXDXTxKpAwU0Ii11i+jB8o/Tf8ecBFMgabKMA6lwoVZ17NAEIiNrur5CgtgKdYdI56DCO+pgygEWKDsdlwLy9vxMbuX+QjxLGVsncShcwkBNPvsnqncE5LfAZzarKX66mjke6gj9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:32 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:31 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH 0/5] ci: add long-term latency test for next
Date: Tue,  9 Jul 2024 10:35:19 +0200
Message-Id: <20240709083524.739194-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6414321a-a224-4822-14b5-08dc9ff217c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TWZH8/MdBUDJ2kGpeRw5tE5Bx7ylFEeypS2MB+Tzr+Mgm8sxEC/HcJDFhk1S?=
 =?us-ascii?Q?0DaN1rXYaMHhM1j+Tcn4OPQcrQPU75BRX08ZdsHJgRbq4iWuJtbJHbJQOD0g?=
 =?us-ascii?Q?U5RrivOwf+ToFrBu1uIiao/lyZgu48miSrXZdYCiMRY3fEe4LfExNMpHKZ08?=
 =?us-ascii?Q?OW8KF2M1VOkJVpFUeeiEj4CShLDAUpVweFrBpbE3WqVmIbLR5n43CYddmQ5A?=
 =?us-ascii?Q?6PWtAXREq2ebH4jhbr6zVhROlPPv9baiI2zxA4XDxMeHbSqfZ8jg6XvnGEi3?=
 =?us-ascii?Q?l9lLQPMRLOFlnqhvPqFSysXjEYZdvJRTJ+l4kfu1x5b+4iZ7vm1Qzq+9pVsQ?=
 =?us-ascii?Q?4Yu8JyX324IVymTD3MO+MOOJq8jts1vfxVpt2zt6d1FzNgvQqLpTyAtFVhej?=
 =?us-ascii?Q?sbrZWP+NiFzR6HSoeU6CXSVlhYDAzXGIL1LEv3XwKFTdTyPDRh0vehsGZt9q?=
 =?us-ascii?Q?U3vi7WEn/cIcTDsx6E182CFiG4LJi2/DBxkhBgKqT0s9j3K6uA1h0CQSdhI7?=
 =?us-ascii?Q?aBW0uxB2EsQ4pVMQgb+Mz3KYLfoOH/ow2p9UWxZRD/4Tbu9OKhZIFXFx2gdb?=
 =?us-ascii?Q?hBEwczNf1PE0pfXT1LloEYFQjteN1eNghopnlAtzsM5fXLu3fVehUNLUQ+5k?=
 =?us-ascii?Q?Ek9W9NwYmCaSkb+j3kQwHstXmdd2heIziwxi9Woox3nA6vHPhCJGAORChVAW?=
 =?us-ascii?Q?jFhwWwTkxkDo3LXAp81iev6hE3FcN4uizL6bV4PFlnf3/Vd5L1T4086gzrAq?=
 =?us-ascii?Q?9sVtyBmv3uokhYwQMEVghN5yww1HPrvesxEbrXqM6E88Sg7QE5jNvSXOpyBp?=
 =?us-ascii?Q?eCrL1eaQCAz/xywrBgQWTeAGXmRANvF6AhSYwMJAwx+aqHPj4rHhGWPg4Ev8?=
 =?us-ascii?Q?Zg922Hy+/8yBxNR3oDhy1Gdmhgp0S0XrLGgCR188gS65yPdWwMtLJUDbRWtS?=
 =?us-ascii?Q?4dEj1x703ctrnGzjv4yfS5PrqYHLkCwfpwMNJOfdLseDnaNikweTDdMwc6Th?=
 =?us-ascii?Q?/is5ruxynW3Gn/H/nqKJI4yftgojxFfx3EWZIOmNY/wLrUmt1BfnkxYr0uLT?=
 =?us-ascii?Q?LZHG38lnC87hhSUWv1/1fz1kf7pradXhepdDRGKva+pjq2yVC/ENbbmsF0IK?=
 =?us-ascii?Q?hSDpKQ9AmiWGAlgA2ebUesQDUUPqP7ezt2VpBnoUu1nuBFDmsMG6yvheHl5C?=
 =?us-ascii?Q?MtQN4vB6LJ6a7zjnmcvPKyOIqVqdF/kqS2BQ+zFzYPZA+YElp6PEKbO30U8r?=
 =?us-ascii?Q?GkgUx4B5P1qn+5zEXZ6+sRH0KH1xSDB+jR7NGFlFYk4gzuCpoL9ZaSp4bTvQ?=
 =?us-ascii?Q?6fVGS9wPlfqpMVTaiZHH2z8Gx9LARCVm6vspZyRkHI3ZUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcd45FXSxmdLz12iIURwZUy3giXcph5Z425qr01RvamrIcbMTTLpk4BXUj+D?=
 =?us-ascii?Q?2wGEimmGJuSATZUZQCf6RkrjVmrRlC7Jz+Mi8RDIrg/JH8rYvo8Qaobbtnsy?=
 =?us-ascii?Q?/pgTyaw4rxNoWuwb3HtuN2uHIjaBWMxcRjScaTzA47QrkVd5h7Va65jSpvuR?=
 =?us-ascii?Q?er++nQ6GVrYH7jVABrkQN9EAGWnlPr6a4COXqSy5rg5SuZd5XZQ/vHswAqmd?=
 =?us-ascii?Q?eYHX0dQkN5G36eUU38QBTpqKZzXWOI6hqdJsoBbbUhtA7dQRn5/R+mYe8lyD?=
 =?us-ascii?Q?52Zhv663oIsFPSdivIxyPg1KkL5bxOiplqvgBLgEG5UGVZaCH/Gib9lQZlEc?=
 =?us-ascii?Q?pql68fbDUnqGiI4ylf8PjtUP2WKz9OpLyK+WfRXvxKj6rlwQSOtFK1iyQsOH?=
 =?us-ascii?Q?TaXtJrC8YNveNC6/PTwekEw/iGtuSUkXGpSzEX1ekr1eS7DDf4i4HIfzWiT0?=
 =?us-ascii?Q?Nhbypg+LSOjWfYcl4/wazg7NvIq9JVcSZoVGtAz0FOknVScoOBv0nRt1VW9r?=
 =?us-ascii?Q?9h98PD3nEtVzN7omdrPe39LM9IkQZs0COu2itjtYimnODFDffMpad/SGTlo8?=
 =?us-ascii?Q?224t48D46uO5xR0AZdsY4QP0KVTxXk3OGPI7apv5A0RpJIj26A+vxByDAAtq?=
 =?us-ascii?Q?Eht7nq6oGrfZ2dxGhEJBR2GX5twSBFeWtmQsF4pghPskH7DNBO1jHdAfLlkw?=
 =?us-ascii?Q?S1bhr5eOEhm9fAysta6j/uJfJMcoN7VLJjxEtHylXsjxTNi0vPVA25QuLSIu?=
 =?us-ascii?Q?pKxNL2cgIjXA7Ip+btQtZ4c1svMMGcxe/XWcW70uSMEQrzbS+s+SQIdqlEQ5?=
 =?us-ascii?Q?P3AE8GYoobKkaDhDFRODtKMj4ypNOBZycgtCBZ87Yh/z5XVDUI/7BuxPSxkY?=
 =?us-ascii?Q?sI4cQ3FSvWbFlLPtphkBf1HzOWElFDFdvzF7hfWxD7K1825tinFEezq/ty5O?=
 =?us-ascii?Q?NIj3mGhKsBSxRGWfQkIIm12v0UNW7TaIdKsMi3DJ65A+KuD5HDMzMzWlW04J?=
 =?us-ascii?Q?wZXmPO0+7GuzbCR6+MSSt/vbprx4BrH/hSvDKp0d+QGiUpwPpkgn9swGLBAC?=
 =?us-ascii?Q?lByPXri1zdAQfO5qdv0sfAIjRr50p/fOSQdYcmMsC6EPx0+G1rOyi1nvLTGD?=
 =?us-ascii?Q?cV3Lue0v1Uah3WJMMHnCPdmSbEWZ1gEUg3Kxe6Qn/7XhvFyzDenpGcyEuUMl?=
 =?us-ascii?Q?inMkn2zVlqkUjpsZdkPhk0XEwKM7cZnIzF1cDVgdwHHD47ZwjAgTuYJUpDGd?=
 =?us-ascii?Q?YRNof4jNdOvmqxb5pDhu8wfyFiPxPrOJa2iIyCq+ZTNCUzVv2K/NNN98FJqz?=
 =?us-ascii?Q?+S93WqMxR1XCdNCbMMTv8eeyctGxUkruQzG4OsIfJYvuKA/bxz3M9X6qrKAO?=
 =?us-ascii?Q?hLWi1CCgI5Aff2ZozsE0s9fiT8Qjrlw7QIlHeZK56gjGO7JLRFtBTEV5XVAC?=
 =?us-ascii?Q?HUenJB3xKIhMUrbmhm6h6ELqiBcnLOcFA+IK14acra7qi+aRu+mEcMVAGT8T?=
 =?us-ascii?Q?Zl0HFEVe5Q5U4imm6Wu8cgZbVf8s0sgv2iCQ3L/LFGSnq1YZv/8OVaygAjtJ?=
 =?us-ascii?Q?whX+ibGIKFBkihV/wuoz5giMQzHMMDX5F1oXxqqlOaMhdTCjyRlz1habkHCX?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6414321a-a224-4822-14b5-08dc9ff217c4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:31.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL+HVTLpn4heKuHqL66xDkKpQ04z6yWOEkH42N+0DGQln62+1klgHRermCF2oM6ULKAA0GjCTSzCAyxOxKpoPYji9Jxgsk9zLzKyhfaI1Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Add a long-term latency test that on physical targets namely the rpi4
and the beagle bone black. The test will run for 60 minutes and fail if
a worst-case latency of 100us is exceeded.

The long-term tests are only run on scheduled pipelines. Therefore a
scheduled pipeline has to be created in the xenomai-images project to
enable the tests. Running the tests at night is recommended as the run
will block the hardware targets for the test duration.

This series was testet in our internal CI.

The custom xenomai patch can be dropped as soon as it is merged into
next.

Tobias Schaffner (5):
  ci: only use opt-debug.yml if explicitly needed
  ci: Split kernel 6.6 config into physical and virtual targets
  ci: Parameterize test command and timeout
  ci: Add a long term latency test
  ci: Add latency treshold to longterm tests

 .gitlab-ci.yml                                | 10 ++-
 ci/gitlab-ci-base.yml                         |  2 +
 ci/kernel_6_6.yml                             | 29 +------
 ci/kernel_6_6_physical.yml                    | 36 +++++++++
 ci/xenomai_3_0_x.yml                          |  2 +-
 ci/xenomai_3_1_x.yml                          |  2 +-
 ci/xenomai_3_2_x.yml                          |  2 +-
 ci/xenomai_3_2_x_compat.yml                   |  2 +-
 ci/xenomai_3_next.yml                         |  2 +-
 ci/xenomai_3_next_compat.yml                  |  2 +-
 ci/xenomai_3_next_long_term.yml               | 21 +++++
 ci/xenomai_4_next.yml                         |  2 +-
 opt-ci.yml                                    |  2 -
 ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
 recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
 tests/jobs/xenomai-beagle-bone-black.yml      |  4 +-
 tests/jobs/xenomai-hikey.yml                  |  4 +-
 tests/jobs/xenomai-qemu-amd64.yml             |  4 +-
 tests/jobs/xenomai-qemu-arm64.yml             |  4 +-
 tests/jobs/xenomai-qemu-armhf.yml             |  4 +-
 tests/jobs/xenomai-rpi4.yml                   |  4 +-
 tests/jobs/xenomai-x86-64-efi.yml             |  4 +-
 22 files changed, 170 insertions(+), 51 deletions(-)
 create mode 100644 ci/kernel_6_6_physical.yml
 create mode 100644 ci/xenomai_3_next_long_term.yml
 create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch

-- 
2.40.1

