Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBC4014BB
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649674; cv=fail; b=Fp8yTGAIJVa+F+pbRBoRtb8QjNbzEMQOcOSHihbaPnjBr8MkWbnwcT17R4Pe87PoGh16H82hkorf/Pe8ypLpPHqYR8AacDqNLeUXLwKWDb+Dtb9wvfe8cRQFfO0aEy+AzaIbeXCr4IBVLMFfIlNVt6t94PwhpHJdaDuDf9SQEFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649674; c=relaxed/simple;
	bh=6HFy1KKZbxLTerD3uiWTM+JQcsKm48hqRJDI0PFTlAA=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=kYtzyJOrdAiDXHqn60vcpmgzcPlr7JT7R90mo6UEmDFx2rYbyIaHK6+/xUgKTiXEIFm+YFbLiMJHOAoVf+on3FapUmxAuKkr2v6IpqfAKr9TDVNpOX/fPnkyqe82FkRz1K6oyI8Eo5BAlDIRPOrIOqb9blEvw04Xn4FPkw0EDsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=prXPaQPz; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="prXPaQPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZagOEoZkEfJLdvBt8igqfhHdxvePX1HMfGrsA6eT4/ZERECEbpcbPinP+zG+zf//wMxRqRgHtZUJI3G/UMsXx3jPKJb2iTlT6gKix8KlShLdHEeSgsW6zphaO0L4VD8yUETdyyKsGJGpNbZftCJ3teKoqa9kBjDEzrCP2iOqFfC8MUG4IrM9WROirisVQSCpWfbr5E/emBpQKQpcWACsOfd6EWJwmWiluKrkrxPzIhceRUH8vQVt69l6mD/Cm19daZWAOrvRUY61kU2rhe2R1MZUziWsgVoq4rf/u8YHWozp85IfnSCPjQPSAAnbATL2fCi0Jk/SoiOzR1c0kWMT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HFy1KKZbxLTerD3uiWTM+JQcsKm48hqRJDI0PFTlAA=;
 b=QoAKFsgoqrc/JOtWtAkCv9Bcc+z2ytBgdITykzOn4XpYWysqncqUpYBKexCJdeZqFhYoUbVMLersOuffJrazp6RmjA0eA5lGJyCVhSICgE1rhMMECCPUO9HGMda430bOe3VduPBUkV6JUM/5VPgcOM/8txjFSX/tcZC8u0Hz/BPqsEUDgwnXeUX+eFaB4vvQ0m2MtuSapEUy/SWerMuldN5uDx6R9xDyg7wtASYZbw9gMNOxb8ODcRNTxaysHGqXuzFW+XXXQYkhgpV2wEle+HsF2YJvcdNd6asvg1kPoUEtCQ5ib+JsVj10ocDvyHngo1/H25lhU0LI2lE8hDgZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HFy1KKZbxLTerD3uiWTM+JQcsKm48hqRJDI0PFTlAA=;
 b=prXPaQPzR/MAb7jnWCFst3adZG3Ph8JFPln6KLfURsz+aRS+VEemZ/KCbc9L3xVm33hekRETY73HDcHmJE77jH7PYHsEyu3H6MRKzEmWzNlgS0KTuAXjLqKcKta/xsxJSvhtX8j2ijYFPnPAmyWTdKcmdO5ZQ0q+wXjdMzVQqMynD335uDu/w5+WQy/c4OaNYYpy50kIDXIXG4qC66xq/euQPTVX9rrSE6nxWGr3KztWWm6A1ljD22Ng1ZiZS1I5ilxvp7JwT4zU1j6X9N2otvSrnK20AwjoDm0AN91YZt0S90Bv38EQRu0SSCVFK7nRUqttXxU32AmnEyrdMRVzJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6191.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:385::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 16:01:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 16:01:09 +0000
