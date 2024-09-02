Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10313D503
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272813; cv=fail; b=f2hypv1vVdY9aII4uOY/u9Ynq1xDwUZARMERx1lOsDITEjhA2oRbJWQZRiLjYSYT9wyqwmQqeUV/UuOGkU+FjC627v0tw+rhgviSyGCME0qmt2KDqjQUc1Up1j1sJ8/4f86vxAM02e3keRADh0w1XTcKZ+2OZXA3XroDkue1jvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272813; c=relaxed/simple;
	bh=GxQ5eKc4BAhSatYHskzl4VR6GWF7WyKb4L2PyxMNoT0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaFOPxc+fxlBr8c+J72vpKnoKIWKLplQG9S3dgd9DDlPQH4mpAUA2fLJF0ajZC2KcjB+ob/u2knRSo53Vbv29/oT0Kv7LuvD7bz3WyNDcjLjylWfj3ojVORHYdSrHda2byvGZ3v65yabAkGdfLnOo52H+ntPgJi03wuL2speZgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JJZEnpyA; arc=fail smtp.client-ip=40.107.103.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JJZEnpyA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL0LijvSocvwO5zA8OTm0fc9mILA93IEjAz9IP18+CPi0q6+7Hco5ZB9OaVWLCmr6uJT5LlMZLO/7FOJsw3tiy4eZ0O0QFBrODJqtdan1XX7Q+shr3sVQ+czF5NWlXh7PaxigbxM+sLNS9G8PtnhrkrDvqLs6huHQSLdXMqePZDjLbYcBOaN4ET6OZEeyXTF3xkvxPg1zsSNZAO/7OnTax6TNsGZQ+RWbrFbfwovnxgS/kT1dtevkzM4wra+0I5DgnbeL1hRfIa095uL3jWEI5aIDoOEZgVWcojr0MBYPDvEfwNcf6/Dl9cggvrUVf5i8SrwiKx5VnpTTGVQJJKJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGNYSacOZXd+L2j2fFvpl4mQ376Y13iSGCxbYm3C/uA=;
 b=VZv1NdS70ROFLZHPgstJ4N5j1hew34t7wdjo63iVG3lCGNGMgXlHtpCpC+C8fyIBtROYuyWvBwqc+ZJVn3I2VScRwVVSkLJ/rp6nKaVsLvaJ6VtMtyF7asf+Qz8M7Igwuue0FjY0EQsllCXUT2eXWRo/LOI/M9tl3gY9RBf1WNizg2A6UpHvhqyVllY1UKMofd7q6Iu+qmfmR9pAxxQm53hAhAWNreotwaY5D4pwrXKbCyLX7QVzzuJscCbjEf71gz/lvkYvGTc4/PprlJZcNDd4aIwmU7MT3Au+kS/OM8DuIZBvlqklLDhlHE26/lxAV2Gx0/db7G26WDwzhOniHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGNYSacOZXd+L2j2fFvpl4mQ376Y13iSGCxbYm3C/uA=;
 b=JJZEnpyAlM+/xwHCT7si7bbm9BCnLTTsYBAwR5/tIkKH8+dNE5woN6TtA0Sgb+7mz4xVxEgG86or0BmO37+rDS5uH9c+hf+iRV/JuUxVwaKHe8ja36tPrin9GhmVPbrYTvQabqb9bCcPU3Q4YTC1xfdBKiHn+lK4FqxVsKWipXkw3aicop3O2GEZY2+VEg8xMnvA2VqMEg5NQ7fCKh+oBXAIaTuBLO4asds+AYC6onK9/tDgVZi7Gsmewme7dEEquGiWr01IQDBmKEyuelT+7/Iq3I6Zgr/fBqbJUHTKfdtGIz16VvLxPaNW9TjSV8Zm4OFf7K5xeH8mkPwB77PD6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:26:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:26:47 +0000
