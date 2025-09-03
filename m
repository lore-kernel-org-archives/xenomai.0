Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C951DE3CA
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919612; cv=fail; b=WJ03m79oEGYn7LX80ny4U8NsS8d2PWCVSaUYwyyMnPL7vcfsRghWT9NsjPxWEs/+lZSmDjcoORMC3HX2EUBaknLrFrCJi8YX//bTbVP3y/kd5XX83LYwW7xZx2++gRHxx8DK89bfuP4SLQUx2vDPXDWIzeHhFPGBATSeSq3r7Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919612; c=relaxed/simple;
	bh=L1MzsZKdO3826gs8kv4owPQaVns9HHHTUxztwGzg4/w=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=P1mcdwUcLz79OZ95bTQoCiSk41kogDTWqMiC3CsuJNXWnO4P56bWQIREqpZjFDM8vD06VZF2pKEn0+wgzB5vhkXGryFAgq+eBYBQxJtIvA3t59EI8PLDXuJDS/iPciMalJKNpQl8OFrqF9MaiiaMZ/DQnnydU0VaTbd6k32nXYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xQQJrknS; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xQQJrknS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn9OfWPgTPZw4RupLDxeGtH2aCF9kEdvcFI2WqVkP2KmMQMiUDlKZqCQm1tV5h4pG6bQ+wFZsRe1xDUt0QcOVciaDfSlKDRDaiqAj3ZGYDJpspuISpiH3ou8LqNbdCFRKjWEpMZrAOdQtC1KxfG6JSJopeTrecA3aTAvoZiDKOkJ8LDSGyJGCRvYVh7cYAQZVjr1EkCwevRzdf1b5Ght+s4qApLLEoEoVmXOk65otrCAetjsoyRV7cS20LRVHPwpbXTtfzWv3vWG/tjLsJuggv93VuJq02Vlw1+vOKTWIve6xP5VAyTTyyNviiN2CJVQRzgzGWiLRdfW6s58lBJ6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSjCTPi6TNPjF9LC84J4PoWF7ssleGh5XR7BX1oDWMs=;
 b=JOX2a0+fIdeAU/fMzzLTexqBvhxbztKJ1nccFnHNue8mT/1wEBgN5PnnCbhEunfF7kyTlyhqVbdDlAozXxkzHjzYIFM4zwgqBkekdrRvbh6paymL/cGVmzY90EGXQa2aPkO9by956mzfBCmXTad9TBFUU81jf1Uv2jLecuHppGVXJwghF29jWecWBHaMLmqKe+cu4b2OH7o02GTbo77/Riq99SNpBkKO4HJHPxDdhVNrvyIIa2oYQhwgEALMHyKfkGPdUJ9rofxwNa/ODeUL+ipWbwVP61UpSnrCuXPu8wTcl5ADHdVR7xHKZMG42iuoTGBSKtolBdljXj2mCLnmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSjCTPi6TNPjF9LC84J4PoWF7ssleGh5XR7BX1oDWMs=;
 b=xQQJrknS0nL0UqxAJyaSX0RlWoiRBNjMLUQSfHh72Z/GjQqLgtbpGx29D7JwlhzZ0X3IvOWdHiECe6YT+vP9sga9ItUnfqFDMPqNivN+zmpFG/JMD9DKovcEYH59YYP7921nFX0w76dr4skCPN5dzQvLjrMcxzs+oMKuXfuBighuZxgGO0U7+soqKaZU894Rdy/rU/FA2FkncPzOzc2G5NdpGQ/Sez63b1xO2QWeqNFiWhMksD8Dckv6IgC3yShujUkhcZBfWlsIaIpbuYpfuNqAEluFWGGqwSP1j/MkYWIV0AM5ei9XKULnr87OncASjew0aVA2ACiTGRHy5AhhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:13:27 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:13:27 +0000
