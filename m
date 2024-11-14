Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE233FE
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563092; cv=fail; b=R5gHiiYfEIn7uaFv//Kc/VC0LOB9o6JeIXNHKqb7MWV44TY5D5KKjjH5a5U8aR1ZLV2I9gyYkWpqmRR8lgU3dRI4KOS1loMNDwBa916DXLzjRWBdMK046+CQUC6q8C1+N46rGHvD8IUh9XjFlNOEoT+ccPWWOjvPikJAc0bZMjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563092; c=relaxed/simple;
	bh=Ik+Ip5vA4lZ4YRBon7ztPsEmKD/vojzAsByN4pKu8/E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dknxNZZkcNNfjgvunefz3mQbB4HqLjiY/HFgMSoqWhAllmQlCK+1s7n0ZZZUzE9qY8qjRh7jAB3Lr1DlMPttww2kWwiBd+hsZr/2fqD6XB26DtZTo9xTMERbWpEyFXYeVEwWlHNe+38Anoy6RafHnme87fwEkk6fonCywHkuKBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aqotc7AI; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aqotc7AI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5cH/+2ybb3pIVL7mRVfO54l9dTevC12h0X/J4synpevIdK0KSHzJNu0M+fBbLsZjwcLMBweU1GJHr9EU7Q5+LLkVlrKIh33dbc0GCtU1q/UTndKlOdzMimeDFu+swqsi/+z55W6ZkPWef6JfucTYQNothD1RFXbM2/pS4A7HA86klr4T16BKurm3AR4YiESPbGaqA5etVxbcgDJLBd4F80gN5qfbF1h2YY8oZetpAd5y80VnllUh49HsxrrRrBIyNwXtHA4GJuekNJ2vEUh3xcNnLRrBgD+ol5wBnUNtn3jY3JI+U8xKwQRNLbFZkKsrQ3eyWBJBAjlBvzMta3TKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h550DXygibblnVoXIbjJBz++LOsG7ULK7xY/e+ISm0=;
 b=dz8bDuVF9PmoNp3EujssNPB/0TY7DhDVoKZT2HDtr4rcIRa7S2T2sEb6GQNSt2TZyJpeliPzskppOQcg0n9cdCKUaM9ia2H6QHpYQI4J7tPwOl9tvL/EkZoO7jSTbRY3bjizGC9oTewuyEvvxChWf1EMxXW697npZq8Yl01KPjDHSvxB802kA4uCOW6OLpibI8eHHMcLuU9R2Oh72z9jLvHoJisL445dkqQr4HjsiaikcHE6md+Avxy5/K562mZxV9JTT3RU8CwG5dIn/JBlYYHHYyJXEZ9rqS/FFeaQqIFXGLZ5sCqyQ/kTLxIY6ihP7Tou6LCsjMrSM++HjZ/aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h550DXygibblnVoXIbjJBz++LOsG7ULK7xY/e+ISm0=;
 b=aqotc7AIneUZeya7vvY/z+Y/QJxSfG9QGOvHL2aYN0gafAetfZKiTtAg4KqYvGC2f7RUfEHmeqYuppgwx2wzlA1LrZ45jAWp4Gddps38vfTXNlVw2Hb5ROsNJow369PFYnRx9p8pua1DHqqR0RuZTksmKJrQW42zSVkcpaNSCWq0Vhms8X3Cmg/kw5m++ZX6PhV//6FjpIo7kbsNqIyxY7nGHC4he/DcnFYrUC+B3VqV1y45JbyTVRCmVNC8HmsaUYZGQL9ijbzlDtTUWETHiXBZTGJiCqW9l18jIMprlQAUup/rdNEp5uOvJotoVomMqP1ANwnPf0+nxoyFfHE81g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 05:44:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:44:43 +0000
