Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DC3C4B87
	for <xenomai@lists.linux.dev>; Tue, 23 Jun 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253794; cv=fail; b=rZ0wUkO1GtzmrD2rCXvrsXoXVGZU9SRehcQoOeWN11K3eMZ0b4Q35YYW7puMTM+lE/F8JvKKGQDqb0SDt1ASzgvv7QU2Mb4F1LmPbe9q9BQC3oO2zl4/68LkdxqHqKhV7BwjOgOq8Q0hs4LY7CYCqbusOBAIh0yqnZNgAIbOw8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253794; c=relaxed/simple;
	bh=v2W56cuXDQEXMa+huHJY8l+oUnPIrOoz6BrcrkWd+PY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=dVdoBy1cBwYcEuXBDEEyGcmGpB1L4DNfqFldogy57VGK1zgABdY5M0CsfaPYYtPj1nx4rHl2h1TbT3fLV7y03NaGnvkdBWwlZTvN2ErAd2eoxsH9ZCIW08kpCRBGhQco8CinPWYdTGcr4TwjUPIE5w6568Kmz9ZDyOHh6/iN09Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HGjmlRyC; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HGjmlRyC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9a/wttmfGp8cVDww1Z2np8e28Y9LG5f+0oX1hvmpkCA5IcVXt2ghLYdPAs1nVu9rrZvVCCqHxXXmjosCrcKAwCwTtoCJJHgUN6q78ywdeiHcRbo1wUYT27sHYxKo99+yVtazJ1dIn0mhDIOc05+HMyrJ9ws+smNSkjN1ZLl6BwKCE+tEmuRb+xKftWdUlZ5j4GDbkCMboGgR2hQbull5Dk7pnXh3pLH4dkWRk4Yo84Qvuq+r3rIRaMChGvaLmO+fnmRdZZRUlHKwLP0xvNsRDm1QyhIvHsdQ2mdP4LgYwhcupnDJ5yJWCKevmIEFpif6lIDYjh0cUO8A1TsTN04tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+HdrcVhmrR1ZcTSmt53LoxRa8pMezBYIPHinpbWNsA=;
 b=oT5FLmf613sqnyanaBlggkF29yK7NGe5xUOAxxts2IjHFRzidoEyj4OQfestXqyoFlrAWTt4XqzxwwpSlNwOJAjFpnQWV4UqcwZ1NYRTMAsZSCt/8f6Ajaop4G21BqHTBRYTAnzT5crHKDTKO99jKdL61DBbEJxh8sJMd41Hx/zgRMwK0adL09gDFgYHVviO2lv1rgEfcy2F8LktwAG1EJP6cIbPU/E5KbMWFIRsx9rcShy9XVNYunBnEzA9t3SpM1rgM5QPORnE7D4wW50Dp4+AKOLSYfRgQYexlQrTDvZq9WRbgrB1/0zZfvBiZyGkE3VNzBR66bnWjrmLEauCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+HdrcVhmrR1ZcTSmt53LoxRa8pMezBYIPHinpbWNsA=;
 b=HGjmlRyCyfjlqe/5hlRJl91+zvRDLjFZI8IgDl8OsWO86rqS0lciNazodzRKH1eog7g3P1JVyAFUpUhTjxjcjDFR9+rsXLOu9grRTtS7kVfNSiX9srTe5ol0oN+r5jyE2ubUiFl6eRSy79dheJROm/5Y7xw0EtsKTwG56qUG1WSDJR/jDFojdvAhnrCxhzjycqyit0bPv7xc5yS018mL8M3DwtDAuYcumFE7A4xiXb2lOUxR5AoFaIeE/XIy4ei6TWWERZrBeTp8dEURlTCXx1I2fOIdnb3B+BcNulIG0XJdsE094zw3oJ5GBfS4V9m6Y9zpDMV1tes4Cc08rLjoeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 22:29:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 22:29:50 +0000
