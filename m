Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F118B49F
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069797; cv=fail; b=FMp5GIl+8ysj41CJ4efavBb9svdaWjH3+6OLaIuuwl1P5WAquKTnsfoBVu/63tST6rbzdLkBp0ikd4vQRIr1kY1juqU+s9ihV1lFw3qwCN0RV5t/+EtldJBvk7vKGCqItRREeT1k+NMSlLCC4rDAcmmJyunmpf0ULVipC9GKCec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069797; c=relaxed/simple;
	bh=svyMiEY3UCJOzIcLmxFRevfmDb61koDiudaR6HA8H+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCL5igxd/yF9B7XKl+6tJ0nF4YMHINJTiQXp8Ug+f1eelm7/43PCtAg3iVQJ5UA+P+CiH870vMqPo0ugxBY19Z1hzoZZcn1AqAlfigXpEUiCc/2VJJvXag4YWrU+mfYBTl9vmIrA2he4dl1+x8Gelave7Y1DVs/pmdPKG5VExZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tXsk3JaN; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tXsk3JaN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1koaPgXnUE/0F4f2pr7w1pdoVMTPzUkMlIGz1aby13vEQcM3D3R1QR6QPB392qzKUpatEWxYr9vegrHzFtdDn1T7ujT+r4DG/rHb4FisY2HhwjGjA0KoNW76gihLbReBybqZz5qFIZ/dzUAmlTjyXk19dUApXxOQhjBcJ146/rhGPObrC04rBtotIIFTNmqXCI0kaqNMEZSHl0pwfRqotSTH70re+/BnAAdNUF2P30ypqNNUVb87xAc8S/navlbMpcesl4eacnBchZN+VKQ/phQuawLuWmycnKpP2a3SbDjTofPd/JwkneVp3HXtkXKFwo03CkBkK9Uri79uX3ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoHld3hzW6olCUVAEsC3GxUYDpg/h7Ecsl4+m6WeENA=;
 b=bsKuI9FdqTA6OkGB8OUYZTmPKSe6k0XzHduyA/Ucvh/jFHpllw4KbWhPkYZNss3C3jpmxUVQbhkzNUtxt9hYD3p4Fob0MvtIel9fEVstLrHdgX3Xa60K2llMw90v7UqIvmBMm+qleeMB/TxmrVVMiqxkrw6OIVnDTmcxKlWCgosBAvvZv7b4scvucev2DnxpjV7z2ApCtoYwlwQ7MbLlwOwkJ6+mbTv5BlogQHwJ1XQT0owFs2NEigrB6qW3a0wTw+XBfZRlyLtZuecpalSHTgdAlw91Ovod4MjYhbylLwKtS7uQ9z+1MW8+Yzju2+lG2aaQPiOARVs9DJ4aExJLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoHld3hzW6olCUVAEsC3GxUYDpg/h7Ecsl4+m6WeENA=;
 b=tXsk3JaNMdLq8du31gjvIyPpluymzb5fWhBxUKEjjIubKup9r4u91KO06qbTqC+JlcYq578VQRDg1E9BtVWFnV6GaMVIGsbIsEy1bMkbm85wcWtWg0F1u/XT4L5r1qVHuVGEuXfHKCM+f01daBh1pGp6hqVo5JgGn1fvMaaBRSjTggCNyqGITzaz8IDgANT0KZPy7j4a76nfGhecZtiZyMjyvQGkF5Rjl8/x38YKbVwwM7dO7FykLc73VZ5inaMJvQWtevRcSnHuFP4duP4CVHq9ZEJWsCbNLVhZoJsyRAUXtE8JLnARxvrSWzIhzwLfzPe1R/0kzfZyfgHhHUtPfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 09:09:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.000; Wed, 16 Oct 2024
 09:09:51 +0000
Message-ID: <b55fc798-80c8-454c-a566-e38b2b88e3f2@siemens.com>
Date: Wed, 16 Oct 2024 11:09:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Move relax related lostage_wakeup work from
 stack to thread
