Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC192D3EE5
	for <xenomai@lists.linux.dev>; Tue,  3 Mar 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576580; cv=fail; b=QeU+H62CWwSIQMeu1PVLf5jwoQwsUMPIhOZZuckTc+vXnnztKhtei17TdaAXuevbFI6kDWdQfxrAMCXgDq+mBaW8+PzSSx3yQn5nA3spDX3+IR+fie+2QiECBeSFRqeklxf59CD52CQK7yAq0LFgPTlaIhppY3vdwuCjIHc1teE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576580; c=relaxed/simple;
	bh=Wbpp3GQiWGpWmrndRxj145vKnto0RmTKQzbP/lJKz0E=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=SL8wxIeh0uXUj0xNoXcrvAkAVonbsFgnJJI3KOPJh4v+VMmiT1tkTIZr6HDcMSOwMCa++fQdrjkd0d8b2GEmdINtNz0MVHmKqwhKwpmV0tVAH1vGJeFIuG7dCie8qwDwBEeX+2N7Humk6/t8ljaj4m/+I3Mtf+x1vM/nmkBZim4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wrw91Gu2; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wrw91Gu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpzzTCgzK03kXeY3pnVeFVSUggvVBqRWsXCmSzy93iIEXN6Ah6zpDw+/eELTd42luGaKu26fqO5yJOS3ctRNcjYrak5GJpF7H0YCjQuokP7NKrPPwkaEuuuNvVX2D66LinAmLjxl2gkKWDi6OY9OIil3sUSWsdhOMHHwuZxuln4Lck7XppxXqODEbTNQ98+O6yhEff8IwdqkMtCVQyS0eJG3P1zSRLxfci/WR3OJPSWj5Vre0KOKCKIclSj4F8vjsCle5A89BsiQrutOT0XfbE2F8qXfUxiYtpm6kSO85WjDtJv93vmFUFykqNqx/OuiBlGtkJhs6JDQlYkjW/urMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbpp3GQiWGpWmrndRxj145vKnto0RmTKQzbP/lJKz0E=;
 b=PlYYwS6fIs2ok2sGhNtufLA58IrMNWdgEPM3hE79PdbiP5sqjMBqnQLxTfz1eg4mJXbLQ6hd5uthTqO8zIdfjr1oIdZA+Dm5OYtkYS1xuijltWNJ3yt8y6YzYt06me7NplUBh4ScsnD3ZpUl5USe/Jco1O3hW4tEa40LKb1Rvsjqi4gF2k44Nk9BYuHdxiuFghEZpX1eVndf8FwHM1woTCgUFrggNLUiLEvb7FCb8k5UiN+BOldigeB2WjJJDHm2lboBFiasfKy+VcenZsiwEcfN8BwW0F6twP6QAWDLKF17FcpO1e1RTKX3VyffF2REJ8kHrFavnblCoxDZPGVVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbpp3GQiWGpWmrndRxj145vKnto0RmTKQzbP/lJKz0E=;
 b=wrw91Gu2lJ0BNdTjY+v7R8Xqfa4ZelYlCEiDJ5fhh2YwKWwwdXK3mD5Wr8yYfs3TNbR10R13Tv1Nm8fIreEGD4tDzNHKClb/+uPfCVNsSNsjRBlZ4ARSObCXXCrmBa3gQo9CyhK4EwG2HLNAXbk5BeQDWb8w0Ga3nX3ESe9GxBdoJV3UlqMYhSzeDJRdlFXD0VWl7Norzw40HlaXaLinXQH/cnt1U3nEuD3QkS2Wwoyxx8+i0SP2EvqrxW3XWO9/9sU/e0riDz8YPiNkooR+Hthozdy6ocQutwVXON9wSuyTSEtqrJSm5ZNZ0sDb8EwLuXU6J7P4uIQxe9x5snY2yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 22:22:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 22:22:53 +0000
