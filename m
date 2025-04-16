Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEF1DF246
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818714; cv=fail; b=LcE686D4WBoeE2fcbsqJ5sp//PEjzgk4wt0oItilRaweGkuQ4YKpSRNby1pLqAUh2/Gz57V5XkUMgf9V4RHgtJzz4W6j9DGjk3dlblgtN01JQppy9/YffKm0ngglK4EuTQXsFFAYrVJ9x764J47eL7GJ63p76SaoYHmUugtpcd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818714; c=relaxed/simple;
	bh=g4fUGTq8aMufivXK4fWxOqK2ZOPj4030E8CJceR9ee8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sS1nQapSsKbcnI72iy0EZsOtaM39uOWziazrV2w0ozRDvDfer04pzBfxjMSmNNEuhb4nvDBT2Tw6lCaBd/AyYd0YVhSu4EjNJM2U5buXlZPRyL+iVy/+lmBdtXv9KRQgt3cblkR1ikew4ovkEjeiKBV2l6B1vyZyagtEmQMyhB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D/HtQ/oE; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D/HtQ/oE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJkA6gZhSSFvmJqgHZ+6HuWsRWxbXoCZ9Q8LpbSy0i0hvQlgxcbPWG1Hy74ZUHNIOTMMhcE3GSnO2qmCwI/EFH9YwjzT2ADxnHmNYw4WGkB78N6P7f8lZniQ4ODA2aFva9fkFaa5utx0tMVdaj/WkmaSzL6GpT8/duePRxAa/OotwFZ0StKPqZkydsD9JkQJcIuv3HKSUrjjyOG/fhBBt0iW650oK+FbVNBN5O3Tccw5AUHQMEvGgaTDLrYN/zrl0/z2CWQaYkZ2rMOtyMkIRtmOC/xgz19o9igaFUnZO1ZJU17vsvXjd7mb5hYPPT1kXpwfP5MY9pWWmiTVGh2YxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42UninCi3C+XqrbqzhyF1c4VaPNhFezC+HeTkuAzTkc=;
 b=b9LXj49sI4TnGfV0ks5+qv3pTxe02HBeHA3ganTfnY0ajH4WbWzT15k5eoRGU6VXSd+OPd49Yoy80MbU5oBHOzbwyWBs7Mj7whELSkGSHZjwYugbaiPg/adSY2HDHJAYZKETeC3/4DDhyKs35SQvWmAZssRoIjQ5bixIAff7LZwPBwNyBAHiaGtX5+VAyn8fgC2hF8z+R+GeqJugxw5jk2IP2nDjpsg9QFOAOh8Yo94Umn8UqXPNmLh9dFoRVwlO8TXASAKOdFgw2Wj20euFAOYi90RN8RPt89lr+X/d4aOLqYVdWUK8RDG8wnRTH8uaq5lB9bWZ2LKS+QnSxfIgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42UninCi3C+XqrbqzhyF1c4VaPNhFezC+HeTkuAzTkc=;
 b=D/HtQ/oE3nATcI5ahBv+v4yCv0PLc2DeXLn1PxvpNhFPqrDHQUfu1PUKq0t1nFkaDx6yhoxEjUPqyBZpQ8KinwsWwI47FGarN5eM+Trr+UyqSoHPw+BXAjOsYftBnHsAot+njNLEAL896gYzdQIR6iMWAON+rxZXcU2i0ka6qlSdyWqwJfOAzHSAZApBWtDijnkYZQpzuWrgr+VbmuRoydeoDHZC41mC082GftsCm7LOYO+J54YK/LHNhFVEV9NqNZ12syjO4Dc+ES5zoTrcwKzhY1h4NBXJR3ZlDezkGOnpKlYbE9ztYZGp/BcosQiaOZnjahuFrbxl51a8Zl60Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3655.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 15:51:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 15:51:45 +0000
