Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883FE343D76
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073241; cv=fail; b=P9seXPAqZSfLdxUPWXogov+y/e8TRaqscxRl0Cm+3BPpx8u2S4uXp4iRTIeYNe+LlBY7p1hDVLlXmOah0J+jfipKkZGoPJP9wnVBjC/EJvqHU5rBW/Tj51izVpEvi1Yc/MOZsKZ3ech3v2qK6Y44oL6OvzsMn1QTf90DaxhfybU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073241; c=relaxed/simple;
	bh=r4BOe5ujfciQi1Be38lpkioxonT0Vcq5Cfvvejf8L5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HkKHtTgG1RuqWlhtKA1Vle2de42WQqSl6+jCB1RLvOghSyhCsVvaFcBH7gFVbGeaLZbluEdmLxvVRxwQTj35SMO/mDErozfVW+r0D5aXxZ7g8lkR7Ut9oDQMs0JnQau7bCeksOoNZHLwCls89AfEKp4Wa6/Gk47MsDQf96hiQjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UK9zClj5; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UK9zClj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enAtG0ChzKew860yZjpa3qUn6+lcehvBKmRuqeyQb/+BWQIj1vEbiUA2Z0GsmNFAxAAi0FQ3Gyqg5KkhuLt1ZcVeMq58h6VBWfRASX3cS6OzyZQLo/oO+ozKS+y/WQ/bQwdixuW09dfqZfUznXPc/tDUy53rV8Uo0qnLYfzcCFwOzCM3maxG2macRgONZAZviz8rp9es3RzWC0Gccu/cS7Wna2ljVttWl4ozdOyElbca1Gg9b+uHI8uYOvLSKu04PzxOeMCHcJSHjynPydZKbJpqWP+JsWr8Cw+zk/lIkXPsNNPLUXARPA5tIFmAb4gLTMQoZUxYb3+a/xywVo49ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVSHGi8JAo5MHcjAP3SnDtiqQw8IY/QWCsTLFvUEslA=;
 b=I79UBWRGhyicpMAExZsbbyHOSw6rKvO8R0bwitWupUjzSF841NCVb9QYcJJyXze83tqO/LlCTbczISb4tzlonulefoP1TkPUQCoouC+2CV86ltd00uc3VikpV6eeNCYCvhnJdTOnpQzbh1SHgsGEpirBje+y1QsbLmwknzqshTl8aFDMDeZXe0065Y3hvale2jX5DwznHqH/G2YujYrw5tMLJ12fQg8/4EJNtjGzHIHr9Pm8bdieAynZ4LwO0VGxQLUF+U4ErSebmIgUMwRyBuihzSAqro9CWxVMebPtj+uZrgxOEABygY0cbvWd6i8MJofzstFhQ7DVs4MaUbzQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVSHGi8JAo5MHcjAP3SnDtiqQw8IY/QWCsTLFvUEslA=;
 b=UK9zClj5Qq3bauMEF3nAY28LnYXxc6RC0CFXa5l9+4Qwe5BLiH8sWKk2Ie3M2/WtKE6zmdMsxdBzlHFNwl3crA8gpfuZNZ5Z6VoEPwBf8IfWtUBz5ElhiL0b7VXYPE/3MNTTIZDtXRZQHOBYxsZfxgPWFd4MQcCqMSU236IXTqY2Y7n5TjAkOuFp5PYTRXcMv8PWItMHAm8yR5Xt5kzDZ21VVvhn0kaF0Z+QCZc5mSvDl2l/xrkqa1i3vvQVGsJ4zjboGsDAFgcH+nRCg9g9/Ws8tIFlJECJoDrDjC5fNRSQ0PeM7ENSzhunwdnWkG4ZEuVHApBwnseXKDSgQgLGYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB7529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 11:53:55 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 11:53:55 +0000
