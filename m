Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADB295DAC
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580964; cv=fail; b=FNbzPLaMkyyv2qBpLpCpgNMoNhR7H8+9uN59GyqfK5kWhLieovEIQ5FAiMg/i4MCniYEAQKDBe+uhhXPE29xbjaIv8NRo0BypRTkKQnnewZFOWq4xrVAOC1zE8lNp7kitGFStcmMDOsQzTBvnYV+b20gpNmVE2+etzp3upO+MBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580964; c=relaxed/simple;
	bh=WnkTbCCg6yOQWdCVO9+uDBWpujXFA4PcVESRnikl/wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QiJCVScIiK8zHJK/UPOwDKOHm4vK4c8GPRwlKewWu1Ne/f2ssmopu8EPoerEAFRfQqP/dYr+jQqMCw8/ybOaTUot30bxJVrEA+5UlZh/OWZ6jxJEMjrtus/80j9FeLsPya0xLpnmkvorrbSmhEbO+UZH07P6cKQg/F6CCFSSNDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eLzxyyxH; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eLzxyyxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC56Z7Pqa5Pmz9N8zQMSrNXFd/5Dn6GYdzF1/gaTzyAHVQ5bBDDfHzIu/fAx2WUyNcfAuUBvfMkUP3BLC3xgl1T15q8jK6/WcUZW/JWhO3UsTEFaZag+uEc1Yt0gmUtQARTHP6FW10fJg9frfX2MKkOzA85HsfFJVdE07wl2wDW3C+lgSbZdEdqG7R8VZadA1ldaliygodvj/AILmTjG0Jol/I79gGDJU4V7YRTA2WTVU8jmD0tZw6jdT8grb6dF73ea0vZtCneN43tZG1gWimDvs2EzppeMmohkvCp8zkCY+Q5jGopSS+g22e+VZB3/pJyNR5fOkcIk3K8vflIeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cXvczEKqgnfc8YveRTQFvccC5p/dH0QJN9a5XOgDzw=;
 b=AQZUO0IywjUoS14sM9EXQF8wo7MhqHYu//KaXALYdvu04iknwISX1pLY7HWwUg6Rsa++/6BJ+SYCPsVTpeNniYC5GcS+384wjoGgBO3b1mFFhtCJrKjzS+xJ/Ix1zXGGfLyEKqOMU99NtuKC5hjxTE7oCnRHGRFpBEE4aiZXWyHiOoXS9Sp4O1PbJdqq/I0NtG4TbtMB+96+dH/0XYVZE7jPaDFyDR+pn9bQR/7yz4O1uuZNQx081kqpKZL78uswP774OeDgXqo3Z7gBx6PYIF3FuJ9m5fxyQ7LNzzfe9SyI9riv4lldKqDEVA/anSmNsTP5VNnUEi8S359hSXF1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cXvczEKqgnfc8YveRTQFvccC5p/dH0QJN9a5XOgDzw=;
 b=eLzxyyxHhlMQzpI9zYCSCVzhR3sSfcGcDVd3ax/ScI505sD1/M9Gk3Dug4GQY5jsGX9jjRVN0VRUTIsG7sV5x348Vj/HFe+6tnekJtD2XJ1RyNS46nMtrlBpvL3vSGHZa7yD587JQMmOxg9UXOKE6OHXvUfFLMNJB5xXA/mPYBYCGyBF66SQD3Caes3t60hyle4cIRKXcjLpq2hLZQGwMvn4iLfK8w344a6PjlETyJXUdAoI7Y4EkCmX1blWq/Xm8aRB44hwwEXoTDd+RMQonm89Wqb1xX4Y3WREnfRJzEQe0SIoM7vr1Kk6+z+k1TRcZrhwuR6uqvAGCBV5mDF/cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3234.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:02:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 16:02:39 +0000
