Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBD392B61
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084826; cv=fail; b=sN2YX81fWTPah2jn4KuKCO79gHYJSjBL/FvqDkTJnNZ1QOfRwZTI1oY5r4kHaYyiYAXBb7+SE9pFbrYYEcl3iLJJHUYlAmadTdOx4vIvxUljDCEFN2unp2jBQ9dhIvhkYJefQafXpZENiIKcLg4hmbsC8gPdKPHq5pynzOVTcrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084826; c=relaxed/simple;
	bh=sSknGfguNmxM1SgVoDLzPq4WtMSt+fAsUte8PeyklLU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUlyt5YYqknNbXaI+EJjD4kOlDXtId0YdYyziwVd5yR6XBos3bH51T4zsgm0GwzC23d40ZTcR40jDNcektHA+wvHUDCEokxniFMGU96cGWZYdtC0ObdYR0Y11+vu75hblmu26hPh1RmePOttuR2gNg8R+E0m7iO5sHVjgecI9SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WCjYm4mW; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WCjYm4mW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCWrjiPo+wSknjiq/u5h/Um6Q57z1ZqOMZXcyAS/7QBZlaHbcjUGAbbDtQcjFR7lyOpltvf3KeThPaZl2xlZPTBLON0zp5yhaQZ6GP059ClqhmKH6dF+CLfsgX1y16bWbwWdDVTxPE+Qj/fiBReWh7yFZDqxk77hgId+odeJFNJQcMNIt+0pyNwIjpwn4JCgIwGvSHgsTLHqBNIFQiYvxhfoKpj/BnnQggTqKWugAaUzYZz4Pon+dsBtCwEPiC4bZB+tIgoGQwgPDF9KL0MVsAcQUp+tQO7f4AkJjHR1fnNFx+Ynv/Is+r6co1xd0ePZXXK5k1r67a9vTRmo+CUX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8vHMHeuu1/Zyfa1PFY/jXMAO7DCl0JG51dPy3p5aAU=;
 b=TzleaQF6vYIm5OqIJ5TOOiJa1MPrngcQ4bG3Hk2FElNqxZkSuu/o13hp/219UnQAg44jH9jG0xCsfntHU6vrpfR3OkbQpPeDw9ooFl9KqX7ycfKLNUqTJ/ydQ/ZDJrEIkdgmtcn0fehrvlS70KcgGeQTzpGzhfaYQoSkT5ms+nWpwnQHdlv0l3EvZsylI6zcnPp98ac+jF1/VkfS8Vm5wChRod2Iv3JkFHfXG//DoRNI+90z9R4iJgKNIH3vvxSNjW/+v+UdrfkFca9el45gE2OwnJL6mEHIVAkPh0SNaeNxooilomiVrmxAWjwBZnFQWSIaULPiqVgrpE2Snf6PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8vHMHeuu1/Zyfa1PFY/jXMAO7DCl0JG51dPy3p5aAU=;
 b=WCjYm4mW5Zw4svK1IUzf/02Qpr6bCpi/J25x8nqdnzGZ2TnD5Mcg9Vb2950XtEvmC3VBgU8HI6JaUENr913TiRCSz1tm88rYkGOid8x9IMXBzcskYDOGiQ1f1ExXGfB6/8AULtp/43DCuhkV8qxyO3k0KliGFEpktjhvMI8qjSFLWPUnNt76MVMm4+sK/NNAxyKKV0l6iZsP2gUnN1j7CNYTwSJqF4qwKXBg1DWuaa8MnC/t4d7x4XAixGBsT1oaeja+j8E/AFM8wCXx5pEC2fgD15JBvLqVPsyZzfHGyNzj0iKXRXUQKdFAcCKpkpJV+LUH69Y1fXkKwuei1GLsiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMBPR10MB9240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 12:27:00 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:27:00 +0000
