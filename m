Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469C37AA91
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433775; cv=fail; b=eMfthWT6mxC6xaC3Fl24STGHaDbhSzZVextjzrFRiHeDGKAwn4Nd9TY2lg5+Qm5JPqbVypm/LU7IOMswYgXR9ApQSfMMhUe2LHTuOwcmQ1rp//+McEze8LcEO00cfDGYuBKpt+iPYbofjIaiDvoub8RVlphxkrdcVs0Yx9YulWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433775; c=relaxed/simple;
	bh=e/iNJaA2jNiK1OnZIaJVMsJkwmmn2k819asKwuyah6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gKLCIRJBYMGWjDHGbXifTAhrgjiqDb4MUr/8Egah3T3++gA3AsVasZxtUb75lyqOigUbsoTp/AcgGqjumFfsk2v95sH3aslilrTfDum78btdb4vkARJghd56JXGJ95Fp1nxh9+2umJ/Us6kbGeTUzglLcNST7GYu7MRfCDTaEv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PbVBC91A; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PbVBC91A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCeyK+gG6C4uZh21VzXQtN4a5TJ2qOlNeVK/i+fBMPNPI4UHjDyCCS7yb7H8cmt7gD35DlfhUO7SxhM64Dfk2eNnJ+F1vSjFdIgFWpLyYQlPk+W6qk1QsjZwXasZJXTq1UxCF34cKrhiWMwyDC9zUUYLNk8ZB8mKmQJSd4KcB7pzTa2bziJIJATHdGRFe1X2nmevBZfi7GQLeWSKEYmRnAQLTnzN7NQQWGbJiaMouZwddx5yV3HChabnwcqpyVfZ5u8pXvGI7s+aHkLOKhYhWr+UQAwGGzqExGKknSyJYA+hGEo+hnIqIOg7TuXz8Z+2x/YZZmHmIeU8+f1Wg4/6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUR25Aivq59dSAy+fBCeWfrUHJies+JPO7t6YjeMntQ=;
 b=PM/ATpKek3e491hSGjsfRe7JjmXN2ZFcDNZtB2Le97Xd1MrbQliidnlN3Vi+FqW3bJkJ5rUom6tAAdWGY8lQ5iyg4iU8+D9sh6GG0ByrDqUEcBcxhSPYs++xpMt6dhFnoa2md8nOSqNgWABhopTUk0/lX+p3qJg8wAbU+/nbPZx4B1Tm/kfsckY1AgwM9bCQzhckiBUidTqoP10QmmpIBiF3zsW3D89QaCSIkQGdI6IwixJf90bj6YZTcpbYzUVoj+lBYy73KhYK0oX6GGYeGRMDRSW+KDmzWGrePBOFcB9pc0NnPzJIzzml34rAnqI2ER7JME2zpoLbDOxVotZSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUR25Aivq59dSAy+fBCeWfrUHJies+JPO7t6YjeMntQ=;
 b=PbVBC91APpsqLW2BvMX87zi+OGYNqGiHHv/H7YiIGRVSeWcfhYQhXbZxzNm75j74pdrV4mAXeDpGDCdNq3hzOM+B/pOEKEiAzPcpcqSWY4bakW3znWOFeqWySwbjU7IeW9YbtRow8K46Jrdhd3+GuhpRB60zYZVcUYjJp2SIJJ4VeuUutavF6r4+/7RC0UJP1XXuNww47gUc5Cn/+zMtI4eTpTqCnMLeFxXmtt2X0xzC5i/noeC56oWltIm8kXqesLNwm2B48cTfX/2wFGY9QWF4WQ9SZJknAqFYw1BnvWoWW66TTzesKo5NtdWBjjDcnnUfyKCwqWhaGQQWaYudOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:36:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:36:09 +0000
