Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C311CDFAF
	for <xenomai@lists.linux.dev>; Mon, 14 Oct 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945557; cv=fail; b=Kyu3rlNWQv/6btvf+Vb2Z1VjwfmuxKR63Cupfrwljbl0swSqdLzqwL2eC+qGo1QOtRj3mJ17rOCR/3X+RKKmbGtThADZWCNogHmJXGBXYYYm852MGU68kqY3lwirCPOh/Ldb+kqbzco+dlCISn2z1hGOHQJfUNcJOWgR4l+ehdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945557; c=relaxed/simple;
	bh=c2F2ajBafNAyQ5b2UvXFJn5svzUpv5GlCO3b5IoREFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=chSes+yCjB6+8uf/wbG04Qhbfw/fdTWt3RU5X11egWqL5mjClQi6vDFj++Djy/A6mKhlMnH1/X6jzdRYcSeRb2AZZrUsWexdlXHn7ZUMRZ80yGHXiBl3vIHXJTgmy5V2vCbYuJue4aUWnAoafkmi5PNfckN6CGC1Oj3088wWFhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WwOgnyow; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WwOgnyow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBe0TIbyevbwx4Cjl3Zh5SRebB4GMO7jqW7K1MxYsRFPA5JCWBUMEG7pAcJGJfgsBS5x4iXcypssrFnsJ5kys2OFbKFGfVciNeeY0V3XjWeDQWz3iEAp0UUoZO8LOwx8OdMRn++AOIO4zUN07OxXzl1061od7+YLOddqDdIMph6sYpiPAEL5uJWTrLqGytzTXAbKB0WYbHzEIqmqixIsSCTSQo4XNibIoSacvUykDpVXD7vYYw8jmFuYLqnPApyqIgibq6huPPSqOXEeJWU9M5lmS+V9vCgVU5ZjgnFGLB76Pmtk35EppYkXZOyAwXPy5bGm5Ljq4AEfsOuZxr6E9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tGyZWUJiRI1Dy9r/3owjrCVvkWQLjzd11GhPbNm88c=;
 b=lxRL3KobIQGk81wufOaFD3SdKnuWImKZx2q3lXVRz0rlCn3YLLTnLjqdrLeazwaNkcJx+6zu6XMmO3WLg+xrTaTCO7mB01HX2V6KqU2ieXmpP8jPLLt4omBJKQUZmvII1FV6s3bQN2vWMy2vCZU9KJ5x9LJ+r6XInkizV2huT0VaU0mmfxlS0b/6tat68aDUPa7orQhBDg90OSpe1hs8C4l5myzxQsYHCBHSMcakxZA1XXXo6NrLh606jHJYxWDUnALs5F4PmhbCiDJFdRGJfg5GWQH5K4w36m5dqmoW3MXUBpMdUBpiZPYzqaUacnhpXYPquDayIhYFEm5NrzlAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tGyZWUJiRI1Dy9r/3owjrCVvkWQLjzd11GhPbNm88c=;
 b=WwOgnyow8shC/WaUTwCZEphi1B4Dg2N5dLt5UfZY1COMecgiBgKjThf6+ZvFjF+6n7LUGo/WvT6tgHjIdXTJswm9g6D34JH8EjXCtCk3YT8KvUwawgtLgS7wIbxokGblpt8TFs5Mzo1x7GC8cNebv12SxN695E+P2XRzCjpZGlYTX0M7/hT0+B8FEPu2Hh6QFQhqggBTqyjgFWkiTCjYaJzAxjYs6E0dx0V+bjvocmbOxVPXMUwoWzOKoMmQE9BoAWCxSWmWp8LzKjaQSSfqtqvMJYA7R8O5M2MuA/w4/AViQ96ZCmU1iPzKqGrEOtvcbe02qKrQ2+hgfrb322QJoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Mon, 14 Oct
 2024 22:39:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 22:39:11 +0000
