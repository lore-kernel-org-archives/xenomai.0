Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE86A23
	for <xenomai@lists.linux.dev>; Wed, 27 Jul 2022 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658910801; x=1690446801;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=k8s82xa6M9Xg1FjSNnDaVo5R3y/WyccwwE/6v5imo8E=;
  b=OaQ/1hpDSiJsTTe7sg/1h6Lh7hZ+RpgG3WFKQfD7Xyov/Md+cakA9drE
   IHZM/oSyPYzFGst4ejqjo8EBnepAwjn5bcmrV2um3MYi3faoqkqDRMTTH
   qdGznrA+WyQ1IJhF2rFqZMU/NxWl2eaxGJhNzhc56WEe3GVt6TOAXX82i
   e8yakYvTaZkGRYFvupH4tSr2LrmEgpJPLrqp2L4T7solQBI990EKpa9Kp
   Vqjoc3yh0GNYbK8j5FcYMyR2NVK5FBGimvvyFlTwxxyCJopiqpKviZiPT
   k2j+Q6kzyTfVcDFIjuUO1Ju1X3JvyKCPy0psL6KWVoS8a94vjp7AbiMp6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288189383"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="288189383"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="600331524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2022 01:33:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 01:33:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 01:33:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 01:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjUCo3MgtRzJoTFJoFFVdcBx74/9f4e/x+lEyPYR0RymY8PyPW8VqhaaqE28y4jnttWb9TtejghwKI29/8rTO0hrZ2pBPHqaMfHHo2+JG7xdRw6hXRxWmoV15DCSGCMRJxSDUcHZ89JJT/MW73wBlgbv7usN3t5uHqxE58UnI50e8MBTozx/UUiZyIoVXPReWItfV0ZyTMnc83GesRzvrvfO2YCdRlHyFeDki3atRV3Inolns3b3C7PUHhCjDJzU767LxTJLpPJrpxg54UAfKy5MMLOrv5AyRugHzlUsfiNDjPDOsYtEdaFkiCLlQ8Sy+6PCupVcTB4zQAzzs/159A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb0zpljoPBYSvUCd/xtmMrlfrhrI7iuaWZqOFYIhFgA=;
 b=KQqYr3Awis381d1s4vPQRlD29mi5OdKg8bk6B2PT41HNkq93l0rVS5KW5uupaROS6rJryF5gfZ7Q5q0KHRLPMVBXOYWQKIg5YhYb7Mx5o7rPy0WxBjdH+Zb0yF004FVrL9KnrDr/l+KXDLbtzTxN/7rsRikbB/zfDX7OfTHGP6/AsSvWkdg8N1BaETqI6n2AWrv61v9yZxBKGDPQVA3PpPQUNKjVSb+5Tq1tZ/R1PPtHuliSyrekssfu/Q5Dw+GwtJ5C9yA7Ayw9YDNUrwOQJ9hbgt6RVqjwxFN7L9WP+2rjnIbTXgX+zLuiqVdaYp22Ih2FAEkpaaS0NvMpl8QawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Wed, 27 Jul 2022 08:33:19 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 08:33:19 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jul 27, 2022
