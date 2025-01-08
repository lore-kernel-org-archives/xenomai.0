Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970232594BC
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354751; cv=fail; b=kmC8/nd3gs7agVotSLI4NDPlEf9VoaBqUNUM+xRFrTXU/P3Gy9pq54yYciOsa0t4WvjlHygsGcV+7rtyVpa1/6jUb9p9DmJR/LbmQD+M7+1/T6uaUBXWZf9qAmbWkUrdW5WJTCBtZFbI0rH+GPcTFE7BQ7uILGrlQFDty/zLiU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354751; c=relaxed/simple;
	bh=K8OakOijWOq5Bekhb13+tLTFAQzF/9OeXlsN84SESDs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bBjY1thWH8vrG/lwaCKq3owVcGeYwi+revuVNvlf+3Thv3i6imzS/aI+Y7C4YfvwddAAkiRZywq3X+BFMX1/fQXOxox4YjJPM6Z5pP/8v6wrUl0Y/QstKtLMvsQCKUL4t6J7uhKStjFzf8we54T+NUgjZ0lNL5HjUH/L7L0SbHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TkRS2i3n; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TkRS2i3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq/++AsqMBngT4eoB3aaeqLEVVNaps5snWffoIChl64L5RbpLjGCcasz43gD1rR0khFXtu1LLhmaABsPPJ1NtnzqHDVj13MPtffSyFh/k/D8C6mhOzG3KesiVKSk4Py2d1it5+FeXPx+CsMkoiuZO59PoIqAgxHi5E32FLWfoDBcT5b6k9SSJgMWX2auPD+p0evWishAVGe6g2dYkL3nA52+fUMZwieqrAo2qpgyQe8chaNQ3rZfuf+OaNp28EDgqfi0KWPKz5CQs2yvsuTYMMGMTnH0bMA6aIBbkoRfGJKT9yF8G5BgdTwO+QQCl9wA9iJuf6Ja+RfL4WKiMbRtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmg5cPZ0KdceazkZ7EyWQR9kqCH8xJzS1IudOLE9NZA=;
 b=SZhnwvkMtramTRL/DFTIQNrxBtl0NSsO105X4a3Qb1vkpPDhZQo2Z8+QElnXkwDqUYXmWVarzHElRVJyWOoi3OfRJGEP6Q8Lp7Ub/QDPEyogTJ1SA80fyZ/zGKpFGqAAXAxBppb+VK524nvhTuXLnLOhhjxjCVrTG88qT2FErLUwfOnSim+vE977xQGqh8I/yaiB/mCaGmjcTCG6mPl1GsOMy0fq8bNShDwY4vUM7H/O2zSGz1xBOUAez5UTgBiLqkpKdYrGLRV0fcSS1aNnpC6/cIKMNrUoZ9GN6ON0XFYpy1iGDr/4JbblU8O2sFJpzQlvXx2whv49lXXQmYt1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmg5cPZ0KdceazkZ7EyWQR9kqCH8xJzS1IudOLE9NZA=;
 b=TkRS2i3n/MEYjh0PY3WHOcausk3Uwz7YhS3zcv9F7I5bdIOUJMqmIPqyJrVrov5f8RlT7dvMJljxON+DlplcU8qrRp65myC8LD+P4dh0k+RZpDNKXkHtQg/lm2U9+D07hT9nLqKifhw2CZPg2mljOCG1iB+588OtEES1qdT6dswhfYlK8/Xe/K3yffiHnkDsV6OT/eQwHXgfGKmrua00fH/+c4jZb737jBRJHaUBH3sU+CWqAOKrmu5mItiFsJS/UVatmiwZ8qOeLvG2e11Nnv3TlmRutghW39muYg+ZAXU2tG3Emn0LV++nUtH3WraA2N/ArLNJ/8WCNfwABGFRpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 16:45:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 16:45:45 +0000
