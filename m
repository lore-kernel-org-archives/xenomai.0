Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0145387599
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852439; cv=fail; b=giuEl2rpYd976ND2+HKWyEWx/obUyjlJG8tvQachd2NpUBD6NbbzRtAcEh9XLJo0fUTYPley+M8rTR9jItyp2BTZJGbs3dGs/7w3od6rsafdxR/Svdy6t/TsgFBQqjwTC+fmi28jUNPInM+kPETfIoeke5KHrVTjTm0TWU+r2HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852439; c=relaxed/simple;
	bh=pBo4I9pi9p13bhRnnORj1Ea2ZvuaUG1WD5OBbsUR6cY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYgKF3N1v0ysDlAInrJMNM6Sa5rPwDf0hAHofsLN+2cu/pb9Y/M2EK59stQfPs4tfjABFE9mQgh5M8X1KhgTOLc0LR+hh3o4qJx4JxeuxCogJfRZKbrriNqUO8FgjMloLkw/fA/WKtyrwmHpB2usmz2ZukjRTBvyuDa3JsK1HXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kUuEq0+i; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kUuEq0+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXGlLQC0ygDGOccT44K7wHzhm1FhB1gcAhSSqmKzZcA34bzueVHxxo8Tz8rAV4W8JgHHlCTbFeCjFhMWjypBpC3rkansJKF0wzYbstiNZ09YiiRrcsz/ywZluDMlMndHTfBH8wFEQBxm4CAzBCEpLdqnRMQIP5Y0piOZZtgThGFyt1m6YQVlR4Mnquhsi8/Zke/x78EDN20gX2WAWz2aEvV4WtzoQQa0jc/prWLeV1XD9Rp9U/2ibBiqe9v9Zvp+KKM4TsNGVZqQnvl1U8Grf2MzMeEnvmNa6J//6XvFOW6Es3bK3VN0fun8Vf49YtQX4I/zqxTBMDAoLsT1axRkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZcroNSJusvU5qORdnCudz73dxo8Ehy3PLg1+wrMFpk=;
 b=rzAl5zhDve79YmmAmL9EThNsD9qSywmsJ5OaIUZPCZc5i55dREq9OXYoS4t6QINulWse8m/7hNIxAZvKBNOFEyvwGt6Azm10Mp7DiNzXpxsyCRO71BYQqG2b4BBK/YN9iGgYE6PsCvVa6Ybo19Mutvawctu8K74KIn7FNOUJPjTIuMknNAi2KlixRte1INb6Al4QjUGUW83dQqXRsCi7ZJh2GwGPkPeXf/GhNX4xMqaL12Bqj2059AQHR+BZ5+VbnJBKVOnbueDq+tRnaX5u2dbLwlAcwitMxyPtizh+FWlAFuLPa4yx5Is9o1yVVw4ptnKb3rvc+V8fofuKxKk4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZcroNSJusvU5qORdnCudz73dxo8Ehy3PLg1+wrMFpk=;
 b=kUuEq0+isL9XcWS0ZEh/sjAtMpRFInbe2gWqgJQkRQkoZf76L8ChdZsPOyCZQjjVdVM7LWt8zDcjwk27ctZ7U7e2XpCkhxeawg9bV1faL13LDGjH+1pV5lgXgmCsXRtTGOg4ay5ED72jSmY71VVkneR4ypBiEgaHC3odz1DX/W+Vo1kAeHBj8oQg1AJfsaRrO29ufh5+HK4XCkOslQYkOF6/6B+u9Gx/EE2CnHCqiuNTcOe0j+TlRhXxAkISCN/pQ9qVq3VMvBg7vaj51VQaix9sKTKEU+2yXpylKlcSDvZTLYFJiypyjxoUJ/aZTO8YLexjTSr8TFkeY0qUMd5Zog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AS1PR10MB7935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:27:12 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 07:27:11 +0000
