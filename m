Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60632234CF4
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857379; cv=fail; b=Ja/Yl5lKAghK8AWnnRXZYalksc8l9b9pKlCgFKNL8/55hYW/ZKsuJJXH+pflqPGADI/uq4yrfpppBGQDth7w3I+KH7YrCsxGoA/270MhLbv7erq4hmzQ/ql36FSLjKjPq+/rYYPUkA9x7Wolbp3nNKrjx2OXfNOpKVus/VanTIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857379; c=relaxed/simple;
	bh=sSZpaLNlSyLZwgwnA+2XigJWKeEq49UWCChXECHgP2A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NxpF/oOqBOQAsnBSEbe7NP3MqWEQzNIPlrq4t2EjWAvfb4vN/lrzUOnE+qpjbI83quBpjus7nxnq6WaR4LSdJDq/3jTVUt4IolW5bUHV5JtOjG91LZS0WGGYxwibXFxJ+6yPC08Te9kn673ZsSV1GSMS2n89csGqwzlEASgDbmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MNIQqttv; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MNIQqttv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmm5roqzX7V6msWG7aY+q5k/svLfKqe5w1BIlXF4Xv8u4cXUvYlNmRfNoYgXvppJOK+4o+m4WbhCiSVanSnoXnAWWeLbjQ0i9Ff+VogA3+TqtX5YS8v8hrlccWS9wDIZ2MjmM8PdMMObiCMhGga6TcK+Dgd4NGNFpw7DVK60jJy5fx40WbbHsWGp2ekZMrTK446yD8VeKnQMkJrT7su8cmHxGvFtHl6VU/ClDsQjFv9vBY5UFybykifsVkAEQEP9pJjQ+xAZErJD8lcMt05CjL4FYfpjRwA/X5h7RQqkqkDcXIN1FVoUVwjaj2j0KrJQh2cEOQTehnv0IK7q6clojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJBo4rjOSzm2rCdQxK1oJau4OYAHK76RmLzEiFAbJww=;
 b=K0BPXEaa7N3GZPIxBFnMf1DlwF7MJNZGDe6Ift7RYR5YdbdEJNStSaT7XhEfCjFWQtW1lKbtT6gz4vC8BVsTua/bxesOfuL1BNHokNsOXzopT85m9h5nkxiCZNDAgfFnL2FyVO9kt5HhdW8urSWGSTYZB2CXlw4byBnrEoTaFSLnl2lXCDUwo34P1769NR737ajsWCimKhXg1YSGe/QHD0ykfXjKZVJG16VuDCKb5eyi8ku86VBNRsD4II0YLVtfU2e6CqnrW+woofgQE2GybFXYcyY1F+T5cj2jgJ40GsMfDjQpQ3JoQvjMS32fnA8Vm1kjlMrA1FcwMh49tw0WaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJBo4rjOSzm2rCdQxK1oJau4OYAHK76RmLzEiFAbJww=;
 b=MNIQqttvOOQZ5UTbFgGC4VpmH8vGKLlo9mLBsiZzneb1xYR1Kg22iGlaDu4+pJHURDU2vY+qD9TU4PZnr5nTSzQaNR+Fnw7VOAIR06inCkZ0rChMofAuhu7CQhQaObhHGHSrDKSBX3aLIAAa0u0q+0Mfk32/JbbKdz8gOKR3R06k83/Y0MkzacEpB4JKeL6syu9DtlvHDhKDCio6Aj7E7eborPdvwSHATFafv9cr46M8jOhpN+WHEs0g8FqJUFL4Kk+/G1o/+A+nvldA7voN+EV84I4yrVBaO7sqjpr3jxjg+hIO/tQlcvt2D+UzSJ4etX/qKd+h8mpyJwUj4xdU7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3623.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 12:22:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 12:22:54 +0000
Message-ID: <f9635d3a-6831-436e-bc01-b5d033318b04@siemens.com>
Date: Tue, 14 Jan 2025 13:22:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on
 arm/arm64
To: =?UTF-8?Q?L=C3=A9o_BRIAND?= <leo.briand@smile.fr>,
 xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20250113141003.3146947-1-leo.briand@smile.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250113141003.3146947-1-leo.briand@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3623:EE_
