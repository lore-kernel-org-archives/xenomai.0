Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529970;
	b=OKS4XXIpTUcJypfltW01p7k7EtGfZunfW6GGjrjyBaziN6dC9LR3IzDNsUFnzvrK02ut
	 ZWdxwqhyAbzbtuXY16Nj00JwZsb0IAMy7p1NscNU/Ro21rWn2purvjjvNB+wG0tBNbiN4
	 tIQ3yr7bvP2paN3Sa6QnCdpx94Z2vnvgEzrPV+fmq7sxtV4LbmmYL0LxxkcDtk82ta8u1
	 rIoaXyq98SJofGFAA732d3tDNQWq2zKSWryax7gbwVdIjxJ9W+1pJDhEjvoXDE8IYu5sM
	 Wrz+QvIePN2dmMQEAIqRMq9mljGN780fRBBC3ey1GexdG2GpL8JBzyE0AgKO+7rdAGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529970;
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
	bh=rU0+Q3GgXva9NXNvrcbtTIUgGguDGmdqF6mJsI8YzqY=;
	b=SnbXhOdxxJfiN/iwiBLBT/S5KP9f9+voKlnrdoBVlD1gAvcZrxHpaA8JoDpKSQMaqYgs
	 mLidGseqbCby9jrrs9PF5LPHi8qcM+dQEfxl+k91p3w8XQjltrTEuXDQeqPwZ6JceCFtD
	 vWsRkc6rwFiPG2hP9Y9Q8C45mpnoVDHNd+uqwRDF0BBVGGV5K1bKfTluo/GdVcBo4QZ3T
	 cuvBYjTLXeYEH8PQQ4YpW1K+E4CvRLlthGTv71IXbftD5SkP9DmLkKYZ9EqIP0vdJgMqV
	 8OkpBlQWn8UhEbQ6Rl2YXePXGby6pHXSUKS6+mJM+Y6HnWf/UJZmvAnQWkBORRbIr+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="WAM/z/E5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.5
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52640606A321
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52640606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WAM/z/E5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMjsjv5EBF9VO7rl3OaJigbkRxeGiz8OFrVsh1GuW5V6T/uj6cLauNOLvjY4ilzRCOiDQNVq+qbO6eK+38YvzN8fYnLuHr7jf7BNmii/zdfnpSR/TrvhhY08LjyDkkP498E37+EYCsHjDMD8P30Hz0qybr4XbiuRqaY+SEknjqy2tOVyjGKwGyk78V8qUdX20ZHYdT//Zhtoc8zLdsILesdcbOhzSG8l0F2HQZKts2RxZDn2kuTo+xPYXtixHHbJoFr/iK6EbQ6l04pjxT86b2Z1atJW/ESkicsbVcYbVKALns9MVUt2u4QPb7eu4oQDA2uck9P3ZNr6/qD9rH+Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU0+Q3GgXva9NXNvrcbtTIUgGguDGmdqF6mJsI8YzqY=;
 b=ADHcpjkDn/f61ZBheaC164d/SuUKbDmX3RJ6snXc5X7+REGjqGeMFSKbAimIDmkQOvkDRWfag39Uvv56+9DDqmZEaeEAHdZwRa87Ny7ECVZlZ/0El0uqRBAvjwfjwrdDYArXJc8A9yfszhKvD8NAuaaMg8STfSVXyQZrvieAg6ZTuVLggc+Jph1k5QjdBiP4DJ7yiZCMui0epcsn426jGJ0oLdmIYoeWwUhVqqhHqUgOvhM45ojxz+jUuUHWiHtg3KNTZoz2uW/+gSjpmalkwVPmY+Nf/YLZwmLsBhbChtZ6iT4nMNHwDvIkdGAjimkkFSCTfUrkgACaP5C7z+IicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU0+Q3GgXva9NXNvrcbtTIUgGguDGmdqF6mJsI8YzqY=;
 b=WAM/z/E5cHoK6sGF13YrtuQ/J+iUX7siHQPFe63S+WxrMo3DrlGrvs/jzxrdi6goITNN6SElmo/WmbIoK6uPL11v86MtYYzVRCDZEofGH7vMOij857/CmwBxI2LCbSeKN58x6sZuIXLzII2H6atzWk8pAHdKXYCLJEpFlAvjFZwAk3KXjaVPxC+t1Iq7G5cAnOD5/Neq/414sHolhV9IQ4oJc7tbP6YBQfe89OHOPhDEMSbFCwbrM8FF+86ot83OEBcFMbBOHv+ZEGBvIk9T6El3IhC/zOak5HWfIPLt7tfodAPMCA/BuLCLd4XDV8Vcdz+ciJ1OnTP9KyYyP45IWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS4PR10MB6304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:58f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 14:19:26 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 14:19:26 +0000
