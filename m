Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE474C63
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179664; cv=fail; b=MAONT/CJXjXDyX0zlUhCZ1H3fEu6Snmfar8V4gYjiPVXC0HyUW1+5z4F2flHvL10iBGEcKPiPYZcWfE72kLPsj7gYk4g/fmcWygtxF/QbVViGuhk9a26QaidzX0LaFfEFxwIeBEwMhtwIcJ+2bSCUB9ej0+CFWeiF3pGZQjwNpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179664; c=relaxed/simple;
	bh=5Xnva2VKdqrtRM3QTyr9qYZaMkvp13cKmzPpQZTiDbg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ENvfFuTPJ/mSzudSnIEM9/bnUt8Ixixtb4IBFCuEUkUvJUFGXF2XqRqYg4KDy0rPyHOqx3QHK6HnARYtXTiycrSiX7+mEdyXXdaikMcOHkqsCe2XqDBwXJ5sYUxwwBE7yK9s9zybbFa2KAt8vwEQAyOGL/qUroij9wWGZm9J1Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTNoP0/d; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTNoP0/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718179663; x=1749715663;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5Xnva2VKdqrtRM3QTyr9qYZaMkvp13cKmzPpQZTiDbg=;
  b=aTNoP0/dw3fTwjCtbgd1hxbbKKD1V81KsrIRQ0OWcs0dE1nrNeAEdNbw
   dKPHCcUcyCgi/pl1JIWc/Nk0lmF7jz58R4tZPSKK5H+KvkFwsWx0LH5ym
   VgSF6Uyn2YWnWQUEbVKvL53sud2wbhYWzITl7793Rb7vwrDT0RMukjloI
   O4QvT9Lb1HzXdcWmnZxGVhv2rLH4a/0Hbh3AFndsiK0mwGjVYWjkcDoH2
   yDBFXZrBkI7psyHLa8xSNkXJHo3OnVnTzggZshOU5ajMXJTtSahxvUyC9
   mqt6165+6jaAPlH89Wwh3faaeHZkr/RgYMKM0zmc5inXwhgWOGgX1P2FQ
   Q==;
