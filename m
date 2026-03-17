Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833503F54C2
	for <xenomai@lists.linux.dev>; Tue, 17 Mar 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767126; cv=fail; b=eyWP9LGt9/muIJCLQA28luK5VkSHt5zbjVUQFYMptPK7mUtoW4ZybZYmcHSmzj5aXOfv09oDQTyiKO56hB/hYOWRcTyPCZ/MOxKuiw5Po1rlIlBJ+YWMHcbQfh3rqlz2UuV2KkIbCyUjFWKT37JDTY7enRLcJYlM5iTXu9oxt9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767126; c=relaxed/simple;
	bh=t7ujIZpmDl+CLcDQrltvArwAvf8uEkVk2SrJ61l2i5s=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=WgVkVW10Zfsd6PM9YmHRstkKWPPk7WY2ROUoTdiHXTUhJLK4OeGmUwrmJCoiHPilXYSMW4sSI4SpC+znfGU8U0AYWB4S2rTCOexAsxvEqVU91ZpgaMf8hiW1LOEIGPphWfOyNEqB+ZkTRJ0pt6FV23vG9mx7LZoLKdF5Y6QBf3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LTos+Sok; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LTos+Sok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLtN5+2tptmCI8xcIt9fhGnGVv2Ewu3dM/5IE3Zesn3Gt1Itwjmu09OcHPbBULdNVsLIyokUpxzYY2CgfQpGPaehWWwBBpPUgGQq1D72qB602wdC29fe8jyYiScAqlCDTGtA1jhqh4/v0PhmUhv1LOZT5eE+nZ0HhzUS32yxgGsTOSxncPUasTNPgZYUaZzvSbjA1tXNsibeZTG0JBl7cOa6WuO+w49GahuWXfV/5OzJwDESXUKJ+RbfLoLGql9KMPMBOOEAyBRz7ChcM3fv5blrvClB/LnbpvWmOSArL6pw65jFW0VEvnwXwOaWCcl6UbcYf0Li5ZG5yu4hFGyRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7ujIZpmDl+CLcDQrltvArwAvf8uEkVk2SrJ61l2i5s=;
 b=yC9fydXTjQETdVJBq8a34BmlPjPbz7hb7usyNVM+HfWGBCw1LLSSQxfFCIWWdUS+UFI1xoOxzVKDt56WdbiGODKbRSsjQ0bgIMqfGG5SkQBcrU2MWDNCPAAO/pNyj/kvIExccP5B+O4M09HqrhRzhxCpjT0Kf4bIlkoxQl1twAleWMMvh1syEWN4CZtQFyYHsebtCSe8zYP/KDnlApZrzPRsuZ8X6RaSciPwvtkPSBzwZMz2m39M/sYpg/VuanTdJ0kTgriL+DAomAqlw5aO8WkxAf+Wh3YDBXW07z3aRgtzNTBt1U1ZDxYUS71WN5nfVXCIWxt9lib4RMa7Sk3dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7ujIZpmDl+CLcDQrltvArwAvf8uEkVk2SrJ61l2i5s=;
 b=LTos+SokBEIBxt/3H1p74HPbapWCqsO1LBbKEu1nGZvud32qUKas4OGrkYhq1AC5c73uJ1y691So3Z0kFppvqrOtx0ywdbxtVrJpJni/94+9wfRTkU3wN92fGRIDZRlu67dkY3C6cw911SMAztgZMFREm5RfeiCaGsK6jRT/n4PuW/Yo7o6bIBw7FoMAiSzyjQ6j9nAq6TwrOGY9iEr5Lqxpa+1JrZTlv6qd50BblCWjWa0jdfQQbJRYoONBQ7zSkYfQWHfmw0hDXWu9hi+VAtZD5JrQPb+h/Dk4fpbl1y9rIkTDnSxV4NtcdRYcxeL+rnLDW4e1iFx0y06kM+XsTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 17:05:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 17:05:21 +0000
