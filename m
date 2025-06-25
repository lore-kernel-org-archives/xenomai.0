Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012042.outbound.protection.outlook.com [52.101.71.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4D202F71
	for <xenomai@lists.linux.dev>; Wed, 25 Jun 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836898; cv=fail; b=X2b7OPdA9WB0fsZdWfTcrHs6NzAWHw/quMk5b+/4qPVrOhDpXyfAp826FApG5/im1IqefsLfZcb0ns5FYd2gaQfvK7rTpjqz5j0ojEEC/zgmHsQudkxThbLbHh8tKO38WTK5tJCRDr10cumzxlGLvLeOiei5llZCe54lfH45Cp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836898; c=relaxed/simple;
	bh=5ZYNmG4uibFmr/TJGgXYtLw1dIvye0wiY71yuEDzlc0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DvvRlfYzcm82dX9YQCOQRJd9HClth5eJf7QW0i3SKeagQA0DEk8mYuciwlI0uf3C6NKl5XNXBgz3uO7ZnSUhxaTeUAaKOkxSgXHyXE6HkJHIdDDht4YbFLnW0BADpPnhPBjTg7ebNq27cOBwMRLtR+symrliA8jKimy3q23dCik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R/nk7X4r; arc=fail smtp.client-ip=52.101.71.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R/nk7X4r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNIbu6HTDntGR7SfXSbuDsxyjknbxPWvMridsTHLT2vWzm1rvAO+Z+WQvoRi4v95Y5q5XMYdpsYTgk5C931DcGFZpirnxTPeO+Eqxe1+2FvOdlHKr8HdJTZJU+4vV07RDDu7cS2eqKoeyJyKZd1f7HwbSozXorUoZRRE6u/IpM/GoCYX2TV4FM1kgLEnmS0z9ArxBJ3emZObIZuTGQ4oH8zLuJxzuCZWPAGjBKwG8jzFudm9VTbmXkxrqGzZB5kfWjlWhf1lobFAEMkq6T3Gr+iBVca6wR1D3Jqa22cOYzXRViRlw701WGB0hAeo5k8PGDXrUJ4iA+POp86ff72gSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wyRTrAF/CF4kx5UkSVS926QQRMErWzNKNPCBwi1uV4=;
 b=xeT9P4CLUvvxfDqCJjfjaoZhbK/WmsSxyLgu3KMszsJKmIvkXgR5vvnlxAGT3Z09baf/5C9SHdU0osOFZ9aejDzQiOjM33bdfTKvZfZ0oOX9hK8Rm7yDUGgRRvn4xeggK6jFLfCn8s5qRsrOxCGO4l0Ym5dgu06miHiyjZ3AneSmVh0DIkccCJ/ARutbxqbCGTAnaPnELMketxcSpH/OLaLognws1pncYdrdH0oRSR/pp2gx/CQT+GdkbD3ERNvUmKHQppMtWVmG2TZEsPpfmfFM1XOhHs0THmBZ1wjNQyNRoMpmtbSWmrjbNWlNvuZqFnAUPqWlvVxnjTWVAaakhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wyRTrAF/CF4kx5UkSVS926QQRMErWzNKNPCBwi1uV4=;
 b=R/nk7X4r1EQWbZ/4HVmr/H9clYszD9Igle+YOXLrpRKdwgLLKVp9HF4LRPi9YVNdkGBgAz4at0cTAM6dSazPi1090EvGW8qyBaeEAMONd5oQKrlkDkXDChlegHTxj2Eog5vqJGOlE7nAWDnJVfmj4XCYyMhL/lzkrCm8mtnx72o4FHzety0qKp23zEe8OX/zBI4HcYsINIYZ43l9iLX/UaOVijSj+j6EqDOLQgRd9QDCUPNtZqZ02Cf/U8IrPEhTExRu0fXuVu3NUM9ZbsuI1Wst9iFTwC33lPm+s7HOEjb+UNnzY1w7BpeX5xyLBV9/qS9MrQ4NnM+BdlF2sMxE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 07:34:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:34:52 +0000
Message-ID: <d186c945-ab95-496a-8050-072c6ffc4f77@siemens.com>
Date: Wed, 25 Jun 2025 09:34:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [NEW URL] Xenomai community call on Wednesday, June 25, 2025, UTC
 7:30 AM
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <b734099b-3e87-475b-b51b-21b914b0ddbe@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b734099b-3e87-475b-b51b-21b914b0ddbe@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a59208-5201-4373-9bed-08ddb3bac5a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXMxektkdS8vQlM0WlJnc2lDMVJEUk9GNzloSE9ZMElkM1dmRzdyK1E4WDdF?=
 =?utf-8?B?OUpHYkZKYis3NDlQRDRJOXVXM1BpQ2xEYWZYQW0xMk56RENZK3ArejI0ZUs5?=
 =?utf-8?B?ZWtBNCt3NEpOYzdUMG52OWtjVk5tVGpNT2E1Zk9vSmllMkRNNHNEMHR4WEZX?=
 =?utf-8?B?TWFGQ1pxTnI1YTJMWnMreGlHUkRkUUpzdWM3cmFhbE40bGlXK3R4dHFmZkJ6?=
 =?utf-8?B?K1NRQXFJV3gzdWZ4dGYwMTBWTWhsMlkvb1hIMm1waGY2Q3dTZ0t0ZTg2dE9v?=
 =?utf-8?B?RGFEWGdmK29NVVdvaVFpRTRzc2ZobEc4U2NCV2JUL1Ntek1sVWZrVnpKSTJX?=
 =?utf-8?B?bjFYZ3JMcG1JVDFsZVZESWk5QkpoM0l4cGE0WWF1eEVwNGRqOEgvNFF4aU41?=
 =?utf-8?B?NjU5MEJ2S01RS3VPWitaS0tTMkd6Yy9POHFmS3FNcVpwZ1Zyd1laUUF0S2Jj?=
 =?utf-8?B?eUdCV2M3WWlqc2J3SElHVm5oOGNZRnpiUUR1dnMrd01SQkRSYXpwWWN6T3M3?=
 =?utf-8?B?Y3dhZHl5TldrTjBVZE1FVHRtcjE1clIrK2l5N1RwbTZqMk1Ydk5zNUZ2T1FP?=
 =?utf-8?B?cHRQL2NyOXlRS21LaGhXazJVRi9acTljT0ZyejAySkkyRnhSVHJ1QUlkNG5M?=
 =?utf-8?B?dGh6M3BGNDVsYjFSejVpVlJNa092Z2hFWjhLWE5USkRxYy9JVFlnaVIyU2th?=
 =?utf-8?B?OG9PSHFNNlU4STY3WjY4ZDZUcVcwMG9hYmUvaS9yWWZnaEZPVzRqZ29PTTdV?=
 =?utf-8?B?cHZRYjFGMGRFWlEwcENzTGIwa29CRmdVT3dZR3Rra2xjL0l3RGhaZENhQnlZ?=
 =?utf-8?B?T2lwNWJBZ00rTUpXS2IvNUNJQmFWWjBJYmViYlh6anR0dDFkTnVsWDRxZzlS?=
 =?utf-8?B?WHNmdHVzWE9jb0ROUkxoWDlNZERlTTJadmRHQmdsTUtHdE1rbW5PWjJmWmZj?=
 =?utf-8?B?a3dDbklOcUJaQjY1cTFMSjRvZFBydlBlRFBvaDBoWmJBTWxNOGYrWndqb01v?=
 =?utf-8?B?SmZqb3pRK3l4ZENWSlJsOER5NDVUNURLcEgxMjNxRTdTTXFXNkxCdWh4cUlH?=
 =?utf-8?B?WlRKc0JKV2NIR1lsWThkS1pUUUpyLzF1dXh6T0lSYXJaSTVUejJZM1dta1ZD?=
 =?utf-8?B?RmdmeUJEdEp5T0w4OENNVDgyc0ZLL1RiU2wxMXk0S1oxVDY2c2pWQXFvNi9H?=
 =?utf-8?B?RHVrbmpoOU5yempyR0tBWnhQUWFmaERVUFpQVkE2WEhYamIzMCs3M2U3eGRK?=
 =?utf-8?B?c2VIVkozOG14R21YYmdoRGhhRE9HUStQbmpmeXQ5NXFtWFNSeGsrK1NndXdW?=
 =?utf-8?B?UnNiZ1pWQ3VtaEhMeTAveno2bDZobDE3a0VZMzlKM1NWNUJScG9rVExTV2xW?=
 =?utf-8?B?ZCtPRjZ1bUlSbGY2K0ZiRHV4MnViN0JDWmRjUjRYb1Q4LzdlVU85WGNFRzk0?=
 =?utf-8?B?SzZoQS9LR1I1NmlkclRNL0F4VVJVMWsvOVJUdFZ2dSs0Ukl2YjNkRUhaT2gz?=
 =?utf-8?B?MWMxWTBsR2gyYlFna3VqdGx1RTRHNUVlbEp6dlBhVUhVcmlnK3plTjY0Zndv?=
 =?utf-8?B?QW45V3hlY3JvUktMMGhHR1U1WDJBR3pJMnVUM1hYK3N6WWg0TDZPdVZGVjQv?=
 =?utf-8?B?M0Y5bG14TEpqbm9oNEhkWHVPK2prU2ZTZUFPN0ZsVjYrK2NuUCtpQmZRcERz?=
 =?utf-8?B?akRCVlR1dkErTnNmN3ZUTDV5bXlzNm9yWTNFT01ZcCtLODJBNUFHQnVOSlov?=
 =?utf-8?B?ZVlJbWtjZHVhQ0JJYjMwWmdpc1QvRjE4WGhnU1ZXZ3NYam1mdi9YbWpKOU13?=
 =?utf-8?B?L0d1NUNmWEV2MkF1THllUmRLUXMxSTJRUGZ5L0Ryb1kvZE5pOGMyaU5UZXlR?=
 =?utf-8?B?ODNjMzc3eUZSMTdLUkRkSmJScVlhQUFwdnk5eThVWk4xVHVYOHMzeFNDeTFN?=
 =?utf-8?Q?OA4y4TFWLB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTRJcElYU2hydDZXSjhOVmRnU3FuS0xlSmpkTzI2RHFjenlDOWRjWEtYRzZm?=
 =?utf-8?B?NXNqSElWOTlTd2xaejBka2dGbi9tUW5ZdkRiRnlHVXkrR0oyVHZON1RaOVlI?=
 =?utf-8?B?R21VS05ZUjRnUTNUdG9tQnROT3ppS3ZIVmRrTkhWc2IwdWJ6RWM3bWM1RUph?=
 =?utf-8?B?aGNhemw5cWV0anVMNGhYUEFLWW8yK3RqQnB3MU02ZFhsTXRmT3pPenFGaTdX?=
 =?utf-8?B?NlZFaW1LY2NxejFXekxVY05zZ0JCaC9VUzRMQVNaSW1RVno1UnIydzI1SFIv?=
 =?utf-8?B?dk4yZ2x5M0U5L3pUV3JvakF2OXVGRVpsa3JrSDZlSXcyeFZJd29Jd1lvSS8w?=
 =?utf-8?B?UERQY3R5eXB3SXBLUXRyNEFUaFlrc2RwaEdxOUQwQTFPazlNaTJFVGNMVDQz?=
 =?utf-8?B?bW40ZU92QytRUFNDaFY3YXFZZm5VcWtkVDZBUlZoQ0ZiV0ViZU82blZKYitk?=
 =?utf-8?B?UHlIZU9OeGFCcGk4bmVHS0J2VHBHUUdRTXM4UjllMU13N0lLbjBxdll0TDlK?=
 =?utf-8?B?ZGwwZVdrRk5CZlovSWlwVFV4TTZMbXNFSzZ5ZnBZbVdBdWZ4QnVPRVVDT0Ru?=
 =?utf-8?B?NmNQdlZpQzhnOXdMenhwWFAxc1hYM1pVSGJwSjFMUGF0SHpxTngya25nMGlu?=
 =?utf-8?B?Mi8xQ3RlQXVKMERsUUptRUluOFBzS0dMOE5za05sblNYMXBSaWdOTFI0dFVN?=
 =?utf-8?B?RitpOEgyM0pGeWdvTkJMTVk2ZjhOeFlNYTRLYnZGSDZOcldOWWpYeG9wakVq?=
 =?utf-8?B?R1lmdWJPOStsVERsYXN1eUhNNEE5Q2NOaFN3aDd2RUI3TjF2RTdQYks5NWEv?=
 =?utf-8?B?OWpCOGFHY0oraEswRllDT3krVVRZMXowRnREbW9RU1pLSDhHRVVYWTRxK3ls?=
 =?utf-8?B?MHE4SjA3OENpV0VHY013ZDJxQmFUazFpV0oxTlJlRGdieXZSS0YvbUFXK0hK?=
 =?utf-8?B?dE02eGNwUE1Qd010R0ErZmp0OEZ6WUxkK1JCVzREY2Z0cStHYzBIUWo3S0R1?=
 =?utf-8?B?TTNqM0E5UU9wMHUrSmo1NU1VUi9ZMGxEVVhmbFBMTG5iQUxYSlFldVYvZ2tY?=
 =?utf-8?B?RnZWTWQ0akRSc2syM2w4UlJZNU5qMFJYYzY3RXdsTEtMdGFSUUhtalpkNDNU?=
 =?utf-8?B?a2wrVGJzV0JwZUZlZ2FvbDNHNDJhTHdJQU82NXdyb1lBMGxRRENQdW16Y1Bw?=
 =?utf-8?B?ckR4d2ZDSkREU1B0dVhVcDFIM2xZeThiV0N5SmZVQTRNcSs5Q21NNnlTZjRj?=
 =?utf-8?B?M3c0ZWVYaGt5eVdXYndPZWYwSkp3cTErNWw2WTkzanlKZzRIVGcvcTFOditp?=
 =?utf-8?B?c1FDK1hlMzBsc3lVa1Z2bjZ2elV4QVBLem9aTWtlcFdqcFhQVTh3S0c2VGdr?=
 =?utf-8?B?bXZUcEdTekJPM3ByTmducUZDMys5Z3YrQlFyR1UvQkxSWHVqR2YrZGpjYi91?=
 =?utf-8?B?YWFPdzkwVWM0d1FGdWFyQkgvTDQxcWtoYVVLUDFYejRpSklmelVGREcyeThn?=
 =?utf-8?B?aDY2UG9qcDN2WDFxU0todUJGdXA4NWZvK2RJSFRtOUhXamQ2ZTVtRVU0Q2h3?=
 =?utf-8?B?eGNTMmdLcE5wVUVkd3pzaEVHUSsvWmVkYU1Cb1Y5eE81TEExblV3Z0hPcmk4?=
 =?utf-8?B?MXVNeWd3Ti9LNExDRXVRU1c4dTNBMGtRQ3BCTk9uUXZWRUVUUlVSRVN3VUlx?=
 =?utf-8?B?RlVDZDhvWmh4WnJTb2k1VDZISmlQck9rYWsrOCt0dktIclAvY2ZsTG14NTRX?=
 =?utf-8?B?Z285VVdwVjVTR1hjWXkwbHZNSFJLWlB5TE0wRFZxUHlncVA4MVdIUFhyUUFp?=
 =?utf-8?B?M3ozNnN4VXgwaWNIMGd6MWplYUVId2VPWWN5MG9nM25LUG9mUlRVUFp4WkVa?=
 =?utf-8?B?QnQ0R1BCVnZxZjBSZHRSNWR3OGI5S3cvcHd2TTVwcnpGR2E0YjZWTVJ1a0Jt?=
 =?utf-8?B?b2dkNVUxYTcySzRTRkw5YWVKcExrMFoxWW15TnNiQmt2S2oxOEk1aFIxQndY?=
 =?utf-8?B?U3NuVmRGY2VyU2ZWa044bHBVNEE5OHlVc2g5d2lub1ZkNzlUa1A0cU5QVHFK?=
 =?utf-8?B?MklwditIZG0rMWhWdmZ4bVQ1TzUrcE5TMVE4ejBuakxUSU0weVJrejBJaFEz?=
 =?utf-8?Q?szXQpnNrdRxE0IIB9Z8HlXIQl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a59208-5201-4373-9bed-08ddb3bac5a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:34:52.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erkyyHBm98FrvSwaEbVjfJPd32FYWX/w0pS608PFITc6J/ZwZl/o7/p6ZJiGm2EBFt6icN1fouOq3eHFV1IP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6398

On 24.06.25 11:46, Jan Kiszka wrote:
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions (you may have to wait for 
> the organizer to let you in).
> 
> Time:
> Wednesday, June 25, 2025, UTC 7:30 AM
> Paris, France CEST 9:30 AM
> China CST 3:30 PM
> 
> Join Teams Meeting:
> https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d
> 
> Please note that Hongzhan will unfortunately no longer be able to host 
> the Zoom call. We will therefore try via Teams tomorrow but can discuss 
> alternatives as needed.
> 

Reminder: We are no longer on Zoom, see above. If you have problems with
Teams, please let us know.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
