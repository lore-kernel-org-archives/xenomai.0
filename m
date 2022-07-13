Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34115A9
	for <xenomai@lists.linux.dev>; Wed, 13 Jul 2022 04:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657688254; x=1689224254;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=SSY/C0DyNudQinHNfoAGl+z4sHypy6yTQdO5w6+irlk=;
  b=jf1T7RFm4w1At6kyOxCl7GAPMSwL7nE5Zw7vo1j7Z87R5bmRpSo4jCFi
   5h8KTsbuA9CnytjVKkxAzh+UbcNUlUFtenWqA4z9w71Y3/ScTn3S5jIou
   P52B+T43RQ3j0+DtXGYXGkmv7z6EABHNijNFFVZzAKHDBV6X9XZHd90fg
   Qq2OtDdAgquv5Fuduy6Tcr1+EaxlkmZdRwJBCMKE0x6NQJg2E9gGgdtSz
   zwxXc0QwhueuR44+zW1bMje0BIDWQUQsmU8urbEWCXs3I/syPdPzpKOLB
   0DvSecwR6xLYVr9+mA/mhPuFQN8F3zTh9sr7b/AtxR03os0vqeQKJZGXI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="310738543"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="310738543"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="772113444"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2022 21:57:33 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 21:57:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 21:57:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 21:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUpiliIlrp5ISd5a2eMMRtory6/EpuKZCcvGhLQ20yiZfkF6hxdKzyT2ijehshYf6IvGxMPEyRJ7XLRBYNH5eFHEImelioiL0T6/Y8czM/dWVRLfhtwglXi3E3XB2BAE7C9tq86F9Wb/FDMxD/c0ymDEcqQPpFGWP5QEhzWyCDLMqLKsqmmPsFmpVwy8IRNVA5SgH4C3AuJIM8V7ss8aF87r+gGkreTnnKcPyTXt0JMn8csgmnuOUAqqu1pjJ0bMa9GIaezed5gELWELrNwAWLRFvftqS/X258EuUWYMnnRr0wnnkOTGmkPtG1RFI3ji19eFh48fX5MYKNpBnDFQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNjm4Y7Elz45XXdQG9ekpqSUbGbiXk4oe0k8b54V4Kc=;
 b=YcgROL3GQKFMx0OUIKVj0QT3AxGk0KUOp5U+wVLha5u0gKlWNZ1oKV/M2PZZ8Gl3RkxPsOZdfU8PGg5gPUiuUL1POhgDYOO0o6FYQBWl/hyN6YLmYZJngprOs/PScH/qidUgeCy+wvX6MbDdIiTWc/R1jO20mBjDWBAIOeBQy8EizdrIiUhijbrRuRchqloPcmd3m6y3DOwr3CkBTAs+gAwdyJ2CXuQPmirglkoGRZPCR5qG0tRRPWgOs6oYLZOgIBZScyDi5mvx16ZyN++bLMIzzh/9ERk95wYE/xrvMEJ8cegrPbtDm7x6Zfa8x45fb9no4dYjvzlmZuI4BRgk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 04:57:30 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:57:30 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 13, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 13, 2022,
 UTC 7:00 AM
