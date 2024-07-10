Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDD190040
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609202; cv=fail; b=S6Abae5aepFb2Z5/zUvy/9k4eha4AvfmqjwO07lWx2kpn0zmSgH7LKqnXtODzUHCTaGzEJqmJzuVkkZl39KcBB8WLgvgYZSqP7LdJpLBn3pJWeMQS95pY83N3gQoYHzJQmJDU/U84qyCLAeb3qXAgLfBa3L5ZV0uZN4kj2LFEds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609202; c=relaxed/simple;
	bh=AvW+eSrlI2qQcOIaYnP52/zcZ4dxN0ZWaLPKMbMw94M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwC8dfnM+kMjqV7PirmSOMv3XQVeR8FQAdz69kny2A4RxNzLrRQC4r20FnB2Gw98TlCTcp92/Ksg5Sj3+CUFgXtNBCwik4jCi2SN57L0bd78Z0k1/eWpIbFRJClqBKvlJVRfMgVoMLGnEd/z4GgUUfsGYK+N3KTJ/RtWqq2KjH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZriJIc3L; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZriJIc3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDkYGxrn2COCF32i4qtljaWJt1M3AGwy7c055eEZ5Z5E4HHXits/u9ET4veRPWOZV7Wvx1YJynJgwUu8J18iuFyj5Bw9NJsEhMJ3mJbYn0fQ/UGSOq9kv/Ru5i8pwZDvAgGznp9SzRft8NDUKG/65BOVYSJcAK88oKt4Oaj9GkOOZXriu+BpWiqXxC8XOOj+DUzDHgqz+EBiNhBGqjhx7BXh7AIunaLHRKmnxc3VDlAxHbw2LL7FsStR+UXxAZuSQq6jT3xWDweDbzEPJEdbcUVf+vdw0WbbtpGBwZ+yTNbuQAKm9bWlMZMMCQenLk7PEx+9uqrfuNg6VeYvgrKSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joWg2EZQsafpL6QFgIyBGOn09j7bgmBizBkKagahXBo=;
 b=Paf0K0L027fl0tumPFxCYZQ9vB6k+trYzGY97ThtR3cTPzPbvu1o4Usn0Ys1oSAZ31XjUGXqMkz3o3NbbHJTOZ1gZGTMo5URojcgUHp9xSbCsX4nUe42qp9XUoOgtcLU43t8qah10gEbP5UrettMn0qe8KB+5pRooOschOB59Y/UBDdJnLU/+OapAGlAygAA4Jx2xj7JbsAfPuvppyQL5to9UKSxODhBFDiV94iI3IstXZ/AIUuDPMF1FbRSigldsU8HNsPVNbqxQxMEL0AIdpvKKmIlqXbnNE7i0qNkJ9PDQHxLlkUiWRfVAPgHJYlYulxjqPUlmk1qhvPiUXJo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joWg2EZQsafpL6QFgIyBGOn09j7bgmBizBkKagahXBo=;
 b=ZriJIc3LPsjFXh3zdWhPQnqxtMEh8G1/ShoTDNhFeAZNm03VNeYcRN0wbYJFFqwuxyDPg3RAcHVXpYKSW1GUQKR9aAe0etvkHcVkVoEmnFJlTWMBz1jIZhV9kwdA1PilZ27FCZiZXH33L3rAxypdf7BaLvPY8nZyMyOg+g2UZbCjhJJNo2J+pkGniOzujQTc5U7JXmUjFpSWZu7XR0nH60O80Oa+6QkzcJwMHT5sSxIlWKlHlkMY+uWm13s6KXgqlv74Lw3RXprLnepFqAX8GT+CoLftm+L+PIaUGppfwpcrkeVzVp3Kd6Q5g2bjPPk2S90R2jf1qvv2XtKPbWcRug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 10:59:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:59:55 +0000
