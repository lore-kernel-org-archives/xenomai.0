Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795171553;
	b=rnWUfANfY/DdL7EtLREQqhXppeMIp6968pHZi7+J70zVaL1O1NW8NDLbxZt3QLTF42uS
	 OL+D45dnC7j+pG3dSD2NVOvYJt5d3zhXssDwIS9igDDFFTGehh7PBwlAIC9HuFk5+IJ96
	 59As1i9hIqWlI+mxpO406DPjaH16e6wOETWw5sSLVNCRSVgN+fl44TDLc+teMvqcEFBqR
	 c16DNHl194xewhUU83zNZ55rANDoj/4bNH1F4rG7lAb8jvHXmJal0yMdPVz9SGm22r34Z
	 X8l7YjRHtkpoprkj9tt4AEqMYJdRiLCuhlWVLVkFQ/aIKvgD/8CA+LAbwX9/aQtKq+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
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
	bh=QEUL33ATG6ri6LV4Bj/miVzUlsiP08qn4w/APcBTJYM=;
	b=dE60wbh99AEcpDHJm5TqBntsaq5lF93GwbGEcJ9/LjphfLP2OH5YNaDTR/GS90f+iJUE
	 4ZNCkfMbko7R8uWS9uUiCrrNfoOUnwAkMeyMbP9niWvXunwMWWgqtrT8QECwX26+qULKG
	 vcIBTsDns8VvgcbXqdtemMAmQ+VCVa4POb5niDawy/1hvqE6tdfWTCESZS/KSuqf4FyQg
	 AYE9is7J36be+aKw+opveK7BRQrqKNi2W7QzXtGgEOj1tti5xfNw8KZ3ovjtTKo5XFt2G
	 fj4mge1SkPajbpKbOUbYh7z4m8d4JK9gf7JHRz+wIWVyJJo/MqDMv+a4rRm+AQLtFVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=L5nXq1oQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0060A381B
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 10:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC0060A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=L5nXq1oQ
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 4FAB83E970
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 10:45:50 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F11512680316;
	Fri, 20 Nov 2026 10:45:49 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=L5nXq1oQ;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c201::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb9KDVuHd/Vfg3oDSgn4sXYi8ur8+t3BEUvtEGkIixPub2Yqv8ONWBv/GSjQUOjZ/fb4ND9Io1IYLT0goAEJNLysq1SBh1Y+n8W9dv04JUV92dCBAVwxfrDDFwxmsSXziXMHtZrVdgVrerAdtJrsFYRtj+aOhEFSFxa8t7c3ONKlBUsp4xlDnluv11MJGCbV+nVE8dWW+2JtCOVghy42yCWAvgn40w/vceVFRJQ+ldRdLB6/3zcY5+pJ616co72ect9FDOsYRLmd+s5y1ZOzHs7K76FDzvoxx4731iiMtj8U08URMaviRAlcY1UyYW1qMy8JqZY0URNq07371XG7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEUL33ATG6ri6LV4Bj/miVzUlsiP08qn4w/APcBTJYM=;
 b=o3ZUwUWdAK+oLtXDo1ezDO9Nih3BBEh7p99csdXt7sV/YsCUKNw7HHmyUhflA44PEk5xEp70eyX8oLISQnjLolkBvmIPs3d0qZSM3RkljZqPzoOg2YLMHRuGjOPOiSn9nIGO+7Jw/TYctKOws4yp0XQMIi0hFj+rNJZ/eMQhM8H3BpyjoqO3hQbAQxoIzvTbeZChf/phk5OeEJHjE+dvY19gzg9HIHKdOEPVeqq690Nop3pqobQ/YOKbVAK1R9MhdjNu8chAjWWmXE/lo9hh48ghWzjfj4eM+KHztJ2Zq8zfo3Qhzbss810qy238wDv1TExla0owzlYt64U4N+nV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEUL33ATG6ri6LV4Bj/miVzUlsiP08qn4w/APcBTJYM=;
 b=L5nXq1oQehFFrTGF3MtRQjNYlv9Q4IxmIE7kFT9h5KJqjOOcIAi0R4XdVyZdIe9IBObEVQKzmAeGLmKPtDE6gbMT+N2ZJTl5k76phNnoJYscAN1csD3kMqbuRXkf3VIx16ikTPsl3Swl2mNV8mmGd8VrvuKLg8g/9c4PpfzC7smiRVY7SYTCl69PMDH0RmEoGUNi+HlWxZDng3RBr8htVJyotc2wHcmpZPDxyJVEeXo3PS7jT/89rd7xv1qABw7f4fj3VhasBzttjJxSEr7VgjO78embgk8cQAToC7FI3fNqOWbFbQfNSJecX4gdphbTnlXLir0jS4HRZU3ejlnwFA==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MI3PR10MB912697.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:202::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 10:45:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 10:45:48 +0000
