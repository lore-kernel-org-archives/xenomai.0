Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFA7260D
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872060; cv=fail; b=cFLUH3UNrmkaWNpICbsuJZ4yaJIqsuR+6u/OJe7QHJP8nOap+kWjHB8pi5l0K28oX+FzptZAEiynTbVfHdtCm1vxhylwonz4xA6j8QqoJqeXpvKgS4W46VhIecrsqCAqQC8dO9uLA8WahiuJ1dg7h5dMnx1crgyzFLwdklVPSOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872060; c=relaxed/simple;
	bh=tMolhaMWzokfpvtAa1pqSpFa13LmM4umxGlfQPwbBFQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dh9S9KO9ibgWCMDSv6qmmmtGMRGrMvf1NDGUVc7LCjcZ2tDjAS84+eSAKQFd8yMUyAC8RoRMjqZ0wiWEJKgybDqN0/aR3D65Yl277cYRngsO+cWGe0KixeDj+r7nwJp8I4AISIXM7qB4Z4gSOTQJzh2xnwWjVTGeGzS2MDLCcFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xkySmtUq; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xkySmtUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuUH8hyA6hTedw13brMAq5z/lmRf6K9HieaRCzT/7leLgl4qVq7vUVT6kZlnaMC/5n1Ik3j0aHzc34cu+/Q7JZUMZvqDCt9xIH7NJXsARYXILM+0C70Ibjjr6hHEJLt160Vh8w2gWFybYnkNHEnpE/rCX1AEJ6KPGohY/QIKcFySBMDrFkU/TpQjCBPYxdSXoJVyKSSOaH0HMbEBda/kjg6f0xRmvaR40ijkDRSCnjJpIMyPMmbyEu7b9dt6wtdMqyxYFi1/iZo+kviinqaUscbRpXryKjuzo708w63R63kRnXmq0ruKMGoYmjvWCeLtDJ1IiZzY1nrY5W6KaMoxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcFAS0vTLPpmcEt5V89m3cwWBDWqvQiYKdEO4Sal6mU=;
 b=fPtnEqVUZW3flfYJDerZ0C6YlHYebARU7qjHq4IYeczW6xrnHUjhvTMPtRVFHAqIgxa/L7r8jUYSy7Fr1ebxVoO1sEbIVMVNZ0V8y+sd02vCZD3gN43cVWhze5Koerhm5uL2Peeoz+xqrXhCS5zgmIfwomF6PjxEdZ9BJ7w19vk8huMAZ+12gLrlRqhQyvOK26AXxCVc/YeGc1d7d9Qq71590sKz9Yed5piDbI/DsJv/SVCpkmhJfK6o0KSZGd03cfu0B1scysgFtZ+pYNbeMTxtaVW0BkwrPqzn6By9Hkr953ewQfrL5fWqhsSpKv0zRMgmLq6wENNwsW42CKpskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcFAS0vTLPpmcEt5V89m3cwWBDWqvQiYKdEO4Sal6mU=;
 b=xkySmtUqodAuvJVusDNhQNI7GzaErtKBTlEh/836PtFVRZZu7i9NjksZeCYrIwgzzjzZNwbNAzAqydMMi8HHyKvPkEYl9tgf71kOZQeuvZfJYj1TOyAZKPqE9BWIzFpWBjqpYyD+mRbFPmgyBYjrXjCMuHO5skMTWQ1cq1j5BoALydyRVtNy5pEZx0ESc8jhWyYROtU0ZO0FDefH/1xicc9HKzzoczA7U7cn4WyIIZa373T9N/ml2RiCpdXVNwK6lHSWWQ/3F6bO3pt49NebQ5IEFF+UgpodJDN0XT/Isq3xk6+utq1cx0qZcqnHVk+so0X8Fl5G7Q/vTak5ndxHsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 14:14:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 14:14:13 +0000
