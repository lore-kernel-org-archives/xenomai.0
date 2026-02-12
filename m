Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656A263F5E
	for <xenomai@lists.linux.dev>; Thu, 12 Feb 2026 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923248; cv=fail; b=eWGHcq21ZBIqXpiHBC3DRa1OSPCfLg313s7K2jWi6B85kFQl5HM4SlIxQawPmc5eWPK0tVMlYJMwOi8WYU2QEa0eixh70MSSGQdF5AawdluToKpfHUASz98AgjCiizBTzqTIVdj81rJjK63e5EfmFMIpxD4oLpIPi1mPLpjpyCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923248; c=relaxed/simple;
	bh=mCYsOmlzG7X1XGWq7oSrH+RwFoWpPTOHlNpiN4oPyFA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/08c2cEIgXLE0MmU03eB0B7146GQtjdMKk1Uf78RcI/BJCOOtERc0xEEHUwFBSP7Ak33vdKg5q7wbQdFIAk534SnMPRs1z525+gjG3XQ/cfvj57nK34iYxk6SmLByNTNPnSWF7t0MEzLq23Hpat79hmUkrHdSQJCy+dP+RUrVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xM3DK8ql; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xM3DK8ql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU0CcXYWJc5anA9k1F3AlUFkgv/4u7b+61s3/WGwhtIfy/KL+d5lzOD9tzoCfIdVTr2UFpDMA83T6+VS1sqfysrnoBV/KvwzmGj36tRn19Pr26X7lF6DZj08WCBv4wJqePkg206Ba1Qt9saBuBF4CFbV135+SYhQkFr4znbuoFRj5ipgDmqxXDdxF08irequF5xjZsazXsY6OgodvthviNWMjdgIZyO2Pn4pl1HLOv6yzE+nzHIwz+E0HByr9JZbRAm9UtF7MOsR3TZzHK1xkdgp6xGpNV4Sn2A/DQ4xAguLjrU0nL390dDYNfkxymp2U2pnqAwZhwGfMyF06e+HuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DRVP2N0idwCUgw8HDEmZUHFFMVGpnuC6xgIIaIb2oY=;
 b=um663q2eIdM8O6pjkzI4Jq/+aYHy2AJYs3zMl2IjvYRwn9LtB1cwFk6vh/kEGKjlQKvMoEMnm1dr8XSq4U4Y+xYC8ZVFzsCwTGhG3TWlkT1tRRA75rT5lyfaL+lr4FMkefvCa/LZ4P5d7SbNNbf/gRYgfdb+QzPQ4BDJAsXGKyfxujAP6yFS4MeHjIxV4bgAmkNyFv3ocbM0DvD86cd15zKrisa8FatlNk1ii3zq0ZQTv8+m6umfmMFYdofKFJI81sk8O1FTMLETOeHDuA9qJCwmfmDue+IMCHkOj9yDBYh1U5kaHPff+2AVfzDACwlF9o6Q7Av+np3E00lc6RIEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DRVP2N0idwCUgw8HDEmZUHFFMVGpnuC6xgIIaIb2oY=;
 b=xM3DK8ql2CYDEHT9+0VULVsx8azHl7sl6Cr3o9HJojudcd5uhNrlJ9L4Z5H6jLa1pWx2PTvPR/J6etwl62ri9qegHiKeMS+/qoEJ17L7UIG5qLrsCMCFf1uMFvLKD5X0h+DGvLvzr/EAkvq8uKC6k95SQllFm8eziv93qT/hHPmqqXWj2LQdSy+SiUCM1aMDBVCyXvWXQ9G2Z87wgtaReSAg1YnXnnCKymSNRAOdZmbKy/71d8yLPyo94Rho1k2mneOdFc5suue46Q6EcD2Ak7GWnjSe/7nm9jjpmvtbuxgslNVPzfrJvnLGAM6frT/t12wvwQYx6engoBjB17v/iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 19:07:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 19:07:21 +0000