Message-ID: <03a8c39d-a2d5-4f95-9ac5-30b06562d8f1@siemens.com>
Date: Fri, 5 Sep 2025 13:53:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to three
 times
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
 <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
 <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
 <ecd75542-25ce-4beb-b7d5-8c58b2611cf3@siemens.com>
 <4fb68229ddaa695d640a5ebd03e415e0e50f2a67.camel@siemens.com>
 <859bc0fc07c6972d566f6e658f81c2711194978a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <859bc0fc07c6972d566f6e658f81c2711194978a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d93dd3-e73c-4cbc-59d6-08ddec72e381
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmEwMUdPVTBCQ3pTNFJkRis2M1poZnRuTmN6eUpEVUlWeXFUYWxhc0VSck9T?=
 =?utf-8?B?MVd5dVIyS1NDcnc3RzQrbktWZ2M5d3RNWFFrNFFkeTJyV0ZGNWs3bWtPNmgw?=
 =?utf-8?B?ZVJzd3htMFJTSmlwLzZtZXFqanFEcHNmTGFqK25ka3BubmVqRUhTbUNIVFVz?=
 =?utf-8?B?THJ6enBKeUg5UzdxRlhWTk5tMEwrcE13R3UrYUcxU1JqQzBFaERMeWFtWm1N?=
 =?utf-8?B?Q2d3S055MHZpNGFBZFFEY2ZGdThSazNicUZQb2hMazVhTm5qKzJlbWVGSGRO?=
 =?utf-8?B?RWo3SDdZMmVmbW5tMnorSkVuK2dHb00wbzROR1RzRUxwYnVrR2lFOUNZQUxE?=
 =?utf-8?B?bittSzZCeU5NbGYwMVU2U0J3cmF3Wk4zTnluOVZWK0dhS0JRVHREa0tJc0NT?=
 =?utf-8?B?Zks5OUxEbmxKT1hJODg2NEx4MzJDNVlwb0Z6K3h1dFJldkhWNGU1QW5zWjdT?=
 =?utf-8?B?aGs2QkpIemxBbTBha3dPWEJINkx6dEk2ZW5YVjRnZlRQVVdZalRCUi9kUHV3?=
 =?utf-8?B?b2ttL2hhdGgyZ3hqWUtCOWN0OXlmK1BtNnFBVEFLcmFCbW1xeHkvV1RSdmJO?=
 =?utf-8?B?WTlNM0JKQ21MLzNRR3ZNNnpkYWZqcWpTYXl5MENMRFVNajdTamRleGEwVnFo?=
 =?utf-8?B?MTZ2VFdoS0Q0Zjh1VEIvcmJuMHYrYkQyUjlFa3dDV0Fld0VRQWJLMTdpbFpG?=
 =?utf-8?B?RTFMMHZqV2pQUjllMjEyNnFKMDVPSitrVjZOVDMvK2ErOGk5OWdLREVMc0JN?=
 =?utf-8?B?TTRna01TQld0dE41aWhQY2pzbHpFTmJxZnIxTStLYVBCbVhYbW53eVNuYTBa?=
 =?utf-8?B?Nk1zUjNjRkRaRXhrWUpYZ0F6SStWRnpMbjdqSlY3NmE2V0poQ1F3ZGExTkdw?=
 =?utf-8?B?RjJ6aGNoekdXUnpKVk1NTTIxSlQwWUZjUlR4Y1lBdVFUdnpNQTU2R2xMQWxC?=
 =?utf-8?B?QkZTallmMk52TmtMV0NyT015Snc2TkRFYmpiRW9NZFpmTlc2eVNPakxhT3pj?=
 =?utf-8?B?Y2d4NjFSVURrQy9WdWFNM0xnd2pvazJieXlBZ2t3SW5XU0t0ZnhyNURzR3dW?=
 =?utf-8?B?QjJXcDVBbU5JR05LYkg0SmRUZFpaSHllRWRtMXFDOVVEK05oMnhkZlBYRFlM?=
 =?utf-8?B?L2Q3NnVHcVNqSWZuNzd0YVRSSXMzWHVKU1VzMGl0RmhiQUFxRDhQS0pTZk9I?=
 =?utf-8?B?Wmc0akdpa1NGeTlrMWVGcHZud3VwMXo0eUNpVERmU0ROSXFxS3BlZ2RkYnZO?=
 =?utf-8?B?N2hRMHpYeENRMkhGa0pVcUlHMGl1cUhEUDJ2SWE0UE1VS2t2ajhZSFI5RkxM?=
 =?utf-8?B?YkpMMmt0aFBKejBsa2hsOVlEQjluejl6YlRNUkVUZnlpUXRnV1prdTF0MUJS?=
 =?utf-8?B?ZXBYUFpFVlVtdTIrK2FaQUVJcEh3dUc2NTVzUzVhN2U3aUpWVjh2NkdtRVp2?=
 =?utf-8?B?M3hNT1pDWVNURXZLK3h3WEEzbHpvSURta0RNa1NwMDR3WmhaYjIxdkk4cEZR?=
 =?utf-8?B?aUZ2cVhXeGdwazZiYUlVWjhWOHIzUis3VVlUR0dJcW5vWitnS1BxQ0NXZDJp?=
 =?utf-8?B?dVRhcUowcTVtY20weFh5dTY2elYvRTFsQWhJTWl6SVQzam5kSklrWGdFVFlh?=
 =?utf-8?B?N1ZlcmtTZ3JVYXdCQi9wZys3V2pKMlA2aXRtcWUyV1crWThkMWZ5a2JVTnZ4?=
 =?utf-8?B?NXBCbFg1bElGbHVCMlFmYjgrYklrY3FTUkxnb3RkSVhRalBxU25FV1NVQkcv?=
 =?utf-8?B?USs2MTVzR3ZscFpISHBzOGJ4N3NqOFEzcEdxQUVieDJkR3R3MnlBbjBRY2Zs?=
 =?utf-8?B?djcxMHJpY3pMbmd6SExqTHl2c1N0RjYyZjdpWWJOZFQ4ZkhGS0tGZkw0N0lB?=
 =?utf-8?B?Z3Vucm1KclluUDhneGxCY1VKaEg4Z0tVT05IazlYd2p0M2xUTThoTGJxT3gr?=
 =?utf-8?Q?+nj+GNEnsWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdIOStBTEYwSFRzVXFad1NCNnhFNGJkWWN0MTZRYzhieUxoYUJOSDlxdUU3?=
 =?utf-8?B?NlIveE1qNEZ1Rm9mQVJubFQxbEh2R3J2T0t2dmI2cXdjbVgySmNmUEQxeGRW?=
 =?utf-8?B?S3pwQ3BkZk5pK2dxNmZ6NGQ1WmhyOUthTURuVmFmMXVtQXFjU3NWOHA4Mi9X?=
 =?utf-8?B?TXhONkxsdTFmR1lTTVY2a1hXSXFGL2ZQckkvTHVOS2xwYUJxSUVBeC95N081?=
 =?utf-8?B?T01mZnlBSmJxTTdDMi9oaXM4MktiYU9hS2RzTWRRaGM4ZjhrMWh2bStIU0VD?=
 =?utf-8?B?Tjd1elZjUDJ3Zi9Gczd5MDlOTlZWSkVZRGlRdVl1OWVwRUExRDJadm1uQmNV?=
 =?utf-8?B?dDQvbnJVOGY0SVlNTEZKVDZ1b2tlL1ExS3YxeUo1Q2dtcUxvcjRuY096YUM0?=
 =?utf-8?B?dlRicTVOWEdtTnpDOVZNcitnOXo3eGlHQ085L3FhcWNYdjVSS2FkUU5PZFA0?=
 =?utf-8?B?eTUvVWFibkhIbHVTOTAveGNLcG1tODFWVXkvMnpIMFhpcDd4V1NuQ2grVWdY?=
 =?utf-8?B?ZjZ5alBES2xZWlltZnVId1BKOVRxYlJaLzk0enMxUGt2a1JTRm9JNUpDR25H?=
 =?utf-8?B?bm1SWFdJR0FHNDIyaCsxbTViQk00eXRIUjlXaDlmZk1kRStUSjQ1MWFHYklP?=
 =?utf-8?B?aVZzeEM0TlR6dG03ZWpSMmp1eVpDT2ZpOU9RNUd2WVl2QzFhT1hMcWRYVjdj?=
 =?utf-8?B?UW9xQ01XdFQ2M0lFY3cwSTk2MXplMy9BRExNQytGaDJwcFFvWlgrMC9oQjFu?=
 =?utf-8?B?L1VOcS9MS3YrZm9xQm1Cem9IRG1VUWtwWkxYVWoyNmU0U1dDc3ZYNStKem90?=
 =?utf-8?B?TU5yVnhWeHRTRFdobmx5REk4bGNiYmVKN2tpc0crMWlTaGk1N1JqTDVsbk1I?=
 =?utf-8?B?UE1IK0tHNEJBaGZ2RDkvOTNTdytsNUVYeGV2UUplSFdoWWg1YlgzTVJGOC92?=
 =?utf-8?B?T3dqNWZPbnNLeUdFUHZTNHR2SHA2TlBPSDQrQkdVKzd2UmI2QlFHSlptaDJi?=
 =?utf-8?B?RWRrNGJ5Z1hKUitTVjJGQ2txOGJUWG1ReUNOdXRPekJBa0NSZ2FvZlMxdjE4?=
 =?utf-8?B?d012SWRINXgwU0FTRDZCYmhtY1JXZURvdEhyWHpQRDJtaUt6QlNGZ25HaDVw?=
 =?utf-8?B?bXFpc0RKZ1poOGcwOUZ1VktYVXBrRDNSUDVVdXZKOTM5SjZwQi9hUGoxazJN?=
 =?utf-8?B?ekVLNTNIb2EwODF4c0Q4NEMrYXZoNjd0ZUlRTHlHcDI4RG1CcVNTSlZxdGxK?=
 =?utf-8?B?K3R0Mi9SMXk2aVNVd2NaK2k5dXc1UmJLa0xESFZrbE4zSlpsTVlQY2t2eXpi?=
 =?utf-8?B?YXlLaDJpbXlxUnE5U1JQNE5aUWM1MTVXYTlNSWRMdFFYLzJZS0pZZHBwbzd5?=
 =?utf-8?B?cS93bmlPSnJWb2NHOGdSSllaT0plSmw5YUx2WDBITGVMbnh3QVROM0ltK29x?=
 =?utf-8?B?WEFrTXFOVUNmUklBZVNMQms1SW1CbUw4bjNRUnFEdk1HeFZEblZJdGx0OWg0?=
 =?utf-8?B?bklBd1VLYlNhbmpsM0MzbmtMTmNzZjBqV05YZzV6WWVFaUF5UE9VQ0o3bWVx?=
 =?utf-8?B?UG1YVWYzeUhiWlpRaDJGSTYwdUZkRFpRaytoVVZQcDVsblNnN2pSa2FpMS9X?=
 =?utf-8?B?UVE3MnBjZ3VucjhhLzdjeGtWbVEwa1NFSGppNEJFSmNEektEb3ZtaHBFcnJi?=
 =?utf-8?B?R0RKVnhWRFZVSndSdWk1OFpBQTg5aGlzZjc4WHc1eHNNZTRDVlc5OEFkZE5N?=
 =?utf-8?B?Z1BwK2RCakxqTjZ2amNJK2tzQmN5Y1hzTkN0Mm5oTDBtamRKNFdRQmwwT25r?=
 =?utf-8?B?WlhwbllwNXBOZkVncDRKRHZGQkdlWFBXVWJSemJ6SlZqNTBxMHAya3paTGt2?=
 =?utf-8?B?UHBCUGd3c3lvQnZJYnlTTTRZRGU3eDQ4K1lWamRibC9UY1Bpai9uUUtHODV6?=
 =?utf-8?B?ZWFzc3NwR1pnZEE5eFJGMUgwMEc0bGdHSHBrTnZVN2lVYjlVR044VU1YNzRa?=
 =?utf-8?B?VUZhUThsNzV1eHd3MXM3RXQvV2JmcGdJeWRuYXhzVzZ5NWQ1bVprc29YT3lN?=
 =?utf-8?B?L3dmaEdKcDNIK0srQnlvR1dEUFdpd3ZPL2xVdFhUaWdERnlpK2VuVVZkMk9B?=
 =?utf-8?B?cW1Wd09JU0ovMnBNQU1YbEN6aE5NSDRQbkdUdWR2cWZIVjVST1J3czE3Z1Jy?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d93dd3-e73c-4cbc-59d6-08ddec72e381
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:53:54.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWLmRj74AZ4+elupWwwx7u2qT8Gi8jYoHN1+4fHegOj9V3BZM+8uyJOgaP/8j2+Hoo1L4DeBkNPltu7/BueCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7529

