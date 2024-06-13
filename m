Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F85C8C7
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286396; cv=fail; b=LivqSMeP27E00hIuZC4m7tMfguWaHDBEDFjQqiZHLeahG8LV798B+TRuiB7LWpuZcIs3zglSnsDJN8XDB5Og1KFt7fIbPpPsveo5WPFCE+a99ntMNQGdxaN4Ja76oW+3VdimMs/BpGNfW3Nhd0WU110F11GjPlz+QKVnt+7hdzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286396; c=relaxed/simple;
	bh=zC39ZbOeyZjcuaF01J5eely5qm84w3qsdZbZjFzl6uE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IPq2NoPJF0RQ1IGjJp0f18amLIqNmX6faQab0CSKCEn3z9jE+gYVoa/IoakdJJscCPM2LYziBmse4Vyn2cJDxCoZ4fy8vCzrOP1XjAITOLJmjjoRU7IUiyIMFz7V1rET6q/ODeFeUiKY5cIV7rT66vTD4oqUkS/f0I+47YK5gbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dErtCm8+; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dErtCm8+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB1qS0Uy4vAl8MV/riklkkjGRXZ4OSvPUQIuBsGY/pm3MSXVV2bK6pefcQWH7s3W8TE9zjyKwV3DihqY9iBjicWWPiaYDiJHD9u2GAl/tZOZoxw6jBBgLsvERraE+RsYZFLzA794VWQ/Shzm8Q4YLl9MibzVd1foEfYh7wom2sQsRif6DgAt8uUuMPodNbC5auxCUL2bTG+aDhnYAlKB+qHtvcmkbj3ODo4mHLBBCqqfShqtf18RUkfB7fr6JVm505FCccb92dSkXI+H3hhTsD/FcAElj+oB/t8KJsUt0uRnficGjfqcHIG8UvVTMjMEcWQ4IZvz/1QibFYhYA+YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A99myyu+f7MvbTkc7hldn0cg6dqH3zTbZ+k9mBrzXw=;
 b=PgIIi0nFo/ysBDVgq/flY8hqks2CQbhaQTkFA3CZYAogMrjub2C0EBG6S6Z0OInQw8JGYBSTvt5DzSYvaYqQnAWg4UVKBnG0lyQHiv8tYwSteSVG3E4yB1vyKco09cbVbA6gLRjBlsT3V3R7jwsrWQITGQ8S5/JAVfmI7K9Y5Y+2ZKa6GwhdTCmJD704xEkIugnrx0VktRwFozWPaQMaphwvbKDOXk8iwvwkVOcQFnCAdBmao4vtttVgEBO4ZUUFTCY+imOqaelaYtQkJOMRP+A+hrMFrVzhxKk79Jyaj9cpqjbuo9ACJ1zrbhPDtJiMt9hMe5i05qyr9Uqmh/XgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A99myyu+f7MvbTkc7hldn0cg6dqH3zTbZ+k9mBrzXw=;
 b=dErtCm8+zKhtXX8m+kBUTnhD16/Kwodta8f/SSRSBjihUTvwaydwX30YSLrTyzv8dthHI/LD4M/IuOAmng9VjfBFM9+cC9SUf4pvISbuYSv9lwH5QqX2JZ8QTpSj0tZAMBsYIrRxj7gWz4D9KpYeCr4VLrQ6hqcnPza906lE9e9rR0NdSPpvMKTYI1xthqfN08dC7eb5tQRnRU2kSHnvaFq77ZYAcMDKxmyUOZGWc0y72I62iQusu+LvJiON9fjHnJx+eQVB7/mj9/c3OaHIEunzBp8sbYBOaljlDWlvygh074fnyIlXzBr4+uesuP4FV0Y5XUBmNYIJsSa4l81ZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:46:30 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 13:46:30 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [libevl][PATCH 0/4] evl-test: align with xeno-test