Message-ID: <31d9a49f-f7e7-4e02-8d65-0d517a0e3bdf@siemens.com>
Date: Mon, 27 Oct 2025 17:02:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
 <b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
 <e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
 <878qgw740t.fsf@xenomai.org> <87347473hi.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87347473hi.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:610:e4::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3234:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a4af96-3a3a-446c-96dc-08de157240b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWZqQStBVlBKOHBnc01mbjI3bnNweTQram1idThTc0JKdm1aUjJZQmlWOUNt?=
 =?utf-8?B?TEhvdEpQODJKM1ZnT2NJYjV2aWdTQzYyZHVic2pHcG43MVlLYzVaeWxFV2V5?=
 =?utf-8?B?bkxYOGZvKy9kcHdlclNYMHVNamRrN2Z1OUN0dlU1ei9YTHdmdmVGckIvSStY?=
 =?utf-8?B?Z1dZTW5ERXZMd0hGVVdYM2x4TmlydkVTSHloUFRKM3RDMjJWQk05THlZT0F3?=
 =?utf-8?B?L0U4aFRKMllWTGVBMWFlQ3VIQi9naVplVW1DUXN2RWR0cVJjVVlETjRwS1d1?=
 =?utf-8?B?OVhTZ2g4ZlRwK1lVcEdPR1ZDWnM5YVE4UW1zOTlva0hmL2NCTEYyUVhvVTkx?=
 =?utf-8?B?VXdvblA1bjg2NFhuT05xa3l5QTB1RGJmVWZ4ak1oTU80aldLWjl0ang2TzRy?=
 =?utf-8?B?cFlQTnJHeFFCNUErTDUwTjhCNSsrSTFYOGMxVk9KRkt2Y2psdkNuVW5udU5B?=
 =?utf-8?B?RkEwK01PMUIyd3FKNldkYUdqTGNYZzNkRGdUUlA0aUMyN0M4bFdIZEJLQmtZ?=
 =?utf-8?B?OWMvaFdkNENmWmIvczFzVXJES3AxdEpuVnFPN3R4WmJ4bXo0TDM4eTEyMW9L?=
 =?utf-8?B?SGw4Z0RQU2M0aTFyS1o3OC9URzVpbXZTSkJ6cjRVZFpHd3pmY0x3c2ZsQnpp?=
 =?utf-8?B?ZmlJRE9JZW5ySzRuRFlrZExtWjlBdjN5VWJwMDVXaHNhREJIUFFHazJNK1Vl?=
 =?utf-8?B?SWRVdGxlblFMKzJLejJVUmVrVUo5WTFEaklmL20zUnFpeThxTmRwaTZoalhi?=
 =?utf-8?B?c0psQlpja2Z4VkdrVnR6V3ZQVnByajN1VCtDSGxlNFBaOGx4SzVpZ3dhd3l0?=
 =?utf-8?B?Ylk0MTFiVUhIWE5pQzFIZXgxVkFDVnE0MTZmS1hSdVV3aDY1ellERHVhNkRQ?=
 =?utf-8?B?elFyMjZEMjBlNDdOY2FOSE1TZlczTkxRNWRBY1ROeCtweDBiSzFIRk05bWIw?=
 =?utf-8?B?aisxNnZsU3FYUHhGbW9HVEFObGNGZ0FiU25VWE9ocldaaWZuNWJtRnUrQ0NQ?=
 =?utf-8?B?UVBFWEF3a1ZmSUQ3d0s1MnpoVU1DK0dpMWNWeXV6SzFHd1FJdmtwOEkrR0VG?=
 =?utf-8?B?TUJvUTFHSjRYSlV2dWV1dytSMjR6b1JuaDA0RXVtNXRhWFJDQzNmdThrUk9I?=
 =?utf-8?B?dEJUUXYwMnJaRkxhMERiZGRtcGphaXlQRGQ5dVBPRFd4Nk05MHJFZGV0SWxS?=
 =?utf-8?B?aHEzVkNYZjhZcEFnRStTZlpTR3kzYm8zclYwVDFLdHUwYmxGeEFMY3YrYkVS?=
 =?utf-8?B?L0tSN2VsVEdwR2t2OUk4VlRDZG1zL0k2STNDSTFITlhMc1UvZ0hiaEpYMjMv?=
 =?utf-8?B?dDUrU2ZETTg4RkhUNWNPcjJDSnY4TnlDQ3FkSDkxRjcydmhmc3F6ZmJ4TnNk?=
 =?utf-8?B?V2ZvcGV2b0ZwMEVmdi8rUi95NG0rTFlmS0pTOHZhQWk2bVZMbnd0V2FSZW92?=
 =?utf-8?B?UTJEbllMZmROZW0ydjlKeGtEdHVGU1ZCRnFRTzlMNTFNTm9jMEFUSS93dFEv?=
 =?utf-8?B?RitqM3I0aXR6bmxoZUE0Y1pOemdxM2d5NURCN2poNWs2c3VVbmJncndaT1d0?=
 =?utf-8?B?ODkwQ3BFdWgyejJvOTNnemtTRUZXVmV0eThSaXQzVU1jVVMrd203eXB3TVRo?=
 =?utf-8?B?b1hLc01xcVVuSloxbS9ENXZPRjF4TlhJZXlNSFFxYkVVNnNIUklFT3pvTThQ?=
 =?utf-8?B?YTZLMWxkWkdFL0xnQ3JGWk5URlFiOXRiRVlXaDcvdFYzS3pyTXdieDlSeE4z?=
 =?utf-8?B?R2ptYXhvZWNYNmVwOTJodDJjZjhWYmxOSVZySTVUZmlOTXZMeE5wcGtGS2Fv?=
 =?utf-8?B?NTNNazd2STN5em5ra0l3YjBjU0pjZEFCRlM4UkhYV1hZY1dZemozcm1Qb2cr?=
 =?utf-8?B?NGY4WFVMTk44WThPaHV0cTNNeTBoeG42enhSK1YwYWFrcCtrVUcxNVdpbTdw?=
 =?utf-8?Q?aXwkkcEPjnEj+mNVz802pu4zuzORoe7r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjJXbDFta0MwdTFkSlN2TVNsRzVDZ0NtaGRYSXpNQ3JvTmg4TzdraW1XTWNi?=
 =?utf-8?B?SUdSQmw5eHdFZGRxTXU0OWxmWndZUk9Dc3QwZEpoVU10bm1NZEt0MFRmYjdM?=
 =?utf-8?B?bS9VeU40UjhGdVFncFR1VFpoZjVUUWcwWlVkOGtuNnFIZEdhYjA4eHFPbjR6?=
 =?utf-8?B?NWx2cExRV3ZpTnFMYmg4VHIyWFpNbjNtZHZtb1RVMG0zV3B6OG41VEo0clMw?=
 =?utf-8?B?VGFaYld2bmRVVytqUFdVODZzbzRyMGplTTU0eUxRSVVDT1JTNnR0bStDMXVt?=
 =?utf-8?B?d2tyWGlldERhWGV3c2JBZ1V0cXdkSDRYQ2pqK0tSNk12a1pCRHRVRWhiMnVI?=
 =?utf-8?B?bWErdm02VWlUN2lqTEtuUlZMY2ZrdUhrN1lENVdzUUpFSnN5STNUVU1Zdk9C?=
 =?utf-8?B?TEk0dVlFOHR0amwrKytMa2xnTXV5dFhBOUtsc05XbzBkbGl2KzBTdkowemZD?=
 =?utf-8?B?by9lZUlaK2t4U3poeDhOUEFxdXoyRkZUQ0ZkbEpIb1hJdVBnV0d2d0lkS0Uz?=
 =?utf-8?B?RmpsWmh5N0x3WnNrYXpDdklxek43ODNMbDJLaGF1aW96N3BhUUNYeUl4OURh?=
 =?utf-8?B?azVtYUgzODZ0OHFCMmQ4RHVva2pNeUUrY0hsdURlT0VNbk5QaFhqNEt0aWUx?=
 =?utf-8?B?REJaUGlhMW94OGY5RW9OYmErOEtTazFMdlVBckg2b2psUEp2Ny8zcDMrSlli?=
 =?utf-8?B?OElKU2tkVGoyM0pmWThmaGtTdkVsd2JpdTYrRG9yNGhtMUtVczBaWmlQNDNp?=
 =?utf-8?B?c0lhM29IRXdLVGtLaC9nYmhiNU9DQ2xhaUZzcW9WL3pubHZtUGlKTkVtaUh3?=
 =?utf-8?B?bkVDeGY2OWdsR1ZIRWREYldQWGhmRkJGTXgrOGV6eHJ4VUxDRGNZU2FqbFVK?=
 =?utf-8?B?OUxybnNNaG9IUjIxMll3cDNoWGk3b0dKNTV6WnhSKzFwYmJaQ3A3LzBiSFp0?=
 =?utf-8?B?ajQ2YmZmNWxIZkFxQnVhTGorRFdkbC9LbGx0czQrblJMNW5NcSsvMjhJQzVR?=
 =?utf-8?B?OEorTGhyS0lUdzBBcEVWalh1QnZLSGNEZWZTSzEybnVyVndlREdSRm9DOTlm?=
 =?utf-8?B?RVpUSDNISTd5eGlRMnA2Zjk4NU5hQS9YUEJ0MlBqT0JvUnJwRzh1YUh6R1ND?=
 =?utf-8?B?V09vY1NIblhxT3NXdjg5T29IOTB2SE5KMk1rMlg4eG1CTGhUQlREVzlid0dY?=
 =?utf-8?B?Y2M3RDVhaTd2eHd5Z0E5MDNsT3dqdTJDd1IzelhaWTFzRFFxMURoUjl2cE1C?=
 =?utf-8?B?T08xcGhaOHBENmVUTVhLaGM0MVhYM3RKWVY4UWRESFVkQmluY2ZGbTUrZnRY?=
 =?utf-8?B?NEk4dFljaU1kekhkSGZkaWFXMlIvc0paUWRpU1gyVlFqSVJmNHQwRmZXbEhZ?=
 =?utf-8?B?TS9QSjVHTG1kNlJ2Q2FOVWtyOVRJZ3hPTG9NOFNqcnNhRzNDMC9kUzJvMjNp?=
 =?utf-8?B?NXFGZ2ZTYXI0OVpEWVRFZjJQMmVaVW56NE1MTWJJRHVtdTNIQ25vcU1VQ3di?=
 =?utf-8?B?QThNcjB4dkpKc20zeSs3bVNaUmZjRE5vRjRGT2NESmN3RlpSaWUraFprcVAv?=
 =?utf-8?B?c2RiMk5hdUxYbWU1VU0yRXdyV3Zjcml6WC91bG1OczljbjB0RlJRcThJelpF?=
 =?utf-8?B?Mk9aOHZxRlhrRWFwQ1NrZk03bDBod0ZTTnErRlplQnh6YkpuMFVJWnRJd2JJ?=
 =?utf-8?B?cmR1MzRDbU9td25FVDI4NEwxZjNPWWZndXE1NVNWbVVnVlhabHNwd2dGTzAr?=
 =?utf-8?B?L0J2M3YreXIyWHlZYUl1NXlKQmtRb1YweG1TNXJaeVRHY2h6eGhuMXY0dVRL?=
 =?utf-8?B?UlZvanFZSG5oVjR2VlM4YUdzNmpOWHJVbnlCOG5ZbjhBOTZLQWg4ckVIR0VR?=
 =?utf-8?B?WHFGM2tDajNaZmFCaXNrRWh0Qnl6MEVHWTRwajhBMVpDQlhrSnl0Y1BwNWVm?=
 =?utf-8?B?SHVYS0xkbGFMbDlLelR1V2cwZUZoTm9vZnVJaHhsVHZhQWV5WnVCZG9QWElV?=
 =?utf-8?B?ZzJJTGFUZ0hnNS9rVkxSbGZPR0x6RUFuM3RPNHJpWURISkhKejdaTzBZVUY1?=
 =?utf-8?B?L2lhSkR3T2cvNjIybjExaU9wQjlpN3ZsYUFvVEhyWWlZc0hGYW9SZHJIY0xB?=
 =?utf-8?B?cUNPTHZCT245ZFF4aUxjZTlEVHI5MnRxK0wvWmxFUXU1VHRmeFUrMW10SG5o?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a4af96-3a3a-446c-96dc-08de157240b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:02:39.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLZsvGh+WuvnT7pWytD+IrWfHV5ppUA0F7/QedgkLwJ/TK+UA2T326bsfsGYcdzT9IM46KZLoP0QWuGgd2xSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3234

