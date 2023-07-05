Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2033.outbound.protection.outlook.com [40.92.19.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C34EA5
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 05:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YecbBK3cs7rhAUgoSzK16EKN5lK2Qy0jgE6tu7F+K+T4F8gn4dwCe+9qG9rvc3vGbgaxlkEyDckp3YRJexxu6ebiVjkhMKXlPz88IerSJSDbObpxQe9FXphdsvEs1gPXjKuuQ7QsS5xJ+uaHxpr30VJrmsJ5xbJ3/Ls8B4sFEiuuHDZP9Yfl/tEAyRdgCYfTT1WCuk4DjCQwth7z7sJzjiwHjLMGoCLva7lp+u9mSE23ZE6Fcq57bhlncOdkq+D64iVIGeRfzwnO6CrSycLNjtC3ufTU4+aYXIaVvcc21+XRi/UZjGdPsGWTmZfNY0MMOUCnzkwX0zfDRAmwBcZJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg+n0962v1UBKPFViDft+wz/JNKHIgwmhi0cOOcE9Qk=;
 b=QBpitq3PXYESC5AvszGcxXugaOO3eygbjug5AGTnzBLbbYYd/yd9+fymLHK80N3jyp3MbHQwXJH9uO4y/DtC3Sd+qPMgrIZ1NbfRHkvoSVaAzNEbz4RFKFpCJdyZCpxKmK/3t+k7LSO2utjQDUJaWREz2G2mW4pLTsiEkhbhfDV8S9L19XwRnKTm7XkeZD1Kd5WFAlADErZu0+6wWymyS6PzgisqKWSn5+yue2u79LjYVQlaKqgPHDUxIQvTHAcSPuaWfzRl4zSY83UXRO7veYtlYMzAYrPKpFPKPQMgc3JPcktcTvWmCIDbuA8DFbni7II3LOkG8/EBOI3MFtuKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg+n0962v1UBKPFViDft+wz/JNKHIgwmhi0cOOcE9Qk=;
 b=IHIQnrONgvzJac+ZHBGkIpMqReqcPprS8mM1b/N8mxCJ11tq1ZSW2bR/Uepx0C9vP74Mz1WBNyZdk37T6jGaAo/s71kizBHFgCyJmhwZ6QGRUIsk3VJK4RJjmvWrvV5WF+VGjjiSL7r8pdMkC/VhZk6SiL1AD1awN9VObp3mWBfrpUUGRnh7VWCY2iiAgkvEOuRNMFbdURKG79C7tYF9yQ0luh8HjgWYdDcyidDfv7rrYdTIt+Mbt2Z7A5NKMli6EAlpqSW8X2d4EOZWAdFXUu1wyOztKgxg5+GdtcqmIMzANUTkenhII/oSzkguVOD4vwbX/bt9wFhaGcS/CsY3fw==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by IA0PR14MB6836.namprd14.prod.outlook.com (2603:10b6:208:3df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:27:43 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a025:91b1:1913:417a]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a025:91b1:1913:417a%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 05:27:43 +0000
From: yo sang <stlfatboy@hotmail.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: dovetail kernel build fail on 6.1
Thread-Topic: dovetail kernel build fail on 6.1
Thread-Index: Admu6+Kvk/Z/9NIqS0O8NFG4gKze/AAFV4NA
Date: Wed, 5 Jul 2023 05:27:43 +0000
Message-ID:
 <DM6PR14MB3871F74C7C44DB95CAA1C6C0A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
References:
 <DM6PR14MB38719DD14CE4CBF6F612C036A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
In-Reply-To:
 <DM6PR14MB38719DD14CE4CBF6F612C036A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [UuN2WaXJNWHY7ZGGZX9/ZB69SfgLgrMz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR14MB3871:EE_|IA0PR14MB6836:EE_
x-ms-office365-filtering-correlation-id: 2cb2ddfd-ddd9-48f4-89db-08db7d188ec9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ax550OOaEFh4rqlZwIczdCU6dN9PDnI2SczWz0qIGXpW8cvUbum+uURXoSYOYRQd00uss6N1KDyvT5cXUm5ojALUthbj0/SbDGqYXfrN/6BFA86rU48ZseLjBHXaJP8/qTav2yt5Bhfpq5EXRgzJZKgl7qyHgCx9gD8i1ACKKDi7GjzzvzQ8ZKwlOEXy+7FpZXlt7J/DdqQSGVE5PUpSLjtzXsGEzPKn+YTQE+Fk8RGrju3ZzEKLkFxUhZy69XmhSBHkbFkHzMJt/0MkpE4pNgIIujbAe/HWNkRnWMvDWp6ISj71h3Nhwuw7nX9KNYDSZbkIlqgizcKJmhdR//WEFHHA0K8wqWalw71odlj7CrG7Zg2g5/iUAK6dTV5M6u6XsPzK5qYpM8Ik884KOb1y4KieLSrE6oJBJ1p8C6IHU9S31yAP8Crb+WHyjfUzclZIdmwP374XyITPIjetryPsWy7zb95y5GseFtqrE6xeEMDAVqyFoXwtW5tflCHhqBM29Rw9+Es6ESEI/+q834P4cbgwySYlgZubk7/0KZ+3iTmiJwljy/5hm+KMQsmkRYD8dwIyKK8+CvsRYCsdeV/Q8Lu2l+V9VyEBVhYkliWFOS56SOL3mSHVM3yV1J/RbP0kOsfSo7kBPi0CbS3+Hwv2WQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AnS6RRlOYkUVhDGiDCBnBkfdCJzvO1dxmSEAuUpSZflxKlBOD2Gcb2POmf?=
 =?iso-8859-1?Q?/oOtQLUo6+YpN/lTHnIxCwYlnA05cqoMp+swNrCRcad/nxIxqCS9800MNB?=
 =?iso-8859-1?Q?h/XipMC9tKvrp7D8lMs0VHLX2y3ZWLuB2sYmyBu0C4jXxCINBJPTE72A+o?=
 =?iso-8859-1?Q?ZhYhUEWl4QHq2RB2hGlc9+LMdhYuhrgZ0Z7lry2KsR0d6NCdi+2nEmYZU1?=
 =?iso-8859-1?Q?cIA/gw6ouiJTmsizVdljdTUlewKYDPovSIVLaZpHbWYbxjptQMjzy/EP0w?=
 =?iso-8859-1?Q?qLNpiEH+/exHA1FE9qSPW5+WMmLGdRE3z0rUb/5uQN5apUVZuxWqE1KLEk?=
 =?iso-8859-1?Q?l1C5+Hee4A6WWxZq2u5E6CQ/vE/EXkV6G+XlFoirRnLRXo1aeR4NSoEoa7?=
 =?iso-8859-1?Q?5bm5WWR9cPC0FErSzmk3rPejKxRGvsRQPlVGr62QUDah47AmuYAZ1KIAaa?=
 =?iso-8859-1?Q?PMK3nhSasAbTw+jGApa9nJDqvbsNSJPUXu2mHxKS3aiUke+Q75iqekdkgq?=
 =?iso-8859-1?Q?PfCVGjy+nSM9TDiMGnXAEAvmQwCSwT0ggpCG8JMsnHCfiTtNlk5mGBx6ID?=
 =?iso-8859-1?Q?d00ek/yVCHJzjIEcMLIUhxlpy0eBo0pJ5qy3UNY5Zd73W/11pAw9BNWFAF?=
 =?iso-8859-1?Q?Kj8EVr3/y2QRzCYKtKS987VAvAyyiL5G/KBAIlWWpEo2+FU0+AvOIkeUap?=
 =?iso-8859-1?Q?PnbwLYWNV+Vb/dKdmcaxZk1iSTzFDmOhEFZaxGqJdKj6AzID0rjYqh7YG0?=
 =?iso-8859-1?Q?CVH+dPU3h9cp8uVu6X3esna838MvwVOfBkN9m20z2KmN/308Se9ous80JD?=
 =?iso-8859-1?Q?N+u19phcTiglfS94vCBljyl2+F3Y3UGgmTUzq+TGuhPnbz1cvjTk0B4QTs?=
 =?iso-8859-1?Q?rGKjigOW3deINFdzUfnUshGjPPLgT2es4SyCeff9RjaUxQAq2MRtLUGc7a?=
 =?iso-8859-1?Q?qh2eKe1OPKGbVB1hRfNe0q71RN9kAteDfzNhBf5OmvtXBJHoApc7aHa0Hu?=
 =?iso-8859-1?Q?0SaOw/yOo1f8TIgp/mJycwkgBuC65rnmKva89BE3WH4jZ8FQpRsH1demSq?=
 =?iso-8859-1?Q?Wh6o8wOo8KJvzvNQ/ON5QzaJlA4/bXkg6TGkpnxXAUq8FqScSPDoRMCpWx?=
 =?iso-8859-1?Q?XszCCvD7iqwy/ged0qofTGAQwBLj01CcVaLyE/KsgYMeXMJGpU+NyDGwDo?=
 =?iso-8859-1?Q?EGYxm4wBvuVjm54Pcpi1xY5LlEBPs5sA7Wd4EUrI3ts0DkttmJN0zCVOgM?=
 =?iso-8859-1?Q?466ZYXY5DtEiM9uYC9/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR14MB3871.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb2ddfd-ddd9-48f4-89db-08db7d188ec9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 05:27:43.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6836

Hi, All

=A0=A0=A0=A0=A0=A0 I am trying switching to 6.1 from 5.10. It's ok when bui=
ld with xenomai v3.2.3 + dovetail v5.10.179, but failed using same xenomai =
version + dovetail v6.1.34 (building in released Debian bookworm with gcc 1=
2.2)

In file included from ./include/asm-generic/xenomai/syscall.h:26,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ./arch/x86/xenomai/do=
vetail/include/asm/xenomai/syscall.h:24,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ./include/xenomai/pip=
eline/pipeline.h:12,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ./include/xenomai/cob=
alt/kernel/lock.h:26,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ./include/xenomai/cob=
alt/kernel/sched.h:23,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ./arch/x86/include/do=
vetail/irq.h:12,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from kernel/irq/pipeline.c=
:16:
./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error: asm/f=
pu/internal.h: No such file or directory
=A0=A0 44 | #include <asm/fpu/internal.h>
=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~~~~~~~
compilation terminated.


Any help is appreciated!
bryan