Thread-Topic: Xenomai Community Call Minutes - Jul 27, 2022
Thread-Index: Adihk3pu8wvcSGbzR/Ohx4eE2+fIog==
Date: Wed, 27 Jul 2022 08:33:19 +0000
Message-ID: <MN2PR11MB428547AECC16C672E6850020F2979@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f1bd0ea8-b9f4-4ffe-590d-08da6faaa8a1
x-ms-traffictypediagnostic: DS7PR11MB6126:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwsRnqywjjieo/foTaxbK7479SvabArKkmwvl4OY/xoamJf5XF0de1blxN9m3+rHCe6yvSGjj6q+6I7LSEKgqjzidHHPSttWlEShAp42Iy3IVb90diaw/dGf8xYU0hvqUzCMLZa7WaY9ZYvFfQwi5af7UutUwrP+qtgqvJkzo8GNjz5vg4FWtY9r6cbBSTlpvTWrPsf8prsSGAAdbsNv4Ccc6cHNDNarORsv/XdfwJaQexP/b+xuV7QOnCqI/+KgIhJ8l5n384Bn0Jam/Fd6xjrNzxoC3PMRNEOMxLZRnLT2VkNbCHabX37M5JFo/0COKVShPX2PXCnTfmDKybUNHsxC+BOl1ADL+RsHNRBxePptwibwUVIN5+IS16eaJ6Yc3dT+pe7BAF8aXgBH+q9DIs4xVaCcJrdfR+h+ZQPUJBKURgh/46YKr8tvu1lLdh0SK72evzKOSw0GiI/jT0Tr/j8j7dmVnta+rh8pdKE+Acdj/Ge5yGAIYM2S9OB+03BFm+YvclSRZN9IGUnWjxt96TA46Ankpaidf7b77SCScIYMPc5pkJ5EdWQ4PBNxz9/1ETPzLs63FA/yqypkkdd1zHI7WmI4p7kU+a7SQtNEbWAczREFZHtUhzAcWAP7gS5adEdiFqh6rpCG2O8vzeHYgfcPq4jcsDzLrTPvCfltMg1IoPbJUA3H54CfgyQJhUXCT4v035DwgMdrlJ2MGlxV0dbTGWEE+bE+XkzypST32RmjP2aRDvhoXt9PoZ0bt1QQtR7Jwg4oa7F8+fTP1P7WeDlorWqSbO+xXejaFD7C2Y5DF+6KWSooCCVdZZINWrWG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(4744005)(6916009)(76116006)(71200400001)(64756008)(316002)(478600001)(66446008)(66946007)(122000001)(86362001)(66476007)(66556008)(8936002)(52536014)(8676002)(5660300002)(7696005)(9686003)(41300700001)(33656002)(2906002)(6506007)(26005)(55016003)(38100700002)(82960400001)(38070700005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiWiEZxxXuJD9AcbKpE2rHxjmc2RRW4vroyDeD3BPZxqd3tQKtCUBGJXBOMi?=
 =?us-ascii?Q?uhc/fJXTAeIRnHcylWv8RAS4VbTKmrJI60DVIASK6mxWEn3MTki3YZrcAI8N?=
 =?us-ascii?Q?oqUWCYK4bWIugivDYrIAWQnZIvecX0+PsOu5K+0fRUQlP7NJUHwQUxPgzHi7?=
 =?us-ascii?Q?zfUBunhWO4gvu8r8BJsb+fDL9uyRs2vXOA8sQIlHvALl9NPrX0Aobp4XF/kQ?=
 =?us-ascii?Q?VHX0wA24ZxPyoLWnQsEZM3Jrfqu5osx2MIB33c2ap3WhCrYUjr6dCpSZDuj3?=
 =?us-ascii?Q?K3LF8P9iVaNWTR5wS6sNSfzFfp2XdmALgdCDmkZMoWqPtc3Gh4W+/5foaGbs?=
 =?us-ascii?Q?Ja24/lm9KrydtjyXzBrJ+u0QlRmqj3/tGCkT2DWPyqJ5q0/4aLjiL2OOIX+R?=
 =?us-ascii?Q?ZrQ8AAbuHqWD+mp5u2rub5cvTOH5CiK2//9gmP1ZUbgbVfGnh6LJJByuhgTe?=
 =?us-ascii?Q?sYfmDiriKmMliDghkz4GN5VO/v9pZ73OqMzpN+gmKb+Aazm+TLxy22yXNPX6?=
 =?us-ascii?Q?KfgusR5XFbuApCgs5y14pxW55ytXGS1Cf9LJEhY1KwplTx56s/z3LHYjyPGp?=
 =?us-ascii?Q?0d+2z37O1dZmXBhD8B8FwXXzeMVba3DFHOX2Yq8tHqReyL5U8nzX344XQIQJ?=
 =?us-ascii?Q?JR5BRbMicLukL4AAZsP+iwis2PgwW/3xXYy+IUtK6pcPp74VizLda4Sf98EU?=
 =?us-ascii?Q?mUz9XJZuvT3VJCYz9cmx8WZCLdstdOPECQ3B4ZRJzyB/ut0DOA86zZ4fP2wh?=
 =?us-ascii?Q?FmQBF1Z16CrLMVMLvqpJkD4XcO3aaKnlZI5699Kw86igUb89xDV+yOM/jG/a?=
 =?us-ascii?Q?hZE7j63yl/9W4jhBuiEG0+T3tS/ucJLZpNu8xsNRZTK1TulnodQfpOXwjURu?=
 =?us-ascii?Q?ML3+Z9jDWIeaGt0RGh775sLrDMb03tDxJ/7Cxwn7GavSWo/MDt2+DOFC4h7X?=
 =?us-ascii?Q?Ja8HX0QdGRlCcdFq4ODJdygvk86h24HLO+JYFo2dIR08nGKCPkuq32dnIajv?=
 =?us-ascii?Q?nFwcUanRlfDz3cD/o5VlqSpQPTxSfvBE16pv/Kb8ESQY9TZQktZ0ZNSXNOZA?=
 =?us-ascii?Q?lNMmF+mGXhIQy7tWLdk9foGJMLbMd1pEUil71ZBBhD2BNBAvnilWEMQX0DHW?=
 =?us-ascii?Q?PwXD2hPrJs4w1+2s9vZiUJE4FLSCuYGBshTCzaEAgJPrNTbUv4Tyk6V573+E?=
 =?us-ascii?Q?U8REPQzGuyXC20RDkDl8pWrcKloJdPvBA3+bo0BdaI6rBJtOc72C/W/2WPpn?=
 =?us-ascii?Q?lkg69GsAQ/BMgo1ZASC13mCm1z2AM2U50qa4YCuKi+F0jAeprNsgXVvDBAtz?=
 =?us-ascii?Q?f90aU3z8wvr/gUw3aqJi/FlVZL4ETONCM8djfzA2/hS4pbrFE4F+3r7p5MCX?=
 =?us-ascii?Q?s9Lk7RVe/niy98p+lZeh8s1kw91W8hG0tjIDJusj4j4QFedk5oyzG6HzwkQ0?=
 =?us-ascii?Q?Zm1QqP3F6Xtv/nfO3BDJoB1JfCfnV96empy2m5kQ7rG/G78fwHa3rM6Ndz7T?=
 =?us-ascii?Q?tB9E3E7JE/w96JJngAAnOQ5+uMGKe9GITY6SvE6nb67oRnPaYQqUpVi15b7U?=
 =?us-ascii?Q?Cp6dFZtM3UYDTqGOCjP154XSWwH9HkmTMQkKDQjK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bd0ea8-b9f4-4ffe-590d-08da6faaa8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 08:33:19.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbSL0BoXWtX7+dZvmmR6GX12G/+eOdEI9Y4Xq1TC+q+cDPwV/cg34P6uHM/uDH+iIZVZ7ggjSZFYIpollLx37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com


Attendees: Jan Kiszka, Rick Wang, Florian Bezdeka,  Li hao, Zhang qiang, Ho=
ngzhan Chen

*Community update:
	 5.19 dovetail test not green, need to fix.
	Dovetail related issue reported to Linux upstream ,no feedback.
	lots of EVL related questions raised recently, Philippe handled them.

Open discussion:
	Performance tuning on IGC NIC driver, TDMA enabling on igb
=09

Regards

Hongzhan Chen