Message-ID: <3b3b2666-ca9f-41eb-9d49-fd3eaf7e51a5@siemens.com>
Date: Tue, 24 Nov 2026 15:19:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] lib/cobalt: Provide getauxval() fallback for the vDSO
 parser
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
 <20261124140303.3336015-3-yegorslists@googlemail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261124140303.3336015-3-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS4PR10MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: fea553b0-63b6-484b-e412-08df4a35f1cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|4143699003|11063799006|56012099006|261026140227099003|261022105027099003|261021123027099003|261009223027099003|261021121427099003|261026121527099003|261028144727099003|261102123227099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xLr3l7hNp7PQdi46+/8tap/G0E1YYZBgfgavpzXmK+V5KY8bN2kmzbhlRVaSnfwK5Ge3ytOC0RTzSOtm07ltWtHhw33ynT+ziBoRkXKqDAj2VIkT3weRVIVf+40aVIU+MmJ1DSyqeTcLsxePSelwBceMr8RY5oHu4F66uFlKNo72naT0I04ZeJAEjIt4J6hN9SduIfjMcDK3JKQmbqj6qnP/hbBrIkrNxA98gtadjzNhC0mqysptiDiST1S1IFRZNBGyGYqyOlpT31j7LW9EwMBAv1v+VtFvMPq8elS2ZngEWDNFHHMi44I+lkDJJ1h4dy3DDEdrElAYcJlPJ+vISJ9OxzETzqxVbzWFHRCoHiN3/SM6L0FMQVrDYf7V56Xw5powla0bK4UTz4nwW9HQrUlF3ASDAmFBiEgzH285kYn26bgOhtTyv9C0LsbSFjPKJ7hJYlJaVELx18fvlWvhKx7m3jHfasjP8Wla84Xv55U567sjE4Md7wYTEe//jgHfvfcwJXXV1Z6nKresCPMtqN0dDIrP9CvbRDa9hqAQaRNW3TD/mnQydnW5ZRuDXXlkBZqx0Qtrj6wZ9CiFZYseL2+LlfKJqmSoZmkiIXt/WGcYN6aReygQRKV09P7uA0szfFEtJzJf6ho1hnWY0VB9QAblrh+MSird0ZHaeNPUcHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGgzMU1hNllYK2poVmVTRkRhanRUajBmL0dKU1g4ckdJV2ZlQ1RVTEh5R2R4?=
 =?utf-8?B?d1N4RGpXYjJFZW5kcjMxUDFxSkt6bk1WWUhsMitEMU5QMXRkQlJ1NDhCZU5R?=
 =?utf-8?B?ZlJlb0F5QjNrUlc3cE1JdEhxU0tVM2M2K1luN3FFVzNGYWxURnNsZjA1dVNo?=
 =?utf-8?B?RGdndXZ0WUlCbGtpeUFjMkp4SWc2TlJpTzBodW1QQnRPOUdtMmF4WVByTTBz?=
 =?utf-8?B?YUdaR2JvODZNaEsrYXlzTkFacXJlU0wzNzlwVHFoRDJZVGZKWS8yRU1kS1Nq?=
 =?utf-8?B?bVZHeDJIUTZ6dVY3ZTBNc1preXNHVmozTXBKMmZTWUN1RXZCN3F5V2dUVWxa?=
 =?utf-8?B?WC9zYnpZYVJCbVZObmpIYm5LZDMxRmw2c0dCZUR5WEdUMzlRYzB3eDdQWkJL?=
 =?utf-8?B?b3dLSThxL3orMVJQd0hHYnVpcHNJZmxCTXNLTEEvZVBmbHAvZ3pibGdpVVJU?=
 =?utf-8?B?SjJtTGIrdTNUbE1FS2RzOGV4VzlSWnZDbzVIeXJqMCtsaGE5UjBpTGJNeGNn?=
 =?utf-8?B?UEtpTXdLWHFqbkNwS3lCazZxYmM1dno4Ris1dFo3TUhqcXJpRWRyRm1lYklF?=
 =?utf-8?B?aHdZeTdJMGhuRXVBWHpRdi9ISzlwUVpKTjVncmc5WVN2WTgvOUhzQXZBb0tp?=
 =?utf-8?B?YUZjTTB1dkNuMGhxSkJKZDR5TG9RN2F6aG9UaStZVDJHQUIwYmVjRzdqYWFa?=
 =?utf-8?B?d1hYdCtaLzRoS0J4YXdGd0FSK2Z5R1pDRVBRb0FqNFZ4L1ZUNndpeVo1YVlF?=
 =?utf-8?B?V0wvL2UvNVVOYmZmcmVlVTBINnpLek5rSTNKV1Vva0JCSVYwbVR4Z09uWGhJ?=
 =?utf-8?B?bXJPVndaMi95emgyNzVMc0tzNVhUelBQYlVvU1pzN05YSW5rZVFVcm1idlF2?=
 =?utf-8?B?Y3NyZEVUbnRvajJmSW0yMENQRFdNbDFEdi80eE8veCtvcmZJY3dTU0JHTDVO?=
 =?utf-8?B?UHVTMTRZT1hyTVBuUzJDdTFZSVNFWjMzVUo0Unh5KzJEVmlBQnFySCtkNXFj?=
 =?utf-8?B?enFDNmhBejV4bWtjR1JpbXJGNWIwQ1djSHlYQ3A0ZGZCU2FqWkNyUW5WYzBV?=
 =?utf-8?B?VngwaG9FQURWWVdjRTJKT1FLcit2SlA4alZmZFhmMEkyQ0R2dDRsc3QxQXVW?=
 =?utf-8?B?NS9kbDF5bHN4Tmk0L1J0ZTVPeDdqbVptb1AzVnJJb0ZoK2ZQc1VRR28vR0pl?=
 =?utf-8?B?SEQzTXUyejgwZmJ1eTJXVlU3dExXUGU0NkZiOTNVUTM2S3JhcWJVSW9EQ2h1?=
 =?utf-8?B?Q0kwZk1id1oyb2N2MVpSTFhiQmxRMndCNWlpNHZSMXNnVmVFSnJjalIzOUd3?=
 =?utf-8?B?bk9Rb3ZmY1IwdHhYWGQ5MTlUaEpobDNnK1RBN0oxRE1tbWxIdEhNQWRLelRH?=
 =?utf-8?B?NUFLMXMrSjZDQnNwMFpyRFBRUk9INFZTMTdjYldGNkc5SW96bitVTUZhdTRX?=
 =?utf-8?B?dHhkL3VBRzU0MGN1QVRENW5OMkRhaStYTXV0SGw0RFI1SDkxSXpzaGY3Ullq?=
 =?utf-8?B?cTI5VENvcEV0Z3FNZUVVWmFRcDlrT0RjdHFLMTY0aTJBVkYySzc0ajVScEkr?=
 =?utf-8?B?WE1QbVJOMWVsYzVGZFd4VlNwRkFMeVRVTXIyUm1IZ0JXcFVXSlZsNTQyYWJY?=
 =?utf-8?B?VFMxNDIwUWFtSjhOZGhMdGFoTG5RWlpHRGh4dUppUXA2SkN3R004ZGlGeTJT?=
 =?utf-8?B?cmpTRVJVM2I4bjRnTTNCSWZmTlZ4T0czRlg2MnFhOU9WdHFnTmpPV2dUVyt1?=
 =?utf-8?B?WHFoSVd5d1VHb2lxa1dtOW9NcHB6eHlZeENiOUNiK2tmb1VVYjhncTB2bzc2?=
 =?utf-8?B?Ly9Dd3AvOXZQQWtnNkJSQVh2ekhrRjZ1OUpHcjZoZHRuVGYyeFR1MTM3U1Y5?=
 =?utf-8?B?Z2xnTXFEUUxzdFVRMENJcGE4aHdibktNZkFyaGNkNTZYcnA4c2JPUnZUejJR?=
 =?utf-8?B?eWdtQTNDUUtHeEg1Z1hXanpBV0tmOTRHbWhPVzVSMHEycDQySFA1NTZDbHM1?=
 =?utf-8?B?dGRQb3dnSFlVNERHbTA3WW1qSTJTbVNJTjVISUtTRjd0cmk5NVNuM3F4Sktj?=
 =?utf-8?B?UFFaOEpncmx4a3Z3RXhPcWx4TjBxOVNMa04wWnZUQXZaaHN5Y2c3bnBOdHRh?=
 =?utf-8?B?Mm9RMzBjZVpuUmtQRC9OZDZGbU9XVk40VWRSNEVhTHVPajh4WWtaamFRQWJi?=
 =?utf-8?B?QjdtQjhOQmlnczZTTFJSNUZydDFFaWkyeUNuanVCVmQzYVNrdlJ3QUdSd2lH?=
 =?utf-8?B?dFpES2ZGNjdhTXJkanZuSFlUOE1Yamg3TjQ3NVRZeFFwM1FDV1lGMy8vNFJ3?=
 =?utf-8?B?TlZKRGNrRC90eTU2V0s5MWRCcVZ4NUwweUlTc1Jodk9BUDdTZFJIUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea553b0-63b6-484b-e412-08df4a35f1cd
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:19:26.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkPxcN4pOiX4PmL/btWdiMMrNc3i+cDzpgCQbqXl8gOyrJvZ0KbPPKyktOFpIMHpEieFngTg5i0YgvCkhtRomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6304

