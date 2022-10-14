Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971863A
	for <xenomai@lists.linux.dev>; Fri, 14 Oct 2022 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665739710; x=1697275710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSujnngcmpgcr9Zu+A9GmLhvHLIocEpIoakeoXSM8qQ=;
  b=IcVqXo2f8dT9DEjDsfSTEBZy86rp6Yk7K7qDxChAGhp0Ju0e4g6nV1U3
   PP+kT7LdHazHXu26OGB17I1R3mIfCSdd5bu5vyut1Lhpl4UDrtS6IZTrh
   yIuhWFn5CtIYo0zdYl4y6FzxjaJES7+9Mgy/TSBU6tQvuZMBJx0A8aKUa
   OrNqoCugPKLKod5dqP/uUBwvdI6viM5huaaGV6NNLJf5fNsguqPEte53o
   F1LrDDfOw/J36bHzsJfP3BYTydMR3s16FfPeNTEcrTyNBI2Vj7E+ql4Za
   CkTd/OyVYC7p0bzuSa+drXlKBdKDdUlzuDcN5N3EtgneI38bm1+ZWYLrj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302944945"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302944945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 02:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="658526969"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="658526969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2022 02:28:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 02:28:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 02:28:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 02:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkrpODBIHozfe5Rp8Kc8GdrMK7LT8gLg0EZ5wQomlWi0OaeF0DLbjSWtqtza+/q7Iggywhx/1KPof+qsWaiZJGKuYA6PM79YXbrZ0PsFYotSOLyS63gaHLomsWw0XP86WmluFHv+0LaUTW3LXlZ/yTodMF/PWCFu66SSWUWvscp3dPsk4547pL+pBQwnUl5tkO/mqdZX/C6f2ftxhpNohyBsaPjbkMp3IW9qEqyk6ycTMvSpqYuvkLceekmfSyjtlD1YdZjFt2gQFv77EGuwg610OaPvkSCY5v4WUnyZ7O4yy/xZWayCFqt1D5hc5a6DPZSslEItr27rL9aXr9VTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBPv0r6UUAIeT8k1RjJSw5WJVeTkiM4hPSsQFlnyxb0=;
 b=IkjyzUd/nMMHbBEvQpXiATXV8jqCWEF1daFYOS7P9SLqwtHMdgO/nab3q+loZ4ZgBWPwPvWd7iVqk0Lo7QzzWLUTwobNY8YX7YFoIOnGTrnDlDNf1kPI4y4uiZAeiaWLBo63My2QajS1tLZ2+Uu6GOGKoVr1ZV80NAMXPjsEeOfyT0qDB2E9YD2f4IAM3YVBcUFt0UfzXPt01sb8P1j1OzjE8XZkt4Wln72ynHR65pMhKBGx9SggohEDVHRPPYlFNWlYSvN82aNtc0KY9O8RtGeY6GaLG0Y/4stc7vJjUKYPKTQ7Iv3ZXe4Ti+8S60Vicdkmez4sMYCZlObl9FbTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 09:28:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 09:28:26 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>, "Chen, Hongzhan"
	<hongzhan.chen@intel.com>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: AdjUuPBUbK+UhP87T6Sf3hDOZQOijgK7K/yg
