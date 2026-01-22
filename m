Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7D3254A9
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078135; cv=fail; b=fvZVfY6yUvhO5wBGO1MLjZ80ogNWOvyNSJAluSggNtbeQTh4s1wtmESOlCM+vM5rBqPZnHkmK/2HLRr1hxhA5xrMydXj3+CHerA3V3R88Tzh5fkt5GtYYOAA4ebSSh/9qi+2Mp1oZ/FUUNcrhzlIoHywQUzF1pvicLTJaZTpPXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078135; c=relaxed/simple;
	bh=kMb737Ae8vtXo6YBP4MOWctzvjQKtA6XSv49VAFLH2k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9WnVtymT6J/2SvgLIyaGwfgg2nKTRjGhmUUL02TGdLCrFPg0oY3xeKiLvPlyvZ8ob0WziiYQ+gtKNn2Umw6sE+zwtl3RdOW/fgTdgN2tD5agzzh3wf0tZgEq4GlG+GEYgcFzjmmo/zMWlYCt+FCzdAUpMLSrM/3kM34UG/ISdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wkMntE3k; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wkMntE3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM0eO6YDbsNfDammjqu0ght+aiOBC88fIaC6aVXxeZxar42Y9+cEGe0ZAze8qHLBZlScqr3Iqp98MnIXnu0JDas/xryMkO10aKrABIXNhWehhM9pMEb5sz4UMCH1+6kKl+Bh/tBJ5j53M7vhG1rB4oxr2G3zQy0MPUsQ4zbWkY9FsQNbBhVk6gCF0LP/oIG9VZwYgturyuj1hfT0DcanSmcOfn/ad5bdYmx2StqskK/JwRqEIwo7Cc1ZGKT55zVha2RTJarhSX2MV/CDOtKkt0MXxa30EIxPuvL8fbpbHgwRIHNTv1GNN2PhOpI0DPW724GXlKLdD73G48ZSYcWxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WiSCbLrc0JOzvrqo4wEcRRhhff1C2bRSWTh4i5vyv8=;
 b=eR8wgcHKvGuh5bJvXgTyTOUZa64abjbufd8USBtHH9q/+Eo/O/BPBXwEP1FGCdkoHgMIPUCb6WPF6w/ynw3nCOFYHnAYeansKN/IIFPeJBJ6bNq89dxyvLkch0cwOfroc1QOflTNrqemUczrQV75c8AZ1/EM0c8FUdqlgCt/4wA2qDncNLibcyMyYU/4ExqpVg/wsEcJ1fT27SMqPEdEPn7lKkAtUgFB+ciMesEHPFAp0oTDPntkc7ulPz2JJvvNB/fh9E/RxbDUF97npkX+cXSRBcp5bU8VorB8wNa0hdYgE3ET16k30g6mQEwB3RiRyWqZULtNO1MXkK1Ccp73Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WiSCbLrc0JOzvrqo4wEcRRhhff1C2bRSWTh4i5vyv8=;
 b=wkMntE3kJModyO67dNWGqz4JLl4aoRYXkUHANGMU+qbBLKc3qP6D0s9sb2SEZQR1zx7vGudRt5I0tqItAmgBdSujQ/pBsc1SkjXSvk2Zt0Jf3b6N5dZ7GGKB412+ugHYwdzUISZW5qIlEggQmw9A4h5WFATSvKjRoH7feo6pfDh2XOp4m6QnDbeXofZwymhN6wSnt71tFlqUc84yUcbtAlTJJf7xcTXTxtXLgmw6ZpdGFm3bzHaTWO6XzTfe6PMYxMNpL18nDZvNIOu8lxVTcZ8eLF438LMB27gDlWTL9AIIlyXDQaPOU1f1Apk2FHDZ0SIULlD0VnrlcNLtjDiDmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:657::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:35:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:35:29 +0000
