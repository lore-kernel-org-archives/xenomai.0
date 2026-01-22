Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC92D595D
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086101; cv=fail; b=K0RLIcFVLg70VWE3sMrANmUB8JCJhTVpk42od0a1NuycyGPjBcdu3nCZR3Jw+VBvXa+01bjJW3WX0Cu6HiSHpcYVKkjalWRsRedzRxPUyokSpB7FGkU0a5eV/P5urBo98M66TbVSRfItA3P+4gQoL1u5XDzOqystdBEBxCi60vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086101; c=relaxed/simple;
	bh=OKLx0WHfE8u5kQqlytifK3+MrREWymrmJOQgbMAslpA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pJvZ9zceRnYAfLacTicQNlqF7cMMYmn2nenFDJnYK+0uvyoVl/Uh9AGN7ylsb4Zh5qLFzSIz6Lpw5ZGbBzo88RjNrztzkTWiKHJUSG2NQeaYIwXE2upTEfBwDb9pjEq56sIvq1eVEP2ApWS95dZfu5GIIk1kRecWwdsbn0zFB8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pMxK5LNY; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pMxK5LNY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=danNWqCk9KrkO0DHapk8piATGLKT3m/NFnDUZEbFU7LrxsiAkwmiuUJIkkqH59Z8DCPYyE0c4ChxcfMbx8eOMTRyKolqi631edbngg5K+IB1zNWgJvyywc45LM+FeBBxi4zFrYWrq8iEKK0KlQwaHv1W8c3hSLRPdI0l5T5BHUgnu3cqI5RuBmke4zOPeJaB8SL4Gq/0dy2FcDTNe0YgZQ9/Zvnh4CLaGBFRCblZEqUkNPl8EpUZ40u7kdHhJbeBFI8BRFJYyR2fpEIuXGuAm5E4Vu39ppXpDv/mCUEaVhvleCuWBAk3eErDH+cx8zDoo0f+3FNTirPwoRo9O1VzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BahkXtTmpLttoCUJTI4VhE1VKV34v9gaQKGh86MZ8hE=;
 b=aTl5+OcJr7I5Q4qQ2TIboW6MY8iGDescCZHaCBD4IYKgmJNHiFWKvI9aGAWyzlpKQ3W1E/qDiA2cCe9xk/kVlAKJFF1xKuRKFdqnMcXASaptRwdqQ3n/sACSRGTY0Nktw6eRDcbTuWkS67WEI5oBfqXU7BG5SRm3EH9nZqRHINqeifBo3aPgMfHEzrgoJaBoa01LJtrXpsxq9rzmqIgnYCsRwnqJT/wcIhENs9zFF6MPBB5reSaNDcyv1EnthhSZuo7Su5+0xwAyuhHbyvYTPyC+jYvbY4fxTjMVnmm6+DaTK56Lv/Bfzl4+Fmswqe269E0lVOWvN75NirVP6eFAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BahkXtTmpLttoCUJTI4VhE1VKV34v9gaQKGh86MZ8hE=;
 b=pMxK5LNYv18iPPm5C2gnDlKhX7aVITW73UREU8IqVN0XmqOlR1U4APY+5eVq4CSgcU7dQ7sPt6qc1Eqf6A1IXlBWdAX89xIdbR/UqoHG2il16wySpr2rENhYX8Wc/WNSnE2DWS0vBEf6hPQbo8B+regL3KD62yhOWv6vfCmEZvXMbCxSsS7aBiyNKsZEemtnyG9ip3XMH6znwmTrFugQXkvYaUENsUq7jnhqkc3eKPma3wbtjAXwBfiMFsnpG5356xUYVAPyKzUUe6tYnq3MBV+SNlBpzbDkTitm6qjMgqQ4Jt5JZrfX/Ez7Ziv2Mg6B0z1IUt4ACm5eCNz2vv1gEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:48:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:48:15 +0000