Message-ID: <aef60503-252b-4a9e-8ee3-e50d86c3c71d@siemens.com>
Date: Tue, 15 Oct 2024 00:39:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Dumping my refactoring cleanup queue before the
 upcoming release
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 58825a1b-aa4c-45fa-f1e7-08dceca1060a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBzN0txOFI1UFpDS0lqaHJIMThzTHowdUN3QzBWdTdCS0dBRGkrYlNNZXVB?=
 =?utf-8?B?b25KbkRYa0x3TnU2Q1hSU2ZpMVNuYWRGSDJ4YkNBRjNUU2FWSHN1cUhpUWpC?=
 =?utf-8?B?OHpUNyt0SVNCSUN0UlE0UnNTbks4dSt6eHg1MGhXZUQwd2tJcXR0dWdFNkkw?=
 =?utf-8?B?TEJOZDlRNkg4bWhtZG5JTHdNZDEzdEJzcG1pNFVZMFJmOEh5b1NPUWs4U1JQ?=
 =?utf-8?B?cnVuZ1gwejhsSUlIWFVnNlNlWlFNKzhmZlBZdGpVc3dkc3dZNkhCTmNUcjhW?=
 =?utf-8?B?U0FIaG5ySzJYcWtHRCtYSk5YOEZDYUVPVUFoWVVxbVFLUk9ZQmFPU1NxL3VD?=
 =?utf-8?B?bzByYXhNVFJqTFp0REs0SkZBNk5wRjQ3NndMQnRyK2M5c0RvUVh2aXRPQklp?=
 =?utf-8?B?MlZ4SkFwbG01bHdNbUl3ZFhwczArU0ova1Z6MHNiUE5HdHNVQ3Z4WmdHZWoz?=
 =?utf-8?B?ay90NzZEMmUzek8vWGJESWkxVUpib2FwZG9yTDA5QW9xdmhwSTlHQjV0MEJy?=
 =?utf-8?B?VnhrM0ZiUkMwUEVRbWdmT25Wb0RJM2RtZ2diR1UyZVEveUlNbnhKY3Z1UDd4?=
 =?utf-8?B?NmpJdExkeGlrNU9IMlNiQW80bnJ4RVNOL0duZThFWmRuQUpKNDBIV3RaWTJh?=
 =?utf-8?B?S0xnZzNEcWMrTDBhNTRsQnJucEdEQkNzbjNPUkNVcC9nSENNK2FxMjV5c0Er?=
 =?utf-8?B?OHRtbHZWd3ZWYWl1dTVvbzY5Z2gzZThBM1hjSnFVRW9VRDA4cmFuQmNJNW9l?=
 =?utf-8?B?UWcrNGVEVXI0UDFkMTlxQVZGTzhoNDBLRjVTUTdxK2xJcm5BaDZ5THRKYTNa?=
 =?utf-8?B?MFBUY0ZCeHpaSG5ReUZvUm9UamljVWMrNDJqSFovZWlrSzRnM1kvYy9GMk9M?=
 =?utf-8?B?eWRoaFlJbm4yT25tUDgxaVlzTHZjSTBGV09rVVVIQXpnVHlXZFpmU0tqNHFr?=
 =?utf-8?B?b01wbXQySXZMZ3paRC9BVk1rSy91YzdaQXpkRUZUcWcyUWRPbEhtbzRweHNZ?=
 =?utf-8?B?ek1IeklVWUpiTW9OdzFBVW5EZGZFQ0E2VE9SNXgwZzZiVjVBM04yaGlXTnBq?=
 =?utf-8?B?d1JVM0RZUjg0QzBWbUY5d2ZYK2Q0ZXBIcnQreG1OeW9MaU5sRy9NNFZ4SmdL?=
 =?utf-8?B?Z1FnRUE4SHVrNkJDcTM1b21iemRnaFV2YWRrR1VHbXVvRmx0WitpaFpNK3FS?=
 =?utf-8?B?TUxoVmwwaW9NcFdvTXd4TWFPKzNlY1JzbE5oZTB5SGh6OFJjTUNibEZBcmFp?=
 =?utf-8?B?eEkyM2ZNUlYyR1FKKzkzcURTR01jTXJJSVFTWWRUZDJjcngrMWc0bVQ4Q3Vh?=
 =?utf-8?B?bnJzYmJDWHNieVNqd3JXYVR5bFp0MHpaNHdmQ0I3S0Irc2lxMWwyalRjUHJI?=
 =?utf-8?B?azludWNkVWlMZGlaL0pOMkh1QURVZkdabFg1ZXlaL1NKa0FNbmVRYWdGQmNU?=
 =?utf-8?B?K2lmY0liRjBCTEpKV3pBNit4Q2tzMFk4TW5HZi9OajdveXQ3QmM1Tm9XcHpW?=
 =?utf-8?B?L2plUVNQT2liZVREM3ZpTFpNVE5PYTB3MmQ4OVFzeCtra3JMVGNpNG1HUklx?=
 =?utf-8?B?YmdZdkhCZHR2S2N3ZWxoT2swNWQycHVpb0ZRNklpb0hyVzJucHFMdS8yeWIx?=
 =?utf-8?B?Qk5UTjhBeWs5NUg0SFJQcU1sQXFjODZYYU5LWkhqRzQzcGF1eHp0K04yTzNx?=
 =?utf-8?B?ZlNxU2luMXBzQUNlNUlxbXM2cDM0UFNkUUl2Qi9JMENqeWIwaHhrSE53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0J2NE5RY09OUjRDeUlCYmlBQ2ErZ3FnUCs3UEw2TjFEbGNTeEFUV1FiZXM0?=
 =?utf-8?B?Y1gwODZZU0JNYjZsdmZ5T1NyQzVCWnltZnNzcjUrcVBxMm9aL2hvdEJNOU92?=
 =?utf-8?B?U3FpR3Zna3FwajM5Y2w0VTc4VWhNZ2I1VnUyMjM3cmRGMldyOUNHY21mVFBp?=
 =?utf-8?B?MU5yek5tYnBKcTNhczN6Q1JGc2J5VStZVkVCQm96WUU0WlQ0YkxmanlYRnho?=
 =?utf-8?B?RE1FclJwdTl6a2hRazlIVEVod3IvcU44SGh1eFp4RXBCdmgvS3ZDSjBxZ2tN?=
 =?utf-8?B?bDArdUJoSVNTbmN4NWIrMTZrbEt1TlBVN04yU1NnOW9ZVjdobW11UkQ2aURJ?=
 =?utf-8?B?eXE3QnZRODlkZ2d5Z3ZuZU1CMkI2aE92QVF2Tld3TFFWc0hEWnFwOFVYczRi?=
 =?utf-8?B?cEVpb0pLY1I1SGRnbzJNMnF1cW5pZVlrZUMyKzk1eTlIWkJJa2tVbm4ya1Ra?=
 =?utf-8?B?V2xpR2xkMjJqSzRRc3JsRUtwRzNWdVN3aUk4U0NVbEZuQzU2MUNKQ0lSbnYz?=
 =?utf-8?B?QWcxaUhNaEdhS1FQbXYrVVo1NzRhc25ubnNoclhRNW9GcDBYaDNPdHhFWm5j?=
 =?utf-8?B?VVZRYmlVbWpvYmZ0SVBJQ2s4Y3lvSGUrNDY0N2RaeG5vVzNtdTBqSXZPQXQz?=
 =?utf-8?B?QXlTcEpBaldjV0J3enhwSlN6ZWUxQXA1djdBZmZ5RDNCTGJFN21NRHpHeitm?=
 =?utf-8?B?Yzc2WmNmZTNSUnR4dlVmeGtwaWxwRmZoRUZrYVR6QXNXWjJJZjNZbUViMmNo?=
 =?utf-8?B?a1Y5NnJqemZpMTNHRkRjbFQwNk9qVnVNdkNWd2piSjZha2JoUUlqN2Q2MzFj?=
 =?utf-8?B?eGNvVmFTM2Q2ZmpPWGVXWXNOVkxYNlVHbVdqODM3d3EyZjYrYkNYUVFMK2tL?=
 =?utf-8?B?am9hQ3JMandMMy9qOTNONzkvTEc5ZmpJZzljQWxKQmcwYVBxdnVoZTlRc0xl?=
 =?utf-8?B?dVFGSDhOc09KTWpIdXN4RXJ5WUFwcStnenMraEpyZzl2V294MDE2SGI4NGdr?=
 =?utf-8?B?bi85aTlRZHVxUE8weVZQejBNRXlHbjFyakhuVjFLSi9JbTA0eHlwNWNTc1FB?=
 =?utf-8?B?Z2dPT1JhUDN5YXFXeEhFZlFTb3VoZVZ5ZU5Mdmw3dGEvdDJCM1EzczZ5RzU5?=
 =?utf-8?B?NU1EaTVXOFlOV2JXcVczOVY0bllQVHpIa3hTNlJTV0NTZGFTblBLQnlpcWpx?=
 =?utf-8?B?S0RBYzBEaXpXWHNLV1RJZkhxUFpzRENxd3BXeDdwM3ViN29ha1prY0JsRnhs?=
 =?utf-8?B?dFE4TkFHdjZKVzBlODFTUm80NjNLdmdmN1o2enVwTXhhbDlaaVN6VElwZUNz?=
 =?utf-8?B?Zk05VUFzUVcySGRwN0t6bUQ4NlVwTnliUVgvb3JPbHlxQmpzUDVZTk1TcFJW?=
 =?utf-8?B?aE9QeExMNW5aMlNNVHEzS2lncWE3SGhiR0JSRFkxbll1TXRBcnZBU1B0Tk5m?=
 =?utf-8?B?RTlLRGM1d3NlSzI4OWgvVVg1ZWdaZnFKd1B6WktRakY2TVhLM1d2eXZwSjdL?=
 =?utf-8?B?Vi82YkNqVll0TU5FRjlEYmhkYm9BbjZyVlk2ZWRhb2U5SmlSQ1Urck1VSkVT?=
 =?utf-8?B?c21LWStYQlRBM250ZkxEN0p1aytRN0RhcUdPb08rL21XUTNPUjlJd3MzYW5o?=
 =?utf-8?B?SytZOGZqa3pIakE0NWoydHQ5WE42azVoVmZ5QUpCK1hib3V5VTR6K0NmNlhZ?=
 =?utf-8?B?aUJxaXg5VFFDLzZkaTc1RERCdUN5bm1GdkdDYmpTZi95TW1KVlV5aEhwTm5J?=
 =?utf-8?B?azdSWWtYOVJVUjZleVphbEM5NkNNTllodmF3TGZvSWNwSzBFS2NLTnZLbVBU?=
 =?utf-8?B?bWZIaW1RcDZueTl5L3VUUG5NR3dEdWtaU2ZsYTNpRThZMng4RmUwL2x1eFBn?=
 =?utf-8?B?eDU4YVJWUG04ZWxuTm5halFGTTAyUmNHbk01c1BENTFvZHRtakZDWTQ4dU1S?=
 =?utf-8?B?b1Jickt1TmJIdFNVbElDN1hHTUtwWHFTQzdCUWtKemNPa1N2cVVnQmhSd2lC?=
 =?utf-8?B?MnNpQ0NKK2xPa0RPUS9pUXloZGQ1a3B4SUxlYkJ3VEZIRlQzT0YrQkM1RHFC?=
 =?utf-8?B?N1JwdlJuRDhPWnpBeWtWaVEwMWlQUzZQMVMvR0xjbW9NVitRVDhJc0dnOFB3?=
 =?utf-8?Q?+tSdmjXomP+vWeERUzwPLGc4m?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58825a1b-aa4c-45fa-f1e7-08dceca1060a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:39:11.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg+QIVWIHGgkPwKtFzv7sdB+6UWck8toD6z/VkY5B5pyK5IiYz0GiuOP405eI3esaQInzTNrYSsYxzerbhJwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6867

