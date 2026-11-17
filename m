Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935749;
	b=5rpSPp+KCUgxxoWudOrAGCi8ymT3ERPwcVDpgza3/o0ol2bpkDkhwi20D00Erlv/nr3J
	 QHz5JX9S8oDh54j5k72SFn9XMc+n5n/liWtfldJHRrrCHnFOXj/91gJJq0c8zIrkDttZF
	 1h52e1InHxeqMacVCufLvWhvmJwOu6TGxhVl8uVX6hhV1WsbHC6jT84bKt9TTcAtGMa07
	 QiB0EjeBAKYU4oGOSD8MgIxSv797hI3D6xtUyi3GAyt8GWQ4NERHy6AZ5sm+f1b1VUmLR
	 ONgq9lDOxPEQwXW8+nmUMOQyLbGtOq4s0DfX5EB0juaChooTu1h98oQYZ3eA0clBb9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=T577isG8RixJhqpC0qvqW6UrfGICtjepNBavF+swu20=;
	b=IaZufGa2GP7pa5fUrO5aLIsAZU5JZqWcdhzbhO0pQBNDkZdCiY7Z3wKe5/kdBYKDIpeN
	 y9iHCYczGoMyZCDDj7d72nmKhUe5xZDwzAmTywB0Ei1jAyM3wrKRVXUrbOAbnfgT1EjXj
	 Qdl7PV2RCvTXFlp62A5IkB4gK/lDXK7Fm7mdFIWgWLsZBqRU2rsDd5Iyt5jJHFrHgOMi5
	 QsaiP2AWekpFYEqdWfFLlMtRRVpQRiip+yikePCsAOmY7cCPhBxeCsoTTptptnDC6yhYM
	 dMfUt0eEjOsu+44yDirXny/by5EDp9//MmCxb411S85Pp2IEfy8NicTOJRzIwnCOgBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="FQ/bFP/S";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.51
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2427606A31C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 17:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2427606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FQ/bFP/S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJjP6rJYiz68eXHR1Bs4mEdm/E7HDvQjcD5XTlq+uUI83TVcWsI22/IEGMtwR3Y9oaPb/Eq0SEBHT8GbjzZ7xD2OektC48HaYzM1rS7qJbZ98mfrKygd9/ng+35uH/DiV07W97uS4y5Wc7w4i8awvqKhllnC0wJfV7xLstKIK1vZcbpSHoBFamWQzVX/3/m6240cuQ2DDqoVm7+b5ldPf9TD+oR04DGsH/1BMSRZ1YOlyDnErTJ0vzyMMt7rm6C5iTb1VHj56kZZ4sz151eySGsH59JTCKFMd+4Brk7cMReo5bBaOUnfHQkbWULsnPqj9I75FkpuZRXq17iYhv4f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T577isG8RixJhqpC0qvqW6UrfGICtjepNBavF+swu20=;
 b=yUHmcw2ZYak5dslWqYX9F01MHJHcMDCg9XfipOrIHU3irndu2VHssrnWhEMZUEeaq+r1DYc3cnI4uee5XU/Rs4JBTjytOQx8ANX+KixYOcCUztBXqvjS3USdjXUN5+nuGlfIybgDSZnWidCc/h8gwe5meKZK6gFrXtix8Tg0zD6s3fqNZNm/gG4h6Q5cuihFgqAbH3EzYEX3ss3zbmQxrG1l7lU19k4hSGLrmfNJk6tKwFbR4WXe3R5oNWHAGc7aJsnskOHliF/auENyFJnnOR//1Rv+4x1JBCuw1HEGt1/OLye83Tcf0XdJx/g+0kQbRkQ8weQYtGlhvitEL0erHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T577isG8RixJhqpC0qvqW6UrfGICtjepNBavF+swu20=;
 b=FQ/bFP/S2Hu8lctGj3tSkxS2xoIzhxtOQ4eiZEwTqWgETM8GpZCn/5EWf6c71JmqQXXBCcGiuvI5Nnq0lVeBxI+nC/2JXv610pIoadzhC94/EVbmaYY2EjKr/T58fUUVwxsqY5bkzvH65uwfcIh5dYQA0D71ueMJfO3k6Q7mNfoWtob+MQwUB80xFumnXBXRmaL95eLiqk4xySwEamvReGA/6smC5FhuHx8XixsqweYuS6bll0pthOA+drA+TZi1GvlMjEBPyIc7c82+8cFgQM2TgBXgVggWTW1QmCUpb58xwZifKHCOUO4++mF9kGmfKZ1oxOLh9fn2tgiv+xbsiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by CPHPR10MB517000.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:380:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 17:15:46 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 17:15:46 +0000