Message-ID: <d653b7d0-4655-431f-9bdf-7f6baacdd5e3@siemens.com>
Date: Thu, 12 Feb 2026 20:07:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 4/5] ci: Add CI for libevl
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
 <20260211131043.1185863-5-clara.kowalsky@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260211131043.1185863-5-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: f8848f70-9cd3-4d0d-46dc-08de6a69f2fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2FvVkVTN0w4Q2dNbjNOcDdSOGMyN2t0MjZrTTM4Zm5qaWpMWnU0MElEWkkx?=
 =?utf-8?B?OGJYdEFZR0wvdUJBOFJRVXNkYkVSN1FHTys0WGxXYUpiZHZ0YXNadkxZTW9Y?=
 =?utf-8?B?NnhpUEU5V2hBdG85SDVFUkJQUjJzRkkvekNlcTZmQ3lCcWNYMTZYUEJsS3RG?=
 =?utf-8?B?R0RIUWpqVS9rRGllZ3VHV3Q1M2VYMGNaOWJUYm9xV1M0clhmcW5DaHY0bWtU?=
 =?utf-8?B?N0FBS0twNE9yL29mT3h3MzZXTHJORklGQVhTQkM1T2R2SG5MSzVxMEkxM0c5?=
 =?utf-8?B?OXl5cTB3T3VWNldGRWNlcVQ2NVk2cGx6b1M4eUNXYzYvYVc1bjJ0WXRWNGJi?=
 =?utf-8?B?NW1rZWE3dnRFNHIzNnlLY1dRaEl2bThvSFZxVktXUDlTUWJFU0pLNVgrbi84?=
 =?utf-8?B?VG53TEwxOWd0QzRFTnE1ZXQrNW9yZFlRbmo2YW9GQjBiZVNyZnhZUWZrUU1l?=
 =?utf-8?B?dURhM2hRTWlJc01jbFYwZFg2ei9tT3FQTVNDRUxKWnFydUFqQzE0SXByTmNq?=
 =?utf-8?B?Z3psT05jQWMwQnpHWGczV1FGcndlemhBbHJ4V2lrNGUwZ2hBUVZqN3pZVWFy?=
 =?utf-8?B?OGN0ZDZyc1pLdnZScDZBQW1aUW9sQXh1SmwyWWw1L3I5YU1LWENTbGFCUjIx?=
 =?utf-8?B?QjRaY01iMEFCZTJHa1BnQ1JxUExWUnY4dnVmV1lXZDRyRTlOdlhIV0lTcURW?=
 =?utf-8?B?SGx6TUJ1OUM5UStkdzZUQ1drR2RSRjZFMG9lZWxLOVJoRURBWWJXOHhwSHYz?=
 =?utf-8?B?VEFpYmlYczJSTFY5RGQxWmVXeWhBdnZFNUFYc0E5aUp1OVFQZEFVdUVpUkkx?=
 =?utf-8?B?d3BBQ2ZHbWZRV1JkMUlXWFBrUllId1hONnU1aFcvOVVGTDloSGNOSnpPTFJE?=
 =?utf-8?B?ckhsZnBTUkRRUlhvZ09HMktBR1Rabjd4VllJK2puUW9SU3pFVm5kWUI2dkQ0?=
 =?utf-8?B?dzlBZExRdmxFRi9KVE5RSytFNGZTUjJ1Yi8zaTJPOVFPUzVsd0lLQ1N4a3NU?=
 =?utf-8?B?QWdobWVTL0N1R2dpVEFyYWRqVE5RZUFUVEhSREVHTzdxeVZ1R2h4eVRyV2Vm?=
 =?utf-8?B?QVhWWXM2bGJ0YWNQRCtNMmFWYitvaStZNktkMnVmL1ZZNnVZZ3Q2dy9WYWR3?=
 =?utf-8?B?UGQxNUhjSzErMjFCNGxNZG92SmQxU2twazNZaUlSbmlJQk0rZ3BwYVpiYzhI?=
 =?utf-8?B?cXdnOUZKNmZVbzBKY2VzUjFmV1lkS1BwLzVMMGRiQTMxeFltb1ZmQ0xDbnpC?=
 =?utf-8?B?cW1GZzlCSGtnWEk4WG1UUGlEMXAxcFA1aElMVk9HR045ZXNDRFZlK2xQdHdG?=
 =?utf-8?B?a0lFUFlmTFFhVUZNazdpWmVMbXRkZURScmtxWi81NWZUcUQ4UDlLMmJMZUVY?=
 =?utf-8?B?M05pTnF2Smt5VGZ3dFRMcDZQM1JRRFBlWEpmRW40UHBBdlo0c1pxYW9zUUdB?=
 =?utf-8?B?aC9RZ1hCb3EyMkl2Myt3ZWM3bnAxMFFES2dJOFhXUW9oN2I2RGlLall3cGZ6?=
 =?utf-8?B?bXNIZTVWMVRKQWE1RHpqM3hGWmw5ZzRZN3VtZlArR3RVOHZ5Y0k1bmlVVEFa?=
 =?utf-8?B?SndKQ1dkd2dGblZsU3g1cnoyK3dNd2JidU5XWGhKaEswZm1ldVgwbGg4amk5?=
 =?utf-8?B?OUVBTkRReThuVmwzK0VpWVJYQ0RpYWs4YitvMWV2Y3NEcWpzMnVBSlh6S3hX?=
 =?utf-8?B?VXpCRU95OXVqd254eUx3dTM4Y1M2TExqOVRFcVhRbVhvbTd5OVJFUytXVld5?=
 =?utf-8?B?TWI3bEN2ODRCTjhoTi9wc1FlcmJZaGtlVDJsMjdtUS8ySEo4ZXRYZXY0Nk55?=
 =?utf-8?B?T01PMlI0T2VpWFlQS3laQ3N6ZitTeE1kTW9JOGRvcitDUUVodGk0UUJ4NXRr?=
 =?utf-8?B?ems2ck0yNmR0cDJIV1NwVS9QcGZMWXFLb0pwSmtIdExYcVFtK0FoTkRCOHhW?=
 =?utf-8?B?M0Q4TlpqMFdIcVgycXI5MGIwSjFRZXQyOWoxUUxRYXlzcHpVa2ttTGdCbldT?=
 =?utf-8?B?WnA4L1ByTHNramxvV1F3RUk2cmo5dVNMbmNaKzlDcUhPekEwTmhwaHN2SE5H?=
 =?utf-8?B?Q2YzWWcrcTJOY1JZMGRNalJ1Q2FFOXdGRVRlUTk3MS9DaUh0UFQrdmRnRG5h?=
 =?utf-8?Q?hHYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC8wNG1kWExKYU1JL1JOUEtaMFBzWDBkZFdRdUR6VFUrUHlscHVuMWtjcll3?=
 =?utf-8?B?dFBIalRRUExHUnV5VUZiVTR5V1k4MVZUUW4xRk44MXE4Q3N1LzgzZ2ozSXpM?=
 =?utf-8?B?MDJCNWwvbjNxdEs5bmJLOTUyQzZDbmJiTTVRVE1zMkMxcmJQYisxaVdJd2ly?=
 =?utf-8?B?UW1OZmdVaVUyUUxOcU11NHRISXFLTzIvWDRnTG1rVkh0YmVZZ3VmNWhvTExF?=
 =?utf-8?B?K0grYVhXUGtac1Q1eWJYdVhWUG5JREdqdkp1M1RsLysyTVdRSC9kL0hCUWJI?=
 =?utf-8?B?QXV0dUswaGI1SCtaUDFyMmxiSWFkVURyczhzM3ZpRVFkSGNRNloyVXBWamRm?=
 =?utf-8?B?OXNnclBIZXk3dEpGeUpxOXVLcXJZUEowWWFDU0hPeWVGOUxqdjdqeDVIOUph?=
 =?utf-8?B?V3lhdjloQzU4Z0hpenNYcVVsWHNra1paZ3R6TDdNdFlzSmFJSUFkblJxSjNC?=
 =?utf-8?B?Q3puU09vaGtoUUYzWTZDSkdNbDRoMzNHd0ZKM1pESXN5QWh2ZHgxd0I2OWdo?=
 =?utf-8?B?dzNJSFhlUTJKL3dOa2R5NWljTXBHUG1WekREVytCdkh1Umw2UjlGNlozODFz?=
 =?utf-8?B?a1oraDF1N1JyWGdYdFFqRXRrYldYTk9FSzdsb1IvMEdJODJkeWZUUzlCeTFq?=
 =?utf-8?B?bTRlek9YZitURjBnQ0F4SnQ3YUNEL3NFemJXbUFKc05EZUwyWjI4eFZObW01?=
 =?utf-8?B?OG5vTnlMdUZqcXdHZ1FOemNUWm9DWmpST3pZaFo1TWlpWVdNN2U5SmRpQi9k?=
 =?utf-8?B?bVdHcytuZW9DaUZzQ2JJNEErZXl4dEV6TlljV3Z4c3VzMjh2TzdheTJiT2My?=
 =?utf-8?B?RjJNaENNYWRHVTk3MHBYeUZrVGY4QUNFUDBjRm11L1BnTDd2bmlTWC9GNjdh?=
 =?utf-8?B?ZjVWZUYrMjM2MEdndlA0bWhwQ1d3K3NZZFRuckNkTFUzbHdXUi9MYzlCbHNu?=
 =?utf-8?B?QmJPcUZvbGRwWkpNVVFxKzcvcmFjSW1jRXc3ek9sL3hGY2RMSXVQd0NaYWl0?=
 =?utf-8?B?dmoyOGhGTXc1VHJnUEhSZDlWWStxVWxnOE5rNUtvVVVjdGlDSFgwbjhEM2NT?=
 =?utf-8?B?QTgwV1dSSm9vcU82NmJ2d0c2cURhVTVSYzJSaS9TODdURC9ERDRPQTlPUnVX?=
 =?utf-8?B?S29IY3lSUis4SXRDT3hmekdWbXF3NnBtWmN6Zmo5aDBkYWgybFlKRDdrV0l0?=
 =?utf-8?B?NzVJcC9zK3FJYkZ1cHZUOERLM29POG92K1VKaFpYckJBZTZNbzE2RldMdzZy?=
 =?utf-8?B?dDlLc0JYVE8vaCttZzQ3QURpWkVKSTJNV0c1L01UNzFhKzRtZ1Y4ZXdmVEhJ?=
 =?utf-8?B?L1BRRmMyMlVOMEJUcENicGEzdG8xdnM4dnlOREl4Q3NpZk9CRVVkUVQ0dEpH?=
 =?utf-8?B?U3p5WnAydWloL0VLUWRtWStRelBpN2JEWk5xSmQ0NVdhcGZrMTA3d2Nwc2cw?=
 =?utf-8?B?d0V2VjZZNzFHUGNvZGY3cnR5L3pCdTN5ZnF5T3dFcmkxak1LdDZwblpBdDNU?=
 =?utf-8?B?Y1F6MUNyVXJhamhSTHhTZ1NrWmhDRWpXVjhJRklrdGRRTE1CY3pBQXlhalI2?=
 =?utf-8?B?ZlVJbzluM2Q2elFlTHJkZjFIOHBWUVhJM0dTQ01ReFc4d1h4RGpMT2NKdE84?=
 =?utf-8?B?S2YyTVRLREQwQXVTQW5CSHY3aGpSTGZMVUNGWnZZekMzSkR4QUJhcWxHWlZ6?=
 =?utf-8?B?TDhuVHdWSW5tc01XU1FVanlKNVZtRnU4Z0M2SXBTbGdMRXRyNWFhMXdkdE9r?=
 =?utf-8?B?aHVwQzZPZmR6OHhkSG12L1pOQ1E0dUFVeUdid1UvSC83emN3WFpvT0lZQnFm?=
 =?utf-8?B?RFhDdGtLUys1S2dDdU8zL1IvY1BrQmhtRmhBYVNtb2hkcTBuZ25MU3pEbDhv?=
 =?utf-8?B?ZTEvNDFUbm5TM280azk0dWlqeEh1ell3U25TVUYxZTZFbFU3S3dUT0VaUW1v?=
 =?utf-8?B?VWlXY2h5V1RCV3lzUnlMWHVacEh6elJNdUZyNndtNUtkTGxtdCtFMmVkb0Jw?=
 =?utf-8?B?bEFIRlFmaTBOdW8vVDhoMllwMkRIZG84UGhydHB3bDY5KzBOaVByaGZOZEZM?=
 =?utf-8?B?RDROYlpaYUFyRXo4a2txY25SdUM0T3JRTjZsUTR5Nmt4Y2dQME5wQWk1bzFx?=
 =?utf-8?B?KzlFRmNuYlVacGovR1JnNWZSVUc0a29LL0o1Skk2MlhQS1luOHYvWjZsMmo3?=
 =?utf-8?B?WU9sN2o5Q0VPeGJac2NFc0JUc1J3QjZtRzJQQ1FOdnhBVG1JL1I1YVR2WEds?=
 =?utf-8?B?L0REWTU5cWZ3T0ZzNGhZem9MaHQ4SVpTM3VlTGNGcTdJWHVSekZmbEJiR2w1?=
 =?utf-8?B?MW42V05YQVBMU1hmZGpLeUR4c1g1UmF0a0d5Rmk4V0xGalJaRW1EVURJSzdJ?=
 =?utf-8?Q?nmBKrXDQ6hHkfcco=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8848f70-9cd3-4d0d-46dc-08de6a69f2fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 19:07:21.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR9KJUgBNjWM24LsslZrImqmulHGkCIF3Sn9oe3j4BF2SWmRQC2jMv3IWvm2qvv/EPB6u2yUIMHhdSBx6+3C4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7783

