Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173E33D6
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659077713; x=1690613713;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sQ8SDx9p1VgD1xRxoRSEYveyfs6FYZ2z1ZfaOKAIhJI=;
  b=hHY9ym84ua+5dk8jzYpYBh9bVwe6eba3exaafaw5o/kf1n+FmPwZ61vE
   uOEGM2mR43jd+xhcm+WIDBHymZNqqOZgEJIhdy94WUDqpGON24pWDnnyd
   H0CtI0vt6r+wDQmUHqj6yCcgFsUToTA7/aWYpFazadoDYm1LJafijOfKZ
   O7agrQnlbqFCXPvmHCUXdthqWDndmMaBgT0CUBIFRQ8WBKtyaVq82YClF
   dWlxEXKZ6XtdfWXiI0yI0bQPdApwXinzmMIMX4SKcsM3kOdPG+a4gfptC
   +01E+mOAmjqNiiN9SLR721uPscND/YOyPSZHiBj4vfLDqfb62OTXRJaNW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="350412766"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="350412766"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="669181233"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 23:55:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 23:55:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 23:55:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 23:55:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 23:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPT//IafshM/HtU+utxlYtzi8AaDaxvoEaUnAz8aQW+umtOFSjfvCghfu3HubSFogDjl2ANjXvXelE5k+6t1yItHTYbYOwJoMY0kaj0cjQPZVsLa8x3BW0UrUAWSMGkseWpLfcDIvtR410oBV2Dp7cKlOfCJ+xXqgHW3f3jrT00J/yf9+Mxq5UzZu2ts/pGrUHuh3tVpBJHCZDzlZW2cRh8Lm0gVjnj6iTSyH8AH1NXWIESaOXvLCk1PyvPltK3stngdl0LK67BvfrS5oMCyaNq6xsPjLKkR4nCed+Kiv1YXHRS0YrQojaF6UaWPeLbME7ca86tJ/S7kBv3x2ugi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JBnyu3Bkb632xlLbCdV9yXvFo6cv/AUX7MUWs0fdFg=;
 b=I6UgS1E+mKILiJKT2xwFq9BUCSv/YN/LReOAyJofqGMyUefSlv+xSLekYjRWcK9L+X7flT96UJTQhYc/b+DU1VQ63a5xpChbdPpE3RJot9V/t1DJeMqOX5iQ+5R/Nhf+tg3VYovBV540/9DfDf3QiFu1pan1z7zW0mtK4PsZPMJjp+9uMPe07MS292o94bNaCZ5A5h6GbKZErnuOcgX3e1I43QKPL0lTysjb9PM8ECFesJBsLAFgnDT7fmOPLo/HxjUlUeVv1ryVcQRPD0+XF6eJxhtFBwsfp9kaQcJRQtv5dt27DrCrqbTQIm7mkX5ZtULDE+D8SGSKlKi1tNKbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 06:55:04 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5%4]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 06:55:04 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: would we merge tag v5.10.131 into v5.10.y-dovetail and also tag
 v5.10.131-dovetail for it?
Thread-Topic: would we merge tag v5.10.131 into v5.10.y-dovetail and also tag
 v5.10.131-dovetail for it?