Message-ID: <43e42f60-e923-490d-809d-b0e35d4743d2@siemens.com>
Date: Fri, 22 Aug 2025 16:14:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
 <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba08c53-c795-4695-8964-08dde1862bff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vis1U1hRZ0UydEhWTmtUeTUrN2ozY1pzcFNuR3hvT0JnWHdTckV3YnVraXFB?=
 =?utf-8?B?dnRBSVZJYlVHaVVya1dYWHAzZzVIMEZ5SnhIZldyNmRabjNZYmc5QlU2ZDhn?=
 =?utf-8?B?YXFrSWN6MUNFUTY3dzFCODgxZTgyMklHa0c4UXZEMkZOSmh4RTR3djlkSnRX?=
 =?utf-8?B?S3pOaEFmNWhicHlGRG1zNkF2R1JzdlpZTkNLcmxJbi9UNGVLamtuRDZqZDk3?=
 =?utf-8?B?cmRRcndCVWkxVUh0OUZYcStsdHRiN3g1VnpUTXlwY2h4NXpuZlplc3Y4bi9t?=
 =?utf-8?B?R3djZno1OXhhUWpXMWlrUGtIdzdKY3NmK1d1YkNRWjdDNitjd05JQXhscENr?=
 =?utf-8?B?NVFLZGR3aWVBYzRYdWdsd0xyaHhNNHh4Y3QxaDJMNEdYYjRHR2gzY1JId01r?=
 =?utf-8?B?TXdtRVlPRERvaS9xUnFBK3BvdnFpVVk4dlVXamZFeVExSFhFdGVIOVBUOFFG?=
 =?utf-8?B?enJWMFM2bU9hQXcwSzFGSHo2QXBBU0g1emREdTdHenpka1VhZjgzL3hEbzN5?=
 =?utf-8?B?Y0JkNit1T3RrZGFtR2RPTTBPYk03cHpGZjh2T3didTFHSldzK2tBQnlkVVk1?=
 =?utf-8?B?aXZVbEVGYlBSbnNjYld1R3A2Ri9tbTd0WGZtVzRQbFBONEhGbkZGTkNxV3Mz?=
 =?utf-8?B?SERQNkxjWHhJQ1JkU2Z5YzNNNk1mLzUrTFNSNW1FZTZLMVZDdUtsaDRZbVIv?=
 =?utf-8?B?cHhqa2JHdHJmNUVFeVh0ZTRHUk1JVFhtN0t2S2w3N2pjdnRGcC9DdkhydW5z?=
 =?utf-8?B?NjZpUzJkaWtZMi8yL0VVZXZCRjYxN0xsNU4vZkVvTzJnWkpzMEpnaEFaVG92?=
 =?utf-8?B?cExpakg5K1RxUnh1M2d2M0RCMTVkVEVuMUR0VWFMeWtUdmRSenpRQzZuNG5M?=
 =?utf-8?B?aUZRTG9XSGFtbjZ1ZmlMTlR3UGJKd0ltTXh4ZTZNV1FtenFMYWpFMDl2eXN6?=
 =?utf-8?B?U0pjaDE4MnRTUE9lY29hd2c5YmJVcnF6dnk1OXAwYkx3VmtBdUtVUGRnSyt2?=
 =?utf-8?B?cGNkY0F6NXlycGQ5UWo2WVY2NDByQ1UzWE5yUXFlWmVkVVlpZUdybVRuT0Fj?=
 =?utf-8?B?TW5KNXgreEhvWkhlRitNYUNDK1hraURHSndmTjFYdWZ1T2FvUHU0VTJSV0l6?=
 =?utf-8?B?OWdPMVZtYkttMjJrRU0zZXVqYnNSTzEybG9uSFlISmZDcWFUVDk3Yk1WcGZi?=
 =?utf-8?B?VTZZR2toYkNDS2VzZW1ZU0g0azFoR2FzZTg5ZkRJU1hmWFR4a3RkWUoza3By?=
 =?utf-8?B?L0wzRGZ4UDhHM3UyQjNKdk5aTU5XdHd4aktUc0F2TjVXNWlpK2RvbTNneE5K?=
 =?utf-8?B?TmdtQTVhTnlFZERBbEVvdTZ6eHVHZVZmNnlQRU5aRTl4aDNXVVVGZU93Q0VI?=
 =?utf-8?B?MjNVSG9HZXIrOFFHTWF5d2hVeUJpUlFJMTZzQmRIV0IzaGJIUnJ0TWhFMHhW?=
 =?utf-8?B?RzArVTJaY3FRdG5WVWp0d1FRbUVVZlFNOG1aWkYwcU85OVZVemJFUzA4bGpD?=
 =?utf-8?B?bTR4WjhSSWZVRW9kNFN1dUx5TTN3OWJLT0pTTlFmUzljL0pBVWVDZktiTFA3?=
 =?utf-8?B?aXBlcjI3cWVRMUEwSnNYS3VzNFJGVlo1Z2tVSGUxSnQ2VjU3V29nZ0djRFFO?=
 =?utf-8?B?N09sOHZGSkE2Q21qaFc4dzIxdmRJZVBQWHU0SnZydjJnTlhsT2ZUOXBsSEZY?=
 =?utf-8?B?b0g1bStIemFyaGxNZFdHREJHekpIZGZuM0x2WHdneHBIb0VSZWdsN1FlRHlk?=
 =?utf-8?B?enBnVWNmak9makNKU2V4WWZJU1JUNy8vYUloazQ0aVk1Unp5UElUbmRZbEEv?=
 =?utf-8?B?dUdlV0ZYK2QvdmEyR0dVeHRuR2ZCTEl2anZLdEk1WUtkRU50cDI0OExXSEc0?=
 =?utf-8?B?ZmRucHlrUzRIRzQzdFcwOTJzWVoyeURnbHowUTRyN3IxVkNxdDRZeU9NOG5H?=
 =?utf-8?Q?0k5iq8lQG0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBSTXkrQzFUby9qOFd0UzdYTVlqSGxEMzlmbjNEWU1JaHR3NkgxY245eldL?=
 =?utf-8?B?a1hHSmRibG9xS2dKM0xNZkFicnNud0dmaW1hckhDMmI3YWVZbnEvaFJxcDBB?=
 =?utf-8?B?R1RqQWl2K1NFSFhDY2orQ3owUnJlVHZQWVFpaXJlYjIrSFJIT0kvK0o3VW5C?=
 =?utf-8?B?d1pXTXZrRHdoZjlWcFhNNllJNHhXbG9pTjdzdVFCL09mWWNmNXkzMmNMOHRm?=
 =?utf-8?B?VW5qUXNNUWIyY09XZzQ0bWp0YVNvZElDdXFlMW9aN1Mvb0RkajQrdGpiT29s?=
 =?utf-8?B?ZU9FeW1oMHRqMi9QaXpSbThXWXZHZ2ZMeWVaMVVPbVc1NEtoSFBXUERGdzN4?=
 =?utf-8?B?UTZWYzdRbnJSNWVkQS9EOThrbnYyeTFhMFpOYlRpV2JvVGM1QWlCL0laRkFS?=
 =?utf-8?B?eitsTndNUU5jcFN5aVZMdS9NT29NZkpvb0VyTDFoYkhwMHhLWTZqWWNzaTd3?=
 =?utf-8?B?clM4SFRWbGJXbHpIVHlaY3IzZWY1VFI0VXRkTTdMUzhPUlJEQTQzNUF0UWFD?=
 =?utf-8?B?b2Rqekh0eGxROFFtYmZqUUZ1MC9wQ0xhdHRCSnZNdnhzMVNQVXY4M1NySXBS?=
 =?utf-8?B?dFdqVHhjKzdPT0NVelZ2ZHN4YmtyWDVCYy9ZaWt6V0F0bW00Z3MzM0lUTWJ6?=
 =?utf-8?B?dklTSXpzam0zSk5YU1ZzTHYwZElZWUlMMkxuYVc5VzdEdmVXU2RsRmRNNUZh?=
 =?utf-8?B?OGZ3RHpPSDc0RHdkbjBSS3RYYlQvOGRBZnNZS2NUaEw5di9jSzJTeXo5SUdQ?=
 =?utf-8?B?L1pHSGh6TGJwdHZXODNBRmFDbUFWanhPSTJvNktEcjV4dlZVTHNFTzVtV28y?=
 =?utf-8?B?N25xVW44S1FOdTdJajBsbWFuRlc4UzF4Y2NuQk53bXBjV3YybXZLTG5HdFIz?=
 =?utf-8?B?cW1yRWhiOGc5eHBvbE9YcGovR21SMElZZmVUMG5CZGNiRTI1L2NRN3BIdHhr?=
 =?utf-8?B?STIrLzVicldpMXg1enRxaThDaDM5NEo3c1MzeTFtbGxDMUs3d2JteFREWFc2?=
 =?utf-8?B?Nk5ab3VpOUFNMU9GWEpBQkJrd1U0U25qMjRHVmdwM1JNU1JwSjdFZno0QndD?=
 =?utf-8?B?aStwUE5yQmtDM2NzT25HMlhxWFFqekEwMkRUaG10aEdlZ2RYRVhXajBWaVpC?=
 =?utf-8?B?TmRseTYzRzV2WDJsZW1rbGJRMkFSQjFTUGxWZ3FBMmRRbkNmc3Y2TkE2NXZJ?=
 =?utf-8?B?N2J3Y01ITTlsMGswM2VhS3hDdU9kdHUxUkxVOFFTRjI2N2NBZHBRZ2dob2tz?=
 =?utf-8?B?QzlldE8yeDVWcitKZ1RPTTQrTG90NVJYRk91VUxoeTRLTllydmRaYlpBTm5G?=
 =?utf-8?B?TUZFOGIxb3B5OFd6ME9yL0g1REliRFh4TUZxemM1V1ZLNWU3WlZQRjdpb2Za?=
 =?utf-8?B?SDBDWkZKeS9ha0ZsN2VuWlJqaUhoajBpMXdlckJFWTZSSmtRSjlzbWVYVFdL?=
 =?utf-8?B?cmxucnZ6VFBVUTdDc1ZqU1RoZzVFWkxWWnNsR3dsVlVGdzFjaGRxQ1YvVm9O?=
 =?utf-8?B?Vk9VQ0xidTlYWDdrUlk4RkRialRqT2QzRGd5RGJiZ3VHMVViVnVjOVlxYjZt?=
 =?utf-8?B?SVVRSGc1akFNeVgzbDJBUkVsa1NRSDlOSVZMZkVQU2Z5Q2ZwUkZ0SnVFNXVO?=
 =?utf-8?B?NWRqTU8zVE9abGFYYm9oNWUrdTJ2TFZVSmZNRWZyNkUvelVVRzVvMGJqVGs4?=
 =?utf-8?B?SkdqOTJCYTJIZFNpbzA4QmRMeWQ0NHFnc0tHYnI1TzRsSkkwMERJZjZ3TS8x?=
 =?utf-8?B?TTB3UFYyZzVoWTJBWXYySHZrcHY3NzYybUxwWUNjNzY1ZG1ZaVpLZnRhbHVX?=
 =?utf-8?B?bWtZbllDdDA0dU9sbGpRV3JaWnFUOWk3ek9XT1QxZlIwb0ZZbkU4aEtiWjhQ?=
 =?utf-8?B?U2tzN0E3U013S2VHNVJmcmhhUnVPckFjTzlqSmFTaFdxZWU3SDZDUGhVd21E?=
 =?utf-8?B?bVlXcUM2MlhMeHRoTTVSZXlseG55K3o3ek40SzFaTVdtWHdmWWdraGtRMGM1?=
 =?utf-8?B?VVlTYXNkeG11K2poUDJHWDViVHdFOTZmVGZocUlUeXk5K1FRSFdudGwxTTBF?=
 =?utf-8?B?bHRxN0RQclhNcDgvV3dwQUVyZjJNYnBhYzZpaHpNSHhQaGZPWlVhZlZ1M3hS?=
 =?utf-8?B?ODBKbUx0UUFrWkF4VVhDMTRQSGxjbW9DcXpDUFJveDZVOWdEd3YzZ3Mrc01i?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba08c53-c795-4695-8964-08dde1862bff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:14:13.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr3RfdhFt7JWTJNLQ1dwKYmRHg/39wP/OvrippXb6Ikm0nkqbY5Vd9fyAMzv9y2lD20oXbAWH3vWnTYQwkUFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6603

On 18.08.25 11:15, Richard Weinberger wrote:
> On Wed, Jul 9, 2025 at 4:55 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>
>> Like last year, I expect that some members of the Xenomai community
>> will be attending
>> the upcoming Open Source Summit in Amsterdam. If there's enough interest,
>> we could arrange an in-person community meeting at a local beer
>> garden?
> 
> Finding a place was more work than expected.
> But here it is:
> When: to start at 19:00 after the booth crawl

Just to be clear: that is Tuesday, August 26.

Jan

> Where:  d'Overkant (Scheldestraat 101-105, 1078 GJ Amsterdam,
> Netherlands), about 7 minute walk from OSS Europe venue
> 
> See you there!
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
