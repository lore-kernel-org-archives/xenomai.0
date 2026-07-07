Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DB27FD43
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443677; cv=fail; b=nmgP/Hn0ga14E1PqO/rL1AItKJC+RKNlsPWlNtilQnhIBWQDbnYuNFmjyu8IrC9q+rQTwx4hgw8iA/T2jsjFP2rO39YRNcGU6WH10SPDSBq+oo+ZUUeV2R29h9b9Y06/j37Hs2q/FrOhfY4PeHkKUobmAD04kitrehv+rlKmfzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443677; c=relaxed/simple;
	bh=sTQTZalyD8KC3W2eOblTK1Gr3gvEyj7T3tp1VoFQJnc=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=pAE94aYL2YiNRlxA56kbz2QMOZoL18H6BK2D9xCG3FSPGAvRm4fX4CNKE/VPHgBIxPfteNyM0TbjNZ0bip1WiXJru6VbY9PB4BgmUec+L6oSuKk/A4cvb6PeeCnHxolaj+KU9k63sI331RtKdZIZHBcewSOsoz1Ua6AGQCki6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IUQGsxMS; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IUQGsxMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWOrrRYCF5cZKOnZzUui2l/Vbk55TBmxUgIxnrJT3EKvPtGPz33U7N8vT80+GcGrqfSwnlUsL32kIEa13DD+p0xzJaWiVAwgRQ0DO0QgmZMMPn89NaVinwWeRMRVCCXVuDnxqdHUDL74F/ftVZGst82Hk2QVeB0qKsGsxR35hT8F0syXiGNnV3r8DPJEjE9bf2KtE67S2U9u9xO2719XPB2PLaxCdaKRghdG96FMCCyRXVw9oIioFAkiP19MkDdEFNPyEACZmcf0QvN1cHIXsVvSsTltnrueXBB8KgBKdkN0YPpArIZDHpvvAEf4BUjg2oEiDHKjDLz3wr5O+Clztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTQTZalyD8KC3W2eOblTK1Gr3gvEyj7T3tp1VoFQJnc=;
 b=WaxOU6vosJiSLjkmI6sBqEu0GyX0bMyxASV7T917Yx97cHy1EvnIcqnrUeHTdhy5FH7Jce1INHgJLBC+3eluuMzrGuoORFLu1MuEpDgmgswn5CqzvqqlWmCJD9p3grp8bFhz24QC+itB07pZrb7Sid/0mmdRF90+g7Qdwsh7W67g+Cjmf026U7FccUxV2nMjejJLnOgEW94LHKHE89WbhMeFmzE4wDnLPog3m5JS8BDNPdv+n1kKMsmZA5GlUWXZv4SgIkIDTpRIARoPDvO1zXAJ3ecChvfcfXHM7IFLY6Bg2h5/GXf+8Zs+KqZqR3498YBOTIL++hRmxubKi9JpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTQTZalyD8KC3W2eOblTK1Gr3gvEyj7T3tp1VoFQJnc=;
 b=IUQGsxMSzzD7IP1eKMx+HHMMVK9WzZg5yVTfhmBjg03LbQZoBJXtWDDpN8/enCPkooz0nX76XJcFb26KSxCtAk/U6nuwkCQsXnxsfd+turybkjNvOUpyj7vxYzwthl2gqwZJSTRW8ebJ2SJhDsjAyUyh5tno3y7h06J49iPwDSvP3ciXCwMqmtFVCIL9P5LcENTj1+00AFKQOYzZSayU0sbL9LLjVM473AirAwLnndFdVJnBtuu/GZ47dJlNo0ikkd33DGDVtOveUy2xtSDTFFv9MRVSrifcQSCl3X8gJF5NL8s0NFRQUO0J6AjnbvLF86lcOoxczDAA7ZQeHFR+GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 17:01:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 17:01:11 +0000