X-MS-Office365-Filtering-Correlation-Id: f390aa3f-c7e5-42d9-be3d-08dd34962be4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDVDeGo0Y215QjBtaFNyVE1LY2xXdGJtc09xVHdGTnNHK01idFZvN1ZudmV6?=
 =?utf-8?B?cEROTWg2NWxsZlhEM0dxNW9Vc2N0VTl0aGFDTDFoczIzUjNhRENab3JITW5F?=
 =?utf-8?B?cVAwaE96aHpiUXFNb3NUN0xXWnk2MlVlNXR2RWhpa1hNNlpQNm5OemJ1YzdT?=
 =?utf-8?B?QlFxSVZIYTU1V05zWEoyYWFyWWpjbEwxV29kNkUwcHRiYXE4SnZNYnF3KzZp?=
 =?utf-8?B?MC92MU1GQ3QybEpFZVgrVm5FWmxBSEJLNmJKcWRZbk1FaGcwbzVaK2lJdzVn?=
 =?utf-8?B?QzhPT0ptdC94NDhaNDFwY3M5a09TSHAyUW96QXhBeXVZaWUwVVAvUEdRdlhJ?=
 =?utf-8?B?SDZPMnFpQWxnV1U5ZXhLTFNOSGxkZVBSbGNBN0lwUURyY2dvYWlML0NFOC9M?=
 =?utf-8?B?V2RTYmRsek8vYk9oWURQL0JnMHdFdVB5Z3VkTTZObXI1QlBBdU9nYS9FMGxi?=
 =?utf-8?B?aldBVDl1VGFDUU9tSzMzNW05S04ySGtpVDZBeXJjdWJIdkR3eWJEK3NPempx?=
 =?utf-8?B?cEhSOTZPK2tqVXNHLzR2eC9KK0F5OVpheEU4OE1yVGNnOGYxQU5yRmhjbnB1?=
 =?utf-8?B?TUxpUlVQSTNlcEwrNWZTV09BY3VQVXlrWnAydmFma1pueVFNODlvT2dML0lI?=
 =?utf-8?B?TUJDbGMwWlN6TWsrb2lFSzVZM3RvbnJYNUs2UHlRcWJ6dUJ0WE40Vy95eFRr?=
 =?utf-8?B?dC9CUU00UGZjMWlIWkJyN1g5SGxQQWZKZDk4dUdCaVozMWsvcjQ5bFEya2hO?=
 =?utf-8?B?ZE9wWVhCNitLbnJqOHM2c1g5NGlwckpiV0NucnpMYkxLQmQyaC8wY290WEFD?=
 =?utf-8?B?RmtIT3QvZldHS1daZE94SzZNakhzMEYwZUhVdnJSRDFRMGZoN2RtUGEvZWEz?=
 =?utf-8?B?U0xHanFNYWEwNUw0SWxRVTZlU1dTSzFCUHd0dWowQkMwQlhnM1Z6eGp0R0li?=
 =?utf-8?B?OXJsR1ZpbTBpdUxtak5UR3gwNEViVTlqSWh1UENUM0xJRE5QeTUyMVlzZDZ6?=
 =?utf-8?B?ZE1Ic1BkUy9teHFmYjhSazZwUlZaWWZrbXNWd0wveFR5SmZLaDA4aUhYbzFu?=
 =?utf-8?B?V1BRbkRIMzNTQVRKelJOOWgyV1BjLytTT3Y2SHhxTkhsU3ZsVDM2bzMrNDUy?=
 =?utf-8?B?R1BGVmd4M0RycXBJUEtmblpsbmpVK1ZmcW4vd2NNUUxLc2k3SDhsWjNnR1Ax?=
 =?utf-8?B?bUNDcFp4NTQzMzg5aHNNN2hmclltcjBEMGpnbHpDSTNqbXgxdUl5OVBDdHhI?=
 =?utf-8?B?OHN2bzlwOHQ3OGlXdFpnRWR4MEVyY0lnRjN2YzVpZjRXZnZlQURXQldBc05h?=
 =?utf-8?B?OHVzVlZVaTM3VTJlSEVOM0F2NXIvbzMxRXU1bGcwME9raE1WS052cXRERWVX?=
 =?utf-8?B?SDRIYUNJa1dCQ21rc2dORE9hNEwxS3hIbXBZMW9aaE9xQ0dXK3hqZVM1Q24z?=
 =?utf-8?B?aHZWNVNlN1BZV3Q3QkZIQlRKQ0xSMGVpYzRGTnBnbUxUaFo3SE10T2VqQ2xS?=
 =?utf-8?B?Q05WcUJRQXNsZWEwK2l3MHlRVFNiK3k1NTg4TDNEQVY3VFJIYjg1bWExMk5I?=
 =?utf-8?B?ZWJmK0V1NGxlMEFER3UrVTRZWDZ2WUlUcTlrNzdzOUh4OThLRi9iS1V3Wm93?=
 =?utf-8?B?MXd3aE1pOGRSdVJGN2R4L05DdzhmOWtiWjF2T3N0Y3YzTEdBMDVnbFo1TzZR?=
 =?utf-8?B?Z3pyWlZkWUJ4K1JNMTd3NHF3ZjRIK0ZOekVFbFUrN04xazNlaEcrb1pmRk5F?=
 =?utf-8?B?NTAxMnUyTkViQWViYjNablZtaVdTMFJVQlRNWk1KUEtMMktYK2tWd0kvQjh2?=
 =?utf-8?B?Wnd5L3BzV0FUOE10MmtucTJoR0g0eCtTNmN3UHNOcGxwUW0yYURzNDhnQi9K?=
 =?utf-8?Q?KsURCgtNVVWsg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2dSalFtVGFzQ0gzNnBTRWZQUis3MlZucUl5bkRRRFBMSVNoUFFIeml1VG5R?=
 =?utf-8?B?Sm82MStsSzgxMWdtWHJYaS9ndm1uc0xYcC9rQTZUbTlkMnVTeVpTZmxZLzA1?=
 =?utf-8?B?eldjVGl5cEVBaWhNV0d2WUxUb2QvYWdHeUNSYWlXbkVtUDFJc3RGK2liUXpM?=
 =?utf-8?B?TXdqN3VROE5HdU9hanc4NlVRVVJJcURZM1YwdWNXNVViWlVpdndlZDBobHg1?=
 =?utf-8?B?SW9vQ2NmemIrWUdqbUsrWjlMWnBRUUtXdnVyU3ZJZHNUdFg4WmI5eXRIa0Uy?=
 =?utf-8?B?eThpWVlSSHJ2a0g4MUJOYktzeEJLU211QUZXVU1VYURsVkJWYkJmNmZYWHpT?=
 =?utf-8?B?V20veFVOdlFNMm9JQ0pFQS9FNDQ2Z0EraHRCZW5LM1Jld3JpVmZUQ0hDSk9I?=
 =?utf-8?B?OEpVSzY1UnlmK3dQaitjOWZ0WHplUG85VmNObTBmWEhUejhiVW1RS2VhRzZy?=
 =?utf-8?B?NUVacW05RUN1cmRXd3VCL05yYjI4eEh2SjVLbW5qZHV0amQwSVdGKzJVSWdn?=
 =?utf-8?B?M24rMFg5Z2hlZW9lWit2WUMwV2FiYmgrNDRIak5BRmxrNnBEVFkySVVUL1hU?=
 =?utf-8?B?ODhzY0laSmRjVUZETDAzSnpZREEyUU1oT21ZS3ZOSTJuOStzQjVycGtHbVZl?=
 =?utf-8?B?UWdWK2RyV3pwREdCWXBocTM5eDB1alRiUVB1SVBPYUFkbFNoRStKV1U5N0Zx?=
 =?utf-8?B?MUZzU2RYS3FZcFVWWHBWSmdkQmxQRlJSa1Z1cVhJK0ZSclNoTVg0dm1YeGxr?=
 =?utf-8?B?NXoxRTZkZUlpZlhHY2ppVGFGMFlXdy9rN016RjFRMTI1R05Ha241SWFDbHBm?=
 =?utf-8?B?QktuQldvK1B3ZnJCZWJoSURINHBHdk9FR3VEYWFremlJWWRsL2VFTklvc3Bt?=
 =?utf-8?B?UUNVOTZCME42dzdrRmF4RFNmbnpidllNME5POTQ1ajREV2tBNHpEUnA2S3hH?=
 =?utf-8?B?dTNUbTJ6TTI0RXNXdDAyUTBnVUloV3Q0VmFFa3Y1RFRSN2RUenEwYVhGdkxr?=
 =?utf-8?B?b1lSNHNWRmo3Z1pFVGprRnNuQnZuL1dVNlpjaDZrS253eDRDbVIrN0xmelFG?=
 =?utf-8?B?VElNcXNZSENHaHBhVi9SOVQvdXUwOXI5RUVLTWkyYjV4RTVscEQxcFdhcms0?=
 =?utf-8?B?ZmxBUTBsUStKWkxQMStiK0lCSUpKUjZrOXdpUFNFam13OU9Qb1V2SXJnWUM1?=
 =?utf-8?B?djBHYWtaUlNiWmNreS82clRZbzNKVUVYdGFyOTJWT3Z1bzN0TS9PdUxTdHVX?=
 =?utf-8?B?YVdCendpdi91TTgxZ2pIdW55QzMzcDMrMFJudmljbTg1ZlcwRVZrMFVpeGpD?=
 =?utf-8?B?N2pGdGhESENTbjJTZDdvVHcvTk00RHMrSkZOMFFUN2hTSzV6ckZVdFB6cWl4?=
 =?utf-8?B?a2VvUjZYZDZpMUZNQ2VtZ0M0cWRmQWVZQ3c2VUNpZWVFbm1IcE1pUHFaV0Ja?=
 =?utf-8?B?UUdBQ01Vd1Vib0FzVjEwL3pEa1FNNGwxVmhyc3EzTnR3QUIwci9DbjhwZjFK?=
 =?utf-8?B?REhNTDlwd0g4YWNQZSt3SllQK3pOZjF4Z2xPOVZaaFp1V1RrWmR1Ync3eFhi?=
 =?utf-8?B?VzRrUlgvK2ZkbTJGM1FDTkVhMlIrNzZ6c3VBZUh6dVVXWDA3Ly9WWWZYSXZt?=
 =?utf-8?B?M0Q0ekFnKzdjcHRYZXh0azNMejQwLzQ4S1pvSzhLMENUeU5tQWZZK2RvSC9Q?=
 =?utf-8?B?RGVDeEx0WEhFeC9VVGkrdENhV1NpeXRQaGpaN09YbjZaQzcyallKTkZWZDFM?=
 =?utf-8?B?Sm1OWVVUVm8rRlYxUzdxQUp2VUxTd1U0L3N1MDJUSmNkbTFCU29KeEtlT1pu?=
 =?utf-8?B?aTliWGM2WUQ4QzNkOU9LQ2VTbVNZS0RXejJSdy9oNDJhMVNxeWt3eHNTT0J5?=
 =?utf-8?B?RStwNmVoSkZqanJGYWQvK1ZMbmtWcGdqeG0rS21YbmdxMTN1QVZ6OC96dmNE?=
 =?utf-8?B?TTV5cVV4LzFQZHF2TkVUWWxWTjdSMlNxdHBHRWo0RGp2QnI3SWhkRlVWTk5Z?=
 =?utf-8?B?YUVuQlF6eWxvd2FHNWJsbWVOUjY0ZmRSTWxZNW1jcklPK3ozdTQ3RkdXQlFC?=
 =?utf-8?B?aGRJMlJZdWpyaHNFTHFQT3RBeDIyZVFhU1YwQUh2dXhsUkdTdC9kb1NBWGRR?=
 =?utf-8?B?Q1JHNUR4UDBjOUU1OEE1K0ltdlU5WVVES3dlRUJ4STR2RTlzanVNU2dEaFNL?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f390aa3f-c7e5-42d9-be3d-08dd34962be4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:22:54.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzHUiw18yy9fYbnCfieOhoG2ClcQdQYIXPquR3oUMln54RpVg0hM2adCFzHIzjthsuwDuhhbm6ZaofVIt9SUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3623

