Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332837;
	b=1PYFzJ0zB+jKPhDWTDl992iKL8hqONKjDMQmEgPEhkSMplXmU2GcnfjXJQR2tFdFo7Fn
	 1pkrghmlRwPbmPAAA2TYfvl1+JSD26FV4DWeXD/yXxX2GGLx/LXsUhpWDa5VckSJS9zSe
	 9g+X8YNXTRfhYnkq26s1JziqB1dsF71II1oKCnMRLBCjgsdx7eUX3THt33M4eyHTzw8PS
	 ECEMfkMNMT7gjt2Oxb7qDWocCghSLCIs7b7NRiZwV0bi9/PiMacbVQY+aFL6gX9xVqkWA
	 vy92O1aGFmZH1QtNO/CjyaF2MT1BbdDU+c+nYBKB+JxEaljabNomin3tguE5SX6GjUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332837;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xTABpKRZqjKywl0pptlcoI4Kmml+t4zYP+ECzX9JrFM=;
	b=4no0+3pxwSueTD2JccKbOtzwCpKNLZRXPBE/ZkJelXUV7syL7whCGaTj9ifq/DjRcaYV
	 6lUJ4kXI33Z+oagkyXJ7Ddjq8ITGbxUo8aaQfDqEZXMYIxu67PKUxYDFQNvEmhML2pfwm
	 Le13gllwvmVDNjgY8c1pUEJW8Vt7GyhegLTXbSyVsu65o9wou7xCDSWs+3xGRbEAMYDTw
	 8vqx7leOi3Y9LMt93SxD2SmswfHNIMluOXMiIFJ2Cw3/hSVaVO295D5EtHijFh136QLWe
	 Ma6k9DBCyT3BR8ooYDS9SrZfIHiT1M3cxAF2JiSwkWJ4LzJcW46hIqjI0HwNtHExxuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NpUiVBjh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB69606A337
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB69606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NpUiVBjh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bph5MUjdgsux7m7cohnxYLKh9NxyLQSiXuMBmW57+Fudb/6Mtdgg2ociJDcv+PGNDoMj6yVrX90sPUXImWbyhQ4oDL3Pii3l0TxoHEnkGbC3wX0yxi9E5Ltfn8LtkHLzxjcKM/RPrKoZOICnxfO0maYyWEoWrGeSjl3NIdzY5GP1Mt74/NkbsOsdkfsoyqMqEEzlv0WD/3MWspO8p/fqeo5HU+OiSnRgYumAUK3v93H0+Rm0lhk/jMuO8TM5Kw8Rfo17c1Yv3bzknT1BVb3LTU0WaaFl8DOEXzDutBAPytfTbDwewc9DIB9V1l7aNjG7W35o/1uV+Gpwz6Ngi5zYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTABpKRZqjKywl0pptlcoI4Kmml+t4zYP+ECzX9JrFM=;
 b=bBKq6Jxi0221QpeCWbAPH52KOMrs+rmETc8k0TS5JQsms3ozXuY1LGsmuWLqFvB3uPhKlqxUtdmMb9k5Evd3rYc0pPVRRmQUCQ2AhAbhMYuneShWTWgcKq2MeNd3uTa/coAlaS7PenYaqaU146d5yAnOljP8o3N4IqsH2pX/LCwzioBfZVe0rkJAbFp0WxWBvUfICW61K2wYtSjNTJkp5Y97uDiLSESpzLvHuitDK8SYIrYHnq4AXOtLiFDOU3GnpC3xqFQ48bwlTPPBZKG3N5Ex/YYE9EvBpTpYLYa8IdMv0x/7zeGmHvhZotUCsFAdOfPxnUd+tXIqgz50VbKTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTABpKRZqjKywl0pptlcoI4Kmml+t4zYP+ECzX9JrFM=;
 b=NpUiVBjhf2OLJxVmVtV1tKPRbNZz752pEDQBy0fCNCGUGa+VCkWbI98t8DqvKJOgEyQ8eJw7DokI3bO2pCKKLe8nJ6kmD5iyV6schOo8FeZilBBA+0Uh2FTnG8jlhAn5hYA+J9c83HT/in5Lj+K04CWrWVbCwapK06GOUTqR0UhT/6x/zzLBC2nqMbsnN9ei4QE8lJmVnfOXxGah8kX7bSDDoQcQHvLY97flLzOv6f34SIIKKGclKccjBjZORKbcpTL2GyKvYzGfrtZ0hp0262+hvNICiwpYL8ZH4S04rf253NDt2EMvFq2/EV78OU+N/jStdQ0rubQkYdcaWVdCaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by BR2PR10MB992213.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:2c8:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:47:13 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:47:13 +0000
