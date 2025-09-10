Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0601AF0AF
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509430; cv=fail; b=Fu3YgB6IhbDIkItEasuQ95cWTYhiwbjTq22g/2JdyyvPQHT1FpBj2qur7nR+/NDSGiiHALsLZfiDojYCYAFmU5yJjyeebdCKvrCTLRbnHTNRAgSCMkzkfrZ9qA1FQbj5njwl+TweXpJEw1Q8Vm1YRW9c/C7z/HkzJi9CBDg6JU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509430; c=relaxed/simple;
	bh=wzd9lzDALy5IgXzR2g5o81Y75Irt6WS2gjpIgLUj40s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lETZFcpKHCqsCWOGZy3xBiaQVgrla8Bk5RyyIJyb8FMafFKlj4jVryQbdl3usFXg0akTKkpzGOpNJ0rCQgtzxhOQqUVnU0gLbnbOjWsuZDRXHSpf0cVl4cf7t8rds5D7f62ld4FC/p7Uf9zLNNqQp627gc8Mx/TEuwPsDGadLUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=phMh7hRi; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="phMh7hRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCfdorX8mII/vdOyKN1S+m4yFjOLRhvFmhaWzP8jn+y/6Pkv0HzcrwhrseOpPW4Pq2fovoPsLOHAaH+p2JgqUutXzZOuPmcNN3kTs23q+zEmhXV1GQz2w2IZjb2NduA8rPZExBd5ykgkhj5/Nb6lvGjkf1IyH0vGbRZZmk6HLZ/tuIHHgqTiVx9yk1NF8FezUaKduSVegRSVlZsMjhJ5hVVariZzSt25BLyjc4BfZ0ux1EJz2SC8FI+UckOa7sAmvkPpJIJSohg0ck0WmMFhfF4ruGY4NHszXPI5Wbr9wDWfeJS6ltN3W9rdD4UNsDlCSOVkAZrnHFww95oH70gRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwja/I237RJIPLN2lYjgKu06G8/wzwacI2M+uxr0Ct8=;
 b=LheATuDVqbWq29TIBy9rGJAxOVSqXd3nISDm+o+Hx8tK0v/H+RmliDEJimBG5F0SxgHUKkuY8OfkR46xHU5axI1nFzfczgZbWgNZF3MqadkOIBFbqYpUH7FvOSIMR3LEfnTGZj0ol4UsnBfe7kP41VZ77eOglUAXEUwjZIo+/AATrUT2U31scGtTFeqBS6i1hg0PhKL/DDrU+TUGxWGUXEPDpw2FRX8NJQQzzj5iC0eKMFg0y42NnYl+sbZQJi5nezzhQ/JWzp2wL3LmjgCCOgnRDodlNao45CZD2Z9siNW7FRf1w+QDC7zYv0WWKRgXO1M2lsnaTGITkVcQOC8amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwja/I237RJIPLN2lYjgKu06G8/wzwacI2M+uxr0Ct8=;
 b=phMh7hRiHTieYg9an52EwsBdKmwA2ake/KfezzF2JRtxOerfqKN+/C7Zd739kx0clq1MGEWYI7PQVRlslm/5GCgfsDPna1LQmtEdT5XT8IzSM099DAH5XffQzvFfrEm6cWxSgjK2yuOPpL02dJBeHzkG4Rx+5xAeZ0rJkwBAb0RUetttwCTnrx/wfie4eThdNHx3oeYm+SMVBar4OM8JuiHjHjVzkKZrJusY9IqopawsYoMV153VvPK0tzwRRRo+5oEJB3EMBPXW8psYJlZVgvGcX/sffDr5nLzGvtbhNCBybirT/gcAetnRgPudbi7H4wGMHDjAx1Qrh1pJgcb3aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 13:03:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 13:03:45 +0000
