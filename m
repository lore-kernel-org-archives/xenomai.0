Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F4314A95
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165400; cv=fail; b=GtiN2xY0XijZMfzWLjUjkmxbrgbEGhTcpcMHK91NDGAUzgAa3k+boQ/xkA1xhibCPmGQQa6q0bidFhy8mz3fmHA0cX8khTsOjQrPdoNbVBiSHMUHO+NkrwNfm50LtuiOzYTgR9Urp/xAILr9BBVuxlSKHrbhrtYXMyYlbMP0Oz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165400; c=relaxed/simple;
	bh=Zd7C/4Y9vehLb64OS2woCBhnIiqwueKr3b1Mfx6WBec=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bfyw43LymFRnMe7MpaTu6zHOkkVAFD7mC8S9Iu08+rOUqxWfIHu5EytG64rIFvfxbJfd+hR4nocp8PA6/vy7T/d9Z5igb+3NIP54oYhP2KxTJsIaYIoFRzfy+Pbw8ERrnasuIcA7ZiVdTGqs5BgHGVLdErml3S+7jWAOQXnO/Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rOy82Qat; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rOy82Qat"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TslsvocgRqRtuoowyoF7ybGYFh70Gzkodwovcg3QYiBdsUCUgqfsnG2vAfUM1sllNcNJerVx6EnoNxDiM0jbPyUEimS+4amJCJ8fD6BDUHsilC31Ejs4gcn0zA9Y4Cxu2B2eeYa0QrQcgmuEjmpf2JhMG/tsqNMhk1yO+qNGEKd5V2Di6M+O0ZjUWZYbHesTFa5Ry58pp5Lv2Sf3OfDlDFGatxzAbDLFuGMIVIloQTI4scUGe5J2nuVgP40e/y89HFtUfxV4lEqHO5wDcktdRGlgAt8gp1ip+CN+RmgP8mjOd8Trmxk/jnPrjShT3yvXr/eRYK2YxXfnYXLX+3A7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2PDnYk2fqfnzduIrHAvv5zgUCV8wtRpM2fgPSpmNt8=;
 b=pvSU/k/srd4WNW+UaZMm+TAwm/DrLv2ZDu++cO+kqRpy76gGX92ZBr1+7K+agyEKCw98Q7QGVhXvXsfr4GZ+9OXnRTXnKq3TOAMgI1dKI573h8rjW6Mr+weIMdK/FOrlTywluO35lcF6WRsxkJYOo0OqsuMLZMNd0jFhLLbwx4bMw1Wk3ftCYDMmzl57FbP988yJiS0shDss+nIL8F0n5sstBlTnl5nOsr+JALR+A2VMKKRURNwspLSgxugbH9wckt1ifMhCvIG+8P2CP/rhNR8ZG8cLPyPNDJeOF6b+1ZH84fifhhNWBPbUOYzBCmXQCV6qmlWjsLOhvVFfD1McIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2PDnYk2fqfnzduIrHAvv5zgUCV8wtRpM2fgPSpmNt8=;
 b=rOy82Qat9dEm+SZ35HwTqrJOwQjYZ1clXumSorwJuNU81N0rPJTVOaeKtY8X3EqYHVPIy3Uyzm+isTCMTtkV9HFMFHYVdSZLfainlUuN5YWKZkNMBUf3b5to+cXAIY6eYUvhZqXsMeL22Zv1Y/h2D2RXw1jULlmeqj7qJiDKZQOx2geL3IJ7R7jRJUUPvLK0hhh/p291hszV4AzcwZ1daIbIrx+E0Y1ugyTKLvkmu1LH0Zzukgq0mXwTp5ZVs/nFzGPLc2Qo+7qypFuck3uh317CupjCohWmEXdLi+MFCfrhJAaSvlTDFUiTO4UqH11BfCTsQqyENLzgEfQ7i+Xecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 10:49:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:49:55 +0000
