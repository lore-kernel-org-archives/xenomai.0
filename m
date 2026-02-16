Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA0303CA0
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242509; cv=fail; b=QfMq42RUoSDog4b6BcPTthqsVjc2dDJT+86xpIQ0dUF0fmle1quHtmFqWE1l9gmXDpQ723QRKB2iecO4Hr3en8XE27/fEmvi4cMjGKTMbOwIEreUOLL7IuUmIQVUaudIpov6p79cc5nsAVtVxgnNFaI5wqLTr4J47N7XusFLqG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242509; c=relaxed/simple;
	bh=BwT+tRQuSymMV9jRsvAWCLfriAYm+gfbFfwd8yxQQg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DR9CDSKoGqoOm3DLmWA1RPjhNfc8lROUmNXKF+69mNB2rXdxfI97BUa2XMV9tICedNhDu77FWzy6N9io4w5vfszLoo8fXPGDPl10Ecji/UdC96IWV7eTn7R5ypc1qysCgdMLukrHDP1aXgHfcCGDXCDsprgkO29j5OeIoWZJBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yPDq8sBr; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yPDq8sBr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArupQu3N0RPnbp7NbG/SF6BK13DC3h0KyvNg64UCgx4cInoS0ycqd5HjPfKtTeWifWP5Vdf0IQCnSypVGcwyIdrJnUjkGjxgX7w+Rpmc1bTalfhyRbTacmnSRjr3TLwMxduVyBaT1FH6u+Hijc9HHH/39tZ8Ami7XMgD91pgHJmPjb23L2Iz6yBcjMHqepDKbS99JlfjuFh2J/o8f/1n+/FerKFHK1ALayoTGuW9wVenGdCRInku4gtRb9kLWysWMyG8vvBptNaTGxfqLOeUqG7HtQ01Qoo0H2SdciRNfPIvHXM7yY8Ub4Ahs1+5L7VRSGmU6LEi1Y4PXCJz+6ZGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v9ol6x4U5wqzv2OOkAzLSjQsf3KMS9FxZyi5CAEfpo=;
 b=oOHxDg1hTbuTFUsaPPuDd7QOdcARuRg3Ke2LULK9PUUNCJ67JlohxqYDRTzlXd9MgM5qXDaC8oA5yqx+6n1EEEO7nvXRnaTMQW9wkO7x5bockv6/iJCf7n7Kx9NJOSm79xUfxi32aXQ2XDE7tfVYqvXxfox3XPH+mHNwz0uHEriSdz9Bzr6ARjYaKWSa+OVGP7YG/A1SaoDXTsWgNiA2EmGPKgzIOU2FgmusP7SFJEIRbwMuf80WfuhrywgXwvh6dfQWnr5e9lFnq5/npRql0PqWwcI3Vxf2ZJ9Yv+Xq1b5GXmKB+UHSxMNzf1SmxzXfMeWYA1iXwv6txccz6XYtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v9ol6x4U5wqzv2OOkAzLSjQsf3KMS9FxZyi5CAEfpo=;
 b=yPDq8sBrjyhJ+Pc6BgJXU8D+w0Kuyp2X7OohDHF9yyujxJ4jbfHeC1rtQ80eEcyNDYr5Nr/obOk23uHvwnJFKLZUobdCdfDmJoBN9lEgl/6LzpjickT26mOczNAQBoL440aQVI9s0AnMMaIcSJaFtbzNMDU3rKzeFxAaXlYXy1Y9FMamE1yizUylKVC7n0k1XT7CD35H7SbZoeudI++K3vtWXKaBKsK2JaNgBkI0g1XKBymDVBBDXp9GO/qqnmNmrreY5Zg2501N58TGoA67S+LiAEfhnNuEIwSQNLxg9PfRBz3eYUbEcr6b3slHU6s5hNpS+JZ2rLq1IkHoygWByg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI1PR10MB3695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 11:48:24 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:48:23 +0000
Message-ID: <b231d3e4-8d3a-4554-ab8c-3e6fe3a273c9@siemens.com>
Date: Mon, 16 Feb 2026 12:48:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in
 exit_to_user_mode_prepare()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260214113941.91453-1-tobias.schaffner@siemens.com>
 <5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
 <9596bb75fa20f8f470dbef5cd03d944e7df50c1c.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <9596bb75fa20f8f470dbef5cd03d944e7df50c1c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI1PR10MB3695:EE_