Message-ID: <505fd322-a1c6-44f3-b31b-0be7c7bbb108@siemens.com>
Date: Wed, 10 Sep 2025 15:03:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl] utils: net: Add missing initialization of
 query_type
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <0b07213a-d4d6-415a-9179-b9a632a78aac@siemens.com>
 <87plbyxy08.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87plbyxy08.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6f6386-3b5f-4cc6-60c6-08ddf06a7941
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVZnN3AvRHJCaGQrYUZZWXNQd3hhczVlVGt3NHBoVTlrRTd2RXhuMC9Cby9w?=
 =?utf-8?B?cUVZdDhDcUxvYnQ3MWRGSWxIcUh4aCtOdFNWN1lscnlhQ1lvVDJPZ3E2dEVY?=
 =?utf-8?B?N3B6Tk1LQ2FVOURub3NKc2F0RXpiYWtVZUhyampLUVh4WFMxOFh5VHVmQ3JR?=
 =?utf-8?B?eWxpM1YweTNQa01rUzkwcDVGam5mM3AvS2lRdDBTV2M3ZHVBWENaZnZhMmp6?=
 =?utf-8?B?bGRLWXhTSDhxUXhSWmZIa0tqSjZ4b2hzSGJzTmNHTWJPakpHUG1ERjE3N3ZU?=
 =?utf-8?B?NFhZK2NzVzRxd2ZGNkd5RVFHV3E2YWQ1REZ6N0NSZ3Y1WlF1RjBTOFNSa3Jx?=
 =?utf-8?B?bXM5TisyVlliRzIrMkVTRjFBV0VQZzcxSWN3R1dZd1pZVGtzQS9nZyttNWJz?=
 =?utf-8?B?QWtiVWNYOTR3QzNnTVpWVVl3L3BlQ3BJRUI5SjZxQkorVnBDd2x1MXplR2FJ?=
 =?utf-8?B?TXl6blNEc1dsL3NVNTlqVUdKUUVhclpRaUhIY2pyeGxhSDJtV3J2c1ZkL1ZF?=
 =?utf-8?B?ZXJLUHZxSHRnaitoZlVGWlMwTWZFNFUvQVArTHFPcEpJb240SkZFSnRwa3Jq?=
 =?utf-8?B?WVdJUHRWMEZPV3NsS2xHT1QvcVdMZmkxM3pROTBHT0ZHSmtZZ0dmOTZjdjVH?=
 =?utf-8?B?KzZLR2FNaTIzVUtKTThQVVhlVHR6d3JCakszUXZzQlFRVUVhaEpFM25lelFv?=
 =?utf-8?B?bWE0Z0xMeDU5UHJPQlRGRGtJQ1VGTENMazhQdFdVZTcxNVJURUtzd3hrVnBT?=
 =?utf-8?B?YTN1RllraEk5N2xrcWJpSlorRGxXYkNDSC9mbzYzaXcvZzdSdWZPTUZBU1Zt?=
 =?utf-8?B?a1ppVjJXUnFEdXhCSzhFVDNnazBtZDRvN0g5WWt6d3dBc3ZkaEVQTVhuVlNY?=
 =?utf-8?B?WUtTSWN4VFBQWU0vWDA4aVk2UVU2eUk5QjU3MkdDWHIrVVdTTndWZldqVEVN?=
 =?utf-8?B?UXFtRlRqcWx2RmhkeDB3SzZ4Z1pXaTdWOTFhQnJwdEVxcWVZNDBzYXA5cHVN?=
 =?utf-8?B?Sy80Y2JIdDNpVjNEd1pTcnFpeG5vYzNMQTRrU3JjN3A4UzNDTUljc1NXSXFT?=
 =?utf-8?B?OVFkckdNbzJGOUcza3FacXV5QTl1K2wxeWZTaVpYTTRTQy9PQ203VE1mVWIz?=
 =?utf-8?B?UmpEMnNpdDhHN1hhSi95SVZ3UU1icWhZV1pxMnZhN2dTdGtRZ01ydEhaL1F5?=
 =?utf-8?B?SWNyQU51NDArV01mL3ZHWjc2MzhHUDJLSDdwQk9idjJrekxLUk5ZU3RYMVR2?=
 =?utf-8?B?SHM0MC90OGo3T21HcGlVT1lSeitEdEp6ai9ETm9HV1ZNa3lYNkxBVFBnMFdM?=
 =?utf-8?B?UFdNRks5ZGxWVFdaZCswemdjWGVTNmFjNWhObHk1eGVqKzl1amNHa1JZVmxU?=
 =?utf-8?B?YW9qK3krOEEyMUNFM2k1MVAwbVR2c2QxK1RpMU5raHd1TXhlbHNMOSsxOWhq?=
 =?utf-8?B?bEVnVnYzczhoMmcrYWNUNzVaTUFLTCt5TFF0YzZWaXpLSUtWNTFwd3BFMHZI?=
 =?utf-8?B?bHYwazVleEhUeU00aXBvN2NaR3NraHliT0tTVmwvSUhveDZ2eGVSVlVvN3pO?=
 =?utf-8?B?SXQxYktmU1ZpWHFJQ0J5bmt3NHExNnVEK0txT1lzVnlnUjFMNWpVaDZMVHBz?=
 =?utf-8?B?aGtBTG9uUTM4c05zZERmQkdqSnhHYzN2VUQ3YVZ5bWJ2L3ZMdUJ6NCtqVVRx?=
 =?utf-8?B?WCtEN3laTnhlejlubEI4VGVIMDZqdWxpOUZDRkZaRnpXZEVVNnQxSTFLSDBz?=
 =?utf-8?B?dSt3dkxQZEl0aFVaamZiNVlQT3BjNFhOTS9LblpRdkpxeUIyajF3M2lEQVhm?=
 =?utf-8?B?b0FidkdPRldLcmRBWktqb2o5M0NVZXo3ZjZFcVJlc01BbFF4YTMrNWZHZlcx?=
 =?utf-8?B?SGFMbjdCWk5qQWV1Tk5wUG0vN05Qd1p1NWtpMmpOckZjY1NFK3JEZG5UcENy?=
 =?utf-8?Q?scl5RP94Z9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ZEREVZTDNWTHpFQk1uY05iYWZ5YVRBeE0weWN1TXNyYkZidmd3aEZtWG9i?=
 =?utf-8?B?SkVCZnc0OVNMWGRESDkwcElndGRZaEwrbzF4RHNHYy9DWjZ0RnQ1VEhaUHI1?=
 =?utf-8?B?Ti9STjlSYlhOcHBxenBoN0NEUUp1Skt1Ymo0clU2ejBNY0pPZ0J1aStGVzRB?=
 =?utf-8?B?WmtTZjJoQVNLQ3Z2d3pTbFhyMVdENWVldlNBV0phSklBM0lUeCs3VGFMaEta?=
 =?utf-8?B?cUVvWXpaaktDVSs4eDhMV0xYQmJ2bW1PVnkvanpWMVVlYkc3UURjTVBYa1Zu?=
 =?utf-8?B?TlZyNi82TnNjQzJxaUJ6eTNBVW1xVnRPUDZib0ZmZWxXbEtnYjg3VDBsVWIx?=
 =?utf-8?B?NWdZM2x6NGZOZUZVOWRieHdCTXpPNld4d0ZoNmhDVWRwd2tacHU4VTRFSm5Q?=
 =?utf-8?B?ODZnVHdiVmgveTljTEpsRkhKY1hMSzZQanQ5Wm9xWVVSYzNjSHIxOWpDR3pi?=
 =?utf-8?B?Nnp5Q2JWWTRLV25hQ2JMUmtKMHRzVHU0dmlWV1I0ODdmdzV6VFE5dUVFQ1dL?=
 =?utf-8?B?eUFLQ2l6bmVsQktyRWhXeWhmSUNKcldZcUpBd3NvbUNkTGM1YmFtWXdIUVdO?=
 =?utf-8?B?Qkx4RW9kM21ydytWZExYYmtONDJhbGZhUC9zblJxUGtDM2Q3bytWa1JZVXB6?=
 =?utf-8?B?UG1RV2dZRW1KaUcrY1E3UVJpWDBORjJZK2ZLSllQN3dVSTZCZmFCSHRuZ3J5?=
 =?utf-8?B?RGNXbDFTZE1OUlJFcHhnU09KVGhUTU9CcHA2b2ZaeGF1RFlrQ3c0ZXZrdTdj?=
 =?utf-8?B?TC9OSTlQQk1CQTgwb0RYUW4wRFRWWWFiYzJzVytVeURkSFgyL01Qdk5ucmdW?=
 =?utf-8?B?Vi8wTXkyZFgzejZ2ejUycERPbEJuMm04a0hJRkk5d1pQNFJEWmxwNVJtSjg2?=
 =?utf-8?B?WFBZN2hYbjdQcW1TdkIxVnRZYXZyVm51ZDBxN29MbFcra2R1RmJ3WUl6cjUv?=
 =?utf-8?B?QXZJbzVmVDNvSldFdENUczdTd0NDYlhOZlVqRm0ybHc5T0RKMFdYTEVyc0hW?=
 =?utf-8?B?OFA4ZjJ5YXdwb1FQMDhucldVYkduMXA0MDZyUUh0YU02bTV2dk5HendLMGdE?=
 =?utf-8?B?QWZWbkdjeUd4SlZTM0tyRmd4ZTNvNjJnZTZQdS9qOURwVHgzQ3VMU0c3Tlg1?=
 =?utf-8?B?VjJkaGJ2OVRkL3VRKzdEMGs3YmtvOWNpK1RUM1U3SkhSMGlocVMxT0VWS2NV?=
 =?utf-8?B?cmxZRTVRT2NWZGZYOXZlQ2thblRVVFYvMjdqblNaVFI0akFoLzRCQWNxU1Rl?=
 =?utf-8?B?czJnS054NG5lSkhTQmd2K3RMbW5GLzg1VjlIcXBqd0cyN1ViTktpTVNzYkJX?=
 =?utf-8?B?L0lHUFhKd1JmZGhpeHRQTFFmKzR4cFZsOHBYaDRSWDAwVWNsRHB0ajltcGd1?=
 =?utf-8?B?Yk1aWTZ3a0NZSW5OZXltZlYwb1c4blRXd2doVEdpdXR2ZHdOVjZCNDhJYUtR?=
 =?utf-8?B?UnErY09NZ2VkeXpaZmJ3YUh3Z2dRbkZkNjc5RTN1SDhyYXJJUStEZjRubWt3?=
 =?utf-8?B?VGNFZjBiWEFXQkhueVVoN1FrUkJtSXdCRkpUZ0wzSE44QzF0WXBaY0hXSGVp?=
 =?utf-8?B?SzIzZ25tdENQN3NWSmp4c3pNUEJiUUx4QW13aXJIUG5sMVloS2xrYk5Db1ky?=
 =?utf-8?B?eE1nUS9uY1c4VStRQTFvaXZCekphU3NzcWNYYkkyNXg2Q054b3RxNm9uOGJO?=
 =?utf-8?B?UE1OQ1Z0L1B6QldyaXd4cXFkblE5S0NHVDlJc2pxUnBxcFYwTEpVT1Zkbm9I?=
 =?utf-8?B?d2ZtNUdXQ2REVlhZeTVsWVpmV2RPYUVnU2NiZU51K0hiOVp3SGcvT09JZm5T?=
 =?utf-8?B?bEMwL0JNeWxLckdRTHNzaUZ1TEpVcTFhVEJsUmZoNFpXQkxVTDlGNWhHRThi?=
 =?utf-8?B?czRiSFpDcTNKc1g1NEVHdzhSWGtXekJ3NWN4eW5DK0NjejVoYVJBNUJLL3Rk?=
 =?utf-8?B?SkFYVWdDRDNnTk1WSERrdWtaYnZBejBDTTJnaFdKMVo0QXQxa01UNHNBQ0ZR?=
 =?utf-8?B?S0ZRejlDYktoSlI5OE5XZWh6V1RQcWhObDk4TVkwZmNucXFLMk1XaTdKL0V6?=
 =?utf-8?B?Nnh2eVEzTUNhQ1NJU0VSTCtmREJJSk15YkRqamZYRFdybkIzRERuOVZicUx5?=
 =?utf-8?B?ZVNHQ3FPeU5tVnQ0TmJvNS9LN01WczBUUnBhb2hFVWo3NzA0Z1lEcDdUa3pW?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6f6386-3b5f-4cc6-60c6-08ddf06a7941
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 13:03:44.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4n6LG14+U0wp782EsqGMbKsCF6Vu6SSw+NIr/0yYZkpCE22Vh6SZ63goYJHmajDhYgA2ch5qoButz/Pbc78zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7561

