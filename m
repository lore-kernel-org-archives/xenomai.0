Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDA350D47
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093184; cv=fail; b=EXwmoHoUnvJb/6DtMvCH3vc7uR3L7HteLIj3WCYgzE+vvfmSWGWH9tIBqn2Xc1Pgj7TFl0Z5TvHftfMTnm3NTQpJehj1auQ5k6PZf1e+DwEFoJ9X+tXR7AHyplpyioj0wtJrdrEcI5+awFrzBOdQWy3wVx6WFWrZk/umuhqP1fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093184; c=relaxed/simple;
	bh=xKMpUA6wQ2nZX5DtCIEyYgDK00EwJVUv+MAxFbi513k=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pdM2cNsf9fGg2rdBbCagUL//jIIKxjnNMiqIhGMC0JyRay3kynpQUIXfLT/tTEn9BEW6xWLOB2t1+IRBSlz154fO9uC5IPjaj3pK6hJ1YrTwVMKJ40rqL4ymLMst+okcLKjDSMxElhHHDnhEe6LSlhBKAQlxklo9NIEcAoRlRuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=P2cJYir1; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="P2cJYir1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv20AVze1Cpp1buJsTF2iS1vnYJB9GakKAWXKSYu8NGrfs6RjpQLH1dWFYljbpJYDP4VLU47xK8hoXopq7jTugawQqgzy+6/zHFIayrZrRUGxEOclqakpb1Rwd1P/rAjt02gqSkX8FLR9xr9yv81Rnzvit6r8bxlRsY+gEoCZg0yhHqiZgsue9gvDGpFd3hCfFCi/HO7pIlmj7veh3K3AL/UWnTDO3YdO19taEIeSb+tXCSZ/lvjcmzXMwmIHE+4kSo/9v3A9hW6wr955mJxih9nwZq0gwV6HbqLz09zfchStCfPMDhUh//utlk+Bgw92xwJ5JNIa6lauOBW/0SfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxZ9rPPYykhuEu1umvo3hr9JL/uq22kUIuGoEs1wi4o=;
 b=T5Adq+g8blWRvYBODUoMmIsTvu9JPZ2nQImTbi5g4MmyKymqbwry9vmRGqA9RHB/EMp4BOjZwguFRIWH3f6YQeNod7pWl2IAZPfb9Spq/2c/RDoFwsXMbVmKYLjBHz0iRjIqWw0HUFfhWzR4ba5bJTULSVkzTOXAB8wJIU4EqDPR7pOlJjH2V9SXKEH7hpJEVtLGgL8RJ0ner8iatDmtsTX3hy/zaQt/HWe5ql9FtWTOYN5K31RDPHL78be12lx1fEzBWYKV9jCuIe9q3so4aTi0QaYNlL3jvanzvhZwiEQQ88X5Elr1LKlOA490w0jEDaf7gYwLaIxOn8djEhSIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxZ9rPPYykhuEu1umvo3hr9JL/uq22kUIuGoEs1wi4o=;
 b=P2cJYir1ANQ/HHJF8+f8kMbLnT54FuiEMYk3WyUleboLedyEzseMLWY0m3uIaUWa4DDyNw3IIzquCmZ/De3ipxSQUJYFuH1jziuKnLzNYsIS4yvOFPGg/QIMA/y5RQK4XV8tQhZzgsPUWGqInoKJ1G7C7v0dVSmv+Hx2vrzhCAOEATeSn4uWQHSUM0BvFFQCjfxeW4lIoocpvUP3jFJviXrpZGqTFxJDzV4Yqv5zoZxtKWS4pAFtI/K5jqKSEDgoy8ocbUBMAC9bAvNqMLmuqt8YWb+vEW1ZyF6qKTJXA4l0TsWu4O0ndLRN0/hU18H6cSWxU/vHlMUsO9FPua5meg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 14:46:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:46:19 +0000
