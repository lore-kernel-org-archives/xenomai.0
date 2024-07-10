Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49A54FAD
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592004; cv=fail; b=quH+Rf2NsDX5PvMPVMFp41I2rUelq+E017B5j9n7YBkx8galAduJZLNo/paUNkfOAf/XFxsNDPXVVLhAXANR8WAy4cvFuWSNWCvj2ddWjO229DESRvD63C0Z7KAxj8en8PwAr+S0U4djCgtsYyNIeGWxS8ggiiV2BQZPLSZYY/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592004; c=relaxed/simple;
	bh=ItA7urrsLoQga7HnwfS+B7KdHQPPVKJyzlzJZT2yyzI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k0tlMDCrLFJ2JHmlZPwWU+82SBgX8PX/fq0OUNXFjibE4EunbJZPbDm9JdIUJmXKqViEIBndl3OS8n1BhVENylq1JQpBMeiYb0Kd/JlheQcTAPSDyT6EfTM5tbrWwM6Px8+d0cDqth2SO6uFIcq/PGXOyaxWaC2O/uLgDmjVy5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o749Aaor; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o749Aaor"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWhyCsapjP7+e6G02sUiJqRh0wHVQwbj5/wu76Y6zkPA/LPCONn8WETLqyDYA2CBFeYy2xzcwgxi/RGxjFNvkQiyvepJ2lOoEHkp7jGi2fIvZOJ7w8mBFWpxfw0qZPbLc09HIirpM/cCCXAzwlDc5akvAFYL9jS0SBhicPX6qoUz4OLcnwe3vOzIz1auEYJVB7o51iBHOiwLJHb2H0DDgfnV/z7hmI49Ru4Q/n8e75VUrD7YOSJN0S6sxEBSlp4h3vM2i+xvp7xPjvOcmxxrzskL/bjUtvff9MEM3JaugCgWH+N6EzpZIYfYmwA/y0If8isouryGIC133Tfw2SNF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRCAQvnjOe33tkpBo5OyA9qVRyCexhbQL5WSF5qdfGE=;
 b=COQwey9eVsmSTJj2vh9vNrwiueGg6Lwi3RbsQDOU63I6Qy1wq6dyUJSJq2qw/Msz3XE53/B92YTghQUYHeeulzHF0Tc4gUTRrWCwMTAKITUtDvjbMsscXGRABoRIZrHVpCqr0HYHi84MjVSwhcgLIu8qsVPkqYXy7vp5GoyHA3NFNPh4E6TkhenP54Qnhn0IeHhPTeqU5dX8QNcs1dJE8vHPl4q8FPO5/RBk6CuHNpifX6nvcgAZBsuufgCjCOOQJ3MrWY1X8ng3xVnd3/qB7gAxyUIZ2fpKmtmFx8c76+9qJ9RfSGO/Lih77aKE50fjMY8vPJQrrMlVCfQ2Yr0ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRCAQvnjOe33tkpBo5OyA9qVRyCexhbQL5WSF5qdfGE=;
 b=o749AaorshCo/VED7/N/v6AyqzqQzU/xkZNLYIztALfpGjnHRf+krTFqknH1j6Wo1YZRUUcSNoZd6vEeIYdzeQ24TgcaWyADQwCokAh40+SCls3QNnHwTixKK7XksW5vBN6kYH5wrU9fUp/74JEn+223dUnquq4pLmzHKA0c9tjHt5Fm6eRs2j/oTGQePlV5X6jzAG0mX7ac+ndR8HP79ebMmyYRUn+pYJ8wwxR3yiR0liQ6jLO9H1S0CbXSLbL4xoyroDU3acHIG5jtjqUt92aZluPKTazak5O2RoyRTEuuU76S6DLjxkr7nsi19VCuBjJ0dA9/0CrI0aZvPciK1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU2PR10MB7742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 06:13:17 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 06:13:17 +0000
