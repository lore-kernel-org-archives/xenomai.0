Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EC3BF314
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863544; cv=fail; b=WI/n8yDpeergCtgGKf722cVq5L+t1kNRy7cO2yB10UVAABkYfiBo1vNy3XDBsc4I/oNBpefYi4y/18zRHg5uar6WPRqpRWECxfjB9sBokofcMZU98VFMzriabVBiRONi9X3zIGbdIx2vGTlcj7nLomrElXoFUaXtkc+W4F/9xDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863544; c=relaxed/simple;
	bh=Fj18u7ehZIcorgbPuTjS172mDMiEePghp2uUZv92tZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsmEwzMp2FrGqpleGGGRvynbRVxRtqPklDPqoEfQCp3AfLs04X+VydIWHO3GSjAnMzDXZB/00II1kGT3XGtMKaBG1lmEjoGEJ/qNJEVVaDUdSOfCV0Jb1YYARyiRaQaN3pS6XP7bM8vEL0hXirW6+C+VmihJBS6N4BdWvQ2uDB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=siemens.com; spf=fail smtp.mailfrom=siemens.com; dkim=fail (0-bit key) header.d=siemens.com header.i=@siemens.com header.b=QGeuCGo6 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=siemens.com header.i=@siemens.com header.b="QGeuCGo6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgbPcsMbs5k09/+ushYypir0IM8B8kR9yhh01mNxNDuSHyKqCSZadjW6o7spv7gid2GmsHb2GEBaQszhUGk6Mm/ivpwhHgC+zfC6WRfbnbVlOTbkYZ8x7AVJaWYgvaikq7vDAfJz5lV7kDZ+B46tHXZWBNsqoKhhApLoIc5jNg2GY5G+6YxWG+GdHsnIIqGlIX3egQE+i4DJBYEltPPQzxDWE7ve286I8msA6NZdI0msyT86x9xoV1kgQB5ZgwHinHARVECdBdrogeLL5jR71nsz8Ktq8aJ4rsKoPjn0xsoKWbk+epMp5n/d8OjmjHMjtEvF0c+p+32fkEdSRajkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdZclSO4pgR72JtuUjmG30ixv6bYce2xTrgr6A9ykj8=;
 b=E8nIik6Pd5DWo7rT5E+PozpYqm2UaNrAHsDOpITAHxQmR8vUiEV73vIcwERI29MqkPd19OeENFOkT5feOGlYOL1nKp+fAt8RYaYI+FEmn6Yds2ZgU/3y68JsBLXJXvE8lWa8TFMooOFiJOYKwVHKKjsmQ8c1BzlIyVc/fKVhZLYilGV7vpitJW3z3aRriKKl9/L9DrBfA3aksH9hSa3KeNNur2bEB1Edk3LoSZrlCqR8uRAlbodHhcc3t6NbenSAaS3QH8pPVW73AHnZ1Wigbv0x4QozWsT89wWItczFd70N8PeRLTQrVOF3kGxbuAhoWSIlsIknmaV1FYLO9hglCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdZclSO4pgR72JtuUjmG30ixv6bYce2xTrgr6A9ykj8=;
 b=QGeuCGo6zQds9wy6MvAlEAGGaTn+oFNW2iJ7Q1NK7VzeesTDjEwaQKOzkkZtcFN/vrAwv8j3rqL+0My54P+mlsymWIMNXQjKABM9Pmo8BPPses2USJ8Z/yB9gBI6XdIPzxeRkfQ8BIpEX7H4sn5XhqX1XFvFbBrnVEg5F+ZX3gSlsFR7GtJcjVTtjxex8FasAU5A/vMZ/NU83AbLFkX/j/h+kkBq45xGGEKrfJ9YAYu3oK3hIxWwoP2iKQu1leuavLufjYsW1q/b6PVsz/5AOfIrNFqRYfh7q65DZPWMkcMsb3TWD68M12ItF2YJhZvqPguyKKR8BjAhK3ryyvc3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Thu, 8 Jan
 2026 09:12:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 09:12:13 +0000