Message-ID: <0ec41ba3-0382-4a76-97cc-42537edb6bbb@siemens.com>
Date: Wed, 3 Sep 2025 19:13:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v2] Purge left-over from 3.0.x removal
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:610:50::40) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1662c7ef-fc33-474a-a987-08ddeb0d3241
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWZ6VzRkaTNQYXIvR1YzZ3Vzd1RoNmhtSFBySTVCa1FITm51ankxaHFJYStj?=
 =?utf-8?B?UnA2dXRQaDhpUTVYdy9ud2p6UFcwblViakxZYW82VDVPK3JJdENYd09saUUw?=
 =?utf-8?B?ZVRaUWJWUkNTUWlkRmZlZEp0WEJZc0lIMkVmd3B6UjgrNVRoY3FGM2VaaGl4?=
 =?utf-8?B?amIxQ2lKQllLZis0WTdYckNVQVk3ekw3QXBlVlZjOWFPVG5nT3lUcTdnQTVC?=
 =?utf-8?B?RGtDNVJsWG5XMXJCaEM1dThkOVd6T3dibVVSS0JsNzVjdGNwUEFDeGFLTXVN?=
 =?utf-8?B?WmNKZ3dEeGZiRCs0Wm12VzFkbzNDRzFFR0hkWHBOUUlXVEo5OXZtdHhiU2dX?=
 =?utf-8?B?Z1lVNmhBMnhKalM5eGpKT2NLeExKQWQwN3BBMEVyeldNVUt2c3RSeWNVUnU0?=
 =?utf-8?B?YmZZRHd2alNkbXhacnJnbWlIbEpuaDBuSXNHSER4eXRyUFRiZEFjQ0NLY0Rw?=
 =?utf-8?B?eUhEcmQvWnhmYVJGZjNUNlFYTkxQQU9DbnBWRWpUSWZta2xzcXdPNit0RU1N?=
 =?utf-8?B?MURBL0NGYkNIZGxKWmYreUVhUDlaSUE5NnJpakFKOEE0Y0xrOHZWbTFxM1hz?=
 =?utf-8?B?UUVOcnpkbGhzUWhwcVN3UnFsSlJGVEZka0VOMU1BT3BvNzBnOXdMNW0zQ0ll?=
 =?utf-8?B?NmxwYmZaWllJZWdGSkhMY01UbWh2M3piRHFSeGluQWthMXJqOVd3TkNKNVV4?=
 =?utf-8?B?a3h1TCtpYy9CYVkrYjhzRVVWb3pSbVh0bk1Fd2g5MU9hU1lDb1JoaE5uMVFX?=
 =?utf-8?B?Uk1rR3VJVUhWN0hzQ1ArdlBlQXc0K0FuN1BKUG5SM1VpZUFCMStZT2MzYnFG?=
 =?utf-8?B?R3B1eHFadTFMb3RjbGUwM3pNbGZlY2Y3U1plVzk2dzdJc0RMbjU2S09NMjRW?=
 =?utf-8?B?ZDNqOFhMNzQzdTM1ZzU0K2NOVWpadWpodGpRTW56YWFxZkxOdXVvWDNyZnpx?=
 =?utf-8?B?NzUrM2Y1OUJYNnNPNTUrUEN6Y1IwVEYvc3NLNFFJMzFYT3VvZkxNSUp5UUwv?=
 =?utf-8?B?dWpjeE1NRnNjalpoT0RYcDJwdnVPb1NGN05qSlJaSDZDT1ZHVTBFdE5YV1ps?=
 =?utf-8?B?OTFkNDVDNEJScitiU3Zrald2N0dBRGwvb0M5c3dBWE1seEtiZjRxdXY0enVj?=
 =?utf-8?B?blpIVVRudHIzQkx2aWJHQ2ZCMzYwelJxVUJ6OEx3RFV4bSsveHVFM3lJWHZm?=
 =?utf-8?B?YjdXbUhsblQ5bGRTaGNVSnFkMWxlMXBVVWVFRnRnT2EzVEl6UDR1Qm9HdXc0?=
 =?utf-8?B?RFUwM3Nqb3BzY2Vqdkx0T1RMa05OTWMxZVVJWkZKMmM0U1dmdk9naVZhamI4?=
 =?utf-8?B?WjlqKy9aQ29jL0JTNGdlU1JSSFJwczBwK1AydHFuUy9GU2c2S2h6TENNRTV3?=
 =?utf-8?B?SHMvN1JMVldOaFNuQlErb3J4TWhKODNrRUJ3Wnd2RFMxelhydk51VmtXc05W?=
 =?utf-8?B?b3NIcXRwa1BNRlNVY2ZRK0xBcXdwU3NBczJPREV5MWNnZzFPcTlRbjJEWXIv?=
 =?utf-8?B?dGFwQ1ljdTlvNjV1Qk5RVWJBbllNNW1ZcUNEWjJQSEZyUkVaQU40WnZucUll?=
 =?utf-8?B?aDVjeHk2aFhuZDdOd1NVcEFpWlFrK2g3ZW9JWForMmpUNHhITDhzWno2SWlF?=
 =?utf-8?B?QmNLR3UwZ2d2L3U5cENTS0NPNWNWY2U2eWdKSjNIVUZLK25TTmtLTEp3c2V5?=
 =?utf-8?B?MzA4aVpQMUJTVENneWdweUR5R2FKajlHelZjdlpIS2h4QmZsbnVvVjA5R29K?=
 =?utf-8?B?S2VUQTM0V0pYSnlJdXh1OVNxZ3owOXAxdEJIMmVDRXYxdCsrdHZyTzZkNm1x?=
 =?utf-8?B?SmRQQlpxYlNBdzJibHpVSTFGeGo1bDh0RThYaWFWaXJKR280eXl6RXg5OXRB?=
 =?utf-8?B?b0hlMC80OUR5SStJSzlPUmoxNW9MenlOZXBNeURHMml0b3FnaTM0UjZkdGtp?=
 =?utf-8?Q?U9yTwm3LeDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0psMXlBZS9zRkM1bkY0cU40bHk4TThZV00ydUh2TEZJOStqOEJOelc2bUJQ?=
 =?utf-8?B?eU04STdOYTA5NUo3cXA1dDdGL2tqZ0UwajcwRE5kc044dzYxNW1mNUZSaXds?=
 =?utf-8?B?Q21aWUFrcWdJZzRwUGFheS9STTNadXZmZjgvSERsQ01kdi84M09YblFFSzg4?=
 =?utf-8?B?VE1yeDE2TEJaSW9LN2lUdUFUOXhDY08xTzJUTjh6SW96NSsraVZpMFgyZy9i?=
 =?utf-8?B?dEtQTGlnOThWL2kyZFEyRGdneE1KZnhQWW1IVklsd21iUC9lYTc5Qzh1ZWM2?=
 =?utf-8?B?U0NoOGc3TTUrUnNoZUVGZVdIbDdaUU5uQ3N1ZUw1Qi8wTlQ2K3lQNkVqZFdQ?=
 =?utf-8?B?aUFINXlOWDBIV2puNEhqQmIycW8xWld1QS9CVHNHSHhhaG16SWdWQWVVRmJu?=
 =?utf-8?B?d2xxS1kyNkhLL2pVV1NKUFoxSldWbDMzNXN4bURDRHlISG1kbEh3aUkwb3hi?=
 =?utf-8?B?V21iSHpyYWwydnZtN21zUkl1K0RiZUw2VERZSzRpNDBHVXhoWkR1Q2ZoMDVw?=
 =?utf-8?B?OThzeFZHSjZKSjNJOUNjRW5yZGVEK3BrR3d3RkVzeldUeTBEQjBuaXByZlVn?=
 =?utf-8?B?Rk1rblFzNHM0cElVdUZ2YlNXRW9ubTdWUVVOSklwOXg5dlJYdHo0bWZVUVVS?=
 =?utf-8?B?U3c0bzdEL1czMVhzeWU0QUl5NXJ4NGUyK2Z5THdBWTJyVVZZWm9wYnBOc250?=
 =?utf-8?B?T21uRDg2RVNLY3lEVUNjY3p6M0VmZDBSU0l6YnVpajNld3M4OTc3UUxOTkRa?=
 =?utf-8?B?UGo0WXJDb2twdVI1YlI0Yks4ZzlBc2t0ZENGeUxOTTFFWjZJQm13T0NsRWFD?=
 =?utf-8?B?VTFwSFJEaWxWaThQTlp3Z2dZWFRaRTh4RzBZQmd2dXAveWwwNWZzc3FkdjE1?=
 =?utf-8?B?Qk1oYSswY2lSQmxUMlQ1Umg0Nkg3cy9weUJlN1BidG9kczZDNUllV3hhcG4y?=
 =?utf-8?B?UkF4ZmFWcUI1ZDVqdFhrWDQ3UTlpQjFTaXloOHE5VUtrY2hTaElja1UvamRY?=
 =?utf-8?B?VTBDN0xEbDJmNVN5M2pzc09TZ0FuVDIySXNvYndMd1l0KzJKbjFlaGlQWnkx?=
 =?utf-8?B?bjMvMFNBTmJidkRZZ1NUU0hBUUt3MStxMUlycXpWRWI0Y1NOSFJycVdFUEto?=
 =?utf-8?B?Y21TR3RNeXg2MnhYalFFRWNHbUQyRm5vWGRYZUFXQ0dlcEJuSjMxbjE2bDNX?=
 =?utf-8?B?SEkwMjlTZkJFTm9VdS8yUVV4ankyL000T1JGd2ZSQS9qUFpOMjh5UmdESFdC?=
 =?utf-8?B?TmRtcmgrb2NjU1RFdUkwczFiYTZNYzZkdUhJVC92dGxlRjVYNGRiNXZ3d1kx?=
 =?utf-8?B?V3h2eGJlVVdRdkh2YnBiOW1UcjZBcXd1WkZWOTBHZDRVWVgrNmppZFlsaWl6?=
 =?utf-8?B?dmJFWGRTT2pQd2RHdldmS1NWemZLa09OdVIyZDN6UXZkeE5TajVHOW0vUlRm?=
 =?utf-8?B?MUE4QnpnOFg1SEdSNmpyVi9yemNWTG9IaGxCblRONloyZTcvM3luUGdkRlBp?=
 =?utf-8?B?MThVRTF5YjBkQXZKdDFieTB1UmRaMVRGbWZ0bEZPSzgxVTJMaXBwNDVLaEtU?=
 =?utf-8?B?Y1hIZ1FzQUQ3TG93K2ExaDVWWWE5cC9NZkMrR2VyVjdOMDc0RWRxWWxqNy9n?=
 =?utf-8?B?YndoSkhocWhNTFl4S0lqQlE0c0cxQWorcDVNWlI3YXdTUTI1U0dFZm1LblBE?=
 =?utf-8?B?ZTUrUG12aUpvamlVRHZsb2FTd25xWUQveFAxaVBXZWt4dFR3Y2pnMU9sNHMy?=
 =?utf-8?B?WmhvejZYdWltejhXUnJIejFLZ2JrWUZQRGZ4aW9WcVBKTDFFeUE0T2Fua2hG?=
 =?utf-8?B?cUpFazBiNUV5bksxcFp2QmdvUEpJU0pscGNUeTRyTGxqT2RNNGVoUDZ6ZUlL?=
 =?utf-8?B?ZldMYUFqYVpWaUJVQTNxcHB0RGlJTVlCV3NSTStKKzdqUDE2WlhJR25OQzlO?=
 =?utf-8?B?d3FMMXJVMzlkdGtVYzRGbU5YcVZ2OWNjWC9YelpNMmJqLzZReVhON1p6bzlI?=
 =?utf-8?B?VmVtK2ppYVd0eHlzTUVSeTc0djhGY1E0emRuSkVGeVFGTG04U1BybjFNT0s2?=
 =?utf-8?B?OE1WaGZtT1dCWnNkNWxqdDVSN1J3enM3emordUVRK010dExNSHBlZkRTU0h1?=
 =?utf-8?B?SUs3VE5BRXljMkdpY0R0UHlyS0tYU0pUZHg1d0RnTlJvZVVuOGpTUDR2a3Yy?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1662c7ef-fc33-474a-a987-08ddeb0d3241
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:13:26.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVsUj4ZgrDptxjjjnlfm2/M3OIwJsqfjpM6yI0E3abnZDuiMx48YO6IuNLXWw1IEPby9pi6I9jI/OD2umY5WUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3654

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten by 5d996c0ca83b.

