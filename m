Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111C3A7F7A
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958262; cv=fail; b=fER59B5gHt9y1P18dPq8wQGBLuHE4scUlhDQVc0NWDgJvSX6AA7zzI1j6TgjDumsykNFxXcRBnTLiXU3bC2RpLjpbZdWA8TQ+Z+g9xm1H/LHgznDAtShwRDnFeDx1XaAOjDeSQIFsbvH+6bk6qs3w5HfhGaKNvj4jjAfl7ukfx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958262; c=relaxed/simple;
	bh=Ji5HE9Cotp3zlpinKiq67ekrNk3Ax+piPs5FQdZZ0y8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=snhZkrQexY+CMT+CnUrDHyg9wQuC3lLkRo3Is/KV45lzSTHF/2xpcjTtPfLcHZ7+KFrRlIPc1d0zE6fZAAwyOp8Y8Zvxy2Xf0K65urHUUfhy6oNb71Vt6EfHBb46D7shWepWkr4XsUER5NLPf4dQliccsHV/+2yNf4YfkCkAL7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UOH74rks; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UOH74rks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isl+jF1EtCg9nqurffHTgZRP4rYf8svf7Bk6+9bPHM+rFmALoJ0lCw+6DaqvrwgQyIY1bSYijF+9yG+rdzkGCc82U0hCFFWy7cQs0PYpF0VHtZbGho/XhWJyU2/GEb7YFGdv8KfLScbTwMQUrstDGhm5jZjZI1PnHqfiFusAPCf9QqMBRoW2JKv6pqwrKpfxJ++l1TYyLhnJjZBvIbqDkRtOHkjGqJEdB8rrd6Y3uQmkN8MctEF48LH89xFqNs7R/QaaFUUgNdReEB2SnbDYbREpnBMMXRnRu/1AfpiGXkcAS4G2PHJjPEi2rGjWJLLGPR/G470So4x4CjyWF/03OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXgLh9BLPaFZP9APYVBjuBpZaxrne3ihZbyKmqbxD+Q=;
 b=G+tg+8dsS8o+d+g9KFnqP1eAjoPQptaFikGzmTupQj8Fc/pkf3PtdNbfIVdJlTsDsyI/yG3fNHVZb/VjfEXdbP6Z25S5uWWt0YbFmCn2iUbb8+Ez47TwpLMIPkqo7bP/RMGutLUaYFnUzujI78j/8Eo6uVEFr+BPDdcK9/akjLfSiGL9dwn/nqnlAd0leNWFtZ+aQGnjx5Oc8yKdzbimk8umWK7FYIydANoHPEOd+RZyBiIb5tIg7LOdNOSxZ8Wu4pnHGfkjMfB4QVeREvT3pPzvmbiCUjqM3KU0EiVjcAHXbgnGTCq44JT9LDGbNT6JIDiwRy1evMXB7Ju5TEELFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXgLh9BLPaFZP9APYVBjuBpZaxrne3ihZbyKmqbxD+Q=;
 b=UOH74rks38xUr6colhHWbQ9Rgk+5k0Xrskxiz8D42nE4dZvdoR8a6ecjXFMea7ql51vt65RN7It/mTw1En1MrxPcsFKSonaafdBtdSWTXRZ9mo8rOW9dBwFJHRaAqLS/rV26JZ+VyPLvmsvTm/4n/CFlrF+YJbL4z8ZbQDmf1tsYosZANIIkDifRXXj6oB7kF+W56NZMI1Q0I6c2+LaHadI+myMIibeDriKREnlWGshvSk5BUDKzTDpP4Lqy8OKuwfzZHOWuTksw36UBnR3JCNaXB13N4EpKZBiPsx3uaPuPi1zDreZUWntwY39yv5p66mZ7r5s613RkqhFNCej6GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:37:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:37:37 +0000
