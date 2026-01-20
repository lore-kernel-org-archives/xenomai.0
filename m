Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8842883B
	for <xenomai@lists.linux.dev>; Tue, 20 Jan 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917305; cv=fail; b=Hth93SvdEH7iUMsvWSLZv81Ibl+Td6xrHYKKU1Cya2EJFRo0vAzJbksQG0Sxbk/csptDDoKLBAxxB9YGvcBoXulXQuJ7n7wKJSYepbhCbkqdItACQt5K/SI6VyxP3ZdmhZOBse2pVw3Fl4nu+8CwNNhnjDP34PMoqA+qbheWlFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917305; c=relaxed/simple;
	bh=DjsuGvUtybfaO5IA3SrL0ssVnQBDFulJmNMJ8KEjCzs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsUTiZ9fZ0cv+OOd6h9GhOTzHAulOJ75KJPVipLbP8n+l7qJM8A2DjdAn6ndLgXJoygfMqbPwSC6SAT6oAbEGW9ZFV7h9999cwViDvf+nPh2O3FEg+2m1sTUagRsUepXTvBF4uixRrgUqdTqqFxwZP2n006mv4KNfQezO8rNIbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EzamzLLN; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EzamzLLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqXh2aY/6obRMgN4g/FUVJXlJfE+giyFqf/1OdZMjgMqu+BsqfaXkc6oObrstoZlX8p2b4oQikrrY92lqzbW6EO72QfDkfoR+DSid8q1DnKnJCE9W2Z5KMlhjtUGqDo/BKaLGkqcj/Tu0NMEkuJHx+tVpZyx7D+uDDOfArY9eUP10Yb9i59o3XOMibDePJBOYDpPltZwW6pMJjKWSZRfQLN9XVLbslsOTKVuMMybksYv20crJWKEVt7zZruV3T4X3IUUl1yEovgfWG26bhEKOmNsbaLvI0JHhERAHh3uzSBIgZs0KbUlJoSmyQQUKhDAA8Di3SdYFMGSf2NFQPN+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TvFqjmBaLCwo5/aeSLRyW1wi3OqgmIARkmIkLzFp6c=;
 b=hSXy+T70sDe7qWnmvizc1CHOJjhew6cGHlWH+2sdR4eK/mw7THZAsfzAqFz9rbHdVxmd+Wrx/9slwZNVajI/sNK8PEIxHmD/JatrGL42fPEMz3B2ZfBuVokmbKzDiRVI+xgGMu5pjvVB8xgsBm6eb6fBULCBWch//0gcLbbEqHEoollVytUWyDzsMEJ64XqsbP/7/ED0SelF35gWgVV4Nh8eW+IhqoG9psGDJKD2GEMKnrC9a83bqiCUGbRUMHLBlcSrG6UN4JTMh6JnPHpWmyf2NhkwAWTyJowckdcUu9VwYXGdP4F/UY5t75xvk+sU5A8fXzsLc9Po75Ttp56rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TvFqjmBaLCwo5/aeSLRyW1wi3OqgmIARkmIkLzFp6c=;
 b=EzamzLLN7VTqc2yULzjfmzr05xnItbKEG6dLqHb5E59fQReeia5Pid2JUWdPRho4JxbKYfdr/1ROUeQc8+TVP7ZgJ961dEgKz9HXT7hg2e1LAFH2LmMGhNb5vodpDDlb4QATlsvNNQiM21bUijhbBrbpZXEM3cpuxAFmmMjih/eEaHk0/J9e46+HdEdaeY9dEfbQiU2LlA2V1zyeBs9gmWZHQpjjC3UtF+I4Wtpq4tPzp3Spfn9s0fYKKHPMoenMfBzSJz+PrwbEL7cCqNyAavC1HCsjTgNacEE4Kiph8lLWe5k4i6R4dleXQdzBd2G3cJ+KyOWKo3SgH/9InUpo2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:54:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 13:54:57 +0000