Date: Fri, 14 Oct 2022 09:28:26 +0000
Message-ID: <PH0PR11MB5880E8F036B2FA3DD81A41E4DA249@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: 2218b27e-cdc5-4aec-6fa9-08daadc672ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRMSUfKm89Y6VTx410e6/W5d4FpWAYpitfpldKWERnEjmt4z75jg8rE0QQCxe5UTpyE00It9UnVvdmtiubS5uuodM9COCHu5PqOB7+tj3wW9svxDRc4PX1Gqpm6J2aPAQlTYd5eXPJ3Ct1NS4cbLjyCUZWUGbx0gTFAAv02jXj8W9egISJeHDGz/gDlGjDUyLq2a2i8rmS6FoMq3v/5oFqNalf/jfgVtkUo8n7IsB9TqiByZ1RFZt9VSvMaqo6g3HxStu1slROvh4xG2Xk3PepLkn39R3IgdMVXUpEDtcdc4JBdoXOYHdWJvwj2anP/Zn1KmnhxOxw9VGCSBTaKUs2Hgc+S3SILqDV5m2dSx3gA6yS36+TwORzyVGjZFNhhWbSxF1eYR5SNHutuYaQNY1V7PyTkjfQkEyKIWTXZ/KYQEVjvgVz9mNkK+2tvUXBPUKeiwxkAjCs1nIk2Ubxf9GqlRKCxn6JTJUo9l+nZ4df1sB98TlfTMcNIvpdLRzTYnxJkprLbi9zZL2Q9w+HydIMqRpBp06Ve722rwZNuydDAnAj4JlF5LWYKSpGNNtWMEs1tly8jrPFRzeHkCYRUFEOofFuQ9B5cEHo6PuKuSFvVcU4KoauBw8UlEVvQzqC9/MWojpvNrgiegeobNeqhWqo+ejGNVCgoAP3ww+Qbei/urBtvNgozaGbsrsHCFXkKanBkbxZzgnyj/IBanW5n4bkiOUvk4lvYzmoTShpb6ZJvagwW5oMZgWvft4x0+WfbIlJ+4+bhKbcrmnPfpYJaauA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(5660300002)(66946007)(38100700002)(76116006)(55016003)(71200400001)(66476007)(66556008)(86362001)(83380400001)(122000001)(8676002)(38070700005)(64756008)(4326008)(110136005)(33656002)(54906003)(41300700001)(186003)(53546011)(478600001)(316002)(2906002)(52536014)(26005)(8936002)(82960400001)(107886003)(66446008)(6506007)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QbAQPWyE1L6StbkkvXfk3tf5lHGXG7sRlrTOrr8tS6o0e49kz7+pv04qRsxE?=
 =?us-ascii?Q?z2E25Pjw7pO8t60fva+4uCT5bAzG8D2aLbBksgltLlFCpx5MwKunX35ZLqrX?=
 =?us-ascii?Q?nd1HdnA6WH3xFr+83cy4IMotf6N6pbZzkHXSDpRqRhSh4QxN7k50H0OhPHIR?=
 =?us-ascii?Q?pwt/ZrUmUjWBuvbgZEPDQ8TlOpXW5Nr2mUlHxLIu/00zZH1c7ImZSibSERyC?=
 =?us-ascii?Q?lSHCB3/9OQEN4O7CgTPZ6P7vCxQ5szen/yb9h/+v4HIezZ07UrAfbvJ+woy2?=
 =?us-ascii?Q?MqC8IYPwX/IeYdi7WivNCxshnNQBN/9ODY9eCeA4h/Of/1hMYmBVm7Xsf5xY?=
 =?us-ascii?Q?dNkq95sOimzLTQVKfZy10ujWJsz31cwq0ScnROwg/LW9YAMpJPA1ifCloYUg?=
 =?us-ascii?Q?G4KCs+rMEFRTP29knEkzCiVmrPMume57yZChBt7v8NBOeZSRjbjNa1oNk4CP?=
 =?us-ascii?Q?fZ6qQ0mVVplKclgOzgQCzQPrFg5rLZxujaNAfwfwa6J5q1YIdyM8U9IBJDLA?=
 =?us-ascii?Q?cD6aErzkrGd0g5SKbS2Q1CBsaY/sjddBVVwst5eSrctnuLXpn+7D9d3wlqVe?=
 =?us-ascii?Q?QfIEPyjajv6FN/dQtVYzBC6A7AfrcPce+oe81BEVIbCjOm3naN8AGyft3Itk?=
 =?us-ascii?Q?eaPI/z2q+oc3HTLX2r5+uqOg7Lui/8nkzWcDfGLyTcnEpEDTeQBforYsf4+q?=
 =?us-ascii?Q?IXWAAp6S1Bm6uDwYhDjZch/v4unUCw37kMgSOtBg2oBh1jaaeFNAN/j0lmIZ?=
 =?us-ascii?Q?+861cvB63rEAWIuLKV0J9FYmS+E2aoHVLb3CGWK5bDqtcMCGr3F0qKjZ+XGD?=
 =?us-ascii?Q?ZXqdiJ/U30mN4pwDEh4tDhW4LVgw6SPXsxD5P6b5RM/N4ZDB796QlgOenRwV?=
 =?us-ascii?Q?D05sYR1RlZDBR2S/8daegnsm+7n22V7jNrYRvUtQCjqJ6TMzZBouTfLgOzgF?=
 =?us-ascii?Q?KrvgBOwtfd/MENzw66fPb4oe9vzNFyo+r/h9AbJUz3Dsh9ZeaddyFv1smVOR?=
 =?us-ascii?Q?W2JjBNa+GFzWWFKwo084s9bOHmvg81f73wVYJtpNt8ofljqF7pUfUxvVdpkV?=
 =?us-ascii?Q?u6/PRWfv/acL5cleFtL+WUKDf4W+qz29R4mtAfq/jedEHiEKhzXnzqiQfgEW?=
 =?us-ascii?Q?l7Trrf2PjbGXJYDsAchIMIC5cGJnOReHktF7Zup7qsLeumvs8ndvjYLqUr1f?=
 =?us-ascii?Q?shlS2yxpUP6PrPv8NtpTaT7VpBatejNP2AiZqwwJGbD2JJ6d69yI+5IeBpqz?=
 =?us-ascii?Q?VEMTiQdwUSIZIXAJe3o+tuA5/oh/g0pcPbtjxTvLrL5Dj6IVCHs17qoMOWXt?=
 =?us-ascii?Q?M/pQMBKo3wU/rA09NO0+Fvo5vcc8qNzTMgalXfbnzktJ0xGihnAIpsLkkVXg?=
 =?us-ascii?Q?qNiDzMQ7jyoiRP1xODqXoyJDmVG76hrtEgArpsPh2m4vrLQ0txOPaRnf6J4M?=
 =?us-ascii?Q?aHWvePvmbwYZqrJPZyn7DPUMI2BV0Z+Dzkie7b3yfQA4Zfzq8TOcaRS8kmnX?=
 =?us-ascii?Q?JxZWp87do+nJGOvcMlpG6vNebdewSS80Hf3XRZtcF38imDQOdyBWBjRR3bTt?=
 =?us-ascii?Q?iZnYN85bM18JDfQRc8gQZ4ScNRRJqzVq/Fs4alXK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2218b27e-cdc5-4aec-6fa9-08daadc672ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 09:28:26.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4nm00PEb2nD6OB5FnzH3WfNlCHzl6D+yO8JmLysIby1nSKQhiRUjzoAyIAXIs1kcrTEVGmcXB3Ew2yMZ8jCUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com


