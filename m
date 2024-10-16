Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407020512D
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069369; cv=fail; b=E1Myhvz+mUMGuHsppLbSo+1aT6Fb5Wo2/qd8xAaTkFUtjtc4lbyQOa3oB6tTLtI9FjkjSdzYQ3tR6IEWmRvF4SPDVH4v2oK1lokce1eSMK3/IdZlzrgOUjpXiQW5jt2I6I3+KBXqVHB3qcW2F69cWN16Rz+RC8LXdujnxJFVCDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069369; c=relaxed/simple;
	bh=LK3O29ibSgUu+MzdyGSK0yp11lufjJwurdJWsXT0Cec=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+KUuf419ZKYaFiaeQRpEnrRr3XaV2SBDwebuAsO11oCTT5DhgXwE+Dy1REAuFCY9z5G6X1fTRFeG0wJV8OCHu3qBadAKD3E6oJAfrjsk7Y9A/ToLkARyYdH+0AlOgdgRqw+uvu5bvHrkWBUmW35whWk3SF5r+/NHswNgZ1BHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PXodAxYr; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PXodAxYr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntvBnb/9LH6DldLo1qfZC5qiYK/nZU6mFB3DnTbxani2KhcdJm3c5xJ5SpGX2raq70wQt2KOlC8WhfUwPRlSk8PWYYUliSx6GhsGTqnZ4FbW8Yx57OCDjgdR+NVAmB5MmwZf+OM8vLFboCa70C/Nic9JCiTJSOGCOv4wm/y1qGFxoUfkCoonEAhz8CxIdykZmHijQcFjB6yWKFdRCT/w6p2P8RSSLD8npQh974h81IHx5Bc2aeHxDmd7CrrEjor+JVC4aXeGKM8wJkshit8/DNfXN6InxFg7cfSxjfpZ9YvSaenpgU1oSqu4gQRaYWJqG8AdsmGGWTmM9ceMgLxxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvZqp+BmJsrkDkyivPj4JvcqcIyMeUbvxDdGv08uHYI=;
 b=dY+5NXuedGZJMDYLzQqXQFqklzpA3GkVy60p/eYnjV2VLZQ6jD0pRWcIBQSI0D7wYYmjfh6jlCouo+jwd2rJUXUkBjYMdTcP/WzMNr8eeJyyw9g0+B0eUEM0ErlQKaR1xa2Iw53EJsvaM9FCTVsxsx/L/QBLWs5jvICBKFn1QEdWL82nfzUw5HEcIMAMSL7/r3PBTve8hqf8L8BxtdhbTN5q5tbprHHWmRyyGeoNO29c327wa9sHHZfMQrQjR4cFldTVnEUwAcNMZVMpu81EY2CqlcTi48fCBvCHCDO062g3+GZlyD7hrYodAcdc1IkMvdHLNdKWZgJrX1glBr4kUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvZqp+BmJsrkDkyivPj4JvcqcIyMeUbvxDdGv08uHYI=;
 b=PXodAxYrNdVNzTsEw9pzqm2VANFfBNB4/GNOTw9LhJUVyn/y30V5r/eG9u6D4pdJ0WeESO91KxKg6c5y+qiv1qu9s9LEUjhlk6eCWtr2MtdO6Kv3aBLUcWCNVGnpXorTEV7rfN72V/43F23wSr1ey2YmfC0nR/AmX7xJY9XpXSgIGtmjne4uLhQiqY/uzXoSQST8hxexqGcXc7Wqicf5ABiznI1Fv+NkmZ33rQJVC30FWkjtBl6c8d+o3OPATEh+RYLIYK6fUfsvr+S06H3ciz5t5A8OF+pZSFdvJkNEaobDca1rvQQ/n3lXDfh4bB9qMYdSzCaSw6VtyWun9aW1fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 09:02:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.000; Wed, 16 Oct 2024
 09:02:44 +0000