Message-ID: <216ea921-e542-40b7-b0fe-3d76649ef4b1@siemens.com>
Date: Fri, 20 Nov 2026 11:45:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
 <576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
 <87h5hcoesz.fsf@xenomai.org>
 <c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com>
 <878q2namrv.fsf@xenomai.org> <8733svam8s.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8733svam8s.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MI3PR10MB912697:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f98b66-8a95-4bd6-8455-08df46f3704f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|22082099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ka91JPOYuu5YqYRQZb45uLj69KxzFN2pDQa3DVs8USlZHd9K3T6vH0+GxR7/rGQkNR6NWnieaU3y2ouXMXPva6gRa+j9n83164CdZhFVtfIyTaa1h9aQVPEFllvJfnZ1g7bYEXmcBehCfW6KFO1+bgTycQ49B3DHgIO8lHGvSa50J5FyTD/Qbc1cQdWGLOkawElztDn1kYnMKlxVXf83uLrQ/nUjxzp7xtL1jnAaB1Zr9eP76XHNBawMeUp6Q83Qs2ZrbWYlj5yjGu1zS5/PCS8QfXCN8iz5umG9OMvQNncoeZ9mGN+5UCATahu3Hj7TBZR5SQZnPtBeag9zJociNkm0XLrZyFz4p9eA288f/d3ojorZLyusBkJwlMRLJqKf2jX5XXrL0EnBgzpY4xB7ME5hGq1T4IB93T9zrj4Rj8rqZZ9gaCWJOQGouoe3Z8tyOG87eAUhlFQwpZ86M3Bmc4Zm1rAJ4jblwmOGJRGwqtDpYEU3jh6s/Vd9MfzTMdLysM27Qen+kvhfWYdC20QAOj/r13pefY8gLDx3ZYTkdtfmAsnX6I/jrdtcJO+5ODhgIZVywPJ8VQBa3p9Zi8O1qNcAjXjRev0pJaUr72i/ZT3sCV7nw6HlUabJwoBiiZH5jXQeNFlr/GQ81W4UOFNPQtCnfu/x5TM3vtaVMOs5q8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVE3NFhhV2Z5MFRQSktZdStyV2Mvd21UaFpSdUxaWEdKcXN0SmxsNXRKemdC?=
 =?utf-8?B?K1JWai81VVJkN1doQS9qU0xyUmJPbUNVRW55SUhUVGgvWGhUSHMzd2pWY1N6?=
 =?utf-8?B?T1V4TWUrMTN2ZFAwbDlzOHgxSkNHd28wN3orNjRCejJKTlFGZjV1VUlucHJW?=
 =?utf-8?B?TVJSa3ljYVA0M0lhTll1N0xES08vWjlsSWlvYlk2RS9XRXpMMzRxeFkyQzRL?=
 =?utf-8?B?QjNhemlNaS9hYW1HVHZkQWhhSkEwT2pMZWcwRFplQlJ4cUErVUVVTW92NDhV?=
 =?utf-8?B?c3hqRmZtM1plTjVGdXFkUG8yNmZJZVd4WXpGNmRHWllpMHpKYVlaaFNEYXQ4?=
 =?utf-8?B?cndUVkhSNTJjckMxUGhCZ0hYUzN5NFM2MXVJSmRRcjBmckUrQ0FzN2ZMb2ly?=
 =?utf-8?B?WkhBcUJCNHNjbFhTQzY4QWp1Z2F5ZlZBYTFCZXRrT3o0MTcyYWtSM0VRanRW?=
 =?utf-8?B?SHlHRkFtRElRSDFhMVJSOVVpdFgyZWl4OU84cU1CK2N4OHNWa3hMamcxcWVh?=
 =?utf-8?B?QnRZOW9XYUs0RXZza1hEUDBpR2UzZC9OK0Z4cysrL0pQTXgzTjdHY3ZjeUJ5?=
 =?utf-8?B?amJkcWNQWmxqc1JKd1BVKzh0dmJxVXlob1lKdjUrOEt0SitWcXFiQmk4VktV?=
 =?utf-8?B?SkxRRkNGZ3BJdGdMZU5acURIQjYvSHIwS2lrdTJPb2toOHN6ekd0L0VrMzNV?=
 =?utf-8?B?OTltNnpvNitwOFhPM0NKcCtPM293aFRsUWRjRTkrL1p4WEszTk1YazlXWEtM?=
 =?utf-8?B?ZURHRzVPc2lpSGtEK1RVYmpQNG5LN3dlRHYyb2NxL1RPZCtPamw1eUpyZ00v?=
 =?utf-8?B?NEVxenhyMXBxMXZnNzAzb21oeGNEWUxGR3hLTEoyUUo0SSt4Y3pVZWhxc0V5?=
 =?utf-8?B?NStRMXd4VE9yNEJ2Y25raGVBUkNQNlpQRzhoMjVCQ2Vjc2tzSzlpTVBvSzlw?=
 =?utf-8?B?TkFBb04yU0ZVbFJmc3JqbEx3Uk1kN2VISE5qT3MzQ2JMN1krQjZQOVNpVnR2?=
 =?utf-8?B?bGsxUk5yT2NHQTQyVE0wZ3FzTlJiaFkweU9MVkVWQks5YUhkaGlzNUdqMlQ2?=
 =?utf-8?B?bHE0Y2lNRUxCbGVhbGVlSHNVR3VVV2FVSHRLWWtDVHRMbWRZRGdTcmswcURy?=
 =?utf-8?B?N2JTSk5kUkJjV1dYUGY5ZWo3ZjVwM1hUTGt4Zng1N1ZSRXY3UFNPVDcya015?=
 =?utf-8?B?RkgxNGZrQzZSUnlGWU9lLzVRZGErb0dmZ3lpemo3SnBTSllndmIyV3pwZktZ?=
 =?utf-8?B?SjNUWnpmWUZKbVlXbml4TDBXbTk0RXZicm5iSGJ0eE1kVGRnblArbG1rTnpz?=
 =?utf-8?B?ZFpBTEFSVmdxVm9TbVBUMG5VV0FZaVlXWGd0bllLSVJZUklzSmRsT2duc3Mx?=
 =?utf-8?B?WDMzcEh6cSs0ZWZoM2kzSWU2bVJoeWVqZElkc3pLRXRrWWM3RDlCQll4cFdo?=
 =?utf-8?B?M3ExNXczcnYyTjF2c0JsaHljRTV4TEdqbnVKVVhJdVRvdW5lSWdpUVRQN0Yx?=
 =?utf-8?B?NnRVNVQ0OFN2Q2NpRGVsOG0yazN4NWtkUkR6MTJ6bHRwd1hPQ0dZakFYaEx0?=
 =?utf-8?B?Nnd6MGRwNzBNMUxEU3RaNnd2ak40RzlSTktuVDAwQUxIOXRuc0lEOHZrR0Fk?=
 =?utf-8?B?QS9OOFdUMFBaRVJVUjVaaDdYb2JtcDFQK1ViVHdCNDhIQmU4STFubnZ6UzZh?=
 =?utf-8?B?TEFoNW9Db3JncXJwa1V2OXdnbGl0RFJES2w1dk9kVXBYSmUrazNGSXBzaWZy?=
 =?utf-8?B?bnRNNVJ0LzdWb1pBY2VCbkwwb2N6aW9qbFR5cGs0bFBOT3dpZ0hlUW9aZFQw?=
 =?utf-8?B?SmtlS3NNZEZXR2ZpMlVKaFVhZFh5bHRvUXEvU0k2QmVRWWVoWGFPTGdWU1RK?=
 =?utf-8?B?ZXJZTGxVV2xudS9rNm1sZjRwT1UwUlE0WlVGcll2alJCQkI0eFhhaEkxMHFl?=
 =?utf-8?B?RThxV3o1aldRQ2JHT1d1RFFpelhUL2VBMVYzZjBBTW8vZCtScEY3WUVTTEF0?=
 =?utf-8?B?S1d2R3ZHdGlyQjJHU2VRQ282bXRhYUNKNjdIY2FLeVRZTHNYN0ZzdEZmQ3lu?=
 =?utf-8?B?OG0ybUo0TnN4ZHdDZEpVa1lOUHBpbXluamUxcE1kYmp5ZTEwbUQ2V1ZOT0dI?=
 =?utf-8?B?SzY4NnJzSGlpUHNhVUxIVktYTHNiRmlITzRUM1g4NmdvSGlxanJ1NEt4M3dH?=
 =?utf-8?B?L3FRTzUzMDRodzF3OXR4dlR0VTlBd3hWY29pQWdYZFovRjJ6NGFaNk5HSmZu?=
 =?utf-8?B?YVNWT2NsUHVPeE52dDZTTjVyM1RieEJVMUtCandGSzVtQjJJQk5JbklHd2Ir?=
 =?utf-8?B?UlNIRVpHK3E4OWVwbDVHZUVoVFp2UWJiWk1CNEhBU3dJRmxERVE3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f98b66-8a95-4bd6-8455-08df46f3704f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:45:48.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2AZeHInn+bfX7EbS8vVdRcLq6qx+NssPbbeXKFO6xDCjQ/5r3oiM/5YauHPmERQb7w3maxj6FgSrtzp3XltGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB912697
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGrIdPerzj9Dv94E0PeMG2ao97cEYSwd3xB5Tjz8CyUshTFaR78G0LsJHE/565lWUIkFGqqOrXEiOXTAzz9elI9OyYda+z4Oy/CQcmdXGlEiuTAvDo3GzLEV7N6wVH6Fj2peKb2nXJlUpxeRykwWqBc/6sskCkfIKwKcsi/56JB9vyuq31EorcLs4HknPkcGymZ8ANitR5rvODzl2rYhYDrU3JH5ss5efDK4W30dgvRW4vkD2qlvPJCLTMhqSKcFmbc5uoYq1EPAZCkA+6t9NWrzw/3qfc4MAuaq9YIEo35qLhpJmDvQK+YiwocplkVIvxniAOzepa5xcZPmLVPxuH0kMhDsvJki9O4iEepv0hGnIzggw3+JYw+FMgoq0sF87rumpPCobhhLMEo88KS26vsTzaSN+ewdACWp4Brul8jl0LB2V/UeuIUTT+0Y2d79iB0sSfccMI9XGRKQpdbPXLrDhQorHqi68G4e+duiHB6VOnHvap/JAhST0y9PmnI8FfW0vcK7114UVA/qPtJhCek/D1zfsYOTCtF7Y1n+LcKdmoYwER7ag2cXyJpRC6VgjMkwygy4pDqjFrk+u5O8VQZKivkiug5sd8vxhB3yqFbPbt+2ZyE2espglg/Bf7GabAOBQk3PNIqSTtxFAnNwJQJFBU9YP0n9/u5jpUmjpzAFw