Message-ID: <2d1a4a7e-41c1-406d-8e3d-46b025c1a708@siemens.com>
Date: Thu, 22 Jan 2026 11:35:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v3 1/2] riscv64: Add support for RISC-V
 architecture
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260122103259.423957-1-tobias.schaffner@siemens.com>
 <20260122103259.423957-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260122103259.423957-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b705a6-bd9e-47ac-cf6b-08de59a1f6b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUFNUlVqQU0xbTgzWC9XVmdLVzk2K2EvUEhSRHQ5VHJuMm9scWl4V2VIRDJu?=
 =?utf-8?B?T3c0VWFxVHN5Yy9UOVQ3TFloN1gvM2V5V2Ria0RPemRmeDh6aytraHZlL0hO?=
 =?utf-8?B?RzI0TFNPekVpY3B2a0tFbS85d2h2bzBITEhpVUVsL3BWK0kwaE1FNHk1YmE5?=
 =?utf-8?B?QVR4SW8rb2IrczJGS1pkZ2x5cUN2RHMySXlZSE9UcWlMSGhKQy9HTHFpdWd0?=
 =?utf-8?B?UGVodVNXcEFrcmtsaVBnS25ZcjNOaWtSRkFBZGtyRHAzMHpBU0VxRjduOGxj?=
 =?utf-8?B?eFVFUXk1TGpmQTlMUU1iN3Irb05ZTTFhQ1I4c2F0NThSVUFkY214cmtlcFU1?=
 =?utf-8?B?UTFiYlVlTlN5azBRUkpYLzlEcHR6N2ZkQjFTSzFZVUNCOURiMDF4VlNwZ0U1?=
 =?utf-8?B?WTZLVEx4Tmo4cFF2amhJcGovb1ZBT2FNQ0g1TVlCemtoM0dhQmhFOHEvVGtW?=
 =?utf-8?B?NnR2YURwRGlkUFViVkYvMTdJOGdCTDVDNkJLU1ROaGo2SXNPWCswR09aRFFi?=
 =?utf-8?B?eXlBaXNXSGIrOGFGUndLQXZZV1BzMWVlUjhSTkx3VDNLdzZIbFl1alpDR29m?=
 =?utf-8?B?Z1JFWkhXZ2F4UWRveTRpdHJSYW42U1BLdTEwOE1saERCcGxyRElEUStVYzdh?=
 =?utf-8?B?Q1BSaWlDTEdzTkZHajFqSG0zUklwOWczZWp4Uy9NZDJtN05RVjk1Z2I1TVVJ?=
 =?utf-8?B?OFlVMFR2SW4xMG9mTkdxSi9ia0VUQnM3VEc4TElpUEVkWm1GNG55UWZLWjZB?=
 =?utf-8?B?Vk5mT1VXTmtIK2FyYVg3VjRYWmVGSVAwQUdYVTBiSWFENzU2c1JZc2p6Mm0x?=
 =?utf-8?B?Z1hlOTVzNVhIVzJJUTVWemVRdFRqMndGTnVVZ0x1QSs0THExeThQM3p3U2w1?=
 =?utf-8?B?dlJPanhUZnVjbitQRFJ5Q05UMm5tUlJmUXhYSHJxRXNVUUVtUkRtRzQ1aHNX?=
 =?utf-8?B?VVhTMmN4eVVudGMrTkdCYlVrS0duR0dLWmhjVU9RZEhqVkVpd0NPRFF3S3JM?=
 =?utf-8?B?RzIxWUw1QXFscnV1ZEFIRGhRdmpuM2cxR1duZ2dLZGJzbVhkbE1KbWR2ejMr?=
 =?utf-8?B?U2M5V1huNnp3bWxlZWU3bkZxUE10enRLVGNhSzRPM0xzelNxV0trTkVaZkVv?=
 =?utf-8?B?WWRGc2YrYVNJUytRRUdmaVl2TFlTNVBxZWNDMlVTNkhONFdIaGlIcmN3Nzcx?=
 =?utf-8?B?ZWRBZ3BLMm9mZjBteU5lQk51NUR2aDlOWnJJZ1dZeDl2OUx3dHBTTDdIMTIr?=
 =?utf-8?B?OWg0VnFtNmtJT1ZTTXYyMEMzcVdjb2hqcGxYc3M0K3o5dEFpUmtuOVFscHEy?=
 =?utf-8?B?T045T2FJSUl4U2hNSWVsaHdrNUxTZVdMYTNyOVN1R2FXNCtXVVlpcWp6aHRE?=
 =?utf-8?B?KzNZTVN5aTJCbkVTUFc1MGpiUUo3NjZDSEtGVU4rRzJTdkNrR0NUc21vNzhC?=
 =?utf-8?B?VVUyaEZNaDZlNmZ1Vk4rTmkydFdybEVEcGF3UXp5bmI0VTRlWGZkYzFnQWJn?=
 =?utf-8?B?c01WenRGWnZPVDNJZDdlcXRhQiszVVRlV2xRZWpEdTJnOWR3RFoxNVo0YW5N?=
 =?utf-8?B?S1FYQXVlTjAxdzg4RlBVaGI3VFQwdDRiS00vU2d5MmhkdmN5azRtOFRWcFpw?=
 =?utf-8?B?em12cFlzRjJjNkFycHpPTXBVRHcwN1hHZG1RTUs1QjFYaWZVOGVJVUg3Yk5H?=
 =?utf-8?B?bk1qVjRydXFtR0QvaWtLUXNJRXkwMjNOaTIxeEYxU0J5UkJDNlpCWHpseTF1?=
 =?utf-8?B?SlRnKy81WkIyQ2t0eWg5QWVCRlc1bjNLblpFVEhWK1p4ckMydlBBVHgxZWJz?=
 =?utf-8?B?Y01GUUJDR1dnMW40TmFHMFZCdXFIM2IrK0V3akJlQWI2Tkd1Tldkdk1XdjE3?=
 =?utf-8?B?VXAzbkNDanMrSjJtdFo0UkR6dm5IQUJkSVk0TXJ6Z0IzTVZzOFFBaGdXYWhz?=
 =?utf-8?B?ajhGQjVtNGdQRkFhTDlOMTdVRDdpWitTaWxnVkVXUjlCUnQvUkVGSkJiZzJD?=
 =?utf-8?B?US9yNmdoZFpaUFBMYkhLd2hFQTFONzhGM2pnVERJdjd0ZHJ0M2g1a25xUHBO?=
 =?utf-8?B?MmJ1VUYrZmwrTmwrcHdMOEF4cVo4b3dCbm5SRHBjajA0RlhaVVB5MVlNR3Rr?=
 =?utf-8?Q?0r6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czlWOGNjT0hWWWpmdCs0bGh1V3VEZnovS1lZQm92dzZGdStMekI1ajhIYjFF?=
 =?utf-8?B?dUJWVWQxZGpqMVlIRHJ5ZmRYNW9FZnB4T2lhWk50RTRTdVp3cWI0RnBKdGJ6?=
 =?utf-8?B?UXpjOENhYzBLT3lBR1VBc3ZVRTlEVUJjcG1xcURaaUpUYlFycEIyRFRKREwy?=
 =?utf-8?B?bWhTSXdxREt3TVNRRzdDQ0kzZlFiN01aVzluRDlSb3Z6bDQzNWlqY1gzQmhY?=
 =?utf-8?B?c01Oc05OU1pvdG93ZkVSVHk1MGhmSVZMeXJPMSszdjVtWXJVaWU0RFh3VkVu?=
 =?utf-8?B?b1hZeTl6WUZOdVVCbGpLZkpMWXhrZDZ0d2JlUDBYUVBsR0RYZ0VXSGZxbTZh?=
 =?utf-8?B?dkk0YmVXcDFlcXdyS0NQeE9rSlk0bXhjazllQzRuYm04Z05CM0luTDRqT1Nx?=
 =?utf-8?B?aWorQlovTnZVNHpzWUtkMS84T3ZPckNKS1F1UForU1J3dkU4ZkdzSkFDN2M1?=
 =?utf-8?B?NFZIVmtzL0dHbzhxNjVlM3BaZytCKy8rR0tFS1BHc1VSWHdtZDcxWGFOMFdY?=
 =?utf-8?B?OUFyRGRHN1Yzd1I4MWpVSjJHY0ZvVEdqaE1CRktIVXpJdEEweHdhYkhidFJn?=
 =?utf-8?B?V2hZWnVMSVRXcEg4UVoycXIvVVVYZGg5TVdkcmRTVll1NHF6VnJGVnlIUmE3?=
 =?utf-8?B?djdIRFpZRDB4M3hOZ1dPNG52Z1VXbHRhdVVFZGRZcDgySkg3RkE4OUlqcjg5?=
 =?utf-8?B?Q1pmWFJ3YTNyNGZoYmplWjZtT2VPbUkyT0luMG80RWFSais3VGk1cWY4SXdw?=
 =?utf-8?B?NkhoZVBMdkRTaVVHMVFYbTYxV3BYaVVJbDFLb1RLODNxbkdUTDZtTTFaTlVC?=
 =?utf-8?B?RlJRY2lqNlJuMzFVdVlUSGlGWVQyZHFMOWJsY3l0ZkJWQmRxV2ZzVnpqQVFE?=
 =?utf-8?B?ZVhOeXVzQzNzSWxOT0VrWkNqcGtIZVdxSklYNlVoOXFPUFBHKy9sdk52a2lB?=
 =?utf-8?B?UytwRFpqR0wwa2s1ckhxVkJRanZRMllNYm9TZTdndkpmcGhsWXVtNnhESjRK?=
 =?utf-8?B?L293cSs0MzZ4aWtybEtlOGhTRmlWUkhRamxKMzdEU0c2TEp3aXVXMzV0ZHRm?=
 =?utf-8?B?MWpmZDA1R2J0b0l2MTRIc0hLQWdhRXJWekwvYmpJcDlKM2dwNjdMYUp0aXlu?=
 =?utf-8?B?SVhPU0VCcDZTL083Z29IdENOWCs3Y3hETk4xaUZGUFNKZWFWeHA4YnFRUHZ6?=
 =?utf-8?B?bmtqWGdrZnN6a01IaEt3TEx2N05MWTVmcHIzWFBuelRvUlBaRExXTGl2amh4?=
 =?utf-8?B?cEM4WWhLQTBEN1JrTUU2VjJwN3NOZjdHWVhRVkFrZ2RmTHUvbGdQVnY0L2g4?=
 =?utf-8?B?b0JqdFJ6b1EzNk9GdkwxMURRR1lLM2lCSEFiNTVHYTkxQm1Udkx5aW0rVk05?=
 =?utf-8?B?RDNoVHlUbklxaktSeVIzZmJtWDc0QU0ra1NqN2ljeXAzS3RtTnhVVnNjYXZa?=
 =?utf-8?B?ZXNkbzJkRXJPRmZUNXEzZWFwWFgzSklDOUg4WTNkaDkremxsQzhka2FrRnJT?=
 =?utf-8?B?K21idDRlV3lVVmkyNm1xalJsSWNPUUwxd2QxMnM2Z2t6OUpRNkx2S3U2SC82?=
 =?utf-8?B?b29EdGhtNkRScDhTdEllNEhQcmpwU0dBdXJUVGpzaExMSlFZYm5YQ2RYZzVo?=
 =?utf-8?B?MloxdWVEQmUwblVhd3NaRUdRWFF3V1JDdW9iaHJKSG9kY003SzdhVWxHN3Nn?=
 =?utf-8?B?UEFGUFJaTG9tU1FRVXR4SkZJM0xWVGJxNnJZK1BZMVJ6NjFNUEt1S3R0MnpY?=
 =?utf-8?B?Uis3NXRpOTVsTXdpcmc1UlZaSlFxNXJUdkRvcVdOTkdlUGFZSCtTS3lGeHpw?=
 =?utf-8?B?NzJZUnVMSXAvMlE2dEw2Y1p0Vmtwc29MVnltZ0cwMWZaSEE2Lzg5b2htaUVq?=
 =?utf-8?B?djZCTEExV2gvbEszN0hpeW9WK3lRWkh3YWhWZHl1bk9Lc3JGcHpMWm5mRS9F?=
 =?utf-8?B?QldqbE5mdWVqcHoxUDlFdEQ2QVQxT01lV2luZkF1R2VrWG4wUlBCRzJ6K0oz?=
 =?utf-8?B?M1UzQ3pNN1Jmd0MybWdiM0tzSVJhSVBIT0FlSERiUCtiY0ZTWGtBMTZnTEVM?=
 =?utf-8?B?dnAwODN3S0M2YklBOG16UTR4UEkyT1pGMkN6d2dRUTgyc2ZsWXVjc1ltREdy?=
 =?utf-8?B?b2JnaWRVR0l2UTV1SlkrTzNOcll3U2ZkWFl5RDZOZjEzbHRvVVlYWVVwd29M?=
 =?utf-8?B?dVU0Z2Zoa2F2emJXaDZTUHFOREtTaE1BbzhYZVJYUW1LODZDbjRYcUZkZEI2?=
 =?utf-8?B?RjZERndUSzIvdys5STdRWDU0Y01NNjNHdDZlektReFRBMlo5Z1JhRmdBVWU3?=
 =?utf-8?B?SXlqbUhyQ3N3MWFISDZBUmVjWmYrQWw3WUorWGdtRmtmdDBhdGtJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b705a6-bd9e-47ac-cf6b-08de59a1f6b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:35:29.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/5INyRwWBARzlBqJfI8QVWag2a/L5U1DkqpJ+sx6H4HFrXcw+uKAQ5H5hTXD/TxNup6ptMiemU+LK7UR0pDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9788