Thread-Index: AdiWdQxOY5Qx3j74R0SBNdM6YFgh5w==
Date: Wed, 13 Jul 2022 04:57:30 +0000
Message-ID: <MN2PR11MB4285108E73B21D311600BF9CF2899@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6635d5af-460f-4504-265c-08da648c3103
x-ms-traffictypediagnostic: CY4PR11MB1447:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bj9iUx+QNgmk/50xi4C1neHmFTU14JPsyFLnRUisRfmweN3DfqNIRtM2vrvnnbwJVhfUH4dDhzfR/Sh+mUXUBFTNWMD4o13XEjLR7BnfE5eNGc4wR+/iAz9VOHTnPWhoah0bdDjQSZLrv/6ZMJuoeVeDPEJpASJ1e76fbuQWUck2/Xe37mWrfsBKf1Fy8NlB5+/2VndUU0RUY3iSQ8meCFgZXiG3EOgcGEODidwtO4ezaFCd996PMtGrGkl0dQiwhi7YVIXPcnyhfhrhH6e25aDMe+Tc2H9KGSGZsepZcB/j/QRxwAdRhAvAi5SGpOLF7GDLiGmUKNAEuy0Dp3zA8G+aEIE3x5iiBThqJnc+t1/vlD3kob7iOlvz2eixc1kwfneHDlHW4BqGB9DQEPQZo2y7DjoQ2nZLzas+ar+ycQNqXMeTW3i9sQJQO1pXnoYTlI9pL1vxYW6HXpErh0GMAc//rApN3vOLzCTxR3ZeNY9RnQToLsvATEXWfZ4zw+ILubkq2cZcWJxTKRbaOkqQWHBMNz1XknsIAtZigb0g8XZj0MFIE1zNwrOidYdllawgsBnd668muYo7Z79rjbpNxLqaivFOClwrUhswpG2PzQO7SwCAfLk0P40VWCgEQ9ha9XJi7Yh+HaP8RSQm3olu5Az8+BxaO+ns2RQBgiJ+GFteMfrPqlNRYYRdobTdfc4uzDad2fGUur8RXUKczjolm/IAdovNj2j/BJgQe+L2w8doP827o2uG0Ii/LGd6TkoirFVmGjKREw7IZA9qj4m8qyyvLZFSDmjrFmM3GUCqjL2kpGvWdF8yjYuDUca0T+rRJTlQYpIDUt93XY/4AGDiiXXb0w12in7kTsML2fI8VXg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(82960400001)(41300700001)(478600001)(38100700002)(966005)(26005)(33656002)(40140700001)(55016003)(2906002)(8936002)(122000001)(83380400001)(5660300002)(66446008)(52536014)(66946007)(71200400001)(64756008)(8676002)(6506007)(76116006)(66556008)(66476007)(6916009)(86362001)(186003)(9686003)(38070700005)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CQuTrCgz9SgB0EvV6VX46k4z0ItqnEp6HDRReRVfOIhYjaM+4p4GChG8ySii?=
 =?us-ascii?Q?1DxpAnXVqGhnJPetTawyS0eCkZ5YJB/Ui/qgXPPk+WVA7lWPX1IH67DoM5la?=
 =?us-ascii?Q?Uxkm1jMjvwhLMYxYIEnqqtJLbB3rIXpLsTaKo2Dx/NkSqBO4+GCIrkVQPExf?=
 =?us-ascii?Q?I2VN05BQGovTDB+rEJLZxvxXPmHQpVmZJEgM1pfTCaBNgUwA6v1tAoa6Ixjh?=
 =?us-ascii?Q?UyY9WDSi0uQqTAkv4J9CrviPVtmmFn/Lp5ebD/CE2VCpGH7AedCIbMqw7/8/?=
 =?us-ascii?Q?WqrZzLEzwdoUdMtGsgW5QyOnPJOKVhu2t3gtkLUNqCtfgYIhJJGAqhuCz5E3?=
 =?us-ascii?Q?vtb6l7EN98Fep2/+ucAPqquHsF/BbMewgVc/Tma9Ut/yf8iD665JIe4mdExK?=
 =?us-ascii?Q?1TfEcTqV58WzEe2RZmush7zt29wU+xNU6ZMaZMiP84XDtZlXhOgKq/ie/jtw?=
 =?us-ascii?Q?S7Nshb6c8LkcBvPf0uOuAMeBoLUqfoWRJ4jg840v9URmqfFFrqYSRfIoKO8t?=
 =?us-ascii?Q?7U7LYPU+JGgs8AXk5ENpZmtWLINWH+nhXbg31Gf7zv9dxJcqrydRua7toV2A?=
 =?us-ascii?Q?EWptpIo/+T3ZwUadAStf61CXBbur/YiM23Vyp3qtZEweXEyFLDdMUyXXFV4e?=
 =?us-ascii?Q?qSF26jA/IaCPtBR/dPSj7llbA0mQKa7+kMS5lhz4XvOTfKZLsc70ZSKh/04/?=
 =?us-ascii?Q?nqJpkn23GboYdxNN2EbXzsrr0Ji9iu0CKT4azp0D2MmS/RTuKcnvU6/5pFth?=
 =?us-ascii?Q?ApTq0M7svTE2qOj2JHc2bcGJvhwO3DkpJqZ27roZp2x8e7RMaeYM8B5yd2YT?=
 =?us-ascii?Q?2Lj0TwoSBbzbn+SVy16UCglPIBmHWekRVheU8RtBsqsmYm4RjGfi1VncjC3I?=
 =?us-ascii?Q?DgD3NxANcpMmmB979PXqDVsSAX/pPVQtudJ1YZ3zKC3PVD0YpkJk/NPzgv56?=
 =?us-ascii?Q?sf/n5piiXKUuSRjsu4vh3W539f1U3H50WuWwDjZ3WNpqoUDoz+z4jABekJZ8?=
 =?us-ascii?Q?02LavqkgBR3fSlzHTU4LVU13gJynxAEM8qJtt06+uqN59Sil2b6Ga+yFOHri?=
 =?us-ascii?Q?qxaSFIw4hiG08FSxZaDYbmDdKINfsBo0JI+E+2EgOum5Rx7PW1W54bgPbiEL?=
 =?us-ascii?Q?kmiUOxaePUzzot5N/TAcxVJXUrdfudFtPR7SaDyky9O/ygz9zZpuUR5aPDR3?=
 =?us-ascii?Q?AhlZAb+93oWjKOrALfi+2T0uajdJZZiCoSPbtrvOUB/whhxeQZt6VVbFth94?=
 =?us-ascii?Q?ap5iKHu5J5S0HSuCYkUUhZgTWZxnIDL7kojZj/kEPCaspFawgSDxAeMjWXUV?=
 =?us-ascii?Q?IWxGvrooxYSUJmwSs1mupE5lxuUd0ADzmY3YDDlpSFMaLRg8NN98Pway4wXa?=
 =?us-ascii?Q?Ge9WTv1FceEgaifmA1RrKTS1damdn1laFeqTGA791MuoHd60MTFN8EiV0rw7?=
 =?us-ascii?Q?dVxJNyK8zoY+78tz7+cntwSuhLWi/CQJOEK9RMH4ezG1bsB8brbCQJmr3Miq?=
 =?us-ascii?Q?I7gEXCPY8pTZ1lJ+QwsnoQ0Gw2N+56JwuSgE1p+wVRGD4g/osX/TbjxgNzYx?=
 =?us-ascii?Q?rS7mO5p6Te0lvUTaThSOxud8uI3C/hKR/razBFhR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635d5af-460f-4504-265c-08da648c3103
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 04:57:30.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSugn19/eD6Gdcaba86kxdND9douTdEvLaW/ajVTGqhoWe903Jm7BGpY1PpB4foqL+zIvkBrD8LvP8g5V+MrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1447
X-OriginatorOrg: intel.com

