Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A517541
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706852118; cv=fail; b=VDqB2ozUXK+l3/93ii0pGNEK6g2FgRNTrXGesT1YUaIaDiFswxH/Rr1ksJ9WL6vFzMPj5dm2AkwVmCR9hyBwyhSChgcgZh3ZgM57+kMg4os6MEVXABnWd1KVwcet/dGQx20n4fT9d5vT3ijyWAKwCm3xbNAGiwP0SZJtW0macxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706852118; c=relaxed/simple;
	bh=+Zww3/ppHh69tDimuiRAI3DuLTjjl1/U5WXz984HZAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4RZehPp1BDmpXmPcdsRDl/5UNTPRLi0uLmApjsZUfQNDocwaBoD00vuGH6PGSO/6CvfWY3Z0fk9/jLOGL0AXPlvxgiCZIpZWX67r28d7BMx1YF7GrKPAQumG6ZCWLGb3KbclKNttT34lICzZpefiK6Nu9DmSgjtqmsu1YNJpEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lcMFlX0h; arc=fail smtp.client-ip=40.107.249.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lcMFlX0h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0mt4HTWqSucmIH0uMd8mKy02tgMsYcbmtdEozRQggjNb4G4H0AokY7Rocc/Zk3sxj9HsSd4gBAsXDrC+h1vX/b0ITAkxZKKwXkLj0OuqKhkXDTmaFmV+Mi1YzKPiLeCrmRQT3hi/lpdIoA6BhpF2ahn2Dpanh3TUa3HcdmQFZUpIzlkOhxuDosu61tH1D+S4BzlTm8MK3zBeqSLMQ23zs2GDiHYfI9VR1HXTgwo5zMqbOeJjgDDPK13wRkg2Lj8gdmuLxIoggKCdgjZDArKQ4MCUQgcQHtHhMp1Y0asro4wosKVHG4XfNqsJz6LQt+jDdPWf4GiVC0dgPTIfv8l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHn3kB9FwrKHkw09g1mdxtW6jKjLWY0DZ2GGBp4kvtk=;
 b=FKQRnByKlkJ/MjxlW7oAjxJIlENK+915dUG4QtL3z+Q3dY6K+uFhfkdJ2p+DJ/QihTcmoK/82pdRKslw2e2sSA6pIzyb4lSs1lXCHPEiitSpPIXY4o1dN67LdXB6o8f0hnUkpc1CsNp0J8oV5rNnErbfCyOfRPSV8f70aGQPEui9zZEsIfQzAB6Y42E1A7Kh9+pprWinw25oMERbfyArPnQdudrX3jwrUxwvClnEtZ8/1zBha2YjAqRaEWcM2fA7nstWlsAg9ugHhfAULDXtDKcAvvC6NlFJw71EqlctYzGSDMkbbe3qkIOcDjK2LvtnIiS0u4GF+9TUrgNReg/kBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHn3kB9FwrKHkw09g1mdxtW6jKjLWY0DZ2GGBp4kvtk=;
 b=lcMFlX0hv5UiTSYerjvKRJAlhcN5dFIVDPfpIWVn5EpvSvU1MycvB9QcGpWB+Xki2QmeFGLs6o++kL6PI+WiD1NyTxCz9AxsJCowkPv0jAZ/pcqBF/Niq2OdrZ3kee1TYgNELFA5i+PaHNogA9XmCgauADkakrM5vn8Jel3SoHTiJw/4zk28lWqQuIXSc71+oH+zsJrmoqh0O6gSSyw0pR/KgVYDyEipehp2jH1TAu24OoMjuctsuBmJyTY08t5g3FzQObbU/5ivBeTT0NaMjFW+8lFyUpRX+7QUsXksslqlg6+gP41dUE+2dRCGhGdaDxlxVXTxqQ95ShjZqFdxbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 05:35:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 05:35:12 +0000
Message-ID: <ddfb238b-30ed-4487-8615-091f5c27f2cf@siemens.com>
Date: Fri, 2 Feb 2024 06:35:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-dovetail: Branch v6.6-dovetail1 was removed
Content-Language: en-US
To: "Bezdeka, Florian (T CED OES-DE)" <florian.bezdeka@siemens.com>,
 "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 "Kowalsky, Clara (T CED OES-DE)" <clara.kowalsky@siemens.com>
