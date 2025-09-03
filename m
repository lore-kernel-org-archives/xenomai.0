Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441F26C3BE
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877358; cv=fail; b=ch7vDRgWWyAUaBVMtba+8R/Xo2h5N8l5HlReok3DfxYMugt06VxI/u6VfOvElJjbNfpiPtuL/cd4TVhtc9AejlcZBP4ynb7lMwdSvI6VgHFa52X68F03GJGf9bGTx2qVObganXCvVesJS4BbLicPasQzYJDLSvx1OJn5V7NOOvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877358; c=relaxed/simple;
	bh=Ks4OM6CBXi8xKhnYdenfUGp547oS7uo+mj+y5Q5FBgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EixBWfAgwH7lRAxoGyQfPTUmfWB2WbJ2GAvLsUlI4nJHZP55ZiDJoEROGSawSsnaNElfS/978q+Ca2cfrWklpC2G7U51YXhH3AXRATHYh/nBn79ucia2f7QONiHQdepGQG0dDPgEpBC4Rhwoay6R7ZUsyeNTm3F9X/KAko712fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TL3CeH5H; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TL3CeH5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5+dqSphxqWuolK3B9mMj6QD/qX9Qv0B9jdbt6fNen3SHVf++EyxpSxPe/YWFOJggxwjEprhgUY01Ol+G4tXTXasv5MZ4+rS9HnfYbGqdnkLfkP4tCW+fh9t3lp6yi/oXDGKIDhFVoC0ZpsxqIU8p2APAHOZjoEcC4ye/dwKmBW2UvTGZo6jHlfr2+v9KOrZ9TNwdwqLRKD6r7LKisG4RxUFf56cS4rwP4+A9J1E2CUHoIZqkCDFCzuNFdc4+sj8qD/pimGbqqNXXt7z5yWjKG9u2eF8FpoSt6EbeKlBYD8xGjPAQAWDrb74IZnQxUB/sGOIJs9JGbwjGe8Juc8Mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jICYe0IaHIgPZoXMk+LZmSHpgkZmmRBZeV/m1aIaGqM=;
 b=lhL/2VQ8LV2/oQ+BfGuqjHI5QA08hPWVce6gxOYIHLcAcrI21nUjUaD4A4OSZkNz4TSlYj4Ju19oBtPD+vtY5hMnZ58Enu13svHGVOlX540gaG4XpdI/1wQCS0nFGTKXZBaTxJDL0ZhtqpXQUmPV4aQYbUwqqHeYGsmzIVSu5sDUhy7h6y9ULAROS0xMSHgrJv7FWzUBmtfiYDxH4jzosGZZYWUX2lHtAEz/LmKDCQgeM4Kgy0Kr6dxnMSq19ex8I7+vIwjkqXNgGZK9hRXY7cVnpU3T4ardT68YwpW8LFVzQTUF97U5rW4w6ulXjQ+Uvg4p1Di6dS0eXS+vqldA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jICYe0IaHIgPZoXMk+LZmSHpgkZmmRBZeV/m1aIaGqM=;
 b=TL3CeH5HNXGQ26JtAMPu3DrtKx/QmM1fJ7RTM/DLgO6YdR3y0ROrK44rhZ5RlNUd2qcLfOmN1hWWX9L4QMJ4dAUUpL3pa880LuY3vB+bAy0Qy9bgcRFb/0UeEdkkislD11ULEb1MOPcJI35STN1CHv0GZOW9ffhbjisL9Ldqimwy9pLthcFicdfCzxfqaHTwk+VGbo2GY44sfaOEqjBQt19l9PYsqX2zGmRQh1Hqhm6vilCJNgVbVYl5IoAFDwzRa6mwmy+VnSxgV8Do+A9PO6CDjG4K2RFlsD5AniLT/wBD7e1KJspeQctso0IFbhXua3s8q0/5fLWzIye74kqmDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB6690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Wed, 3 Sep
 2025 05:29:09 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 05:29:09 +0000
