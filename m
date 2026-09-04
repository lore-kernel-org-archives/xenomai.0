Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F4485CDA
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524486; cv=fail; b=rkn1XiWDzLRHHj+d8DvwbD4jQEv8tWWkNlD1Ys9lj8XbAkFB7QAVYm2dLQQ9Ks6NqvyVhHjxtbye4mHYtny3L/8bVJhlWi9j8Bx2PqMO6XjqxpwR2c9SrnID1OPrRkmnGZbeuof3myqWqtEAVCVlv1qVr6116EjTvzbJS9RZF6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524486; c=relaxed/simple;
	bh=jYGq2mgTpnkk6Iq0FzcGJ9gF7qK5/m91mQxWbvpZQ+o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMraQhvqE0xTzt3DJXjaiNnDeTBBLxzvrJCDiRaWlUaPJNRnr3BlBFXubmLhSP1CO9qm/rB7xXls2I56WLmzyAju2hJIGxg5BWYQ5D4HlurEoey0r5OpRDjKjmkrtojEczfPMuLtTEVjdkRK9r2kXmZAknvl2i0AFJ/R79vBMfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=u/9CKh2H; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u/9CKh2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiLqal900GFfqtTTng2srmRUoOYfI6n8ltWM4887i1AncIzFx1pW2IbS4MIRH0pgoYpVMkGqTttqmdf3bUEIXlaeYS14+K2F2o/pdXKSeMZgmJT152DapxJClgn8neZvGBAzvqCaha/XdjjoneI8+Qah0Kl1ZlTTxDUudBRjUbwIln3kD4tknvTqoW/hs6BCXT1rejjEcqZhR8/8Ieic5q6MER9qZ1K0228NMXXFGc4N7aCbMCL/UvoOe7Uouq4KIdM1/ayYiDsR73KtUJv45k+w5UnvIbtmOm7HKzNZqBh6WF0nubuBUi3LwND8T76/DYSbJMiTWBcnVFLnS6ItwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFlbkFle3cTtpwauZdLT3zxs+hoEO9nyig2GYKi2sos=;
 b=HxGtlAGq9/DVqTtNTOzVOj04bvSEO/YLyd/xixL11Bf20C2jJw4VMPDzz9wkv0nm3EN++EOKb9dLkbefo8JnES8pSewSZFTauDNiFml8nyCMFg8MBRk2Qp1EZKIWwB9ESp7AznZz7tEZ3Z5lr/C2dgeSXdW8UhyOF0pPVr5aM3VMnVyOhdnUGHwcW4QPFrn4VM89XZaAv/kOg5592SX+x9FsgaRyaVLsyszTnKfey+5WvZpEBEvgqAAzmYhvupf8Cy71wzHdgvvylvCVWq5wuQr9tpgYXxUymHyDCg75sQpRvfEt9DDhpOLjqtHjUokKO2FILS17eJ/8D3lRrODt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFlbkFle3cTtpwauZdLT3zxs+hoEO9nyig2GYKi2sos=;
 b=u/9CKh2HWMeRWm7mixhQ44l8JEgRa+/DkZu32O9TSOjyT0RlAM8Ih/ZaGV63H9R/rQbty0LGQduCs1WKKQyLeZcEBo/1CZqSMdFL6/IJzeYk0L0//cpk6KLdqOlEVv45ZBfI/4DjhQTxX8nrhAVk8ea/Vnhzp3MUOx1+7fqp+JQIZVwazEgGI1MFB8JYOSSSGyH7IiNAhlTCu++Ev2+ZKNkP8AwbbkdJM3c98R5PGcPv+K6JllWlFog537nOzAo06pViC3QYhru2Qr/bdLB0IZzAIruhwCUWdC50Fn4FMaNSNvBa9l2Wyi5gI9G5vrQy1UbyhHFi3q0gs0Hn/1OkDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by VE1PR10MB3807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:21:21 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%5]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 12:21:20 +0000
Message-ID: <87932735-ad30-4fa9-a356-1f8ad4786d98@siemens.com>
Date: Fri, 4 Sep 2026 14:21:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs(xeno3): Drop COBALT_DECL() to avoid duplicate search
 results
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260904115440.2981755-1-clara.kowalsky@siemens.com>
 <15f5d6f8-350e-4468-821f-0b4c60a4a30f@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <15f5d6f8-350e-4468-821f-0b4c60a4a30f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|VE1PR10MB3807:EE_