On 24.11.26 15:03, Yegor Yefremov wrote:
> uClibc-ng only provides getauxval() and <sys/auxv.h> since 1.0.43, so

Ok, I'm not against backward compatibility per se, but the build was
broken for ages, and 1.0.43 was released in April 2023 - do we really
need that anymore? I think the AI went too far here.

Jan

> libcobalt fails to build with older releases:
> 
>   parse_vdso.c:18:10: fatal error: sys/auxv.h: No such file or directory
> 
> Check for getauxval() in configure and otherwise look up the auxiliary
> vector entry in /proc/self/auxv.
> 
> Fixes: f8cd2923b0b0 ("lib/cobalt: dovetail: use clock_gettime() vcall for reading timestamps")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  configure.ac            |  3 ++-
>  lib/cobalt/parse_vdso.c | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 0d6dd87b6..6e8d8d549 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -572,7 +572,8 @@ AC_CHECK_FUNCS([pthread_mutexattr_setprotocol	\
>  		clock_nanosleep			\
>  		shm_open			\
>  		shm_unlink			\
> -		backtrace])
> +		backtrace			\
> +		getauxval])
>  LIBS="$save_LIBS"
>  
>  save_CPPFLAGS="$CPPFLAGS"
> diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
> index 37b997b78..f65af1191 100644
> --- a/lib/cobalt/parse_vdso.c
> +++ b/lib/cobalt/parse_vdso.c
> @@ -15,7 +15,6 @@
>   * architecture that has a vDSO.
>   */
>  
> -#include <sys/auxv.h>
>  #include <stdbool.h>
>  #include <string.h>
>  #include <limits.h>
> @@ -25,6 +24,36 @@
>  #include <elf.h>
>  #include "internal.h"
>  
> +#ifdef HAVE_GETAUXVAL
> +#include <sys/auxv.h>
> +#else
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +/* For C libraries without getauxval(), e.g. uClibc-ng before 1.0.43. */
> +static unsigned long getauxval(unsigned long type)
> +{
> +	unsigned long entry[2], val = 0;
> +	int fd;
> +
> +	fd = __STD(open("/proc/self/auxv", O_RDONLY));
> +	if (fd < 0)
> +		return 0;
> +
> +	while (__STD(read(fd, entry, sizeof(entry))) == sizeof(entry) &&
> +	       entry[0] != AT_NULL) {
> +		if (entry[0] == type) {
> +			val = entry[1];
> +			break;
> +		}
> +	}
> +
> +	__STD(close(fd));
> +
> +	return val;
> +}
> +#endif
> +
>  #ifndef ELF_BITS
>  # if ULONG_MAX > 0xffffffffUL
>  #  define ELF_BITS 64

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
