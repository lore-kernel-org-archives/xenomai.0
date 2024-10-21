Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE81F8EEC
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539671; cv=fail; b=dxWD1ep1yua3vliv0SSo2YcsP7zwyz8oNBx9UdIqYcOZYxRia77haB5CjDfxZJSmRuoYepOr6OosWKIePEaJkXDe8a0XgFYz7q1bwfqP8NJ9Skzat9rCFq2HY6gEBmv1XfW7WFTMppU25y0R9t5fAyC42Vrkc4Yqt9ME4aVespo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539671; c=relaxed/simple;
	bh=XkCIpZwnv/ISfU1nQm97BzAOCqNgK5pBAi3lxtvro9Y=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=kHwNT9AuIgnmlHbngSLVuhnWHMp4UPZ5pQDT/FNeWon9HsW5C3XMUgTqlPcv8n0HtfvNcrAXbkGrWjjsyWfpiPgEG2uuGfYfB7bv38UI8T6jnqw9HuA5teBwYiMuNGZCNCMQxobNGlKVa+8CcIDDFK2HMKeb7LyC1Vhrox+wkQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aeS30pBO; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aeS30pBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emqkN23au9fL11lVqWwC8b8RaqPp/VINn+5U1biUPGUW/azaWve597vkL62qruz7q19OeaMz2tJbpGFSdHoPy4Uf8YSYFWZYuXLbby4ruhIygDDyLHksNXYQqbSJomcL/h0GX57iGQ+dr96oEX7NTeaW47z+IMcj/8DoaH6X7pugiygd6m/lcLa1O2zjIQh1n8TTrYqSOmk36lS4rrpEIHncQqUjiRy1Kquc6bcDT4lvshRK4uauTRcNcvyv1TcID0w+/BZN/NAF6NAWdMZ01LYQPHpRDC0QoHzjK2thDP9LuyIEGAeQvKNx7PP02gytJDXns9AOEPPEIXClFgwmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zoo35eJKdsHrYNC0ds1FxKKV3BYiO2/H+q1a6OxTobo=;
 b=seeTcWQV7PwgX9JWNaux82ukK8D7X9glmLocuZqYbSFZcUCXpxaz9W7l02kG2iu5kLrP9UtHvQSFyD8fh0BbKuB+TVZanLZwtXRa40cYqoxHac8vBdOHKA1XpWHkK4PasiJ/DIXLttpIaiF9mkrMfPrRiUqsYkkVAXzywD5NR9HuKOiGsnEhrNywIZ2zoO2Yg3TASDO3aOeVRTLboJGqC2kVpoxsKKbtDdV3vGrwNNopcZ2rciZFLC9GLQDFvRUaSVg19zuOJ2nConi2KP/kL65mQ/QRd9aC28tJI3f5GL5HTNW/QAcCh8RAfrQ5z/hqcz1t1+/BEy7GtqkvLhkdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zoo35eJKdsHrYNC0ds1FxKKV3BYiO2/H+q1a6OxTobo=;
 b=aeS30pBO6DcaScTryTPtC4aX8srk/KI0NKD/O5OBtSOu85+HMGphkMCrkdaO0yXaF62k8BAkjTnDCESHjn/DoB9/VtkOGMoHjkX/A96qb5+NBTEJDiOAZa8Hdnz9OLlpNvy5px2avTXjg+NqhTv+CQx2AY8bNiIyJcwC4fgB6rxU91n46JqmvarFI6iMPVdFS07vJ081QBYPkKl9XdcFXsM5vo7sHV7ePpO96l8oOfaBhwDf8Cx9oD132mziR1LlQ8QejAyjUjnzUx/aq10H76gdDgd5IWGtH/b8MuVwvtW8fu2kD5XkK1BENsWPmejYdNqDcmLdAAMKTfmc80WD4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 19:41:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 19:41:05 +0000