Message-ID: <e6caf0a7-8a76-48dd-a523-3c6fcf8fbf3b@siemens.com>
Date: Tue, 11 Aug 2026 09:36:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5p2O5bCP5a6B?=
 <lixiaoning@sinsegye.com.cn>, =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
 <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
 <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.016f3d46.7d4b.4b85.be4a.b6c524f3b5d7@feishu.cn>
 <b1da1fc4a8a4e44d3b398ef4d514bdb738f0598d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b1da1fc4a8a4e44d3b398ef4d514bdb738f0598d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 75da4702-b20a-4627-899b-08def77b361f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	iZphrg8ZIXZDWB53slJ5LOOQact0Uc2iKySpQlWhaaovAJGyNP0Yo0XaHfJoTfvBBkGhwYKK+jtOINGUjSuNfFnRGipPFk0n/j4ghKIxMBYRnSt3zAkW9fn1hZwxmfXRrgA0BlfQSuqEZUiSCBhiBipwPUUKe+i5gaSivzdJZh5f7L5J0CDhy/ZqBxB7CpVn326mw/JVT7aE5NQlMzurmubTIjA+gSaRf6llIbQMn83Bm5FI7xdFFqayD7+auzwSFlS0GQ/T5ON32G0FtAYg8UVC5iiuYUp6Fbuv/odyaC3MbFTUXGgbLgotnHNcGa0/8lDWHsVK/ws6kfT9g2lgZpoxscFHgmDYFM+RnVsfqv/3jS0SJDOUkwYCjk+zsXO4OcYOqgMTE+zA+SIW9g0UEWo6QF6pemtxdZHjcAZrTz8DkZ59OxP0XrljRPLBrSvKiEJnPoOBLnqU0mblJFmx00RpmJJn0069+emOSMBuhC3pbCpVAXwkL7NP3UrV56sYopw6bAGAfQL8l5nrybjH0AL56Kr0qCOqMW1myYsA1uvTTt9MvI/tOKi9aNPPGlQ7bBtDSSBt6P/pW5+SJJGplOhfTZ3z2wSdgY94oWhgB4Cuj5cChvzApjf3vNZSnrdmigEEWMKQkvyGIp+SjgJHfsWjiySHWOEFXAld9l7xGjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2NJMWxvMmZtWWdKSysyUVB1WmlZcFArK3FrYjQrSThvb29ISmtnSHYrRW1Q?=
 =?utf-8?B?dmtRbFQxZmtKaGZyMHNzNjh5UEI2ZDN2VDM1T21GMG5jSVd2NXg3UnZuemNo?=
 =?utf-8?B?d292aEs4OVpFQ0JUV0Y1TzZWZFZqYVB2OTBZMUxSYVNrUUVTZ3dlRW1ycWdq?=
 =?utf-8?B?bEhNT1JWYVU5Q2Fwd0tFUW9ZOG9zbjBHalVPMkxuTFRjamdiMHBFaUg5bGN6?=
 =?utf-8?B?WUZibFlzVzdzUnhwQUkwYlVQNEcwL1h2VkRGVFMwWS9aQXdHeWMxMkhQZVYr?=
 =?utf-8?B?QndMUHc4TC9VZmx4Qk1VQzRpQWtQdlFWVzNJVFRmaC9rRFdxS0t4UUNDenND?=
 =?utf-8?B?TDE5ay94TXFMYkpubFZKU0daWm9jUlRLYmI3SHk1b1FNVmJrdFFDeExOL3VX?=
 =?utf-8?B?VnhJaTBGcjM5c0tsVi9kdjRGRjE5eU1VUDAzd1lqRmJNRCtRZFpzN3UwNEV3?=
 =?utf-8?B?YjYrN1Z1Y0szbjJlMGR4ZlRxZVd4ZGlNSEJNWEFPWXltVzhxWVNmaElDcm9y?=
 =?utf-8?B?OFlvbnVBRTByTktCUXR3MXpEeWhjNW9PVGs4ME9uS1I1RjlJZkRlUVE0TFJ6?=
 =?utf-8?B?bFFTQTNLY2NySUZyak96aE5IT3JMZ3RtcVZUT3Y1YlpQVTBMbDlUaXRZblBO?=
 =?utf-8?B?MWk1Y2FOMzNZS3NBNVM5a2NaOVhkeDJjOVBjeHgrZThmdzBoR3RMbVh6dUlD?=
 =?utf-8?B?Mjk2NnZBY3FURlFZNkw0dW1CdnNLVlZJYVRuSjRacERXRGpxcDVEbVhteUNF?=
 =?utf-8?B?OVRuWGZDZHJmdEEvM1JGam1VZHVwSzAzZFh0L3ByblFKankxaXJWeDdqWjlS?=
 =?utf-8?B?TTRMODhlMWdkZ2ppSDVPYi9jNHdvZklJRUYrR0pwbXdtTEZweGJ0UDJISTQ1?=
 =?utf-8?B?VDRhSmV2dmlscklya3NWYTRzQzZhUU9icDlMb3hOUkdaR0JyQVpnNW9lQ2tH?=
 =?utf-8?B?TG12Wk5ISVZkSk1DT3c2dHJZRC84akZkOE1oMW5pbUtBSkdQNng2WDg2bGpZ?=
 =?utf-8?B?c3MzdFJsb2djdTRZTjNDRHJzTDBZWkNVckw2WGRBZk93RmxSWVBKTlpzbEVS?=
 =?utf-8?B?WTFUcTBVYXp3dXl0UTJzWGVWRnZReE03eXdDQXNnS1M5RnhEdGI2Sm50aUFq?=
 =?utf-8?B?VWJDSjBqNmVuRWdTYWpTZU9XNTY5VXBwN0ZtaWV3Rjc5OWRiejRoQVhLS2lF?=
 =?utf-8?B?UlczVWFCWEc4bWY0OHNjT1pBNS9KdDZMMXhJbGE4SnYvcmRmbU53cVQ4WFMr?=
 =?utf-8?B?S2htNG9lc1VSR1N1VGZONjdpZXovU0VMUm5oaC9Ea2piYzhqRmduc0FCNVhK?=
 =?utf-8?B?bFhteEUrWDhVT1p2RVRrakpSS1NFRlpqK0d0RkpGRi81NnZscGFvOHFKcXRI?=
 =?utf-8?B?MlN5OVBaTVRvekRzOXliMFZ1aytXQlpVUnVUMk9mZWwwQXhiR3Y0N01PdHU4?=
 =?utf-8?B?My95YVZhMHMwN3BLaGhqK2Y4RmJ2anpLWVNyellGUVZ0dzBnM2h6NkV6cDNC?=
 =?utf-8?B?R0xnRXR2NE8zRlhndEJzQ0xSY3ZKZXhadU5mMUVwbEwxTGllQy9BeFpTalYr?=
 =?utf-8?B?em8vZ1ZwVEl6ajd5c0g5THFxaURvcHBuSGZoNkh3RWhwQkFKMEF4Vy9CdHgy?=
 =?utf-8?B?QURrbVRQa1dUUy9aUXZTL2Z5TjNnYll4UldGQWJqbktrUDVZS3FLSTdCbFRi?=
 =?utf-8?B?UHhBaTJmZ0NRSngybGlXaThoQWRhZ1JXZFFCYTI4UnB3dUZHYWkxcGpGUzlJ?=
 =?utf-8?B?RmlXK09PVzZUbi9kQk5kWWJoQXZVWlBobVpkSXRYVkdJcjF1RVhBRDAyc095?=
 =?utf-8?B?Mkl0NFNsTEFrQjJxRVRnQkZwdEhvUzZRNU9JeUxqQXlzK1pQaXZ6Z0hJRmZq?=
 =?utf-8?B?Mm11aDRwS29qN2JqSWVURWo0RHM1OXVENFhBZmVmZFZtUzQzMVAwdi93MXdT?=
 =?utf-8?B?L2dPMjNVRXI2QllGdWt0RXdVbUg1VDNmUnhQNUtpRzFrb0FkSlhxMDZxNnE2?=
 =?utf-8?B?T3FWMzJ4WFAvcFd0TUQ1elFBMWEwcXpVbGg4L2hGS3paV2Q0MUsxcGFLdmFv?=
 =?utf-8?B?UHBXL3JzL0szcUZJSk5vUnVsWUFRSUVPYUxmRi9iSGlnOENTKzdNSUxrZDZJ?=
 =?utf-8?B?MWN5Z1huajhlb3EyNm9scXFxZndaSEdTMnpkZlhPZGNEaWxzRXJ6NS8zS2ls?=
 =?utf-8?B?NU5mL0V4UVBDdGNKT0l4MlBBSG50ejBsMjg3V0VzNFRkUTRxVGR5MkNRaEhC?=
 =?utf-8?B?ZUJjdHlrMkloc2dFT3ZndE9aVUgrMlhYQ3d2Qm94NWpUTy9nbUVRaDJkVGVT?=
 =?utf-8?B?S2FsRTk5RUpyNEdvT0hOdHhSY09mZlJjK1M2S2c3UzJkbmV4cUkwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75da4702-b20a-4627-899b-08def77b361f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:36:09.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM8gEmcBn+ggkCilA2pjlB1r+Q+o6RFL8yAeUYe6A2AyU1pxk/dygAvBFb2hUJuy6fIOrrsLbStgpync6M81qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5404

