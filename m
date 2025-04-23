Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013002.outbound.protection.outlook.com [52.101.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870110F9
	for <xenomai@lists.linux.dev>; Wed, 23 Apr 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386780; cv=fail; b=ekmYRH90/l6wwzee29Poeb/fhT9TsoiW8v1O4P4d3XGKGbrQ1UYDZ0ejl93Z9ZUKbaJSdDJeXn4fUHyBk6akZ59XBshVKNoNRrpp1JgOKUYDaHuG3qaxJVUczZK1wfdWTxQr4nmFd2ZeYgEQobL21GtwQhCFLOCe3ii1woTpTeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386780; c=relaxed/simple;
	bh=7F0ynDqLJm7AeDgjAbgBZKSA125gege1UA/Z7N8Ndmc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g5wF581Yz0nKA0E59C8NZz+/YTaW8aj86lnDpaFx2hmDCLfYWW4kjuk6Z7+JsxHR1xRQXoTEeeycWZoN/1avLngAhDGhBok6DxJIch95wxXxtmBWMAV/JFt+7jatwR2SMpwCWfZgQszzT71W03JLeBrK1Is6Z9SF/lBYB85Qym8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HKH6bfiQ; arc=fail smtp.client-ip=52.101.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HKH6bfiQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTsPp9RZ0Znc+6UnO1Pe9IoDFKyjy+OjB/CK5Gj3kNzYYNKBGuca6Un5rlI419RDndyIdDi+XVLH3/78sYqJrXQTH2vJwT4xeCwA63slIIC2UugcdM4Z1krpF2n6mzhZbBwYji98wWV+s9+0OBf8cyGrEuF7pV/GViSQYdb3pVQL7A63iFaNjlSwPcXVowWytkcNJWtoFNyZEgkjGH/CBohqXgQh9qC9L/NQ43VnLtJ24bzI34l9PjblJ9KlskcXttLeW/S32BcaPwrITCwl8mac0XEzulFwR6rDiLvrMHGCo50bSDycFbmFhqa4A+AvvblM5NwvIo5L6XkZfcStcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L2OZk/8s+aoKV3VAOZAPmCJH1Jr69VsmQHwave8H5Q=;
 b=wknP69NsdLTup8H06B0lGL3j6WXKhbeNEgjtdL8sQ1zTsxe49KzjQEa1ee7Da2+QP2G6KKGyblJq90MX3VZr+OtKpZLC/8WTPodfwmKPkGkqCvWZquiYM8JVMXOJlv6Z0OwjzB3DRlfPyeVsjyJ3D1HENwDiIitg93QCrfO4vQPKv2IqNu5MltvmBY02f5hXV2zE1r2VI12SMIY1yjUtmqwqYmodaMh7TF2UOs7wWM65lsfaYT5Dkz7uvGKwxYs8ZTsnk3x+T6Buf3U4JWZysP9bgyD82qj5+qry/EAYHsvDaBBllNAa3LG1q+frDGY6kOXu5xShFUHZbyjUce8iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L2OZk/8s+aoKV3VAOZAPmCJH1Jr69VsmQHwave8H5Q=;
 b=HKH6bfiQerh4bFC42cqBeW2b3J/AGpu1OP/VyVQlEqQmhfolOdrh54YylwTeeq1+YfHpXk05LGnx/KS8QtUSc1xLDYiVDsDNaZ0tv5PkwfxJdR5YpjexANSLvVqC2dk1YiyY2SVwZNjAV/wEhSOZFfHIPVCTU/PgTUyR0amQ+0ueN+OnfoNGskeGYHBTzmr9Qo0MJwfyrl01s1knL1jWLIoZEeQZT+VnPfbW7/DAeLdezuFmM3jrr4HYGh0gx1NSwNyKaSO3z/J6GeijCO4oYrZMVtydl9Vngzb6ivViPidQXUJEVeNllLe4THXFBW5ECOFBJ2uEza/9PRhbpZf9LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 05:39:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 05:39:36 +0000
Message-ID: <1c1f2f75-b1d9-410b-8610-90c3b7caef0a@siemens.com>
Date: Wed, 23 Apr 2025 07:39:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Atomic double writes
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPFJgDYmyM5iZV80JwP21n6vSnrdsQaHV1jGfrhw=+WKFw@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPFJgDYmyM5iZV80JwP21n6vSnrdsQaHV1jGfrhw=+WKFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3322:EE_
X-MS-Office365-Filtering-Correlation-Id: 081859a5-da94-4645-3565-08dd82293b79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlBhcGhkU2c4NHU0MFVsR1lNbEZnUmsvMFhBSzZnL2lWODVWdGJWUFRaQk8r?=
 =?utf-8?B?akJiVkpua1pXdTlnTVN4Nm1wOU1MbkNVdUl2cjM3ZjQzVFhZMWU0bFFidWdI?=
 =?utf-8?B?cEJQZlhEeFl2a01RN0s5eURYOGJVV3o5RVpYV0pTQVB5eDZFUTZNSDlydDc1?=
 =?utf-8?B?ZDVob0F1T2pPaDQycGxiWDUyUlE3cXgwdFpzUUpxNE5kU2V5VlFabkFNa2xM?=
 =?utf-8?B?V0hoRXVtOHVYZ2RLSVZiLzNubUVpL2VsQWxQM1l6YS91c29OT0NtNU91LzZ0?=
 =?utf-8?B?L2h2MkFEUTdlNXVkcWFDUlpza2NTWWp6bW56M1F2ejRZOXVhQUozOTRsVk9v?=
 =?utf-8?B?ZmxSdlgwSTcrQVVSNEZsTEFadlh0TkVaaVBNV1BlNjBoOEJvQzhwdjBPSC81?=
 =?utf-8?B?dWVUbjhUbC9zWmpGZngzWXZIM0N3SjBmWTk1d1hFTGRLNmgzdkMzQ1BDRFph?=
 =?utf-8?B?WkxxWGNaVnl6YUd0dTRBbSt0T2RUL29PV01qOEVzYSt2emVEMXBBMUxTWm84?=
 =?utf-8?B?Y0Z0cE0xZjlNSEVjQkxnc0dKQlVvOVI2WUg1ZWY4YU1HcGE4NVNtcktiZk0y?=
 =?utf-8?B?c2VWc3NNelZHU1pXT0NsZHlSQkUyV2NEdTVuYVMxb2N3ZWEyb0pwODZ3a1Vh?=
 =?utf-8?B?R2RwT09LQTZOYWRNQXBmOXpNckFSUlQwbDNWbnhic2x0cWVpY01mZk1Lc1di?=
 =?utf-8?B?QnVWRktuS1VtMEdlUUFhOE1TWTMzM1lUM2tJQmFHU2dQS0RCcUtwU0VDb1o1?=
 =?utf-8?B?WTB2MVE5eTBINElFbmErSWtBTTB4M2FSNjJZd3FkWk1oeUllOGgyV2ZiT09o?=
 =?utf-8?B?NHllazJoRkRTdlBhVzJHelZQRUFoK1ltVnBSV2xaNitUcjhWTHdrUmhXZFlt?=
 =?utf-8?B?dkVEVHBVdHlRd2E4SUJVbXl3Q25KM0MrWXY5TGVoVlVaTkErc0RRNFFCWGV4?=
 =?utf-8?B?akVHTk41dU9QVmdONEZ3V1d2MVdDZWZGczZDcnhuWHNRbzJLVTVFK2tPV3VS?=
 =?utf-8?B?TDdVMUlPN0V0ZG9GcXFuZGR1M2NEejU4YXk2Z2NpS0FUaW1wWjBlaDBYaGwr?=
 =?utf-8?B?MnJDdmpFY2RqUWdsMmR0R01pekFNd1k1TWFNVEhFTkZjeWVwbUsyc3ZObk5V?=
 =?utf-8?B?ZUg1c0ZnK3J2S1V0Q0UyL3Z0YU0vRVR1SG5lQ2xaa2ZlODlrVjhTVVh3ZGpO?=
 =?utf-8?B?MDYzS1NoUlF6bkZKVVdlQkVjWklXSmhYZjcwMWcraS8zaXBjTWVZazNTU1JZ?=
 =?utf-8?B?ckhTQWdBZHFLUHVzKzhMeDYwcDJtNmtvdEp0R2doejdmV1Q1elNzaXJObW5B?=
 =?utf-8?B?UnE5cExhWElBb3JYRzBIR1doMU5xMUxqMys5d05RMUU3NldHdW9RUkwwRHRB?=
 =?utf-8?B?Y1FPb3NYcXlFa3o3M1ZtUmxpVGI3K0ZmS01uOXVGekh4UTc5MS9vNlBiOWFB?=
 =?utf-8?B?UEFsdUtwVndZS2pIcXlicnNSQXZSS3JOV3k5dC9qZVVYM2Qvdi94YWF6c2c3?=
 =?utf-8?B?RlJkemdmeGZTcVQrRCtOWTJHQTBxNkhBcUJwM2NCTnVBanFRR0M0MklIRFhz?=
 =?utf-8?B?MzZBMUM3UUR6WGlmUE4xTUNydUsvR3JyLzFaL2ZFOWNmSUNvL0ZvenNQSUpn?=
 =?utf-8?B?aGtORjNJM29HQUFULzVFY3E4VFRBMWtJajB1cm1lVmpaUXdYUFB5OFMySGc2?=
 =?utf-8?B?ZFl5am1WekNMME5JaVhWN3l4aUVlYlBTUEJqWmJjYzFyQkFlZHlFVm1jMjlW?=
 =?utf-8?B?THR5ZFpxVDIxTGViditwOTdFUEpkNjJXNUU0SEVpK2tFTEVkN2hKeCtHbmlr?=
 =?utf-8?B?enlCRktoVDNGKzIrSFNoVUdjdWgvVEszZlZESk4xbTRXNXdZeStwQVlxcUpx?=
 =?utf-8?B?bUZMVUJmcjZSa21pTlVFaURFWWtKc2RBMS9BeC94YVQ4ZTlGMXdUY21IeXAv?=
 =?utf-8?Q?CkZzdlCzcZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlN2Ym9ETzJRMGhVQVdJS3NIU3I5WmFPL1JJeHdrdlgwMENmRWFpQkVuTUFQ?=
 =?utf-8?B?Q3oxZitTc0ZZc1docEZ1U2NqZVVmOG80MzR6cEJOZHp2RGc3aWhUT0FKaEFH?=
 =?utf-8?B?T0V4WDk0bUl6SkIvOVkxQklzUjhxNDVFbWo3K2RMaGlaTDMyeXlTYlloSURQ?=
 =?utf-8?B?eDQ5WFV6OHl3MlhDKy9vRXAxVFpKcVNidkgxYzlPYkRhL3lnMWMzSkE2dml3?=
 =?utf-8?B?Ujh5Znl2QUJqMU1PMDVlTklxQzRqTXg0RkF1dzFLUFM1L2pDdlFnbFhKNTdk?=
 =?utf-8?B?MzZOM0VnTUxDWWM0M2JvV2lsUUJGWWlGRnVERjRhWGlsNEdYZ1hMVWdyRGtB?=
 =?utf-8?B?NFNHQ2dPblVrTWZocnI2Sys3NmFWUGN1RTROWjk0WVh6UEZ0Y2RBRXREZjZ3?=
 =?utf-8?B?VU16d1E3NVpPem5aTVFqSjZTVCt3UWI1ajg2cTZ1ODdkeWxqZHp3YThMQVdG?=
 =?utf-8?B?U3drYkkxdURyY2V0UStlVTQwd2dHaHhKclc5NU9LRXRsYXNMbnRQZTA1cTR4?=
 =?utf-8?B?VEZDMmVrbWVKQ08xOGVReXVEUkNTUnlIaDdrVC9ubW1iczFqQUVUaVROVG9L?=
 =?utf-8?B?RnZpeDF4aFQrQ1R2ajc3WGFKNkxxMlpLcWpPeHFoY0E5Yk1LN1ZrWm50VUJS?=
 =?utf-8?B?M3ErL2dLa1ZKTzUwaFNCNXJSK2JYZWRSc2ZDV3E4aWtyNGtjbmN5QWlUR0R4?=
 =?utf-8?B?ZzR3MkRvZmI1YVRUbCt6Z3phZUhuUVdhUHl1aEdyVitFeVVGY00wNlZJOGx4?=
 =?utf-8?B?c3FPeHFYU0J6TUszYkZ6U01jRW5ZYmFFTVJaWldxSy9FV1QrYkR6Ri9rZzNw?=
 =?utf-8?B?SXhrQkJWaENUMHBuWGdONzlyakhZenllbC8zWktDNEM4Yk5EcVFLblZBSFZ5?=
 =?utf-8?B?V3RXcjlweVZCTU95VmV2T1lOWkpVM3BNcXJNSmNFamhjc2JvMkwwOGlQUW5O?=
 =?utf-8?B?SDZvbk1sb3dvNEc5dDQwQnVsTGhWQVk5ZW4weXNyZzFMdVp4MmxiUEpDYnF2?=
 =?utf-8?B?d0dKRUVmUTVaSnpWVkhjMFRJbEhaekc0THBLN0JabW80NmNYOExRbVg2bXly?=
 =?utf-8?B?WG4rQWxxMWVRTEVSbXIzTktrOUs2emxnSW1QbzRacXBXaUFZWElaWWhIQUMr?=
 =?utf-8?B?ZU1WeERGeTlrMVVNTzJKNUY5VWFTa2VkM000WFhGZGViZU53alJiNDVTdzEr?=
 =?utf-8?B?Y3lqVFJ6WDZybG9BeHd4RGtsbk8xOG1IUzdkK2pRUkZxZlZiNDUwMnlPK01l?=
 =?utf-8?B?eGhTT1ZEVmRma2lqbENocEdkaVFTa3puV1VDK1htdTZvczBQdGRna3ZMTS9B?=
 =?utf-8?B?ZnVYV0NrK2FFVnlvQ1BqZCtKaHZXdzNIZ0JpcWZYT1BXNXFTUVlqbGxLY3dZ?=
 =?utf-8?B?anVFalBOK3F5T3k0YzBtT0RNYldsWllZenphTUsxRytvUkc4NStsRzB0UGV4?=
 =?utf-8?B?SjZjbG5KUVQzK1dJY1lKVHRoRm8wTysxVkVJMUxtTUF0RU1oSVdNNFB2RDQ0?=
 =?utf-8?B?T2xFdGp3b3VxTHRmck9oN0JuR25ZNkNPVi9RVEYxaVNvTzNGYTRDbnp5NVNm?=
 =?utf-8?B?VG9LRGZoUkJuMGtsbVhtNEZTNm90aVZVTEsxREEwSkFwOGtraEUwL0U3UTlx?=
 =?utf-8?B?dnUxNEUrM3dsSHV6c2oyTkdvL3BCbmNHNTJHb3JOZllQTzc2RTZ5ZG9BdXIy?=
 =?utf-8?B?RDRmT0V1RFg3TVZnenEwcnpIQUlwVm1yU2g2dDhka3liODVhRFhjWXBtZ3FP?=
 =?utf-8?B?clQxN3Z1RDFEd1ZYbGdjQ0FDZ0J0SVpScHpzTERiK0g1VnFJQ2RwVFFQSmMw?=
 =?utf-8?B?OU0wWEtjekZtbnhQZ29zZks5QzNQcUZZV2RvRWZBQVA1T2FrbHV0emI2c0tm?=
 =?utf-8?B?Z0phLzE4c21vUXJJQkwvVm1QZHREcWY5MjNpcDQxVHhxVStnTHlMZXQ5YmtU?=
 =?utf-8?B?UzYvR3ZjajUrTEVaTDFXWnFWU1ViV0ZlMU0zZU1RZ2ZBMHQ1ZE56TXMzM3FR?=
 =?utf-8?B?RXJSWnQxWkhoMVpXSW5UbW1va3JVRXdwRE1RVHJpSUlkV2JaeVhVQjhNZ0xF?=
 =?utf-8?B?MkJTQ1cyS2krT01nc1ZrNUJBcmpKRHFQbXFzTEYyc0tPK2xpc0N6c1h1U2Vl?=
 =?utf-8?Q?9TAZUv32IZV8vl90nHud8YIzx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081859a5-da94-4645-3565-08dd82293b79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 05:39:36.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ5+zkToJx7DC8NgaIYAf0zJFLsrenULKzqYhwfUpYFwW7U+b+nVVTwiHouqVpUzJRnUFNQH+4fitCvw7NB9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3322

On 23.04.25 01:23, C Smith wrote:
> I have a Xenomai RT Task which instantiates shared memory and is
> writing doubles to that area. A Linux user space task is attached to
> that shared memory and reads the values asynchronously. Is the write
> of a double atomic such that the userspace will see a valid value at
> all times?
> 
> I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281
> 

Not really a xenomai question.

You can study e.g.
https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html

It likely boils down to casting a 64-bit double to a 64-bit atomic and
use the related ops.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