Message-ID: <a52d8f7f-91f4-495d-8981-7179717e1bec@siemens.com>
Date: Tue, 7 Jul 2026 19:01:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, July 8, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4dac4f-40e6-4b22-6ffb-08dedc4958b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|55112099003|11063799006|4133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	389bT/plytAc1OxSjoDX3TOy/gmCBdNeV4XFKQijmBgcgRKO0mIjbXtpGJ2HrLHknrid+OHitytTKb88SWOJFvlbjFA+mU3VAhA999pkqkMB18/3JD1+PT2OyPLr3ghQlG49cdmeliJvtUbI0cdjm7HGCaSG+8fakJBA6r8ClCfiZklv6tXBqll6yamPTO5P5BBTcXApbiDTz52UKxSydtnLoms1LGdRZEL+7x4Pdguars8P2Fx8RJ4crXyvDWbBa3d6e1NmF36kr8YbvBA+jzxy/WhjwTZNrDa4nixCM2EPhUO4ecGK2lVufVQ0RnwCO8SeCCJfAMHuXTCDR4F/7Z8flIIACVIO8HZ8ir4ON8dVU9MU4M++cD7tQzkbpjc6fZvW8R0czsOhFYJ+M/HDMG5GA/4P6GrXZs3TFzKJvhrqS7WJu5UqoBDGR9y/NXa2xHPnWUrgV+1t1ZGJuYSiV6C7aVUpONoDRBRWS04eyJ+renje3gDdQibl2D+Sj3C44DmdX1lWsIoJ3dQCQkNNHwbk4Jw0OVT374JG11mkkhmlt9VyonGPgpijVmE1pJFzMkktQi3aHwocmz7L0rYxH+WvJLIC21DweOLGDC560kKzoiIblzSSm+Kg2d/PH0yRLtsDnLodH3dRcp17X4SKi2eSn4EBqnAm+AVT5SbHHmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(55112099003)(11063799006)(4133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0U0Rnk3ZVI5bk9EMzJ6ZUE1RjBVTUUwbjRvRlJyM2hqcERuWG9TVkYzMjhL?=
 =?utf-8?B?SVBSajdRMUsvRS9ZOEZqRjV5VFBQWXg0K3FYUWgxbVc3ZjRBc2NxNHpWTDZ3?=
 =?utf-8?B?TldDbkduUmE4N1NpOVIwM3M5UmVSN3grRWloN2l1eXpGdmdIL1RnR0pRM2xM?=
 =?utf-8?B?VUE4NVA5OVd3Y01KMTJ2QU1rUnFkaUdSeUZRaUxVOXU4V0RaRGczTUVrL25J?=
 =?utf-8?B?TnBucXFEek1ac1liclZxWU5lUUFsWUNQenhzMDd6Mm40TlJWUWlmVjNiUkg5?=
 =?utf-8?B?K3pRT2R1SlNyVnFBTDQ4d2NCN3pFSG8vSVhWb1RhY1N4c2JaREN3dmI2MXpr?=
 =?utf-8?B?SnEyQ0Z4Z1N0VUlURFhaMWR4d21mREFNaUpIbUhwQzRVajlXZ05BV0ExMjFn?=
 =?utf-8?B?QUF2N1I0RnFyaExpdUhZTG4xem9NU0ZEdC9oQ1pKZHMwbmkzT3dPbFBGdERF?=
 =?utf-8?B?UUV5YnhudlhmODNlQ3NFWTFwcy9VeGdMOGhiUk9ZNFMrMFhmSTBoN0JBL0kw?=
 =?utf-8?B?bUhZWk9hbFpJRjRSN25yaWV4c1JsUWltUDBRYUExcXNhNDNuaC9WRVJCTFV2?=
 =?utf-8?B?R1V1Z3B5aVdSZS9abjFJU0ZmTHJmWkQ0S0ZHaUNldmFBVTZOWktvVG5Dak1N?=
 =?utf-8?B?U0h3ZDlCZFFPSW9BSHZLOGUvZ3BoZElrMi9DOFB4NVdIeXV5WUhsbFQ3WitQ?=
 =?utf-8?B?YlhMOW1SYzhZbFA0aG9QNXBELzMvR2Q3RzFYN0VveEQzaDkxbnZ0UGg3NFp3?=
 =?utf-8?B?N3dUaDFIUDM1ekZUdFA3N0VrL1NFM1NxSERqVXVKVTgyempuWHZ5YlFLbXl0?=
 =?utf-8?B?NjVobEY4MldxdlBTTERWSnJmUFJTS0RxRVhZMG0rTGQ0NUY5U3dMekRvdmpV?=
 =?utf-8?B?NUY3TXhLWTJORzZFV1dPN3U0ZlAwSkZ2TkdFMU9ZZ2JSZnEwNmVJRWJ6dzVx?=
 =?utf-8?B?OHdTbjJIRTl2RG9PdHFIQkMxcVVrRTJrL1prd2VnL1BHQmRTNjVRbGg4akZI?=
 =?utf-8?B?dTlaZTVOMkw2eURaTnMzMXJFN1Z4SnBXMHlDbnBxNTJoY2h4bU1vb1Q4QldZ?=
 =?utf-8?B?R3l3OGlEVHJXMVZlUWFGdW1rSHUvc2pJQWN5bStYeUs2TVFoZzNGcVpGR1hY?=
 =?utf-8?B?V3B4ZDFIUDM5TlZaeXpLMks2RHhYQ2E4SEpTZWNacHpPSndWQzZ2TE9vbm92?=
 =?utf-8?B?N1JxZ3o2ajNNeU5VN3kveWdsaWFCUlVZSTBFN0V3RmgwWUhOUjlkVVhSMjhG?=
 =?utf-8?B?Q24yT3BHMUxrUUwxYktZd1QvQ2g0SkpyblM3eUY0Qmd0dTVGeFVlR3hnTHMz?=
 =?utf-8?B?d3B0M3o1WlFVcnV2MkZXRW1NTVlFc3hBU3pmNjk1SUNyVDlZZ3VpQXNpT0xM?=
 =?utf-8?B?SlhpUEowcStDbDF1bzFrRjdJYTVuc1IyS096MXhNR0I0Z1VUR01ZcnBqZG1J?=
 =?utf-8?B?TzY5c1FwNkhjVTVFV0JTdUEra05KWkpsNDJmUnNmV3ZvczQ5NFJWYVN2QVQz?=
 =?utf-8?B?RGZCSjRQS3Nmdm4xK0lHeVdIcWdaM2VDVHVlb2E3TGpDcm01ZWNTb0E0dFdK?=
 =?utf-8?B?UUhwUHhSWTJ1ajZXOCtGb0U3dTlTMGhmYWYwNDFSTVJlU0xyVUpjT1ZZeW5R?=
 =?utf-8?B?aE9zVGxqNFlwN3dxWGl3WW9QZUQvaEdpZ1E3Q21WeGdQSnBTN2ZQM3lvMCtr?=
 =?utf-8?B?aDFINS8wN0NTQWx5Nk1WeXk3R0xMVnhSNGx0SDNFSE1NTmxJUm00UnZqenpP?=
 =?utf-8?B?NDRmZlNjMTE0QXE1cGxTVGl1VnQwd2JxSEtXK3dBY1VuZkVISkFqRHBFVUZi?=
 =?utf-8?B?YXhIVUh0emVXeTlya3J1T3JRRkxvelZSZUQ3dDhVeW5rQ1o0N0RuN3Y5MkRz?=
 =?utf-8?B?RVVKTEdQdmdMRW1yWWg4K01PYklyNEI0RFJvWHhmRldPQ1BaUUxSazY5ZTJM?=
 =?utf-8?B?VTVubkdVTldHMmc1Qng5ekpwWGxVZDFheExjSitKR05ONDdvUTdCMTJyMUdY?=
 =?utf-8?B?MlNtS2JqZU55WHNPNkt2R1l4b3FHUmN3bThlUnBTNlJ1N01EdnN2TldnRzZI?=
 =?utf-8?B?c3Y1ODdZcE9PZ25FRThyeGxUeDZKTE9HWm5PTjhzZ2JaeWx1WjZCam1mNlhi?=
 =?utf-8?B?cHF1TGZucTArQTBYZ2FqZXAyTVV0OFlKNEtQRStIZzJMKzBUNmU0ZFZmbGVx?=
 =?utf-8?B?MXJVZDhCd040NzJhYnl3eXRTNTFGbUY4N0FlYUowcVd4WUNNN0RwdWZCWFNQ?=
 =?utf-8?B?dHpNOHc2MlIvQjhzZTgyRVY1ejQrcFFSWUNPd3A2a2c5aUxSVVhRMlRna2Zq?=
 =?utf-8?B?SHozTXF3RWErcTdKNzdtMUIrME9SNnZvSlVaa0ZhTVBKREdncFRQTytWVWtQ?=
 =?utf-8?Q?9RlLEm538M/r68/8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4dac4f-40e6-4b22-6ffb-08dedc4958b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:01:11.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRH5IqAPiK2x72dzGHnUWN3XeOlmv4iBF4oUi0VDS89Suawhz67drvtkhvN3VyQv9hTwpIAAz6tEx2yYwKdhdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8434

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, July 8, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