Message-ID: <af5611a8-a4d4-4b08-8785-efcf1adc8bee@siemens.com>
Date: Fri, 23 Jan 2026 11:49:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: allow gdb usage for ptrace-sync
 test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260123103358.1440709-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260123103358.1440709-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: e02fa8d8-e331-4c38-8ca7-08de5a6d2510
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cERUSkhDWXVaZEpjZUIyaTdScERCQTgxMmdnTTk2SjN2alhjUlowdzhBOUhW?=
 =?utf-8?B?bTBBUG0rTGxhWUpjaHZlK29QZWt6NVVuYzAxa2hqRE5GRTF2YUdkcTFYM2w0?=
 =?utf-8?B?ZHBLR2FaOE5QYlZ2Si84NkhqQVR5UVhpZUZKazNOOExJdlAwbDBJcndYY1JY?=
 =?utf-8?B?WEtMN2lRQVZjOUJXKzYzemk5WmNhNm1LOC92U3pNTVpFNHlvZ09QcnV2UGxO?=
 =?utf-8?B?V1BWTUJ1Zi9hbzZ3QUVnc1JidnV0RlA3MFdHNkc1bUNrbWx5WDl5SEd1UUhs?=
 =?utf-8?B?cjBId1l6LzhSSC9WUEV4WEFBU211cGlJMi9uN3gzcVFhTW00eDJIUWxMSGJU?=
 =?utf-8?B?aWIzdytZU0hMcklpZmt6WVpOd21OTW5EZ3l6azlVeEF4LzIyaDFOaC9oTWZO?=
 =?utf-8?B?Y1k0d2xlMFFvVmZPMzJ1c0dUNWxsSTd1VTdoaHhDcFN3d3hjOHVRMTNwYjU4?=
 =?utf-8?B?QktHZkR6ZzQ3K3pRdmI4TGZxTitNK3hCS2xPMHduTnZYSUxUWFY3Vld6aFlj?=
 =?utf-8?B?T2ZKbnJzNG9zaER0cElEUW5MUjJkdWJlb0krRjhIc2hiUkNINSszb3VVVVlu?=
 =?utf-8?B?eG1TWkh2MExHLzJVUjMxeVE0SUREd21jS29NQXEvS2Q1YVdNczdVY0JrcUxx?=
 =?utf-8?B?TG4wWElDV3ptSWloQUM2c1ZqdFM5c3Vkck1wTzltSUhWa3E0eTd6cnlMalRY?=
 =?utf-8?B?RkNTd2pCRVFGRVBuVnpOam9ZK1RaeVVDamhlYWkzZE8vNFdmSHFhd3E4dmR2?=
 =?utf-8?B?azk4bGJTSEVkWm15ZWx4QlhKVU5Zb3I1Q0RZOWVNZG1SYnBjSWxlZXh6bjRI?=
 =?utf-8?B?dmRtZXVQb1FDMlQvUjgrU05xSVBvRDRiNEVqelcxWW4vWDlaNWttV2h1YnR2?=
 =?utf-8?B?VGpMdHZ6WTlaQTE4YUk1OVp2ODdBUXRIU3F6N0xJZHZOUTduUVQ3MnRnQWJh?=
 =?utf-8?B?a1Nrcnp0TGtXMkNsNGJQdTA1a1N6eHoyZEZJa3lkRVJVNGRaWTR2S3RrdlBX?=
 =?utf-8?B?ODVrbGsxQW0yMkhKeDViRldFZVJHQkdBUEVmU200QTdRalA1VldjSndOM0Fm?=
 =?utf-8?B?ZytiMGtBbUI3Sjl5WXJJdTdMVjhvYWl3RkozUzlvREZsbXB6ZGFmZDMrVzN4?=
 =?utf-8?B?WHNZZlJBbWh6a08wcWNTemdNdFhWZXdVbmJtQzVtZ09iZm9zRTgvUXZWSjFZ?=
 =?utf-8?B?U1YxRDRaMFI3cE9vaEtoWVU4dWlWTDhxOEVraWxUaE05bE5pVEJpY2FRTjZH?=
 =?utf-8?B?dDJQNFVKdzE5SGg2UU81K3hWUTh3WlQvTjNucVNuV1ZqSlNoYnFCdk5leWNa?=
 =?utf-8?B?SFNYdHdNaTAraDloT25GSGU1alNYdGZMa3JSWUo2QitvbENYT0ZvWU4zNHpR?=
 =?utf-8?B?eWVEWjJ1RnYwWnEycElRRFcwcStRNzQ4RGswZlJYYklTU3kzNnRsUHBDa1Bq?=
 =?utf-8?B?ZG9UbWtCUlJRS1VscEpsN2xMZWI1QnRnNDhKb0hIcStVNHZXdUZlS0VDU3Bq?=
 =?utf-8?B?NTUzNlRlMUdBYWU0dTY4VERHTkpGbkRnaHB0aVBMK3kwT3NIZG9mcDV1T0VI?=
 =?utf-8?B?dHJxcEU1Vk0xQ0RhcFNGTnI0ekxIUFFWNnMxUjJhcStXTG9ic0loWHphM1JX?=
 =?utf-8?B?RTYwcXMyb1hBTGtVK0N5dmZKREhzNWlrTWJLVm5DUlZzekxVMVJrcFpNWUl5?=
 =?utf-8?B?d2hJTzd5OTZhYmpwTDVDMDdCQUFXb2xEcVBVNDlpRFdQZ29hWWRKK0xOZVBK?=
 =?utf-8?B?aUZCeDk5TmdWZDE4SHU1RW95T1AxcVowYjY5YW5wOTltcC9jc05Fajh4M0lK?=
 =?utf-8?B?cWdyL3NDMG04ZFBseUZ0Q2VJS2UzQ3FUeGFxVkVjclQxa3VRYU1PaGtDS0dN?=
 =?utf-8?B?bUFTdlhpc1crTVc3MlVmdnVMelhUa2RKNHZIYlIvUkQ4Ti80dXhoZDNBVXg3?=
 =?utf-8?B?MTBobVhzbFpzdnJkU3FsWURBVlV6WmxyUEVuenFBN2xwUE1oUlVpZG00K24y?=
 =?utf-8?B?WFExdzY1dUJkSmFZTDdjb0IrY29leEJFNWQzM1NYanNCbk9SZ1RXb0VNVXNh?=
 =?utf-8?B?c3ZBQmJtMWptQThHRWFoT2ZkVzcwS1pVRFl6Z0FlUk5qUE9YZ1hIS2JybFpj?=
 =?utf-8?Q?ttT9SC72t1RdvWw5qQA94VHnR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBEMmVqUmZYNWFFUjBvZzNkZ0t5d1RncSt4c3hFajhsZDBnVXZWVmkxQzF0?=
 =?utf-8?B?OFJ3SmlGS1pra0ZPUlZzSGZhT2VBRjYwRkhBdk9JSDFyckNEZDRPM2d4S2F2?=
 =?utf-8?B?L2FQMFRSUkF5dnNiWHdBR0RGK0xKTFliYjRTQk1oNkdqOXZ5UE1kMVN3ak9l?=
 =?utf-8?B?dTB3MWpITGFlSmRLUWhsMVdDOCtNczRSVFhnSEQwNEdaYUFmQmVJaStDalVm?=
 =?utf-8?B?bHlnOU5MaTE4M2dNbWZueXN3UEl1NnBERXNFeW80U2xoZ2VrcmtMK1JXUkZN?=
 =?utf-8?B?VmljNkdMVkVLRXlhOU1JeWlGUjdFZkFUbCsvYkhPU3B3SFBneXIzQjJ6K0NR?=
 =?utf-8?B?ZE5CTldYbnYza0NLM0lMeTdDODE3MmRIR25JeFlod1BDL1h4QlZsRlNtUDVZ?=
 =?utf-8?B?MTF5OVJ5dHJ0dWFFTXJhVW1KUmRiSzUzVmpFTGIxTVdXN2RjTEdsSXJJZUJ2?=
 =?utf-8?B?c1lUZ3oxa1FQTEZoVlVUUnRVMVp0dFNTdytHYzhTS3lROFZNSEtHYWVReXdy?=
 =?utf-8?B?a1hlVHMyOWt6emdiQ0NQOTFkakQyd2Rmc3l3dzMzNTJGdHY2TnJsSERUTnJm?=
 =?utf-8?B?cXVpanNHcW56L1NLNHRMbTZKNXF3a3AxdXkvdXJuQlJzaStaOCtWSUJFZVRQ?=
 =?utf-8?B?MkNDMy9VT2NtdGllZDhnaExiZ2p1cTZIQlZGQkErWkVydEpNcVZsUzZSeThk?=
 =?utf-8?B?L1pBeHNTMmVNRUFuZmxRUTRNeWQrMWREQWVyNUEwZnNiQmxWdGlqS2txTFh6?=
 =?utf-8?B?M2RUbGxZSk9ZN1F3TnNGTngwMWVueFg5cU1ZK2tmQ0E0WjJKSUZ1T3FIclJM?=
 =?utf-8?B?TExFZ3QrbVE2akdqakhnaUFtbmlxOXd6ek1sNmtLNlJLMXV2Ukg0TkswMHhD?=
 =?utf-8?B?MU1GV3FrdE1ZdGJONkY3RWo2QVoxRUtPK3hkWDlmWTNwMDRhU1RycUNzNk9h?=
 =?utf-8?B?ZmhSSkg2RFZ0OUpRbmF0SndUbVlsN09JOEx1UDJsdEhnV1R1aUp1KzkrZWx4?=
 =?utf-8?B?eUxZd2NrUklNaDgyeW12ek04azgxVHVuUjNwMVJMMzNISHZ1VUZ1RkJva0Uv?=
 =?utf-8?B?N1BBdnVVNFB1V3dRWWdSRkN6eitzTXJtNzZ2VSsrcWpONUdqSGkyNkt3Y2xv?=
 =?utf-8?B?UjhkY1NVV3Y3QkZEQUcrUUR1bzJHM0FhL1ZQeml4bnZoYlFEZDVBdjc4aFVU?=
 =?utf-8?B?MUwyVm9qM2tPQzJaWFQzVmVpdkhjbzM5dkhRVTI1VU5qcitZYk8zKzAzdXRu?=
 =?utf-8?B?dFE1eFo3OTE1V1ZFeFExYU93TUczYWZZOEM4WWJPdEwrTW5hTnpuaEZvNWhB?=
 =?utf-8?B?SVhMTksveThSYUJySlB5cWhZZ1VoY3FGU0ZRSGQ2YXljVFZlWUxJTkpIS3lo?=
 =?utf-8?B?b3E0cUNoam5ucndsVTFvWHYzUGsrTERYWVoraHNWU3ZaME41cjFwa1M0cjVx?=
 =?utf-8?B?c3lsdVhQeHdsRE5ra2ViRC9QTUVzb3lEZ1d3OXBHaXZuUVBiRkRmODROczlj?=
 =?utf-8?B?U3FTY1BKR0xhVDRQZ0FiUkVvQUN1RkVYb3BpeTl3NW50b3ZNZlFHV3kxMW5E?=
 =?utf-8?B?cDlhUVdEcUVBeVJ3SkgzeWxrUHZYN24zbXdnNnI3dytrRGRHVGFyalFzbmRx?=
 =?utf-8?B?a0QwSHVUMUxTMWNQYit5ai9ONWZGQnozZm12MXVyMklQUXh5akpFRndzN2tI?=
 =?utf-8?B?Yi9FaENBU3VYTUpINmxFbkxNSWNKZlpPT0hyeEErb1Jkbk1EYlpWVUcrS0Zr?=
 =?utf-8?B?STlLaXJvVGdCVXgrcTRHVVVyOUZZOHRuYTZSRlQ5eXlaMHJuUjVQaHBabzNa?=
 =?utf-8?B?NmxlNU5QcjEzRTM3dzVTeXRBaGlHYm1LMjN5UWFidTdBQyt3cHJwRHMybXM2?=
 =?utf-8?B?WkJnTzlsR09GcWNSWE1uZlljblNwOEpWZGFsa0doWEd2VytaV1FoYXU2RE43?=
 =?utf-8?B?N2s1bjJGV2ZPbHN6UTNGbU94TGMrcTdXOWxvU0JHZktLQm9OQmxaK1ZsMnFD?=
 =?utf-8?B?Mm5xaWhvMENrOFV4bWZ6Y1lOZ3Z0OEFiUDJBYmM2WVFUbmlHUmZUMTdHVEJO?=
 =?utf-8?B?NjVOZEJyWTYyZGFKMGVlWVdNazQ3M0tTZ0lpSnVsbkNldkFTdWhsSmJ3Y214?=
 =?utf-8?B?S1ovU0NjaFRIK3VZOWlRZERCYWdsRFN5OVBJVXJPRWZtSkIwMDVEdEppbGpt?=
 =?utf-8?B?VlZjOVI1cG00alB4SjRDbERBNm5hS2xqR2wwemdteFAvU0drREdjZTJPeFN6?=
 =?utf-8?B?ZnFXMXd2ZGQrNUdUMmlmOTloRnRxbUpISEk2Uk9Kb2pIOTA1WjkvR0lFUUhZ?=
 =?utf-8?B?bjBudk00QWdGVzdjbFdyRU5WTWZIVUo3cjFzc0lCSmJjdE9iN3lTQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02fa8d8-e331-4c38-8ca7-08de5a6d2510
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:49:55.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaW1FfJZhYjC7SVdY2WSUxOyaY7f3JO5CkhvGtujFBQEmIemiMrja709gOcEjEYDPAKcfZA0SzrS11W5nXgF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9259

