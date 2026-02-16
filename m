Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AB3EBF24
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240593; cv=fail; b=kZHP0S5gpV5Pc3Prq2vfdoEFls/R+tXW3NCdjlFbvRnvyi59Sv1RjX12v/lfi8iOBs2nD9PjVSd7Jq52hj6vSm/n5yXsO1RLs2bEhqrFqXYDNSMQ2jMUzdQMgXJkm2lpTYM9ctlWLDbiWMDqLU1YWblHIybQ48/H+A35EPvRR8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240593; c=relaxed/simple;
	bh=c44d30hpcfFK192nRhoYYu2XRHfYVOxRvF8veW3hfuU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTUmb2aAdGPy0Z1PMcD0y2S+Hx3XgzKkrlfQwNwPUaH+hsRjEq6fKLxkB3B5DDaRmmalptEqoTH5yGwpHYIutae58WB1RjhZ1VIsl/WJ9CTTQ8mQdihelRVJ0HaAHCCy57YazyETn7OpgQOGTjTy13dayWelGTf8ZLkwcF9w0z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qIJ1CLJ7; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qIJ1CLJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/JkHxgAq4FdUGegk+xIzjmhdEIKz4QPVVCP6FXYsdnRl3GtwLmLVDTxtlu4fBr2P9HPAYGO45tDQ0AI2sEtamS8+uMJiBkDuZBjrbyKNnKP21rYtis6euRHMRToAymj39hwBuahRhu9BDMrGg1SMQ7AX7ewJ0k1A96uoHS8WBynE6FHfft24nqwOOjqaoBHkrTvhiQZguBmPbCwQYkGQbaOVIftdvEb/7WZkH0cbA1XTcIoClAE7faTfaeL0JL1Qj9E7f7uRX3Cz7lmguqk9RZg5lugyJel2+7ObRveJaOlBqcm08e6j6aCQvWE3yotmi/1ElXK54Y/rufCFnqTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hezkFxTYQR5WVZ2ZsvVktXfX7m8iqaMHFgQKX4XBQIc=;
 b=pR6c9l1r8ft3ZoZPtvKn8krBcbx7PebRrMKPg2Z5AIpmr9+YsoYOh/wGArBqnrwC+gXZ7RoiPNCSbTmi/aK1KsfGpbUHlFBPZ22gdg6Rvi9ux6ggNP42mN4HjS+urCBK7wgYke0KXG9U2Z//WbiIzMsBLB8JY+0QfLrP11pSkcni1LDvL0AzG7Amg0ECwzuKtMAhGjP3RrTEbd5EZp4JGp+2T1+NHJv2WUfo16IyhlRUtVFG2c+jieKQbs8ISFZGcf/6CWNZUyum1QL6qoMa6g/xoHaJiDcFGErHohmVGIiAOVjuBKj9sFMyJAF9p5g2tFQgWOAjlocVE7PjX/KEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hezkFxTYQR5WVZ2ZsvVktXfX7m8iqaMHFgQKX4XBQIc=;
 b=qIJ1CLJ7jHdOiCb3UNZvzVWIwUtMyQUbORWKv+EJ7WEFoUR66YbQmU1XXNzt9TmDrIUZmbWhVUo9IICxmS6Du5hfq3SxukhNaiI+no1Dz12arDBKK5n3bjFz7TjRMg+wpYvjTXr8ThlCloZgdXMR3o3x5w8qOOe/ZJrcG+T2i9YU3pUZJ+vAQe0VZpLsBkqij521Cryx0dPWC1tXtwgvIvn7nL6BBbof89Xar6IDQKxp7ieYe20vZrY/bnEvKFuTbu6uJnuZ25g2trgH3z0m9kn1wpc2AclEHiv58OknP5I+mStLs0sxyiIADe5KiVaMwNtIC5fwAXsF9OYUI0G6Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 11:16:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:16:27 +0000
Message-ID: <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
Date: Mon, 16 Feb 2026 12:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
 <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:610:58::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3291:EE_