X-MS-Office365-Filtering-Correlation-Id: b55a51a4-bcf6-443b-2440-08de6d514a25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDc4OUU2Q1dscW02WURoaUpSN2o4ZTNHQUF3ckJUWndhS1JXYWMyMk9NcExs?=
 =?utf-8?B?d05SY2RPN2Y3WVZEa2RKL09MK09xaHJUVGtOUmRmaXp0Tk5iVk1WU0xjcUg1?=
 =?utf-8?B?M0lpOFArUFBhWndhZXp3LzgvYlIrcHVSNDJkK3FyNXBSNEh2TG5lZ2FWS2l0?=
 =?utf-8?B?angySU5qb1NvSnd5OVJsN1VqV0Z6WHRIMHltR3A1RWdBRkVFOENZMXM5WUpx?=
 =?utf-8?B?N3VHMjNFeDBCMGdFN2YvR3Z5dHRsdEZDK0dndFNlZkZ4SDA3UDRlcWdlZnBM?=
 =?utf-8?B?ZE9BRjBVcGZoV0lCdnVKbTNwMzRRaXhqSXFFZzEzNFBUQWxQMzdUU3kybHJS?=
 =?utf-8?B?dDRwUXY4WjZBTGY0azR0alpuSHVPZGhJbGFJOXhCc05lUExRZmdEVm5qamdw?=
 =?utf-8?B?dzBrbkorUzJ6YXBkbUxUM0lOMk9EbkczY0EzdlhCY3ZOMjU4MnZ2VTY0UHdz?=
 =?utf-8?B?K280bUx3RHZvOUFJc0ZkZmQwbDBMSk93TGJkc0dhQnkveDVWWWp0UERPUTVC?=
 =?utf-8?B?WXFPVS9NUEg2S1hTQUVHNmNVaDFMYUJtNEdJTnVYdnNnakFBM2ZUUFltTHJ5?=
 =?utf-8?B?WGk4S2hoanJPeEhCeXdEUUhtT05HeGEwWTIveURYdkM0KzROM0dtWFBTWkt6?=
 =?utf-8?B?WmtXeDZlbDEvM3o1VGptSVlvNWl1MzhHMERoSW5lRkN0bTMwY09pSTV4UjAy?=
 =?utf-8?B?aVFhL1BwVU9tL2ZUQlhCY3QvZ3k3dktjSHh3OVBTaTRPOGw4L0NkRWRoSmhq?=
 =?utf-8?B?Z2thdFJ6dURZVlJ4M1pOeXB3bUw5ZjROcWxEZ1dxZmZ5RFk0cUxOMzI0bGVm?=
 =?utf-8?B?a0pvaXR5VmI5aGV4S1Y5S1N3aGc4Tm4zdjl0SENqdmFENU5YajhJN3JtcHlv?=
 =?utf-8?B?Z3BlM3oyOFBGUzRxeGNyVWZXYXF4SFhjWmxkQXR3UGtSdFZMRDBOSVF1Q1hN?=
 =?utf-8?B?K2JaQXBhNDFzTnBWVEhMdWU2SzdFWElnSnJOK3VDSG5NQi9LU0dYL2F0cGs5?=
 =?utf-8?B?U3FZMzlmdnkwTlhIL3kxZ2Z5ZXJkeGpyNWg0RmZQbCtPaTlvdzVlVzF6MHFN?=
 =?utf-8?B?aWtXT1BBdTdoS0I4YVFVVnVDdUV0b0lLRC94Lzdrd3N0a0c1UlNGQytEd2dw?=
 =?utf-8?B?MzlkL3RPZVJkOXlmNmlIREtSdlFtcWxEYkhCTEVZVGV0c2dQcG9LT2JpelZG?=
 =?utf-8?B?K1lDTTBkV1BsTGRvU0dWTXJyUFBvYlc3RzB6YVJJL0JrY0FRdkQ0U21DOWQx?=
 =?utf-8?B?Z05FcisyYktiRmZmZGpNREFnY2lnMUU3RWcyQ0dqSkwxWnJhK2p5S2FFWmZo?=
 =?utf-8?B?dlA2QUxmYzRhczVDeXRYYnF4dkV6SXZ2OHB5cmdnaUhwUVVrd04rZ0dpLzB2?=
 =?utf-8?B?cWt6S1RrUzZ6SnZZK09YdEFvSlhRQ1BFVWxKaWI4WThzLzJ3M2RFRVVxZXFH?=
 =?utf-8?B?OXNvUmh0K01KTTl6bjU3QlNyVE9ZZnk3RW9zeTg2NkUvd0VEM05BRFBUUURa?=
 =?utf-8?B?T3pHVStNdnhCWmRZYW1GZjZJYUJKNmNoR1pySDdldlBMd1RCNjcwNFlNK3kz?=
 =?utf-8?B?KzJPWmZnRjFxMWVMcEM5U1NhWVZjWERVV0JjakRHNkhFOFRMdWJWaTlrWGJZ?=
 =?utf-8?B?N3dSeHNNZGY4bExBRHgwVThxMlFJMWNoSllQTUxVVTlSUkplY0M3TlJlSXB6?=
 =?utf-8?B?TzdJeEZhbkJDZVJlQVZGb043Q1NZWkwwdmw3OXFPUmZicjhEdmZBTGtmTVFi?=
 =?utf-8?B?SEtvci9qdXU0aFh1OGdTTnZPN2YwUzFzS1p1ZWhvTEZ3ZUd6bE9CZHF4Y3JI?=
 =?utf-8?B?aXVIcWE1NDZtUncwbkYwekFnS215d2ZUd3BLMUFUdjhBSSt0eDgwTGRDRHBI?=
 =?utf-8?B?UkRuWnpHYUlyYVVyQTVUUGc0S1hqTVowdHN0TS9aSkdPSk9XQkhxeEhXbERS?=
 =?utf-8?B?RktRNXNqZXlraDgvdG11RUY0RTcyNi85RDRQSmM4ZlhxL2VqcTZSQk84anI4?=
 =?utf-8?B?dXBBeHpZU1d0US81WXNmY3BpMHpHYXNkUlJHaUdxRHgvNkJrZ3U3akVldUZh?=
 =?utf-8?B?R3RzYncvY1h0SkQzVThtemVNbUp4Z0xFd1EzMjJQbHdVcHg0SG1lMEFiUVpr?=
 =?utf-8?Q?40q8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBPTWdlZW9ZamlZRGt6c0l4cCtPU2MrNGY5SU41UG44L0dlU0NtbXFIZHpn?=
 =?utf-8?B?L1BjOXlYcW1yWFJ2ZjZMblNvcmpqTXJQYjd1QjRWZG9GQWc5UjNNMDZhRUV2?=
 =?utf-8?B?b1RvdUtrQ2NRS3d2a3pXK1N4Wkp2UG0zMzlsYXRoK0k1OGxPMURjNDZISWhj?=
 =?utf-8?B?d1BDNUlqREhMcG9XV05DcFBEYUhJeHdWaG90dGJlN0I4TUgyZEFVbzN4OXkw?=
 =?utf-8?B?N0hDTWQvOGY4dTFTN0FQZjdtRkJrK3pza3JFMG5QNWpvRVlHMXozUTdOUXVw?=
 =?utf-8?B?akZjVXM0U3NPcExaK2ZhSlhPbEp6cTF6YjNCbEtJRzExcXFwaTFtQmN0RTVG?=
 =?utf-8?B?Ny9Cd0RPQjFOS1M3RnBRZVNaZXZkdVE5VUlGODlDY2U5a2J1RmJlRXdZQlpl?=
 =?utf-8?B?T08yVU5ueWlzS2x0Mmh4S3k3TnZML2IrekZHL2dhZGtraEx2QlVqTGVTRWNG?=
 =?utf-8?B?TDFISHBQaWI2dmVxSEt0OSsvS3hUQWNYaitGbUNxZ1MzcHVsMVVrc0E1L0JW?=
 =?utf-8?B?TDlKQSsxYXJrL1NNTUorZnBFVGJQOUI2bkFkRU1uTzBBK242MDRjbTc0Y1Y3?=
 =?utf-8?B?UFhaS3g3a1hBYXVyUEhJbkZDNlBqNWdHU0xmcFFkMmJPZCs5dzBYdGNvMUM3?=
 =?utf-8?B?YldVV2RidTgyZXJEdEp5U3VwOWpMMjVMVEtPZDUwSU1CMU1ndHhiSHVmUVYx?=
 =?utf-8?B?aCtpbFFuSUxJUEdzRThhNDFGOFF0OGZjWDdkdDlaR0RJeFJrQU44RUw2RjAw?=
 =?utf-8?B?a2drTE5GS21kNTNNaUNSMUthbzFkbFpieUk2ZlB4MWpRTURPNEFrdmJod0hp?=
 =?utf-8?B?RXFrTVNVcUxKWjNIb0NtalNoNnRLQXQwSHNXdDB6YWNFWXVlVDNJSGlNMncr?=
 =?utf-8?B?TFFLOE40a0dQZS9BWWNaTVI4RCsrK0pHWkxUbENXZ3h0ajV2TEorZFlzK011?=
 =?utf-8?B?bmViSFlDcFFMTnl2WEZZS0pvTWUvU3VUYTBQS0U2MzhjQjU0NER4d2hBaGFl?=
 =?utf-8?B?TDFSS3ovaCs3WERBeW9xckRxNTVVSFQ4b0NqR1A0WFpLVUw2VkV0UkcyRUxL?=
 =?utf-8?B?T0VJeWJDSVd0eFA1MWhTdUdrN1ZFN0h5UDdwdDNUbm84MjVSbXNndzRZbmlm?=
 =?utf-8?B?VHExVzRIY3Nra1lkTDF5cEFEMXZ4L0xyUjVRZUpmY09VcHRjSVpyNko4ejUz?=
 =?utf-8?B?VVhaRmN1SXdmZFgrVFB0ZEhZR3loSnpWTnIwZStCM214RDVZTjFZZThvdGdU?=
 =?utf-8?B?SzI0MTJuSytYLzF6dHBhaDZoT2ZOakdBaEJOamxZZS9vTzJVZXM2bWxmejMy?=
 =?utf-8?B?MHdsWVhDOWdOakpDRnRjSUxSU0t2eVJpMnNYSUhNVTJta09EQUY1N1pUa0dM?=
 =?utf-8?B?YjFoSHNYV05nTnA5SGRtQnU1SmtTUVpNUnl1RDFZaEtmOTR4QXVkcVVjUXlY?=
 =?utf-8?B?a2gzQ05ycmRlMzdnbFVWd21tUVJUSXBIUHBBU0l0SFZQbkdNeUJoakhkcmhp?=
 =?utf-8?B?V2M0UUhWZWJLc1JNeTRsdFR1cWF3aEh6cTgySG8wTmpXbGpoNnE0dkRxUHRP?=
 =?utf-8?B?OFd0OTFtQjlDUFc5Qm1oK0JzeXY2T0VxUWhXRlp6b0FBTFdlakxzdmdzWFB4?=
 =?utf-8?B?b0F3SkhvbFBVemdDUjRnZkQ3YUVYK0FFWkIxeFFpV2JRN3pCMWg3Qm9sZHBX?=
 =?utf-8?B?UUF5ajRkV1hSdlE2cEMzYngvNW9SR1ZROTd3OXY1YlRFVHArU0d5em9KSlJP?=
 =?utf-8?B?RUJZSG5xM1hzVTlUZFgreHdWRDA2VVV0ZlRrb0Nta0tmbEhrWVNidjR5TjFE?=
 =?utf-8?B?YWJsOTVSZWo3Zis3Wk56dC9IcnY4U0NjbjhTUWpEelpyZ0w5NGFxd1V0R0Rh?=
 =?utf-8?B?NkJnc2k2WkNoLzY0UnlSQ3djOFFIazlPd3ZmN3pnNUYvbG9VTVI5a21na1Uw?=
 =?utf-8?B?cXpoOHJ0bkxDa1cwYUJjMEdqVG5yYTZjeGdGdmdWUk5Mc1J0bTlYcXdKcmZH?=
 =?utf-8?B?Rm9yN21Eekx3Z2NVVWp1aHRuVzFyU0VkWUcvaUFyMm9PNGc5SktQMU1xbjdG?=
 =?utf-8?B?UTBhcktUdlRlS3RpNGNKSGZVV2U2UUV3cWQ2Q0xHQ1VkNFdqTnFXdndEUFJL?=
 =?utf-8?B?ZUNWbkdvZ1Fqd3JQMkRxbUFLVlNQeXdoQkFDbFFkTDU1ZHdVb0ZKblpqK0Z6?=
 =?utf-8?B?TWg3dGhzTisxdWdFc3diUGlzQVp0SUlzZGNnQi9CaDJFZHowN3pOOW9EMDh4?=
 =?utf-8?B?NWpBM0R3b0h3MjFZS1pPWFl5Q3Z5N3NiSTNpbC9oRXJyN1JDWmpCWEdpUFpF?=
 =?utf-8?B?ZnZHdGUvdDhYSVBaVklYcE8zeHZneHErZkR0MlFheXhkY3lteU1MVjdyeTV0?=
 =?utf-8?Q?9PxmFyiBJcwiJkb4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55a51a4-bcf6-443b-2440-08de6d514a25
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:48:23.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R//HP2p4LwL0Zu8B9eryoJeMNck/JVMyPFhGs5v32ORJES7+y9n/6vMGcVs7UsObmC/OFCHJq+vvhFnP1xjq9GLGi/jJPleeuSgKX3MV3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3695

