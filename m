Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA013A86C
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343045; cv=fail; b=UMsl2yxlWxUj8zm+0hPZz6x7xXAIATN0FalSZKfUqinL1iGP/mglGDHfsiUsscqLWohhs7nzp3rfXtoMfqSxFWJl1JWOXi7G3O9s0xMOOChyjlHJuI0RO2/ygjNMeVrTlfmPMWVR24sgO/8wiYeKkvviY+37VM6Wlenk7SjInT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343045; c=relaxed/simple;
	bh=1TWs4e42KveJHwvDMSJ0xyZiBFXoKUJzfOeUEBLzijo=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=ALSCtSgxUwW15CzbE4bE0b68zWab54zXRRseYC/gWfkGDgT6t/6wecHUcIz7IZbDleaxaSVZOwNQauaHdV460LOR+viJUNuVrJEo20mJJS4CAdvPb2sDAHhVMXyzRSQ8Tz7CRQmH3piYEVA2zGuUulF/C9yG/I+UrYIRkRc2kec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Svk3X5/9; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Svk3X5/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2BLxB0/d1jhB+2UVfhD1eZ0LROTx4iknk30V0etL7KnLMoAlYq6CCmbPh8rTjB/CVgVFRObfSJIdKmP6QOqWssIFs/yWklrOV67A2Ck6wDD740urntEVQNIeXOp3Y2TcYK48/x4oI/7RnSKFTxiSFwTyiFnicpyLVIyG1PZjR0x6ZWtxAgfjQo2fVt/Q9VTY4f3/QkRqaLNlNJCkQKVJrIV9NhZoh/2SUoUI/lnTybIa/kDURwKvIoPoN5fz9o7B3NZc/QaEueb22eUZHjduKp62Isw+g9PxMCDBcEHuEq7/e+E025Im+MQJZh4q6v8M7Gkc4sLNz47XHIe94T1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH73U0nTvulHqU0bYRvXRn5TXSnKee8axpoFrhAPIAc=;
 b=DLiSCSR7BxUCE1EGroWaeJotaMklbDEgwudQxzARhyy4ttUt7HMpMWIcIqWqewggfj99D2MdDtrMrJLZ6uXBC1TX3FPDPOC5G4X04pEOYzoObIcB4gbeDJ9ivJaL56kUDZTxRsN6YEF8NnjkXgdF7MfHdOG20tP3hk/lgjKD8M8Fn43lKnbYbuKwd2ohMm8BrXk21wciCMDeZTMTTZwHBiQLUMAPi+3AjJEighpZaoQv26alsN5DqhABHDoptpGUmUFZW0SPMOItxzP7NmuSIjpB+deBSWAxb1p5Hbnj7RLTGyLV7lncZ9qx5TyAwnBqddgCkVMhe+QDYFASA/huuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH73U0nTvulHqU0bYRvXRn5TXSnKee8axpoFrhAPIAc=;
 b=Svk3X5/9alO56Kf+wNkpgyw2s9RBrbaN55/KYQ3Lild+M2vDFSgbhl4d80exmFEPQ4nPTyst/gWfQuaGRMNGInv6Z0E/TTEhcj4iIRJccVey6r3Ud3LS5kc1eLkwI92JDJzwrqQBVM6e/wFaBxXtJhHmnjBM0cts4gDThfWNVA8O4nEB/NQCm2qTzq9K0mpQod77zv9eF4w/GCM/qjnzti6XlnbmrfReM3tFI1+t5JfIDjhRsZeuLNqg3fdSBnhYJ5RTt0Tj5cppeATRYizlg6Lj4u5xJYQPn8e2Ha1msAKLS0cXH8OLM0IRoLL3CGxx7PsDu/j/Ve7P7JY8b3Mwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8717.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 16:10:39 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:10:38 +0000
