Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF891CD16
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391580; cv=fail; b=P63L5ZaraOCBx2HxW+CfEcNw+W4S5OAS+uaZkFnGB3AymhA+gO2W002YG9xu8vkPneu1BDewgddoAz0iUwadWAu5pcCa+4k8axKIkXqxPT7ARrgTSr1ZA4XFyiJpXZbFjhojJxBvSIx0+OULGTnwhVCGwEdqrdmuYqBBBv5XbJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391580; c=relaxed/simple;
	bh=nvLqXWq9kxcwW2lEKJflgaTyezTDuMRaxA11QG4PFX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ux3n+Vlzufuq83ww9uhHW3+6cpe7xbC5RpdgvPLjdcs0vdd0frc3EhC8s6/xmN6fJIgi4E0pMbaemcqWdPPNPVq1WmMUanugwvZne+/PSFnc3+T5v2alnN1qxiBIGRTFHDMhKjw6cYB2pqS2FrorqxzJt+j1y6ALlZJ/rxcIkW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1+0EqVE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1+0EqVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716391578; x=1747927578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nvLqXWq9kxcwW2lEKJflgaTyezTDuMRaxA11QG4PFX0=;
  b=J1+0EqVEXQMAnW67lZ65MR3mfA03qIy3cuqQ8Wk1mR4yw7r5zEJ231Du
   X9v8x7M3xVELqwcXeVv7W9KGay3KXbraixZ+5b2IVynNPeqxoKy6tobgO
   4nSW2j8KaOqqxEHpxWgvr9wJeS7CRs/DSmtQDY35hcMfkJZ4QvjAupzqT
   atmgt+gS2pK+R0sM+v1qDjkmy5Pl3lV6EA6+iq0PYnkfNN6/wEYYxKRNA
   jlLR6vucJtd4DESb2uaTyDrez2Gbepga/Q4Q908ZdYejOBdyySxADGvXd
   XPX0IfR5sCtLQNv2X5+xumaeQkzbRGat9bq/rFNNv5yw0Q3bA+3ET5GYK
   w==;
X-CSE-ConnectionGUID: 27z2wYV0QjSixwYnu/q+OA==
X-CSE-MsgGUID: 4GD8v+2dRESobYRZcaz2NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="24057326"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="24057326"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:26:18 -0700
X-CSE-ConnectionGUID: 8skUWUV9RX2GRdcEzF5X4g==
X-CSE-MsgGUID: OXFs+g9gTyGJinonREtQkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33436977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 08:26:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 08:26:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 08:26:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 08:26:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 08:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggzwpzL989FDVv6cxPT3XSHBgYUxAmDo0vQihEKiiBRaA34t4Mc6KnVsuuzYuqJiA3AhF+alGjkooWbtHrbfzYGSooQex1W5msNY2zxHeD+bTHGPe/QBiTJ4cwCXpR0BkLEo57PgEi7rQxup6ASxBk7jMJ3p1zIq20rihqzq6TP84SbFne5YIx+AbdX3fNZO5UfmWlkUKeedyHmi0Qk6wkcuWeNF0JgdfCyEbi51ejmbosfGH11hP2L7R9LCkSVHxCryPSPmhEFk/LhJa1wrm6RMy+ZkK4s/I42dJjgzA04wk8/WJ6Mh1H2rAqjRs7amCwcwyLCwb4+PUpaZeNiT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZFf6dH9KuNlQWa/D2uh3FLgy3aFp5RHlpg5NLq0aSk=;
 b=eupQvl5GVVyoSbcUYmsYCdEQm4bMs4PlKtK+PJRqdRVJgYzbt9xm47DQn8YYySa0DyQdU1AeC00c7FRu6BAmNRdTigucjdFcdrHCeT568uhjRa416FasGWPNt/8nlHWY1JaQRhNm0k+lsSqUkC6ErastR/jxZtHbiV4xNNVTZvLG3gBvK0D/0h227kZZ0K4+C+xBXClHUZeA7D+cPW3HCylVO3/kG/T8vY0ZICzmj0UWaaFt6SW2Dr/iLC2FQT7YWiTbS+CbZnRaHzUWdMNkAAoT32r9mr9pIvF5qeaDYR3x50TCAHnyaJsANKIZ6qigpBzxRY/I1lSt0egYqVENxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:26:14 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Wed, 22 May 2024
 15:26:14 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauAAAU+/AAAAI7fAAACbpVAAjtw04ABr89SAAAAbP3AABFErkA==
