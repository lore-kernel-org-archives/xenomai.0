Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5453BCD2E
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433142; cv=fail; b=WdgCF9CbNWjXQBdSGZhi/6AnlXxwyWw1l0zj5/sDX+h4Ppcdqlepb4YmXePGbFNTiz7NGJEM1DbboVxrooixGCF3GRSOMsMg6YbPmWBp8yL4Q15fDw68cgh/uXoWkY2hmGu81SOegyBKWtQsFK+r6q4+8yN7ldNFQ5xJ6GLN/ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433142; c=relaxed/simple;
	bh=gDkoqqAPoQzQYY7kRF0MD7Qwa7BjQwEl+TVGXJ4DgwM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNoFRkjdDlK4UPMG6TKmtcYgsaeXQ8DG/LN/eUoC2JN4VQntoNp8knLG43qG1AcaF83JqsppLeTLVsn84YskSyW0+NhaUPSgwPT+ZRQUs/kysrqOjxpcPjdTJ4cnrUHSzpicnyj3rKKRIguE8Tm1DriCdH1ei30gHtiVChbKNIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uASd1+UW; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uASd1+UW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLwRUNQgyQOjj8n7AJP0TwYxzdp8DsM52AE5lqpB2BJMzx4EEzgWHZpvM4VRBg+QiPORxVOE3PR30hmFY1IKn7+lCCrzwgUfHJLwPx8UWGe3+RukrZJDvsqS/xYmW2Ege/t+SG6UQUhgK9vlBlWcSDQO3S2PYlXnZqoXdvQXNrytlvXwP8kYzti6xJCSME1ZKaPrqE2NWdyrxNxTTyFzflk6MbxToQi7QEh5imT6DLWrBH2QRmnTQIC3zIsX4ak3IFdpF4Vr6ipIvBoQ3tosdBg2x3thc03HxMzz7RyIs+8MnCFsP61ihPb5tLYi1hy+aeFn654vK/wMfSD1w7Rikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frbHZzo1uDSd1pQ6UmdFCLNEm34PjUpFRqs+eOqh6Oo=;
 b=P99GG271uQh0AD89wEfBY7lPzUGytaEIhnUafAptp7Ao9YILOWY5/qZxphIespTyZd47rRWFpuXy1CqvGqezlFVDVYgjesHTL9+6jIrqyLD6mlKqRSWzshmHgPFU2B7TvJh5dTdYwlyTMCSM93jRXXG005CDBANdyIrTJEdxSG1HIwT2dPV4BUSZf4Jyw+GgpoM1Xd3apUzBimXU9IHGxKcgHtjdaEQHIf+34G0g3jw0ONzBQxLNus/CnyklXp3SzS7aEqToDpddSDRFSbbSmjVJlhNHuekaB+5tq4aEK4mB+YC/V7r/c6NyusJzLDh6yf4On0Rnrcro1UnJuXEXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frbHZzo1uDSd1pQ6UmdFCLNEm34PjUpFRqs+eOqh6Oo=;
 b=uASd1+UWb4iDIFeg6aG3YAxQW/eJ/NqALhruRogrXDB8XSKxN5GM94nga7+BwKORh2RAF1ZeZl+8W01zs2BsJt9WDayPe4nVROtUL7AJdGVOMZdFPwV59Eao7Zh26ztGOyH9dWX9PtymDtpIsIqaQpDrVEg8sbJRt6lyFHe+j4UKKV3pyFtngIAOc8wrzxuaQj4PT/uSJZfyx87XMspOMqdeEM4a1LC02K4eA/noWcu2LPsXOD+T3wjINkEsY3JhLUMikOAN+O8gqB3NxRDgDHBfLa/HcVOrQnyh4m8rlPeSCXe8V875qNvLXfdLzugGckKX38yR9HdOCXZzKsUn1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:58:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:58:56 +0000
Message-ID: <ca8fd24a-9e40-4d4d-ab9a-eccb3f2d9dda@siemens.com>
Date: Thu, 3 Sep 2026 12:58:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of
 COBALT_IMPL_TIME64 wrappers
