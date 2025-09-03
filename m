Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8A239562
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919188; cv=fail; b=X8Mw0/fsb0AC8fD4zkjaCNsIntay+/Prt6yjwiGiL30wDXCMPbl9YkAX9l/azM8i4JiZEsk/obrZHlMH2lw0egThJ37u7VLARlaIRoQU8zJqZgF897K6twEh+uiqUFtOCyo9YTJq5jZL8xaMe856/My65FjiA1wABOhHqzwFn/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919188; c=relaxed/simple;
	bh=ZDh3QwPJvA5d1uNlBn4WtaAhrtg9VTD6RHAkdK0DuL0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=UqbnZCMYXPyyfo0Uy3MSUzwco0A6Qw1OSY4HVqE9Is1Jx6VOxGFkJ3jhlIVhSEZfKViHeEi3qRIdWJJ+DWptDEhChN6mhLU6f8IzCXm0ovQnge5KEVK29IXd/xuRaxzWLBKGz0vPbtfbVi89ssiu5z/b+RBDsIoeIX/8JGrZOkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QS4r3wv/; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QS4r3wv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo6hpam+ok1ZoOY9dZwOcucGu6Cxng5sfzt+0BIphECcWxqMC+RY/8BeKeTXn47M1RFXcB4/E6OGZIvboGiODKXinbqA6KgOn6aEG/RmEaDRgtkzT6b9OSrZ/+O6rRRNvoH3orwbQvwcevKDE/9Yjt4oOXIzuJyBKJcTZOWiE8PfWiAaomVmyK/iqLEakqSAXy391cBKqpxAp4J+vSEkjU7+Az+npgN6hqzoYI9zw2ozAD7tJSr2LBUpp4tQgN6J/bp1RLsPKontktxfaSTvIf51GNymz1sNaJN21Uv585XqN/VEdpGCNvV9Z1zhMCGPbbEeY4VCzD70dauaARf5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSmJYj1zK1jGJFXT/y/O8gJ4HZzazQhZAksWOr1niqk=;
 b=xz6CCtSiSBDhil3SBJSstl8THvJgF5fkQbvPiiIHF5FpAxgfAVQ5inylTMmSC4TwucELR9QrFGzTee8F4sw0WWq2EbWd8M5e4RpHoX7fk98IOeJgKEgtYpwwb3PxhKHBJ6mc7Um5M9PrHifJVbxAqjzUC7tDFR6bvIeuytd6mWp8zWlO+1bxL+Kwv4wAy0CDBK01b095PfV1JMYa3Kqf+xr9FWkYgb47wzHIIJsW7Fi+Suwq8Ul99eORUgGOjzIg6H7Vk87gLrIiGdsBj0gAdPU93x8+pDKlRBokSaXAPhH1n0RcNLytnhNz9uPzJdTjoQLa1olAqB21Onjf2dIQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSmJYj1zK1jGJFXT/y/O8gJ4HZzazQhZAksWOr1niqk=;
 b=QS4r3wv/4ukk7j4bSFtoEt0Dv5YEtp6Iy27Of2MWzxS8Szmr+aODDPU9/SHi6MzZlCWvlp07LtJ9dLU9/ankAeijVY8RyEWLzI6MwUGQn8yH4rwLXgCORSN5+6LtVN661TEVRLAJle+P5b41PSBJPo/oy+87CIEMhR8aPiEt9msNDwxxl9iK7Etevpw2Y29nj6l0rP5x2dEaMHNh3HCPNAMbNArmbcYRzo95i24llmF7MN4C6m0p3iFUDs320AsImxoA+1QfIOVCtns9HS8Uq2WH05lYi0m+DosEe80vYI5F0l4NfqnQl+8uS0BhPds01w2ONdWTyBbqnUmXY5Qpug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:06:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:06:20 +0000