Message-ID: <47e28546-7e9a-4741-a190-f37346ea48b1@siemens.com>
Date: Tue, 20 Jan 2026 14:54:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Testing: Minor improvements to switchtest and smokey
 gdb test
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 554f601a-26b8-4585-8b3f-08de582b7ed2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGh4Yk8xSkVOSVloWFF1b0RYbE5ETVZ5RUF3TXUxRmZNSHlObm5YaWNGV0hv?=
 =?utf-8?B?aEV4djlyckhDd1huOTgzRHpmSGZ1Y3JCOTF2QWJQbGU2ZWo1YUY1ZHFvTzFk?=
 =?utf-8?B?QVdkRVNHQWhrcFZSdmtYbEFCSjVVMXhneGs3ZDYyY0dqWGtQcnI3eXlmT2xZ?=
 =?utf-8?B?aldzQWFnditqN29id2JqVVE3bUlpUnBlWlF2M0JyaWlCTlRkdy8vS1dyR1Rq?=
 =?utf-8?B?VGF6Tkh2MVBuY3F4dDQwcmZsNnExVzljSG9ISmxwT0ZxQ3hXQWdheWJjRVZP?=
 =?utf-8?B?TkRIZGxZT21GQmNQZDdjQjFpOVJ2cFFVa1U0ZTh6bDFjaGtSMmpoMVIzemNW?=
 =?utf-8?B?RlkxNFZnUFYrQWtmQzFEazFUN3ZiTWp5WEU5aUNkMWdydENSay85NHhjbVJJ?=
 =?utf-8?B?RTBqMjVKU2VWV1g2YzhkUzMxd0g4YTVwNC9WYjVZUGZreGgwUGwwR3Qrd3RU?=
 =?utf-8?B?WWh3L041YVBaVXlSOFFGclk3SFkrdlNlVWlHeXRNMHZPb0pVc2tqeTgxM1pw?=
 =?utf-8?B?dzJFbko1K3ByTlNWa2M3dWRwUnRLVGdLWTF1ZVEyQkUrUUNyVXcvN2ZCTHRT?=
 =?utf-8?B?dHBOUHFkbzRMN0QreXEvRWZkRXVCcFVld3o3R0MvWEF0bnhoWTVmR0dXbG9s?=
 =?utf-8?B?Y0dRbmNBcGRRUUtCUkFVaDlrR2QvaityU3p0dUVTUFZUOENUelhXVkZreVZo?=
 =?utf-8?B?KzBjRHREMHVTMFQweGh2SkJhSFo0Y0liWWdrUGI1S2cybHNwN2dtUHFITlJF?=
 =?utf-8?B?L05TcytqRVZHWHc1dzJvK1oveGVvbm1XMnBpT2VGUUVoT1h4U0Z3SVZMS1Bz?=
 =?utf-8?B?cENPWklwc3pnZ2JkamJkbWN2TlB2STFGMXVTR0Zwa0ZCYW5IUkhqZXROZWdm?=
 =?utf-8?B?eGI0ZmJLendneFBNZXZsSzdLUFNhaDdHd2hYakxYVGhxRG5lYW9md1JTOHFu?=
 =?utf-8?B?bGJsczZITVpscWYzWitSUkV0TkYzNXdVc3gvRXQ5NDJpbHpNUmg5K0xYMU1o?=
 =?utf-8?B?Q3pKQVdLeklKbXMzbTgvNEpWSEUyUlM0YnhteDE2SE9wcmFDVWs1NmwyV0Rh?=
 =?utf-8?B?NDcwenVtSFppd1ZGeWxYQUVaUmFxZGU5NDBWYnlLeWpPK1llcllOVFR6WG52?=
 =?utf-8?B?YXN3bVdJNytLR0llcStkN1I4L1NhNmR5b0U3M1d2aFdkOENGa0RlYXgxM1kx?=
 =?utf-8?B?dkJlWk1jalVRY3RzNXpIN2RUQWdITSsxU0tJSm9aUFdLUkNsRWc1aU9lYm1t?=
 =?utf-8?B?ZnEvc2EzaGtlRTBhUjZDbzk3NHk1cXlaSFVhL3pwZnFRdmhtMGFmSDBBWkRl?=
 =?utf-8?B?MDgwMTYzQW4rc0o1cWk5QktGUVpiUVVCVXcxa3dHbmx4bWZJbUx3K1RRQWN2?=
 =?utf-8?B?VXJTU2l1WFFhZTNFMDFBVVlKMWVnV3JxcERCOWxpdmh2QUNzRGd3ckJkSE1W?=
 =?utf-8?B?YjVYWGhqRmxWYnNGRHNDZFF2WEhPdjdrZUhpS2VHTTZZZU1ZTUNnS0Q1bVpP?=
 =?utf-8?B?RmFrNG01eTRpL2UxMG1WcGZadmxDaTFRZnFNN21remNiYmlxeVNWZENzVG5m?=
 =?utf-8?B?RTI5cnpqTzZseFRNdVk2bThFTXRPcHBDWk53U25WMmp5QU9UU1RpMmJUTGRW?=
 =?utf-8?B?bHlzSXpHWElxQ2Jmb3gyd0FoZXFIcEhsQ05EaUQzUTEybkFEOVN0NTZRMlZR?=
 =?utf-8?B?MUNiSGUvNENOTmhaYUpVakJtL09aN1V5Ny9sdzQ5WU95bGxBRjhsb0xKeEN4?=
 =?utf-8?B?L0txQWxTeEVuWWZ3NEpXVUxhRGM4eHlaU0l0UnB6d3JHdW9LUFdBSGI3b25L?=
 =?utf-8?B?TUZkMmJic21NRGliZldNelh6V2JmSDVlSk1BdlZQY0dUT2lqcTlwREFMZUJq?=
 =?utf-8?B?TjJGOGtFR2pIODFVanlLaU90K3VGZ0ZhL3d5UU9Nei9WNXVMMjJXVzBSTTFz?=
 =?utf-8?B?MWo2YWVYVjlmZ05sMld4ZDF3WTRNSTc3Z0NsNGtRWXJmQ1BmMlYwSmxLVnlC?=
 =?utf-8?B?ZUxidWJDeURoa3Nvb1cwQ3NuMXFXbkRQc0drd3cwWllGZGx4Q00rZzRUeHZq?=
 =?utf-8?B?R2s5d2xSTFpwNHcyWFlRNXB0NFJSamxHS1ZsQWM3SnI4aDdNbWFRbFR4VllK?=
 =?utf-8?Q?47yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk14R1c3dGVSeDlpOTJKaXBQcVFZSmRuMGFJMytCczBFTFlIVEtSbFl1aDJ4?=
 =?utf-8?B?UDNtUE1pZmxhS0VFVjVkWkg3eW9pY2ZoamtrVDU4VDZqSm1QRUJJREVPVGhP?=
 =?utf-8?B?aHVQTndhd0NVWmxDUlFZTVg5Mk91Ym1zY1IyRTQ1aFVJWTBoQmFTcFlOOW83?=
 =?utf-8?B?N0VxR0x2NXJlRHU5ZUsyUEJBMHRRYTY0dS9BYmIrYWJKbWxtSjJGbVVkMWF0?=
 =?utf-8?B?L1pwSjA3WFdwTUNFcHIwNE5BdGw2d1hVZVRKR3hqNWZ6akp5dllBMmZ4bTEr?=
 =?utf-8?B?azY3L1laZVNIZkw5NURNZVQybmRkRC95R3krVUhRZVJYcERFM211MC9aU2Rv?=
 =?utf-8?B?SW1lSmVBTkpTT1VCeWZpOHFFNDZBdFlpY3o0dVBSNXI0VEFhWjZJREpGc05X?=
 =?utf-8?B?TVlIRU5zYnFrZ0xPanQyS2hrSFpZTWtUWjdOZGw1YkticVVadCtZYkQ4cXNN?=
 =?utf-8?B?aFNlcW1BalBqY1VxdHk1L0ljQkZEakZJejZwc21kNkFNdE83T2t4emc1RUNz?=
 =?utf-8?B?dnBLTXBNZFl6Q2VtVllTako1NThPQUZURzlwRWN4aWdsUXRwbWpubTNkVE4y?=
 =?utf-8?B?eEJTZE41YUdnN1NZcTBjOWR1ektlY1V3OHkxY0ZrZlpweUJ5VVBUSm1SdUtO?=
 =?utf-8?B?WENBOW9vbUJybjFRL2hkOEt6Y2RhUGxieXNBZzgwcEY2VldIcmUxcEZNRUtS?=
 =?utf-8?B?U0p2ZEkwTFVPMStyb3NLaWVOeW5zUVprbXRaQjVHMGNCQ2RlakVwQ1JzNWNV?=
 =?utf-8?B?bWZ6aVlpaW5Nd1ZzMjJ4M0VRd0dmVzNtbEFZd1F5VkRjc0NqdWJIZEs4NVFh?=
 =?utf-8?B?amJaNnE3QUM5SGp3Y1RaMXI2S1pmN3FFTEh1RHdxRTFCeXMzMk9KdExmKytB?=
 =?utf-8?B?VEEyOUhnbEdBUG9jZUdEWEcybW90YTY0Y2czY0l0NVhOZnhnNi9BWEVZQmZ0?=
 =?utf-8?B?M3BZd00ydG9kdkgrcXNkMmVYWDc2OGpwZ1ZnUWxKNm0xV3EvSnovb3Q5TzRH?=
 =?utf-8?B?QUVFWkkyZURrbytVWVdGdkV4MnFsRHZFdjlrcFJoaE1lVlUrMVdWQXFJbjlU?=
 =?utf-8?B?K2RpYVFaUFZNTFM4YVBPcUtzWTdDNnBuQXF4U0RiL0JYTTRVYk5QTVBQRnYz?=
 =?utf-8?B?YThZT291aEs0aU1ZdzJ5SU81VGJSVURFQmxtNU5VdkJHZ2M4eEZ1cWxoNUFG?=
 =?utf-8?B?cmtYdkVrTXcwTy94S1NPYzNzUm5jK1orTS9RYjY3ODB4cis1Nm9DMXc1bTZx?=
 =?utf-8?B?TENGMTZpK2RLWk5waHpZVEovc2RoSExIdWdGdkRoc2crcjJ3YlBwcjVEMW96?=
 =?utf-8?B?VHpPVHAvcEJ5TmQwajU4a1R2c01wWEphU0lHeFZMdEhVT0s3S3ZUSmY3YUlM?=
 =?utf-8?B?cFU3cVVTZ1grMlpuNU1jczFmWVdXWGdFcURDS1hDWVRlWmg2TmZJWUwzS09V?=
 =?utf-8?B?N21jUExIYk82R2pCcXdoTGM2a0s3OWhDS3Y3WW9jTHZxdG16Ti9DcXA2Z1NE?=
 =?utf-8?B?UDU2bEVrZ0lxNnhUKzB6STBRZ0JoR3BhSkVjenJqSmhLUk1jRkhtdTlmZDlu?=
 =?utf-8?B?UkYySWovVStscmhtMEgxR1NBVG95T1ZXN2Zmb2YxZTFVeXE5Y2trd2gySThl?=
 =?utf-8?B?UWFuaE1jUE5qVjZhdlkvdk5YZWxlaXhCeDBUUTNQWXR6d05LTEtQbXBzOE9I?=
 =?utf-8?B?UzVPNkxpQ1E3K1UzUEhudWhxQ1hWbExKV2JCV2hGMlprQmdZckhrQk55d1FV?=
 =?utf-8?B?a0hMV2FaV3QxOTlqOFpFNEs3ZkxscnoxR2V0Rm1mVGgvSFl5QVpnWSs3MEx5?=
 =?utf-8?B?MmtUTzk3N0NPQ0JnTVA4dHRBVzZFckprbTFXaUQvdXA4THJhQTZrbUt0dkpI?=
 =?utf-8?B?cWdrcXNTWHJ4a2hDOEN4c2IwUWJBUmoyWEdTR3VMR3N1SmxGWHM4eG03KzBU?=
 =?utf-8?B?ZFJ1a0x0MEtHOERmZjFVczFFdi9pNnp6alE3aFU2UkhMWG4ya3VzeU5vOGZG?=
 =?utf-8?B?bDlnNjlPM0l3V3FsVS9nN1dPSU9yWVcxUzIxRVhIYkJleWh5RDF0QXg2TWk4?=
 =?utf-8?B?N09sVU5zbGtpaXdsemVQWjRyUGd4aW5UbC9MTFMwVS9FQzcrNnE4K0Y5YmtJ?=
 =?utf-8?B?SHZKSytGaHJ1dHl2UUM3UVM5a3MwSmdEdDN1L2ZpSXNTaVhseWxCc1p4Z3JY?=
 =?utf-8?B?ZkNQSlQvZ3JyYVFSR0cvaW5FSEJsaEZMcW1OUit0c3ZnTTZEWkZiWWZKWWJT?=
 =?utf-8?B?L2NKMldIV2RpK0VUSzZJczAvT2dlSVBPUC82TS9JVXlsbFBBM0d2bmhJQ3BU?=
 =?utf-8?B?bHdBVVdKTmErQ01kWjdmWHBTbkN2RU5kZWJZL1dZYnpjNFVCVDBJblFCZTNY?=
 =?utf-8?Q?C1AmhnsIDveiB3hQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554f601a-26b8-4585-8b3f-08de582b7ed2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:54:57.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqWEOvNFu6U2cITTSOWTQXpJeFQpB8/n0QNutnBRh+m75uMhigZeBh9LUDrc+sWDfvOn42UepYztQ6v4bSHG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6964

