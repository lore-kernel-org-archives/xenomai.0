Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE6339AC
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160432; cv=fail; b=bit+kiTwLdBWRg5SuVOTRNr5/RiwaapzZC93yq26oRosC6D9wfdAPtcJDteZ+QIaOcP/6+QrhZTNAVJEYUdoagQsgaOFkEiV8qkYcjHBLudi5uklf753K3JD5WP/9wex7tUvtjcDeT0aFwkOGyPPaQEDYF0UwLGD45xs5gVUTSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160432; c=relaxed/simple;
	bh=PlgMTuIKyXbUR5UgztEhwRPUnKylkgnPHycX1jX6dfE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m8uVspqmz67c8+mb0g7GJbfCVMiJ3yezfkkqVjQ+T+ok4NZRRI8l/p+Ht6alAwwUUlpoLS80lghXlg1vZSYicKu/kOPlNkQyPyf2zFkC/m1T5jXcMRDCGNJGOur9dE8NxVuD+nTKrSaH74N2uYhc5r9dCPf2j4yRwGHjRZuGTdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oPTVh0JH; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oPTVh0JH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPN/UVAdS8vhxaYBctdRsS2TWt+WPoldUvDJfsPNnK8V3+9dMHl8C2qwEuFHUalPEXzo0ElWR4gqgk4Hbpn7Z0zFziIqkSIruz5JChbep3VB3lfApytkYjR9JU7NjMMi9talOgiW0BFOajBBLT8ecArcKS0BgkjDJ390KfJH/DsP0CWNjN8zQZfPsADkmBgVs+mhi3d0L2Komn+frEjRUQk5Jj4r6X8awOrfA2AMIFWLSoFa8clsKIT1ybc9NxdlMGYsnY6xXFvCncLO6gzryImBZlsQ70JV+WhSKK255nXSEZIqmNvkivkKqrO2Rx77EdbkVru6sxMM2UiP5BXS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jotJUSKOs8qBfqwvUfVe23HZC7WpWH+AUI5FJ8YwCfI=;
 b=l5F8eNVW85KdQ8Iw5iqSGelreQ2WV/gi+lPTsKpqkRmzdKXrihxnoC01awfxn39XKHUnRxVAtLnroyKLh0R7vfq01a4Bn2n3KE7R14Ut6NEO+CVlmzuVgeX2YHn1Ca174CPAQ0iU8AVg0NEzG++FIQW24pI2Zw/KqljjkH+o4k3wk/wkDbbBY28CFAH/oY/ParqKKApCVMDXInE+otKl+bA48zYxUUFOYZ2BXvWDm+yUf6A/jq992gA7C66fENYbgQDOhsX1A0mNjDHcxPmMKbg2hf4x1AceDQhj6kojG2lgy6JqCqy6QaisB4S0tWjlEYRL5oZMnZKyY8Sq7qiBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jotJUSKOs8qBfqwvUfVe23HZC7WpWH+AUI5FJ8YwCfI=;
 b=oPTVh0JH41VNx3XRJQjyBqpdIV/k4jNani2cTa3qfcZqwdOBaKVXJT/ysodiLpYIJx3/rplCpMdw7oPvzvA8hb4EDouqtw9LfhvubRPe8Cx6xFrovbckkMsn9No+H9n7kltnFtoBiujY4R+hHa5WjXzeN0nc1u0fo2ClVIiJxLdKVqI2rx4Or1TBosXqaFdB7uD5ZGz73I1cN7wI1N5LvDFfPSwzLTSVHFIUfMQAkl8k3QtMwdXbaMgT6l8AQ5O6PBOd8T/9/FjVVIHK+JgoS1sOsZTWJrBlmfeQCeG8i0IzxzjCllDPBgeb0CSExMMBj8fb8CKL4z0oVfLkRDxtSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 13:00:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 13:00:26 +0000