Message-ID: <d790fa35-e97a-4b36-b09f-cdd1c484a5d2@siemens.com>
Date: Wed, 16 Apr 2025 17:51:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Correct the default value of xenomai.sysheap_size
To: xenomai@lists.linux.dev
References: <20250416135148.1943000-1-aspirestro@163.com>
 <af3a7b56-570e-43b1-8257-9ab99b8c8f7e@siemens.com>
 <bvnm6p65ajubnex3c2m7mqnghy4halsqbfnlvwezt5ybqbqnni@pxlby72ybmew>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bvnm6p65ajubnex3c2m7mqnghy4halsqbfnlvwezt5ybqbqnni@pxlby72ybmew>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3655:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c7d55-5a7a-4410-ed57-08dd7cfe96e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRZd0NSSW9CbDR2cVRVb0dyOTYxZG8reW1GMXhzaktUd1RySGZGd1R6RUpp?=
 =?utf-8?B?YjlxOUh6RTFKWGFlV0pWaURDUmxnOE1iRXUwTGxPcHZEQ0FGS1JNcjArRDdq?=
 =?utf-8?B?Q2pwNUtyMm5lUHVTa0tzaUk0OHNadlBtQ3hVQWJ3SzdmV0lCQkJUOGVnRnNt?=
 =?utf-8?B?WGw0N01MVlJnV1ljdnJpeGFORDBHTytzZjBXS0dDOSszU1gwckpRc0ZmbFdx?=
 =?utf-8?B?RFNlMUthbTBKWkdTRjFZTHB5MHZvRE5HVXRGNmFTeDBsRU9NeG8xM0NBSG40?=
 =?utf-8?B?R0E2UDNESlFXMC8xNERpQmxJeCtydGxGWnhCUXlCU3EwU1hLN1dWakdOWjB5?=
 =?utf-8?B?d2MrVHkyb0UzUnVhaHJsUEgrbzZJYjczM3pYUVhhRjFUb21GVGdUT3R0ZWNK?=
 =?utf-8?B?UlVZQ0hzSFFuN3ZuT3A4ZGc4a2JmaUR2SnVEeEFMNWVTc2Z5QlQ0OU51d01z?=
 =?utf-8?B?ZGRPR2J2VzRSd1FodURSWDRnRTFFa2pGRlFUSjZNWG5KeFdWMFkxMFNDc3lo?=
 =?utf-8?B?V1lWSk5vWFg0WTg1c2xVS05nSEx2cFV0K0xwbVVGK3UzWnQrbG9vTUVWaWF0?=
 =?utf-8?B?TGNmY3V5eGIydVBONTY1UERQbE5Ha2pwY1pza1ByeVI1dlp2aHlTbEhGWWZu?=
 =?utf-8?B?N3lxQytBWk1qWWZFYUdQZkRyS2tQRmlqRjVIaGxMMVcrdFFKRVRTTzFCdy8w?=
 =?utf-8?B?aWJFQVYwUmZrakZ5bUZ4cG8rd1BHQ3Z2eXBFcDJ5ZDdoRUhYMjMyeUltMjNn?=
 =?utf-8?B?eE52SFROaHUyUTFwTzJyOGZSWlc0L2FRV0xmb3ZTNVZGNXBLNlV1SDNKZE4w?=
 =?utf-8?B?cFV1UUMza3RidkZIRjVtUHJEd3lpR1hEM2EzVlczODdhZ0k2NkNtZm85U0dn?=
 =?utf-8?B?cVFrOVpMd296em5teS81WXNwOWRtSENZTmxjaldkenV4czB5S3BYdHdJa01r?=
 =?utf-8?B?L2YyQjNCZGRtZmxDdGVzeWFRZUlvV3ZYYWRYdmVvajNXbWdvbXpsb1YrZ3I0?=
 =?utf-8?B?TU1WY000VHoxamVVaStlZkJYRFg0YVMySEQ0NjVtMTZ5KzVsbnpQakNQNFFF?=
 =?utf-8?B?NXNKb2xOUzFpRXdZb3o0eEwvWWZyd0w5RElyS2o5Z1dtMUlXZVRyOXQzU01s?=
 =?utf-8?B?dVNxM3RtNlpHQmpNbyt5WEFjR3lTdmZoNkIvQjlCRGpUTUY3WTB4NEtNZktw?=
 =?utf-8?B?QWlZVjZwVk44V3hMQ0JkdnB1TVFmTjN5TnNWY1dBbGFMR2VCdVNLL3JNcHFq?=
 =?utf-8?B?ZlY5MWlTTmdxaHlDY3RoOURKekdBZlFjcFNla0Rpa1JxNWw1SmlVU29Ra0JE?=
 =?utf-8?B?SHZQN3BYYU5LckVEdXhDZlFCb0xCalUvc09jZ25FZUgrVmltcUZwdXVRWTZ3?=
 =?utf-8?B?TzJrNlpHU3F1SDZuTm53WlhIT1NBTk5XTlEzN1pQVUF3R0t1SFI0ZkZpWHc1?=
 =?utf-8?B?TXY1bHRoSWFXWHB0U0hiYTRNYlVKbjN6VWZ4djIzNU5UeTlXQk9lZ2dKc1dy?=
 =?utf-8?B?b3o5MDRieFVuUE1sNGJVaVlLTlI1QjcyVWMyVFQ3ellWb3FEZnBTc2MxVFJE?=
 =?utf-8?B?aXViaUFFR0sxa0lUcUR6bGZnMEJyOUkyTWZKUjVEc0dkL1NHSlhSM0IrV0N5?=
 =?utf-8?B?QzNBTVpwZm1ZOVA3amlESVJJSXE0RWUzTUhod1lHclh5OW80d0R1VzRoNjVF?=
 =?utf-8?B?N0ZzVyt3SWlvdDNheElQVlRycEtJU0V0aFBvUFVWWmw3VDRETlk5VXZZbU1E?=
 =?utf-8?B?NDZNZk4wT01BeG9OUkhxbE1PaElwcjBpSW0yU0tOSmRta1cxVHM5dkU2SGVG?=
 =?utf-8?B?b0EvNEt1NldMTHVrUWFXZTJzemFSeDZvWWMwaVY0MHdEeno4QTB4alJ1c1hL?=
 =?utf-8?B?ZDZmNE15T1RWMldVenVKTkxqdTR0TTV2WXdDU3psN2JHVEdmMy9NZjNVWG9l?=
 =?utf-8?Q?g0Egd/Px8wA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGg3Y1NMN0trRU5lV3BzbWJNMXRIWlIwaWsyVU9Wa1FQbG9RYktiSGhGMTZt?=
 =?utf-8?B?TnNwNE1ITGZSeVh0M3U1OGI4dVFkeXFRWENjVmlDdzZEek56aTN2SEJsV3B6?=
 =?utf-8?B?ZGlnUTZ5WTM5bmoxaithN29sYzhpSFk4VTFZWmdQTzBjcXBrU293b2VKY0Fr?=
 =?utf-8?B?MWN1MFRVVHlURHhXajlaUVVvSFFIWVFQc3pVUXFzaGI2cFBFM2FJWGd1T3J3?=
 =?utf-8?B?QXVxTEpwWXZLN1VxTURWUGkxTDYwZ0UvQm1KSW1IYURSQWluWHl0SytTbVN2?=
 =?utf-8?B?Y055eGIyeXB3c3BjV3VsaDVoeUNGS3Z0cDEwamNkU1d3TGVtZ09xaDVwa1FO?=
 =?utf-8?B?Sm1yajhmZVpGRDQ1K0N1eGJKVVJBYkRpNENZTzYyTlAvd1diMEVndnltcmVM?=
 =?utf-8?B?cU9MZHpMSjVHZGF0dWI4bXZ2L3UvdmRhell5elVqL2owR1I5cmM1emxqVWZB?=
 =?utf-8?B?aFFiZWFyZ0EzdUlXbVV2blRHZjRDUG9Ya1JNTHN4WENaK2VUUDFlN3Y5T3dQ?=
 =?utf-8?B?b2Vzckd3QUMxVlUvZVR1bldHQS93eEhBK2hFbmFWeE9GOUQwYkUyZFZzUFBs?=
 =?utf-8?B?YTNsVXlObDd0djJOSHp3ZE1rZU1rZjBVWDFtMlg5bHZhcU5WTjJNUGxEbXho?=
 =?utf-8?B?blRVS0x6dDNhS09QQWlmZTVNMWJUNUxjZ1Jla2ZtOHlhdndGR0J0SkdZN25J?=
 =?utf-8?B?VU4xSVZkNEd5ZDFZT2VtaVVxUDd0RmdPYm9ENWlRQUFleTk3ditWL2VPMFZR?=
 =?utf-8?B?clE2NVJ4ZURCT1dRSmFXV0drd3lKVjN1N2lmTGJLeWx0YnhvcGE0WUhqUFFu?=
 =?utf-8?B?Znd3OHY0WjlsRkRneDYyUC8rWG5zU3BKSkUybjYyNCt1OVJLVTVobzhXYnJq?=
 =?utf-8?B?UFJGUzJDczVuZWcxdG1JMVRBQm9qeHFUM1FaWTlnYTY5Y0JKbi9OaU5Kd1pU?=
 =?utf-8?B?VmZnU0htVE1ONEFqd1hobnhtM1UwTTJETEd2QTA1eXRlcXh3U2ZNWTBMeWxK?=
 =?utf-8?B?RTM5dDZKcStBUFZTbHJnWE9nVko5QXMwNHMyTVQ2RkJ5VDZXYUoyMW1WYVFQ?=
 =?utf-8?B?aVBTenRVL1lkbXNpc0Zxc2kxNlFOS1N6ZG8zRmtRN3A3VHIyOWRqaEVIN3Ix?=
 =?utf-8?B?UnB2ek5JS0NFZ0RhL2tOQlRCTUwvTmp1cHRxMkdJRUhnWXRoOFNtb090Uzk3?=
 =?utf-8?B?U29OK3hwUHNDWlA2dU8yRzJ6OTY4N2E2cCtpYXorMzBaQndZM0tzMXZoYUFr?=
 =?utf-8?B?Z0xPYlBTdnpRbzJXV2pSUHcvc1dvQ1dCdFVsZ1FZTU8wYkV2L3RzRmFMZnAr?=
 =?utf-8?B?UnFkQlcyWjgzekJjcnpoMjZSY1FuejZmRjRIbnRrSUtHVzVDNXhpZWtZMWRV?=
 =?utf-8?B?NnlTdGlYN0VCTDZmY1RHUFVPQUpTTDF0dTlRRzlhSE5VWExWcDQ2eFRRQVgx?=
 =?utf-8?B?dDFuejhnL04rOXFwMklIMG9GYTN2NjdXeTNLNGNCVVJCcVVMYUw4N1BmSWxK?=
 =?utf-8?B?ZFRvb2NjS3I3OGJ4UGVyL0RNd3VZZFFnUGxydGlUSHdZSHRxQ1p4eDYxR01t?=
 =?utf-8?B?NlZaWmZxNDJtbjl3QUEwK21VUUZrRzY0M1lBVmx5K1RxVkQ1V09UNzdUanJl?=
 =?utf-8?B?SXdKL2hSc0dJT3lsRkx2SHlJWlRGQXJUd0xYNGhNM0NBem1FcXdUKzRmZkV6?=
 =?utf-8?B?OUVRTWl5ck1UcDZ5ZnBkcHJLSFk2KzhUUHBlbjMwaDl0cGVkMHNzOGVkakN5?=
 =?utf-8?B?bHBJL3NtU1lkWVZtZTlpQnYrOXZmZlZjSHJUU3ZvMEJUeGJSQm9iWjlkSm1m?=
 =?utf-8?B?U215ZWtTc3pOZUg4emVrNk5xWWdOdWJqcWJ4WmFZYTJEenNPaHRXV0lKblpy?=
 =?utf-8?B?eWR5aDJzZStkcGZ5eEMvZUY4UjBiSUVORE13Sk5rS0RXSVUvZ1Zxd1FlNTZR?=
 =?utf-8?B?NkhlYnFGSE15WXY0MExEdXVnV1lETmhmUXB1MExUOW5FRExndmliRm9kVEY4?=
 =?utf-8?B?dXhvOU1lVnVwbzdYd2NOdjJmUmtEbWpPTUd3RjVsRjRxS3NIM3RkMDU3TUZT?=
 =?utf-8?B?Q2c0eXdVTndmKzhrbVp3Yms2eDJKQ25SVEE1R2t0NXNHY2t3WXJNaHM5SWlZ?=
 =?utf-8?Q?auYBHuLkmI2Pp2X4FRbFNJ8Xt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c7d55-5a7a-4410-ed57-08dd7cfe96e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 15:51:45.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RZiH13CdDK/YWc9AS+vLueehXdMysYuok99TRvGVT/rs+DetIN21/N1nhXAPOBwuci0HJOTgJ4iviMHMlH4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3655