Message-ID: <11652667-3c20-4879-8033-6a9534be3865@siemens.com>
Date: Tue, 21 Jul 2026 18:01:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, July 22, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: b8339be1-ea24-4a14-fbda-08dee741476d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4133799003|11063799006|10067099003|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DPNR2DW2R3aAfZnGp408nsFhp6tH33y8oADC3ocY0VPJ2d2rXkLKzG9OpNlFn1lI8wb0DcQUxVQaDfyUAl6S6z4yHoC8c8jisDieCqJZnTZItz0Ujhs5IjdSM5o2jNUvJ60RjNDt5u8AWN1qejQY//yi0pJcFKQkSVvb8QhiH8VP/mOFZjJ8r6rvjr9TM0vVJVW/u/WM66Uf4iLlvQmEQbeachqf0EElvb9+XftWOqekADPj8ZtOEwSWp3j7sLnbHHKYeU1gCXo3vv1ZpAwmVgKlRnZpstM/viBjE1KV5pw75Voqa9KWRUkHZ8f12KLJ28gRT7VIqGPpWpwoiC2cn858sPUBos7EidxFSQJedJz3FGpfGsX6NqEzv2zRS1+SEgmQwEt8mO8Np8mK1LQqnv2jCgPLJKjxP8wDABA7w4IXAxqtXNtD0IeWlD+ocloEKMHF/R0pylBYWcCqm7rVK6cxDBR6Fg33gBDBsOKxUCFMr4alDNSw7R8LEATTx1ms6RQedjrv+8FpbYLn4WJ1TV9FkBbNITE7Yzo04B46PcwloEh/d0HemUpk4ZmkQQ3VtiAnArnTjLLanaEsn0BzrpVM2tVpmVK3+m85cxxTkF7RA/t2jN3pJknezvLUbo+/2oqiREe919smMRTCoe5/wtQlkIieQ06KbcrHV0/MiKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4133799003)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NisrdVF3dXFGdFlHTzZvSHl0cFhqMlNrckxrM3ZtOFlVVkd4eW96MEdGd2Nk?=
 =?utf-8?B?Rjhnc2kyN3JQMHAyb2lISEo1TjVQVFd5SFlVZlZsWkkwQUlNb3NLOGFNT2Vy?=
 =?utf-8?B?QS9lUlVuQkNMOEpCMzJISUtITWQzdlp3MWgzcEZ5YWhER2p4bnBVdnU1Z2JC?=
 =?utf-8?B?QkxER0RnVnJxek15bmIxWHhLUUIwMHF2dzdJRHZTN2gzZzl4MWYyRW1Ib1Bi?=
 =?utf-8?B?Sm1SQlc5ZVhTY05rUm5EVW1FeThzNU8wRkJZSkxGUElsSTBsWkIxeE9BcFNn?=
 =?utf-8?B?c0RQb0FLeG9mck9GdjJsNTMrc2Eyc240dDYweXlRZTBvZlZ5VHNyOUgxRHp1?=
 =?utf-8?B?djlYenUySWhIdzhEREJMNFBsbVl6UHJmZnZQYlpJWldaT1l4L0FIaU5YZkt0?=
 =?utf-8?B?NkNmazRVbE8rem9KblA3T2hjazZNdkFkOW02QmdOUVZuUXlCeFdOdzU2c3lO?=
 =?utf-8?B?bXYzTWpTRmptU0hDa2RValJVV3VPZTFFQ3R4dHJLdFRWT0tWWW9adWt3SGNh?=
 =?utf-8?B?Z0JhcVNrd3llOXU5aGFrL0VGU251QTFRR2JkOVhpcUFxN3RQNGVMaVV5VzJQ?=
 =?utf-8?B?bGZWWFhTNk9xMnFXY1VkT05hVGZkMUJtZVF2M09Kb3RpaVJnWkx5T0RLRHVi?=
 =?utf-8?B?a0JIVmZWZmUwOTRHczYvRFpiV2lJNkhaamNuTkgvcTlOTTh0aFhYSUIzSndo?=
 =?utf-8?B?dkJDYTBNcEtrVy9paVdLRmlmY2EyQWQ2QW1Wa0MvcXlKK0ZOWGFETUZ4UW1w?=
 =?utf-8?B?WDM1T0srNUR5VDZ4Z1ZTcU1ad0Y1VCt6UFFmRmwzbnhnS0llLzd0OVlqNDlH?=
 =?utf-8?B?c2o5ZFMreENQenJ1TWkvTFd1bEpJZFJTaU95V3JmeXR4V3kyd3Y0RlZMbDVD?=
 =?utf-8?B?SDBUTWVYU0tCOWt2b1BaVDZvKzBZd3BlZE9Ja0w1YWZESVRrTS9Ic0NRN0Vm?=
 =?utf-8?B?WW5wdDB6TnZtSlZMblBQTG45bHhXdTYwMEtOSmkxS2J1c2lhSFNJTWZzbCt3?=
 =?utf-8?B?SHNGRllGZjBjOWdhUVRnVnhSNGdWVHBqT3RUbTlDNG8wWmZJM2FBY084MUx0?=
 =?utf-8?B?cEtObDR4SHJyNUVlaTUzQzhXQkN3dC82aC9JVmNlR1Q0U0Z1NFRkZXM2WWZU?=
 =?utf-8?B?SkY1c2J6alRJYlVBcmhmMkNhb0puWnhZRUorSlpMQWRNbFhkS2xuM09lWkNt?=
 =?utf-8?B?NzVqODU1bEdGY3JHckc3ZHg2UGQ0MjVlQUhNeW4rTkVLSEdHL3B0VnZOWkls?=
 =?utf-8?B?U0RjRFU0VUJhZE54cThrZ1BJTFhPRkZxcEl0WllDQWJzRHpZc09aVVhLU3hk?=
 =?utf-8?B?UGl1ZlpLcEFSTHBpRnB3M3dWMEVBMjF6Mm1vQmZNbGZtcmxLaWE2OFNkOE5R?=
 =?utf-8?B?c21ya09PZ1lOYmlNQ2xWNXZ5WUpHUE9UWkJXWHF0cUFuWS9NUUxpYk50SE1n?=
 =?utf-8?B?bTNLRlluY1JJZFU5TUlBSXBkMzM5OFRYb3R1YmdqZUhYN3h3V2xtc1RJUE9Q?=
 =?utf-8?B?OUh3dVRHdCs0NVNuUGpjS3Q1ajRzRmQzaXczVmFJK29ua1V2NStZbFpzYTRD?=
 =?utf-8?B?YVUwc0E4OVZaaGZWcG83dU1nWG1ldU5GR2duRlZtQm9tWDNMOEd3N1ZPSnQx?=
 =?utf-8?B?SE5EVVBYVm0zMTVUeWZwN2hVdWZxbFFaWVBLYzhmRitqUjZKY0Z3Yi9NaGlP?=
 =?utf-8?B?Yi9TcU04NDlTR005M05WV09xWEo2VWh5b3gyeHJ6Nm1WdmZpY0JZZjVtWFl4?=
 =?utf-8?B?NnprTTFiU29MS0RGc2NXWUxNbFU1NjQzRmpZTjRMVVdhWWJvN3BkVFY5UmFS?=
 =?utf-8?B?MUxaSmMyMzc2cFJvbE1nK0JkY0ExM0VPblRkdW9NRTZvTGp4eVlOQjZYczNk?=
 =?utf-8?B?MVczcVc3QkVZcmdWbzF6SEJWUE55WWFnZ01xQy9Zc2RyNjZ1R3E1U2k5cWVq?=
 =?utf-8?B?MXp5MjM0ajRNMnNqSC9xaFNkU3NLY21VUEtBYWdZdy9zNnJJK1c3aVQ2Qlcx?=
 =?utf-8?B?b0s4MVcxTW1XdVRXSTBPYWI2MVhaTGFHWklHakNZM2s0Q2RwOHZ5cUdQUC9F?=
 =?utf-8?B?REwzRDM2VjZlV2JYTmR4YVQvR2MwMms4em56azFLbkx5NnVOUzNyZDVJNnpj?=
 =?utf-8?B?dUs4Qzl4QmlyTVhrMEIydFdGODNpc00zNGVJZXNSR2FZa0dLYUFWWWJ3M1Ay?=
 =?utf-8?B?QThvREZPbWM3dEVhTXlWNTRvbms4ODBRcCtqR1pQc2lXU0FpdDUyZ2hwQzdM?=
 =?utf-8?B?TUVBTUY4TEppREJiczM4Wk95YlNqM3FtNUp5Z1Zsc0xTcmFtNEN3RGVubjFD?=
 =?utf-8?B?MnVLRTVYOTVjcmJBSWsvdEdITWZSQVg3VDBvMjdTRHZlMkhrcktTUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8339be1-ea24-4a14-fbda-08dee741476d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:01:09.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+/gTSBL2J+5BZW8Q3aEobuMEZdvTqMkFVNwKnkUTZhYiZuegnuIb5XlWCxQzsUitP5vUGYoJjIsdy6Ai6Lolw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6191

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, July 22, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