X-MS-Office365-Filtering-Correlation-Id: c5188a2a-85aa-4a8c-5a7e-08df0a7f06b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|55112099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MCJ8AXEerCf+ceOHa218waDDC3PCKZ8VWjdkcI3T6lBcEiNEhaEghJhzC4qypH7KQgWyAPKC+E98AdR+YrNf/iku0tOCltUx8IRzKy5CgalJAJXLVpZ9soMhuUEh7juCZ9NRBNq16R1BQ63TUAh2bYrof2p25vLFeHxOz3VFkH8yZs31SRN/SbgQZD7RI7Y26uAmDfRSNDZVaP/WrTe469kPFpODI2qGnnG7rLkC5uWRZ2XjASU6/aSwY2NZY05+Qk+DSxBXdvJK3nyHwIrWGc+pXxrrZxT82n9cYfhqQROoE1se6wpqJMgatpr9cTofNuoNb4F3/r19akCfTomI7So7LYIL81dcS+WSVqrYREJ7ZDZbD93/hunfIji3Sq7HfdL2+NlaI/z0dK543N+DiAPBWa+8Ag5v761KUsa1bHa9bJsm3i4OH6fjJ1s+SlArcasRTKZ28lGdzf3xHooOSvlRmpNaXSqpvvZDDClTUyD4o/eFK72NouqRXUzdvJMtkXSsQ+SG6JqQK+uUoFwmud40xZ6k4RlxglleAKSjBT5LA1ZbrI6yEBz9hE+K3rhToZdlSPovXjmKZYALjZIYCeJK7WBRjmxTx0Xd8/SpraQXgmIAKn7nYgTZY1yZqhGUyxF1Gzl1NOqAe/xX/6RKR63gTTpu2i493QPWlQCry/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(55112099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFCOEFpS0I2cHNCNDdyZHBxWWwwZkFIb294NldFdmZnVWo5b3htOUNiUlpJ?=
 =?utf-8?B?eVJ3ZkpoSXNMYmtFQ3R5UTk5YnhoRUhZMmJZOVp0OUpyTDJNR3dYaWdka2Vz?=
 =?utf-8?B?VHRXd0NKMTZtdWtPL1plZVpzaGlhZllEV2VWL3FhM3pESy9WN0w5WlRJc0tS?=
 =?utf-8?B?UkZRc1dQN3NER3AyTE82SE5iN2tCRnRZdm9rSFJTdVpCa2JMejBJdkliRXM3?=
 =?utf-8?B?MGJkb3AzczJNenR3WWExb2lVdjBvWGNRMHNsSGNLdTJGUFd6Q0FLbkhGZitk?=
 =?utf-8?B?ajhXOGtxa1ZxTFpTKzFwek51SldVMGVySjNpSFNjb1IzSVc5OWRRa0thSi9n?=
 =?utf-8?B?STZ6QTNwaEdSMTNTY2xqMWxaeTNUM0x4MEl3aytocjVrTm45amdubzlPVFNU?=
 =?utf-8?B?Tzd0Zi9ERVFXd0Vya3ZqdUpUYzBKcnIxa09OanFMbTZtZ1kxQ21TbGZ0WTU3?=
 =?utf-8?B?OCtmSERoanMwTkdocFZmbjNaTmVpYk1ObXh1dEJpKzFkUzFJU2o2WS8zZ2J2?=
 =?utf-8?B?T2dLL0d2REliVHRiRXB4NUppQ01UdWlIOU9zRTl2ZDdTYUdJTFRBMmtsNGVF?=
 =?utf-8?B?bzI5cGRQajM0Y2JxZ2huVVA0MDFWc0M0cmpxUkE0cEFpdWtSV0szMW15RU9L?=
 =?utf-8?B?aWM4bnR5YjNyaUhrOExiRkhXZ1pjQUpKaEFMRUhvY1djVkdQRG45eHg3R0ZN?=
 =?utf-8?B?eXNKWXY0MmE5VG8rcytENFpOS1RLTFlkZUdYdDhZUXZlekdRNGpCc29CVUd3?=
 =?utf-8?B?S0NtTkE1TnNuc1FUZTU2VXcrbHNVdWRCbVh5bFh5dXEzc3o0OUFCQTNraXc5?=
 =?utf-8?B?c0EvVmgrbmtjZHNQeHlla1RZSEJweldOVE53MW5tT0k2emJGMU5ZSiswSDdO?=
 =?utf-8?B?aXhEdzRPekVvQTM4WmEyL2hXV0NPb3NIeDQvWmdBazRzMUVFakdVeXJhSlVu?=
 =?utf-8?B?a3d4VUpqWStNZnJVMmtaV2oydWVxU0hQRm5BLzd2UlM5eTRLaWhJWjYrQ1Ji?=
 =?utf-8?B?amlmS2F4UG5naVlkZ0p1WEQ1TEp2WmZxK3NsVnJBNnZCYno4M0lwaEExZlNr?=
 =?utf-8?B?VWFndnlPUnlYbk1RRzRseXUyL2pQTnFZb2dnbXlBajZHM3hPWlR4aEE1SVBW?=
 =?utf-8?B?U3lIeDU1Y0lGQjRIRUxVWkl2RlJFbEJSUGkyenVEckpiL2lpOUdSdVJ0WUdC?=
 =?utf-8?B?V1dKdjBVNGkxSGtNU253NGN3bHlnRGJxVmg3dWFvTVhrbUNtTDJ0dUdwOU80?=
 =?utf-8?B?Snp0aUlVRnpZc0xFUTlLYjRUQW5YUlVFeWIvTUxyK3hsdXFnSHl5TnhwNG0v?=
 =?utf-8?B?MDJld2pXMnBIMWlIdHBmVENQcmlGRkhjTEduVlVBeDk0Rko4OVN3Z2Q5MXVL?=
 =?utf-8?B?bDZYK0d5WU1qb01najM3ZEdFTmxDWWh6WW1FbEZQR3Zxd05YSnhoaytRbGJR?=
 =?utf-8?B?S3FENWFlakJYaHloY01RMHY4dmVxTkhYMjNZLzYzbWRnZFRmTE50WUZaaXJS?=
 =?utf-8?B?TFdiR1FKQ2NsMjVRT1FyNjBiaDFzaFhlbGp5M3U5WXhNM1U2bnN2SEM2Q0hL?=
 =?utf-8?B?MWJtUzJ6Smk3TEtSVThESEVadmdqa0dyY2w3d20rTmNGYWpldk9JZTVEbDhF?=
 =?utf-8?B?SGJHL01ZK3ZWYmMxc0NFMFI0THA3UnRlZGVXb3Jwc2RlNHFaSWxxQVdud0Ez?=
 =?utf-8?B?MDdHTmVma0JSbW5RcDYxeGQ5RE9pS2RTbEpsaUh1NjZabDN2dGtmcHJ4cVRh?=
 =?utf-8?B?L3F1cUo5UVRtZG1xYlN4M2dwaWhCRlpyWUNLdS85L1VMZEdZbVlJb0VycjNw?=
 =?utf-8?B?S2VEckZTQ1VScUhkS21vVUFYUEZpNTdzRStyK2Raa2dzWHREUkxuN1VQZlU4?=
 =?utf-8?B?ZDJWRTRiSDRwR0RmcmRYakpkRjJYdkU1WHBIQXAvajhtQy9RT1MrZHZKTG9N?=
 =?utf-8?B?cjVrTXU0cmk3VUxWSXRwNmJacXEvaG1OZHRVcFozbmV4US8xeGRXdkppdUlY?=
 =?utf-8?B?YVVQVDU3RkRCQmVMZFpYNE9tM0cvRTBXWS91NVFOc3RxV2dpV0NzNzk2L21s?=
 =?utf-8?B?V1JRV1FuTUxKSkVXNmtET3B0dlVobjJ4S0VWb3pvMlFQSERHMzBJQWpaeDZr?=
 =?utf-8?B?Umc4Q0xUTzRDRUtBTzlHaittQTFzNmJ5blk4aEM0TjhwRjkxdzB5TGZSSGZZ?=
 =?utf-8?B?SjlLTldxRXFFbGdVUFhhcHBlcERoWkltTFlsR20zK01ZZkhhSk1URWQyUVN6?=
 =?utf-8?B?S3V3VWpMejJFQWpSVWFRSUhHMWUyYU5uaHgvd3ZjdnkzbStJcEFid08wWnhr?=
 =?utf-8?B?cXFBV2xjQXh1OHJlcEJUclR0WVRMOFVzMElHQmYzRkorK0hBUUpGeHBvVG1X?=
 =?utf-8?Q?eQFUmVrQxmk/MnTw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5188a2a-85aa-4a8c-5a7e-08df0a7f06b4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:21:20.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX6OZh6HQVZ7RuJfvGufctvCS4dN0XWR3zrrvzORLgofz7ewJKNM981FMkaPa4wnaF9PPpvbVTGkSbGzs+5EKEgGoZO9AVyo/HZEnMKUIcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3807



On 9/4/26 13:57, Jan Kiszka wrote:
> On 04.09.26 13:54, Clara Kowalsky wrote:
>> Expanding COBALT_DECL() causes doxygen to index the declarations from
>> the headers in addition to the documented implementations of the Cobalt
>> functions.
>> As a result, functions appear twice in the doc search results, even
>> though they point to the same API documentation.
>> As the function documentation is attached to the implementation macros,
>> keep the implementation-side expansion and drop the declaration-side
>> macros.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   doc/doxygen/xeno3prm-common.conf.in | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
>> index ee4ede10d..33ba35ee9 100644
>> --- a/doc/doxygen/xeno3prm-common.conf.in
>> +++ b/doc/doxygen/xeno3prm-common.conf.in
>> @@ -648,7 +648,6 @@ PREDEFINED = DOXYGEN_CPP			\
>>           "DECLARE_BITMAP(symbol, nr)=unsigned long symbol[BITS_TO_LONGS(nr)]" \
>>   	"COBALT_IMPL(T,I,A)=T I A"		\
>>   	"COBALT_IMPL_TIME64(T,I,N,A)=T I A"	\
>> -	"COBALT_DECL(T,P)=T P"			\
>>   	"COBALT_SYSCALL(N,M,T,A)=T N A"		\
>>   	"COBALT_SYSCALL_DECL(N,T,A)=T N A"
>>   
> 
> Sound reasonable. But did you cross-check that we do not lose anything
> that is only visible to doxygen via COBALT_DECL (for whatever reason)?
> 
> Jan
> 
I checked and there is no documentation function block attached to any 
COBALT_DECL, all are located on implementation side. And as every 
declared Cobalt API has an implementation-side entry, I don't think 
we'll lose any info.

Clara

