Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917D22F399
	for <xenomai@lists.linux.dev>; Tue, 10 Dec 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816686; cv=fail; b=ROIJY5Dbd7X/xzVkUFIyM8sWNiyqpKRyMDXeumrYyQ9rg/tFgBkjGyglSyKuqHibHem39p05BLNRUQeQ9D50ZU8pmNIHo1d7nNUTA0zajmiObdrY7lZiClyPkl+otdicgdUsXSJ2P44tKtsfuv1r0skury+jXYYbsKDuefb05g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816686; c=relaxed/simple;
	bh=LzBvWVUVnSv1ZWHvPPA00XzPBPwAA6w2EPXTMh6LOAE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIO4fGYvbAXs5fMm+tWZ7GbQojj8WGSfeYS/Qu6RNB3h2J96btOA7nRc/055uihQO9hMCiDrbuLW3KM5cDSyHGnNrMNJ2u7epxo0AXlohBGzyi8vZT9mx80VFTJCd4yPLmWIhyQG2zA+xgWMiiBXnv1B2CSKUazu3gnGVyta264=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QXpxljua; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QXpxljua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp0K7aVc4rVzPHw+aOXpNZ5XsrSnzaM09o1+Tvx2+avS53lpG+kR03sfIZCTJQWSSFBGBd8BfsybUg6m/YN+MTyAsOmBhe7UetmqE7VzQ1T2PeBqYh9A5xZZz++4bv8kPu+tf3h+H7f70Zh2m0F+oaGuxkeZFRGtMGjwstfNZSBqLjtD6B+RY+6oevfq8+SWGZ3xkdHBnd4835P9u64zzOWsMWeSS06LkF6jSQLKZx40yzCdmkI7z5WX+9v0l3DRfT9/lvQGfyQD8LUEDcxeNLTzEm9TUBtrXAyj1XILiopqj0eW7JlEulPZI7xHH8ySH92VRlbj6o1NtlG0ZXyyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X68A6nXvWMp3pORWPN3zph/G2zvBp+ydvHODlRzskxk=;
 b=Dy8NsscKd7+iHkpJ4afS0Z/IsRvocksKgm7jZ42T22jGJbtgQlXBfgKl1ek9Sb5z171kRHkjVcm6SJ9OzeX44wER/9e9j527wYXxcJMcCaNNcpI8I3NshqhNZIK0ZmNoPc7tQVfK++iIhSir6Ai6VG1mYpUQ/z4DYl/jCkKAdjSxSkXpNGgFZUheV9FKFPSKgt2effzmLE4CldRlUfJx8GpHiAIgWvRO7WdtTtT048P+5THlOEFF5QO0cWTLloKSXekJRPc0M6bjOZ21guewvBkeOj/TkVVmK8iQ4qscs4Bh/5YYu7CvmvgRc/KiLMwknctS80dbXg8/UYhIHB8odA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X68A6nXvWMp3pORWPN3zph/G2zvBp+ydvHODlRzskxk=;
 b=QXpxljuajexkhULdjmAIoRxkEYSeNKFq8TdpS0bLI3jBdTanf/4+KvrbXivI4c9QrRyNZEAYzdoYWTytcp00Awj9lPH59RHaRvC3VPD3bb00ewoRgn7e/mnjYQzr5fuq4aqbCS9ZykKGVkFxd2yu+KisfVlwy8+lCshgGWyPOJe2dH/DnBdh1Jm5sXDIYQb9Z9waqbTFJicsfDscZGvmMLE6KKDodME4RUpv3MjOY+xfhybSMXD8oAR3lOzB/FXVIGMcx+W44+Gh8DqLPgEH1Gx3WXnIXa+CLn1Q2wBknLYbtgYaNiYqQHFosWfizFZW0/wPXh8KS1H6rfxMzndD3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Tue, 10 Dec
 2024 07:44:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Tue, 10 Dec 2024
 07:44:40 +0000