Message-ID: <10114da2-8616-498b-8b08-6a4d0c7505c5@siemens.com>
Date: Tue, 24 Feb 2026 19:37:33 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Add official support for 6.18 kernels
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:610:57::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1e3207-b647-41d6-06d1-08de73d3c89a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXdsRFREMGNMNG1mb2VuRFFkSythb2NBYkJYL2RrNWdpbFpyZ3hOVFUxOG9X?=
 =?utf-8?B?TXZ3em5aRVlYSExLZ3R4a2lTVmExOFRGSEpuZG1sTW43S25JM3BoZjVvTnJJ?=
 =?utf-8?B?Rkh1U1h5clphcnRkUzVIaS8vOURtUEZsR3hHTmNuQW41amtjUytUZlE3S2p2?=
 =?utf-8?B?UnRKM3pvL3FCaDlDTFJWT1Fwb1RWeXVlak9IQUpPMnlJVDNaL3pXaEtGTTVH?=
 =?utf-8?B?dDM5MkxKdUoxWEY0eEt3SmhXY2lLVzd4RERTc2VsUWRmRS9acEJCSXZTZUJT?=
 =?utf-8?B?NXJFY0ZsVmFUd0Q4U3FVVXc1b01GbVFkWFltc0IwWHlpOExFb2YxSm50eTJE?=
 =?utf-8?B?K3IzTGlJNUVRUVp0ZGFHV0ZqL3ZXa0xnbnFyZXJMcUVmak5vTTk5RmxKZ2dH?=
 =?utf-8?B?UWRvWE4wT3VrNW04OUFocktkT2s4VWZrNUhROEllcC9BODI2ei85VTRqQkll?=
 =?utf-8?B?b1o5Z1dQeENLSGpueXBNMy90UEREK2NWQmJxU3c4ZFA0VUp5T2U3bHkvU2RU?=
 =?utf-8?B?L2dVRVRMY2ZLK21RSXRtQWQzbmpkdjJ0L2xHU2wzNERJYUdrZ0psSVc2b0kr?=
 =?utf-8?B?MlBHU1ZmOFlDZ3dOUWRCaTFJZDllNk9WaW1nSU8ycHBxTEYrNGg0dEF2RmNw?=
 =?utf-8?B?bENQYXRPVys5eDgxTFUyRTRzMUFEK3JSVkRhUm8wSE1wVFhXMTRBZFBhRzRK?=
 =?utf-8?B?ODFFd0xiMWcramZUQVlTTkM2SmZHekVIZDErVkRvc3IrNnFlWExiT0gwcitm?=
 =?utf-8?B?OURIWXQxSVRZUlFWVnJPSHFBdmx6WVFPZ2k1NEIyQW1xdEtsTmRsTTNEcmpv?=
 =?utf-8?B?dzV0dkhNb3NwTEMrbXBZd3pFMko2L09DOXRLWmdvSjgwTkdMTWhQUWVJY2Jr?=
 =?utf-8?B?Mis1MHEzbUV4UGQvcXl0cktKVE1ERW9EUG01VjNOMGtEUklpeHJKRUlpSVVK?=
 =?utf-8?B?Mm1XYXFWVEJITUZBc2VJeFhKeTlTMGp1bzRJMlo3Y1lTSmtmQ0tlVzhUM3gw?=
 =?utf-8?B?THg2cGlseG5sMFFoNUI0aUpDVmI0REExTlNSUVdzYy9Vai93azJlL0hQbVFF?=
 =?utf-8?B?UDZqWm9SSHFQSjAvTGw5SmlWVm5VZlQrMUlOdXRnQXAxS2EzUytUc1U4S0Qr?=
 =?utf-8?B?Z3JTK1pYakVmWEo3NmdjYTk2U25HQjZXbXIra3hDTXk4QzA4Z3l6SFlWOWpy?=
 =?utf-8?B?Wms2WUM4by9KZkxqbUlONW1Zc2lrSmFBSnJ2ZzFla3BlYVpSY2RIZWM4cmMx?=
 =?utf-8?B?Mmc1eWxsQ2Nzb3JqVG5VdlJqOEdBaFEzdzU3SFFHSDVnWUVJWTFoS1pUdTZC?=
 =?utf-8?B?ZlI3Znd5cjZRMGVmQlZQWkVvcDFkY0N0MDAyTHpLVVhNeTY4SVI4UzVRTFVO?=
 =?utf-8?B?WWhYSGgvT2h6VFpyRGdHRnY5VlNVWlAwTkZDODhZVk81YW5kcHFydmwzZ05q?=
 =?utf-8?B?NVZyZ2xXZVAwTk91cnFxSWpKUWVhMkU3bDJRSGJ6aUNXSlpjUitoQUkrdkxP?=
 =?utf-8?B?MmkvK1ZGYWtady81SDlWcU9OVWhCbXlRbksxb0Y5V09WOWhUSHFBMjdaQncv?=
 =?utf-8?B?ZHNrTS9ZakduOUF4QmcxVVJhZ0Fja3llWnRvUzk0elp6Sk5mbmNiR2UxRm0z?=
 =?utf-8?B?dWdULzRUbm5uVzRJdExFaFcvTkY2M0toeGxqbTBhaXh4N3ByTHFKNHdTQVpq?=
 =?utf-8?B?V3RwNXFGRm4zWENTYmZEUmRBZnB1dGQ4b2Z1NVA1M0w5eEJhY3luSDBLQk5q?=
 =?utf-8?B?NlY2VUlrR2RCOEUxdkgwRU9ibEp6N3JodUR2WklXcktyM09TNmlJVGpZaStz?=
 =?utf-8?B?T1QwSElGcHkyY0R6UU5CL0h0SHk4VHpqZFBMbFZvZXVLWmVvVUh4Qi93Qy9B?=
 =?utf-8?B?QXZRWHNZODlCOGVCUTIzWklEdG5tVEd6aFZnTXo4NDE2bTluT0RtMFFhUlJU?=
 =?utf-8?B?YzdtMVBRT1RnWStSSzZISzMxT2xIWndCVjF3c0RsSVVBQTYySTdpOVU0NEow?=
 =?utf-8?B?TmNtdzNaZE1RZTNFSis5eXhQa3hIa0pVNWhiNEI5b3I5ckhkNnVOUmFPdHdl?=
 =?utf-8?B?RThqWmJSUnlmSzB3emRLK3JRWkozSE9KOWlxakdOK1FkZkNzNEUrYXMramRD?=
 =?utf-8?Q?e+L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGpCQTUwWWRKRWhqRzJJNzdHYmxMejFPS25mYUpFemZRM1JNUmpRQ3FDek1k?=
 =?utf-8?B?TjBCTXlHaThpVllHWGZWWXBsVmVyYm1Da1hzY01ONzBldnlZS3JuaERIdVBu?=
 =?utf-8?B?WHFFeTVJYys0cW5kamdwSW40ZGFkcGx6L3FxS3RXMXR0YjArWWhzUDc2dU1G?=
 =?utf-8?B?aE9LOEtvQUlGeWt5bjB3VkV0M2IzUGdzUis3dk5FdStUQUlBT3JiT04weVAr?=
 =?utf-8?B?MEJHZGMwUUNNZWI3bkNHZkRXeEpXSkdkZzBkR1V1dXAxRUtLcm81d1Q5Ykpq?=
 =?utf-8?B?MUc5M3VpQVMvaXdkNUFnMHhCRmRxUHNxOGRneW11TGUveFFwRjA1Y01hT0xx?=
 =?utf-8?B?YVNXQzV1dGlIK2FlTk9ndWNiL3BxYkNPc3JkcndnV0duZTRseFlkNzhMUzlQ?=
 =?utf-8?B?OFp5M2dSdHBvWStXYlYzN3hha20wVFNzajEwSEFabUpjMlkrczJTNXhPTjhI?=
 =?utf-8?B?SS9CeUJQVmh2c2xNYzZZNWRaS0FHa05VSWdOWTZVWlRMN3MyT2dRNWV0bWpC?=
 =?utf-8?B?ZW1iakp6SkU2WllLUUo4RHpheUc1RHhBVlBzZk9zclVZSndtOWpXVllGdFFk?=
 =?utf-8?B?a3BPczJGOEJnWjFLK0tVY3Z1Qjc2K2Y4TWx2eCtJVk56NUl5NHAzZnUvaWFx?=
 =?utf-8?B?d3VXNmhjRWtSTjFpekE5WUV4ZHNKeDI3dXN4T3RERnR4UFU2VUk1UTAvd2sx?=
 =?utf-8?B?UlVSazdhTDR1SUZtV2Vzbjhzc1RiU3NNNTJrRzB6ZFJMYW9BY0VUVWw3WXNq?=
 =?utf-8?B?akxuR1pqclpZYzgyUUE4TVo1WCtWRkh2OEZuQVBpOEN5SXN3VFdYMmZQOU1a?=
 =?utf-8?B?VHE5cFhTWFVyMFVtR0tTRDFzRUZHYS9pYVBmRVNjcjkwcTVSalhBeTJmb2po?=
 =?utf-8?B?VnZLMmFXZTQ0TjlzRlBXVC9nSUE1K1JucE92cVZWQ2Vqc3JhL2ZZdmhBQXR5?=
 =?utf-8?B?WnB1WWxqUm1oU2lGRnduMFl0VkVtN25VdEJvR1NPUTRXKzZPVXY3dmhlVm9p?=
 =?utf-8?B?Vm9lR0w3azhFbm5HbjdSTXBTdG50VTFJUjl3WnFVSXFkTEdKNWJ6eEoyYzNa?=
 =?utf-8?B?c1NaMTZwdEY1aWZwcmRQandnTUlwNlRvNkMvWFBXRFkxSWhuVGhZcGFSNkdP?=
 =?utf-8?B?MklhU1JsKzdCUUZwZmp6RFVNdVhJK1dZYTVrbXNpSjRxaU5qTFZLaTgyRDYw?=
 =?utf-8?B?RGJvTEVRZEhBZm9ieHlLTndTN0txbEFLT29EV0NwWk9FVE5OR3lMYWs4cmN6?=
 =?utf-8?B?OEFRcWNGT0JnNGVWZGxqMlRRSHpvZTMrWDdxV0lMT2d4QVJkYUlnbVc3SlJl?=
 =?utf-8?B?bVFLSE1QTmF1WnZPZUpPYkMzbVowOU93Umg2ZlVZUUx4aHdQeDRwWTZSTFlh?=
 =?utf-8?B?eTkyOUMxYTB3c0MvbEp0Qnl3bnlqdXFSbENlYVJoWVRFbVdGQm54Nkttbksw?=
 =?utf-8?B?R1VwMzhUbTl3YWUxc3Z5eEJqYUVuZGJSS050N1VYeVdqcGh5RGEySkxmNlMz?=
 =?utf-8?B?ZjR3YUhyNlkxWHdzbVNuVkFBSUFjSDhFSFZFSjhWdTFmY053MStGL0g2WlhN?=
 =?utf-8?B?cjgrZkFjdm40YlFrNmdQT1FVOFZ1bmoxVjVsR3BwNk1hSHZLWkFBUWV1YU51?=
 =?utf-8?B?Tzc0SUNGYWZVMHVscjJISEdkZURoY1FaQmNpeC9YZzJaTmlaUm5iU1FjbTdU?=
 =?utf-8?B?N21ndnlYMUIyL01PeXBMZFA4d25kbDAyZ050TURoL0t6U0pkQURLaFVYOENZ?=
 =?utf-8?B?MDEyUWdncnFaSmNobjNnWFc4OFl5bytmUFdkY3JkRWRGVHNpbkFWL21pd25R?=
 =?utf-8?B?TnhkTmFjcU1Bd25NQzQzc25OVEh1TG45dU4vT21Kb0d4ZFBlclFoMFZ5TXRM?=
 =?utf-8?B?WExyV0NBWGpBSnhFbktIMGVKc0Z2TmFWTURoUlV4NCsxSTY5Ym9KbWZpeDhS?=
 =?utf-8?B?WDVTZUdRdW4wbkE0d1AveVJvUHo4bUpuZ1JpWm5WUnNoclJPRVF1WUJiUUFI?=
 =?utf-8?B?djRZTjgxc0VjenlSdCttdGhWbFFkVTA0NDNMd3dXTkFMc0djMVMyMEt4cndr?=
 =?utf-8?B?TXFPZUNSdm9uNEhBSUswa1VFeDdlYis3RUxsTytDTy90N0EvYmVLUStrSXBp?=
 =?utf-8?B?dTgyYjh1aXk1cDhlL09oeCtUY1FqSXp1RDVxeUhUOWkvTVlIU3NZUE56ZnNE?=
 =?utf-8?B?RXlXVFhxNlg0elQxb085WjJIS04zeGxaU1VsYVJrdVdjemVwNXAwQk8ya1hm?=
 =?utf-8?B?WGJzbE1VZU52M3hTcXpITXVEbFA2QWVNVjZaOGZ1T0owWEI4VkhCcE5DeitW?=
 =?utf-8?B?VVpvYW9HT2hOT1hYbEV5dGh2bmhMditSTUx0V2pmR2JYOTJ2WHB5bXlsVlBU?=
 =?utf-8?Q?vC+t9Kx2Rc+u3yxI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1e3207-b647-41d6-06d1-08de73d3c89a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:37:37.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZk9x9fPi2Q5gRmNpqiAkHlNwjwDolEenxs+KsEhkEcEI84/p59C0+HUOu7a65LJKZePaIKaV6fRlq1gcSkApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7652

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, we covered this via "head", but this slot is now used by 6.19.
The 6.18 kernel is LTS, thus we should add it properly in recipes and
CI, both for Xenomai 3 and 4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                                       | 20 +++++
 ci/lib/kernel/6_18.yml                        | 88 +++++++++++++++++++
 ci/xenomai_3_dovetail.yml                     |  5 +-
 ci/xenomai_3_next.yml                         |  1 +
 ci/xenomai_4_evl.yml                          |  3 +
 ci/xenomai_4_next.yml                         |  3 +-
 kas/opt/linux-6.18-head.yaml                  | 19 ++++
 kas/opt/linux-6.18.yaml                       | 18 ++++
 recipes-kernel/linux/linux-xenomai-3_6.18.bb  | 14 +++
 .../linux/linux-xenomai-3_latest.bb           |  5 +-
 recipes-kernel/linux/linux-xenomai-4_6.18.bb  | 14 +++
 .../linux/linux-xenomai-4_latest.bb           |  3 +-
 12 files changed, 189 insertions(+), 4 deletions(-)
 create mode 100644 ci/lib/kernel/6_18.yml
 create mode 100644 kas/opt/linux-6.18-head.yaml
 create mode 100644 kas/opt/linux-6.18.yaml
 create mode 100644 recipes-kernel/linux/linux-xenomai-3_6.18.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.18.bb