Message-ID: <57cc805e-6ace-4c51-8138-fdb575e75dcd@siemens.com>
Date: Wed, 10 Jul 2024 12:59:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Community Call Minutes - Jul 10, 2024
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 10395330-7324-48f4-6a27-08dca0cf6ec2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxTQ1l6YVA2blArNjdBVDJGT0VqdDhHTDJTTnBPL2RidE50dVlKVVBxM3k0?=
 =?utf-8?B?aG1xOEJheEI4S3VVZUtzREc2c29NUGVtS2JIb2pxbnhuZVNIbEhjeG5MRHdk?=
 =?utf-8?B?dkluazVZTFdKZDVCamUwNTBHZldRVXMxL3lsazlORElrcFVnWUZkZlNhYm1z?=
 =?utf-8?B?MGpwbEkwYXBzQkJRQ3VIU0xqQ1g1UHozTVZRTDNrdW45ZC9DTnhjWDdER2hT?=
 =?utf-8?B?YVF2ZGYydWJsUjN1RStjTmlvZ1Zwbit6RTFkbTdWQnpzSHRFd1FhTFNmTDdQ?=
 =?utf-8?B?TW12QW9Ic1Q1amZYSi9RTzV2Rk1nS2k5eXJKN1ZOK29JK0tYZjRqMXdhNWUx?=
 =?utf-8?B?VTdYR1UwdkRKa1A2ZnJabUxPcEpQMzFPY0NQRUVuZXIwdjhDYWNCbVBOcUJu?=
 =?utf-8?B?ZHBEa2cwb3l5TXJVVXdPdDRobkxaV3Z3dzhkbGhIeDl6aEhVUkEwUVlMcFFN?=
 =?utf-8?B?bFJRRmEySkFOUnpNWjFxYmlrenN6dUIzUUh5WkZmWDNIczMwa0IrSW9zWFVy?=
 =?utf-8?B?N0JYMFBiM3dtUER4QWFNUDk5NnI3clR0STBQTVdPa21tZE5oU0JoQnhRck5S?=
 =?utf-8?B?ZHZEWGRRSW9NVUtlUGpxRXNtMnM2ZTArMXAzMGxjaXJGSmhsb1RzdzIwTk1L?=
 =?utf-8?B?ZFh1a3duVWYyT3FuTWxoQzVJU1VEb3pTL2JvQzhpbWY2VUkrSFB3eE9JQzk4?=
 =?utf-8?B?VG92d0JiU3hFNFA3b2wrUzBYMHZkeXlEMFBWTTNRY1ZXdURxMGV1Ti92cHoz?=
 =?utf-8?B?ajllRUZudzIrUlZLZTQ4Qm9EbjcyckpKNzJuVXh0WGRRSE91OUlQM3dlZTF0?=
 =?utf-8?B?ditGc0E1NXNHTmpLSzZoNnJ6UGlvYTF4cUU0REFKUDJoZG9lQ0FqMzlYQ0Jl?=
 =?utf-8?B?b28ySG1QWlMyanRzOHppOUo2Q0xuWEVraVE1ZzNER1dkWkx6bm96eWhFR2R2?=
 =?utf-8?B?UFRHQ1BLZUpBYlptcS8zMVhET3I2R1JmS3Voak9sQVRaZWVkVmZybVlDKzRS?=
 =?utf-8?B?VE8xK1ZPdnVqRzZHektUWVhVWmh5YnRwUk8xTGcreFpmb3QvY3hXOXo1VkVR?=
 =?utf-8?B?K2hYM1M4SlU0TElTaW9nOHpWTjcrVGU5eDNJZTJUbWZuMnpxcER6YjNaUWpj?=
 =?utf-8?B?S1RiQWZrdVNYMXdmLzFJUURUUG9wenpkajNsNVRpUXlGSHhiQUo5cmpyLzhE?=
 =?utf-8?B?ZVZCSUw3aldKc0NPRGFZRzJueld6QjkyY2x3dnR5amRxZWVMc0ZxOVFLSERn?=
 =?utf-8?B?dnlpelB5Mkw2cnhaR2FnK09iclFJSVduTnM1a2RkVGxoVW1UTnJyNGJBWm54?=
 =?utf-8?B?THkraENCckVQKzNUNnVZdE54Y1ErcUpodVhjUy8zTEZFYzRhbGhTSzVNK1Ns?=
 =?utf-8?B?bUNiYTdOWm53QWIvN05PMGJGUmR2M1VnTWIwNDBUL1NxUlhOU0FpczJjc3cw?=
 =?utf-8?B?WTVaQjZVd0RsZXlPaDZhSEpyVWdjWXpEUzlSdUZFNjNLL2pNNTdsZGR2S0c3?=
 =?utf-8?B?RUtOQ0FodkpzVytDbExFd0YxYmdDM2huUkVKTmNFTFFKTGF0UDJSdmNuVXdk?=
 =?utf-8?B?M1VxR2VZVy9GVkRnMWY5TkVDNzlsOFdHQkdvdUFuRWRMd0VrNjZnTlFkeEdE?=
 =?utf-8?B?YkZENlhUTTQ5dk9Ka3BwMEs1ZGJ5YlpIM0lkejVjTEJTbUx4WkI4YjhJNFNM?=
 =?utf-8?B?aklmNHRLMWdwSU04NFBubWFZMUJhU2FBeEQrZTBGSTRVeTcwZmZVZ3BNNEkz?=
 =?utf-8?B?d212OWRkdStNdExVNHROZ0U0cUUyNmkyZVphMHRhakpYTGtRcHdTbytzWXQy?=
 =?utf-8?B?ZkFScmZ0dnZzWVBWRHFyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVdQSG9OVTFVWGh2L3c4MkV0S3ZWbmtqcklHamNkYTJubzcxTlliRjRLS1Yz?=
 =?utf-8?B?WFd6ek4rTUpGUkhiZkxxTkk2YmJOR2syQkc4bWNNUHdBNUFjZlZsQjdacmJ0?=
 =?utf-8?B?SG9hS0pPOXd0dmV4d0NRRjVybjZzL0o1Rnk3bXBDRk40WXdTdVQ1NU4xRVhX?=
 =?utf-8?B?a3dCUUVXUFVoamdFU1ZXVHp3Z1FiK1VxNDdCMU5FZGxaQUdhM2NSc3JIU2ZM?=
 =?utf-8?B?R0hHK1Z2eHlKeVo5Vk5VcDRMTlllUjVzRm94d01mV1U3RVBjYWlJeE9zUVpm?=
 =?utf-8?B?Q0pvcWkralgzT2RyN1FHK0NsVVFhMjBMbUdCZjJkRUxIT2tlNU9xWi9nL2Nr?=
 =?utf-8?B?VHJwMmVOelkrd1Z1RGtTTVpvL0o4TjMvQ1ROaGxSTzlsV3FleUp3SVJXNnJm?=
 =?utf-8?B?R1g1Uk1SZ0hPUjlGU1ZvdWJHZDM0ZmlDaUcrZEVDOCtkemMvSGY2ZFY0Snl4?=
 =?utf-8?B?Rzl5WHVicUVSN3VBWHRPb2dOWkUvMlZFN1pkM0p2Wi9tYUQvYTBKTUJCOWc2?=
 =?utf-8?B?VFljcVJtYm1VaEsxeFlJOXZsYzE5WFFXdVVOTXZSOWVRQUZGMUowaG1NNjZk?=
 =?utf-8?B?K05Ha2pwVHAzQXlzT2hXZUk1SG9hQkVsNS9yVDgwakdQbEZqT0YyYWlDQ2Ry?=
 =?utf-8?B?ZWMxL2N1ZFBhbnNWUi9RcUYva0UvUWIxaGVMM1Y2eVhwZ29pa1ZQL1VDL0Fq?=
 =?utf-8?B?dU40Y0JvcmRwS2xaUmZBYWI0bDFVZmljNXZ1eFlBa3ZCcTRIT0VUQlhzcTQ0?=
 =?utf-8?B?a2dPSnNBbnQ3SzhZY1ZFNXM5SkhmVmU0WnRaNDRMK3VneERsUG96SXFwUEtr?=
 =?utf-8?B?UkFnYmZxT21OTlZ6RDZwTDhuNTNBK2daalRXYlRjMWx2Rk55SW1pcWN1RG1z?=
 =?utf-8?B?R0p6ZUcyaGd2bTBISUVjQmFUdU9kSG5VdDhnNjFmL2hvbmZXd0I5aWphOEgv?=
 =?utf-8?B?SFFXbGh0Z3FJMzlES1Bydkg4NWJZRUJaRGlnUkZYY2hyU0s0M2tBZmdoL3pN?=
 =?utf-8?B?Smk0dnJpcTIybUx3L2RncElzMG5hazcwd3NRbUVXVWxabktTTWNjdmR5RHpT?=
 =?utf-8?B?dWVpeUFxUnJMTW4rOUtMNW9td0ZoVnh1RUhRRlRnNEhqYXZmK2Z4ZjE3cGE1?=
 =?utf-8?B?OXZXUk9pWHBtY2k2aDFrdTVDaTVwRnh0MWFDV3Jjcm1zWHJqY0kyUGZnb3Nn?=
 =?utf-8?B?QjMvN0Ewd1dzdjBQZk1YYTJaVzlvK1dWVTJXU1lwNC9WTnRDTGhjRFNVcFJm?=
 =?utf-8?B?UUlQMlZsckxzVXk3c3czNytSQ2pWYXNNTC8zV2JpQ1VTNkg3QnVFejNldldp?=
 =?utf-8?B?NXZzRUpSY0JIVWN3bTV4V3hwOC9jQ1FUSWZYaTZUYzFiaUw3WjNHb1FWTnFX?=
 =?utf-8?B?VUZScGc3TjJ5eFNYMUpNOHBMQXJiMDQ2bW5IYjRZK1pDblVKQTNoc1FzQ29M?=
 =?utf-8?B?UHIzZHBIT1NTNmpOUnNyRFR2UTJtNlZHQnBIU2Q3cnZqbU9SaEg3WE96WEha?=
 =?utf-8?B?Rmt1R0ZBQTlXNE9ldm9WQ3hudWNCeHlTRmVGcFhzbWc3YXNLVHV1TC9PUFJ3?=
 =?utf-8?B?S2pTQUdFakVGZk9CM2ZqWTdQZEhGRWp5S3NaWDdzNjB4VWRXTlJmMjh2RXlB?=
 =?utf-8?B?U3lINVlWQkNkY3RNRjk4VzN1dGVjQUFDQ1pzK0lpbGRjdGk2V2tNOStBM1gv?=
 =?utf-8?B?SmFWU0ZseEJqQllqbzVBdDJnZVF6RDhCUjBMSlNIOVJBeDFCQi9WZndyc0wr?=
 =?utf-8?B?RC81MDlmVE1aWUdOeWxEbFVmZnZEN2VLTHJlUDRTQVp2NDlCU0diUEloMGg3?=
 =?utf-8?B?QlNLU1hYcWQyYk5sZHNQNXJPQXVrL2ZrZE03Wk01eERpYk9VM25CMEd3cWE5?=
 =?utf-8?B?Z0Ntb2Fkd0haaEVhY3lpMDhpVitlZ3FzZVI2OWh4V1lUeEdCa3JxQUgxcHI0?=
 =?utf-8?B?bHo4VmJnUHgwYytpeHZUL042aCs3bGZ3SWdaTHN2T2xDeHJ5djI0eG93bk90?=
 =?utf-8?B?MnpJKzY3Y1IrTVlWdFQ1SjN6aWpjYXF1V3ZtQmlOTi8wditJWktISWZuWEl4?=
 =?utf-8?B?SndsY2hzOUZPL0RxSE9NcmNYTzltT3B2NWNXU2lQcWpMRTdqZnZ5OVFJdzF0?=
 =?utf-8?B?WEZNa1c2cGNsdllkSWJzZEEwMTExL3Q5T0lKMDcybytKSm5XMUlCa3poYjR4?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10395330-7324-48f4-6a27-08dca0cf6ec2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:59:55.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPUu8yAgsxuBfr3SnKFTbgNwoRYPrZK37PO7Sw11c+GWSRJSrEKn6rTGnjjNWBljI5F0KF5A3OmkFaGpG87CxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5989

On 10.07.24 10:34, Chen, Hongzhan wrote:
> Attendees: Jan Kiszka, Florian Bezdeka, Richard Weinberger
> 		David Oberhollenzer, Lianfeng Li, Clara Kowalsky,
> 		Tobias Schaffner, Hao Li, Hongzhan Chen
> 
> Community update:
> 		Xenomai 3.3 -- released

Slight correction: 3.3-rc1 is release, final version not yet. Testers
welcome!

> 		6.6 Dovetail  -- released
> 		6.9 Dovetail -- releases soon
> 		Evl testcase integration -- ongoing
> 
> Open discussion:
> 		Iddp mbuf locking issue
> 		ftrace debug on GPU related RT issue.
> 		Xenomai workshop
> 
> 
> Regards
> 
> Hongzhan Chen

Thanks!
Jan

-- 
Siemens AG, Technology
Linux Expert Center

