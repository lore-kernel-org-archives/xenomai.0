Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20A4582E1
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435173; cv=fail; b=qrRmvxn+Vhnj/ySBlxkPyVsZuHDApKdbgrm2GaIM1eGeXPurBbNAulM43Vc/BsZwSG+F9Z52yuaNMOOU5VkR9P9Mrkva4J2x6I+TgV2Z7+OqjilPLikmNXx/7IHpmrwRKAp8HKYktVvGg3ZdeIH7PNnThLuojJKGAStsayw4vN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435173; c=relaxed/simple;
	bh=1KMMN6bXYzjPtWLsdYIuQ8C0ymDzhZCltMoLEgZk/4Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NDjEsbo+n28rodZAxSUylLzVwbzS36/148Vz8/Cj12SPk1WeE0SK5BnajkuJUKC4Og6TP/gbavbT9lD2Pgq00CFXhUc+chbCeWKW0JWD2moQski6Y0mr+erxK3P+PLQkv/tOyxmrn5tVDBziq/CU0P3reauao3TJpx+1lkebPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xfIZwtDh; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xfIZwtDh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU3Pcf7+vXVk+R4uQ0BXPaBhvYFY09IcHS2aw/3bvJum/uz3NbQbZK/pketfGvgnfd6HQLYk63K7dry1cciM2t+LOhidfHvWWN6wzG0YeT9GfVarrkPb9TwxnoeD2/ZRwmxggRwbgXEn+/Y2arAnXheEpvhk7+VJO1pc1FFmf42NwXBttgJIR8m9K4bFs9UIWIkgedgz+w9epi0dCwrxfzb9ns9XLVrPY2QfDCS3l5nF6Y/JpHf9SrNQ/aVMQjJoNtxu8mdAGl8LCYbz7RpN4GJGqPKl0AL7Trh6A0RJMr3YGpr7W4/hwkcp4BS38c5E3c5iUdhbcyjhieK1p5ctAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa0uAmfJaJrNvjaZcwee9U88gQrqd0Fy0JIlgtvpee4=;
 b=idDacannA3ZrsUieeYmr3cTTHSCKBoN9HmzACMH/158RSJprnhltCTEX6sfQuiwAn0QbWuZb3EqNO0eBfhesKU7eI7RPinI/kkcfsOvNhBJelIisol5xZtj4P+3XqwYrx88wTytsjvJSuMFXA1hwzSp9kzrGjaqeFPeGSp7AougPorGQcJDT2bQqurgdhuBSYluNtWRfl8FRjJkgSrgZw2OUHkTKCvTFWLBunIOr6DiOofVZbvYfamFuGqTtTgnz94ccvp3nk9MV3/tFy/VFMqJfE3G1XWn2zReW7ZqpKkzjBwqCNy/0DRTaW3fS1fMl/Vm9ZJJAdWookQm3lySqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa0uAmfJaJrNvjaZcwee9U88gQrqd0Fy0JIlgtvpee4=;
 b=xfIZwtDhT4+ZLUcU6C4+PDavkrHy8Twt7qPZiGI1B4+rWjnl1oSoZymXrFbCSrswhXUUpmavQTKJpnMZWx9PDDe02IcaX/vmOGqnzgwKziDA9bJQtRnpL/3zvkzmZyjXveR5gThwiC7/FLJ3WoTNwpy8JFRqn1zPAYZa8SubFBgTtQpcSvcFj8IpfKqABns8Wn+TssYu90U8+DADo3CAfvzKMr5s/R3evi8Q28mAli4VDRP/7s0wpMcpappZ5aydF29SspubRS1/oEqlwTCo0tyoqqEpf1cyhchPLA3zHAy4iTHhy41Cii0Y4y0cjLI5xccIwfVUCjQYSuwcZGQDdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by PAWPR10MB8163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:381::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:32:43 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:32:43 +0000