X-MS-Office365-Filtering-Correlation-Id: e240b708-8a20-44c6-6a86-08de6d4cd415
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGF0K3RYbVhWaWtxRFhtWENyTkxsN0dRQkcyVU9XUUhiZkg1UHptSFhhMHJE?=
 =?utf-8?B?SkdlUFVXMUdqanlhWjd5YlZzeDQ2QitEZVRkU1ZxS1p0OEZPUXZHNGdkclpT?=
 =?utf-8?B?VjhZemFoUG5YKzR2clMrcGpzbU9VNzlWL0ovdzRFRkxBTkVMT3NFRmMrZ3Rx?=
 =?utf-8?B?TlB2Y1lCbkRBSDA3THc2ODdYUXgxZHphemtPbjd2YlNyWUp3bjc2cDZlMERm?=
 =?utf-8?B?SWM2Y3lWd0VNN1B5RkxjdkNGU2JjZWdEd2drQXNLSGM3NlNkWnVtTk1YN0pt?=
 =?utf-8?B?SXRWTFNmQkZaMk1iUGc4L1g1U3pJK3RlbzRnSTAwOEpoNDU5REN4eVQwS0Zs?=
 =?utf-8?B?SmlPcHU2VDZDSGxSVGRwZFpSeW8xN2ZCb3NDYmFMbE1OdXpHelJ3aE9qMFZr?=
 =?utf-8?B?OVpENE5aS3RaNzE1V2xCUW1VN3VQUDZBZjVLZGlKV3YxNWFudDdWbjdDWndS?=
 =?utf-8?B?aEllcGl0L1U2TTdLRzZsYTFFZnhGenNweXcwTTl1RlZqakpHYkY0R3RqaEFF?=
 =?utf-8?B?MDlhSG5VbGwzUEtGK0tCMk9ZOXR5VU43cXNSN1VaSVpsNU4rS1lRNjBGTmJk?=
 =?utf-8?B?NG03aTNnVElQanB4a2lQOVBjUGRIUFJlTkFXcDFrdG94S3dpaC9nNHNDZkdm?=
 =?utf-8?B?bDIrVEErRWw4REhOT1BwaU5BcVlETHp3d2V1bHpIUGlCQkZWVUhxTTdMT05n?=
 =?utf-8?B?ZmhnRkFYcSszd1E5c3BDZ3k3ckxNbGJxUzFuTVlHS25hb2tBdXc0elprdDRQ?=
 =?utf-8?B?SUlKbVdsUzZIdSttd1RWeEwvaTArQS9NM1RJSmREWCtOYWdRYTNVQmIzblhv?=
 =?utf-8?B?ZXBXVjFtMHZ2cWRkckt2QTlQZzJqL3lpbm9CbzhvVmFaek5sT3BvbmtjL2pW?=
 =?utf-8?B?VjREM1IrS3Jka09WTWNPNGhBL3M3c0ZlaXc0RENFdHljcUE3N3h5N2lrdS9h?=
 =?utf-8?B?cjdWa3ZlQTNtaEhVY1hoUjNRcmlwcm9aSWdDV0RiT1cvUHIvV2Z0UGZYSDAv?=
 =?utf-8?B?b0wrV2R3Vi9Wb1E4eldjRXF1RjRNbXpiSHk3MTNHSGRiQzBGTGxTdEVJMEdt?=
 =?utf-8?B?V3dtcHByWWxMNzAySXczWlRVV3h5YmZCa1RHMmN1OGpBcUxqVmRGOVBqSlNE?=
 =?utf-8?B?Q0Q5NjZaVnRmNnlCYkZ1Vk5nSFVrQUxHV0JmQTRtY2ZTaXBvUTB4bFlRcTJD?=
 =?utf-8?B?cmpWMzc0c1dyNndTYU53Rk5UMDlFWHFGL3RJeVFPNTVUbUV4SzBEZ3BPT29B?=
 =?utf-8?B?YUhuZVpqNEY2dGpxZmpVWmNnR2VOaDZ3YU0zYkd5a2Nqd2tlaS92WlhYbVNs?=
 =?utf-8?B?YW01WHlLOWZMZ1lOeURyd1d1SDZLMzR3RGNlbFVSRWVzMGZrSytwaEFwZEtU?=
 =?utf-8?B?c2JJamxkTy9kZHRiZVc1MkFSd2ZpUURZRTVYWXNuRERNYkN0cERXK2ZScEsv?=
 =?utf-8?B?ZXNOeHdXaU9MSUNiUGpkek9WOW82QjA4dUNJZzBJajM3VlRtcmx6cXhqUlJz?=
 =?utf-8?B?UlNpeWF2QWpkQWIwdXlEQThnRVcwUmlPMUhobnFQRmRIeGIwdkU2aWxvNnht?=
 =?utf-8?B?VCtsTFp0Z3VmVlJPbzdhVkxHTWVWOUg2eks2OFNDdis3bzZkVGRKVDN5cVk2?=
 =?utf-8?B?eGE2WTFPSXNycXNwdGNUQUttcXVnUm5KTi9TRG5ZOUw4Wi9NeVYySU1BOS9C?=
 =?utf-8?B?Q1lldE1ZZDNpa3RadGFDNWlDMk5BQ1dXakpZUUxDTWl5amdFQWEyY1MxTjBw?=
 =?utf-8?B?UzB5NFloK0dWSno3V21EWFI3TmdqUzBBVGs1cndDczNvZ0VkR2Q0RUtNMzdx?=
 =?utf-8?B?SDNwZlJWQlVIcDVSTjNmUnpsMkhXL05KNHA1Yi9KK0pNbzFUSDlGUEsxd2Vu?=
 =?utf-8?B?V29lcWRLSDdIOHFucENZdnFaSUIxK2c1MGlzVFoydmRaNTQvR0F0YW5Ja3Vp?=
 =?utf-8?B?TjNhbkpQRkltMjZaWjBGMWEzdFU5bVo5b1pTMC9XREJXTXJXTU5PZ2pZbjR4?=
 =?utf-8?B?M3pRL0dDZWE1enVZTC8vRmM3Slh6cEhtY3VDQXJFb2FpNDIra3hucWQyK2lN?=
 =?utf-8?B?VjRXQ2drdUNyTHVqTDYxekVucHFGNzlyS2JXUGZGUkRFcTJzdU5jWjhRWlI1?=
 =?utf-8?Q?Dg6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJGNml1Q2JuMmFFNXVJSUVEa2FUTGNDdGt2ZmdwbU9mV2ZIcC96TDFuRkZ6?=
 =?utf-8?B?b25pVnkvSHZnZldneURSS1ovSE5lYUlNTDdXNW9LUWhZbUVHVk9mNmQ0NW9C?=
 =?utf-8?B?Ym94QkNabEVHZDdsa2lPS1JzbWZuNkZ5MEljZnBGc2x5ajQ0MWF4QTNabjk1?=
 =?utf-8?B?OElvTExaUVl4emR4eldJVzdHRG9KTzU1YWZjWjdQUWRsVm1MSFdlTUY2QUp3?=
 =?utf-8?B?a1RzZDE2SWpRbCsrNDYyVWIrbWpaeHVqbGowcllMWWRyV05jWmFaL1FWcFdV?=
 =?utf-8?B?SU42bGNkRDJoTjBWbDcrWTEvMkhSMzllS0swcURCaVhWNXBaUkxyNSttYS9G?=
 =?utf-8?B?UWpvTUc2b09uSjcwMXFpd2ZuSGgwaXEzTmlWZlhtbDBsZWNqZzVWdDhpcWhr?=
 =?utf-8?B?VzErSWlTSEViZVlGQW5ibW5xNWlJM0I0ekM4M0VSTzhWNFBLNFlyVDk2T1lk?=
 =?utf-8?B?KzB3cXlEdVMwZDFUTWdQYlBGZHFZMDhRbTZSSkp3eTlZQXUwcEhMejFwY0RX?=
 =?utf-8?B?bVZZcVVvZU9UMDV1WjdBM1pJSHRwQUFUaFlZejZQQWNnMTcyV3psVTk3WFY0?=
 =?utf-8?B?cy9iZFVwbUx1cW81dEpYUnl2TzdiTk9iWm04ekRtejJxOWJPcytLUkdscEd3?=
 =?utf-8?B?YUFxeTZSYXZYVWorczdoemZRV3NncEZXTmd2UU1mdllqT3Y5cFowK0wvTHhO?=
 =?utf-8?B?R0JkRXpzK2pvZktsamFtclY3UFhEVHJweWVYbW5mcmxuYS9FT0lCYUJ6Umtq?=
 =?utf-8?B?UVN1KzVxTmpqRVFzRUs2ZzZGVy91R053WUdWU3Rzb0ZSZWJpVTBWWGhNT05N?=
 =?utf-8?B?L0lVU0ZxdzVCRWkwVVIxTGNrdVFrSU1SRFg2cVU4d3duSy9PL21rd0huWk5p?=
 =?utf-8?B?RkgxYVVDVURCekdkU21URXJVN3RjUXJjQk9US3AwOGUwaHBDTUdlK3lBcS8w?=
 =?utf-8?B?UmVjczFva2xXaXUvLzRTWW02bmVmUGdnTFRTSGxmaEkyVE9UTU1sbkNmUGx4?=
 =?utf-8?B?eDMrbUM4TDM2djlNNkVGOUpHUEtVbnB5VllUYkRCeXpYdm5rbGpQdFhrOTN1?=
 =?utf-8?B?aGZuTStEeWVSNUttb2FSOUdKRmx1UUs3MmhPcjFOYllMNFExelNlMFlaYVdJ?=
 =?utf-8?B?UzU5ZEtmbjJ5QUNDUlFnVUtDa0dyYzBmNWx6cUdsdzhRcWlidzA2ejhTNTdZ?=
 =?utf-8?B?MEt3cTdTeHphc0J0ZFAzWGJsOFVsVE5UazdEcXQvSkFueHV6M0l3eEx1QUo4?=
 =?utf-8?B?U2taZU51b3JCQUtuQTZ6eGdtc1JQcWNmM3dLM2pwR2FMM1M4Z0VIVWp0Zyth?=
 =?utf-8?B?Q1NDa2NJcmNEQXlwUGNmbU5abmZSdkl4N2RyLzJYeWgxUGcxRGVCeURPUHpZ?=
 =?utf-8?B?NWQwdTY2ZzFBckNmMGNrTThRNDFVUEpTOGFuYS9XZS9PQngzOEwyMjBvQzMv?=
 =?utf-8?B?cmZlU0oyTHM5TENnMXJONDUxcllobEpqVVI1dVg5Q3FCblhWRzNsV3Q4TEc5?=
 =?utf-8?B?RWdscHVzdE1GbXVLSzJHVGNGSm5YQUtRVXR0SXVtbGN0TzU0WENHcWVnVXVK?=
 =?utf-8?B?eHQrcC9nd21ZbWNUb0QvQ01FdDN1MlN2RG96QW41WGczNTZHMGUxY3pEOXhs?=
 =?utf-8?B?VmtGMUpvcitlaG5BQWk4SysvdXBBaUxmcHV1VmFEdDgrQjRQVUQreEh4ZUV1?=
 =?utf-8?B?a1dwOWZoWDdnd0l5cDBoSENWTnBQNWgrdy9PMUlvZ0VGc1hudHYzLzhFOHFO?=
 =?utf-8?B?aHhrRkhiQnVCbnpBRzdvN1o1Z2h6MUxJRTR5T3dxVTd1UEpKcGo0eHlhL0o4?=
 =?utf-8?B?MkRVaEYxWGgvQ2RITm5EUGUzWTUzak45dVhhMmltNldoQVoxNkg3NlVPNFRa?=
 =?utf-8?B?MEY1SWp2RnZHR2ErU0dGTHQ0ZlBQMG9yZlIyQVM3RTVWT1JHK0cyWXhtbTRq?=
 =?utf-8?B?V0YrYzFYaW5yRDd2Sk1TL20vYnZyT1NTTGhQTlZUZlQ3K0t6YVBuTXNLck54?=
 =?utf-8?B?ZUxjK2U3N215anBaNlBaTHltUVUvTlAwOE9VTkgyK2RJN2c2V0JDVFBnT3kr?=
 =?utf-8?B?aVh1eWN6UWdQRURYWmRZa2o0KzBjZU96bUNuWERUTVIwd3c4NVZkWkdSSGZm?=
 =?utf-8?B?K3JzVEVsZ1RMbTBPMjIvcGVWNG1BOVhKK25TZDExOTFTeXRPZnovWUl4SDhH?=
 =?utf-8?B?T3NFMGVSeWZzTzJiaDlKOVhTT1k3NGoxeFNqWGRXc3hoUlVBcklLRHZiWWlY?=
 =?utf-8?B?Q1BtWHpOYkx1L281dTVGSytkYytZbkxldFZYTE5WNitUeTgyM0d4cXh5RG5m?=
 =?utf-8?B?TWp6K09KeXFXNzVkUWJnNVFZNy9aN09vZEovd3U4Rk5WaEZPUUYrUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e240b708-8a20-44c6-6a86-08de6d4cd415
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:16:27.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOMZ964EIEpq/+PNyqYn7GS78gPOTvnOdO/yegqUMFxxi3mrWgda4FkJF0wMdLFj1M3/OlmFAbURaFDT91ZXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3291

