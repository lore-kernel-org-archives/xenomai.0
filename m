Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FA2114
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867014; cv=fail; b=appzAriO1oYNG8LWhYc9mDVMMI4Jr56KzB5V2GPLV43fmCC6ohvbye7lc1Wgl9qerCFLWkV2tm/YVoxghBlvPqZ2UzW4kTa3HOD2U52zZgBFGtyj87+s0/zK1wqPVXwAHbxnzeYd0CV1tMz/gJBJTnJPOxnWqt3H+3R2okcTsk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867014; c=relaxed/simple;
	bh=NMbF4j+oTEOnh3IiY/iCa38tx910Knwf/TzZNt4WEi4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5hnDajoOgyKzRPjSyVYyvrlexx0i7X8tej3RIZ4hMBab8dnSQyVbSs472L+ultYCwFbLQ6b6FDDqMcLwLjU47B3ZeOAtMlQa1hX5Ld4iNs5CTrg1cgkIed6SUWWsloR2jcgv2z7uTkvMl63FhrkzM+RsrJ/wgbvtooxOzUdf2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ8hRjLd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ8hRjLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716867013; x=1748403013;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NMbF4j+oTEOnh3IiY/iCa38tx910Knwf/TzZNt4WEi4=;
  b=ZZ8hRjLdY9gp/ytDCEeYjhjbRcWHxkegjPeP5fXv+oeNQgCR/lqAS5M6
   kpvEOQ2+mbTtN5qUTFd946CO6YtIknmcDZZE3X8Nv9XVmdMJQbB8uECVm
   8b8/mFUioszEIFJqZqsDhOm5JLLtChPPgKcPJLQfvq/CYr1ANo+n9v+rD
   W13IOKb4N3un3OLzJY+IbyHAHY/6B5dKB/u58HBfQNADyion+S5Igp3Zv
   cRTRdi05VWz1Pcf4txZOrYOP3MVvDwJv+vMO/KP+rhL5Gzml6IxBfuKDJ
   3h5VpsKAO11rjxBt9lAG8xY4wNGr6xOqSybPOnw70+ujROxNBprWeCmrk
   w==;
X-CSE-ConnectionGUID: tslyjK+xR2uX0zxzepXKTA==
X-CSE-MsgGUID: lEwFn7c8TMGvYCOICBkvIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24316673"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24316673"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 20:30:12 -0700
X-CSE-ConnectionGUID: AvseeHaORq+2UMjx/LYe1Q==
X-CSE-MsgGUID: o/SlTMU9TrKb2vZ/7V7A6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39724785"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 20:30:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 20:30:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 20:30:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 20:30:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ/LrZyfkPHFs+g4WGQreQOEaYmxmGDGeu9yxoA69xQDbMmB14bYo6iTmRZ0az+kAkTlMFjdheTGI9CX1FsPV7DgqXkvUGtq8HhCiw809sfYE5JWcDurEAk5+WdiZGI7oTUev01w6JkLaZ4I8YIAWt6pj/ychJnAsK1K23qF4i04HLXjm2VKmdRnN2Jvpp2mD0uAx7ActJmXHjgxUoKqXiAIvRh/uu9qxLCdICpQv6DIthFR7oG3DhO3Gw3rXziYN3xe+R9my20CVoXa2jM4/kEzUX4KEfnDB4wHztU9dsG+CaOHCSVJWSUdD7nw4B4WO+BVqFFCD7UZyYilONanOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMbF4j+oTEOnh3IiY/iCa38tx910Knwf/TzZNt4WEi4=;
 b=ObqbYWtqz6Wbt5lO29ZwgucfEx64Hbuab0dYOKKL8mHckkyiaRaSC8iJ/dwFX7ktSQQp5Vnjx13GETIQvdloDLglo1w4ne6GZXLTkA9Us1ZM6U+IIpGoLaJDA+XN+tQ34PIuBZXF0mqdBfVxNjoi7qq4gHACyqjly6d2cUlzxOnTX29TcMUShCoTaX7vrq+fwxcao2GoEFhxXb/R9jZy5gk38DRVf/whD7cny1Gi7mH3SjxzckvkoAsA/lspDCSIbkPT3m70LMXBaXAOMoBykk/dBKmtW16YquaSvZvSe+NpM1v00AXl4l82tNRIW6M9VQgYI58QRsv1pjje8tVdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 03:30:09 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 03:30:09 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>, xenomai
	<xenomai@lists.linux.dev>
