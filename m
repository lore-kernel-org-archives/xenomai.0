Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5C342CAD
	for <xenomai@lists.linux.dev>; Tue,  6 Jan 2026 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719208; cv=fail; b=aBOveRCMole/09d378GeFXDYpf4PExVMhdDIhsn+VLgTXV5eSM2awb+cbt028hyss2n4v66pSHMegfYrIV9brN8DH2LDDTeM+v53c4BmhWBmNnhsTdzaSa1mwmzmXFpBuXHhlHWmb9Dh63ueiQqfKy8F9BFOCYWwiMYWESCFtgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719208; c=relaxed/simple;
	bh=zWB6zt6qHgwKEDII+YG55FqnpYxEQ5YOhjMTMB3QKOE=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=V8nW8nhza1N+90Cq+cllpTiWJTPPOtDHd0+UHEi05iRxWTWytz0gAyWezzM37zL87lTMLAyB88MYcZhOCw4wI2ukDUcO2heaig7jnSo7dMqkQ6b3ENFc7AfdbumC+Ui4I5C/8SgI8awgj4EP1E7DJxuowlQCY3UcKss4+tYVrOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=p9cMosgi; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="p9cMosgi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsPdyBB2rxC16dn12YTyTvWalNFei8ttWe1Bj6EAXdsE9pkbJb7UXRDA0j4eHthKRNH3ut9JJZEOnMAathBekjDXfWBHYGT4LA0doZMHfuZJv8HrcQly506xX/HEhNCTvEnN8/c9GJg4OHYHTMZSy5sccU33MVnyOYeWYJ8YM/3db+RZDDe2QtULOfMIb4UrwxWFiCHnIJ95ocgbwX9NuzpGlmVNAoCPzw3JKoeG52Tf9S8S0XHCvp6DReC7SJq2ueH7xDZvIMQ68WeRbKG3J3Q7LNEaIJ0tnNvi1SFhh14SytSpXfjsEYJF6kisv77HO39UQiDdWWa4+YTea6PDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2CdaPkvq2lEs36kuj25i1GJ1vcBZVQcfhKVPc+Euj8=;
 b=VluYJnG9a6xC/6w7N6/REHBhlOqWiVDdmkxsMnKeYlr4QULkJmh5vfvYS4U8A0JYhDtqMGdU6Kqdl9YYkEj2cJ2HueVHUMLr7RWEfbAxEMYaZQGQrmwDeH0CWZBXs7PFJsOxgWv/vfPlYXuGHn16+rOWF8gyBKzh7mJIF4cdVCjoj069/KFxAg5O7K2Ai/NIbuc/jwR7PaWTrI9/RS1DS3X/IANZvonelMKSOwMw2DoDy6Ac9M1ZJiIRtkz85mopl5lNxoQlD0A3Vz8IctymqRJktd0Elmb14xFH9F4h23RU25d4cD3mbDTMUPeMFegvy65sU1nu0qImbSEteu7eOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2CdaPkvq2lEs36kuj25i1GJ1vcBZVQcfhKVPc+Euj8=;
 b=p9cMosgiL03XABc91IlVVZPiE8rp/m4fekghjiNrrorRjFnvkvlBQfnhovCVZTNoZjPlejyqdP36g/fQvfI9taBJWlmHDHmrvj3ftvd6WtTWG7YXjiFMEiJpmCn2MiD2RXc8emlTCKd/sWZH0MFDMGhWJjTPplxSIlpzgfJ2dy+CPQ8LvFomXRSjK3BOkmjyc9lTvKKIOtsFIGAB7RA/BgMFpHGhzYw9cvA8YGhO//e3lb3QVtXlLQvPekrlohR3Vg0MfqMiz5XdovLnWgsTqZFmLOH5hSw2YZRpB5ICA+wGvivLzEM1z8zk2Cr/XXGKS0PYk8/efIJGK6kTuSLMmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 17:06:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 17:06:43 +0000