To: Clara Kowalsky <clara.kowalsky@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
 <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3625:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baaf2a8-d640-4463-3763-08df09aa5971
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|5023799004|11063799006|56012099006|4143699003|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vy18TGl3XxOUS9PrjYVg4QkbVSrS0YTxwXyGgibaMU3Qca6J05xcBoF3ova7s1y7lVj+ZWXJyCNmigDGiezu6l0u1FMSLdyZH1qXvg6eciUez2/fAR71juUBFYwqEzVpa9Cvv6aW00iuw484OgZKq085kXbztSA7PQ58U2q9fCkMNoXcrH8ZxHJyQb6H0qun2mq4NbFjI2Nxtg4omNIRDaZsX8FbUe9e7+/qRW3JdeyIDwVz6PJJ09jONjev5DDTCoxyt0c1OEBxppMAPsd7z8r+6zbtPFBFnn/eTQqsGSXjl7mJxz3YSl+xu/8GGEhI8bKDZmCz3kcX3h1gqapMCq1Yrdj0w3eUnJTSB91x7lexIW8hFRJ3mttd9tQyAFjW2HbJGCEdLRomdx36fPvSGT6TANmnNxcEVQysL5+kOYxFdEnSWsm9r+X7lyVEZJGdFF+mVriWsaaRKmKBdGHo8l3BJkcSr1CTzAeIlUH7/70Ten00WXS+syVYK8Hxz00boAxI1oHzip2RHXW9dNK5l19M6oKWZlJ+tc3MMeHfOA0IAQplis9HmNAPLDUWXLHN05wLEMJLGpC/psy3JmLuzE9kl0WkxBwE4EQ+UxtwguIf9UcsONtGtQhvcauKKfrLL0C5Uk8cnmE4tr0kWMTsIE9K/lElB049rVQQ15kZeZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklFa2lwZHJJeXJZeTA1TW1ueGRqK25hdSthZUdPUm1sUU85bzI2cFVpOURq?=
 =?utf-8?B?a3ZvM21pL2dWMTQ2SmxXWnRCUWk2TGZmU2s5Y2JSbnBkbTYwRkpjZm5wbXVm?=
 =?utf-8?B?ajhGOTZkR2h0MldlMUlDL1F5d05KNWJTbXM4aVdzNW1OdTljdUhrOHU5eGUy?=
 =?utf-8?B?YTdHanRmSjkvTlpCODNKU2FiS0ZrMitHeVk5RzNBYWFnOGxWczVSZjVnZmNE?=
 =?utf-8?B?THpHUHZpVWV3anJqa3oyWFY5bTNReERJSDZkYVdmSSt0N1l1QVBDbVB4RUIw?=
 =?utf-8?B?S0MvUVdhTHBXL09TKzR0bDkrdWJZTkE4VTdlS1NpNnVFNWYva0VQS3lRSnF4?=
 =?utf-8?B?YjVadjB3bVBicjNXQmMyaHRocVlYMFZhd2RtcXhFcGxmWHRjQW1sZWRLM2dv?=
 =?utf-8?B?cjFzV0dWQzFrK0RoYVJJUWpZZ3YzTHlYVURVUVpaZWpOMlB3Uk9TcEVja3d0?=
 =?utf-8?B?NUlJV0tsMmNxS0haMWUwdmlVZnF0SklKSTdPd0M2OGp0S1czZUFkUXN6MkFh?=
 =?utf-8?B?TmFocEQ5NG8rWEtYTXQyRW9vbGpqbGh3cU16MW92Qzh1N0NJYlR2U21XdGlX?=
 =?utf-8?B?NWFkNCs3SGdURXU0Wm1HY1JIUStDc3A1d1g5VzVobmYyTmEraTBPeVpzL2Ju?=
 =?utf-8?B?dUlOL2NFeWlNS3hzaFNVWWNaMFhpMWszT0xDQWNMc2F1L2QxamQ3WjVtSWZr?=
 =?utf-8?B?RHFHem9VNlNPNUd0cHhiUHpCVTgrWHJmUjRMRE5GZC9ZaGJSY3QyOHNXWkNG?=
 =?utf-8?B?VlZUa0tmaGV6ZGdDZE81a3luWU1XaEdjT01WdWVYT0QyeC94Vm9LLytUQ3NB?=
 =?utf-8?B?N0FJM0t3bXltOURwMTI0ajdDaVRyb01zTlR4U1lockc4Tyt1cUJUejlWeFAx?=
 =?utf-8?B?NWNoaDczTnp4S3BJZVlKV2c1MisxcXBCM3FiSk9KcnJxeERLY0s0azhCTlQx?=
 =?utf-8?B?MW95VllXcGh4OGRkTU1Cdlh1Tmd4T0twbmVueEhpaUI4eGFYcWFEbnBRQnMx?=
 =?utf-8?B?Um1HT0RGNE4xTTRqcUI1RzZDRk9YVGhhUFZLRW9XOXNIVytoaThwVDNZdThj?=
 =?utf-8?B?R1ROYkNqd3MxT3ByQ2EvQ0VPWHdJOHpPNkgwOWsyMW9MZzNUcmNWMVhHT1kv?=
 =?utf-8?B?eGtLYUtNNEVkWjNZOFhYY1ZhaGhTdTJmNDJOV1ZKQW5RL3FFRzIwQ0RTZllh?=
 =?utf-8?B?L0hzWFFBVzIxV3dUM20rdTZSNVBXV3E1OGkrc3AvYlYvcVd2WGpIVFdXdEJw?=
 =?utf-8?B?ZTZOU29aUlBIU0NmUGp6WExKWjdQMFB1V0J6QWVIL0FOZ1lGRTlGVElOQi9w?=
 =?utf-8?B?TnJ6NTJta2xHR29EUkZzcjFxUTVEY2NDMTl6ZzNHNk9UUWJlN2VnT3Z3M1Qv?=
 =?utf-8?B?Uy93OUtCKzhHSUdkMjI5S2N5V2p4OXpBa0hmdXVPdkNyNldRdm5jbkVZZ1Zv?=
 =?utf-8?B?TDkxVkRWQ0Q1c0M2K3AvRUdrOXRJWXhubnhaMVZBeGhWVEQzVlhYM1ZTQ1Jr?=
 =?utf-8?B?N3FPd3I3UHZsVUxjUHY0enBONWszVkMvN0xQRllwM1JNdGRBU2lBRmtZL2FD?=
 =?utf-8?B?RHBmeExBRmZsZFlkcFl3SHV2Mlo2TGpCQm1mNmNtVVhIV1ZVU0w3cnN3L3Ry?=
 =?utf-8?B?UlZpaTkrbmh1eGtTY2lYaTZLWHU4R0ZZbzlqRWpyVGVKUHhMODVjTEdCT3ZU?=
 =?utf-8?B?dW5kd2JweVRpVDNlc2dON3FwQnBPWnJ0YXFtSEFFYnZ5MlZUbDRSOS8yT0Jv?=
 =?utf-8?B?QnN1VmcybUtYTEpCYTZpMnNFdjcremxMMFJENzNXaWVRZURJdVM0WHJsYTNx?=
 =?utf-8?B?dE1FNWhMNnZ1SEVwSUdWNHdQSmp1YWtGdE9TV2pZRTY5MXJpdjVIdml5V0dS?=
 =?utf-8?B?cXJOV0VldHk1ZTlUWFkwTndNMDE1T0lxeXJzWVk3Y1M2QjlYOVZ2WHRIUXdV?=
 =?utf-8?B?aW1HWEdNZ3Q3TlBoWEx3UldtS0RjZnM2UGh6WmljQmR3aXdTbmxEMnV0MitW?=
 =?utf-8?B?Y3Nic0Q4RFk0dXFGVXpZa21QMStpSXJ4UWh1QU1wNnVMRC9NRFNKSDRoc0pu?=
 =?utf-8?B?d3B2NldQZW1uRERCbFppV3FUL3V0OG91cGt4dTV0MTE1Wmx5WFRwbTk3RjZn?=
 =?utf-8?B?TnJ1UGVFYTdKTkNVMEhMdDNtRWx0L21MbmZFdEtEOXlTTWxmTmJYcVNtKzI2?=
 =?utf-8?B?a3VrYXVsNXppeUMxd2RsenNpN3dNd3UxdzhFbEVpK0hTZTRjdHpCOWNtdWlI?=
 =?utf-8?B?Vk40YWZ1WGFmUTZvUldlcGd3NitjQ2hhVGVCL1JRZTN0ODVuaDMvcE5lTnZN?=
 =?utf-8?B?UGNmc21KdWxDaTdCQ2R6eWNPeU13dE9USVMvK2pFL1hPOHZHNi95dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baaf2a8-d640-4463-3763-08df09aa5971
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:58:56.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xICW2pEDMe7Uv/nVGYZ1MwhK0BkdLwYToROlY2oc8k1oRyvGc69uemzci6ud49FZADUCzNnon0d1tje5ZdEpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3625

