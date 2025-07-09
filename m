Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012015.outbound.protection.outlook.com [52.101.71.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5026F462
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046461; cv=fail; b=Us3nJNw9/H32NUeRNgd7WzzxosoCjM+Lft4yngT7PHlvqc2cd9X9GsFs7V5czLGId7/siIxv6dVoCADfkpY2zKACDzSc1F3r91xjLNdOSQGYxRtknARykXCrWJEG5PkdR1uEc5LvrYAAtWtN2GyiJkUXvZoqRAJf3U0lrWd7uC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046461; c=relaxed/simple;
	bh=PaAkiN61MUP8WaE0sDtPDMo5Na+JZ2vlH3Q/O3ZwiDQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBgpv+tvNEmo+hg/dYBvWV/mC1gEABTph/2TWcbS8E5RL7EM6pplxaSqlZXrT+ZA+SbfIZ+Xsq27YCMQXeSrQsjr57t/tdcfcoy8IyU6FVea0rajmbWyQuOzI94n8Ov96aBEkIuc+1MbXOqI+POLoFbQ0hXrPzWRaijsk21oFmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AFXekdGO; arc=fail smtp.client-ip=52.101.71.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AFXekdGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThGbJZSJHj4e4OP+ETRXJ6Y5xfDVxyZnqPSEwnof4siul9Fwk8OSWEVsmjmAWiHEggqtKYxCqRHc04GkgipHLYVcA/hoT45vtZIQMj0/U6Rmo87r3BRJMFo7w54wzvTBDvV+4ykrmwayWyfWWfTMXF6i05oAsSXASa4MoGvZ0k5Ps3mXDMYWEt0C86owm4HVb/MCAARUSjLXomNyF76Zc/W1KxlTtKy/dmNRsAzXRQHxOlyAKTdUrvbIaALkAsufeSZYV9KFnrDHTGQ6ySdTU00yCkURvb5Ggx5+ognPf6XyRZTOw/j8/iy5uc2Xdc0bKD5CZ3HRzfQYbWI2PmftnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvxy2cpjBdCHmwadjeZHuOh+rJDfVSUVE+9ROhgYics=;
 b=E9DnZjfMOjNIEBokLgx7wzqNHebyZx2BOC4kB+7PwiMAEUtAgkRBmPnHFX4Htb3PRvWanWew95XcPyehl5/zxTMjXdE9G+gXhMBiX4lDJzIY17U7lXooCwA5WFZkSMfKtsdf+k/SIRKvBDYASiLjs68DmGBif+3i/zzmTs0x7VdM03CwHITNFfscvPGlIb4tUrPQKxyZhqrNHpcAPW1kmdh72QpfmP/7Qi6M3+WN80HVN2rh3FZRI++mjpwKgPK4mjD+xLRBLGdqeLq2KT15qgYeWAmhQ77CbkW/UXe0h5m/LP/60DfYHr5Jul2TBLgCjSclVYVk3J28Y26iGaiVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvxy2cpjBdCHmwadjeZHuOh+rJDfVSUVE+9ROhgYics=;
 b=AFXekdGOSwSZl/BibFeI8B9BmhxQpD9VoZlhEq9+bzk3wndmytdVd5pxEAkEcqWDlHlwfYfWL25HSWZhVD5ijQgewTXCXTgvhsRLe/NwF9GXAhgeoa2R5INyZkT4pPOwxckTPjb4m85vrxrNo8MF/yTL1pFbwzMxvaQSOCcYmyswlgLKo6EC6JegkaUzsLo0K52d8ejBL3rIU8UmcEufyicMb49sjaZmdhuupg5IHui3bXUnbNTDc92I0BFnDVXpRKanQPwODxeA/AA/zCpVnp483v48h8BA4NxUtqF5E70rGIE0B/UhaU++HNJDT7GDv/FGH8itJbtU0hw02/XhSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 07:34:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:34:16 +0000
Message-ID: <08d29887-2566-47a8-a454-30cdc575c391@siemens.com>
Date: Wed, 9 Jul 2025 09:34:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, July 8, 2025, UTC 7:30 AM
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <61cf30b0-30af-4ff7-8c3a-4ba62624d74a@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <61cf30b0-30af-4ff7-8c3a-4ba62624d74a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 6979e418-ae01-480c-97b4-08ddbebb021d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d25KVyt2Zy8zM0sxcTZPZnFnbVVJcVZ5cTU0bHhGWGpsT0ZPQjBFNTQ1eEQ4?=
 =?utf-8?B?ZG1yVEFuRTdVZDhNbkZQQkJ2R3loQ3E4Z0d0dnRnajUvd0l4VVYrc0V0R1pJ?=
 =?utf-8?B?YkF3aUZjYTVmdVpnYkJmTk82dERObWhEQis0Y3lmY3pMSm41RGEzWVRZRndN?=
 =?utf-8?B?OXR1RGovQmxWVFQrSVY4dFFCTEJ3eWZjTWlRSnBGb0dmeDNPZGxFZ013RytI?=
 =?utf-8?B?YUphdTZXZE8vTVJMTWZNTEVGTVFwZ0JJMnJzVkFhSWl5ZDY5RHo3Z3B0Z3JS?=
 =?utf-8?B?aGNxd0ZocTl5SHNRZjVTV0xOUnpBMFVZTkxmb3BWK1FPemNVV1hrWDVYU2t0?=
 =?utf-8?B?ZGlUdzRPL1p1a1Z3MmN5aHppZVY1MXJJU1dlNGR2RXJPY2FaT0M2UThDTExU?=
 =?utf-8?B?RUN0OVFnMS9qL2lNTjJlSkRUYUJrQzNnVXhkSGNDRWdNRDRDM1hnRG5YbXor?=
 =?utf-8?B?aGg3Zi9PQ3dRMUpBdi94ZDFqVnducEhJelRqVlZXaGczL1dzQVhqdVhxTFRL?=
 =?utf-8?B?RlVFTkI5RnR0MGMrZmVXaGdVZW1wV3dxZUwvRUIwS3haWVZua042dXNCNnVs?=
 =?utf-8?B?ZThzand3WkhqZktoMDJ4VWxzVUowM09lcWRIVWZPbFNVemkzKzVJN045TzVC?=
 =?utf-8?B?QVhKTXpNVzg2SERXRnk2MDBTRU1CS3dwelVFamcvSDVQSXV5bytoZjJsaXIv?=
 =?utf-8?B?VUN3NjhPK0pVbU5LYWxJdExRWXpQTElCSVNWcUdsL2dXNEc5bG1DNGNuL2dm?=
 =?utf-8?B?K3phbHBoVzI1c0dvUTBqMnBNeTNlMGR5SzA2Wk12RkpBRHVGc0VtaWhXSEpx?=
 =?utf-8?B?dVY4QWM5NlNxaHFIOTBNQ25GT0tSeVh5WHo4bmFDODFkNVRzNWsvbDVGZjJw?=
 =?utf-8?B?ZkE5Zkpxd0ViZ0tjYlVYaUtJQ256czhCUnRzYVFacm8zcDh2bHhGSGhyRE95?=
 =?utf-8?B?RGF3M2RvdENVSEhLazd3VzgyT3UxQXl2a25PT3R2UGFMNlZZNDlDcFpaOVFt?=
 =?utf-8?B?RnhSazBGQnFMQzdUdE1PVllkTEdTdnFncStDT3hsRERDM2M4cFhjcmxhNERq?=
 =?utf-8?B?Y1JvNXFYMGFCdEdqM1d3YTZQU0hSaXpwMkRWUUVUNHIrYUVtZTJ2Vit6OE9M?=
 =?utf-8?B?Qm9nSDJuRFFBUU1vN3B3Sm4wRkpFRmRNZHo1RzZjYXpZY2Y1d2VTOCs3RkJ3?=
 =?utf-8?B?eml0T1lFOWVMRSsyWGMwdGliWDZFQzNUZ2I4RndOa3krV04veXNTZjJiUXU2?=
 =?utf-8?B?aVBZZ2R6Q1JrYm0xSFl6V0xYdkxqVWVPTHVYeGxoZENnMFcrRDFETTMxOW9C?=
 =?utf-8?B?NzYxaDZidDRtZW5VUWg2SXFFdjlBdG5nbzhTNXlSYTFrczVRSXIzRjVaNXpF?=
 =?utf-8?B?aHFkVmY0REwyNWF6SCtmaG1WZXpWOXdkZzJXNDZDYllKVUZITUM1K2VUSS9j?=
 =?utf-8?B?SzFPRFYwczJZWG54STN2eTdzUlFBT2gwVXhVRCtvbSttRzIzb3Q5bzhkVTZ5?=
 =?utf-8?B?SlArNjV5aHZQWHlReG95WU0zVTFpTlE2WUp4ZTg2UWQ2MDVoQkF1SlJyczkw?=
 =?utf-8?B?cFNhaGJFZ2Z5dTIyVE9hTXRjUVp2dkdVc0lnanRKTHdYYlg4SmQzSWhwVzcr?=
 =?utf-8?B?TDZ0UXZMWENoUVV1YnM0SHJ4NzdWWDh4ZHZVc1cyVG1LZndZWnZxZDhqbS9F?=
 =?utf-8?B?MGtJOGpmSEFQYk1UcVpiRk92ZTY0RnlKbWluaFZ5aHhaeWlPNWhPSHlMeTI3?=
 =?utf-8?B?WUx5T0dEbjZlTTd0RGJxUGJUM1hBUXg3V3lWVldKaHFPNkprMUd4bHJSK0Zj?=
 =?utf-8?B?N3ljdXFMQlpDZ1VzRHR4UnBKVUplOU5NQUpVcHhmeUhkUEkzVVBycWgzNy9Y?=
 =?utf-8?B?NjI1SExvaDhBZjI5UXNZQ2R5SVR3djZuZ2xoMGQxVWxoTmNqNjJWaXdHa1hH?=
 =?utf-8?Q?IZ9fkZQS35A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHc4V3FTNFRkdWdpQklrdmk3TTdPTHpqeUYwTXNaRTIvUGZaVGp2cGF5Vzdj?=
 =?utf-8?B?QUovcHBqVlB3cVlyWlhvYmdsd1BwKzJ3aEtidFk2YitpU21MVUZwMFgreU5G?=
 =?utf-8?B?emJHeGFEQ0FmRmo3SytNUm0xTmtwQ1FuUU1PdlM1SVMzMEphUHpRWFRlSVl5?=
 =?utf-8?B?c3U1eVBjNFJzMTNYZm5mK05xUldXajV1OWZuTG8yRWI0TjI2TXdVa3ZzUG1n?=
 =?utf-8?B?QzU4QmFVMTcxclN0ZU9IM3lRcmxpTkQ2aE1SbWlGeXFpVGpZMG5kYjVyMThW?=
 =?utf-8?B?VzZudnJVTHZRNnExR0hYcXFXUmhJSzQyQ2kzYjRvdElHc0pjTFFHa0NKdUpE?=
 =?utf-8?B?M05oYklxOGc5ZURJWWx6NVp5R0lSRVozNUFiTGNRM2V3VlVKbVpEOVp2dHZT?=
 =?utf-8?B?MHp2YTJZSmdBV2NDbkhybTl6dkk0WTJWSzFVc1dVcDJabTEwZ3FwNDFiZUk5?=
 =?utf-8?B?Y21OVzdaRmtwVGpuR3ZnbW9HK1dJZEFDZG9PNXdEYTlmNVlDeElET0pLbHk1?=
 =?utf-8?B?M1pUMU9iMGtIWlBhU1dhMEtCd1NsTlpzV20yWXJyQ1doLzVHR0xDL0c5bmVJ?=
 =?utf-8?B?SnNhZXUwcGQ4dXh1czBBNVhhSXpjeVBqT1Nsblhpa1A0dXBrNWxieGJkNE1E?=
 =?utf-8?B?QlArY1V5d1dmOXVPTU1BOHhOM0VyYkpLNEZLbWM0S2RaREV0YmVGenBEdTJq?=
 =?utf-8?B?bFFIRXFHMDJPQ3hyZHRES084ZXNNSmEvKzFvdHJyRzhaenJIUXRMaXhJYldz?=
 =?utf-8?B?Q08xUWtPeWdJUFNRZUpMZ0RqK0FUOVJIWW9mNW5lcWhaYmtMT3JNanZyNjFO?=
 =?utf-8?B?WWdzQXduWGhTV3N1bzZhYkJKNEo4eXM5UzAyV0hXS2VaRTM5RHNiYkZ3cTlx?=
 =?utf-8?B?Z01ORVkyb1FFZ1QyV3BSaTFyV2x0Y1pEL2NKVkE5UllOd01OaytlUzkxeFNU?=
 =?utf-8?B?RHROczZDTU14SzQ0dHU3dFhQcWVYVzloQ05iZWRRS0RtOWUwbmFNeHg0WW94?=
 =?utf-8?B?eGQ3RTZVODNEczdQdmFqNUE2UFlOb0lWSjZ3RFlvdVBSSGgwQTdVV1pxWnRs?=
 =?utf-8?B?ZTZJZ3ZzWDMzcWpmR1B0cDdPUTJyMjRVbVd4eTY1YzEvMXlIaHo1YW96VmNJ?=
 =?utf-8?B?MGk4L2J4K09TZ1YvZkZwNWZReERSSGliVXo0bytRdTlCNVZkVGloRStyZWo1?=
 =?utf-8?B?cG5SMGVmZ2x1bEFWZU1IMlphZDFXTk84T1FLYWxYVjhYQWszVEhZRUMrbjBa?=
 =?utf-8?B?NkRsUjg1YzIxUWF4VEpScUk4NFRrdGpWSnlGelhZTTZjeTVYUVJ2Y2hERDRv?=
 =?utf-8?B?OFZ2OGxuVkNpZXI4NjJhRFJyWUtLbUdLVjM5d3ZmUXhvNEdUSE5WMTlWWW1E?=
 =?utf-8?B?LzNVb3FqWE85MkhjcjRwTWJONFhQWDIxeEF1TmRONnRpZWhiMjFqeW9RNllk?=
 =?utf-8?B?SWZ6bTlPV1JYWVFaSzBOWHk3cVFocTBFTnN0dW9GUWxpR3RsLzZEYXJqd2l0?=
 =?utf-8?B?RDl0MXQ2c3d2MTlUSHJXU1I3b0pram82SFhwZGk2aFBzV2FYbXhSL1NMdlVI?=
 =?utf-8?B?dGpKMFZZNGxJZ3dIU2hrVkNzRnhuTm1VVzcremFlMmN6a2gvdnptNWxQYnlU?=
 =?utf-8?B?RThuMkhXdU9pbkcwcnVtVUNGdG0vNUIyenFRS3A0VjdvQWROVzc5ZjhMMUR1?=
 =?utf-8?B?a2NyZkRXRVJjdldvMU5mUjUwczJ6KzFSNUJ6R1k4N2VMamFHYy9TL2VRa0gy?=
 =?utf-8?B?bnJVMVl6VVZDV2loVVJ3Z1dlckRZU0JHaHVORXduQkJMdCtSLzNneGxVSCtS?=
 =?utf-8?B?dTVlTmhMcjJWQnBaMlRwMURFZzdLTnlGN1M2T3VhYlpLREZ1TDRJVG4wUmhP?=
 =?utf-8?B?aURXUDF3QTFLYnJPOEtSS25PTURWQytvMVVIOGxjT3drRVdvaDR5SUNGc0Jl?=
 =?utf-8?B?TTM2blRwRUJ3N1F5UEdtOVhRMDJDdVo1aXB5WFcyUUY1YU9LNTVJUlRuaGN1?=
 =?utf-8?B?OFR5RUxmWXFLZDg1Vm1WdkNYVEp2eDVmN2lLK1Vmb0NuZ29uemFvZFdVUmt6?=
 =?utf-8?B?aWtQdjB2a0JzUXRFbmc0NS9tYlFXTFR4bnk0MFN1QlhOT2plVDhPLzNHK1dm?=
 =?utf-8?B?TEY0ckR3SlpRcTQwdW0zNGNsUlV0MUJ5RjZodWM3TXdqR0NkSWF4QWRIa3NZ?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6979e418-ae01-480c-97b4-08ddbebb021d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:34:16.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgUbaOykQDiezVz62qhm8njk4tT2yQRWAIAdNXtK8adYF+0o5j+DGm0G09R5e6ys1hRWVIpFQUfWM6Tqw8BCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8744

On 08.07.25 20:45, Jan Kiszka wrote:
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions (you may have to wait for 
> the organizer to let you in).
> 
> Time:
> Wednesday, July 8, 2025, UTC 7:30 AM

July 9 - means NOW :). Sorry for the confusion.

Jan

> Paris, France CEST 9:30 AM
> China CST 3:30 PM
> 
> Join Teams Meeting:
> https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d
> 
> Jan
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