Hi Florian,

On 2/16/26 10:27, Florian Bezdeka wrote:
> On Sun, 2026-02-15 at 00:25 +0100, Florian Bezdeka wrote:
>> On 2/14/26 12:39, Tobias Schaffner wrote:
>>> Architectures using the generic handle_irq_pipelined() path do not
>>
>> arm64 and x86 are not using that, so the only arch left is arm.
>> See below...
>>
>>> synchronize the inband IRQ log in handle_irq_pipelined_finish()
>>> because inband is still stalled from irqentry_enter() when it gets
>>> called.
>>
>> I think the real issue / correct wording is:
>>
>> _TIF_WORK is left pending on IRQ exit.
>>
>>>
>>> As a result, deferred inband IRQs may not be played before the kernel
>>> checks for pending work in exit_to_user_mode_loop(), causing
>>> those IRQs to be missed on the return path to userspace.
>>>
>>> Flush the inband IRQ log in exit_to_user_mode_prepare() before
>>> entering the work loop.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   include/linux/irq-entry-common.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
>>> index b21fb5893a67..e5815511a80a 100644
>>> --- a/include/linux/irq-entry-common.h
>>> +++ b/include/linux/irq-entry-common.h
>>> @@ -8,6 +8,7 @@
>>>   #include <linux/tick.h>
>>>   #include <linux/kmsan.h>
>>>   #include <linux/unwind_deferred.h>
>>> +#include <linux/irq_pipeline.h>
>>>   
>>>   #include <asm/entry-common.h>
>>>   
>>> @@ -237,6 +238,11 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>>>   	/* Flush pending rcuog wakeup before the last need_resched() check */
>>>   	tick_nohz_user_enter_prepare();
>>>   
>>> +	/* Synchronize the in-band log before the work loop so that any deferred
>>> +	 * IRQs are played before we check for pending work. */
>>> +	if (running_inband())
>>> +		sync_inband_irqs();
>>> +
>>
>> I think there is more behind it. Seems your architecture (most likely
>> risc-v) is missing one corner case in the low level IRQ entry code:
>>
>> Potential stage demotion of the preempted task which originally entered
>> on the oob stage, then left it for the in-band stage as a result of IRQ
>> handling. This should happen in handle_irq_pipeline_finish() - if required.
>>
>> So on IRQ entry you are OOB, after the call to
>> handle_irq_pipeline_finish() you might be inband.
>>
>> In that case you most likely want to call irqentry_exit_to_user_mode()
>> with the inband stage stalled:
>>
>> Taken from arm64/x86:
>> if (unlikely(running_oob() || irqs_disabled())) {
>> 	...
>> 	handle_irq_pipelined_finish(prevd, regs);
>> 	if (running_inband() && user_mode(regs)) {
>> 		stall_inband_nocheck();
>> 		irqentry_exit_to_user_mode(regs);
>> 	}
>> 	...
>> }
>>
>>>   again:
>>>   	ti_work = read_thread_flags();
>>>   	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>>
>> That said, we should double check that this corner case is handled right
>> on arm. If arm suffers from the same problem, this corner case is
>> missing in handle_irq_pipelined().
> 
> ARM is doing the right thing on assembly level already by calling into
> do_work_pending() on the way back.

You are right. This seems to be a leftover of a prior oob irq handling. 
Thanks for pointing me in the right direction.

A first test draft

'''
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 51e1407ee066..96d79cc3d3d4 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -527,6 +527,16 @@ DEFINE_PER_CPU(int, irq_nesting);

  asmlinkage void noinstr do_irq(struct pt_regs *regs)
  {
+       // OOB fast path
+       if (unlikely(running_oob() || irqs_disabled())) {
+               handle_irq_pipelined(regs);
+               if (running_inband() && user_mode(regs)) {
+                       stall_inband_nocheck();
+                       irqentry_exit_to_user_mode(regs);
+               }
+               return;
+       }
+
         irqentry_state_t state = irqentry_enter(regs);

  #ifdef CONFIG_IRQ_STACKS
'''

fixes it without touching the generic irq pipelining.

Seems like I can solve this issue in the riscv specific IRQ path.

Best,
Tobias

>>
>> I hope all of this makes sense at the end. It's late...
>>
>> Best regards,
>> Florian

