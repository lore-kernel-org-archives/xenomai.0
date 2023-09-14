Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3861C02
	for <xenomai@lists.linux.dev>; Thu, 14 Sep 2023 05:48:55 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 9B81E200007
	for <xenomai@lists.linux.dev>; Thu, 14 Sep 2023 05:48:53 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::604])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4D1EA740038;
	Thu, 14 Sep 2023 05:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq9UpU+VxlV9HK0zxFyDOBI7FItuFsJLLsQV5HTvuZUe5ATPC8LaGwsc9/ZMqfXDFTFFK5ivRU7f5L0UWNNDvTcXPOw6DA1INwuyM0KBCZzHEYQD2kYe6+wQDlzQf+zBU2kPLPVVuTT6SGnk+Ig+rzNF9v4gEwRk+t6CpqxhPuudrviSxQk0USgx4xFYScxCCdd+2t7FACgRIwIjkr5uZXcq8+wQfs4+znPmiuRgd0P5/x3uqtyIIR2WBS+TH0mIvE1L4lEdMSco8OhXJs+Q4UMnCDxMlxtLB/Ue7uSD0D5ilji7DY/rah2vxPombT6tt28Rh4Th3OCjdr/5rJe+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBlWX4lUwerRXcZkCSWhJ0aHfXIsioFAnyiaQ0P11to=;
 b=YxcjX+yMfcWiBGvB4bWNEuiD7OrS8hQLcZtGq5xSj9hHXvqZlivEvnmIL2MUziPGmGIgZv9tQrbHnytgSMaoBHQEMdPlXggTMJUddogPOazsBht82wJUXLCIpSVKrfpH/T84DaBLuwz3lq/brI/KCbQMstuzt49VCFSq6YFw/jyFRE55SpvPsryOrVN+6ZVqWtcyDLGLbm6uCzMU/XRW0cj7q9HGJyoDkl1Uva7ky9Pc6J7dfkGSX9yBWjb82U5EyP1UVBkuh9NiDyL3PgdAXpAiJ6gf7mftb+REZ02+XwcvOBWmdAET83w9Lt5PbbmlBQxNld8hsHL4xZJwCL1LDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBlWX4lUwerRXcZkCSWhJ0aHfXIsioFAnyiaQ0P11to=;
 b=jOS+KFshsa6URKpr/hoCEZmkpx6qE55lpSMRyj2HycQii+tmwOg4GcUZCLDxhP0z4I0ra7jx67PG8zWRWsBVAYAoOlFtp0np2139l/J82B99lDjQ1cxJhMjgx+bLSD99fXa1+AfgCL3YMK8mm/pDe/PNePJNj6C0viOIdflO2IyYAelTXeYqusHzWF49D1tzRQYBuKcZDoQOq+mMf7oHQfqSJT3Go2/RJ2zX4+okz76TNbOz7u18/0HlhTtKvoZAdGd0EWhaJi6Ykvof+3izkunKdO/jgguEV2f2L+1cK6TpXmVOngEJFUkPzUBktW4mIIPlVtL57v7Vh/TbyvCs5w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 05:48:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 05:48:52 +0000