On 13.01.25 15:10, Léo BRIAND wrote:
> Issue:  Runtime error on arm64 application:
> 
>         root@ls1046ardb:~# latency
>         latency: __vdso_clock_gettime64 not found in vDSO: No such file or directory
> 
> Reason: Due to changed __USE_TIME_BITS64 behavior the vDSO init fails.
> 
> Fix: Adjust the vDSO configuration to correctly handle the selection of
> `__vdso_clock_gettime64` or `__kernel_clock_gettime` depending on the environment.
> 
> Impact: Resolves runtime errors on ARM64 platforms caused by incorrect vDSO function
> selection, ensuring compatibility with 64-bit and compatibility tasks.
> 

Thanks for the fix.

Under which higher-level conditions is this biting us? Does it need
specific defaults of the toolchain, certain versions of certain libcs?
Do we need to expand our test matrix?

Jan

> Signed-off-by: Léo BRIAND <leo.briand@smile.fr>
> 
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> index 1b4947b2d..c260acf46 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> @@ -12,7 +12,7 @@
>  
>  #define COBALT_VDSO_VERSION	"LINUX_2.6"
>  
> -#ifdef __USE_TIME_BITS64
> +#if __USE_TIME_BITS64 && __TIMESIZE == 32
>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> index 9577aa773..06992e709 100644
> --- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> @@ -12,7 +12,7 @@
>  
>  #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
>  
> -#ifdef __USE_TIME_BITS64
> +#if __USE_TIME_BITS64 && __TIMESIZE == 32
>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
