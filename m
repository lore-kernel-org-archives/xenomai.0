Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF62B9C4
	for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990565; cv=fail; b=MijRsD1308MY2hBGT/oSOjgJpQO0YflimT8Wu9n7pFIZbYXy6Td9NElyOjHc4qUAg/dGns1XNAsSJhvPANlpZE/Tw+Ba5DVSI0IVfZZ9k2sdrPYQoIl6HwWsw4CK/WluHz7367ePgrL6rI7lu5HQt01DfEdyvGKDft5NpbT/qOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990565; c=relaxed/simple;
	bh=hHf7XR5XnuI5bxvmYuR1H7MBvyd1cJOwC6ag1Lor+SQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KmDGjEF0HXowbfPZoFteYfqnndC18sDQjklRT4qgF65xeRgd7HQIupPX+FwsRmJvpmjawln0MzDzJFHHtSsHIwgLTnMM6oGt+xVGPQF33AMJzMn4Yc8KgCcd+rmnfPfBz4CQ7m6lGOvtD4mujbpS1qBoLQRzxhNiDuuXuO899NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeIs4G0o; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeIs4G0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721990565; x=1753526565;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hHf7XR5XnuI5bxvmYuR1H7MBvyd1cJOwC6ag1Lor+SQ=;
  b=IeIs4G0osz9RFrw6j35p/70EvTbdYbbdv4c5vMJBIJ/ZmMFJBZ4MBwcj
   NX6jTsHbqiKHS5QMQIxe8kfCSxsSdRm59lH18AhWW8yj+cc+/LfkVlNJ0
   y57lB1ciebj5XelqnxrZpvMSQOAJHYN/AZhY5GIJZh5znQFVnnT7HcisK
   U8C7tZn3HXtOQZm8tDbFIHyYSAoAhnd9TcKYjbCxxzJWgMtRhIxooF6kj
   JFkA/YLR8/04AzFghQf47+lfW7rVq+n+qLaiibFTu++S2tbwzFkbj+Fgx
   bo8AUMweV0sL8yeKW8Lm+hw87nJwmTK5Hsjx8KD4CU/5KEIb8D2Fd1W6S
   w==;
X-CSE-ConnectionGUID: STTUJqyuTXuKLf2PJH2mKQ==
X-CSE-MsgGUID: WWRVsi1IRjqdxDH7vWCEPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19650787"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19650787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:42:44 -0700
X-CSE-ConnectionGUID: Ot8Pwg4MRt+iXGBusjuMJA==
X-CSE-MsgGUID: +n1ygr9DRp+8N3R6AMa8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="54015114"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 03:42:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 03:42:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 03:42:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 03:42:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 03:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyqMv7xLDSn8Z83Jiq37YJthgTmQoRWx9YdEZFZZjWsS29BlyDkCiiq+hJDUcn2ZKKb3aSPmWngrOZfQki4Cv13ABBPLZ5mrmJJwuW5A7HV+znAAIz7HHEt1pBQsl57hGA59o1qsOOZkdce7mr6NR1cGndT0NL86jNFaksHR7VeFJ2u2Hnov2RP2Bxu340Kt7mA4LSM/rNZx2ZJOwNngPuCN5bE0g+cNvDrXNkPXAGePrfU6QBroKwinNRd7iYjMNOa6Dl7d2nwngFv1wE0sgzJgSg2dp9+52wV7p/ruw+dsd/JSy30RyHr5Ccj0vSPrRncj57YtH8RyBSBxV/zuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuaExOsqNUPHYESeHu58FAiH0ddJxsHzjTmmHjkpKc4=;
 b=n4/e9czWUcS5cDIUJsa8lANOL4MTrR0y3P1i/6EKA4z0oWrESP1qIgIPIEVt1OMko+YsHlRyx7Q27StWokgo0MCwPoR6pG9WlvUCfgpZe6wVyw7+/OoGfX3c/VR1wkCKnHiB7yjw9tisO4YfD4Pp/sogH56oXR8HfgoBo9gK+oI37KDfm6o9kUAv7dT25NXCsNEzFP1IewAeo0DMGqN7S2TOvQqi8+pKKcYEranfq1V3H/yZ3SEdcquDrszHaBcNCiEaJiO9cJEz+mgFQNpsQ/EhwF18rnhZOu+2CAMiOZdPSMIm0yBP6sD/WQ2nwLoTZiUlUZVC14K6ml+nNfOhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 10:42:40 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%4]) with mapi id 15.20.7784.013; Fri, 26 Jul 2024
 10:42:40 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Philippe Gerum <rpm@xenomai.org>
