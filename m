Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E911C83
	for <xenomai@lists.linux.dev>; Thu, 22 Feb 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565067; cv=fail; b=TCsuC1VegHVlBy88UVNGkquXA5TXVbB+vKBCtPPJKCqBE5JLwVnRC6N8W8N69C8wyXduHBebdSWtL7tF5ED8pWzrndkVgPXQlUGpkXKJLj+6fKNd2Dvqtv16IGUHpdT2VAvuxM13g8Azo/CkoBWiDaSi3msEkciM40m/kNkUL4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565067; c=relaxed/simple;
	bh=T2nNzRZrwUmYIV7uHxuXaMjA6peXP2GRGYg2e4IrGdI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilZMGVwsvPwIMLp1t3rj43YRNKj93FONCDWha6o+2awG57S73JUw7HuiMaKpnR/mGEki5ftHHldRlLVG9vzN11Lrsk5qEKewit5hrUgK9RGWOZTzMuyhJv0z9eLiO2QeAQhtDhdGs6juUbTXYBibgYJZIPyXqPx9CkLluHYKwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8fC+IZN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8fC+IZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708565065; x=1740101065;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T2nNzRZrwUmYIV7uHxuXaMjA6peXP2GRGYg2e4IrGdI=;
  b=b8fC+IZNSetP32MlY4+GUa6bv9Tr3HKpdvIanFV2l+v+QkFKk7OH2Qqa
   rJLysJU6kgwWCB2UND4g/YaeDmIOQ+fFrbxsVTLhtBIfNnbKiNgwkjH2M
   R0bSGQF18wRHduZ6OlRjkxMcpGWW/Gvaj6brZJ61bcnHp77OZPQzLBKaf
   DL0qSSfF7HApoTGdWH6pz5COzsWDJeHWsQrn/XA/Fbtj5eZiYMg5miweh
   Muy9ybAkQ8jf71ocvJnIaK575jFm2qWQSw6uxF05PoeOfEQsfLcvnNfzT
   pvVhU0FwO8MDVLMKS778ZMpkFCxlg9Q6kdFM72aDV2u28b0BVcyw19j8l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13384389"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13384389"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 17:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913416069"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913416069"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 17:24:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:24:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:24:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 17:24:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 17:24:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHGNmIVgJ6Nvv/6bu41r7/i1nYqobt74FWt0j28hD9wNs3IjX5Tnj/RK2jedk84h247QZrlPsR2rfIbc+kxBilLSvethlZ46yPGZnQcHVAbHtFRgT7Pv3xZ02lQvnP7pfqcy0CZzuH8BM0nzlvzELCwU4Te4dcmWU2pL5IZXwnhMq7jrUHaqt/jLEgqHakH7/0HI7CnIsm9GZmTk6it0Ol0BZwgXzFdD7hoJ1k2jNibCTpfMMZUexKJ1riLP6bgPGyb+IMPooZiEkGwWwd8u1c3DDqNvYLyz/weNRyBUUmv2xYqRiU1X2Yv7ezEzNh0aaNcFxYA9JxnLcqBl2SRzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2nNzRZrwUmYIV7uHxuXaMjA6peXP2GRGYg2e4IrGdI=;
 b=Qbf8xFVTxO+tEnG41U+Wt04P8xk5HB+C/KD1GteZxpFyl60MFMeYhGGvSukvelZOY7MV2PMr8REnO9gTTTqlhISg+xb/8UBksrphAiWyXxLU43sszaAnIJ5g9q9Kx7pYN2SML+Bwgs4vIpRSPjl9WZ1ECnQwIlNbVJ932bEpKuqfEzMUfBle9gMZ0junFgdLx7xb089ftgf48FxZEsStBOqDyZIiBLuH49EKfHBw2kZPXjAQrzUZF2GBwfGjf9kTKO9yiUPlqkIGlluL37oWnofwirWAgkYx1XwOq6efawjJuonkmMIDmshkeneeEr3njt+7hWb3kk1aXrmDu+x4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 01:24:20 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 01:24:20 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Feb 21, 2024