Message-ID: <2d9eac38-825e-4038-8b9d-9b15dc1c1b4e@siemens.com>
Date: Tue, 10 Nov 2026 18:47:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] arm64: dovetail: Notify the core about compat
 alignment fixups
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <4d7b7926-4a09-40c0-b4e8-d5512f8107ef@siemens.com>
 <87wlqk6332.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87wlqk6332.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|BR2PR10MB992213:EE_
X-MS-Office365-Filtering-Correlation-Id: 9379dc19-ffc9-4ddf-2421-08df3f52a6e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261028144727099003|11063799006|4143699003|261022115727099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|56012099006|261022075727099003|261022105027099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	g+12R0jdm16zKTQ+kOg5tWgmWy+yumcDs7VTAAqyXiyWx/mxChK5gkZXZT17FWuHnvrXeUhDzhayFiLFHBlZa5bilBeRIkHmTZ5iV+AhEEFI7XKJ6Sp51mKFjlWcO5h74Wwn87vJvkod/mNP3NJOOzo3apzYql9yy4TZ0+h5zGRNpJBIeOPsFbTLv4+ycMJUnScMh/plv83xlaFwtJTM/fdvY0q0bDFQp01LTE6/KipQt9T7pNxrsQsvCPYlU3B7Bpqewbd9uvg1vHpVYIt5kmE2ubJtk7su8M6Re/rb2F905NGQOSnoj3mu9CB1rLLJ7W3xLVOrmbjig7953mLQeVq0i70Xv4W662EnmOk2k0gRWjS35p/tztQYOtHDwI6SC1KqGXVRptMWMv1+WUEVmwnBUHxQNlEO8nVp5QzSVvqQbDa1L7AViskZmT5Otoff4pYE6OBc2W/opQRWzc4/Pu5JDKIujTDoaWkgNfVlwDbSfBlKAeNfyAiSVHto/ZlLUsjK57hEG18y+hkRJ7M10Ydg3dVQFrZdTWmAo1k6Sn5nLzqQhI5kzgqCUYWgDBJqx4jPaCsG6x5ed55tR7oInUC+geEKhW+yVVfT3LGyZbEll3hHQvaVT/TwirV2bo/QHiIbwNoimu4fhMHNNru+YVm9YOUuQBpKsUMeeCsnYRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261028144727099003)(11063799006)(4143699003)(261022115727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(56012099006)(261022075727099003)(261022105027099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjNKVGlLN1RnTklkTlc2NEY4cC80eWJ5cWdlWGNTQ1F3dWQ0Tmo3Y3Z1ZGxl?=
 =?utf-8?B?Unh6Zk1kVC9aVmR2Qyt3cXZLbVphU1JQelBvVWYxNk1HR0ticWVRZGRMUU1M?=
 =?utf-8?B?bTRXUmtBcnVzSnlQZXhRTDBOOGR6RjA3ZW8xVEU1bGFaelhiM0s4bFplYng2?=
 =?utf-8?B?eDVWRUdXRjNSamtNRW5hdWYydmFLcnVzbGdDTDd0emhkdWxORHZ4d0ZtWkhw?=
 =?utf-8?B?dkd4aXQvTlRYMGVUUkVIRy9GeEs1VzErbUdjTzF0SWRBaGczZTZwS3h2OU9S?=
 =?utf-8?B?RHMwUm9DZC9CT3hNUmpVYzFKb0dWUmNXRS94cm00YjRvbjU5cHEySDE1ckdL?=
 =?utf-8?B?MkEvL3FSNU53dDZxNGRzUTMvSHRmaEMzUEJKUlpIbmI4UkdUM3lKTWpiZnc5?=
 =?utf-8?B?Z3Boa0pZYnV2OTg0ZXVVNDcvVnpqZmpNdnlNcFBYdzZhNmxMelJrZDdDNEFp?=
 =?utf-8?B?dVRCQk5GR21vQzJUY282VnJ5NFpFeXRtaCs2U0M3M09JTDg3Y3N5OGJrQlI5?=
 =?utf-8?B?RTlZVE0zNE1qTEZHQWszY2k4QUJlNStuTEdBUTdBSDFYRm1IOFVobGs0bDVP?=
 =?utf-8?B?eUZGeW1hZ2VBdXZjcUMrRDRFNmtIM21laGZWaS9DSkM1NGV4Y2pUWUJMNFJj?=
 =?utf-8?B?S2QrWlNPbkZXMTBnSWh6K2lLWml0WHJlUnRSY0VING1zUHhoZ210M2FvaEt4?=
 =?utf-8?B?WThBOGU3Tk9mQWg1RlYwR0NJTEhQNFhobVptNlc2YndiUDYzL0cvME1nbFVt?=
 =?utf-8?B?bGI4VmJaL2o4eVBhaGg0NzkzN1FUeFlnRk1JWjVNU2o0UXliTGgzb0d1N1Zv?=
 =?utf-8?B?Y04rdzVJWlFweUF0WGlkWUpxbHhiUGo2Y3IxTGo2R0FITmJLSjcrZGVSZkJs?=
 =?utf-8?B?MmorZU9tTnhIdDJFRjd6T3RITE9PYXNQM1N3aG84YWxvOTBHY3BoS2Qvbkph?=
 =?utf-8?B?ZXJWQjQ1S1ZkUFlwbWc0bHpTVDUzNHAyOUJ3Nm9kcXo1Wk42MTJwaXlWVmxS?=
 =?utf-8?B?YzQxUmxnVS93ck0zckhJeGdmd0dZd2x2L3hnV0dla0xOZmQxdWhrRzM1TGlX?=
 =?utf-8?B?bU9rY1lBOCs2UHJpdlo3MXk5dWVMU01ZS0VoQnhQMldoZXAwVXJVcU9PYnZo?=
 =?utf-8?B?OVlkVjA4d3FzbDlSUDVERUllcHpoVmIwdjZ6T3hucWZDTVpDb1JBcSs3R1o1?=
 =?utf-8?B?eFZuZ1RFSFVCRWExTkRZUWJSdW41ZXBHN2VZKzV4TUhEeXJhdmFiOEluSzYr?=
 =?utf-8?B?bFQ5NEJWRXR4NEJxRk5yOHZsQUVNN0NJa3lJa1IwVzZ1YmZuRlkyQmVveUhU?=
 =?utf-8?B?RG5MaDVQbDIyYm01OTJhWVRpM3ZwTmNIeTBzNURKQUdaZWV0VWdQVk81NEZm?=
 =?utf-8?B?ZDI2VTN6QlVuQ3FPRGRJVUJaSUhGdnluSDhGbDh5RXI4eU9Zb3dJVVZTZ2tQ?=
 =?utf-8?B?a3lUUU9OV3AyeXNHM0huUXpvSTVrdHVzS0ZXM1RSWVExb01xS2RNRENQUTU4?=
 =?utf-8?B?RU1pSjhJK05laVdQTzgvOHJPS1dUNWdIblFBNTZIRUxQVlVyT0hzZ0JQdE5m?=
 =?utf-8?B?RnJYZGx1dmkyUlFIbVJ3RGMrMGFwcGlXSytKcnRJL1BzOHNBUk5hVVVEVzV4?=
 =?utf-8?B?T0xaV200MUoyT05EdUhRQlo1aytvUHU1Ykg1cFc1ZEtybjJoTFFqa2JydHBv?=
 =?utf-8?B?SmdrOTh0NEhDTHNGakM4RktBU0RXK0xQYVo0clorMUkyZWF4aVc4eG91MGJS?=
 =?utf-8?B?TUpDVkYxbFpUaU9lSW9LT3J1bUhDbHkrMDdDUWQyMjkvOUE4WXlodjRlYktZ?=
 =?utf-8?B?RjBURnJpRWZlbkJKYXZEM1NWcUZqVUlOTnk0UUZlRkJyUEIrSWRNY0EyOUtM?=
 =?utf-8?B?M21BM3FhL0V1NXc4K0tVaG5ZTXpBMGZyV21qSXcyVWhMcUxQbVRON3B6YitY?=
 =?utf-8?B?NE1rRXFhSGFYamxPeERURzR2MUFuM2hyNGd4TmxOMWNvbVBXNmhKMEtNK1Fn?=
 =?utf-8?B?aWZGM2VWNU9UdjJmbXRFVG0zSytWc3pXWHBhc0JmbTUxUGVrS1N5U1FQbDVM?=
 =?utf-8?B?NVdsaFBXSDdxTThXN0t3NUMzSHBUcTNJN0pWbU94N25SQUN1KzBqOG1BWm5D?=
 =?utf-8?B?VWxaYlJSZ3JJdlJoazZwZGVvcXhPRUR3dzQrcVhwSVM2YzMxYnBycGxtWnli?=
 =?utf-8?B?VXBseU5ERTIzNG1tT0RhNTZIU01DTExONWgyWks2UHVlTXUzaC83WUJpeW1v?=
 =?utf-8?B?ZjUvaEJ5d0VkUTNZQ21seVY0L1lVcnZYU0YyK1I1QXBXSTRjT0JwMUZ4WW9q?=
 =?utf-8?B?NjJEY2dONnBIYlFuVkFzNFJ1cjF6dDhDYU9ITWV0K3ppZzlGSW8rdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9379dc19-ffc9-4ddf-2421-08df3f52a6e5
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:47:13.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1xqsAt2qdby1v7LVEZpPSEmbtGO5V6RT83KacMZZTPd7VeKSgRv/+jtLEIjYcnnD66uP+y+cSK5ZeBydFQX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992213

On 10.11.26 17:52, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> With CONFIG_COMPAT_ALIGNMENT_FIXUPS, misaligned multi-word loads and
>> stores of 32-bit tasks are emulated by do_compat_alignment_fixup(),
>> called from do_alignment_fault() via do_mem_abort(). The companion
>> core is only told about the trap when the fixup fails and
>> do_mem_abort() falls back to signal injection. If the fixup succeeds,
>> an oob thread runs the whole emulation from the oob stage: it fetches
>> the faulting instruction, emulates it by accessing user memory, which
>> may fault in pages, and accounts a perf event, none of which is
>> oob-safe. On arm, the equivalent path in do_alignment() is annotated.
>>
>> Notify the core before attempting the fixup, reporting the trap as
>> ARM64_TRAP_ACCESS like do_bad_area() does for the same fault when the
>> fixups are disabled. If the fixup fails, the notification is unwound
>> before do_mem_abort() goes on, so its own annotation pairs as usual.
>>
>> Assisted-by: opencode:Opus-5.5
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This was a found by pure code analysis as most setups have
>> CONFIG_COMPAT_ALIGNMENT_FIXUPS off. It was not tested yet, working on a 
>> setup.
>>
>>  arch/arm64/mm/fault.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 2726eb3fa2d46..c3532ff0440ad 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -867,9 +867,15 @@ static int __kprobes do_translation_fault(unsigned long far,
>>  static int do_alignment_fault(unsigned long far, unsigned long esr,
>>  			      struct pt_regs *regs)
>>  {
>> +	int ret;
>> +
>>  	if (IS_ENABLED(CONFIG_COMPAT_ALIGNMENT_FIXUPS) &&
>> -	    compat_user_mode(regs))
>> -		return do_compat_alignment_fixup(far, regs);
>> +	    compat_user_mode(regs)) {
>> +		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
>> +		ret = do_compat_alignment_fixup(far, regs);
>> +		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
>> +		return ret;
>> +	}
>>  	do_bad_area(far, esr, regs);
>>  	return 0;
>>  }
> 
> If oob, we can expect MMF_DOVETAIL to be set for the current address
> space, so .text pages of the caller should have been committed. In the
> (unexpected) event some are not, get_user() and friends would still
> recursively bump us to do_page_fault()/do_translation_fault() on a
> subsequent synchronous exception path, which would mark the trap entry
> eventually, causing the core to downgrade the task before damage is
> done. This should work now that pipelined faults can pile up
> safely. Anyway, I'll wait for some testing, things might be more
> complicated.
> 

Working on it. Key questions remain, though, why we have to (or not?) do
this differently on ARM and if things like the perf handling are
acttualy OOB-safe today. The LLM is rather brief here, I could also
challenge it while finishing the test case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