Message-ID: <1d94880b-2c63-4085-9223-ea56be2af35b@siemens.com>
Date: Wed, 3 Sep 2025 19:06:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Switch remaining github.com/xenomai-ci
 sources to upstream gitlab.com
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed63478-8cc9-4a34-9355-08ddeb0c33cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzVPMEd3WVFqTnJuT1Z3VDh3a1h4aWlXb2ZOVXJlMjlYOERCUWJ3N2JLK1da?=
 =?utf-8?B?NHk4VzA0YVlVN0tBWFRuRURPa2VIcWk1SDFGTzF1SjVnMmNQOFhuY3h6VXh5?=
 =?utf-8?B?TVlzbi9pSlR3RG9ZVk82cWFTdmVndVhETGs0eEplYXFjd0NjWndmVEVCcS82?=
 =?utf-8?B?MnJvZVNKdlJuRW1TWjZ4cm15L1JVdkVIQjNhMWU2NEwybW10MkpXZTRXR25a?=
 =?utf-8?B?RHlGaVNVZVAzZE9qallRK09kNHo5MHp0eVFjbWk4KzRXclBLZ3UzNTdZREFC?=
 =?utf-8?B?cys5UU9qNCtkRmc5L0kzemZXdkIvVm9UNno2dG9OUFVSVkUwbUVMa05Ta1pP?=
 =?utf-8?B?SVRKNVB3ZjlWTk5EOUNxa25jRCtxL1VQR1BTQlFFTS9odldTelZod0lJVWw0?=
 =?utf-8?B?a3NCczVMMk1lYjBkV0xZY1pHeUUwaW0xRVF4MTl6T0hMUGw3NlZXeVlTZllr?=
 =?utf-8?B?cm9MZ3IrZWZETkNDa0ZzZitBMWlRSEZ2dUZQaXc1N05MU1dMYzhoVUg0NGZP?=
 =?utf-8?B?MmxmK0cxeHhnam5aL3RTRURMMkdtNXFjZ1dZS1UzWmdNL1YxeTZydEhYOHg3?=
 =?utf-8?B?RTAyVUlNaGZvQStieEI4NnAwcDJzdUtLVGxnVDBLNWpmdDFycG83TzZ0QTRM?=
 =?utf-8?B?clhvcjBuWmpJNWFkeXQvRk5CSW00N29PQ2VzSmN3VDgvcFIxblljazhLUCtq?=
 =?utf-8?B?YkxjYjA1YUZtbjJ6dm1WT3hjUjQ2MmVGb2FBQTFYc2ZoNmtDK05WS21WakN2?=
 =?utf-8?B?WmZLQnc5UElYYk9SZnZ3Y2RDTEFXdW95bmEvUUgyclhFOGNEc0pTaFpLaHQv?=
 =?utf-8?B?clJQMG9XWGczZmhseGNDZEtOY1ZvTWdQSCtwNmVxWVBodGlXUExaL09zcEV5?=
 =?utf-8?B?MkF2bWhRUkkxOW9qOFhWaVVqU2hhdnYxb3ZXT1NPZ1YrdVhUNmlzVFd2UHMy?=
 =?utf-8?B?ekNTbjcxQkhSUlFkdFFOSTgvUWZTa1dOMGMyTlhjdTBQZGV4Nnk1Z1Z3ZlJa?=
 =?utf-8?B?ZXZ0SVZYblB0bXpENzRUSWMrc0JlQThMdlBjMktJU1E0MEJpK0NpdStmTEdC?=
 =?utf-8?B?S1I5UU1GdUYyQ0JpK1dGWTNWL3BNL1RmS2RnQUgwRzRJUWdGOUl6SHRUeUxo?=
 =?utf-8?B?YkZrYktNbHQ2TkRVY1JoR01jSiswdWJoTTBNaERlc0VGREVJRXV6WWZmV3pB?=
 =?utf-8?B?b2lNaU1EMks3WkNlVXFnNEFZOWZVTVBFUXFFUENseXJiSk1HazlxaDBEVHJo?=
 =?utf-8?B?bTE5d2pMdm9vSHBPU0hOT1V1Z1V2Q3RhUGdaWlZNVGlnanBvOWt2ZG9Dc2Zz?=
 =?utf-8?B?OTFkaGJVeHozVnlzOEhiNFExZ09xMnNpNkhQT2tjTk16REVnWlk1RGNud1I5?=
 =?utf-8?B?Zm92N3dxaWtvS21LRVJZL1hNMzBIOFBFOEZuKzlneXpvZHJDbmpGVUVWTE1p?=
 =?utf-8?B?RlhoRUlMUm10eERrVmtyRVJ0cW1BUVpLalFSMWtMNm5JSFg0cWNYdEM0WHk0?=
 =?utf-8?B?YkdqZnBDRVU1YVczV2lOYkFCcFNRemZmYVJ5MmlRSWltZlltUlVaSVhMNHp3?=
 =?utf-8?B?cDZpYytjWHhqUzZ2UUszc1RUemMvc0d3eUxpOHgwZURJR1BraDNMVjF6K2tQ?=
 =?utf-8?B?cjE5UHdiY3k2c1VGNHM2NEowSzkwRk1TNjJBYk90M25qNmU3N3hLR3JTbWRl?=
 =?utf-8?B?K0d2bFVJa1JMWGRDWDU3S1JaNkUzTlpnekhPb1hFRmJ5eWQzbG16UXpieUhX?=
 =?utf-8?B?TjBteERDOGY3SWlvb0lZT3Jubm1OUmNyakRUSTBVK2tQaHB0a0RSQ3ZUbEh2?=
 =?utf-8?B?SW9tdjJGZ0xvQ3V1WElQU2lSTDE1aXZpMHdXVHRta1JNM0IxQzhWd1gwVmJv?=
 =?utf-8?B?SGNsaTFCb1B5SUNubzVnWFozUFQzN0tzUzhBRHJaVXF1TUlKWEgvSXdvVHo0?=
 =?utf-8?Q?l3H7CDx+pu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1F3a2dFUHRucFI0MjhFVEswN2JCbElId1NPamk3dzV3aWJ5Vk5wZGVMSEVR?=
 =?utf-8?B?VEl3akJmT0RaS09Ham5ucXdaUmZQYzVuRFNGd25NK3dKTlJsT0NXZHVibWMy?=
 =?utf-8?B?dithSmpHcnQ0VUFmWTNUSUEyRjBqVVRBRFRjWnU1eUFpT1JBK3hsaDNKODVS?=
 =?utf-8?B?S3BtNXhRQ2dIeEU2Y1BpZkZ2d3FTc1J3WFROaHFQVW9LYlhwaGtuVy8rQWYw?=
 =?utf-8?B?NFVFK0lON0NhYU5Zck5BanhJelBxcStFUW5JLzdOVncrWXMvdkJVVnRrSVc2?=
 =?utf-8?B?aUhwSGVhY2g4bGgwcVVmTXdtQzRVdk1uOFA3enhuQVlKR3VKMjIybmVkL3hZ?=
 =?utf-8?B?SEhGTnRVdGE1bkYyRGRPR0JSSjlnaWg1Z1drMmNvSFdNUWIxUWFPWVJBYUVl?=
 =?utf-8?B?OFNaMlBwUGExcUpSV3VJaThGUks0b25Sdis4VS9aK3lUWTZvcGVSZ2tmUWJQ?=
 =?utf-8?B?clNHN2d2SWZqS3JnM0FtdnBPQmlaWUx2emFTRzRSM3FtZ2FlTjJZdHE5RHVq?=
 =?utf-8?B?K0xkRll3aGMyVzV5RHdBOC95TXNaOVhJazhEL3FLYmI4RWhsalptempFQzZQ?=
 =?utf-8?B?cWU5R05RT2Z6Nm9wUTdleW42Q0xNc0ExbkVCRk1mK0dVaW10b1NIbm1FcU4w?=
 =?utf-8?B?ZFUzRmozc0lsSmVoQ2pFclUrbXBVL01mUCt6RzR4QmJieWQ0dU5xREY5eHZB?=
 =?utf-8?B?ZFE4Y3JpYzArL2Qrams2Znl5ZERUaHpxQVk4NkRXUXdKTGVBcmpMaXNteHlD?=
 =?utf-8?B?T2hTeU56dUsyZGhkZ0FaejJhdTFIR09iY3RtKzljbGZCSEN1ZEJ2VitDOGNU?=
 =?utf-8?B?Y3ZzNjYvNTZLVEtGU1JvenkrYTZGMXNVd1VIQkpMd0U4aTBFTUI4ODRCNnZr?=
 =?utf-8?B?U09DUExJRW9LMkhoK3dNNEJxTG5jMElHcXEwUzR3OWZtdm9DMFo2alN0SjlH?=
 =?utf-8?B?Q1g3elhubUo3Zi9kSzBRUVZSN3lCWXVFMGFPRHo3MmFmSllOWU1VVUdJaUw2?=
 =?utf-8?B?N2tGT25CeGNFUlFMYlRCR1FWQ2VhWlpxZ2FzTjRJUTRIVEVPVjlELzFxSThG?=
 =?utf-8?B?R3ZybVp4YjB6QmdnT1RnTWc3bG1meG9PQnArR2hodDNJZWwrU1BjWTFCVmRH?=
 =?utf-8?B?S2k1Vm1pSnBFeEN4Ky96QVNuMzd4aUdKY3JNdEE1d3pNK2NlOFpDVnE5WXpU?=
 =?utf-8?B?Mm5NdysrWi8rTzBVZlhIcFBadHU3ZkFUdGdJVDNwOFRiVGZSVlBJbDV1c0JT?=
 =?utf-8?B?Y3BmbnV4OXZmeFRVc3d4NFRLekFNVkMrRi93clhRK0FoSkFuZ2Fsa1VyQUlH?=
 =?utf-8?B?YmEvN0tqOFdYcWw1K2lxeGc4cWVOeURDa2xtMXhueXVTaUQzRTlNVGNsUEpV?=
 =?utf-8?B?dW95MmptcWhJT2ZFUHEzRkNkMWlzRFM5OUR4UjhJc2xGMTlzdHpmV2Y3SEpz?=
 =?utf-8?B?UEdhL0REd2V1My9TMFpTdlJnZVJvYlUxRkJMNTIvRXRITlBpM2crckFQRGpH?=
 =?utf-8?B?OFFneVJoajQxNnlzUS84Z3hWR3pXTTNVMnBJNTk0STJQaUtIdXZwbTBnTWxK?=
 =?utf-8?B?ZXluWXJyRWZ6Qmd2MGFIYk15N2J3MzVPa1hwMjh0Y1NidmllQ1JtZVZHZ3Q1?=
 =?utf-8?B?c2ttbVZ2aFF4eDJaelcwQ3FlL0xVcm1BL21JL3p2cVMrMGNGQUxhaTREM3VX?=
 =?utf-8?B?NWZyUmNoMlVrdmJ3ZHovQU1vOVFQbTZIVEFCNThpa1AzUU4zaDcxU1ZnNmpS?=
 =?utf-8?B?OFRJeU9wclpraXQzOFB3YjEwZ2hudjZLZ2JvQktuSzFCSmJ0UklGSENQSzZ6?=
 =?utf-8?B?dU8rb0JmWEZxZFBiMHZMWWYzbERaMGZNZE53cDVKTzFhMXcyb3ZUOWYxUWxJ?=
 =?utf-8?B?ZVVDRStKZXFHbjNEb1RwWHh0VS8xdG5FRU1PQ2hBK2RKdUY1QWV0dUFYVUJT?=
 =?utf-8?B?cGNVelhtNmFnT1BuNVR5RWRkVktKa0llbENQdFIyOUFUYnlmTDVlZEZ3T3dt?=
 =?utf-8?B?M3ZZSGxVdGExbUt4bkREeDl2NWUxdTYyQ2hhRjVuL2k2Y1dTM1kxd2g3dEZ0?=
 =?utf-8?B?c3c2KzFXeUFBQ0VvbUJDOUxVV25mZkJlUU5LdmNTRFltNXBsN3d4Uk9mdnh4?=
 =?utf-8?B?aUlhWVM0a0h3Z2FIcldabVhFT1J3bXNnNXE5OWhmY29STU5CQVFsSGMwY2NS?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed63478-8cc9-4a34-9355-08ddeb0c33cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:06:20.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmAkPoxokQG0t7iuRW2fJsaGprBmuG2XZ+rzMVDwNeU6hFfKTRme6/abz7mnB4TCnWdvBmP4kbADFDW1wEHibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5574