On 22.01.26 11:32, Tobias Schaffner wrote:
> Introduce support for building EVL for the RISC-V QEMU target based on
> the current wip branches.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  Kconfig                                         | 14 ++++++++++++++
>  conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
>  conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
>  kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
>  recipes-kernel/linux/linux-xenomai-4_latest.bb  |  3 ++-
>  recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
>  6 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 conf/machine/qemu-riscv64.conf
>  create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
>  create mode 100644 kas/board/qemu-riscv64.yaml
> 
> diff --git a/Kconfig b/Kconfig
> index 178db97..dec7458 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -17,6 +17,9 @@ config ARCH_ARM
>  config ARCH_ARM64
>  	bool
>  
> +config ARCH_RISCV64
> +	bool
> +
>  choice
>  	prompt "Target board"
>  	default TARGET_QEMU_AMD64
> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>  	bool "QEMU ARM64 virtual target"
>  	select ARCH_ARM64
>  
> +config TARGET_QEMU_RISCV64
> +	bool "QEMU RISCV64 virtual target"
> +	select ARCH_RISCV64
> +
>  config TARGET_HIKEY
>  	bool "LeMaker HiKey"
>  	select ARCH_ARM64
> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>  	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
>  	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
>  	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
> +	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
>  	default "kas/board/hikey.yaml" if TARGET_HIKEY
>  	default "kas/board/rpi4.yaml" if TARGET_RPI4
>  
> @@ -67,6 +75,7 @@ choice
>  
>  config XENOMAI3
>  	bool "Xenomai 3"
> +	depends on !ARCH_RISCV64
>  
>  config XENOMAI4
>  	bool "Xenomai 4 / EVL"
> @@ -215,15 +224,19 @@ config EVL_KERNEL_HEAD
>  
>  config EVL_KERNEL_6_12_HEAD
>  	bool "Head of 6.12 EVL branch"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_12
>  	bool "Latest 6.12 EVL release"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_1_HEAD
>  	bool "Head of 6.1 EVL branch"
> +	depends on !ARCH_RISCV64
>  
>  config EVL_KERNEL_6_1
>  	bool "Latest 6.1 EVL release"
> +	depends on !ARCH_RISCV64
>  
>  endchoice
>  
> @@ -244,6 +257,7 @@ config LIBEVL_NEXT
>  
>  config LIBEVL_RELEASE
>  	bool "Latest release"
> +	depends on !ARCH_RISCV64
>  
>  endchoice
>  
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> new file mode 100644
> index 0000000..8dfcda4
> --- /dev/null
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require qemu-machine.inc
> +
> +DISTRO_ARCH = "riscv64"
> +KERNEL_DEFCONFIG = ""
> diff --git a/conf/multiconfig/qemu-riscv64-xenomai-demo.conf b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
> new file mode 100644
> index 0000000..90980cd
> --- /dev/null
> +++ b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
> @@ -0,0 +1,14 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +MACHINE = "qemu-riscv64"
> +
> +DISTRO = "xenomai-demo"
> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
> new file mode 100644
> index 0000000..3b9bd6e
> --- /dev/null
> +++ b/kas/board/qemu-riscv64.yaml
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: qemu-riscv64
> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> index aae7910..4ae9774 100644
> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> @@ -31,7 +31,8 @@ python () {
>  }
>  
>  GIT_BRANCH = "${@ \
> -    'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
> +    'wip/evl-riscv' if d.getVar('DISTRO_ARCH') == 'riscv64' \
> +    else 'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
>      else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
>      else d.getVar('LATEST_KERNEL_BRANCH') }"

How about just adding

GIT_BRANCH:riscv64 = "wip/evl-riscv"

here as well?

>  
> diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
> index 8fcf768..48f10dc 100644
> --- a/recipes-xenomai/libevl/libevl_master.bb
> +++ b/recipes-xenomai/libevl/libevl_master.bb
> @@ -11,7 +11,10 @@
>  
>  require libevl.inc
>  
> -SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV}"
> +GIT_BRANCH = "${PV}"
> +GIT_BRANCH:riscv64 = "wip/libevl-riscv"
> +
> +SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${GIT_BRANCH}"
>  
>  CHANGELOG_V = "9999-${PV}"
>  SRCREV = "${AUTOREV}"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