On 20.11.26 10:24, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 19.11.26 19:29, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 11.11.26 13:10, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>>>>>> calls into the companion core if the flag is clear, and sets it;
>>>>>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>>>>>> it is set.
>>>>>>
>>>>>> This does not cope with nested traps. A trap handler running on behalf
>>>>>> of an oob thread may trigger another trap before it reaches its own
>>>>>> exit annotation, e.g. a user access from an emulation handler faulting
>>>>>> in a not yet resident page on ARM:
>>>>>>
>>>>>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>>>>>     do_alignment_ldmstm()
>>>>>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>>>>>         do_DataAbort()
>>>>>>           do_page_fault()
>>>>>>             dovetail_fault_entry()    <- notify suppressed, fine
>>>>>>             handle_mm_fault()
>>>>>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>>>>>                                          wrong frame, and the core may
>>>>>>                                          switch us back to oob
>>>>>>     ...emulation continues oob...
>>>>>>   dovetail_fault_exit()               <- no-op, flag already clear
>>>>>>
>>>>>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>>>>>> nesting levels, the flag alone cannot tell which trap occurrence owns
>>>>>> the notification. The exception frame can: every nesting level pushes
>>>>>> its own pt_regs on the kernel stack, and the frame is already passed
>>>>>> to both the notify and unwind helpers.
>>>>>>
>>>>>> Record the owning frame in the task struct when notifying, and only
>>>>>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>>>>>> exits become no-ops, the outer exit unwinds with the trap number and
>>>>>> frame the core was notified with. oob_trap_regs can in fact encode the
>>>>>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>>>>>>
>>>>>> A forking parent can never be inside a trap handler, so neither the
>>>>>> flag nor the owner frame can legitimately be set when a new task
>>>>>> inherits its state. Add a debug assertion for this in
>>>>>> inband_task_init(), which turns an unbalanced trap entry into a
>>>>>> loud warning on the next fork instead of silently propagating the
>>>>>> stuck state to the children.
>>>>>>
>>>>>> Assisted-by: opencode:Fable-5.1
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>  arch/arm/include/asm/thread_info.h   |  1 -
>>>>>>  arch/arm64/include/asm/thread_info.h |  1 -
>>>>>>  arch/riscv/include/asm/thread_info.h |  1 -
>>>>>>  arch/x86/include/asm/thread_info.h   |  2 --
>>>>>>  include/linux/dovetail.h             | 12 ++++++++++--
>>>>>>  include/linux/sched.h                |  5 +++++
>>>>>>  kernel/dovetail.c                    | 10 ++++++++--
>>>>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>>>>> index 23cae59037c1e..12ab7e49b7b76 100644
>>>>>> --- a/arch/arm/include/asm/thread_info.h
>>>>>> +++ b/arch/arm/include/asm/thread_info.h
>>>>>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>>>>  #define _TLF_OOB		0x0001
>>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>>  
>>>>>>  #endif /* __KERNEL__ */
>>>>>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>>>>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>>>>> index 48563d782a99a..934b080246146 100644
>>>>>> --- a/arch/arm64/include/asm/thread_info.h
>>>>>> +++ b/arch/arm64/include/asm/thread_info.h
>>>>>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>>>>>  #define _TLF_OOB			0x0001
>>>>>>  #define _TLF_DOVETAIL			0x0002
>>>>>>  #define _TLF_OFFSTAGE			0x0004
>>>>>> -#define _TLF_OOBTRAP			0x0008
>>>>>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>>>>>  
>>>>>>  #endif /* __ASM_THREAD_INFO_H */
>>>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>>>>> index 820a596d9bf65..11164e12317fa 100644
>>>>>> --- a/arch/riscv/include/asm/thread_info.h
>>>>>> +++ b/arch/riscv/include/asm/thread_info.h
>>>>>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>>>>>  #define _TLF_OOB		0x0001
>>>>>>  #define _TLF_DOVETAIL		0x0002
>>>>>>  #define _TLF_OFFSTAGE		0x0004
>>>>>> -#define _TLF_OOBTRAP		0x0008
>>>>>>  
>>>>>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>>>>>
>>>>> This hunk was forgotten while merging the patch.
>>>>>
>>>>> Jan
>>>>
>>>> Not sure how that can ever happen since I'm applying patches with mu4e
>>>> directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.
>>>>
>>>
>>> Please fold the fixup commit into the original one, or we will have this
>>> commit twice in the 7.3 and 7.2 trees.
>>>
>>
>> Not yet, this will go away when the whole stack is squashed per topic
>> next time.
> 
> Unless it breaks some of your tooling.. But if you can live with it
> until dovetail 7.4 is out, this duplicate will be gone by then.
> 

7.3 is likely the next LTS. Latest by then, this inconsistency should be
cleanups as that tree would live longer.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