On 16.04.25 17:07, Haiyang He wrote:
> On Wed, Apr 16, 2025 at 04:01:33PM +0200, Jan Kiszka wrote:
>> On 16.04.25 15:51, Haiyang He wrote:
>>> By default, the sysheap_size_arg equals to
>>> CONFIG_XENO_OPT_SYS_HEAPSZ. Ref to kernel/cobalt/Kconfig, the default
>>> size of system heap (Kb) is 4096.
>>>
>>> config XENO_OPT_SYS_HEAPSZ
>>> 	int "Size of system heap (Kb)"
>>> 	default 4096
>>> 	help
>>> 	  The system heap is used for various internal allocations by
>>> 	  the Cobalt kernel. The size is expressed in Kilobytes.
>>>
>>> Signed-off-by: Haiyang He <aspirestro@163.com>
>>> ---
>>>  doc/asciidoc/README.INSTALL.adoc | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
>>> index 60f1f9149..04c102822 100644
>>> --- a/doc/asciidoc/README.INSTALL.adoc
>>> +++ b/doc/asciidoc/README.INSTALL.adoc
>>> @@ -132,7 +132,7 @@ whose members should be allowed such access by the Cobalt core. | None
>>>  
>>>  |xenomai.sysheap_size=<kbytes> | Set the size of the memory heap used
>>>  internally by the Cobalt core to allocate runtime objects.  This value
>>> -is expressed in kilo-bytes. | 256
>>> +is expressed in kilo-bytes. | 4096
>>>  		
>>>  |xenomai.state=<state> | Set the initial state of the Cobalt core at
>>>  boot up, which may be _enabled_, _stopped_ or _disabled_. See the
>>
>> Thanks, applied.
>>
>> I just need to find out (again) how to generate the docs for the website...
>>
>> Jan
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 
> FYI, I just try cmd "$ asciidoctor README.INSTALL.adoc" and it generates 
> README.INSTALL.html which looks well.

Yeah, it's more about digging out the deployment details (including
involved pipelines).

> 
> BTW, I find that xenomai.watchdog_timeout is not in the table of cobalt kernel
> parameters. It depends on ONFIG_XENO_OPT_WATCHDOG=y. Should it be added to
> the table?

Yes, indeed. Same for supported_cpus.

Thanks a lot for checking all this!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
