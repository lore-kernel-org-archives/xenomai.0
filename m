Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D663B5
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691572211; x=1723108211;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bHI6og+Wdld75uBTE+F0OBTeDldLmfcC5O7Scbmdty4=;
  b=mkXfAdo6J6H1Gqri1QVgwMyVnXSNhF59pELJ1bQQTpxp1/N6hA0tQzzk
   X57oGwxIi3Ixc5v2y6vSzWXOvJbSSTurvFShVE0kEYdGfOYIYRxsmYS9r
   uzlCV4RfFhF1mBcE7I4DuxkcCshv1EsnehEKfRcbIIxO1Oo08vsZxDsUZ
   X76+4w7Qw7vUfQQ4JosYuGB2vZZzl0DjMJR4QUIB8xo29AWSZLsh+9M4C
   pv3kaLMQNjYhU7Gozy064Q6xRycLr61cBxxTidX70IpJa5kUq1NiunTXY
   SYF1a5Mq/o9jvWRfpgBb93xWTQzTuTwFR0e2dqowBbheWbMgA7CbPSgOx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368528974"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="368528974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 02:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681603900"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="681603900"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2023 02:10:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 02:10:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 02:10:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 02:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv8Ww3WffjvS0nryHRFMifYX73wMMTwb3ePYdh5uveEIdZB+kxK9e1PAw6Arl6V41Iba1rb9J/9CRu/y6keCH8hHYjD0tHPyxNzR5Qpfdb14VF0pkiMn8w2PHtis6CshkwHMjHo+BZZ52z8COsQu3CEAoz2svxTZTI4AS5BnYED5jbotQ4x2nOCmWHvYaHU7MI168zWyYwHj+4nusKmrT3NGi48kQ0qdQEMye9okquDWnsGjnW3PfnmBdqIMSzfX3AlJkgeg9cGWxkOIfTAlyvCk4Vi9P8/s+Nd4Ry6wA7jGPxmV86t9dGl/CCtqCwzXRvGqzQVs167k1tt639SThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHI6og+Wdld75uBTE+F0OBTeDldLmfcC5O7Scbmdty4=;
 b=a64jtvxsB3qGe/OW5GtybZli3u+PlGuxBR7bw9bYnuIhH3RbJ2uUG3KQ2iNMgNSco1S+wf8OqLF9NwueOjbk4X5Is4oiI7VNMHmmEo7YlM+g9YRvYvzRmnbJzDsJRAUPGXDvHG+zU9OCxyVUFLPxp3wCp2aBSwlXBJ8nHSJdTZ9m/hMdWUzUkrWtJjbqoSq4oTMe4zSiXPPy+sYkk0XpKTjH4/YLEQmt+960cMvtH1SxaME9z4VweQyGTUd00/p35s+XlNrCkswrEKe4HFHPhbd/H60s2aO/par3X7i91C6Cqn6RJ8N6hUE2Kf6TIgvCokZZA1F8TIUqhnYJhC2grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 09:10:08 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 09:10:07 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Aug 9, 2023