Message-ID: <a80562e2-31b7-4c1f-8284-03972e99b39d@siemens.com>
Date: Thu, 3 Sep 2026 13:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs: Match actual return type for RTDM doxygen
 declarations
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <20260903083447.2220024-3-clara.kowalsky@siemens.com>
 <ae21a7d7-ac4d-4c1d-b83d-3963ce68c352@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <ae21a7d7-ac4d-4c1d-b83d-3963ce68c352@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0018.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::30) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|PAWPR10MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b653f8-4ef0-4b15-4b19-08df09af11e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4DEkzqpjTXvnmFGpexeOTfFte45p4285ZEth/QEtrFPwdk4i+4DoLc5RDKwTrsl93CQ/B30DdILzrnK5F/rATkrqkodOo5VZV11S60HHv9N8L8WHj4FCLbNe6SKiPThDDbkHZPpgIE7KRyaUtS7sP8WPGjTCOfEYxiXfcdsYbEsUjxf77NkAj2zvnfUWY5NO3Q78oltKPRMY1qApN8Cyn5W2nazYcmaKPawGfAVpJQLutvnVRfXYSfU/S8IqQSOlLAkenNf0Hx9nD5+kdQl+wI2zHJw+R7/CDakWMVcqXI2F53TBOd9UbM4t9ybzHUGan0zmWINmC4wUgkPQ+i1xRv6A0qafh0Xqzj+4zhTGmmMXUA1YNhrkH4jiTAH9wY1/0W2kDKKyXhF8SNXzCGc/0t9+xXknwewEworBYKKi+wp99FJNhXVBksbPZYkiNm9Ez7fibwXDNzBdY5GZ6FzIFHCVVh09RYwzQ0FxjNG6FolE97iUfx/7Rz4nqjvMsSnHuox6Os3+V9MMYmV30XGiwIg3vv3iWptu0Mvy6ip3bRQXQczHBHWv87c2RlXe4OKDuSEh7Lg4Tn6uEwymuHTO2C/lT4DkMgXlnTkFEiUhSs+u2/aHXMX5gMWAiNhQG+flANxuz4PMSohCnyYHrjxWtfQkFWzstA/AUrbcFLyZjGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9KdmVzbGhjc0pmbnY3alVwUU15ZXhKSWZDVmZMVGRJQ0Jxb0ZVSzJMM2NE?=
 =?utf-8?B?WWc2ZXRCSHQrZWs2Uyszc0taNlQ1b1ozbU15TEhhdzRvLzNnM0dnZ1Urblly?=
 =?utf-8?B?WHVkRDZUMUJaS2RscVV2TXV0YTdQWXBXNFZINmx2RmdUaUR2OFcxNXJVNUNj?=
 =?utf-8?B?YTZaSEd4NEZsSHBNZ1ZVR3pGUnNvUlpHTUlWQjFXcUhBcmU4VFZUNlJ6S29X?=
 =?utf-8?B?NlV3bmE0VktJWCs0N0tlV1RvZGFvTTFweVRzRERCOEFCOHM3Z1BTLzR5SmJF?=
 =?utf-8?B?ZU5EaHQrbEh2M1A0RmpjZTJCWjduazZ3c0FSZDlxeXkrK2xMZ0NvYXIrRUR6?=
 =?utf-8?B?V2ZMVEdxWERQVjhtMHROc0U2RUN5d2VQNEtLdld0TjdBUXBUTEZNZWloT1lF?=
 =?utf-8?B?QVN6S0JUR2RPL2ZNV3lKSFVvMk1vNlM1bk1scWFHRnpnNHYzOE1ZM20xUU43?=
 =?utf-8?B?ck9kRGRPVjlIanNkWkNYaWpvdEZJZkQ0eGh2Y2QvRnExSEJ6dlJyVkFvelk0?=
 =?utf-8?B?N1liNWhrZkF3TFBhMXB4RjNrd3JWOEhGdTViRUdrOHZWS25kR3VzMkxqcGd6?=
 =?utf-8?B?alVvU1drejNieVVZSFhGWlBJeStjQkRTcEg1M09vVXVISXRYNkZ2RWhtNVlH?=
 =?utf-8?B?L2VqV29tb2tTbGtxb2hVcEk5WkpWZWNSejU1VkhuQjcvSk16Y3FxSFdWczRn?=
 =?utf-8?B?b1lMZWJYR1o3MmNSZzlvVm9SQ2M4QzJTNm9sNmc2aGtyNzBKeTBGWm93c0xm?=
 =?utf-8?B?aVU3QXRkZ3dvMzRRcGtWeGQ3UDE2TDJiKy9VVFlJZEdhVmQ0cXU2emZTL0RQ?=
 =?utf-8?B?eUQzaHAwaW42V202a1RGaUhnSzBvMGZONnhiU3BqME5oTWhZUjk1MkF1R1Jx?=
 =?utf-8?B?QnVabTM5UmdtbkFNblpQMDhURVFpS2FQTUF6cE84YmRpTHkvY0hqUmhLeEtG?=
 =?utf-8?B?d0t1d256Ylc5bGpPODJmanBua2Yvdjk5MHlXYzNpVkw1dXhhRjhpRXFzR0lL?=
 =?utf-8?B?MEtteHlhaDR1WHBzUFloZDU0SDRHZWthRDNLNU9nNzRjS0gwbUZTRmZFUE8z?=
 =?utf-8?B?aUIwVitjeGhMdXIrUDE1M2FTbkVlZk14b1NQUzBEY2htaFdIODJYRlRWMXNh?=
 =?utf-8?B?Z1FuUVdkWDcrL3lncVJRZExjZnBlNmJ3RzltdEpSOGJxQmN1UEpiVy9UR0Qz?=
 =?utf-8?B?aUgxS3VES2svNjVJM25rY0J5bm9naWQvTUNsNk5kbGFmSkQyS3JIazVNQTJL?=
 =?utf-8?B?dXhsZ1hSQzEvNW5yemx2MHVEVXdQRlFURmdGN2MzVW5hQVJLMUp2UFNpK1Bm?=
 =?utf-8?B?VjE4VTVSTHBNMElaRjhPNHhYeGt1anEvSTFnenZEUjZ0aVJ0MG9MRUlTOHJO?=
 =?utf-8?B?RUU4OUdFUVZiVVVjbzJmNG1MZExzb0Z0bkRwTklXeXNyS3VRaDNOeUdWSUtB?=
 =?utf-8?B?eTlPTUhnY3hJa0V6enlpSWREaDJkQmsvc3J3dlFVSEZMakU3dGZZZm4veUVo?=
 =?utf-8?B?SmVDMCt4b0hlUkJNUkV4QzJVQkZwVlZ0VW9sVzFob3FENzFEQzBGQWxrYVo1?=
 =?utf-8?B?eGxUb2F3Vkpvb1RjUUhBd1k3dnRnaktuT2o0UWh5YndHbkRIZHdnSCsrdFl2?=
 =?utf-8?B?enF3cXNUU3NaK1QzNEplbFd0bjl0aWlnV2JxUTR4bTlaNUhVdGJoMURKai9O?=
 =?utf-8?B?TDZEa1JjYmNLUEVzVVhDU3oxRG9RTWhDanJMV1FiUXI3YlY1RGl1WE9PQi85?=
 =?utf-8?B?WDBSbDFJdEREWFc5SVB3eVZWbmNyV1ArVzlNSEczK0F4c1I4NjBpd2VYMzlN?=
 =?utf-8?B?Q0FZUXVFS1N4dnB2V29UakVPQkR2MW8vQ0ZzUXI3Q2dHald4S3Y1Nmk2R1o3?=
 =?utf-8?B?UEVxemp1UlJveXo3ZllwVDhTdHhXcDIxcDc1dlo3OEJnaGcvL3VLRWVnbkVQ?=
 =?utf-8?B?Y3NNR2Rwb0VRVlJOb0RRTUZNQWFzRDB2dnZkVisxanNzNXQ0VC9rN0haV2tJ?=
 =?utf-8?B?bnRjZEttWERQcmxaaXpWRlBIVS82Z01QcG5JV0N0b1JMMXlvcFltdmx2QTl1?=
 =?utf-8?B?ZGdaNi9VRUowWS9uOHMyUVQwSjN0ZVRZcUdKYTFYdDdkTitQbGVWeENkWXVM?=
 =?utf-8?B?eDJPSGxzS1AzRkJSdVJVQk1ERmRMdXNrYTZVL3c4WmJRL3ZmczlpVVN0aE16?=
 =?utf-8?B?TzRHc3dlL2RPN0ozRlpTNThzQmxRdm8yY2xSd2VjSi9QSmFEVkZGYmxZZ1pt?=
 =?utf-8?B?eVBiNE5HS1lrZ2NyODBMTHJjWTY2K01pTzZCTjJhVFo0Y2RNZDNzR3EvTXdF?=
 =?utf-8?B?S2RoVW9haTZtdE5rVHhGcnNMNlFSSFlLUDA2bjFxdiswZ04rSEVOcUxsTmhE?=
 =?utf-8?Q?DHmOjR8YxmnB9840=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b653f8-4ef0-4b15-4b19-08df09af11e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:32:43.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C50SROIwPXPZO3lPUcr6yqGS9dZyEybVfu/cmQnjUb4QCtpU9VO6XWLJ7kre2n1UHHJjQwt8IW6tsJgGjKaTOqtCW0tPThIPmf013Iow2cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8163