Thread-Index: AdijFgQ8HUM7PWqmRiWyVKhFvpW9dQ==
Date: Fri, 29 Jul 2022 06:55:04 +0000
Message-ID: <MN2PR11MB428507EC01AE358D7369CDAEF2999@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9dec3d0-c4da-4d04-ff04-08da712f4424
x-ms-traffictypediagnostic: MW4PR11MB6617:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59H1kH6Lt6x1g6dC8mRdoLnaMzFE7Q+EAFOu8ck+M1KTKSAvFiAD58JLr3DwKMmkrxvFx6tw+4ibM8ZzOy9vOigcrHY4S4So9bvekXiE7okSIjL/Bye8SU7vJw0bYRsfwK2tRZ7vq/dLOaVO9OB5+b7ElJfzNyS1CKcdKcf9XZkoW15eMrXyZydao/cZ76//e0LOpBFIQBxdBklieyhVaAFJU235J5Onw/Yh4kk82avwILTmHysXdUgsW6aSdBbAkNz5jWEsmt3FmHxbTsRZOkoeIiZERTi2xhDhd1BTBZUqHmYAoSe8PbJDaiTrbWii3nOFAOb8szyqBVDuK7DA+NxMubMdAzN3BcJKLLjkSZTxgnsshy3W1OT8Lip9oYZJ/glFTWgwW94uC7rf2LJ2o0CIsvQ4AYqnRE1+5fxtH5RSGVUdwheraxvW5GHqVfE/VDqqmBVswdRKOqMoq2Ngei5D/K5K96QNUwJODZqZNBWWwfuYHp0/TzajMfRqEmawLjG0PDmvvC/DtXNslqEFJLGiqRYcLRB4CJlM+hSutZwKGwqgLBQxDccRAUrOOttIH0dG+pQeZXMhtR/b/CIVRphTxL7U3d6XhhL7F0WkK4gN7LAwvqqCExX1YkCKdN3sF3OswEPSNhVInzLJxTbw1WfHcn8sD1QKjO0eibYzGAAs/RacqVwM5Z5Bw2saM2K6lrS2wE9LqCNbTHDdFs9VXoC0ini6BUTiWzTk7tDph2zdCh7nXAZz4XTFeRCUVqk8NFCpflcyhInfE+0BoS2Is5uGhuAX1xtZHLLPIM9L8evDjRumf1DVqK9oSULAMypx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(376002)(136003)(4744005)(66446008)(33656002)(64756008)(8936002)(2906002)(55016003)(66946007)(316002)(478600001)(6916009)(66556008)(8676002)(71200400001)(38070700005)(76116006)(66476007)(6506007)(82960400001)(86362001)(41300700001)(9686003)(26005)(52536014)(5660300002)(38100700002)(186003)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdcsvjCxIeDU/mTyNUv2ubJAhZYC5RFxqVh/aZbuhfxC+6HjfC0qBThDNT+X?=
 =?us-ascii?Q?1w5Hl9SNrLVlOXauBrmRq9VzCZIBShBZlyzn947AhpWps+EstJWmMIpaWo51?=
 =?us-ascii?Q?KuC5UsNlMo1UBoTOUvGsxsqv8cNdY9FbHd7Y8MmSGzHgllD3YigZwIbYespy?=
 =?us-ascii?Q?T7+LTX4cYOeUruxDlUEJw46KTNSU6qVBCQfU96nOgHoJJB/r7bWZO4x7vASE?=
 =?us-ascii?Q?XhAdprg6u2gqv5TIpxGgdkjwmIveMGhgSYUnF4tzDo2dKoI4lRk0VB0iR6Cy?=
 =?us-ascii?Q?r/qZgWEQAiWSH2vp37T/p7kA6T7Vzdij0Qs5sC6i0MRkPMWf4G4uN8UY9ZxJ?=
 =?us-ascii?Q?j4tgICvZtrCIbWtF49HAxGCQ3LLmH5dYNmqEcpHH84OEHVRBj3qYIbFkbQXV?=
 =?us-ascii?Q?aYbNiXE6yyz7GYUevcvg216xyaXK10VTQxaHjaKizxgKucmq150Oyp+0FkRb?=
 =?us-ascii?Q?FT7TVBmQPnP4AgkLKbShHQdsicMYtJ5Cu8CjsEAevmVpG9a2O9by7aHI2Tqe?=
 =?us-ascii?Q?6+viYgvB1vaqsvZCUfqFYFtIaSuNLteLI97Ekca+UXEn9qjZ2oeaaImhZDQM?=
 =?us-ascii?Q?F9zxrRKGhZbVKGQgUkg41U9rpAGrbrRiCO7Q9cG17C6Ozs1aJamlr1sepafT?=
 =?us-ascii?Q?F4K2uHM7BUDusIXDCxzOEzChXn27w6HQKbQwbG53UEuSA2v0HU3NH6+P0Nkl?=
 =?us-ascii?Q?M1P6nsTKTC/HC9aRlfgCN58LvZYn6SPf+5GIlHw7qK8gofx/C8iwmqsqQOSI?=
 =?us-ascii?Q?D8bF45EIa6G/BJmwaQrunlAsUqUzSdi8cAIagmGD51Lb5TKmX6zK6Yt2DjC7?=
 =?us-ascii?Q?offSLQE0+oBY9mGe6311syhkkK+vaDpk3GWUyumyiEw3KwDk+cLLeBFJO9eY?=
 =?us-ascii?Q?mhxM11NklXD6TzyO7omvvN4rsRGxliCZYBgTU3AXMNN/QEyEcmt0tqYAoUOE?=
 =?us-ascii?Q?r5F/6V7PZifbCJCv60JMgN7sg48/7yTSRaqnUtF8Y4V7OtpMi5sWc/KCHVrN?=
 =?us-ascii?Q?+pEnOw7jnsPpTpDd9KBdFABoNpmgp/fjJ6xFopXmw53BNF/NDjqZWOardeX8?=
 =?us-ascii?Q?uMVxqW2yPLSxmXXaxU6G2ukcpVoLIAtZXIX6qeNbFfKHtrcJS24Z23dw9pjc?=
 =?us-ascii?Q?08yfWlhs/r14XX9d40vaxUPvXQVgr03kPTLag3gQA0LE2D0R2/V1SsEdU0+r?=
 =?us-ascii?Q?Nwm8j4rrh/HOIP55lVtbn+GlO1KxEnO0ejIm4F79dsbCxBjfsYDf1KK78eLl?=
 =?us-ascii?Q?qwAvvpjdrgULUW5M7Ofy61kapdrunxa7Vpfnc0VwjpYKEWDtqLTmC5TtHP+6?=
 =?us-ascii?Q?Jz80IuvYBn4VdvuEhDCeziZEOO9AWUYAMQu+KnrJdCGTMNfSoC6HUkoWVUAd?=
 =?us-ascii?Q?rJgcej4Gu1AciV1IXRMDJ4//Dd/ke5OiuK7DCBRbSI3mqL++0VF/ibfIbh9F?=
 =?us-ascii?Q?wTRcOLEIyFhDdrUVSluIPUf25SLq2ybby+N9yCsXbhxLryWPH8Iiq2t9yYSE?=
 =?us-ascii?Q?1RM07NHkRLY+3dA0pgF7VWb6e6ceXy31LDPSwizKI/zEy07ZkeCvd6GeTopg?=
 =?us-ascii?Q?hpoQL/sU8LexgEYt/aCkJvBH1hs6UH5X6IOUKKWw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dec3d0-c4da-4d04-ff04-08da712f4424
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 06:55:04.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0xVhzafVKP9HXpeiJCxcv6A3roWHwjEij1iFXEDrP19F0BmiSEG2JnBU8ufoMS7sXeTHO7sL303ozNLSdgXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com

Hi Jan

Would we merge tag v5.10.131 into v5.10.y-dovetail and also tag v5.10.131-d=
ovetail for it?=20
I am asking this because we will base on v5.10.131 to do some internal rele=
ase.
If community can provide tag v5.10.131-dovetail for v5.10.y-dovetail,  it w=
ould be more convenient for  us
to merge code based on it in case there is confliction.


Regards

Hongzhan Chen