Message-ID: <6d9e0919-9d8d-4cc0-a1a5-653dc35c7448@siemens.com>
Date: Wed, 10 Jul 2024 08:13:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ci: Add latency treshold to longterm tests
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
 <20240709083524.739194-6-tobias.schaffner@siemens.com>
 <1249dde7-39ab-4410-a114-d811da4f8cd9@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <1249dde7-39ab-4410-a114-d811da4f8cd9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU2PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: a3871912-6f28-46c3-6f45-08dca0a763c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVnTWlRckQ0WnkvWGI1V2dCM0ZyYmZncHNWdFphZklPS2VqOW9aVWZzaFFF?=
 =?utf-8?B?ZkR4QTU0aHhEMnlIdmM3Znh2Q2VXMWVueU9FVHRieGtkQ3BTaml2WmdLOExj?=
 =?utf-8?B?UkN3VHhwcmhjVzllT2Q5bElYVElRMnBIbTdoZEk2NjUyQkRnMHNHTHZaYWE0?=
 =?utf-8?B?Vk80eTFtNkhPUFhIcWhuVFpnbkdPK0dDeTFFWno2UFkxd1VPcVRwWSsyTFpT?=
 =?utf-8?B?UTFjNzRjZWxHVU90M0V4UTNpT3FzbTRQalIvcUFpbEdzTW9wSEVPKzFXK29Y?=
 =?utf-8?B?ejhBbU0wbUJvZG42U1pweHd5SEZzZ2FNU3dqeDBiQjRKRW8vQ2dIa2NVTjhs?=
 =?utf-8?B?TE1QSm1VcnVZZUxrTDR1b1JmVTg3cERrYVdxU0hRcGN0cEVVUXplNHVBVkd4?=
 =?utf-8?B?WVRDWWIvOXJPaEtPaUJ1RTFkbHpqai9FaXJmaWc1RC83Yi9oTW1PMU96eEFO?=
 =?utf-8?B?WExHYngwbDF0N1FtSHNScGMwaGQrZmNLc0JwVlczS2c2ak1sb2UvNlpIMFZU?=
 =?utf-8?B?UjZkbEtjNE5LbUJER1I4UFBxNEc3YmtxWjVxT1RwL2hSbC9uN3FiY3lpZGdU?=
 =?utf-8?B?bVBCRWkvOXQrNlJWeERiRVc3SThPWXhOWThOWHVPaHQ4SlNBdkRrMC9QWTcr?=
 =?utf-8?B?aFpuRmJpNUltWkdCUy9SQVR1cCtxazQvdzFhYkRtTGxyY0s1LytWUlU2YmZr?=
 =?utf-8?B?RWdvWHBjUWplbkY2TW5YeDJod09YYlRDNHpIN21XWkNQTUxVSDdhN09Zc20v?=
 =?utf-8?B?ZGdtZlgwQWhZSXlrQW1LSVoxa2FCUTZoaTJBd0ZvTlhqd0hCQkhGQ05tZ2Zt?=
 =?utf-8?B?Zi9FR3NGYnJrdUZNdURJaTZpb3VIMUxvQW1LbG9vWWdmL25vS3NjOFNOeCtZ?=
 =?utf-8?B?ZE1uT1NTMUh5WG9jRDcrczl3d0NsN1U5WmdZdUtlR1JnbTdEZVZWZ09ZWDhv?=
 =?utf-8?B?YUE3MGNPOHorNE9LaHZIU0hxWVByVVNoL2ZRaklFUEJmeFFBK1ZjZ1l2L3dE?=
 =?utf-8?B?V1Yzeis5ZUpvdTFVMFBUU0hNV3prcmpuR0dxVm5xcmNXYjZJb0F5TkZEQjhW?=
 =?utf-8?B?V1ZtZ0pnS2Jmb0RoYkZ5TnBKRmlaOStvY2xLNGVsc25ESmx3RU5JclZBcUQv?=
 =?utf-8?B?QkltQlgwaGErbDgwKzFqQ2ZubGticjNQd21KQ1BkUGdnc3BwTXlGZTdIdXgx?=
 =?utf-8?B?ODNUWWVBejVheGxSeE56WDk0NUMvUEhWeFB1UjI5VVRNSkx1VDJYK3FiWlpM?=
 =?utf-8?B?dG1lY2FGU2o4N3lQdDYyRE4vREgrNVlmK1NNeGFCd0lLQStMbFhCVER4cFlS?=
 =?utf-8?B?bFM3anA5ZjRwM0g3TTJGaVJKdmhGRTREK3ExMThsOHVkUWlPWEs0b1hxWFpv?=
 =?utf-8?B?RHVQbnR0d2pMNkUyREZOb0FFRnE4ZkVmL0poa2luSGhRaE1FRi9zZHpncXpm?=
 =?utf-8?B?UFZIL3RKaDF0SEpYM3BOMkQzWlZDUHZDaGxBOUM5MHlaQm00dWJsSlJKOHBv?=
 =?utf-8?B?WEJSck5WMlpDaDNxdjcwMUhFUVU4TUU1Y29zVkJsa0wxWVp4OHo2Z29JMXlr?=
 =?utf-8?B?ZWpWaTBwODNVRlg0ZGZFc3hhd1JaR1VEbDlLbUJJRFFvSDliaWI2OElyTGpP?=
 =?utf-8?B?Y0xMdWlOUEcwY3BPMStoWjNMOWpnUGhqTVN6dGpPNEZHNGpwR2J6Yy9tVTBR?=
 =?utf-8?B?MFQ0RUNzeVY1OWJSai82S1BheU5VTzYybk1Ga1RkT1RVV1VNZHhtTStsVWgy?=
 =?utf-8?Q?ia3Eeoo6c8ZCprT1qA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXkyTDlFVmV0dDFtTUFzc2VWdWpmYTh3NTdGQmxxb2EyTGdlRG5sTUMvRlVW?=
 =?utf-8?B?Sk1OSEZ3eGhyd29ucGhkcUZuSGFSTW8wQlZWT1JWcmx5WXZTUzZaMFNSWEJp?=
 =?utf-8?B?MDRZbDcxTUdIL3ZacHBTVHQ1Z0E3aTk3UlROeEVkT0l3b3ljSHA4Q1ZmM3ZX?=
 =?utf-8?B?Lzk3Ym5raFdXdWt2UGNnU2JWQzFIeVpKK0VSSjhyeXZ1a05kanRTWHpucTJm?=
 =?utf-8?B?K3EraXpEdFFwd3N3ak4ybGNrRVkvUnJTNTlQNGdNTUV0YW12a3hSbXh2VjJH?=
 =?utf-8?B?MEpIRFA5RnJkMGNaUC9vWW5DKzVKa1JYaWQ0ek1DVlZzT0ROU1QzcEhVWGdT?=
 =?utf-8?B?Z3FBRVRINHNZL2hxVEx6Z2VEWHpFSTdqQXlSSHBRWGkyVTNJVTdCdlBHK3F6?=
 =?utf-8?B?Tjd1QVpXTVdPTTVYdWlKL2pWSEdRWktxOUhlWi81QlFwTWdCcm5RZWhrSU85?=
 =?utf-8?B?NE1vanpQQ0hjV3VKYWZsRG9yb3ZqUFU1QTA5QWlwSlJGaExaZlE3WGNhNGxG?=
 =?utf-8?B?UjVQL2w1VWJWcWVlNmxWNjViL1lpYUtEbnRyZjYzdUFVTDlaS25Ub3NodW5F?=
 =?utf-8?B?YWx4eHRibERLZnRsazhERjVBeWFKTElaL09NMG5Kclk4QTlHTXVmZno3ckF5?=
 =?utf-8?B?cUFlSG5zYW5jWkJzYnllcUpacXA5em5VZHdBd1QxRmdhRS9QdzJaR3hYSm5Y?=
 =?utf-8?B?bmxpSU5qckdxcGloZlpIdDBsdXVJVkVSaFVUUDROdHF2T3lqYkt0cXFDSWRi?=
 =?utf-8?B?blBvSk92eHoxRVJFZUxPMkNlUXkxb0oxUlkzVGZZYVBLRWxTSmZJdVhNNVFa?=
 =?utf-8?B?a09PVG13NDJtTzZjMlpLc0lhU2R0OEEyTm5sQVpncnd3bjBVVTc4ejNHWVE1?=
 =?utf-8?B?WmdjdGtVTnhQcXhvS0lqNjMySXIzaFFaTHlkZlFiMnZPTno5SkpBL0xBS01p?=
 =?utf-8?B?UlhER0pkbkJuRVZyQ2E3TkQwRndkVnZLbXpVMVZFRVBJVjZsQUNMQ1FNT1NU?=
 =?utf-8?B?NFJodUhWbW9vSDJDTzd6UmU5RS9iWGo0TW1rbEh5S1l1UGlWTTljYU5NdDlT?=
 =?utf-8?B?R3FlSEg4dUlQRERCMDVrYTRFdHRvOEJIK0JDVEFOaDFFZm50emd2QUNwUGhK?=
 =?utf-8?B?QUJOOVJhZVRSL2NQcG5zQ2JhdUFrZEkyeHZ2WFZlcUtWKzBTM2s4bnRleDZE?=
 =?utf-8?B?VkFLVzloM09MbktXdFpPY0x0V3hObnIrZlFtNElBK3NZamNqNWYzbldGdk16?=
 =?utf-8?B?VHJ4bDdYNGJVRGw4NjEwNjhmWFNtSVJ1UGlyNmN3cWZUdUNnNFJqRjhGa2Vo?=
 =?utf-8?B?UEVIZDJsUnRBRTJ2cXNLaGdFL2d2MVhUS1RtV1F2Y1FmSmNweHU1NkNvdEww?=
 =?utf-8?B?WDVKYVVBczdnYXora3RoVVljS0ZhSGcxYjFtM01RUVF0SGZOVmVTN3llYXp2?=
 =?utf-8?B?aUUxdWNlR0N0TGdYa2pnSEtkS1c5cmI3dXJ0ZjBvRC9HOHRGNHZ0U1dEUTk4?=
 =?utf-8?B?MFkrSHdNcjNzQmFxeC9zMFp4UTJWdkFNa0I3bTdsWC9hUFNNTjlENWdueHd1?=
 =?utf-8?B?NmFORmRjK1NPOHRmUUFPQmZtUWN5TDZTeDZuRjRFV0RqYmhVdkUwcm9UTDNN?=
 =?utf-8?B?b3hQZjFYOGZWNVJlRGMzRW1GUzhQdEMwclBKc0xxaVNNWDgxRVRxeTR2ZndI?=
 =?utf-8?B?TkNSOGtLMHI5VVU2V2NKdjFTY2orbVlhZEZ2anJ3U2pSSFZudjlFb1MrcW1a?=
 =?utf-8?B?RndzUEdYQ3dzMGJUNWYvbUFKdUtESzNFYTh5OGk0WnFDUGNNcnhJNWFpY0xV?=
 =?utf-8?B?Sm1XWUtxbTZCWWlVb0g3SUhqeHZLY2oyQStVQ1M5RTRxRjhCcGxXZjZsa3lE?=
 =?utf-8?B?QXUzb25KaE91OS9takw2NUFtUkg1MUlMbmZaMWRlR1pDMDVqaUlCNXFzYTVY?=
 =?utf-8?B?dE1UVlhaL0xKZWRPUFRoTGNKY29uYVp5cHhZM1pGYkFuTGFNampVNlVOaEhI?=
 =?utf-8?B?a0w4NXFSbUZvdk42SzRoRGJXbFQ2VFhmVjZNc0VnQWt6QnpjRklmMDB5cEdS?=
 =?utf-8?B?MEw4MkRhU0FWeWR3YnU4SWRYNHQ1TVQrL3g5akVGVEUwYjdRYkcrTm9YbTdh?=
 =?utf-8?B?V1JvWTVjb0hlTFdxRG5lM25UL2FUdDhMMEhRbHlpaTBBNkhUVllvTnFZWjgx?=
 =?utf-8?B?MnR1eThGMjRGdzZ0dU9lbXQzTlBnSW5kSEVkbExublZHR3lwSW51dWc5anRI?=
 =?utf-8?B?ajhxa3RsalVMZlNSNFJRZjNWcEhBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3871912-6f28-46c3-6f45-08dca0a763c6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 06:13:17.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxHvH0bHsT3+E/hddtNJZ08YjV7TSoCd8UcMmhfoe+b42z2OMCgESzpgIoP9Dbb0M4+ElOFOj9/wT8R5NnBJ2YSTGaUFtH554JCdlnKP4kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7742