Message-ID: <1141d131-a699-4050-8f38-8775cfe13f6a@siemens.com>
Date: Thu, 22 Jan 2026 15:46:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
 <8ad846eb-c7b6-4056-818e-9e12f8a94cb2@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8ad846eb-c7b6-4056-818e-9e12f8a94cb2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0181.eurprd09.prod.outlook.com
 (2603:10a6:800:120::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b64b6d-220b-463f-385c-08de59c5010e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndkeVY1bmJrUVpFdkhWclgvek5kL1ZrZ1FaL2U5Z1ZVMm9DS3BGRUpQbk83?=
 =?utf-8?B?b3VyeStpSm1HdWpka2QxL3d4bklTQkZIQ0lScXBuWUlqY2R5QmhnYU91bEov?=
 =?utf-8?B?M0dpMTAzaFJLNkhsSWpidUdsUzRLbkZzL2Z2UzFNRm5mNGVHOEc2VHpiUkJk?=
 =?utf-8?B?aWtETWQwYnpRT2E2K3VQVUJBZ0NNTHJObGVEZlUwVXFyUHplS21MZjR0ZnY5?=
 =?utf-8?B?UGtsSWN4TncvVGhMNUJxcGxXTG50WFMzWjhRa0QyOEw1NGYzaXAwRDVCMU9s?=
 =?utf-8?B?cXNSU2szTUZlZk5GSGdPZXZITXZoK2lGQWlENUdPYmhBV2ZNamxCRXNJRXJN?=
 =?utf-8?B?eXlXcDRHd0RPamJlRk5uUTRDY24rbjNnYjBEYTBrVUVCSG02NXZ0d2Uxektm?=
 =?utf-8?B?YkdGOUdOSFlXcWREbUlLYXFTVDdnUzRYeDJ2VUwzMGE4bXhYZXIrUUNWcVBN?=
 =?utf-8?B?T1VVQTZkb1QzTmptZEJWV3lkRElaOTJuR1pBUzFWcU0rWnVNclptbDBLNnIx?=
 =?utf-8?B?ZHRBMTlSeUsyWHpRNVZpM3hGRFJ5TkMrcXQ0ODlzdFFUbTF4NUNHK1NWQUJX?=
 =?utf-8?B?U3E4OXhzYjN4K0VBbFoyenJRM1B5RUVyWGxZVlZMZTZFSXoyZHdTZXZESHpZ?=
 =?utf-8?B?aWQ5aU15V0l0c1J1TGpqK2dLZWtneTg0VGpMM3g1LzlxR2N6ZW1Ec2ZwRmJ0?=
 =?utf-8?B?SDdhbXN5eDMrb2kzMldOUlNpRmM3dkt4aDVvMHVJM1psS1MweUY5NEsyeW9q?=
 =?utf-8?B?UWpoQ2doaGdXR0xRcUloUHMxOHhEeUVIU2hvSDRvRHViV3B4M29ERVJSd0I3?=
 =?utf-8?B?ZGczd001RlZMZjBsM0hOV2RyZ2czbnJpTkROcUt3RkozZUwwdVdER1A0cnE2?=
 =?utf-8?B?K3VxZWI0ZGQ3NXAxb0VTY01PZUhMcThhaEpEUzRkTFVSdmhGSFBnYjlWZVdG?=
 =?utf-8?B?RzJaMVJFL3pXT3lkYmlvVGIyTy9FUUlURTBMS2wrdWFkdVRtU0toM1RkL3g4?=
 =?utf-8?B?TlZEaS9LU2pHVEtNRldrTGVRL0pMaWY1MUJ5RWUzZWVrNW5wNEJBeEIzWGZr?=
 =?utf-8?B?RHh1TEIraW4rWnpaOExIUUdmc3lNNVF5enlFdERKV2JYdHpYRHRQSzdDWEFM?=
 =?utf-8?B?bDlPa1M4R1NCVkhTRDlRR096QlRnUUNJQ3JYSkVNVWlGWkRwaCtrcU1kNEVM?=
 =?utf-8?B?ZUsxT2dQY3ZOaTFHaGphOUhRQzM0Q29EMW5Vdjk2ZXZXVGpidlBkUzhhR0NN?=
 =?utf-8?B?L1VLT2U3TnB0MU5ETGFMbFpMZUV6RW01N3ZZQUJiaURrNU8vSkVEakR0eC9W?=
 =?utf-8?B?K3RkK1FRWUtLOW1DMFdrck52RVRzVHJXZHh5M1FxUEtDUDlneWtteWpCSzZD?=
 =?utf-8?B?V3FmWEpnVG5IOHhWL2FOMkRUakllSk83cWxUOUE3bFhRem9zM1lJVVlzVVBG?=
 =?utf-8?B?UXZGMkRNZjdDWGxhRFpSaWFwSmF1MGZqdHo3Zlo4MS96RWZQRXRGT29BcXpj?=
 =?utf-8?B?TEREYS8zSmVNQ2tFa2owNU1hT3p3RVJKaUc2MFkySTR0cmczMGNmaW80M2VP?=
 =?utf-8?B?Wm5UKzgwdlB2cVNhWStUWjJBYTVaWlV4VUsrL0hRV2NVVGpLVCt6WGhxRmor?=
 =?utf-8?B?WnFWVWw1VzNRUGJtUDQzbXRRbkkrbjA5ZWZUUnZVbWJYazRYaWtvWE0rOXBa?=
 =?utf-8?B?ZFdndXJ4cU52QUF0VStZMU9uaWdYd1NCRDZIUmsyRUYvY1ludW1RUEMyOWF2?=
 =?utf-8?B?a3lYYm9VV1A1SndVQUFhU0dtUVBtd3B0RlpLMjZQM1Z4ZjY5bzNJM01vYkor?=
 =?utf-8?B?R2dYREx2aEJPQ2hJWmNteFRXOCs3WlV6UVFWRU9nT2IwSmViRHQ5SmZPajM3?=
 =?utf-8?B?TmtiT2doT3lIcTc1SDl1OUtoYzhva2F4WmFqVDJSRk1pTUZGNFEvNk1XM0Ew?=
 =?utf-8?B?cnlZbmdOOTdMemliU0J2S09DMHdqbWcxSkRrdUxNTW01SjNRWE16ZnphZE5G?=
 =?utf-8?B?K0JQTmVHYUpxK3VuVk5NV2FMeTArOHhyaHBHR2JvVVpVRDkyM3liOVNqWGdV?=
 =?utf-8?B?N1pSRkcxa1JZMEhyWk9Lc3k3a3ZHUXdTS2lWMXoxMFlpNnMvVUREN2RIYlVK?=
 =?utf-8?Q?7AUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUZ1dHUybWFXVG5RUHN2aW5wZXk4NkVpTTcwbmMvSndCczdDNEZ1UnYrb01J?=
 =?utf-8?B?dWJPaWFodGNVd04vVGkwMDBHNGlLdkZXc3VrQ1B0aUp6b01JQjBFaFdnQWJ3?=
 =?utf-8?B?bVhiTVBPNjBhQlVoV1hML05MSTcrTnNWUjFjbG0vUnlJWnVSM3dNWGZNWGVs?=
 =?utf-8?B?eWFqeUcvTHBML21YUS9iV1pRUzhLMzZiL1RudGtrYlMvak1BSjZZQzc0YXQv?=
 =?utf-8?B?ZFhtMVQyOEtWa2hNeXRYL0lkOE1PSDN1R0JOUG04UjlaR2Q3aE54SnR2VmFi?=
 =?utf-8?B?MC8ra1hIc21rTEt5blIvRWZiK3lTOFRvNDN6d1h2c2VYU3psYTY5WnZVVnM4?=
 =?utf-8?B?bEoveUp5SldOTnBHZlN5Mi9RTnNKQkpoNFVibDZnY3FPWUI0UzNhZ1RvRWY2?=
 =?utf-8?B?NGd6UTd0bUxMeTIyUUlLYUo2Y1NhRmExQkkwakYyS052VHJUZlk2YlltTzZ0?=
 =?utf-8?B?aG5IcEVnYmgyYXdGakIrTGJPOHB2d2l6UnAySTEvUEZYU0d1eC9FMGNVUTFs?=
 =?utf-8?B?czhGN1Zmc0xIU2FYMDNuSUR0Y0VJODlBb2NCMlR3Y3VZRDFPK1M4Mk85YXZE?=
 =?utf-8?B?OHZkNUMreXUvSmlXam91K1M2MTRVcEhkbG1DTHdvaERoOFdBT3NpZUVJZWRI?=
 =?utf-8?B?WnVURjRTUzR4VFpiWGttNmEzQjZyUGZQUXErTnAvZm9CRkhMYklEUHZBOER4?=
 =?utf-8?B?THVWOFpYMFJtamc1MG5VTStpS3UrcnNUL2NYK0tWRXllWlBDa2dMMnlIeXdG?=
 =?utf-8?B?ZmRTY2l1OCtJampmNHBGUXRiR3hobk4wSm5sdEhZSjg1UHdRa1RMTisrRUNI?=
 =?utf-8?B?S1RJb0YvSHZ3TFBMOFRyREUwaERqVFRSQWttVDN3Sjh3TkxZOHNRL1VRdjcy?=
 =?utf-8?B?cVBjOE1BdnNuVUx3aXZqdWpYa2YvL204eitnclFrVHhKRStuM1R4YlpSaU5E?=
 =?utf-8?B?NmVaanpSMWZjOE5HU1piazJlbW9BRDhEclVTZXFXNERrZWRobzR3cHBRcVNa?=
 =?utf-8?B?M0JsUERIMVhNQlJjVHhzSkUydGwzY2N0MzBSYWZYc0thNjFVZDhWTXpOd0hC?=
 =?utf-8?B?eWVoSit5Ynh4bFY1bE5nSFI4anU3NGQ3Uy9TZjhoQi9BcGJ2Q2hIRGxkMVBH?=
 =?utf-8?B?aEZ6Um93OUZMVHNlYmF6Wnljdm5CZmo1VjZDN3BIT2QxdlBQc2o2MldTNjlu?=
 =?utf-8?B?OEJuNUpTZEtybjV0WEFPc3VSVktaMW9HOWxLeUs1ZDB5TjdNeWY4Y0pmRGhG?=
 =?utf-8?B?cG02MEtyNDl0MFdDS1BaTGF1Ri96aWdpR1pOTTdRd1dqU1BnbVVaT0U4QzhB?=
 =?utf-8?B?UG5henFYWkNIRmQ0b2h0L1l4ZW5kZ0czRWJxVklsdUUxaTRQcGZFejB4bUVD?=
 =?utf-8?B?SVZ1dE9SWnN4M2VNVjFiUUsrQWRFNjNDQVI1emJKZFhrVmYzN3h4TGtCN01R?=
 =?utf-8?B?T0tFY3YyaS9NOFBpVDU4Vkh4c09hcE03bERYVG0yOHl3QjBjTm0rUWIxZVhX?=
 =?utf-8?B?Q3VHclRkMExNeW1mdFZIaFZWWkp5N29GZ3BvNkM1K3BEeXloT1dYd0FPZDRp?=
 =?utf-8?B?Mzg3ZU5aaVpZbUtYZGdPS3R1K1hBQmRlOHFYczZqSW5iMXNEMS9DdmlrQVlO?=
 =?utf-8?B?MUF0SmRGS1dERldrWk02Z2pGNEMvVFlNalUwQVZDdGNTSVhQd2lmR2t5NG5p?=
 =?utf-8?B?bHJqZmhRQVBUa1cwUlRnUm5lNHRvU1ZmU3ZRSmRxaW5VSlpGaUYxTUdpQXB0?=
 =?utf-8?B?eVladTR6SzJxVGlvbHdSQnBnNS9rTmRkc0JpU0VXVlU3d0RzNEJkZC9DZ3J6?=
 =?utf-8?B?TzhNc25KZGllcnFTVzc2NFVGa0doZ21NM2xueERBeFN2TFFHdHRhZ3VOV0Fj?=
 =?utf-8?B?R2hhcGY0SjA0UWNtemJvYWlYSTlZdkk5b1FQQjFPOCszTlh5d0VERWF2TGlV?=
 =?utf-8?B?WVlUYjZHN01qSnV0YTErQmY3VVhyYk5uN2xsYkVtZlRaS1lHcHJFOVdPZjdH?=
 =?utf-8?B?bnQ2U3RJYnBVejFHOUU4N1Zsc1FHMVo1TUFLdHNkWE5jaWdHWDllRm5OTTl0?=
 =?utf-8?B?WisrZ3JVeTY4NWpnTXZ0cEEwMDlGeENablZXcVFROStyZUFyR2tBR0oyOFN6?=
 =?utf-8?B?ejYzTW1zNElzZ0tNQkpZREtsTkxmVjJqOGhFUmVMM0k0Qk13UnlmU0V1ZU1h?=
 =?utf-8?B?RjVWZ3pKcHpIUmI0emRSajhvQ3EyOC80TlhzSXd6L3I4ZHArTHU4dldlUjE0?=
 =?utf-8?B?UWRtV3NuVVB3YnBhck9nRlJST3NXZ0hwOU1SVGtBQzFXc3JQRzIzeHVUdFU4?=
 =?utf-8?B?YWVJTlFaQkhCZWw3emgySlZUS1FMdjZla3JEVFBPVnR4MHpwZEY4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b64b6d-220b-463f-385c-08de59c5010e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:46:19.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s7Yv3n/ZOkB16N1Lj6KHh9D667pR3sZShm5VLqUDfD4oWrzgIlgitnySDVOVg3yz1fkyBNYsLoqnTiG3BFHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8467

On 22.01.26 13:48, Jan Kiszka wrote:
> On 22.01.26 11:39, Tobias Schaffner wrote:
>> Run the EVL test suite for some first smoke tests.
>>
>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>> the moment this is used to disable scheduling quota tests that fail on
>> virtual targets.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  ci/gitlab-ci-base.yml | 5 +----
>>  ci/xenomai_4_next.yml | 1 +
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>> index 186d1cb..76e38e6 100644
>> --- a/ci/gitlab-ci-base.yml
>> +++ b/ci/gitlab-ci-base.yml
>> @@ -107,8 +107,6 @@ default:
>>          - report.xml
>>      expire_in: 1 week
>>    rules:
>> -    - if: '$XENOMAI_VERSION == "4-next"'
>> -      when: never
>>      - if: '$LAVA_TESTS_ENABLED == "true"'
>>  
>>  .test-qemu:
>> @@ -116,9 +114,8 @@ default:
>>    variables:
>>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
>>    rules:
>> -    - if: '$XENOMAI_VERSION == "4-next"'
>> -      when: never
>>      - if: '$LAVA_TESTS_ENABLED != "true"'
>>        when: never
>>      - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>> index 30ca9b1..03dc233 100644
>> --- a/ci/xenomai_4_next.yml
>> +++ b/ci/xenomai_4_next.yml
>> @@ -20,3 +20,4 @@ variables:
>>    KERNEL_VERSION_WITH_QEMU: "6.12"
>>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>    CACHE_KERNEL: evl
>> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
> 
> Thanks, applied.
> 

Seems there is an issue with ptrace right now:

https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2278891139
("** ptrace-sync: BROKEN" on all archs, 6.1 and 6.12)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
