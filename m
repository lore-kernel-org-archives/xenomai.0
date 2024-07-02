Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DDBA3F
	for <xenomai@lists.linux.dev>; Tue,  2 Jul 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937009; cv=fail; b=dd39Dnrgn7pIznifUCAgONI27oslCzjZ/ou8po179xWr8yLWXfYfRFVd/Y3N+GClH2CQMHLGk92p6YcZd0/OxuXYCLYApW/c6Os0FDWqKvMr/cmhNTA04ugWUNW9QkpVe5YCv8X8kA0ql4ugtG9e+cm8vGEPfHGya8ZVs4HC184=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937009; c=relaxed/simple;
	bh=uOW8K7Ho1gKP7/rBbCMVhYzDP0+rBBRqhTq68U92ebc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bfKYPrRxaxoIov45T/rZ55M7hRpYS1mgH/nlevn96IbhawK9iq4KYnUA++H3+Fuo6Tf3Hs5FfGSBDJsm3rIxwhosZya89ws6arQ5Ivm18Gzvw6+BFcfj52uEZKfdubUUH9TMxmMkm6rT9gcU1/+O26r4DiN0gHQh3nU8+5H4mGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tzzo9zWu; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tzzo9zWu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2OvSBOV+A5TvOzG2AhjZGHHnZSfAJWZ7f9jTwtwM9cogpAHqTppDYgBTylTxgTbKpWqqlfEcLH8A2xuldErLPjCCy/ULj4tsEoZ/oqF2HIpVy9Nl1yJDo7EnKYeVWIUYE1s/LDEUbybmgrgOs76IkNcCfNCOynR3ki30SwIjVDqA/otSSp9sCZa2hXuZpTOpu6+sy6cGUnPFmlUgOMVxRLyOWxLdTaCgn2hmQE4JFVHRGtwsOAfh21ss9bBKrHxTdGkPqfHnMSIOTC+I8gMg9DzrhBmsASCLDx0oSLDQLUGZxGQoFSrtqDMw2DfI7VsTd3Z365wsc0gsNOzIU4cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m3YFsVRudBHQKZ4Tv22eeukEobYw3a1MRDBhzWgjCo=;
 b=mdCxRr/5F33sGqPz5iORJ3ZiGlIOzpPbATGoi/yu92y7uvVITBOgK0ark/mP9VVeZFsIuErUfIxOynsCOxO3F2h/eMcaT4qhIjlxuU1b1Cp9fW9n1iB0P1DxZ8FMOV5FtZJ6JoXIxrGvcnRvIX9gFoS8tJN869ZyQc/BEnijRVYGotN7Z0URicSqsDrvojPajRMcTGEjdxxuJg17c9RKOYrjLdNg+ggKuh1tJPfwEvJ63TloKMcAYOohl2GNej09Cnf4SnLHpYVqrljcNexDwOfvnz9NHuDXAMnLrOYoksBidb/7EvmqCVtpfj3iFuk0KxrkQbs7ICvVCMoPGRdHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m3YFsVRudBHQKZ4Tv22eeukEobYw3a1MRDBhzWgjCo=;
 b=tzzo9zWudligAHoQTJwic42LSNgW1C11ci0gloA1pAqQXW///1IV9PKcfO3UICmW8op8Z+zuaxjG1nnf6FqCwEglhjT7DLknS3dMOB2PC/twheLeQRKgkFePb2C0MsXbo9eMFxSb0IwSBSV7CcowlooRQTngsM2d/O+Ybagxhq/+Bd7qSDoKtUhug/k4O4cuV7+PlFPN+a1Cba3nxt11zgSMK9It+pHC0yBW+IFL6Psx7DO77bFmowUilxd1m77svggWXon08z/O9kces8xblmcuhPoslvlI0rHaHxdKKLeIrGVy0EsKmhRB5qHR47H310WEXo+mj7lGnJA2i9TCTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3515.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 16:16:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 16:16:42 +0000
