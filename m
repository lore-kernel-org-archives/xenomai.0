Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35753191CA
	for <xenomai@lists.linux.dev>; Sun,  1 Feb 2026 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938585; cv=fail; b=IeKgtpydBG0m/FG26+eZEpq5vAqkK3a0qTu+CCjnKaTJaPc8+TtkbbPTDMvJUdO3Y4bSl92DB2O8Va7iQetMbhIfJP/2sOVP+vVMIY0owjsF281ZS6oAa2O62yv/32qWVe9f/K/U9sGyR1EeDDXCuxI7BDg+kt/RTfpp/bFh6N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938585; c=relaxed/simple;
	bh=Prq5ZfjZ6cBg21GInZJowquDdWM41wygx5sd2Pi/Saw=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=INPuoHKLujs29vECFWs907J1gY+6P6tvUG+zNXPOsSgx+s6IeAkIw5XlTb1fmUllZt9A3V53s35tMg70KjEstsOV9YbBhB9DVk4PmTIA8EflTcNyzAB1pFRF2Gv9jbxvYX/tot7vPo+OtTmCRGVZ4DG5qcBIGViRvDZm0zX75a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C6ZR7haj; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C6ZR7haj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjqWpBOhJRIVV0mma0uXczBb53TA8S0i7hHBVFcA14ofIe7+Xy4DXEFTFzJH5IbvYq0x22gHTzBUtSvECxrqzlBskbnTRhFGJwgeKxFZwJZK5DXG2HnvUKoLFmT6JtqQGosOWnuWd5XC4L/nR91V8t40dzX9voN0QqqMiK+n+3Tz5dSI9B8QDeQByZpzpN+YssOxGBfOsSocQIVC9kwJmjfM9WWoSiGRpuOnEl5Af+FVnJO9+Z5vFWzkuD24QA9UfHuP3MmfHZnhxNk8PAcAPJtValhWZM+l7SutfwRJtS+CPIlmH+leCCFRZfpJmvBp4XdqIV+GZMfRLoEOL+Iklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEfNUMgNfq1UQehXoXMtMeGSHMXFpgZhXp5xI0Humpo=;
 b=ULFwGJj6RDrePLkjFS4Kxl/w40QbmlThNj177ZDiJUjOgctqHMun2KkY/nFwjOdCZjYYyeLHqdjXeficOM64aayPSwVMa5EVQWRDyUKdZlixW86SIwUNNVokjDor086B5mETveDHk7zfguOi3E+QWAdfjSC6bXoNvIw2s5RutXgQMmGXyp/qdN7TeRekIbr/2S5vsrlYun9h424ueHRf0QFIXhSw1rcQolP+Fbzd5G8kosizFi/uoADztfcAxtnkzPVEK0UKD2kKVuEThMP9+erB0qAyR2rGZcRTW7hgbU6zXolXTsNWnyhaPGaUATJpEgZEGYw35XMFMzOBQIBg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEfNUMgNfq1UQehXoXMtMeGSHMXFpgZhXp5xI0Humpo=;
 b=C6ZR7hajGgarpeHxKE1Upv0NMI30VdpOpS+B2EFlA7xtv9ytw9pTdUC/Y9vRQZGfDJTvEesEMNaNQorzHq4XhToPrCCAz43yQgfT9dcESb0DYkEBTS3PVbbzFGxqKqOb5NGClmFezvSs3pOdm+n929rbhhvp4gjC0swYY2CxCJNUfZMAoOdllIRPrBzuUtdR1Uzn7Xcnz8bY8tw+58Xi818JmBR4TxRhwM8BmKhDiNRBil8ZI10tlXj/yVqyrbQvY0Vq9d0j0lvu2UitN9xAUQcC/Qi+Q6PgfOcN2cfRFvzgLUpx0/6ih3rWIDB+VkeV2HI03UY6oJXJH2g/Q/L/Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 09:36:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 09:36:18 +0000
