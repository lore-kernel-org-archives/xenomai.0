Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794463875;
	b=F7EJQXtpIzUlJ5PkQaoGFtP4ylVzC5Gu0s/zhj+IhGmqbQsUNTIm3yRIgt6KVmJaU7uo
	 Vn8b1fpd9A+hgCfAMWHEmfgZ+AYp3czyX8CNSW4T1+pw0xCAEbNH5DQ8UZAH8AC5uY3OC
	 0QVavdh1Kmo2mbTtZdGpNe6vbBEFtrjtHrMUCmwZjMsnAXDZtqVx5xhgH1J/TY8PedA/Z
	 jrKck21KsyWMZCaQFJwavkycEvGf8+IoFytetw51EqSIgo2u6dzOXiGQahDTNzzDzFpQX
	 PeWYl88cWDcBW2DrKLJHTO8a/USjaoZTdgbdaLLEFkHKwSngCvdOsH/HxwMsJPEd+Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463875;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-State:
	 X-GND-Score:X-GND-Cause;
	bh=3PFccaIt0yO/MbAnJ4fDLXo2xfbGotqwuUufInzFLy8=;
	b=JnIgdTh7wZO6ma0GqaEL0X5UuN0V648BdORm5dpRYTAY0xWohH9foDkMtsIpWexq29RS
	 an8sVeh5mHBTXrp3sK8D9b12Xism6+ICsXtUHYhumLVreia3PuziYunjSiLqqELb9qBtl
	 zJsssfYb29baPOubohA/58PVFnzb8Ij6atEfQBnINZECUMIjxCZQeXv7jebCkDkDGc7lP
	 nDfoaNoeNN/dIOGJqLUEg0tWBCJQxeaiXUoVQOLVDW+KAZ0i6w74S6w6LpNQ+tANgUuxA
	 SFUR41GbvS1eBa2qFBBkclsNb4fdk9dLTGdzIO/AU5Ll/uk4ATK1lw2iLTUnm+VFQuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dy4FWH3w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81E606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 06:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D81E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dy4FWH3w
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 9DE1B456A1
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 06:11:12 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 64F0EC007BC;
	Thu, 12 Nov 2026 06:11:12 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=dy4FWH3w;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv5MTLBuN5vEXBqlhWQoZUsYFtIH034xWsa9WTwD2xo8w8Z2z68kMVyUVXo+NtOpBbEBHbWePMRRhExOCvhREIhQV/H1evz41HYkrKKLlrKFCzaMKWZPq4GLkh52oUO90BlJAiPbsQHxg+KCViDP8+dQ0s84+d4WWyyrLAGmzEQs9QdSIWKWVdMTuMy0jcENrrZAYNLmaFtAviW7a1TH+ftN43Cjel0xjbKslJIZOsVHuywH56QGdD+14+PknMK8YVNEN4CT/sN2gx0GZd5j5R0vHmVE9Mbs+BJqi68SUTqC62Ex9TFzXHSxfJmuVpNBlW+bJtqhXuupZ6gUc5tBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PFccaIt0yO/MbAnJ4fDLXo2xfbGotqwuUufInzFLy8=;
 b=Vr57nLYbcRwyjqebWqORnOvDwH/ddqBqVaNEFdAhi5LRMLwrxB8dHFdBoh+vXf5OgiCDsaZ6XDwkYryCGAbWvZ6RDtbdWktLP95G0mzvcmzbgjll1+nHSavQGOYvQTqj39a+2w7Wsx6nOAjuHKZTHWGjnSGS8hKWSXMYBrT6nOef5NXSoFz88bz2TpRQsJ0dtJCWakxMJ61WWhx5sQYQcoPbTqhBaLYlaHoJVlwYjzxmgAN3xQVsjQlcAmOOOms4DqfW9K+izsLUbll9m0GmcmtB5eAdi2rqQzKEl9LTNume0lfGHlTiuUqriCnWhloxU/oxGSaGuJntr4PaeMWibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PFccaIt0yO/MbAnJ4fDLXo2xfbGotqwuUufInzFLy8=;
 b=dy4FWH3wuAQXwCtLo0t4GflduZPNuT8d1ZcjKJA+1brERmXX8EuDs2tLxhP6Va34xuuyW6nVlI30CSSLkv1h7ulMshtlkaTO6U9AvWk+XjzF7XYOTid2jRDQOVXUe47kSfWwoRcQHtuZuikqlRuOBbKuHnx8lFVLbdnlVBVXNNYAYE1h2h/KwP2bChw1BbozlaqxUOKR/HAKvJvvlvrF9j/W8cjCWPKurukStpZ9nPTuXyjK9M7T5JRcHHhnStGkkc3Y6LcUDhFqsi7oY65Qf2YgALx5ZYFRQcud5P3M5uxwS/HOVWRIaayXu8xAf6BP+spjuS1qPDPUcT8yLtGI+g==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB9123.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:443::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 12 Nov
 2026 06:11:10 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 06:11:10 +0000