On 03.09.26 12:34, Clara Kowalsky wrote:
> 
> 
> On 9/3/26 11:48, Florian Bezdeka wrote:
>> On Thu, 2026-09-03 at 10:34 +0200, Clara Kowalsky wrote:
>>> The doxygen configuration lacks a definition for COBALT_IMPL_TIME64().
>>> Therefore doxygen does not see the expanded wrapper prototype in
>>> wrappers_time64.c and instead tries to match @param entries against the
>>> macro call.
>>>
>>> This raises warnings at doc build such as
>>>
>>> lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of
>>> command @param is not found in the argument list of
>>> COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,(clockid_t
>>> clock_id, struct timespec *tp))
>>>
>>> as doxygen is seeing the raw macro form
>>>
>>> COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
>>>            (clockid_t clock_id, struct timespec *tp))
>>>
>>> With the fix, doxygen rewrites the macro to
>>>
>>> int clock_getres(clockid_t clock_id, struct timespec *tp)
>>
>> Hm. The generated documentation should be "generic", right?
>>
>> Depending on the chosen build configuration clock_getres OR
>> __clock_getres64 would be correct, but that is also hidden from the user
>> in glibc land, so we should probably do the same "hiding" here.
>>
>> That said: LGTM.
> 
> The doxygen mapping should describe the stable public API, not whichever
> internal symbol is emitted for a particular time ABI. So the generated
> docs should expose only the generic API name clock_getres, regardless
> which build variant is selected.
>>
>>>
>>> It uses the first macro argument (return type), the second (function
>>> name) and fourth (parameter list), but ignores the third (alternate
>>> function name, unneeded).
>>> By this, doxygen sees the actual public function prototype.
>>> See #18.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>>   doc/doxygen/xeno3prm-common.conf.in | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/
>>> xeno3prm-common.conf.in
>>> index 71db05686..ee4ede10d 100644
>>> --- a/doc/doxygen/xeno3prm-common.conf.in
>>> +++ b/doc/doxygen/xeno3prm-common.conf.in
>>> @@ -647,6 +647,7 @@ PREDEFINED = DOXYGEN_CPP            \
>>>           "EXPORT_SYMBOL_GPL(symbol)=//"        \
>>>           "DECLARE_BITMAP(symbol, nr)=unsigned long
>>> symbol[BITS_TO_LONGS(nr)]" \
>>>       "COBALT_IMPL(T,I,A)=T I A"        \
>>> +    "COBALT_IMPL_TIME64(T,I,N,A)=T I A"    \
>>>       "COBALT_DECL(T,P)=T P"            \
>>
>> No complains about COBALT_DECL_TIME64? Would have expected something
>> similar...
> 
> I built the documentation with:
> ./scripts/bootstrap
> ./configure --enable-doc-build
> make -C doc -B V=1 2>&1 | tee /tmp/xeno-doc-build.log
> 
> And checked for warnings:
> rg -i warn /tmp/xeno-doc-build.log
> 
> I didn't get any warnings for COBALT_DECL_TIME64.
> 

I guess that's because function docs are normally attached to the
implementation, not the declaration.

>>
>>>       "COBALT_SYSCALL(N,M,T,A)=T N A"        \
>>>       "COBALT_SYSCALL_DECL(N,T,A)=T N A"
>>> -- 
>>> 2.55.0
>>
>> Question to the complete series: Is
>> https://gitlab.com/Xenomai/xenomai3/xenomai/-/work_items/18 completely
>> closed with this series applied?
> 
> Yes, those 3 commits fix all doxygen warnings.
> 

Thanks! Patches 1 and 2 applied now. 3 is waiting for an update (but I
pushed it too quickly already - will be replaced).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