To: JerryJun <jerryjun123@163.com>,
 "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
 <95ccd795ec5db6c2d4d867b0f29fae964cffcf82.1725016413.git.jan.kiszka@siemens.com>
 <cd1d4b2.302.1920cbd5314.Coremail.jerryjun123@163.com>
 <46532234-69a4-448b-9fc5-a04ac47fba0c@siemens.com>
 <afecd73.90c9.192948dde67.Coremail.jerryjun123@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <afecd73.90c9.192948dde67.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 30363282-5646-42ec-2e82-08dcedc24b04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzFuM2tLckQ0d2NQMStxUEdOWVV0aU5OZVdOYlJ0c2Z1SGxucnhmcjkvTFB6?=
 =?utf-8?B?NHpBY1NUWUswbk15VlZNblVPbGRXa0xyWU5Gd0ZqTFhqTjNjeHlJT1lJWTdW?=
 =?utf-8?B?MGNYaWhQSU93cDhMRXZ0NWNCZkZYQnpVWC9zazdOcFBMSHZqN1prSHJuWHlM?=
 =?utf-8?B?Zk1NOVJqamkrSW1ZcXRHeHBUelk4Uml1UlZFMFBDckdCRisxL2JiU2lnNVJL?=
 =?utf-8?B?dldlSzQwcDcrSENYcXN5V1VxcW4rTkxHMTF2QzNJWjRma2VOUDY4bVJ5LzBy?=
 =?utf-8?B?a3F4U3J4ellZRW5VOWZ2YXJKUHlzeDVuQlNmcXpEN3k1c2tIQTg0eFRRcUFr?=
 =?utf-8?B?eW1XM3J5d2hDNWVsTEdYQSswUCtQTi92OVpZbCtKOE5mejF0dzV4c0JrbjZL?=
 =?utf-8?B?bkJkQ3FZU21BY1pxdWRQNi9rZ3pGcXJReXEyTzg1b0l0WXppT0pLUnZVTnVE?=
 =?utf-8?B?UG05ejdsdlp1empVOFVKcGJuQlNrMFhoZCtEOVZaQW9GR0VNUm5kd0VJODhX?=
 =?utf-8?B?QXRRdFJmamZwREIwNXVseTZzc2hFWWs2Y0ozeTVnVU1PTDkvQUxvZGpXY3pD?=
 =?utf-8?B?TEVSOUxwMjdDWXQ4ZFF0ZlRHdGZSUDJlS0MyckhhV1ZDczE5dU9CV3ZJRDhW?=
 =?utf-8?B?YzgyU1d2K2lIcGRqY2ZJeW1TMnRXZ1VuQUw0Nkp1d2VuR2NqeS9STVBLcVBK?=
 =?utf-8?B?d0RQQjdTSWdYekxCenZUeHI3N0NuU2JjYmNaOUthZ3JsZnN2T05LaXJWb0NL?=
 =?utf-8?B?QUpWcVB4NTdCSm5Rak5FTHRFMUNzbkhHK3didkUxWUwwaVY1Uk5tN3g5bnZj?=
 =?utf-8?B?RXltN29sQTc0UWgxRWNPUDdJUFJZTVBhTytuSHViNWlCWUNVK1h6ZFRjeEp3?=
 =?utf-8?B?bHhQSEIyejlWSlJmZnBJNklwSVdYM2E1NkIrcFZDS2xXTldubjR2YkdXNUpF?=
 =?utf-8?B?eTVnU3NGTkJBY043ZW5hTkRJMkl4UFE2R2N3d3NwejdiQkJPYk9icW4zRVF3?=
 =?utf-8?B?bzJKbEdRZTBhWTc2RjE2M3ZUSXpZRjdGS2Z3ZThvcHMzWDFTUUJUdDIxT3JZ?=
 =?utf-8?B?OFBzUkQ2cTRDeEZBcnlrcDZ3cjAvWmY3MHUrTHNFQ0pEby9aN2IwcFo4U2tN?=
 =?utf-8?B?VXRYNFNMa0tTZ3E3VTRRWkJKdFEzVEgrTTZTeEhaN1hYeXU1RG0wOHNIUFNK?=
 =?utf-8?B?UnljelV0SGlnVjducXZlYTdHWUp4N2pDRFUyMXByTGV4RnRzQlZRcXVMdmtL?=
 =?utf-8?B?S2hSVDFmK09CUHJoL09udkJrTUh1UFdqckUyT2RXWC9JN1M0OTAvNW54WE9P?=
 =?utf-8?B?cjYzYmdLVHRob0p6NFFJVjFXeWhkRGlWNGF2cCtaTG0vTGZKOFdkbndrcWd6?=
 =?utf-8?B?azBMWDVBR1lFOVhWVlFQNzB0WnJETXBITG4ra1ZxMHZTdzJIbzF5S3J2ZUpM?=
 =?utf-8?B?OFd4RU1kdTNJU2JKVmJKS1VLNTBFUUQ2dHpnVFdEL3BuUDc4c1JucHFxVG82?=
 =?utf-8?B?cktCNlFKdHo2b2Y0Q0Qzc2pCbGd1aFVuVUJsSmd5bkJNRTYvb2ZGY2lwaUVQ?=
 =?utf-8?B?SGZXQUhrbzNIckZzbThjc1ppK1dQVUV6d3Vxcmw4eTdRbjhJTGg2eGttRjZs?=
 =?utf-8?B?a2d4MnA2WTBkbEhtOExQeHNFNlNOQmY2SHV2ejlwemg5bEZpSlRYcm9SNXBw?=
 =?utf-8?B?T2htSkZYNmpFRy9WelNoM2ovSzBsSTBJcWpiWTBaZ0hHR2JhUWNuSUtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZva0FSMWVUTFVKNTd6K3A2SlV0OFVPeGlLN2w0c0FwVFNkRXpjY0x6NzN4?=
 =?utf-8?B?cWZXOHM1TFcvWGdsaWdPT3V0ZjhLWmhDbnhzZTh1bFFkTWQ1bkN6ZGcxa3dX?=
 =?utf-8?B?UmZTNHVKK0krUHdqNW9DQXlnK29qa0N4QzljUXppL2NnbElVc1drWjB6QkIv?=
 =?utf-8?B?bHZUT1B2Q3VJMDRFeW1SSDlEcFdQcE9lVlZNamdRVGNVZ1h6Wm5VbEhtdHhm?=
 =?utf-8?B?dUFtWjdYVjRQdlZsQkczWTlwTlFDUUdoK25Za1E2bHhWOW1ZTjNKeFU4VENS?=
 =?utf-8?B?QkhBcjFzN0NTMHEzejVZam9CSXd5aStVMWlYQmVhVGdhQ0JxS2hvKzhEY3VI?=
 =?utf-8?B?OG9MTUhrVW5pWjFMYlJoVUVMOTNQZVdMVHZkS1VmdVBFRytrVmlsREd0WVNE?=
 =?utf-8?B?end0ajlxdFZaUTB0cDJuQlJtNzEvcHlWSERrTmhzUmliVm8waHhuTTJjZCtK?=
 =?utf-8?B?dTBBNEx5eHJtdU1ibGlnOW1ZM1phcXFBMXl2dkJxOGNPclBVMkJGOVk5VFZh?=
 =?utf-8?B?T0RxQXdNbm9rODhTRCtPbFFDdU10MVNFK0RuTjNLR3FCdEJjWFd2aWYzYmYz?=
 =?utf-8?B?VWNldDQ0a2hnZFpsNGw2UFZMSjUzRDcrSjZ2QjlNRVhIRE90MUJZTnpDU1Bw?=
 =?utf-8?B?R0xkTWRDQUl0TUNBUUlKbnB5SDc4K3NxZ0lFY3FLRUZFNGFxZFBqcTJOcGxq?=
 =?utf-8?B?azZZemhXaWc2aFp5RzhiSmw2SmFMQW0vRzkrYndLTE1vNHRGTEdUNUt2M3lY?=
 =?utf-8?B?d2w1WjN0enpqa2RzVVh3WGg3eFR3Uis5NklhMHZaMGxrc2UwSHM5b0tEVnNp?=
 =?utf-8?B?elRlbHV2UG9nSGdJZzc3ZFRNd0ZITkpCaStqNkFBUjFoVmRnK0hOTHlyWkJ5?=
 =?utf-8?B?QTBDRkdlZU82bjNrWjIyckdZQU5RZmdDU3dPVVgrY0xJOXFjSnNaS1gxMDBa?=
 =?utf-8?B?S2cvR3U3akowZGRCTFJxZkQ5N2lmRTMyOGxia3p1R3JCL3hid0pHdDE5aXFF?=
 =?utf-8?B?NDkxeDNmTFllVC9ZanRoNTR3RmhkQXNIWGFzWC8rSVdyYWxCUk1ib2s5N3ZB?=
 =?utf-8?B?aFIvL0V3QUpGQzlwbWp0RXlkdm1HRTNqT0MwWXBhZlVXTGxVZFJBZlRjblN0?=
 =?utf-8?B?SGNnWWJneC9sejZBQlo3SEdTY0xVTTBuZU9YMWlKY0o2NmpVT0o4dzJFS0Zn?=
 =?utf-8?B?VUFSd2ZhaHVqOGkwUE5neFRsQ2wyMTRIMlc5TlQ2THVod0g4emVONWhmNFU3?=
 =?utf-8?B?RkN5K0NlclpFSElGcHZuaGxPZ2o4eEZ5SnZxemt1bWx4V3c5VW02cUpSeDI4?=
 =?utf-8?B?c2FqMTEyZVl0NCt5YldJbnJkbW8wK1k3SjNCY0hWZ0tIUzBCT1hjMHBNRXdr?=
 =?utf-8?B?OGwxNlk2V3MwbzU2RElYQ25BWWg4TjBHcjVGYzB1VFgySFV5clB1SGt3a1hW?=
 =?utf-8?B?OHY0L1lUWDFmNVNkS0hiODU1OVk0ZnplMXl3bFA0ODE0dllzSC9VbUdmSFUr?=
 =?utf-8?B?ak8wNC83SmxyVVhaTVJaSVFCMHIyZEZFYk1jaFNNRURGTWlLZzZpTnNCUGNY?=
 =?utf-8?B?a2dHaVRJSmx5dEFXNHplSFlUYXp0VHlWektUcEFmYnUwRXZMWnl3NkphNW5G?=
 =?utf-8?B?Y2lmWTN3ZWM1VkhqaENSbWhvQVRkb3lCUHhRelQvYjNZZzVtRGlhQTM5Q1lk?=
 =?utf-8?B?WEpPWXMxL09adlU1bm5UYnczYkNseDVNSVhrbHpjNWxRaUp0SlZQZmVMRFlQ?=
 =?utf-8?B?YytpMzhFSlRINTl6S2NsRDNKRnBzdTdpbDRFZUdoeVJRTzh6Unc0YXRoTzRY?=
 =?utf-8?B?Y2hIaFo5Qlo2Q3NLODVrNC9EdHpNaXRvSFJGSVlQRGFxQnRTNnB2TWFtVWJx?=
 =?utf-8?B?K2hPT1dYMSsxZmJGWDlzN1JHd1lTRDlFVTZtaU1DME5La2xBU3JjQlEzLzFW?=
 =?utf-8?B?MlJEZTBCdVNRVUQ0ZE5QeXpIcW1kdTJlaUtkbHc5U1NHdWIySE9NWGFWQ3cx?=
 =?utf-8?B?YUNkVmlLWElDdXBRRzdhS2g2V2IyUWFzYTM2Q3lsRTYrVUlJSHdXMVREdTly?=
 =?utf-8?B?Ykp6NHlRRFFDVmtCQmsyQUlVSzJFdFJ4bFpZSG1SNGFaeFdhRmc2WGZ1NVR4?=
 =?utf-8?Q?W7wd1dzedlUb/sMCWTp0s22IE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30363282-5646-42ec-2e82-08dcedc24b04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:09:51.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeX7DL/DkDz+7FJZ0GrYZotz9buySOpNR49dn6FrO4DKGYXPXixgoK2NaHSeWsPz/uIAZNcOHtlPWI3uvQP2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8543