Let the latest stable version carry the recipe now so that we can more
easily drop older ones later ones for a while.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - do not remove the file we still need, rename it and update links

 .../xenomai/xenomai_stable-3.0.x.bb           | 20 ------------------
 .../xenomai/xenomai_stable-3.1.x.bb           |  2 +-
 .../xenomai/xenomai_stable-3.2.x.bb           |  2 +-
 .../xenomai/xenomai_stable-3.3.x.bb           | 21 ++++++++++++++++++-
 4 files changed, 22 insertions(+), 23 deletions(-)
 delete mode 100644 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
 mode change 120000 => 100644 recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb

diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
deleted file mode 100644
index bca3eb2..0000000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018-2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require xenomai.inc
-
-XENOMAI_VERSION = "${@d.getVar('PV').split('-')[1]}"
-CHANGELOG_V = "${XENOMAI_VERSION}-head"
-
-SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
-SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
index 0914c52..dc121a7 120000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
@@ -1 +1 @@
-xenomai_stable-3.0.x.bb
\ No newline at end of file
+xenomai_stable-3.3.x.bb
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb
index 0914c52..dc121a7 120000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb
@@ -1 +1 @@
-xenomai_stable-3.0.x.bb
\ No newline at end of file
+xenomai_stable-3.3.x.bb
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
deleted file mode 120000
index 0914c52..0000000
--- a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
+++ /dev/null
@@ -1 +0,0 @@
-xenomai_stable-3.0.x.bb
\ No newline at end of file
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
new file mode 100644
index 0000000..9184391
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2018-2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require xenomai.inc
+
+XENOMAI_VERSION = "${@d.getVar('PV').split('-')[1]}"
+CHANGELOG_V = "${XENOMAI_VERSION}-head"
+
+SRC_URI = " \
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
+SRCREV = "${AUTOREV}"
-- 
2.43.0