Message-ID: <681bfbb8-97b3-4597-903a-dc0bd6f22d94@siemens.com>
Date: Tue, 10 Dec 2024 08:44:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: remove unused `pthread_attr_getdetachstate`
To: Qichen Qiu <ruiqurm@gmail.com>, xenomai@lists.linux.dev
References: <20241209085852.676777-1-ruiqurm@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241209085852.676777-1-ruiqurm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9226b37b-1c68-4aec-2a6b-08dd18ee811c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTFqRXNOT2ZRaURoOUxRZlpaaGltamhTemhYV3ZwNDU5YXhBWFRGVWxBVDcr?=
 =?utf-8?B?M1lvb0YwUUdrMkZwQmFiclFJeU1talJTWnJCMjQ2SlU1ZzlleGFwN1dVZzBt?=
 =?utf-8?B?UHI1RFpMTS9SaWJTSWpXelZEUysvUW5iVDYvRDBjemIwRUZPVHE4RytKUnNs?=
 =?utf-8?B?b2taS3c3V2VDQjhjb3NYaVBIZDNzd2cyVEtXWW5oUC9xZ2hVenpYU2dhanpy?=
 =?utf-8?B?MlA0VWNyNEtPZEtxUTBZWlB5TWI5T0xwMml3RXUvMjA2SmhTQmhjaEFiZjAy?=
 =?utf-8?B?RVZWWExqdnFrRWpETmpaY2t1RVVVL2dZUFRNWE04TlpOUEdLSEg0U2NMMHZs?=
 =?utf-8?B?bS9DMnBBM29XWFU2SlB4S21ydkJkVUtQemxzaVpZUmdMb2pobG85ZUdYdnNy?=
 =?utf-8?B?RVlwdDQ0RW8yeEJJejZQS3VhZjRKOEtkcXUzZ05GYkk0cldNU3UwalNRalBk?=
 =?utf-8?B?Mk0ybnovQ1JudWxBaVpabUJxdDd1QlZOU2NrcGN5NnJRVjJCWXJyK1lsc2pk?=
 =?utf-8?B?dUYzcUhSTHp1VnZEVTZhWk1pRkl1MThQb2pwN1duMGxHcGJHUzVySnlTVy9S?=
 =?utf-8?B?cmhNNk9jNXdUQytrVDZWTWZGVDNvazRESUZvaDY2NGt6VEFsRk1aNzBCdDdQ?=
 =?utf-8?B?WnlhU2lRMTJmRDBLbEtDNVdiVkUvVzdaM2oxdE5ZSjFNNHI4ZFBPVVVJd0o5?=
 =?utf-8?B?QUpqSTNpeUErMmNDQlNwaytXTlNWYXFjNkhHMUlwVU0yTkJ5ZUZyY3NPbmNv?=
 =?utf-8?B?Tzdxdks3aGtHVDdoVy9Ra2Q4OEZURS9CZkhXR1g0U0hicTl2THdyaG94V2F4?=
 =?utf-8?B?NVEvVHl2N09FaGN1R2NYdi9XZ08xZGFBYnJTak40cERzTVRPWXpISFpEOG5L?=
 =?utf-8?B?dEw4RU9MUVhTbDN6Q2ZjMXkzRTR3ZHByaFNRSiswdUVsQ2NpaGZPRXJiT09k?=
 =?utf-8?B?QmRPSnA4clNNVkRmN1JFWEE4bVd1U0NibnhsRFlaNEdkMG5Rc21qVGFLbUta?=
 =?utf-8?B?QTVPWWtMYzNvV2x3Y0Q0bWt3WTJ5dmdqSzBCQUVTSk54YnVUb25KQzkyZUdi?=
 =?utf-8?B?aWJxa1pua2htZkFUcmEyVGZYRW9RdUNKYTY2TG5FMkJXMndwMHZsNzRLSnJJ?=
 =?utf-8?B?K3JzMjBILzZGWnBCTTNTbHZKeEZGdW5rRnAyaXAyRlNIUWFrVnVCYVREaWhT?=
 =?utf-8?B?Ym9WQnNGMy9oUzVnWDV3MngzMHdmVG5rY1huTk5xZUFyVks5K2Mwbk9reHFG?=
 =?utf-8?B?aHZmbjA1Y3Q2aHBrRTUzKzAyVS9VcFhPbWJuRWxZQ2JCQVhaTmx1eHcwekg0?=
 =?utf-8?B?MWpHcFJmeWFad3owb2UrcU53QlR1Rk5PcFUxQ3RoQzk2RFNKY3RFVk9qbmFi?=
 =?utf-8?B?QVk3NUd5K0Z0V1M0NUwvaHBuNVU1L1FLL2Y0UzRnNWxoSTA2bENaR2JCbWlm?=
 =?utf-8?B?bHRzYnpWNlBkL1BKVnV3NzcvWWMvNHhrU01HNHJDRE4zN0xqUVExb3FQcXFU?=
 =?utf-8?B?VjcrNW9nZGZGd21aN3g2Y2FDajY0WkxRRnEvQzFQK1UzbGZhTkJzTGV4RkZm?=
 =?utf-8?B?eWdUU3IwalRmL2JYa2tZd1hRRWhRTHMwU2Z6OUF1dFlRZ0NXR3JSdkk4bjlT?=
 =?utf-8?B?dEJ0U3ZwQ3hVNXFGclhhUGZkNnR3T0xyNU1FMVowU2NhVnVnOXhsalRydTNn?=
 =?utf-8?B?MXZnOUVUbEdUWHpvc3lYUmNOeEM2cGIzajdEdDlGVWExWXRNTm9wWGFxU2J1?=
 =?utf-8?B?bTU1c1ZSVlZMOCthM3BNS3hIVDdZeWhQbFhqMFNmQ0ZtZUNZdjN0TkRzUXJP?=
 =?utf-8?B?NXVjaVp0NVRzV1V0SnE5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejMzK2twN2MvcFVwdWtnV1RndnVOUkdac2tjOC9HOGlwYy9KdXdRNnlQVkhm?=
 =?utf-8?B?aS9FbWhCWjR2TEUzY2srRFBzRWtOM2V1aVFGWGprR0NPRVZub1pMdGovMThD?=
 =?utf-8?B?Vm5WTHZiQk1IWjkyRSttSHd1UGw5MDBiNmZvWVREVFBCME5vbW9RNHBEZ01r?=
 =?utf-8?B?RXU1cXZwKzZUSXI2VFRQbmRFclNNQ2VUOUdxSS9pQ3JKWGFvczhjOExvSEJv?=
 =?utf-8?B?Mk1NUFVmQi95NXI4M0toaW5zSUladjR6T29YVklCc2NVcmtBNHZ2NVBXb0VE?=
 =?utf-8?B?Qy9jN1pKQUpRNDR4UWFTRkhqeko4Mm53T0RocGY5ZWlMejBkRjRVbDhyTitC?=
 =?utf-8?B?UEJ0TDRsSkxmckc5UExLOWZ6YzNhemFKY3ZmOFBqcHFYM09VQlVNLzg5ejA3?=
 =?utf-8?B?YXd5Y1RzaUFHclpVRTJ1YnU0MDVPbXdkbVJKVnEzU3ZLR0YxTlFyOHkxYWhD?=
 =?utf-8?B?ZnNVTERRL281eUpyaXlPaEhYTXRGc3Q2eE9NdUorRElIZUdKYTV1VDR5dm1v?=
 =?utf-8?B?L1FzRjhlLy9MMnM4d3JtUTl2NkZ5Y043Z1U5RnpocUpaaWsyVmlNWHIraCtr?=
 =?utf-8?B?NjZPVkwwZkhIL1Z0bFFRc3dVTFF3bGR3M2FlQlFTaE85dVlMakdzYTVXVTF4?=
 =?utf-8?B?NGlzbDRubnBLUVhvaE0reDN5WjM2U3krMFdIcDIwMEYrRVRxaGNxQTFmRDZ0?=
 =?utf-8?B?SU53MGdiY0haSHh4djJoZzY0bFVjb09Kd0FZT3hZQXp2cVBJczRiejF4YlBx?=
 =?utf-8?B?VEFjcitTNUNUUklKcWZEaDFtQ1NQbFJvRmF6VlJDM00zYlh0eUdNdTg5ZnVN?=
 =?utf-8?B?Vm5kRUVkT0V4dlFrTFFaMDJJS1dmS3hUVFAwTUQ2WmJRazVXN21CYjdPOWdC?=
 =?utf-8?B?K2UyYjV2dXcwM0VWTldjQTNXeHlmQ1lsZ2RyZ0xEaVhuSkFFWFNzRGl4KzNH?=
 =?utf-8?B?TjJmY0ZCdk9hUHRGQ09vbDZEV1FoUG1hU2pSdEVGczBYeUZGVDRNK2I2ZEp1?=
 =?utf-8?B?OXFDUUxKcU56K3hoMXpZUmQ2MkdtK2xYZ1pOL0FkRncxTENTdzBNNWdNWTVI?=
 =?utf-8?B?UmNUb0ZiZkVmV29aV2MrR1YwaTROUHYzZ0Roc3hEeTA0dU5YZGFjb3ovc3Rt?=
 =?utf-8?B?TnRTbWIydEFFNStwMUVjaXJuUTBJWHNqY0hSYnVaV3dUd0I4SGJSMnBTbFM0?=
 =?utf-8?B?K1p2azdnbHA3L2ZhbjYrWDJLbmJabEdTTjdBTW9hMDVCKzNtS3huN1NtMm84?=
 =?utf-8?B?RWExZ2lFcThybkdDVnJGaEpQTHEyN1hlbE5RWWRSMHdZOWx3U2hTOFNuYm8z?=
 =?utf-8?B?b1VSSFM2NFJXYUxSaHp3KzhxL2IwSklBR1gzRVJTeE9aczFqZUNGbGtNMGtG?=
 =?utf-8?B?RHhzNSs2K2MwemZ1S3Q0WlkyeFFkK1hrU2wrODM0eUZwelRkT1hHcVh5UWVI?=
 =?utf-8?B?d2dxZ092dzAvNnNDcWNtbmtNTk11aWVpMFJRQWc2M0ZOVk1FNWJ5d0owNjB5?=
 =?utf-8?B?Q1N1VXRHVkRnRzUrd3RUK29lT3lXNVNjT285SEJxL3h6cEhvWnhpNnJPNGJt?=
 =?utf-8?B?ZHovZ0grdUlaTlFwbWpmd0d6SWFzN1RuTlVZbVErV29PWVZ1TG5ZemFBc3Z4?=
 =?utf-8?B?OEwzUDgzQWhKaGF2bTJwSjg3a3FPakFTTitkL01DSWI1Mi93d1V5d2RJVWR5?=
 =?utf-8?B?TGdCMjZONmMyN0M1b01uTUxvQnM1OXB1WFZWb3lsejNVWnZHeGUwRnQ0Q2pw?=
 =?utf-8?B?U2F3STY0OGRtRys3ZnZHYklhZ3RpZEVXYVgyV3g2WmZHSmtXYUR6dmpCejht?=
 =?utf-8?B?TXFxODBMbDZ0MjBGaHJGQkRlVlF5MnRyajUzekh6bjVNblNIQWN0NWRSbE9Q?=
 =?utf-8?B?YlRxcnlha1BNSHdrb1JlUENzNExpN2hBWVZmemZ2WUJqck1DakZNSW9seVVP?=
 =?utf-8?B?M1AvRFZKVDlQNE9KSnZmZ2dTUzlZcjU2SUE3WVpoOFozTEgvSk1PUUJmTVNX?=
 =?utf-8?B?amQvVGlWWlhjcjAyUmtveFozQVVRNkxTUCtqbTBHNXdkZmtFTkRyM09CbkMz?=
 =?utf-8?B?WXlad0UyL2YvU0xDbmZ4bnBWaDZkYWw0UkdNeXpKY3VwT21Fa1FEZXAxazgx?=
 =?utf-8?Q?ar6C0DfEdEWID04mfvZS0nHNE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9226b37b-1c68-4aec-2a6b-08dd18ee811c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:44:40.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umAGmXl6U1rEre2AK2k6f2BLGt4RV4XtotmskFGzcMTy2tlRFNckFyb/DK3kS7+MpXS6vuaB16n5M1q6CoEJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3994

