Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E33A1D14
	for <xenomai@lists.linux.dev>; Tue, 18 Aug 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071560; cv=fail; b=FqfUcqk2r3z1PPYyaO21GwqokynifPtentnxKQtwf/b5oP8KfjlX4cS/gpJubNJHNJFK/EGZ6KgHO0g5uqfa/EPqiYGqnbZjYMyK0rkTW1CcM4H6+reI6bTWYZuzof3TcaS+V2eWpOYnix3oo65/nH+5W6Rc0BgkYqjz6MdDsFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071560; c=relaxed/simple;
	bh=77wlM0vG+ylC0ZlVKXaSuWFzzdWPIDe0oFQSsrEM8yo=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=BtCQvMhhv2R7ei2le04z02Nbry6hpV60q0ybu6NawsiK9eZbBQ8Gel8cLKuSjbEO3F+1cX8SihxZMDSrv1d0BQQPndQiZKoRmJyw0rlA6k3gbB+WJLCMLtVlI1orxBYutd0mYdhCoPyhhQsm4Yyy9NGQA5nYUOM+v1WxwAHSauo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iOvED1zl; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iOvED1zl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e08r25K8qN2iOLqzMcmQu1/WDHpKPcPQ9T5j4F/x4dOa41kmJzRCRjneKXHX87YlVnIuU31DJUTy1S2Kv977seuCHbKYNZ2Uxme/HVMlUVJW0+Y0KhpX+7CoHVuZjwmlVEqcWUFzMqeQ4vKSNeD1it97alGFjh9nUjtM/Obgffc1JvyD4cC6OfMYG6EzHCgZoy/EHvz02mrU6OdheVvjZrKBNTjlO4doA4viXQjSTbupY/MjpIYCEJakqMsgukXv6useIJ742gVE85NsDI2g329Vp6RMoCcoEjE1mn/esLOMt1rcFHiBjRovCcCnQD/9eFHrplkItxpShP0mAUzKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77wlM0vG+ylC0ZlVKXaSuWFzzdWPIDe0oFQSsrEM8yo=;
 b=L+eB0tcKNyTZdrPfI2h07536dmCfXxi2oF24WfqBhJhBY5d2iIpH0Ihp+RXEyKSjaHnrbkR3cuFfh388HQ8MBuTE2G5W0WisSzF4G6CF0taqcf/uZcKzU3XZ1HEzVf0rLxMO8pqZxeYgqXLsJT0tYNvz3gaMqwP37vbGmrFwrEtW0nyzaDySVMtOHs4TfX8FjhP8PPuaR8cTRzadwjTiwP0H70NrCBaCtlpLZimPpFF+ZRxIxoWq33zciAU946j+jpHTAa29yF8StdQ/iSTv7s01Vz9v61V3TY5L/bjkwPe93bg7yRhvgL+kdPYt0tENv1MTJU8bWbeqL5dulia5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77wlM0vG+ylC0ZlVKXaSuWFzzdWPIDe0oFQSsrEM8yo=;
 b=iOvED1zlJoqMgD4yi13hH7C5QOVWFOT3pPsoU4frYEjdlgYyvNAiVU5I3M3nJkn9KfOD2ECUjRxjgWsDnkiJaWuV9DgRz8JZhr6kx+0qaJdbr9R+SYt05Rv/OcWpEG9YsrX9TN6iTLitw3yx5it7NtgRMVTbN3nByt2z5NrfuLpAyGfXCYhunIYBa/dJOP1wX/rj0iuoAll6jPPjDRmKm0JZ1FXRBzoDJIGFkh4ls9QtFyi8mnjT3HJqpeF26xinYsyMo0XOJD0bOU5pmxJznU/7J0pUJ6veMCriW+5gvo6W0aUtgFDRNdvJKbjQqKp6RGrKx23Wcp+xyFRxNyDucg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:45:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:45:55 +0000