Message-ID: <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com>
Date: Wed, 3 Sep 2025 07:29:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
 "rpm@xenomai.org" <rpm@xenomai.org>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org> <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex> <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
 <Zx6QxE+CNTmQqZDk@trex> <ZyUH7BV50dlhvc92@trex>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZyUH7BV50dlhvc92@trex>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: b4113e02-a2a3-4464-4418-08ddeaaace99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWd1TUFZVkNuME1Fa0ZyeXpid1ZRV2FLVnhGQm9wRUxmQWpoU0FMQWhhUjcz?=
 =?utf-8?B?WHVNQkJHZm9RQ2pLRVdpb0l3WVpwKzV6RU95dXhjTExyUVJZVHZHeDBaWGZw?=
 =?utf-8?B?enZTQUxBc3djbFZqaGFuSGcva2pSQXZIeWIzd3k5T2tZdUo4dlRuL2NidEFt?=
 =?utf-8?B?MzRKcVdxNVljSktNYVlNZU16Y2VpQks3b0ZZK1BpQWZFR2t6Q0pRbml6STZu?=
 =?utf-8?B?RWhvOVo3ZUJ2QXA2SXBSdVBVbEp1N2docmx2WHlYaGFEayswRXgyRDNVT2Nm?=
 =?utf-8?B?N3BTSXFJSjVqSlNVbDR2NGVOTGZCMENFMlN3MXJ4NDJkQnBhWE5YUHloYWVp?=
 =?utf-8?B?enJTRHhGS1VocWluTlJLNU0wdGtBNnJKbjZOQ21sSG1udm1jeVJOQkJ0aTRz?=
 =?utf-8?B?a3RJaWgrMklRV3FvUll5bjF5RDI2c3VjZVFHV2FZVkpycThma1NuOTl6ZmF1?=
 =?utf-8?B?ckdPZzZydk52MFZMUFM4Ny8vL3p0OHFUdXVjVG5aYXBlYndhMjFIYmh3dW1F?=
 =?utf-8?B?bytnMmw3T2hMK0wzYzZoSlFkOUREMmNPMlN0dXUrMFhLdEh3WXZpOTByNDZ1?=
 =?utf-8?B?NmJocXBWR0VuZHRrM1N2bFViQm1KWkNqQmFNTWsyZ1pPTWNsUWU3U0tsZnpq?=
 =?utf-8?B?N0JiOVJyRDVhK21odnhKWU1oUStzUmppZkJsUGZOTDhRZnhhNGtJcW94V2Z5?=
 =?utf-8?B?cmhpQjI0Q0c3bnRLZ3RVWlkxTmZMZng1QXI2WTlHRHVib2NTbGxDUjFDLzZt?=
 =?utf-8?B?cm5yWlBFWlVNUDd6N0xmdmYxYll3N2R5VE9lQ0RSbE5FV0l5dlNJLy8xMlQ4?=
 =?utf-8?B?R1hNd1dDN3lRdDhXYW1Ndy9QbCtYczh0KzJZTHRCbTBnSG9ISzM2TDZ6dmZT?=
 =?utf-8?B?YTJjbVJxU1FRd1AvZ3lSZ0YzVDBHWVhuY1RtOE1RTGdWYjgwdW5LZTNobFRW?=
 =?utf-8?B?cUE3bW9qeFJXU1Z6bHpRL3R1dHd2S3p6N1NCTjBhT1BTSGhld0x1end4alpx?=
 =?utf-8?B?R0pBS3JuNTE1WHpQSDZjS242Q1c5aDhYc1FiQ1JOd2RNdXBXZit4Z1EvTld3?=
 =?utf-8?B?SzRUZmt3RkJiR25USGY4dkVORG9TV3NxeXlZbThVelJqYWRSand6Umt1N2gr?=
 =?utf-8?B?WUo5Y1N1Q0QrYmI3a2lhaGFjc1Z4U1Bhbm5DTVArR1ZlanQ0L0g0SmpDMkY5?=
 =?utf-8?B?NVBrSnNJQVFVeVRHVmk3bzZGNHVTQXlZaTlDZGxvY0lVSXRRMFBMUXZwbC9r?=
 =?utf-8?B?R0VBRzJvNUlYZWprM2k3UGtQKzJpUS84a0RHZmpFbU53OEFJM1M4VTFETGlU?=
 =?utf-8?B?NFQxNlJycFdmSmpIN1BOQ3dmZlBSanlyZnRYZEd5ZzVkcTFpem1Qb0xSMUNN?=
 =?utf-8?B?U1RMRkJ4R0tsS1ZvSm1jeXB2dHMwbkcwcDhReDRYRERSSWY0bElLc0k3TUFE?=
 =?utf-8?B?cHNXUlVYR21KUmgwM3JVekFJSEtqdmtWR2RUdi9HZVB3Zkk4ZmNoRG96YVdk?=
 =?utf-8?B?dEtuSmJ2SURJQUpWUXpOQmx3d0F0NTJmcmlNOVZCZ0tPNkhsYWtsWHNETTVu?=
 =?utf-8?B?R080Zi9kTFUzbmNvY1k4T0dXREpTR1FhUzlDTXBLanpRZ2FBbEFaL0tYNGVk?=
 =?utf-8?B?WDRiVWhlcUFhWFBxdW9BS3R5b0syTzRIcWVtakRZYXl5NTQ1SlgrK0EyaDM5?=
 =?utf-8?B?ck5RUW9Bc2tWaWloL21ITW9LRjZJckltcmlYNTJKZEV1cHlPNkJ5MVljWTFj?=
 =?utf-8?B?MHVXQnNDcTIzWlo1d05CYThMcU9mOWdIRUVBUG1qa293bTdXdUhlSDJEUXpS?=
 =?utf-8?Q?L0zYvqaenxRjeJ7T+V2oiKCRwEfI6dYvTXet4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0RwM3U3a2l5ZTk3Y0hTYytqM2dETTVoL2VxNUtzclEzU1VtbDhIUit6eGcw?=
 =?utf-8?B?TEIvc0lMaHErdTNrOEtRbHh0UTljVG1HMktVdU1vYm9wY1JZV2paMWd6clBw?=
 =?utf-8?B?eHZZVWI5UDgzMVpocklRaU5CM1lDOUwxaGR5b1hidFdFc1B4cFB0TSt2N0cx?=
 =?utf-8?B?M1dHOTQwenlLaXNmRVZUSUpOMVN4NU4wSFk3R0ZwbERUWU9CbFExZHkyWUQ5?=
 =?utf-8?B?MUNvZzE0MFBwUWlTR2piT3JwRFMrYmsrajd2Y1NVUGxvS3hxMzF0UlZBT2Mr?=
 =?utf-8?B?cjc1ajZuL3BiNnNKa0NlclBMZ0JFaGV1Z3djbEVQUUlRZ1lNL3pzandvcEJG?=
 =?utf-8?B?SjhLVUR5MmJReFVybGh4YW15VTRtV1czSDkrSlc1LzVUamNjaE1BZStCNnM3?=
 =?utf-8?B?SWU3dmVxU2hzSTJDM1NZa3lRN2UxYlFDZGNNSU0xMUx3bTF4SzBuN20vQURM?=
 =?utf-8?B?ZzJXUlhBMk41SVprRjVKSXo0bi9jU3lGUVd5YnYzZXlQZTZ0V0dKblQ2YWcz?=
 =?utf-8?B?U3Fobk9kSDgwTHRhSFRweERCU3QwM0xzTXN3bzJ0ZXhTWUpSUXFVeGVDTTdy?=
 =?utf-8?B?dkluNUUzL1hLZGlVY0NvVFlMUHlabVFFUWprMlIrd2lRZHB2OVorSWNRR1kz?=
 =?utf-8?B?R2VzaUVxYUVJblRFMEhuYm91NVY3aC85RzQ5RkczV0tvV2VwR3laL2RNWTJT?=
 =?utf-8?B?V2x5L2NPejV6Qjd3YlRhVkw3THArWVRGalRuSVdoY0gyeEhTTXBRbVdkcHJr?=
 =?utf-8?B?b2NObURMT0FvUGNQMzlpVU5tM09sRlVKN2RtMU1VMEtsQ1BicGdHeEpHSW8z?=
 =?utf-8?B?MHVvTFJwRnhycDN6Z1dLbHRCb09JeXRNZk9XbFpwMHQwRGJtS3lXbW4yaHlh?=
 =?utf-8?B?ZXNIdGdiOU9LckZVbEY1a2I0c1NYaVJJdVBBZ0pRRElwdVYwSGlLZmpLWEo1?=
 =?utf-8?B?NERLdnhNMXNpMktmOEIxcUhuRXY2c1RPMW9CNXhBMEVEZTJQZW93dCtldkFI?=
 =?utf-8?B?WkhDOGlWVGx2WGEvWkQ1N1g2VUx2SzJ4MndEajZZTUlpZnFEVFJVN05MdCtR?=
 =?utf-8?B?Z2J6NzhXS21hNUJZVmlwcUNmS1NBelJCSVBLbWRnYU4xUUd2amRUaGI4M2VN?=
 =?utf-8?B?VERmVkttSVVqMFJzZ0txRlZvekFBcDI2T0J2MDJLVWNOOXhtWkJRaENwZkNQ?=
 =?utf-8?B?UHBrTTJWUTF6MnE5U0orRzhwVnE5TWtYMHFRQ21QTkt6cHdXSzdvWHFHTTR5?=
 =?utf-8?B?MHpvejJpRnd6cWN4T202OE0vVjJ3TXovWndCTDZzbWpCeHdlVWhzZ1h0N0xV?=
 =?utf-8?B?ZVZXZzV5MkQwUDBBNVE5WHJwajJIOW5Qa0crbkN5alNaQnJFZEhvZTVoajg1?=
 =?utf-8?B?Z3lINDF1M3UrS3hENkFkZlJTM0tmZFgrZEpjVG5PRXlBV1l2WGNVM3FqdEhh?=
 =?utf-8?B?SEpiQ3hvYW9SSHRsMHprME8xSFZqWkVCam1oS0JhWC9MZmxoVmhOcWsxWnlB?=
 =?utf-8?B?NG1qY25CY1ZUMnlYOFcxY0JueGkwZEdpKzNxbkNhNVZtdHgzVjlwVk1lUGtM?=
 =?utf-8?B?Wi9VUU9yVFN3Q2IzeHZhWVA0eFhKWEx0czFBL0RKaGR0ejRjaDVmbEMvWGw1?=
 =?utf-8?B?VXU2ZHd4Si9rZEZNd1B6UnV2RklwOGwyV2QyZXdVSExKOUV1N01SZUd2SXkr?=
 =?utf-8?B?aTAvSVZxRkNDZWdkZ2c2cnBQRG9PTGxJeUFwc1NSTWJuaVFMNkhBY3hHa1dk?=
 =?utf-8?B?QTdZVTBKN0hmSTRVMGZRTVhOdCtEOEZDZWJyeHd5OXJFcnkxT05WejB5YVVy?=
 =?utf-8?B?UVZjQzZ4a2Y0S0draVhxVUJkc0pxUk55YnE4R1N3R3JuSkRoVENZbmRpa2FX?=
 =?utf-8?B?QTU1NUU0dU5kbEgyVGUzWUVPSHpYdFM3TXo5dFhycDNsYmd3UHF3cHgrZHYz?=
 =?utf-8?B?eHlXcFJGQlVjalNId2xXS2Q5Y1FnNlBjQVFjT09WVGV4dmdpWGpJUnVraE1C?=
 =?utf-8?B?YWxnR2lBZHNHMFgyQ2xrak9DTGptdG5XU3Z2R0pEb0pqY200dVd5Umo5bk42?=
 =?utf-8?B?eUtjOW9XRi9HUlRtYis1QXdDQXBZRlhvVjZrenQ0UG0yTTU3ZXRmenBaSVd6?=
 =?utf-8?B?Mm5Qck5kQVA1ak9LRFRVdVA4RmVmTGdRWHRXNWdHMUc3MVExeHhrZ1drVVFj?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4113e02-a2a3-4464-4418-08ddeaaace99
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 05:29:09.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQCsmbrweCGLpraSrDcfyLztKd9jbp8a3sTlF6lYZQ6D9PV2BpA9YKMMSR+39nZ7JCqPLBgYoNIXkueA5VmF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6690