Thread-Topic: Xenomai Community Call Minutes - Aug 9, 2023
Thread-Index: AdnKoR/czrU0lpzHT/iycoXrRQSRuQ==
Date: Wed, 9 Aug 2023 09:10:06 +0000
Message-ID: <MN2PR11MB42856A6A032214EF4F94DEA8F212A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SN7PR11MB7706:EE_
x-ms-office365-filtering-correlation-id: 1a5c1f06-31d8-42e8-a0fb-08db98b86c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jw2XdkDnvntGmrjMNq4Rqf220jnVkFDJOk9eXehOrBp3CKYOGtgeO6kwilWxfzWbafV9l3JSB6HkctFtUcBAORz05KDeHhH32QnfUp/rbYGdc5uJli5Y6IqF9XnlINP/6HDQjmFuXnHyjOAOLn1BGkq2ZTR36jXXNU13nAIb66HvqIjqgskmZWUwpC2W/jSfBe0T6oxwOPz+z6gFMF8VU3o3YsyCj9PjnFSMU4k0W+vCC5haevAdPVWgGJA9GHfLNGzMFMDcbNxXjHFifiNBhQgPkJXXty9hjJ4XCM/zs/yino41IBk5Kp43wWAfCpI5pkgNZliIk9d2Xjhbr1ky++4/b9KPayLujP4r0zq//d6nIozm2umRG+H8WjOZ1zw+v3b7L8Zi4VXvROhgli9lk0z9duJSsCnytw5bDpe6O+jAXMWTGm6p+rTtck9hgv6zlB80EgkDzajIbEDQJ4uSyKTowCqvmxIVbWOMJBdFGvgqQY6qy+4ofLCSaXRnrFdjsb6kdPkqpkKIi/+PcGjoiC4+h9tou/k0LBLsv4oIRZ/+mkbdU9b8CEJ10NWvinaUVcQPLNGG5IMqbmwgOXH7R12wVLPTQMftFvkDht96zOhdx2uCXbT3QrfAu/GGAOXIJNdMZXth6pCz5C/hZcUCCRJDLP7qUUaeDC1XBm3e5ZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799006)(451199021)(186006)(55016003)(9686003)(7696005)(71200400001)(86362001)(478600001)(82960400001)(33656002)(122000001)(26005)(6506007)(2906002)(41300700001)(8676002)(5660300002)(38070700005)(4744005)(52536014)(316002)(66476007)(6916009)(66556008)(66946007)(66446008)(64756008)(38100700002)(8936002)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTcvcEJDZk9JZ28vek1Kck5ySjlza1MwcmJBTDlTV1BsWkk0L3daa3QwVTVw?=
 =?utf-8?B?aHd6a00rMFJFSzZYclVOZFVKUVZyTW9YU05kMGc4UEJjZG5aRVlmdHROb1Vz?=
 =?utf-8?B?ZW5VajVHVjNXN09qeFpGenpGcEd2RWZTVlBKWFNJeXZKNUUvRWhrL1hPN2Uz?=
 =?utf-8?B?U2VFb0hGUTNObGZ2RlhFNWk5RVlUbXdkWjRFU2czNGkycUJvSVVka3FjYXM5?=
 =?utf-8?B?cGVYMUFkK1BIZmh2dUs3amhQY25oNmxVdTVscGsxYzRsczJtVDdZa1ZMZGtm?=
 =?utf-8?B?MG43Tll5VytOb0I1eGtEeG54Mnl0a2MyT0gySHlSb216V2lhb3B4RUJEOWZG?=
 =?utf-8?B?bG5hYWhxU3FlN21weWxwUW1DSVdnQjRaOXlqUDJsRjNQVHo5WHZ1RFBqSlRv?=
 =?utf-8?B?L3hXMTQ3UGhBakRqc2kreFJTUnUydGg1QXN2VEYreURvY1kzUDlGWG9ZM3Z6?=
 =?utf-8?B?cDQ0UC9NZmlYa1V4VGtGRXhYWGVtK2hicWdNMDhiN2kzemQ1UUtuM3R1REZO?=
 =?utf-8?B?Tm1vT0tXNUxyTDBZMkd6U3RQbkFhU3FBZzFWOUZnSlZzdTkyWnlVcnBWTElS?=
 =?utf-8?B?c3JFSmNFYXhWTUZEYm12dXBSN2l6WE5HZHNYc1RaSXlDeTBDNXljc05YUG1r?=
 =?utf-8?B?cVJBS0UxT3pDRmQvZ2dGUE1XbjBrNjdYa2w5VXc1ZndacEZSZmlyZU1EK21U?=
 =?utf-8?B?dG9oSGZDNmR5YlpLSlgyS3lvemVjQUVnMHNHNVJqYXBNQmlhdTFmd2EyYm1R?=
 =?utf-8?B?SjBFcUh0NzVXeGVXdS9QelVWeEpBM3JvdmlZZHVhUGorUGhvcU9aNFQ3dW92?=
 =?utf-8?B?TndrOW1SU2dESDdRU3F0MmxjNStjOTMrUGVTakF1dUcrRkExV3BBWlk1ZzNZ?=
 =?utf-8?B?dDBEMWxZVlI0RnBLb1R2R0hFR045SFBZVmxOZ09Ha2tNaUZ2VGd5VWF5Mm5F?=
 =?utf-8?B?Mm55UUQ2cFdETmZOUFBna09qWG1LNnVabmE3WG1QQzVpdEVzVmRtTnVZY2pM?=
 =?utf-8?B?bXNPYzltRE9NZEh3ZzJXRlpBY0RvTVdWaVovNkxwT3Nac1VTamVPVFBTQ0ky?=
 =?utf-8?B?bDJPQkMwWGNOaFZLVVI0ejJYY3lhaGdObDY2cUJlVCtxb2E5ZGlxaDdKZjJV?=
 =?utf-8?B?RHZGZm9WaGMrdmFBZDdHS3pBbkR3bXdjejgxSmM2c3hISWJPZDVFRDRKM2kw?=
 =?utf-8?B?dlZOM0VMdStLL0EyZWNkUjNFa0tsWjliR254KzZhM1kwNEZYSnhQVjYrdDh5?=
 =?utf-8?B?SmdqeHFPVTkyQ1VqM1FKZTJlOXQ1YStQNVhGRnJYVy9hNy8zNUFNQWl4Y2hj?=
 =?utf-8?B?SE5UL25vVE1qQ0JsaUlkOTJ3WlBDUVVpbGdqVHNvOGhYOVdaN2IydTNuTWMy?=
 =?utf-8?B?UjRzTHpkcGJZYXZnTXJPTllBbERCalBoNzdlQlBWWE9MNlFGOGtDNzhrTERJ?=
 =?utf-8?B?OWlVNXM1VkF5MlhHeXFnM21FSXNxKzFzQy9lWk96VGZqWTdTMTc4U3N4clFD?=
 =?utf-8?B?OWo5cms2SHpjdXduNGlxNXpWbzhGa2xib05rWHFLRzVlckN0bXJ4SVBMTlp5?=
 =?utf-8?B?SDNRV3dDb2syMlo2TjVCdjNVUFZ5ekMzUkNZNFE3azhvdTlPZS9BYkNMUUhh?=
 =?utf-8?B?K0JjenVuUC9oY3c5NWVUOWdjdWg3YSszWGFtTWVkZ0thVHVLL1lBd24vNjdS?=
 =?utf-8?B?UEo5OVMydTJSV1lrVUdoajhVWmVuSU0wZm45T3dwN3MycURaL1UwMUNtYnIr?=
 =?utf-8?B?cnJrYkkyYlFwSnFZSU81TjFFakRBSDZNaUxDMFA5VW9oMWJaa0NibmkwT2Jr?=
 =?utf-8?B?Qm1HaWhYSkhSMnAwM3k4M1JxV1NqOXQvQ2xSUmN3NGszaGVEd01XeHF3ZFBC?=
 =?utf-8?B?eWR1WEEzODZrYTk0dmpUdkJMTEJoeXlhTVM3T0J4bWVsc04wVmY0M0V3NGlp?=
 =?utf-8?B?RDAvYVY5K2JpQWppWFplVklqclNwTEc5cHRiYTRwdGQ3WmN0dlBITlpUZFZT?=
 =?utf-8?B?bjBsRjJNV2M3THo2QndvNEJnQ09oTzNMWDBNaEhGaDVDTmM4N3FpM2l3cDdm?=
 =?utf-8?B?QUYwdW1aNHNnUDBZMytXQ2h3QmN1UGJ5eWJuM2tlWmlveGNuN09GL25Wb2lO?=
 =?utf-8?Q?9ZTGD3h0+3qVOC8iA+UQ/Ut2J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5c1f06-31d8-42e8-a0fb-08db98b86c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:10:06.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNwP3XQul0qbZLYnvK5Ejs/fd+VhorC8W4P7910nYUXoAFh27JRHFi3Ex8EPPC81sDEUiwHQNkLaDnp6dS19Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNoYXJkIFdlaW5iZXJnZXIsIEZsb3JpYW4gQmV6ZGVr
YQ0KCQlDbGFyYSBLb3dhbHNreSwgRGF2aWQgT2JlcmhvbGxlbnplciwgVG9iaWFzIFNjaGFmZm5l
cg0KCQkgSGFvIExpLCBIb25nemhhbiBDaGVuDQoNCkNvbW11bml0eSB1cGRhdGU6DQoJUGF0Y2gg
c2V0IGZvciBZMjAzOCBpc3N1ZSAtLSBtZXJnZWQgDQoJRG9jdW1lbnQgdG8gY2xhcmlmeSByZWxl
YXNlIGxvY2F0aW9uIG9mIGxhdGVzdCBkb3ZldGFpbCBwYXRjaGVzIC0tIHJlcXVlc3RlZA0KCSA2
LjEueS1kb3ZldGFpbC1yZWJhc2UgdXBkYXRlIC0tIG9uZ29pbmcNCglDYW5jZWwgbmV4dCB0d28g
bWVldGluZ3MgKCBBdWcgMjMsIFNlcHQgNikNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
