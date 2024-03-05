Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAF79DA9
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626002; cv=fail; b=S0YSe4T2zLHAIv1Tmqwfd9aTADd52V3T+pw5/8fb5ubamMqgxumXyPiZBBxyWNniTp3jgLqwsyQfLP9C6QOvhV3ydrObwDSgnU43At+RCN4CQykZ8qGyUpKEM/inFCtusl/tHSvRGwqCPm8ZiQ7+hxcYwVdKv9yRtJga/eZMeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626002; c=relaxed/simple;
	bh=0C74/s1TWdmDUv0o3Bm9gr887tt+EMYwgJ1StzcJBm4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kpNcE5QVxJdFG4qUsPDORSYud8k96t74COX6UPlq0ApLcKN/uaj7pwEr2vdIQWX/86bWJbtj3DVfkdbWLxMGlEuNHKfAcMEfpp+y1YTc0+NL8XCf4M695cWCF30WGNzkZCCmC9AuKeGiWfUrmFuzUPH4ZOtNB/rWLuQOKI+qzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UtucIH+z; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UtucIH+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTDhmP8owdvSIJsr9QMw/kW4fAD0V6RkudM0QcElPQBR1dO3Ktr5eYK7X8hX4rqImZpwO6hFnQ0xdmw2X0rG18DtIySxVZtn/13ogUeOmK/VxVvhNf+AFqrxwYE2i3H4xvQenDwRR/QEul85DqL83Gn6HC07zuCSJIOHN0Igh1J6n8LV7sujMnqWtINEzc5JkBkwtF5eiwjbDxBdP6t8C9NNI6JmI85FuFQfQR5djRDlO4j8zHJ+xKWoqHj89WKpfoxHvLu7iDV8p7MLfdl9fAXJYo7GSYbie8M9JsxKnY2Cw0eh2dQ4NPamIsxuf5pjI14eH6tgXWlFaGE/uxUWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eki93svxKHkVZfaq01B4QB+OD05MvkQ8BfbPSIRUwjo=;
 b=O934ElkyX56F/UTzU7Na3mPkR2QfORA3dw5pWbsVXI8QaduKoL9ZqQUMmoQk619IZEOFsRG41BjG+Mx2TbMR9JnalkESbVqQAclgyV++es5ZB5Vv3CJ18fqdyLL56gq7MkIk8gE2CUSZV2CgoeHWqS8mobPQir0Kbur5LJUQgvaPCrvsfKfKW8UkegNkhxSXUojl+Tg2gdHZ8Awxes+ajU1UUu/0s4+m3ico8YiNgXeyMIKCwHwvpyXWYy49b6L/3eGiYnDKLf6JapB0YhRJ/1Z/FR7xpKM7P9xG0P4mS9yqvKlZsjCPjQDkNKg6r4l4IrJUD3FI42FgCEVJTj7gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eki93svxKHkVZfaq01B4QB+OD05MvkQ8BfbPSIRUwjo=;
 b=UtucIH+zLAur/TXGiGSZ8sj0q7WGS3O20vi4RDWSthUIDVvxWp73zL2ri2ZKX+CUKPcuAq6wuZLByr+f4NJsv9AMWs+hP/NzvGRDRi4+5ceUMzrotVGLjwfsGrB21V1XQXGIy2UKqrPUKzOLcvZWi9Aen0W0sE+Uv2bbhUMepQpkq6AdreGQtcKMEcWXKtULrfboY0KUUj5FcvyUG64za+ABiYlcHccxrlQoU/Xy/9soX8b0osQ2y49/GYnZGdylFD6eStPNN2/MzYWmR78BcWz31/Ym4lT7MuB+10gTl7iDj5+kIrNE2XKj4tSdvTTjQUx7TCRcw+OEpsa8VMomfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 08:06:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 08:06:37 +0000