Message-ID: <ef3689e2-45e8-495c-b436-7486aae4c7c1@siemens.com>
Date: Wed, 8 Jan 2025 17:45:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Reformat all Kconfig files
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250108163135.3631208-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250108163135.3631208-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f38a95-e5af-47b6-b003-08dd3003e5e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXZvYmlGYlczRkNsSG45blNDcXZnbHRzVHdwMmQySXVMdURZajQ2d2xmYXQw?=
 =?utf-8?B?MjVhenJDYytONFRYd1l5RVJwL1hxY29JT0l2RDZwZ3JvV251UURaazdtVEZR?=
 =?utf-8?B?bjFlZlNZL3VIY05tcVhxMTZWM0orMW9MdUNjTG91YzhxTUlYaFltdENQbDMw?=
 =?utf-8?B?dGw0YWFCTTF4TUw5b1FmbWxFb0FFdndlaXl1TlFIY3BKTzZTdWFERU5YcUFS?=
 =?utf-8?B?KzNrdXhUM1F6QVhyVU14dTVvd3RvcTF2WlFsaGJXbGxBS3NZcU1Cb3BwNGJp?=
 =?utf-8?B?bWN5TncvMTNJTTJXNVRZczBLZlJCZVkwaU9JcW9yWDdEZ3ZsSnBoMERWUmVY?=
 =?utf-8?B?NUdUays3RG5HZjdpOVRoYnNUZTBZbU50MENBK05hZCtYVmF0dU91MWlhanpu?=
 =?utf-8?B?RWV4UW1YR01CSTdRTk02dXFUWXgwWnV3dlpsekpHWlRYdzQwaXcyN0syNDFC?=
 =?utf-8?B?RHhkRXdtOGRKNGNuZG5TME9yWHJyVVNZVGk0WFp4ZWIvV2FZK2lvRFRoQTVw?=
 =?utf-8?B?ZzNpcllWbjNBQXczaUYwa21zU1YxM1hYUXk1cnU1SkZZQUd4cnFQdW82Ulkv?=
 =?utf-8?B?NjQxd3dWSEsvUEdRMHA1bHVQYlhwTGtxMC84WWpOSGJIUHhwQkFkcnp0VXE4?=
 =?utf-8?B?eDRlTFNPcHJEbS9VYUNIbDM1OUU4Y2dtVXpnR2g0MjJqeXFqc2w4MThENGwz?=
 =?utf-8?B?TzF0MXA2TWNLK3l0c3NDY3VVZCtlcThUOTZXTHRyMlhyNXgxY1Jrd0NIb3Az?=
 =?utf-8?B?NVNWT2ptbitiS0VzS2lva09pbGh5aUxtQnl5aldkR3d4WjBKOHJPMGZmNFdT?=
 =?utf-8?B?OWVnNzFsUWk1VHlzMWxwSlo5aTFHSTg0YjRJK2pRUEx0ckMxRzdhWGE0TDNS?=
 =?utf-8?B?VEdVQmlFdWpJY3ZScVI4dE9wSVViOWN5UVZ5WnRCMThPczlaa3lDdXhwOU9G?=
 =?utf-8?B?amdIU0VpRlRPWkVLNlVxWVgzOWorb3orTXlab0hGMTZ5RHZrYWc4UU5sWGJQ?=
 =?utf-8?B?eFBrN2w3OVF2SUdCMXpaYmFoa0s5S1IyalErVjdINCttRTJYaHRJanQxVHJK?=
 =?utf-8?B?SG91UEUwaWFHL2dwYlBhenBnMFB0M09wUytiYVg3MkNVWlBMUkNoL2FuUW9r?=
 =?utf-8?B?SW1QQWxUWTN5Vm92cmlyNm5uSHZtcE51eXJSa3RkU29kcG1GOENXK0tjMFFo?=
 =?utf-8?B?ZzNuQnhsUHoyMlNZK2FpN1lNRGQxY2tuUTRBd2NFOGlRZE9tY3BFNjRkM0VH?=
 =?utf-8?B?Qityd3FxbzJWb0tsWkgzZ2ZGVXM0eVFkMDJzN2JGcXB1eEFlR1VxQWUvUHVR?=
 =?utf-8?B?YjdEM3p5QTErNXR2dDkwc3BTcGx0Q0ZyWlVMQUxsUTJLNS9ZMEZVS1hhZWxG?=
 =?utf-8?B?MVVLanIrL0hhZ25pRzNhRGpGZWkwQ1o0V0MzRkJKMUY4V1pqc1B1Q2gvckNm?=
 =?utf-8?B?ZndYZUIxY3lma1RBMUVqMldBU282ZlpwQkFXY044ckM0ckhUblJZYXpjSXox?=
 =?utf-8?B?ZytDYlZHRHo0RDRtbFgxUUltMmN3QjM5aC96S1F2UnVOUkhpZzJSeWd1bCtC?=
 =?utf-8?B?Z2o0RmxTa1pyeURLck11ZWNRY3Zhcy8xMjh0UzE4empuWGF6b29uaTB1cS84?=
 =?utf-8?B?R1E0bTNxeVZET1Q5L2FMNGEwME13djNnUHJ0OVpqNVpoOHNLZHFUQVdLY3My?=
 =?utf-8?B?R2cxZTdHN1pBaHVmck1MRHQ3WGNSUWhrV0RkNlN3am0velVQb3JrUXh4QytM?=
 =?utf-8?B?QXo2TFpvSEZ5eGUxZzY1eTdtUkpab2xoMitpWllXOTVlZWNFZkpXeHkvRE5u?=
 =?utf-8?B?U2pya0dHaU5xVWljV3Y2aU5uVExxbmxFOFREMlo5TWMxR0ozMUlDS29TY0dZ?=
 =?utf-8?Q?z23oX0NnrwB3A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHJ1TWFLRCt1Vkd4YitQN0lKbUVOSHVST0xUeGZiYnhUdGpXcmU4SjRvZEVW?=
 =?utf-8?B?dG1qeTFHNGJFcGFFRldrUmRmOEtSdFVMU1NUaUtEQ1NpOVBZNDltWEFjdW1P?=
 =?utf-8?B?WllCUU5QTHJZaHZ6eUozcXN5VTRWYUJ3R2cxNTk4Ym9IanlUY3dmUGt0NWY2?=
 =?utf-8?B?UEhpbEcwVDQzSWg2b01aUUlYWjZmM2U1M1dWYlhDdHVOSVNrMm1hZW9IbmpQ?=
 =?utf-8?B?bHdkbUtSY1FlUmdGWGFyc1lBTnRpMTlXcldZY0NIYmtwK0pEdHRsUG93ajZZ?=
 =?utf-8?B?MXV1cWlhWFFaeW9sWWZJbk13R3p3SGJSNWd0aytaSVpHcUx6WjB1aEVpUUJK?=
 =?utf-8?B?VE5FNGthWnAvdE5XMDZVdlFjUlcrdm05amdCczBFQ1pyZ04wVlV1S1VwVDJN?=
 =?utf-8?B?SkZiZW9Ka21TTUhqa01IdGtyYkk5L1RxWmNRa1k4c3VSaW5vYW9vY0lsNkNt?=
 =?utf-8?B?VzNMQmxpRndoV2ZLc1ZzaGsyNmtGcnFsVnZNdVJoU1c1N09YemhDelNQaVhN?=
 =?utf-8?B?cGtRZkl6ZVhhaUo0YTFXM1N1eHZ3aDdXaXI4Z2RkS0dpSk5XanZZbk5kT242?=
 =?utf-8?B?N01YTXl3MnlTZjRyalU5VmkzZVpFSTl5TXByWWtVSlhRZW9oM0YrKzU0RWpv?=
 =?utf-8?B?dUpGRGhKcTR2Z21zQkxPZDJIc1RwMmRuc2FkL1ZHMHliK3h4S0REZnBOL2xu?=
 =?utf-8?B?MnpMeStoY3crV1V1QURyenNoaWRNRERmY0lHQS85NlNGb0RMMlJMTForMVdU?=
 =?utf-8?B?R3gxOFpvTDgvK1dENC8rU0NxOStpdHVRanp0MEU5RWpScHcreVl3QUhLc2p6?=
 =?utf-8?B?b3lFOHphcFhzOHpTSTN1QXpzSlNMZEdpMWVGbjR1N3FQQzRhbkpSTFFvMTF1?=
 =?utf-8?B?azN4YXpuOUp6Y1YzdTRNdXZyNmdFZVRwc1NQMHZ4YjJKbVpScHhsMEhKUlh5?=
 =?utf-8?B?RDVxRjBsRk5zQ0o5VFpBNm5TQnI3MU1iVUR1ank1Zi9QK3dxMS9IK1U5dGEw?=
 =?utf-8?B?VFM1eXBZL3MrMWw0bEpZdEpnN1k5c0d1RENqSXJvK05DRFdhRUxvR2gwWlM4?=
 =?utf-8?B?N3NDWXRaQXczblBra0pyYllXYlJTa3RKRko2WERiNjdnUmZEclhUZG15aFp6?=
 =?utf-8?B?clQ2SExleE1QTHVvWHdWa3dJd2IwMGJNQXA0ZDVoLzlLRjdQSW5kdnNrZ1pQ?=
 =?utf-8?B?UGhLb3UreG12V1VMSlJ1M2FVS2RDRENwMVYvWUQwVFNYVVAxNlFRZjF2emVT?=
 =?utf-8?B?NldJMUZhdGVUSnFJMlNuRTBta05ZMFQ1V1pJNzljQ20wMXBGSDdFckwycTUw?=
 =?utf-8?B?T2RuR1R4SWhCOGthazNudVgrdmNDd2dGRit4SDRvZEJmRkU1aWg5WXJudi9v?=
 =?utf-8?B?enhPNmtTYnIzSkpBT1FPbk9Kc2RuZitRVzcxVHFwaFQrdTRRZEljSWlIT1R5?=
 =?utf-8?B?cFE3emprQkNGT3pnNDlrT3dmb2FROGFEODJKQ2hFaFZHQjBkaEFtdkloTmdO?=
 =?utf-8?B?VFpMTUxOVUw1dG9IWlpUeGNmVy80T3FGanM5T0tQT01YYTNUanI3VnBiOTk0?=
 =?utf-8?B?NWRoZGs5MnowdjNJNTJNdTdWcFJyQ1pqaG5xR002WTEyd1M2VU1tT2pSbk03?=
 =?utf-8?B?clpRQ3pwR2RZVjljbHo4RXZ5amFNU2NlT1VnYzRlZVI4NUJGWXBOYTg4Mzls?=
 =?utf-8?B?cnN6T2lJdVhyS29ibGswVDZFRmVoNHpPMHZ4NWt6VDNqRk43YmRjV2xvMGs0?=
 =?utf-8?B?cCttTE9YaG5qTURmUmJjc0k1ZjJIMUxLOThLdmQ0Y3hUSE5oSG5VSCtTb1VQ?=
 =?utf-8?B?UFp3YnBFMXppVDg2dFRlNXFPWlVUMGlqd3lKVmhRQ0FQT3N4N3pWRytKRjdW?=
 =?utf-8?B?bkdGZW5qVkNhUE05MHlOWTBMZElPRWRXSVkrTzBRRkU0S2FkNHZtS2tXcUlY?=
 =?utf-8?B?ZGhzRVhBWFA2YmdDeHI5UzlUQ0pFVVBSbnM1cDJVTFBzM2h4V3U5R2pWNU53?=
 =?utf-8?B?MisxWWJIUHdDZlBFU0Mzb05vQ0U0UEpOLzJIZkFkWjBFZ1BDa3dJMmNJWVQx?=
 =?utf-8?B?RGhWMC9PN1RxSWxhaU92cmlmbUx2KzMyRmJnL2hxMkR2ZTk3eWl3MGFjd053?=
 =?utf-8?B?RCs1MnlRZXdmZHBvMk5mbFpyQWpkUDRzbC9YR1lpYjNLbXZIYTdVUjVtR0tK?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f38a95-e5af-47b6-b003-08dd3003e5e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:45:45.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 979ovAxmZiQv9qgrltmQTfYugolrIxiKEvwWMzM3uucnytLp0QhoJsxbC2et0osbikOL6iPV14YwyTnh0LvO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7129