Message-ID: <95d4f7a6-1237-4ae0-9fb6-3979fa058bcc@siemens.com>
Date: Thu, 14 Sep 2023 11:18:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Downloads and mailing list pages broken
Content-Language: en-US
To: Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
References: <2099512930.605027.1694630572180.ref@mail.yahoo.com>
 <2099512930.605027.1694630572180@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2099512930.605027.1694630572180@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c0a87c-2f36-43c4-6d94-08dbb4e64636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0v2ch5N4OSBPW5kr5izl4iJFo/zx/uauIsUgOd+BCVUhrS7+klnT9Tvi7Ytjzd0/JOifpTw226LofMhUUSxhefAh4RUmUR+qklXzjxpxhd76ZWV+N8kgB4B75KK8Lyk4wJdOPOfnPN4Wwu3eOnKvVmk6HwBBPpwhdUaJzrKGVMZK48ForgI54XYwqYj/n4/KZKYgHV3kVVcUnlhT7lTWIWMWZTfs07eOkByycI+1QxQc1PkZlo5g7Z+OmzOnIQEc833C2yjkK9GrmSrv2Pe450Ktsb/zjjJ3evkWnyTO7+8zCkFFGunxX0vKk9qw8/pYWUDKGBzmSwRjPs66q10q0IgegsAejs9X+8xClr1a7IUwLdItXDe/vYB06a3GvPZEK3gL9jBFUv4l51VGLdJF5ykKPcNAMdT6UeAqvJ4TNbv85opNKyMojYDDAxhS9Algryh89f3foSUKMm/cdXZCx3OvmFPucuyXUeZBJxvANV5WNCg7MuloCTsFSOcHtKDEAX8EswCTslTsIlL11fiuoT7GaANRnUafLrqTHAuqZxmu/PKdFLe6/SgFUxQPMIzT6xEFZctak2bTuzn+56OXMr9sRdeTPMaG1sxXNTWUNravjqSTw1rlWQOyG22vAywiwiODHl9tnM2mv+LSbPDxCfpweAh8L6OXeqbSE2iEQZ0/c5giZmPqvliY+4V6jMy5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(316002)(5660300002)(110136005)(2906002)(66476007)(66946007)(66556008)(38100700002)(478600001)(966005)(4744005)(83380400001)(26005)(8936002)(6506007)(53546011)(82960400001)(44832011)(41300700001)(6512007)(6486002)(2616005)(8676002)(86362001)(6666004)(31696002)(36756003)(31686004)(45980500001)(43740500002)(130980200001)(223123001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEpvbFU0K1AvN2lJQzVuMGNjeE9GNUdyWis0ZlQrU1NYRXFoMWtxbU1rcG5h?=
 =?utf-8?B?cTIrZGdEMVNXNEUrYnljT3FsTklCL0xESUtqVWZFbUx5TGtHSk9LaTdRWi80?=
 =?utf-8?B?ZjZIMzI3dk94MGFHbE8zOGE5bURIbFBhK2x3Z3Z2eFV2cS9ndy92dG8wNm91?=
 =?utf-8?B?aVRnQnJTYWJwY0thU3VnYmo3SXFuOVVDZTgyUFR1c0RjNGpvM1ZFM2JVWUgw?=
 =?utf-8?B?NkdNSmdEWGFNK0hlQ2NQTW90amFma2IzQUtHeUIzOHRrN1ZiSEpLZE10cVlk?=
 =?utf-8?B?R3lzMnBWY2poYWZlT1ZndC9OditoVnFrbVZZdS9xTTczb0dWcXpsZjNCNC9h?=
 =?utf-8?B?WmgrWjhUSFNhUmpNMFE2STMzUm5wRnN4WkJ2OFdYenA1ODJSTkgyL253ckNM?=
 =?utf-8?B?dUdIanI4QVZuektlK0poMGZhUWFQL2VYSkI2MG1VdGNodTNqWnVmaURJN2NG?=
 =?utf-8?B?WXVCM2M1NXNmREQrRmpBUUV5M1VqUk1QTkcwa2xybUhWSUJNaDFFd05POWVr?=
 =?utf-8?B?UmEwdDZ5WUJMNkJJQzhIR2R2THRNdjUvaWZ0a25QNVArckhuNW9ZVEY5MndI?=
 =?utf-8?B?RDgzY0x5aVV0aVFSM2FKYW9mZUVldGVRM2JLclZxYmJjMGgrZW1TbXdEWEJu?=
 =?utf-8?B?VVlRb1hvSzV4TWZPZ0E4WDRiR0JSMnVZaTlXRi9neURHNVU1dUN4TGxSajZy?=
 =?utf-8?B?akI5VWV2L2c1QlBlWlpwWmtKVVpiL1AremxYb1Fzd2p3M0lJSWJvTURaMFA5?=
 =?utf-8?B?RkRjWWszT3BIQXhUdGc2bGx6d1JENFNaeU5XV1RFS3NSYjBEZ1k1WkZaYkFF?=
 =?utf-8?B?ZTVwc0QvanRUMTg4TGN6Y0RoQTRzRDRQcWY3cG43Y0ZzQmJpd0xWSkVrZDlq?=
 =?utf-8?B?bUtQK3JmT25XTmRybTNVOXVxV2VuckFITFZmS2NWMjR6bkIvRlBXM3BOOHd6?=
 =?utf-8?B?SXVYOHRMZWd0SGRqOElET3V5aWNlWmtzOHRwcWcwejIrRDR1UTdiNFFuaHVa?=
 =?utf-8?B?VGI5cVUzVXhoYWVLV2RWZXczMi9nWFg4bmdlUVduSkQveDdiZjBsN1V6bU9G?=
 =?utf-8?B?M1VTSnhrajBPYytQK2NRYTVSdzFEVXYyY1lTa3pMSDA3QmZEdFNGQkZEWEtQ?=
 =?utf-8?B?cjZIMHppM0szTDVQcHlFdXVMYll4OWZRczJwYVNrVGttNUJZZGFoWHhyNllu?=
 =?utf-8?B?Tm05WFBFQmJuOWZ2TkNBMUtLSXd3Z1lyVHBmejZrK1FibERpWnJPWEszWjJh?=
 =?utf-8?B?RHBjZnZGazdHa1E1NFFYYW1lNjNiY3YvdWZ3S2ZPVlVZKzVKc05US2picldS?=
 =?utf-8?B?ZlhEZEt2TFg0TjZMMUQ3WDZrSXhFR2NWbWRXQVk3a3hqekwxQkVZUDQ3VlZD?=
 =?utf-8?B?NUFrWXFWNTJrbVlrR2ExckY3cGY4OEVRMFRjRmlHQzYrbER5czZ2cm1XTmRP?=
 =?utf-8?B?aS9Jb2twL0paZWEwQys1YVRtWUJxNTN2dG5vcG5CUTJjMDJGbGI3ZU5TTE1O?=
 =?utf-8?B?cTlMcHVMMkcvWElMM040ZWg4S0lUZTFuOGRhVC9xL2xDMTFBSjlMNTcxRnJh?=
 =?utf-8?B?QmpnWU5Hc24vSmNoMHNJL01DdkI1TFluaWZWZ3JtaVJCakRSSHZGVFlENFdD?=
 =?utf-8?B?ekxXcFlaTi81dzZqS3ozLzBub082eGxhaXRQK3llNXFyVnVFdnFkeldRWTFB?=
 =?utf-8?B?TW9JNzB2dTFUN2paZW52Nmg1ZkQxcmx5T3p4RVpXSTZkeEx4bzBTdnNrck5r?=
 =?utf-8?B?V3RMN2ZGVjhEQ28zd0RlSXFWTFZMaUNrdTM0TmZjSTh5QVN0RThCQjhIOGt6?=
 =?utf-8?B?WTRGTW1hYnhVci8wempzVHczdk5IZjlQb281K2VIc0c1dHI4K2VwK2ltVmhu?=
 =?utf-8?B?NGJHNGV2QTQ4bG5tUCtXWUk5VEd4elYwYnUzNEIzT2pHZHRLekFlaGI5RmNM?=
 =?utf-8?B?R0JrSldvNVRFMkVCbEhqZTJkT1JMWFhQa2xuNlVZVFZCU3RTMG85WmdwTXgv?=
 =?utf-8?B?dTB5d3NXbmJoaytodEw4Zk42UHVLZ1hQOVRaTzJWRDhmSmNBTmxHa3V4dXpt?=
 =?utf-8?B?YThEWEpWU0xhRjVodi9nNGgvaWpPeXdVWkg3RTI1akd3SVZMeWQ5TFpVbm5h?=
 =?utf-8?B?R0pQOHcwSjVCblp3M1FBeGZpVVExOWpldUl5NWViZ2JKbzAwSEtHQzQybDZU?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c0a87c-2f36-43c4-6d94-08dbb4e64636
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:48:51.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: johCDawb2bRGPLqn5i1kfyRPzF0vVzIVfxPOeCPmFHV+khFs9fVAzcyzYH06JSS2t6xrj38UroDA9mg+J9Hjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6671
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=jOS+KFsh;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0e::604 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 14.09.23 00:12, Alec Ari wrote:
> The following links no longer work:
> 
> https://xenomai.org/downloads/
> 
> https://xenomai.org/downloads/xenomai/stable/
> 
> https://xenomai.org/mailman/listinfo
> 
> https://xenomai.org/mailman/listinfo/xenomai
> 
> Just letting you know.

Yes, we rearranged things recently, see also [1].

The mailing list moved to kernel.org a while ago, you now find it under
[2]. Older downloads are now at [3].

Philippe, setting aliases, specifically for historic download URLs, is
not possible with the new hosting, right?

Jan

[1] https://lore.kernel.org/xenomai/878r9atwev.fsf@xenomai.org/T/#u
[2] https://subspace.kernel.org/lists.linux.dev.html
[3] https://ftp.denx.de/pub/xenomai/

-- 
Siemens AG, Technology
Linux Expert Center