We have the Xenomai community call today.

Topics may include but are not limited to upstream/downstream project=20
plans, status updates, and technical discussions. It's an open online=20
meeting that anyone can join and ask questions.

Time:
Wednesday, Jul 13, 2022, UTC 7:00 AM
Paris, France CEST 9:00 AM
China CST 3:00 PM

Join Zoom Meeting=20
https://intel.zoom.us/j/91297279269?pwd=3DWmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
Or
https://intel.zoom.us/wc/join/91297279269?wpk=3Dwcpk52a9f96d989e7e20b628c2c=
36e48b68e

Meeting ID: 912 9727 9269
Passcode: 367528
One tap mobile
+12532158782,,91297279269# US (Tacoma)
+13462487799,,91297279269# US (Houston)

Dial by your location
        +1 253 215 8782 US (Tacoma)
        +1 346 248 7799 US (Houston)
        +1 669 900 9128 US (San Jose)
        +1 301 715 8592 US (Washington DC)
        +1 312 626 6799 US (Chicago)
        +1 646 558 8656 US (New York)
Meeting ID: 912 9727 9269
Find your local number: https://intel.zoom.us/u/aTEA37i5G

Join by SIP
mailto:91297279269@zoomcrc.com

Join by H.323
162.255.37.11 (US West)
162.255.36.11 (US East)
115.114.131.7 (India Mumbai)
115.114.115.7 (India Hyderabad)
213.19.144.110 (Amsterdam Netherlands)
213.244.140.110 (Germany)
103.122.166.55 (Australia Sydney)
103.122.167.55 (Australia Melbourne)
209.9.211.110 (Hong Kong SAR)
149.137.40.110 (Singapore)
64.211.144.160 (Brazil)
149.137.68.253 (Mexico)
69.174.57.160 (Canada Toronto)
65.39.152.160 (Canada Vancouver)
207.226.132.110 (Japan Tokyo)
149.137.24.110 (Japan Osaka)
Meeting ID: 912 9727 9269
Passcode: 367528


Regards

Hongzhan Chen