Message-ID: <1fed3c9b-bec6-42d3-a0e0-44edd92c60ff@siemens.com>
Date: Thu, 22 Jan 2026 13:26:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
 <c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
 <ec542b43-9ddb-4211-b3cf-73360c0441b3@siemens.com>
 <fb746056-3527-4ae9-8cf1-dfc946118fd9@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <fb746056-3527-4ae9-8cf1-dfc946118fd9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMBPR10MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fbcf8e-8b65-46ad-2fa0-08de59b18a6e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2RGUTFaVDMrZFI4QVhsaERpYlRLczdMM0wrZmcyeHN6eC9xOE53bldJWU4y?=
 =?utf-8?B?VncweTNEUEpZQVdPMEVYTzU0R1lleXp6Q2JxZGd5YWZiaS9uOEtmaU1nSldG?=
 =?utf-8?B?d2lUYWo2MVNvNHlVaVNvK1V0L2E1ZVdTSGhRdmZsOXl4Y05iK0FDYk1sd1Ri?=
 =?utf-8?B?aGJnaXhsLzBmYkUvR1dGVlBZNzVDeXJoeE9IZDJCOUhuNEtDSTNWdk0ycTZE?=
 =?utf-8?B?aW0zSnFIZmxMTFdCT2dKcS9Cb0dLZEFLQWxKa09rOHJQaVZUOHZCTGVNMnI5?=
 =?utf-8?B?dXVkZm9yWGpYcWpTWG1BcE0xQkNqWEFhYnFadlVia0wzUlB3ZGJWRkxmcHZ2?=
 =?utf-8?B?TExoaEw5UnpyODdnYUYwcnhGUU9XQVZYM0p6YUdVMXRiZ0pQL1JKVlBxelVi?=
 =?utf-8?B?dTZKbHVuczlQaE5VeHByaWVSaWhHMTg1WGV5YTBiUUJOUmhpWk00clI3L3ha?=
 =?utf-8?B?TEpnd1FmeHhtREFCWFQ4OUs3VytMTnMxMEFOaHVYNWt1WG0rR0VTUll5Qm5h?=
 =?utf-8?B?eW5LVTgyWkp4SUVjdS9qUytZN1lDSmoxYm5yOThkTjZoeDhWSXgrN2tsUXVT?=
 =?utf-8?B?VTZWcmg1UERjYytYS1RLa2JMSFAva1ByTWNldU1MSFpONWhsRjdMb3RnVllQ?=
 =?utf-8?B?RWluT25YNENIZldKV1g0RVdzQVY3SzVKMFg5aERMaDhSR1VTT0RKRVBLWUpE?=
 =?utf-8?B?dUZVVUl5dldzeXgwTUZSbGovMUNwQjJmdzVGTDZUZjQyWmNZcTluTWc4bWZr?=
 =?utf-8?B?ZjkydHM5eGYrcys0b2ltMDRLTTFDaTZKVFcxQ3hNZjZCd2JhNFNzR2xyZU5s?=
 =?utf-8?B?ZTZUYkNaVzBGNEQrS1crZmVRQ0I1OTczbUJRc0k2WXBvL2liODAwNS80dzFu?=
 =?utf-8?B?bUxrQ2xCaUVYOW9OOHMzS0JicHhXenE4a01SdmRnSWJqWEJPV2p4TUZRby84?=
 =?utf-8?B?V2Q5L1RPNzVkMWRwNlJxVGxXR21YSVRONlh1QW44WFZERWNGbnZESC9MQ1JN?=
 =?utf-8?B?Vmd6UC9KRWkyRExiNHlrWGdWQUZBQk9OSHdIZ1VBWG4rOEZXK0I0ayswZ2hx?=
 =?utf-8?B?Z0hRZDlyeXJmNWFTdVc2STRPczFlOGNXMFFSWWNwTXlacmF1UzEvQ0g0eHVn?=
 =?utf-8?B?MWtoQjJKRXBiMTh2dzJ6eDlPTldHVDFPWU9PaE10TDA0bFVnOUthVnk4andI?=
 =?utf-8?B?VS9ieEVNS003ZEFHRy96eS81Yy9salV0QkV3ZzFSd2txbUlJdjZtd3FINEZm?=
 =?utf-8?B?ZE5oNC9xMGkvclR1NVE2THZLS3JUM1NERnhBUW5BdzRWMTRic3FpaTRpdjRL?=
 =?utf-8?B?R1hlaENqM3hMbXR3SjJnb05oNzNnbGZ6RCtCcWNPUWZnY0ovcEphcVozM1NV?=
 =?utf-8?B?ODJUYW9xeXp2UmREa25UUk5MQ3pWUGRPMnkwSHBJemU0NVJSYUlUc1ZNUzBH?=
 =?utf-8?B?RUFTckVQV2FmL0tmcVhWQjJRdnZVQ1dGZll2b3JsenhZTktZbkhVWFRSdUtu?=
 =?utf-8?B?Y1lrTllzVDlUeUZRalRSajZTT2JzZkdNUGZOS1NwUjkrUjNzQWZKdFhNVFYv?=
 =?utf-8?B?M3Ura3dMTTZ4ejE5bk5VVXplQ2VyenkyM1hDRFRhREtIMTBYRzdGUy94bDRP?=
 =?utf-8?B?RnVCYVZURW5zMHVoWnltQmswbWYvOWVIOG5MK2xMWS9Ua0lqWndjenF3L1NT?=
 =?utf-8?B?SWZlSjlLK1g1M1dEbkJRODNLdzRodFVqK1FNaHhmeDNIL3FuOXRQQnRURDlN?=
 =?utf-8?B?MitwSEkrTStCL1gyaFNYRDhaWVpWZDBRMjJPTnZBWVBWSGtnT3pFMjQ5cUNK?=
 =?utf-8?B?UGJkaW9td3loSjgvcVJWQm0xSXdGcE1sMTljeVI4NTN3QW91Y0FsRjF0Q28w?=
 =?utf-8?B?MUMwK1VId2s2bHZFcjdwdGNTT1I5MjlhQzRDbkhnNi9QMGlGK0doZElmMTR3?=
 =?utf-8?B?cmJMa0FPOWdxbitXZzI3ZnJUZVJPczdmbzhaS2djbjVPaXdPVEg0WTRoT3Rq?=
 =?utf-8?B?YkkyQ0E4cG1rOC9Oc2JITExRWjlTQ1RWWHlieGVNenFyQk1yREZXaDgzeHhQ?=
 =?utf-8?B?cnQvVFdqUXF3UFVoLzY1ZVVHT2ZZbmFKeHVsR1NmRUdKR2JtZkJKT29UWnBj?=
 =?utf-8?Q?NPp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXo4NGNlYmJWUWx5S1JNcFZDdWp3U1ZGNWNFUDg5WjA3VEE4OXlpaWczSHo5?=
 =?utf-8?B?azV5L2tEVjRUQzhlMEoybFlkTmlYTUxnKzRPd3RTcnpCdVlxWEViVGtuTFJQ?=
 =?utf-8?B?RTZsWUxJOWk2SWh4eTQ4aXJGZjhqOFBPR0NFN1B5ckFwaEVhU3diTjNOTVZB?=
 =?utf-8?B?TmZzRkQwMjluMFd0elNWaWlQRUNOWDlpbFg1YTYrUEpZVnVMeEtHYXprdjJY?=
 =?utf-8?B?UTFFMW9iLzJ3a0pZb1diQ1ljS3hnWFdiZjlXNUp2Z3RMOGJBVUUzMEZPZ2ti?=
 =?utf-8?B?RlhDMXRJRkVYbG5ISyszQWJPTHdRTGJqWWNnclozOGJqNHZMeTZOcmFuVWlI?=
 =?utf-8?B?QzBOUzVaY1BrK3NoU245WTJzL0JzSmkwSkZ3dkE3TVlhR0dUNDFQY2dubWY1?=
 =?utf-8?B?VjBBWlRXVEkxOTBXcURoUDRVNCtDL0tqazRTZWU4MmV3R1lyazNjK3FPU21m?=
 =?utf-8?B?ejVJdklvNVdLYlVVSkVWRHdjb3JzaWRrY2Uwc1VmRFRpbHFTbHpHMnJYYm4x?=
 =?utf-8?B?Ynl6WmhTK2RlL1lYRHp2M3o4NDAxdGpnTG9OQ2JBOFBVSU1lTFZ2bHNPV0J3?=
 =?utf-8?B?ckdtdTVaNFpIVlorRmF2bDR3N2syMVpkVnlKcmhkMTcwMXUyQ212d3dGeFBH?=
 =?utf-8?B?eTltSjZqL3RmZksyWHhwUTA2eVMrZWR6eGdZOTdQRGxYUXc0cmpvZ1A4MUp4?=
 =?utf-8?B?ZFovQTFNd0RsZFovNS9PK1hYVWp0SGw3WHRvYWlDWjJNSEtOMGl2STh4d0FI?=
 =?utf-8?B?N3hUbmdUYlpmSHMwNDd1cDBzcGMxRjdNM1kzVm5PaitkeWUyd3JDWklOM05K?=
 =?utf-8?B?eHdhOVVoTVRnSDlSSnp2QWlDTUdLSjhQZGpJVWJhSkUwb0lwbDNMQmNtaHpr?=
 =?utf-8?B?d2VPUjYyRFVWZ3lRbUtDdW5CN0RDMURuM0R1UjZaSGdYLzBjdnozR2VFQXhV?=
 =?utf-8?B?YXVzUFh3SmYvaVMvRXJCdVNJVFJrSXovejRBWHMzdWFrRm5jVzRIY0c4c2M0?=
 =?utf-8?B?amVVMkFUTXZoTGxFMFVYSlNGeHRMTTRHZUJQVmZsVWQ3VS9qa3FUelJwUDJM?=
 =?utf-8?B?NnB2Ump2SnRON3VHMmJucVVPdmRpazJwbFhsT3pWSzFZZk9saXNVc053MFFS?=
 =?utf-8?B?ckpZTkQ2L0NLQ0NrTUZKeGpidU1TQmpoZHhsVnVGZ25qODFycS9xMFRqUHRh?=
 =?utf-8?B?Y1FBQjZvdDNsWkpFVDlwVTVsOFJGdWtDcFJVdEExdHlpQmRyOTdvZFlTNjI2?=
 =?utf-8?B?S241eW9NdHVGeDNFVHpMSVNSM2YwVkRIT0dzSERLOFVQU3FBZUs2bHd2MVBP?=
 =?utf-8?B?bzdpdFV3eU9qUFZFQVhGbFl4akRqcFhLZHFNYzJkQ1M2MCs2RTZvTlI5U0Ry?=
 =?utf-8?B?RHdaNEt6UHdub3dVSjcvcXhkdWQ4TkprYjFaZWdQTjZDaU92dFh4eVVSNWEv?=
 =?utf-8?B?bU1xNnNLS1l1UmF4amIvbHVQdWFqT1E1N3Q5VDRKWVk3Zk0wTWhVcEt1N051?=
 =?utf-8?B?NkZJSnlXQmJ0UEJmaHJUTlptaytxSTVXQTY2cmVDYm4vRW4xRGpjM0wvYjE2?=
 =?utf-8?B?S25LcUxrcDBveUVpR1JRejVrSDhpKzJ5SlhNd0E1dElrQnBNeEI5bzlmdXNJ?=
 =?utf-8?B?NHVTR1dYUHFhUHZoQXRUMHpnQ0Mxd0srWTZnSnZnZWg5M21ZaUtlN29lekxY?=
 =?utf-8?B?RC94SWtlN2ptVStWM3ZmMXJYOTZxY0gxODdReDBqbnd4OXJnREJXMFoxS3Iv?=
 =?utf-8?B?d1krK0cwN0U5dFR1UDhxY0x3L1Y0ZTAzUWpjVjM2QjAyLzJlVWVzS3pXZkE4?=
 =?utf-8?B?SnhDbFUxZHdRaTRQaldsbDFLNll2ak1KMktmOUpwUW1qcFlJMkpuTGJNYm9J?=
 =?utf-8?B?RE4za3FkUldVZWdnWEZNdlZLakwyU2xRcXgyZ2F1OE1UQTdLMjlLVWhYQ2Qv?=
 =?utf-8?B?eVhVRURNb2dXYUJlbnBWdDBjK2xkZTNNazM4WVZSUUNmY1F6R282N2ZoRTB2?=
 =?utf-8?B?NnBUM082UDhyRStSOU50WW5CTHloMUowU3RaUHk1VEJBc1dzZUlKZUhwVTZ5?=
 =?utf-8?B?R0hRSjdWNllsK3gyblZMSm05SjMxRXNXTklCYjlWdjVGZjZzVk0xaXZERHdp?=
 =?utf-8?B?Z0VBbTZvZDZaREZVa2JmSmV1Qk0wZm9nTDBiUkRQWVRJR0pPMGt5aVVtNFFa?=
 =?utf-8?B?V1RyUWx0UjRyTE5jQ1cwTktHaEdxemV3bEk5NzI1elJOTXRCeWgwQVNuRENu?=
 =?utf-8?B?Z29UTkpJV3c5NEpUVk54dkxpL0tCSCtRMUEzL2tLK1hVaEM5cHMvdWRxbTNQ?=
 =?utf-8?B?R3FTdFhFVlVsSFFkRGY3dnY3Vnc2WFMyTzFjTk5tTUk5cklUQVpSWkhDVUh3?=
 =?utf-8?Q?GSiTk8J8GQk51gLs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fbcf8e-8b65-46ad-2fa0-08de59b18a6e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:27:00.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJn19H6cIFn/8x3pEpFNATwQaL3Y8I3RSeKEvMFzw+zVzPFPgfmDtzcM/8y7b3PEzoXVWf4M8MoJJ8AzqDT17fqsg4s8oesXGNy6H0fmbM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9240



