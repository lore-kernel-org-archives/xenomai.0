Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4836B19
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:42:24 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 508CA80002
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:42:22 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60e])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 60C4A74003E
	for <xenomai@xenomai.org>; Tue, 19 Sep 2023 13:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyXxi1H5mxGXFNqgAViBiFUKyyiGPVVy+J+W0zsVRTZybviUbxJ0zSdPCm/LTo94R1E4IvGypnjj22bvzNUpKigj7p7XZdd0aIElkSEbBJGfut7j5Du4EMYhton2r2/D+UicYW0VmWicLoRg9bu90631IbaJJCgjgHfyrLkXU7smp9vIFIbSolzJabmzVn7M2jGlEqHtqnCzMwQVqS9QsRfrmBEd7ADjegYkWgYYjsBVqOZdbkHo2gBKBLVsQg0IrWYx7rkRXZDpMlgO6LYX+ldKKmUg7pjy/kN6bwGOe897nqIrT7crUqxxyuJNY1PVB+grgIyjcA2xR7HrEjoKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V5qMV/j355XujLhi+kH+sduIrOFHrGC+aWY4ZiwT2E=;
 b=DIxDn45+7CKvSM6ETJs5gNQaeyNnRwWlvYAC0IFnI/uplhtQM66ucbgM+Vne4m/HpLDcEWOXPGTF1ANDB6aeiaIHLSehKR2lrRWpVq7HOqmD2Cj/aWvf3DcBRadOYs4gpReql4L2VDOK65Kc0zlwNa4ue0+WWySzQx9tYO8WxWuuKJZ+ejlBLbxsQ+u0yLa19h1az4rJo6BQE4nMWjr67zchBUFomf0aDxkPyldrtnwIV1DjoH8yM55Hzb17tpBv/Xlm87R/hRVl8M4HVTPWqZpcMmCFgpi+/Qkf1CfTOkb9z/Jp/RcicIYWbfhSxfzuPt/N3qES/65wIHnOkmHCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V5qMV/j355XujLhi+kH+sduIrOFHrGC+aWY4ZiwT2E=;
 b=ACKr+1XKsOP+xpzDJwqFw0sm+a0XG5XVTvJL2WWOhFBSvzyU1KYR6JujIfW186W1RLpvE5LxZIcqtLnFba+SKQ9Xv3F5j9QhgZWsTqpz9HLMm2z8xfD8LQn/0i45XM5ukUT3zCROqNeGBXhqgiDL+GdIb+rykJQ9ruZJftYcVEju6HjU1v2687Ux3ysPAzhVZ4wBWfnK5M9l8enaf/a8B+BYEhMdIwWVO1V0c9rK7ky11IM6jSXLKT8GjoPJf/zfmqSmY8/9XaJKbN98KawjDTDbwtG5VGwGfX+QMcLzyFqdE+yZ+Pgag9Jeph2EedNxrqGn7PQ+4XkJsBhEKdRJNQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 13:42:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Tue, 19 Sep 2023
 13:42:19 +0000
