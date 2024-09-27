Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EA1779BC
	for <xenomai@lists.linux.dev>; Fri, 27 Sep 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444468; cv=fail; b=mLy71bJ6uIealDOiIwPS9DCo266gZ++74gsb2rCqEk+oMUMW717s9gB4JM1Lh64+rQKumXcQFiHRvqI6DV7aKV0DV5gmlmQk4QH68EJn0rObMu/UQ8HN/+eaxPp+49hKRKdsBcIgflmEoHRUPjmB7JhMaPRERq1u1KEl2YYFzfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444468; c=relaxed/simple;
	bh=r06c+Cmj2POTB3HLC9oQO8+21vss/L7wSKFBhdNW5b0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qA/mpSu3OdbCuzO3vjCCmjDHLmw4mieN1hUGKlvLYNnmv+EBLcwXUNftcUNvsmTQWDbVeN2e89eP3DNalh2zPXQ2hC0VMPkL/RP4f/+yiZ4eNC9uZbtRtklB+fkMNsklDNQDrNuhrMix1LxToAUuENcM6M65y7UVi2f9pD3N7c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=d8Q0+mCp; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="d8Q0+mCp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOGEZxJc1c4MBH5rcM2aMOPwXXxVqg2ig+XQF1lUVay37h3sNpP7nbtHOdobrGnzuffyt7YYRt3F1/xPgXnKLMW9FKqT3riPZZGzTOwm3XSXeFngsETm82110f5apbStGqlPD+ZiBERm7N9UtbRMm3Ioa1A8jTla3qZaDfZvfaucYf9pUPAmEGaesPGQ7Qzb5YfCDW4qeWZTP862MIlfydg3OZwNFywuIALd40kryr4gts/VqPtVdLYpLmxGXaA+E/gqTzQypILeGsix2HjzZmRSsXeXvjZ6Tysaarnxy7+SGLXUxjRh+6OqF1P9f3CajAFhi0F7PAgeUTUs0ROHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RluyEqnkaqJ2FNcuuCrMX7+pUp/WLXf0UPEGWX6w9GI=;
 b=eIE05qeSFVioqjNtXSzV4GU3prukzcDlAAC/9CqQ/cCx0mY+DXCM1klT3Z4VGwjYl90jOb1rscF42dUDYSva4+7ck/aI+jMtbFdvB2H94rheRwfNzFNKwGwDxzxTtveM7biBB8BvgkUiGlxYphMceDsO4j+/xQP1RizIiY8IV3dDKy6doUVIuxW34jR+/R+5XzUqsTzSywcO43Em1IZj00vdHSwa6c6E23glh4VdyEVwdDYaftAoe2wvi8n3inWgI6kshyeYooxPdrukXdaGhEukjwx5G6AyDQV1lw2+ttd6Zn6sl9rqIE0mjWSSYYPxKhC/Ho5wE+7orjLro1UuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RluyEqnkaqJ2FNcuuCrMX7+pUp/WLXf0UPEGWX6w9GI=;
 b=d8Q0+mCpNUpvyo4NfiweGIJap7USpd0RVBCC3qCGtJKv96ukuPlLy3OyJ/KMe7lxJzOp3nh5xsccX8U5z4k3/Daa5qZTgWK5PJfwhxX3Fwm2Bgz1QgSLwTywhzONAqJpRu6x9IiHseOh/l9fKHN9vBiBEG4/nyvbEoX7mZ0YkdiIG9zgpr/+Meom0KT3/YcAjXhGYDVCKfBpm8fFmpvxW+eHvn2iDz8xmUvvg08BE54SajbxViHLrsUvF2xMW9cKceGBngTS3dSEa5QVUl2lZPRtK3AWAg80yw+Ck6SRkF4ir125R/lBFzsdQ9O8pdSlrkGD/4ipfe8uOmKOLx+lvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 27 Sep
 2024 13:41:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 13:41:02 +0000
