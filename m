Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FC21B185
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930525; cv=fail; b=DPsciMt4QtmOL5tfEwTjB+Fn33nZyDQlNVML0RXA/XjxdtL/B4XJC21wKXv4M0Cc0SP9hZcIrr8yb6XCL26pOk961PedFemxY9sjc6pXDBLMeE9EeSK6Bf7WMzOCacvohU4iggVuiKzCbx5ejCzJK7R1sQmZzPP5gHfrstlhDPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930525; c=relaxed/simple;
	bh=I8De3ogTRVfYwI1UjKC7Jw2JV6mwuSBGQ726n/W/BOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WW9wPAPlHlkVDINDj+PZPP7NyyTr36QTBKWWeazAZjBQGsN6uOFvstE5jTesiB8DsXjEB8b6AAC6pPtRWumDub+QH0WwtEGnhCnUyvBEQezv6z0saKnGKgmKLPIdM54A5z1YByRzD4RKKIiOmVIKQhV5LCPMUWnPpiqQ1H6JMug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Be8zHnC7; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Be8zHnC7"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 9AD8C42F88
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 13:35:20 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 015359416B9;
	Wed,  8 Oct 2025 13:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqGj2IvQYyx1ezXL7V5S/dv4zvHFqttfdJyRqxksS+HMgejItrBOqotJTH/bJscF+j4MazwON13GiJZvQiwSyB8B3Cl6Mu+f7pOmMBFb2pRaL/ou8zy3phbOUCumdvyU47QY4UDjjKZG71POnOti0fnf2D/RSRIZb/sUzHwRaPMqxjIVPTUOPmbZoxzhDBxwYF0DXKF1tKMzeet/ON+fz/iu1kqTHZ+zU0UREwnaZRJxFPi/ba/winRAZHXxGJZA2ug3Q94pgK7Vml/j1/RTx+xSUxholDdz8iZd8ilxbkZdSKlM2tqIUWEbYdzAkLK8iX5PLhNNzU67YbUDgn0+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8De3ogTRVfYwI1UjKC7Jw2JV6mwuSBGQ726n/W/BOA=;
 b=mqyIqwBiINrjVc4pEvt4PZSrBEPgeXc637q/mtn2ePhxd0TBhM02IUEKyuRg9r0rAzD1OdwwafoUuslvLdHv5UBMRDkBlr7V76vGb11my8L+CHAhbz6Up9QE5Dhdks7ad9psD/wtLxT6k+cMJcpcbynUoFvEQ4wkklkCWNU8enGlOdvwENfoqD/iFJdy5frFtTaA4PzC1dMMO1LImUQ5Kwa5kDhoiypiLQWGH6oIiVJbuYkYzFhinqPOpj6kV74MH8XhWLgS/5e+MPJMFx1C82dqQkcYFyjFFTJ/7Ukp8FewShVCUH+nD0W7DfDU8JT1ammoYGHy8CMqch4do/B4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8De3ogTRVfYwI1UjKC7Jw2JV6mwuSBGQ726n/W/BOA=;
 b=Be8zHnC7x62Z4MOsSdbzN/Y7H3Ff/8t5gwd5m1hQp6PdWkSyitilv+7pHPevl+nTRNXM5w6G9Zsq6y/7MltcOfqCUxboBbdgWb7Rv675Dseb44mpWK/LXhX7rPdCbUp5Ki/dwFzvitKJZHvHlt1VlrSe6b7qhya3qi2Ra743/aucnUcbDnica4Dm1vVgCHeYSy8/X22QQDVFpb11U9GPS8aw4PIX1Q65TDElDraqXAKRLhRJZyy8wGWsGyYH19SzMgdRuUfk5f1EGNAKjtxnp8C/ZF3S5gpy7739+acQTtlNbUtn/X7/6hXQ32mwo0AaBC9dN3R3I2obSKhleIiwAw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS2PR10MB6520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 13:35:18 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%4]) with mapi id 15.20.9182.015; Wed, 8 Oct 2025
 13:35:18 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
