Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03734FF78
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524415; cv=fail; b=YWn5jTSOzkjfwNy8u5aN6Rd+zCvxTcYSRBLWXc2cgKTQNCPYl0PJisUPdihVNvpYzILoxunOUl0Yk4Ryl/Z9NXjyBLS5xFSG60NVojyyFpd0rwQMvMZZVEEUm1jYwTon1/m6EJmPQWRaD/6RTmFFAxQtufCa9NcviBLarZh8iMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524415; c=relaxed/simple;
	bh=NaYHzauQBAzK/a5HQcFw8goWA7wanfZELHC5NcZ9drw=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=st9/J/blRarsJAz7tI90Q0p1F7QcbVjJQU+kwS/aI6n2REopEc8t1sRD1ZZCPXszXxAfV1+MiIt590k3K0jj5TXEfJTrzszvUz9P6FPMEoo28en5s/B1igzl/sCXVC4jBQoLRxMcWeIcaF+7LRr6iiGGFuRkaKoffK+52gccMiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fkgV0YPQ; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fkgV0YPQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdOxFTXmmkc9h0gfvu0ShyXjszWyNVvvl5yG5mee9E+7Oq6GUUiD078pvzzxn2KWXNtFFHNXHriSyK9bgndtwhWAWvKMkpspN9vPEYWhMS40iLiHlWFSKv5PIkBhKq5qshCYpR0YAm5uGgRdwLLIjQZT08sGLwCgs9Vxhs4cUdK2GAX9mWALYr3UnCVDCz8Q6uZpGLAdSgltAOfbyiRGNf2cX+LYJ8LYvrIlASeNSiTeIUSzia6vs/kFZMc6kSvLMbkn1tVGUhvit0JvO4IWTwGWdER9oUSo/UJU1UqdZYKd2/a7+hPqupYSoYCaawCRlRxtY7xoJRh+Bq7OLCqFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyjIt8W5g/JtED70dm8wZFSpdRfXHAwVyUmUp0DnKQs=;
 b=V+J8IUeX2Y5YNZWlep+BzsXg1ORJr+WSw6mfJSTgidkpqoNalBWqDmUADLetHbwzzoLmCXRLiFvmo/trjnpbp4HQOKx1UTK4jX6Wu2bzafymds8uX5sKP7uCRQwlSUpSqsAna3pIKasXIR67uQ90RTuo6cIzdi8hPOdXsilVu+OD3k4CHsLViiFCGZwa8fOhwh156VCeECIVrLwlapZgFbbCDg+jHKhnJuHP9wK9MUK6a1eOK7Y16ZxgTyEHVBT0P/p8kbtAPcI1wRXizc7qzt5RnkhGCykCNqhRLmm1d64bgomw8e9lRlxeAGw63Jg4cjsp4jGJsMScuA53r28qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyjIt8W5g/JtED70dm8wZFSpdRfXHAwVyUmUp0DnKQs=;
 b=fkgV0YPQfBOzt+bOb5yfAEp39TJJwpxM9jWKkHIF1iWhGgTd9oQq+LItL4nZMpXSUVOcq5m9iZoh3w4Qqh0h0aOqVRsDXYK0EdN+Q0lF9LC5WTe7lQhfnC5lSVABrM6N0GDAm9UV2ZmZWIov2bvkSQTvmsy5Dqd43F7Wa3MjqidYM5P+MY7B+1voIkPQE64bH1fPrRdEetG9dgRgiN0Gm/HJ6uX8O91LZPoJi9MXghVQ378PsJyi9TQIL08uCCLVxjmylZuSUgpNXYXNUbMvXsN98ms7enle8nTjifoX7t+7nflD2urTPgQVEK+ec6T8RkeKuj4FbQ6y2LDT4BR1Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:313::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 18:06:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:06:50 +0000