Message-ID: <964ccf74-9252-42b3-bf9d-741f4814af08@siemens.com>
Date: Thu, 22 Aug 2024 18:10:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] analogy: Avoid warnings when
 CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is off
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:610:cd::28) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590e364-39da-4181-052a-08dcc2c4f694
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGdTUlZIaEd5VEozc0QrM2xPSkpaKzE1OUlvRXlWQ1RIWVpwQmp0KzVNUzBh?=
 =?utf-8?B?Y0NCOUJCVmRWNDJjK2dNaXBpakxVQkJMNVkvelJjQmV6YnFsd2RNTWQ5cXlV?=
 =?utf-8?B?eTlNVXZSak1lRDZZcDlOdGFjQWsvQ25aeVlHanZqYTBUUmsxZGw3V0RvZ2VW?=
 =?utf-8?B?Vjl5aitSaFZ0ZzRXbVJrRC9FNzgwMjdYbVFFNm01OFNEREgvTzBSSFkva1Fi?=
 =?utf-8?B?M04weVB6MGlRdjhPTjdGOExVQlFNQ2RPaXRjVDhhTXlIV2VDMUgwVDNMRUNK?=
 =?utf-8?B?S3NVYTE3VTZ1dCt1TVZQRGdmM2d3SGZFZ01GaFR3bk1JRmF2UGtwRGVDdnc0?=
 =?utf-8?B?R0VEL1cwR0hCekdOSHJrczJUU2JQMGFPMTBZOWlvOXlNR3ZyK2lKY0NUd2FU?=
 =?utf-8?B?bzljOEdCOWovZ1hLb3duYmliSkY2d3YxZDhpUmgrRFdTazk4Z2VTMmgwTm1L?=
 =?utf-8?B?dmlwd2hGRXduN2tjaEdTeE1jL2FzZVowWVpvZHRpS3N1QkxCYWNpaEllTllI?=
 =?utf-8?B?MXlRWE1OTFhLS3BsVFJEMEZhNlljYStkU2dpQ3RwbDFrK1lSTmhDQ1lOdE1p?=
 =?utf-8?B?enZwWEhwaGtCWEZuS0VwUWFuUTkzZXdHYlRWSGFuY1VqazhWdzdUa3hsWEFR?=
 =?utf-8?B?VVlEeTZxNWFxaTVCTk9qNnRzU2VIWHRQMFgvUFZEdUpDeEZWT0o0L0VJMURm?=
 =?utf-8?B?MnpXRm5pei9ma1NSSXVzbTRJelBDdDJPZ3FUQnN0N1RKS1pQWXJwUGZEb3Fy?=
 =?utf-8?B?dEFXWDVSWDhscmNyTVNVQlhiT3JMT0dnWXJVbWV0Y09qVzQzOERiRDl2MXo2?=
 =?utf-8?B?d2RPdmkxam9LaVN2ZU01SEhRdG85ZitiMG5hM0pnbzNuemxYOHgyaW4zS1dt?=
 =?utf-8?B?VnowN2FwQWhuditRR2EwWVNBRDhXS2Z4cWJjZmpRSXhESmNFMURtMVVLS0ZG?=
 =?utf-8?B?aUpnUFliaVdjc0VGYkw0U2VHdElmUS90eCsrRUcyU0Q5cDlpR1NMZTlOMVdF?=
 =?utf-8?B?WFlSMkFnTk0zNy9relR2UFFmeGFRQzZMYjJTY1I3ejA3bVhZandFM2FDZTZu?=
 =?utf-8?B?TFo1aTVHZVB2NG42RnBKRWVKcVVIejZ4Yi9QMHFMeVkwWFlNcEo2Rm5nRjh2?=
 =?utf-8?B?aWM4MEMzYS80MDRqQ2t2M0VLNGVkdjlzbFVhRjJRbW5XQjVOYXovbzdkQUM4?=
 =?utf-8?B?YStvZ2p5UFZ3THBqazhrQjRzWTg3cUhqK1AwREJmRDdCdXpJRGhoY1QzS2FO?=
 =?utf-8?B?aTZoSmxiVFRFakZDMFFSeGl2bll6cjl5ZzZDNVFIQXlDNnZJTGdLaE90SGF1?=
 =?utf-8?B?RzQ1c2o5Zi83dlBSZU1qSy9GZ20zOXk1cmFac3BGcUlqeVlhT0JhNDFuOW84?=
 =?utf-8?B?MEdmZmoxNEh3VkM3NXg0bmxCcUJuT256U2wwTXVjMWNyaHlvcEc3cmxMOERz?=
 =?utf-8?B?TWc1OFBCSXAwZG1SRE83bGVoSE5MQ2VmbGZoZ2JzdElPUDA5aktQSHpURlho?=
 =?utf-8?B?WkYzY2hjbnRGS1BBb21UMi9pcVlLTXdaRTRGa1NheXNmQjhtQkxra0NQTDZ4?=
 =?utf-8?B?YTZTdkd6d2JVTGNpZEREYURhYjBwQ0F4dDMyYkNKdCswSENWMVhQUTVwUXFB?=
 =?utf-8?B?MWpJRVFqV05NWlZNMnBFMlpEV2NLeTlNUDBIWGN5VExNNXdKWXhkSncrSWt4?=
 =?utf-8?B?MFA0WUFmMzJtSWhzSzc2QXZqam9UaHN5TWY3dHRIK0xncGRIYWQrWVQ5QjlQ?=
 =?utf-8?B?ZFlpYVM2UlVRMnRhdjk4OWh3cGpvSjBBQTFveHdEY0d1Umh2SzdseGZlMCtG?=
 =?utf-8?B?OGt5RlhPa3FYZ0c3bkpZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3dXK1J0WW43OXJIM3FqVlIzZVU2WnJKUHduT1U0aHQ5RmNyU3RTMVBlWlhF?=
 =?utf-8?B?M2wvTlliUnBxcko0REo1eEF6NGRHNUc4SVFOTXEySFhyL29vRjlvZ1FtQTZs?=
 =?utf-8?B?cnljdUpNTkRiL2JhMmZ6RGVTNEZJQkhmdm1RZm9ISXEwK3JONE9sNWF6TUcv?=
 =?utf-8?B?dVlCSFNFd0UwR3pNRy95blRQeXhEaFJhMXI5Z1I1ZDZPT1Z3STlYdWpEUmRS?=
 =?utf-8?B?S1JZVEZOVWpWY0UrT29ZU0ZnQkw5ZVVTTlVEZldpZVJOc0R6OGpRaFdCMnVq?=
 =?utf-8?B?dmdyMHU3amkvbFhwcUlHNDQ1Nk9sWllTZjBVZlhXbDBYeHF5QkNtVnFNa1dR?=
 =?utf-8?B?a3dwSS9CbFE1RUNaYTlpY09RU2RhTURzUUxjaVBEOWZhMC9ueUIzamNjcmhu?=
 =?utf-8?B?ajhsS3FWekorcFgxUGhZS0k5dkhpdmw0Y295dUxyNm9vMTZTODNnSWV3TzNK?=
 =?utf-8?B?RXV6SG5rUVlRdzVxc00vcklGQkltSU9kOGtTb2hwWFRPZ2xiTGFhUW9ieXZj?=
 =?utf-8?B?VG9BdXZMd1BGais5a2RTaEFRb3IyMW1rWERqb3lML0dibmE4U2E0QUZtZlRs?=
 =?utf-8?B?WkNDMkZkM3FwZ25KK1lnalBOeC80NUQ1ck9aTG9DSTNPZFU1aURrNUp0NTAv?=
 =?utf-8?B?ZW52OTlYWldYdVdDRkp6SXFoanlQV0pHWDlKczhTWVNXMVdLczhxSGxpK2Vk?=
 =?utf-8?B?S0FHbXBHZXdDc3BSYWM0Q0MrOHhNSkYwK01rK1RKTzUrWlFtVXZzK2RwNEVk?=
 =?utf-8?B?RWM0Q1plVFF2bkVCbjdZL0R5Y0VxOGt4WDUxUlQzWnFpWmVVc1EzZXVseVR0?=
 =?utf-8?B?bEZDZ25rSkVZRVQvajg2MmxTMHhYemxuT3cvSVg5c21NZk9pZE1xeFlIYzBH?=
 =?utf-8?B?TVJJWXQ1MVgxeW1uZHR2SHFnNUU4VWU4RkNXYXFGMFJlTVJndHh0YzFJU09B?=
 =?utf-8?B?bTJJeWxIWEpEb2grWjdaUW0yeDltMlhhZUtmTDZQNSt5WXUwdEc5QkJhSGpE?=
 =?utf-8?B?VXA5cUJXanhzalJXbE8wUTZTSTBFOXlXYTAyWXlyTytNS1FHUVdRSnFEYlpa?=
 =?utf-8?B?YnQwbzRKWEVQQU5aUXYraFc5dXBkOGZwbnd3M2hSNlc5NSt1MG8xcGY0UXNP?=
 =?utf-8?B?YWFnTElLWGkrSkN1aDVObllzNjBKMGdEOWx2ZkZXRnovd2REeVB1SHgvdlJp?=
 =?utf-8?B?QUlZcnV5K3Y2VllhQU9rUFNmR1ZrdWtHQ2hOQ3JhRi9EYm1DNkxjT1BPc3Q3?=
 =?utf-8?B?MHFLTDN5aDR6TkpBU0FBYXdzYkRYSjZzV1ZwS0toT29NL1R0Y1U1UDJkZXF2?=
 =?utf-8?B?T1NDWitOZThIcllBUWVlVEVtV2VRSkVVTkFFL21iYmJjclVlWjd4TXg3Vk1F?=
 =?utf-8?B?MWx3OU9lMkZ5bFpQODdRejlTUWVFY0gvd0JEeVZ0Z0lydW9GQ0YvUnlvY2E5?=
 =?utf-8?B?aVcxaUlBU0puTVM1bml3a0lkdXhySDFjUjRjeThZb1MwbVRrR2xGL29Fby9u?=
 =?utf-8?B?emxZLzV4RmdoME1QeTlQbGFpRGhBT2FqcEVKTGlZMjk5bTJMMjJZdnRzVEFp?=
 =?utf-8?B?NjRCdVoydFdab205VnAvQjZqdm5GS1BnVm9kajB4TzE3cTNoKyszcTdaNFlX?=
 =?utf-8?B?MTByL09YSFFHbXlxM3cyUnJIam4rWTFXdkRhUGVyZCt0OFV6Q011Sk1PTVRu?=
 =?utf-8?B?eklBakVMSXdBa2RHdXhoYmdKUHp0Vjl0amZ2MHhieUlGdXVCS1AwditIME5h?=
 =?utf-8?B?R3ZZOUhGTjlUbHVvUGhOcnhJVHdGcUw5UnByOElHQ1FWTEVSUmRYV0hrY0lL?=
 =?utf-8?B?d2ZyOE5mV0o0d2IzVjk3YnVYS1ZEb1Z3NkU1M2poL1l3WkZKNGgwdnZFTCtr?=
 =?utf-8?B?cU4vVXFzcVpObnRpbzRGdUVtTHBqc2ljUjlITjdyWjRCTmw0bit3Sy9nRGVT?=
 =?utf-8?B?RlZOeHcrVXJRNGJCeFhxZjZ5QjdOTXJQMHFpZHlvbUE3Y1lVLzJudXp5anh3?=
 =?utf-8?B?eDdDUVRHczdFdU9xblA3L3laR0theEk5WXpueVJaUUxoWkZSTzQ2QlVxemFt?=
 =?utf-8?B?bXkvL0dtblRTNWtwV0ViV1lQYzVYQ2p4WkFhYnZMTStLaXNhaTZiUFREcHV6?=
 =?utf-8?B?dnhmZ05IRm5DZmJvL1VSZmxRRjU4Y0FBV1QvcFRZSGU4bE5rdkhFR1crdmRa?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590e364-39da-4181-052a-08dcc2c4f694
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:10:38.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr8c7fo+jHoi0/n+LR50ZDhAwCMMT4A4vdrdfAslZEo2XBQm82OSg7N8kwIQAeOx2ZJAA4+1zH6JZE7w/FWR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8717

From: Jan Kiszka <jan.kiszka@siemens.com>

Provide an empty statement to avoid warnings like

drivers/xenomai/analogy/testing/fake.c:642:71: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
index 2adcb15b55..5980716e62 100644
--- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
+++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
@@ -65,7 +65,7 @@
 
 #else /* !CONFIG_XENO_DRIVERS_ANALOGY_DEBUG */
 
-#define __a4l_dbg(level, debug, fmt, args...)
+#define __a4l_dbg(level, debug, fmt, args...)	do {} while (0)
 
 #endif /* CONFIG_XENO_DRIVERS_ANALOGY_DEBUG */
 
-- 
2.43.0