On 27.10.25 16:45, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 19.09.25 08:40, Florian Bezdeka wrote:
>>>> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>
>>>>> ---
>>>>>
>>>>> Changes for 6.1 will look different.
>>>>>
>>>>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>>>> index 1f5fcac32b2d2..21f8785948ca3 100644
>>>>> --- a/arch/arm64/kernel/fpsimd.c
>>>>> +++ b/arch/arm64/kernel/fpsimd.c
>>>>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>>>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>>>>  				  unsigned long cmd, void *v)
>>>>>  {
>>>>> -	unsigned long flags;
>>>>> -
>>>>>  	switch (cmd) {
>>>>>  	case CPU_PM_ENTER:
>>>>> -		flags = hard_cond_local_irq_save();
>>>>>  		fpsimd_save_and_flush_cpu_state();
>>>>> -		hard_cond_local_irq_restore(flags);
>>>>>  		break;
>>>>>  	case CPU_PM_EXIT:
>>>>>  		break;
>>>>> -- 
>>>>> 2.51.0
>>>
>>> Philippe, this cleanup is still pending, applying as-is to
>>> v6.17.y-dovetail-rebase now.
>>>
>>
>> Which tree is this? If you mean v6.17-rebase, this patch is redundant.
>>
>> void fpsimd_save_and_flush_cpu_state(void)
>> {
>> 	unsigned long flags;
>>
>> 	if (!system_supports_fpsimd())
>> 		return;
>> 	WARN_ON(preemptible());
>> 	flags = hard_local_irq_save();
>> 	fpsimd_save_user_state();
>> 	fpsimd_flush_cpu_state();
>> 	hard_local_irq_restore(flags);
>> }
> 
> Oh dear, I read it backwards, this is definitely not redundant
> then. However, which tree are you applying this to? 6.17.y does not
> exist ATM here.

I was rebasing it on top of v6.17-dovetail-rebase (no .y, sorry).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