Message-ID: <1e52e0ce-4a5d-4397-b39e-1c8550111e12@siemens.com>
Date: Thu, 19 Feb 2026 19:06:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Set MAINTAINER for all generated Debian
 packages
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8351ec93-6f3b-4f92-c7c2-08de6fe1a765
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1WVlBQeEZXS2NSaTNZNXoycE91cjBYVFN4eWIwUWs4ak40anB4dldmVzNP?=
 =?utf-8?B?SUw1SVNkSEIwYWYwbzR1bWFXamxKbEdxMzdEdVJrSnNwTzY0dEVzdThnVXJp?=
 =?utf-8?B?VkdicDlEZ2E0L2JScEE3dUJOMnJJL1lFYjY3S0ZhUjFCdmNaUXRoNlhtRnNw?=
 =?utf-8?B?NGNsd05xcGtIODhQbmttZitPYjkvL1BzWXBJenAvM1pxNEVVQ0lWQzFPOFF0?=
 =?utf-8?B?eFpGNzl1ZDVFOGlIRUVxaDF2M1M4QjBGOVZVTjJ3bFZ3TFh1bjI1SDBBN0Fm?=
 =?utf-8?B?Y3cwaGJsMmJ1VkRISFBmSnlOVUpPZC80cHN2c2tQMUpkYzRJdjNpMFVGd01m?=
 =?utf-8?B?VHBCY05wbEplT0lUVUlvU1IyNWFKWU9SaElqYkowNEZscXp3a2JJTUl4YXdY?=
 =?utf-8?B?dTFYbXY4bDBJMlZyTXgvcURBbVVqZTFURWFtY2p1RGVsSG5GQlFDSVV2L0FS?=
 =?utf-8?B?Q3lFVnNrYnF1R0VlcDFLNzV1aDhMbEkyYnFZTi96Qi9UU250cHpoUGtIbDNX?=
 =?utf-8?B?N1VSN2tNNHlpdC9ZWVk3OWsvVHZub3RMZkpoQ3hLUzczM3JKQ3ZBS1RlVEtH?=
 =?utf-8?B?alhWVllmckFZYVZxL0ZFb0VlSzJhYittRU9lbDZnOTNJTTMxVjcwVkZ4OEd0?=
 =?utf-8?B?VXA3d25lcmhTY29RbkRIZnFNZ0R0VC9qYk5OZEFydWZCV3lOL1l5akt0ektP?=
 =?utf-8?B?bldUM3RuYmtlSzd1b01CM3ZnQ0Zzam05Z05peWR5YkhyYU56THEzNHpWRTVo?=
 =?utf-8?B?ek9EYjJ1TElodDRKY2hmcU83cjRISXIvOFZqbS9UMDZLSXhQSHhmVDRVYk9J?=
 =?utf-8?B?WDRVcHh4WWdXb3BkY21oQ2tCaS9vcEhUR0pxejhWSDZ3TzExdHVSMjVVd0pE?=
 =?utf-8?B?VjZTRHB2dEFGK1R3eUZEZUNYd2NtaHp3MHRodkoyUVFWZkhTSkptQTFzQnlS?=
 =?utf-8?B?d3d6SUJXQW5iOTQ5d1VlL3UwT25SOERDQzlsRGhOQlJsQ1dJYnZod3E2U0NF?=
 =?utf-8?B?ZGl3TE9Ga1R4MHFWNSs1VTc1RzE2OTBrTStNSEtqZGNRWDZ3L1BhTUNJbW5n?=
 =?utf-8?B?ZFN4V1BxUko1ZXdLaEw1UjR6TE5RVGVIVzdJam1seTh0bjFzc2Vkai9lWXpn?=
 =?utf-8?B?cm1MZUhrcW4zamhKTy9ydWdWcnI3U25PdTBpbTVJaDBnMEhtaE5VeEJSUStI?=
 =?utf-8?B?Z2lxYm9lVk1LUU1xWjA5dVdrK1pJT1prUDh4Y2VKMFlaSXNteWZVZEx0RlFz?=
 =?utf-8?B?d3FZY3R6NCtwZW9pbC9nR283RTNmSEZEWldINEgySHVadDh0dDd0U2xsMm5R?=
 =?utf-8?B?Z2ZqaFJBMWdocTJESndkc2RjUDhCaDY2bEU1Z1RSa2VDZGxIdFJ4UW5hSkdx?=
 =?utf-8?B?dzluSzZFbElKWXh2YUViZFloSHZMd0FBdnBpRFdNN0pUdWZRd29oUWxZWUtH?=
 =?utf-8?B?VTk3WHBYZXhGSkc3RGg0MjZiQ1RpaUkxRS90VWY5c2dMKzJDeWU4blBjNFdP?=
 =?utf-8?B?THcxWkN1RkZ6RFlhU3R5aGNFTWcvaXBkK2tHZldtQXdaSEpvTElNVWhIc25o?=
 =?utf-8?B?NHJWR0ZBbU0rdVJSckdJSmN1SlAyOW9OampLa2FyL2pYbFdPbDFDcFA2UE5x?=
 =?utf-8?B?YUFrR0pOTDRwa2wycHFjNEwvMWRiYVhxNE5vUFQ1cjE3RjRQUVpGcTVPclNo?=
 =?utf-8?B?N2Vpc0NtUjRaZjJXNTBEZ0Y5M3kwMi90U1lkck9NNzhZeUJYVkcxM0ZLRFdz?=
 =?utf-8?B?bFdHT25FQzhPNDBHdDdTUnh0SldKUU9POGtrU1lSc1pTTnJsd1Z5QTVpdEtD?=
 =?utf-8?B?OEZGTlhUTHdkZ2tpVkMzblBPbEJaQlJGWU5Kb1cxaVpyUm10UnJDUitYeEJ2?=
 =?utf-8?B?bms3bUNwYjBXYnBzTUtQNjZHTmZsaWF6MUlFbDhRREVUZllTdVptdkFyYTQ3?=
 =?utf-8?B?aVp0NGRET0FEK0RBUGNJdDNPdU0xSkdVOTZEdk5PMlRNc2l0bUI0QzFqcjd0?=
 =?utf-8?B?VE5OeTd3V1Q4S3QyamlNUkN4N1FUTGVyTHArbHNTSFZOc1ROVzVSTTNHOS93?=
 =?utf-8?B?ZU5SUTUydC80NGh6eHhGMGVrRVJUSmFoTG95MUhuaVZiWlVOSTcyWWNqVVVG?=
 =?utf-8?Q?T/UA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkU3ZlRNRVhBWTlHbnBITlZsRGg1YkxSM0QrdW5HRXREam9IWDNNTHIzVlYz?=
 =?utf-8?B?SFJWUzJXMEtTbXp6aGxoeUd6VHNvSXArcjJRRDhxQTZFS2pCekxKaVZ2SFY1?=
 =?utf-8?B?VUtkZ1NhdjRFUXo2YUM1dUVWZGJYcFBBa1pDMmpjMmo1cW1XOUNLY3hkYmN2?=
 =?utf-8?B?S1hxWEUySUZ5bFhieDlhMmFxWml1NFdmNVVVVW9nM2NHU3VmUDVoRW1sTG9Q?=
 =?utf-8?B?NEFaVnhZSlViMloxUElJZitSMVJBOHVTeUlDYnRSK2wwV2NhdnQrOWc2ZVJl?=
 =?utf-8?B?MkkrMVl6YXV0MWtpQWJBMG9MSGhBRk81YWxOajExR1BxdkJKUkFmMmF5SVZj?=
 =?utf-8?B?UlhUajBpc3ZtS2hBRmdydHZDRjBudnNkb2RpcFhkR1VIckpUSDErYlNCVGdw?=
 =?utf-8?B?OFV2bGF4dkVRZDNHV0g1VTliSWE4Zy9lUnhBNkRJTDA5L2VYaUx2NkNFckts?=
 =?utf-8?B?K2JFTW05TGthT0hJY01MejM4cmlXekp1c0JwOGcvZ0lxSnBza3RKQUlmQjZv?=
 =?utf-8?B?MUR5YUJnWWx2Nko1SXY5N1lCTWU5ZlBucEVDRHRrNHlWSWgyZ0dZYTJFY2xj?=
 =?utf-8?B?ZFlrazVpWUpqdjgvTVdtL3FBK1I0NWFKdHgxT211cU94NTV3ZTViM2s4enBB?=
 =?utf-8?B?WmhZbEF1ODdRc1BMOVowdVd0bWVqbkpqaG5MWjJpSWVrUmk2WGxFWGlVR0Jy?=
 =?utf-8?B?QnVjVWFxbFJma2NBWXhhVjRCeWVHOEMySHVHQm5CWWVWa1NQdm10cnFsNlcv?=
 =?utf-8?B?bU10b1hSU0crSkx2WnZ5ZVBsdnB3NUVKZVFORkpkc3lHclAxYzZtWGJOK1ph?=
 =?utf-8?B?UDRSTEdDN2EydXQ0NWlsU0ovNUpWcVdteWh5RUpmelR4MEV2bkxoV0c2VU5p?=
 =?utf-8?B?RUcwWElOeC9keHVDSVRVV0pteElacGFvSmU2dlFJYWZBS3NtYWU3YVZBOUpI?=
 =?utf-8?B?alF6ZjFNZHM3OVd3MGF3cmNqWmZUbVhRYWhJcHh2NVhkSjJWalNRTWo5MGtu?=
 =?utf-8?B?aHJENUdrNjRBUVh4cDEwMzlNeEhpMExJQWFoNFBFcXIzS09admZCbGxGOXdT?=
 =?utf-8?B?RmZpTVBRSHRWNWFucHBTYzFVam5xL08wS0FmWUhJU28wZzBBQTlWTDFzOENN?=
 =?utf-8?B?bEQ0NlhlOEpuRVF0dnlvQi9NMkxXUU9vSTZWNi92MldkaENyeVhsWW5lbDAv?=
 =?utf-8?B?SlFzMFdSek1XM2ZmQ1U3N0VJbkRCTUNFcUVMbnBwMmhEbVB2UTMwdnFTNm55?=
 =?utf-8?B?T3hlSGV1ZUNWcVp5Rnp4dDdTQ3RNamo0S2NYT1E3dUlaMU5ySlVhTm5LOUdD?=
 =?utf-8?B?OE8xVnc2enNnTDhQYy9hWThFbllNWlpzNVU1Ui9pbEhIQ0t3SVdPeU9UT1hR?=
 =?utf-8?B?L3RkME5nazI5cmp2UDlwY1hWN2lCUjNSakU1VXJqM1JBTjAvSzFNSERvc2o3?=
 =?utf-8?B?TVJtOW81bDh2MzZQQ0gyMnFWYjJYcUpJaDlPWGRza0E0UmgvQ3lqaDI0OVVL?=
 =?utf-8?B?a3pLOFZveDZZMXZqT3doSEE1aFRjS1c0TndOM050cVhLd1J2UEp0ckRCVTBR?=
 =?utf-8?B?T2t6TkFiejVmNlNxNHQrRnFqckhKbU9HU3BYei9NMXp3ekVZTWdMWmV0WkVw?=
 =?utf-8?B?V3pTbEpWZHdENW4zTGxyaFRVWE5ucHpHRXpzTTZNanNFSGZ2MENaVFI2SkFp?=
 =?utf-8?B?K1lJYVp1VVFua0NUMUtxQ2x4U2RpMTlxR1NEaFYyUFhXWHZMNFpnVFJXWENk?=
 =?utf-8?B?SEFpcStNK1dyUUNSQm9hZGNMWEdNRDJ3R0w0bEM2eUg0RnlscUFwU0NYaDB6?=
 =?utf-8?B?WHNhYlpxTjJSTE1Ham9SYjNOc3o3ZFdtSkVDakwyUXRHRFhENm95QVNZaFB4?=
 =?utf-8?B?SUdiMkJHVFgzWVhGMTdDSjEyM3hzejhMMmQ2eGgxalNqOFRoSEY3NSswVzBF?=
 =?utf-8?B?OUtzNXhzdytPYjU1WmEvN1ZsZ2dKdmNNRDZ5ZlVMTkptY2VuQkl3Qm5HQkFP?=
 =?utf-8?B?NEtSZDJ5MDdQdDhneFMxQjM4TDZ0UkVpa2JoSGJ2c2NNVm5RblM0OWVKQm9v?=
 =?utf-8?B?L0YyMGFKVEg1ZkJwdHBabDBGWDV1ZGxUcnRKakQzQkJoM1BxeElWMUNVUldv?=
 =?utf-8?B?aHkrTTQ5NlRFTTJ4K2xVYVM0Y2w3ekpoTXVaTTVueTJpSGZjU05UMEYyVDVF?=
 =?utf-8?B?bkpGVlBMLzdudVJTOHI3eDhONHhneS9rQi9PazJWalYvSzZvZUdHMTJsYzZW?=
 =?utf-8?B?anhPN2hLc1M1SlBVblR4VkpWTnZwZGV2Ty9qMTBIbXE4TFVKUTNHNk1TeE1y?=
 =?utf-8?B?M1RlcjBkaUthUFU1U0d2TzJUNEIzZ3hJZFU2RmpKeW5UYzM1SSs1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8351ec93-6f3b-4f92-c7c2-08de6fe1a765
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:06:50.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4BYTPj9CsK/VRgAnfnFDR+WE19NrGg3PjZNIEEB8BWjTYhnRai2LOG8QHvC+/tfpFX3jttoTGe8rLj6k/O+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9641

