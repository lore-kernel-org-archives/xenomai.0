Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001D23EAA3
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598021; cv=fail; b=s34ExmcqhLxbl0BNdcujYf5QhuepYF8gh7AEwPOAJl9ZXq50syfyNW9tCEjsRwhX+C5cutB0iXo3ZnZIdvL0eWp2e/fKbfvehJ26F8tTMjs9Ft6iLz3QbU0aeIqrLRMof3wmMFWxlbSNPUA8ejgkjXA4TVKl8IZkQhKQNh4vHio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598021; c=relaxed/simple;
	bh=/vbWdmMsnR7GqmM8rMaxOEVnsqmy4ekaS5fkhulXSAQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljLxCO92SneGnrEP27O0tNLevk34OvEihOVQDxoMA4pMYq4RGW5ofeqI5CG4Bj4hrzF3ZyDCczIP2eEZi1QIoo75j8Da1KrWNdP5hvVlTC6SEgXd46vRtR6TfZ2iKTW7QRnJcondTDdEJjs7L/r5Jbl69yvy3+Lg1rWKJe1baRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g+H/C9Zp; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g+H/C9Zp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtWpiR6EnJd9dPhOGTJ/Yd8Px3t+ezgDwrPB7xIs/ob+r3kLgOxm5lpFDIo3AQHHyKKsY1PYOc9q54iDm/CiqjMjcTfH0wUg8IfW+fvYyuY9bf+ftAkvXzKll/HWRXv0GjwzxWAAcqrfFikj6lF41j4LLhEJjt3CzEY3CKxf48bXCjQyRaFKc5xfYY7X4lNEKUym91Ty8ndub2d3dsQcEfWYgklBaTDZyHIypGt340hfm5GhVIAni1OGK24haad3xCI9G0kOgPgjboSmm+5vyPfzINqsSPgFlZdtX6v3v8INzrIQPrBGC+ruxqwzFvYZ+Ewe3QbFtOweA2uNxzQx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKihmXBq0PqcCG7deVm48g2GMQhIdCEl8qxSLrvSe7U=;
 b=dKaqSRj0stsKbYcOt7pXvfklsDgYIEwYFBpYqmlGTzv/ACj2jiAzP/mX4ZZ1QLSL5+mKD3W49ZzWT3WtGnvAPw/ZUenhbt9BDMFQpMPg2iqZHjJNbXPAOMV5+baqcbFcs1ecwAvJ17SP1pHFTzLMNQCz2leHpEXUx2OvrIcqCAS/SmXuCPTRIGcS7c7siddbUQ7dgQzDLmpv1z3JeVR94+qWQjrgsZNmwx/tzGH7XOY/kvuu8i3PVy5VWsSpyCFDYEWLSaSb/xpRvovsyoBiXBCQhHXCP0CJkjk1ZhWM5cLnVs7rXzKrZVix5MqejzEjBxxS7OwqbVJ5CVTttcmeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKihmXBq0PqcCG7deVm48g2GMQhIdCEl8qxSLrvSe7U=;
 b=g+H/C9ZpfWPoeMvfLoLVplpxWaEqtBtfT8bDGOzju6h45SGpaM/VtvpMKzeIQGpHdUm7maazyozls7bun0f8qyPZ/KktPAg9QCSW0CnD5FcAyybPGNXHlTZp6C+5dEIPTsdvu7EGBnj4BH1QKL5b6jBYUX+JGzo4tnr7VDE4ATRYEX9xUfdvVqA8z0nZ497vGswycmLoYrwx2/FRaomFo236OSteweybaDltwIgvPgfcmCqlyqdvZqiKEP4L1/L4jKlKBXC9zBB+DEaOBTl0N8T52EwMjltx4FryQb2niG01aGxwniFL76hYGtLiU7uUb+pld6tzGQNdX0wBtipx/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 14:33:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 14:33:36 +0000
