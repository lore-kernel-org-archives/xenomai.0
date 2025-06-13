Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861221B19D
	for <xenomai@lists.linux.dev>; Fri, 13 Jun 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749796448; cv=fail; b=F1UWK8mWgRAbLasDotErzCffiGj98ClqO7x+RLH3K3GDYfUOK+lZwWJxq/1y/61sbl2rSrsXiEVBibegewpUuBD2nI9Q85giHdCG+vTutdPoOsQu7JfuMiZiw2Y75feHCDtyeVnM/LJHF2+KmtIgFkfE2A+r7HzqbuJL7+7yScg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749796448; c=relaxed/simple;
	bh=ROfsjxs1N2QLzFD5X3U1NFbAGXIEbrRMbLgyMn8VRYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ixg0XXQT4tUVDHc5hmiQMFWFS1cJEGE2uF6UTWKMZvlQxBMnbFoEHqie4X7aHF/FtC6hXuytJoEE9CHBQ2Bt5iAI0WBLCPQfWN1lP3+tNNoBF1VFnV9MJKhZF48nfyu3UdtRX/XxRxKNlSk8s8nP4mEIIm6CIaPqPHcbojgDfG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OCgC2gnj; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OCgC2gnj"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 3D11D43BD2
	for <xenomai@lists.linux.dev>; Fri, 13 Jun 2025 06:34:03 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 53966D80047
	for <xenomai@xenomai.org>; Fri, 13 Jun 2025 06:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjRbUG+2vbOx16HDR3M/Xs2x3SiB/BE1Sku3sf8jSyful7/tnVCqCEed5lzUK3BEHK1NN8tRQW9SCTPCveLrds9vMD98ijkXEYN6ZkFg35YXv4z4+Iy/+LQD7/qENFm9NcL13Ic39nUolUGnNyPm0oNGI0J6B5DiKkLjnSZjoVWsm/sesaz5KenvrJzvy4gAWKMbs+XHC3RFmLxFSCcpHHGiK+DN7Ml5dPL/sWi/gHpvzaD8bOo/78CgppUlxCL2sF+9BtZ4/pujFDtZNdHmmaEIm3dXFXsVlRCBc6JJYQHGiQnbwPCPcnDntDkN0n1bNZUTa90Lz9mnjbIwOhZVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPM4rNE2IX5RoytbgHQwCaDtL3sQ7dj+uG2Qea2cMaY=;
 b=lgBT853QqndtTFAUXvY9B0yFl9/UpeXOlMoP3ZazBRhycLvYY+BGaIt3+7l6zSKPa+94UiNDenwyRyjaGTnZr97/Uu4mOW+PyGNVSCa4zs+7kOY7hhzBBuTM0PTAAVMr/Sv1/2m8YKTNIHFl1w4asgeofAn/LUIexWS61wAdJRrajCK4FnxLqGDSjJJSc9NiPcvmG5P768t3E1UILeRgiMUzxffWR7D/C2ZvrsDbFH8711ONVkjqv25OGuhbidgifFkTieB2Rk+WDW4as/jMpjcxvrOJvxyV8wDg11pau+yiR5G31k/+qxbRUIqkcx5xEcF5LQj4HpD8/warS13hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPM4rNE2IX5RoytbgHQwCaDtL3sQ7dj+uG2Qea2cMaY=;
 b=OCgC2gnjuv+h5fu2zhJ3oQptZD9eV/7EYmn5Ws5EqRXxV0o0k7s0D3bYDH30Ta7Yooy8OmAGfIL+RUrddcHKQkmDw1MKQnd3xud1SFs1H31TzJ3l8WzcHE3RFaZoYIHO0p/ZaiGva1o0LXZsiwT10Xalbqa6TEX4e4F2fjPfLN1n2oT5JXGygRgt4yPrRUAUpGjkabya1TCwYZfmsiHNT3qhUaoArFOgboqzwX4MoMhvZ4exY8kl0ulI/KVN7thKV2Xy24LZG15gruFg89P9Gvsg1zuKGtsTvMO1QlLlk8FzFkFARURGdExdO/7t3AhbrVxDCerKF+/uLDilViYc6Q==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 06:34:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 06:34:00 +0000
Message-ID: <77d08e8d-f5c9-4336-8720-d25f98561ed8@siemens.com>
Date: Fri, 13 Jun 2025 08:33:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry Regrading Xenomai Usage
To: =?UTF-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?UTF-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
 =?UTF-8?B?7J207ZiV7ISdKEh5dW5nc2VvayBMZWUpIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <hyungseok3.lee@doosan.com>,
 =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQ=?=
 <junesoo.im@doosan.com>
