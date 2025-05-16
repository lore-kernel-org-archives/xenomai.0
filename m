Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AE13790B
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375790; cv=fail; b=FyAaoy5CANfZ6qP4nADOXv5EyvZvTV2IIvEiBlYbpfHcwFRssu+ik0kQCMqrqfOluQhfyeryHD236v+082QXRjcvuAehnZzLdqsTztn8vKa9dAHkjKEUAkXq4EdpmiiRh034VB6+H8yv0vg2NKz+p3JYNd9N9xcF6W346P/57H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375790; c=relaxed/simple;
	bh=dK619Y4zJLAg+k/IuTNupvoJOFt+bdJ02d4lUcu3IqM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfEP3Q6O1A6imPc6rqpt5FjDCC37QY1tLZXune6yxdK9ul9P38N0czTLU2CH2EXGeGhB3VhOnG7uDOD5hCEwYCqVI1hf8dX2/EzbxwYGarJQWJ4M8iN5NDkErnWidN7vi5bQgo/0pViLWmiBELO0UH/JhqNGSUB1KJ4gmv3tA4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=x1xk/ueD; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="x1xk/ueD"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 975FC435E6
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 06:09:42 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id AD5AD9405B4
	for <xenomai@xenomai.org>; Fri, 16 May 2025 06:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/PYzEkg6yKAUpsh9xAICiYuLkS10UdQrxrdBozj/LYfVOU34y7h0lMdWXOnPvGKWapAQdUK1JRg5IuHdBeyEB2w6kWVirJQSGYTTnDiE5ZwfH+AmXn23IDXKCSbU9VMG5h0FxpiB9DqzL+6VhrVUxp5LsK12DEdyZPipzf+voCYseayS5WQg85mW1vWQBMN+NbQHOXty3VAXOpKZb31rXZmhFNdsMagyIm8oGcA33agN08m7UwiPYSz7+AtONuhCByEVLJHSDiV3O2T7yh2fpsKmchVU0O+qFS0WitPExlvw6z03Si55nurB5erlHs5YInf7fin4OMauaPeJ8YjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz3XMOpTuYMS/wL4o6A+Wj1DcboUzdwwuyMirVWRyY4=;
 b=iJ8yKtiy2+6pxH2JeEKIl1Oo6+nld+2W/8trfFoek0bBTUFmLNLsuooRaakSoavVKgyXz7a6uHrCapfk6GCD3YUwygbepNtsVg5/auUv+zlRBmxHnoUXt9YMV95XSwrFFvMrpWHF+7U5ymjcK1NSuCrcwTV1koKo+uMvyLyu9zwQhCdbay7DyLRQrqO7+Vg750WqFAhdWW7g2Lhm+RiuZ9VjAb1oKwZIa/MZqS5mq+ykLz96kKUtsiTCgtYW/4qQs14w0i/7z45o+Wj9K7kSe+uBiCyKezDJWajIVSq8M5UEGl502O99uTLWyAY5/CH6zWl4tdk3s4uHgiKXrBBkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz3XMOpTuYMS/wL4o6A+Wj1DcboUzdwwuyMirVWRyY4=;
 b=x1xk/ueD8UZSksWxPhYwAWb34Ahbsgva2W/Esi8zjC9k6VLbJlAqmlsA4zRpshnvyo8Y6hL5UlWuwBQuonhBbdpArMW2bTFF02AkQlxW43cEfmwPkhImeXn2Cmu4cHsjlKktPhQ2rNOCPalo2tDfz9jNaioaomwABMd1GlHyjW2iUnkENFRYmmGPPVqIMZwtJXG9sde7pMKBNJZiubtq8/zHDhDNJFx/X5SlTvoDJ7UBM1PN/fW4p5yzx1AoL+G4hjjFtPwmrmnT+6F1oOkLgkIrWTtxIu0iiU2x+VR81W52MjE5p4f/vpD6RFBwE9QG9N8jKZOnvsMI3VwaWhVzuQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 06:09:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 06:09:40 +0000