Message-ID: <d3b53281-610b-42d3-8e56-02f5e64838cc@siemens.com>
Date: Fri, 27 Sep 2024 15:41:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: how to add cpu load in testing latency
To: mars_liu <mars_liu2023@163.com>, xenomai <xenomai@lists.linux.dev>
References: <3c07ae1c.6c55.19232479f35.Coremail.mars_liu2023@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3c07ae1c.6c55.19232479f35.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: b71fff14-ecf8-43f2-c8a2-08dcdefa0745
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXpUdFRsaHR5eUdtUmQ0blcwcE5jam55K01nS203Z1hmalo0R1VEKzhqbWQx?=
 =?utf-8?B?N0xYc1MxUHB1VytzOGFZeE9yN1VXLzQrYTZyOEFaY0g5SGtaR2RjUE1rOTdV?=
 =?utf-8?B?enl4SExBM2Z0dmxXMkg5bjZXRWJrZlYweXJGd3M1M1ZrVTBra3JoL3RySTYv?=
 =?utf-8?B?Rk15SUtXYWQ0cHFWZlNUMFk4MEVNWUU2SVJwUHZuUlpaZW9FZzEyVVNRaE1F?=
 =?utf-8?B?M3NKUXBHUjhteHpxYzRXT3MzN2hyU2V3c0hLa0l4L3NhQ3VKcVlKT040Q1RK?=
 =?utf-8?B?Y2Z2NUdEcGFKMlNXS2hBeXNOK0dzbDRiYjM4RWt2REhDTzJuRWNVVExBWWxt?=
 =?utf-8?B?VmgzOThERXRzUXg3R25iQ2VudFRwckRLNkJjSkV3ZnRINjFPYnBVRnV4ZXRB?=
 =?utf-8?B?djlLV3p2M25zNmlqdjFlVFg0TGkyVzNBOHdkVU1KbmNkT1d4ZlZJQ1hZRXg3?=
 =?utf-8?B?dDZwZFZnS2FQSFVOemJrMkNPNHBaSkZaNENVN1VYZDJQblpKRGNkSktEcy94?=
 =?utf-8?B?cmZ3ZnB3NXREaEpnSDBaM0tHR0t5SjVUWWtjK01pZkd6TmRUMnJGbFZFWjRN?=
 =?utf-8?B?Lyt6c1BaM2taKzZYeWNMbHMwRm5ieDkyVXQ2eUpCb2dZZkg2RVYxWFQ2UWYv?=
 =?utf-8?B?OWJiVVYwZXdlQzdEVHFyalNUWWZ5eGpRdktEb2VGa291cmQ2ZlBMMmYvQVVY?=
 =?utf-8?B?eWFxc2xOMC96ZXJDc1FlTEl3blZoWU5hKytORjloOWRrdWRuenB4UmE1OGZD?=
 =?utf-8?B?VmM5N1dPMVB6b3JKUmZBTUw4bkJQSlhOemh6bHJPZG5WUG1BWStRRERDMTFK?=
 =?utf-8?B?NTZ1OGJ5N0RJYi9qVVAvYkxoczhsMjdZbW83Q0JXSzRrMyt3czlrbGxqNS80?=
 =?utf-8?B?M1hOblBqU1J2M05sNDRzbGIyVlpPYkphWjZYRnRQTUFrN0UxTENBWFJhem9L?=
 =?utf-8?B?bzYrNUtkcDhDK0ZRcVNaNlU5aTNTV296VlVBSEFPQThoQkp0dE1jQ1lScmNj?=
 =?utf-8?B?T0dYcVBvdWZQMFRQRUVSZDBkbDdiamxQNVVuSTBuVGVIL3JvNlBGYWQrR2Na?=
 =?utf-8?B?WERBRURxSjd0ZERtY2ZiNkVIRWd3MUlLc3RKY3dyMlpKWXhhUTc0UDlqMkU2?=
 =?utf-8?B?VHZEMzY2TFcvcUk3a1lYejVreWFCeUhwd2xpTVVnTFFMcWdlSGR2enB0Q3lq?=
 =?utf-8?B?T0VLZEU3YUYrdUk2SUl1Q2p5OCtHZzBwWWFFbTVqY1FKcURCbFBGYXhZZ3ZF?=
 =?utf-8?B?NjRzbzVqTXBSUGJ6MlQ5QTJrU3FvZ2tZNVc2QjlnaVZtblpGUzUxUC84endJ?=
 =?utf-8?B?M3A3TWhLOFl6bkJVUTkwdlkyTHBrckhQTUVUUCttdGFKY3MxRTlFNVZyWkg2?=
 =?utf-8?B?bTlXbjhSRmloZGQvV29WY0tYS09mNDdwV2N0eC9XWjZIYXVDWmhFZ2hyaXRu?=
 =?utf-8?B?Y2l3V3VjUk9WSTdZOG05a0VqR2hOc01wQ2NqT3U4cFdpMGNMWXR0ZlBCRGNj?=
 =?utf-8?B?RFBkVUhDNHY4eEJkZHRsKzl3VG9VZ1duRmc5TVFXci80TDk3akwybGpTZ3Fh?=
 =?utf-8?B?dzJjOFhsekpqVVZ0NjAvMVYvYkdsbzFMOE5kQWxwTUFhWFMzNVVUalRMMEVt?=
 =?utf-8?B?NDBRTm1UOTFrR2RIdjhGTThJbGZmb2xwOGhpTy9JOWdWQzR4bWVOa0lueStO?=
 =?utf-8?B?UHVsT0Mwejh2YmV5bUF5d3ZOWXBkVTRwTmhleGdaVGRsUzNyR3RMZ0ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZtR2E5a0Y0ZHFyYnhEVS92NkRKRXR1VDlVSURkRXI2ekhHanplRHJnWWZn?=
 =?utf-8?B?VW8yN1MvR3lvdjd0OFhOV2NBcDd2ek1rUy9Eemg1N3k5TnZ1amgxbVNIN0RG?=
 =?utf-8?B?QVF5UGJPQ0JTd0ZzNFpyOWNJRGdXUEJZTWZlQW14RTRyc2daRXdkRjN5eG9H?=
 =?utf-8?B?Ym44ZkhzQmt4cDk0ZGI0RFRCK2ZyczZlbUlCb2RSVWxqUlc5di9xQ1F1Vy95?=
 =?utf-8?B?KzAydXBFTzA0SVJHRHJVejFWeG1xQ0ZvMnZFS0tpM3FVTzVaeWczNmtuQVpx?=
 =?utf-8?B?SlM3OU9ncWg2Qk9XenFpWXV3Y1dQTWhsM1RXeS9nTlA2ejRZYnkxWkorUGtp?=
 =?utf-8?B?SkorQ3FUSlRLWFdpSUpqdlRPZlVtTi9LajdYdlNlZkJjbkYvR1VkVTdzT2VI?=
 =?utf-8?B?WlFBSVBSMjZjdk1FSXVmMkoyZDQ2NWZueUZlMzZiMzZlbmdLRjFIWVZZdGt6?=
 =?utf-8?B?YlRoY3AzMWU2Mk9BZGZybURma09UcmtRM2FJNkNac2tQT1V5NTdqYUsxdzJX?=
 =?utf-8?B?M0JoRlBCSGV2NmlhcTdIam9Db0MzYUh0Z1hjaE1IeHp3KytVS0VzSE1SUlVN?=
 =?utf-8?B?dmFuaTVLYUE3TVNHajhaSkhlM3QxbzlVVlg5LzJmY1VGTXE2SGpPaW5MdW92?=
 =?utf-8?B?SWhoTHlvcWJTZHByZWxTc1YzY25ISkpFbTA0L1E0N2tBZUZTZWFNTlM1UjA4?=
 =?utf-8?B?Zm8rbGRGMm9FQXlNd2VmS1dVd3p3UVNCV3hVRlJKSTRLdXFFWGQ5S2xvUURs?=
 =?utf-8?B?MEhiUEphbWI4MDg5bmxxRC9nTmd2blkxK3dmVkE0R3k3Q1ROUlVXbHl6dXov?=
 =?utf-8?B?M1JpQjY2YisrUHFzSE8xODNYUitPL1dpMjE2YjlHSDVMQkdTbC9TMUU2QTRE?=
 =?utf-8?B?ay9VMGFCTDdsSU9LK2tWMGJsdUMyZkFnQ3NFQkxnK3oyTzJIYmE0UEdmdENT?=
 =?utf-8?B?a3orU1BVcG4zdXBWTW5lMEVNT1pDTGZKL096ZC82OFpEbzFSUkdjUU9ETWZw?=
 =?utf-8?B?bEwwUUpXTGxOc3d2VWMxRHJNTHhudTcyZlZUSmtEbEtzQ2xyVDNUMmJaelZE?=
 =?utf-8?B?NE8zek9VbE11TFpRNk1xZm1WdXBIUWhwaytjUEJBcFNESExUT0VCMmYrUk1I?=
 =?utf-8?B?ZVJkV2tLbW9BaXQ3ek1JZlMrY0J2NEx2SmFMRlFsL0ZmbUV6RkdWeGkweVpI?=
 =?utf-8?B?eCtsRWxLendjTktacjFOK3Q5MEFFMlprOVlSdnVnQlYyUDE5WmJOeHlWNmIw?=
 =?utf-8?B?SlFCbnBjSE12MkxrVUpvaGh1aDZTR0UyU1BFUGxBNTJDSU5XcGhsdG41R21E?=
 =?utf-8?B?OUhSVnRxcEJuc3g0dmRrVTFaVEMrKzdxbTJoMVFvWXVQbTJYK2FvRStrZ3h2?=
 =?utf-8?B?SGVCZVN4SGI4SXZZTlJSWndGQUVpd1FKRHFQVDlXOGxBYzh6TldGb3FQakNZ?=
 =?utf-8?B?NmFFY1pmem1yVEhkdXQ4RHAySmZrczhWVEJnVUw2bFFXaFJ0dUt1MHZTTDI0?=
 =?utf-8?B?em41bEtpcEFnRSt1QlVNN1pOaTNCS1JURGgwajVMc0VpQ0w0dmNOZTNBc0Jo?=
 =?utf-8?B?OGsxdFd6UG9vUE02OStUdmx3a2piSkRWYVhZdmFmclFiNERNeFowRUJhdXA4?=
 =?utf-8?B?VzFaeUFwUGtZMGR3eVJEQkZScWNRbjZhWTVzWG5US29ObisyRU5pV0g1MnN1?=
 =?utf-8?B?UnBtTHF6TysrRWl1R2VNbFJXbUgvRXlGU3BENmQzZm8yTXRHUFhlRW9md045?=
 =?utf-8?B?R2VFMWxVSnpNaDRSTExVTFFyclVtdzVYcmFqQTYzUmh6YVhNVXJydzkyRjVh?=
 =?utf-8?B?RlZhKzgxNWluZWVyMUt2Y1hxbFZPYnZqZzlBN0daMjhPdFNNaktHZCs2R0RB?=
 =?utf-8?B?YXNGL0lxV09wL2tMc0VXdWlvOFlOK08yWUwyWitXZ25WdXhCOU03UGkzZEVB?=
 =?utf-8?B?NUFKYWRCRDZELzN6Y3hVK0J3WVd3ckVHUjhlVGNLSW5ZQng0NmhEUHV6dDY2?=
 =?utf-8?B?VXh2UWxydUtNazI2amVCSGN0T0VueHk1WlduU1V0QzNDT3RGOFNPUTNraWp1?=
 =?utf-8?B?QXQ2Z2oyUld2eHErdG5UTlpYNVJhZVRzMENxQmpYNGgwU0Erem9RUXcxS2JC?=
 =?utf-8?B?V0R3VVVRRWhIeFVFckwrZnFVMDJzbnVWTlNEenIzZi81QlpmWTdFUzliYVVE?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71fff14-ecf8-43f2-c8a2-08dcdefa0745
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:41:02.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcjAl51aCr1I4ltq95471eXfIwuZPNGI+8jkfUCZZefTZoxAAEGviOrrOy86VF6pOn8PucFrPsHsQWSboYRtLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

On 27.09.24 09:00, mars_liu wrote:
> 
> 
> hi xenomai,
> 
> i'm trying to test latency with full cpu load .
> 
> it has 4 cpu cores,and there are two mode cause full cpu load :
> 1. 
> for num in `seq 4` 
> do
> dd if=/dev/zero of=/dev/null bs=16M
> done 
> 2.
> stress --cpu 4 
> 
> latency test command is '/usr/lib/xenomai/testsuite/latency -P 90 -p 100 -c 2 -T 43200'.
> 
> the test results show that  latency of mode 2 is much better than mode 1 .
> 

No surprise:

"1=kernel task, 2=timer IRQ"

> my question is which mode of  full cpu load is suitable. 
> 

The mode above has nothing to do with "full cpu load". You are testing
differently "heavy" RT code path by switching the mode of latency.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