-----Original Message-----
From: Heber, Stefan <Stefan.Heber@zwickroell.com>=20
Sent: Friday, September 30, 2022 7:47 PM
To: xenomai@lists.linux.dev
Subject: Memory corruptions upon strcpy and similar when being interrupted =
by scheduler

Dear list,

we, as long time Xenomai users now have a severe problem. We are currently
in the process of migrating our huge application from xenomai 2.6.4 32bit=20
to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one=20
problem remains: Obviously we have memory corruptions resulting from=20
strcpy functions (transferring large configurations) being interrupted by=20
high prio tasks.

We now nailed this problem down in two minimal test applications in order=20
to rule out any programming errors in our own sources. These two=20
applications are:
a) a simple test that swaps two very large strings forth and back via=20
strcpy (and alternatively other copy implementations) and then check the=20
string contents. This simply happens on the main thread.
b) a "sleepproc" app that simply contains a while/nanosleep loop that=20
wakes up every 500ms just in order to interrupt app a).





Hi Heber, Stefan

I tested according to the steps a), b) you described, and I also can reprod=
uce this problem.

(xenomai-v3.2.1,  linux-5.4.105, ipipe-core-5.4.105-x86-4.patch)
The test method used is as follows:
after launching  txr19391sleepproc, run test.sh
copy methods: memcpy

#!/bin/bash

for host in {1..20000}
do
        ./txr19391test
done

# ./test.sh
ok
ok
ok
ok
error at position 40473600 of string S1: expected 98, actual: -56

but after I made changes to the code

about  txr19391test.c:
I only move simple_allocator_init() after pthread_setschedparam()

use test.sh to test it, this problem cannot reproduce.
But I haven't found the root cause yet,  You can test it according to my mo=
dification to
see if it can be reproduced.
Maybe Jan and Philippe  will have some ideas.

Thanks
Zqiang





When running the test app while sleepproc is running we see sporadically=20
errors (typically less than 20 runs of test until we see that error).=20
Without the sleepproc app, test runs without errors. And don't worry=20
about this magic txr19391 prefix, it is just an issue number ;-)

So, could you please help us and have a look into this problem?

Some remarks:
- The test seems to be highly sensitive concerning timing. So we had to=20
fine-tune a lot to see the error in this minimal test. Also it seems that=20
even the CPU may influence performance enough to make the error=20
disappear. Another weird thing is, that if we let the sleepproc sleep=20
100ms rather than 500ms the error disappears.
- In the test we can either work with individual mallocs for the needed=20
3 string buffers or with one large malloc and specific "pool allocations"=20
from that large pool buffer. We can see the error only, if we use the=20
pool approach (see the two options in the code switchable by commenting/
discommenting).
- We tested 5 different copy methods: strcpy, memcpy, two types of while=20
loops, one for-loop. We can only see the error with strcpy, memcpy and=20
for-loop. (also here: see the options in the code). Maybe that depends on=20
timing, maybe it depends on the implementation ... we don't know.

CPUs we tested on (all with more or less the same kernel config):=20
- Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
- Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
- Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
- Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune=20
  it such that the error appears

So, thanks in advance and, btw, thanks a lot for your excellent work=20
during the last >15 years!

Best regards
Stefan