Hi!

On 10.07.24 06:45, Jan Kiszka wrote:
> On 09.07.24 10:35, Tobias Schaffner wrote:
>> Add the latency treshold patch to next builds as long as it is not
>> merged. Use the new treshold option in longterm tests to guarantee a
>> worst case latency of 100us.
>>
> 
> This threshold should rather be per device: 100 µs might be tough for
> low-end ARM devices while it is not really a challenge for
> high-performance x86 machines.

Good idea.

>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ci/xenomai_3_next_long_term.yml               |  2 +-
>>   ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
>>   recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
>>   3 files changed, 79 insertions(+), 2 deletions(-)
>>   create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
>>
>> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
>> index 0edaca5..d5a93a7 100644
>> --- a/ci/xenomai_3_next_long_term.yml
>> +++ b/ci/xenomai_3_next_long_term.yml
>> @@ -17,5 +17,5 @@ variables:
>>     XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
>>     XENOMAI_VERSION: "next"
>>     LATEST_KERNEL_VERSION: "6.6"
>> -  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600"
>> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600 -m 100"
>>     TEST_TIMEOUT_MINUTES: 80
>> diff --git a/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
>> new file mode 100644
>> index 0000000..6adb7d8
>> --- /dev/null
>> +++ b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
>> @@ -0,0 +1,76 @@
>> +From 032a29ccb649cc2d076f14e7769bdee8eba8ecfe Mon Sep 17 00:00:00 2001
>> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
>> +Date: Fri, 21 Jun 2024 09:35:08 +0200
>> +Subject: [PATCH] testsuite: add latency treshold option to latency test
> 
> "threshold"
> 
> But I haven't seen this patch on the list yet? Why should we carry a
> Xenomai patch in xenomai-images?