Message-ID: <0b60192d-053e-4ba4-96bc-2d60b5a8e464@siemens.com>
Date: Sun, 1 Feb 2026 10:36:15 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: d9579fb2-be0a-430d-a0db-08de617559d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWw5dHJvWDVUVnhDcDc5YzRmajBhNkJWUGUzaksxWHF4Qi8zeWoyZlZuMU5o?=
 =?utf-8?B?d1hMdW4xUFB2L3J2Vy9vMHZSemUySVE2Zkw5ZDh1bm5waGZXRHlVT0ltN21Y?=
 =?utf-8?B?ZnR6QjM3Uzd4MXd1MlkwNFRjTHNkdWdzUWFEcXQ3czNrNWdYaWZjZjJXbjdC?=
 =?utf-8?B?TDhiczZRSU8xUE9lVXZMZEJiTlBNajFrZngzZnVzRjJtUGR2TXNLL3J2bjRt?=
 =?utf-8?B?MUc3Zi95R2pnY0JqZURHNUpmWUpFZmZSMVZKcFRCTEtwc0pWK3k3VHZ2Q200?=
 =?utf-8?B?T0k1cUlFbWl4UjJZTWVWbDg5WGZLVGxYUVVYZVVheWMxRkVDSWlYcEt5NG50?=
 =?utf-8?B?MmVWbTZjNFZzOXFtcmtkQk5pc1ZLS2l4TFlIOVh1SGI3RTlZSDYwUUZ1M2pF?=
 =?utf-8?B?Nm5JR2NLV1k1aDZ5cjhvaHBBUFljcUJJcmp5aWxKbGptVllJY29DTVhqMnB2?=
 =?utf-8?B?T24yQy9CNjFwMXJJY253dlUxRGdOL25qOHdKQnpjblRDU09BemJ6Y2d0dENh?=
 =?utf-8?B?SGd2WTI4cW1kRlF0OWlZUDNJNzcxMUdkNjNsdUxNYytvQWd4cHhsTzVMYnRB?=
 =?utf-8?B?Y3BWTW9OUnFPbVBVdW9oWEFScGFlNnNES0tWOHV5ZzFXd3JhL3QzelZWSGdj?=
 =?utf-8?B?WEZNUlhQU05EaHZ6NGZiWGFhS3oxTWtiNWJHVURlOW1ZUHMrRGc5V0RxZkN6?=
 =?utf-8?B?S0hvenk1M2xzQmlZOUhqa0lQZi9HakFlSjJNallKNWgyNFhiS3lzL0RZZGNa?=
 =?utf-8?B?Vk84YkdrUUdRU05CalZsUlZtSXB1TTlmM2ZmempPbEk0ZjRGWGwwVkZuMVN0?=
 =?utf-8?B?U2s3VG9EWnhoNHJ2WVUwWk9MU3NvRHh0SW5qUzRZSi9yQ0Vsazl4aTR5S1Fl?=
 =?utf-8?B?UkJDeHJvVS9iQzhXZWMzT2t1NFFrcGhtMUIzUWkzai9HY3ExdzBXc3VwdXNz?=
 =?utf-8?B?d3BaSjNhRXRjRm4vaHBwS2dWYmNnTnpMcGhIcTZLZHBRSE8yd3FYdGdVWVR2?=
 =?utf-8?B?UmtxUlNwenU3b3FqTFgxUW80cWhNL2UwVEpPQXN4aGF1Q2NqSFBDRG1mdTlO?=
 =?utf-8?B?QklpNllsU04yL2J3Z1ZiN2tzNnBBb3VJY0hHY1RrSDlFZGRXbzNZNlFIV0Nu?=
 =?utf-8?B?c3NMei9rY1c4NDZWcWtwZEJlK2ROU0JPQUtDSHJrZ0UyYkhuS2d4Z0htUE8z?=
 =?utf-8?B?SG1Da2gxSTVJTWE5R2FJZDBMaFQ2WjZJZ0x0d2U3b0xXMFB0TVdpVE9iWTV5?=
 =?utf-8?B?QXdTVE1ZOXNmY29WbDZjL2JMbisveG1UN0s3TTkxYlJSd0dTRzlzVEpmRlBv?=
 =?utf-8?B?aGVBbWkyeDFWM0dHdk41TTlKOGJPQkc5SDk3TzRjWjNxdlNtRXovdkFZajkr?=
 =?utf-8?B?UHZmTmowYmZRdzNxSHRVUVVYMUJkVEdJMEY4WW1ZNjh6OFA4TGhCS2tkZERX?=
 =?utf-8?B?b1dTRDU4KzhOcHBVSFdUUGp1T3BRSHN2Y2IzZGNWTWZpZDVXQ2R6U0xYQklt?=
 =?utf-8?B?ZVpuMHBVa2NnZXJxUHpId0x4Q0VoU2RVZGhxMDFENVlRSS9ObE1PNnBrM2ND?=
 =?utf-8?B?TDY4TzNKQVQxUGtXQkVKNGxFU3pnM3VPU01nS0x0ZzRuM2hnVDJ0VEVDSUV4?=
 =?utf-8?B?OEZRVWxQTDRSdWdXMzYwUFFMd2VxK1hhQTJtNkJqNzNwUDhvaEJPTXg5bTgy?=
 =?utf-8?B?a3R0NU4xbHo4emNNa3lJQWdVQ2tQRTF5K045enRxajg1MGVEV1ZVUVRFMncr?=
 =?utf-8?B?akNCY0RKZGRERHNZYjdzdjJNdHBlTFBVQ2IxQk1WOGc1RGNla0NOblR0UUtW?=
 =?utf-8?B?QmJKb0xCRjUxcHZybFFpaktKK04relBYTkZDOUw5VllpR1ZHa3V6dmFKZEVJ?=
 =?utf-8?B?VzNyVlNmUUVjQ25jUHBlNEpRWDRTaThDVXg2VjVjTS9OZzlVS2VKekhYNnVJ?=
 =?utf-8?B?ZW93YjAyYW8zU3B6RlpsY2FHTHptYXhROUQ4cGpRKzNsMlpwVVFsM1lZMGd4?=
 =?utf-8?B?ZkNKL0hFTkRESUtYWWFXWGMrcE9HWmRXVlJnbXRtTFBRTThEMEV1Z25vejd3?=
 =?utf-8?B?ZWxZZ0ZueEV4dnhtZHl0Ui9UYjN6TE90S0lHb3B2azY2a3dBeFJYckJwVlhr?=
 =?utf-8?Q?nGYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmpVajZWcnc1aDlrWm5zdnNYcHhEY2VBWnRtT1l1VjRTblVFSVM5NDBVbnZF?=
 =?utf-8?B?MHQxWERYQnlJeXo1S3J6SDBUUVdib2lCcGZFa2ova3RJRVVzQWJhd2Q4c2JU?=
 =?utf-8?B?enk5aTFrVEVDYVdEKzAzbGZodU54Y3pvOVdnNWF1a1VlRVQrV1RDV2t2Tytw?=
 =?utf-8?B?cDNaVzhmeWZWaTBzTUYxNGpNQjJFVzlPeWxEemlSZ1FmelFaa1lZaXdVYWh1?=
 =?utf-8?B?OUV3NW44TzB1ZEpqaEdDWVFMUm9yUkNyLzRYS3RuczNDTzl5WE5mRFZMWWZD?=
 =?utf-8?B?N1BodFBmMU1YRkJwVmJNeFpQOXBNNFhqM3VHNjJmQlh3U2R0bStKVWJTVlJh?=
 =?utf-8?B?OWxSMk1zM0xjZTRJR0RET3pYbnpHR2NSdkdLVVNqcVNqcmpWRVFhMHhEZlJq?=
 =?utf-8?B?MlJSRUZsM1lkRzR6VHd6QmJndk9JMEMwU1lKVFhaRHlYV1o4cTl1dWpvcmtk?=
 =?utf-8?B?cFdLb3JacDlldWpYZ0tTdTk0ODJMTFJuRzgwTXpEcGNzZEpQMi81eXd4bkww?=
 =?utf-8?B?cjFUcUl0NTJkYkM5d1FtYWI1OGNrMTVCUVQraFViOW5vaXBBbGV2YUlLcnNa?=
 =?utf-8?B?aTJJbFBRekNLa2NkMGEyZzhXV3RZdkxMRUZwcVNHY1pRd2RDeC9za2RqTkpt?=
 =?utf-8?B?YnRpLytrRmh1UFdaRkZ1UmFvSzM1WjNDN1NjUlB1QTlubmdudEpKYTRUUFN3?=
 =?utf-8?B?eFJSamdLdGdPVG15RzUvSmptU2tSTE8remFCVTV2S2FjcGtlNTU2WE9BcXJ6?=
 =?utf-8?B?d3U2L1JEZm1TYWVlZGdpdmliNHJuNmF2TlZDVWltQ1Z3UnFtYWsxOHY4TVhS?=
 =?utf-8?B?YU1IbnNMdmlSS3h5Q29rWDVNK1N6Y2hENnVHZm8rK2NrYzk5a0RsWmZrdk1h?=
 =?utf-8?B?SEdweWR2OGRGdjI2ZUlwU0dyUmQ3N253YmxNdVk0a0l4amg1dDdNRkR5YSsy?=
 =?utf-8?B?QlhRanVoTUwvMkdRNzlXRUpGOSsraFpFMDlCWk1sbHJsNUxPUVBhR1YxZ0Ix?=
 =?utf-8?B?cDBDSERyeWt4RXRUcTlhR0NoWXBQTWEyYnlQaDJaZk12NStRclFmaHVSQTFV?=
 =?utf-8?B?b3BMT2NLc29zek94K2w3TS9pd0d0c21yK3RVR2I1Vlk2dyt4d2xPUnRKUGxa?=
 =?utf-8?B?WTBoTklOQ25OVXdZMW5KYXE4M1Y4Sis2U0Y5L1ZoUkh2QmZ1b2Z4UDV6aWJw?=
 =?utf-8?B?VjIyNHp1YTFZSXYzUjlrc3pJOGlWbFU5ZEJlaU4rbkI3Q1dLak11ZmVOOG1F?=
 =?utf-8?B?SVQ2NTdzY0Q3VXE4aENwV28xMDJWRjJoRHo0ZWZsTFZkejlGamRRbXZyL1Bi?=
 =?utf-8?B?NWg2dHdEblg3UWNXOFpWaDdtOURjcGM1d2UycHJsUkpvdDgxYjNrdHFkaUo0?=
 =?utf-8?B?REJlbmlBaXZVTFVrQ0tQdHJQdWlCMk5MZmRxaEhucHoyUXhvdnJ1Vkk2Wncv?=
 =?utf-8?B?aUdGQ05MZjRjbDBCQU9vck9xSnd0RnQ3LzhHd1h4enNQYm5iUlJ5UDhDdm9w?=
 =?utf-8?B?c0dKcGtqdEthOXZiQ3ZTWmpYYkl4eHBoMUl4eEZGYlU4ZWU3bkQxWGJxZEo3?=
 =?utf-8?B?czhTcjU0aHJFUTlWYm5NN01aYis1cVp6S0lUaUFZKzhBcEhKQlUzZVN1UEM0?=
 =?utf-8?B?cTVmTEo0SVBKZkgrYlNMTDJTUDdjbTg2Zm02cUF6S2VlZ2ZidXRxWTBuYkhR?=
 =?utf-8?B?QldJRk1vUnBnNVhObCtyZEM1NDZibUQyc2Vyakc4elp2TllSY294S2FydTlx?=
 =?utf-8?B?ZDRaWGI0RXBhT3R5NEs5SkZlMWZuZldRMSszOGR2eWEwZHo2dDNIVW9YNEp6?=
 =?utf-8?B?aUNnbU9xMUZWQ1RRYWp0WG93QmJSZFU4dUE4clNBTmYrNzJjSGxzakR5TytO?=
 =?utf-8?B?UjIrcisrZ2tnZlVyZ2M4Vk94aHZPWGViKzZMT1hBcmJ6SUoxM0R0WmFqVWNH?=
 =?utf-8?B?M2xRdWNYTFhiK3N6VFF0cmo0eDlYNG91N2VvUkhXRW5LSkpQL3pvZ3ZnT0FJ?=
 =?utf-8?B?RDJWOHI4bzgxOGVpTk5nQlQ5Y1hodXFvTXpyZE1zcEZnMGY3aDlVWVh5cWZ4?=
 =?utf-8?B?TnBPU1FSaVFTOVVhRUh3dUd5WThSU1l4Zm9pcVlPQzVzeW50Vkh5a1pXTEY5?=
 =?utf-8?B?K3c5NnJ4M3NsbXRLUlkxdTdtNkpQdzdrVCtsc0dLM3pCV1ROVmY4S1Z2akg4?=
 =?utf-8?B?ODdjaFN1cFVxTDNiUXI2cmZ6cUpmZlpsNmE0SEFkOTNKZnBDREtrOE1aeTZW?=
 =?utf-8?B?MU5QMktGN3psYVowTjJYdmlpQkNWTjBSQTliMm5McjQ4NHBsRWZUUXFxK09Y?=
 =?utf-8?B?QVlpOGs4bjl2K0xsZkNFaE9vUkpNSDVaVGNnZjVmKyt4WWV5bHRXWmNDR3hQ?=
 =?utf-8?Q?E8HkV9tUT7lR9sqxTWKkQzP1qWGnC2R2pqYWgpY5x2D7K?=