Message-ID: <83d6b279-583e-4ba1-b5b0-53c230282db4@siemens.com>
Date: Thu, 8 Jan 2026 10:12:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: the kernel hang with kernel 6.12
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?6YOt5Y+M5ou0?=
 <guoshuangshuan@sinsegye.com.cn>, =?UTF-8?B?6YOt5L+K?=
 <guojun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.90c6520a.23af.43fe.9b63.9c6842941db7@feishu.cn>
 <9e679d7b-c247-489d-8351-5e5976ae40b1@web.de>
 <5f8f678655906dd33eb2b98b20d136822d4811c5.camel@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.a75ab7e6.df2d.4080.ba93.65d4609060cf@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.a75ab7e6.df2d.4080.ba93.65d4609060cf@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8398e825-2be0-420d-5294-08de4e96029a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnVUeFRUS3V4WGRDL0taNXo1bGNjUFNGb3R0dXVzUGlvQ0JOWUNPZkNncEZz?=
 =?utf-8?B?UThld3dIS3Z1RkxINjBVZWxqaXZ2QzVZcGkrMGtWRFpuZ21leFV6VUlod2Zk?=
 =?utf-8?B?VTFMdVZPdHJheU5NWjlyaFRsS1djazl2MnFGTTJGdXZBMkMxNXFqRGIyT0ht?=
 =?utf-8?B?S1BLREIyT0lzc2o3SWdja0FjeDNwd2FpREt4OUVkWHpOSlkyWkFuTXpLZ29r?=
 =?utf-8?B?SXI0S3JteHVFSjl6YzhZUDc4K0o0eXRTSjcwY0p0MkVhdWRUckREbDZuRHdm?=
 =?utf-8?B?bEhWVXFkajlGdDUwUFZZeXZnZ2h1NGIxRGk4ZjFtLzFyRVhzWlFLK01jYlh2?=
 =?utf-8?B?a3RCaVdBMFU4VW10aW1FSFlQMXl0K1E5Q3M4S3VqYTV0UUFodFB1ekkyai9v?=
 =?utf-8?B?eERCZG1GbWJaTjQ4ekFBK1VJTFkzcGpsemg4RzVjV04vSGZIb29Oa2R6QVl4?=
 =?utf-8?B?UEhwRTdlN1lQMm5vbEJ0ejVXUmlmekwzY2VocmhZV0xqeWR3cE1iQnlLZGxR?=
 =?utf-8?B?dGg0WGt0Qy9JOXEyWTBaaHNTK0Q2ZEJMbTIzUUMweHBNamxkK1E1TGNlTzFF?=
 =?utf-8?B?MWlXNDBLTHNwTFM0Ty9McjlDbGNRQ0VEWGJkdEsvTForeU9zUnlzMEpldk5I?=
 =?utf-8?B?TDZLdVk1cDJjVEE5YkdEd2FyVExycHdGTnlkcGxiRkhpYkRHdjF1Mml5eTk0?=
 =?utf-8?B?U1N1RVRKTzFKNjBBTkZtSGlsdjJoYlgvNmdNdlR2TzlJZklyYVZGMVdJK1Jh?=
 =?utf-8?B?amJWOHRHNm1hbnhGbVZlR3ByZExEcks3NHkyeVl6NTFFUXlXUmFtQXBsWFR1?=
 =?utf-8?B?eEFzK05neXZXR1k5b093a0Z3QU5ZQmhmeXUwRytaNmMzbS95bkt0d05lYzlN?=
 =?utf-8?B?d2FteDVYbWVvK2RZeHhQaHM0RjU3aTdZYUtidTZZeWFNRVVUc1FwbzZ1Wkk1?=
 =?utf-8?B?TUVid0JLMVgwbG1qcE5tNXAweFdrVU1Hd2lYcnAzUDB1bUtMaVVkdXFsZURv?=
 =?utf-8?B?N28yTHMzVzlTcWNVL1dEWjNORHp5YU5rRm1QOGZ4eGhUUnJlUzVGRTlEWEcy?=
 =?utf-8?B?VjBmMm9odjAwdGtOZCthOWJoV2psNWxBR2k0MkVRbFpKdnp6ckZtUlZlcTJN?=
 =?utf-8?B?bjAweXlkcVdoVm5uL2pLQkQ4c3NKOTJvT2ttNlgrTnlqVGx6RzlpR3hhT0I2?=
 =?utf-8?B?L09KWThiVHlZcTUzdkd0U1ZLalI3QjZtdjNpaFQxTDFXVWh4bEo0STBveGlm?=
 =?utf-8?B?anF6cml5enh1OVQ2eHdmQTRkZ0xpK1dzTkh6YU9YbnRKblFqczQxMTc2Z2kz?=
 =?utf-8?B?dTdQSy9XUENaR0c0L3ZuYlI3aGN1VkFIb3dTcjR2SEoybzQvSURRMjl0bVRR?=
 =?utf-8?B?MTMrbkNoaFlJWWdHK3M3SXhEemc2SnBmdHdRNlRVajYrSmhZWFhsclZ5S3FT?=
 =?utf-8?B?VnNRdnEyM0sxQXdLUGN5RXZjN2JsY0JDRkFSb2w2OG9yVG5laG5jWXpXdDFS?=
 =?utf-8?B?cm0vOEc1T1JPSVVpRXJtTnVjd0tVQ0dteWpPc1RDbUtBOUVLWDdMeTV1Lzgr?=
 =?utf-8?B?MnMwTlErRWZzbjFUQXhmbFNLaHk1cU1GZmxqZVhiMmVDUUhKRlV6U3gyQ2NX?=
 =?utf-8?B?NDdZMWRqYWFIL3lvamVkTGZRSjBLTjMxdmY4ZXNDZnRPNC9OTElvTi9WVjdk?=
 =?utf-8?B?SGNHQldqTUFUNGFCRkdjR2FwYTYxcExaMFYwYkdEbVczRWJBTm5lYjVrQUxo?=
 =?utf-8?B?bzN3b0RKUFpydjlkZi9ZN0p2YUhGNm42eGFhOVliR1ladDRrVHJ3WDJvVzZN?=
 =?utf-8?B?bHVSZHcwY0x3NUpvdEtvNVNzQ1BSWEsrZmsvanJqSUIxYUhhVkNKMTdJdlVQ?=
 =?utf-8?B?eThLSm9wNW5BNCtvNVp3ZGh1U0grK3MrTkR4RzlxOTRZcGx4SEx1cU9uTnBQ?=
 =?utf-8?B?OXlmYlEwUXFxR1dEMlV5NEZ4OE85Y3hHWGlJb2d0aURHVTFDL0NMVk9GVHpJ?=
 =?utf-8?B?Y3Z4N3U5akdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1mS0pHQ3RxYzBUdWpTTGZ0b0dQelVCRUVlRk1VVkdzUStJMVNmVXdwRnpq?=
 =?utf-8?B?ZnZuOVFKMEttQ0p6MHI0YkpDdEJNUWtuRTJvRkFtR25PejlKUXRqK3BuaTJu?=
 =?utf-8?B?NExHZkQ1Q25TZ0VaQUdxWFhsc2g4Zi9SOXpBU1EwTjF3QzdTUkFIcE90THR4?=
 =?utf-8?B?QzBIR2o0UDRmTWpUVmpLQUxoYmhWaElVTjhXUnpvVmlwRGs1Z3NsemwxVXhZ?=
 =?utf-8?B?aGNwTFI1UEtaQVBwTnRmcEdoQTVhSGlQSk5vakc5M1lVZ1o1bXR1dXkwNWhk?=
 =?utf-8?B?eHVvbDB0c1oxZ2Zpamswc29DZnNGNFg5OXp5dG1udkg1ZjFxa2Ezcm5uaHo3?=
 =?utf-8?B?VVFsRjZMSWh1TTBKL1FkeDlUeUxxWmhsWDhHc2g1OU5heEk2c2lRMWdwdWtL?=
 =?utf-8?B?UndNdFRHS05XZi9UalpSbzc3RjV5emI4dVJIRUxLQjA5YkhtbjdqWGlsVmgx?=
 =?utf-8?B?M3RFWjljd0hMWEVGZkZGYnhLcGM5eU9lU2UwZlo3Rjhnd3oycGZ0eFl5dVRO?=
 =?utf-8?B?OUZMeXFtdzA1Z2dOcytqNmoyNlpTaHRVWFZMZG9mQUhWenFNZnlZazByNlpu?=
 =?utf-8?B?RWlPTExqMzhpM1MyQXN2bXJDT055WXZna050ekdHVS83K01QelF3b2tJTEdW?=
 =?utf-8?B?MnVkMW9ra0gvTFgrUE1pUnFTbDlnRUlDUEM2NHhBVnlOZ3NoZ1FzQ0JEdTAy?=
 =?utf-8?B?Vlk2ODY5MWt2UGt0RFNXdE1wc0hWSTFUK2dwcm14RndDK1ZUdFhwZ1hoMzBu?=
 =?utf-8?B?N2dHbUI2ei94WERrV012ZGM5UWcyQ3VLZkJSSDhnaEJ6VlplSHlsUDcvZHRW?=
 =?utf-8?B?cERoSk5kRlNoMmE0RWxFeFRxaGlORUJPYTBYSlJzeURZcnU2ZVhZMCttdnVy?=
 =?utf-8?B?SHJHdWtEVGcraUZhbk9VZm1IRE5wNkZtUjVBTm9qUEJyS0pBOEdJdGJWSkx5?=
 =?utf-8?B?YkdnU0VjbWRlSngxVVBRakc3VjBka1dyRXFpNDVxbC8yVnNmZnFpNG9oNko0?=
 =?utf-8?B?MTI5NFE3RFRWeUcvM1lEMmVPQ3FqbzdnSzNUYzRyRW1UZmt0VjFmd2ZUYUFy?=
 =?utf-8?B?ZUozcUtISzAxajhhZ2ZkQU1wYllFV2lVRjlBUmhJaitrNkozTHR4NXFOWVZF?=
 =?utf-8?B?bGdXMXRLa1Q5SnlKTDBlYTViNjNWRDJhZWltUXFKWTkvRXBXZHJGNHc2aW5G?=
 =?utf-8?B?a3NQSEJVaERTSHB3MzgwcDZtQVBhVURERm1Ga0I5U25mRUxRVE5mVDVHL2Iz?=
 =?utf-8?B?ME4xMGRydzNLV3B0VUVRQUNoTmc0ekx6U1haNWlHZm9YMW1DZkdML0ZtcHor?=
 =?utf-8?B?YmZIcEZDUlRCNjN6S0ViRzFqcmw2dTFNb05PRjZoQzRrcXpiRU9VNXBCbG9K?=
 =?utf-8?B?VVEwbGp0MXhNZGp4YzNzdllMajFERVY2eXQyS1F0MklDUjNVRkp2VzgyYzd4?=
 =?utf-8?B?T1Z2MXFzY1JiWXBTTWo0YXFXRlQvcVd1RUhEUCt5blJQNGJUQkxaRzZPTmJj?=
 =?utf-8?B?enhUcFpRN0wydHJmWGNOd3hWK2krZVhHUGI4bDN5d2NsWldCMjZtMGVNMGdj?=
 =?utf-8?B?VGJoU20yU096SGt2WVVocHZPWjR0WmpHbmhPSkNaTmhRNnA0WkJwL1JpMzlP?=
 =?utf-8?B?MVNwN0VZZkJXV0FPSGtVa1VCazM5NWU5aDlCU2Z2WDRYWldocWl4T3ArWFZw?=
 =?utf-8?B?RWREODY0R1dWQlYxL3JoaEJ2OVdwK2d5aGtHczNiSzh4VGhlb1pLSVcva2pP?=
 =?utf-8?B?Tml1UEltWGpSeDhpUUxIbWVKMEN2Wm96YnNmTVczeDFZdEthT1JObkdZMGFn?=
 =?utf-8?B?dURwMytSVlpieTFxaDBONE51NmZqRHZsU2syTk5mSkZ4dDZSa25lbU5JbW0y?=
 =?utf-8?B?ZElxUW4wVzZQL2lzaUNMUzd2V0V1MVpGRkVmWExaNVJNQVRRNzlwaHZncVJM?=
 =?utf-8?B?WXdDakgwemxJRTFNanpiUlh6Ym5Kb2NuRVN3a0V4S2FpdWlGaHBUWnMyRE5D?=
 =?utf-8?B?bXhRdm1HNU05Z0pjNVpMYmYraTlsVERuZVVXd0hYR3Q2RlVNQXBiT0pweGFu?=
 =?utf-8?B?VDlhbzJRNEExRHZZSUwwREYrRHB3NGY4TzJScHZGcXNScW9iRGF4OGQ3VnVk?=
 =?utf-8?B?OXVTT2ZNL2dLK0w4LzFxZEdlOEZRK0lFTlZ5Z3gyZXdLNWYyckF5emczSUJ6?=
 =?utf-8?B?UUtCZFV3cXlnT09Wc0w5aFV1K2YzWFdzZmVRR1F2cW9uSFVrdkZ1SjZpN1pu?=
 =?utf-8?B?bkFQRzkvZDNmYTNFb0Q2V3lDN0dxTFFsZmYzTldpM2lsV3hSWXRaYkFHU0VR?=
 =?utf-8?B?WlN6d2FpRUx6R1k3MmQ5WmxmVVFPSi9DeUkxOWxwWGxMUC9YYzRZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8398e825-2be0-420d-5294-08de4e96029a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:12:13.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jq06U9pugiqNlkTetS6QktUSDMpNQA8vOq+fPuIvxWnIP7zXoXHsrhpmpUu4OY9KduCqsfmQ6n1aUaJSOatEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152

