Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD213634B
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859820; cv=fail; b=IOMsxURRbhWtwWF46SYf/2oqevphN4DJ9JooWtCCwnV/7x3xOyZlxkIth3HTr5LUwahyFbaBMo/YTmd7d6xDthc6RluD/5XzquuuQaFguPWqxSGRg7Jop0WzOvvg/zWYQ8sbWKpsOLTBeU/F3GAh5nkHaoSGEEEeyOuhQIf82hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859820; c=relaxed/simple;
	bh=Wj1rKWNQj5h6g1PKaqzaYgstNWKZq4sPoA1rot/jbqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oz6xQyhxtpfqjKvWIew26b8edJMHDVottt3V5pNpjwLuvC4q0i6kMV5ft4fz0hFLaTVQ0NQzE3qYFdB8G10aER6Ve07TZ6cpMh8sJf2vnv80XhnULtN2b2lxIrMQ1F/bBObkAw1fBx4AJmxF5bml3P52H1m8Skf95HyqhYc4RzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vbYom+rZ; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vbYom+rZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2Pu8GBSGOpCSvGII+b1Ph38WF7lzPdjOXgXy9DDv7uapSJ4gI0EGPEkV6bebC3ybjmTGCES2HLsgrluBEvwOZfXbhEAWkykqq8aMNrdu/DV+swn37YCoIP2WXTUXcD61M3bbq8lr9UDsDzvZGT5uNtv3G2QR3C8T3w3IPkmYSu5y86E35TC1a1Otvifvnr1WTjxKc+8n2AXaPEH2u1/xV2oWqvgbCA0fh8niZ8+uAynqvVvbTc7Mu/KihU1YHDxKrhPtA9ikd+BkO6LsL0PFActMpkC//jX1aTA8ZnpmmtTzV9xIStjIKi6h8srb8UUiFtHF/0zl741XkGTKhZw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqNaLxA0j0wNFpMklwWzKSuLcMTdQBOfSvXkNEeyBzU=;
 b=DezK+WH+AR/EJp6UaMId8o9HmapyHUf6KLxEFeNEbZwbVzoiFziPzC42JFSUDmSSLbDUP5Frz27rQ3afcFDp2M20OhEtQmzk1SvhiTi83UyIBGgtVYew0KKtqgqxRFoO+VeBl/ulLOalOaNrebqXFpEPkB9BkkHn3Fw5xzmRjpRIFPuCYh11vPRnPYTSDlOdGPiV5hFFnNRcgpjHm5/VNhr2xdQui5FbNuK2f5rczHcK4csRAstyTCCCaKGKHoLPwr7g5iVTSJtfJuU+hejKQlTHXLSwyB86u5M8wPfbUHMqy+OBWEeueN3X1aIb1D5Gh6fvCi9O7WH2sNqSHsunBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqNaLxA0j0wNFpMklwWzKSuLcMTdQBOfSvXkNEeyBzU=;
 b=vbYom+rZIapttCRHx7K+Knw3LUFH5AuDKTdsNDxTZfuaypDmp6Rf0gALSX1dZ59NrD/Rl/U93K66PKKpvNe+mqnNebTV5OENSL/G+AUWY3SGnF9LAJWsiwzPi4licSvHH8WFoBMsyOm/Xp40vXz2zCIZxm9Af/4ve+to3HP78YitNVKQqEgYMjlMnZrWWS77sQPwEAIc+oMR7gGwq5e2XcC1BRkhGxAoQ0IlzFAG3sbA8nfWojTwQlJfxFUyQDJONCM73jspnmf8zQAe+IdiLP1LD57jLZ3inqwP36CFQq1X1vszl/ytOqvpLZ1NlfGhLgPFgi5E7xsozWw0dZ/xgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:10:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:10:13 +0000