On 05.09.25 10:57, Florian Bezdeka wrote:
> On Fri, 2025-09-05 at 10:39 +0200, Florian Bezdeka wrote:
>> On Fri, 2025-09-05 at 10:24 +0200, Tobias Schaffner wrote:
>>> On 04.09.25 17:33, Jan Kiszka wrote:
>>>> On 04.09.25 12:16, Jan Kiszka wrote:
>>>>> On 04.09.25 12:03, Tobias Schaffner wrote:
>>>>>> Increase test robustness by retrying the LAVA boot action up to three
>>>>>> times on failure. Failures are detected via server-side error message
>>>>>> matching. This logic will be refined in the designated repository.
>>>>>>
>>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>>> ---
>>>>>>   tests/jobs/xenomai-beagle-bone-black.yml | 1 +
>>>>>>   tests/jobs/xenomai-hikey.yml             | 1 +
>>>>>>   tests/jobs/xenomai-rpi4.yml              | 1 +
>>>>>>   tests/jobs/xenomai-x86-64-efi.yml        | 1 +
>>>>>>   4 files changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
>>>>>> index 8e47dd6..b7a95bc 100644
>>>>>> --- a/tests/jobs/xenomai-beagle-bone-black.yml
>>>>>> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
>>>>>> @@ -41,6 +41,7 @@ actions:
>>>>>>         compression: gz
>>>>>>   # BOOT_BLOCK
>>>>>>   - boot:
>>>>>> +    failure_retry: 3
>>>>>>       timeout:
>>>>>>         minutes: 5
>>>>>>       method: u-boot
>>>>>> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
>>>>>> index aaf8949..27beb07 100644
>>>>>> --- a/tests/jobs/xenomai-hikey.yml
>>>>>> +++ b/tests/jobs/xenomai-hikey.yml
>>>>>> @@ -40,6 +40,7 @@ actions:
>>>>>>         compression: gz
>>>>>>   #  BOOT_BLOCK
>>>>>>   - boot:
>>>>>> +    failure_retry: 3
>>>>>>       timeout:
>>>>>>         minutes: 5
>>>>>>       method: u-boot
>>>>>> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
>>>>>> index 50ff9ee..4074825 100644
>>>>>> --- a/tests/jobs/xenomai-rpi4.yml
>>>>>> +++ b/tests/jobs/xenomai-rpi4.yml
>>>>>> @@ -40,6 +40,7 @@ actions:
>>>>>>         compression: gz
>>>>>>   #  BOOT_BLOCK
>>>>>>   - boot:
>>>>>> +    failure_retry: 3
>>>>>>       timeout:
>>>>>>         minutes: 5
>>>>>>       method: u-boot
>>>>>> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
>>>>>> index 4f1a7d8..0014429 100644
>>>>>> --- a/tests/jobs/xenomai-x86-64-efi.yml
>>>>>> +++ b/tests/jobs/xenomai-x86-64-efi.yml
>>>>>> @@ -41,6 +41,7 @@ actions:
>>>>>>         compression: gz
>>>>>>   # BOOT_BLOCK
>>>>>>   - boot:
>>>>>> +    failure_retry: 3
>>>>>>       timeout:
>>>>>>         minutes: 5
>>>>>>       method: ipxe
>>>>>
>>>>> Thanks, applied.
>>>>>
>>>>
>>>> I think we were retrying here, but it did not help :(
>>>>
>>>> https://gitlab.com/Xenomai/xenomai-images/-/jobs/11248170239
>>>
>>> It looks like LAVA is only making two attempts.
>>>
>>> On the first attempt, the job runs into a timeout. This could have been 
>>> caught earlier if the U-Boot soft reboot was detected correctly. In the 
>>> log, it appears as "must RESET the board to recover", but our pattern is 
>>> looking for "Must RESET board to recover" with a capital M, so it 
>>> doesn’t match. This has to be fixed in the .jinja2 config on the server.
>>
>> Hm. The settings is inherited from
>> /usr/share/lava-server/device-types/base.jinja2
>>
>> a very "basic" LAVA configuration file. Which version of U-Boot is
>> deployed on the board? Maybe something very old and the message was
>> updated meanwhile?
>>
>> Should be doable to overwrite / add another error message. 
>>
>> @Quirin, do you want to take over?
> 
> Just realized that there is a device reset ongoing, triggered by u-boot
> because the device tree could not be loaded.
> 
> 2025-09-04T15:24:53 ERROR: root node setup failed
> 2025-09-04T15:24:53  - must RESET the board to recover.
> 2025-09-04T15:24:53 
> 2025-09-04T15:24:53 FDT creation failed!
> 2025-09-04T15:24:53 resetting ...
> 
> The problem is, that the board is now booting into whatever is deployed
> to the EEMC:
> 
> 2025-09-04T15:24:53 U-Boot SPL 2022.04-ge0d31da5 (Aug 04 2023 - 18:48:26 +0000)
> 2025-09-04T15:24:53 Trying to boot from MMC1
> ...
> 2025-09-04T15:24:54 Reset Source: Global warm SW reset has occurred.
> 
> Which is not what we expect.
> 
> The problem starts with:
> 2025-09-04T15:24:50 ERROR: reserving fdt memory region failed (addr=100000000 size=30000000d flags=0)
> 
> The job is successful after a retry? If so, is the memory of this board
> really ok? No overlap between kernel/initrd/device tree?
> 

The problem is that we reset the board after the first failure, rather
than power-cycle it. LAVA is then not intercepting the boot and
re-injecting its network boot commands - and we fall back to eMMC or
SD-card booting.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