diff --git a/Kconfig b/Kconfig
index dec7458..93958b2 100644
--- a/Kconfig
+++ b/Kconfig
@@ -130,6 +130,14 @@ config KERNEL_HEAD
 	bool "Head of latest Dovetail branch"
 	depends on XENOMAI_HEAD
 
+config KERNEL_6_18_HEAD
+	bool "Head of 6.18 Dovetail branch"
+	depends on XENOMAI_HEAD
+
+config KERNEL_6_18
+	bool "Latest 6.18 Dovetail release"
+	depends on XENOMAI_HEAD
+
 config KERNEL_6_12_HEAD
 	bool "Head of 6.12 Dovetail branch"
 	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3
@@ -175,6 +183,8 @@ endchoice
 config KAS_INCLUDE_KERNEL
 	string
 	default "kas/opt/linux-head.yaml" if KERNEL_HEAD
+	default "kas/opt/linux-6.18-head.yaml" if KERNEL_6_18_HEAD
+	default "kas/opt/linux-6.18.yaml" if KERNEL_6_18
 	default "kas/opt/linux-6.12-head.yaml" if KERNEL_6_12_HEAD
 	default "kas/opt/linux-6.12.yaml" if KERNEL_6_12
 	default "kas/opt/linux-6.1-head.yaml" if KERNEL_6_1_HEAD
