Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE983563FA
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012192; cv=fail; b=LbffILUAwS4+Tyx+uUPuP2PCj4pgQFurMQ9/EGYNye5fjmMICtz3htrz0j0Kb3LPodhg7jMTbPREuVhYMoBdQyp6ZuLBh1FteyS/D12ofK0fMEfNTNTA0NJMvi6NI/6vgNqJws9hHQysIylwapHBhp1qxQRr26eVoi206ATItCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012192; c=relaxed/simple;
	bh=RNbIrGBAi+oxnw2TArSwpxGdTStKFN37tINokZWjTcc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ThB7KORDCJnJxZNXOqkap+tFFql5QhXyeVN8IJUhne/dxEZeCr7p5z1fj8hrj47wyzs4fCrQGN9ZHOAIjhb7Kh/tGrReiooDaw3z84/IGb7ERUIElsWjFZV8rIpvzvgttJFpi/bz8XK7t0KjKBa4oOYpbKId2xQq1IU/d0vOs08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YomESMMy; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YomESMMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOepqa8HK1h8o+y/CY8ZHNzmHrCke8sLb5NUBdLGJMUKm6M1nv551HFufU6p+n4xNfX+qX1Enew1Hg4UZH68FRE9G/I/8Mta+7srTSb8R1euvnr3MdOUX4pzAnRsWpTb8Ryj2e8GZXrvSERu4Sf5yaZ2q8QKOidXAVUK0Dh/ZM9cdbyLMtrPIKHI/ZAYSyfoXdR+Dh5fNHqCIPF7fItZLTTlav2Hp8oWU5otBF0jo6NTRXlpblPjHO8aktGYwCW0f9PQOIB5u4ctdN3pU0VDUgwm9RzsshkwQ3Qu1pz3iYza6Eo5mQEhWH/riCxiACqrFMxF4dT+JqJBOPzXgRmLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP4kJWb88dkH97xm7N8Py/crhO/Am4H7QfTGeW1vd5c=;
 b=dZMOaZG1qQn9Y5t+UBquLstIX1C+UhgkAoC8PeBdVMTbvjez1nr4Zgxl9wSqDHv4xmgKZ7xMC2GtcFwCDzo+h1ozG9oMolfh6UK157FSm2VQTiYPImHFDxsXVM2kjjSNemf5WqxExfKkW4ayEKnIvMoELh/mhn0ssrzFc381JrSp6N68Ueo38ZIWKRqvnEMgxBnbo/2jr3szcdyrEcYqBmIm7oh3ehtOC1lSScye+W1rB3d9QEaUUDx9eXU/LhO8jLCQ8DWJYfbDFGW9XBoHTSeFmF0OE6i5OR7qNzsig4OsDz0djFLG0a+Pd7AulsC/Vj+vG6j5fG8CdAqYbqRBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP4kJWb88dkH97xm7N8Py/crhO/Am4H7QfTGeW1vd5c=;
 b=YomESMMy4YAiukdx29X2zeeju4BqxaSzR9rxN171R85tru2E7qB5dSU5zS0O/2+FjqUYml7tRMXd4uepjwmUT+kZEP6qEGarKAsYFoHTI48c6pCWRItXTXefeKNbHuU9cOs2LdFd+tc+YYs+EW5QBvnm/ymY/jfdxBdsJSoOH7GILmAetQIRgks4xg5Sv/bsDACxlTLFbCxcdHZxEJiUznxE2FAKX9aVwM9FYcbDX/QrjC2qWU6j4+WCr2MqRLuMrRvOA5whRby3jQOCj0HN3rYkZqKo6bBvj7xxE77komEZH8bWb8zQVJm6nNG3jR9QoiqJfFk+a1uxhMBF/GuoBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:16:25 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:16:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 0/4] test riscv in xenomai-images CI