Message-ID: <149e9ecb-4b46-499a-9205-ca7641e4bf7b@siemens.com>
Date: Fri, 16 May 2025 08:09:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
 <SL2P216MB2274E85F2E9ABB2A869F54B7E093A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SL2P216MB2274E85F2E9ABB2A869F54B7E093A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0641f0-9ce3-47d2-c2f3-08dd94403e1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkp0Zm5yZ3FKRy9jRmJrYlRpTnUweSt1WDduczlGWms0SDE5OTh4ODEyYnF1?=
 =?utf-8?B?cVRRa1ZhZFdJYVpUSXBuVE12dHc4SGgxUC9iTFJpV21nNXE3VktpQ0x4aEZV?=
 =?utf-8?B?L0JqVGtSM2hzMXYzWk9QcDdMbnZ4TFRsTmlpc2Z0MXEvRUp5UXRpSEZmdmZE?=
 =?utf-8?B?Q2xOQ0U2Qm9QVkZnMWhMQnZIcjB2WmtmcmpwODIvTUtRRXFBZE9rUlBXUkU1?=
 =?utf-8?B?UnYrOFdkaDVyZTJkNmQ4OU0vL3R4S2hwM2hJZGZHYXg3dEJ3eTZ6K3dUUzdC?=
 =?utf-8?B?MjRTME9aQ3BaQ0xzbktoK2VLbjZLdUZXbHRWc1VlamJuanZyTTBIeTFZOUww?=
 =?utf-8?B?TG9aRHJxYUlnSFVtOVljdUNndVFNSDM2MUlJN1JIWndlYkc5MHBCaUcxR0RE?=
 =?utf-8?B?ZkFUcnJtc2djMFlGUnAraUc2cDFsTU90VSsveTJnbDBvNTV4d2kvVy9zTjJ5?=
 =?utf-8?B?VThVd2dFN1RaeEMyaXFMeEZkQm1GZzR0RzNrWFhvOC9FZWpTZDBrZVRDcFEv?=
 =?utf-8?B?WFBLOTlRQmtSZVdscFpZamo4RGtxeTErTjU2RmZkU25GRGxnOE9DMHFCMTVr?=
 =?utf-8?B?a0hlblhxeXo4V000MmRZOTlwZUpKVGxHb1VweDlyWUh5YjRiYWxGVXAvZ3Jv?=
 =?utf-8?B?dUR0QmJKRWV0a3VRdE80M2dERkFUTVo4SUNCeXdjS1RSQitxVEVDWEtKbmFS?=
 =?utf-8?B?R0x6a0owN3JhQzYxWUpON0FHU2tsWHp4RHUrUGVmUW5rT3c4djdsb0UxOTBF?=
 =?utf-8?B?eW5BU1VOa3BqUVdtdVJ4RVNvVjJpRkRMcWNqOGt2NHVRMUhadUQwN1d2WmZN?=
 =?utf-8?B?UmV3aE1MZVoxZ2UzRk14TTI2anNWWVJMa1p6TjljZUJzU1c0T0VvbkZQWmJj?=
 =?utf-8?B?TVV6UVV5UGgzZmJUS0t1RUZkZVgwdlIyZklOTVNxQzBsNkF2WE5pVFBUQ2JM?=
 =?utf-8?B?M0x5YmpGTDJUajRKeHJjYS9SOThjR0RDbDFNTENrWVZOakxTZElmSG0wcVN2?=
 =?utf-8?B?Y0hDYUxFOVpwaEd4cWpDVGt4Qi93VC85YlkyMkd4VU1vOHh5ckw4ajJkTHFM?=
 =?utf-8?B?VVFQZnVtZHZQQXVxQ3plZm5FaWhocGRWNVg4RU9uVWZWSktybWNpWENXV1ZH?=
 =?utf-8?B?N0w0QyswM0JSNEU0ODl3M3dsanRpOVlla1pCdUJYaUJCbDBxbDZwNG9KQzV1?=
 =?utf-8?B?VTgxMDRTTWpRbHZJYVF6NFd0ZXNkcVZmNGF2RnU4b0pabllTTE80L3JHV1Bz?=
 =?utf-8?B?MEY4S2paUGtUenhHak5DWEN6MnhkalZXSzhiUm1MZWVhTis1WWNtYlBWL3Fj?=
 =?utf-8?B?VWVOUzJnQU02WVBwUmtFRTF1L0c1YVZQcXRhTy9BNERydGJzM3JHQW5PSDZi?=
 =?utf-8?B?MUR0VUk3SjNkc2tGV3RWbDE0RlhrYVE4Rk8vMkFVVUt5MlhmMDcrSU93aHRv?=
 =?utf-8?B?L0RBSnR1VDhCOVEvSHdYcnZ2cFJKbDJWUmRqS1kzSzJ4VE5rTmJNaFFXUitB?=
 =?utf-8?B?Q1NicGRZZDBvc04wSjlvU1hWQ1EzakM3OGVuNFo4MmxRZ1VjUktCSktucnRr?=
 =?utf-8?B?Zzk4Y29zNXhvcnNOOVczUHBXbDZERnFwSDBnTStuZzhJeUNwQ2x2aDJ2SjI5?=
 =?utf-8?B?eUVoOThrckpQREVndFNHZ2RFYVRXTlpWUVNmblZZVldTQVV4WU9GeTBTd002?=
 =?utf-8?B?MUNwbm1kQWExYTZqbUhTbG9kOS9oWWI0Qk9NVTFodUJ6enNRclJwZ0ZJa3Vn?=
 =?utf-8?B?ZWJVc0tzOW9MNUhCcW9iSEpaOXlXL2d4VUNHbDRZTENjQjFMZmlLSFJ4M1lz?=
 =?utf-8?Q?6m6Vbs+cd7Byly/zSDtVmVQTf5W5I+xw2hVLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURxbEhIWXhYM2ZUWXRwcmFpUzlhSDhHUGJvTXFYeGlFSWwwMVRvSEtteHBF?=
 =?utf-8?B?Q0h1Y2NheE9QQndadnlyak0yOXMwNTg4OXlBdjE5ZFZJZk9JLzhrUUpUODZr?=
 =?utf-8?B?YnpiYlZCOWJLa3ZaZWRWL3VFZitsUjNUQW9xZnh4L2cyU2h1bTN3VDlEVmRj?=
 =?utf-8?B?OGFDeUVkVU1xemZlRGFzbTc4UGwxYmQvaWhsNThlaGFwd1M2WUN1dWZNTVZz?=
 =?utf-8?B?ajV0UjB1V1JqTWNDREZwZU1PY0Z2ZHlKR21za1E1NFhTK2I3bFdoM2hQM1JI?=
 =?utf-8?B?SGdmNHlGdkdGN05CekRGbkplVEo1OHVnTCtoZFF1QW1zZUFMcjRuR0tmRi9T?=
 =?utf-8?B?Z1AzcWUvY0dqNE9tdHMxajRyNzJmTnIwM2FueXFCZk52bXk4ZXBrN3lDREJy?=
 =?utf-8?B?enVodEdNS3FYb0dmcWtYU1IySi9GUFJVTU9Pc2hTUVY5UnJETXJ0WkZwdFZv?=
 =?utf-8?B?SWxWbzZoOHRoTm5mTlRxYWdHNGhuNU55RFZoalc5QkVsYkhuWEtjMldoYUtO?=
 =?utf-8?B?NEVMZ2JOZUVFaVRkU2luaStLVFhtTkk2RndORVNEN0F2ZHQza3JaL0p4VFZN?=
 =?utf-8?B?UEZTTkNneUJXYjVWTHRVcFlCb1BLYWNSNUxBLzBCWXVaMElXUjlIcndKdHI4?=
 =?utf-8?B?YjFxZXg5Q0RBelFyS3YySmtxVTd5ZW5vcDFHOUYvaVU1cHEzSFRiWjJPT1FI?=
 =?utf-8?B?RGJ3OG1KTkRqWW5HU05qZmxvbElzQVdXUDlOMXBKZHVadm5YOUlYNE5wK0Qr?=
 =?utf-8?B?MjVuQmFFckdVRXhLNFlkVmlmUTVVTXduaTZBNExZaHRoV3BIZzR1V0F6UWU3?=
 =?utf-8?B?MU40WXBPLy9SeVdiVUNzZGQ5UkVWQWNjZjVqL0JvbVdMUHI1Z3hSekdYd0V1?=
 =?utf-8?B?QW9UU2VZL1JmUEEyLy9CclA5dHFBZU01ZkdVbFRVT2RGTWpQVjdpa3ZIRVlR?=
 =?utf-8?B?MVlKVVhNMVRTZzR5ZlkwMkpPZmpXSWVwd1FXdTVwNE41bHhxdWNKNTBxckhB?=
 =?utf-8?B?MGhXVGVPZXFKR3hjdmRVRXhYVUpiTXJ2U3pYanRxWnAyMFZKN2dvaTNUL1l3?=
 =?utf-8?B?Ky9waXJrN3ZzVzdGQkt4MHcxQVkzVFVScWcwQ3BsTE9rWk5OWUNwOE5XSHB4?=
 =?utf-8?B?aUlNZDdISEkxZjRaN1B1TmIrbDBES0NUTWpnUDVIUWhlcXNtb3B6T1hPUWRt?=
 =?utf-8?B?VktWSUpFZCtWcmlMdU14aHhUMW9Gc1BmaVpGYndqMjF0Nit3b2pmalVOZlV1?=
 =?utf-8?B?UXJwVk1CWDgyQW41bUZqSHF1SHhZcDVjQ0xJeHdsSXhEY3hNbFVhRkp2RnJw?=
 =?utf-8?B?eWhFT0RrVFVLWEpEand1VVpINSt2Y29nVVptZFlQY3ByZ0ZlTHNKQlc4YU9r?=
 =?utf-8?B?bU5mMzRMejhjSnFPcmFWUEJNWTRaSUJleGduVllmakRnQ29YNlBjYWtwTEo5?=
 =?utf-8?B?SFVFUjdPOXRqUmNRNkRLRnVhU0VNTzdFOGp0K092dTdLVkt4ZjNKRzRkLytx?=
 =?utf-8?B?MFV5WWlvWURqVzVleE9WSEN3Z3VZWndPcXVlallnKythYTFyMFVyVkQ5SFls?=
 =?utf-8?B?Tm1VbWY3bWwvWC92TVdUMXFxNForOFdYK1c0blFObXUrbnk2ZUh5U2pyVG5v?=
 =?utf-8?B?b211MjNJNzdsaDg4d1poN3hCUitwSFVITURndHFOY0dJOS8rYVJ0MzZrNHdo?=
 =?utf-8?B?MUpUdFJ5R1BIeVdidnZnTWhNRWVjTVgzS0huWkJ2ejhEMHVidDFLa09vMWZi?=
 =?utf-8?B?dGlNQ0JGSTh1Qm00dG5jSzd0V1ZrenVXNlFQL2hyWk9TZ2U4bHMwSXM3OXdM?=
 =?utf-8?B?K1BpaGVYQVRTZEozaUQ4c2ptS3NIMlV1UklpVnFSNWJmdmttbjhISEE2R0dw?=
 =?utf-8?B?QzlDb21jRDVnYzE5MHpndVBBYnVlMjBXOHp5V3NSQU1McFV2REZRQlRYR2kw?=
 =?utf-8?B?WkxocEFra2FDbDViOHc5UUppcVFXRFZ0ZmFnMlhHaG1SR080TW5uTmdEOWNT?=
 =?utf-8?B?QTJ6L3dWTmtMQkJzZFNidThXODhtVFhkc0RNQW5CVG5yWnpYU0E2VWFnSUxt?=
 =?utf-8?B?Nnl2SVc4MTkyQ3ZWRE96WXBzai90WUJLVWtxcHRJYVJjYnlyVHNUNjNldGNo?=
 =?utf-8?Q?v5CkhGwHp2vi9afW7DqJuHkGT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0641f0-9ce3-47d2-c2f3-08dd94403e1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 06:09:40.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl72ONV6Nj4zvrITkwQnugn/g600KhWk+Sy9mmi8UdfZldbdvU+9VEaxXFpZD5/ZFi3AX3SZ0BcUHS9L5gNdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4053
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="x1xk/ueD";
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c20a::7) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepvefggeduuedttdekheffieeggfeffeeljeeltdfhgedvjeetheduteekveetjedvnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgpdguvghngidruggvpdhlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecukfhppedvudejrdejtddrudejkedrvddutddpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddutddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 16.05.25 04:29, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
> Thank you for your response.
> 
> 
> Thanks to your explanation, I have decided to use 4 cores for Xenomai and the remaining 4 cores for Posix.
> 
> 
> It seems that I need to apply the Dovetail patch to the kernel.
> Could you please let me know the most tested and stable kernel version and Xenomai version?
> 