CC: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
Thread-Topic: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
Thread-Index:
 AQHcKTJl+T3wZTj0FECWLIU0KOAdSLShI8QCgAK89ACAAAICgIAAAHkAgAACLgCAA3eN9YAAEOQAgBDwjYA=
Date: Wed, 8 Oct 2025 13:35:18 +0000
Message-ID: <f036500881b880d81d25272a4f4745903f28a7a7.camel@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
			<b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
			<87bjn1m28m.fsf@xenomai.org>
			<e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
			<f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
			<8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
			<682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
		 <87qzvrkcip.fsf@xenomai.org>
	 <ed58111d2e01e76f3a64df0379e4f71e90680f0b.camel@siemens.com>
In-Reply-To: <ed58111d2e01e76f3a64df0379e4f71e90680f0b.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS2PR10MB6520:EE_
x-ms-office365-filtering-correlation-id: 78b2d6d0-3186-4cfb-87b9-08de066f856e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkZIWkNYMW9nUGwxTjd4MEY1RklVQkYwNUJQZ3kxRW1PalRmZlVEVS82RDN0?=
 =?utf-8?B?SDI0QU4wKzZzVTZiM3AxdzhMUHhQUjROaElaU1hOdkxzTWlYZUs1aWM5eitj?=
 =?utf-8?B?emxLbVRQZmdqZG1PMmxiUGZJYlEySVFwOXBkYnVJZ0RZSjJhQ3h6bDBpNmxx?=
 =?utf-8?B?eTY0QlM0ckZhcVBpVDdoTEhoS1lxS0RiTTNyTGRxc2dLQUxGaDBhTjR3M0Jp?=
 =?utf-8?B?VVdGczhlTGwwTlJpTG94WG8zbVc1b25xUmdSaVMzRVBFMTFsaUZzeHczMkho?=
 =?utf-8?B?eVpGVzBYK1JZcHZRdnhLRjZ4SzlFQkd0eXA4UnlzVWdPNWZnSDJZc0hvOGM5?=
 =?utf-8?B?MkJGY3Z5THVzSUdubnhKUVFGc0dwa09veE1MNUpvd3d3Uk5QeE1URXhZM0s5?=
 =?utf-8?B?Q3ppMlA4NERIQ2VKNVoxYmVVMlZNNTdtVkZNaGF1bnU1MkRIYTFwRVRzVXBD?=
 =?utf-8?B?eGR6cUxmRzhvS0tNNVdTd3pOYVV6V21sWDVhZVN6cVdIS3ZweTE5SmFQRXF0?=
 =?utf-8?B?aHkyd0ZueUdDTWVXS3lKcHYrU0dZMjljcmpZdUV4OEpMZlBkc1orUzRrdGhV?=
 =?utf-8?B?SUkyTm1iMjVyR05pd1BsVmpwdUpqK1d4RFFxNXlFMzhTZkE0N05HU2FLUVJy?=
 =?utf-8?B?VUtMd25oWkxjQ1JXVzgxQ2h0VlJsV2psT0JJZWNOQ2tDVG1LZ1hnei9Kck1O?=
 =?utf-8?B?U0tNTmR4dFhlWTZydEFkYlB6b2dvYVpkKzlYaWRVakVtSlRCOTU1YURMdHg0?=
 =?utf-8?B?Yk5lTXI4NS9IZTNId3hqN0ZOWjFVNjZKY0JqVU9xdVdMc085dy9LZ0M4aENX?=
 =?utf-8?B?ZWZ2ODQrT21uUTBxR0ROeS8rNC9oNHBrVlF0YkpqSDVtTXJ1Vkk0aWF0SGh4?=
 =?utf-8?B?MFZpSldaTDZmcVlYZUtzL0lxSFhmN3VKMlhzOVR2Wkt5TXpvNHN4Y1B4c1ll?=
 =?utf-8?B?b2VZVW5ITXh3TnN5bFhuVm1qdFdYaFVBMWJqSFNuYTJYd2N6VUtpbzlyOEZB?=
 =?utf-8?B?Z2RZZ1hqZ21BSjhDcS9BMHZNeDV1ZmhCN1FZdFdqZSthNkdpc2g0VFo4YnRw?=
 =?utf-8?B?bGpLZWZseDdORWh1WG16c0I2bklsTkhYQUQ1Q2I3eFYvNFpabGU5Mm9HbU00?=
 =?utf-8?B?OExzMjlocldNK0VnQmFJc2x5T3ZOTnVDNW5LVlhkckoxQm8xT2Y3SXlIY1l6?=
 =?utf-8?B?dEVnNUo3dlI2YUNpQVJZZWJjdC9lUTA1cjNsMk5QMUt6aGVtUG5Hc1l2dzFo?=
 =?utf-8?B?bFhpdFpqZVd1b1JXVGE1WEZROHo1TThzWE5DUkdQbUhJM3YvZ0dGZjR3YklO?=
 =?utf-8?B?RnozOHdrMDZsd0IwZlg4WFViUlp5YzN6dXp2R0txNjhQeDhoVC9tNkVVMDky?=
 =?utf-8?B?ZVUya3NTbFBsUi9idkFyaENtOTE3dHJ1bjQ3RXRpYkRMY1ZMRlYwUUU2bnZE?=
 =?utf-8?B?bzBpRUFzZkxlTGZUMFdJRXJrZitYdXB0TU44SUJDTG5IL0NzYWlzUm9BMHZC?=
 =?utf-8?B?dDMxVjVabEVicmdWbm5aazlreTlUZjI3VVRFaHdpbHNqVVZFdit0WEtjTENk?=
 =?utf-8?B?QllZTUtEMllZQjBWUkVXd01LVHcxU2krWmdGYWtTRWNHTDBUNndyZFlpMHEv?=
 =?utf-8?B?S1RYcG5zbEZkcWJTQ3NyZUhwWWJ2ZXFNMmV3Q0xwRTZzNWY4elNLK1lRUkd2?=
 =?utf-8?B?dk1yVlVzWnRVaGZuUWMzOE4vTmpHYng3c2tyZitJc0lNa2ZGUHdWc3daWXI3?=
 =?utf-8?B?MUtvKy9BRnJZeUlvWmhEOEZDcWxqS3JicURYRk8rQ1FWZUxYZ3BISjRxUU5v?=
 =?utf-8?B?eVVGUkE5NjRhSlhjRkYwcGlSNW4rZStTVUQ3SGxmSzl5N09ZVlMwUnFiWVBj?=
 =?utf-8?B?aXBXVUpJTVZzRStYVzhXNVlLblB4a0JRNm1xUHNwYmNxZHA5ZGthNVQ2UENU?=
 =?utf-8?B?OFdDOFNmcVBieVYrMDdJKzZwYzNLZFhGRmVYYm9wcHdIY1B6K2FZUXNpR05y?=
 =?utf-8?B?UG5YbFV2OUQ3RXh1dFhkNnJYN1d1RjJiNnpWSk1BRjR1eXFEL3crVHVudXlO?=
 =?utf-8?Q?AvfCPR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmxucTJNYldWK1Z3cDZHK0g4aGU4Nm9wa3d3aWVoTHMwQWlvajQ0bUFHTXhC?=
 =?utf-8?B?Q002dFlLRE05Y1N4eTJFNFFEN2E0SzNTcFZjM1R1UnJXVXNZQU1QNzlwamJx?=
 =?utf-8?B?eTNMc2JRNWRLWWYwUUExaVUvMkp6TXBtS245SDgrS1ErQWdPaEp3UThTeEc2?=
 =?utf-8?B?WGFhbm9EWmlPemlZT1VzVzBmUUNxTFQ3aHZxZDdYZzJrR3RmZERIZHVkbTBN?=
 =?utf-8?B?b0V6SVdYeWFXU3Z6RFJWQnU1a1U3M2RvNEFzazQ4VGtKWWIvK2dDTlhGdDZs?=
 =?utf-8?B?b2tORmg4N2wweGFyV05TSFJya1c2ZFJvY0t1M2QrZk9XN2x0ODA2eUxyV0ZJ?=
 =?utf-8?B?eUc5NnpDOWJYbDYxSXpuempkUkxGbjIvZFp3YitzWEFsY253TFA0aW9ONngr?=
 =?utf-8?B?Z1NnSkV6enhQRSsvRktsZkJIeGd6R01OaGtPVzFQOFRSS0xIQjJUTDRLcUZy?=
 =?utf-8?B?QVN6QUliSW5WRHBmL0phQlJFV2tKaWdncXMxaVBUZWNJNVJMS3MzSzVzQXh6?=
 =?utf-8?B?KzlJTFBkcHY4cllRSkNMYVNUVnhoWTVtWUFHWlR4bkpES1lkZEtidlo0eVQ3?=
 =?utf-8?B?aWdyQWtDVVp0My9ZU21hUWVaOWxmTktENW5Obk95MllwT0ttVGMvNkZteGVI?=
 =?utf-8?B?MGFJN3Zxb25CakNkaThrM3pWTXRVbzF6QTRBUVRrUTRTN25wNStnNVNjaFps?=
 =?utf-8?B?NW1yZjlNQkV1K2c3bGJOS2hEejJPdnRDb2xDa2U5Vjd5em1Mb3pPanBhNDAy?=
 =?utf-8?B?TUdUL25QNE0zamtWWFFxWmZOb1lJZXhHVnA0OXRYVmkzK3h1Z0cwaGkrYUpt?=
 =?utf-8?B?emhTb0xkcEFLZVFQeGxsbmxTbktFVmhLOE5UV2lIOGpsTnlpS3BsdWNXNGt4?=
 =?utf-8?B?em1WYWx0ZTI0b0dIY1EzUldDRVBaUndCYWRCVmxML0xQODdLUkRxUDhvZ3l6?=
 =?utf-8?B?VXU5dkE5N2NkdFNINzFFNENEdm5qcUIzaDdBakRoWnl0bkZQemtJUm12RU9P?=
 =?utf-8?B?eSsxQ2M3bWt0Qm9uMm1uZFFFMy81OGp6RjZRMlNqR2lLRUQvOFN6WDM2SmlS?=
 =?utf-8?B?ZWtsY1dYYkEyZG9EVXRKR3Zvc3Uvb3RCTDBUMGJqR2JNYWd4bWFPMGhQbE8v?=
 =?utf-8?B?WlVQdFdxK0dTOVE0L3NWL2IvR3NIdk0rUXFPNDBYcjZYVFRPaXNEMFNubURC?=
 =?utf-8?B?TlUrWmErdUZGejZiUmVuYXNxSnVnVzFldHhYZkVJNTVpSFNDR3hra2JSdVJW?=
 =?utf-8?B?eWRZWFJ5djBRZXpKcGFONTZMSkV3WXJzbWYxdHlMQm5BMlBQMW5HdXVMSEgz?=
 =?utf-8?B?aUdPeGpRSi9OY0M5Ulo1VmdLOTE5c2FVc2hCSnlXcTMvTFVhRDZDWDdLMThB?=
 =?utf-8?B?NU5FS3R2ejVsalluMjNQY3FKbWluT3RaK3p6dWRRbGdyRElQWXhYTXdwSW1P?=
 =?utf-8?B?NHBRSnd6MXVUb3JKQ0xxeUlISzR4UjlnQllTVjB4Y092VjlFSE1EeFJZZ01w?=
 =?utf-8?B?U3RjU09vWi94Qkx0T0Y5TkJxMEJsUk11eVdWeHVoenZTc0cwK2wvbWR4azFp?=
 =?utf-8?B?ZG9SQzJtMDNtM0tQUFlQOGFzOHFHQStray9Da0ZBbFpJbm1NbHlXcjlORUl3?=
 =?utf-8?B?YUZ4ZjlXMGhiam1OOGhaQmg5M015TkY0YkpUZWFxa2dmV0oxTTRkeEt6aURB?=
 =?utf-8?B?L2hVR3NaU0lsTThBVTEzTUJtc2NoOGhRV1RiazlyVnBtTWR0QW94NnkwdXV2?=
 =?utf-8?B?VUJySHZRS1hPb3RITFVNRERmM3gwcG83N2Z1b0NNN3ZOcTJWN0xsclBOa0hC?=
 =?utf-8?B?UXd5L3lpMThiYndtQnhhV2RjWm5VNnVjNFdhTjZHeVgzM3JVWWtocnhpNjd1?=
 =?utf-8?B?SWR3anIycmNLdkRyU0UycDRDMGYzWnNqakNOd3JCM1NNUDBFOEZPbXVOUk9p?=
 =?utf-8?B?Tm5KMDN5VWpMY0k3U0lkYjRrSGcvYlNuR2NuaS9yYjJBOURKeXBjQTJuWDRC?=
 =?utf-8?B?SFloLzMvbzJPQWs1SElJbHBNcmp2TWNhM21uMnNFWWRkMHRyOG13NmhraFp4?=
 =?utf-8?B?ejRvS1orUjRTY3NnSCs3ZDhEQXBWOTNyZVZxczZLQ0thczZDSWw4ZnhGakxM?=
 =?utf-8?B?aEErS3prdUVWMDJvemdZb2ZSSTZycHZYYWlkVjZSbW5GRFNiMTRSNVBYYkJG?=
 =?utf-8?B?MzBEVU5lclUvajZ1QTdNMk1LRlcxMmNiNDlOYXVrTkRWb1EwOXdxY0VqSmRD?=
 =?utf-8?B?VjNwRXNMT3cwSmhvbEtRSWdsMFlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9E99E3372AFC84194E9203415AEAA0F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b2d6d0-3186-4cfb-87b9-08de066f856e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 13:35:18.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkBwRn4sdBwMyFtmGZM3z/TqqFUZpuhk59SkVJjr6ZTB/HmY3LHR8KcJFZryNP565yQ0+zU+BbFETLWrB0qqbwEnew0+X8wz8xiWJN/b1HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6520
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Be8zHnC7;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com has no SPF policy when checking 2a01:111:f403:c200::3) smtp.mailfrom=florian.bezdeka@siemens.com

