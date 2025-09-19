Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF22874FF
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262711; cv=fail; b=g3h+XgnB9uzmvR+qFtjTmjfcv43TjWTvy257wAy1xbUNipO+vjXD3+7uN7R8s/3fugsDd9bqoFmDl9n/g/I/oTWlSZfPm5h25egAIODNWxk6GFacpSqkf7o64M6UW6uUgvfdVnspbsLR5/XYntiFRh5rhTmrJ14Hb6ZOiYZYJ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262711; c=relaxed/simple;
	bh=8De9QpHRXHlLiGUOiv5ubT0Ym1SMwjRekKMOwGu6jpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WeXW20/iYRCim2kOoaGJTVRAfMJzatbY0OPBVAP7WCl6uuimFp7pb3+O84RqaopC2B4NiEn9QnRvZVueA52pBd0+A3Z08JYPsaAmYXEuwpg4NKrhml9dSv2JskUOA3xj5vMmQqDgibTWVikU1h2DPpslsMYeGOWjhyVtYq+r2pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=adfUJm5E; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="adfUJm5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paTmEOdZ+bpQ1ZcsuKmydD12ey4bJhvxjI2Jl4eik7sdfqMXHh5ip1hfz4UkRSA3f+zi/YuXIvEb+85WJnrcdWoqs6wPpQELq63LBNyw9+p/acCEgoOnQoW0wuvBf+x7FNJGWEXHxUK7dcwsxVfqfprkf1qomWUs3DgFiNUJhCpqwukbWimtxOf/87GsN6Q+q6t/POJ0+Uy54M4iFSBEo4lpFhDyTvVC/eJGE4D78H3m6VhZGGsSpxHC6+M1VmfFHLUpOXAeVfVX0JTJ68wlIrFbvDGwEvHprAhZs9v9tM0ddPEREv0VoKRsiakkIgb9YWdDZ21QlmxbZWLQwghVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUP5YeX0d0yOXb4ssYk8EGrqHHecow8b93bv74NV290=;
 b=nqac9uiOAGncCHHmZCK0D9WQkA7/p9Asz3ETNK4+l02kbHXSTmcKa9wqFXV5bF30o+x++9GkF8Y02RaF07RNRDxGew/Rzet64wPVVw2Upk8uXxWKsic/CyUqMRQ9LiwKgKrL05GqxyAC1spVGT0PtZ1KVRDMOi+gcTLIFF60unHYRQ0nUPHgS4LgBbqShevMfOQmmt9sfJW5l7rIkSVn8uN8iQhqbqdx/5tXwpucRy/i78prbTn8ELlekquXoLe8IQf5FY3r+0XYSI4FiU95pIgfY9pvuc/J7r+l36DeEmySlPbWVA0EUbdUenajCB/S5sqY7+6WQrmRnDqlcd0g1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUP5YeX0d0yOXb4ssYk8EGrqHHecow8b93bv74NV290=;
 b=adfUJm5EQGCM7UqQ6uX+1rBeFWkyKAP5d4i3squmoOsZzob4BY9zBm+iyAfqO289w7TQ1I28pzCs+AuzuJu2K3s54qvMaHj0hv6iBqCjSn29OKmHNl4BMxoQTKmwmpeDHGNH2WhTUaR6ObFnDdfjxEiOeRxd1QSvsTYlg8wTT8I+93GwIBBv81SIMRz33pvtPC3YxbDcGs5D88TW2eoKUdeF+7l1NdR0CPcbaxDJ5G0YL+pupm+8Bsh4iy1DNWsHHRKkx+B9b2kvi84FeoLjPw0jyr98+rwzqHmu3BEySXpHhIEIYGBTRLk9RoZgqmyecvGILoDWbMbZ2+PJJvgTAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by GVXPR10MB5910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:18:25 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:18:24 +0000