References: <PU4P216MB13530BC40F39719E7871C290A977A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PU4P216MB13530BC40F39719E7871C290A977A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b91ed3e-84e2-4f42-c2da-08ddaa44486a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEcrTmMyRjZUMnlRMStqTXl4ejFUS25uYU9YZWt4MWZXV3hibWdlS2tFdW8x?=
 =?utf-8?B?akdoRUhZMWFSY0p6SFhGaGNoREFHb3g3TW9BMWhtN05KOWlQelJrY20vekUv?=
 =?utf-8?B?SWN5SWpDbGZFTE45TWJubG1ZUXpzekRZaUZHTzl3ZkJrSW9pNHNTSXdIMWVq?=
 =?utf-8?B?NVN2clU4b3JTMk5uc3BLUzJFM1Y2aEQyUDhuOS9DNE5WTmVmSWl4MGl3T0tv?=
 =?utf-8?B?SHZZbjdrZVRmWVAvTUtFZzBkLzhkZ3hrai81c1luTWNzcm1Wc3JrUzZMa3V6?=
 =?utf-8?B?RTNhTzRWU0VDWmswQkpnbUYxTDVqdmN5VHE0a1g0TUk2aHZDT0ExT29RUTIr?=
 =?utf-8?B?UGJUMDdyVU5LNXJaN1o3YzNkbUtFdU1IYkZ0UEEyOXNRdi9kSVBJcW4zQkc0?=
 =?utf-8?B?RXJ6QXpJSFNUUFdRNU1iaHhKSnBCOHFOWEkxOFIyenVFVkp2a0E2clhXVHpP?=
 =?utf-8?B?alBWeFV3OVA2bkphWnYvdnVGaGpOOVpyL1A3QmMrNGRoSjByOUljcE1KYTF0?=
 =?utf-8?B?ZGo3ZTcvRmErdUhQMnJkYlp6L2cyS2JCMG1iS2RieEdlcGEvd3k1VThxNERP?=
 =?utf-8?B?MzlOa3BqUGU2OGExd2hTSEo4ZzhmV2g0UktuaElpNDVTRmJmWXNxeXdoS3BJ?=
 =?utf-8?B?YW5zMnRsNDFuSjg0VkE3U1JKOHdJSDJPK0RTMzMyTmovR2VTS0dBd0VabHRk?=
 =?utf-8?B?NXVuQW1qWkRVNjFYRklhWG1ZOHVjOVpaZ0lKdUQyaHN0ckZRNUtPVHdlRWlp?=
 =?utf-8?B?WlNYVnRaV3RIZ1h5RFVFbExJVVNPOGpuM3FWamEyMjUvMlVxT2poaVg2U2da?=
 =?utf-8?B?SVFzMktzSkRaL09RbXZNU1FjM3ZreFFGOFV6M3BuV3hEYkhDRTQ2V1hnc3N1?=
 =?utf-8?B?UGtUUENuSXRDck9QdXRacW9ZM2s0blZBblk1VjFVVjJxLzhadnZiQTdCZGow?=
 =?utf-8?B?S254Sk0wbHVULysxTFRPdGhqSTdUS0ROdmowMHpFd3B0bHE4dmNFWUZudFRE?=
 =?utf-8?B?VmgzSndSREsrczlIK211dzBQSS9nc3FvSG5ZajhFbDdrQXJMQmVoTlNRaERB?=
 =?utf-8?B?NEpGRXJSc3dCN1ZjSWYwYUxNTkh5cDdCVkhsQ3hiVFRtM2FPcHMwc1UxdTlP?=
 =?utf-8?B?NFRGSTh2Wno1MXNrSG51TE55cUw4T1RDVUNvUE9jd0FmcHU1anExMkdXVWgz?=
 =?utf-8?B?ZnRQK0xMTEdGb1dKY2VvQjlYRDhDaVoyZ1ZudjA2TXVPSzhwMHN4VnJ1ejVa?=
 =?utf-8?B?cGVwZktGQkpoVlRnSGE5UStCT3Z2MWNPMWQ2SzJQazFVMmVQRGJVb2ZxZ2NM?=
 =?utf-8?B?aC9qR29mdWZFWnRIKzFvRG82Zm5ZMjNJb3UvR2Nqa2ZxVGtSRlJ6SUprZ2FD?=
 =?utf-8?B?eGczSjNDdGwxQlZmR3l4QmxzZDFOQzJ3bWZVOS82M1RQUDZkdWlyKzFJQWdH?=
 =?utf-8?B?QmNJNmtCRmdqR1l1b3hJa1IycnFYOEpxbFFGSjlUd0Y5R3dpVTIxT3BlRnVJ?=
 =?utf-8?B?bDVzNlhML1JUQ1lCTExyaHljWFFFeWdXaURmelVNanJibDdhT1hWRU9sUmF6?=
 =?utf-8?B?ekE5aGp0VUZQZ1hFRGJTV3RnV2dJeEhjc2oybWkvZVY4cXp5RWRwQmQ1bC84?=
 =?utf-8?B?d2l3NzYyWUVjdTllVngwcCtKVmF0MVB6YVVRcDg2NHRvQTExYkNqcVEvYmsz?=
 =?utf-8?B?WUQrb2g3TTBEV3VWVXphZ1RsYUFEa2g3QUJDZTVaRWg0UzdsQnc0RWhYcHpt?=
 =?utf-8?B?c2RvVTlTK2VadXd3YUIycGFXM1ZQL294MGs0S2xFckxZTzdsdDltRjBSS2lH?=
 =?utf-8?B?djh3TllTNzRKVzdnUXJldTRuZFRPa1ZQQ08xQjJrM2dyS3FsWmpyaDBhVGFT?=
 =?utf-8?B?TmNNdFBkY3dSSEZNOGIzWHUySEZESGg3UlkrOGo4NDU3M1plNDE0ZENYNzJT?=
 =?utf-8?B?VE1lV1V3RllUZG9ZUGxqZTRKYTR6Q0t3Sy9hVTNxRUh5NzJXR0d2dmd0Um5q?=
 =?utf-8?B?TSsraG13VWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtqeWJ1WGZSQkpTU2N6c1RvM0UxZW1hNXB4dzd5TzFkMExwc3crVGNGQlBO?=
 =?utf-8?B?dnpQWCtTRW8xaGdxTlNZb3JwZFA5THFRM2JicW54NS9DeFRWSis3RUFpS1BL?=
 =?utf-8?B?cmF3WWRnWUozSzVKMDBORWM2cGhnSFZvTUd3KzEwWG05WWZUQTljSm9wZmkw?=
 =?utf-8?B?c0RrMDl4TGZqQ2V5a1AxenV3bHFBRm1aZWRQUHQ2VmplNlRMZnhBMnFNOXl4?=
 =?utf-8?B?MXl4LzdZVW9RalZ1bGNrV2h2VW9ncmNMRDZuV1ZuSy9VVmYyVVh4Q0FKOVZl?=
 =?utf-8?B?NkdjdDJScUVzM3U0NzB4RWhVOTRWUENEZmtCOW9UR3R2OVVsY3ppemhJMm1r?=
 =?utf-8?B?S29adXFMWGYxaVVnamE2RGk0TUVNMVFWR1hLRFh3NVlyR3NUUU94VlJYUFBX?=
 =?utf-8?B?WXkzbEQ1dytyTWJVZktnZzZucWdmaDBxKzgrTUR3V2RsRDVZTEhONlY2WGlJ?=
 =?utf-8?B?bm4zQmFoMUpJWVBmSjlkY28vbVpubGNTSUNMODdFQWlRancrYnBKVGt3SG1m?=
 =?utf-8?B?NnhNcFdOeTFYa20rUWFCaXUwL0xoajY4Q1pJRHpadVJ2bVoxTlVNT1BUUDZt?=
 =?utf-8?B?RXdWS0x0VDgwN1FTbmdpcVNvbi9aTWYxQ25EbTI0ajUxWmpqSnRrQWxDZUdv?=
 =?utf-8?B?WTBKdzUycE4zNm4yd242S0tOdVJubldPYkk2TCsrQlJ5SlVwOXFoMEF5UnU2?=
 =?utf-8?B?NWJyaFZnaFhlbUQ5d3dESld5dDJwMXRzRFE2QWNqUFJ1Z1A5bCtuVjc1SEJK?=
 =?utf-8?B?UjYxSm5XTkd5SFRlQXVNakNaOXJoUXNyTS9WZlBMUlpqZUtmS1JzOEJ5Z1ln?=
 =?utf-8?B?elcyTWw1M0NucXl0dFV0MjA1SDVxQmFhbmxvN0FUaWFZVmV0K1k1ZENsK1da?=
 =?utf-8?B?RjlNaFlEVFAxbTNURE9KZ0QrVUprUTd4WE82VFdzTjUwM2FuRzgvWFNkcG05?=
 =?utf-8?B?Smd6c0ZXVE9aWFZHd2xERVNlUCtranAyczZtZkFzdGpFZTN6YTJVTlNYVm91?=
 =?utf-8?B?aDR5V0liQjg5Uktmc2JVOXBZb3ZHYmhUemppOUJCdFlabWlUeDhmRGQ5S3Jv?=
 =?utf-8?B?djN2MW1lUE5TU2NTaFo3T1dndE03MVRaQXpnR0pyZTZWWmFpVWJvanFLT3pC?=
 =?utf-8?B?bU41NlgwemZKZDRLTk9iRHpxWW9OblJZYUJsS1dXcEMrMXEyaEVYNTR4Um5q?=
 =?utf-8?B?c2R1aFh4dVQvQndMRUwrRVpXamdDRndScW5YMTlMN1ptQUx5d1pzRlRzRmlT?=
 =?utf-8?B?VU1jNTlEMzlsbGpXZy9VMUJWcHBhc1BQUkpUalRta3duazhhSGVnOXVPcERl?=
 =?utf-8?B?N3I0VVFUczlXVVFZUDgwSlBrWE14UGs2QzVBdWJXRHFNaXpqWlNTQVFvb1ZU?=
 =?utf-8?B?WnBFOFRyYUl5Nk92eDM1S2RYUFpsMnNoVWVmRnBoQjVwVlY1cTRScjJwZWI2?=
 =?utf-8?B?WXVyZ25uSXIvcXU3ZGNvaGJoa2RkckxsaCtORnBaWUR2Mk1JbmtaRWd2bXlB?=
 =?utf-8?B?dlpoTXkxdTRadUkzMUxOSnpaOW1QdllIUGJYS255M1VCQ1lPZCszMlRVdzlm?=
 =?utf-8?B?SjNtRDNEZmt1Z21mNVhoSnM3VXcvM3U5VUp2TVZ2Z3A2Q3JZTW9MeFBxUXRr?=
 =?utf-8?B?SEw1U1RpOWJhMU5MSEExZkxXc0VqcGR2cXliZU9zcUErVE41N200SFhiNVVh?=
 =?utf-8?B?dStpK0lQS2FQVGE3bEU2Mkg5L2VzdEVSVDQvcXdmekpqWUtjWGZZSXcycy80?=
 =?utf-8?B?MkZsQUFmL0NDTzVheFptY0xqNVl5SmtnNHZwVUIydzJ4R3BabnRyV21vUjFT?=
 =?utf-8?B?VWdPVStOR3E1R2ZGYTgwNVJVWmxKMzN1SS80TE9Sbkw0Z244ZVIvcTNsOEgv?=
 =?utf-8?B?aWh1Kzk2eHdoSVdHTFhmeDNmZ09CRkRKSWQvZVgwLzJUSk5XZDc1WlJHcnlV?=
 =?utf-8?B?aVBLaVFCV2J2L1poSXFpcGFSUGdmbkJ4SlU0K05PRENpcmZlNHprSTBaRnFG?=
 =?utf-8?B?ayszcEppMERmdmtndHhUck9HTjRZRjlGUE05WmVoMklLYjdXRFRwWWprNTdB?=
 =?utf-8?B?cjhiMTNQVGt4YWxTeHdjQWxlVUVOdkdVSDdoT2NKZkdyNzczbFBncEY2TWt4?=
 =?utf-8?B?S1V5cjhtOXlZOVEvcWR5a3lmRCt0bTV2c1pwSTdJL2JPM3RhVy9oQmF6WGFx?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b91ed3e-84e2-4f42-c2da-08ddaa44486a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 06:34:00.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4CLXC0QxZpc45egpqc+0njUfFQ/YThr/uhcD78CeepC8uy6rIZgrXYN+Ovw9rz8lS/eXyWsNyD1/QsOivz9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3195
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=OCgC2gnj;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c20a::7) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujedvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffffgfuvfevfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhephfduvefgiedvudefuddtjefgveevtdekueekffeikeegiefhvdevkeeuffehheffnecukfhppedvudejrdejtddrudejkedrvddugedpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 13.06.25 03:23, 신민철(Mincheol Shin) 선임 두산로보틱스 wrote:
> Dear Xenomai Project Team,
> 
> Hello, my name is Mincheol Shin from the Doosan Robotics Control Architecture & Framework Team.
> 
> Thanks to your previous response to my inquiry, we have chosen Xenomai as our Real-Time OS and are actively using it. While creating applications using Xenomai and referencing the Xenomai API Manual Web Page and PDF files, I have encountered some questions.
> 
> We have tried using the Real-Time IPC (IDDP, XDDP, Bufp) provided by Xenomai, but it does not suit our needs. Is there an API in Xenomai that allows us to use shared memory in a way similar to typical shared memory usage?
> 
> If there is no shared memory-related API in Xenomai, is it acceptable to use POSIX shared memory-related APIs in a Real-Time Process without causing issues?

Yes, as there is no special need for handling pre-allocated shared
memory differently under Xenomai, you can simply use shm_* etc. between
your Xenomai applications.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