Message-ID: <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
Date: Mon, 5 Aug 2024 14:10:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 89458f56-e8f2-4e50-c64c-08dcb5478f47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0FMY3k1Q21OZC9OMjJjUFJJRXVYY0FISVBlNklXRDNxd3kyNWVqcGh0TXd1?=
 =?utf-8?B?anM0anpHVlpBV1YyVkM0YjNqUGg4M3hoeHlXbXl6aEprMEN6OEF1UDhwWTE3?=
 =?utf-8?B?ZTFoRmxmaVMrdXVxNXBSMmVTQ2plK0RaTWtEeVAvZ0lNWExNK1FXZ3lwamVG?=
 =?utf-8?B?T1dpWlVuK3kxeUFETVZhN2tTSGxPOEJSczBBS1ZGSENVaUlhRE5LcTVOQVRS?=
 =?utf-8?B?WFlCWnBsbEpZekVHR3kvSTVySCtPSTI5T2Z2cmNKR21RelJpWWNkKzk5Mkkx?=
 =?utf-8?B?L0J0b3Y3ckkyRVowZ0pIWkR6anVMYnF4UVNLM1hZR2pFTWhZY1M2RUwzWG9J?=
 =?utf-8?B?N1RMaHhzK3BPS0FJc3Bsa0hsUjZ3MTZuN0RKTzY4dmN1YklVa2wrSXp6RUdE?=
 =?utf-8?B?M0JuZXhhaEJuaDNTUjZNOTF1QmFvWDBVR2VtMlV6Ynk3aGhibDJsMko2OFBB?=
 =?utf-8?B?UXRnQkZDazAxTm5qTkEweGV2RVBiRlJoV1F0ck92TENzM0JTN2VEc3J4Ti9u?=
 =?utf-8?B?R2piTHN5NENoa3p0TEkxUDhZU2JtN1krRWlmNnRhL3hrUXl2WXkxS1hoc3NB?=
 =?utf-8?B?TlVud0tXUzZ4VStmZHdkK2ltZEZOeUFLMGk4SWRKUXkreDd6R1paUCtBa2xO?=
 =?utf-8?B?NkRUSlBZUGZYMUMrSE5PSXp3SDVzQUtUYVlqczdZYmo4NE1LWXU1T1JnTjYv?=
 =?utf-8?B?Qkc1NlQ3ZmtnTkhTVWlaQzlBS0FBbXZwcVdzdUp4WTVVM0VLT3BobHhEVVo5?=
 =?utf-8?B?dzJaOEY5dk1RbzR0YXBBbitRa1pXbTZMT2Z0Y21tSUdWQ2R3TVVFOUhKV21C?=
 =?utf-8?B?UUc3L3F0YVZNYmhyZDBXMlE3b3BhQjlBSmJVdGNGakZldFJjN0lrT1IvRFJ0?=
 =?utf-8?B?THhWalBPeFJHUUpIVXB6RlVZeHY4Z3c4VUxIYVBxVzh6b2hhZlhCNjVOUWE2?=
 =?utf-8?B?MU9pd3NQcE5DY2J6ZDQ4cTVrNzJWYXAyUmpIVCs4Qzc5Q2Z5MXdyTkNPL3Jo?=
 =?utf-8?B?d0x3N0s2WUltQlBaZU56dXYrd0JHQ2pOazgrSEkwTTB6ajF6TEFMbjc0dGVa?=
 =?utf-8?B?UjU5ZFdkRFFGWVVib09VSndRU0pkQWJZYytrUDVRQS9XZHZ0T3pBY3VDT3J1?=
 =?utf-8?B?ZlVCVHgvaEQxSmFFRVo2NEoxYVp1RWpGVE5vODVZaForK1Zoc1AwcVpiRTUv?=
 =?utf-8?B?REw3WldTZ0xlSVg5Z3pmRmE3L1ljMmc4Z1BPaGV4WUIzTXVCQng5VElaSG80?=
 =?utf-8?B?b0NmVkRVL1h4eU94RG1vbjFBRStycXNRZDl6RnpmOWZ5eVVORmpGVVlWM2x2?=
 =?utf-8?B?a0VoQUJGMGo1VjVCUWFpMnY0UWFGMnlkQWdiU3VxMHdzM3U5NE50U0t0VXps?=
 =?utf-8?B?eVltcUtybmRObE50a24yT1FJT0MvcXpIQThOdXNlcUNVWWlHME8xamFjYzdF?=
 =?utf-8?B?ZDhqKzdOcWJBYURTMlUwdjdPb0w3T0s2SHk4aVNjZytKbytyb2VSZXNETWVz?=
 =?utf-8?B?T1NQaTVZbk9QYStqeVpqZ3kwb0pPZDJzTzY2bk1EV0g5b21Ob0w0ai93VUk5?=
 =?utf-8?B?N3VCQ0ZsQmJQODNnbVlSYVoyTnFCbVZUQjBnTUl4dDAvaU85TEpNczIzeGV4?=
 =?utf-8?B?YVhPbndOTERlL1NkOW5yb3hzT01QaXJ3b2N1d3REZ2NMMm9EZ2d5MGhqekZ2?=
 =?utf-8?B?R0tFU2Y0L29odEhncTBJeENLKyt4a2dqUThGUnI3NmFsRFRCa1MvVXNsL05r?=
 =?utf-8?B?b0VaeDV3NzRnRkgxMkhCL045VkJEQnQrUXIyYXpUQXhka09HV2ltSEI1bWxJ?=
 =?utf-8?B?WjhEaTRGc0lZSVdHUi9xUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUtZZ2daVkh1Q1NVQ24vb3VRUTJtL1pRYURKRmZPK2cvUmt3cUVORkxoeUhF?=
 =?utf-8?B?U3BNU3Z1Wk5PZUpMQlM3ZCtnb3NMb2JkVnU2dSsycUlLendnVEFDK0N5Sm1V?=
 =?utf-8?B?OVFJVTZadEk0L2xzRjNXL0JLUnJxWTBzQWw0aEdmRm9YZUoxbWtGc1JGUCtW?=
 =?utf-8?B?UHcreWxLYVlyK3JCKzgwbDM1eWJUU3JuZCt1REg5QWlkb3R1ZEtCSTc3Z0VJ?=
 =?utf-8?B?Wk5mVysyRWtXb1l6REFaTHhWTW0yUGI5ZHZsTzFVTW5JZzZCd2x3cHVCQ1Bh?=
 =?utf-8?B?akVZek5hUCs1d0VXV1ViS0RYc1FRNEh6bkwwMkF6Z2hzU08zQ0lyMVl4RENR?=
 =?utf-8?B?QzFDS0xKRXpoa011SFl2THo4S0RuTURiNmc3clVjOXRFdnFkQVRGaEdGMy9o?=
 =?utf-8?B?aWdvaVg0QWQyMEhOTzhGbnJFTUlzTGQ0ek5tTXFRQ1d0OERYVjZjMkg2Vm52?=
 =?utf-8?B?U211NG9YaHJCNWhGQlhOYmlCU2xINVNwaE9Yby93Sm85b3lwYjBHY0pnWjdv?=
 =?utf-8?B?aEVCbStmZWtyeVZybmRTOGJkZ0FmY0syWkNrM0xqUE5MSFFXQmVGeEJUNStI?=
 =?utf-8?B?Zi8zL2M1NURXZkVVY1UyNThCTUo3WWJaVDJxS0R4Z3FJeXV1TEhYa2pvL0lM?=
 =?utf-8?B?SnUweHlocERVUFpkcklIdCswQTZsdzljNXp5a1NyRjJuZWh6a1pMUlVaZ1dH?=
 =?utf-8?B?NlFmYlhheDkxZndkbGgyVXh4MlVMZmtPWWU4NW5LMjVlSFk1NnFVV0FjMnVn?=
 =?utf-8?B?MjVuVlBQeVlYZHVYWFlNR00xNjBSYldhb3lNRU4zT3hFanM3WllZSEZYTnlh?=
 =?utf-8?B?UzRVT3VvdHFzbkxiY2hIV1ErakcwdDh5bDE2Y0RNcUw2L09ubDZYZU5iRU9m?=
 =?utf-8?B?N3BxSUMweVVMOXZvSFpaN1JlVFpFMHhDdlRGbzB3SEtzOWFIUkpTSGZsVVlE?=
 =?utf-8?B?cUlCRFJzT29KQnhxR1hkQkVjckZ5eEtZVWZnVWVwdStXUkNQS0tFWGhpUmZR?=
 =?utf-8?B?V2kxWEQ5cWdOZndGUlcwTmlGaWczY0t0cWxNSndsNWFwOEJCZEd1aEtPSzJQ?=
 =?utf-8?B?Q2p0Z2FmZGtPRm1sQU43RzVHWDNDU296dEFyRnBZekp4WWwycFpDdDBnUXVu?=
 =?utf-8?B?ZWJHK2dpNGd5NVE4R0VGeUhoL3R2eGJJZ1Zwczl2bnNZQmV6M2xIUlB4Nnov?=
 =?utf-8?B?cW1Qb21GNWd1Q0F4VnRCR3JzT05rS1lETnFRRkluNEIvQWlHY09KLzNBbUx6?=
 =?utf-8?B?ajdBWVpPeGtWMm9HcEhxSjdEb3lNMkJqdUJiaTJISzI3MVdxS0dZNFFjQWxB?=
 =?utf-8?B?dkFWZUFIY05BV2RUT3ZnTittWjg1K1JwQ0xyWHJiTDZpdUE5ajE3cUszWGt3?=
 =?utf-8?B?dmpDMlR0QytKZTNIS2dJMzhNZG1HbnNtai95WlJxMGg4alg1U1N5bTVBUnAx?=
 =?utf-8?B?NkVHMmRkQkdMOUVIVndWczBDK1VNUUZSMGgxRGlQR2ZhV0FUaXFXVXNyM3g2?=
 =?utf-8?B?cnZkcTl6c1FXTDZqQTVhSVBra0ZZSmVJYjdDZm9QTUhIT1JUUnJ4TkhGNUNU?=
 =?utf-8?B?amhmU043clg1VHBuUUNYc3UyWFgxUkdoZWRrdDZQODZSaHFheXNTYldiak5h?=
 =?utf-8?B?ZXpkZ0ZaNm1VRzBYRTdsMDAzRnplZmVWRkM1UXRobkFzZjZmREJoYzY4aitZ?=
 =?utf-8?B?N2pvd0FuMjM4d0o4NUs4dHlYcS81M3czYlNWc0JJMHloZTlwamxkTXllSm9J?=
 =?utf-8?B?STFPRHBzZi8vVDB4SUY5anBPWmxSc1ROWS9tY1RReUVZTWYvQmNRWE9VeGt6?=
 =?utf-8?B?RzFONFFCQWVzT1VuZTM0QlJVVWNKZVRaU0pKMTRrS3QrZ0pZSXVBSSt2eDdk?=
 =?utf-8?B?T3RTUjdDUjJrOG91dWJwSEVjVDZUQlU0Z1lkRTBIQXJIVVJkajQzQnlIVGc4?=
 =?utf-8?B?SHFYVU42YmdHQ1hCcmVEYWkrUDhhZ08xRG82dXB1WTc0TjdpZG1yY1lZcjZU?=
 =?utf-8?B?MlZlY2Z4Z24xbmgzM0ZxeGNUTDNCQVQ3R1Z2dUtndEpPR0tIM0dzQXVGY2ow?=
 =?utf-8?B?UWZ4Z2NuaXovNFUrNGZHdUx2ZXZud3RBTUJ0K2VWY2x0QmJpS21HWmUyTHgx?=
 =?utf-8?B?MjdzOVhST3lVYzFxT2swaHZzNlJVNW5hQUdjQ1FFTGpsL2c0aCtvdlNUdjRO?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89458f56-e8f2-4e50-c64c-08dcb5478f47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:10:13.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bD9zLQI1P7ErJtzrQX3dCP94tqRfu8dFnHgrTeywFYUBZMb/+oKxxGtapRrGYO+gzvZ8Ufh6rvWIcO0cIR1bHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7196

