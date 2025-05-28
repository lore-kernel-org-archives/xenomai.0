Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012020.outbound.protection.outlook.com [52.101.71.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB920297B
	for <xenomai@lists.linux.dev>; Wed, 28 May 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458413; cv=fail; b=ljmJFqaG4PqlTIuvwiZwMOwY1/eUwzPBFUtD5sPQKDe5ts6nOHoi90qWtR3ndVhhnOonfBQyfYNDvmyt7lJ/SHrt2bUkX/ClC1bmVcUMZ5NUkwRIocUrh5WoYnlABeOgY99SP7yAngr8w1JomJ00V3JpbbZ9lGBLnuGSPhC4nMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458413; c=relaxed/simple;
	bh=WIbpqfVFz5R4t1CCTQu/BHgWzGQBCUEAbDBNX8iPZ0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEVh5dqJXZpT2Jwq/8iZ+Y+ZJYegshObNWVRY30RM6nnoxmwnWfajwDfou5ufrK9X7DheXIxt1elX6h3rDv+vhTJx7qji47Je9JdxdEoU/2XgzUlg5Hbueqyb2ARC2YDUYwisY23hY2xrLS/D8cEZOrLmSbEKpsUSwpYElMW52M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UogRrBfW; arc=fail smtp.client-ip=52.101.71.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UogRrBfW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lldnQLENfO0+sOtCcxx6EflyHyuZHOz32GqQtQRAWZCTad5d2hwzNQdwNVAKf4G2u3sWEVHPHxH/n/8nQ/Hf3ZVfInNsUfDP82leMBb7O5xNlZvwYyh8QMSM5JNJQikQKGsimtpK5rbnYdgq9aWq5l58sRGBSk89QtOk2seORH5UXgo19uAOZJeVq0A+6ma7/PqwEFNG9+r2of7SzSGZcuCu47lqHlmTyD1MkJyMWEMHBBm5xifN2VP2gceNxOWyEgPpIJao6YfQWal3HD5eXgtGYm2ruZonRP3VfPCmL7QGAg3NJMu+UQrMBTd8LNalNmkKOfoS90ZKgp4m3BW7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWE25zzq/yhYK5Pnlzs9megwx6vtXRZfH6aoHCZ4fSw=;
 b=TjTRam1hDx8CjmXQE+rG6n4ovdY5uSJ69spQ1crtxXypSr+uPHh9bSxezSGYWLp5YELT7uzizZNM95qqCmh/HixW/Sy5ItWTQElAOUMDVl/ySXIHqp/Z8IzpEVTwm12jDm7cZNwj2nCi/bna5CZ9rzii7Do9ImMG6l1qg5ZaPpjBABEom4PeSJnCxjYocyaLBNkmGfhIslNpkzwQW4xhTw+3ajJtAFe6Vi9UQ/9XLU4YtlIB4WCI62x6L+sPXbXFT15RqrXtpw8LDSGX3CgY9IGN6Ew61tWFJ0szCArfPdQyaeqjOKif7OymMysIUQHxtSRGeeV2maslyyWZqSrgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWE25zzq/yhYK5Pnlzs9megwx6vtXRZfH6aoHCZ4fSw=;
 b=UogRrBfW7Vs4ibU2zS1y5tzcajj6np1uTDZmMqR+B+OZrFuD75uqiD/dIjTE76nzzPdkDuMgjFLhg1CI6/WdA75tQ4WgvRLqlSS+DBvd47IVywWXqXbPYwNcnnR0oN2oavvO115t4/sEuFwjPmMY50UoBgIQMnczxNixNr7OgAMXnelNFpkjf9mbBlTm1QLM18qtf1aJXsCeEiGUhuNw9eOOhcAHWZqjNok5f/vRAZSEwtoSaESPgoHn9alupzLnQoYb73xjo7/tu9B15ShsPOL0VuIBWNx6M8G7k7hxrHCkOfNoMpmt5YDFAO7iW61YIcwaal9L3BIPAS6sD5cx2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 18:53:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 18:53:29 +0000
Message-ID: <50cd30c5-8818-4719-b607-0746a5cc0d99@siemens.com>
Date: Wed, 28 May 2025 20:53:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Installation Inquiry
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, Tom <t93252352@gmail.com>
Cc: xenomai@lists.linux.dev
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
 <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
 <CAFc1U0uNW-NiZqQFA4tU=GVYDOxa5tq5W1Vd1Fa1xjgr3nzbVA@mail.gmail.com>
 <CAEzxD05N_icELe2dP8w_5ibFHW28oUteJSjpW4Q-XFL=AY594g@mail.gmail.com>
 <CAFc1U0tTeiR=khP2-8bdHUPE1vbFKdBk8Q3TNGfD+Wkh4LxNzw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0tTeiR=khP2-8bdHUPE1vbFKdBk8Q3TNGfD+Wkh4LxNzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 810020de-8c3f-4baa-857b-08dd9e18ef6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTlCRzJYNG5wZFI1RjRmMnlWempuYWVmdkpLL3pTRkxVdzRvV0Z3aGtyWlVk?=
 =?utf-8?B?RVRSbWZTNnlaWFF4RVFXamZIeDlXRUQ2RWhmcUlwUmtqd2VuWFNHcFhKT0Ru?=
 =?utf-8?B?RVk3bS9JWFhYWG85SlJJTGJHa20wWnM1U1pDN3dNbUhEK05qNDdjcFI0bzQ1?=
 =?utf-8?B?NVVmdFJJN0tsU3R1SmE0Zzd3SldvblpGcmRhL3RlcVJrWHBRcmpuWmR2em9v?=
 =?utf-8?B?aGp1QTQzSnFlSUV1RWJGa0QxM0xhOStsMDlGS0tWUDFkU0xuSzJzNTJCa3Rz?=
 =?utf-8?B?bUpGNEhWVStLRUxPRUZiZ1ArbDJyYVJTUHdEL1dobnUxMzJQVlZEbzhmKytI?=
 =?utf-8?B?WUVQS1JQYjdVaFo2RGJrcjFOdVRITnRjL0M3dXVUZVE3TktnN3pNNXp6eUd3?=
 =?utf-8?B?ZmVXb2hvWUE1NE8zVXFyVFQvbEp4SkNhM2NnRGZHangwd1VqeFJ0RlJYa3Bm?=
 =?utf-8?B?WjVETGRUQUk0OWVPMHMrd1dFMlVET3k0eWQ2VVVUUy9kbElocHhXVGtvV01T?=
 =?utf-8?B?M0p3azdZaHJRSlhleWkzYWFzOXRuRVZqcmVFcTlKYnhDa3gzeWpaSmlCZDMx?=
 =?utf-8?B?MFJGajNRbUwzaGdJdXZCR2lrdXU1bnJmUjNZVG1nblF0czdqNmxVQ3FBcGY5?=
 =?utf-8?B?V1Bxd012M1NDRWJZaFl1QThrQms3NmlPdTFyeVJCeEROaUVCdnFJaURlVEVT?=
 =?utf-8?B?Szl0ZTRtbW80QzVGNEZHVng5V0p6cEltSk5ta3hzODZpaXlac202OVdqODZw?=
 =?utf-8?B?dWwvc0dGTnV3K3U1VmZjMytzSmhQS1RFd2hRaldMcUc2WnZTYmVWL1o0ZCtU?=
 =?utf-8?B?TENSdDlCa0J6R09ZVWNSNEVLVHBpd2NzMHAreFIyQkxaY2hoOFFjelpuMGFV?=
 =?utf-8?B?ZFVUZUJGdjcxUXRMYVhjOUU5Nk91QW14aWJ1N3VyMTFxWDFBd2ZkVE9obzhL?=
 =?utf-8?B?N3VQOUhUYjlqTlBLMU4ySDZWV2M5cXVBSDU1cDVUUnBFc0l2d1k5ZkgvbTlU?=
 =?utf-8?B?R0ZPNWlkUjFoMXRvb3lsVmdhdjdWdWErVmh6V1UzekdjM1VQSVY5c1JsM1Qx?=
 =?utf-8?B?QTlzRHVWb2kwbFR1dTlwakpJdDUwR1A1VzhzRkNPVFdWTmdSRVNoWnB6WitS?=
 =?utf-8?B?TUR0YTJ0cS92YWRFb0FaV3daNFMrL25VTjllT1V1NzhXN05hR3piSDhxdmg3?=
 =?utf-8?B?a2s0ajN0ZUdVaWNXTFVhWEo0SXJwUXpCRlNYNktCVVRacDdFdG9sR21EcGRh?=
 =?utf-8?B?bmJjQytuaGhUVkE2djhGNi9wNGt4eGUyRlpPVzRiQ09SeTdTUDlXTER5Mldo?=
 =?utf-8?B?MjNVSWQ1U0QzeDk3LzF0TW8zOTEvdnVBMUJWK2VhVEx0WExyUWttQVJsMFdr?=
 =?utf-8?B?RkZrWTlxU1g4Z2JvbHpkYnorOFpodW9MTlpCamF4d3lqUFMyNW9xV0pteGJt?=
 =?utf-8?B?THYwTEVNTmxvUzVqSW5PUmgrV2ZWSUZhYm1FVFBrblo5a3FOalhSdTQreEVF?=
 =?utf-8?B?dGVyUUgxZTBmbEJJaDUzR1dGd3lQUTEvNUR3WHVwSmNrME95cTV1aW8yeVp6?=
 =?utf-8?B?S1lrVW9Tbk1mTU15V014YW1TVkxsUDlBdXlPajFTUFBCSEN5bXJPYTVERkE5?=
 =?utf-8?B?eGpsa2xOckZiMzlWdUtqczhSSXZyckRsLzJ6UXJTZVJmaTZ2ZktqaG52Qzdo?=
 =?utf-8?B?N1lBbS9sU212M2FGbzQrTnN6eW50RGFsWWRORVAwRGg3YjdrSVBacGZ1SDJx?=
 =?utf-8?B?d0RqdGpiNHhqeENIcWcydVVVd0FHMmR5c1JoNWMzM2pBOXh6c21kR2hkaXM2?=
 =?utf-8?B?ejFlbWhUK1VxWWR4ZlpxNG4vQm55SHhrYUxjTkRWdHdwK1RKRmI0NmtVTWJR?=
 =?utf-8?B?L0FEMEw2SkRzKzdDdll2cFozbG9FNlRyYk1oWU9ZeCtPYW1QdHd1c3JyN3lK?=
 =?utf-8?B?TURSQllHRUc1K1YrTjdFaDVQR0kwS1d4RndldEdhNVA0YzFxdjVXQ1VhWjhF?=
 =?utf-8?B?c0xxaDEwVmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUkxNUw4bDVaMnRkM3hOZVFjRVVFeUpjV1VxYWg4Vmtkbm5RclpMV3dycDhk?=
 =?utf-8?B?blRMa212aVNKTmNKcGttOVB2OUZmZitPdHVnLzh2STNQSWpub3BpQ2lWNSt3?=
 =?utf-8?B?VktrNzNHTGJXNldlK24xMDZCSTJrRmJUbHpKWWM1eGRlM3NhMDZ6cEZmbzd4?=
 =?utf-8?B?Z2IxeVUwSVNyUk1LMmRMVVJxdzlaOEtSTnBPOWF5ZkNoY2dnRTl6RU4rcHI2?=
 =?utf-8?B?RzJSajN0bW5DYjdOWUZOcUh6UTNhSkhMSHlBTjJWRlUvSGpFQnJCMHMwMGZp?=
 =?utf-8?B?RU1vUEY2ckkwbWNac1BOTXZGbGFYRkF2ckdoMjllTHJhQkkxVTMyQkQramNZ?=
 =?utf-8?B?M2JaRHNvVTFrQWlKeXd1WG9TcXhvV3Q3bUQxMVZvb2xMeHowU0VzRGI4WFpo?=
 =?utf-8?B?ZllCWDZXdGJzQ2JjM2Nkcm9OSVozdUZMa1hLWjdOV2M4Y0U2bEtFOURjdmh4?=
 =?utf-8?B?cmozNmR6L0Juc0lhUCs3eHNXYkdjektMYUdUVzJHVGNJam9XY2pMYlZOVGFs?=
 =?utf-8?B?ejJIRG1zSUxhdzVTajdxZWtYNXZIV1NXeUJqTFczSDBwUW1LR0M0Y1VlLzVa?=
 =?utf-8?B?cm1Db0hldjlzM3hYQWRTazluVFlrSmFnbnh5RDFPOExoOFBPbjBHRTAwcTVM?=
 =?utf-8?B?c21NMmxkOFpncmM4RUZHZlZmOVpGczJSOVRtaVpxVmtSaUMrcHJ6Q01UT1k3?=
 =?utf-8?B?b0ZXbWUwRTBHTytqb3B3NEw3dUNQVkFpem0rbUU4S2dpcmJ1RmpzNThBVVlB?=
 =?utf-8?B?RHAyWWEyYkRSbDAyczV0N3JHWHRoS1dUckYzL2xsaEZSQU9lZXVZWHRNM1Y1?=
 =?utf-8?B?NVVnZ1BrN3FwMk42UW1GY1RXQndoZXkrWEw3UmtPSWFKcHVUaXk4OFRWT1VB?=
 =?utf-8?B?SlpUQjZVSE1CeTdHbEZyQXQxT1lVUmVQSVNmR1FxTnBCOUJuRnI5V1o2alBz?=
 =?utf-8?B?VFV5cXFMWExTRXlmTGhpcXdaWVB5VHVvazI0WlRNMWE0aVFyL213ZmJZTGw2?=
 =?utf-8?B?MytHNUQrSkREOVA4UUd4d3hpNlNZWmlOUlR4OVFqb1pKZ00xUTFaakF0b2cx?=
 =?utf-8?B?d2lRVm5sYUlMRkFjVmIySjMyZlV5Ry9LS3lUUkJQZnNweUJrZ04vbzR3Q2xV?=
 =?utf-8?B?ME1FeUFBd3lmVkhuVng0WEtyeVdUSEtObTZEQndqaTZSTSt3Ry80MU1BUXgx?=
 =?utf-8?B?SC9XVkpjZG1BeDQxYkY3QlFqekhPS0tQdWNwNVUyanorQUtJTFNzSjU4NGZn?=
 =?utf-8?B?dEVHTU1HbEZZeDhsdmlQbG5qSHR5UmxmWWptN2QxRG96Qy9Ha2pDWjlPbCtZ?=
 =?utf-8?B?dnpTblhUbzI4WENkNmxrRFY3ZlBZa3NaN2UrREF1YU82bVZMSExhaldaV0ov?=
 =?utf-8?B?dGk3c1g3TlJOLzdJOUNLZDYxY0JTRVRPSzVpTGYwa1dweFB4dkIrM040YXo0?=
 =?utf-8?B?RGl1eVVkbnJ0V2dTK052eHE1REEvSHFrYURtbjlrRG1QdXhycVd0cW9rZUlF?=
 =?utf-8?B?WkV3ZkJwN0VFL1lhZi9iUjVaQ1Y2VmVaWjFTT2l6S2h4U3FTNG4yYXNwY3Zr?=
 =?utf-8?B?WEVERzNNWkdGcExJWFBqajJ6bzZzQkQ2OVZIbnkxWmt1TkdRSkVOVGxHcnFY?=
 =?utf-8?B?cmF1M3pRMEVKL0lLUjM1MSt6Y3dBZnpqUWZ0cE9XZzB4eTMwbEZDc3o0dXZh?=
 =?utf-8?B?R2R6KzNJNnVUTnZWK2ZKTjBTdW1uRHlJbkJiS3VzVndiOWk0UzVvQXdLekpB?=
 =?utf-8?B?b1hCMURXYXhPVDJlcm03WDczd2NyNjhyazU1Q0tEV3hvUFVYRFhSeHBSdURr?=
 =?utf-8?B?VFZ6VkoyTlFnNmJSWnQrQ1pXcFZIUUxROXZsRlVSNS9yb2NxOTh4c0ZjanBa?=
 =?utf-8?B?a0ZXTG1TTzliQXpRSDgyMnNvbitEdzNDc2R0R25UNVd0eXdkQ0FudmU1MDBK?=
 =?utf-8?B?cUFqZDV6alQ1VThpL244S3VXVElCQkMyQnVoRTVQWWh1YVFWa0JMaDYvbXk5?=
 =?utf-8?B?LytjbDVlbWVRQWFYMGdUZk5VSEdmSGdVY0M3VE5hdUlSUjR6WkdiMFdMUUw5?=
 =?utf-8?B?RmJiZzZMdUkvZVNORG1RbmM0TTdoSitEWGk4YmU1dHR5YzNZV3U3cjh0Y3M0?=
 =?utf-8?Q?BWRszwPIEfeIy66KQUfoxt6qi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810020de-8c3f-4baa-857b-08dd9e18ef6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 18:53:29.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf+ja/n4QY6SDvRobwhOQ6iK5q8LvcuYPnjL6XXmoysRo3xz6etJkxTWJv08DpSZozzgkEXuLfJzjua/sjJMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7109

On 28.05.25 17:47, Pierre FICHEUX wrote:
> Hi,
> 
> Some kernel features such as CONFIG_ACPI or CONFIG_CPU_FREQ should be
> disabled as they are not compatible with
> Xenomai (and could lead to performance issues). Is that what you mean ?

You likely meant CONFIG_ACPI_PROCESSOR_IDLE. Almost no modern x86 system
will run without CONFIG_ACPI.

There is chkkconf to validate kernel configs for known issues, fed by
utils/chkkconf/kconf-checklist.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