Date: Wed, 22 May 2024 15:26:14 +0000
Message-ID: <PH0PR11MB59490A3F6467E7EB4471F6A1F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
 <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59496A3A9FFCB39B7715813AF4E92@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87a5kirnjs.fsf@xenomai.org>
 <PH0PR11MB59491ECBE8A1CF6C2D7586F6F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB59491ECBE8A1CF6C2D7586F6F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|PH7PR11MB8503:EE_
x-ms-office365-filtering-correlation-id: 1a4ef1bf-0438-4dfd-81d6-08dc7a7384d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ns4vN4uxi6u2pLXN71LEW8uzUoxvl/hfC+llGy2l52cM9mkvsJrujrVusJJG?=
 =?us-ascii?Q?xgqZQFANk8kwqqpg3A+DPk80zz88XjLmRKvTw5xYkhxe00OsW1TbQXrlbisp?=
 =?us-ascii?Q?7eBXHeRczLaoFkOt3XtOOUd590xo0PgtEtVWslg4ZBGGnKia4EElprlEjF6N?=
 =?us-ascii?Q?DQ6WapSoAXvYOtwgreL9fOSaquLTc5BKD3h3ZVmf+RAYddmFOkwnUxdkT5Zi?=
 =?us-ascii?Q?YlvEFj9z01PhwNNI8eQw8CaP8WhGRUtsUb3STaEUu56TPw1d3+5tb9p1bZOY?=
 =?us-ascii?Q?TJN6RPXabaR+kDatxt7gzhEf83MyaWA07qQM4ggTvarBZ3iqZysZPmBxQcVy?=
 =?us-ascii?Q?ZRwmVUu0U41OnN6QJCOIz6eFvNhkJYOK+LXnmM/RkxIua5exIkF+3ukfGO4J?=
 =?us-ascii?Q?BrvvuXDic2NEWs276777TsqisEzlPtJQPpyMGcKbbdfVXDi05+TiPfR5aBGb?=
 =?us-ascii?Q?NwFC5+zwRacKpgjTG4vt+JrmG7+L9PS8K9iUDdofy7koiKgRd84A7pPb3b6G?=
 =?us-ascii?Q?Ye5ndZCrVH44ZhY73a9HPuQ4Lz/WnQL6QPzpXcK/lDWQ0LiEmR7np7LGmy7Y?=
 =?us-ascii?Q?QSkSotELJpgFlrTCvPYq/RIO/rRznwBP9FuWiKE5j5V/QrnQw10f+TVWbuge?=
 =?us-ascii?Q?0BIXnrIpTq+d6ipsecU5+m8LoZv7mz1OksfqqM1s2AyvzIsgR22ZtwXumT9X?=
 =?us-ascii?Q?gEX57fJHnKjY+TJ9PIElTefjjIwrdjH6BHSwX4E8VpUXXkM6NqDMLeVAj272?=
 =?us-ascii?Q?a8Zcl69+kslTvbRrlsv+djq5zz9rrkTrch319JUH34yaU+yClABNljP2rs4q?=
 =?us-ascii?Q?iJLRXODVRujDjbqummenvC1gqqu0skclRa/PfJJqQgp3cwk4mK7gFnvaDWpg?=
 =?us-ascii?Q?UHdyHL0LlWlM0UU5baNCvwu86p3f+vNB7oRBOnAcVLKedwii7LWnDkuyn8En?=
 =?us-ascii?Q?euY1T5TwATkWAsJSI14Bj3IoQhC1dCOcMRlW8tez8U+Bfwg9jNPWqbb9VbYW?=
 =?us-ascii?Q?1N8HsuMynEeTS27Hu5VoVIppbuPs6WzHos7/au8b3kzrJZpiXNPqmDWWJDBM?=
 =?us-ascii?Q?SiwFf+ATsdhcKvBJ5iOjZXfX6p9nDokCvGh75vTAwFLiiucSNV0eaj+U3VIc?=
 =?us-ascii?Q?685b90TDgHLcOpN+25uysRui5KoQuipxaNK4yLwIQISIHJUnOpEJ2Veorb0A?=
 =?us-ascii?Q?GpaAfZyujnAvBooT5quKkyeXtsWuIm1Chk+Pl/bYVI4HFBuMrnfGpbkXe0Dd?=
 =?us-ascii?Q?33bvSlRY/DcrDGoaF5L87cP6nGr9Qh1UXvby7TbsDl6Gg3WFbUzT78QEIw+y?=
 =?us-ascii?Q?HIB4jtGd5ghmP80xxYJI1l9MRqHnvK6KePQAnvd7V9Hl9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2SGzi5AqqIP8BfbfEWe4x4N1zrS1C45P46dQARYw4j6LonZ+apBAisNE0QK6?=
 =?us-ascii?Q?Dd6uCl+MAyZ/MMmHgU5APw9qNyk/dlr8zxPUuqOed/w1gsIDHQad/7DWLqT4?=
 =?us-ascii?Q?8q0O+hSJovZ9yDMUker0zE/iIm0l08cJ8YEuYkaIc5xsoYxB6FE3qXoJW+dq?=
 =?us-ascii?Q?eh7iyu98xFsxKNqSoy+k/6OoM8TOijQfC/T81QS/+Q8VhuPsbggP4DXLlwck?=
 =?us-ascii?Q?s3Kc1JHZWufRKsFbOk4YuJEHciiEZv+5xFi6cu0PE+aRlAvD37pTxta7sRQy?=
 =?us-ascii?Q?aJgkpVwph8hs2HrX8Yh0Kx8HkKkTfUVtaTrfX/lHxHlrzZ01r7ngqdz008n+?=
 =?us-ascii?Q?4fowVAs8L2m1Gf3IoK9dYcBjpL9UDXJUKo19kEGv6r2MD3KC5faDI0i+5/4h?=
 =?us-ascii?Q?ae7ORybqGJ+1Wv8UoGpNmO6sGGSENji/V1TeFrMO9cwe4xTRtNsFJw81Wfvr?=
 =?us-ascii?Q?lfffm9wqwnOVfCrg3l3PAy05kIS2dXPeO8TaEw/GBwpvF3K3RCw5DLVUJHsX?=
 =?us-ascii?Q?g7SyczU0VWZhhi/VMMN5okKCsricO8aWsYLILqRFwY0EXhWmWtZ95oa0C2bI?=
 =?us-ascii?Q?+I6bj2+lk+fI0FPPZufLKXO2fVaFHCeMZn3aaFVQJNK5t4ohtdsfdY6FoAo4?=
 =?us-ascii?Q?ydGLQyO4CRZJsYU4h7ZoMv5TuHNR6yaFfs3+YCnm3VaL0XihtRlUsJQBzvEx?=
 =?us-ascii?Q?vTyIIJMyeGXqTa/j3EgrQlvZ2GhaK7du+/z/4rin2We+x6tE03qgW+jrdMCr?=
 =?us-ascii?Q?HCzNdVH0/KCBv3ax7yjs2FzDwhStr8pK3+/iKydzFhVh0yQsI7MoaTrxyUs7?=
 =?us-ascii?Q?fM7nEXao3vZDF3Rn9j+JjqdnMZd0YWjRYB4RSVTb+YJzk3b7AMIH4hhqDya7?=
 =?us-ascii?Q?AODDoWDP1m4egkDD8hYSEKkUP+VTs6n8P64UhTModrWZmA+bhblFt1ps6Qwu?=
 =?us-ascii?Q?q71Klxo8k/Kr62g4hkDUONc7zW7EK204M+I9yiGQBp7prBc/qDUtd09BfKYe?=
 =?us-ascii?Q?5KO71fUEgjmlULgdtVn/MezaYz8h28fmM3KP1qqXa8dH+K3epJFth14DJ7PF?=
 =?us-ascii?Q?p8qrk7oxFM0pMNgL/hzxLpPz5N32X1Oi67/U98SrdeASlLliF9050Y7NWgqj?=
 =?us-ascii?Q?aIhxgv4KkAGNrSrYYPp45at/t7MjJ9kNsr3dNPWL0yWI4NDlAsFaYNYH2MyA?=
 =?us-ascii?Q?PvfNDVu5Pla1xIRv1GlfiJFfVONxdZiXF0JZAG/dG3tO6cQKlMZBaGKgdQxp?=
 =?us-ascii?Q?O6KLlg4tNg/9OC2k2/+qd2HDm4omk7qmU9YObxy2YGQd9JvalpiwwQiAy/VJ?=
 =?us-ascii?Q?PslUvsHKfebogf2/j84OS8w6P6l9Xnet6hyQdtj/qrkSPLN2mr4Gt24MHzyR?=
 =?us-ascii?Q?JTl2RQSesVq3eJvSRfA1G/FfdgsZ7zHq6717cQuXLEsDHH5uPtwKHJDks+0X?=
 =?us-ascii?Q?bwCpBTLLqIZo+6n0q4HJKtzxvdKghOVVuMN2wBn3KIkNnVvErozTcNSIXhXY?=
 =?us-ascii?Q?57MzkY1KVNuGGdh45TIYEwS6t0hLD/MqHvhhuqFxCO8P727N9UPBp1UAjUNb?=
 =?us-ascii?Q?LAX2/y3fzOx0N7/B6qCSzwxwE6YCd3DjSZzdiKAu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4ef1bf-0438-4dfd-81d6-08dc7a7384d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:26:14.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLzd5c4CmbJe39m3qH6/QxbzDLtGCLvuXBEQc1eVeuI+93aulUNPHTgGexCd3Sc8musqkrSRYSMgMD6wrZIRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com