Message-ID: <ec62e497-4fc5-45d0-a142-16603e91f801@siemens.com>
Date: Tue, 6 Jan 2026 18:06:42 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, January 7, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b05fca-21b5-4a55-03d4-08de4d45f782
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTZneWJlUTdRaFZ6b1RSVzErY2NmdzBhWFVUVzRCV240WjVQbWtGc2ltTGI0?=
 =?utf-8?B?VWNhTUs5L3E0WWxXR1dnQWMvNiswdTJNczQzQmxsVVlFTjdIbWE2YUhCZXJ1?=
 =?utf-8?B?bS9FVEFySTR3b0J5MC9HQmFkUEdUdTFPaU11cnFQMk0wZG9XYlZONXErR0Q4?=
 =?utf-8?B?dEN4bGx1enE2UTRWV2VsSEtlc3pzZ21FZFNyT3drSVdqV21rQzhVM3pYbktt?=
 =?utf-8?B?b2hFcXNONHdhalVSTmNQTWxHVlJSbUx0b0YzMnBMNUord29OUWJrVlV3ZU5T?=
 =?utf-8?B?VkdhejljQ3JMdGZ3S3lPaDNSL2RmWXhPQVIzKzBOUmx5Q0xLY1o4YzIyRGxS?=
 =?utf-8?B?d1k2cWlBd0FRSDR5Lzg0eXM2TGErWEhIMHdCMStIZ1RWWE1wTXdoNUV0NFIw?=
 =?utf-8?B?V29oYWtRTFozbUFvOURkSGszT0xWTUhzZXY1b2M3RmgzNHAyNSt2VUdEdW9m?=
 =?utf-8?B?K1J1bjM3VjRBRWR3RktVWCtLSEIwUUtWZUdVbnFRSEtKcTNTdmgxVmZrRjcy?=
 =?utf-8?B?YVBsME5Vbmw3N2NmNlVKNEdzckRpZzZ3Yjc1KzN5ZmNYOFd2K1g1NHkzVExT?=
 =?utf-8?B?aU9Qenpvc1UwOUtYQXYrcHFuaEcwT1RhRElnVHFIb29GNkRyQ2xVV1Jwb3N5?=
 =?utf-8?B?S0gwYWZaRmNDQ0RlaW9SRktIVUVOYkc3YkkxYW53eGttcmppd0VzUDRaUitL?=
 =?utf-8?B?TitUd0dBcmRKc2ZlR1c1dzdGRVlVcXNZT0hsZnZiMllIb2VBWCtpaHhEMVFj?=
 =?utf-8?B?elNua3dJOVlDc2JFZWxhc08vbUhicVIwdGJQaWdEL0lDVGxBeTVyc3ovVFR0?=
 =?utf-8?B?TFZFNmhCZjZVdUtydFdGUTlTTG1SVEkvMU02OTVDN1EyOHFWNGNNa0lSckt5?=
 =?utf-8?B?bW5UVVp4eTRRMHVDUkNxaVppbm83RkJ0MzZWT3l4ZFB4ODlXUGwyc1RZZ2JR?=
 =?utf-8?B?T1JKZ2JDcGhTenVLZUJDQ1RNMXVINlp1WUNNOWpidlRFc0lZSWV3RUMxckJV?=
 =?utf-8?B?TnBZN09hY0U3dG1JNTRuemhsaDdaUjA0V3A5ckhHZk5nL1k4aE1EekxiOXE3?=
 =?utf-8?B?d2ZGclVZUEZSWUxmSnJ0Y1ZQMHhnaERyZ3N2Y25PVWhTdUQzTUdBSGkxSFEv?=
 =?utf-8?B?WXlXVU1aSWljM0JLVzV4a1hxNC94bHFONFVOcHhrNW5DL0lOeVA3a0I0d2Jp?=
 =?utf-8?B?YytLK3JHbnhsYkl6K3NKWVU2MHpaSVBBYldYZThHcUROUU9TM1pNbWxUTHhY?=
 =?utf-8?B?NjBXU3RxbUIxV2Q5UHhGWDlDRHdKQzQ4Mm96MHpqblZYYWl5VUM1cGFMZ0w3?=
 =?utf-8?B?K3ZhQ2JHZkZzRTRpTFJDWFo2THU1eC9xaTJqNE5HZmVYek96WHlrQkMxTzJr?=
 =?utf-8?B?LzRVc2kvd09rS2c0TlRRSWZxNFNHT010Qk41SXR3WWpoZGxxVFQvc0FnZWg3?=
 =?utf-8?B?VEJuUHR1cE96bzIxcEM1cmtMemVDU1FlZDhzSmc2N0Jtb0RwK1FqMWxLR2kx?=
 =?utf-8?B?NWhHdW15QTNiaDA4dVBPdk0vQkFwYU1zZkhKaC96ZXJFQmpQRVc0bmpXRytx?=
 =?utf-8?B?S01GNEZrZDZCKzFFMUdDbmxIdXZrdmNIbjFsbmxzbUd3eVZ6d1VoRVRiQjRl?=
 =?utf-8?B?aTRtaUZ5WHJhaGQ5YnpJdVZwQWdOTWoxQW12SVpVTzJ6eUJYclhvc05RMHFQ?=
 =?utf-8?B?V3FPNUp1b1E5Y3YrWUkzczZkR0d4S1BqVTNPNGhxUU41dldPdkRBRTQ0djRK?=
 =?utf-8?B?eGdrNWpzUXYwS0lGSjZhUHFSK3pGRk4vQUo3b1NkR2RLRWJsQTJtalNidVp1?=
 =?utf-8?B?eU9GTGV2cExSS2ZVNFNnY05Dak5FaS9HSmJrZkJzVzJXamdUdHRUTFRPM04z?=
 =?utf-8?B?T3M3bmIwQmRHekswNk5HSkEyK3pJYTN2MXlPYVZjR0xWTFc4d1pVWkc1K3dm?=
 =?utf-8?Q?nM5yY2tl3u2nqH/6FlZ5yFNd3t9Vkfzj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akIvOXRLWlNwY1ExNFBYbzc3N0xDMm5wcVNNZkZWSnE4YlVzZFl6YTlTYmVo?=
 =?utf-8?B?QW1UVTRSNlRITGw1azZJR2FaSVo2bFkxdUJUNDZkK21ZV1lHZUJ0RFhEOXAw?=
 =?utf-8?B?TWh2OFkrLzJjVFBXT0JGeVJBSlRheENlc2pvZlFjdVlXZHkxWTVFN0R6WlBF?=
 =?utf-8?B?NUpaYncwZjFhUHFITTF0OUkwK0tVY3kwaVl5M01sTzhhY2c4cTQvbHpZdW0r?=
 =?utf-8?B?S2lmZTMxSjJsS3BrYms2d2hJS0xMRzl4akliNlM4dXIrS3dlWVJLR0Yyclcv?=
 =?utf-8?B?aU9JVmVHckFMNmZaM1dsRkEvbUVmK2U0eTZaa28yMy94WThUQnFJZU02SXNz?=
 =?utf-8?B?TjJLelN0SmVXMW1SR2ZhRkVtQ0syc2xIRmVPM2FJOGZEZjhSdzc5cEtSZElo?=
 =?utf-8?B?U2RVb3JYaFZmUUNwdVRrMnpiT21mbElpRFVyVEVWNDJEU042bmRXYVoyZ0xW?=
 =?utf-8?B?ay91ZjNNYURaNlZ2NGFMNXpUS0k2ZjFLKzc0TkIxMG8vbkRtOXdTVlBjYjRu?=
 =?utf-8?B?ZXQzeEdQcFhpYVNDVmN0cTJ3QU5JMHFvc0VwWFYza3R0Y0gxaHZ0clhnUzRl?=
 =?utf-8?B?cXZjUGZsZHVWQUthZ2ZBWnVOYzNxYzByK0pNSlBxc2JTM0xJRFVNQmU2YmdX?=
 =?utf-8?B?dXBuVGpKRjJ4d2dSNlRDbDJDbVZ6dWNOK0NvekVYNjE1UmkyNW44Ykt4bC9T?=
 =?utf-8?B?TUIyN1NaSEVpK0RjRnhwQnNMWCsvM0lDa056T2hDSWtrcmFqUGtoOFJ6OEJq?=
 =?utf-8?B?REJkNWxXTGVaWEpmS2xsckZocHFldC9QSGdDTXV3VjJDM3RGYmljd0R6NUNH?=
 =?utf-8?B?bnY4WkI4UHhBenRoVG16S2laVmlNem9COW16dUNaSDNkUmJrdjJXV0NZbGhS?=
 =?utf-8?B?UlZRYzBaN29CSGQwcW1ZbDlsenlBUG5SZDRSR2ZIaEg4b1FUazJ5ak4vTUdN?=
 =?utf-8?B?UmhZbTRscnQ1VG4vY3N6WUVuTDdFbkp6MHhWS0o2dnkzc01xd1dwRTNLS0Fo?=
 =?utf-8?B?QnFVN3ljUTQ0RmMzNmtXZDg0SFZ4SWhtYUhDZjhsS0FaVWhmSWw3cERBdnhp?=
 =?utf-8?B?YnRaQkU5NkpxQlhUNmtOcmJNV0w4R3VYeDNvY1FBSExlUlRaeEtpS2hZWnNw?=
 =?utf-8?B?bGtDNzlDV1N0MENsRzZVWlhLUHl6V0MwZG1BNW1GekhVRFA4NmNTR3hiTFh3?=
 =?utf-8?B?YWRtMkQyeWwyK1I3TVE5TUpGa0dPU2NpcklsWXdVTTNnSk9jNEl1b0NOR0N6?=
 =?utf-8?B?L0ZmOW81MlpEdUcxOFpDUmFjYkp4R3RzR1dGRWNsZ0EyclAzUDZLSHN0eGlj?=
 =?utf-8?B?eitFSDAxd3d5TURlb3N1NWlDejZlYVFWQmVWM1Nuc3JpbWFHaGdMNWtmMEpm?=
 =?utf-8?B?UWw4SjF6d2ZxRDVhTkpzMm5LVHZPUXdiYkhIdUJ6K3kyRE1NeExaeklNVnJJ?=
 =?utf-8?B?YThEYjdCUEZBbEdUcWRyUStTU2ZDRHpnVm4wRW4wcUlqL3hBV0FIZEZuQUNn?=
 =?utf-8?B?TEc1LzJoS240K0x5TWlzeWlHZFJSK2RNbjkxeEFWckxNRU9ybmt4MXJyazR3?=
 =?utf-8?B?VW1tWVpld0JCck82d2YzRDVHeE14b0ZCaUpld2RQYTlzU0VTdkpzY3BLNHMz?=
 =?utf-8?B?YVozcU1VRzlLY284S3ZtMFZVZU42QU9Yc05OcWt0ZnV0K2dpdWMxV3NFMWZi?=
 =?utf-8?B?VWE2UG44R0tFR2ZsamRzU2Njd1UyUXl2bXljVDBPaURxaEZtdGdXSWcxT21B?=
 =?utf-8?B?c05Va01kcUt6UTk1bkxGMCthNzZYbi9qUnFEVWpTcGNNYUNSdlRmcDJnSTB3?=
 =?utf-8?B?VzdNNnY4QWszdE9yeG4zWUVRM2tUWG9laGlvbThiTUdUdEJaSVNRN1p1WDc0?=
 =?utf-8?B?bldzT3EwdXNWZ0pmb0RtMjFPRGtJWXZSb21QV0RTNnJWTlZWbVd5cW5idFEx?=
 =?utf-8?B?UlpFeENnVWtHL1JQZmVPbDJyOWZYOUplODFBSGQ4S3FnMUhUTWZ0bXhLREVB?=
 =?utf-8?B?enNsSCs3WHNuaDZvbndXWDB6VktOUTNzWksvY0c2UmYrUnFyMGQ3SE5CSW0v?=
 =?utf-8?B?emg4Z0xSNnFNMkViRUxkVXplMnRPb1FzbGZ5cXJ5Q3hSQWVNcE9YUXQ1TnVK?=
 =?utf-8?B?ZTFCYWcwUHZxTVZ0NHRrKzR6dElTWWN2dXhYemdYOUQyMGpZNjlYeEYxYWdu?=
 =?utf-8?B?NW5oeGR1a1dQVFFUTGhhNG1sbUw0MHVYTTQ4NVJpRElyTlIySnpOREgwVEtt?=
 =?utf-8?B?NzIzYXYveVNlbDFhNEt4czYxS3dHOGxtdmRPT1RkSUNwQVA5TU01KzZ3N3N3?=
 =?utf-8?B?OGE1SldYS3VpMk5PamdBTGNwS2NIazNuSmxmL0dvOWMwT2hsd0lRUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b05fca-21b5-4a55-03d4-08de4d45f782
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:06:43.5125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs4dtnDoCimv/m3rUdO02GdzKb/unrWJMED1bMB2/I0RawpxDxACmOwuPcfSRfcuMvbxJu9TDH4To94FgFbZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8657

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, January 7, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Happy new year!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