Message-ID: <d508985c-bd9f-4e66-aaf5-5645e5a4f9dd@siemens.com>
Date: Tue, 8 Sep 2026 09:27:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: Fix a2x warning for PDF builds
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <20260903083447.2220024-2-clara.kowalsky@siemens.com>
 <308d85c3-7e7f-40f1-8755-5a99b25d0015@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <308d85c3-7e7f-40f1-8755-5a99b25d0015@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AS1PR10MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: da87ff4a-8cf4-4327-8477-08df0d7a98af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|55112099003|56012099006|5023799004|11063799006|4143699003|10067099003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	n+w/BTZ3f1eVlJxhPqtIy748fjVKHGj3Qg/hyPPnsKVokcGBXUXdf4u/MF2QgS+77m4GadfskFE2x2VdO5wT06sU9pDMPl6EMC4emultx004PAMYODMeDhi+WZvxQrpf4KtB5ZP9JmUFJhdACHs/hPewDP5yRWZ39KF0+vzXlzH9Lo1bvpefSyQ5ePC+XBbvJfaTE8MQBKvCVFguo/LnjOT7bvZ0pZ/2PBfrjZs+XewrPLVle2Z5B5bkTwGZ9Kp5lFwmfM1Z6n+OItFdURBkKrWrNm8hcpteG70/dgl7T0l01z7/05u20N+uBKue8NQ++DQT4lFWOU4iDKS9eWITEqYTxu7J6aEm2j+3/e7pRbq513EOK9/KT+HhFr5WtNbNY97nyDCK9w4jcSsuomv8Fj0ddfrVD24/O7d5j9OCzIjS0JE3mE2i8UTt5O0Y3KkmotYyUoq4v1M+wH+vCNhUxbQs9e9Idw12h52y0axdtRth6BhE6QhuLn4JnnNygA5MBQqprwfTjekn9gV85jkVXFSiac7qCXlBZseQrupL1N96jjBuzq0+Q6/p+4Z/MdKhJTFFpVCul1+tFv148fn7eo1n0upaeBSs/D93mhi/eHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(4133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0pzem5KaGZ4clRXclMzTnhSbEttdmxOWHNBZFlOWjJRQ3M4ckxYTHFjZW9v?=
 =?utf-8?B?NDdqRmdVK2k1WjBGbkNZNzAxR1RpUnRPVXhLMVF4S2tpMGsvMTBodStZM0NH?=
 =?utf-8?B?ZWdQOGFGK2E3aWhpUUpzRGMyZmpFeFEzM2ZUeFRlL05Hd0YzU2NJMzhUMXRT?=
 =?utf-8?B?bzNXWFZGZkVKQ0tLRng1N2x6RW9OK2NLM0dRTEZORUs3M0FUY1M0eitIUTVu?=
 =?utf-8?B?TUtSWDR5ei85S29UeFprMGlNUVQrSXo3SGhwTVhxaXIzZkhBUklBdWo1ajlm?=
 =?utf-8?B?dUg2SGZiKzE0L0x6R3l5OVRvZTc1dU5JYUw1VnRpNW9NV05EMHgzZEdydlJN?=
 =?utf-8?B?L05IdnNURXl6RTFBbTFCL2tXVkNYYUl4bmIzc0hYSGsxMm9MUnc2UGZXWjJJ?=
 =?utf-8?B?TXJIMHN0ZUhkNm9CeW0wY0FRWUtwUkxycU1UbTlmWXB1OUN6cWVhU1pLWGdn?=
 =?utf-8?B?VXA2ZlNuUWkydnZpcnU4d0ZNZ1NsMkNKU2JNL3E4YUI3ZHVDMFhONVBYR0xu?=
 =?utf-8?B?T1ZTM2xrTnpWdGpnYlowa2NyVHdMYlIrYWFxTkdNY3VyaFVNN1c3aVpocCtN?=
 =?utf-8?B?L0FvbTY1L2lOZlVkbEVyQ1ZPNWJRYlI0QVI4QzN1bUNnenpndmgzWnY0d3Vn?=
 =?utf-8?B?NldhbmVzSjUxL3ZEcDl6eCtYdnJKYlRranhkQVZEQ2hBNGZPbmlLUTdMdENH?=
 =?utf-8?B?b0E3NHZOWFBocEgvOWdiWURJd09UUzRjdEdFa1hPZFBobzVuS1VmNkxEQUJl?=
 =?utf-8?B?cXRzdnUvelAyK2hyRk1CYWl5Q2lnODdDSWRzZmdLczBTcXNsREdYNnNoMFpK?=
 =?utf-8?B?SDNoTTloeHZILzAwSm5ENS95TlkyY2RSNVZDRjJaSFJnekJnV3FhSldQQTNv?=
 =?utf-8?B?U0NpbWdvak9mZ3lvRGxtRk9JVyt2T3pUSzhFTU01NG5FVStGaTJhOElkTG5t?=
 =?utf-8?B?VUlRVTAyZXBrWjM5MXJIc3c3YXRXLzhLTzg2TUt2STVvZFJpejB1ZDZWcFkw?=
 =?utf-8?B?MEVrUmJpNmZ4a1k3bXdvMzE4aGRZVnFoNEU2NWhjZUx5Y3BkQzdmb3kzeG95?=
 =?utf-8?B?VkxiYUl1bm5hZ05hUnc0NitlZ1A1WjZVZTJlZUxhK2w5V3NHWVN5ZEJUSkgw?=
 =?utf-8?B?aDhodTFBdXpHNEhNZWNwT204ZHExZ3NQNkdoWDlNNW5TNHRkS2pVUFpPYmd1?=
 =?utf-8?B?dmhnMWx5VkZleXhFZThsc24vRkZCRUNWSDNaamxWQnBmQnFkOUwrSzFTdUIw?=
 =?utf-8?B?VzZiUEhmMTB4R2FVVWtLQVVQWUVDL2xPcTVsSVM4SkxHWG1uTUdsSWJVaWpM?=
 =?utf-8?B?bWtYZHplOVNFMXZNMjJZYUxicGRERjZjaE5rVXVlem5LV1RETW05dlZLdDhv?=
 =?utf-8?B?SEhneEJicFN1TVBtejVUTVJjMG8rVVZDSnBLU2IyN0dsS0NsTXhqdkk3NWU1?=
 =?utf-8?B?WWVnNWljTmlsYXpyV2E0dGVERFZONGhvbEdtS2g3aFc5QWxtOERaOWs3bHgz?=
 =?utf-8?B?N2Q4dWcvSTU1UjZqUTN4VEk5SnMvdGlxSkZSMjV3QUQ3L1JoZFZKRStsd0kw?=
 =?utf-8?B?Vkx1blpWWTJTVkNQN3BDN1lVMW1zdmFwYzR2RWVkc2FyRnlWYW0xbVJSN3dr?=
 =?utf-8?B?TGxFTGpNWkhCN2M2b2VBajVCT3VDNkh0YmgxaFRnRDlMVVRQRWpVY3l1dC9j?=
 =?utf-8?B?eis1ZUtOekcvOUNZMWdzUlIwdkFkdzFFN0dnTUF0UVBqWEdid0RILzlrSUZ6?=
 =?utf-8?B?TFJSa29Rd0p3ZS8yU1ZlOXZyYzJoQ25mcFVVMEx3eHlIcnlyUUNsY2I1dHBq?=
 =?utf-8?B?cVVNTEt6cHVKbE0wZDBNUTU0dGZaOFV5Y1BPYlJQRXQvelFpbjMwRHQwdktI?=
 =?utf-8?B?SXBxbXIvamlzcldPZ0tyOFZCb0NsWWNJMm00MHJCbU5hMURiWGJUVHBpWTQ2?=
 =?utf-8?B?d3AzUXNudjd0VkI0azJOLzlReVcvRDVWVzdsbmFpOFZCMEMxcklLNmwzYURL?=
 =?utf-8?B?bit2VVNXMkNDRExHNWlSOWlBdUl3UG1PMG1uWU1xZ2ExSjZHNndMV01IVFkr?=
 =?utf-8?B?N2dvZG55ZDRFcFg2NVRrbjRpa1Fnc1NxWEQrYzZiMi9uRnBsd3dhTVEvbjZj?=
 =?utf-8?B?dHcvU1p4UmxyaFZCOHE5ZTFwMEZhL1o0ckRpYW0vdWUzUytVWml6Rm1TQ0lT?=
 =?utf-8?B?K1FNRnZrUGxXdnkrWHFnWkRsMndDRkVYYVlEL0ZmTGZNVjFlby9nNmx5V3FB?=
 =?utf-8?B?d2FxcEJFZTlqNUpSYWF5ejgzYXpyNE93Ym40eEhnZXJib3lrYnVNdUMwQnIv?=
 =?utf-8?B?ZnJCMDJNalNVTWc0NkkxT3NRYXZETVltVnlXMnBTQkV3QXg0WGY0YUt1UHdX?=
 =?utf-8?Q?cgaieNCBmLXPZt+o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da87ff4a-8cf4-4327-8477-08df0d7a98af
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:27:10.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VbDpCS3NXGvgVgB3fF/c7cS1e8ZmuqNHHCEW1TGtppU0XTdVYHtFw6PFMrcJSfRSf1j/EskWa4UOJMiGSvaQmhgJie+Bs7p6JmHOXvps24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7935



On 9/7/26 16:22, Jan Kiszka wrote:
> On 03.09.26 10:34, Clara Kowalsky wrote:
>> The documentation PDF build passes "-D" to a2x, raising warnings such
>> as
>>
>> a2x: WARNING: --destination-dir option is only applicable to HTML and manpage based outputs
>>
>> Drop the unsupported option for PDF builds.
>> See #18.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   doc/asciidoc/Makefile.am | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
>> index 782c7a23f..669decaeb 100644
>> --- a/doc/asciidoc/Makefile.am
>> +++ b/doc/asciidoc/Makefile.am
>> @@ -91,7 +91,7 @@ html/%: %.adoc Makefile
>>   	$(A2X) -f manpage -D man1 $(ASCIIDOC_MAN_OPTS) $<
>>   
>>   %.pdf: %.adoc Makefile
>> -	$(A2X) -f pdf -D . $(ASCIIDOC_PDF_OPTS) $<
>> +	$(A2X) -f pdf $(ASCIIDOC_PDF_OPTS) $<
>>   
>>   $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
>>   	@$(mkdir_p) $(tmpdir)
> 
> Could it be that this did have some side effects? My pipeline is red
> because of missing .pdf files:
> 
> https://gitlab.com/Xenomai/xenomai3/xenomai-doc/-/jobs/16348492423
> 
> Jan
> 
Yes. When omitting the -D destination dir, the pdf is placed in the 
source dir where the .adoc is located.
https://linux.die.net/man/1/a2x

build/doc/asciidoc$ a2x -f pdf -a icons -a toc -a toclevels=3 -a 
xenover=3.3 ../../../doc/asciidoc/MIGRATION.adoc

When using "-D .", the warning is printed that the option is not 
supported for pdf outputs, but it actually places the .pdf into the 
wanted directory.

As we want the pdfs generated in the build dir, let's omit the commit 
and live with the warning.

Clara