Date: Tue,  5 May 2026 22:16:13 +0200
Message-ID: <20260505201617.148513-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 36805038-2359-4cc7-63c7-08deaae32e89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	PUogD1RfBzCQH6ymjv0jBpUgxRV5YYzCIBlue4m7sNGV7v+h0FVvYU6u8AKgwlFNeRklTLCo8uzZVZdFi5R11LJ49+gXSNMJabXQEK4y0A3+DmxevCddN6jbjv4XSDPJj0jrtkfXJKwo7x19D4O27JSI3UF8nlDdFXn1CRQYvF8IVUCgqi4YS0iUl8If0reStcMcKSpM81/E0cU59uaNyuK6PfqaZmyOtI69SUzbt75r7515hB7qYCzbKWMr9envELp/9gYviuvK8DFSL2XGNeN1s2sxEDVMVzWaiZsgPp/Vo1P2Z3It7qYpCaoejqSTc1d6u24rE762pHvvg01a9+VmJIarIaKql78z6LaRbo+0qUf0nYta9eci5PzABXUMsUNO26dk/7rnJG/tn/r2Is3Iata75hY0Xn1ry2Sekv7LeVtSlhwOm/1W2Bt6mcGVR2McsgRF0lmr1kAqunZrnhD+tlteLddzKQ1LrarFoFX8JQTu7v9GNqqBXuzJpXZkprJ7CcIgwljDZBGzzmTu3DqwIz75tQ3r0eHQR/d+h6eHRB6OFsDT1y+E9LHGrbrPMJ+pDsHGTY8BIRzdhN8d5mDmn6hx8zkRgM6Aus7JAcjZN2t37u2Q+BTPHGSz/jp3J3hmpER5S1bwxf8RbEweDLs76I9XCMOmlonN5Y++/bGkxtjnNqjxOxyk59jOKX+fp7D5P+azkrP/3TkWaPnB0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDGFUF0cNH6lw8NjX4s33g9Cv0F3JSxHQPwQtpG0ktMo7PEOyDBfuVN5BRfZ?=
 =?us-ascii?Q?tcQqaSezoo1I/GSRVQiePYChvn/oRx5HzAWi4frbdUrX/X17E1WJUmQfGYly?=
 =?us-ascii?Q?/M1kmSBXb46Vid7mFW0/gBBFF+chKCDLJSDQZA4FD7v5IrBSCLFsdNeCeXyv?=
 =?us-ascii?Q?hdUN5WDy6acOcSQDcdH24J/Y/fTCj9oQF597zqCWOZTz5japgE0G/bNW1YFn?=
 =?us-ascii?Q?KH6QQIufn34VHnjhjW6ChdVws6mDQ8knaNoem2gn0UDzNyzzQxWpOYbtf+NQ?=
 =?us-ascii?Q?z6HggwV7sDzMxjeP6ezom81Lmz+WMgCjnUeRGsXrLS7Kfhdt7vjfuVtjmGhx?=
 =?us-ascii?Q?PPM9/dfS3hFWYWhc/wwQcNbE4UcpZ40NiZSsM+UgHmWS58LIvxbUAR/ZhOuz?=
 =?us-ascii?Q?gQUQtoEI7Gbr+9k9LQV/by3+LVTrewIGXoS2s35koMlZyVcJ4dUI1JEMKXiu?=
 =?us-ascii?Q?/FzMUVkXZcAjW8Y/2sMABMBz+5Se+HDu2AingcCPiXjKJgWsx+WXBHeEDG15?=
 =?us-ascii?Q?9MGtszeKyYwDSoaZj5LXNwibrXN+41An6meY+pCP3aNc6xR9wSlHCAPlPSf3?=
 =?us-ascii?Q?mXtaT6AM3S071B/kLjreXsaJr/0gXxDPDappatHP8HiVNjljI9mj0TUxok4B?=
 =?us-ascii?Q?0gMwD2TLpnZjxx/HsS0jh+16He38zjMebXajBptVO7RvGG5/uAhO817cNRiR?=
 =?us-ascii?Q?Vn5plegP9njpXvcaGBaF0Jqj4W6mGgalk6O3y5uwOYX2qJVDv/IJuPlrcWBE?=
 =?us-ascii?Q?lmB+02ZaGqnkzZxJA+2b/uKQ6wAgqkZ90RIqM0zwuaYRZPjNPbJobqrBSzg6?=
 =?us-ascii?Q?dapRJjZVH94bN5iXoXP0Jy7TKWcOxPL9osGKEfLjnS2ufLOGER2CxRR0ZerI?=
 =?us-ascii?Q?UKwSzysEyOgyPbgnUod1xbw3DDZMfYEw9GTNx1TGoGuYvHS7a17Wet1SwpIj?=
 =?us-ascii?Q?/4VaRDNXGfPRrm8OEw//5UPNKDfwK5WgKeR3eiItujjl1IIdnnjVQoNCM8tU?=
 =?us-ascii?Q?TtE2ingShInPjxreQpnewfgQxCcB5hC8ZaZUBmE3PGFCxIlMRqJe4SPB+Q+b?=
 =?us-ascii?Q?ohugpZtOg7WE5EYg1McHb3l6t6OtjzGfItYoyLSsenbIdVWRhzqeIv0a9jOp?=
 =?us-ascii?Q?YAjpjFaObj316FxZQ60/Yqd9cozxHOGulpJpGRKruVDNNsbs0vuS1wI3hjHO?=
 =?us-ascii?Q?b2NVTDMAsIxe43cdRlABWSiigoYCA8MUr3/r08uCF0bCV4SVJwdRmtWioaT7?=
 =?us-ascii?Q?cGA732i7Z98RBHbD1tV4PAAXAwiwi9/QsZT09oW70uCjLKRx8BzSEf8Ec4OD?=
 =?us-ascii?Q?i2/aPeVC+/QdRCZ11vMoGJgk0hPzvIB1qJpcu1RW3u6cx85sEBMjGuWpzzkf?=
 =?us-ascii?Q?LleKI78JunMjiHMN5yQoi66FlcbGzhatqPuPGG7a1WjXXUn9vYVmGbmLTn8Y?=
 =?us-ascii?Q?BkDuXWZ1qYtcvfHSXeK5UUksBtJQWOkgfjTi6e1PbNpu44uwt9FugX1AjOh/?=
 =?us-ascii?Q?nqgbQMccxcwtA5mrWXLaR2azOgIPHjaMOnnasOM8P/0qIsHDyv/hC33sz85o?=
 =?us-ascii?Q?kS+c0EfnD75Nrj8lDjnWrdTuFoWPei+SW1iHzPMSxZLTg6oySsrZzpFB45HV?=
 =?us-ascii?Q?LvDeIKKIiEWW7zb34Xd8jsX1pPoh7x7EECFU9OxmZZJxobFbnPqOrK/017bm?=
 =?us-ascii?Q?8p1HT9vNih7cNdOAxVF2Bfwh8u4i+xUoK6RK+YxFwGhRbxjFlbu1Z5wzG76d?=
 =?us-ascii?Q?/oikOFh3qMJeZFIwq0golFKsaQZUIGA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36805038-2359-4cc7-63c7-08deaae32e89
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:16:25.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAwIvZDNHMirAGg5R+7W5zQkgOoUdXqL4akW8J3DiagoOhJVd/+dR8uGc9wxDVSSMgB/zClfNvZbDyXNxNtXp7sMfb42WpxI7cGq90FHiFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8155