Message-ID: <ea3d8319-f711-4379-bc0a-f5a6762fbd06@siemens.com>
Date: Tue, 17 Mar 2026 18:05:20 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, March 18, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b17e05-0e0e-406d-b948-08de84475fac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uU9jnHo9rp/4sHMbRnTByTjeX3HGOM3edk8VtPgFPCI4dNehyeYrVs+IKUyXxrEXnEHxDPPa69w4iMqttSg92SQ4KjHsHqb5mFF+Thhq701WjiUx/erdv6vsmzt3ghAl7i3Wgtcs3zyQClGxmuhTHEOcmhpeUMoGJnIvjW3rf0NkJcQmxnlf/6qUMwdeCYYQEbdNGDoxDsOoSDC04a+Y815GsLwv8yQgRdTlx9DGjYOx3mRGcY57ZyQvtC0I66KW1a77aGopTb0TXs5k2Fwwzi+5nRPwBekHVQybQV+uhEV9sav+Se7xBOE6ggTgmakrHz/D7wkYUbmwIEe8nuk9ItlaT5kGS7Y6sKpJ446WCBGHrD4EZXeU6amQeM4A082F2hWH1aT8ifVyDljbjaB+FCmRmAm8ahOeyPfHmDJ6uxnY77GCVtd0UI7b+4c5wSBtWqxdG1Lvr+41gUkdI7wSuaNI+bs+/UMFiw1hCnfOVKi5DtXAFS7LDebSZM7aGASjfTywn/mHtWdx+FmewTM/piBAN17socG98F/FkN9BKNLNpuScFkWggn1V2LxHoa8C+BhbQF8yonevBi8yHSf8SgPf7UGtv92ZSnR8ZY+UeqVh9Q4ivVm8tSWeOeed1Yxtni0FE9RoeXfTStExnQz34hd18qfF1bysw9HFALN0wP1K3qZdomsYnUyZzRfvZyjLR/eaWm0PwFpZZb+/yerh6ltWzgK4rJS8iiQlPnh+Bs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VStwVWwrY0NFSFU5MktYelRYc2tITnZMemVmejFiVlVyMVlzdVhyOUNNc2Jz?=
 =?utf-8?B?c3RBMGNFU2JVeFREeXlaYVdKeTFvMTVtQ1QwUXJKeGFhWEl4VG9DK29mVFdK?=
 =?utf-8?B?V3RObXlFUFpMbHVyNjJkM2NMTy9NKzlsZHFqc0EwcFNZYjY5LzhxNUlzTmlp?=
 =?utf-8?B?c0M2TUlTNHNVN3dHZnJyZWxiSFY4V1FiMzVpTGtkbm12WnR3dlduNGxIbFR1?=
 =?utf-8?B?V3hpNll0V1BPN2FaN1d2N2NCYjJsNlgzck13ei9IK00wUzRPdlZ3L3RmOXRq?=
 =?utf-8?B?dlVSU2Z2Sitic1c3VzdMT2dWSlN4MEw5YnlYOW1jZHAyQWJjZzhWNDNxNzdI?=
 =?utf-8?B?d3BDMmVna01sQTZlRzFmcURZbTdtVk8wZjZJalg4dldXdnczYkJiazJTT3pr?=
 =?utf-8?B?azFUck5xQ3lrbGhrM2JOaGI0REV5TzVvSWxaQVY1M3VUYmhpSnVMaWpadjFX?=
 =?utf-8?B?RVBKanZidjE5RTZIT05OK05ZNUpMbU1WM3NtZ0dUc1BaTmgyWHJsT0pFNUJY?=
 =?utf-8?B?ZGFjNlB4UVR4NUlGeDlhYWp4emhTVElXSEh3MVhPOEtmRG5iYk9FMkZTQlA5?=
 =?utf-8?B?eHNDWWM1WXhzM0dwVXhXREFEdTFnNHJpb05JS08rbWcwaVAzODhtM1lKakRj?=
 =?utf-8?B?enNhaTJKdVVnY3pnQnFTMG1kTXVQOUJ2NHZZNGdCWmJlVjRnUUp3bWpPRlZZ?=
 =?utf-8?B?SVo2TE9nYUFzckJ6MU9hSTRuV3JWdk9VRk94cXk2QjRZYXljZFJWOTJmSjFw?=
 =?utf-8?B?YzZZTU9zWnY1UmFtd0RKRmpWdEdjYW9jU0hJU08zbXVSbnZqdjViMTFtNk9E?=
 =?utf-8?B?ZkQybncwMEcvcUZKa3VJU3NMRmNWMVI3S0VpNkM2Sk1XUUc1VTcrOVlIek1w?=
 =?utf-8?B?bWMrZUZIaFFRS2ErTGptN01hc1oyWTV6NkUvdG9DZDc1YUNLR1lCTzBIcjB2?=
 =?utf-8?B?UlFaY25PNFNaYWs2OGlwNGI2cS9MQUpzK1pUK1dIb0ROSG1YSE1qdWRMQ25Z?=
 =?utf-8?B?L2NCRVgvVE4rcWpjRUg3SUVQQkRTaUZDcFhLU2s2eVkyL0hHY1lnWTNLR0dK?=
 =?utf-8?B?MjNqY2VldWFyU05kTWwvU1BST2JEQ3ErckRlNFV2VVB6aUN5cVhYczNBaXdj?=
 =?utf-8?B?K0JKSzcyRDVBZ1YzVFN1TUZWUlJYS1E4Yk4vdHAzRW4rbWZGa2trREx0Vm8y?=
 =?utf-8?B?VHVDTktZSXhKOW9MakNvaUg2a0FoYUUwSDBmWDBYaCswUzMyTm5GZXdheWQy?=
 =?utf-8?B?Slp6MmozZkVUNHhiYnJHc29yaWhDRzVQUUJaOHc2RTVIZWl4L3E3RFZ6M3B1?=
 =?utf-8?B?ZFFLUy9EU2MrdVFrYTkyZEtwSGFWYmVJa1ZEZytqc0tSVUJZUER5eThlZ09I?=
 =?utf-8?B?RmRMcDhaQVlnVGl6c0xRekRXb0cwcm1vUXMzYitCVExXSS9nZkpsTTF4WTYr?=
 =?utf-8?B?VnJTLzI1RUhNaHA5UmRlTkk1dit2UW1KbU5hVVN5bStzc2EzN2tWRkNKUGQ1?=
 =?utf-8?B?djVDZEwwR2g0alhYd1NBcFErNHVSUlBMRlRMVk1UQnhWb0xVbHVNNWZwS0RP?=
 =?utf-8?B?RkxIWWwzZ2JjbmRxZVVxWGhRQ3hnZXNwSHZ3ZWJzRXo4eGFxU3lySkpUaFdz?=
 =?utf-8?B?ZnVLZm1pU1ZOeElvdk1yMm5lcGt5RWk3TGcwNEliZlVJM1lwMGtTa2p6TGsw?=
 =?utf-8?B?YlFkYnJHOGZRZ00rZjFBTENqT2JINnU2SnhBTnZhMXNTc0JvK2lYdStXRk00?=
 =?utf-8?B?MWtJM0pjenNtTVdONjdqenJ6Z1RmZmpkaG43c0x6aHA0TWVSUGsxOWlyTk9t?=
 =?utf-8?B?YTFwSlJUL1VaRWRwVHhHdDNhTytJTWdnWldEUHVZYmNzckRkQWQ2WGNuL213?=
 =?utf-8?B?b1YzZlZjbzMvcXdzdmR6a0VtcUJlYmVTMUVhOWdLb0FCem56ZElVN3Zxbm9y?=
 =?utf-8?B?eTZzRFdyS2ZXNnNYZFJVT1JiOG5tQ2xGV1dyZk10OTQrZlBmTjJwWGxuditr?=
 =?utf-8?B?ODdLR1lwbVJPTjF1T3hMbUpTTVdUdDBRRmlWZ0dKTHZXL0xpUXRjUHJPWjdj?=
 =?utf-8?B?dUFCVW1HWjFQbVlVQmlWN0pMUDY5ZlgxN2dyZ2piZENjL0FmNTlxc3B6Yzc1?=
 =?utf-8?B?UUE3MlpwMGJZVXlqU0FPYUg0Vmd4cUVPNVNCaG1ZRVFtZ2tOQkphWTg1aEdR?=
 =?utf-8?B?NmNZbWwxZ0ppUURqUEtRaDZyQW8renlhZlROSzRrekhxUzdtNmZkYzNHSGVo?=
 =?utf-8?B?SjdPZE9vQXJzWDRRV3VsV3ZtQkdWUWpwYTZCc2tBSWxlWGZ4ZVVsR1BqWWRC?=
 =?utf-8?B?N1UxZ2I4RnFXNXZTVGZDV2xRejhENVMzR0dXVXNYREZBallOait4QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b17e05-0e0e-406d-b948-08de84475fac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:05:21.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdcYzFOu4yLYkLZClFj1NDuW3SMAnMhl9ydfFpjHJUSR7N38Ir6i81wyrym/4LKaUctMhzak3hHPSu87xen4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8334

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, March 18, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