Subject: RE: rt_igc fails to bing an i225-V Ethernet device
Thread-Topic: rt_igc fails to bing an i225-V Ethernet device
Thread-Index: AQHasDdwBZFKY8hLkkygWgh1EF0me7Gr/UHQ
Date: Tue, 28 May 2024 03:30:09 +0000
Message-ID: <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
In-Reply-To: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DS7PR11MB7931:EE_
x-ms-office365-filtering-correlation-id: e9939585-ac38-4f9a-a753-08dc7ec67a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZWdveVNvYzh1ODRMYWRTOTNGaTkvTTBqb3J1OEpMZXhNSWxraUZ1WjcrbGhQ?=
 =?utf-8?B?TzlnWFZmbi95OXA5Y3htVmh0cHZpY3E5Vzd1MXRaZHRVTVlmR0lYTVd3ampk?=
 =?utf-8?B?NTdWLzRvWWRkNVVvVnhYcDVRdVVIMmxwK3Y3aU1jdUVYaDc0MERiS2daTlBZ?=
 =?utf-8?B?VjhLR0hySzhxditqUThOWGlLalFFV1VHVWVWTEJJOW1xcnRtOWlnNzhPTXNl?=
 =?utf-8?B?SUR4MlFYdnkrSEtFK1VPeWd2Y2prZjhxYTVXNVBKVTIydzZjS2xWOHYzVVZP?=
 =?utf-8?B?Wmt0NmNPWkFZWkkwTHlXMmI0b3NsM1pXOWYvdjZiRE16OVA0ZWpwVkNzb1Bq?=
 =?utf-8?B?L3k2UWZSS3JCVE5LdTBkcGNKaUY3UHYydjU3dCs2bW5lZGlQUTVsYjY3QTRJ?=
 =?utf-8?B?RWdsUE9DMTd2WjJWRUkvK0ptY3laOGF6MmFMUFlmRHVNRkw0TlE0blZaeXcr?=
 =?utf-8?B?UnA3V1ZSTHgxZVF2ODdTQ3ZnQmVWQjFyamVNS0pMTVkyY3dwTEorZlBmNEdm?=
 =?utf-8?B?RXVGVGwxTFgxdEZKVVVCU2ZEK1YxemRUMGZMSTg2RFd4dTdUSG1nUkVaeVhX?=
 =?utf-8?B?eFlSZGwwNEFDZHNCb2V2SXpBYSt0ZDVwZ0FZMXBSVzQwS3VLVjY0akhULzYx?=
 =?utf-8?B?WEcxZnI4S1h3T3BoYUd0S05yaU9yNkRqbUp2N09uY21GRXRiYWlXZjJ1eVhu?=
 =?utf-8?B?aWc2Mmc5bTlHSjEyZjVJWS93UGtLUy8raFZIcUgxUmlpVXRxOCtjb1BlWVI0?=
 =?utf-8?B?YjhZc0NnQWxFOC9GZzRlakZHL3pKZlZRYm12WVFwSXo3eFJod284bDZNbXBI?=
 =?utf-8?B?M3o2K0o1MW1iUVh2ZXo5c3FsYkV3eWU0WkJsQVJzNGttb25vVUtiLy84NFFo?=
 =?utf-8?B?ckdmdTlMdjNkSlpyNzZtbjJwemNnbnl2Sm1OUFJ4MURFajd5UlJQamg0SjZx?=
 =?utf-8?B?a2lUYjRvcnpQby9uSkp4Syt0MUhSTDc5UmVZZ0JzS3pOTVlTc0haRlJKREwx?=
 =?utf-8?B?SGQrWGNMRFZlc0NvTVA1Zno2bW5RbFZwL1YwaEJPbE5tcWdVNDRtWllucW9l?=
 =?utf-8?B?ZUlpVUFIK21hUTFNMThZR0JnSHFUc0ZTZkhZNVVPSTNOb245enkvbWh2THRt?=
 =?utf-8?B?TGlmYnVuYVJnS0V4VmVMdmFwN0RSc3g5dWY3NXBjZFNhbHh1T2puZ1ppOEJ5?=
 =?utf-8?B?M3lnOUF2VWFlWGFha21WRGNZWFg0TVVtRGd5QlROWmZqYTRGZFMvM1B0MVBV?=
 =?utf-8?B?VkkwNW93OEtrdHVWSUVJU0FJc0tRRGVKSUZvYm91cEw0aXg5Z25GSk80ck5P?=
 =?utf-8?B?V056SGxVaHJWYjB0TDFnSDJ6SlQ0VnJma0FEdDBBMGprajZPVld1TUpqOUlL?=
 =?utf-8?B?eEE4eENMZy8yTzlzeUZpdUxwRG5TUjFyTVVWNnN3VWhrUHVrNmVFb1JjNzV3?=
 =?utf-8?B?dk55RVB3bkcwcnJLeklCQnU0WHVPUmpzT0xmbnRkU2NpaEQvN3hxa1VkKzFh?=
 =?utf-8?B?NVNmcWNyalI1T1lUNmRodGV1bDErVm9Ic1hmWlZvTDQxd2o5MUhaTzZ6VXQr?=
 =?utf-8?B?VXFyTm4vanZOWWMwMUFDNS9GUUlGdys3YUNzR3FhWC8yRDBVNkhnQnVOSW5P?=
 =?utf-8?B?ODZqRGR4REFaZjhWQzUrZjYrTGZpVlFLNnF6Yk5CcUVnNU9FZlUyZHZnTFYv?=
 =?utf-8?B?QXFMS015UFFqL1pVWGovdzBXaURrWStaZkZac0I1UXFWdUdiQ1lLaDZZd3Yw?=
 =?utf-8?B?Sk0vUFlmblp5OWhJSDJuaCswNEo3Sk1ta3dNTWJ4VVJKbXR2TFRyeHhERXdy?=
 =?utf-8?B?dzlnT05tTWdISXZZQk40dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHlIczBqK1BiRllEbFlRQWI5R2lWVk40akQva2J5SEVRTkQ5UW42WXNtdmR4?=
 =?utf-8?B?OHcwbFdCbGYwNVA5ZEJSYUpwMU10eUtONzEyTS8zVWwxaDhPU1NVc3RDSDB3?=
 =?utf-8?B?ZkI1cXdkbW5VSFhJbDZPTmpkZDRocE5wNVg2QXZoenF2cW5PZjlWTjc2dGNl?=
 =?utf-8?B?b1V2MWR5aG1xWVltQVlLTGN0WTUvM21PVUhCUDVrUDV5VXl1MlF0bGtGS1ZZ?=
 =?utf-8?B?dElIV0hGa0FkZ29iWXFNTzErU28zbVZadkpyZUF3V2JmbXhDQjVXbkVLdXNB?=
 =?utf-8?B?cGp3Q21UU0Y3L2JuRUUvTS9FbmxtQ0U3aDROaXNPbmt3YllZNE52UzRTNjVv?=
 =?utf-8?B?SDVacnFNanF5T3dZSE1yS1RqVzR2MDNUUEFaUys2L3d2OStPWm5nRWM5Y1Rk?=
 =?utf-8?B?NXNBSkdicEJrYWIzRUk2Yml2OXB2Y2x2MGNOQmdoN0laM0hKOGxmUDhZU240?=
 =?utf-8?B?eHFZQ2x0d3hZQmRaNU91UjlPcnRIUHFxVklRbUU0MU14dThoQzkyQ1k4ZWxF?=
 =?utf-8?B?c2IwWVc4bGd6aElvbUFscU9JSkh0Uy93TUxOZVBsSjQ3OWUrUytqL3dERWpK?=
 =?utf-8?B?RUc4eWtKUTRDeDg5SllXS2pnZ1NKUnByakRwRlU1cnRtSjZ0NUVORjl4b0Jy?=
 =?utf-8?B?dWNWN0JFMjY0b1Z1RU9OUVFjVFlCZHJVbzFEa3IrOENOaE40T0J4ZTBNRmsy?=
 =?utf-8?B?RWh6VUxmWEpIWE9RajVWb1crVTcyaXl3UjYwRHZZcG5EbnVCNnVrYnZGNm02?=
 =?utf-8?B?YWxzZHdaV2Y4RWRZdTdhZmtkMHdrVmN5dDdobnpoUGFKaU8yd2o2Y3Uvbm1I?=
 =?utf-8?B?TTlsR0JQaGZGeFJKNjc2OGgwcWpITks1Z1JSdmdPQktXdlhEZXZlbDl0Y3g1?=
 =?utf-8?B?Q0lzb3JSdk80OFRObE03ZnNvbFRTcWxNcmFBakhTRVlZbU1ISmxqRW5idStB?=
 =?utf-8?B?cWtnR1V5dW4xUE1KTklENVpHa3ZiRG5vdmpMZFcvOWttOVhGUURzVldQajRE?=
 =?utf-8?B?dDd1RmdUd2xxSkQwaVJkd0gzdmk3c3RqTHdBMGhjVnVBVVoraWlkSDFRUC9n?=
 =?utf-8?B?TW5saE1CZjdnMUV1aCtPNnM1SktXYUlVRFVoOW1TUUpWRGVqMXlNVTlEKzhh?=
 =?utf-8?B?b25kbHBnZnZGWktCQTNJczJkekt2YnpBOWJqNEZWNHZLQUIzMUdRT3o0eDJ2?=
 =?utf-8?B?bS9CT3M5bkhDVkl6dzhkWmlYZ3g5cmR3YjRzSzBEc0VmWkRmNXdZZmp5aFlV?=
 =?utf-8?B?UW9Ia0RpTXU1YlZoeVR1c0x4WGNNakFrbzR1eDV3U3AxbW9MMll2VW9lK0NR?=
 =?utf-8?B?SXEvN0lIbVpiWVk5b2NvNlU2TmlxS29pdk1jSTdQeGc2bVp3TjdQcWJGMkxu?=
 =?utf-8?B?OVB2OE96VkN2Z2NsNXZSSE9pQzlrczV1VUNtdkhMVmJCMzUxZFdjNjE3bHNZ?=
 =?utf-8?B?V3BmcTNMb24xWGdYcExjN3JxMEV1c1dydVNQQ1BlVW8yZ0txK21BZlB0RVFi?=
 =?utf-8?B?UkFSZm4zaHZEbmR5MG92WWM5UHZmcmw4aEZieVU0Wm1oVDZhS2F5Q3hHTXp3?=
 =?utf-8?B?RGdzNlhzVnZuQWNlUVZ6ZTJKZ3Q4Z0tYbUxlZE1kQitLeUIxVldQL3ZLVEdq?=
 =?utf-8?B?NnV4cCtkR2UyTDhRV2dHanUzaFZWeC9jeEdaems5K2hqL21FdE1wdEFRN05y?=
 =?utf-8?B?YkpCTlhBWHVJRXBiblNlMXZLWTZTcVRKenhPaHI2K1ZwRzJEOGtxL0NxZWVJ?=
 =?utf-8?B?WkNrWEFaRHZrMWxOZ1BJOWdROGViV0xhbG1CKzNOMWJRZ1UrREw2OC90YzR6?=
 =?utf-8?B?WEN4V3doUDhGRDA5Q3kxQXVmS2dpZmlQMm5sN3hzS1BJUXFxN3VNSGFuM0d0?=
 =?utf-8?B?U0t6TEdSOTE3eXoxajRBY1FiV2FRNTYremRBZmRTYi85d2xMZyt4Mk8wT0hM?=
 =?utf-8?B?RXVXeHFwRUs1QStUbUNrMHF3cW9rSWlUcjJCV1dDZlVIN2dWSVdsdmlWTHJn?=
 =?utf-8?B?d2ZXMllZRDNMWTNvaG80Y2tuQVI2SnNyOFJZSkFQWlhsSnVRc09SUWxHL0NM?=
 =?utf-8?B?aTJOb3hWbHgxQlZCREJ6RjA3WnRrdi9jMHV5UnFvZGJnTk5Va3RMbjBYVnZE?=
 =?utf-8?Q?sA/S1AjNZsY+NuYLMJaady5Wp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9939585-ac38-4f9a-a753-08dc7ec67a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 03:30:09.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kY+d/YBk2MlEEKKdNKtoeR+8TI5upooDoBYjfffY68+pagUL4xr1lmLiA0fxJKt8i0MUYzkec9yHczxFgwavhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRhbcOhcyBQYcOhbCA8cGFh