Message-ID: <717c441d-0c1d-4445-b240-02ac57a34b38@siemens.com>
Date: Thu, 12 Nov 2026 07:11:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <9d863011b2e90b1562e5aef41394c683da5120bd.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9d863011b2e90b1562e5aef41394c683da5120bd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d509215-8a18-440d-9d1e-08df4083bf3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|55112099003|10067099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|11063799006|261021121427099003|56012099006|261022105027099003|261022075727099003|261021123027099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	4ErrwH0rguvccALu5FlM/hdT9ZSREoe1Gob5sOPrVO4nHKK7Iz6fkPJ1yqmj2X5EL4ILz7IZOjPhlyZN4Wj6MQQ8WMN7+t+FlJpUn6YXQwJFWE9CTu0MOr2Aoxz2UYDtGMSiK08AzWj2uf5tdIdTVqILtGjGHwDor3e4iQSNSHGSFyS2ryhYukVzVrN3zHFljb49WNHgnRnuJrDJrzIf1T/lMw1uGP65Qv3S5p/IfGlet3SS+nGSIw79f6DwVe+K8bJP/quqPcnFw0ZoQX9/pqT4MLonEXZ50JctjgXWg2WCRUd3wgmgf4jqLjiZ3EuwxmvTrZYE9XWsJa2iD5Z9gBObQ9FqfJhWsm/XMVwbmC0YuHURFGS0fUKtxIHjzVpLHnmojNEK4+uABnGgzWRsaR+/JLWLjocGWlKPjiPqjij11j59aCrxHNsbg/OnHctxt8Ex4N++D8MHbYTGXk+/CEBKyO5gJGgxniPHi0rKnLL7S/LERWVnovG8PikGCla+2N1bkQBMS27hH1cyJvouMuOV8UW4JWTQVTdARgKePuW1C6EkKvC6VN7OonUOKIzK+Bv28bpRuyIu5uC2z11LbFmfuACaiZ/Z/yDWIAs0ttIV4PGiGVlm6RsImgaCgYXETrTVJUfC2K27alKM+VNnfUIHRn1wezYygGsl7AYj2kI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(55112099003)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(11063799006)(261021121427099003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akdzb0txZXI3N3VCL2hrZGhxQ3VQNWZpQ05PajhQbUdaZWVsTUdLYVdrb3hL?=
 =?utf-8?B?dTBkbzBsZnZsNlIwNVZMZGxQNFNSTFRHanpoVDBBdnU4ZysvUCtCSGVUYmhp?=
 =?utf-8?B?MWI0dFlMczJITmVKU2t5UGJIeDBsK2lCVGRJMTBLalJDRDZ1OFNDelo4KzAz?=
 =?utf-8?B?Q2VkbmdTK0RPYnlxUkFRd3Bvc0RnNDd5UVpQY0JIbmE3QXorbFhuanNvR3A2?=
 =?utf-8?B?cTQvSjZucVBwRWZqenhzRmUyZ244WHhCdC83bTRDckI1bGJJQXBISGh5NWJy?=
 =?utf-8?B?Vnl5L3l5ZFJnRlFxN3NhWk5mR0RUYVhDMlNiS2xrL1gzS1lwcXJaYUR5bUEw?=
 =?utf-8?B?WmdxeVN1elI3M29MaWl4WXNUdFdrdHZsL0pVbWJYU0ZMZytxamlhVGdYcVlV?=
 =?utf-8?B?Z2FqbS9rUTRjeHRPL21PL0JiQldtN1hQY3NnY3hSc3A1RjQxT1VzbVBkWW1z?=
 =?utf-8?B?V04vSGdDRHhFV3U4REZDbFNoUW8rQ00rUEhVY1R1MVpUNDBTOHEzUURMbERG?=
 =?utf-8?B?OUJzVUxrMjlkbVFLZEc4S3k0T0dPN2NjVVVTSlByWGJibUorcUZoUkdMUUJU?=
 =?utf-8?B?WHFjemJORXFHUTkvenUxc2R5dzVKN0VEdG1yeG9xZ1NtcG80dmRBbDJaZFYw?=
 =?utf-8?B?ajllNStRK3FNNnBSekg4ejJsR0hnV0UvaGJMWTRndEhNVWJMSVRDTGNXYjhM?=
 =?utf-8?B?NTVmNURaRjhiWjRreW9xRG5TMWZqWitJMVBobHZYNlJqYzF6SDAxS1F2anpw?=
 =?utf-8?B?Y1Q3VmhpV2Q2WlhPTEpnKzg4ZXhrdDMrMncxdDBhT3p1ZTcwd3pjbGtzbkVO?=
 =?utf-8?B?Q0NRWUFRZjBiK2J2aExvYitMVzlQbnU1Q0FDaTlkZXdjcXNFNUdNeUt4RS9X?=
 =?utf-8?B?b0U2eldHREtNYzExc0k4dDdHNExTTU54dXFNdUMvVFAxR3llU3BXKzUxNURw?=
 =?utf-8?B?Z1U2UjlVNXNITlhhRUxvVkxHenMvYmkwcGlzUDB3elVwMWh6QzdmU29IWEYw?=
 =?utf-8?B?T1VoY3hWa3hLTEVJa0xqcEY2M01aVTBpZS9Zd1AvdWlwOWVZa2hIVDJxT051?=
 =?utf-8?B?elpYWWdMYXRPTjV3YmR4MUNWZXZnRzNseG9OeHJ3ZTAvMWN4NldlUmJMMER4?=
 =?utf-8?B?bHJYZnVhUW4xVktvSVRjTkQ3aGgreEJvY05YMDlOUnU3T1NhUDBFTWhXZ0pZ?=
 =?utf-8?B?NVRZS0x6QlNnNmZYY3VKRFIrTkw2UDYyRURoVE5uMVRCODhKaStNUzFEY0sx?=
 =?utf-8?B?bHk1MXB2NHdXd1NKQnV1amdRNTU3OTI1TjFKRU1SNzNPSDl5MG5SanpNLzBF?=
 =?utf-8?B?SExHZC9uZ0xhUlZJclYxMzZLeW54aXRNSXNycVM2a05GS29DTGZZUEFNaVU3?=
 =?utf-8?B?QW96Ym1iYUladklDdkl2N0tIeUdJWDBPWnV3d091MXFiZE1sclZna0gzOXA0?=
 =?utf-8?B?ejRkc2dJTS9RSm1BZXd5TzlQbXJTZTFrVmoxa3pYSS9ROWdxZkdtVzdNcDhU?=
 =?utf-8?B?dHdnb2czNkkxbzZqeGF3QU9VRGtxaDFxR0J3WXZFbGFVdzlIUWs0ZXBOWUVN?=
 =?utf-8?B?MjNYNDBNdHlkKzJIZEkwd0x3b2VQM2loVVNVNDdReXZSd2cvSEdPWTRyY2Q4?=
 =?utf-8?B?YnlyWEpMbnF5QkZyVVhNOUJmVGV2TW9KSmhDalJFbGsrbmk4UjBDbks0bEdy?=
 =?utf-8?B?ZGlHZ3ZFYzh1Q3kzSk5aVXJ3SWlKUDN4ZUQzbUZKTXV5aDJMVlpNcmhIWTNJ?=
 =?utf-8?B?SVpLLzRZL3huN2plMEpBNStLdG1mRnBJdSs0NDl4VU5uS3V2RElPUURxN2Vm?=
 =?utf-8?B?U3UramMrODVqUGh3ZXhVUzFMMkh2ekpvK0hoQ3FqMW1MS3l6YkVHdmVGTXBo?=
 =?utf-8?B?b2w5Q2x1aVlpc1ROWUk4bnk0Tk02ZHNqWFpjT0l2bHRRNjZtRlNPWDhsb0xy?=
 =?utf-8?B?UXBLTVppM213SVZtcmlBN0svNmhFTGlZSXV1ZVFKanVVQkk1Ky96VzFmOHho?=
 =?utf-8?B?cDZFd293YmNEeVkxeGM1ZlZwcXpBcC9qanhmNTFkS3c1ZUZiYlVhSUM2VFhB?=
 =?utf-8?B?MFpBcm0rRWx3M0dDdEFWZndpK0p0TDBYeUc4cnZtSkhvRVk0a0ZBbDc3WFVi?=
 =?utf-8?B?dWZRcUtwcGR0bTE1OE9tSnB5WVR2eTFnYTl3TGJuUEp1K3ViZXdiTFp2dlRQ?=
 =?utf-8?B?MXh4ZmhmaU8rS0ZwZ2M0MUxwN29INEF2ZHBqb3lGWnhlcFkwdEVya0NOMVh6?=
 =?utf-8?B?Unk4ZzZTZjZUM081cG9kcEJ2YzBmQk5POG9NWk9scC9XclRZUGsrUm5HUkJo?=
 =?utf-8?B?dWdLdVoxSjNXanhsckVTaXdibHc4eCtnQTF0RC81clFkQmFUUm1wUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d509215-8a18-440d-9d1e-08df4083bf3f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:11:10.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izGUCxYLkIvkBZwzgoy/fxH0AkoPW29xEDLKt5Ep13GfL4nLW5IO8DKNMbTYSnF/Hl4MM1GKvvBdkEzWWPhE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9123
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEhB8YwTdUsWU8hFeUV1NCEN3vi1uEWiJ/O6+SMYAqx8ERLm6YEVHAF7RicxpmcvAKsmk3LE0k7HfpK1u55+M4THeR6xIK43AJl5O3ah0GxVIS7CCARQpfpeDLISpj/pf+MeZ/p+Rmt/6iguOcIeE9GhL+GnvjMdGygoIU8dH//714wGcNnlpUeftMcKdf1QS2K+j6y3dYmE8Gr18QrcmT1kcG5vXvuKLPF96zO1Y4L1yjEhu6/dCUs/Mk3/i7KLDuLP4mcS4MTELHWLORKRnpNA9lzRetyEqvT1C9RaVOp5xS32+DRwhU6lS5qss/i0AcHVxf4J6FsFYQPDa1sTYasJBHiJHWNWVjsqjPbAPaQXScEJHziExSmS79hvB9vzXIjDGKPriwS6bMFCT/cr0mb2SFCPcuQwTDa1GupVZ+XVGipJusgiDDpmfio5567KASxjYJnkxzpwyw/ORL//Yopm2Q4vyq2nozc69AQG5Rv4Wv1HW0U8nXu3MYSTZcq05e/HmlKMQZwZQGvukVBsvaHARCf1wZr0JuvsmUdO2bIAn9awKdJbo25DOpJ8z3Fn5GXtIlSyeGdvzWbLG8fcnGEbDh8utFDgXxmqLC9/k+Izr30r4U+K8t5GWoQZOnbqa5qBMBBqw0bzmWr3CB0VeoTOJeBODO3QBJ6Tzm1WxK1sA

On 12.11.26 00:21, Florian Bezdeka wrote:
> On Wed, 2026-11-11 at 13:10 +0100, Jan Kiszka wrote:
>> [v2: rebased without changes, resent due to delivery issues of v1]
>>
> 
> While reviewing the risc-v implementation - and comparing it to all the
> other archs - arm included - I already noticed some problematic cases in
> arm.
> 
> I was able to address/fix some of them already, a couple of TODOs were
> still on my list.
> 
> 2/4 and 3/4 where on that list - with patches already prepared but
> untested, so not published yet - 4/4 was not on the radar yet, 1/4 came

Patch for is just because we touched the code already - it is
practically unused because there is no hardware out there which can
trigger it.

> up while looking at the other reports. As this is a good coverage with
> manual code inspection I'm quite sure we can trust the AI here.
> 
> The implementation looks sane. I'm a bit unsure about the comments in
> the code, but can live with it.
> 

I'm happy to shrink this down. Somewhere, I already did that, but the
rest was left to ease review.

FWIW: The related test case is in xenomai-3/next now, still waiting for
another update (and another kernel patch for x86). But the ARM side is
covered there, and the these patches on top of 6.18 fix the identified
issues the test otherwise complains about.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