On 09.12.24 09:58, Qichen Qiu wrote:
> The detachstate is used to determine if it is PTHREAD_CREATE_JOINABLE. 
> Since this check has been removed, the retrieval of detachstate seems 
> to be unused.
> 
> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  lib/cobalt/thread.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
> index dee39a8d4..e237e7ba1 100644
> --- a/lib/cobalt/thread.c
> +++ b/lib/cobalt/thread.c
> @@ -129,7 +129,7 @@ int pthread_create_ex(pthread_t *ptid_r,
>  		      const pthread_attr_ex_t *attr_ex,
>  		      void *(*start) (void *), void *arg)
>  {
> -	int inherit, detachstate, ret;
> +	int inherit, ret;
>  	struct pthread_iargs iargs;
>  	struct sched_param param;
>  	struct timespec timeout;
> @@ -167,7 +167,6 @@ int pthread_create_ex(pthread_t *ptid_r,
>  		 */
>  		pthread_attr_setinheritsched(&attr, PTHREAD_INHERIT_SCHED);
>  
> -	pthread_attr_getdetachstate(&attr, &detachstate);
>  	pthread_attr_getpersonality_ex(attr_ex, &iargs.personality);
>  
>  	/*

Thanks, applied this cleanup for a 10 years old commit :)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