X-MS-Exchange-AntiSpam-MessageData-1: Ds17VMdvM9GLuA==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9579fb2-be0a-430d-a0db-08de617559d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 09:36:18.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44+XPVMq4HzeUkryjwZfdTvf6kHc2zjJY3AhaY83E21MetyhSbzFpUFujmj0mOKQOGdYP54zkHxMMrH35ft4GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6918

From: Jan Kiszka <jan.kiszka@siemens.com>

When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
glibc. The original mmap continues to expect native off_t size, i.e.
32 bits on 32-bit archs.

While we require applications to be rebuilt with the same settings
Xenomai was built with as well (either both _TIME_BITS and
_FILE_OFFSET_BITS set to 64 or both left unset) which practically
shadows this issue, it remains wrong to change the wrapped mmap function
in a was that is incompatible with glibc.

To avoid running into conflicts between enabling and disabling
_TIME_BITS=64 and, thus, also _FILE_OFFSET_BITS=64, factor out the
affected mmap wrappers as well as their __real stubs into a separate
code module.

Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - factor out 32-bit off_t code into separate module
 - add missing libcobaltext_la_LDFLAGS
 - and v1 was completely broken...

 lib/cobalt/Makefile.am | 15 ++++++++
 lib/cobalt/mmap.c      | 79 ++++++++++++++++++++++++++++++++++++++++++
 lib/cobalt/rtdm.c      | 38 --------------------
 lib/cobalt/wrappers.c  | 17 ---------
 4 files changed, 94 insertions(+), 55 deletions(-)
 create mode 100644 lib/cobalt/mmap.c

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 4318adf185..ed7e503899 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -7,9 +7,12 @@ noinst_HEADERS =	\
 
 lib_LTLIBRARIES = libcobalt.la libmodechk.la
 
