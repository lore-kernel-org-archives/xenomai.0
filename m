Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795541709;
	b=JvyqluxdFoM0Po/usD71a2k6brdPWsGJpY43xDtJN7JGAR8ITLPvo4UxZ+t8n0+D6GMK
	 o4WPf4U/1nE1xfgTwZCinCYhluEMOIcVBgd59IbngWYdSzBQOLgPKm9zkxsQRrMPyH5Hg
	 0OM6pcTjYfBusUk0oGWrz7tu5tn6a8AuM2hrh+6oY5cFQVGbCjQ7ZUkXB5Vlrx/tVpQ3n
	 yZLOInTxcb+P2nghqpv4SBaxRKyB9SE9DpZPBWzcCZlbKg+Rj7PTEKbmRXKjZD9cyQ2ic
	 bJQs1qbmOMVLZzyMcM5QxvC9AJco0IWA5JYKvwLUL9gvaXlaylz7UqYkrzI2f/R4USg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541709;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Content-Language:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yJjAR2MuOf2n4rP1cCCytstUJGElLd0zA89I5hNUGmE=;
	b=zblU/ysmJ7YCsH+czjF2ODE146c97mO8qPLrOhx8cP7ejlnUcDfPguh9sOVQsYJzhrl6
	 tZCNrhjYhnQ4qJvI17CfiqT7uyt/4mdFZrTQN4YvUhxEfsxKiD2RIuHKSWWvdFcN3UO3E
	 wfaTlzJd47mYIa97jn3W3uXkwHWukRiWu4BwWlCV6Rgl51zKQc3fPrPYHdUSnStxWmCwo
	 WQoEq8zfzQK28E+xQK5QTuToMvO/D9LUrg4rJ7OcLMVoUsIbvbqsTVJTYlgojtkQPbv7g
	 Uy30VqGITrMGL+iPx0tBLhrllrUobA2Qg4a45NUFfyHz7IZREaxkCTChcvbchePXIew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=aRAtWCeG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98213606A33B
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98213606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=aRAtWCeG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO+Qacg7Izqh+VRuPUcekmwhcqO8R1XVQYUy4gyeiOP8vpjifHHJp0XEetMtvFqWjpBWxbWaCDhNN2l48yTwJMEv3aN5jyK9WRHWFktrp/t1bO3ES/AQtevWHCSddn+eojNGksgxQFLI/8xFKZgSRc+yL6HHG8MliwHyUDlZRkBPoWSIBWHJzAa/kMvYEQ03rIQ3TyxX4Q4OcPqWvbwRwGvbXaD/JDVbqLKJpyhw0A4xdUI9+TicISs3e23/D25gIu6ao3XLez1eCekQVZedzETj6sKjAezyPT9JWkaYciYtYXpFRparIzxLOTEqMs9uYzH9MOMORP2wj88sw9k80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJjAR2MuOf2n4rP1cCCytstUJGElLd0zA89I5hNUGmE=;
 b=sqCheAxPA2aPLuastr60KPrHkwR4OstVbRF/su8HaqX6TaHh0Vl8067K3MZc87ZzCudlokAkZQU92q9/JW/QXcdTu352geiYBkHjSnYf3Z+6xF3ptErTMI5/z1Y8wCX1YzQrGKCKGrW+FeZ4PGBZRZQS8kDIsiTISCVq/8LpzCR4VuBT+U0qyCkhQVKRmbRl8ro03KuPDofiua0TF/Oo/2gRM6akicUD4aZ+N7PCGlyWuAAyZThJzJU4jmwTfZmQNv3VzG7ueNQ9mL/05Zw29ij5O5fcpDXa1gSHS0T5YkFqmoAh74dLT2h2yeyYvwQjMTaDTO5JbkXtEPJs74GSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJjAR2MuOf2n4rP1cCCytstUJGElLd0zA89I5hNUGmE=;
 b=aRAtWCeG91UuiEl7urkHjVRd/22FDF+j/jmoR72lWrRws+qkLthG9BjeTTxs/V7c7rAQ9LevZGfN6WnPL7YPdEuw+Vjmj13ssQs0equSVMm4axAJhpiimw4UTX/fE9zrZf1AX6Ywuv7B+PFxSlW7+72xlk8gFU9QSrjXmRK+LjV7DThJFhTf1600N+F2dOrG9O0XifGXBcxaGl4QneXaRjZahxCHU/MkNb9HKfuJZ4PeApPaNw1hin4p2cbGsMJUrqxLEOge8NFvX2jh9Dq/7oEywPN+jjgRF5xw3j+n9pPKCTxks0h5cI8/uNlKIDTARadHnqcyK8qTATlixHIfOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB8666.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:239::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 17:35:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 17:35:05 +0000