Message-ID: <eba3622b-2949-4e3c-afe6-4674b53f2473@siemens.com>
Date: Thu, 22 Jan 2026 13:48:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v4 0/2] Add RISC-V Architecture Support for
 EVL
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260122123646.445823-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260122123646.445823-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0091.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da5ec41-5aec-48f0-b643-08de59b48282
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bksxbEJwTFdNdktLYWVoQy8xQ05VbzhVZmZtcnJIVDJEc2VPWlpRV3kxSS9p?=
 =?utf-8?B?Zk56Q1U2VTNPajRGTkFrSC9RV1FuN0haL3hmQXBoVFFHZ3VyUnA0aVNya1ZG?=
 =?utf-8?B?QzRNRi9XalhMM2JDbjhnb2JPK1JIV1VmL3B6am5OSjVPNDhnUncyaDFZYjgy?=
 =?utf-8?B?NDRmcHpvWVFtNGlDVUo2V3JMamNCc3AxRGlJb1BJUzFGd0liZmFDQzA4dGk4?=
 =?utf-8?B?L0Vmd21iL01VcjcyUnlMUTkxbGZydG92WWR3U3ZEQXBDTHlpbk1ReXNpL2V2?=
 =?utf-8?B?bGVyREpnMEM4Yk04WW43N2p0VG80c1RYZzF5bHQzOUlYbndmSXppM2ovUk5H?=
 =?utf-8?B?Y2VsT2ZIRXZZNlI3Y1M2VWRkdEVmMFMrazNXdktGTzVCYkJSZm5iME42THRu?=
 =?utf-8?B?SVROMVA1aTlXN3ByNFZHWWFKRnJjdlNOTG56bTRUVUdjaktaOXEwb04wYkpw?=
 =?utf-8?B?M3MvOFZrbVBUTEQ2V3BwV0syNHVxMjBrUUpoR3RJdmZiQWNxdlVlOENXS0Rw?=
 =?utf-8?B?YSt3RlN1cklJb1FPMkZqTlBheHplR3AxUXdudWNIQnV3QkZ5QlRuVXlTazJ5?=
 =?utf-8?B?ZWFCSm5WckgyNTNUWEtCS0tzSEhtOU1VeFJRWXdBR3EwbmNWMzVpTHlDdGl1?=
 =?utf-8?B?L09keWpxSXVhV295Nk43RVdRU3p1bWV4QXpDOEc3WmxLc0pYMlFLck05RkdB?=
 =?utf-8?B?TkgvQ3I4L0FQMGdHNElJTUtXYnVuUVJlOUswYVArK1FwS3V5dFVVZjFXaHpY?=
 =?utf-8?B?UUZsRjZ3bkU2aG8rVVV5UW8yYm9iMTRCcXIvNXoyaHdRelVhVDRyZ2EyU0p4?=
 =?utf-8?B?QWxuTUZ6RSsyMHI5QlRweEpUaHg5clJwWktPRUlYaHFkR0lHTmRwWGpwNlcw?=
 =?utf-8?B?dGx3RmRSUTZvMHhTVjhEck5GK29RNzF6TDlqWHhjMGtDbG1HOFFjaDlSZ3I0?=
 =?utf-8?B?ZEl4WmUrWDNmdHdpTGVPc0thbThhbWhFWHNONGFCeWVYUnVmM2JHZEZTUS9Y?=
 =?utf-8?B?Z2JTTmZ3L21zQVhROXlrR2c4c0hta1MxdXJoZkhwWGh1NVplenBCeUhlTllt?=
 =?utf-8?B?bzdlbWdObEJsVWRxeCtIeVFaVG1WUGhXcWNaT3hlQ3BvMHdVclRySzM0MnVE?=
 =?utf-8?B?R1VTSHZzSk56SS92aWdjZE8ya0JmQjJJSkJPb3B5T2lHdks3ZExuMWRBQXRP?=
 =?utf-8?B?RUNQUUlTeFFZSndhdFRaQTdiaHNzWTg5OU9QOWZZa1ArZTFFeW9Qazd2Qzdj?=
 =?utf-8?B?WE5qSHRxV25lTzc4WG14UzByREw4cDkzdHlPQS81emI2NWVQelNTWFAzb2xG?=
 =?utf-8?B?RGh4MVpHdkFPRzNENVpmWm9zeHQ2aGg0Y3M4SVdZNVl5L2FqWUJYMEpjYWVw?=
 =?utf-8?B?QnpwV0d3aEtWaEErOVpLTkVIR2h3S0JpV01FZ0dlVUpMNFZPdlFmVld0MXZ2?=
 =?utf-8?B?Uy9VYU9oQ1BHaUc1R0FjbkcxbElaOHE2MGk0NGxtQ2hRWG92ZU9CUzFwRHJo?=
 =?utf-8?B?MnR1TDdNbm5qaDFZWk1OQkpiUHlRQjZSM0pWdUlSL3VmV1JnK2oxbW1reXpK?=
 =?utf-8?B?MlRIVDBVRW4wbmYyMlJ1T3plaWZsaVl4WFE1bi9PN2ZscVkzdlpmUFlTdC84?=
 =?utf-8?B?SUhQTkRocUI5azNPNnRQRkJ0bmE3dVAvektTSmwyYXUyNnlTRXlOTjh5OWEr?=
 =?utf-8?B?S3FVNTgyR1FPck9oOEFsSWFqbm5oMG5XdTVYL3dRWTVGTDFqSTI3dGIyRDBx?=
 =?utf-8?B?cktVZngrL0VpK2JCSzlCdE5XOVVnNDkvbDI4clU5TDRTejFjbkhvdzA5UHVs?=
 =?utf-8?B?UFZtbVNrOTU1enJLVUR3a01Pc2N0TXRnb0w4cUZEelBSSEVObkFINkRmK0NH?=
 =?utf-8?B?anVTOUFuL21pa2M3dGNJSE5VN0srTDFVblErTG9tM0Vqb043elp3aUNOMGpy?=
 =?utf-8?B?ekJ1TC90a0w4NDJ0MzBxRVNCTmUrZE5POEhQTS9JelRDcDlibFFQSU5XcVZ2?=
 =?utf-8?B?UnNyOXFmbklvUmJ1T3JyRHREQ2hDdjE3aTdlS29XVDBRN1RiNUtYUnV6VjZM?=
 =?utf-8?B?RzJEaHQ1K0R1OFl0QlBZVm9jK1l5aXZmNTNJM3d3RFI0Zml0emVpRE5LTXFt?=
 =?utf-8?Q?1bUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZLWHpIaUlaK0RaVmxFQS9uRzB3bkViQmdubHJMdERYYko0bXB6R0FWTGl2?=
 =?utf-8?B?VWNkR2JubS9TcmFvN3AwNG1qb3l6N3ZYaUluNzh0R3dTMTZEcTZWUWxuZnli?=
 =?utf-8?B?b2lteXpiZnpmOXlvWlZJc2Z3eUdEL0tXSDhPdjV1MjRha1FKQUIxVHE4a0RP?=
 =?utf-8?B?TjRlZXYvUkpnUmMwNjdUeEJpTTJlcWt6Y29MZS9vby9sQzBoTndEZUprNkVa?=
 =?utf-8?B?L1J2Z1A2b25XbGhWN1IzRGJzV3IvRWpLRjVGdHFNVnRmTnc1TWxDc1d6SXEx?=
 =?utf-8?B?dHgrMkZWVm5QMzAzL1BTY3huVnBkVXZTZGM4d0lJcXh1cDlYTmp0d1J6ckR5?=
 =?utf-8?B?VEdpZ0RtQ2o0eFpmL3lqRHd2MEZjV05mYkJsN3BVSUhvV2QrZlVCY1NybGdo?=
 =?utf-8?B?ZTA0dlJVQ1NDK0pSRnFRWC9lZ0R3Q3o4eHlWY09sYU9IZFpaUTBZMW5EbGNX?=
 =?utf-8?B?TFVtRWNUOCtlM1VzYUt2bkV1SlkxRUxjL2kzK0FmVHdLc2o5SzFxa29PbTJn?=
 =?utf-8?B?a3M1M0c2WjNxRlplc04za2dMQXp3UTBvYVVmVjJ5WENmK3UzL1FHRWM5S0Ez?=
 =?utf-8?B?Z3lzM2ZsNmhDUS9KVVQ2TXFHRVJjSngxUlZWUlYzQ051MWF1bzc2RDU3TzlF?=
 =?utf-8?B?NnNFRE44cUNYNVlXVHFYRmZXU3pNazlTY2UwL0NDRXJ3dUU0V0hIaitsYnNi?=
 =?utf-8?B?UEJBZUJWNU9ZTjBjUFE1N1FnekV5TldzMkdseVN0d3RsS0Z3S2sxMTNiVEZ4?=
 =?utf-8?B?SjduczJ5ZHJ5MG55bFJrRHdjdzRBcGYvSE9GMFJkNnVOZFM1TTBHZ1pCNGdp?=
 =?utf-8?B?SW1WcEkrTUZLY3Vsb3N6WkRCUXRtb1ZRMGV3Wk9qN0dJTXNTR3pBRDVMSzEv?=
 =?utf-8?B?cm1IMmczZy85YlpWdi9HayszZG5vV0dOMnlBTW8wZXpDSnZMMUg1WDY3VFJz?=
 =?utf-8?B?L3JNaUJnL3lYb2JJdTZUb2hsZXNxL29nMDV6WXVzLzhDd2JacmNnOE02akZ0?=
 =?utf-8?B?RVVXaWtpMXVLZVF3Z0JHbmYrcUhDRG1XOVNITlZaTHVpMjNWNkZQZFc0SGl0?=
 =?utf-8?B?TVk4cDJLcjFxbWxyZU5xdnBMa0tnbUxlVzhHcXRFWlN2TWxLZHhDY1VaS0tJ?=
 =?utf-8?B?bU9RNnF1OUVoRUZBdzBRL1ZIZGpRVnFpNHRjNGRqUG9CNFE4S28ydGpmVy8v?=
 =?utf-8?B?cG5iUGJnai82MmZrRmIzOVorT0FUUjExUVpMMTQ4S3lsRjZITEhBemo3VDJO?=
 =?utf-8?B?WERSbHhJbU5ZOEIrVnFYdDFuUFFFWFRMVHhpaE9tMTloQ3ZrRVBRa3Zranh2?=
 =?utf-8?B?eDA4RUpoZG56cldTZkk5NlNmMkdlS0FKVEV0V293ZVJvMlJGWG85TTR3eGFj?=
 =?utf-8?B?aU9qdUpkQkpCTjRUY3RCOTVpTjZqMlJaM2dxQU5HUDRCWWlaaXlua05CNmps?=
 =?utf-8?B?eGRUQ1pyS3ZWdDNHVHZEY1pOWGMycWZFS0orZnFIQVM4RUVuUGk4dm0zZU9W?=
 =?utf-8?B?SitOR3phSG16bjRqYWRvYnVBL2hla1Mxd2hPMXdqTEtXY2d1ZHM2SzN4V0dw?=
 =?utf-8?B?VWVMY1VUZ2lPT3kyL2J1VWlyUEZ1Qk9GU2tVa3M3RXlTd1lhYlJBUnhNMGw3?=
 =?utf-8?B?WUlXQVlqTzU5cFp3Vm5Ub0d1T3dYbHVLTkxhRDd1RHpJT3h6M1BNQStpRkJM?=
 =?utf-8?B?ckQ4ZU9rMG9jMzZrQmVjMFMvSjFYZVZnM2s3elZDRnRWUmRXUHdqV09iRElj?=
 =?utf-8?B?emFnMEFVeDUySWVPN0R5cXlPSVZQVUgrc0NkZGpUR2sxUHVuWXJxYXpUSWlB?=
 =?utf-8?B?OGZUZnlmQjh2L0g5b1N4dVpBR3pFUGtZSWEzZ1VOUGhYNkxJdkxPUlZuajJD?=
 =?utf-8?B?bmZCbVZEMnhzdTNZc1phNFJFdGdyNmZnUVpyMStRLzI3cVY3L3ltUTkwam54?=
 =?utf-8?B?L2xGUGgyd0ttUG5GU1ljYjVuVE1lR2orRG9YdEpoM1JEejdoejQxR2tJVi94?=
 =?utf-8?B?Tmt5dG4vMkw0K3IrRGcweDNCUnhGT2dPcGJWc0I4Q0VycjBzQU05dTJzUnZv?=
 =?utf-8?B?cTRPWHFaZG0rVnFVeG5mc2tHK0l0SnNEYllCUGxmRmJieHVMVHM3bVhQbldT?=
 =?utf-8?B?WkNWTXN1UEJsekRMZk1YZXNGNzJqTzJDNjIxK0hvb2U4NkpRWkl3TGtNSy84?=
 =?utf-8?B?SUNJOTgvWWNmQlQrSDk4ekpZWTFwODRPYUJZazlWWHhZSG4xOFJYMWF4THRu?=
 =?utf-8?B?am9xSmpGTklONHZ0VmkxWkdHQ3FtQThRWFRpUFpaVlZtODB3TjhqdXFWUVo3?=
 =?utf-8?B?U05NSFFhVWt4SWtXbERma1N5cU5VeHlaVDMrUk1zOUtKTUM2RXVIZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da5ec41-5aec-48f0-b643-08de59b48282
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:48:15.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpZGBqZ8wUyZJOQ9+9G4wkJymK4FVpwVia5LJWF5WOssJidmpJOzVBa9CWcqeD9CRNWrEk3fu3IpCGEUvNDnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3187