Message-ID: <e56bb7fb-8308-4761-a187-b8dd65debc41@siemens.com>
Date: Wed, 16 Oct 2024 11:02:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: drivers: can: sja1000: add F81601 pcie can bus support
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
References: <20241016081433.917945-1-liuyang@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241016081433.917945-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b052cd5-a1db-408b-6c5d-08dcedc14c5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG4vUlJqN2g2MkdnRUtHQ2lJUHJRNmJ2ajg5c1lKbHl5TFJnVVBHdFBKejNX?=
 =?utf-8?B?WU5SOVkzSHJxZVI1RnlVQXVaUDhESXphVmEyTU1SZ2JCTkJnL2pmazF5MTM2?=
 =?utf-8?B?NHpZb0N6eGdPMGhHTVpnM0szNXovQnpId09pZWVHVjFXc0xKVVBJRnQ0YmNt?=
 =?utf-8?B?T1F5Ulo4WjFrWGdkc0J0cFhvZDdMdm5LY1pXWnErWDFrWUFwNEx0Q0dLbEk5?=
 =?utf-8?B?Ym5SZ0dxYVhURHJYUDlvTUFHdmZvdUZGR1FSQnJFdXVUdG91SkZoZGhKTGhs?=
 =?utf-8?B?TWpUcmIwelBZRElXempTckdOdi9OaTNmdStFNXd0TkpHVldBQ2lGeDVIU0Jw?=
 =?utf-8?B?UnB3WVBwVVBUQ0pEMzdHdnByU1hwVEpMSWdFc09iWXhsUTRhdWZ1aWR1KzVR?=
 =?utf-8?B?dlMyWm1GM01McEZBWm1Ub1A2aVVOQWxUekJacnM1aWlQWSsvNlFxdVExbEVN?=
 =?utf-8?B?MTJHNkJqU3g5MitRMWsrdHNySlFpdU1pOWxaVzZjWWdac3Z3WEdzMU9hRHJU?=
 =?utf-8?B?TGtpYUIyTC9sV2dTeU55cTRMSlZXekxybnFqamRHeW1CNEZmNXlubnV3LzhY?=
 =?utf-8?B?ZEFUK1Fxcms2NDBSeGtWYWVjb0FBNzZTVnQ2K1BtRmpMMjNKdVhmNnBDakxp?=
 =?utf-8?B?QzMyWE5UVldodFVBNk84aHpoWm5PamxxVHl3cit2SWQvcWVUb1VPMWhtdnIr?=
 =?utf-8?B?VnhGM0JKbGtkT1VyZENPbEgwUUJIRi9sT2REMTBlWEJad01XOHk2dWppZ0xl?=
 =?utf-8?B?dFVhZ3BuanA1TmFNcyt5YWRicWdLSm02RjNVSmRUVXZsZUNVR2E3TVhtb3ZT?=
 =?utf-8?B?NXVyN1FuSWlJdU5naUo3cVNwSytuUlFyNnhqQ0ZmaUZMU1JXby9VZSsvbkdD?=
 =?utf-8?B?Z2FISGRzRWhBa0ZEN1E4R3YwQW5IWmxpYmhYcUxLcGlhbm9KdmZQcVNXWG5h?=
 =?utf-8?B?TXRHQlhZeVRZMFMyTDRVOGcrcWx2YWNJb1RmazdHbUFUTmRWUldiZkVvRVZs?=
 =?utf-8?B?c2o2YW5TYlEzMTl5NWtPSWFJKzZyN0czbDNEeXVzYmZ1dFFsQkxXMFg0YTd5?=
 =?utf-8?B?SUl0eWFzdjN4Q2lEQ3d6alRPUFJoc2VXdUx1dkhWZUhSZk9DMDBCVVBiR2k3?=
 =?utf-8?B?MVVpeHFOV1VBdHp5U1JXSDZ5L2ZmdDN4RzNGYWtlcVZpR0s3amhJY21ncmhq?=
 =?utf-8?B?VDB5UmQyQWNnbllTSmZ2bmhkeCtOSG1hOGROY0xVOURSOHcrVWJERlRsTEpw?=
 =?utf-8?B?T0RKOHdEL005VXJCaDIrQ2JjKzMvNFdyajJMWFhMeDc4bEpvWWxTSGlWTVU1?=
 =?utf-8?B?a2d4bVdiL3NxQWVHYkQ4R0ZQS3dkRXZIMzk2aXVydTJZMm00SXVvemFVZkt6?=
 =?utf-8?B?S3hyTXVUVnFORnVuZC9PMjBqdFhZZm56R3BRejIxVmp3ZzVHSTB6LzQrWERl?=
 =?utf-8?B?TytCV0VvMjBtMXZOWHNJTy95UGczcmhDNzFZcFRsUWpZV0JmOGRkN1U5d2lT?=
 =?utf-8?B?emQxOTBmc1JxNGQwekJZd1h4WldsQUZHb0xtNmQ2Qm1oTFAyVHc2TTIwcVVh?=
 =?utf-8?B?Z0IxRkpvWE1jVDBSNUZMcFZwMU9yczEvYXFKendzcUs3aFdFQWNjR210T3lQ?=
 =?utf-8?B?eVpDbGM5L3lESktoWEc0WlpJZTNHSS9tcmZMSEZVc3FKOXB5MC9mVTJnb3dV?=
 =?utf-8?B?eGd4YlBBQ2pabWFRMXZ6NE0zQ3hROHpTL1M0Z1B0dE9sQ2drMUpJeDN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTYrYlNnaU1YOExBSUE0Y2dzckV2WUw4bmtPM0Z2ZmxCeDMzY1o3NE1tL0NS?=
 =?utf-8?B?ejZ5LzNIYnRMV3ZKcFhNRHdpWklLckRpUGZrRW1uVFgvNThRZmNjaW51b3R4?=
 =?utf-8?B?Vk1vUkNSTytVVWllRW16UElEYUMvdEFhWGRoeVVsWmdLL3pwS1YzSlVCdHky?=
 =?utf-8?B?Y01SNDI2SWdtSlczTDU5aGo1WlJ3MEkrZUM1UldlYTZJdHJISEFSM2paclNP?=
 =?utf-8?B?M1IvN0hiRDdnQVYzVUNIc0FVWVRKZDFTK0UwU0hCRUZncFh3Vk5XdnJwdGtN?=
 =?utf-8?B?bEFUNzIwTHMwOFl5SEhNZDdYTVZtMEliN1RtTkM4VjcvM2FnS0toRkhBcERK?=
 =?utf-8?B?SitSTk5xSXRMcXhFa2ZQY3NHajVGbEVqN2hSeXJtTml6bjEwc3pUN1NtMk5v?=
 =?utf-8?B?dUhKQVcxRjFQZnJGYWdaZWh1Ky9lbS9mWEdXRVh5RWIzT3V0MjZIUWtFMFBm?=
 =?utf-8?B?dDFoSGxnaHpuUG1VcGczZnRSTHowMmlMK09vMTlNL1p2czBBM2N4cGc4cEZE?=
 =?utf-8?B?WmQvcGJ6MGxWbjgyamRMaU8yaHVLU0lXaXVUbS9iV1ZrZnpSc3JzdXZMRHJw?=
 =?utf-8?B?NFhKZXlTd0E3bFQzcFpxaHhid1FtQlM3Unlsb2xLaUc0QXJkc2tnMnJQb05N?=
 =?utf-8?B?SG1kMk15Mi9qL3FsbW9oSmVsclllSExSVmlPYmlwekJ6N0xGWkU2SjdIMnV5?=
 =?utf-8?B?TUJLdzZSTEprUi94WEpXMkQxb3J1VmZ5K1J0VFlPQTlkQVRrWUxkdGZ1TjBq?=
 =?utf-8?B?MXVLVUtiWmVTNEwxWnQxMkphdkYxVWZsZno3RDA5S3RtRkhOUmkxaW5OTXZp?=
 =?utf-8?B?cGkrNWN2eUpLekFEYnFNRk42c3d1ck41MmpCV2RtV20wVlgxRXI5OVlmTVg3?=
 =?utf-8?B?OFRDZkppcnJDYm9kU2ZhQnhGWjNTcU5mMTV1WjhpK1hKVmFxSXRRNVoyQmt0?=
 =?utf-8?B?N0s1Mi8rbWhYSjRYUCtVaHZQbkpNVHF2T25RZzFQSW1URlBidE9TMW9iSEgz?=
 =?utf-8?B?UWZZT2RUWklIeFUxNTBGaHJJc1l5REU0T2hPeDlOMGF0Y0wzZnd2NGc3UEVm?=
 =?utf-8?B?NVNWWlR5OVBrTVpwUHI1bVoyUTdWd1I2aWc5ODhvVElDWTNlQ3hHU1B3ZSt5?=
 =?utf-8?B?NGNIS2wvc0E2Qy9OWEw5aHlMbGtzbmtEQVUvNThQRzEzSkN1akhPak84emVB?=
 =?utf-8?B?Y05BanMwenJxNTF4b1NMc2MvaG9JSWs0QVNidkpDK1F1WjhCRlVHL2MyTklh?=
 =?utf-8?B?RXNZVkRiRmRMTllONzJtYStyZUJPN3lqUlgxWVBOK2gyVXBUU0djbFBRU3p3?=
 =?utf-8?B?S0d0T0YrOEkvRnFLQzZOMHJFMjJ5Tkx4d2dvampZQXJMN0V3YTRPOEs0MXNG?=
 =?utf-8?B?UDloOERmRmh3eG1YakViZVcwOGc1dWFRSjhKTG9KL3kydW5DenBwZGpnSllU?=
 =?utf-8?B?MzRNSEFmcUpvMkxNeU9sT1FPYjNaRmtkYU5kWnlmU3N6N3JYMkQ2b2JWazBj?=
 =?utf-8?B?M0tCRnYxRDB6eW1pSVNrZlAyRnU4VW9aZk8zSnowZlZWU3MwbmxYTk5yTk1v?=
 =?utf-8?B?VWxMd0RiaGllZ1NHaHRkZURIcGttaERLaW5Ea2M3dUtucENEc29BTmxLU2R4?=
 =?utf-8?B?UFFXdnJxNm5BYW95dFB3ODhmV0VUTHgrejNkUjBqeDFIVkZtTDdDWmhrUzJE?=
 =?utf-8?B?ZlFEVlZWNmt4SlBuNDBQSHIyLzV2RHJnbDMrSkJSL0IrUXZMMExGQ3Z6ZG10?=
 =?utf-8?B?ckNjbmZ3L0pzbEF0K3htSGdydWFSOTFoWTFWSHZHL05hdy9iemczTTFRaisy?=
 =?utf-8?B?UGJ3ZThJY2VKbmwzMDdjTUwvR1JkRjRPWUswMzJ5WHUrNUNaR1YwcFYzS2Z2?=
 =?utf-8?B?V0FVNkE2cnpnZ3ZzTnBwUXp3UEpzVDZSeUJ1T2VXeUVlcDZxKzJVdk40ci9M?=
 =?utf-8?B?dThlZ0lQLzlKWFV3OE03TlovOW9PSjA4b0JENUx3eXpaZUc0RFI5NTdqWVRN?=
 =?utf-8?B?a0l3L2VpUjQyWWF1bWVsVmppeWhpWUIxczlvUlFmU25yOFhQR0ZTMDBuWFlq?=
 =?utf-8?B?VnQwQlI5L3BxM2VVVWFMQ0RRYXhkMkRSaUVmNXF3dVpranROc0VOcFZVUUNW?=
 =?utf-8?Q?986CyeMT10b3+KElfqDTSI3UU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b052cd5-a1db-408b-6c5d-08dcedc14c5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:02:44.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb5tarL/xoe5LxZ7kn0B+ZAck0T7Nm5m3UHFEhO+8/zm/2ukw24bEWoaMuFjlX851cofuhJ+C1KvqNfnFpvQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6244

On 16.10.24 10:14, liuyang wrote:
> Hi,
> 	This patch is port under linux kernel 5.15.51,only use the can control 0,have tested in intel J6412 and Hygon C86 3330 platform.

Does this mean you used the upstream kernel driver from 5.15 for porting
over? Or did you tested it against 5.15? Or what is the reference to
that kernel release about?

Note that the commit message of the actual patch is still empty. When
I'm merging, I'm picking up that message, not this cover letter here.

Then I do not see my review comments [1] addressed in your newer patch.
Please read again, either reply in [1] why the code is fine as it is
from your perspective or send a new version (and, again, please increase
the version count).

Thanks,
Jan

[1]
https://lore.kernel.org/xenomai/421826f0-0523-4ba0-861b-067a87301278@siemens.com/

-- 
Siemens AG, Technology
Linux Expert Center
