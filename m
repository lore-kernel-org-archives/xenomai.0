Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012032.outbound.protection.outlook.com [52.101.71.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EE14286
	for <xenomai@lists.linux.dev>; Sun, 20 Apr 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185609; cv=fail; b=i7RNERmZLW5opIjyltKj0BsQBiP1tU5SZ/e75JMGAvQ/RqIKFC46tf006ScDJMIkom3zvwa3k4jFyOZ7DB0/fQm46MYfDGp/0JMF7IwnCgQQO8iFoN8XUm+UU3I8A9e5BgcGFoOe9DlRaZ+jGg5MADGi6EPzu4uQAJL/69UvDz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185609; c=relaxed/simple;
	bh=ot3Rb3B2JynYOjWRqqIpiOe7bLeC7LW+5ihCaT3Yn38=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=n5lUnvnqNtBjYZ+gPuP335YpX5FnuV6sQmXODA4OD2DNYzA0lV/B0zAmoa70Y4BnAJBARY0/SqSbEIRppGJfT9aZUum4djhxv47iOe7KP8pTb0C7Fv1aZyyZDUJtp7lbg8UpUCuZ1/HkgrJyxy2kHQHMNhzP/xvl+b3EgAIigbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RSSkmJ6/; arc=fail smtp.client-ip=52.101.71.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RSSkmJ6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KadH6RmBVPVx34mG3bMyZUzap7PiQ4LTHSphkFUOlYOlB8KZBDMNE3jwtpbHTDie8XdLcuRGGrRJerA56kYrKrVh8I1xEfwTq7Miw8tBlFjlKeawkSyya8fQZgwQCu3t8UZWid2mANJDW45uC2sbmh3ag2H6jWSCqKDdpk8ZhuUH31zNUNeo0GWBkILlTRVuBnj12Yfped56wtp51en3QQ5Epy3BG8MnHQmXCmbewmPUdJGs/JVfCaYeXKZ0oogq78sI/WC9xIBifJ8TtxdtbgPtIY624kI6M7FpCumAc4+PszrqCch27BwJ1cYG1nAib5FjX63IsmAdkFepOzt2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlXevhDOVtK2rorMKccZcEqq+M9ux/YDdMXuzsaCJA8=;
 b=U/h8QLj0c6dBlouKy1hZm3f8hR5SX7Ls4wgNFoF3qPrCGW2TmqEvB2KlVk7N7bg9JnXAQOTDNN1msrGHG211Ab5VwmXxNrEoxbCE8UKEpD0jew8XzZDg2EcIwFQjumY3lrPUjF8COyjC20bD93dsSwlaAVbI0F5INwdcqaf5mncLJ8KXzHEHOGYcMaYXMDbRWfYjM3SbKqxSLhjmEAfx1sIFNy4Ww29qTvlPxGyDTs1BCt2AFxnmUdP4a0WV+Vmp9O7VQudrERsqQRPumOgI5SDGJzmIbBUUslIOak0A2CKufLm/V5aNpZkH78gDH5imeKDCaQh/W3dfd0Uw6jqvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlXevhDOVtK2rorMKccZcEqq+M9ux/YDdMXuzsaCJA8=;
 b=RSSkmJ6/HWy2ukJeZbK+dZDriWC21ove+RCkiHgguhMpLDdT0SyCXDZqSnwHHd7BZgy609ZjfbI0wQ0akDv8118S3F+rvB04Pk79yHLmd18eyCSCyKwCoBLgJIMbxCKKgu1N0nExZZg8/5SrJ+GYyTfZ/ZurnF2loiZDUAC+mA76EZtNgxcx10UDSXqEm9kqC13h/O2pxpDvW/OlUxGupWkCYHTD9vSpmz1TpQ8xyxX9aV9uTH9j2HN0J0QRwPW+kEmYSyZE9I5aCzW73bNqfcWQgvJzQqCOk9ylvnuOfN87+3O6XAOYVsAtgrnbfFcd4maXJyQuoNZFvHfHH98Bpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAXPR10MB5735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Sun, 20 Apr
 2025 21:46:43 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%5]) with mapi id 15.20.8655.030; Sun, 20 Apr 2025
 21:46:43 +0000