T24gU2F0LCAyMDI1LTA5LTI3IGF0IDIwOjU0ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFNhdCwgMjAyNS0wOS0yNyBhdCAxOTo1MyArMDIwMCwgUGhpbGlwcGUgR2VydW0gd3Jv
dGU6DQo+ID4gRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IHdy
aXRlczoNCj4gPiANCj4gPiA+IE9uIFRodSwgMjAyNS0wOS0yNSBhdCAxNDo0OSArMDIwMCwgSmFu
IEtpc3prYSB3cm90ZToNCj4gPiA+ID4gT24gMjUuMDkuMjUgMTQ6NDcsIEZsb3JpYW4gQmV6ZGVr
YSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIDIwMjUtMDktMjUgYXQgMTQ6NDAgKzAyMDAsIEph
biBLaXN6a2Egd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiAyMy4wOS4yNSAyMDo1MSwgUGhpbGlwcGUg
R2VydW0gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IHdyaXRlczoNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gRnJvbTogSmFu
IEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBOb3QgYWxsIGNhbGxlcnMgb2YgdGhpcyBmdW5jdGlvbiBkbyB0aGF0IHRoZW1z
ZWx2ZXMuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBB
cmUgd2UgMTAwJSBzdXJlIHRoYXQga3ZtX2FyY2hfdmNwdV9sb2FkX2ZwKCkgYW5kIGt2bV9hcmNo
X3ZjcHVfcHV0X2ZwKCkNCj4gPiA+ID4gPiA+ID4gd291bGQgbm90IGJlbmVmaXQgZnJvbSBkb2lu
ZyB0aGF0IHRoZW1zZWx2ZXMgcHJlY2lzZWx5LCB0byBjcmVhdGUgYW4NCj4gPiA+ID4gPiA+ID4g
YXRvbWljIHNlY3Rpb24gYXJvdW5kIHRoZWlyIGludGVybmFsIHN0YXRlIGNoYW5nZSBfYW5kXyB0
aGUgZnBzaW1kIGZsdXNoDQo+ID4gPiA+ID4gPiA+IG9wPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBJcyBrdm0gb24gYXJtNjQgb2ZmaWNpYWxseSBlbmFibGVkIGZvciBvb2IgKC1wcmVlbXB0
aW9uKSwgb3IgYXJlIHdlDQo+ID4gPiA+ID4gPiBwYXRjaGluZyBibGluZGx5IGhlcmU/IElmIG5v
IG9uZSB3YXMgbG9va2luZyBhdCBrdm0geWV0LCB0aGVuIHlvdSBtaWdodA0KPiA+ID4gPiA+ID4g
YmUgcmlnaHQuIElmIGl0IHdhcyByZXZpZXdlZCBhbHJlYWR5LCB0aGVuIHRoaXMgaGVyZSBpcyBq
dXN0IGNsZWFuaW5nIHVwLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdlIGhhdmUNCj4gPiA+ID4g
PiBodHRwczovL2dpdGxhYi5jb20vWGVub21haS9saW51eC1kb3ZldGFpbC8tL2NvbW1pdC8wMjhh
ZDNiMmMxOWNhOGEzNjU1NTc3ZmIzNGNhYzc5OTZmMTY2ZDJhDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gc2luY2UgNi4xNCAoQUZBSUNUKS4gQXQgdGhlIHRpbWUgb2Ygd3JpdGluZyB0aGlzIHdhcyB0
aGUgZmlyc3Qga2VybmVsDQo+ID4gPiA+ID4gcmVsZWFzZSB0aGF0IHVzZWQgaW4ta2VybmVsIEZQ
VS4gTWF5YmUgdGhhdCBjaGFuZ2VkICh0aGFua3MgdG8NCj4gPiA+ID4gPiBiYWNrcG9ydHMpPyBC
dHc6IFdoaWNoIHZlcnNpb24gYXJlIHdlIHRhbGtpbmcgYWJvdXQgcmlnaHQgbm93PyA2LjE/DQo+
ID4gPiA+ID4gNi4xMj8NCj4gPiA+ID4gDQo+ID4gPiA+IEFsbCBvZiB0aGVtLg0KPiA+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gSW4gY2FzZSBiYWNrcG9ydGluZyBpcyBjb25zaWRlcmVkOg0KPiA+ID4g
DQo+ID4gDQo+ID4gV2UgYWxyZWFkeSBoYXZlIDAyOGFkM2IyIGluIFtyZWJhc2UvXTYuMS55LWNp
cCwgSSdsbCBwaWNrIDk3Y2I2M2FmMDFkZQ0KPiA+IGFzIHdlbGwuDQo+ID4gDQo+ID4gPiBQbGVh
c2UgYWxzbyB0YWtlDQo+ID4gPiANCj4gPiA+IDk3Y2I2M2FmMDFkZSAoImFybTY0OiBmcHNpbWQ6
IGRvdmV0YWlsOiBBbGlnbiB3aXRoIHg4NiBpbXBsZW1lbnRhdGlvbiIpDQo+ID4gPiANCj4gPiA+
IGludG8gYWNjb3VudC4gSnVzdCBhICJjb3VwbGUgb2Ygd2Vla3MiIG9sZCBhbmQgYnJpbmdzIHNv
bWUNCj4gPiA+IG9wdGltaXphdGlvbnMuDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IFdlIGFs
c28gbmVlZCB0byBlbmFibGUgdGhlIG9vYiBwcmVlbXB0aW9uIHRlc3QgaW4gc3dpdGNodGVzdCwg
d2hpY2ggd2FzDQo+ID4gZGlzYWJsZWQgc28gZmFyIGR1ZSB0byBsYWNrIG9mIHN1cHBvcnQuIE5v
dyB0aGF0IDAyOGFkM2IyIGVuYWJsZXMgc2FmZQ0KPiA+IHByZWVtcHRpb24gb2Yga2VybmVsX25l
b25fYmVnaW4vZW5kIHNlY3Rpb25zIGJ5IG9vYiB0aHJlYWQsIHdlIHNob3VsZA0KPiA+IGFsbG93
IHRlc3RpbmcgdGhpcyBmZWF0dXJlIGluIHYzIGFzIHdlbGwgd2l0aCBzb21ldGhpbmcgYWxvbmcg
dGhlc2UNCj4gPiBsaW5lczoNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2NvYmFsdC9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3hlbm9tYWkvZnB0ZXN0LmggYi9rZXJuZWwvY29iYWx0L2Fy
Y2gvYXJtNjQvaW5jbHVkZS9hc20veGVub21haS9mcHRlc3QuaA0KPiA+IGluZGV4IDA5NThkNWUy
YS4uYjhjMGMzOWM1IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9jb2JhbHQvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS94ZW5vbWFpL2ZwdGVzdC5oDQo+ID4gKysrIGIva2VybmVsL2NvYmFsdC9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3hlbm9tYWkvZnB0ZXN0LmgNCj4gPiBAQCAtMTAsMTYgKzEwLDIw
IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL3hl
bm9tYWkvdWFwaS9mcHRlc3QuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9od2NhcC5oPg0KPiA+ICsj
aW5jbHVkZSA8YXNtL25lb24uaD4NCj4gPiAgDQo+ID4gICNkZWZpbmUgaGF2ZV9mcCAoRUxGX0hX
Q0FQICYgSFdDQVBfRlApDQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIGludCBmcF9saW51eF9i
ZWdpbih2b2lkKQ0KPiA+ICB7DQo+ID4gLQlyZXR1cm4gLUVOT1NZUzsNCj4gPiArCWtlcm5lbF9u
ZW9uX2JlZ2luKCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
IHN0YXRpYyBpbmxpbmUgdm9pZCBmcF9saW51eF9lbmQodm9pZCkNCj4gPiAgew0KPiA+ICsJa2Vy
bmVsX25lb25fZW5kKCk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGZw
X2RldGVjdCh2b2lkKQ0KPiA+IA0KPiA+IFRoaXMgd2FzIGp1c3QgZG9uZSBpbiB2NCBieSBbMV0s
IG5vIGlzc3VlIGRldGVjdGVkIGFmdGVyd2FyZHMgYnkgdGhlDQo+ID4gJ2hlY3RpYycgdGVzdCAo
c3dpdGNodGVzdCBlcXVpdmFsZW50KS4NCj4gPiANCj4gPiBbMV0gaHR0cHM6Ly9naXRsYWIuY29t
L1hlbm9tYWkveGVub21haTQvbGludXgtZXZsLy0vY29tbWl0LzAzOTZhNTJhOWIzZGMzNTJlZjEw
ZTZhOWQyZWQwOTY3MThlZjVkODANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLi4uDQo+
IA0KPiBJJ20gcXVpdGUgc3VyZSBJIGhhZCBzZW50IHRoYXQgdG8gdGhlIGxpc3QuIE1pZ2h0IGhh
dmUgZ290IGZvcmdvdHRlbiBvcg0KPiBpdCdzIGhpZGluZyBzdWNjZXNzZnVsbHkgaW4gbXkgeGVu
b21haSBxdWV1ZS4gSSB3aWxsIGNoZWNrIGFuZCB0YWtlDQo+IGNhcmUgb2YgdGhlIHRlc3QgZW5h
YmxlbWVudC4NCg0KSSBkaWQgc29tZSB0ZXN0cyB3aXRoIHRoYXQgaW4ta2VybmVsIEZQVSB1c2Fn
ZSBlbmFibGVkLiBNeSB0ZXN0cyB3ZXJlDQpiYXNlZCBvbiB4ZW5vbWFpL25leHQgd2l0aCBLZXJu
ZWxzIGRvd24gdG8gNS4xMC4NCg0KUmVzdWx0czoNCi0gNS4xMDogTWlzc2luZyBiYWNrcG9ydA0K
LSA1LjE1OiBNaXNzaW5nIGJhY2twb3J0DQotIDYuMSA6IEhhcyB0aGUgYmFja3BvcnQgYnV0IHRo
YXQgbG9va3Mgc2xpZ2h0bHkgZGlmZmVyZW50IGNvbXBhcmVkIHRvDQogICAgICAgIDYuMTIuIEF0
IGxlYXN0IHRoZSBmb2xsb3dpbmcgaXMgbmVlZGVkIHRvIGdldCB0aGUga2VybmVsIGludG8NCiAg
ICAgICAgYSAic3RhYmxlIiBzdGF0ZSwgYnV0IHN0aWxsIG5vIHRlc3Qgc3VjY2VzczoNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5jIGIvYXJjaC9hcm02NC9rZXJuZWwv
ZnBzaW1kLmMNCmluZGV4IDdlZTgyM2E2YTVlNDUuLmJlM2QzNzU1NGRlMGYgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYw0KKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvZnBz
aW1kLmMNCkBAIC0yMjE2LDYgKzIyMTYsNyBAQCB2b2lkIGZwc2ltZF9zdXNwZW5kX2luYmFuZCh2
b2lkKQ0KIAkgKi8NCiAJaWYgKF9fdGhpc19jcHVfcmVhZChmcHNpbWRfY29udGV4dF9idXN5KSkg
ew0KIAkJZnBzaW1kX3NhdmVfc3RhdGUoa2ZwdSk7DQorCQlfX3B1dF9jcHVfZnBzaW1kX2NvbnRl
eHQoKTsNCiAJCXNldF90aHJlYWRfZmxhZyhUSUZfS0VSTkVMX0ZQX1BSRUVNUFRFRCk7DQogCX0N
CiB9DQpAQCAtMjIyNCw4ICsyMjI1LDExIEBAIHZvaWQgZnBzaW1kX3Jlc3VtZV9pbmJhbmQodm9p
ZCkNCiB7DQogCXN0cnVjdCB1c2VyX2Zwc2ltZF9zdGF0ZSAqa2ZwdSA9DQp0aGlzX2NwdV9wdHIo
JmluX2tlcm5lbF9mcHN0YXRlKTsNCiANCi0JaWYgKHRlc3RfYW5kX2NsZWFyX3RocmVhZF9mbGFn
KFRJRl9LRVJORUxfRlBfUFJFRU1QVEVEKSkNCisJaWYgKHRlc3RfYW5kX2NsZWFyX3RocmVhZF9m
bGFnKFRJRl9LRVJORUxfRlBfUFJFRU1QVEVEKSkgew0KIAkJZnBzaW1kX2xvYWRfc3RhdGUoa2Zw
dSk7DQorCQlfX2dldF9jcHVfZnBzaW1kX2NvbnRleHQoKTsNCisJfQ0KKw0KIH0NCiANCiAjZW5k
aWYNCg0KLSA2LjEyIGFuZCBuZXdlcjogT0sNCg0KDQpCdHc6IEknbSBvbiB2YWNhdGlvbiBmb3Ig
fjIgd2Vla3Mgbm93LiBTbyBwbGVhc2UgZG9uJ3QgZXhwZWN0IGFueQ0KcHJvZ3Jlc3Mgb24gdGhh
dCB0b3BpYyA7LSkNCg0KRmxvcmlhbg0K