Message-ID: <80d15bf5-beae-43ca-a595-262e59daf4b2@siemens.com>
Date: Tue, 24 Nov 2026 18:34:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, November 25, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8c6c8e-fe86-4ab4-061f-08df4a514655
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|261026140227099003|261022075727099003|11063799006|56012099006|10067099003|261022105027099003|261022113327099003|261028144727099003|261021135927099003|261026121527099003|55112099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	5G8RUTc+qO5aVtcMsjsXZ/9a/p07k2iC/DOnK8zYhe0Pki5cCqZbzh5HRNS1FqrAqcJDi25WRnzGOWT9p9cIjmuDuPzBh9mM/H7F2zDH9jy466NtI17pdr5ktHzFxCt38a8NCGn8QvXzDg9XPm6zvBAqrZ/psjIKNNt/lZOsdJZgEiP1qlugmPcOetRLk4RGlEQco57ISUCRyqK5DxYsehmTkWFrzX46yZvDg69F+GssQhaywiL/UHlPNdLxtQhitMjAYqnMLyKv2kCSmDMV8gChoF1XhWdpgbKsMRBlYTts8ga4Admds5ojh6fc4NwpelfjsA9+5hHIxNQcZ09wSP3+6i+mGJEKSaLgnB0h2nujHzJpS8cPT+tJf7kKJXkJHat2XUTjHLhOPdRNQ2ph2+JFrCKSjnDyGpco0h8I4F4HT66lQqtwO/rXfDqQWOJGjUOWculxE/EVIyCG6gpnoD++mwyVHv5i50mf44yYFAc315OFtfXDXClhTj8CAaemkCimXSHFhpvoL4KyMSlCN1lJMjkIto/rLUb7tWsKnjrUmIz6VJMjodDKFPazl0l69fpsMGb7URwaE4j34HDWwQHdLIywQAOWtPzxxzB3VAMk2XYZufeZJ+vVGaZWC8gnlCPJcJwtoA9zAeFMbcIp4TP30CWw4rHMqywklAfe6t4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261022113327099003)(261028144727099003)(261021135927099003)(261026121527099003)(55112099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S21Wd2tkRW4ycVptQkhvbmtmbFhzSGJ3RmgxaTRFU0lJRTlyVS9oMmVpSVlj?=
 =?utf-8?B?aktadk5iVVRwWHB5Rkl4c3llM1VjKzM2NHBDTlR1cnE5T25VdGYrRlYzOWpk?=
 =?utf-8?B?OXgrd3lGMHZ0WUViV2RhZ2o3VmlkY1pBWG1TQzR3R29Ba1VOc2VhcDJHdTkx?=
 =?utf-8?B?R2pHeW5zM0pBbjVpRTNraDlKMnNLak5Lc1pnY0tKU0VGMWgvUGhCd2dCM1A1?=
 =?utf-8?B?V0V1Tlg5eVRzNm5Zdk42SGplazk3eXR0N1RYSXZ1VTVWcjlodkFKbFNGZmp2?=
 =?utf-8?B?cXpJQ01SbmM3cWNZT3JqWGRKNEV4TE1DOVNVdStqNFI3UklUdjJ3czNCYTVX?=
 =?utf-8?B?ZzVYb1VFREt4MUIyZVQzVktBcXk2cWMvS3U2eVo3bE84aUgyMUZ3R05sckNT?=
 =?utf-8?B?T1U2bG9meUs2dWMyMmtYcEVBMkRYbHI0WldzbEI1NUR5aUhDcVhjaUtkb0NO?=
 =?utf-8?B?S0NFT2hGaStqWFhkRExvSmxxSklyUzF2Y0xDQ1Q3enk1V2NBY2xDTHdGcWdz?=
 =?utf-8?B?eXJENEV6SFQxd1FsQ1VnVlYwbWMyT0p3cHU4dkJnYVhaTkFrL1RPU0xpT1Jl?=
 =?utf-8?B?SlhSK2ZEMGRYRUhabkx2dnpsMzFGa3lwdE1WYzV6dlFXUWMwaXVOK0hSMUNX?=
 =?utf-8?B?clBQZWJPcWYxVTJlUG1SZHQyQytxN29PL0dnQTZOTHI4VmlDbnpRZEQ5bkUr?=
 =?utf-8?B?SDk2OUk4KzVlMjhtREI4RUFGYlE5YnBVRmpKdWJBajVjYlhGcktsY3FQZ1Ns?=
 =?utf-8?B?SWV5UTB6aWtJTitaaXIxWlBIaHl6eG10MWt2bXRSREsvb0hIZy9GMThidnl5?=
 =?utf-8?B?NFd6UnEzVzJVN2tmMklRaStnUjRENzVnQ3VjUndLd0QrMXM1N3ZEWG50L05t?=
 =?utf-8?B?WlloQVgvK2RDQ2hWVThOZEhOU0Q5OVl4dHVxd2FaaTc5SVZFQ2RBQjhsWTlu?=
 =?utf-8?B?anNaVUJ6My8yZENZbVllbHRORUlpUGZxRExvTUZUTEZ0V3l0TkJ0VHJ5MlBu?=
 =?utf-8?B?TGpuMXJXVmJBYWFhVnJ1bHY0RUJNdEZmSTBWWkkwakNOTFk3QkQvbjAvT1VN?=
 =?utf-8?B?bUdheE90VzB0eWNjQ05tT3BXK1FZRVEvUTBPSUJCQXYxY1BzYk5xUUdtV29u?=
 =?utf-8?B?MkJsWGp0OSt4Y1B6VjFYVktqb1FvS2F4ME5WRlV4ZFYxbVNLMmlTUzE3SitX?=
 =?utf-8?B?NXJ5KzhyN1pMM093ZzhDK3l5QnJ1d2JmOEhlL0srbUxiQzBmTjRrUzBOd1h5?=
 =?utf-8?B?K1p1WTlwOVBtZ2ZERVNja3lhR3N2YlY1K3Q1emR4M1BETS9rTkZCNEtZdEVY?=
 =?utf-8?B?R0JLL09laEw2dloxdHJkUFNDUS93MHVIdjNib0VlSFNrUzk3OG0rVHQ0dVRQ?=
 =?utf-8?B?MkVyTXp0RzRzU1V2cllLV3d6QnozbjJrTlZoVzhIemhPdjU0a05WZ2FYNzM5?=
 =?utf-8?B?enoyWS94YkJUV3ZRMm9NeVgyc1VZM0FRSEkwTEY0REJKTWMrNW9PQ1AwR25s?=
 =?utf-8?B?SHFRVWFYMjJ5OVpDY1dwRWZYa09BQ1ZiOFUxTkR0OVBTaWN4NC94RTk0TStp?=
 =?utf-8?B?SzltejVPL2FVQWlOZUJhZHM5bmVZbHRneHpXSTkzY2ZKdG90aUJRcjlmT0xl?=
 =?utf-8?B?VGdsYU42M2w0WnIwOUlCdTV2QU9hVmw0TlhlOWhOOHFWZUFhYlhTbnYyM1pD?=
 =?utf-8?B?RyttZXNOYzQrNC9mSnMrbzgzYTMyWExwNVl2b1N4Yzc4V3VLVm9qTHkzcDRB?=
 =?utf-8?B?VEM1cm5aWjlnVWZyMkhDS0t4SU1SMldvUzZDVUZZTkN2OEd4cVdiT2lWMzFw?=
 =?utf-8?B?R2RKWDlEc3VMR0NIN2pTd0FLSWNydGcyY29jcG4yek92SmJjeHdJSDFZRjVw?=
 =?utf-8?B?Z3JOTHh6d2VmWUNmQ1hZNGJpOFZ2MDR0VnZucjBaeEx6M2o5eWFMTGFPbkVs?=
 =?utf-8?B?UXpNR1BwWDdPYVorbjkyTUFYcjVHU2R0eEZ1cmIrUSt4cjNSdm9FeUJqOUJi?=
 =?utf-8?B?NDVsaWwrWUVFVHp6SlZPUUo0SmpSSW1URm9ibk1HcEM4M2JkeFhTYU55ZVpF?=
 =?utf-8?B?MkVPdHZWUklPaXU2Z3djajJqZHE2TDVObk5DNFJZa2pGVVRySHM0YXZWdWtG?=
 =?utf-8?B?cU9jd1luSjB4YjNPOXhGSUVLOG1WK0FYeXNPMEFRQ3oxY2hZWWlxNEJLKzBW?=
 =?utf-8?B?K0pRQ3huYXN3TTRCSEhod1NJRkRwYUxnM1pwNGQvQjBGUVoxUVRJZG03UXRO?=
 =?utf-8?B?OUVZOGFtcnJ2SjV2Y282VHR0Tno3UXdDOXcyVTJVWlFiU0UrdU9wRHFmRTg3?=
 =?utf-8?B?azdyeVpyTWhzZWI3Z1kxVHZycmxJeE81Nk5lTjVadUNiQW1DYzRJQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8c6c8e-fe86-4ab4-061f-08df4a514655
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:35:05.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDarOo1CeZREdukBXGLtILFS+5bNdhPIpU6KrHfEaE0i9yoIGM29z4PwdhEJHUe+E3eSzozXebK3yrR6TLwOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8666

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, November 25, 2026, UTC 7:30 AM
Paris, France CEST 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d


NOTE: This is likely the last call of this year because many the Siemens 
folks will be busy in two weeks, and then is already X-mas. And January 
6 is also public holiday for us. So if you want to discuss something in 
this call, tomorrow would be a good time. ;)

Jan