Subject: FAIL Kernel v6.10-evl-rebase - EVL: In function 'do_sysvec_inband':
 error: duplicate case value
Thread-Topic: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
Thread-Index: AdrfSHsgteAJweQCSTCo1hA0A2gZ4A==
Date: Fri, 26 Jul 2024 10:42:40 +0000
Message-ID: <PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: 4e7e8dff-597b-4ff8-f7a8-08dcad5fac36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?flWgHU0RrjM1lvgpilw0SjZBJXWpZtfIbST6RukIvXBFTzog6bfidTm57Aas?=
 =?us-ascii?Q?EaRL0ZlIi4tgzYPKkRV+Z6ge00E8XWu5qo7ziDuYPODqImjImwnK/zyB9gca?=
 =?us-ascii?Q?v1K5N4NpBSwSl5ZaGMmwc7un8VITYAW9wq0D7OocF4a7X1M0gabtUOLBByu+?=
 =?us-ascii?Q?4GwvfJgHqevKOyTcPiVO764FfcE6VKZA6inyYtzfuPHvEIQyt5qPJ9jeSYFH?=
 =?us-ascii?Q?pXFnfMnN3UUSJmaxzi5BTm9RioFmhqimJEW10+t86dCNpfVOfTpz52jN2j5m?=
 =?us-ascii?Q?TL0QK+yxvDfe6yyyyNB3OBQKpqbqhW/sNljbmEmidJfDpKbbWMmMWOFqu27v?=
 =?us-ascii?Q?O86de3xNe706dsPzZzFIPKTW+aTkBehxoa7zm4/mpZYRZrVHCsl0nXgKaEBU?=
 =?us-ascii?Q?/81pgtnf8yu5AXlwM4APGjYyoXlTgEM/y24hhWc1sMSCIDzh3XnIXqTcCx4V?=
 =?us-ascii?Q?Xe46PL/cAh7hNgZFbXH8zAkLxDVwgpcUOCiBZgY24ERYeSenUCG3KiPyeYfd?=
 =?us-ascii?Q?Go/K50EZKtdYWK9oQpViObb4OcSYqBkaxL2VLkV543rf1oJVFuMcEyMpBDKn?=
 =?us-ascii?Q?zq4AjvTbC+dCdx5QgmRS082ZrGan9JFmX0IjElgy7it/XipMT0udWfJ6+/NE?=
 =?us-ascii?Q?I13ygKeE3BeV9fr4iNCdG86j7D6lsCCRxgscSBcXL/PMTeOx0XI0q8ebWhzJ?=
 =?us-ascii?Q?uosEr4xxS5PSAGT3nGyeCDdg2IweK49nJOxQ57BKlgLvSRphKT1bjNH6ZySd?=
 =?us-ascii?Q?M0ohFuSOJ/C48m3KXCWKeh5F9d3vtCyidCu9zza0b1gG7Rwiv0kX3EcR1om+?=
 =?us-ascii?Q?m9DO4N16B+AjIpAVcuNxJrWc/jF8IXNvN0+M5K9L0iZZ619arNvIPDsCxUBL?=
 =?us-ascii?Q?yIQC/N9jvrvHw9Tl0rG/OxJzobncPJRhZOHrc5pVx5EGxmLMrSHKfSW0ZBNT?=
 =?us-ascii?Q?bIxBj6Y4iB4v6piyaCX2QqjCWbKSfd4Az2Cf36NjNT5qASz/KlMalxTqc5Ps?=
 =?us-ascii?Q?y8+o+Zd/qu5Jx90YQ2GkwiB7A3p4hBhshthpXkTkWhgPF7I8m9eTS7VpAxHN?=
 =?us-ascii?Q?YMj2jqb9k1yvB3auuQzdngPO8tsI00BK5AyVXGw2GnavAFsvCdC2+7HItT+c?=
 =?us-ascii?Q?KaqN3vszbk4d6ZhpU6IRKpw/SdKwUOqMmybxWmY/yGdG0iw53pqqtXCsrRgF?=
 =?us-ascii?Q?JvM/Di8IGqIkAYM71THX95pL4KiAccjLdAmTlkYWA80Zdxn33f1FN6/kKYXS?=
 =?us-ascii?Q?aHYxFNC/F/4zuZSACz/ghaOqlQN00XvfJSqJIwlSiF7pbSdEn48HwWdZvhiH?=
 =?us-ascii?Q?ik2l/qfDt5zgCj6zkoXc0qjwwpbBtO4oloqFhSKCT3xc/fYLVm8h4UL4EHPU?=
 =?us-ascii?Q?S4a/yiTbvIlVW+TEYOulmXyuqPbL8P0dSmq6kDJPugAPX764xg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSb7ctADi23oxtKraIAcsdBXEjnIfxLhTxizS5Bfun4miZF125uK0Mp/tjOL?=
 =?us-ascii?Q?kpyyAhkdcuNEWrsU1mINTnVc3X34Nykn7tfxbnMCKpA0dDq04UpHwI129O8j?=
 =?us-ascii?Q?x16jfzhcZidRRfy44q3AyxrgnSXyB7DarQXZdkCdwjsebceYZ3uz2Hqe2Ql/?=
 =?us-ascii?Q?kCwOAC0nU144Yben5qjRLocgOXd0zSN9ZR8iSGJ/zcmc3ZlowfvSaHbJx3Sk?=
 =?us-ascii?Q?rlT4TgrrJfw+wM3noZ8J1VTNp/fm7cIfevOc3fbKJlV7rrS/VatV3oWoWcjG?=
 =?us-ascii?Q?WqChV/YT9jE2WorhaVXHhpvtxey6LcHFVktpNtX8jBtRLNFHML6tyNFligJy?=
 =?us-ascii?Q?yr11ZdRrufBghsx8nHymNh9qHIX2fKIVEYZRr3KvQpYrBNdzPWr8Xy++wifk?=
 =?us-ascii?Q?RJNO4a6+nsZXKBIv9xFMbvPLqJiBKepkBSm/KvGN+DZLiJYhLfkB12M+B0VF?=
 =?us-ascii?Q?H2LdIFLCSlD3nQM3g9U+3PZrv9A5Cxn6qYYcbMbfpg879AG39HC3k1HpfhxC?=
 =?us-ascii?Q?HnUQH5pP8VdKnO3wLGmk+xeY6Deaa31pTQjIcgy6e6DVMMnMZl+Em+Tvr+RX?=
 =?us-ascii?Q?97fY925rbYywtuzXR4zI9ED9RQPoe6+W1l4axVQ/alGX4cidOoeBhVTbY6pv?=
 =?us-ascii?Q?BjkaUj+IhJ9sJWRHjX6+G5FcWyZMyRbRKqb75T2zsB56Lc7HSr03SZ1Lcj+E?=
 =?us-ascii?Q?l6PDAiWIwqBfh41RKspnOdivzQynvNVehO8p8mu24DNNntIkGNchjeo67Kea?=
 =?us-ascii?Q?J5vlru47qIGDkBv2PUEy6OMFAvZGZUGcA4rVxPx2Sht2s1UDJCKN+ZimiN0l?=
 =?us-ascii?Q?36kXOc3SIS7apNqWC6mWPnIuRTwyPZkGEdmx31l6FnYZyP9PBiU2IPeSduQ8?=
 =?us-ascii?Q?l76tCSPJLbkv6VsoJKTS2TaYGzLbVfM6m0aXYJv+1uZHEr3U3JePjMox2z30?=
 =?us-ascii?Q?jWl0qBy3pixyXVQZrLw7rWUUoC9O0eeRtpMPYNO8Jn/A4iN5haokh9Qne8U8?=
 =?us-ascii?Q?b8mcFT3Egctv5tK8//hqVIg0Nr5UrQcOI4YWM72mWmXKEsuVQ+nfIp4870e1?=
 =?us-ascii?Q?JOINcv8ub+IiBT1Rw6j8474bHwQ39lE5aDYtFCGCyXwXRiez4rxl3iVNhLXf?=
 =?us-ascii?Q?ZQOs6KZlln2jfMlnbB2KZwlnec+7KZIy/l/RVKI+j6oAJKjojUXTS41HY689?=
 =?us-ascii?Q?/a/Gfc5RPfdy0jqsGJpFSFHRlaTteR054VzCIGEdXU7VEWY4kDYcW3Him7DY?=
 =?us-ascii?Q?8x5dOzjKJx0+9YnzqwlJOTfMoMtIQjz8Vblq8fPwT1K+486njBbkpBCgbx15?=
 =?us-ascii?Q?hTem5hyg6mW+4w2A56QNKRU3BaMfR5hKpG27w/L9zaqzXPF5vFvBjtZw9IeG?=
 =?us-ascii?Q?vdQxXeeg1rKqGs8mdEtNbZF2b82216TNZgqtH/VPqAff/7mwAAQXBabLUmGV?=
 =?us-ascii?Q?Cki07P0eMFfboUOHajIWMlkJg4YWuJKJj3hkgeskKGQP2M0vQtpFwIAzeqKQ?=
 =?us-ascii?Q?Tl6GGAmYSo8ZSzctm9f725rJiOUKBTvVPC7XEW0+LaGE9QHMs9VKuOn7EjsE?=
 =?us-ascii?Q?eOZ9fmK7w7YbxKWOAhPlJuXbXn9IAFDfmkzoS7KN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7e8dff-597b-4ff8-f7a8-08dcad5fac36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 10:42:40.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bd+hed8TD0WWjqGu5usRPm2nknhWehndvP5KbJJzJHEbTAReAuAOwfDb3elX1ZPU7aNpWl8s0r5HskYHMbVffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