Message-ID: <5f546c94-440f-4641-9549-f6c27652caf7@siemens.com>
Date: Fri, 31 May 2024 15:00:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dowload URL for ipipe patches?
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Norbert Lange <nolange79@gmail.com>, xenomai@lists.linux.dev
References: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
 <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 525b1896-22bb-42fc-f1f0-08dc8171a3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmUwWnEvUTg2aTI1TkZwbnVRaGV1OXVOZCt6RjV2cE5ZZGVKaHhrem84VDZi?=
 =?utf-8?B?QUxaWnhVdWsxTUVibUM5bVZORHdmNUt4NTgzdG9lN3l3d2VjdEk3UGxaRnVn?=
 =?utf-8?B?SXVsczJqaHVqZWUxVUd5Mm0ySWZGUktWQXM0NzE3bUg3M1J1Smp6RFkweDIz?=
 =?utf-8?B?OHcwMVUzeEI4MVhOb2xqbEVQWHdmWVFmY1diL1NzOHdaU1kyT1RQREQwVGo5?=
 =?utf-8?B?M0dXWlp3NmpXV1dyeGZ1UEs4ZDJ3RmxIS0xxem1WQWN0Q2l0Ym1UeGd0STNs?=
 =?utf-8?B?YXNSQyt1cmJBVHdBZ2s5R2pnVmcxcjlMNlNrL2xuQ2JaUy91QWQ2WmFUNnJK?=
 =?utf-8?B?cDduNGI5ckNzbGlNMEFVL3ZTZjVrbEVBNkluRDVxUzlLU1crZ3NuaU51aldZ?=
 =?utf-8?B?Slk3SU5pVmlFMkNpL29rYkl6VjRBTzQrc1VRWENRNzBYRFBiTW9oV01LZ0ts?=
 =?utf-8?B?NVpBVy9UazJOVitXZjJLNmM5UUloRTloaVl2WEdhNHpvZTRVSlJsWmNHUzM2?=
 =?utf-8?B?cHlNUXE5dGJRMlkvdDZSQTlLQUY4ZzdscGUyQW5pemdJTi9BZkp3OGQ2QzlN?=
 =?utf-8?B?NWdaSFNmQkZoR0thNG55VlZueXRuOVN6bDl5YzBvSEhOQk0rTmdOcjVLc0FZ?=
 =?utf-8?B?R0QzNEVaNHJWUXd1WElFSGxjS1prMkZ5TG8zNFdFZ24xRW5xZlJ4S3ZRZk83?=
 =?utf-8?B?MldsTjhEcGZBeDlObXZ5a1FmbHRkWk9NUzVQbUpMeGIyaFZqV1FSaVNtRk9u?=
 =?utf-8?B?K3lkUTYzOFFLRitjenNPQ2IxUE5TcmdFL3NQTjk5VzZMYmhONk1zWFY3S0s1?=
 =?utf-8?B?WS9QZlcyWjVhTTlzdDVJdDNWMTNKYW1FZkhESWlyMkM0c2hGY0l2NTJ0eGpm?=
 =?utf-8?B?dmFMQkx3WGdLa21Sck5xRkJkbk82RFpHZEw1T3Ntdmp1SVNmNndTV0JaOVk2?=
 =?utf-8?B?Ykp5aUJnMW0yRUN3RW9wS2ltNVhjTS9yK3dPK1NGZ083eVBVdUpFdTE3N25y?=
 =?utf-8?B?YmpWa2R2dTdIVzBKcjJ3RDJHd0JEdEVhOWxOTFJyUVdDeHJ1dnQ2b0d1SEdG?=
 =?utf-8?B?WG5HMjYyZEJmUmJqcmoycTlHUm84V0JuYVNPeHYvbVNYSG9GUmlTSkpzdlk5?=
 =?utf-8?B?cloxbTM0Mk1QZXB6MG5XNS9ZMHBOWXd5bS9CeStmckE1OVRlVzB3cCtweXFp?=
 =?utf-8?B?cG9ESUxxT2FHaENtVXBCYU5OUWUxZWcyTFFrdUdSbVhiRTRXS0lGK3BNR0Q4?=
 =?utf-8?B?UlROSzZiTUhrK2c5N3FtQmRhbks0RzFYWFZwQXdLK1Bjb2JyMU00MDJHUkJP?=
 =?utf-8?B?ek9OU0w3R0xTMUZydFBuS1p6aDJQL2M0QnArL25qRnhxVVZhWTY1UHFKTmY1?=
 =?utf-8?B?VStnaFRuTHBhOEk5eDJwajlFUUU1YmEvTHVFRDBiSDJ1ZmUxT2JPeG40cXEx?=
 =?utf-8?B?aGZtVGVPVzNlcHpzNktoakxBaS9sbkFqdENPZWU1NVZSU0RWc3NsVlYwQmk4?=
 =?utf-8?B?OUFMQStDSk5kUTI5MmM4WUR1YkFyeEdtZEc1U1BSdzJjMXNUc1M5MWx0eWlm?=
 =?utf-8?B?YWFJdXdHS0pnUTdRZHMvOGd3cVYrU0Z6Q28yWnhST2RRUnhTNW1aRHV5clVn?=
 =?utf-8?B?b2ZTcjR4THRrU09PWGZLUFhvNWtRLzEreGN4dTN3eVRFNy8rSFUvWnN0a2hU?=
 =?utf-8?B?M1FkbTV3ZlliTHRUOE9uQUpsajhCVWNyd0RVVmNKKzJYT2p5VnZLMWRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1PSU9XdU5PRzkrYjVqcXk5dE1BT3dFQXI3cDVtcHMvUGRQbWU1eG1EQjNL?=
 =?utf-8?B?QzNEeHNlTmhPem12ckROK0F0aVVkaW00WFI5bWEwejhBNkFPQ0tpL08wZ243?=
 =?utf-8?B?aEZqYVBGS1JwN2tBNkR3QkdBVHBzMTFpSmdqNHBiNjYzUitURFBkMHpUZnlW?=
 =?utf-8?B?eU9IUUFTblVVbi9SYzRtb0ZHYit0SGJhRXgwS2hYRGExS3lCYVl4bTV3OG1j?=
 =?utf-8?B?cDVja2lvVEhZQW9FYVQzdFdxb1pma1Y0dVU2U2FDazQxcTJyVEljOGtVdE5S?=
 =?utf-8?B?blhCbjU5bUNZSmp3eGFVT2dqNS8zbC9JeDRNdVhjaUMvSTV6QW5HSzlxVEkv?=
 =?utf-8?B?U3YvZDZWNmIwQ2FqTWlNRHB2Vm4wQkZLaHhOQTZiMFR4ZUt3ZGpXT1IwVzVV?=
 =?utf-8?B?VXJjZW80dUMwdU9BLzVxVkowTnd0eXpuSDRQWUNxbG83SW9zSDlZamRJM01B?=
 =?utf-8?B?aWxkQXFCcndOdk80YTFBMTdHN3dMclFURXF1YzVTUlFDd2FXOFpGd3VPcHEy?=
 =?utf-8?B?eWxEYUNOQ243K3kwN2tnY0pMRTlKNitDc3ZtN29UbXYyUExoQlptNndrQkhX?=
 =?utf-8?B?c3lEaHVjUVRwT2NibEVIKy9XUDRpTzByNFlFODZIWStUa05nVmlOdVBNbDNR?=
 =?utf-8?B?ek4velRpMFhYU2cxMlJ2TC9LS1ViRW1pbzFzNkg4TnR0Y01RVVhrV2k1QzF6?=
 =?utf-8?B?YzVaYVRJUzhTZkNGZkVHS09heStaWGFyLzNwUkErb0RmNHRjTWx1N2ZDNEht?=
 =?utf-8?B?NkpOTmZuRUZYZW52VEE5TFFkaVVXbDFjNW9TTVptMmR5T21YeXBpcTRlYWhG?=
 =?utf-8?B?aDZKbWhHOTBGVGxBL29OUkNweHRZREp2eGNzVXVCMjJuWU1BanBQOTUybVFQ?=
 =?utf-8?B?M1d3ZlF6VFZsUldBa3JES1ZqRnVaUmdHOTJRaUJwSTVEU1hlVG12b0VWSXIy?=
 =?utf-8?B?dlp6bUxUQTBqT3JBYm1iUXVtS3h6TWxJMGNwc3JiTTQyQXlwMFJUSVhxRHcy?=
 =?utf-8?B?M2lQNG95cDdyUXdHcWhtUTBOaEZkZjRBRUpRaXhjd1Z4bks4SFJFMHM5TFFP?=
 =?utf-8?B?TjJkZnhDaU9CZjhWVUpOdDh3QTArQkltQUhHRW5GZS9vRDJzUU40Q2dPZHVa?=
 =?utf-8?B?VVpvbzAwSTBUVFNrb2JrcENNWmp3V3pIREFSa3lVMjBJTnd2ZnI2SkN3N2VY?=
 =?utf-8?B?dWxBN2NEbEJJMTZHSjFNREllVURQQkIzaEg3UEJ5VTRZWlg4VmFUWThtQUdB?=
 =?utf-8?B?VXFpMlJIc0FZUG40RFZCSThKM1Z5MXRoNGhGV1QySFFxNkJwdG9LNTl0bGJY?=
 =?utf-8?B?WXBmcjJOemJUeUU0UTBDdkFrUjRYeXJ4eVhyQ3BWYkhMclBzc0JwRlZXYnlZ?=
 =?utf-8?B?R2kwUXZPeEs1YXpKbjlyYmxlcXF6TzVET1JUTkw0YVZVS1ZiNjVpVEI1eUhQ?=
 =?utf-8?B?VUlSdlFJVU1PODdFdzZTNUNxKy9CR0g4UUxHa2J4Y2VDb2NHdzROQzNPclFB?=
 =?utf-8?B?UjZIMGUzZjNSN2ZsRnNDWFlCUjVWZFgvbitkanBGTytWZ2FUalplSzF4Y3Zw?=
 =?utf-8?B?WWFUR2J5cHduak00cmVEeFc0b1RtWmpMb3o5ZGpPWCszL3JrUXJHY0JrU0xC?=
 =?utf-8?B?L0JZYzEzSCtsZ2M5UDI1N3pHVGtOZ09uUGpiK0JETm1KbDkrQkU2L3UxcVBz?=
 =?utf-8?B?eXZVRmVSQlY4WmhOVFpHdDgvVkEwOXRUN0pyQU14N2cvaXBJTGtqOUpSZUZl?=
 =?utf-8?B?RHR0WFJydGxZc2lscFJLY2lRaUVicHQrczV0WE9hTjlZckw3VGFwbWJNUHVu?=
 =?utf-8?B?cU5tZjBtYlR6VzBIVUlsUFRuM2VXQTJxcjRwNUFzVFBGOEcrYllodmpTT2Yy?=
 =?utf-8?B?bWVTeUt4QmJIbm5JWkxTeHRoSmpjYXdFUXBxdytwTndFQXN1WTMxYXlVdnJm?=
 =?utf-8?B?QXN5bHhJNzI5bFdlZ0JpYUI4VzdNYUNvZXlPalZIZ2RJYTFBOWlKbFY4Tjdt?=
 =?utf-8?B?TlpOT1BFWExmQXFDMFdIWFdkbjlNS2wzYXd1UVAwUHU3VEVnemVZYmhmaVdo?=
 =?utf-8?B?Z21DUHlXanB6L1luVHF6dytNRWdvZmNXc0loQzgzWEw5NHVJazFBSDRObmV4?=
 =?utf-8?Q?s50kkq3IAgiRTrr2/Ay8DvwiC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525b1896-22bb-42fc-f1f0-08dc8171a3e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 13:00:26.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSGyP7TOlkxEIMUur5gPQbRMIAEnLJCDquttGLUKmSFEgGZq/ztRTs4YwSEc1gQK/Trbj3BjGK4C/ZdmlK3aXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7808

On 31.05.24 09:11, Florian Bezdeka wrote:
> Hi Norbert,
> 
> On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
>> Hello,
>>
>> the older URL's dont work, and I did not find any reference to the
>> replacement, even rather recent releases have non-working URLs [0].
>> So the links dont work, and the gitlab repository doesnt offer them
>> either, eg  [1].
>>
>> Whats the plan going forward?
> 
> the main point is: I-Pipe is "dead" / in maintenance only mode. The
> last supported Linux version was 5.4. We have dovetail for modern
> kernels, so the way forward is "use dovetail".
> 
> That said, we have a downloads archive [2] here. That might help to
> some degree, "newer" I-Pipe versions are available through the
> architecture specific ipipe git repositories, so no "ready for
> download" patches anymore (as far as I know). For x86 it's [3].
> 

Right, we are no longer having infrastructure in place to format those
individual patches and push them somewhere on a static page. None of
that is technically impossible, but given the current demand for
restoring this (you are the first to ask for it, TBH), we were not very
motivated to do the required work (likely more than some hour on a rainy
Friday afternoon).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