Message-ID: <08e34367-c342-48a9-91f2-09e00779d870@siemens.com>
Date: Fri, 19 Sep 2025 08:18:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Error during libevl build and runtime settings failed
To: "Xie, Nick" <nick.xie@festo.com>, Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <878qk3za1e.fsf@xenomai.org>
 <AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <878qimxczv.fsf@xenomai.org>
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <87plbuz9ib.fsf@xenomai.org>
 <AS8PR03MB100560006594FE9480F592EB98B16A@AS8PR03MB10056.eurprd03.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AS8PR03MB100560006594FE9480F592EB98B16A@AS8PR03MB10056.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|GVXPR10MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: e292d7ad-0cbb-41c9-51ba-08ddf7445700
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG40TjZHSmo0T0xIbHgvWXgyWUcrSWE1OU9ibVVWZUExWVR3S2RvTlRDREVy?=
 =?utf-8?B?ZGJTcEJYT2pCUXBuNHBMUEJnN3U0RkhBY1Y3c1JTSG45K2ZRdktsT1pLb1B3?=
 =?utf-8?B?akU1U0tlbWxMYTYyYWJQcUNuOEs4TDZGZ1dFRCsySUJzWVd1VHI2dm1hTE9r?=
 =?utf-8?B?UHhxUUdrcFJpZyt4dWdVTUpjN29QSXVCVGZHY3gvT29tQWJTR2xrdjZ5Vjlj?=
 =?utf-8?B?S3psbTgvcThzSHdyY2tyM3RtdmtKSHRqcC9HVWF5VFVqdUorR25YdkRia1Qz?=
 =?utf-8?B?WFpiTi83VDZqY3ZZSSt6VmpCTGJRN2kxNUZBaGpuYVNsY1hDZnc4T1JXbzJi?=
 =?utf-8?B?OXBLejlhdXo0RUpOOGFzUWxDRjNha2pncGpNSzhJcDJGZUp2NHo1WklZT0U3?=
 =?utf-8?B?ZUczSVVZOWY1RWkwMHRyUERnRkVQaE54eGs2Q1RaODRzaG1CaWlzTXFiQlpJ?=
 =?utf-8?B?NkpuaEJxcXdLRzF0bGpmYzlzWkdwK1N6VHpzc2UvQU0ybllmdGxOa3RVVEFa?=
 =?utf-8?B?RkcyTEo2RXYvTU52RFQvSWV6LzVEZURmdzY0enlTN3VHcjRmVWNQNVFnN29J?=
 =?utf-8?B?NnFwa2tOeDdOeWtKdkcrNVRqaXRzdzMzQzVWUE5ab2pCWStGWlYzYTZDQU1s?=
 =?utf-8?B?ZEF5UTdJWlVUWWlRdjltREFRbmhzUTk3dDEwSWVMOFJWUUVnN1dnTy9NS240?=
 =?utf-8?B?Nlp1TWRXYkJqbWNrbHhtbWhKeW15c0tUaENJYURJQmVNdXVIRTM2OXU1amd6?=
 =?utf-8?B?MzN3TnNJcGgxaGVwQ3BRVkdwR3c2YVZjaURmb05LeklTVm5tR2pRKzV6bFBG?=
 =?utf-8?B?bFUxKzM3Sms5cU8rRWhGQzFuM0xDZU9XekN1WnY5WlZwbCtER1QreDhBQlF4?=
 =?utf-8?B?SHJ4ZE9TbHptVG1ZVGk1NFR1WS9qNitkNzYrU2xQN3lvL2VKcnBpS3dmRmFX?=
 =?utf-8?B?SmRSRXZhYlB3S05SeEh6NGZIeEpIa3VEYWVCUGlFOGFBSGVUNUE5ZnpJY1p0?=
 =?utf-8?B?UnMwRUZuck1paVJDM2R3NDdoYndVS2hWQ095cUUzQnREeGFyRDExUmpmRlBZ?=
 =?utf-8?B?K3BhWFUwTk1waENFY0NUWjZ3MDRmeXd0bXNzWVpYRERTS1d4cGROUUoyZHly?=
 =?utf-8?B?Vm82YVJISnZXY2VTWStGWUJCMUZPZS9XQmNaTkxYYjQzMUdKakxtempZYlNs?=
 =?utf-8?B?OEQ2dUhhbGhQVEFDbzNBRHRKamZnWThyVUNjTVZwaHFKdkZxNElGcnp0N04z?=
 =?utf-8?B?MHFEemlHbjJFNjZnbndjOUU5dTRDNzMreXhsbHRodXlDVDZvMlR1b21XeXlC?=
 =?utf-8?B?WGJ6TW94bzdrcXcveVNKWjhpMmF0OVZaUDhwai9kSXljaEJhRDRjdUsrWUpT?=
 =?utf-8?B?MVptRi9BbHY3VllmM0dPSGlQdThudmpJT2c5ZW9IWngvbTh5OXEwWEtBd24z?=
 =?utf-8?B?RVQ4TFp4cEdnTGJVYmpObzhCUEVZRXc3R2hCbW5DSzdMaEVuTjRmYmlaekhh?=
 =?utf-8?B?M2haZE4xcEVieFFVa1JTQkh6VVk5WTF5UFlENE81d3AzRldKUDdTRWdQK1kz?=
 =?utf-8?B?eXltZkNjYWVPNVBtRGdMbWxjMXJXSm1qU2w0d0h1SGhDNnZ5UnpyZVoyZEYy?=
 =?utf-8?B?MWRLYVJITWhRbGxUT2JpOTFneE90QmxDNlFMSHFXME1oYzgzMTBqNjFEQklt?=
 =?utf-8?B?bld1ak9tMFdKWFBGUGVSK3p4THM2RXVPNHJ0Ym1SZSt4WTdXajRadW94N1pU?=
 =?utf-8?B?WTlreXY4RjNwa2NXejEzRjdNamt5bDlvTzNYaFlwcytZMXY2cTdQb3U5M3ZR?=
 =?utf-8?Q?IXByLZJQcf1aSJ+sLrfYYnGAsUooUTelHoWXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3JiM0dzSit4WTRnWHNSclBWb0FYNlpCSW42aE5KSU9GTmhmZG9PL0cremhv?=
 =?utf-8?B?bG1ZcGQwUXFBTk1OVnFaNHV6M0cvNG05R2N3U0NISnlEK1pvKzl3Vm0xNTFZ?=
 =?utf-8?B?cFJyMUNVY2FyRjJnTHVtY1pVWHE2RXNRSTRPdnNRdERiOE9RM3NPRDJEcHhU?=
 =?utf-8?B?c08xc3hJTlp5N3RHWkR3QzgxR2lYZThkWHBIMUgrYUk3VzNyZW1vVDkrM3FV?=
 =?utf-8?B?YkUrUnpyU2EzL1FsbkFIbTdQZmVrVk0yZ0d1N2VsR3EraTIzSjIxUzV3ZWc2?=
 =?utf-8?B?aG5oU0lxdDFabHBvWktOMWdoeFc2N29nYXFURHZGUlNMQVRvL1VmakExYkJh?=
 =?utf-8?B?UUpNVkQ1Q2gyOVdrZHNpVWFmaEJRM0JMRVRKVlhQcEc1ZE5KNWFWNWRXVktm?=
 =?utf-8?B?OUE2NVFRWFFzcWVTSWxJdmJqN2RUQ1JxTTZWa1J1Rjl4VW9PN0dKMktUUDlU?=
 =?utf-8?B?bCtsb1B4cWllblh6TG54dUM1TnZ2bVlxR0doeDE5RjFRKzA1ZTRuUFAvek0v?=
 =?utf-8?B?RzdMOUY1QlN2OUpvelpaOE1GaE1sN0JyQkRmeWtqWTR3OUtSMkhZRUdhT0hv?=
 =?utf-8?B?NUxCTnNMVENDZUxXTVMzMWh5RGtPMmtpZVVVVndsaDRFMCsyMXhKMGJFbEdU?=
 =?utf-8?B?Y0JQb0ZCYmwwbk4ya0d4ZjBCZ0s1ZHhGa2I3WnE5UVZNcy91ckttbjdFeGIv?=
 =?utf-8?B?cG5qeXJ1SVJUMS9GWjBUS2E0OU5pSXBDVjBLc3V6eTVKaEdXQlRLZDJnYnNJ?=
 =?utf-8?B?eGJWNlp1SjRseXd0c2FrcGhxUVdDaE01Q3lKU2ROVUphbjFrUFVraFp2WFlB?=
 =?utf-8?B?SVZjM0F6c1ZRR05SMjMzUUc2amllZm90am9tRkl0RkRicUJtOHVDVStLNnhm?=
 =?utf-8?B?cThxdDA4OWxkcVVzZjMzbENHdHN4UGVvcUhENHRFVWhteXpXVUQyWUUvVkUz?=
 =?utf-8?B?RkFRRGhBcFB6VUpVS1o4RGdsUEd2WDZSQXUrV3dsYlMyYkU3WTVMUVFJYkVk?=
 =?utf-8?B?N0NzNTJuc2FsS3NGZ0xjNUZjcnA3TmJnUEMxSm80TUFGZWhDbUNUeXJMc3B6?=
 =?utf-8?B?OS9UVGFJaVp3WWJKT1MxRUhFSms0Qm41OUhCeDFnQUduRm1zdlZDdjlZSHcv?=
 =?utf-8?B?ZFJROGhCRkJEejcwY2Y0d0h1bm1pYnNqeHNzVzZXcWNuZlJvNXQxNU9HWFJ4?=
 =?utf-8?B?WnZOSTMyZUJrZlhsck9kZUFGaThteE1ZbDR6Yyt1UHJPTERLWFFOYUoyYno5?=
 =?utf-8?B?ZjdwYWVxS1RpNGVPYzZKQnhaQW8vY29tTEtYdFZWRnRHazFxeWNiSGxBNWxY?=
 =?utf-8?B?LzhUK096a2JCZE5kV2tkZnJrZUQ4THdFbFFXWjBuNHN1aU1JSnB0M3dPWStr?=
 =?utf-8?B?a1JpaHUvM2dybWw5QjBlRzBSaFN3Y092c2NNNXBDeGFNMDNDa0ZBNUFab0FJ?=
 =?utf-8?B?RnZON1hwZGdNRmRObWREbklPVm9Ca3ZKYjdYZ3pTdURraDNScU14UlB3MzJz?=
 =?utf-8?B?V0RkRzBINlhyeTBEaVk1ZFFTWE9TQzRWRmVTV1lvZkZYT1QxQmhnRlhxdTJB?=
 =?utf-8?B?dmdvM2FnSXcvTVRIZTdOVlNkWC8xREVWdHlLZXNYbitDdXFpdVN5QTRqYjE4?=
 =?utf-8?B?WXFGVnJrbzZtUUNUN1QwTW03VzB6OTZHZ1h5dUFwTW5pQ1JQUW9YSUgrUkVz?=
 =?utf-8?B?eGt5S0hLbS9uWUU5WTJRbllmSUVoRWlHL3Vnb1F1UjFnRW9OYjY4blZFOSti?=
 =?utf-8?B?M1FvQ2VJUHNoWUNkVmJwVnNSK1gyMmY5QjFiM2hlN3l0R3JyM1lZc2NMYzg2?=
 =?utf-8?B?aDNSUXQxdjJnYlZ2Mlp3ZWNWVWRlYWZPRWNLWDRPckJ2VitsSEJENm5CVzR4?=
 =?utf-8?B?Z1VaaktJWGVhYWtnSWNjb0x6RmloSjlkTzhuSTdrbEpwQ0szbXhoVXdmTUFG?=
 =?utf-8?B?NDRPTXdsaDh1QWxzcDdnUFJtNmIyZFFCVTZpNC95TGxKSURSYmNBdk5KbXI1?=
 =?utf-8?B?THZ5TmxwbGNxWTZFMVcwb25aVWJJemh3VmNpR2pyMEtycGR6MTVhNEh1UGRN?=
 =?utf-8?B?YStwZWZMSFptZmN0a1pSSDEvTUwwcnNVMGRWSlBWRXA4am9zaUo5WHVuamFL?=
 =?utf-8?Q?pMIfW2Hfu2GtUDV+w1CwMp7q6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e292d7ad-0cbb-41c9-51ba-08ddf7445700
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:18:24.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9LiydxZjYC48wiG64aH34/dDeklRiIiNthgpHmofAJgsxkJGLXJYNkSQ8o8UCRAGdbxIhSkm9t0KrERj1/bYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5910