This is fixed now.
Now CONFIG_EVL=3Dn is working correctly.
Thank you.



Best regards,
Ionut Nechita.



-----Original Message-----
From: Nechita, Ionut=20
Sent: Wednesday, May 22, 2024 4:23 PM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation

Hi Philippe,

Thank you, will try today to check this.

Best regards,
Ionut Nechita.

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, May 22, 2024 4:19 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Philippe,
>
> You are reproduce this issue without CONFIG_EVL and CONFIG_DOVETAIL enabl=
ed in config kernel?
>
> CONFIG_EVL=3Dn
> CONFIG_DOVETAIL=3Dn

Yep, this should fix the issue. This bug might have been there since the in=
troduction of scoped guards for hard spinlocks. Checking and backporting fi=
xes if so.

commit b51c3afd66c8763bed7a4b8258cc5cf5c8ebd719 (HEAD -> rebase/v6.9-evl)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed May 22 15:16:52 2024 +0200

    irq_pipeline: provide placeholder for scoped guard w/o IRQ_PIPELINE
   =20
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h index eb8b=
4d386e942..545368b045e52 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -612,7 +612,24 @@ DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, hard_spinlo=
ck_t,
 		    hard_spin_unlock_irqrestore((raw_spinlock_t *)_T->lock,
 						_T->flags),
 		    unsigned long flags)
-#endif
+#else  /* !CONFIG_IRQ_PIPELINE */
+DEFINE_LOCK_GUARD_1(hard_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+#endif  /* !CONFIG_IRQ_PIPELINE */
=20
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),

--
Philippe.