Message-ID: <c25eab63-c17f-4cf7-8f35-079918c6d92b@siemens.com>
Date: Fri, 20 Feb 2026 15:33:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] lib/cobalt: Introduce cond.h
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <20260220-wip-flo-fix-time64-32bit-native-v1-1-731c773e72cc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-1-731c773e72cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 59111156-1de2-425d-a3eb-08de708d07e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUVLenBMdU9PbUpic0pjVlc2RE9IOGdyR2lYNTBUNjR1c1YxRlRWRFJ3d3No?=
 =?utf-8?B?anNXWEN3M1Zhb3F0M0dyZEFQKzBTWFcrcVhIS0NHQlo2N2YwVFpyNlFINzJo?=
 =?utf-8?B?bDVtaFJTVzE5bEhiZDR4ZEJZcXV4YUIzdGVkeVJkQWlHbGh3VCtETmVYd1Qv?=
 =?utf-8?B?VXJyT0pFd0o4L1lTUlRrSEZlRjVuelBIZ1VGN3JkcHlxcVJJNzhYMzVyVDYy?=
 =?utf-8?B?SVRVd21PZG5ZcXRydzdVdEg4R0R2YnhCMGU5UndVL3hudnFzbXhVQkVBeTQ0?=
 =?utf-8?B?L3dSQnc1c2NJYmFGVXp5bkRocXVtNGVyZjdWS3VsTEFTUUpJbUhJM2Z3RkM0?=
 =?utf-8?B?Q0hXUXhMcUpQaVlWbjI3OHNoL1BLcEtvK2JuT1RpSHFERDNnencweE9MOGFY?=
 =?utf-8?B?RzRoQnVmVzVicG9mRXhHVk5KdS93R2RpdG9Kd0pJdXZBNXJTVG96Q1RILy93?=
 =?utf-8?B?eG9JS2EwSmI2MFl4b1dKeGhIemJIN2tNVFptTmpZalRVRkx0cTh6MVBKRU9l?=
 =?utf-8?B?bU5Pd3RUZGk5T1d4T0pLWU5EalJUN0dJVzZiNytOMW1meFVjSEhyVnNEaWlq?=
 =?utf-8?B?MGNkdURTVzZVZGpMbDlla0xzSCtkdVczU1IzWWp1UXlLaHVxV1UvYjFicVlt?=
 =?utf-8?B?MDhnRkxhREd6R244TWFhdk1zYlNZNy85d2IwdTB5M1Z0RFJkN01mOGlxVTh3?=
 =?utf-8?B?Si81RWZtam9lVXBNeS8rczgzOFpHcTA0UmhLN2hRK2p2LzA1K1daeHR6c3dW?=
 =?utf-8?B?Q3NQTkVEbHpZR1plUEpWYXZSNkN1cG1HSTFtakQ4SWxTeTM2UmFGMWxXWkQ2?=
 =?utf-8?B?VFlIVVZLZnVLb0N2OENZcmljSVJxczBwQTVleUliTWo0K3g5M3l2Q1FqVXJl?=
 =?utf-8?B?Vk81dDgzUkcrclJVTzhuU3g4TTNlTjRiMitxcDNhN1YvbVljOFgrMUQxQ3NL?=
 =?utf-8?B?MGVxMG9vb1lCY2R1S1grM3NldHI5aTF0emxETVRrcWQ1eWlDcExVUzVPZWJR?=
 =?utf-8?B?R0Z0UXczeVYyNERRRG1XWStYWXp3cmdvQzRqTzlTbHRTZ01vdmpGRzVROEs2?=
 =?utf-8?B?ZTlIdXI0b3BxK2RTSHlwY0RyNTI2KzM2MU1McTA4TWt3VzhFbVVpOTIyd2ox?=
 =?utf-8?B?bWtkSEIxZjJ0SUxOZjlESGxINDNZazFZTnZFQ25QazlmY0w5eEQ5akt6bU5h?=
 =?utf-8?B?SysrM2J0QjBCUW5kOHlUN3BwYjFPQ0lSN2hwZXk1ODBIWmZTbFNpRmJMS0tT?=
 =?utf-8?B?dzQvTHlPeUd5Y3lSZWtDU1lqaHNBdHJlaHI3dUtHbzhGaXhrbUwvekNTUTlp?=
 =?utf-8?B?Q2ZDa040MmlKRHhnSTBZQVQrQjloMk9YbnRuemJuNzhqWlZLSkJyZCtTU0lD?=
 =?utf-8?B?T0NKTlozWmZuMmJ1Q0FiQllwRlJUWkpEOVd5Zk5ZOFJuN0tkeTBUMkZaeW10?=
 =?utf-8?B?VmhUOVdGdTM3THpPTXpOMVFJL1VCMXhWd04rcVc5d3QrQlgxSHBLdHQrNGpD?=
 =?utf-8?B?UE9DZWQ3SGduc3YvVVlXWU9FbXFSYkhybFpYTEdnTHQ5eThoNHF4dUIzd0hx?=
 =?utf-8?B?c1V6QlRkdkhEUkt3cWJqYWd3QnkwV3pseE1mZFBaMVh3enhMZENwZlhDV0RC?=
 =?utf-8?B?ZzhsaGxWbVZVUkFxL0cvbUI3OEhrSEVUS241WWNBOTFFK1VuaUJ3d1M1Y1BN?=
 =?utf-8?B?YU9abnBqK1hGQklSNXdCZ0ZPZ3RsaTExdkxwM09WWXlZYjA2dmM1MkNJSmtw?=
 =?utf-8?B?eEhsZjdjbHZyczJIN3VpRy92UFJyKzd5c2E3Rm5oOTl4UlRTNU4rcjYvUVR4?=
 =?utf-8?B?TUtuaHErcnh5R2w5L2JEazdSNWVzRDJvU21HMmwrcGVyKyt4SW12aGdRQUYy?=
 =?utf-8?B?SWZuNzNhTEduMWlsQVhRSURvTzZ6Y09ESnpoY0FEMEIxVkhUaFlwUFF6YTI5?=
 =?utf-8?B?bUhubkhSSTBiNk5GU1hTWUJyakVVQWZINmdwS01ESkZoUFZuNGFKUUJTdWFD?=
 =?utf-8?B?KzRCaFpNT2hSSm9CdGxRelJFd3E1OGQ2UXBENFlpcmRKUDdCZ1pKSWpRODBT?=
 =?utf-8?B?cjdwY2IvVFNBaXVrWGI1NlNQMzUvVXRLOGFDNTlMSTNBY2ZBNDVUdE53UXdt?=
 =?utf-8?Q?T9QQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0t2YVd2ZUFYdnJ4TUtPMm5zb0RxZittV2FpZFlncVl6bElraEplMC8rY09L?=
 =?utf-8?B?amUwdXp2anNoWGdBYWtLNUxQLytUQlZNTlI0eERMOFE2RThlZTNNRjRRQno2?=
 =?utf-8?B?NWtiWmhFT24vZmtjL0QyTmZBaFJoSFZyK05FektKaGt1TTRzL0pETDFiSEht?=
 =?utf-8?B?VVBEQ29MT2JnQWptdFZaaVpSNjI0UUFQelRxV1JnSENTTGEyeFlpcnUreDYy?=
 =?utf-8?B?OEFxSWFzS2J4alRqdFlFRms4dFFWMThZK080RWhBWTltaDRHNVc1c0t5bU1G?=
 =?utf-8?B?SDlabTN2R3Y1dit3Ykh5OFZvVW1Bd0NxVzJRaWs3WDRENEVUVUkvSTRnNk9G?=
 =?utf-8?B?UU9SQ2ZXMTFKSFRYb01aK0FiZ2dqazJCYlkrbFpJR0NWUzVnN010alY5U2Rs?=
 =?utf-8?B?WGRKVzRzaWhKNnF5YXBOYzBibm9hdWFibElpcmIxZlR5VnVMN0Z4Z2ZFQ21j?=
 =?utf-8?B?dWZsNTVTUklSc01wZitHVHJHN2xiYW9hVXFsb0xaT3dZZzNQSjNtTkYvbUVL?=
 =?utf-8?B?RWxCaittTEZQd1V4aklOR29sTHduZ1lkdldCY1hTcVFQWDdnMGxuSFpjdkI4?=
 =?utf-8?B?dHI5N29Dc2VyaDkwelZudkdUcmR5Ymkyd3dOaFhuYmpJaHREZUVpaGJCRWFo?=
 =?utf-8?B?NzlsZm5Qc1dFc2NSTDZOYVdCREw5Y3NmazVETG41N3lub2MyVGtid1VXWnNT?=
 =?utf-8?B?c2FtYk5FUFYvb1JOOU5EaUh1U29ha3V3T2ZqSDdacVB1QzVWVFFtWmZiTXc2?=
 =?utf-8?B?OVNyTXI1OEF5bGx1Uy91TDlRUTF3ZzE5K0hpUExhZHVIbTdlMmlHWXBCVTZQ?=
 =?utf-8?B?amcyWG5PSmF4UUNBbVF2MHVrUUQ5ZktlcUtmVmc2eGFldXYrN24yVXB1TURN?=
 =?utf-8?B?V3VLR1hGS1hXWTZqNm1ianVRMVQ0QVo0UkFhZlMramZGWG1rWGRRQVhlSVFN?=
 =?utf-8?B?UWpaZmhCWGdDMTlvVE9hVWVkRDY5UncwWkh5aFBGb3MxV09mM0FuUWRjekRH?=
 =?utf-8?B?SXR3N2ZpYnczai9FL3JSdmFMR1FSVFFNSUtla2E4WUJvdG51RkQxWTdwOWRM?=
 =?utf-8?B?ZytHTHd1SlJlYTkramJQNTZMVGFUK0lPK0lacW1KWDJ6MXNIY3h1L2pKOGE2?=
 =?utf-8?B?RitJYm9WWTNHRm0vT2VtbTBNQk43aHNTUnZRQWFsRzJ2R2lwMGdyK1Z0TFAz?=
 =?utf-8?B?QWh3N250Vi94L3U3ZnlUNGRKSHdkWngva3ZwK0s0ODFtQWp0dzFuSUI5MDNk?=
 =?utf-8?B?VHpoODNLWEQ0Ni9adlJ3allDVVM2YnZyWFBYM1gwMGVXdWR5T1I4UUk0RUpl?=
 =?utf-8?B?anV6eFNwaEJGVEFNTTBpMW0zajd4M1J0dXBYcjBSa1U0OVp0dlhsQ2JOL0Nn?=
 =?utf-8?B?RWgrY2pyYW4xT09ldmlNSkU3WTdHZE0rSzRHV2d1RTNJVW56OUJ2eFlBN3Y4?=
 =?utf-8?B?YWFwbHlmemRJdU9RWThOSXpYWUZKM2RHSVc0NFNkSW1oQzlVYUNRRU8rTXM2?=
 =?utf-8?B?ZXZjREMrSUlJZnpDa2VyR1R6bDRHOFpITG91UjlyMmQxOEtsaGh2M2tWdDcv?=
 =?utf-8?B?cy9ENEwvQ2FWQzJuMnFUT0Y1RWxreFBqQ0VIYXphbUtpMGVWR1VHK25WV2or?=
 =?utf-8?B?VjZ4TnlLaXNhQ0pQYTdFdVpNakxaSFNsS1RFTDdmM2ZUSkFZSDdKZjZNS1Qz?=
 =?utf-8?B?M3pHUFlhU3krR0xOS0JnSElVOUdTT1dtRWVkd0hnaXlkS21LeUo2VitSMlh0?=
 =?utf-8?B?UmY3b0pzVTJsVERSZWhXVXlOWGVvK2k3S3pIMEZza21MbHh2cys1ck8xSExu?=
 =?utf-8?B?TmdGckJWdTc0L0hLZE5zazJxeE1sTkRnWExwVkJObW9FRmdXQ2dDT3Q3SGtN?=
 =?utf-8?B?Q2swWWUyV0RHZkkxTStpbXVUUDUwdmxNTXBQeGsxQXhGR1UzUUF2ZmlGOHJJ?=
 =?utf-8?B?UGsrU0F1elowdDNEZHYvNnVwUnlZdk5UWHJjKzF4VmRmdEZtKzU4bUM1Zmxa?=
 =?utf-8?B?QVEwSE5ucUZybFNFUEpaaXg3cm5seDBtMnBtL25NbVp6Qy9qOUdCQVdyemR6?=
 =?utf-8?B?YzNIV0trU0VCRk1FYnpGU0VsUFdBd2pTRjM1dlhUSnpKeUhKNndXbzRBNFFl?=
 =?utf-8?B?dkg0SG1OeG4zaVpRaWV3T0ZSYS96ZjhmdUk5bVdiaERwdHRCbVRnN0xqelU2?=
 =?utf-8?B?bEc4SFVLaTRkbjVnOFZSTlhNUzhDbHhWWG5UQ2tkSit5VTViN2h1TXgvNG5s?=
 =?utf-8?B?YVVCMCtSeXNQM2J0emNoc2NmeUhMMkpOQm16K20rY241ZnRKRnRBRStUaWov?=
 =?utf-8?B?QkNHNjgwblZZbWRWL051UlF5UFkvR2NLOFhoUjl4QVltTm9YU0FWZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59111156-1de2-425d-a3eb-08de708d07e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:33:36.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAs1zzOkfJdEC5AfazWYOFh/Q0k0JLJO5qavCnX3vr0vry8ljVIwYhK+OKfWGs52JNKeSVTu90JxqyUCBAoQCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9423