On 16.02.26 12:15, Florian Bezdeka wrote:
> On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
>> On 16.02.26 11:58, Florian Bezdeka wrote:
>>> Since 6.19 the signature of __request_percpu_irq() got one additional
>>> affinity parameter.
>>>
>>> A new Linux version specific wrapper cobalt_request_percpu_irq() is
>>> introduced to hide the signature change between different Linux
>>> versions.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++++++++
>>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
>>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
>>>  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
>>>  4 files changed, 32 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b5b8cb279035a5dd7b 100644
>>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> @@ -5,6 +5,26 @@
>>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>  
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>> +					    irq_handler_t handler,
>>> +					    unsigned long flags,
>>> +					    const char *devname,
>>> +					    void __percpu *dev_id)
>>> +{
>>> +	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
>>> +}
>>> +#else
>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>> +					    irq_handler_t handler,
>>> +					    unsigned long flags,
>>> +					    const char *devname,
>>> +					    void __percpu *dev_id)
>>> +{
>>> +	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_id);
>>> +}
>>> +#endif
>>
>> Please use a define for request_percpu_irq on older kernels that uses
>> the new signature and resolves to the old one via __request_percpu_irq
>> as needed. 
>> Yes, also switch to request_percpu_irq directly because
>> __request_percpu_irq is going to be removed in 7.0.
>>
> 
> request_percpu_irq() doesn't allow us to specify the flags. IRQF_OOB and
> IRQF_NO_THREAD would be needed.

Then request_percpu_irq_affinity - whatever survives 7.0 already as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