Hi Xenomai Kernel Team,

I notice today one issue when compiling latest version, v6.10-evl-rebase.

>>> error: duplicate case value
  160 |         case HYPERVISOR_CALLBACK_VECTOR:

# make -j208 bindeb-pkg  LOCALVERSION=3D"-1-lowlatency-evl" ARCH=3Dx86_64
  GEN     debian
Using default distribution of 'unstable' in the changelog Install lsb-relea=
se or set $KDEB_CHANGELOG_DIST explicitly dpkg-buildpackage --build=3Dbinar=
y --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat de=
bian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
dpkg-buildpackage: info: source distribution unstable
dpkg-buildpackage: info: source changed by root <root@0296de802d65>
dpkg-buildpackage: info: host architecture amd64  dpkg-source --before-buil=
d .
 make -f debian/rules binary
#
# No change to .config
#
mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=3D/srv/tm=
pfs-disk1/build/linux-evl subdir=3Dtools/objtool --no-print-directory -C ob=
jtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  UPD     init/utsversion-tmp.h
  CC      init/version.o
  AR      init/built-in.a
  CHK     kernel/kheaders_data.tar.xz
  CC      arch/x86/kernel/irq_pipeline.o
arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
  160 |         case HYPERVISOR_CALLBACK_VECTOR:
      |         ^~~~
arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
  154 |         case HYPERVISOR_CALLBACK_VECTOR:
      |         ^~~~
make[7]: *** [scripts/Makefile.build:244: arch/x86/kernel/irq_pipeline.o] E=
rror 1
make[7]: *** Waiting for unfinished jobs....
make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [Makefile:1934: .] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned e=
xit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: bindeb-pkg] E=
rror 2
make: *** [Makefile:240: __sub-make] Error 2


BR,
Ionut Nechita