On 19.01.26 11:34, Florian Bezdeka wrote:
> Hi all,
> 
> These are some testing related patches that pilled up over the last
> weeks/months. Mainly to increase test coverage (fpsimd on arm64) and
> some minor improvements to the gdb tests.
> 
> Note: All affected kernel versions should have been updated, so that
> Dovetail on arm64 is able to deal with in-kernel FPU preemption. The
> necessary FPU context switching machinery has been backported to
> Dovetail 6.1, lower releases have been skipped for now.
> 
> There remains one known Dovetail issue open: FPU preemption on PREEMPT_RT
> inside softirqs. This corner case is not yet stressed by CI. Can't tell
> yet which architectures are affected. At least arm64 is confirmed.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       testsuite/smokey/gdb: Remove unused include
>       testsuite/smokey/gdb: Improve error reporting from gdb
>       cobalt/arm64: switchtest: Enable fpsimd testing
> 
>  .../cobalt/arch/arm64/include/asm/xenomai/fptest.h |  7 ++++--
>  testsuite/smokey/gdb/gdb.c                         | 25 +++++++++++++++++-----
>  2 files changed, 25 insertions(+), 7 deletions(-)
> ---
> base-commit: 40b2479bcaddf767a779f72a3c707348204bea1c
> change-id: 20251006-wip-flo-test-improvements-26c0ee1073a2
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
