Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022109.outbound.protection.outlook.com [52.101.66.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2926287512
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893593; cv=fail; b=q8BfIQDqAjs7vBi5ePvz9CIjMykZ1T8V6lbHZYYpWqxdxqdRNaR5Dbw702lcT9UsMHcAjNDq6MdFY/W5tE+7Pmuknm4u+CcChoXZFV20a9EKxBF9Q3LONsijNAabac9MucqXKxVlIq9+i1DQkfB9QNzTL6QqnfWWLtLeQs5G3Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893593; c=relaxed/simple;
	bh=kgf1KMlbeMxDZeUU0tVjwKNeT2JGGCoT5+AlKUaE7DU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=XUDGdZ2ZI6jYypOY4QSao0Ck0bR221gi8KwmO5Rea9BCZ3lhltmUtsRy28vIMX0WZCjd683E1AiD0PkrJCIwRO9sZuTg+DJ2F9nEi0ZQVLKnqnxsg7/akn6Jv6mMMPBa+U5Fr02Cu5YHLmA44FD4BiXfPlJ7BSwPNaRCkKQFbpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=YzpnnQOQ; arc=fail smtp.client-ip=52.101.66.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="YzpnnQOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RICxbgLmEVrXEumdpktsw/uFbx1/kR6o9A9kdEJFJ8MwSIn5qXtb7nP9mhx+VMxDJMC6/8N8pO7PpTGT+tUP8KINoeRAJN7bAMrQogreo4n69e0vlWdHMS1YiXMNdtq49pPxO9L4aaB7u3AhL+rMk5ia9HMmOVb2byByG2vOI29emn35NFR1GG9TDuSvNnhuHbEtwbtT7w/ia0UwHkjHlDqKOp2Uknt7FtzFocLMs/u25d9Olw70S07yD+g0pKB2TKTeOVbwBok9wdFdEp2szGTPUdGG3R43woeKBHv1kOdT1KgpO6M5TDtKFjZvpx0b8YsdISeDQecBctt84Aktaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9heCio/u5WZzUvFWW2EWkqIN0MLDPDKrBqe1visvCA=;
 b=HS0PbEg5vAFUqrx+NoB38lx/q0Wab0Akrpc5vdNcLcicm2ZUSuF2qc5bOWDCjm5fxd1a5kv9Hhl9Fo5kZIr4np9R9QUKeIjBEx4/p1t4SVfA8Y8a1zvAfeIdnm20W5NbBrwfqUYMSN2Dj3DGJMdTiV6VJcjB1tkYFxdNlp13fg1JD8HrX5eV6npmZZ3wEPugL0E89/xqSAIMw8De2XSpEFMdVMbpFTvjGIWC2J3504g6QxWPx8yIMHlTC/i9tvPwaNa9Z8UMVlcZ8KX5m4L0NdGLZWDpwX5I7BjmkXUNIo1Zbh+bjUhPUPwxnmeJBKEINpztGFNu8POWRcVeD3hh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9heCio/u5WZzUvFWW2EWkqIN0MLDPDKrBqe1visvCA=;
 b=YzpnnQOQAePwqLrrvpdsdFx2n+5DCvju1FHb7KV74F1F8iL9djWTut9FxftDvypE5UPsneIJILk05PG0zplJfOzURXO9Wj1kbJiWRX912LyIY8cfBl3p17DizSpowowSSOQ8gJsw3APUZdw568IELleha1kixDDcCxniQh3h280=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com (2603:10a6:10:428::14)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:59:45 +0000
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348]) by DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348%4]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:59:45 +0000
Message-ID: <7e7f370a-ac07-4a0b-bab4-deebb80c2569@sigmatek.at>
Date: Wed, 3 Sep 2025 11:59:44 +0200
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
From: Markus Kurz <markus.kurz@sigmatek.at>
Content-Language: en-US
Subject: buildpipeline for xenomai3 docs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To DB3PR08MB8961.eurprd08.prod.outlook.com
 (2603:10a6:10:428::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR08MB8961:EE_|AM7PR08MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: d40ee82f-dd4a-4886-1c0c-08ddead09c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1NXOVNFLzFYWS84ZkJ0MzBickt2Zm9ZczV0WE5EN2FlUTZoaThOSlJSOUJl?=
 =?utf-8?B?dk9xMDRhMmJyb0owdnd0ODg5ajIvZDhsRU5LblVxaFd2ODZyMHplMzlnQUM5?=
 =?utf-8?B?ZUErSFI1akdJZEhiMWcyZmZuNy9kNmhaOHRabit3YlhSVjVkYkFMTFI1Mnpy?=
 =?utf-8?B?UGlBQWJqa1F3cEMxV3pnRXNVNWhTVFJHejRjVUhnNzdmWkt4eG4rbnBzSEtx?=
 =?utf-8?B?RVQyL29JbmtIWkNDTmJENnpzcG8wMDk1UFEyMTVCVmNXTkpGWEVra1NubDR3?=
 =?utf-8?B?bjBoWDkwUElPYUQ0VTNjUVo2WGRQYnlLTnNpSk9memxNNmF5aFJNN1lJWjZa?=
 =?utf-8?B?R3A2R3hhNmJDRTVIcE4ybmRpbTducEFxV3hkaU9aR2xwRW5OM25NYkMrYlN1?=
 =?utf-8?B?YkJtSm95Sy9wRmJ4U1lJNXIwTkIwdDUvaFUxWmd3SmFqKzhSK0xEL0xHNUV3?=
 =?utf-8?B?bVlwSzF5MlFDTFlkTzRQbmNScDd1RjhYV1BkVG4wdVhKU1lBWFc3SkRzcFdD?=
 =?utf-8?B?K0E1UmI0YUYxMmtpT1hXdWEvRGtJWHgvYjN5cXJrUEMybExVdzMxUkhsWDNj?=
 =?utf-8?B?RTZNQkJCQ284elFzc0hzRC9oWTRnenJEdmxQNXlsK0JSSStqeHdHdElKRUwz?=
 =?utf-8?B?UTI2R213UlhGTk8ybFBBd2k1NW1uTjdFV2p6NG84QzM0L0ppaC9XQmw2R0NS?=
 =?utf-8?B?MFpVN1BtTEJRZk9KeVcvbU00cThJd1p3VEJiN25qbXhrY1FXc3pKdWx6b21R?=
 =?utf-8?B?dUZFQy95bkNIWC9QL29DOE9YN29OMHh3WEhaMWpOMDZIR2hhVEdEL1gyd2s0?=
 =?utf-8?B?dXFjR3R0bUYvaFB2aHRMdU9KWFlsUTBERmphSFZkaWs0bDVOd3R0OGRtV3Zo?=
 =?utf-8?B?aER4cU9JTGoxbDJVd0NJVHU1bFl4cEt5VThrNzlXSU13MjhYR2J1ckl1dWht?=
 =?utf-8?B?am9TTTN1cmZUSnJORVRDODVXRXVFWlZ2aXVKeUFqVWc2R0FGRk8weWRxZzRh?=
 =?utf-8?B?WXp2Um50clhkU0FBWXllaG9uTFNlc1gwTkcxL0U4RUIvNlc1Wm1OQnpyZHJL?=
 =?utf-8?B?Ujg0SW9CTkk3aDVLZEY1Z1daNytZR2RQMXZGOFFZbkJHL2JoMURKcmpEQjc2?=
 =?utf-8?B?azRDNEdXbk1XU2JPUTNZbHZwYXNnVnFHMGU1bXRHM2NCSXYxcWFVNk5Haitk?=
 =?utf-8?B?YWZuNjM2UFBGQlA0MmwzTWxFL2I1SDE5QkNhYkpEdXRGSnAwVFBhZm05WW5r?=
 =?utf-8?B?c1RsaSt2Z3Frc2QxZTliNG1OS0g5N0FHNGxOeVdSa1JLTit2K1NLejU0YU9B?=
 =?utf-8?B?dy9mdUhtUGlwWUYwNUg3QkJ6REtzb2Jxc0h3dUNxMTBkZUhtR3BUQlJ1S0Zp?=
 =?utf-8?B?RWlJd1hxckU2QjJpRmh5aGJ4R3ZKWjEvU3dvN1hmUlBSN0dabC9tUzVaMnpk?=
 =?utf-8?B?LytpQ1grS200dDdydjJrRU9vTTF4MVJaZHd6dVA0Mnl5K2RJM3k1V3AvMHN6?=
 =?utf-8?B?MmN5cE1jMytzYXZ5ZlUyS2VaR0p4SFZEb0xIYVdob2F3YnJ3RVNZN01EWmNz?=
 =?utf-8?B?b0RRTzJDaTdxU3l4V2VPWm1rUFVNUEEwWXhNdlpOcGJHUXNaRVExTDAwN0di?=
 =?utf-8?B?TndFcy8ya1ZBMGIzSXRjTjdlYkI5OE1qNElPR1lQbUh4cVpnRUh1alNKT1dy?=
 =?utf-8?B?NFFsbW9sZmRiTTdwSmNyZTdtUmtnS3hXMHR2Uy8zeENDSWpGNjViUUtNVWlW?=
 =?utf-8?B?SVJ6emNEbEJxZTZndHc4Vk1EYkVWa0xmNTRoNHRxRk9GeDRZZjlYc2dpdjBT?=
 =?utf-8?B?UStpMVI1bWIvSmtVRHdYYk9Xc3NGNlY0cFRMeEFjNGJiNFZjL0pGaURyWWxq?=
 =?utf-8?B?bTRtTzYwRlRZcEdqZ0tCMzFpK0ZUY3J5NUdXZXpia0RUWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR08MB8961.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGtjQzdPZm1WRC81L0RBVGZuc2NEaGRmTVpFMFlQWmg3cjJyaXc0eWlTN3Ux?=
 =?utf-8?B?MGdvTmRzSmhBVmN6OVk4eldLTTZFejBVWE53L1EvWTkrM1dTcUpUOVRJQ2tu?=
 =?utf-8?B?aWxQd3FvQ3NnZ1lBWGhBVHVXMThvUkdLV2tqOFZVR0RKS2hjdGFPeVBFRHp2?=
 =?utf-8?B?UkdWekRvejl2di83QzFHMlZiK2ViRUZQSmp0N0NkMXpDRkQvWWhJUjlrSUhE?=
 =?utf-8?B?RWNYTWxVTDk3Q0p3dkdYZXdMMVZ5RWVsQzhRMHlyQWJ2ODNJdUZON3hIRVEy?=
 =?utf-8?B?VUgzK21zZmU5R0VwUnRsdHFtWG1FRDNWOFBRd3diWFpXWitOZ0dGbUlJYkNZ?=
 =?utf-8?B?S2pTYU81TWRrYjAyNVpzMkkvcTlGUTliTjR2Zk9DbFgyMzA0OWxuK2M3cWF4?=
 =?utf-8?B?M2ZtV1hwTVY2eGkxMFFPT0ZqMWRCcjlZYXVmQUJCbzN5aUprVzVXa0MzbWRz?=
 =?utf-8?B?Z0ltVkE2UjNnZklBNzhsYU5EMVo1SHhYMVZvYkc4VE9kSUVneHEvZDQwa2xL?=
 =?utf-8?B?U3FGVVlGaTdLVlRNeThBSHp0UWU1N0UyRDlDdklHMDRMb3VScXdTaC9lOE9N?=
 =?utf-8?B?V2w2UFRZTG1wRnFDTXA5RUhQVVdCMWI3V3pXUnlKVS9qelJLalFNaFRMcjdW?=
 =?utf-8?B?OEVkRUtucU9MZlVSUGRmdTlvV3ZFek9GVTJNdzBBd2UyUUxlbWcwckQ2QTNL?=
 =?utf-8?B?L1V0Wk54aVVadUhzUlVudU9mRWVxVks1NCs3cG9UMEszYXJpWFUvemNUMUpG?=
 =?utf-8?B?L042bUpWSG9mU2JrVHZ3UVNvTkgyYU4zU1J3UjdlMGdYeWlDQVZMUXJPU0k4?=
 =?utf-8?B?VlFpNEsxaXQxR1ZTbFBEUTdoSDFQZC94ZjhUelR4RE1mRWkzN1FHVGtCbmJh?=
 =?utf-8?B?WWVNZjAzZDBTY05oVDlEV1BvcHY1UkhNQ0lUZ1JaeDMxN0dQR3ltVXhyQVVo?=
 =?utf-8?B?ZThvYmhtYmlDK05ENnk0VVZZUVZoanpxZFBSVVJZYytwVlNUc2swUStNaG9w?=
 =?utf-8?B?SW4yNnJLTmNNaFpGWnJPajJqUmV1ck0xalFMSmRUWm82dnVKSTV2azlzUHN3?=
 =?utf-8?B?NWJ3c0o2YzVvTTlZeW11R2RaL2lNbkRrYlptWUZ1amQzSDM1bC9XZUlUVDdH?=
 =?utf-8?B?T2RtOGhmVUp1cWVLTElDUHArdkFydW51dGdpeU5mbW83Wlhna3R3SVBneGFw?=
 =?utf-8?B?OEdZQ0VsRmZnc1YzSTBrTS93Q3VySnBYMHVhRFh2KzZvK2picklHajZiVHFj?=
 =?utf-8?B?VGxHcEI3cmQ5YmNCZEl1cjlzZlprWWZoajhucTE3OGJrSGptN3lKWUdwZU8w?=
 =?utf-8?B?VHRKN2VoNGhiUE9EeGlMVUE1ekUxOTkzaWx1aS82dG50YXE1VUFnVlBNZlkr?=
 =?utf-8?B?aWJMWTRSdjNJekZ6aFg4UFZaSUk1M1pwYzk4dkxhWjBTREFrYVR6Sy8yTnJ0?=
 =?utf-8?B?UmFJdGhaWU5qS0xTVjRKcnc4VW1DY2tZaU4zNjM4SjRyQ05DRDBBSFhtWlJn?=
 =?utf-8?B?and0a2NaUlNVazNhcENhdEl3WnZVYTB0UjdILzdXQms4TndEd3JGQStqVWRG?=
 =?utf-8?B?QWluUmhlcXRkWmFGOVpHUEI0SmcwYVY3eE1yQ3dqcFQzQThFSVMwNkpxaWFw?=
 =?utf-8?B?WEs2YjBiRG05Z1Z4Q3JzYjlZZzEyZ0JDWlA5aTZxUjlXNTg0Y244d0ZoRzZ6?=
 =?utf-8?B?MUJEZkJmWUJCSTUwT1BRNzZTLzUzQ25MbkJUYkhuMVVCWE5udDJ1S2RmNWpj?=
 =?utf-8?B?VzZZTVYwT1Z0WUFuVTVhZVFLZ1A0bUlOQzJxQkh4eVNQZDRsMGcvZmFzbVFj?=
 =?utf-8?B?ZzVOQUxrNEVJTGhCbjZmY2tYOUpZREUweDNBbENTc3Q2Wko5Qmt2UHBzcVJq?=
 =?utf-8?B?bVNKbEJyUm9sbXBQN2c4QmV4UzBpc1hkc21NTURtbVZlcnROVzRYOEFHUnF0?=
 =?utf-8?B?UVVhQWk3U3ZOdUVnUUY2akoyRHVOZkVoOER2cmNidkYyWGo4WWVPbGREWWtB?=
 =?utf-8?B?NmJUT2FGNjhMTlVEUDhzV24rQ1o5L0FYeE1HdjFmd1hDOU55d3J0dGxlb1Za?=
 =?utf-8?B?c0l3cVJtZXNMZSt0Z1FOQ1RqOSs5eWNBaC9QYnJKeS9NQmQ3aFNVaVB3bHl6?=
 =?utf-8?Q?sWbl1r7cxayZmrDHj5x2HC/52?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: d40ee82f-dd4a-4886-1c0c-08ddead09c63
X-MS-Exchange-CrossTenant-AuthSource: DB3PR08MB8961.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:59:45.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXX1qNE7/4N4908Jj4Ybk2T71QjpD8r0SGlEmHfURfZ9WKDYKeTmKrlR0/Ko8UA19zOxX5WuvYJDmyPPuTg2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334

Hej,

as discussed today, I'm currently looking into fixing the warnings 
during the build of the Xenomai docs. Could you provide me a link to the 
build pipeline, in order for me to check how exactly the docs are being 
built. Then I could correctly check the errors and fix them accordingly :)

Thanks for your help!

Mvh
//Markus
-- 
SIGMATEK GmbH & Co KG | Sigmatekstraße 1, 5112 Lamprechtshausen, AUT