On 08.01.25 17:31, Florian Bezdeka wrote:
> A lot of white space conversions and reformatting of the help option
> according to most upstream files.
> 
> No functional change.
> 
> Typo fixes in the following files:
>   - kernel/drivers/net/addons/Kconfig
>   - kernel/drivers/net/stack/Kconfig
>   - kernel/drivers/net/stack/ipv4/Kconfig
>   - kernel/drivers/serial/Kconfig
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/arch/arm/Kconfig                |  10 +-
>  kernel/cobalt/arch/arm64/Kconfig              |   8 +-
>  kernel/cobalt/arch/x86/Kconfig                |   2 +-
>  kernel/drivers/Kconfig                        |  22 +--
>  kernel/drivers/analogy/Kconfig                |  63 ++++-----
>  kernel/drivers/gpio/Kconfig                   |  49 +++----
>  kernel/drivers/net/Kconfig                    |  20 +--
>  kernel/drivers/net/addons/Kconfig             |  66 ++++-----
>  kernel/drivers/net/drivers/Kconfig            | 130 +++++++++---------
>  .../drivers/net/drivers/experimental/Kconfig  |   8 +-
>  .../net/drivers/experimental/rt2500/Kconfig   |   6 +-
>  kernel/drivers/net/stack/Kconfig              |  46 +++----
>  kernel/drivers/net/stack/ipv4/Kconfig         | 110 +++++++--------
>  kernel/drivers/net/stack/ipv4/tcp/Kconfig     |  28 ++--
>  kernel/drivers/net/stack/ipv4/udp/Kconfig     |  10 +-
>  kernel/drivers/net/stack/packet/Kconfig       |  24 ++--
>  kernel/drivers/net/stack/rtcfg/Kconfig        |  38 ++---
>  kernel/drivers/net/stack/rtmac/Kconfig        |  22 +--
>  kernel/drivers/net/stack/rtmac/nomac/Kconfig  |  16 +--
>  kernel/drivers/net/stack/rtmac/tdma/Kconfig   |  34 ++---
>  kernel/drivers/serial/Kconfig                 |  56 ++++----
>  kernel/drivers/spi/Kconfig                    |  15 +-
>  kernel/drivers/testing/Kconfig                |  12 +-
>  kernel/drivers/udd/Kconfig                    |   5 +-
>  24 files changed, 390 insertions(+), 410 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
> index b0cbdc3b7..080f9df80 100644
> --- a/kernel/cobalt/arch/arm/Kconfig
> +++ b/kernel/cobalt/arch/arm/Kconfig
> @@ -5,12 +5,12 @@ config XENO_ARCH_FPU
>  	def_bool VFP
>  
>  config XENO_ARCH_SYS3264
> -        def_bool n
> +	def_bool n
>  
>  config XENO_ARCH_OUTOFLINE_XNLOCK
> -       bool
> -       default y
> +	bool
> +	default y
>  
>  config XENO_ARCH_IPIPE_COMPAT
> -       def_bool DOVETAIL
> -       select IPIPE_COMPAT
> +	def_bool DOVETAIL
> +	select IPIPE_COMPAT
> diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
> index 14e5fa1c4..2ea82ce48 100644
> --- a/kernel/cobalt/arch/arm64/Kconfig
> +++ b/kernel/cobalt/arch/arm64/Kconfig
> @@ -5,9 +5,9 @@ config XENO_ARCH_FPU
>  	def_bool y
>  
>  config XENO_ARCH_SYS3264
> -        def_bool COMPAT
> -        depends on COMPAT_VDSO
> +	def_bool COMPAT
> +	depends on COMPAT_VDSO
>  
>  config XENO_ARCH_OUTOFLINE_XNLOCK
> -       bool
> -       default y
> +	bool
> +	default y
> diff --git a/kernel/cobalt/arch/x86/Kconfig b/kernel/cobalt/arch/x86/Kconfig
> index 9adbbf79d..dd08a5a3a 100644
> --- a/kernel/cobalt/arch/x86/Kconfig
> +++ b/kernel/cobalt/arch/x86/Kconfig
> @@ -2,7 +2,7 @@ config XENO_ARCH_FPU
>  	def_bool y
>  
>  config XENO_ARCH_SYS3264
> -        def_bool IA32_EMULATION
> +	def_bool IA32_EMULATION
>  
>  source "kernel/xenomai/Kconfig"
>  source "drivers/xenomai/Kconfig"
> diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
> index 197a48eef..a0781c4bf 100644
> --- a/kernel/drivers/Kconfig
> +++ b/kernel/drivers/Kconfig
> @@ -4,21 +4,21 @@ config XENO_OPT_RTDM_COMPAT_DEVNODE
>  	bool "Enable legacy pathnames for named RTDM devices"
>  	default y
>  	help
> -	This compatibility option allows applications to open named
> -	RTDM devices using the legacy naming scheme, i.e.
> +	  This compatibility option allows applications to open named
> +	  RTDM devices using the legacy naming scheme, i.e.
>  
> -	fd = open("devname", ...);
> -	   or
> -	fd = open("/dev/devname", ...);
> +	  fd = open("devname", ...);
> +	     or
> +	  fd = open("/dev/devname", ...);
>  
> -	When such a request is received by RTDM, a warning message is
> -	issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
> -	also enabled in the kernel configuration.
> +	  When such a request is received by RTDM, a warning message is
> +	  issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
> +	  also enabled in the kernel configuration.
>  
> -	Applications should open named devices via their actual device
> -	nodes instead, i.e.
> +	  Applications should open named devices via their actual device
> +	  nodes instead, i.e.
>  
> -	fd = open("/dev/rtdm/devname", ...);
> +	  fd = open("/dev/rtdm/devname", ...);
>  
>  source "drivers/xenomai/autotune/Kconfig"
>  source "drivers/xenomai/serial/Kconfig"
> diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
> index 858762bda..974b90021 100644
> --- a/kernel/drivers/analogy/Kconfig
> +++ b/kernel/drivers/analogy/Kconfig
> @@ -3,50 +3,45 @@ menu "ANALOGY drivers"
>  config XENO_DRIVERS_ANALOGY
>  	tristate "ANALOGY interface"
>  	help
> -
> -	ANALOGY is a framework aimed at supporting data acquisition
> -	devices.
> +	  ANALOGY is a framework aimed at supporting data acquisition devices.
>  
>  config XENO_DRIVERS_ANALOGY_DEBUG
> -       depends on XENO_DRIVERS_ANALOGY
> -       bool "Analogy debug trace"
> -       default n
> -       help
> -
> -       Enable debugging traces in Analogy so as to monitor Analogy's
> -       core and drivers behaviours.
> +	depends on XENO_DRIVERS_ANALOGY
> +	bool "Analogy debug trace"
> +	default n
> +	help
> +	  Enable debugging traces in Analogy so as to monitor Analogy's
> +	  core and drivers behaviours.
>  
>  config XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
> -       depends on XENO_DRIVERS_ANALOGY_DEBUG
> -       bool "Analogy debug ftrace"
> -       default n
> -       help
> -
> -       Route the Analogy a4l_dbg and a4l_info statements to /sys/kernel/debug/
> +	depends on XENO_DRIVERS_ANALOGY_DEBUG
> +	bool "Analogy debug ftrace"
> +	default n
> +	help
> +          Route the Analogy a4l_dbg and a4l_info statements to
> +          /sys/kernel/debug/

Still spaces here at least. Happened to spot that, maybe worth to have a
second look with an editor setting that visualizes spaces.

Thanks for the cleanup!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
