Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69E2101AF
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283536; cv=fail; b=PwVF2s0W9LAgI5+T3b9G+lvQFtYT7/VuYfmrE+LQx2831RqTuPO0ZmYS/6Y8JyIPGEE2QmLnKS+h0QIxqYlG5w8w2T3YLcSTlwOTsMGxjUxBYHTgsjC9ZKOJCjjtGRfwKDicIGKIgwsz4O2g0Lrx4L0x0LcljRJsthPzhvznPfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283536; c=relaxed/simple;
	bh=rorry4JPS97GkKA7VVpPtGjl/0zAn7bB5TMTN9BavIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWmGO56r+v7LBiJ/wuqy8LQzjsP/nM0JnUiEDS4dBEDV0PsgyRX3Aikw2Q9zu2ogTsJ+HaQRSOEmn1ZHCM/Q7xRZvXgZn3NvlRlDn/A4W9HXF1CrKoiakvrAtKvgBgSk0UQ6V/7GmdaZHZ64tKgfzYDyjoZ+bzSftNKlRmWM0dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yX3CQ6Qc; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yX3CQ6Qc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYKMW5zaIjZKRNXyGInWIog3PjIPujmHHjd6RBixipsl8QDummWw9vkWrK8Av2pnqjb/ccJNCf+W35IRaPXZcJEHirUp9r/OnGxmixUOh0TeNW5EDL3P95Ni7crqfAW001687ksDC7bLw2ol/g7zUg41x4RfY1Vhij7QIxL/OM7HwUXSoTP1oy4OeXoO2vjl6fzvc6u+E7wUG6TzFqZB+GvUANvkC+VAl42YZBdhIsMWmwDansL90me6uZk8Sh+qOm7jdaQfaXRUa922J4cwmAP2/45PKROV3piaMGUl7yz1ZEZskE4lTRInHzJkaiH9jo9u+/9GivgUjZ8CjZ53VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLq9Jla0OIL1+of7LMQF51QLFatw5kBmcQUipSzs4/g=;
 b=Vcv1OxKCZinjkG+qBzK0FVGSbFuHs2z4SWy5FK6GQvN8/jXjRwB7G5nnIIC07SqqawbHw4NDvIpccf8Y8ix5EaTu/IInG2Z3c6OEaHOpj6zHEh15llRFRleBge810q9XvZRtcmEJAx1nonmgrTIsvInirOGqpEz+5Jg9Hfbb39w60oiwKbxZ0nqQE9YKS5jCyVLvDfakF80GH/KJIZzmNXLTRIBPMVCC913sRsvKuRUFa7abKfzBOeXcUVZOR0cFy+l/4NAg3Xo+eftCLqdVnCClrV4Coje3pA4DHCn319cMwk3R3fHudM5GWJPnSdv9TjpcnFkRnPnfNyHZ92mZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLq9Jla0OIL1+of7LMQF51QLFatw5kBmcQUipSzs4/g=;
 b=yX3CQ6QcFLbm9RzoIZ756SPOoqBE8ZnsN9DmGD1Df1hkHddjx835h2aXXjZQR/fi8QSDpxcoh5ZFitX4VYQGXCL1ZYsmrKiue/2N47XIQKxm/y3SsmBx4ztHYYf82OvJDbeoQtz9C5gaUGC1mloRAxExmr1KUa+1wNq5PKPZm9ceHwIjCQoNrCObM6WGgzXzyQfO+c3vt0xTLwa5UuxnyAC61o+p7DUGDH1QfRokQCWiUnltUY64cQVT687q0q7LOzwh1OlSheV/vycZlm0NGxfq6FC/gosaytri56tEcyoLKYcaPEwUAwP9AdqeGxi43bAx9bKsXt3/HaQ+8ZKr1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 2 Sep
 2024 13:25:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 13:25:29 +0000