Message-ID: <08509b51-fa6e-466f-8974-b88d0c63644a@siemens.com>
Date: Tue, 19 Sep 2023 15:42:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai.org download access broken ?
Content-Language: en-US
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
References: <CAFc1U0sNjB52q=9pNQ_G6o6R07GJTPJtYZs-AHh9Oe0PVXkzwQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFc1U0sNjB52q=9pNQ_G6o6R07GJTPJtYZs-AHh9Oe0PVXkzwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 661a233b-69f2-448b-21ec-08dbb9163eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8prRqw5nSagOjPCLqegMM3I0Aopv4yRmFciA97hx6cBa5or/ClXE8kYo6OhM51dv2P98JqIbQAtrSW7XzPjmVhENj2QJ4PYZpbzgk+3fl+R/vXdazPNX0m04SuAF051h7tkHFjbKMpn5/pGiWTQlavPaSBcbKYCu4Z2gJ1elJWzooPnSVt9NUoFI73qGlRvXhNUsQvcMSTpZAkyLPoZ8YZhgAuWL7yZJ4vu4hrkiqZD+yGp9ihd6DGN1BNOYM8bBofuoceQutHSQjHMoLnFifD1uN4n/Qky1QFH7bIAqIpFcBzVDlGIPr5UzpLkSSUP3kF0wQU5QAs4C8vGzZmMJiCKDELk8GXCvmWnBNj68b/G/Zz2f1UIAvrLVoQmEqGYaA3ThAm90jCKDt2dA1VuU0P9O5O7YFiQlvL/LlaZ8BKcs/NV+xwQLCrIDMG1/KTAcly/PaciO/liv7TyYx+G4DYFk/3/FU+Wai3x3rT3cmJA2snl/tADXbpDeIFAAThDg3cipvleMYDa2CtVjTg6WViqV28oAbv4tlU+x8rCebFkV+iKj9hfdMvorWMr2fTYNPHrG5rsOqsMMNIOlSmo18wEaBEinHRFZ6A8/VG2zeicZgcWzz9ifmdcYEaLP7Okv1ZUqEHu7rnSbiAV69PPOrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(53546011)(41300700001)(31686004)(8936002)(8676002)(44832011)(4744005)(110136005)(5660300002)(66946007)(66476007)(66556008)(2906002)(316002)(82960400001)(38100700002)(83380400001)(3480700007)(2616005)(966005)(26005)(86362001)(478600001)(36756003)(6512007)(6506007)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUZPU0RkeXF3SmR0Zjdaczc3OTVpTiszdmdrUVRiZ2VXMkIxNUJYOURET1lJ?=
 =?utf-8?B?MkZ0MWVQRFYvSDc1Q080NEN3MnY4Q0V6R3BPcTVMOWdEdEFYbmFiTGtxSXMz?=
 =?utf-8?B?L3dJYlZCb2xDQkwxSUdrUUFPdzFNdC9rQ3pHY1QybWVjazZoOUxtdGpGYnpa?=
 =?utf-8?B?eEs1a3AyT0pxT2lnRXUzeGNTNHBJaXlFY0xrbTlWZHo2QkVVV3Z0R2xNWHZ3?=
 =?utf-8?B?Q3hzbFgyV1ZtR3luN052T0VmY0IwSmhadG83TXo4b2htcVRia0xnSk1uUS9C?=
 =?utf-8?B?cG9yRGpwSW9UdDI1OUdSd1k0WVVPL2hibjBmSHNhMUM2WGtsY1dyb2pVYXIx?=
 =?utf-8?B?K0dZWDg3UjhvdnM5eWNGMHBPNnQvZ3NLTDM1UzZBQkJjcmNzTmNSUWJQNzdG?=
 =?utf-8?B?N1EzbUplZ3VsVUVNYXRienFRVTYzUUE0S0Y0TGpkV2hicmxodTZ6R2ZzVkwr?=
 =?utf-8?B?SHFxbDVSK3VIeXBBV0VGLytjRzlQby9VcHl6OVZ1Y1B5TUxhQjhYYkRlWGp3?=
 =?utf-8?B?Z1ZmT0tTdE1JRmtqbHdaZ0hGdXRMbVE5U2Z6MEVOQ1RvZ2FORFJxWU1Jc3Nn?=
 =?utf-8?B?aGJwVlN2OHU2MlMvRW1kN3VrVEtOYk5SMjIyem5LaXRIeHIwU0w5bTVNYU8x?=
 =?utf-8?B?Ny8zOElUUDJIbmk2MHRNUEI1NHJWalpkSEZNby9xeGZnbGdHNTJ2WnR3OHhQ?=
 =?utf-8?B?SHBKdWhuT05zZjd1L2ZQT3RXRVpwTy83TnQzOGF6TU1MbHpDOFpvZVRLdlNh?=
 =?utf-8?B?SHYwaklkVGI3d0U0WklJTzNNNG50Y2ZiWGlpWVpwclZMM3JtWU9ocFZvVldx?=
 =?utf-8?B?NnNUQzlxT1RUMTJoY0F6NXFJUTFRaldnQm5mMkpNY2FBZVVXd3QzZjhmSi82?=
 =?utf-8?B?TThmWlhCYmVScHRWTVdCaktRcFJWWGFRMnJaR0hpM0hLY2xlbm5qcFg4Mk0z?=
 =?utf-8?B?NjZqdTM5djd5NC9id3N5R0NEZ0FSc1IxMlJrajEvUENMVlFPVVVrYktJbFFM?=
 =?utf-8?B?dEtaSU9oRVE1akxnaEtoK0dhMkxTV2ROQjJwcHNkL25QdjF4UXZRNncwMFhJ?=
 =?utf-8?B?TVBNV3ozaFFwS1ltaWRWK2tXUDFVU1FDcm9EU2NTSHh6K2RRNXJQd0JaSjRZ?=
 =?utf-8?B?WU03bVcwZ3Vsd01VVnBQYm1reFE2dE5VV1hscHdiM1pnT1lOSjBxK1J2NDhW?=
 =?utf-8?B?WXp2SmI2c2t1clc1K25kdDMzN0YwVkJsYmhIY3BSU25SRWtOVkxYMUhXanNj?=
 =?utf-8?B?d3EwcXRid2ZvZm9GOVJIWnFIdThWeldMUEtVWFZwR0FEYmZDQjRLanN0ZDJk?=
 =?utf-8?B?WEpEUVNDN2EvR1pESFVCdDluZk5GcDhDdEY3ajdRR0t0djQyOTVpSHB2MVJv?=
 =?utf-8?B?NjhOeG1YYWpkQUYvR0FoSXZ1encyQ1ltMEh2cVVjanVONVpUVmdGK3lHQVRx?=
 =?utf-8?B?TGJsRitINEVOTDdoY0JISlBkZk8xMEI3MTRoNXEvNWo3ZkpNbFVGczhVbW54?=
 =?utf-8?B?MDcrN0dPa1NiajVlMys1bU1qcFcwN3dqZDBXM2x4Y1A2UDlUaDNHOG05MU5l?=
 =?utf-8?B?Qm1XKy84SVhOcmIyMVdqZ3RXL1hFTDAzY3VwSzdBSmNFU3JrVEl4RituYzJX?=
 =?utf-8?B?c3E0YllEUUFlTGlpUFFkSFpvVDFVY2JDeXI0UmhSUndBQXpxaVY2MVdDaGgw?=
 =?utf-8?B?ZytEb0xFVm1mZWVDL3liaUZYVVN5cnd4Z2ZPVnVCWW9xM3NTcWtVeGU4dmhE?=
 =?utf-8?B?YmdsUXNNL2o2R1U5WVZyTlBVSFk1ZGFZQ0NaTUFiV0xGU0phU2JlaHp1ait0?=
 =?utf-8?B?dWxnak1DdGh6cGVNTEtTbDF3WFhWUzVPc20wUHpwZy9VUVkrRXpPU3ZjZm9q?=
 =?utf-8?B?QXZLOVJYTDNnSExtRzRBK0g5bHFUQkt5cS95cjZQTnIwcmJRRmF5b2VtRXhQ?=
 =?utf-8?B?ZnZDVG1XYVNrY09VTVk3N2xxaEZ1ejkrZlRNdnBQZ1VLKysvcGNRU1ZMQ0wy?=
 =?utf-8?B?TnBtcFFOTGtRM09CVFdVZWNQamxKTk1UaWxpMzJSME1WODVGeVEyWk5obzJj?=
 =?utf-8?B?QkVOb2ZoYlhLanYzamYrckp2RGpCMmdwdU95UndpVk5GVnkyS1I5aHdkbUYv?=
 =?utf-8?B?VU82LzlhbTJWWjhqbFkza0o5OVJCVUxNTWpnTTNRbUUzZW1QQ0JsSjljRXBW?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661a233b-69f2-448b-21ec-08dbb9163eb7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:42:19.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtezJnm/ydG8kXZR8LPmS1FED+GJ22GwvBk/NDv4SVKodPy8JSUzDeCIMyJsJ7RYTmz76L3hKo1GCFnUiJ78vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5793
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=ACKr+1XK;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0e::60e as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 19.09.23 15:23, Pierre FICHEUX wrote:
> Hi all,
> 
> It looks like the xenomai.org download links  used in the wiki page are broken.
>  (https://source.denx.de/Xenomai/xenomai/-/wikis/home).
> 
> https://xenomai.org/downloads/ipipe
> https://xenomai.org/gitlab/ipipe-arm
> ...

Wiki-based homepage has been superseded by https://xenomai.org, see
https://lore.kernel.org/xenomai/878r9atwev.fsf@xenomai.org/T/#u

Historic downloads are in https://ftp.denx.de/pub/xenomai/ (we are
looking into setting aliased for the old links), newer downloads can be
done directly from git.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