It was posted on 21st of June:
https://lore.kernel.org/xenomai/20240621085547.2088976-1-tobias.schaffner@siemens.com/T/#u

Of course this should not be carried in xenomai-images but dropped as 
soon as it is merged.

> Jan
> 
>> +
>> +Add an -m option that allows to set a maximum latency treshhold to the
>> +latency test.
>> +
>> +If the option is used, the test will fail if the maximum measured
>> +latency is larger than the treshold passed in microseconds.
>> +
>> +This is mainly implemented for CI long term latency tests to
>> +automatically let the pipeline fail if the measured latency is higher
>> +than expected.
>> +
>> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> +---
>> + testsuite/latency/latency.c | 14 +++++++++++++-
>> + 1 file changed, 13 insertions(+), 1 deletion(-)
>> +
>> +diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
>> +index 7856b48b8..52e315d9d 100644
>> +--- a/testsuite/latency/latency.c
>> ++++ b/testsuite/latency/latency.c
>> +@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
>> + char *do_gnuplot = NULL;
>> + int do_histogram = 0, do_stats = 0, finished = 0;
>> + int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
>> ++int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
>> +
>> + #define need_histo() (do_histogram || do_stats || do_gnuplot)
>> +
>> +@@ -536,6 +537,12 @@ static void cleanup(void)
>> + 	if (histogram_min)
>> + 		free(histogram_min);
>> +
>> ++	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
> 
> Overlong line, I suspect.