Message-ID: <fc96d945-5c67-4d6a-80dd-336c99594371@siemens.com>
Date: Tue, 3 Mar 2026 23:22:51 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, March 4, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5e1f9-f03f-4ff4-6bc9-08de79736962
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	dU4aZn9AzVSCwfPMfSZHh+Z1yX2vkkrAKE3Wml+llW1AvhzQwqPaZAJTI5oz0G5SJDu7CuCLXopi1uCWdi/6QrmDx1ApXrEdlrTgD5+Qmj1V5Y5wzdrIlmqrqX9Lba7cHDTjhe0241NvllYw0bGK3bdSHOBhdk48NLSiAEf1aUuqdW9YJ8gWjkxhbOprCcbpRXJs6uv8E2AGUemEdV0Ofpw8IFshHOgocmZUqnLGse+eN+eaWjN1icfLgIFQmruWFrZWCfaK4l1ozRoP19SMQ66WM5qVVra2q8X5etndjdi+4JAvqChIY+Naq39N7m68XzkEU4s9cJZgfGdT2xYmp0XYIxP1mwiCBCthZqFT8X7mFzGL0qAoQmSCk4jcOkUGip8ui3qYTUWPz7Arhu3yNJRTTvzx6s6cOt+8R9L4nW1Z3tkAKK9XN8ZvR2a963Q5JDvuR8/Zp5PZKUipEdrq1++SYL1QxVBew8LNRJmDxRYm7kIwzOIuaU8/lTjVCg9+0jd7IuG15u8X46Bq9XPz6k/Mu++ZmCClY13A0A6/zcnuwzFiqT6AaSlQVaGajXvtUh7/I9kNff3+YvkNH70yrLD1M1bYVNyuZd+xXnKdc7CqNXRRqjxDZnSBFBD44PnBxJy6w9JCz1Tw9a2nJPcZWZNPX0TZmxixxo4gHg2moCe1lBAqXReuZbdqpjl4moBG3Qom4v/9Zq9f4sFwrbyhCCYc541jafo7DGfASjQEO5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEVrOGhhei8wMWZSNkxaN3A3c0R5OE8rNjVxb0FHWnZaUmpYRGRtY0tRSkNM?=
 =?utf-8?B?cENzOCs5QkRvUTlyY0UrZnlIRFdKMGswVnlTUE9GTGl2bkFjWHBnSnBoeEpD?=
 =?utf-8?B?TmFTNTBONG9Fc0QvYitUQ1ZMb2xvL25DSWEzbVRBV0tzODR2RDRQL3ZQNktF?=
 =?utf-8?B?c2FURG1uQTVhVlFxRmF1Z0c2SnJIRGI3YkdhOVhncmt5ZWw3MFpwVDZBQVBH?=
 =?utf-8?B?bWRUcm5JWkZ4UFJxWTd2UElXMitvRVViT093R2Q5SFFKZ2RyRXQrNSt6eHpQ?=
 =?utf-8?B?allSa3N4NVZzUENOTFAxRklXaDZNYU9yL2JsWDJ6S1pVNUJPc1ZKdHVwTHdn?=
 =?utf-8?B?VGZkZ1NLVmhKSEJjU0ZMK1FucHJJZkVCbVNRa1MxNWdBY1NkalRhbHIzSmQv?=
 =?utf-8?B?RDBOVUg5VW9TZ1Q4VVBBWUVSN2g2S20vVWlKQ3VXK25Ba0VMd29YMmUva2dw?=
 =?utf-8?B?M1NWZVROalVPZ05pSGFqUmo1aXpmQzFNMDh3SXJocDQ0c0FxdVhUVUtHTyto?=
 =?utf-8?B?YUZ3SStCaWFYTkwzOUsyTlZ5OFBuN2VHSlhoVEVGRC9uYk90MTB2ME56L05t?=
 =?utf-8?B?UWxyZ1Z3aER3eDB1RVhUWVB4TE9TU05wNkNaNHN4TmZTQ1pZRWZFa3dkWTIv?=
 =?utf-8?B?UjhVRXZ5RHpVY1o2dGU1a1hodTJCZ25TMlVGMnFtbmJFYmtUVEVrdFMrb1BN?=
 =?utf-8?B?Y09DZVQxY0gvMElVQVVJT0JMTWJqM2x2Sk9McDVCZ05WSUdUMCtvSHlabEds?=
 =?utf-8?B?dGNZN0ZVdXF3WWNvbWxhek5NeHFLNzZMc05IamkyODB1VUE2ZUFEeGUwUWR2?=
 =?utf-8?B?VnhxOEdxTG9kWkhXS0czRXMzV05tNzJuZE1rOGVYYW1taW41SWszNzI1Z2gy?=
 =?utf-8?B?WUZDYmJYdlNzZUhKcHF5OXZKMlJzVmNrcDZFR0VlSzFWMURHWjBuaWxKYm1Q?=
 =?utf-8?B?REpNWDRob3N1S1RtOGpFRW5tNzdKd3gwK05xQ2swMnJVOGw2bndNK3R4U1JX?=
 =?utf-8?B?OEZqUFFYSUJUTU1pczdzR0FHUkQ5SWduVnVuVk5PbWlacWFWTnFEdlFXK0Zu?=
 =?utf-8?B?b25lYVI2eTg2OXZ0dkhDSW5vMXMzRmdqeFBGTGVKdDdhM2VOdHpxUTAwS1Rn?=
 =?utf-8?B?NmJsT1JkYkNGZXBSRW5qUzBZY2J6YnNxalUrSGlWQnpGNXhva29ER1pycTFw?=
 =?utf-8?B?cm9FZVVEQndPRzczOEFzZGVlWGpXc29JUlVBbkNsTWdWTU1UQmI2QzRtTExk?=
 =?utf-8?B?Z3FGdFVmdFgrb3JwazlDZVQ3bDJ3ZjBoRER3b1M5UXovRXdBNlpGZUR1T0d5?=
 =?utf-8?B?RldMQmsxYnpsVmUwMjFxYnhJUzdDN2RGU3JIT2pnajlJOUZHTk1LNmdJWjBU?=
 =?utf-8?B?WXhIVkxDYkVOV2N0QzdWY2ZsTUZkSWVZOWF4WndyaEpqbU53ZVZMcDlZK1B6?=
 =?utf-8?B?SHI5ekdxNU93RXFwTlZ4S0VOS3U2d1B3cUVobzhOS0dpTXZrNnRrMmU3R2JV?=
 =?utf-8?B?WHJENHhiZitaY1dLZTEvNUM0Q2xXWWZQYUIzWGJpcGxjTjJOM3lDeHRCKzlY?=
 =?utf-8?B?clF4U3hBRFJ2VHpKWUhwS0x1bG0reVVZbjZIU2NPTEZTRGtkSXJ4WUhPbVFC?=
 =?utf-8?B?OEorc1NWeFI0QjlISi91WldjUnZ1TWU1U2sxTHVwc1ZPdEVoeFRUL3NpRFI1?=
 =?utf-8?B?dVlmS1BIMjk0OVBlZk55eFgwbHVodklnMWUvZkhqU2hWQUExR01EeEJlcTEx?=
 =?utf-8?B?THFTcW1zWEYzY290eDFhVnA3YzRIekdGSC9GaURWd0ppenNMRTZzUW5oNEFq?=
 =?utf-8?B?UmhwcXM3T2dnK2Zxc2pRZy9uRnNTSytmODJQdDlpQkR5RzU4QXA2UWdkWmJm?=
 =?utf-8?B?OXptUHk3WjRrR3NRZW8wTU04aTJqdU55cTQ4UDBaVERXY0lVVWRIWUNwWFVG?=
 =?utf-8?B?d2IxSjhrempoRTNUMkkxc0lhTWcxNnhvN01JNDhENHp0bnEvSTBaRW9hZGJi?=
 =?utf-8?B?UDNGVThvam9WbmpISDZXbG1LbldlTGVlNCtIL3dIR29VeGlMQkREdVRvRWFY?=
 =?utf-8?B?MUYyMEM0a2xOTVZQRWFybHNoM3d6MEU3bWFzNlBLZ01rVGpPbGZVb2RobEpk?=
 =?utf-8?B?Zk5HWFhodzdsTlkvYnJwNWJzeU5tWGw0cTZEMm9JUjkyNDc1eUl5amNBU250?=
 =?utf-8?B?SFhoVjFrTFRZR2dsdUtSbEh5MGxHS0xjSDlwZ1NSdkpDRnFTbE13Um9FVE93?=
 =?utf-8?B?Y2s4NHVDZFpYWmRicDA5UmJWTUIweTk2SWtMN1lteC9IZW5WVzZUdytWcUFv?=
 =?utf-8?B?YmJabUdWQkRXWkFtUDNXZkt2L0RuTDg3Ri9Kb1NaVWppYUNHV3ZPQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5e1f9-f03f-4ff4-6bc9-08de79736962
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 22:22:53.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: varhXpzV7dlqCTPQhFLQ+voxop80QUZBuaSTcolMt6npd3iwtXeIB2wBsPHE1WutfeKDJcrRkOhDHiqMBPQzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6283

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, March 4, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