On 11.02.26 14:10, Clara Kowalsky wrote:
> The libevl repo uses this CI/CD configuration file, as configured in its
> settings. If new commits are pushed to the libevl next branch, a CI job
> is started that triggers the xenomai-images CI in combination with the
> linux-evl head branch. Build jobs on the physical targets as well as in
> QEMU are run.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  README.md             |  9 +++++++++
>  ci/trigger/libevl.yml | 28 ++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 ci/trigger/libevl.yml
> 
> diff --git a/README.md b/README.md
> index 00a62e4..e6535be 100644
> --- a/README.md
> +++ b/README.md
> @@ -72,6 +72,15 @@ as specified in the settings of linux-dovetail via
>  `ci/trigger/dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
>  images for the corresponding linux-dovetail branch are built and tested.
>  
> +### Xenomai 4 CI
> +
> +#### Libevl
> +
> +Pushes to the [libevl](https://gitlab.com/Xenomai/xenomai4/libevl) repository
> +on the `next` branch trigger a pipeline in this repository. The GitLab CI/CD
> +configuration file for libevl is located in this repository under [ci/trigger/libevl.yml](ci/trigger/libevl.yml),
> +as specified in the libevl settings via `ci/trigger/libevl.yml@Xenomai/xenomai-images:next`.
> +
>  ### Local CI Execution
>  
>  The CI build can be executed locally by
> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
> new file mode 100644
> index 0000000..bbd4e13
> --- /dev/null
> +++ b/ci/trigger/libevl.yml
> @@ -0,0 +1,28 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This is the CI/CD configuration file of the libevl repository,
> +# as configured in its CI/CD settings
> +#
> +
> +stages:
> +  - trigger_xenomai_images
> +
> +trigger-xenomai-images:
> +  stage: trigger_xenomai_images
> +  variables:
> +    ONLY_RUN: xenomai-4/evl
> +    KERNEL_VERSION: head
> +    KERNEL_VERSION_WITH_QEMU: head

Hmm, this only tests the latest libevl with the latest kernel. I think
we should rather trigger a larger kernel set, like we do when triggering
via xenomai3/next.

Jan

> +  trigger:
> +    project: xenomai/xenomai-images
> +    branch: next
> +  rules:
> +    - if: '$CI_COMMIT_BRANCH == "next"'

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