Message-ID: <d3e21978-3b91-486a-bfc1-6d851f2bbd74@siemens.com>
Date: Tue, 5 Mar 2024 09:06:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai in vmwear
Content-Language: en-US
To: =?UTF-8?B?5a2Z5rab?= <suntaoworks@163.com>, xenomai@lists.linux.dev
References: <abbbd8a.85e2.18e0d30c733.Coremail.suntaoworks@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <abbbd8a.85e2.18e0d30c733.Coremail.suntaoworks@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:610:e5::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a262f-5b63-436a-a4ac-08dc3ceb2e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IBEzFgORKBfTSJYkttRKeYJ+dxzAg6P/o6IWA30u4cjBBrUsMqa5lcgq4vKhVgkqvlVQ/fjB9Uet0cVyDl8Dph1VS/hxFD2zK7gOC3XV99bUA6S/JW4jtrltN4QVMjAkOYWu/ZSOSO489QZH/OQPgsdWmiPIlctFg9nDoI4NkDjJfMW2uk/6DblVvX52ik9pxN5tiX5BraW2ZIDRdRiM8cpebi2cW16iFVZPVcJp70/hKzVKw6NHK2J+tuUbe2Yns4LyZn3n4DHwzhzeHMfQfCCkfM6TrhxeK40cnJCKEDh4lTCth1mcXr7cvCKWSj7YdjCrBHw83iy+mzQDW+hJW7LUOmt9sSvJup19dtuAOJxiOQJqiQZRax9e8MMyTxZAl1P/BWlaY/l2AtRq73iLQXJvIWa3Jgailr5tKpihSuVezaX5WJEdJ+vI59dwsAei88pHwrDo89Z4w9SpmKW9R5cLRz6gUBwd6nQJYFf3AXQnkGXeDX0pH3YVutXlaz4SQg+tfwRrrBxaQRIDCiuM8S6k3MjNvi9kxxvHOCSy3szV4vxIeDeoaejhwWudfcH1mckLZcvIpwdFuJmF+ApuWVfu4Fdsu4a7GNYpSlKowt3Yar17AF3C28PGQ4hONn7X4Ciyb3yi4QRJwS6j/0wJxBNM4frbjyxicSLeBnVjeKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEdGV0lxOURucmlVOHMzWnp1L1dTWk1SQTRSdVRHa1JwYW4wTWRsaDdNbGQy?=
 =?utf-8?B?dWxaVmlwV0xPc2VYeVNyQWJxVFJiTlNjSVNGRWZPbDByVjcxMmpoelc3WmR1?=
 =?utf-8?B?dm1nWXpaV0kwRTJVbEMwUTdNdXF3djJhY1V4Ym8xQVNOSEJuRUVPeGxJeExp?=
 =?utf-8?B?UUFyalBsbWc1TmFSbkFEdGhYTG1CblpnNjBkYnN1ai9VcUJLWWl4VHU2Z21G?=
 =?utf-8?B?eTgvci9DYzdnS0RVZGxpYW1ZMVlKN0c4enRnZkRya2lEU3I5MGREdlI2bVZI?=
 =?utf-8?B?VGlsM0ZyODhCWDF2WXJMd2tiNjN2cTdkbTVzd3hiRk5sZXEzRzBOS0RMZVFW?=
 =?utf-8?B?Q0hLRW1PVG5WZk1TTWlHa2RUUmFLdEIxVFZnZFFmZlZtSkErOU9WNkMxaUV2?=
 =?utf-8?B?RkhDU2IxZ0pneVJNQ25VdjcyU1BuektFMDZnTmhiNUJDSkwrS2R5NVJWTmJC?=
 =?utf-8?B?R3pwWklWbktSenVjeGU2UmZCaFVwUTgwMTlud0g2cU5XYmpnaDZBRVBhM1hQ?=
 =?utf-8?B?SVd3bXNDc3Juc2RkZVE3a3d5K0gzMG5lTDlLdUZhdEJpdlQ2WjhNUkRoRHVT?=
 =?utf-8?B?N1Y2VHEzQ2ZrbkNCOFBMUVZiMGg2ZDFDbDFQSnRrRE5hNjU2NGtBai81aGY5?=
 =?utf-8?B?S2Q1ckhPQUUwalhLV01sT3RkYlFVbENQKzNNZ05ZK0U4VVhDcU0vYjhGdVVp?=
 =?utf-8?B?U212ZklPcTB6TEZ3MVJ2TXpENTFBUlhBOWhJbEI5aXlkU3Q2ZGUvNG5lT1Vk?=
 =?utf-8?B?TGE3TktBVFlobkxESFc2WDB0RG1qQnZqcnQvczdQcXowUVVEcjY3RUZ5eU5j?=
 =?utf-8?B?SDFKcUVma2RROGVSVUI3cUd2bk9tdTY1dTB2dlU3bFBweDhQc29uRjRMUnox?=
 =?utf-8?B?LzFkL3lxOWpGWlc4SjdCLzJpZ0lITmZLb3ZIOVhBNGNqMGdpamZvRHhncExS?=
 =?utf-8?B?NzJRQXlDM0NnNitFNVl1a1V2Z3Nrd1V5WVNCbmdzZmZGOERHam1tekY3MGp4?=
 =?utf-8?B?M0llRXF3SUV4UkFvakxOODlaYmlJc0IrQXFaMnZKYWRhaXExbm9xeHRPdlVK?=
 =?utf-8?B?R0F1TGVoYmt5WmFFejRDOGVNdUZBcEZQY3pvYitmUHNzTDd5K29naGVKLy9w?=
 =?utf-8?B?T0lKVStZVW83STQ4Q25KL3BKVm8ra0l2azc1R3liM25veERucVNsbFg4eExQ?=
 =?utf-8?B?MElERlNyaFJsbnhzUVpZSTdKOWc4RXlBNDl5VVdzbWVGVWkyQ0ZRb0tOdFkv?=
 =?utf-8?B?OVBUNVVxb3RqVXlqR2lERzREbXJIMjhFRTk2djNMbWM5c2dlSjhDZHBKTWJL?=
 =?utf-8?B?SFMwUzd5eDBIcEdFOGRmTlRGNGw3Z0hocFNQYU01aExkdHZOTlZQK3diMnNw?=
 =?utf-8?B?akJmWlJrRERJalh6T0Fkb1NTV0RRQXJjRnZOMWNIdXBYQWxEeFZ5T0g3NDV6?=
 =?utf-8?B?ZFRsbUJ4c3RrdjFqUW1YeE4rRUwrZktPcVVvaldWVjd3aDVKMlZId05wWVB3?=
 =?utf-8?B?STk5bkRGTS9zZ3Q0bEJQeVN4anFNRVVXV0xrb0xkYXQzUldIM0VyMGtHdGNj?=
 =?utf-8?B?ekIwR1dGaFV1Z1lzVGlMR2dKMktiMGM5dWJ2bnNydzRSdmFKWU1RSTg4U29N?=
 =?utf-8?B?V1JyeTQxM1FPRjBnOXhScXcvOGttREdaMmU2eG1RR1FHY0NFS2p2K1h2ZUMz?=
 =?utf-8?B?bEtyNFZGY2QySHBMOUJXeThjQjZGZ2pNTG1XRUJEcklrZW5PMHIxOW1pUTk1?=
 =?utf-8?B?dGgxa0hqVXZQSE1hRWtXMy9JVEt1dDlnb0FsWi9hYWE2SXZnU09POXNuWXU3?=
 =?utf-8?B?Rmt1WXBVZGZhTjh0L3RURmV3MGQ4MnZEZ2ZNQWtZazJSYkZoWjdCQkYrVmRV?=
 =?utf-8?B?MWkrT0JUVDZpTHc3RUtVa1FUS0NjWUxVa3AyUGgwMzNJSDVJTDZwTm90SDg5?=
 =?utf-8?B?eE1GT09telhLS0w3QkF0Q1JBcFZsN3VLMmw0aG5IM1F5eXJwWDdPdU5tSEI0?=
 =?utf-8?B?bUJucEJMS0FhNEtmemlJNFc0V2FnZldnaGx2WlRyU0c1VWlCVzJmeGFQYVlX?=
 =?utf-8?B?aHcxTmxHa3ltQnBneW1KZExab09oTEMxRWVwN0hlK1pJTWxWeUJEMUFPN3VP?=
 =?utf-8?B?KzZKZ09YZTFrNHRrZHFQbnoramY0L3l6NFNkQWJZaW1iais5dW5TeDZWNW41?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a262f-5b63-436a-a4ac-08dc3ceb2e14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 08:06:36.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hacZNeIHVWfVVkS8vy2VeoaIvaNlUctNOsekhtwulkp0ViN03XoJMvvlvFPwxFCQizIyD+xprgvXNbWL4yk0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5238

On 05.03.24 06:58, 孙涛 wrote:
> 
> 
> dear maintainers,i use xenomai(3.1.x)+linux kernel(4.1.18)+ipipe+debian8+vmwear+vmwear tool for developing.it works fine.when i change to debian9, it can't full desktop(has limit dpi).i  wonder why? same kernel,same patches,same vmwear,only system operation is different. i also confirm that xorg of debian8 and debian9  is also same.help me,thanks.

This kernel version in unsupported for about 6 years now. Time to
upgrade, likely directly to dovetail.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