Message-ID: <f3493320-9f77-456c-9c57-1b35492ecac6@siemens.com>
Date: Mon, 2 Sep 2024 12:26:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>, Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
 <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
 <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
 <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
 <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:610:e5::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 809c5e29-0e12-4c50-2772-08dccb39bfcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW1FNlVQZHlqOEJDeWhnRldLc29nbGtwZDkrei9Ca1MzcCt5aTdlKzdEekdm?=
 =?utf-8?B?eEpZRk9CTnNCRTkvaFRkbmp5ZDF3VUxGdXRwYmNEb3grNmUvV2RKOUJTMGN4?=
 =?utf-8?B?eWVpdytJZnMyR1F4anA5RmcwRUl0ZzRINFBkUmo4NmZzNy85eUhRL1l2YmUw?=
 =?utf-8?B?QlNCd3BpMmIzRnhBYVN5RkN4NFZyR2JQWS9DVFNGZzJkR2w3Ui81U1NQbzJ4?=
 =?utf-8?B?Z042UlRQUCsrY0xkeDNPYnI2c0dUMkUxdnNERG9IVWdRODlmb0xrWW9razNJ?=
 =?utf-8?B?NDZLelA5Q3IzeUJ1YmFHaXZqYjYydHhqODRLZDhWMmREMWNrQm9Eb0JTNnEy?=
 =?utf-8?B?SG1JcS9yVzhvQTMwcFZrOHk1Q0RjVEhWcEJ4cXkyZGVoMDBJUlhoZ3B1Yy96?=
 =?utf-8?B?TUNobmFzbkluZU0rcEJVU1B1cmptTnZ1QmZZR1NXaDZQbHlzbW5vTmNQRHhp?=
 =?utf-8?B?d0lBbXozd3NYQkFKTllKSDhpSGcrcEJTTHNzNHN1UmFJdG9DaGdqOFR5Q1ky?=
 =?utf-8?B?YVJscUZZN1FjdEV6REtucGlXOGdmZE1zOXBnWUJTZVREdi9JTGVLZWNDQUQx?=
 =?utf-8?B?dkp2VzhjTFVyK0VpSmtrNTIxZFd4bDBZeDYweHdKcVRISzRZbHlQVXNzaFhD?=
 =?utf-8?B?U1ZLa1B4WitrR1UrRmVsT2dLUUxJdnljQng1cFVEdFJwMEMrb0ppbjVrQlVr?=
 =?utf-8?B?ZTQxbDU1aXc4cG9aTXJmY1pzcU9MdTBtbURGRzhGTytUYk9acmdXZEcvTVlY?=
 =?utf-8?B?bmJSdVpYQTJIYnBZRzBhS0RxSmFRbUJFVW00RC94YzFmQzg5S3IxSnRrZ3ND?=
 =?utf-8?B?dnRid3BMVUlaUXZFai9Vb1ppZDhOMTJCWmU0d2RzZ0dCVnhXblUycTBIdDgy?=
 =?utf-8?B?Tmp3SjNGQkpTM0ZhbkRyWGkxSk9jbnR0azFORElOWVhOMWVJcTVzeGFwaTFU?=
 =?utf-8?B?SU9QZk1hLzYrM0JLV3dVcVc3Y2RoTHc5aEcvdUVsNzF6d21qUU9vemt4S3Z6?=
 =?utf-8?B?YnRId3FibkhFMFk0UngzakhWVEdHYUxIV2lObHpUdFRNTitxeDVqT2wvYUlV?=
 =?utf-8?B?SzIvTkQ3ZklKZjZCWFVlWUhzOFdBT2FKMHNCV1hyTXRxandSTmowUEp2aWg1?=
 =?utf-8?B?U05UWWxLOEIzWEFyQVkyQitwMGRzZGd5SmN0STNtWjYrWmE1R200THpXRURw?=
 =?utf-8?B?Z1NPR3hEYjZGd2tHWmx5anJDNHp6Zktzb1BrbmlUK2FTVjB3Qnk5ZnZBSFFI?=
 =?utf-8?B?SVdWd1V0MytnckwzT2lJSUh3eEhpVEZ3NUtHdmxMSU1EUHJoSnBnY2NLRmU0?=
 =?utf-8?B?WGxFekZsOFpISndYenR2a0pBNjVyV2pINVdURG5HZWd1b1UxKzRKRTl3TlpS?=
 =?utf-8?B?bGlLRTgzVHF1Z2U4b0J2MkhGNFp3NEFxMTljYkV1eG50Y2NOMGwrTGF2N01X?=
 =?utf-8?B?b1M4aDl4alBlZGNVbjlaRjkyTWphK0F2WVVjUDJlTjY2WHdqQ082WjA2V2lT?=
 =?utf-8?B?WWVSamVQOG5QcVUyRzVHVzNNT1IrTS9BMzVvTVl4V2RvTmxpV2ZoL2F4dUZJ?=
 =?utf-8?B?c0ltNFdqc3ppZEl6eEplS0RsbDJMVFpRL1cvUEhXSndzV3N5Qzd6SEJVZXI5?=
 =?utf-8?B?aXhuay9PRmRERVl3Y1dtOVNWVTZGdkZpQll4Q1pKM1hBb3QvK3ZWSnZ1SmFr?=
 =?utf-8?B?WmZ6NG5jZWdORVFxTllCV0FnVlJ4SFNtaW4rbHFkbmtuOXdXNmwxNmVQSUl2?=
 =?utf-8?B?MytCWm44TmZma3dzUm9WOStuTFErRFpkRmU3OTQ4TU5nU2dNUFNQbzYxVEpI?=
 =?utf-8?B?UHNCYmJ1QVR0M3ptRXY0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1hWZE9KZTZWUWU3NGlmMFRISldpeW9yZkw4TE52UFNTeDNxY05HTVJibTRs?=
 =?utf-8?B?eUZGY2FKRldJQmdEOFMrUkozTm9Qc1Y4aFl0ajlVYzk5VGZiTzdxMDRoRVN5?=
 =?utf-8?B?OEhVS0xRRXZ0cWNrY293YkVINlhsMDFUcDBHNG5DR013aGNTQ0xiS2hMTXI1?=
 =?utf-8?B?aDhDMmtGNjJabW5LZDg1ZEJjUWhRL0FFWHBQSzBzSmpQcEhrNm5YV0pIOS9Q?=
 =?utf-8?B?Tnh0WVJYUVVhWERIblMxS3d5QU4xYWtjdUVVb1dOK3FldzBmQnlXMUo3eUp3?=
 =?utf-8?B?bW1VUTN3V2YxdUo1Zk5JdTlkbVAyeWQ4bDFCWFZjQzcyM3YzTm1CY3M5VHdp?=
 =?utf-8?B?SWJvSW5aR2YzWi9YelpkN0s0L3l5d1hmbFZ0Y3NSVk43NEpUZXYzVzlwODhI?=
 =?utf-8?B?T2lpN2FMVlo1ZFYvS3hacFZtZnVGd0lYQUZUcEx4dDRUamtsbml5dHoxbklL?=
 =?utf-8?B?eG9icXE0NE5uQ2d2LzBmZzc2cW51MURhMVJaSTNEWlhJbkdQZHYvTE1tdkxl?=
 =?utf-8?B?MnVJc25COFNCdGl5ejVMS1ZiUENaa2FHQlA2V2J3eVpQTlAyVUdvN3JNTmxR?=
 =?utf-8?B?OWZuaDF3dlBFamt3MVhvZ0N3dlpMWHJrOU9RckQxZFZRQWp5LzVKMmp1bXJm?=
 =?utf-8?B?cGxFMEpvK1ZYKzRzdkQzMjliY3Q0dDRDcFVLS09HYXVOMVlyb2xjMy9VcjZ4?=
 =?utf-8?B?Z3NKYW56Mm1iY1dBZ0xRMVdoRklNTzhNNW1nK1NPWjhPRzBPRS9OdWU5dzZ2?=
 =?utf-8?B?bTNDbzNqZE1mYUpPblZMNzF4YWlQamhjamVUQ1NNTzc3K0VGVmxOZ2JhRU9G?=
 =?utf-8?B?ck5ZZXNGK0tpNSsrZnJ4cGNaTHhzVUNnYk1PWkpjOFNOK0JpMS9OZmRKM3Nu?=
 =?utf-8?B?aE8yYy83ZnBvZXh4K1R0aitkaWQrNjBqTFVTemxOUUlDSmk1VlJxM0VyUXky?=
 =?utf-8?B?QXNKVkFNT2Z6enNxcDRad3F5NVgxU0gvYi9tMjhaVkhBRHZBR253b1hpNmV2?=
 =?utf-8?B?ODJ2amRza2dXNHVqTjFQLzlyelAxZFcxWTY3TVRIeHdMT2Q0YUY2U2xZYlRo?=
 =?utf-8?B?Zk10QndhUCtkZnVEUWxkQ21OaitHUHRSbERCQ3Awbkg0S0p5VnBuV3pJSE85?=
 =?utf-8?B?NUZaR1pTbjc1THpXUS96NDhmcFlPM3ZnMjZmd0c0eFlrLzR0YjE1SHZtZTVn?=
 =?utf-8?B?T1JQc3Y2emN1R0Nyb3FFVWNvdThWVk1KRWxwQVRpT2JnbE4rTjA1ejZneHpD?=
 =?utf-8?B?WDdJcHEzZG1RR0sxWWZrRjhiM0JTV2VIS1J3SzQ0R3RUS3laa1VObGtJWFBx?=
 =?utf-8?B?YTBjemRQYndzajEwTzZyeHJOTmJzUnR0L0ZVbTVzNUVacGJsYVo4MDZEV0ZQ?=
 =?utf-8?B?NkxQMEpQUmkrVzNFa1Zyc1FWTkFCTjNmRG42UCtrVUprajBJWlN4ZHpEcmQr?=
 =?utf-8?B?MVV6dkNjdWhQSCtlUUppVjFrZjMzTFVLQ0ZOMzRLZEVEUGVMUTBwR2tpWGJj?=
 =?utf-8?B?VXphVytRUk5icktzd0JtWmJ2TUp2cWdDQUdPSnZ0WFpHVVNWL3k5SG5zZks2?=
 =?utf-8?B?WFoxdlZRdStpRmN4bEFDQ1BEM0MrcE10V01iN05iVGEzSm5PcFJEaURHcHA2?=
 =?utf-8?B?RDFuSk1vMGp2MUJkN2xFdUpqamZRQzF0Q0hkdlZKVmZnVktVK01sR1RoclpM?=
 =?utf-8?B?NEZmdkN6dEZFTjFpQnFaSG9qb3M2bEJTMmpONEk2YVN4R3dRL0V6ZFllUjVG?=
 =?utf-8?B?TVpIbE9PT2xwOExsdVI2dFovajJSbW15ak5zOUJUb28wbGlTaUlTMWsyakFF?=
 =?utf-8?B?K3hSeHRYanhGZHhMZDdEYzJoTGRvRXhLWGY2T2dnY3dacFJuenl5K0xSMmZn?=
 =?utf-8?B?WTZteUhGUyszdnVrU1RQYUkySmdaNWRoeG00T21qa1FYR1hLSEw3K2hIV3U2?=
 =?utf-8?B?UHF6UnNuUW5abGwxbEF1anZqb3p5aFhES1hlWXhsaGlmVzkwSm92RmlKVHg0?=
 =?utf-8?B?L1BIN1Q4K2hsZ1p1S2d0ME1lOHZ0YXRhaTUxeEhjWGJsa0Fjam10VzRWNnJl?=
 =?utf-8?B?alFkWnRCcWlyaVhkVEFYMjVYdXZrRE1keG5leFcxanZoMjJvRlMxOHI4OVN2?=
 =?utf-8?Q?D6ZyubgBEnF5zbZz85i+uHtug?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809c5e29-0e12-4c50-2772-08dccb39bfcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:26:47.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5vBb3xOg2cvWUlirTZ1vBCV9v0jloS1U7x2A6H80pajY3TBNM2BgwLfSYcTaq3jKa2yTfQ7Jtt0vieoVz4BBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8559

