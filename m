Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0641A267
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766127037; cv=fail; b=XkjL1tb2cNsH0u3UNCjU6CfKJHecBDtp2Ctu9s6O3BwbjrjbT42Dn+z1LzlcT/eA1s9xEolI5aQEeOwC+sdXZpwUjD8JNtV4kVaf2v0gid9POBDtULsFkPhrKCv9SCH+Nsfveyi7t0pTinef/9Cms/ouQ1Y4X9RAVGhRKHg+aWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766127037; c=relaxed/simple;
	bh=wa62FCNqEyy0dfi5pDn86p1FL1jmk3Y+wP4XzDvq6vY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qE7y2SsO6UhKjkjwrNMk3vPVvGB/VPx5GYEfZ5Rt/BM7578DrNjoJr0v8RT+dHzcto9RyeDvYOril1GDkFWmB/BjuuLKgZ1bf2f1eiQ5J+VRds+1B4c6j7H1XcdhTDkxJadqnE6LTCEl4FyeYHBikhXUyVVMIO4QFz+q217B+Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=d5M4Nlel; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="d5M4Nlel"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF1P8HqGR0g4u2CGCOBWkgjTZGmCfvfuC+RrTggtvOJaOP5syJ8UmRTIpVsXarQFUKVer/UtenTMifoay9sXKV4LmzEx5NsMpP5R5oe4/4sgjfRL4CO96ls+UvljwctBftQOx7+yCDHSIlP2LOAgYZh/Kmjufb7kJx0qzfXKjFAGm6VhnPF0K7sv+MiFQbATjRkzrD1DNivNQqSclIggm/w9loNiKvi91N+7CRulVoOw39dplUT/sTQRst4jg83u4p0h5JmSF8kG54WfIJ756ERj9sKJYKpdiMZev4OD3xeL5WexW0lvelGLVDYCr43iNrBcVSP+H7nJO2+zZIOx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhxYO3Y2e3BCZb2H25tsitk+K0ZYKbAZh/oqg4ZpD0I=;
 b=w4F2oUmP/NlNLzaYY/fttWgwSRbDbLCtVw2xHvsFuYRQMmOGC7yHO3qa2fOD7xvTrAE+BHknCsPx7WhwvcX7k8cOjiT3Sx19yVMQKWm9RqsNhILNkzsXQP4FWDTPBGG2yNlB/vDIaR64zp4evYfRLl6mw+Y0po1pcPxVV56J9s9R8Yhq2NC4o5/9EBzgh0e9nlA1zmO+tTfIM6r7hJ/sAI0ubeJk26DbjTs5ioJ6O6wk/N12rVRTMNDCmE882rAB9KiWxozxRV9EhX23H4aU8xknjxEu4z8OoiH3j/6nfDrWnpvVXjvaO5Tf+EXVcMBY7gCfCzA5JmLFiHY7HFGjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhxYO3Y2e3BCZb2H25tsitk+K0ZYKbAZh/oqg4ZpD0I=;
 b=d5M4NlelZq8g0F5X38ADDsKn7Dn8U+1AGY6Gwg6Y9yqpjw9YTvV6wMg3iIoWYlpxwCD1XVySPMzujHsBCo6aWpPQMbUJrE4CchSIQOZtmz3IWsbnvR2HGvtOm+drcXzpaVEfsky+UBDh2wAzxZFOuQql6esdvVgJWAdSgeY7SLubeeVgfaCFHOc8jRD2t//0XMvCgpQAau0MT2K+6YlSDpAk+FX4I0Qe5LYMRblaVpPPzQsA402c+mpIJ3ExRxNuP2VpQySvXlcUXFdt6V04qrhrjZ8y/BEgm1zholMlMdrOKZPwiGOQsnZsvOL2H9+8WLNs25o3QKyl2gMsLxntWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 06:50:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 06:50:32 +0000