On 9/3/26 12:53, Jan Kiszka wrote:
> On 03.09.26 10:34, Clara Kowalsky wrote:
>> The RTDM doxygen-only declarations were corrected to match the actual
>> return semantics (int instead void).
>>
>> This fixes warnings such as
>>
>> kernel/cobalt/rtdm/core.c:420: warning: found documented return type for rtdm_timedwait that does not return anything
>>
>> See #18.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   kernel/cobalt/rtdm/core.c   | 28 ++++++++++++++--------------
>>   kernel/cobalt/rtdm/drvlib.c |  2 +-
>>   2 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
>> index f30055a79..002fb51cf 100644
>> --- a/kernel/cobalt/rtdm/core.c
>> +++ b/kernel/cobalt/rtdm/core.c
>> @@ -414,7 +414,7 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
>>   			 nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>>   
>>   /**
>> - * @fn void rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>> + * @fn int rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>>    * @brief Timed sleep on a waitqueue unconditionally
>>    *
>>    * The calling task is put to sleep until the waitqueue is signaled by
>> @@ -443,11 +443,11 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
>>    *
>>    * @coretags{primary-only, might-switch}
>>    */
>> -void rtdm_timedwait(struct rtdm_wait_queue *wq,
>> +int rtdm_timedwait(struct rtdm_wait_queue *wq,
>>   		    nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>>   
>>   /**
>> - * @fn void rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>> + * @fn int rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>>    * @brief Timed sleep on a locked waitqueue unconditionally
>>    *
>>    * The calling task is put to sleep until the waitqueue is signaled by
>> @@ -481,7 +481,7 @@ void rtdm_timedwait(struct rtdm_wait_queue *wq,
>>    *
>>    * @coretags{primary-only, might-switch}
>>    */
>> -void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
>> +int rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
>>   			   nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>>   
>>   /**
>> @@ -509,7 +509,7 @@ void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
>>   rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
>>   
>>   /**
>> - * @fn void rtdm_wait(struct rtdm_wait_queue *wq)
>> + * @fn int rtdm_wait(struct rtdm_wait_queue *wq)
>>    * @brief Sleep on a waitqueue unconditionally
>>    *
>>    * The calling task is put to sleep until the waitqueue is signaled by
>> @@ -526,10 +526,10 @@ rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
>>    *
>>    * @coretags{primary-only, might-switch}
>>    */
>> -void rtdm_wait(struct rtdm_wait_queue *wq);
>> +int rtdm_wait(struct rtdm_wait_queue *wq);
>>   
>>   /**
>> - * @fn void rtdm_wait_locked(struct rtdm_wait_queue *wq)
>> + * @fn int rtdm_wait_locked(struct rtdm_wait_queue *wq)
>>    * @brief Sleep on a locked waitqueue unconditionally
>>    *
>>    * The calling task is put to sleep until the waitqueue is signaled by
>> @@ -551,7 +551,7 @@ void rtdm_wait(struct rtdm_wait_queue *wq);
>>    *
>>    * @coretags{primary-only, might-switch}
>>    */
>> -void rtdm_wait_locked(struct rtdm_wait_queue *wq);
>> +int rtdm_wait_locked(struct rtdm_wait_queue *wq);
>>   
>>   /**
>>    * @fn void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context)
>> @@ -585,7 +585,7 @@ void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>>   void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>>   
>>   /**
>> - * @fn void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
>> + * @fn int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
>>    * @brief Signal a waitqueue
>>    *
>>    * Signals the waitqueue @a wq, waking up a single waiter (if
>> @@ -598,10 +598,10 @@ void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>>    *
>>    * @coretags{unrestricted, might-switch}
>>    */
>> -void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
>> +int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
>>   
>>   /**
>> - * @fn void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
>> + * @fn int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
>>    * @brief Broadcast a waitqueue
>>    *
>>    * Broadcast the waitqueue @a wq, waking up all waiters. Each
>> @@ -614,10 +614,10 @@ void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
>>    *
>>    * @coretags{unrestricted, might-switch}
>>    */
>> -void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
>> +int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
>>   
>>   /**
>> - * @fn void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
>> + * @fn int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
>>    * @brief Flush a waitqueue
>>    *
>>    * Flushes the waitqueue @a wq, unblocking all waiters with an error
>> @@ -630,7 +630,7 @@ void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
>>    *
>>    * @coretags{unrestricted, might-switch}
>>    */
>> -void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
>> +int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
>>   
>>   /**
>>    * @fn void rtdm_waitqueue_wakeup(struct rtdm_wait_queue *wq, rtdm_task_t waiter)
>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>> index d9de62946..c2e7e1195 100644
>> --- a/kernel/cobalt/rtdm/drvlib.c
>> +++ b/kernel/cobalt/rtdm/drvlib.c
>> @@ -2270,7 +2270,7 @@ EXPORT_SYMBOL_GPL(rtdm_get_iov_flatlen);
>>    *
>>    * @coretags{unrestricted}
>>    */
>> -void rtdm_printk_ratelimited(const char *format, ...);
>> +int rtdm_printk_ratelimited(const char *format, ...);
>>   
> 
> This is not correct. Please fix the documentation.
> 
> Please check once more that all the other functions are actually
> returning something. Most should, but maybe there is one more off.
> 
> Thanks,
> Jan
> 
I checked for all other functions and they all return something. This 
one is only one off. I'll send a v2.

Clara