On 02.09.24 09:08, Mauro S. wrote:
> On 30/08/24 14:00, Jan Kiszka wrote:
>> On 28.08.24 16:32, Mauro S. wrote:
>>> On 28/08/24 15:40, Jan Kiszka wrote:
>>>> On 28.08.24 15:05, Mauro S. wrote:
>>>>> Hi,
>>>>>
>>>>> I'm back after doing more tests also on real hardware.
>>>>>
>>>>> Here is a summary:
>>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell
>>>>> (GCC 9.5.0)
>>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4,
>>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>>
>>>>> I confirm that the problem shows only with my own kernel + rootfs,
>>>>> both
>>>>> on QEMU and on real hardware.
>>>>> Other combinations:
>>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>>> - my kernel + xenomai-image rootfs
>>>>> don't show the problem, both on QEMU and on real hardware.
>>>>>
>>>>> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
>>>>> version and using my defconfig: the kernel became identical to mine,
>>>>> then I expected to see the problem using this kernel with my
>>>>> rootfs. But
>>>>> -surprise- the problem does NOT show.
>>>>>
>>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>>> Then, could really the problem be triggered by the GCC compiler
>>>>> version
>>>>> used to build the kernel OR the rootfs?
>>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>>> problem, then seems that the problem shows only when using GCC
>>>>> 9.5.0 on
>>>>> both sides.
>>>>>
>>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>>
>>>>
>>>> One option. Did you already try switching to a different, likely newer
>>>> toolchain while keeping the rest?
>>>>
>>>
>>> No, for the moment: I should port the whole custom meta layer (that
>>> contains kernel and xenomai recipes) to a recent Yocto version. This
>>> means that also other userspace components will change: would that
>>> influence our testing?
>>>
>>>> But it could also be that the compiler brings in some noise to a rather
>>>> narrow race window, widening it so that it becomes much more likely to
>>>> be hit.
>>>>
>>>>> I can share with you my rootfs and my kernel and the QEMU startup
>>>>> args,
>>>>> or other things that could help you, and I'm open to suggestions about
>>>>> other tests to do.
>>>>
>>>> Problem may be that we will have to be able to reproduce variations of
>>>> both in order to try out instrumentations.
>>>
>>> Right, I overlooked this aspect.
>>>
>>>>
>>>> I'm also still puzzled that it takes both your self-built kernel and
>>>> userland to trigger the issue. We only have similar but not identical
>>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is worth to
>>>> compare the disassembly of lib/cobalt/internal.o...
>>>
>>> Yes, this really puzzles me too.
>>> Attached the disassembly (obtained with objdump -dSlf) of the two
>>> libcobalt.so.2.0.0, with the two libraries too.
>>>
>>
>> There seems to be a difference between the two toolchains in the
>> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
>> include/xeno_config.h?
>>
> 
> Yes sure.
> 
> GCC 9.5.0:
> #define CONFIG_XENO_TLS_MODEL "initial-exec"
> 
> GCC 12.2.0:
> #define CONFIG_XENO_TLS_MODEL "global-dynamic"
> (I got this from build/tmp/schroot-overlay/isar-builder-.... in
> xenomai-images build)
> 
> For completeness of information, in my Xenomai recipe I have the
> following configuration flags
> 
>   --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols
> 

OK, and does the issue disappear with your setup when you add
--enable-dlopen-libs?

But it still did no make it appear on my setup when I removed it. We
might be unlucky that there are multiple parameters with the right value
needed.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