On 23.01.26 11:33, Tobias Schaffner wrote:
> The ptrace-sync test uses gdb to resolve and set breakpoints at some
> named symbols.
> 
> Add gdb as dependency and disable stripping to keep the symbols in the
> test binary.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-xenomai/libevl/files/debian/control.tmpl | 2 +-
>  recipes-xenomai/libevl/files/debian/rules        | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
> index 36eb68c..d9c0ab1 100644
> --- a/recipes-xenomai/libevl/files/debian/control.tmpl
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -8,4 +8,4 @@ Build-Depends: ${DEBIAN_BUILD_DEPENDS}
>  Package: libevl
>  Architecture: ${DISTRO_ARCH}
>  Description: ${DESCRIPTION}
> -Depends: ${shlibs:Depends}
> +Depends: gdb, ${shlibs:Depends}

We intentionally did not model the gdb dependency into the xenomai-3
package. What if you only want the lib for production?

> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
> index 07c28b9..debe269 100755
> --- a/recipes-xenomai/libevl/files/debian/rules
> +++ b/recipes-xenomai/libevl/files/debian/rules
> @@ -15,5 +15,7 @@ override_dh_fixperms:
>  override_dh_auto_configure:
>  	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
>  
> +override_dh_strip:
> +

Can't we use the debug symbol package instead? Fair enough, we don't do
that in xenomai-3 either. However, we only do not strip what is really
needed there, see
https://gitlab.com/Xenomai/xenomai3/xenomai/-/blob/40b2479bcaddf767a779f72a3c707348204bea1c/debian/rules#L110

Jan

>  %:
>  	dh $@ --buildsystem=meson

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