Message-ID: <a4bc2481-9a1b-485d-b925-c84ecb3b4425@siemens.com>
Date: Tue, 2 Jul 2024 18:16:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread safety of cobalt syslog/syslogv call
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@lists.linux.dev
References: <10fa-66842700-9-4b3ab100@82480538>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10fa-66842700-9-4b3ab100@82480538>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3515:EE_
X-MS-Office365-Filtering-Correlation-Id: 799a2bab-3924-4213-a370-08dc9ab25c2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG1aRTVmWHFjVENQaUFLRitxcTlDTHE5bVZQb3dYZGNwSkJ0WlQ5cU5DRUN3?=
 =?utf-8?B?Zno2U2gyV1ZyNUdTOGZ1QUFTR09aMVhQMjZobFRZVUV1aGZGYnltUGRONU5H?=
 =?utf-8?B?a21kNVp6ZXVuV05iZmhBOGlDYVZRd2U2YkRsWG50M3pURk54dEQ5d1UyVGJ1?=
 =?utf-8?B?NWYzU2prSzd4SE10NGZVUU9WZFpvaFA0QjB0VnArVlMrbUFOOG8xL2lic2Vq?=
 =?utf-8?B?UmYySC9OeXBSOXRFUm9rT2doeXQ2UU5YTlA2Z3lhV3NJcGJ2a2lia0NtVzhX?=
 =?utf-8?B?azU5OUFRY0p3TjNackdXdU0wRnNFVHp4UzJZV0JXK1Btck9rcjNDOG83K1h2?=
 =?utf-8?B?RXhtWWtRYzRBMlVTV1Z0bHhjMzUzN0JEbVBDeUpQREhXSXZGRUNSSGJUZnQ3?=
 =?utf-8?B?ZU9zTlBHdUlUU3d1cmtsWUhyT1huMDZhaVNWZlFSK3E4SUF5bk9BVmdhV1Vs?=
 =?utf-8?B?UGlWTXVLYnZBbGdkNHlLVTVXMTdsZitjTDE5SGpnblk3UHhnYm5YMVhMWHZV?=
 =?utf-8?B?dmhXb0hhQ2hTaVBWNkp4VFpCdkZzemdhOEdYQkpsZ2J0NUFpN3JhU1FCcDAr?=
 =?utf-8?B?elQ1ZmFWVWRyTkREcytmZXBJWXVIUVJVR0V1Um1VUWVaOU11VUVjaytBd0dz?=
 =?utf-8?B?ZG1zeUcxOVBjV2ZRVGU0WVRicXIwRWJyV0h2TWc1WGZYVkJnR2FFNDNWdjg5?=
 =?utf-8?B?Q3d1SDVhTUV3dmNPME1uRFBoUlM0d1ZBdmtRQWc2TU55QWdsNGF2SGExdEpt?=
 =?utf-8?B?d1E1V2luVG54SHEwUkQ3T0ZvR2NMTkcxUnVpVUVmbHZJR3gzeFlzWEVhYXNQ?=
 =?utf-8?B?VzYzNFZNYzQ0MWx2WVRSdnJwMjlPbmYwMGo2Sm9kUEJqYnJqUWhYS3F6VWox?=
 =?utf-8?B?K2U5Mkc4VEdvWlpxQWhhNHUyMHNqTHNvK1pwZU1JUjRiM3pPVXZ6VXZRM0F5?=
 =?utf-8?B?eGVXem5nR25IYkYzV1JHUWRpazRDUlRDWG9pZWhPYkVDU1BHR1p1ZCt5b3Bh?=
 =?utf-8?B?aUtabm1oaWNWbUJkaVhuZGhvd2J1OU5QaEx2bi9qeHpCRnlNcndmSm9pblpZ?=
 =?utf-8?B?RUQyNUN5YW5jbmk4bEtMRkFpaEw3RUhod2ZmRDlmYTBTaVRRZ3lhRm8waFdV?=
 =?utf-8?B?QTIwdmY4QXl6cWRrYVRWZ0I4WWRoOUU1WjNDam8rcTFPMkxTNzR6cGo1b3d0?=
 =?utf-8?B?Y2pUWHB2UVZpc0tlR0Y0SnFjN0NRcjF1ZTBqNjhCd1NGMFBocStNMm5zb3c0?=
 =?utf-8?B?WDNyb0Rvc2o2SXRIa0Iza2RINEhYRWFZazVPWEVYUDkvTEE1Y0N3RUFaK01W?=
 =?utf-8?B?TFBRM3RKdnlWUlh4N0MvdGZxMG9GNC9TM2V0em5IUTZOY0dtQ2wrdXEvTEFX?=
 =?utf-8?B?Uk5ORWtleXVTQ29DTWFHaDFmeVluN3RCeEhsRjdGc0RyZjdGeVkwT0JBL2FR?=
 =?utf-8?B?RW9TRVpLZ3FjdkxnRFNCZTVRckszV0NLSlQwUXMwQUg4Y013VmRLeEhSUXAr?=
 =?utf-8?B?Tlhqd250VW8wS2ZmWHBTZXQrei9pTXJuN3MvN2pYQklnR1A1QUpwUkZuVU9V?=
 =?utf-8?B?YmVNdUpmbG15SVBWQzJyRHhrcHRiM0tYVDF1WG1rM2ZTbEFXRWRNTjZzdjNQ?=
 =?utf-8?B?aTBPcXVHM0l3QlREWUdkekxodjNuaEIwMXdvK21qNHdaTUZEQ2ZUY3lPZ1Vn?=
 =?utf-8?B?ek1TR1JrS1BjUUcwYS9IYzhJUUZ1ZHVEVlFycFpRSnNRRTJvbXNjZTlvQXJt?=
 =?utf-8?B?SW8vYWY3TlJxekJoNEZPY2VzL29ZcGZvQnB0YkY1S0dTaXBBRjUrekc5Rk4r?=
 =?utf-8?B?L3EwZ2V1bDIzaGh6YnZxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEt0c0NiVy9YM2t6UGpCNGFicVA5d3BxQVpyY1A3TjNFOWFkakNkUFZVaUVH?=
 =?utf-8?B?OWtGdjgyaDc3YUVLM3NyUnBheWtiSFpUODNieGozMTZhNjNBUlh4TUpJRFFj?=
 =?utf-8?B?ZytwbVlFSjRoZGY5RWJIR0kwWnFVL3lVV3FTQmQvVkh0L2ZvMWF3dE0vN3FB?=
 =?utf-8?B?c2ZXbmRQVk16eThZa2dhL28xY3JYaHh2eVpsSHBScTd3N3hhL2ZlRnBxL1RR?=
 =?utf-8?B?QzYwUmpTT1VvcjhSZ2VudWQwOUhGSkRob0o2cDloZEsyMHdrNFNVWEVZMUps?=
 =?utf-8?B?WlNNOGF4RVFUV0l0ZkR6eGVQa1BvR3NaYVlzVDBuaHI1ZFFvZWFsOHlacExk?=
 =?utf-8?B?WXhScDYySG1GRXp4cFRhNG1NTFpqaUI3Z3BHQnBjbEYwekl3S3A0NFNrSTJH?=
 =?utf-8?B?cmhUbXZ5WmtNWTBBTXhXODRsdVU1WUxvY3E5UmRacUNDdFEyTm5YVzlQak94?=
 =?utf-8?B?bk0zY1pWUFowNHpHOXVLVHNBSTVoREh4R0JWeHdlNGtycTQrMU1ZWU1RZURY?=
 =?utf-8?B?WjBIb0RRZ0t1MkF2c1kwY3U5c1RPajJieGtHMGNCNXJPeWM3MVlSUkUyMERL?=
 =?utf-8?B?TGdHRFA4ZWcrYS9kV05tOVRZS0IvVExjTEVMMjF1WnNhMlQ3amllZDhnakJX?=
 =?utf-8?B?SCtsakEzTytWYVAvcGxnWkVrZWhGNEIwUlRnMjNaMDM4STVBdnY4bmhRQ2Rl?=
 =?utf-8?B?L3NnMjVpUVhvZEpnWlRRRlE1YUI5Uytka3lJbytIZXFVdkNWUGJQaGRBU1hB?=
 =?utf-8?B?b0FsWjdSblFhSko1a1p4RythL080NVZuSGZyZEJpSFpUSHV6dGhUSWJsa0tz?=
 =?utf-8?B?SnBTTTBsUzluU3BwOFJUWitiS2JzUUR1TGJwUU81UTVkTUZKeFRxUWxxM3Zx?=
 =?utf-8?B?VUE1a3Q2U0pVOS82RndWQ0E2RFdYQzVQb3JadTkzS0hkcTJkK3Zhakt6K3cy?=
 =?utf-8?B?Wit3cUxNVVZOZWk1QzducTdhQXFDRkM3ajcwczlRWEFpdWxkL09zcDBCajht?=
 =?utf-8?B?Y05GUWlRU2FhMDZ5SU5ybDNERUEyMkQzMm9PSDBKRDRWbFdzcFdtQ2pEMGdv?=
 =?utf-8?B?MWFxeUY2cEY3cmp4aUtMMjUzWVMrdE9NQ3VnWnJsYUFRaVh1NTlxRDBKRXJv?=
 =?utf-8?B?Ulc5Sm5iSFU2YnM3cDlHYm84bUwxTnhRb3hGeStlVjBBYzAzRzZaSms3Sk1u?=
 =?utf-8?B?Zk9SR1ZOUlhybmd3NGxoVGo2YkpodFdROXQ2UDRDVmpab3NLSWNVZ3V5Vnpx?=
 =?utf-8?B?K3ZlNnVYeXZxd0x6NVBLUFYzVWZvaGUvVUNiWlFodjNxK3g4c1ZRT09ZSDN1?=
 =?utf-8?B?MDFpNUREVGxZM2VzOVJQYVZFSlVnTEd5Zml5Y0VVK1licFg2VzBmcXZmRUYz?=
 =?utf-8?B?MEVHUUNRUW5pMkJUZ3dUSnBVUmVjQlptK0pnUjc2RG1Qb2R3ZU9UNW9sUEhw?=
 =?utf-8?B?TjMxQnhLUTlwai9MZUtKOThyWnJnYTdsRlEzNit6UlIzYmkvT1BaWElrOFIx?=
 =?utf-8?B?UVFTTGRabHZZRDcxZmxoS0hnbk91cXJhYkRmc2pIZlJUV2FiUTV3MkVlY3R5?=
 =?utf-8?B?dmNXT0JTSzRoLy9PVGVRUHlGWG9aL2lCZ3BqL2F0d1RoS1NCNHdZVmxQbTl3?=
 =?utf-8?B?c1puRHBybzIvMmxFV2M2S3hycEtSZVFGeUR2ckNCNUJJcEFianY4R1p6R0Vj?=
 =?utf-8?B?ZHBvVXp5SkFhTnRXRDF5aHNBdWtsK3IyaGZVMlg2S1JlVXV1aTlvK28wbnJU?=
 =?utf-8?B?a1NRZnRhb2g1MTdqdE9VZW12R3Y1NTdOeW5wL3hDMGVieWZSV3V6TzgzRjRm?=
 =?utf-8?B?UGo5dUpmaTJRYnZSTEpzMWcwMXYzNHRHanR6YVBYZmVTVjUvZmt5eitLMUU2?=
 =?utf-8?B?RjVwNHFJQVNCYVZlOEJxSHhVSHh4eHBnWmR3U1kvZk42bFBwdk1pM3h5SlZ3?=
 =?utf-8?B?c2hMN1YxRHdQVUloaFdXRklTU2g4TWdpdzBWTEdsL0NxVHlKQkhzSEdWUlVH?=
 =?utf-8?B?VlNnTFlGdzBMM0Z4ZXdXT3RpT0ltb01RQmpmaXBSamNlL3N5eC9wM2xXS1dT?=
 =?utf-8?B?NFEwSkNlVk9GcExtdm5yRklLaUN1THJaNlVCNkhrTFJMLzJHSmxqTHpLMWw1?=
 =?utf-8?B?dVdQdUJHS0tBbkcxSTgvQVd5S3dldG1uVDMyTXBKM0wrNHFpWXpEdGhjVnlU?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a2bab-3924-4213-a370-08dc9ab25c2b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 16:16:42.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glUTQipvpsBzHVt1L6vrWUcZq8FjddH9ozsi1mN0WOn3kAZueIHwlPceI/MZwP0dsCDcedoXzTPToqN3JjMA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3515