On 1/22/26 12:56, Jan Kiszka wrote:
> On 22.01.26 12:09, Tobias Schaffner wrote:
>>
>>
>> On 1/22/26 11:46, Jan Kiszka wrote:
>>> On 22.01.26 11:39, Tobias Schaffner wrote:
>>>> Run the EVL test suite for some first smoke tests.
>>>>
>>>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>>>> the moment this is used to disable scheduling quota tests that fail on
>>>> virtual targets.
>>>
>>> And why do we disable them?
>>
>> We only disable them on virtual targets not on physical ones.
>>
> 
> That is likely also the answer to my question below, right? I missed the
> "...on virtual targets" on first read.
> 
>> These tests are expected to be unreliable with a virtualization layer in
>> between possibly causing delays aren't they?
> 
> So, the evl testsuite is missing something like a --vm switch to relax
> timing tests? Would it make sense to add that so that at least the
> functional aspects of those tests are kept?

Yes, and we should propose this. However, if I may prioritize, I would
like to get EVL tests (including RISC-V) with background stress running
in the CI before starting this. Or at least, I would like to
propose the stress switch first.

> Jan
> 
>>
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>    ci/gitlab-ci-base.yml | 5 +----
>>>>    ci/xenomai_4_next.yml | 1 +
>>>>    2 files changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>>> index 186d1cb..76e38e6 100644
>>>> --- a/ci/gitlab-ci-base.yml
>>>> +++ b/ci/gitlab-ci-base.yml
>>>> @@ -107,8 +107,6 @@ default:
>>>>            - report.xml
>>>>        expire_in: 1 week
>>>>      rules:
>>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>>> -      when: never
>>>>        - if: '$LAVA_TESTS_ENABLED == "true"'
>>>>      .test-qemu:
>>>> @@ -116,9 +114,8 @@ default:
>>>>      variables:
>>>>        ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>>>        ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>>>> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|
>>>> sched-tp-overrun"
>>>
>>> Why set this variable here, rather than close to its use?
>>>
>>>>      rules:
>>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>>> -      when: never
>>>>        - if: '$LAVA_TESTS_ENABLED != "true"'
>>>>          when: never
>>>>        - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>>>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>>>> index 30ca9b1..03dc233 100644
>>>> --- a/ci/xenomai_4_next.yml
>>>> +++ b/ci/xenomai_4_next.yml
>>>> @@ -20,3 +20,4 @@ variables:
>>>>      KERNEL_VERSION_WITH_QEMU: "6.12"
>>>>      BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>>>      CACHE_KERNEL: evl
>>>> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev
>>>> \"${EVL_TESTS_SKIP_PATTERN}\")"
>>>
>>> Jan
>>>
>>
> 
> 