Message-ID: <e20f90ae-d59d-4e5e-98bc-ce99bb1ed9ea@siemens.com>
Date: Mon, 21 Oct 2024 21:41:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.6 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc5d806-507e-41e6-07a0-08dcf2084da5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZnaEJRVWRYcW1SOThiRW1haU5pR3k4SGQ4aXZoK0k2dkYvY3BhdnplV3Ju?=
 =?utf-8?B?akdCNWlOMzBBTEhyQTZabWhXOUIxbzlRSEpQWHBlVlc4KzF3UkhiTjdVL2Er?=
 =?utf-8?B?VFd5NnRrdU5aOEJGcmRCdDM2Q1hWYzB6L0t1TFpiR1Zab3JtOEN4dXY0NWRT?=
 =?utf-8?B?ZzlTNUdjOUpRa05jczc2QUJnNUJqTCtoVXREYk45SEgvY2Q1WnJoS05nMUNU?=
 =?utf-8?B?YkkxQjVSN3RiWUNVdnh3dHErMFRxeGdsTnVqMDFYT3BqU0UybjkxbnByVE1S?=
 =?utf-8?B?eCtmNnRXZDYxUGYwcVduR1QyWmhkQTAxdWN5ZDJLZ1N6YTFCQlBkcjJwa0JJ?=
 =?utf-8?B?Z1RWYWl5VVc3NlRpZ1ZqOXpkSFVzQ1NyelBJZjJsejMzb09lYzNTQ0Njd0Vt?=
 =?utf-8?B?dUFFdUZRV21ROXQwUGlMa2pYU3Jab2U1ZnNHQ09ua09FeXBiZVpTRzUwUlB5?=
 =?utf-8?B?dmdIN0kvUXBNdmkzZjRVdEg2ZjdtQ3FKaXJGQk12T29pNENESHV5dWV3RHRZ?=
 =?utf-8?B?NUp1cVNUVzduSnpoUFpFSmNsNHJSdmZNRW4xWEw5Skl1R1BsNjdTaGtzYXMr?=
 =?utf-8?B?aDJlT0tlMWFQWU41RnJZTFNZQTVmdTVoNkxxMzcxYS9FR2trNWt1ZjVDYVNw?=
 =?utf-8?B?cWdXODVHRzh1QWFENmF4Z2R3b1B5SlFqcTd2QSs2SC8yQzg5MlpTSlZPSVFP?=
 =?utf-8?B?ditDSE1UbndEOWUvOS83LzdXaGJUbkgrbWlGVnVyY3hWeTJ3THFkMnJZaDZ6?=
 =?utf-8?B?OFBrbnJFZmg0Q05TbGk4UTU2OUlpTjlTVWFDeTNaUi9PZnJmN21YdzFWTHhW?=
 =?utf-8?B?SENUSEtBVkVqSThZYW0wSmFyS0xKYjZxOVlzQ0JscG0vY1hoTFF4V0xvU2F2?=
 =?utf-8?B?dUZrQlkwZFJtVUF2U3pSY2k5S055NE1tRDdHNkNCdEZ4dEkvOHpyZnRLeUI0?=
 =?utf-8?B?UHowYkFpUUt6K0pRWVhuZ0k4NU5sU1FwVmdVcG5SdXJ6WGxobnNjcmxVYVFM?=
 =?utf-8?B?U0RtQ2VOajNzNngyaS9qSktpVEt5SlpvTFF4ZThZc2hEQUVjL1k5WVJSTXhy?=
 =?utf-8?B?bWxRWlVFRWZ0U25kQmpkajZhV2NHUmVUc2M2VGhCaGdrQWUwRXZaY1BrMTJa?=
 =?utf-8?B?T2piSGxYRjQyY0ZjVDBpSEFEeStmRFJ1QjY3VzBWUVBGYWFnSWd5ZXEwNUdP?=
 =?utf-8?B?U09XTDBYYWtNVjdHZSttZXQvdWhQMnN0NWtIUDZPMTNYL0Yyd3g2WU5IcExF?=
 =?utf-8?B?VkgzWTZPZ0t3djBDMUNFU0M2QnZyZFBxVjRqcy80YnQrUUN6YjJSNVZlTUc0?=
 =?utf-8?B?Q1pmcDh2bHh1cGdiaUNzQXErd25xK2pSdFlIM1JhbTVjejZGYWw1cTdST0Q4?=
 =?utf-8?B?cVUrampNZkxpSUltNXUvMlJvT1dHTDF3U3c2czYvbUtSMzcyaDVha1QzbzBx?=
 =?utf-8?B?RSt2bEpOSzdwTkZFc3NrNEFFTndLQnVZNHdCVGtNV1RlQXo5TmoxK0RIeFJO?=
 =?utf-8?B?U2E2OFdQVkJCRkdteWJHWVVwQVllNW5sSFNUbTZrMXYwdk1wbjhIRkJXUmQw?=
 =?utf-8?B?Rm1rM0FBNUFLZmJmbXgxL1V6RVZLUFMxd1ZadVRSR0NsU3hrY1haWHNQM3o0?=
 =?utf-8?B?bW02OEdnTElRWjNuU0xvVWc1ellwZExSUGF4YlVBd3RyNkowMXV3ZklvdnhV?=
 =?utf-8?Q?vCmf0qGUovU/ShZHkFCI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNjaVlnT285SmZIcEZVdDIybkw5WElIMGE3MG9DMlF6YzlmNFNMSHRMSXV0?=
 =?utf-8?B?TEY1RHFDcmp0M0dnY0lLeFRhVUJaR0V0KzVjSTYvdy9hOTB0WTNORHQvUzZL?=
 =?utf-8?B?NTh5MDE0TW5yQkZ0UkhzbDdaOVpWcFdzT2NyMzZiMU52TTRkdUYva1hOTXJX?=
 =?utf-8?B?T2g3NG1iUk5WSmFJK1ZhTXJJWmN4K1N1ajFVcHhRZzNXdVZMREIxT3dKK1dW?=
 =?utf-8?B?ZndxRVoycWJmUHpSYnlERldvRFVKUVpwT3JLdXNmRFg5RmFJZkxzMWhtLy9Z?=
 =?utf-8?B?SW5SUTIwSFp6SVQrb0ltZDlKaFpueFVodTI3b2NTaEtKeC9saC9aeVZLbmxv?=
 =?utf-8?B?eEZzcVVQWXcvMUpnT3VsUW85RzY4dlp2ZU9tNWhXMGVQTGtLY3QxcmxsdDlE?=
 =?utf-8?B?aFdtQzhKdXVaV2cyTkdGWDdzVVdLN0FNeEJtMXdRZTdnenY3b0FrYXh6c0ZE?=
 =?utf-8?B?SGVrU2xrTmc3YXllRzBHY3BNalBGQ3U0SDBnVFZaem92Y1llK0FUYjdRVmcz?=
 =?utf-8?B?YThpNCs2Nm50eFVhSzN4NEpvd0VINzQ1Q3czMmNXWkM3b0JzYVJXWFpYelFn?=
 =?utf-8?B?WlBjTEtiMU1WR09GWWNWSHNHa1Q5RFY1MG5MdVkrRVRGMzY5N2xhaUhVOW9N?=
 =?utf-8?B?STZOSnplWVZZMElRUWU3MDlMRHFtTG90WjFrYWJwWERHd2kxYVp2ck0yeFln?=
 =?utf-8?B?R3UrSmtITjh3aFBLbTVpL2RPNHAxaHRGUllIS1ZyWVVtalpreVBmT2R5am53?=
 =?utf-8?B?MzFHY1F3b2d5emYwYkVBY1pYK2s0VytjNEt3amFXS2M2VUkzTG1ZZTRpVmF6?=
 =?utf-8?B?TDcvTHlWMkpORUNmT0lTN3FBUFJBdGVKa3cwNHNJZGlRUVVFamdSaDFTd2hJ?=
 =?utf-8?B?YVZBU0lVMDhoNGVkUk9ZUERtZSt6UkRBQWdncDk3NkM3Z014UVBucHowM1Ey?=
 =?utf-8?B?Q2NGOUpYVndKb1ZkVlpmMUN4TW03Y0dqWmVIdU1jOThuMm5qR0hWYzRsVENC?=
 =?utf-8?B?OW56U3lVWVlmbnY1THR4WDA0NzZYeEtGSGxlMmNHR1lsRGZjUUg3UjRCYVk4?=
 =?utf-8?B?Z0lNNktZUjczWmpBeVBLWGNnNmFoREp0NkF1SjhXcEFGeXRPWUlUTjFpOWdV?=
 =?utf-8?B?dXlkak9Rd2JyalVxNnErWFVSQmc1VTlwcUI3OStaUFVwY0QvQjRLcVdaR3BI?=
 =?utf-8?B?RjdFNlUyck5paUVBWjdNaStDQUh5YTRtNHVxUGNjMjg0Zm5INEEvVVk0SnFr?=
 =?utf-8?B?L2pIYkhMVDUrMUoxbVdSZDJ3ekExaGpjeDZxY3pqVVB5SWFTNGdaRXNla3B6?=
 =?utf-8?B?T0J0ODFRTHFWVDJzZDZ5R2NleXpDdXFjUnl6ZzkydzRWV25SalN5bkNmaGVl?=
 =?utf-8?B?RFE3WHFOS3hvVUtqZjViUnVpb2JMMzBWOURVYnp5Qy9kQ0taSHZHMHdDM1Rp?=
 =?utf-8?B?YS8zMWRGTEVqTVNOWENFaHJvTVFBZkVWSEJEcXRRa2NRTUR6Rlo5c3RBQktI?=
 =?utf-8?B?blA3dDlBclZCUWdwR3VGZGJqUUo5bjdCelNLUjdUbm1uR1hpZG9jZm1BU003?=
 =?utf-8?B?OE9xYmI4Z2syejZZMjEyK0VDWWFGT0tSUDkybTk1cUxYcGpxSWswd0VNZTds?=
 =?utf-8?B?YTJucjVMZG16eGp0elJpRStSRzNNU1plNWZnWWRaclBuRFNDR3pkWjMvR2Fr?=
 =?utf-8?B?SUpEazJGb2x0dC81cTNZREdtUFAxcHhyZjV3VCt5SWQzNFlyZWszUXF1Mloz?=
 =?utf-8?B?RU1ndUM4NHdocitNWTVWU3BaSFJ3T25yZjRZcTEzUC9vS0gvdjZnS2tyVlRD?=
 =?utf-8?B?ZVN5d2JWdGEwaVhvS1huUXlUUjZhaG11S3Y4eEdZc0xRWko1Nkx5b2paVGRB?=
 =?utf-8?B?YnZaM0lXaUhXbEFpSmxSMGdHU3p6Q0VkbENqMGFtREMzVXFUZ2tXek55TnFJ?=
 =?utf-8?B?eTFrUkxheGlxcTNUa3pGVStaOGUvbU9vc0NzTStXeG4vbXF1d2YzZjcyUWVa?=
 =?utf-8?B?SGxMS2sxV2w5TGkySC8zYnZIM1d1YWZxdk9NSUt2U2wxWTN1RTJKdE9PZVNC?=
 =?utf-8?B?Yy8wM0czeGE1V2wvL3d3TXpYUnpvakdYWUpKK25XZU9GalJJWkZJNVZiZ2R4?=
 =?utf-8?B?L3JnMG52bEptaEpKdFRmRHJzdE5pSTJvc05sMXVxbm9BTDFQOWhWWnNtY3dH?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc5d806-507e-41e6-07a0-08dcf2084da5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:41:05.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FEUd3m7JVLd+e+0IdAJtr051Mx3Fr4rh/avcoHO2qiXyo9EN1OPbkFN0kk+tVoHMIBzBRhFgYGwf88eBwLruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8019

Another small update for the 3.2 series, fixing a race on task deletion 
and the cobalt_monitor_wait issue with signals.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.2.6/xenomai-v3.2.6.tar.bz2

Changes since 3.2.5:

Dario Binacchi (1):
      smokey: fix build failure

Florian Bezdeka (1):
      prepare-kernel.sh: Mark i*86 as unsupported architecture

Jan Kiszka (6):
      copperplate: Address compiler warning in pvheapobj_validate
      analogy: Avoid warnings when CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is off
      cobalt: Move relax related lostage_wakeup work from stack to thread
      cobalt/posix/process: Sync on thread-hosted irq_work items before exiting
      lib/cobalt/internal: Fix lock-ups of cobalt_monitor_wait over signals
      config: Bump version number

Simon Graber (2):
      doc: Fix typos
      doc: Fix grammar

Jan

-- 
Siemens AG, Technology
Linux Expert Center