Message-ID: <40f59f08-129e-43fd-a14a-c769588ffd01@siemens.com>
Date: Wed, 24 Jun 2026 00:29:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: No Community Call today
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3479:EE_
X-MS-Office365-Filtering-Correlation-Id: 071a335c-e354-4ab5-a631-08ded176f04a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	lI+elnKWME6d8Jr+3xgskk0jc4U9bq4WztUsMMwtxYqyaHef3D2QW65VNI4FdAlSBiJ53SIy/uDRxqAHSIvz0xdykBCjnAoIBGjrK57wE5FmGC2B2EwnvF1NAdIpwS7fm4EKD6kD+COpINd5newrcMVMR1wxD54Qyp8nzoyRc8aJXOymTsj9gU7oNR0oa7dyktECg14pIIqENdZKqirwKwRE1YNZ4u2QTmKB6VCy+MKwc/++f6bsIOQV9DYVxnot8MVT3MZcA3plGxaA78vtDZlY3hiMW+Tx0R/F5vTUUZQEny2vRHSlqix6mX0pjW6KBao+NLvakHSFTB5APjKRzDsD9MwgkttbP/SSgFm6HBl6Ybt1h/zYBf9hjnWyRUfajz6+BGU/ZKUpXzC6Mf5DuNptn10fLY1hpFmnNO4y1MUUdZzt42YMA+O8vBWyBHrnKHa6zRxGXa7dj1w7HSO9kBNt55l5dO7J9HTQ8nqdPCLRFbjgzk6n9Shk/yHVVd7HP+qnQUf5WnLi1lw2JjcCiS+XJs/EHTmcJVD6+y7ZtwL87K3SYMyb2iZH8BjPu4Dy0I494A8IGlNlzcBKKkGAhp1fkLTausOnOGW/M5SPnhJ/8+WJiVMVzvP4pLjPqsZhmwHLtuOqr+bV4BQGIJuec0t/rKDkRYexdkOJ/finXWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUsvcko5Q0lDQmhIYTRiNVZGTUxVWWhrWDFhc1N6OGdybmc0Y0tKc0JjNG5r?=
 =?utf-8?B?TU9PaUF3clhSM09IYjc4eTVZdURPNHJLT0xvcWV6UjdabnBJRHVFUU5HV1Np?=
 =?utf-8?B?MUZ5d0JXeGxvOE51Nkwyd29xYTFkcXJrOXhheWNWU2xXSkFzTWdBZU9yUWlD?=
 =?utf-8?B?TUJPQWRjTllBc3NBeU5LRGFHQWRJYjkwT0lja1A4aUlBcUtqdHFLalY5Vm8z?=
 =?utf-8?B?Y3VsRS84RnQ1RDZoYUpmTXlPYStQYjdJN2ZKbkF5a1J6TUJoOHgrSDNPNFRE?=
 =?utf-8?B?YzZRUzNqVXNNUzVKQWJTa2U2KytMdGJVU3hKNG10Q3VQQXFhWGZhUXJIbVZO?=
 =?utf-8?B?bno1STMydkhIWHJabXVCeW5waGh5bU8zWXZPTFhVeVVNNmtLcnpFUE9XUTdR?=
 =?utf-8?B?RGthd0FaRVlMM1hpZ0ZlLy9TeFZTa2x2a3hvZzhWYUhuUUd4aE8xbUswVzda?=
 =?utf-8?B?TFFid2lkMFVvQzl4WjN4TGMrRjNHWXQxWVVwNGxiWTJYM1FoaUg1TVBlV1Zr?=
 =?utf-8?B?cDUwQmFNVUZ2TlFoYU1NUXIraHl2cnZmeUJuUDM2aksvMldNYnlCaDJRQzlH?=
 =?utf-8?B?RUY5M1lDWndLUEpxMUJVbERZK0xPTVBMWDQ1Y1plckI2d0pMVnFVekZlL1U5?=
 =?utf-8?B?eW5YcSs3VDRrM1ZHWnUrVUZ1aFJWNkYveEVtcDVXRDVaK0pKOHNDSzN6ZUhI?=
 =?utf-8?B?VGJaOHZ5MTdwUjZMeVYzZWl4ZGo0U0hjdmlnbVAxdzFtYnlaV1pwRE5LQXlG?=
 =?utf-8?B?b2thditXdWpMN0FndXNzWjNmalpCQnRBTmVIdUZLSzNDOUQ0QVR6cmV1NVZB?=
 =?utf-8?B?KzdoSXI5aTZJOGswc25GMm9pbGRxWGR1dWpJRXVDb1FOWm94Sm96KzRUKzVS?=
 =?utf-8?B?QlA0MzFkYVRGRWNaNjlxd2QxdTVmb0VFUWZCa3hoQnYxTFIzY0RLNnRzdk1Q?=
 =?utf-8?B?Tm83bXIwNkNETmZIeVBoRnl6eXZEWE9hREtlN3RYUWc5dDB0NmN5T3ZWL0hy?=
 =?utf-8?B?cSs3Z1J0U1IzeWdVQkIwTG54N0NVNlFWYnFDSSs0R1Fvb0YrMGVLTVB5OC8w?=
 =?utf-8?B?NmlnNjdPMFdXWG5uTm04NStFSUlmazdjMElSeTZYUHVLSi9oSUpMSUdGcWpE?=
 =?utf-8?B?eVV1cWdrZ2kwRzdUb2x4b1dTSWZRQUFud0lRUTdWQWVlR3hTd0xXUGVQbEEx?=
 =?utf-8?B?ZzE3VGV6NE9FM1NuSGh3UGdWZWRNOGdCTVRpNjVnZE1RMUFWRjRMcWFadWZl?=
 =?utf-8?B?SWZzekkzdXNLQkNyS1R5a2UrY2lRZFpZNU01L1RLeEhuQVBsaUtpQW9jOWhE?=
 =?utf-8?B?bVZ4ME1OekhNNTN3Rlk4OWdUWGxBUlBCN2pOb3lJZ0gzM1JjVlQzRXFCVHlQ?=
 =?utf-8?B?ZGovOGpCWlVQdmgxYUU4ZFVwRFlyaTBhYmJBcytOVG1naHNCRkRnY1hoRGZl?=
 =?utf-8?B?SVplTngyWjh0U05PMWtoQVRYa04zMFk1RWpSbjljZDlzMmFzTWpXdzRHRzQ2?=
 =?utf-8?B?SDBNY2prRG1UZElaNVgrcmYxWGFzaTJqdXl0U2xwbVVMc0ZVNGFib2I1ZU9W?=
 =?utf-8?B?WUxhWlVnY0M5MTRSZG43dHpWWlpZK1EyaDZDby9PSnlBQXVPNzVaenhEZENL?=
 =?utf-8?B?UEVNWUFYbHRzSVZPWU1EcDJsZ2dPdXoxcFIwYjFkNURSZFFmbnlHTzJTUUxt?=
 =?utf-8?B?YzFqK3JMWnNHZHQvV2VhWXhvWjEvbzNpZG10aDhQQUJjTEMxM0puVWZ1Tmg4?=
 =?utf-8?B?YmpFQ1hjNFgzLysxNzNZSFRzTGF0QzVaQVVYWkJqbmZPMlBHV1N5Visvcnow?=
 =?utf-8?B?VlFCS2N6dGV2ejZYK28vdkZ3Rlc1UllwZUJrYUczQURYU2RaZGRjMU5ZQkxx?=
 =?utf-8?B?elB2UE1nYlBxcE82Ym16WVhsTU1GdThUL3pESHR3cWJJV1dtMXRwcDk0UVZS?=
 =?utf-8?B?MWFwb1VMay9RK3pUbmMzMHhCcDAvWDBQVXJIYm1yUC9OR0Yram5ZSWV5Vlhj?=
 =?utf-8?B?ZmQ4d21OK0hUUHhHcUxMdzdTZ1NyNmI3L056VXZlbWhsOVdNaEtmbmVxNDVD?=
 =?utf-8?B?VXVqS3JiL3pWSlE1OGN2bFJwaHRad01SczBZdU8zTEZEd1pveXdyc3o3cmpT?=
 =?utf-8?B?V2lwY0c3ZFNQYzRJMkIwNkx5cjV2V0g5Vy9EeUdHT01TbURlM3ROSEFGRW1W?=
 =?utf-8?B?NGlkSlB2OTdveHdqZkxVMkNJTUIzT3ZsS3BoN3grTnI5RWp2Vm9EZk9sRUNP?=
 =?utf-8?B?SjUyaWZ0N2tQeHJGWFJTbjVlUEtEc1FoL2Z0OEhBTkppajlLTVF1WUNKczk1?=
 =?utf-8?B?UXVwT0VaTjlFQXhQVTI1b01DbEhON0g1TVZVR3k2ME1ramcrcWxmdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071a335c-e354-4ab5-a631-08ded176f04a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:29:50.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjxBQZYBRiNdf8QNh6QeLCKp2W/aHBePFQc/qZSOp6S3EbiZztv9iFJ+cZnKthkdr0U79O+7cedKsneOU63Nlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3479

Hi all,

sorry, I have a conflict today and won't be able run the call. Hope to
hear you in two weeks again.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