On 11.08.26 09:19, Florian Bezdeka wrote:
> On Tue, 2026-08-11 at 10:17 +0800, 刘杨 wrote:
>> Hi,
>> We captured the following on the serial console during an RCU stall. CPU 4 was interrupted in the idle/nohz path and spun on the timer lock inside the thermal handler:
>>
>> [ 2205.999617] Sending NMI from CPU 8 to CPUs 4:
>> [ 2205.999619] NMI backtrace for cpu 4
>> [ 2205.999620] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G     U  W  OE      6.12.90-13-rkernel-cip24-x64-industry #metaOS
>> [ 2205.999621] Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [ 2205.999622] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS SP80000020260708B 07/08/2026
>> [ 2205.999622] IRQ stage: Linux
>> [ 2205.999623] RIP: 0010:native_queued_spin_lock_slowpath+0x78/0x380
>> [ 2205.999625] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 30 e4 09 d0 a9 00 01 ff ff 75 5c 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
>> [ 2205.999626] RSP: 0018:ffffb065802dce38 EFLAGS: 00000002
>> [ 2205.999627] RAX: 0000000000000001 RBX: ffff9334dfaaa428 RCX: 0000000000000000
>> [ 2205.999627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9334dfa53580
>> [ 2205.999628] RBP: ffffb065802dce58 R08: 0000000000000001 R09: 0000000000000000
>> [ 2205.999629] R10: 0000000000000000 R11: ffffb065802dcff8 R12: ffff9334dfa53580
>> [ 2205.999629] R13: 0000000000000000 R14: 0000000029f00004 R15: ffff9334dfa53580
>> [ 2205.999630] FS:  0000000000000000(0000) GS:ffff9334dfa00000(0000) knlGS:0000000000000000
>> [ 2205.999631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 2205.999631] CR2: 00007f56540d1b68 CR3: 00000001637a8005 CR4: 0000000000772ef0
>> [ 2205.999632] PKRU: 55555554
>> [ 2205.999633] Call Trace:
>> [ 2205.999633]  <IRQ>
>> [ 2205.999634]  do_raw_spin_lock+0xbe/0xd0
>> [ 2205.999636]  _raw_spin_lock_irqsave+0x59/0x70
>> [ 2205.999638]  ? lock_timer_base+0x7b/0xa0
>> [ 2205.999641]  lock_timer_base+0x7b/0xa0
>> [ 2205.999643]  add_timer_on+0x70/0x140
>> [ 2205.999646]  __queue_delayed_work+0xac/0x110
>> [ 2205.999648]  queue_delayed_work_on+0x94/0xb0
>> [ 2205.999650]  therm_throt_process+0x164/0x180
>> [ 2205.999653]  intel_thermal_interrupt+0x12b/0x350
>> [ 2205.999655]  __sysvec_thermal+0x46/0x180
>> [ 2205.999658]  sysvec_thermal+0x9f/0xc0
>> [ 2205.999660]  </IRQ>
>> [ 2205.999660]  <TASK>
>> [ 2205.999661]  asm_sysvec_thermal+0x1f/0x30
>> [ 2205.999663] RIP: 0010:_raw_spin_unlock+0x0/0x50
>> [ 2205.999665] Code: 01 00 00 00 31 c9 ba 01 00 00 00 31 f6 41 bc 01 00 00 00 e8 32 04 2c ff 58 48 8d 65 f0 44 89 e0 5b 41 5c 5d c3 0f 1f 44 00 00 <f3> 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 c7 18
>> [ 2205.999666] RSP: 0018:ffffb065801c3e00 EFLAGS: 00000246
>> [ 2205.999666] RAX: 0000000000000001 RBX: 0000000100161a47 RCX: 0000000000000001
>> [ 2205.999667] RDX: 0000000000000004 RSI: ffffffff90217c1e RDI: ffff9334dfa54840
>> [ 2205.999668] RBP: ffffb065801c3e58 R08: 0000000000000001 R09: 0000000000000000
>> [ 2205.999668] R10: 0000000000000001 R11: 0000000000000c2c R12: ffff9334dfa53580
>> [ 2205.999669] R13: ffff9334dfa54840 R14: 00000197236c7580 R15: ffffb065801c3e7f
>> [ 2205.999672]  ? __get_next_timer_interrupt+0x132/0x380
>> [ 2205.999676]  timer_base_try_to_set_idle+0x17/0x30
>> [ 2205.999678]  tick_nohz_stop_tick+0x70/0x370
>> [ 2205.999681]  tick_nohz_idle_stop_tick+0x72/0xd0
>> [ 2205.999683]  do_idle+0xb8/0x150
>> [ 2205.999685]  cpu_startup_entry+0x30/0x40
>> [ 2205.999688]  start_secondary+0x10e/0x130
>> [ 2205.999690]  common_startup_64+0x13e/0x141
>> [ 2205.999694]  </TASK>
>>
>> We addressed this with a local kernel patch, and the issue no longer reproduces on our side after applying it.
>> Could you please review whether this change is correct and acceptable upstream?
>>
>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> index 1b9264e5b..bbd20cfe2 100644
>> --- a/arch/x86/include/asm/idtentry.h
>> +++ b/arch/x86/include/asm/idtentry.h
>> @@ -803,7 +803,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,              sysvec_deferred_error);
>>  # endif
>>
>>  # ifdef CONFIG_X86_THERMAL_VECTOR
>> -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,           sysvec_thermal);
>> +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,         sysvec_thermal);
>>  # else
>>  # define fred_sysvec_thermal                           NULL
>>  # endif
>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>> index aecdb2d02..c432c22ed 100644
>> --- a/arch/x86/kernel/irq.c
>> +++ b/arch/x86/kernel/irq.c
>> @@ -605,7 +605,8 @@ static void smp_thermal_vector(void)
>>                        smp_processor_id());
>>  }
>>
>> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
>> +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
>> +                                 sysvec_thermal)
>>  {
>>         trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
>>         inc_irq_stat(irq_thermal_count);
>> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
>> index 8c9d587bf..c7ade9c2c 100644
>> --- a/arch/x86/kernel/irq_pipeline.c
>> +++ b/arch/x86/kernel/irq_pipeline.c
>> @@ -164,6 +164,11 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>>                 run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
>>                                         regs);
>>                 break;
>> +#ifdef CONFIG_X86_THERMAL_VECTOR
>> +       case THERMAL_APIC_VECTOR:
>> +               run_sysvec_on_irqstack_cond(__sysvec_thermal, regs);
>> +               break;
>> +#endif
>>         default:
>>                 printk_once(KERN_ERR "irq_pipeline: unexpected event"
>>                         " on vector #%.2x (irq=%u)", vector, irq);
>>
> 
> Yes, the THERMAL_APIC_VECTOR implementation has a pipelining problem.
> 
> Main question: Should the event handling take place in-band (Linux) or
> out-of-band (cobalt/evl)?
> 
> You selected the first option, which looks sane to me. You now delay the
> handling to the in-band stage.

It's rather unlikely that there will be any oob handler for the thermal
thing.

At the same time, the occurrence of a thermal event is very likely
already a problem of its own (which does not mean we should not fix its
handling). Is your system overheated? Will it possibly die soon when you
continue like that? At least, it may go into thermal throttling, and
that will not make your RT workload happier.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