Content-Type: multipart/mixed; boundary="------------0Gv2i6OGM42AKggD7E1qihgs"
Message-ID: <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
Date: Sun, 20 Apr 2025 23:46:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Build error of kernel/xenomai/debug.c
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Pirou, Florent" <florent.pirou@intel.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|PAXPR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a3c95a-680f-45e4-18b7-08dd8054d728
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|4013099003|4053099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGVkNUdTeHN1VDhoY3JqWGhUWDd6Ylc0RWphL2I0YWJSQnJDeDM2dFZYTUhm?=
 =?utf-8?B?R05JUXdBT1U3NnFhVmlpRUgzZHJVT3lxZ1U3OTJzR1p4dHpvcExVd3FCQXdL?=
 =?utf-8?B?RXFTR21zTEI3VUhQTjhpRXJoQ1VGdDQvWW1wUHQ2U3lpejNod240NndVZy9i?=
 =?utf-8?B?OGxFUzJCVTdPcUdmb25nMXNLZUswaXU2bjc0S3lJNFVQdmdySkZzRXJxSzla?=
 =?utf-8?B?TWtLQmVRR293M1FXSUcwekJmcjROdWhMRUp2V2lDMEZuZGFnZ0RXRTFjTjZC?=
 =?utf-8?B?dVFHcmNZbTJyQW1CdlM2cW9VNjZsTEEydVNVbHhaeWl5TUw2VXFZMWl6MHJN?=
 =?utf-8?B?L0JQa2tJOElwOVBLMjFkYS9XWGo1WFRJTURVdjhzQmgxMk5hdHR6ZlRMcElU?=
 =?utf-8?B?bjdTbTFDekJsVG5qWHBaQlhnbm1oYXNsc1hXQS9MR2lFQkxVMzJ1WWtacGp6?=
 =?utf-8?B?S081UEQxUzhCM0IvVjN2NE1kaEcxMFBxbERGTDBlNk8vejhJMVp2dGtTN0Vn?=
 =?utf-8?B?cm8zSUptS3RpUy96WEFKaFoxbmtFNC90NWFyTjdtNXoxTDFNd0FpdU1va3hm?=
 =?utf-8?B?aGZPMEh1bHhGeWJGaDR0Y0FKbnNSbkpBVFM2WmpyRmd5Z2k1VkRNWVprakEz?=
 =?utf-8?B?Q3dVNHJxTVFxU2pvT3BsakgvclNwcjZ4QjdGTnJ1dk9PREVvSC8xdkF5d0w5?=
 =?utf-8?B?U2ZqY2U2THd1VjVwK2MvQ0VyNWd2NGl4dkJKNktHRkxOY01IcXBJeTZDazEz?=
 =?utf-8?B?eDJCVzliMGVqU3hla2NaaWEzRk80UmVsNFM0MlRRSFVsdUJOb0JVMThKSmI1?=
 =?utf-8?B?bXNIdEs5YlgxWVVXaWFXZEJGSm5mRDFzRnNuZ2VXNFRYdnJGTy9uZ0JsbFBD?=
 =?utf-8?B?czQ5UzhRbVV0d2o2aitmVFBNdTJTV2YrdTFTMXBBakErNkJoU1BnVDdPQkgv?=
 =?utf-8?B?d2ZqV2N0S3dtamQyWnc4c2dmWU9ZU0tLZll4NC9TK2ZjWWRva2g3YWc5ZmJq?=
 =?utf-8?B?SHFhdU1lb3g4eTE2dUlYOU44UDkyOFFCT0g4T3h5aDRPRjhXcHBIb1pUVVgy?=
 =?utf-8?B?ZHAyWE8wNVdndkNrYXFJeFdkei9KWkswWkpxUDdqMzQ3NW5TL2ttTFc4SGlR?=
 =?utf-8?B?b3RFRkZaUVVORFZlYUpKejdCZk1HQ1dlZHZQSW9RWmZwVmNCODNvSlZ1OUlY?=
 =?utf-8?B?TXhOZ3FFUTBYZ1REdlN2UGNPRzEyNWZtd1VHQUM5TnRocGFPUndlT3ZoT2hu?=
 =?utf-8?B?ZUZWdC9pTE8wSWxOZkp5dWN6bVhiTC82RjhtdndMN0tKV0tCdWp4Qk9yK25V?=
 =?utf-8?B?MlhuNWxOWlV2TVlEMjdCNnZCSkdCRThXMDJGYkJoMzZzQlhtNGxyTmdURlU2?=
 =?utf-8?B?a1JscUVUa1VKNWR4cklwaVlmYmp2YXN2SlBPdmtsekwwakhsSWxPOGI1ZXlx?=
 =?utf-8?B?ekhYMW5qb20rckdWRmZ5MXFBbUxON2xMN2xlK0crWWFhbFlxUS9iekRqakw4?=
 =?utf-8?B?dHI5S2N3eGc0YmZoempqbjZnS3lWMXBua3VuRmdVZlhNK0YvRlkyWDhpWWtK?=
 =?utf-8?B?TlFoZEV1MW43V3hqSENwYkpyQUl4MFNVVFptMHExb0pRU0UydFhPUmI4S21X?=
 =?utf-8?B?SmtVbFI4VGg1RnV4ZEFnNlpxWjZwdC9PRXQxV1Jwd0pGK21ZM3o1ZSswV1Qw?=
 =?utf-8?B?YlZGMndmbklnRFBMUnhuTHJaVmtYSU80UmtVZzVTelVCWG9PbWZOb3JGcjVP?=
 =?utf-8?B?NjVuYWN2bDlLVjJxK2tDb2ZJTW4wVEJKalA5SlJUSHZWQXZmS29IRS8zdGhK?=
 =?utf-8?B?NGRWUlJ5RitkRjBXaFhiREpaclNNaXh6UW5PcWxDR2NtU0ZPV2cyRHVwNjNu?=
 =?utf-8?B?VENBTlBVa2tCcVE1c1VRV3RLamczZ1J3a0RlTmdEaVd5cWlRK2VnWnlBaVIv?=
 =?utf-8?Q?uly/A7gZau8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(4013099003)(4053099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0YrKzJYeEJVZElXZitpd20vYTJkN29rb3c5c095eXF2bWhlUmowRElmandC?=
 =?utf-8?B?S1BOeFQ4Z2VmRS9HOUloU3cveE9RT21DdjN0cyt0NjUzNGdjWEFKQzVLWjZx?=
 =?utf-8?B?OTJWL2t5aGpJN21OU3JlZ25rNFloVjNua3U3aGNDQUt6ZlppRnVVN1VHMEVC?=
 =?utf-8?B?aUZ2ZmwyZHJkaE9rcDEvYUk2SGEvS0JZSzdmNkV6TURTZEJiSCtqNVNGOFB0?=
 =?utf-8?B?WThaS3JVUzZBbzh6QzJqc1VaTkx2QUlrT3Z2eFlWRVBBOUk0bTZNZElPcmhF?=
 =?utf-8?B?UXoyRkNCS215SUxENzNXUjZoVldUSnhqYVBzS0dDZWo3bHgxVm5sY1dsTXBX?=
 =?utf-8?B?NE8xZWtLbVk4K1NQMzE1enorbTMveGxkYjhLeXRQU291U3p1dlRCcFZPUlZ6?=
 =?utf-8?B?UFltNjlpODI5MStBWFpmamsyaEpMOU00Q2NMVzVNL1J4TENlK0s5ME9vcjJi?=
 =?utf-8?B?M3NNeDVqSDB5TjZzVnREM0IrREZQWU16MEozSUVZcmp5NGgzR0pMeEI5MDg2?=
 =?utf-8?B?a0FlYXBueHl3cUVsM2ZjYlRZNyt3K1BWWlJrY3Bqck9Td2txRjZrQ0NQRmw5?=
 =?utf-8?B?K3BMc1hNL2FaMUkwOHBIUkRqcW9MNEYyMFE1ZW9PWEliVUZFVEVZTTdqcXk3?=
 =?utf-8?B?amdITjFrdGF3ZVlWT2hVUzJpWHVGNmRoMys0NlBLanFhdU5iSXJzYXEyTklL?=
 =?utf-8?B?eHdpZjJKd0tMSlpSQXdyM0JoS0RjVWpwaTdYZHhhQ0w5bTUwUkV6aEdPbkNm?=
 =?utf-8?B?b1k1a08wYXVSTHhzT3VwUFZOSFlnK1o2Y1pKbXBuK3pVSWNxZ3oxMUp4U3ZT?=
 =?utf-8?B?NWFmMzR2R1lZUHN5cTcyNkdQV2VnQ3VNWEQ0TW44cjRVdVFrN1dEZTJpYU9i?=
 =?utf-8?B?SmEyaW9BbG5MRHFJbkRUbm4wZllNMXhEV2IrN2ljU09kZ1piOGl2MytCWFJt?=
 =?utf-8?B?L1RxUEcwWVpSbEdFMkg3TWlBaXNlelhiWmh1aEx3YXVlRXhxNmpJakJxdXdh?=
 =?utf-8?B?QWhrTmpUOFFqaE9ZWWRRQlZoQ1E0dFRsTlNMeGNhazd1TVd0NUVKaEpGY2ZP?=
 =?utf-8?B?MWdsK2VERmx4MW16SXB5U0lBWDVmOHcwd25Hc0Q3Y3lYSDljdWVtZHFIcUNY?=
 =?utf-8?B?QndsZGRVK3VOVjFDSDJkb2ZMdG5pc3VoWktiMTFWL1BLMzMvbTV4T3ZDbEFO?=
 =?utf-8?B?TEZEVmx6SmpQMjB5aFpXVWRVNnFoT0ZzZmd1bEhKN3RMSEh4YjFNaDQ2SmVL?=
 =?utf-8?B?empNRGhKTFdrbjVlVzhzcW1rUFdmOGhTQ1dJSzRNZjcxYXZINHp6RHFoTVM5?=
 =?utf-8?B?a1VKc3dJczIvNGZVM1pjTEpjejVrWkExNTNwYmFhenRWN29QbkJ4OXlLdDFO?=
 =?utf-8?B?L200QU1ramZ5TzY0czFkeW9yMTJ0NHVpUFB4RERyOVVWK09UdEtGUFZYRWRp?=
 =?utf-8?B?UmprTDVOR1JPUndqMjExS0xDaEZkQWpWUEZtM3pJWDVPUXk0aGR6YlBxT01K?=
 =?utf-8?B?NzF1YVYxL2daRURYTnhZczBla3dTeUVwL1loOUFIMms0dDJYanNwY1dzcHBh?=
 =?utf-8?B?a29HMUI5M1NRY29Qb1VQTkY0MTduTjlIN3dRd3hVWUxIVXJlakp0VFlTUVNT?=
 =?utf-8?B?YldwaFpmNUhTYjEvdFpyR0ZvMS9QSkhSRkd4OTBjUHN0K0NlY1FEUFlBOHhk?=
 =?utf-8?B?NXJ1QVZ5Ri85S1FsaVpPa1JlWnZENnlSOThJVjNzblY0bDlmR0hkclRmRGdZ?=
 =?utf-8?B?bE9FV1FSOGVXNlNTQ3pjY1hvRTB2ZGp1Y1dldmRQR2xTZm1aUmlKZzVIOGU4?=
 =?utf-8?B?aWVxaUhjK1MydXJiR01iYjFsaGczRDd5TEJGSE56ZWVlTTBidjc1ejNQcUh2?=
 =?utf-8?B?V1k4cWw5N1BCRG5OUDVHVVZ6SzYxL29ZUm16TDZJSk1lVDdmSnNMM3diSTVD?=
 =?utf-8?B?Q2ZPUzYyWXBXNlA0bWh6allXNjlpK0Nvc2I3Z3U5N1J6ZkhnQm8vTUw0MVJx?=
 =?utf-8?B?a2JncXNhNWlXTnFBa0gweDRPSnBnTnM2T0VVZzVhSGV1aWxyTHFNbmowNVF3?=
 =?utf-8?B?bUl3MUZCaDNaR3drekxvVTIzWmpzRWcxTmE1cXR3b0F2dFJNN3kzemJZZWVT?=
 =?utf-8?B?Uk1lUGVSR004RnVVMVdET1NOUldLMENUUHNYV21sMmZNSVM0WHVDWjQ3Znhz?=
 =?utf-8?B?YjRkUGxDa0JtL25COUV5aHhIV3JEVmVEWmR1b3pWdUxQVEdJejlYMzk5V0NW?=
 =?utf-8?B?VUxOem5CWFo2OEEyajJ6R1B1dGp3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a3c95a-680f-45e4-18b7-08dd8054d728
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 21:46:43.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW9BuT7FR73MJkiD4Ue3d1xFSUQ1c42+iUfrqQ3snueY6tjHmGdeJypgIufTxDRIBzBjhkZnYHozHa6SRUgl/FlV/HMiQm9dqeu+4R2yuf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5735

--------------0Gv2i6OGM42AKggD7E1qihgs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.04.25 07:51, Qiao, Wei wrote:
> Test pass.
> The system can boot up and work well.

Which xenomai/compiler/kernel combination are you trying to build?

I tried to reproduce with gcc 15 - the latest gcc release - but it is
still building fine.

You mentioned Ubuntu 24.04, which should ship gcc 10.5, which should be
fine as well.

> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Thursday, April 17, 2025 4:59 PM
> To: Bezdeka, Florian <florian.bezdeka@siemens.com>; Qiao, Wei <wei.qiao@intel.com>; xenomai@lists.linux.dev
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.pirou@intel.com>
> Subject: Re: Build error of kernel/xenomai/debug.c
> 
> On 17.04.25 10:43, Florian Bezdeka wrote:
>> On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
>>> Hi All,
>>>
>>> If we build the kernel in ubuntu 24.04, there is build error:
>>>
>>> from kernel/xenomai/debug.c:23:
>>> In function 'strcpy',
>>>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
>>> ./include/linux/fortify-string.h:787:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>>>   787 |                 __write_overflow();
>>>       |                 ^~~~~~~~~~~~~~~~~~
>>>
>>> This is because new gcc version has stricter FORTIFY_SOURCE( =3 is ‌stricter‌ than =2). Please help to fix, thanks.
>>
>> That is the flexible array story...
>>
>> You could try something like below (completely untested) and report 
>> back if it works:
>>
>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c index 
>> 25b194c26..d048dc757 100644
>> --- a/kernel/cobalt/debug.c
>> +++ b/kernel/cobalt/debug.c
>> @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
>>  
>>  struct hashed_symbol {
>>  	struct hashed_symbol *next;
>> -	char symbol[];
>> +	size_t size;
>> +	char symbol[] __counted_by(size);
>>  };
>>  
>>  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS]; @@ -91,6 
>> +92,7 @@ static const char *hash_symbol(const char *symbol)
>>  		goto out;
>>  	}
>>  
>> +	p->size = len + 1;
>>  	strcpy(p->symbol, symbol);
>>  	p->next = *h;
>>  	*h = p;
>>
> 
> A bit of overkill, given that allocation and access of according size happens within the same function. No smarter way to tell the compiler to stay away here?
> 
> Jan
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

--------------0Gv2i6OGM42AKggD7E1qihgs
Content-Type: text/vcard; charset=UTF-8; name="florian_bezdeka.vcf"
Content-Disposition: attachment; filename="florian_bezdeka.vcf"
Content-Transfer-Encoding: base64

bnVsbA==

--------------0Gv2i6OGM42AKggD7E1qihgs--