On 10.09.25 15:01, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Fixes
>>
>> In function ‘query_oob_port’,
>>     inlined from ‘main’ at ../utils/evl-net.c:483:3:
>> ../utils/evl-net.c:157:24: error: ‘query_type’ may be used uninitialized [-Werror=maybe-uninitialized]
>>   157 |         if (!which || !*which) {
>>       |                        ^~~~~~
>> ../utils/evl-net.c: In function ‘main’:
>> ../utils/evl-net.c:371:18: note: ‘query_type’ was declared here
>>   371 |                 *query_type, *vlan_list = NULL;
>>       |                  ^~~~~~~~~~
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> We are missing CI for Xenomai 4 to catch such simple issues. Tobias 
>> suggested to add at least a build pipeline to xenomai-images, until we 
>> finally have automated on-device tests. Looking into that, also to keep 
>> xenomai-images itself up-to-date with evl (we had recipe issues on top).
>>
>>  utils/evl-net.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/utils/evl-net.c b/utils/evl-net.c
>> index b45fa60..b1d06a1 100644
>> --- a/utils/evl-net.c
>> +++ b/utils/evl-net.c
>> @@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
>>  int main(int argc, char *argv[])
>>  {
>>  	const char *netif = NULL, *modpath = NULL, *ipaddr = NULL,
>> -		*query_type, *vlan_list = NULL;
>> +		*query_type = NULL, *vlan_list = NULL;
>>  	bool set_filter = false, solicit = false, permanent = false,
>>  		enable = false, disable = false, query = false,
>>  		allow_routing = false, set_vlans = false,
> 
> Merged, thanks.
> 

That was quick.

But be warned: your master != next now, commit-wise, not code-wise.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