Message-ID: <84d8badf-cf66-4ceb-a87b-e10a40a95e4e@siemens.com>
Date: Tue, 17 Nov 2026 18:15:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261117123925.597027-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:408:f9::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|CPHPR10MB517000:EE_
X-MS-Office365-Filtering-Correlation-Id: b7eb22a3-29cf-450a-c0de-08df44ce6b1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261102123227099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O4V3Twj0URxw7DeAju26JegXCCmwm1iTb6vGj5xXOIveZswq1mu1BTFcYypIf1Wu1bhlGT3lzUB5SuLrIolZRX9HjRckmSoM9azZdpXie/T36xVhn2fyokIeoIdo6tRWLzb/N9e0gpUM0hZvF5119Tj7hBl+qlkG+vKbA9DflAFfk0fvPV0rpBa7HJkDfmVJfoo6qpPdWFWjDVLQ1bOgul9vLfLBxmwLnSzUgLL29J5VP8GAd0aRwjdqkaADW+49iiBHKvIoCyb2NZdXlaZCEBlXvDOPQwrjZto/QWPG86u6SNPefdr7K6HE5pWAejaQ84auNPCwUGcN87cI6GeDqIdrx5x80vzIZH7Pq0tJi54OkCPNx4pM6+hqpexC0QE5UIRzGpQe0EcDtlou8ioCT8l1+lEgalOhmHxPFK/lYR4QDgpJjStnZrgoh6T+qbfIra/b/JTKMoFx4dW5lOOdF1S6fHnfDiI4HW6LbQQMNgJR80o/ysjNyl27pCbU3t9Z+X2SXh3qv4pEgcTYFMQPncHejmjSzW9e9nSR10Xxcfy7rmMITtJGksyn75svVavxZOV2CE5Z7ca/E8Jof1qDeWiMOvRiei9/LX/NHe6b+feGv7mQ7ucMQevKzzjfadeh7QxkTx30tcSDi6MwNdJN4l+TWB6kT4qej8fPZS429FM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RExTRHVyNDNrMjEzcGJ5L2RoRmdlcm42N1VKeGcvZStoUDhYcmpiN003cE82?=
 =?utf-8?B?d2NIK0dTYXVua1lzUlU3eWx5YzVoa004SEFjTWJwejVGcVpla3NhdVNtMEVJ?=
 =?utf-8?B?ZkpTdzEyMTNBd2dYbG1tY2RlNzh2OUx0TllPUXhSUEN6cmNuNzc3d2pibnRK?=
 =?utf-8?B?eUh5Z2IwK3RPQ2NjQzNTRE1jUnJJZFJIbUFRSHFwaTRiZEpYOVF0NXNwQ1BX?=
 =?utf-8?B?dEVPZm1saWExNC9XTzFjRzF6SmxMS244eWVGZnFEYmtiVmV5ZlJVQ0VrUHRO?=
 =?utf-8?B?T2tJeEpYejg5bkQ0N2FGNXl5aE5HaVVVdFZ1enVsNnZ4OHJla2dJd25xVWQ4?=
 =?utf-8?B?VkE2bVNXeEMxL2RCYzJ1cmRTYmw2bUpxV3FYSUQ2a2k5U3FFTS8yMmtTR0Mr?=
 =?utf-8?B?b3d3bWVZWlZMQ0xQcUFPUmVVSXAzdmduOUd3VU9Bcng1b2dDT0dJZS9tYWla?=
 =?utf-8?B?WllXcmFKTDRkL2F3K3pKS1BKQnlYUmdRNHNsYUpUVE5QWWZSUHU4MzZXc2JT?=
 =?utf-8?B?blFHR3FwKysxdzhQUldaOEdBc0ZPbFhRZ0l0U09Bbk4rbGIwNWJFN3EyaStj?=
 =?utf-8?B?UzVFeVl6UUdCaUZzaXljMVVWVmphUnkvQ2NVQ2owcTQrNisvV3pIaE9pcWd4?=
 =?utf-8?B?WUltdzc3NnlNSHFMdGFHUitVTy8wT0JjaHpxQXN5dHRGMXhkZENRTkZreTFE?=
 =?utf-8?B?YVJLQmp6Y1NRNDd6dTZGM0FUTW9QSUhybWdNbTk3N05KcWdwWG1XNENMbElX?=
 =?utf-8?B?NXR0L0pXM2VUOHVLamUwVC9YaGxjb2xaK2c1WDczbDBqNzk3UGI0VlJ4SGdn?=
 =?utf-8?B?bWhnZFhGS1pMWjJIRlMwbW5SdVMwWmQwdmIyc2hyRGM5clRIU0laK0JxN3l6?=
 =?utf-8?B?eGN0SWJzdTBnRWRRa3JCRC9NUlhBNFdkTmFFU3kvRzVRMElRRzRVc2RSL011?=
 =?utf-8?B?WENBL3RmVU1pTjZSRldzWks1N1kxZFg5elMwSjB0ZWJoRGFiZmNBZFhyYTkx?=
 =?utf-8?B?M0hwREcwR2hDREIreVhFWXY0WXVUd3BtYmVKTE0wZHlMQ3lqYmlJcTVTQW1Y?=
 =?utf-8?B?OUVWL3dZWTVsNUdySVAvNTZ5Zm42UGRvNVRERXFLNi94WE8wTU1LY3VSajNX?=
 =?utf-8?B?OG1ENWdFZVBZSm5wQ044RFF2UG1HWE5KYldGUjhUN3h0QVpRV3ZBR0ZBcFFP?=
 =?utf-8?B?Q20yY21oNXlQTVptTFBIMWsvZzNmWFNWbDI0MkVWek5Hb2ZKaXJsQ0FRa1Fw?=
 =?utf-8?B?RUFDcW5vWko4U3JGbktCcmFLdUtYMVZBMWJiYWs1OWRUNnpCU2hJWTNxNVM1?=
 =?utf-8?B?eUk2SENPYlMxRmZwamp4bGNTM0daS0psOXY3QkNmNXNGR3R2MUlvVDZpSWxD?=
 =?utf-8?B?WEgvZFc0Z1RyRWVaYlhIcWtEUzNxL1VqSVkrdUhzQzdpeTVBVmV1U1pZRFBY?=
 =?utf-8?B?bXZIMzAzRkdTS29XM0FjdVFxaHY3TkJUSVJJT0NaS0Y0WXZiRXVRbWVVR0ZR?=
 =?utf-8?B?SFU2NVlRSkRYRFRaVWxxNmEvbjRCdVhNWmxnSmFzdFFYcWdocDBERHNpMDI0?=
 =?utf-8?B?UVI5Um84endlT0RrbDdDamVZTk8yOS9kb2VGaGZRN1dUeHpFRXBMSDBCcVRV?=
 =?utf-8?B?bVJsL2JjUFk3eXdIOHdjcGFaWkhDM2twUzVoMVJoQXhGTzVCeXdraFlPT3Fv?=
 =?utf-8?B?ZnhldTM5clBIQS94aGhLdTNab2p1ck1xSTBUbmtRSlQ0M0JCd3UzUWFHSlBO?=
 =?utf-8?B?NEgxRlU2Nkhac0pMcFBvTVMrYTdnd1RFeXlwRzBsZnRlbkFYandac0oySktM?=
 =?utf-8?B?SkNVbUM4aVEvT0RoK2dMS2RrZS9vVnRlNFFDZXVReXd5OVpPZEdnNTdsM3J3?=
 =?utf-8?B?M3E3SGlBbUZjOFMrbzNCdU11b3dYaXp0ZmgzSEV6MGtndU9oRmpiOUZVODI3?=
 =?utf-8?B?SWp1UDMrTEhvT2R1eGZsTG5zbkhmZmhLR1VuditFbGhNZGdSL2ZxZ2dBNzZN?=
 =?utf-8?B?NmxSNFhFVHFUSGxOcS82T21PYjJwOC9yRmVkcUJFMUt4clZ5RkNlLzBJSFIz?=
 =?utf-8?B?cHh0VE5jaGx1OHNiVDhSemFacGFXaGxTekpHcEFWQnBwdC9IYy9WZHkrekpz?=
 =?utf-8?B?UUI4Mzk3UHMzckE2VS8xVXlFN3Fza3ZQSzAzQ0xoWXRWbEZRM0NTNTRSZGRF?=
 =?utf-8?B?a1oyRGVZczRMdVI2alkzQWdKK1ppVEFSVyttSE54VlFqZDJhYTUveWF5VWVR?=
 =?utf-8?B?RHV0WGRzT1hSYytFaFRDQWNqOUlQM2RicU5xOEIrTjIwRTdHM21oU3paYmFl?=
 =?utf-8?B?cVBYOUp4T1RMbi9NbVVFem4yVGs1TVJLZlZtRkRySnZ6V293cFphUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eb22a3-29cf-450a-c0de-08df44ce6b1d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:46.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taM7CxiW4n4rIhrxbyeY8KdzzbiKZ86gZgu+bWH0+MX9oshwE2TdVlIy5pT7Qttu7c/6C947u6jHIVQKStrnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR10MB517000

On 17.11.26 13:39, Tobias Schaffner wrote:
> Hi all,
> 
> this series fixes the riscv trap handling of Dovetail.
> 
> Thanks to Jan for sharing his AI reviews on this which made me have
> a look at this.
> 
> The bugs were verified by running a trap matrix test, which raises
> every kind of trap from an out-of-band EVL thread, with a more detailed
> oob_trap RV monitor from the Dovetail RV RFC enabled.
> 
> Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
> test, the libevl suite and kprobe tests hitting out-of-band syscalls,
> IRQ handlers and nested faults all pass with a clean kernel log and no
> monitor reaction. Reverting the fixes one at a time reproduces each
> bug except the last one.

Did you also ask the AI to review you patches? I may come back with "all
fine, but I found 5 other bugs" :). Still, this can be worth it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