@@ -222,6 +232,14 @@ choice
 config EVL_KERNEL_HEAD
 	bool "Head of latest EVL branch"
 
+config EVL_KERNEL_6_18_HEAD
+	bool "Head of 6.18 EVL branch"
+	depends on !ARCH_RISCV64
+
+config EVL_KERNEL_6_18
+	bool "Latest 6.18 EVL release"
+	depends on !ARCH_RISCV64
+
 config EVL_KERNEL_6_12_HEAD
 	bool "Head of 6.12 EVL branch"
 	depends on !ARCH_RISCV64
@@ -243,6 +261,8 @@ endchoice
 config KAS_INCLUDE_EVL_KERNEL
 	string
 	default "kas/opt/linux-head.yaml" if EVL_KERNEL_HEAD
+	default "kas/opt/linux-6.18-head.yaml" if EVL_KERNEL_6_18_HEAD
+	default "kas/opt/linux-6.18.yaml" if EVL_KERNEL_6_18
 	default "kas/opt/linux-6.12-head.yaml" if EVL_KERNEL_6_12_HEAD
 	default "kas/opt/linux-6.12.yaml" if EVL_KERNEL_6_12
 	default "kas/opt/linux-6.1-head.yaml" if EVL_KERNEL_6_1_HEAD
diff --git a/ci/lib/kernel/6_18.yml b/ci/lib/kernel/6_18.yml
new file mode 100644
index 0000000..88e3915
--- /dev/null
+++ b/ci/lib/kernel/6_18.yml
@@ -0,0 +1,88 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.18:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:qemu-amd64:
+  needs: [ "build-6.18:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    KERNEL_VERSION: "6.18"
+
+build-6.18:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:qemu-armhf:
+  needs: [ "build-6.18:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    KERNEL_VERSION: "6.18"
+
+build-6.18:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:qemu-arm64:
+  needs: [ "build-6.18:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    KERNEL_VERSION: "6.18"
+
+build-6.18:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:rpi4:
+  needs: [ "build-6.18:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.18"
+
+build-6.18:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:beagle-bone-black:
+  needs: [ "build-6.18:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.18"
+
+build-6.18:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:x86-64-efi:
+  needs: [ "build-6.18:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.18"
diff --git a/ci/xenomai_3_dovetail.yml b/ci/xenomai_3_dovetail.yml
index 916d191..ffb903a 100644
--- a/ci/xenomai_3_dovetail.yml
+++ b/ci/xenomai_3_dovetail.yml
@@ -25,6 +25,9 @@ include:
   - local: '/ci/lib/kernel/6_12.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.12"'
+  - local: '/ci/lib/kernel/6_18.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.18"'
   - local: '/ci/lib/kernel/head.yml'
     rules:
       - if: '$KERNEL_VERSION == "head"'
@@ -35,4 +38,4 @@ include:
       - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
   - local: '/ci/lib/dovetail/xenomai_3_next.yml'
     rules:
-      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "head"'
+      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "6.18" || $KERNEL_VERSION == "head"'
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index b1771f6..74803ed 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -13,6 +13,7 @@ include:
   - local: '/ci/lib/gitlab-ci-base.yml'
   - local: '/ci/lib/kernel/6_1.yml'
   - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/kernel/6_18.yml'
   - local: '/ci/lib/kernel/head.yml'
   - local: '/ci/lib/compat/xenomai_3_next.yml'
 
diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
index 0404ca3..283a1fd 100644
--- a/ci/xenomai_4_evl.yml
+++ b/ci/xenomai_4_evl.yml
@@ -17,6 +17,9 @@ include:
   - local: '/ci/lib/kernel/6_12.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.12"'
+  - local: '/ci/lib/kernel/6_18.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.18"'
   - local: '/ci/lib/kernel/head.yml'
     rules:
       - if: '$KERNEL_VERSION == "head"'
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 5a248e5..ffb1ebb 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -13,6 +13,7 @@ include:
   - local: '/ci/lib/gitlab-ci-base.yml'
   - local: '/ci/lib/kernel/6_1.yml'
   - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/kernel/6_18.yml'
   - local: '/ci/lib/kernel/head.yml'
 
 variables:
diff --git a/kas/opt/linux-6.18-head.yaml b/kas/opt/linux-6.18-head.yaml
new file mode 100644
index 0000000..1372dda
--- /dev/null
+++ b/kas/opt/linux-6.18-head.yaml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
+    LATEST_GIT_BRANCH = "6.18"
diff --git a/kas/opt/linux-6.18.yaml b/kas/opt/linux-6.18.yaml
new file mode 100644
index 0000000..99d958c
--- /dev/null
+++ b/kas/opt/linux-6.18.yaml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  linux-xenomai-version: |
+    PREFERRED_VERSION_linux-xenomai-3 = "6.18%"
+    PREFERRED_VERSION_linux-xenomai-4 = "6.18%"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.18.bb b/recipes-kernel/linux/linux-xenomai-3_6.18.bb
new file mode 100644
index 0000000..e6d91ab
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-3_6.18.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
+
+SRCREV ?= "v6.18.7-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 0a68d11..ce497d6 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -41,6 +41,7 @@ GIT_BRANCH = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.18.y-dovetail-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
@@ -52,6 +53,7 @@ GIT_BRANCH:armhf = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.18.y-dovetail-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
@@ -63,6 +65,7 @@ GIT_BRANCH:arm64 = "${@ \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.18.y-dovetail-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.18.bb b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
new file mode 100644
index 0000000..3182404
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.18.bb
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai-4-evl.inc
+
+SRCREV ?= "v6.18.7-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 20fa03f..3be54fe 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024-2025
+# Copyright (c) Siemens AG, 2024-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -33,6 +33,7 @@ python () {
 GIT_BRANCH = "${@ \
     'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
+    else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 GIT_BRANCH:riscv64 = "wip/evl-riscv"
 
-- 
2.47.3
