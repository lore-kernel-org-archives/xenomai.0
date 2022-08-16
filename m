Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937802F26
	for <xenomai@lists.linux.dev>; Tue, 16 Aug 2022 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660641821; x=1692177821;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=O8Gm/Rx1q333mG+/dqrfuFKVE8gRIhCaOOI4Zfnn+U4=;
  b=fPUkC2MVzSetbcDLR0DSTJNByDd0Gz0e5SPRPxAoJF9SOA2Bb4JC/hMO
   ZmQBnJRKU5p68I3vk+nBeii0G6JOH65r6XRAFjP1yudy2FNZOqmcJJZsh
   15hxVnvspryOWDbmPfYQCWjHAZZ+F5hVy1Cf1hEvRPWGo1ihfSrGtjoaU
   v9eqprMv35DaPLqw3QvVTOb8ZGt0iR+3Lk2zdcd2V/n5TV86xCSF6+yrB
   5kqWphfemsWjS/kjjCIS8AzfuXoKVVFx3SeosuAm6nHPjY+HQEBv7/d69
   SsEzC6aCcwL9fiTjKxHP2FFz1cDvdWmVF8pmJIlZ0JFbJq95viTKuGYl8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279132485"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279132485"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667032330"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 02:23:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 02:23:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 02:23:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 02:23:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 02:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eicEV8G8c5bWmaeyKS6Ax7PuolxJvP5DB2c7DA9/2af6QSCSCd2bCENiYDe8ZY9byr4wgJfiy2ARAeW9pMH2pbPrH2whJVSWafHSKXMck8j8+MncQ7Hxa+EjSX7qsMzYb/Bb5IMiYlpYjo57Z0KoATtVaQEWOZRCeHd3jli0c6+8Udvvscn/nc1lRR4oVpb0hX17aSrbDQE1ZkIqIqJJcWtBw1VkhpA7Sc9+IDYnW44Ox/YwcQgaTM4BlLcuNWwHzwgJ0nY8eJOe3/lSiSiJgK6bSdMNHJ77vurXaHMlUNQfW7BpX0ZXeu+qw/xZyaWM2tFLtLHK6mMYe280vY1lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8Gm/Rx1q333mG+/dqrfuFKVE8gRIhCaOOI4Zfnn+U4=;
 b=X34rOJ18e+1mvyE1q7G5rTsXZwZucjy6llygdcPhLg1SKDXggZR+Zy/Il7hiHUzMT4V1UAaAuXHEtCxbgYx+QdmiMMmWJo5PduOc1mOqvNLSHeaUlioUueepkIfR80J4a6bFhWuOtptJM0Hz4YL56+0VVEajYDLHFeRJ3NN4ZrqomECo2peOh6RLfzXrEITi6D/vCpfgcyrPbGilhn6dvAdgm9foYHaKBgqj0YyroFHpzxqvUGhJABNXhVr3K7Loey7Tl5WXmspe1n8+dIAVVudhdbtcNW2MIMuNdo18qgiFK33SQ5tnO7maMl4ZChB4hn+6CudNiJu+2O+bjKKf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB4091.namprd11.prod.outlook.com (2603:10b6:5:197::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 09:23:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9%7]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 09:23:36 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: How to verify TDMA functionality