X-CSE-ConnectionGUID: hQY7A99OSZWB3KGfSzNETw==
X-CSE-MsgGUID: xs7y+ih6RHGH+8gJ1sdWgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15055057"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15055057"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:07:42 -0700
X-CSE-ConnectionGUID: ouVckrbSRmi7BjM5zusHBw==
X-CSE-MsgGUID: gsQVrty2Scao/AY+a57FGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="77165260"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 01:07:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 01:07:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 01:07:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 01:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxSGrbgx8yZb1XAYhzsNsy0somiPgmAQXbIMSi+o87/39XnN5KGAyvYUwdcJVgZ9QSb4hLAKY8ANLj4EXf5rguIw7rAGs/ph+F7onAEmOd5G9rA9KBDM+s5NUGul7l8MZWBSp/fhX18Nu4FUY3G0BO3VBMMRl89QTXlj9olUBVY1Y6KnD9CkiTLDMfrNIDiFLnYT4Qzajs/7eLQdcaFg4Ox+elc4AH7uknLY7YId/6njNv6Amu5AxCET2lpuWVG4jhHV7RGx+IaHtg/z3kg9m1UEhfHY6hIFYOaoO68XZROV83eDg/xK6y9t6MpwA16DJ3uvCortZyTxWXxcrFyO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xnva2VKdqrtRM3QTyr9qYZaMkvp13cKmzPpQZTiDbg=;
 b=fCPfncKcjIrOPJZ99eyEFJA1snFUwbCsemyZyUUk+QGBEDahA3PyzOV4lyf5zzj+HBsd9OqyiBcWjPA5n72+53zdzz/FLmXAJE0VNh8ypLf6YNLobY3wXpBB4gicdzmT9U6SEGglN54zgizizDxyacMkamoauomOI/8C8uW0YJZ9JNTApHg6WtkJThlsJjHdPdl8ypGgGIh6ROZN4KrDQRHOQVOu0mRHiEuVLG2wy3YAOyUK/Bz3wOgAWPA9t4gx/CjIf1dAZAAtS47RmTF+wKKYazqARd/H7RSHAE+ac1N50zwF8v87BykhHZw9C6raB6Jna76YAZnJg/KuVFDQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by IA0PR11MB7882.namprd11.prod.outlook.com (2603:10b6:208:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 08:07:33 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 08:07:33 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?RnJhbsOnb2lzIExlZ2Fs?= <devel@thom.fr.eu.org>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Porting RT net driver to dovetail
Thread-Topic: Porting RT net driver to dovetail
Thread-Index: AQHavJhZI9RzKNd7c0q6ZVIuUm4fwLHDv1ug
Date: Wed, 12 Jun 2024 08:07:33 +0000
Message-ID: <PH7PR11MB74994E73E4A092626F492425F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <1158-66694980-9-2e725200@6131738>
In-Reply-To: <1158-66694980-9-2e725200@6131738>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|IA0PR11MB7882:EE_
x-ms-office365-filtering-correlation-id: d7748782-f004-4f76-cd1c-08dc8ab6b6e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|1800799016|366008|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?dlcwcFVlZlJCV2pyT2tMYWRwYTZQT1ZwT1VsTWx1Qk5DZzNLejRHZm03ZWZT?=
 =?utf-8?B?L1hkTzExR0YyS05maUJicWpmQXZwVnFMZ29ta3RFK1gyckE5eXgvd0tsbGdI?=
 =?utf-8?B?dkI0VXNhcnIxSEE3REhUamRuMU5hbFZSS0g0M2YvWFJ1ZS9rVU52VzhpNWpS?=
 =?utf-8?B?SHdlc1R0a1NRZlpFM055V0VGTUEvYnQ0ckhxWDlTczNuMWFVeUQvVXZZQnl3?=
 =?utf-8?B?aUhZa1JwQ042SVo2NEJqYVFPNFVqQjZmbmZOdjlUQ084MUIrbUkxSnBOYUk0?=
 =?utf-8?B?bVpuWmZ1YVNvamZUNXlqUWUwZHBFTkg0RW5venhkUFlEUVBMWXRsUVVhcGdw?=
 =?utf-8?B?TFNnQlJ3UVhVSUl6Vit6eGgyZkJueEE5aUxsSnRsWEttZ3phTTY1QzFVVW9n?=
 =?utf-8?B?eEdIYWFSOXg3TkNoaUZVUVJoajZsOUlCQjhNMjRlanlBdXRVZG1mclFhOTAy?=
 =?utf-8?B?bHpNbHZHK0w5YzBLWXhJdlNGT1F5c0ZmMWxGUzlEWVAzTXlUM0trUUVKeXRn?=
 =?utf-8?B?UlNCNjM4TFFmNGpxRW8xbUM5bUdXTkdYZFZlcjJZQjVTWjBnUkpyV2VwYk9Q?=
 =?utf-8?B?c3ZuYXpNdzgxUlRGZkZUMys2NE9pRGl3MlZLMVV4bzk5VUc2ai9hMVYva0Fm?=
 =?utf-8?B?TFNrOFZzVUwvNERTMFVzcTR1MkJtNjJIOG5CUmxrT0dSWHhiODNiRlYrbFB2?=
 =?utf-8?B?YVdlN2lIbE0yeFhqS1BoK1plR3d5VmVVVjJtam1nZ05CNk9iS1QvNUVDYzBh?=
 =?utf-8?B?MG9ySDh0SWdlRzZsdnZGczVtNXloT2xkRk5LalpYU2NEejRDUGh6V28zSFBz?=
 =?utf-8?B?NUcwTDIvNGpoaWRXSUFkSTllOWpOd28xejJGeVN3MVpKaFJuUWFCaDJYbHN3?=
 =?utf-8?B?eWJRYmxhNnR4THhyZ1oxUkRtK0cwM0hZY3MrRjFHOEhOUlhZRXlLOFBKb1Fh?=
 =?utf-8?B?QUxQTFFxalZXL1E2SHpOWXhRd0R6YWFGZDEyK0o2TklUM1JieGkveWdMTFhm?=
 =?utf-8?B?aGNWQ2t4Y2tkaTJsWGdGUm9SOWZWVXNITFFSSS9jY0N5bkswLzVLR3NUakZ1?=
 =?utf-8?B?K3RDdStnY3BQVGpjVUp4Q1k3TTV4RUl0Sk14MC9xdmM0NDJvV3JpUkczNVl1?=
 =?utf-8?B?T1kreS9TSEJsNVdsUmJnb3pFc0dBQVBIbTZCZk1BdDYxUy8zWk5oT0pPUlFa?=
 =?utf-8?B?cTVTYW5WWDFTdDBLbDRmQ0pmSnVwTzFlZWswcG42d0tXOU9nZW9VeEVtdjJE?=
 =?utf-8?B?N0JkWnlBdm00NGZLemlCMEl1RjNtVjZYTEl4M3cxWXN5S0d5dkpVRXR6ZGp1?=
 =?utf-8?B?R3RMaEJvQ1p3Smw0SEtrQTdreUxQYVdGR3FGZlYwRFU3ZGdXSlR3UlpiTi94?=
 =?utf-8?B?QXVSSE1FMnIvaWNDcDJEejNGNURPRWsydEFZdTZqbVdGVnRBcU1VSjdyNXcx?=
 =?utf-8?B?SHZWN3g2RGdRVWZDWWxOYVRheEZBTzgxeVRvVFZPb0EvejhUVkxuSVdPS3A0?=
 =?utf-8?B?NlRVblRXTzBFRStHSEk1UFJ3RThlSjdqVmtPbVN0NFY5aEtLUFh3d3dPRUtY?=
 =?utf-8?B?NFVFZUU3N25GZ3RuQWRvcUJTcldlMWoxSGJwTXhCUCtoZGs1SHJNR3Fwc3RK?=
 =?utf-8?B?eVRjejV0SnJqZ1l3ZXR4anBFbUljYjJtdWlZdnFqSlJkY2x2V0xEUHFDeWhq?=
 =?utf-8?B?dmJZR29MYUg4Ylk2VGxBUWJYTm4xQXVQYmdHTzJBWVg4Tm5yanNxYTU4Rytm?=
 =?utf-8?B?dnFWcm5NOUoySjNYcTNoUkdHc01kMkowNG8razNwemNlMExIcVJpL1lGNGdq?=
 =?utf-8?Q?yoWnDOimGCfOiqSybUXpfb0EKVUEa9T6bkXSA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(366008)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGgvQXRCRG9YSkZDNlFjWTU5bTlZUEpGcHFUb0d2M3Nnb2xNdUtyVGM5REgy?=
 =?utf-8?B?cXFDVlR3dWlxZnRjT3Q0T1FTOWh5OGFaM3ByK1FVWWtwZExpUUEyNGFNZXho?=
 =?utf-8?B?RkhTSk44ODd0Y1NJS2pRNEJFeVMzRFhmeEZieVF1aFF5WmZxMXlsNmtoVGsx?=
 =?utf-8?B?SW9URHhSZ3EvZUZpaVRiY2paTmRheEJ2MjZ5ZlYrbUU2YlRnN05MblY2NEZ5?=
 =?utf-8?B?TFhsK3diVXBzelB4N05GSEF2VlFTNi9Hais2aDBydjQxaE5aRHk1cWthZFpY?=
 =?utf-8?B?OFJ3S05jNFZrUGl1NDR3ZGFBaG9jeVl3ODMzTXk5WVZRTzhsckN1aXR0eW4v?=
 =?utf-8?B?REQram01SUlxRE4yalRNVm5NRXZ1b2JpWEZkZkVLcjNSVlZwQ3NvK2FUdjMw?=
 =?utf-8?B?aWU3NXpsQ3FwQUw5a01PT2ZQQjJHaVZnM3JNTmRVejdheUlpY05IcXphZUdu?=
 =?utf-8?B?MUVaYnM3MG1lemlQS0NCNzJ1cVFtK2F6aXRuWlk3cm9qaktNQUNyaU40WUhm?=
 =?utf-8?B?QkdvZmdnL01WazhDaUdHTXRGRDFEc1B5ZzV3bjVYTUFGY0tjTzBnQ2pKaENL?=
 =?utf-8?B?NDZRaVgzNHVhQlZRUjRnS0tic3F6bjQycTFQb1Jxcmc2VEE0T1N6SWxRaHhC?=
 =?utf-8?B?U3pVYU9jbTY0SUlBMGFpd1E1a2tSeWhCNStKVVFKYkxvMU5yUWVXQTk3VVJo?=
 =?utf-8?B?WUZVQ2VsNlc1bUMxR0M0Qngzams2S1FWYnMwT3VCVVprR29WT29YMHpOU0R5?=
 =?utf-8?B?MVBxSE03MVJSTTdlS0t1V1M3aGRhU2h2b0J1NGw3UGVuTm5hNTFyTThKci9M?=
 =?utf-8?B?cXNvNHRLWUYrU2JOekVEckcwSGFCNmJZOTUwQlFtc0F2VStMQjVJS0k2RTF0?=
 =?utf-8?B?MVVtbGN4dTZhSjVYYjg2VHlWZXdRMy9qZXFKZ0VlWjQ2TWI0SWpyQXVEaUZN?=
 =?utf-8?B?R0hTSTlIdDFyaGFYditkWU1ieDg2QVVDQjVySExHTG1VNklVQU0ranpldUdw?=
 =?utf-8?B?S0tnTWhSaTR1SjYzckxuMnZuTzdOQmNIUUN0WVdLelJBa1JOYVlhQjlkRW1Y?=
 =?utf-8?B?eG55R05Yb0EzMDdpeTEydVkyNEwvNWVSUWU1SVlxYUNYcld2UWdlYlBVUWtq?=
 =?utf-8?B?NkplMGdVWjZBTk9aSk05ejhJK3R1ZVVUUVVrYTZpbVdMTFhMbTJHZm1sSmVL?=
 =?utf-8?B?VU82a09ad050dnN2SjUzS0pYVGZlU1RZOVdMb3ZHZndES2lkMDYyOGt2djdB?=
 =?utf-8?B?Yi9UaXZXT0NEa3ordWJ0aHNJQlZEN2VUblBuUUNrY013SUhuejNkQVVocDBn?=
 =?utf-8?B?cUlvUlBJR0RJQXYyVGlhVENSY2JkQk03elpHNFcrOGVqdGhRRXdGbHN1b1Zt?=
 =?utf-8?B?N1JVWXZqMFRlZ1YyR2tsYnJrTXNpdkhkeGVFS050dHZEU1VqSlN4aVBCbW5h?=
 =?utf-8?B?cFdpaE9ieG56a0xVdVpzWlNYajFjQnlWQ0tIMnpSbXNaYUVHbzhlVy9lM0ow?=
 =?utf-8?B?ZzlHMFBvck5YZDFpQUVmQTJSWjV5b0RJK1k3aUlFOWNURjFOVVBtM1RUaktv?=
 =?utf-8?B?bkdOZmY5Q0dySGluQmJncFdlNXp4eGJUNXZ0VTk1VGFUeEY4UDdhYndabENu?=
 =?utf-8?B?KzNLd2JoaFBGeFV6dHBkZmx0SVkzN05mc1B3R0piR1E2QzJWY2lTK2ZXVGRB?=
 =?utf-8?B?eFRaaVUyUTFCYUpPMVJjV21xb1VuQzJsMWhLdzVpdVpPekUzL1FDaDZSbmk0?=
 =?utf-8?B?VnJMOHI3SGo0SFl2eWNadDRyNncrU2lzeS9nbXNhcWNJYkFCcG4zMzFFdGpR?=
 =?utf-8?B?NU5IRlRyOVBhTm4yTFdId2RzNzliOWVzOURrRjJNR2hXSjdoYVYycWo3R21x?=
 =?utf-8?B?bFlCK052RG93eHllclp0cWZKME82c2o0Q0hia3Y1RndpWTdiSU92RkFFcWNC?=
 =?utf-8?B?azhDOGVMTWEzWG1zaDNNcjU0SkJRakhiRXloT3QwcmkyNjZvNnl2S2plL3lY?=
 =?utf-8?B?cGpHRXF2VHdvV0xrSzlwSDJDcFkva09vRmdsMjE2OXg4SXMrUmV4cnVRa3pO?=
 =?utf-8?B?SUtTb0lra3FWY0tSN25nT2VNZHVXb2RmSEVhR0F3ZDhrZDliS1RwOWdwb2h2?=
 =?utf-8?Q?xDjk53tcrCtsRX79dNH1kUZxV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7748782-f004-4f76-cd1c-08dc8ab6b6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 08:07:33.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hDIvOCvYErzs31/OLMrxHCEcHCSNxAjdyAFLns9hdxY5yFIQmj1jTSTvf8SxqtpsVPMbfDfv/oxae0JSL8LQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7882
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZyYW7Dp29pcyBMZWdhbCA8
ZGV2ZWxAdGhvbS5mci5ldS5vcmc+DQo+U2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDI0IDM6
MDggUE0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBQb3J0aW5nIFJU
IG5ldCBkcml2ZXIgdG8gZG92ZXRhaWwNCj4NCj5IZWxsbyBsaXN0LA0KPg0KPmNvdWxkIGFueWJv
ZHkgcG9pbnQgbWUgdG8gc29tZSBleGFtcGxlIE5JQyBkcml2ZXIgZm9yIGRvdmV0YWlsLiBJJ20g
c3RhcnRpbmcNCg0KVGhlb3JldGljYWxseSwgdGhlIGV4aXN0aW5nIE5JQyBkcml2ZXJzIGluIFhl
bm9tYWkgMy4yIGlzIGNvbXBhdGlibGUgd2l0aCBEb3ZldGFpbC4gDQpUaGUgZHJpdmVycyB3b3Jr
cyB3aXRoIEktUElQRSBzdGlsbCB3b3JrcyB3aXRoIERvdmV0YWlsLiBJIGp1c3QgaGFkIHRlc3Rl
ZCBydF9pZ2IgYW5kIHJ0X2lnYw0Kb24gbGltaXRlZCBOSUNzIGFuZCBwbGF0Zm9ybXMgdHdvIHll
YXJzIGFnbyBhbmQgY2Fubm90IHN1Z2dlc3QgbW9yZS4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBD
aGVuDQoNCj50byB0cmFuc2l0aW9uIGZyb20gaXBpcGUvcnRkbSB0byBkb3ZldGFpbC4NCj4NCj5U
aGFua3MgaW4gYWR2YW5jZQ0KPg0KPkZyYW7Dp29pcw0KPg0KDQo=