References: <5ae4513b93b5d14b59940daa604b9caef74fda40.camel@siemens.com>
 <84f36ac3a6e146a3301edc1503f257742af0c7ab.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <84f36ac3a6e146a3301edc1503f257742af0c7ab.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3537:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb3048e-78a4-4653-5289-08dc23b0ba09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	11Rd+erqTkHIpMp7GAkJ1noBlXO9Z//oKPsxnEbDqrh+/JSmDeQHC64zPVQMXZe4LC8QIYS/Wx/5VbvXxIryB3DN1bQu5MDDnWym/auXda+lDnMeJvNJP8I/dJKqcBvQ/LAkDSkM5R8lkBK20HgZxxpzg/lq0PzhqarZJwS6Fsqj7Gv0J1qqAg83WtohRG+B9mbGC6iPvokwk+kUsRJeWkfwQ1kUGwqz48WJRO/mCeEWyFh8KQBC8JdtdyYVRFekcxGOXbPlMk6GH8D6IPaXXvHFxRxS/pCe+qjr8nrco9mr+pEsh1irnlHsZQsMgCr12rNAvONLSZoMgzKzMCYct5pWJkFlnwUiUdO9NL+MIfSYijBZcVa9tyvrEjGzDUqOhQTyLSw2KNK71dfUvlrYTg2dW9gjdIciaxgQGk8LOnL7siX08TC8c5qdC9p2SuHf22QAvuyBbBEe1P/TZU9oU+T6+EueAmXHvvQX4f+vOnZFoNuFx3AfZUz/1ScZlosXmeasle+4X7qFgtmMhhufSUPoUTLz3U9bHXSl1mQFBDVB5JA1taHhZr0/ZWNyi3fNrNTFkwEyejCFXw520N4o6/79Ai3L43IythvhiQGwfBaOSPitEF0g2u2ZloI7SnRjmTzFLJPmRwqSCuSuL4EBgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(6486002)(966005)(41300700001)(478600001)(82960400001)(38100700002)(26005)(6506007)(53546011)(6512007)(66476007)(36756003)(2906002)(44832011)(5660300002)(66556008)(8676002)(8936002)(4326008)(316002)(110136005)(66946007)(86362001)(107886003)(54906003)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlHYnFCRHFxZWhvYVhQcUlZbkRnMmlncUdkbUxpL005eW5mUEZnSGhXKy9X?=
 =?utf-8?B?WGk3TzA1bGpQVXZ6ZzBpSlVIQ09maCtBdlVjS0xLdThVc0V4R0N0YnlQcy9v?=
 =?utf-8?B?Ly9TYmRkQjl2UWRnaURzeERuKzhoL0NTNU4wZ0RkSG13WCtwMXh1T2d4Yjk0?=
 =?utf-8?B?Ky9HbXNpdHZtMHMvVmFGODZGbW92SlhOdFZwR1FkeFJSUUwwWjhLa21KdnB5?=
 =?utf-8?B?cm9vWUt4MEpZN2dpSzNhcWtJY0VzYm9TbERBTE1oc0MvandIbGd2eXYrUnVM?=
 =?utf-8?B?WWx2YTBSY1l4ZFY5TUJwT0ZoeVZtbStIUUZOVzRHZ1p6U0F1U2llUHp0ckYr?=
 =?utf-8?B?UStXOG1ObFF1T1JRNFdjczJtaHNuaSt2MmQ1c3NDQUVnbDZKTEFsMm8zdHpL?=
 =?utf-8?B?MG51WldvREU5S0t0V2ZaS1g4YjdYNlFPS0xvY3dOUkRPdW9WWWRUSlhUSzY5?=
 =?utf-8?B?NS9BT2tsMFZic0FBZUpMZGtPMnhkdVpKNlR1Qmd4aWJPWUdLQnFVK0V3cFpM?=
 =?utf-8?B?L3R5YnpqeW9wMFR5S2lTSldzVXpCVkhuOElNcmRSczIxU0ZZdVpseEVVWVMz?=
 =?utf-8?B?RUFoVnVHTWdmZ0NSSlJlSWFORUNnckI5ZnBoaTVhajhnZXZXYkM3TERFRC9u?=
 =?utf-8?B?YzlvQlVnanRReUdHWE9yWWxWZkE4Y2poM2hOc1hzR2R6VDBoSkw5cFN3M2sw?=
 =?utf-8?B?M2hZdk55dTc4em9zbE1oQTNMMk12c3NOVjMxekZ6eVROU25mT3FONTRqbjRs?=
 =?utf-8?B?cUVIcnZwMkdYRXQ3a2N3RHNUZUgzSGJxc0Q5V3dZZVlScU9ObGM5emhjNHox?=
 =?utf-8?B?eXlzU25oKzliYVRaZTdWMVJoTzAvQ3FHeVpGd05oZmlUUG1WL3JXMGpTd1hj?=
 =?utf-8?B?MFpTcjFETml6Qk4yL3ViSWd4akNlQTBNY3pocitXVnlXY0lEUkdLM1loUlY1?=
 =?utf-8?B?NmlTWVFCeHFtVmxyQ09XOG1ucTcwTGVlUWlIQ1dVTDZadjlOSUE1NEZRNVAv?=
 =?utf-8?B?TWdxVzZ2dHJacFRJVE0rS1p2T1ZMY09qTXRJZkwyd0xKK2tGY0pkMHFxbEZ4?=
 =?utf-8?B?VDRydVF6WFFlV0tFMWVKVUs2bWJJNldTeWUzQWtpbG1pUTYzZUh5TlpPY0d0?=
 =?utf-8?B?aXhiakJpdWt5Y0pMRjBPRDl1YWpCY3pMcHFqMjdIRGlLV1pCYnpGdzBuR1RH?=
 =?utf-8?B?T1FseGpncHZUcW5mWUc2MFprdTF0WHlNMXdZbVp4dCtXbGF0QWRUUTdTRlBG?=
 =?utf-8?B?cFEzM3NEYlJBaC9UaVdLeUtxb3N0bUwvb2ZuekNkS0pueUFhWW1WYTljYzNC?=
 =?utf-8?B?UkVLeEZCcm4zY2RQRlNZODNYa0Q2Q1ZHUzdNSzN1K2J4ZW1JQzBHMlBRWHBS?=
 =?utf-8?B?dk9WRExCcGczTlZpaE1xVU1xaXRCUmlpZVU3SXcwdWsrbzcxOVNsc3Y3czZS?=
 =?utf-8?B?QUtYbUloL2hGWElrV0kwZVpMaHliVElIKzNzUHNrMmZ5UHAvV1V2RnFkZFJs?=
 =?utf-8?B?NngxaGozOXJNMkl2d041dy9vN25waDBBYjVYMXdtaGFUQmlCRW1HUnJ1dHE2?=
 =?utf-8?B?YnNoNy9CYU1zdG5uOURhbFZlY0kyb2F0RjF0NUYvd2FkYllHUzhlRFBUZ21o?=
 =?utf-8?B?MTk1RkpRRGdOb1pMN2xCVGI5ZmtqSGI5WnRGSmhzQkJ2L0lMVEtBSjhTckZJ?=
 =?utf-8?B?RnFBMW9JU1NUT0VMRmcwTUVaY1FtVU51SzZlVDJtS0lIODZmRTFWUnhUdU0z?=
 =?utf-8?B?MWRqeXdPR2EyY0Nhd2wxNVBobDhzMlNKanFmbTFUa0JsTzhkV0tyQitqTSsw?=
 =?utf-8?B?QUExVWI0MXJSeUZaa1oyOGlVNW1iZGZPS1pCSGJWQS9mWjRUZ0dZb0Nlemtx?=
 =?utf-8?B?bCtMM05tMCt6aVRxRjd4VFlwSUhCSHVlU3lhclVNMkdaOW9scjVrbFNpSUtt?=
 =?utf-8?B?Z00ybDFKa2twalMyRnBTMHNydXRCTlVBMnYwMkVGckdTZTJGZkZtWnVwblo3?=
 =?utf-8?B?MXRVSHhDc3RocDF4b0ZwSjU5UE5GWndRVTBkMGduWEVrTTZFRU4yWmRJdW1i?=
 =?utf-8?B?T2srZHVSaTgrVzFXaU0vUVd5Q1R2U05SRkxjNVpvcklURHZ6dXdrem5GOW82?=
 =?utf-8?B?R3VDVG1NMGJUeFdEUjd0WHFxNC83UDh2ZWJKTmtCYVZmVzRzYUxoNzRJZlo3?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb3048e-78a4-4653-5289-08dc23b0ba09
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 05:35:12.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkfDRQwqCYF/AlstLASvsMPLhYSdD2P9J4pKY0JWza8aDrnNts9IauEtH2c6IM6l6ADAS5m25xBg8wmog3gRnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3537