+noinst_LTLIBRARIES = libcobaltext.la
+
 libcobalt_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 2:0:0 -lpthread -lrt
 
 libcobalt_la_LIBADD = \
+	libcobaltext.la				\
 	arch/@XENO_TARGET_ARCH@/libarch.la	\
 	../boilerplate/libboilerplate.la
 
@@ -43,6 +46,18 @@ libcobalt_la_CPPFLAGS =			\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+# source files that require native off_t size
+libcobaltext_la_SOURCES =	\
+	mmap.c
+
+libcobaltext_la_LDFLAGS = @XENO_LIB_LDFLAGS@
+
+libcobaltext_la_CPPFLAGS =		\
+	@XENO_COBALT_CFLAGS@		\
+	-I$(top_srcdir)/include/cobalt	\
+	-I$(top_srcdir)/include		\
+	-U_TIME_BITS -U_FILE_OFFSET_BITS
+
 libmodechk_la_LIBADD = libcobalt.la
 
 libmodechk_la_SOURCES =	\
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
new file mode 100644
index 0000000000..069163a855
--- /dev/null
+++ b/lib/cobalt/mmap.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>.
+ * Copyright (C) 2005 Heikki Lindholm <holindho@cs.helsinki.fi>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+  USA.
+ */
+
+#include <sys/mman.h>
+#include <rtdm/rtdm.h>
+#include <cobalt/uapi/syscall.h>
+#include <asm/xenomai/syscall.h>
+
+COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
+			     int fd, off64_t offset))
+{
+	struct _rtdm_mmap_request rma;
+	int ret;
+
+	if (fd < 0) /* We don't do anonymous mappings. */
+		goto regular;
+
+	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
+	rma.length = length;
+	rma.offset = offset;
+	rma.prot = prot;
+	rma.flags = flags;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
+	if (ret != -EADV && ret != -ENOSYS) {
+		if (ret) {
+			errno = -ret;
+			return MAP_FAILED;
+		}
+
+		return addr;
+	}
+
+regular:
+#if mmap64 == mmap
+	return __STD(mmap(addr, length, prot, flags, fd, offset));
+#else
+	return __STD(mmap64(addr, length, prot, flags, fd, offset));
+#endif
+}
+
+COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
+			   int fd, off_t offset))
+{
+	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
+}
+
+__weak
+void *__real_mmap(void *addr, size_t length, int prot, int flags,
+		  int fd, off_t offset)
+{
+	return mmap(addr, length, prot, flags, fd, offset);
+}
+
+#if mmap64 != mmap
+__weak
+void *__real_mmap64(void *addr, size_t length, int prot, int flags,
+		  int fd, off64_t offset)
+{
+	return mmap64(addr, length, prot, flags, fd, offset);
+}
+#endif
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b2..119ba3f83d 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -541,41 +541,3 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
 
 	return __STD(shutdown(fd, how));
 }