Thread-Topic: How to verify TDMA functionality
Thread-Index: AdixUGkDtIsLDsdcSkOPEgRM7zP2pA==
Date: Tue, 16 Aug 2022 09:23:36 +0000
Message-ID: <PH0PR11MB58806E719662A0AB0C6697F2DA6B9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74a3e2c7-cea7-41c0-512e-08da7f68ff65
x-ms-traffictypediagnostic: DM6PR11MB4091:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WeNb3SDF2ljlSolBvubJTLOjpyMR6ePT90JRVmrWtUPApCuwKxtJWzWFUmRc3c3h9D/9Fa0SFax7mP38ZOSpQYybTaI1MnpledNdsYT2wQR76W5Ro5nWCNIL5cw0buBaWJ1i98RNE37J9Lx6qeNS/F8dHNilh8V+5DfkRp8YheI1XGxLx1fc6ZSWiN6eoDtY1PDFClzbCZQVlLK+IG9g4UWV2DjGgXI2bd7ZiiS9cS1u6YX5u8MDs/8/7kH2P22FqooqZ1q5iwO8dPtuPCI4BdKySzjpgyo4jjxjGExwaTOu08/lFosXuB3Av8vypCbAUUVs8XBc1T6hJF2vyDPT0eIENhTD/PYbgXpO24Zyn1oUxYamRs72wxeXEfq8yXCfEBZ7PksAP/zncUYPGxjKVAVSvBydaYozFQW20QCOVo4d2U+SuibkhZHNcoQ7Qux822EQtOV0/4yi35bLF+92L+mMGkoATKCFfAfPklgV5S0MdbE+PJiLp2f/qaemn5+jrDzGKaInaM7fHMEUiUVyPJQxffUgw4v4+N9T2O5/dUHOaGcH2LhG7yAiORHC+gdehnNdTjPvvXCflW8dQG/xQxDnGqb2UexDszjw69n1+eaClHeroihqGl40Z6BbcOTxZRg34RvfATFa3xS6htetPqnft7og4+3SEn9/yNz8fLNqeDJkzlMuyxLSjN3tkb8XYcECtDkTnsX6gRN5zImaoJrWPK3GwLG9QaQoWU94yDO/h+bBW8xmjH0pXj+MW9wUKPJOKRH73e8JOcIzDafdPEvf57eF7nUVpadj2PW4FeQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(66946007)(41300700001)(66476007)(2906002)(76116006)(66446008)(4326008)(8676002)(316002)(86362001)(478600001)(33656002)(82960400001)(38070700005)(6916009)(64756008)(71200400001)(52536014)(5660300002)(122000001)(66556008)(55016003)(8936002)(38100700002)(6506007)(26005)(7696005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XWc58FgY12KmmpzIILEufmpeLRr8qUduaC2eSMKDoapoKfAJVw/suPjlHxEc?=
 =?us-ascii?Q?4qyJM+fJ5XKxLV/89feCBFIFovP5ve2bN8WEy8OJ4nYZ+RsK8WAkME3d7iC1?=
 =?us-ascii?Q?3QFkWnfDXrP42pp+4djZ7JYdD09PmDcU1hBwCHl5JDZ7wCqPzsB3ioZ/ywd9?=
 =?us-ascii?Q?E3M3dhZ4oKfyDDKC0lZLIujea1G+UJEUuZ889xff0UUCjnm881uywZk8x3jq?=
 =?us-ascii?Q?XXSfa7a2eWX0zY7lT8dhQlOgWKSks3jCFteKhNaddUAz0Ugg9lM1G1oXF7jg?=
 =?us-ascii?Q?CPm7CPViUW9ivQZTR4sQtoTDYNu02Z85Sct+4TBVpInDz4tviO//H5iSMzoU?=
 =?us-ascii?Q?px5q1kftkXtdGINTd/235zf+FQfG3z6hj304uhKKmmZvgKIIIWHwEs5DvvnM?=
 =?us-ascii?Q?8w0Gby46qmKSjT//AqcYxNmSz01irIaralvzqheCZ9NUjiT2azHoELrBmeAR?=
 =?us-ascii?Q?KjsnLQBZurB7GE/rDhyoJafnnY/35eKBguW6cltSC6X+GbQ3GBt7LZc3MJX/?=
 =?us-ascii?Q?NiDSOXfKVEIOm13lDOdPNtjQdeSopGSfcMzMRoQA9OFzLXcuLoJlu+6e7mDp?=
 =?us-ascii?Q?Q0NwXfIm9CyfWpQ7X1uecmmxvjEkCqsT2Cd73IyACqmKLW+OP7WApcKtS34P?=
 =?us-ascii?Q?k8HdL0GbTusDsJIlISDj4aVmChX/G53oXknsabB5Lfl+1oiKcMpXnJlwLO6S?=
 =?us-ascii?Q?Oz53O/L+ZQtdiiWTYXOYQmW/fGs5YAiZc6s9itfSIOl4BxZyFkck+f0I+SfR?=
 =?us-ascii?Q?3io3HBKvhnwEXstrrd3iGeXZEM65u/FqDA2qFFZOzaVXr3v0dSPEh/4xeUSJ?=
 =?us-ascii?Q?yoGSkk9eAFgG13e7PlSHx7gRQqRJ+0JFNEHJotd8sYuEMKb1X9oIr+kJRMCH?=
 =?us-ascii?Q?4zegBn9mXo94IKbFFVxX4OCjq93txXOzUyRh5qnrlhYdUcwLBRv9/Iiu/O8A?=
 =?us-ascii?Q?4o7A2uSskgXmsi+0kkDP9U2BNSC5xOmfvFHbalSuVchYfLvlv4nZ6tr5Xcwc?=
 =?us-ascii?Q?uH8OObYEF8WLqYu1qvgxP3BY8kY/p2930v1qadRaWBFLtchNjNzEAtER+HUX?=
 =?us-ascii?Q?lNepT0Yt/lfQJhWDkckeFyZoFLucz8RKMgrK/Jj9bHPkHMoW0QRMkO6XvYkE?=
 =?us-ascii?Q?U6qF0Hbgy0SFMPxHlJfwY+PPaQThUGNcNLTE8QkivVwsoSAaocNGVvnnyMR1?=
 =?us-ascii?Q?NlurYCLaGT3c0u3GINfIfkJ98PELiTqk7JYiEp1TfbZ/0eEadRtpRqTASLel?=
 =?us-ascii?Q?8KigdGHTfwy+nCk9vQEXvEGq8moIZPnJ6Y+tF+pdIsMRZsSfLE8JkgTMacdg?=
 =?us-ascii?Q?UXuec06ILNjwjovH7UpstXU2dXJXWEualag/QIRuDGoX+a4uYjWOiAmLeUBd?=
 =?us-ascii?Q?TUHibp9hMAlUd5938IAQjfaLqRaP6aPTAQAroMu7xSvWM6Tzhm3oL+Hi3WL/?=
 =?us-ascii?Q?zveLobz/oDMsJ6xOxK9Ux998Xy8vdXZe0+a77sCf9kXmDoXpqR3ro95vBcFc?=
 =?us-ascii?Q?h7yDwGCqwwhazaRnz4srGcpzKhAfScSW4wF4c53869S3Xlt6Mw/wCMceR2VL?=
 =?us-ascii?Q?fY/b1Tl9xLkLNtO4NFN+O9t+g1JDVus3sIZ3ZqZo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a3e2c7-cea7-41c0-512e-08da7f68ff65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 09:23:36.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 366KYtkHByyC1dpOxxjppurv6u64MQ3jzrwqH8QuTJdnp/Jq9qwjN61xPB3jIfVAFaTs02CNrRuoHJkK6bVhqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4091
X-OriginatorOrg: intel.com

Hi Jan

I have enabled the TDMA function on the server and client side=20
respectively(execute the rtnet start command successfully in server and cli=
ent)

Are there any relevant smokey test cases to test TDMA functionality or how =
to test?


Thanks
Zqiang


The content of the configuration file of rtnet is as follows:

server rtnet.conf:

IPADDR=3D"192.208.1.100"
NETMASK=3D""

Start realtime loopback device ("yes" or "no")
RT_LOOPBACK=3D"yes"

Use the following RTnet protocol drivers
RT_PROTOCOLS=3D"udp packet"

Start capturing interface ("yes" or "no")
RTCAP=3D"no"

STAGE_2_SRC=3D""

Stage 2 config data destination file (slave mode only)
STAGE_2_DST=3D""

Command to be executed after stage 2 phase (slave mode only)
STAGE_2_CMDS=3D""

TDMA mode of the station ("master" or "slave")

Start backup masters in slave mode, it will then be switched to master

mode automatically during startup.
TDMA_MODE=3D"master"

Master parameters

Simple setup: List of TDMA slaves
TDMA_SLAVES=3D"192.208.1.101"

Simple setup: Cycle time in microsecond
TDMA_CYCLE=3D"5000"

Simple setup: Offset in microsecond between TDMA slots
TDMA_OFFSET=3D"200"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

slave rtnet.conf:

IPADDR=3D"192.208.1.101"
NETMASK=3D""

Start realtime loopback device ("yes" or "no")
RT_LOOPBACK=3D"yes"

Use the following RTnet protocol drivers
RT_PROTOCOLS=3D"udp packet"

Start capturing interface ("yes" or "no")
RTCAP=3D"no"

STAGE_2_SRC=3D""

Stage 2 config data destination file (slave mode only)
STAGE_2_DST=3D""

Command to be executed after stage 2 phase (slave mode only)
STAGE_2_CMDS=3D""

=20

TDMA mode of the station ("master" or "slave")

Start backup masters in slave mode, it will then be switched to master

mode automatically during startup.
TDMA_MODE=3D"slave"

Simple setup: Cycle time in microsecond
TDMA_CYCLE=3D"5000"

Simple setup: Offset in microsecond between TDMA slots
TDMA_OFFSET=3D"200"