On 02.07.24 18:13, François Legal wrote:
> Le Mardi, Juillet 02, 2024 14:50 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 01.07.24 09:39, François Legal wrote:
>>> Le Lundi, Juillet 01, 2024 09:24 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 01.07.24 08:47, François Legal wrote:
>>>>> Hello,
>>>>>
>>>>> I was wondering whether or not the syslog/vsyslog calls in cobalt runtime libs are thread safe. I observer strange behaviour in my logs under heavy log load.
>>>>>
>>>>
>>>> Can you be more precise in what you do? And which parts of
>>>> lib/cobalt/printf.c you consider problematic /wrt thread safety, the
>>>> printout to syslog or the wrapper functions themselves?
>>>>
>>>> Jan
>>>>
>>>
>>> I have a set of threads that would each send to syslof under certain conditions. In my syslog, I can see a bunch of truncated log entries. I'd first though that maybe RT_PRINT_DEFAULT_BUFFER & RT_PRINT_DEFAULT_BUFFERS_COUNT would be too small in my application, but increasing those values did not make any differences.
>>> I ended up looking at the code and got to vprint_to_buffer that should be called when I want to send an entry to syslog in my RT threads, and was wondering (I believe it is not) whether or not this function was thread safe.
>>> Am I getting something wrong ?
>>
>> You application is supposed to call rt_syslog (& Co.) or regular syslog
>> when wrapped to map that on the RT version (analogously to other cobalt
>> services). Internally, those are mapped on vprint_to_buffer, true, and
>> that is supposed to be thread-safe - it operates on per-thread data
>> structures and lock-free in a single-producer/single-consumer
>> relationship with the printer thread.
>>
> 
> Thanks for the clarification. I misread the pthread_getspecific manual !
> So if I understand correctly, my truncated log problem should only be a matter of how large the vprint_to_buffer buffer is, as my non RT log never seem to get truncated.
> I'll take a look into that.
> This code is built in libcobalt, so that the only piece I need to rebuild to enlarge these buffers ? Correct ?
> 

You can just call rt_print_init() (rather than relying on implicit
initialization) and provide a different buffer size along it.

And if that works, feel free to contribute inline documentation for that
function - you had no real fair chance to find that interface :)

Jan

-- 
Siemens AG, Technology
Linux Expert Center