On 20.02.26 10:08, Florian Bezdeka wrote:
> Some code will be re-used later by the time64_t compile unit. Move that
> code into cond.h, so code duplication is avoided.
> 
> No modifications to the code itself.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/Makefile.am |  1 +
>  lib/cobalt/cond.c      | 67 ++-----------------------------------------
>  lib/cobalt/cond.h      | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 65 deletions(-)
> 
> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> index ed7e503899f4852388fb3bf204bfe91936009d74..b1098413fbf3a8f6a5f0a85d6aceb9916b14149a 100644
> --- a/lib/cobalt/Makefile.am
> +++ b/lib/cobalt/Makefile.am
> @@ -1,6 +1,7 @@
>  pkgconfigdir = $(libdir)/pkgconfig
>  
>  noinst_HEADERS =	\
> +	cond.h		\
>  	current.h	\
>  	umm.h		\
>  	internal.h
> diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
> index 2d11f768edc0fe4e89944a96333d2dd76d174172..7be7fca01f53930f8504945206b2ee6ba6be1ba5 100644
> --- a/lib/cobalt/cond.c
> +++ b/lib/cobalt/cond.c
> @@ -20,6 +20,8 @@
>  #include <string.h>
>  #include <pthread.h>
>  #include <asm/xenomai/syscall.h>
> +
> +#include "cond.h"
>  #include "current.h"
>  #include "internal.h"
>  
> @@ -147,32 +149,6 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t *cond,
>  	return 0;
>  }
>  
> -static int __attribute__((cold))
> -	cobalt_cond_autoinit_type(const pthread_cond_t *cond)
> -{
> -	static const pthread_cond_t cond_initializer =
> -		PTHREAD_COND_INITIALIZER;
> -
> -	return memcmp(cond, &cond_initializer, sizeof(cond_initializer)) == 0 ?
> -		0 : -1;
> -}
> -
> -static int __attribute__((cold))
> -	cobalt_cond_doautoinit(union cobalt_cond_union *ucond)
> -{
> -	if (cobalt_cond_autoinit_type(&ucond->native_cond) < 0)
> -		return EINVAL;
> -
> -	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
> -}
> -
> -static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
> -{
> -	if (ucond->shadow_cond.magic != COBALT_COND_MAGIC)
> -		return cobalt_cond_doautoinit(ucond);
> -	return 0;
> -}
> -
>  /**
>   * @fn int pthread_cond_destroy(pthread_cond_t *cond)
>   * @brief Destroy a condition variable
> @@ -208,45 +184,6 @@ COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond_t *cond))
>  	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
>  }
>  
> -struct cobalt_cond_cleanup_t {
> -	struct cobalt_cond_shadow *cond;
> -	struct cobalt_mutex_shadow *mutex;
> -	unsigned count;
> -	int err;
> -};
> -
> -static void __pthread_cond_cleanup(void *data)
> -{
> -	struct cobalt_cond_cleanup_t *c = (struct cobalt_cond_cleanup_t *)data;
> -	xnhandle_t cur = cobalt_get_current();
> -	int err;
> -
> -	/* if we still own the mutex, cond_wait_prologue wasn't called yet */
> -	if (xnsynch_fast_owner_check(mutex_get_ownerp(c->mutex), cur) == 0)
> -		return;
> -
> -	do {
> -		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue,
> -				       c->cond, c->mutex);
> -	} while (err == -EINTR);
> -
> -	c->mutex->lockcnt = c->count;
> -}
> -
> -static inline int do_sc_cond_wait_prologue(struct cobalt_cond_shadow *cnd,
> -					   struct cobalt_mutex_shadow *mx,
> -					   int *err, int timed,
> -					   const struct timespec *abstime)
> -{
> -#ifdef __USE_TIME_BITS64
> -	long sc_nr = sc_cobalt_cond_wait_prologue64;
> -#else
> -	long sc_nr = sc_cobalt_cond_wait_prologue;
> -#endif
> -
> -	return XENOMAI_SYSCALL5(sc_nr, cnd, mx, err, timed, abstime);
> -}
> -
>  /**
>   * Wait on a condition variable.
>   *
> diff --git a/lib/cobalt/cond.h b/lib/cobalt/cond.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..fbb7a02149ddfa0858def5e8741d5b044afc17b7
> --- /dev/null
> +++ b/lib/cobalt/cond.h

New file but no copyright header. Likely applies to more patches in this
series.

> @@ -0,0 +1,78 @@
> +#ifndef _LIB_COBALT_COND_H
> +#define _LIB_COBALT_COND_H
> +
> +#include "current.h"
> +#include "internal.h"
> +
> +#include <asm/xenomai/syscall.h>
> +#include <cobalt/uapi/cond.h>
> +
> +#include <string.h>
> +#include <pthread.h>
> +
> +struct cobalt_cond_cleanup_t {
> +	struct cobalt_cond_shadow *cond;
> +	struct cobalt_mutex_shadow *mutex;
> +	unsigned count;
> +	int err;
> +};
> +
> +static int __attribute__((cold))
> +cobalt_cond_autoinit_type(const pthread_cond_t *cond)
> +{
> +	static const pthread_cond_t cond_initializer = PTHREAD_COND_INITIALIZER;
> +
> +	return memcmp(cond, &cond_initializer, sizeof(cond_initializer)) == 0 ?
> +		       0 :
> +		       -1;
> +}
> +
> +static int __attribute__((cold))
> +cobalt_cond_doautoinit(union cobalt_cond_union *ucond)
> +{
> +	if (cobalt_cond_autoinit_type(&ucond->native_cond) < 0)
> +		return EINVAL;
> +
> +	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
> +}
> +
> +static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
> +{
> +	if (ucond->shadow_cond.magic != COBALT_COND_MAGIC)
> +		return cobalt_cond_doautoinit(ucond);
> +	return 0;
> +}
> +
> +static void __pthread_cond_cleanup(void *data)
> +{
> +	struct cobalt_cond_cleanup_t *c = (struct cobalt_cond_cleanup_t *)data;
> +	xnhandle_t cur = cobalt_get_current();
> +	int err;
> +
> +	/* if we still own the mutex, cond_wait_prologue wasn't called yet */
> +	if (xnsynch_fast_owner_check(mutex_get_ownerp(c->mutex), cur) == 0)
> +		return;
> +
> +	do {
> +		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, c->cond,
> +				       c->mutex);
> +	} while (err == -EINTR);
> +
> +	c->mutex->lockcnt = c->count;
> +}
> +
> +static inline int do_sc_cond_wait_prologue(struct cobalt_cond_shadow *cnd,
> +					   struct cobalt_mutex_shadow *mx,
> +					   int *err, int timed,
> +					   const struct timespec *abstime)
> +{
> +#ifdef __USE_TIME_BITS64
> +	long sc_nr = sc_cobalt_cond_wait_prologue64;
> +#else
> +	long sc_nr = sc_cobalt_cond_wait_prologue;
> +#endif
> +
> +	return XENOMAI_SYSCALL5(sc_nr, cnd, mx, err, timed, abstime);
> +}
> +
> +#endif //_LIB_COBALT_COND_H
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