On 08.01.26 09:42, åæ¨ wrote:
> Hi xenomai:
>     You can use either Ubuntu 22.04 or Ubuntu 24.04, and then replace the kernel with one that has Xenomai 

No need for Ubuntu, we have Debian-based test images already
(xenomai-images).

But the key issue with testing SVM is having hardware in a lab connected
to lava.xenomai.org that supports this. Theoretically, we could use the
emulated SVM via qemu TCG. However, when it comes to irqs, races or
latest SVM features, real HW is much better.

Jan

> patched in. I think that your point is correct. I will use local_irq_{enable,disable}_full() to conduct testing and verification.
> THanks,
> liuyang
>> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
>> Date:  Thu, Jan 8, 2026, 16:33
>> Subject:  Re: the kernel hang with kernel 6.12
>> To: "Jan Kiszka"<jan.kiszka@web.de>, "刘杨"<liuyang@sinsegye.com.cn>
>> Cc: "xenomai"<xenomai@lists.linux.dev>, "宋健玮"<songjianwei@sinsegye.com.cn>, "郭双拴"<guoshuangshuan@sinsegye.com.cn>, "郭俊"<guojun@sinsegye.com.cn>
>> On Mon, 2025-12-29 at 10:04 +0100, Jan Kiszka wrote:
> 
>>> On 29.12.25 07:53, 刘杨 wrote:
> 
>>>> Hi xenomai:
> 
>>>>     After testing, the kernel hang problem disappeared after applying the following patch. Is this modification safe/correct, or are there any potential issues with it?
> 
>>>>  
> 
>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> 
>>>> index c48a466db0c3..c5e0456b63e6 100644
> 
>>>> --- a/arch/x86/kvm/svm/svm.c
> 
>>>> +++ b/arch/x86/kvm/svm/svm.c
> 
>>>> @@ -4280,7 +4280,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
> 
>>>>          * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
> 
>>>>          * this path, so IRQs aren't actually unmasked while running host code.
> 
>>>>          */
> 
>>>> -       raw_local_irq_enable();
> 
>>>> +       hard_local_irq_enable();
> 
>>>>  
> 
>>>>         amd_clear_divider();
> 
>>>>  
> 
>>>> @@ -4290,7 +4290,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
> 
>>>>         else
> 
>>>>                 __svm_vcpu_run(svm, spec_ctrl_intercepted);
> 
>>>>  
> 
>>>> -       raw_local_irq_disable();
> 
>>>> +       hard_local_irq_disable();
> 
>>>>  
> 
>>>>         guest_state_exit_irqoff();
> 
>>>>  }
> 
>>>>  
> 
>>>  
> 
>>> Sound reasonable. But given that we have zero patches via dovetail on
> 
>>> top of arch/x86/kvm/svm/ so far, the entry/exit paths need a second
> 
>>> careful review. Studying what we do for vmx and comparing it to svm
> 
>>> would be a starting point.
> 
>>  
>> hard_local_irq_*() will deal with the hardware IRQ mask only. Depending
> 
>> on the expected result that might not be enough as the virtual inband
> 
>> IRQs might still be masked.
> 
>>  
>> IOW: hard_local_irq_enable() will allow hard IRQs to be handled. Such
> 
>> events will be logged into the IRQ log. If the events are then served
> 
>> (means handled by Linux) depends on the virtual IRQ mask. In case both
> 
>> irq masks have to be touched: See local_irq_{enable,disable}_full().
> 
>>  
>> Can't say yet what is the right thing to do here. Needs a careful review
> 
>> of the call graph / context.
> 
>>  
>>>  
> 
>>> And, again, we need CI testing for this. I've just created
> 
>>> https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55.
> 
>>  
>> Agree, we should really try to increase the test coverage here. It would
> 
>> be highly appreciated if someone could provide an AMD based system. Not
> 
>> sure if we have any AMD machine in our lab...
> 
>>  
>> Florian
>>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