On 01.02.24 23:36, Bezdeka, Florian (T CED OES-DE) wrote:
> As this was merged to master now we seem to have a regression...
> 
> [Resend with list in CC]
> 
> On Wed, 2024-01-24 at 14:22 +0100, Florian Bezdeka wrote:
>> Hi all,
>>
>> this patch [1] in xenomai images - which I cannot find on the list -
>> references a branch named "v6.6-dovetail1" which does not exist.
>>

This is not supposed to be a branch but a tag. I had to create it while
starting the v6.6.y-dovetail branch. Fixed now in that repo.

That said, it would be good to refresh v6.6.y soon. Upstream is at
v6.6.15, we are at v6.6.

Jan

>> According to the project history on source.denx.de this branch never
>> existed, so I assume that kas cmdlines using opt-linux-6.6.yml were
>> never working.
>>
>> That brings me to the following question: How to fix that? For 6.6
>> there is no non -rebase branch available yet. Why is that? No plans to
>> maintain 6.6 as merge branch as we did for 5.10 and newer?
>>
>> [1] https://source.denx.de/Xenomai/xenomai-images/-/commit/3305ab5b3593b01dc08c59e170ac98be1f83f634
>>
>> Best regards,
>> Florian
> 

-- 
Siemens AG, Technology
Linux Expert Center