On 14.03.24 15:22, Mauro S. wrote:
> On 02/12/23 01:37, Jan Kiszka wrote:
>> On 02.12.23 01:31, Mauro S. wrote:
>>> On 01/12/23 02:31, Jan Kiszka wrote:
>>>> On 30.11.23 00:24, Mauro Salvini wrote:
>>>>> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
>>>>> <mau.salvi@yahoo.com> ha scritto:
>>>>>>
>>>>>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>
>>>>>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>>>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>>>>
>>>>>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe
>>>>>>>>>>>> kernel.
>>>>>>>>>>>>
>>>>>>>>>>>> The application I'm running (a complex application, with about
>>>>>>>>>>>> 60-70 RT
>>>>>>>>>>>> threads) has a simple loop in the main function, something
>>>>>>>>>>>> like that:
>>>>>>>>>>>>
>>>>>>>>>>>> while (stay_in) {
>>>>>>>>>>>>        ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>>>>>        if(ret) do_something
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> The main loop reads the buffer to receive some commands from
>>>>>>>>>>>> outside,
>>>>>>>>>>>> and when the application gets a SIGINT, the custom signal
>>>>>>>>>>>> handler simply
>>>>>>>>>>>> does "stay_in = false" breaking the main loop, and then the
>>>>>>>>>>>> program
>>>>>>>>>>>> closes.
>>>>>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling
>>>>>>>>>>>> multiple
>>>>>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>>>>>
>>>>>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>>>>>> ...
>>>>>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>>>>>
>>>>>>>>>>>> I also see the thread in "w" state (waiting for a resource
>>>>>>>>>>>> with timeout)
>>>>>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>>>>>
>>>>>>>>>>>>      0  16328  rt     cobalt     50   21ms279us
>>>>>>>>>>>> w          myapp
>>>>>>>>>>>>
>>>>>>>>>>>> Sometimes, in a non reproducible way (at least for the
>>>>>>>>>>>> moment), when the
>>>>>>>>>>>> process get the SIGINT it never exits, remaining in this
>>>>>>>>>>>> status:
>>>>>>>>>>>>
>>>>>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>>>>>      0  16328  rt     cobalt     50   -             W
>>>>>>>>>>>> flxcore
>>>>>>>>>>>>
>>>>>>>>>>>> The state becomed "W" (waiting for a resource without timeout)
>>>>>>>>>>>> and in
>>>>>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>>>>>
>>>>>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>>>>>
>>>>>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are
>>>>>>>>>>>> many that
>>>>>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>>>>>
>>>>>>>>>>>> This is the backtrace in gdb:
>>>>>>>>>>>>
>>>>>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>>>>>
>>>>>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>>>>>
>>>>>>>>>>>            /*
>>>>>>>>>>>             * If we got interrupted while trying to re-enter the
>>>>>>>>>>> monitor,
>>>>>>>>>>>             * we need to redo. In the meantime, any pending
>>>>>>>>>>> linux signal
>>>>>>>>>>>             * has been processed.
>>>>>>>>>>>             */
>>>>>>>>>>>            if (ret == -EINTR)
>>>>>>>>>>>                    ret = cobalt_monitor_enter(mon);
>>>>>>>>>>>
>>>>>>>>>>> But the problem is that the lock (monitor) is no free. Someone
>>>>>>>>>>> else
>>>>>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>>>>>
>>>>>>>>>>> If you dive into mon at this point via gdb, you may find the
>>>>>>>>>>> owner
>>>>>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>>>>>> get_monitor_state() does.
>>>>>>>>>>>
>>>>>>>>>>> Jan
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thank you Jan.
>>>>>>>>>>
>>>>>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>>>>>> But when I try to print the mon variable, I get
>>>>>>>>>>
>>>>>>>>>> (gdb) print mon
>>>>>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>>>>>> (gdb) print *mon
>>>>>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>>>>>
>>>>>>>>>> Seems that the memory address is not in the core dump, but I'm
>>>>>>>>>> wondering
>>>>>>>>>> why
>>>>>>>>>
>>>>>>>>> Did you create a core dump or tried to attach live the hung
>>>>>>>>> process?
>>>>>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>
>>>>>>>> Sorry for the delay, but every time I modify something I need to
>>>>>>>> wait
>>>>>>>> for the issue to arise.
>>>>>>>>
>>>>>>>> I'm working on core dumps. The previous core was incomplete, as
>>>>>>>> you said.
>>>>>>>> I needed to set the coredump_filter kernel cmdline argument to
>>>>>>>> 0x7f to
>>>>>>>> have the complete coredump.
>>>>>>>>
>>>>>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>>>>>
>>>>>>>> (gdb) print *mon
>>>>>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>>>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>>>>>> mon->state_offset)
>>>>>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>>>>>
>>>>>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>>>>>> thus 10 is the owner. Unintended recursion?
>>>>>>>
>>>>>>> Jan
>>>>>>
>>>>>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>>>>>> that atomic_t is treated as a 2-complement number.
>>>>>> Then, the owner is the caller ID. I'm wondering how it could be a
>>>>>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>>>>>> I will investigate a bit more on it.
>>>>>>
>>>>>> Thanks.
>>>>>
>>>>> Maybe I found something: in the backtrace of every core (cores are
>>>>> generated with SIGABRT) the first two frames are referring both to
>>>>> cobalt_monitor_enter(): frame #0 is at the source line where the
>>>>> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
>>>>> function declaration source line:
>>>>>
>>>>> Program terminated with signal SIGABRT, Aborted.
>>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>>> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
>>>>> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
>>>>> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
>>>>> #2  0x00007f0d76612748 in cobalt_monitor_wait
>>>>> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
>>>>> ts=ts@entry=0x7ffe7d7380f0)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
>>>>> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
>>>>> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>>> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
>>>>> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>>>>>       at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
>>>>> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
>>>>> ptr=<optimized out>, size=<optimized out>,
>>>>>       abs_timeout=0x7ffe7d7380f0) at
>>>>> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
>>>>> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
>>>>> size=19216, ptr=0x55b104844180 <Request>,
>>>>>       bf=0x55b104844168 <ReqBuf>)
>>>>>       at
>>>>> /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
>>>>> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
>>>>>
>>>>> Could that be a clue?
>>>>
>>>> That alone does not tell a story. We know now that - at least according
>>>> to the monitor data structure - thread with ID 10 is holding the lock.
>>>> If the very same thread is trying to re-aquire it, this will cause a
>>>> deadlock. And if that is true, we need to find out, how that could have
>>>> happened. I have no idea about that so far.
>>>>
>>>> Would you be able to factor out a simpler, sharable reproduction
>>>> case? >
>>>> It also looks like as if the reader is receiving some signal while
>>>> blocking. Is that expected based on your workload? It may destroy
>>>> timing
>>>> constraints, even without the deadlock.
>>>
>>> Yes, I think it is expected, the workflow is the following:
>>>
>>> - a daemon starts the program
>>> - upon an external request, the daemon terminates the program sending to
>>> it a SIGTERM. I think this is the signal received while blocking
>>> - when the SIGTERM is received (a sighandler is installed by the main
>>> thread), the main loop (where the rt_buffer_read() is) breaks, and the
>>> program performs some cleanups and then exits
>>> - in 95% cases, the program terminates well. In the remaining 5% cases
>>> the program hangs on rt_buffer_read()
>>> - if the daemon detects that the program is not terminated after 30
>>> seconds from the SIGTERM sending, the daemon send a SIGABRT to generate
>>> the core we are analyzing
>>>
>>
>> OK, makes sense. Based on this description, we may indeed have an issue
>> around Linux signal processing here. Now it's about making it
>> reproducible.
>>
>>> I'm trying to reproduce the issue with simpler programs, but without
>>> success for the moment.
>>>
>>> I will update you (hope with better news).
>>>
>>
>> Thanks in advance!
>> Jan
>>
> 
> Hi Jan,
> 
> finally I managed to have a piece of code that makes the issue
> reproducible. It's not exactly small, but not too big either.
> I hope that this makes the issue reproducible also on your test system.
> 
> The zip contains:
> - a little main program (test.c)
> - a little library (in mylib dir). Some pieces of code are never
> reached, but leaved to avoid potential compiler optimizations that could
> remove other relevant parts (maybe cycles?)
> - a script (build.sh) to build the two components above
> - a script to launch the test (start-test.sh)
> - the configuration of the kernel in use
> 
> After building the program and the library with build.sh, you can copy
> on the target:
> - the start-test.sh script
> - the built program xeno-test-session-hang-on-exit
> - the built library libmylib.so.2.0.0
> and create the library link /usr/lib/libmylib.so.2
> 
> Start the test with "./start-test.sh &" and follow what happening with
> "tail -f log.txt": after a time that varies from a couple of minutes to
> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
> line: the hang is happened.
> 
> A small recap:
> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22

Can you only reproduce with this setup, specifically with this compiler
version and only on real hardware? If you rather use xenomai-images and
qemu/kvm target but still the same kernel and xenomai version, the issue
does not occur?

I'm trying in kvm right now, also with different compiler. Iit would be
good to align / rule out variables if my first setup turns out to be
unhelpful.

> 
> Some potential interesting things:
> - seems that application arguments "--session" and "--cpu-affinity" matters
> - seems that compilation flags matters

Which compilation flags are you referring to? I was using your Makefile
now, will that give me the right flags?

> - seems that splitting the code in an application and a library matters
> 
> Thanks in advance, regards
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center