Message-ID: <6db56416-a470-45a5-9426-efed09a696d8@siemens.com>
Date: Thu, 14 Nov 2024 06:44:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, Nov 13, 2024, UTC 7:00 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992033B790CB6EAAA7BB10F25B2@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB74992033B790CB6EAAA7BB10F25B2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b967a2-423d-4ad8-3a87-08dd046f70d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2FyM2E4dXlodXpsclI2RUMzR210RkU3Mi9mVlFxMVNxL2svYjFrMGlTTjdi?=
 =?utf-8?B?VU95OU03cTV0bVFsbFkrTUJkTEdpTmlVc3htU2NpOWlEa1I2OUxSMDFXdStP?=
 =?utf-8?B?RTJWMUxZdmcvOVRMUHZLQm56RlNXQkpZajBycGlXcHFSVi82SUJ6S2VYdGwv?=
 =?utf-8?B?ZHg0UHBJaVFicXg4SkVremQyMEt1MGQwL1F2MlFNZnFWbldaR1dEYTVudFFh?=
 =?utf-8?B?aCs4SGNqN25XeSsyd1I1Ky83TWZPaXZlNU94a0U2YUVPMzVyVEtyeENkTUc3?=
 =?utf-8?B?ak5jQ1BETjRIZXRMVjFjVFdsL2Q1WFRCeW0rcHY5VklLbFFlaWxaekY0d01x?=
 =?utf-8?B?RDNhbWMrbGozNUpiYXdlRG5QbnBYcHlBSlB4TmFLY3FoWjdxTDQwQzlJUDBY?=
 =?utf-8?B?YUl3d3pkOWVIaFZCdHZOb1RKZnU3alhWeGVQeGF5alpBVm9QcVphaWRWd3BG?=
 =?utf-8?B?dkJUUHJqb0tpRW11UUdNejZhb1hnaVgwLzU1NVVaa3hQWitORzEwZ0syRHhy?=
 =?utf-8?B?emtTa0NSV2xlbVZmSVNvREZqZ3o3aFI3V3hFNEZHbTBpZHdNZ3JZRVZFVEYr?=
 =?utf-8?B?SXluQWwxbnRsczZ2dyszdENROGpQZEtsYkUvaVhPcDJMbTgwYnBXWUd1UC9z?=
 =?utf-8?B?ek1DMHZJT3ZNUEZ3Q29OWEdtWmJFeGdYcFRTMU1jUUU1ZWxnODdtcnRycC9F?=
 =?utf-8?B?UmJjdkNKUk5qVDM2bVVuYnJRWXFRd0Zpbnkwc0FCZFNxbGlGeEtUcnViNjU5?=
 =?utf-8?B?UHMxQ0sxazVhMy9DQmFKeVJ2NEdEdGMrbDVjYU9NY3VOZkgvTHg1N2JwTUFj?=
 =?utf-8?B?NUlwQWNrQmlieUdoWUl3cU9ZSTluWGFXeUhoL3RIWjF3MFd5ZlhQRVM4MXZ0?=
 =?utf-8?B?MG5LOTQ5ODR4R1RtMjBwS3VkWUlzdE9xVCswSC9FdVNPSHZ5UmI4WlFjM1VV?=
 =?utf-8?B?Nis0cE9mRGx0TGt0MVI4Q212cGFTOWdLZjhUM2lacVRTaStvMkp2RkhKQS84?=
 =?utf-8?B?Y0tzdHJTb3JpRFdzL2twRnRvV1NFWkYyamh3Q0lYR3JuT0wyKzhCZFVRWGpy?=
 =?utf-8?B?RkdXTzhCQi84bnQ0dmRVQjVCaVFab0F2bU9wcWdneXBUUE56R0c4SDBpQ08r?=
 =?utf-8?B?NnRKWUoxZVBiSDdzWlZkNGtTdS9XMjhMY2s3UkcrYUFyMDd5ZmhqLzhFK1lH?=
 =?utf-8?B?cmdobVZCMGJ4SEFOR2NkSy9Ba05vbnJqYmh3ajFUU3BiLzN3SWRxVkZYQysy?=
 =?utf-8?B?NXAxYXBCV3JNM09vQWt4c0NaMkduRXlBcVFnak5PSnA2bU9pK0IwWllUL0Q4?=
 =?utf-8?B?TW0rUUlSWUpwZEdGeG1xYnAzTEw1MVdnQVVhck96V3BVbVlCUm9KZEYxamdV?=
 =?utf-8?B?ZlJ1N1U1TGhKSEtBc2F5cFZpNDZyQVFmYURzYjZRVzQvM3dsOHRVZDVXdWpM?=
 =?utf-8?B?MHFhdmhLYzNzVUwyT3cwRWdoaXVlaHFYZ2xNZ0oraWZLV2Z1QlBaTEVzN0tG?=
 =?utf-8?B?OEhBRVErSFN4OXk4RnRGNHdWeVZDR1RhSlZ0RXFuL2R6STZZZGN2bEJqZFk5?=
 =?utf-8?B?M1IwU1VoZkNESlBRU1lTcUdPc2FOU1FTTC84by9UUDJ5VTlSQVA1cGpkN29N?=
 =?utf-8?B?YWdPV0VJdUpJeDB4MWVNc1FDRkQvdzdFQnJEUFVMZ25Gb204clZjUDhIOC8x?=
 =?utf-8?B?L3JqSXlMWmFVdGR2U3cwZUhSQWZ2ZStxaWZ4em1RZmgxQmpPb1Z5NXUybFcy?=
 =?utf-8?Q?mGvotL/X8mhx7TQ4RDZSiubrgk3K7FGUyVXmrZm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhrcHV4NTlMZGg2ZU1EdFh3S3JMeUZXNmNXbWJMYkJITEZkUS8vODhtSUF6?=
 =?utf-8?B?b0g1a3FNV2FJWUJGQVhCZnRJRWlFRVBjWkx4dFF1WDZQTDA1TWxMVmo2VVEr?=
 =?utf-8?B?SUNTMW9vVFBIaUJYeTV3b2tBTkNCeC8xbElaS1U4TVc4MWF1WHd6NGJmT1Y5?=
 =?utf-8?B?NkVOYmtOR2J3SEg5Z09wOXJtMXR5RUYwaExlYUlFMUtVUlU0dFRZYTlOYU1n?=
 =?utf-8?B?QXloS09QSW9QMFd4TThjRzQ4V3I4WUtGc0dPT1Z6TUFNSnRkOGUvNm9pMklD?=
 =?utf-8?B?b090MGpqTVZzL3M3ejBqMndVbGRGZVIwNXM1MGdJeFNTcW9kdEtQd0dURDg0?=
 =?utf-8?B?aFp4Uk8wNFJtbE9jcUl6MHlRdnYrOStPVUJ4a2Jzb09HeEpXcUhnVGVrRmxQ?=
 =?utf-8?B?NUlkaHJpM1JsMU5aTVRTSll3MHJBNzNxWUtyRTF0K3duci9lc2xabEgvRERm?=
 =?utf-8?B?NzNHakxuK1FGdHhOTFlXdzA4a2N6RDNtemI1TFZxMml3eXVhWW85Wk4wRnVl?=
 =?utf-8?B?YVJjcFBsWW1MNHp5L1hhS3QyWkNQS1FoY3pqOGVpQzRXNWdVSTNGS2RPMnNB?=
 =?utf-8?B?aStaYzREbm5wempVOTFzQTh6YkltdDI5cFFXZTFsYjV3bjFOWE8xRHhsWENo?=
 =?utf-8?B?bWhqNmtFNjVqSWViWUtUMG0zMDZvSzBJUFJlbVhsNG0xTFo2S3UydjREMEh5?=
 =?utf-8?B?VmFsREJpTmZTN2tTZk9yQkcrVzJxd1FzLzg5dzRkYlFEL21mV0g5QzAwY0Fp?=
 =?utf-8?B?c3N5cGQvNjZYcVIvdUFleGJVZkZOdmhpbmlobzRaUXNQV0lod3hJbThxc1Ez?=
 =?utf-8?B?ZDlLRjNHeHJVU1JFVjdFRGVVSFRQTGQxT0M1QVV1WlhXc29KS1FCVzh2cTAv?=
 =?utf-8?B?UUZXTTAzYnFlL0VEUWV1N1JSWlZ2d09Udk1ub2FWOHdYM3hGajE4S3hXY3Ja?=
 =?utf-8?B?Yk4yWFlDT2VUalN3bFlndWRpVUFIVUwwOUU3SFFMeDA1d3hZMmxCVUhqb3dl?=
 =?utf-8?B?TUZBRGpwSXhseUtDV29iMDdPNTczdGRYSVdkSndmTFZOcmplNkwxQXRtazdx?=
 =?utf-8?B?Y0ZwUjBQMmJKSHR3KzZxQkJMeUo4K3B4NGxKSndIMmoxd0dBUFlraE5RaWxa?=
 =?utf-8?B?YWhTbnhnUmpWN2JUU2RFbnVGRDFSL2QyMHJLYUU1SXg2RWVoOXNScVNqSmsx?=
 =?utf-8?B?S25rRnVWanRPYTBodldrNFFBTGR4aDlGRVFzcXd1dm44eFpIbHZkU0FJdzBF?=
 =?utf-8?B?UERETyt3eGZRS3hoMGg3d3YvK2NRejVrM09mcTZTQ3k2cjFsVjcyb2IweUNP?=
 =?utf-8?B?Ymdnd09EUDJpZ00vOHRvN1RuSGtkdno3MVZ4VEVnbkpRNUg0ZXpyMlpHK0E3?=
 =?utf-8?B?VjJ5UFIvb21uK29OaUEvNXNINzA2UkEvNjBJUVl0eTliNHUwWlNzMm0yVkx3?=
 =?utf-8?B?Qk9xQ3FWOUhGbnpDV2hjbXhhVGhBZzZrSHhKMUEyUVI3UmpESUVPczV5cUpz?=
 =?utf-8?B?M2FjbWFOOThhSVJmSkozTDJlNDM3UWFkdjZJSTlsNDFpcDNFY0djZjJUSWow?=
 =?utf-8?B?R3hIQW42ckhzRDV6NnFmU2c2bzI2b1hsYjk3U1VrQWt5bWtNeXFIeVUyZjJq?=
 =?utf-8?B?U0Vid1A3MWhYN2U1WGx3VFJkZXJjUWo2NFd3YTgyTmxkQnFqYThOK1JXZ0g3?=
 =?utf-8?B?WldrcDcveFdVUVpDOUl2dlRjYktoTW5JM2lJWFJJSzhITVJrUVZqdFd6Q2tV?=
 =?utf-8?B?YlZ4UnlQK2xDOUtyaXUwTSswQU5yUUJMWUtpVklpajFWTzk2NVRzRzJjM2tW?=
 =?utf-8?B?YXFBWk5wK2NjbWFVcW4vNFRWSUVITEsvNXIvNlJLdGs1L1B0bE9qbzM1VmpR?=
 =?utf-8?B?K0E2b2xXNFNhaU42VWNyYko4KzJ1R2drMUlWVE9DSTNuajhJWm8wT2oyR1du?=
 =?utf-8?B?cnF0aXI4VWpHdk5BQWhPLytnNVg5STQ3TUZkSlhrRythNzdBSWExMW1HbFBa?=
 =?utf-8?B?cEIrclR3d0NsSjB0VVkxQmU5NWdJQmVvT3p5Zk03d3luRVhkY1poNHhwZWZF?=
 =?utf-8?B?WkE4ays5dE9hNThObUErcVFtVnljUWUrUkN6WGt4MjdOYUpMYU5DN3lpNmpa?=
 =?utf-8?Q?lkvcaYPMT+oxdIcHyRW0//BPf?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b967a2-423d-4ad8-3a87-08dd046f70d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:44:43.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGkGgQJ4gLxQ8xIWBEsNg2L07+KA84bKEj4ugNSv1iOkQQ2bl8RZBeU1rFRhU1tLEKAiJSyRRAau/IDKNb+imA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7488

On 14.11.24 03:25, Chen, Hongzhan wrote:
>> -----Original Message-----
>> From: Chen, Hongzhan <hongzhan.chen@intel.com>
>> Sent: Wednesday, November 13, 2024 1:57 PM
>> To: xenomai@lists.linux.dev
>> Subject: Xenomai community call on Wednesday, Nov 13, 2024, UTC 7:00 AM
>>
>>
>> Topics may include but are not limited to upstream/downstream project
>> plans, status updates, and technical discussions. It's an open online
>> meeting that anyone can join and ask questions.
>>
>> Time:
>> Wednesday, Nov 13, 2024, UTC 7:00 AM
>> Paris, France CEST 8:00 AM
>> China CST 3:00 PM
> 
> Let us postpone all subsequent xenomai meetings half an hour to UTC 7:30 AM and shorten to half an hour. Is it OK for you?
> 

Would be fine for me.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