bC50YW1AZ21haWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTWF5IDI3LCAyMDI0IDk6MDkgUE0NCj5U
bzogeGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+DQo+U3ViamVjdDogcnRfaWdjIGZh
aWxzIHRvIGJpbmcgYW4gaTIyNS1WIEV0aGVybmV0IGRldmljZQ0KPg0KPkRlYXIgQWxsLA0KPg0K
PkkgYW0gZXhwZXJpbWVudGluZyBhbiBJbnRlbCBOVUMgMTIgUHJvIHNtYWxsIFBDIChOVUMxMldT
SGkzKS4gSXQgaGFzDQo+YW4gSW50ZWwgaTIyNS1WIEV0aGVybmV0IGNvbnRyb2xsZXIsIHRoYXQg
d29ya3MgZmluZSB1bmRlciBMaW51eCwgYnV0DQo+SSBjYW5ub3QgbWFrZSBpdCB3b3JrIHZpYSBY
ZW5vbWFpIChDb2JhbHQgY29yZSkuDQo+DQo+SSBkb3dubG9hZGVkIHRoZSBsYXRlc3QgWGVub21h
aS1tYXN0ZXIgdHJlZSwgYW5kIHRoZQ0KPnY2LjgtZG92ZXRhaWwtcmViYXNlIGtlcm5lbCB0cmVl
LiBUaGUgYnVpbGRpbmcgcHJvY2VkdXJlIHdlbnQgd2VsbC4NCj5YZW5vbWFpIGFsc28gd29ya2lu
ZyBhcyBleHBlY3RlZC4NCj4NCj5UaGlzIGlzIHRoZSBpMjI1LVYgZGV2aWNlIGluIHRoZSBzeXN0
ZW0gKHRoZSByZXN1bHQgb2YgbHNwY2kgLXYgY29tbWFuZCk6DQo+DQo+NzI6MDAuMCBFdGhlcm5l
dCBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBFdGhlcm5ldCBDb250cm9sbGVyDQo+STIy
NS1WIChyZXYgMDMpDQo+U3Vic3lzdGVtOiBJbnRlbCBDb3Jwb3JhdGlvbiBFdGhlcm5ldCBDb250
cm9sbGVyIEkyMjUtVg0KPkZsYWdzOiBmYXN0IGRldnNlbCwgSVJRIDE2LCBJT01NVSBncm91cCAx
Ng0KPk1lbW9yeSBhdCA4NDIwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0x
TV0NCj5NZW1vcnkgYXQgODQzMDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MTZLXQ0KPkNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KPkNh
cGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlKyA2NGJpdCsN
Cj5DYXBhYmlsaXRpZXM6IFs3MF0gTVNJLVg6IEVuYWJsZS0gQ291bnQ9NSBNYXNrZWQtDQo+Q2Fw
YWJpbGl0aWVzOiBbYTBdIEV4cHJlc3MgRW5kcG9pbnQsIE1TSSAwMA0KPkNhcGFiaWxpdGllczog
WzEwMF0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nDQo+Q2FwYWJpbGl0aWVzOiBbMTQwXSBEZXZp
Y2UgU2VyaWFsIE51bWJlciA0OC0yMS0wYi1mZi1mZi01Zi1jZi1kMg0KPkNhcGFiaWxpdGllczog
WzFjMF0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nDQo+Q2FwYWJpbGl0aWVzOiBbMWYwXSBQ
cmVjaXNpb24gVGltZSBNZWFzdXJlbWVudA0KPkNhcGFiaWxpdGllczogWzFlMF0gTDEgUE0gU3Vi
c3RhdGVzDQo+S2VybmVsIG1vZHVsZXM6IGlnYywgcnRfaWdjDQo+DQo+VGhpcyBpcyBteSBpbml0
IHNjcmlwdDoNCj4NCj4jIS9iaW4vYmFzaA0KPmlmY29uZmlnIGVucDExNHMwIGRvd24NCj4jcmVt
b3ZlIHRoZSBkZXZpY2UgZmlyc3QNCj5lY2hvICIwMDAwOjcyOjAwLjAiID4gL3N5cy9idXMvcGNp
L2RyaXZlcnMvaWdjL3VuYmluZA0KPnJtbW9kIGlnYw0KPm1vZHByb2JlIHJ0bmV0DQo+bW9kcHJv
YmUgcnRwYWNrZXQNCj5tb2Rwcm9iZSBydF9pZ2MNCj5lY2hvICIwMDAwOjcyOjAwLjAiID4gL3N5
cy9idXMvcGNpL2RyaXZlcnMvcnRfaWdjL2JpbmQNCj5zbGVlcCAxDQo+L3Vzci94ZW5vbWFpL3Ni
aW4vcnRpZmNvbmZpZyBydGV0aDAgdXANCj4vdXNyL3hlbm9tYWkvc2Jpbi9ydGlmY29uZmlnIC1h
DQo+DQo+VGhpcyBpcyB3aGF0IEkgc2VlIG9uIHRoZSBjb25zb2xlIChsaW5lIDkgaXMgdGhlIGVj
aG8gY29tbWFuZCBmb3IgcnRfaWdjKSA6DQo+DQo+Li9zdGFydF9ydG5ldF9pbnRlbDogbGluZSA5
OiBlY2hvOiB3cml0ZSBlcnJvcjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPmlvY3RsOiBO
byBzdWNoIGRldmljZQ0KPg0KPg0KPlRoZXNlIHR3byBsaW5lcyBhcHBlYXIgaW4gZG1lc2c6DQo+
DQo+WyAgIDI1LjMyNTg3Ml0gaWdjIDAwMDA6NzI6MDAuMCBlbnAxMTRzMDogUEhDIHJlbW92ZWQN
Cj5bICAgMjUuMzg5NzkwXSBydF9pZ2M6IHByb2JlIG9mIDAwMDA6NzI6MDAuMCBmYWlsZWQgd2l0
aCBlcnJvciAtMg0KDQpBY2NvcmRpbmcgdG8gdGhlIGVycm9yIG51bWJlciwgaWYgaXQgZXF1YWwg
dG8gSUdDX0VSUl9QSFksICB0aGVyZSBzaG91bGQgYmUgc29tZXRoaW5nDQp3cm9uZyB3aXRoIHBo
eSBpbml0Lg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCj4NCj4NCj5JdCBpcyB2ZXJ5IGlu
dGVyZXN0aW5nLCBiZWNhdXNlIHJ0X2lnYyBkcml2ZXIgaGFuZGxlcyBpMjI1LXYgZGV2aWNlcw0K
PmluIG90aGVyIChub3QgSW50ZWwgTlVDKSBjb21wdXRlcnMgd2l0aG91dCBhbnkgaXNzdWVzLiBU
aGUgb25seQ0KPmRpZmZlcmVuY2UgSSBzZWUgaXMgdGhlIElOVCBudW1iZXIgdGhleSBvY2N1cHkg
YW5kIHRoZSBQQ0kgc2xvdCBudW1iZXINCj4oMHg3MikgaXMgdmVyeSBoaWdoIGluIHRoaXMgY2Fz
ZS4gKEluIG90aGVyIGNvbXB1dGVycyAiSU9NTVUgZ3JvdXAiDQo+ZG9lcyBub3QgYXBwZWFyIGVp
dGhlciBpbiB0aGUgbHNwY2kgZGlzcGxheS4pDQo+DQo+UGxlYXNlIGhlbHAgbWUuIFdoYXQgYW0g
SSBkb2luZyB3cm9uZz8NCj4NCj5UaGFuayB5b3UsDQo+VGFtYXMNCg0K