Always latest stable, see https://xenomai.org (this is now
auto-updating, thus truly reflecting what is latest).

> 
> Also, please provide the URL where I can download the Dovetail patch.
> The URL https://ftp.denx.de/pub does not have the Dovetail patch.
> 

Linked from our out homepage, you just need to extract it from git in
case you still need a patch.

Jan

> 
> Best regards.
> Junesoo.Im
> 
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Thursday, May 15, 2025 1:44 AM
> To: 임준수(Junesoo Im) 수석 두산로보틱스 <junesoo.im@doosan.com>; xenomai@xenomai.org
> Subject: Re: Please recommend the appropriate Kernel and Xenomai version for my hardware.
> 
> 주의: 이 메일은 외부에서 발송 되었습니다. 링크 혹은 첨부파일 열람 시 주의하시기 바랍니다.
> 
> CAUTION: This email is sent by an external account. Please take extra caution when clicking the link or opening the attachment.
> 
> On 14.05.25 15:57, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
>> Hello, I'm Junesoo.Im.
>>
>>
>> I am writing to you because I have a few questions about Xenomai.
>>
>>
>> I have an Advantech PC with an Intel i3-N305 CPU. The CPU has 8 cores.
>>
>> Q1. Could you recommend the appropriate Kernel and Xenomai version for my hardware?
>>     *If possible, I would prefer I-PIPE or Dovetail. I understand that I-PIPE or Dovetail are more tested and have stable versions compared to EVL. I might be wrong about this.
>>
> 
> I-pipe is in deep maintenance and only available for very old kernels (4.4-cip, 4.19-cip, 5.4) on which you surely don't want to start new developments. A reasonable baseline now is 6.12, and that mandates dovetail.
> 
> Whether you choose Xenomai 3 or 4 (EVL) is that another point, see below.
> 
>>
>> Q2. Additionally, from what I found out on the Xenomai site,
>>     dual kernel (Cobalt) is better for 4 cores or fewer, and single kernel is better for more than 4 cores.
>>     Is this true?
>>
> 
> The scalability limitation of Xenomai 3 has been addressed in EVL. So, if you have RT workload that actually needs to make use of all 8 cores, you better have a look at Xenomai 4.
> 
> Regarding "single kernel": Do your measurement with PREEMPT-RT and compare yourself if latencies and margins are sufficient for your workload. There is also the aspect of clear separation between RT and non-RT that comes with a dual kernel but not with a single one. However, if you sufficiently understand what you are calling, what then happens inside the kernel and how to tune that properly so that RT paths are prioritized, PREEMPT-RT is a valid option.
> 
>>
>> Q3. I would like to learn more about single kernel. Could you recommend any resources?
>>
> 
> Start from here: https://wiki.linuxfoundation.org/realtime/start
> 
> Best regards,
> Jan
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