From: Jan Kiszka <jan.kiszka@siemens.com>

Recent Isar will bark at us otherwise.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Recent Isar will bark more, but that might be its bug. Therefore, no 
Isar update yet.

 recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb | 4 +++-
 recipes-core/customizations-ci/customizations-ci.bb | 3 ++-
 recipes-core/customizations/customizations.bb       | 3 ++-
 recipes-kernel/linux/linux-xenomai.inc              | 4 +++-
 recipes-xenomai/libevl/libevl.inc                   | 3 ++-
 recipes-xenomai/xenomai/xenomai.inc                 | 4 +++-
 6 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb b/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
index 1cfb103..ed2ac9c 100644
--- a/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
+++ b/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2026
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -11,6 +11,8 @@
 
 inherit dpkg
 
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
+
 SRC_URI = " \
     https://github.com/raspberrypi/firmware/archive/${PV}.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
     file://debian \
diff --git a/recipes-core/customizations-ci/customizations-ci.bb b/recipes-core/customizations-ci/customizations-ci.bb
index 89bfed5..bc7662f 100644
--- a/recipes-core/customizations-ci/customizations-ci.bb
+++ b/recipes-core/customizations-ci/customizations-ci.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2026
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -12,6 +12,7 @@
 inherit dpkg-raw
 
 DESCRIPTION = "CI specific image customizations"
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
 
 SRC_URI = " \
     file://postinst \
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index fb79a8f..3ee570c 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,6 +12,7 @@
 inherit dpkg-raw
 
 DESCRIPTION = "demo image customizations"
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
 
 SRC_URI = " \
     file://postinst \
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 0980662..db0abb6 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2025
+# Copyright (c) Siemens AG, 2018-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,6 +14,8 @@ inherit print-revision
 
 FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
 
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
+
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
 KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
 XENOMAI_DEBUG ?= "0"
diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
index 4c048e5..582d381 100644
--- a/recipes-xenomai/libevl/libevl.inc
+++ b/recipes-xenomai/libevl/libevl.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -13,6 +13,7 @@ inherit dpkg
 inherit print-revision
 
 DESCRIPTION ?= "libevl libraries and tools"
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
 
 PROVIDES += "libevl-test"
 
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 6366b6f..9dfef32 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2024
+# Copyright (c) Siemens AG, 2018-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,6 +12,8 @@
 inherit dpkg
 inherit print-revision
 
+MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
+
 PROVIDES += "xenomai-kernel-source"
 PROVIDES += "xenomai-runtime"
 PROVIDES += "xenomai-runtime-dbgsym"
-- 
2.47.3