Looks to me like the max line length is 100 chars in this file. Please 
feel free to ping me on the original patch if this needs a change.

>> ++		printf("\nMaximum latency exceeded: %11.3f > %d\n",
>> ++		       (double)gmaxjitter / 1000, max_latency_treshold);
>> ++		exit(1);
>> ++	}
>> ++
>> + 	exit(0);
>> + }
>> +
>> +@@ -614,6 +621,7 @@ void application_usage(void)
>> + 		"-c <cpu>                        pin measuring task down to given CPU\n"
>> + 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
>> + 		"-b                              break upon mode switch\n"
>> ++		"-m <max>                        fail if the maximum latency is larger than max\n"
>> + 		);
>> + }
>> +
>> +@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
>> + 	cpu_set_t cpus;
>> + 	sigset_t mask;
>> +
>> +-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
>> ++	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
>> + 		switch (c) {
>> + 		case 'g':
>> + 			do_gnuplot = strdup(optarg);
>> +@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
>> + 			stop_upon_switch = 1;
>> + 			break;
>> +
>> ++		case 'm':
>> ++			max_latency_treshold = atoi(optarg);
>> ++			break;
>> ++
>> + 		default:
>> + 			xenomai_usage();
>> + 			exit(2);
>> +--
>> +2.40.1
>> +
>> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
>> index a2e8802..07a63ec 100644
>> --- a/recipes-xenomai/xenomai/xenomai_master.bb
>> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
>> @@ -15,7 +15,8 @@ require xenomai.inc
>>   CHANGELOG_V = "9999-${PV}"
>>   
>>   SRC_URI = " \
>> -    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
>> +    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV} \
>> +    file://0001-testsuite-add-latency-treshold-option-to-latency-tes.patch"
>>   SRCREV = "${AUTOREV}"
>>   
>>   S = "${WORKDIR}/git"
> 