-
-COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
-			     int fd, off64_t offset))
-{
-	struct _rtdm_mmap_request rma;
-	int ret;
-
-	if (fd < 0) /* We don't do anonymous mappings. */
-		goto regular;
-
-	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
-	rma.length = length;
-	rma.offset = offset;
-	rma.prot = prot;
-	rma.flags = flags;
-
-	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
-	if (ret != -EADV && ret != -ENOSYS) {
-		ret = set_errno(ret);
-		if (ret)
-			return MAP_FAILED;
-
-		return addr;
-	}
-
-regular:
-#if mmap64 == mmap
-	return __STD(mmap(addr, length, prot, flags, fd, offset));
-#else
-	return __STD(mmap64(addr, length, prot, flags, fd, offset));
-#endif
-}
-
-COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
-			   int fd, off_t offset))
-{
-	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
-}
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 18c237734f..3a0063f051 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -28,7 +28,6 @@
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <sys/mman.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -384,22 +383,6 @@ int __real_select (int __nfds, fd_set *__restrict __readfds,
 	return select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
 }
 
-__weak
-void *__real_mmap(void *addr, size_t length, int prot, int flags,
-		  int fd, off_t offset)
-{
-	return mmap(addr, length, prot, flags, fd, offset);
-}
-
-#if mmap64 != mmap
-__weak
-void *__real_mmap64(void *addr, size_t length, int prot, int flags,
-		  int fd, off64_t offset)
-{
-	return mmap64(addr, length, prot, flags, fd, offset);
-}
-#endif
-
 __weak
 int __real_vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-- 
2.51.0