On 18.09.25 23:58, Xie, Nick wrote:
> Hi Philippe,
> 
> Thank you for your suggestion. After some investigation, my previous error is caused by I download evl as tar.gz(it is missing the hidden git folder), because my network was not stable. I used git clone to download this time on a virtualbox (it is easier to output the kernel console in serial)and find out the config file is the problem. 
> I was followed the link(https://kernelnewbies.org/KernelBuild) from xenomai.org. As it suggests using "make defconfig" which will generate new .config file, overwrite one I copy from the current kernel. I used "make olddefconfig" instead to fill in the config and it built successful on my linux PC and I can start the kernel and the evl test correctly. I will continue testing tomorrow. But there is a problem with another test on my virtual machine using virtualbox. I followed the same steps and the error was showed below during make. If I used "make defconfig", the make will be successful but there will be a problem on boot. Do you have any idea? Please advise. 
> 
>   CC      kernel/tsacct.o
>   CC      kernel/tracepoint.o
>   CC      kernel/latencytop.o
>   CC      kernel/irq_work.o
>   CC      kernel/dovetail.o
>   CC      kernel/static_call.o
>   CC      kernel/static_call_inline.o
>   CC      kernel/user-return-notifier.o
>   CC      kernel/padata.o
>   CC      kernel/jump_label.o
>   CC      kernel/context_tracking.o
>   CC      kernel/iomem.o
>   CC      kernel/rseq.o
>   CC      kernel/watch_queue.o
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     kernel/kheaders_data.tar.xz
>   AR      kernel/built-in.a
>   CC [M]  kernel/kheaders.o
> make[1]: *** [/home/nick2/linux-evl/Makefile:1949: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

You always need to look at the first sign of an error, not the last one.

FWIW, xenomai-images is capable of generating full images also with evl
(again - changes in next branch only), for qemu or real x86 hardware.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