On 16.10.24 10:59, JerryJun wrote:
> 
> 
> hi jan, in this patch you mentioned "As the lostage_wakeup work is currently on the stack,
>  it can become corrupt when xnthread_relax leaves earlier on the new CPU than the work was processed on the old one ",
> why it‘s not triggered it in the switchtest benchmark which involves "xnthread_relax" due to linux syscall ?
> may be you probably describe the triggered scene detailed? Or how can I trigger it in switchtest 
>  by using xnthread_relax leaves earlier on the new CPU than the work was processed on the old one?  thanks

The switchtest primarily tests switching between already existing tasks.
I don't think we stress there the continuous creation and deletion of
task there yet.

Clara wanted to look into improving the test coverage of that particular
scenario as well. You two should probably coordinate who will work on
what aspect.

Jan

> 
> 
> At 2024-09-20 15:58:49, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 20.09.24 02:03, JerryJun wrote:
>>>
>>>   hi Jan， the issue reported in [1] has seemly not been solved in ipipe.  Will this issue still be maintained on ipipe? 
>>>     the test case is available from Florian Bezdeka ([-- Attachment #2: xenomai-alchemy-app.tar.gz --]).
>>>     linux kernel: 4.19.89
>>>     xenomai: 3.2.4 + patch[1/3] 
>>>     
>>>     [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
>>>     
>>
>> Sorry, that fix is still only on master (upcoming 3.3), not yet in
>> stable trees. It's still not expected to be I-pipe/dovetail-dependent.
>>
>> Let me recover a bit more from yesterday's Preempt RT merge party, then
>> I will close that gap.
>>
>> Jan
>>
>>> [   98.182433] general protection fault: 0000 [#1] PREEMPT SMP NOPTI
>>> [   98.182453] CPU: 1 PID: 69131 Comm: rt-task-20 Kdump: loaded Not tainted 4.19.89-ipipe-9-xenomai-3.2.4-proc-20240909 #12
>>> [   98.182475] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
>>> [   98.182496] I-pipe domain: Linux
>>> [   98.182507] RIP: 0010:xnsynch_sleep_on+0x15d/0x250
>>> [   98.182517] Code: 30 12 00 00 3b 78 e8 7f 07 eb 4a 39 78 e8 7d 45 48 8b 86 50 12 00 00 48 8d b0 b8 ed ff ff 48 39 c8 75 e8 48 8b 86 48 12 00 00 <4c> 89 40 08 49 89 86 48 12 00 00 49 89 8e 50 12 00 00 4c 89 86 48
>>> [   98.182552] RSP: 0018:ffffc90006327e30 EFLAGS: 00010046
>>> [   98.182564] RAX: dead000000000100 RBX: 000000000005f3e0 RCX: ffffc900012d2a88
>>> [   98.182577] RDX: 0000000000000000 RSI: ffffc900012d1840 RDI: 0000000000001032
>>> [   98.182591] RBP: 0000000000000001 R08: ffffc900012d2a88 R09: ffffc900012d2a78
>>> [   98.182605] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900012d3708
>>> [   98.182620] R13: 0000000000000003 R14: ffffc900012d1840 R15: 0000000000000000
>>> [   98.182634] FS:  00007f888c3bb700(0000) GS:ffff888133d00000(0000) knlGS:0000000000000000
>>> [   98.182650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   98.182661] CR2: 000055738facc000 CR3: 000000012ad44005 CR4: 00000000001606e0
>>> [   98.182698] Call Trace:
>>> [   98.182708]  __cobalt_cond_wait_prologue+0x26d/0x850
>>> [   98.182720]  ? handle_root_syscall+0xd3/0x310
>>> [   98.182730]  ? __cobalt_cond_wait_prologue+0x850/0x850
>>> [   98.182741]  CoBaLt_cond_wait_prologue+0x1d/0x20
>>> [   98.182751]  handle_head_syscall+0x106/0x3b0
>>> [   98.182762]  ipipe_handle_syscall+0x66/0xc0
>>> [   98.182772]  do_syscall_64+0x22/0x170
>>> [   98.182782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   98.182793] RIP: 0033:0x7f888d29575b
>>> [   98.182801] Code: 8b 73 04 49 89 dc e8 54 f0 ff ff 48 8b 6c 24 10 b9 23 00 00 10 48 8d 54 24 44 45 31 c0 45 31 d2 48 89 de 89 c8 48 89 ef 0f 05 <8b> 7c 24 2c 31 f6 49 89 c5 89 c3 e8 25 f0 ff ff 4c 89 ff e8 7d e9
>>> [   98.182837] RSP: 002b:00007f888c3bab60 EFLAGS: 00000246 ORIG_RAX: 0000000010000023
>>> [   98.182852] RAX: ffffffffffffffda RBX: 00007f888c56e6e0 RCX: 00007f888d29575b
>>> [   98.183195] RDX: 00007f888c3baba4 RSI: 00007f888c56e6e0 RDI: 00007f888c56e7f8
>>> [   98.183530] RBP: 00007f888c56e7f8 R08: 0000000000000000 R09: 00007f888c56e6d0
>>> [   98.183854] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f888c56e6e0
>>> [   98.184182] R13: 00007f888c3bad80 R14: 0000000000000001 R15: 00007f888c3babb0
>>> [   98.184500] Modules linked in: fuse nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c arc4 ecb md4 sha512_ssse3 sha512_generic cmac nls_utf8 cifs ccm dns_resolver fscache ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter vmwgfx sg ttm drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt serio_raw snd_pcsp snd_pcm snd_timer snd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc evdev aesni_intel aes_x86_64 crypto_simd cryptd glue_helper soundcore ac button binfmt_misc sunrpc
>>> [   98.187446]  ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 fscrypto sd_mod ata_generic ata_piix crc32c_intel mptspi mptscsih mptbase scsi_transport_spi libata scsi_mod e1000 psmouse i2c_piix4
>>>
>>>
>>>
>>> At 2024-08-30 19:13:31, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> We cannot rely on the lostage_wakeup work being scheduled only
>>>> synchronously over the CPU of the relaxing thread. It thread might have
>>>> a CPU migration and other wakeup events pending and resume on different
>>>> CPU. As the lostage_wakeup work is currently on the stack, it can become
>>>> corrupt when xnthread_relax leaves earlier on the new CPU than the work
>>>> was processed on the old one - ugly crashes ahead as seen in [1].
>>>>
>>>> Analogously to the signal wakeups, move the relax work into the xnthread
>>>> structure to avoid such corruptions. We intentionally refrain from
>>>> using irq_work_sync in the relaxation exit path to avoid starting to
>>>> wait a CPU that is already busy again with a lengthy RT task.
>>>>
>>>> [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
>>>>
>>>> Reported-by: JerryJun <jerryjun123@163.com>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>> include/cobalt/kernel/thread.h |  6 ++++++
>>>> kernel/cobalt/thread.c         | 15 +++++----------
>>>> 2 files changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
>>>> index 7f9a37d29a..22ed61168c 100644
>>>> --- a/include/cobalt/kernel/thread.h
>>>> +++ b/include/cobalt/kernel/thread.h
>>>> @@ -64,6 +64,11 @@ struct lostage_signal {
>>>> 	int signo, sigval;
>>>> };
>>>>
>>>> +struct lostage_wakeup {
>>>> +	struct pipeline_inband_work inband_work; /* Must be first. */
>>>> +	struct task_struct *task;
>>>> +};
>>>> +
>>>> struct xnthread_init_attr {
>>>> 	struct xnthread_personality *personality;
>>>> 	cpumask_t affinity;
>>>> @@ -214,6 +219,7 @@ struct xnthread {
>>>> 	u32 proghash;		/* Hash value for exe_path */
>>>> #endif
>>>> 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
>>>> +	struct lostage_wakeup relax_work;
>>>> };
>>>>
>>>> static inline int xnthread_get_state(const struct xnthread *thread)
>>>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>>>> index 8738fadfce..7dffb081bd 100644
>>>> --- a/kernel/cobalt/thread.c
>>>> +++ b/kernel/cobalt/thread.c
>>>> @@ -1974,11 +1974,6 @@ int xnthread_harden(void)
>>>> }
>>>> EXPORT_SYMBOL_GPL(xnthread_harden);
>>>>
>>>> -struct lostage_wakeup {
>>>> -	struct pipeline_inband_work inband_work; /* Must be first. */
>>>> -	struct task_struct *task;
>>>> -};
>>>> -
>>>> static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
>>>> {
>>>> 	struct lostage_wakeup *rq;
>>>> @@ -2052,10 +2047,6 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
>>>> void xnthread_relax(int notify, int reason)
>>>> {
>>>> 	struct task_struct *p = current;
>>>> -	struct lostage_wakeup wakework = {
>>>> -		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup),
>>>> -		.task = p,
>>>> -	};
>>>> 	struct xnthread *thread = xnthread_current();
>>>> 	int cpu __maybe_unused, suspension;
>>>> 	kernel_siginfo_t si;
>>>> @@ -2069,6 +2060,10 @@ void xnthread_relax(int notify, int reason)
>>>> 	 */
>>>> 	trace_cobalt_shadow_gorelax(reason);
>>>>
>>>> +	thread->relax_work.inband_work = (struct pipeline_inband_work)
>>>> +		PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup);
>>>> +	thread->relax_work.task = p;
>>>> +
>>>> 	/*
>>>> 	 * If you intend to change the following interrupt-free
>>>> 	 * sequence, /first/ make sure to check the special handling
>>>> @@ -2081,7 +2076,7 @@ void xnthread_relax(int notify, int reason)
>>>> 	 */
>>>> 	splmax();
>>>> 	trace_cobalt_lostage_request("wakeup", p);
>>>> -	pipeline_post_inband_work(&wakework);
>>>> +	pipeline_post_inband_work(&thread->relax_work);
>>>> 	/*
>>>> 	 * Grab the nklock to synchronize the Linux task state
>>>> 	 * manipulation with handle_sigwake_event. This lock will be
>>>> -- 
>>>> 2.43.0
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center

-- 
Siemens AG, Technology
Linux Expert Center