Hi all,

this enables RISC-V testing in the Xenomai Images CI.

It runs the EVL test suite on both qemu-riscv64 as well as the StarFive
VisionFive2.

See the last successful run here:
https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2500187079

Changes since v1 (the RFC):
 * Do not depend on meta-isar but add the visionfive2 BSP to xenomai-images
 * Use the latest openSBI version but stick to u-boot 2025.07 which is
   unfortunately the last version that supports booting from SD-Card.
 * Use the risc-v defconfig of linux kernel 7.0 and add the needed debug and
   nfs switches in additional sections in the end. Factoring out the snippets
   for all architectures can be discussed in later patch sets.
 * Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
   as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
   workloads from time to time.

Changes since v2:
 * Add information about the used board version in the xeno-lab to test file
   and commit message
 * Add information about the used u-boot version to the commit message

Tobias Schaffner (4):
  ci: Build and test the evl risc-v port on qemu
  ci: Fix deploy script to handle multiple DTB files
  riscv: Add StarFive VisionFive2 board support
  ci: run ci tests on StarFive VisionFive2 1.2a

 ci/lib/gitlab-ci-base.yml                     |  59 ++-
 ci/lib/kernel/head.yml                        |  26 ++
 conf/machine/qemu-riscv64.conf                |   1 -
 conf/machine/starfive-visionfive2.conf        |  21 ++
 kas/board/starfive-visionfive2.yaml           |  15 +
 .../opensbi-starfive-visionfive2_1.8.1.bb     |  18 +
 .../u-boot-starfive-visionfive2_2025.07.bb    |  30 ++
 recipes-kernel/linux/files/common_nodbg.cfg   |   2 +
 recipes-kernel/linux/files/riscv64_defconfig  | 335 ++++++++++++++++++
 scripts/deploy_to_aws.sh                      |   9 +-
 tests/jobs/xenomai-qemu-riscv64.yml           |  95 +++++
 tests/jobs/xenomai-starfive-visionfive2.yml   |  71 ++++
 wic/starfive-visionfive2.wks                  |  23 ++
 13 files changed, 694 insertions(+), 11 deletions(-)
 create mode 100644 conf/machine/starfive-visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
 create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
 create mode 100644 wic/starfive-visionfive2.wks

-- 
2.43.0