Message-ID: <badbf3d2-4ff7-4d72-ae3e-24898f84c015@siemens.com>
Date: Fri, 19 Dec 2025 07:50:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
 <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
 <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
 <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
 <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d8dd9ec4-1f98-48b5-b877-39a1de243081@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d82a4b-83f7-405e-223b-08de3ecae7ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWx4Q2lyYWg3dTkxZTNhWXZtZDBvazdLYmNudGkyQndrcjBjYjZwdENwcE5p?=
 =?utf-8?B?cjVxZlhSV0tyY1ZJZTNmOHRkZXFuMEJVZGtZaXFwM2NudzBHWDJ0WkZPcDd5?=
 =?utf-8?B?cldVa3BIZU5MV3cyZDNNUTZocVJObFRacFlwS3J4NU03RXlRamx3NHVCVkcy?=
 =?utf-8?B?T1dHZllCeEtXbVQ4b21xWE1VZ0c5Qkc5dFNUQVFaNWJYZEV6VVFsb1hMZldk?=
 =?utf-8?B?UUlsREZUdmROWjduYkFLeVVCMlZvWDJ4elNIRG5uL2N1S2ptc0orWFZGZGNl?=
 =?utf-8?B?QTlUclZtQnRETm12enl2TTFqNHh4Um9LaWtqMHovcGs4bjBmSWlQbzFya3RP?=
 =?utf-8?B?SXJBUkFudDVESFJiaGxqLzQxbGl0VUxRY1l6VWtSYk9yaFBCS2RrNGpCQ2hL?=
 =?utf-8?B?R29ORE1JbzR2ekZLeTNDTHIyMzhzaGJMYS9jQzZkWUZtcXRIZnFRMkJZbE1L?=
 =?utf-8?B?VFZDeDlwQ3QyeFUySG9RRUd5VkhKVjJrZkIyVkw2bjZkNVhUWHlkanpTM0Fj?=
 =?utf-8?B?WmdLVEZwZEo1Kzh3NUJTU2Fldkx0V1ZwekdUQkxwUzByYnhCVUtiM3U2VmlL?=
 =?utf-8?B?MityYm8rU0hES1JCNmdZdlFrU1B5LzBpTERPVCsrZWtudG91T1JpQmFqSnJj?=
 =?utf-8?B?cEI1RWVIczFkcjQvRTczVkh1RWF0V1VCSWJMZ1g3VU5HcU04M05QYitPNWNE?=
 =?utf-8?B?SytkNFVaV3NEUU9uaVBtT3ZRWDF0WXFwUWZvR1BZbjg2K3QyYTRnRStQTXM0?=
 =?utf-8?B?eGZwU1ZCcXJ2dkRQRGoyQjRGTVh5MmhLbURCMGFYdjJWR0dlUm1rTlArcHNP?=
 =?utf-8?B?TnU3bDQ5VTFuUDA4VzBIS2dPQUZNUFV3NkVBTnlJNU5NQkw1anM5Z0tKelVD?=
 =?utf-8?B?cFM0Y2w0VTdGdm1xSElIWVByanZibnBWSFd6cFkxZ3RGaGJERGtKSEVjTkJL?=
 =?utf-8?B?cytDdjlEd0Z4SnZubVUzc04xS29iUUdwVW9kM2FXQ3orUHl3L2Jqb3BCeGU4?=
 =?utf-8?B?M0ZiVXlndmgrQkRvSDg2a3V0cjV4QXVyM3oyRGxUdVJsSEJMWjJuYjFVN05U?=
 =?utf-8?B?TFhzTit0Y1JpTTI4a3B6dmxDRGoyNUhwZ2pmRU5naG14YXVoY2FOblUwbHUz?=
 =?utf-8?B?UEZsYWpWcjJJODNPVmlkTVNUeDgrWEFNRmo2cmNKRkJTdFhJcmd3elNQK1VR?=
 =?utf-8?B?ZVFRQlFaUTVjZ1ZOTmpVaDAvaHRqU1ZxL2ZOb0JRaDRrcVFtZWlvVzd2VkM0?=
 =?utf-8?B?WnV0a21qeHd4Mk4wZm9NM29WTE9uaWJTbXZjOHpuM0ZZeUNjak5RUC9JR054?=
 =?utf-8?B?VWdjSzdwZjlPTEQ1NnczWDFVS0Z3YklFVUJJaDBUalZJTEs2TFRvYmw0R2kx?=
 =?utf-8?B?dWFnMzhEKzE0T2hSZzFXNHNNVlZJMTJuTmdSVFF5V3hKam1FVjRmdWhiMGw0?=
 =?utf-8?B?b09CUFBJamtGd2tpTVg3aEFPNkZpWExVNzhVWnZhZ0pLeDFrWTRGNmkxcGZM?=
 =?utf-8?B?WHB4Slh5enBuQTAzYUpteWNtdlRGMVd5UFozKzd2VWxidlhCL2R1YzBGSEF6?=
 =?utf-8?B?U2JxNmRmcEFGeDVvbmgwVk5vTWRUTTA2RFd1RGlNaUpsU05OS1ZHZXFlR0gz?=
 =?utf-8?B?LzkyV2N0dHZKc3NzVjVTTVhGY2U3QjZBNEJSSG40ZThEam1XUmZNWGxKZzB4?=
 =?utf-8?B?b3hnM2xwKys0dit2OUZXM0M2bnlmM05aOFNjaXo5RGFyVUNCeXhnUHR0bzZX?=
 =?utf-8?B?Z1hMTVkxL0kyd0M1enRJaUlGRnBSNm9LdWJZcEtvbHppL2orRkk4NEVobjNX?=
 =?utf-8?B?YWo5eUl2ditHaFlpZThLS01HbWl2ektLQWZEZ1RLTHNnQmtTYzNIbEFRMUV4?=
 =?utf-8?B?WWptWlhsMTZYVng5L2JUYjBHSzFHUHYyWTlMUERSWC9PUElmUGdLeDh4Z3ZO?=
 =?utf-8?Q?wi9N8uFKTDqiHxM5ZO1jqMdCHGiyiaxs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzU3czZZOE16NVk5NWdxejBaTHNPemhyS0ZTOTk0N2srek1ON3RXTDhRTHJF?=
 =?utf-8?B?bzdLM0VhV2VHUU1DODJEN0ExUkM0Vm96UVVobytNOGwxK3FncXRPVEN3TnQr?=
 =?utf-8?B?L1E3UnVQbHlHWldlRjd2S2plL3lhcDNCejZRQnVDSkVya21WTk1lVWVvM3Bk?=
 =?utf-8?B?NW90TVoyWDk4c1dHTVM1UkYrZExhTm5uVkVXK3dvWVVWbTBGRU9TdlBPK3RF?=
 =?utf-8?B?R1UvOEJwRnNwVFg3WjdJbGx0K2J0L3pPTFEveXVDK0NFZG5obkNmeWJyTlh3?=
 =?utf-8?B?YjlNVmU5VDJsNEp0ekJrTzR4d01mekFMbjYxR2NnYU1XR09GVkhWVUwvZDg4?=
 =?utf-8?B?b1NjaTRCT2FoQ1pKeUgyd1pqK1B3RUtrTnB1L0RuV0hycnBLZmhYUU5VdFJ5?=
 =?utf-8?B?Mm9QWjY5TXhFWkNxUUhWaEpVQVl5NU1MWVgxQm1LVkFLdDcxODNzZlNmWm5s?=
 =?utf-8?B?RmU2STBwcjlwS0hqWmp2Wmxma1A2ZzRpUGJrWE5tMHk4RmI5R0pWNmpGV21N?=
 =?utf-8?B?Z3FYMjZzdk9lMHFxNmZvV3UzYWQwTjl1NnB6RXlzcnowamRDU3M5MVVBcXpt?=
 =?utf-8?B?cGNPdkNOaEM3Rkd1eDRVZmYzTk1ndE5LUXhmcFRJQUJjTXhDNXdVUUorcUdq?=
 =?utf-8?B?K2RjUE5NY05keHpmUlhUcGJoUUhZeHZYRHNzTmZUTW1nSThhc0FLa0tlbldh?=
 =?utf-8?B?TnNVV0ZyS0w2ZFN1TnhMS2pKeGQyK1R6cEZydFk5aVJ2clRUaDVRd0JCbTFE?=
 =?utf-8?B?NXVtcmI4Nm5HTFoyWWRZbE9VTmdRYzFXVnVwNmFFMDNMTnJRQTVmdXlLSnFt?=
 =?utf-8?B?elpBa3l2S1pqaE1kUEcyTU9rcWVSMFJ0ays4T1htVkxta1ZPYzR6aWZSdnd2?=
 =?utf-8?B?Z2ZITCs0WWtxSXBvNkxrNnBCTnhuRngzNUdYMG1KV2U4a3hvNXUwV2hnTEV4?=
 =?utf-8?B?L1RlSHo0N08vaEFBN0xzVE9yZWhBdFFIQnZFdVNSNHhUWUw5WmFmR1BvS005?=
 =?utf-8?B?TGErZmIvNjhNenZDSXdsT0M2T2puZUhUcjZqSUNvZDlGU2xWSVlDejNvSVFK?=
 =?utf-8?B?MDcyNXNRTXVES2VmWEtmQzhnYStDcFlOK240Z0hGd0hhRkNFRWNJK1RFN0Qy?=
 =?utf-8?B?V1hDcFo4WG52VHhmUmdUbEV3Wmg5TzRVSVpSaGJvczBXbTBHVTYwU1VCcEV1?=
 =?utf-8?B?MTk0MXhWUnRYR0htZzZwMktiZGxzUEkxVG9DbnExbEZhSUhzREhaOEdLZnJP?=
 =?utf-8?B?ZHQ1YVNkSzhENlVLT3JVcitScXk0WVFYNDMxN0Nad0NBbmh1U0FRb1BVSmNT?=
 =?utf-8?B?d2tLUGtqY09qSE10bkdlWVRNMjVFbTRmNnc3bjlYajRZQmhhTTF2NG82YkRi?=
 =?utf-8?B?anhDWlNTbjA5OHBZbXdLQzQ1U25lYjFDNmx1KzliUTFTQkJZRDUzUmlNcVgz?=
 =?utf-8?B?cFZWaGJVZzAyZThGUDczZjdyNmVVek5DWWZRM2RmODBvNThNVmV1UDA2THk0?=
 =?utf-8?B?NWY5RFN4bVM0WTFLUXNVQmt6VVRmR21OSVJ1cmM4bVNtY0pwRC9zaUk1OWdq?=
 =?utf-8?B?LzlJSm94VWVIekpoYzhQYlBhWXZhQ3ZWUEV6OFljQldqaEtjVmJSTFNwdWQz?=
 =?utf-8?B?bmNmRG4rL0Z5SzhQd09DMFAzTzRDb2JjaHpJWlFaWWtLKzk1aVd5cWZjbFF6?=
 =?utf-8?B?WVozc3ZxdlZtWHpwRWE4SkYyTmNsTWJldU9pVTNhTU9jRFBQWFhqMVlEaUQr?=
 =?utf-8?B?YWxzOFFuem93Qmtyd2NSWjBBZFNiSEE5bDV4bU51RzZZbEdaR21MUEpmTjY4?=
 =?utf-8?B?SXJ0R3hvdWJzY3J5TklWYW5EbkFPUzBsN2V4emZhQ2o1M1krdVg1UUZZekZT?=
 =?utf-8?B?WnN3M2RZVzhaOHVnTW5HemxYK2VOclhIRHBObzJMYVNwV2wra3dVeWVoZGxx?=
 =?utf-8?B?d3RWU2VkV2FpL2lyRUR6QTJ0S2daMkhOY3RtUDBsRkk1dnNLZWVrY2VxZytn?=
 =?utf-8?B?VnpMZ1NJMjU1ZTgxOVUrdmVWVHNkeTVWTS9sanJTcDUwek1abk9ERUxQQXJX?=
 =?utf-8?B?dmVmeVNjc2tITGNCZGZaVnJ4ZngwSmlLdGZ1QW1BL1FpU1B1cmxyZ0ZtT2RV?=
 =?utf-8?B?UmJwa1JIS0RTemV1dUdrOEpHcUUvaWZRRWpBYXhXMDJCeEFROWZoTTdQQ3Jw?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d82a4b-83f7-405e-223b-08de3ecae7ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 06:50:32.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIxHQuWpAx8eMqRTTxyTXq9hxYU66LIn22IaQ+AIq1zTGVNgRQIVGBEO0nf14TXS942a9AWTW5zUJhCcqeX9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7045