Message-ID: <f8125427-7694-448e-814d-7b3365dca09d@siemens.com>
Date: Tue, 18 Aug 2026 18:45:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, August 19, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:4e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c98b63-4180-4b93-878a-08defd482be5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|4133799003|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qNXpxSiMMDFib6Pb4Ton83AQ1FSq6H0Vq835D6Iwu3oyk8FDrMJPPCk/jbKxt30TFJBS3v3wT1FlpvS+UpkmgktEy7sRRidxqQuinkCsCltiBWr05+UP9jPeRwCKrMOC+JJQ3lKcC+Kp03tbfjuKDVYrMFsDZ7BPhyxvybJQxsy7WVt/C3NzrbdNB/6M92Ab+6NrVAvKfNrjsrSgm658QByQax1o2Eo5FDWpwk4BLEbBfZdKe5FwcKm2zaHmqtZqPq9dDwEWV2EdlBtMyCWu5TDH5lVtWByzryo6OI6LMPpnzoUSHpxO5wK1SIBpCU8tkqGbtTP43/48Ga5E32kxKQqAcoa7JwKt2fSakb5P3AszihMLWryrOclzoUjcEsQ/6AITifYv40HowVjdnxDBVim0bX0RuaKHq3ImniQSoHpFAJQVUdZGHrd+jNuCc0WqyTQk9ebXZeP19UcD4Y1ENvzMRWpUUTJbzirLRXRBuVMToLhPtfS1wOrjS2AFeoARHcyByHORegmmTPCV3aUA0ZBvbA0rUQWwtWtGejVXZWQpAbH2VjxTndtON3v+BgVzlCKnw0vBXocr2momcg3/BdYCwRIKrmKLeaDmxfqqlEgu7uzzxjql8XmimtW8K+MJVHQmqI4hJ2VpoQicfxz5lSDwP4uOP3Gjq3GP6FlQm1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(4133799003)(18002099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENJZVpxaUNlK1pycFNaZGFERE02aXc1Q0pZTTNtUnR3S2k4YWkxaUJvREhT?=
 =?utf-8?B?Uk56T2xSSDBZUTBjWW1iVFh6YU1IQkpnUk9NaFB6N3hyLzFMWStqMnJqRWd3?=
 =?utf-8?B?UnZUWFkzRFJBTmNXT2dwSTFvTzFwOXpQZy9SM0p5REpzN3N2U2dvRXNDWW1O?=
 =?utf-8?B?MFhoaUVNV2g3NTZ4Y3U5QlVhQ0U5OHB6UVhKck9PaTZPK2FBQVIwL2pyOWhT?=
 =?utf-8?B?YU9saTNBTnBwQm1jTDVsVHhLMlQzTEJyOHVvRDNGSFZQaXo2bnpHRDFocmw5?=
 =?utf-8?B?cExyeW1wUldjLzJrQXdmbE5BN0U0dml5VVhoUFRBbVlrbENhMnB1VXdQS1la?=
 =?utf-8?B?SVYzeVJjK3lLYzhhWHpSZnR6RlZOeGdabVRZSERSaHFVWlZjQnhyaEZieHBX?=
 =?utf-8?B?bzRMUXpHdDhlSTJkbmhBS3FUalBDZ1ozMHlMQ2c5emhlQng2N0dXK2k4R0NX?=
 =?utf-8?B?WW1mVnIvRHU5THBYcHdQL05UdVA5TnZnZDg4SlIxcXZxOFZrbXF1aE1YWldW?=
 =?utf-8?B?b3VKU3llWUY4OS9QTFQvT2xtSzh6UUxmSHNvcGc1eWl6Z2JHRGhHZmFWWEhB?=
 =?utf-8?B?Vml3bnVCZGVwK1VveGl3WGhzbjVrZktseGtpS1A5TUZZanZNSm1mZlFLWlJq?=
 =?utf-8?B?TzNDQ1F1dHFpVFFqb2c0T3Y4QXVhbUJsQkg4dUlHdmFacFc4d3lPblMxL0tn?=
 =?utf-8?B?UmFNeXJqdEdPVWh1NFdGZGFEL0FaL2hRWnJkV01oWlZyUVhyVnVkYXJYdnd0?=
 =?utf-8?B?MUd2UTNRVnVlYm5oc2F0UHZ0Z1Y5L3JIelg1MkhPSTlqbFY5dElNT0c2amNW?=
 =?utf-8?B?dXJTVzMxakl4TzFsU0xnKzhaY2VVWUZlM3Q0TzRwZkczVUJtSUlYNHo2S01h?=
 =?utf-8?B?ZW92dklaV0VtY1lOaDVZN0xpNS9qZnlLMjFVbXhBSk5LVERwbE5uSWl0YU1x?=
 =?utf-8?B?S3FNM2tJcGZLcG5yRG5JWGh0bzFhOHQ2R3czMWRocVFQOTFIZlhaV3VsWVg4?=
 =?utf-8?B?Y3UrcTVRUjBlU21LaS9oNTJFTWdIOTdzcHl1NzFHS2NKK2hOWWdyb0dCOXh0?=
 =?utf-8?B?NXhZUkxxVlgyUGFJMFYza1Q2b1YvU0ZEa0ZOZll2Tis1V3BPbHJsR0ZaeEVM?=
 =?utf-8?B?Q3F4NnA3R0dHK0RVWkswWmE3cC92WEFOQ1Vvc0JIRkJ3MThlOU1uNUh5bStC?=
 =?utf-8?B?bTBQUEM1YmVnVmVDQVFDY1RiZkx2eWdyUnV6bDA3b0pJdWxkcU5HK1krYkln?=
 =?utf-8?B?a1Y3N2NBNm1kc3RhKzBzZEpabzlNOEFhMlljNUVGMXlHYlA4ZnUrNU9xZ3Jv?=
 =?utf-8?B?OWhWb2NXeGZzTlBheC9idGlLUUtRblZZTkJacnZJNE9nRXJIT2FFajBTem9T?=
 =?utf-8?B?UDlMTnF5Z0xTdWlrUHFwMWIzNjZjWXdUM2ZGWEphQ1FQVEpnVWJZTFkxSFFH?=
 =?utf-8?B?dThmRE1EdXFlNTBLenZtQnI0UkQ1elQxdnJOYjdBNGVTQ25EejdNcjdLbDBK?=
 =?utf-8?B?a1J3dXRMeXNROWZEWG81NHM5Q1hLY1VMZ3d6YTgxbnFOczA2M3RORkZGcmN5?=
 =?utf-8?B?d3BTdFNhejJnbFhCc2ZEbEZRYkJndVRDUnlRR01rNEdkWjVsMFM1OHBhcTNQ?=
 =?utf-8?B?cnFsNkdlb1NIVFZ1QmsraFBpMGdndlFnbVFlZ1MwNCtpblg4QkhGQWVFVUY4?=
 =?utf-8?B?d3Q5SnNHcTV5TFNrbWtaRFl4MW0rc2RwYUI5UzhzOGszMzR1ZlN5RGdFbVZo?=
 =?utf-8?B?Z1lwaVVXbExUaVdBcFV1ZlowL042N0pzanY3Z0NXT3dXUzgxL3BPZlJnV2Jo?=
 =?utf-8?B?VTRQUnEwYUphV0puc3g4NWpaZHBCMkh3UzNsYVlYT1RFSXNpN2FYQlZjUzB5?=
 =?utf-8?B?TndnOE9lNkZGRFlDMmVkemVRRjR0OWZMeEZBUUxNNFptWVF4K2M2cWlZckxS?=
 =?utf-8?B?OUJ3S1BCdXQ4TWZqanUxeEdteGdSMXFVYlpKMWdsc05sSWZ0YmpTbzFKZ2NL?=
 =?utf-8?B?T3AxRHFueUxRRE1zb2Yrem1md01ndlI5ZzBiUmRNTjlzbHRWN3V1K0lmV0VQ?=
 =?utf-8?B?NVhMZjZMczUyNCtOUk1qNTV4d0pUajBIbU14K3ZDU3FRT0o4OG9xaUJxTUxH?=
 =?utf-8?B?WGd1NzFMVXI5YlQ0YjhHZ0dpNlQ1RVZFL1BHQWxva0J0bVFDc1dMSGUxRjZY?=
 =?utf-8?B?V2tQbkFjT002TEZXakpUTS9mSGU4NlVJdHBFWGE4RnVsTFBqUkJxWGdDU3Iw?=
 =?utf-8?B?bHQ5V2lTejI3ZjBWa01aeElUN045cUNPYVNZcEJabzErZ0gwcjQ0bEsyOVdM?=
 =?utf-8?B?cVRQM0NCc1l3ZDRINms5d0hSZkgyS2N1UFVlaWdTNFY0SlpkV3hhdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c98b63-4180-4b93-878a-08defd482be5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:45:55.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUujmndVSJYcMO4B6I6Y1/IKo65yYqk4Uokxm5j/SKgBVjzajCo6ETuAe2n65V3f37NLA6qYFZ2JcEURoyeuIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8318

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, August 19, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