Message-ID: <60717568-2449-43eb-bf00-fda7035fe958@siemens.com>
Date: Mon, 2 Sep 2024 15:25:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add env vars for session and cpu-affinity
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240902131124.37844-1-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3631:EE_
X-MS-Office365-Filtering-Correlation-Id: 3488df53-88db-4781-c134-08dccb52b6b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHJaS2J6L2M4dWlWZHkwZUo3TWNITmJyU0lSWlVzY05zYmt6RmdYdkhaSm5S?=
 =?utf-8?B?QWUydjRPTTFSWFJ3TVRJTDNUQ3Frc2tWNU0rNlVubmZUSFowbU83RWtvZ3pw?=
 =?utf-8?B?VTFmcWFKVFdXYnpnYkFqR2dtMDMySm83cmFYZkZRMnRKSEtlc3R2ZlFHMnl5?=
 =?utf-8?B?cVpMM29nek9XRjZGZ3hqTTFyei84ODhsbHJCQzVwR1JLbzJyditvWkdnZExt?=
 =?utf-8?B?eGNISXQvcE9LME51K28zNUxodTZ1SS83b01HSmRmU1loS1ZGVHZ3RVBiVFFR?=
 =?utf-8?B?QVl5aXovVVNVd2tqY0NEMy85UEdTL29SaitORU5tS1p2c2xhMkJzYUdJWmVL?=
 =?utf-8?B?bDJDNFBnYkhUYUlhcS9aZXFaS1lOTkJZWTZLY29yeENVanZqaFM1d2tXYjJF?=
 =?utf-8?B?TTBZckQ4SzdYT2hJaDFuWW1KSUFSdFdmK0Q2ckswK1E5S2F3bnFnTEYxSUkw?=
 =?utf-8?B?aWgzb0NaNVRHMEFRMFAvMWRHMnRXQS9DaDlEdXd2N3pMRWcvRWpBUDYxQTlh?=
 =?utf-8?B?V25HVTdhU0RVbEc2T2M4N2FDaHBoU2wrYzlvcm50SUhNVkdvdmkwR0pSS1dC?=
 =?utf-8?B?RFA1c2gzTmJlRmdlaWxwU1Qrb1ZQMW5oR3o1cFJ2UUhObm1BdlR4MXRGNTBy?=
 =?utf-8?B?L2hnT1hhQ1RBQjdVRVVGc1RKN3RkZnY0UmxTSDlTN2UrODd2NitiRVB5UmRW?=
 =?utf-8?B?bTBOdmRZM25JVWF4YU9WN3JUTEdXU3RkdS9lS3JtLzBxczgzSTR1MVJwbDQv?=
 =?utf-8?B?blpSaUltckladVRMQnM5K0hWc0xTS1RmQWpMWFhPWXB6cU5lM20zZTRoTi9I?=
 =?utf-8?B?T0JFZ3ltU3VSbXdTSG84Z1BSSTZTK3dBRzdQREVhcWt5WmNGNk53QmRYS1RW?=
 =?utf-8?B?Q2U2Qll1NkdkdlJCU0VzQmxtU242Z0JpMGJZY2ZiVFkvOHRIM2g4NGEzcHJT?=
 =?utf-8?B?N05NeGVHUk95dXdwTkR1d003dDlDOFg4TUx0TlNGdXMySE1qYlBXY0xNVkZw?=
 =?utf-8?B?WS9CRFVKSlAvOE52aXZuWTc4ckxEQWQvOTdLWWR6RmtmTzlUdnFvNEFmMGkw?=
 =?utf-8?B?SE1pV0Y3TlRmYUpkeU9OaWJhN05ZaWUwTEFIcHVwQ2RjYWF3R3Z5eldwM2Jt?=
 =?utf-8?B?eHY5RzF1OXY4V2RCajRTSXBPMHNMTXZnS0RqY3Jrc1BReCtvZjlkQnJJYjA0?=
 =?utf-8?B?aGpGbVJpcXBIUUg0ZytjcXhMdWtZOW1hZkROdkY0ODJnRjZJTnRWM1lsaWR6?=
 =?utf-8?B?eWlZZ2tHS1FBeDhLRm9vaDJqUVpXdFVhQzF5Z05MSkU2c2xETGJmMG5BVUJN?=
 =?utf-8?B?WEZSdFljVUtBWEpvVlZKMUllSEZML1BFb0NHVXNPY1dhNTNLTWlLMGt4L3Rw?=
 =?utf-8?B?eU9QU2RVNHFtYkdwcWFFYnRUMVprWXcyZWxZTDRZdGlBcGVBSDRiNUMybGc4?=
 =?utf-8?B?UG5CSmlMdUlLTXZLT0NRNFlrc1pacmFUOHhsNnQzb0pyYWFFZmI4UjZCNE1n?=
 =?utf-8?B?WWNtQnU3SWJDdmZFMXYxQVpiNTA1VTd2aHZySDd0Um5qLzJId3ltT24xcGVH?=
 =?utf-8?B?L0Z3eGgvODRZN0xmcjlQSU0zOU0rNTM1cStNbGtObTFlbXRnYUZpYy81cW9x?=
 =?utf-8?B?RFg2ekY0RFBpQ0YrMzBhT2J6a1Z4YlcvZCticTMzZEIwcVdKQjdKMENlalhm?=
 =?utf-8?B?ckFHVWRCSEVCQ2c1dDJHaTZqSE5nanptRlVyVzkzekR0bjhCNmxQejB3NSt0?=
 =?utf-8?B?Q0RlQThGYUgxRzVzN2ZHQzcwS1V3ak5Ed2RpcDBORC9xUmZiYVd4WXdPVFk3?=
 =?utf-8?B?bjNSSVpNM0xaVTlvd2haQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJTak5UZGp1WDhSWlo5ZjcycFI0cXppVzJKa3hPVGkyeUNlUkpybytxUG01?=
 =?utf-8?B?RSswdlhCR3dHSEJuRXU4aDNER3FKejFZYXNHbFZ0SU9yWkxPcng2VG8zK012?=
 =?utf-8?B?TEp2NTREa1lxdGdVQnErTmd1QWZEdHpEMGczRWwybmVhb1MycVZPZ0NMVlUz?=
 =?utf-8?B?bjdlcGdxMlBDbXJYK3NuenRJVlZYTklGQlZhaTNxcFBVN3VKK0hKSTBrN3kw?=
 =?utf-8?B?bGt4U2J5YURIb2p0MFNiRjVZY0Ewb2RJU2IwcWErdFNsdmd1N0dUSmo5RDMz?=
 =?utf-8?B?d3NSa2NkbEZIdXFWSU9OUVk4YnNlb1BuY0FDWG1rMDJJeHp3RGlVOURwQkdS?=
 =?utf-8?B?ZmdwMXNsOEZ0Sk5BNW9BTzIzU3k4TVBCem1jQXRXcDVNck90OHl5V1JCUkNM?=
 =?utf-8?B?c21aRWxqMUJ1aHZiVjV6ZlROcTJuRTVISVplblFoODRNdFJNUzVFdHFoSW56?=
 =?utf-8?B?Z1NqeDJzcVN6Rm10dDl0bmxZWmRVVDg1UFozRitSTzhZWlp3TjBFdmRvR1J1?=
 =?utf-8?B?Z2EvN2lLWDdKUDlwRHdOY081M1RTcE5pcVlIQ3lra1FFbVdqcGFQWEZ5MWtX?=
 =?utf-8?B?QWpmNUZGbWlhRyt6UW5UQ3FoUTRmUXVDRXBYN05QTUpKd0JvV01paTNCVDlW?=
 =?utf-8?B?cmNLRXhHTlNMY2pYYXhMUk1FMEszdjRud2NPVHdDK0lhNVFQK0VvYVNNQmps?=
 =?utf-8?B?U2kyb3pvekNIOTRib3JrUVAwKzJiZ1VPWTVJV1Y0ejVVaU1vWW5xWGExSEJh?=
 =?utf-8?B?VmNnY29JeDBidDB6Z3ZORzJwWnpiSGJkeDZmQ3hOeGtlWStlRWZpQ3lyTXFF?=
 =?utf-8?B?MzYrZlAvZjZSOVFLc2NYMWhUWVlBWEoybVpuQW1tYW9Rd0hjcWM5aVFmNkpo?=
 =?utf-8?B?bG80NmZNU0t0citRK0xlZnlNZEdqWklDaGVQR3N0VkVKblJ0Vzd4MEQ3cTMx?=
 =?utf-8?B?dG5rODJ2ZVRDTGFBVzJTU3BZMzZXR3hHRlNIZ3JncXFEK09jdGoyNE81VVZE?=
 =?utf-8?B?TVRQUEhZR2Qrd0VLajRLc0dFZmVMVzMvTC9tWnkzRndhemhJWjJPcmJqelRS?=
 =?utf-8?B?RTYySHRrYTJ3OS9CdDBHNTlWcDJzOVdtS2dJakRIeW9EV1p0UnVmR1JyWmJp?=
 =?utf-8?B?dWljTm5qcWJqMjRHU1pWUVQ0SEhlVnZYdEJMeGJINnJScnBCL1diVzI4WDdJ?=
 =?utf-8?B?dDVETFVnSjBENFJMS3dpSzZLeFQyb1NIbWpPZ01VL3VzUG1OMXlpREhlc2sy?=
 =?utf-8?B?Vm15c3VNNXY5MkZIMTBsVlJPdE1EMGhEVGoyeDlsaE9qa1c2QWFMY1NiNkc0?=
 =?utf-8?B?OHBJNDdMbzFiTWJJTWJLMHRsMkFwV2E1L2h4a2tOUWk3SkpVTFJ0eHFvZ0dP?=
 =?utf-8?B?UVI4b2VCRFhDbm9GTXpLZnQraTJhZkJuNytzci91Vk1lVy9vWXpNay83aEtS?=
 =?utf-8?B?cUhqYkFJcWh1cElSamVQWWNRT2Joa1p2bGxsZVRiRm5ZSnVpVmlxcUVaTjVs?=
 =?utf-8?B?bEVNL0ZPaW5xMnUyVnh2dGpCRzQwdGp0aUIxK0FKUk94UGxscGxIQTNPbVZy?=
 =?utf-8?B?RlhkeHVqcnlTVU9JVVlLdFVUa0xBTzZRUmVHdHZ3akFRc3pWd29MNUdqNXpp?=
 =?utf-8?B?TG51ODQ0ZlJRQTNBbk80dkxTZ2s2bE9MUFgrZ0IzbHVLUWpLaVpBMnVhY1VP?=
 =?utf-8?B?cHQ0dDl5SVp6Vm1lek9uQjF4WFNVcnZqQXhQK2VnNTFUZXIzTUFNU3ZYUkRJ?=
 =?utf-8?B?L1NUSldPZm9ZMG5tWG9QSVVmQUl1S3J0c2N6eHBvM2xLaEpzd2xTaThtNlhD?=
 =?utf-8?B?dzNHY2NNYWxaK2c3VVk3cG95SGthbEo3UE9aUTU4Vlc5S2ZxQzdYcUZMUGtD?=
 =?utf-8?B?dkNUOHFiT05uL05NTWRDaHAwZEh4bzdTWXZscGRWRDhlQm1qY1RQV1d1ek5G?=
 =?utf-8?B?Nm5TVUcrTGRNWHJ1SHJWMmlVSExndkhMTGNURnlMalRzdUVIYWN0QW5YcTdy?=
 =?utf-8?B?Q0c0R1ROSTYyN25PRDRMOElOQ1ZTSUxrYzNLaFZENHBkeFNBeXFBbnVMeVI3?=
 =?utf-8?B?YlRxQ0ljYStZb0gzaHFNc2NXUVQxZlRtQTNJRkUwbzREMnlndGVyTldJYjhX?=
 =?utf-8?B?TGNPbmt4KzNqVzJPNEU4SkJxeDZjaUloODdGSUloOHkzd2ZCK1Y1SHUxZlRS?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3488df53-88db-4781-c134-08dccb52b6b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:25:29.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gglvupEM6VV/pOBJE3F9tDGSKV5DUo8KDT1nz8EiH6mU0vAH+yo5ohM8y+jJmcNLKLVbNXgUmm7rmnNaX9NSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3631

On 02.09.24 15:11, Simon Graber wrote:
> Hello,
> 
> Revision 4 of this patchset clarifies the purpose of patch 3.
> 
> Changes since v1:
>  * Usage of environment variables is documented
>  * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME
>  * Reformat patch 2 to adhere to code style
>  * Reword commit message of patch 3
>  
> Simon Graber (4):
>   lib/copperplate: Get session name from env var
>   lib/boilerplate: Get cpu-affinity from env var
>   alchemytests: Set cpu-affinity by env var
>   Add documentation for env vars
> 
>  doc/asciidoc/README.INSTALL.adoc             |  7 ++--
>  lib/boilerplate/setup.c                      | 39 +++++++++++++++-----
>  lib/copperplate/init.c                       | 21 ++++++++---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 ++++-
>  4 files changed, 58 insertions(+), 19 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