On 12.10.24 12:26, Florian Bezdeka wrote:
> Hi all,
> 
> this is a summary of cleanups waiting in different feature branches. I
> thought it might make sense to dump that to the list to see if there is
> interest to get that into the upcoming release.
> 
> The header cleanups are just housekeeping. Helping to speed up the build
> a bit. More or less drive-by fixes.
> 
> The second part of the series might need some more testing / discussion.
> This is a cleanup that is now possible after the armv8 compat
> implementation done by Clara. All architecutres are now following the
> Linux syscall ABI, so that we can clean up a lot of our own SYSCALL_
> stuff and switch to syscall() provided by libc.
> 
> The next step, definitely out of scope for this release, is moving on to
> a prctl() based infrastructure. I have that ready already, but that is
> future work.
> 
> As the cleanup got possible during 3.3 development I thought it might
> make sense to include the cleanup as well. Might help to make
> backporting of fixes easier.
> 
> Let's see, happy reviewing.
> 
> Best regards,
> Florian
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (7):
>       testsuite/smokey: Cleanup of unused includes
>       testsuite: Cleanup of unused includes
>       libcobalt: arm: Cleanup unused includes
>       libcobalt: arm64: Cleanup unused includes
>       cobalt: sycall API: Remove architecture specific implementations
>       cobalt: sycall API: Reformat all XENOMAI_SYSCALLx call sites
>       cobalt: syscall API: Remove architecture specific parts
> 
>  include/cobalt/Makefile.am                         |   3 +-
>  .../kernel/dovetail/pipeline/vdso_fallback.h       |  19 +-
>  include/cobalt/kernel/rtdm/fd.h                    |   1 -
>  include/cobalt/syscall.h                           |  56 ++++++
>  include/cobalt/uapi/asm-generic/syscall.h          |   1 -
>  .../cobalt/arch/arm/include/asm/xenomai/syscall.h  |  51 +----
>  .../arch/arm/include/asm/xenomai/uapi/syscall.h    |  28 ---
>  .../arch/arm64/include/asm/xenomai/syscall.h       |  47 +----
>  .../arch/arm64/include/asm/xenomai/uapi/syscall.h  |  28 ---
>  .../cobalt/arch/x86/include/asm/xenomai/syscall.h  |  53 +----
>  .../arch/x86/include/asm/xenomai/uapi/syscall.h    |  23 ---
>  kernel/cobalt/dovetail/syscall.c                   |  34 +++-
>  .../cobalt/include/asm-generic/xenomai/syscall.h   |  26 +++
>  .../cobalt/include/asm-generic/xenomai/syscall32.h |  20 +-
>  kernel/cobalt/posix/syscall.c                      |  70 ++++---
>  kernel/cobalt/posix/syscall.h                      |   7 +-
>  kernel/cobalt/rtdm/fd.c                            |   7 +-
>  lib/cobalt/arch/arm/features.c                     |  17 +-
>  .../arch/arm/include/asm/xenomai/Makefile.am       |   3 +-
>  lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  | 122 ------------
>  lib/cobalt/arch/arm64/features.c                   |  17 +-
>  .../arch/arm64/include/asm/xenomai/Makefile.am     |   3 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h       | 104 ----------
>  .../arch/x86/include/asm/xenomai/Makefile.am       |   3 +-
>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h  | 216 ---------------------
>  lib/cobalt/clock.c                                 |  11 +-
>  lib/cobalt/cond.c                                  |  11 +-
>  lib/cobalt/current.c                               |   3 +-
>  lib/cobalt/init.c                                  |   5 +-
>  lib/cobalt/internal.c                              |  23 +--
>  lib/cobalt/mq.c                                    |   2 +-
>  lib/cobalt/mutex.c                                 |   3 +-
>  lib/cobalt/rtdm.c                                  |  20 +-
>  lib/cobalt/sched.c                                 |  24 +--
>  lib/cobalt/select.c                                |   6 +-
>  lib/cobalt/semaphore.c                             |  14 +-
>  lib/cobalt/signal.c                                |   2 +-
>  lib/cobalt/sigshadow.c                             |   3 +-
>  lib/cobalt/thread.c                                |  24 +--
>  lib/cobalt/timer.c                                 |   5 +-
>  lib/cobalt/timerfd.c                               |   3 +-
>  lib/cobalt/trace.c                                 |  10 +-
>  testsuite/clocktest/clocktest.c                    |   2 +-
>  testsuite/gpiobench/gpiobench.c                    |   8 +-
>  testsuite/gpiotest/gpiotest.c                      |   2 +-
>  testsuite/latency/latency.c                        |   1 +
>  testsuite/smokey/alchemytests/sem-2.c              |   1 +
>  testsuite/smokey/alchemytests/task-11.c            |   1 -
>  testsuite/smokey/arith/arith-noinline.c            |   2 -
>  testsuite/smokey/bufp/bufp.c                       |   2 +-
>  testsuite/smokey/cpu-affinity/cpu-affinity.c       |   3 +-
>  testsuite/smokey/dlopen/dlopen.c                   |   6 +-
>  testsuite/smokey/dlopen/dlopentest.c               |   3 +-
>  testsuite/smokey/dlopen/libalchemy-test.c          |   3 +-
>  testsuite/smokey/dlopen/libposix-test.c            |   2 +-
>  testsuite/smokey/gdb/gdb.c                         |   2 +-
>  testsuite/smokey/iddp/iddp.c                       |   2 +-
>  testsuite/smokey/leaks/leaks.c                     |   4 +-
>  testsuite/smokey/main.c                            |   3 +-
>  testsuite/smokey/memcheck/memcheck.c               |   2 +-
>  testsuite/smokey/memory-coreheap/coreheap.c        |   1 +
>  testsuite/smokey/memory-heapmem/heapmem.c          |   1 +
>  testsuite/smokey/memory-pshared/pshared.c          |   1 +
>  testsuite/smokey/memory-tlsf/tlsf.c                |   1 +
>  testsuite/smokey/net_common/server.c               |   4 -
>  testsuite/smokey/net_common/smokey_net_server.c    |   3 -
>  testsuite/smokey/net_packet_dgram/packet_dgram.c   |   3 -
>  testsuite/smokey/net_packet_raw/packet_raw.c       |   1 -
>  testsuite/smokey/posix-clock/posix-clock.c         |   4 +-
>  testsuite/smokey/posix-cond/posix-cond.c           |   4 +-
>  testsuite/smokey/posix-fork/posix-fork.c           |   4 +-
>  testsuite/smokey/posix-mutex/posix-mutex.c         |   3 +-
>  testsuite/smokey/posix-select/posix-select.c       |   5 +-
>  testsuite/smokey/psostests/pt-1.c                  |   1 -
>  testsuite/smokey/psostests/rn-1.c                  |   1 -
>  testsuite/smokey/rtdm/rtdm.c                       |   1 +
>  testsuite/smokey/sched-quota/sched-quota.c         |   3 +-
>  testsuite/smokey/sched-tp/sched-tp.c               |   6 +-
>  testsuite/smokey/setsched/setsched.c               |   2 +-
>  testsuite/smokey/sigdebug/Makefile.am              |   2 +-
>  testsuite/smokey/timerfd/timerfd.c                 |   2 +-
>  testsuite/smokey/tsc/tsc.c                         |   5 -
>  testsuite/smokey/vxworkstests/lst-1.c              |   1 -
>  testsuite/smokey/vxworkstests/msgQ-1.c             |   1 -
>  testsuite/smokey/vxworkstests/msgQ-2.c             |   1 -
>  testsuite/smokey/vxworkstests/msgQ-3.c             |   1 -
>  testsuite/smokey/vxworkstests/rng-1.c              |   2 -
>  testsuite/smokey/vxworkstests/sem-1.c              |   1 -
>  testsuite/smokey/vxworkstests/sem-2.c              |   1 -
>  testsuite/smokey/vxworkstests/sem-3.c              |   1 -
>  testsuite/smokey/vxworkstests/task-1.c             |   1 -
>  testsuite/smokey/vxworkstests/task-2.c             |   2 -
>  testsuite/smokey/vxworkstests/wd-1.c               |   1 -
>  testsuite/smokey/x86io/x86io.c                     |   2 +-
>  testsuite/smokey/xddp/xddp.c                       |   2 +-
>  testsuite/smokey/y2038/syscall-tests.c             |   7 +-
>  testsuite/spitest/spitest.c                        |   3 +-
>  testsuite/switchtest/switchtest.c                  |   3 +-
>  98 files changed, 321 insertions(+), 944 deletions(-)
> ---
> base-commit: db203dc68964235b1c6b549bfaa2c3b88f736814
> change-id: 20241012-flo-cleanup-before-release-a90d9df08d07
> 
> Best regards,

Thanks, I've applied 1-4. At least 5 is material for the next-but-one
release, and the other patches depend on it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