On 01.11.24 17:55, Jorge Ramirez-Ortiz, Gmail wrote:
> On 27/10/24 20:13:08, Jorge Ramirez-Ortiz, Gmail wrote:
>> On 24/10/24 20:00:12, Schaffner, Tobias wrote:
>>> Hi Philippe, hi Jorge,
>>>
>>> On Wed, 2024-07-10 at 09:18 +0200, Tobias Schaffner wrote:
>>>> Hey Jorge,
>>>>
>>>> On 14.06.24 09:29, Jorge Ramirez-Ortiz, Gmail wrote:
>>>>> On 13/06/24 19:27:10, Philippe Gerum wrote:
>>>>>>
>>>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>>>
>>>>>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>>>>>>
>>>>>>>> Stress evl with a load command while running the tests. The
>>>>>>>> load command
>>>>>>>> may be set to an empty string to run tests without stressing
>>>>>>>> the system.
>>>>>>>>
>>>>>>>> To align with xeno-test the -l command line argument was used
>>>>>>>> for the load
>>>>>>>> command. Listing of the unittests can now be done with --list
>>>>>>>> and --List.
>>>>>>>>
>>>>>>>
>>>>>>> Nak. Compat with xeno-test is definitely not a requirement if
>>>>>>> this means
>>>>>>> breaking the existing evl command line usage. Besides, --List
>>>>>>> looks
>>>>>>> strange as an option. Let's pick a different option for the
>>>>>>> load command
>>>>>>> instead.
>>>>>>>
>>>>>>
>>>>>> We may want to implement the stress utility as a separate evl-
>>>>>> stress
>>>>>> command, keeping evl-test for unit testing which has a different
>>>>>> purpose. evl-stress as a script could generate the load (dohell)
>>>>>> and
>>>>>> possibly check the latency figures reported by latmus (using the
>>>>>> -K and
>>>>>> -A switches to detect weird behavior).
>>>>>>
>>>>>> PS: Jorge is going to look into leveraging stress-ng for load
>>>>>> generation.
>>>>>
>>>>> yes I am going to start looking into it. I think that maintaining
>>>>> Linux
>>>>> stressors should not be Xenomai's business. If we can't replicate
>>>>> the
>>>>> load with todays stress-ng perhaps we could just usptream what is
>>>>> needed (stress-ng is well maintained)
>>>>
>>>
>>> may I bring this up again? Any new developments or opinions on this?
>>> I would like to see a solution that allows to compare xenomai 3 and
>>> EVL. Reliable numbers are necessary to make an informed decision if EVL
>>> is on par or even better than xenomai 3. Imo we are comparing apples
>>> and oranges as long as we are not using the same tooling on both
>>> platforms.
>>
>> Sorry about this, it is being a bit of a crazy year for me at a personal
>> levely. I am start on it this week.
>>
>> My setup uses some Zephyr code executing on frdmk64 I wrote years ago to
>> benchmark evl
>>
>> https://github.com/ldts/libevl/commit/905d1946ca117e3889c53d1150a1334cc91033a8
>>
>> I will load my evl system using stress-ng and measure latency figures
>> and then replicate with dohell loading tools. I should have something to
>> share by next friday.
>>
>> feel free to ping me anytime. In IRC you can find me in LiberaChat
>> #u-boot (nick ldts) and since recently in OFTC #edk2
> 
> I was finally able to get some numbers on imx8mm (an Arduino Pro with
> the Portenta breakout board recently contributed to my lab by Wim
> Taymans for audio testing of the Xenomai4 Pipewire-plugin[0] for
> realtime audio)
> 
> I am using dohell/rt-tools/ltp and stress-ng on EVL - havent tested
> Xenomai3.
> 
> My test bench runs with the help of an external FRDMK64F running Zephyr
> very similar to what is described in the latmus/latmon combo
> documentation [1]. Given how cheap this board is perhaps it should be
> more widely used (?).
> 
> [RFC]
> I would like to update latmon[2] to the tip of Zephyr - it has fallen
> behind - I'd like then to propose it upstream (if accepted I would like
> to propose that it is removed from EVL). Anyone disagrees?
> 
> IMO We should also take latmus to its own separate tree dedicated to RT
> benchmarking and extend it to support scheduling latency metrics based
> on GPIO data.
> [\]
> 
> So:
> 
> * stress-ng --vm 2 --vm-bytes 1G --mmap 2 --mmap-bytes 1G --page-in \
>   --matrix 0 --matrix-size 64 --tz -t 60
> 
> This simple command (VM and cpu load for a 2GB DDR system) hits the
> system very quick and my externally measured GPIO IRQ latency peaks
> within seconds.
> 
> stress-ng has FPU, VM, CPU all sort of stressors but I didnt need to go
> into those just yet.
> 
> I found some info that RH [3] is providing interesting - still the
> stress-ng code is simple enough to work with if needed (really good
> encapsulation and code base)
> 
> * dohell -l /opt/ltp -b /bin/hackbench -m /home/root
> 
> After five minutes of run the latency is still contained (far from
> peaking, 50% below the peak) but I assume this is because LTP takes a
> while to run all tests. Without going into more details, this difference
> in the invested time seems enough for me to switch to stress-ng.
> 

I think we should split these activities into two streams:
 - short-term: setup of a well-defined but not necessarily 100%
   finalized test environment for EVL so that we can run that
   automatically in CI
 - long-term: evaluation of background load profiles and tests to
   trigger maximal latencies, with EVL, Xenomai 3 and may even
   PREEMPT_RT

With the first item solved, the second could even be automated and may
not need some poor intern to press buttons and record numbers on a piece
of paper ;).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