On 17.12.25 17:16, Mauro S wrote:
> 
> 
> On 12/17/25 13:31, Jan Kiszka wrote:
>> On 17.12.25 09:42, Mauro S wrote:
>>> On 12/17/25 07:59, Jan Kiszka wrote:
>>>> On 02.12.25 09:56, Mauro S wrote:
>>>>>
>>>>>
>>>>> On 11/26/25 12:50, Mauro S wrote:
>>>>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>>>>> Hi all,
>>>>>>>>>>
>>>>>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>>>>>> nasty.
>>>>>>>>>>
>>>>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux
>>>>>>>>>> 5.4.299.
>>>>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>>>>
>>>>>>>>>> Please find attached test case code.
>>>>>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>>>>>> tasks
>>>>>>>>>> that immediately suspend theirselves. After starting tasks, the
>>>>>>>>>> main
>>>>>>>>>> task resumes all tasks. They do a small sleep and then
>>>>>>>>>> terminates.
>>>>>>>>>> Terminated tasks are joined by another task, that was launched
>>>>>>>>>> at the
>>>>>>>>>> beginning of the program execution.
>>>>>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>>>>>> joined
>>>>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>>>>
>>>>>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>>>>>> task is
>>>>>>>>>> resumed.
>>>>>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>>>>>> the same
>>>>>>>>>> of the terminated but not yet joined task 0) has been resumed
>>>>>>>>>> when
>>>>>>>>>> the
>>>>>>>>>> rt_task_resume() was called on Task0. Task0 has been
>>>>>>>>>> terminated its
>>>>>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>>>>>> resources
>>>>>>>>>> should not be usable until join is done (at least this is what I
>>>>>>>>>> understand by documentation). I expect that calling
>>>>>>>>>> rt_task_resume() on
>>>>>>>>>> a terminated-but-not-yet-joined joinable task should return an
>>>>>>>>>> error,
>>>>>>>>>> not resume another task. Am I wrong?
>>>>>>>>>>
>>>>>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>>>>>> rt_task_resume() only if task is not terminated (checking also
>>>>>>>>>> the
>>>>>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if)
>>>>>>>>>> the
>>>>>>>>>> problem obviously does not happen, but as I said I expect an
>>>>>>>>>> error
>>>>>>>>>> instead of a wrong resume.
>>>>>>>>>>
>>>>>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>>>>>> problem
>>>>>>>>>> on your side. When the test detects a wrong resume, program
>>>>>>>>>> terminates
>>>>>>>>>> automatically.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you rule out data races on the shared TaskList structure?
>>>>>>>>> Seems
>>>>>>>>> both
>>>>>>>>> your sub-tasks and the main one are accessing it, and that
>>>>>>>>> possibly
>>>>>>>>> concurrently and/or unordered. Or does this also trigger in a
>>>>>>>>> uni-core
>>>>>>>>> setup?
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> attached the modified code: each access to a TaskList element is
>>>>>>>> now
>>>>>>>> protected with a semaphore (one semaphore each element).
>>>>>>>> Strange behavior happens anyway.
>>>>>>>>
>>>>>>>
>>>>>>> ...would have been too easy. Ok, will try the other day if I can
>>>>>>> reproduce and maybe even understand.
>>>>>>>
>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> sorry, I should me more verbose in my response.
>>>>>> First of all: no pressure, take your time.
>>>>>>
>>>>>> Then, a more deep explanation.
>>>>>> I added semaphores to avoid possible concurrent access on TaskList
>>>>>> elements, but I already verified that code should access them in an
>>>>>> ordered way without concurrency, thanks to "joined", "started" and
>>>>>> "exited" flags.
>>>>>> In detail, TaskList elements are accessed:
>>>>>>
>>>>>> - by main task
>>>>>>      - under task creation, writing task handler and "joined"
>>>>>> flag: this
>>>>>> happens only if task was joined before
>>>>>>      - to resume task, reading some elements ("started", "joined" and
>>>>>> task handler) and writing "resumed" flag before resuming the task.
>>>>>> Here, "started" must be 1 and "joined" must be 0, this can happen
>>>>>> only
>>>>>> after task creation and start
>>>>>>
>>>>>> - by sub-tasks ourselves: during their execution. Variables written:
>>>>>> "started" (at the beginning of the task) and "exited" (just before
>>>>>> termination, after task is resumed and did its sleep). Also, verifies
>>>>>> "resumed" flag when got resumed, to check if resume request was
>>>>>> for it
>>>>>>
>>>>>> - by join task: this happens only if task is "started", "exited" and
>>>>>> not "joined". This can happen only after a complete subtask execution
>>>>>> task resets all flags and sets "joined" to 1
>>>>>>
>>>>>> Printf sequence seems to confirm that execution order is OK.
>>>>>>
>>>>>>
>>>>>>> If you would like to understand a bit more already, you could
>>>>>>> catch an
>>>>>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e
>>>>>>> "signal*") and
>>>>>>> study the task interaction (trace-cmd report / kernelshark).
>>>>>>>
>>>>>>
>>>>>> I'll do the setup to trace events (I don't have trace-cmd on
>>>>>> target, I
>>>>>> need to setup a qemu image with it).
>>>>>>
>>>>>> Thanks in advance, regards
>>>>>>
>>>>>> Mauro
>>>>>>
>>>>>>> Jan
>>>>>>>
>>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> I made a sequential version of the test application: instead of
>>>>> having a
>>>>> join task, join call was done by the main task, one subtask at time.
>>>>> With this code, tasks does not access concurrently to variables.
>>>>> Problem happens also with this code.
>>>>>
>>>>
>>>> Starting to look into this:
>>>>
>>>
>>> Great, thank you!
>>>
>>>>> STARTED TASK Task0 (82a9eab0-829636c0)
>>>>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>> STARTED TASK Task1 (82a9e2b0-829526c0)
>>>>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>>>>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>>>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>>>> JOINED TASK Task1 (82a9e2b0-829526c0)
>>>>> STARTED TASK Task1 (82a9eab0-829526c0)
>>>>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>>
>>>> So far so good.
>>>>
>>>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>>>
>>>> And here you are resuming a task that is in waiting-to-be-joined state,
>>>> right? That is an application bug, but one may expect it to be either
>>>> ignored, only affect that Task0 negatively, or even throwing an error
>>>> back to the caller.
>>>>
>>>
>>> Yes, exactly: task is ended yet, then should be joined and not resumed,
>>> but I would expect that the resume command was ignored and/or an error
>>> was returned.
>>>
>>>>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>>>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>>>> 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
>>>>
>>>> Instead, we see that spurious wakeup of task1. Let me debug into
>>>> this...
>>>>
>>>
>>> Thumbs up!
>>
>> Ok, here is the catch: The task handle that was used for task0 is freed,
>> even before someone joined that task. And task1 handle was freed as well
>> before you call CreateAndStartFn(1) again. Now your task1 will get the
>> handle of previous task0, and when you try to use that stale handle for
>> resuming task0, alchemy looks up the new task1 instead - and resumes
>> that.
>>
>> I looked a bit into whether we could delay the handle deregistration
>> after the joining, but that would be a hairy operation, likely also
>> affecting libcopperplate. Given all that, I think we are safer off
>> living with this "specialty", rather than risking instability in the
>> cleanup path to handle the application error a bit nicer.
>>
>> Jan
>>
> 
> Ok, got it.
> IMO this behavior should be documented somewhere because it's not what a
> user would expect.
> 
> Just throwing out an idea (that could be completely wrong): to
> workaround the deregistration issue, should the resume function use both
> the two RT_TASK fields to decide if resume or not a task, resuming it
> only if both the two IDs matching? From the log seems that the second
> field (pthread ID?) stills occupied until the join happens.
> 

I played with that idea. It initially looked simple, then reveal a
catch, but I think I was able to address that as well. Please have a
look at the patches I just shared.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