Thread-Topic: Xenomai Community Call Minutes - Feb 21, 2024
Thread-Index: AQHaZS3cpentP+R4e0Oj6aIKPkPnRw==
Date: Thu, 22 Feb 2024 01:24:20 +0000
Message-ID: <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB8454:EE_
x-ms-office365-filtering-correlation-id: 727422ce-85e6-4413-3e37-08dc3344fee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1ILjDb/8hdgT7JYsnn7B62MJn5pCSgPFgx9uqoGAzaLJy9mufGAcZ5Vv5+fGTgewfK/IQ654uHXbhm0Kt8eYhUzrdHpEd77CmQ3jPfIGkiDSVTBFNc2NeLnMQFV1Yr0UK4KzT0LfYeiHA2bJfWqewH7gMspaIiY8FxajVrzNO6O4kPtZy5994RluFYEaSS2eHOcQ69vMdyWYJV3ViOG+T5HmCXYcQDHVOZg6NcP1bMddld2rPXwGWu5qnN3EllOtdO+kPT/IDQIqznTxWUgT98TNHjgb6uOXuVA809fT0D4AIx1+1Ova5owXzLHEXfeeF1KYJc9KtwROv3sC3dpc9nZJgCecZS/0dn4QztMoP5A/prAj/VSehMzGOjNqB40+FhVoUugieqNlBg0LJB49Q3/uMnI47x4eD8UQ5CTfdCOwUGbr0Wz8Olj5mH8UCFOgOjCdrJX16zZh/62tAbsPCWtPv6u308ThhtTPrJtoW5WV8fPoZ/VN23pxSnUlyReqd6F7q7FnxF37MZ0ph9vHquJHAGtkmhl2iVjsWY46Ha8zXtYxhjzFLqhlyxRCu4wPpV8DqzlxHe+aqM9EUyGarW9Lqv6qoEYt3Oq1QF58wq/ctrViuSIdc8Y24Pq1kas
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBNcnVjbGlic2ZBdnJVbEFRRHZyZlFmZkdQbkhxOTlFQjh0MlVXY2FzRE1u?=
 =?utf-8?B?UmY2WXhMRzhxcmkwRC9aRThoZXFNYXZPNTRlVDNzWHNPVkpma0FXbVpnenhM?=
 =?utf-8?B?VjFJa0FEUnhMR2RnejRoRy9rYndTeGxYODBXNUx2TEcwQlVlSEhnN3lhcGx1?=
 =?utf-8?B?eUpWb3JOTjBGTzJFRjN0UDEvVGhuYVpOY0gxbWg4a045TzRRVnh3RWVJM1Fp?=
 =?utf-8?B?ZnZSa2VwYW5FQmNCU2JXUkt5N1FTME5iUFJ1aS9CNmZxUFJTNU9HMG5ZS0Qv?=
 =?utf-8?B?SnpGOCtNNTVmcER0SkV0NTBsVkw2VWFDcDdHQi9XZDhsUXJzcHdkdExjYzYy?=
 =?utf-8?B?OFVGVWtWdUhaYmx6ZnpPYUZQRFh6bGkrYk9BK2prY0wwL0E3TzBKVUpnZkll?=
 =?utf-8?B?MHZVb0JNeTNSUHBLK1Jab1p1cWh4eEZIMmZnWnk5VjZHVDBrcWk1WmVlN0pm?=
 =?utf-8?B?K0VXTHpheUErTHBpOFc0czlxZnpRR1g0V2M0YnUvcmRhYjJOT2U4L0dOZ2VO?=
 =?utf-8?B?K3RZMFBTa2U3YWN3V2RMRUVNTlNIcURFck5lczVLUjdFOEl2bnpLMnZkTGY4?=
 =?utf-8?B?Zjl4UFVGczdZK3lKOFp0R3gzUUhTN1lObm9RcC9OaVc0RW93RmkxRUEzL0lP?=
 =?utf-8?B?UXl5bWtzMzNmakFyNnNHUkZmY2ZGeWhCMndId3ltRXhBOU1NcTc3bnJpeUFM?=
 =?utf-8?B?aXZQT3B1NUp3dkRyMmFNaTFod2dFaEpiQTlmUWI4V21mSGJtMVdiNUtjYW1m?=
 =?utf-8?B?UFg1ZnJwRTFVV3h4UlNpK01vL3JQRGM4ZFBzR1dzaHByY1cwZDIxTmxHaTBu?=
 =?utf-8?B?QTE3WmFhVVVYcGNScWJnRW4wRy9qNXNpb2oyeWNOQWk2VjZTeVpqYkVvU1FR?=
 =?utf-8?B?RXNvUzFtWEdtUllDZm1EUmJMa3hwUUdYcEFDTE5oVCtXbXRRZWQxR1J0emt2?=
 =?utf-8?B?T1piVmw2dDhmazgyRFdNakp2clFpbUttVlZmd1ZEWXJJdkd4ZExZK2szU1Ba?=
 =?utf-8?B?YytoN2Yyb3JpN1c0V1Q5Z3hEOGNGT0RGRWpCays0WCtPRGhsbVNPR3pCNFdl?=
 =?utf-8?B?OUdTSmRoeS9CaVByUVZKT2VHRHRnUUNvTEJsaDFOMzI5cXNzMEVraHR3S2FX?=
 =?utf-8?B?NXJGNjN4Z0dmeTdVS0xaekhrcHVVYWgyRDNlTmQxUSs4RktIMGtlOXo1K0VZ?=
 =?utf-8?B?MGdBMjF4MGxGUnorTmVsR1pPSlhKUHhsTTV0em5acDRLc1ZVUzAvT3VEYklj?=
 =?utf-8?B?V0FUU1FrYjBFMGdKNDZ3cTZNNW0zS1gwdFJSYjRyZnJMVTIzNHloWHQwM005?=
 =?utf-8?B?cXp6MFgxNlZYRUpnR1BLMzRGaWhBajljRlFiQW12M2JKTlZFV3BZMXp0LzVx?=
 =?utf-8?B?UnB5dE92bkFGdjdoMUVRY1NCdGZBcGJQWmlaZWxnalVmWE5ESmFkLzVMMHJB?=
 =?utf-8?B?eU1lRjlUcnhtZWx4NDBINnhSWUhzbHVqS2kwajUwSHNUdWp4dnRteDg0anFt?=
 =?utf-8?B?QXJoRitkZ3dJSWRSOHdXSTVkMENhdUpxWmhIYmQ0SEtqem1mZ1ppSVM4SW1x?=
 =?utf-8?B?SDI4UHFMK3BxYkU5ZmVYMUw4R2czblB6aUtkb0ZOMjVHaU1MTzdzc3drOUxw?=
 =?utf-8?B?UVI2ZzFMUFk3K0lKZ3pyQUlaMGY3cC9DWjEydnRuY2d3TElFR0Fzc0kvR2FV?=
 =?utf-8?B?MklYeW9BUStOTlRCZmVBbGhEdnVYdjlZYVluUVdQWFRmQmJERE1rUnZaSzRp?=
 =?utf-8?B?VFpZRzEwVUxlMDNnbXZ2QXl6c2l4a0FWRmVvaXZDR0RvdVUwRHJzdmxCQmtU?=
 =?utf-8?B?SithaHlXbW1aRnZWZXpuS1Q5Rmd5K0t1RGpVbmt4UlcrekFyNlNhQ256dFB0?=
 =?utf-8?B?QTJ2eVNJQzhRZlBkN05QcUJqcVBJcDJ0QXB6eUlxZkRmYzZBK1ljZWNVNGJB?=
 =?utf-8?B?WUx5a3RzL0pNWnltNGcxRzVMcFhLQ3A5UTZmMTYxa2JKYVFwVytvU1VTOWd6?=
 =?utf-8?B?cXErQmJUTS9VMjQrTkVVOWdmYm13TWU0T1pLNE1xUHlSbTFiMmdYNEhtcWdL?=
 =?utf-8?B?K2JIcmw3eFhqTmZRQ0RvTUFHSGk2cjlESENsUmlrS2tleHJ6bTFwZ201MWNJ?=
 =?utf-8?Q?o+PKlg+dzWfvY93TX3AJjWLrF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 727422ce-85e6-4413-3e37-08dc3344fee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 01:24:20.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /imIih3Zi6PZQn4i4zPO1eAGQ2+dxei3SXZLfRAINSDv/PJ15G/3m5CP0ap+SVh4xghipVs2Anwea+lIhSWHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

DQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVy
Z2VyDQoJCURhdmlkIE9iZXJob2xsZW56ZXJtLCBKaWFuYm8gQ2FvDQoJCSBIYW8gTGksIEhvbmd6
aGFuIENoZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToNCgkJQ0kgcnVubmluZyBpc3N1ZSAtLSBmaXhl
ZA0KCQk2NGJpdCBmcHUgc3VwcG9ydCANCgkJY29tcGF0IHN1cHBvcnQgcGF0Y2ggdXBkYXRlDQoJ
CWV2bCBzdXBwb3J0DQpPcGVuIGRpc2N1c3Npb246DQoJCURvdmV0YWlsIENPVyBpc3N1ZQ0KCQlW
aXJ0dWFsYm94ICsgWGVub21haSBmZWFzaWJpbGl0eQ0KCQlTeXN0ZW0gaGFuZyBpc3N1ZSBkZWJ1
Zw0KCQlEb3ZldGFpbCA2LjEgYW5kIDYuNiByZWxlYXNlDQoJCU5ldyByZWxlYXNlIHBsYW4gb24g
WGVub21haQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4gDQo=