From: Jan Kiszka <jan.kiszka@siemens.com>

Those were once used to compensate limitations of the source.denx.de
server. With the relocation to gitlab.com, we are on scaling host and
can avoid the indirection.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_4.19.bb   | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_5.4.bb    | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 6 +++---
 recipes-xenomai/xenomai/xenomai_3.1.5.bb       | 4 ++--
 recipes-xenomai/xenomai/xenomai_3.2.6.bb       | 4 ++--
 recipes-xenomai/xenomai/xenomai_3.3.bb         | 4 ++--
 recipes-xenomai/xenomai/xenomai_master.bb      | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
index a4b6dfb..d906dd0 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai-3.inc
 
-SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-4.19.322-cip113-x86-30"
 
-SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
 
-SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRC_URI:append:armhf = " git://gitlab.com/Xenomai/legacy/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV:armhf ?= "ipipe-core-4.19.271-cip90-arm-19"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
index 71e0066..b2acad6 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai-3.inc
 
-SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-5.4.284-x86-17"
 
-SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
 
-SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRC_URI:append:armhf = " git://gitlab.com/Xenomai/legacy/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV:armhf ?= "ipipe-core-5.4.231-arm-6"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 52fcf1e..7939583 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -33,7 +33,7 @@ python () {
 
 # default: amd64 or i386
 GIT_REPO = "${@ \
-    'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH = "${@ \
     'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
@@ -45,7 +45,7 @@ GIT_BRANCH = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
-    'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:armhf = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
@@ -57,7 +57,7 @@ GIT_BRANCH:armhf = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
-    'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.5.bb b/recipes-xenomai/xenomai/xenomai_3.1.5.bb
index 8cfe184..ed77ada 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.5.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.5.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2021
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.6.bb b/recipes-xenomai/xenomai/xenomai_3.2.6.bb
index 0bd7007..a8985ac 100644
--- a/recipes-xenomai/xenomai/xenomai_3.2.6.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.6.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_3.3.bb b/recipes-xenomai/xenomai/xenomai_3.3.bb
index c2babdb..5ccd8e2 100644
--- a/recipes-xenomai/xenomai/xenomai_3.3.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.3.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=master;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index 708ddb3..7438f63 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2020
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -15,5 +15,5 @@ require xenomai.inc
 CHANGELOG_V = "9999-${PV}"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0