Date: Thu, 13 Jun 2024 15:45:53 +0200
Message-Id: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 099e1a11-eaf6-4d8d-bddf-08dc8baf3ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76vgZiw4uPfaRRO5eVbAtiqj3xkvcERLJwoGrmuT1aUtsQ4snitT3oFUs4Jv?=
 =?us-ascii?Q?GApBQDSZqhHiIQqp7Q4UgQf1NQ6LtDcZHNv7RGzmx5q3M0HofNNcMMWUs39O?=
 =?us-ascii?Q?dZnT6a24CWiIKzZGnayA7JK6lMtq+yrlzsOYHGK+Rcq3qjcX+DrC/cWfP/Ip?=
 =?us-ascii?Q?iT8VFBGVXPiaujFsMvkijMIsXLMQ4eVsMkldRnExW+8iHYq6X/6gKKrgDZYn?=
 =?us-ascii?Q?dE956+jWN08pdLQzc1OT4FuOp+5X24jCVGS/KxzIQiu0+32Svg5pPQ1DGrsB?=
 =?us-ascii?Q?zgVtuanJ5D0SUw7nc5+dEIs7qfGRMwgYSYx1SewqMosLiBeFiHDsD/kijPZX?=
 =?us-ascii?Q?uFnNaLmVtiX608Gij+b1RnvYWtxiUq9KDYkMD6N2CzPWryq3PzVCQ1QPM8YD?=
 =?us-ascii?Q?L3cM56SYv4o3314i1YG47V4tHclgN829jTzIdD/Es1efbHmWs2bCVSgoy96Z?=
 =?us-ascii?Q?bUqNVuVSZszbIGZGbfDOZXu8IAa7LBQ8743h/oaASuOEy7s0p1pLYT/uB8ik?=
 =?us-ascii?Q?qOOM5a6PFwqlfFUskgcN3vEPkc5UtvknT7AMC+ZBvM32Lp1+zbjuEHNpsWpc?=
 =?us-ascii?Q?taM+BhQAYowdTcbD0GspUPKVZk15M2LwyMnMnjbqU8nMU+KA7R6lUj4MOuHy?=
 =?us-ascii?Q?80VaUmhrFH+zwYlLQUVwLaV90zbxGv5GrR1KJwzoHbuzJyo/Ia8ML8hGqZP4?=
 =?us-ascii?Q?zPz0wCiLY+C3y4/AnOujCtT8Kd0KMp5MW+OEqU7ChYhkxCajaOTCrFPuBFvq?=
 =?us-ascii?Q?jDE7j2IILyFmeijo7l0f4sZ9H487HgcOMbwpocL/Ocw1xaYceCtB70/wtY54?=
 =?us-ascii?Q?7FL474LgJE4pCzyIoVak7/FAbYi3nPme6yfcCrM1QAXm4NaKNtemqzKBUNZi?=
 =?us-ascii?Q?fOGpI03TruA2ZIymoIzcWJefv4Wof5J9JwWgS6iPcy1Vt8MMw3l8Jg6kwH39?=
 =?us-ascii?Q?tqpk971orJ03FySwIYeKJl2bGtj/YBDvg3BKJ8HLnlMI7sXlB16scBITKwS0?=
 =?us-ascii?Q?7Z+JXoc1cw9jjQxMP/18MOcqG24ExPEspYzHwDNGKCUds4gk8rjh4vqQ1YFg?=
 =?us-ascii?Q?2cfYJBMQ67iEysSH2YAY2YHvSvRu3Sh4Zm4o2exsx9HvcnR0W2Y6fBe/+W39?=
 =?us-ascii?Q?Shc2v+W13HK+OWpeC+mrC0CONEklt1e+qOtTeSRZojvPTCJ17Ssd3t4CF06F?=
 =?us-ascii?Q?blaHf9/ycII/gePR7bGUMpM+yuxsoTSk9sxF9CJ7pCmPeeuWa78VePPm0QjP?=
 =?us-ascii?Q?fhxB7Lbko/i2b8ZJxbePyaYApJYcyCs8nFi+d1h25XLWMjkxpqD/ynKuYmxJ?=
 =?us-ascii?Q?NyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMKXJQ+UsnR06MNYtZqGM/SUWXiu9fb1EUGGzq5hYoC6t8FA/aLFPg2t4hzZ?=
 =?us-ascii?Q?DCmyc6up0ffoJ275P0kuDq9TyaRnEtSVKSWzcRq1Y8JA1dQ2p59lVIsR8Mex?=
 =?us-ascii?Q?Lu32Jl2F0GB4IqLBXaWVbPAfN3m40nUJHrEOhjbDxOir/GyETfCoBDo5hMmg?=
 =?us-ascii?Q?VwydLD8pfKxbPgGAyI8fwihCne8ljd59qB0gMFgm2PBjYVBoC/9DFqu98lhZ?=
 =?us-ascii?Q?a5+vQgQLP30kiz+owa4m2ZdeM7oZk3OelToKmIgqYWs3iYx5Hn6o8qYefhF9?=
 =?us-ascii?Q?/4COvO64Q5LgMTT/VJ8jcrEBWlwoZkoxNNF4P6yT9BKhhUiPzdpmw9TyXkf0?=
 =?us-ascii?Q?Dd0ywO2IJG9Ya8YbubgY23ni9h1rOLdXmcMl1L32qc6G9skHnZGUXGHeNpS8?=
 =?us-ascii?Q?Sw+wGhB2GoL1JoQHJ+dYi/Muc5Q598R0AYnmCUIerXfOTdH6tIChL9W8IBXG?=
 =?us-ascii?Q?IPA86VcHqXdQ8SmDlj7Zc75j+WldDrnXQ8JDPtmxEwRWmy2tAnlXNzydOT51?=
 =?us-ascii?Q?l7h9tSRtS0ZUQzxWT17Pdv+SMP2SxZzX6Rk8zZeyGW5PVy/3cl5WymF/Wc2B?=
 =?us-ascii?Q?LQ1WxlTrjR3+ND5iDdfgeXCkPFO8HxNfqGp2F5DhTuVtt11rD91J29XkcV2F?=
 =?us-ascii?Q?fg7FlMge2ibwV0F100hdzWmgGMlVA6VMsEK0031Ik+5d6zIb7gU8a2JgrU1l?=
 =?us-ascii?Q?ibyutofHhXNI1F0QTFqmGV5I/0MzkGm90lPDA3EtakQqdXiWTrgAnmaByTCV?=
 =?us-ascii?Q?TPnfcalIz71VopcPkx2PrAD/LdJME/XV2ag3UxWhdHpaAY+L4InZISGDB+Wy?=
 =?us-ascii?Q?VchZIXwanhU7z88k+u+CpLNd7XkNqTUZ3keD+9XESqE5+RGnbysK3Gmy1d9h?=
 =?us-ascii?Q?3w7VCgXik0GVXUhug0QTKjmCQdRj1PhkvtS6NCj9ZTjv807/qE30dIj/hOXz?=
 =?us-ascii?Q?66O87Y5CtMFdATZ2AI1b7UGYs4Ogx0QA6gfru39BNiXXElj2xZNWvDqaH8bF?=
 =?us-ascii?Q?4hDhBIDkTIQAjXolZK2AWHRuQCb6eCVsYSWBiYwww5eMWcGSVNZhMQML+ocA?=
 =?us-ascii?Q?AWOeUEoK95abQIH3kOssQqPxXXWYqy6J4sKateVFOfa5j8ne4Bo3YTv11XcL?=
 =?us-ascii?Q?TudO1ZJ2D4re5I0P+mbJoGEtx7n/Mpw3w7gdkVKGcsM/kvSXRqdpWPovT+ac?=
 =?us-ascii?Q?M8z/pJO1oLFIfG3MYkHOjRpAfR5ffW78TGSWRYKpxP3vganTrcMagt1+fD04?=
 =?us-ascii?Q?qD4b3Pv9HeBZH3apo1FhNQWdMtN9xWSTUmDmSviUzXebmtBKUhxaE+aAtbwK?=
 =?us-ascii?Q?yp6GOfKgv3HGx0w4/OeokHI2eCHgR9Yi1AINYCN1BN51y/Pt743lR7K8eShn?=
 =?us-ascii?Q?Y0IbXHp2T+WkYCIGF+A/DTSWJYGiapfCDaxOTQ1yBTXPH3sURUEbOUqSa0kz?=
 =?us-ascii?Q?gOUF7raanW/sIQMGIomHTmppv24vPOaLaqaYkUxLyugFHmITdaTBE1TpiM7z?=
 =?us-ascii?Q?ZNnKYLBtE26AkHSu+PmhYTvwZcBF/zY/kVu7skJRN3AhajsTPp52DrlA/dvg?=
 =?us-ascii?Q?CV0a4rM4/wzOUcUM2Aql+Rk+4sbSIh8HtTZODsbV7nCDpHXupt08p+3zDxJo?=
 =?us-ascii?Q?kUWBEPFMW3ybuPzw6k7D5ZPl2HyDioXUKyR/9QIFJErm5DuYo4/nHpHh5AFc?=
 =?us-ascii?Q?VhZ7tA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099e1a11-eaf6-4d8d-bddf-08dc8baf3ad8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:46:30.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBV88D4MiDelheyof/wbiUgBAlbbm+cSaZy3qcHO1fAso0T08Ya9Aht03/3c0jy9WdXADw8wWkFiyBuxcKZd85ZZwc0Xh0k7mBzwID9lV8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176

Hi,

at the moment evl-test supports running the available unittests. This
series introduces load generation and latency measurement as present in
xeno-test. This will allow more standardized testing and a basic
comparison between Xenomai 3 and EVL.

To list the available tests --list must be used now, in favor of using
-l for the load command as in xeno-test.

Load generation with dohell and latency measurement was chosen as the
default when running evl test. The combination -u -l "" can be used to
run evl test with the old behaviour.

Rel: https://lore.kernel.org/xenomai/cf01659d-e800-4e97-8246-a4418cf6f4e0@siemens.com/

Tobias Schaffner (4):
  Copy dohell from Xenomai 3
  evl-test: Measure worst case latencies
  evl-test: Start evl-test with load by default
  evl-test: Add hectic for real-time stress

 utils/dohell      |  97 ++++++++++++++++++++++++++++++++++++
 utils/evl-test    | 124 ++++++++++++++++++++++++++++++++++------------
 utils/meson.build |   1 +
 3 files changed, 190 insertions(+), 32 deletions(-)
 create mode 100755 utils/dohell

-- 
2.40.1