On 22.01.26 13:36, Tobias Schaffner wrote:
> These patches add the necessary changes to build EVL for the RISC-V
> architecture and to boot the image in QEMU.
> 
> The patch set is intended for developers who want to experiment with
> the current state of the RISC-V port.
> 
> Until the RISC-V port of EVL is fully integrated, custom branches with
> the EVL and libevl RISC-V ports need to be used.
> 
> Changes since v1:
> - Do not provide a custom config and let isar fall back to the riscv defconfig
>   with the xenomai-images debug and evl config snippets applied.
> - Use depends on in Kconfig to filter allowed configurations.
> 
> Changes since v2:
> - Use a head based EVL kernel branch.
> - Adjust the kernel branch in the existing recipes instead of creating
>   custom recipes.
> 
> Changes since v3:
> - Overwrite GIT_BRANCH variable instead of adding it to existing if cascade.
> 
> Tobias Schaffner (2):
>   riscv64: Add support for RISC-V architecture
>   start-qemu: add support for riscv64 target
> 
>  Kconfig                                         | 14 ++++++++++++++
>  conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
>  conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
>  kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
>  recipes-kernel/linux/linux-xenomai-4_latest.bb  |  1 +
>  recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
>  start-qemu.sh                                   | 17 +++++++++++++++++
>  7 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 conf/machine/qemu-riscv64.conf
>  create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
>  create mode 100644 kas/board/qemu-riscv64.yaml
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
