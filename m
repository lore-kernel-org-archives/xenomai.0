Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36F33F3
	for <xenomai@lists.linux.dev>; Thu, 22 May 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937334; cv=fail; b=mZ0+DZ73Vej1rqkICGEGLg3ct1CHQffO/dIamDZkGHXYEA8AHJUJCf2RoclkBSe6CtYirzRotgBY4BixGJLKJh+rZniMEjgwZNtNc9fOZorsCHV4oYt4y569ETz5GeG7m7saP0SRr7Vjt7IV7OP+GZWa6sZ+egdNvq9LPb0RVJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937334; c=relaxed/simple;
	bh=eFEz1uyy3KJXgwKV/+MXZvrHwrUkOQnXieOgIqFxJz4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rcU/MuLhcTL8IGRProH8GmlC4HmkKqq1KvxNzDCMn7oVuBvqn/lTzbSNhEE4kuquf9TVy5LhGpZcKnRO38CLupZcU/dWV05DyNMDVgmAmJyIuA7EiKFjyEU4IfgWA5HDDc5M4lk2Oj8YIeQc8PPyK2m3WrWaAJ5C8rSVHMXKrhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cae.com; spf=pass smtp.mailfrom=cae.com; dkim=pass (2048-bit key) header.d=cae.com header.i=@cae.com header.b=nAs2a5PZ; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cae.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cae.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cae.com header.i=@cae.com header.b="nAs2a5PZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytMmiQDVXpdDStZtlx/XMPH+6M0BdubM3pY3vlM32QIuCRu3dfFQVRK58mbokP9co6fdSETkUJF8tS1LagDLt9KTGfp6m7r5iLjitKB33CarlLaSDjoTVF5HUnPpL7LK8p4dfFJ1TfSX6Wju9L4b4mFH7Y0+kVucmp8zX+vy1GmE5bAEa9IDzY/2Dh+V+4NzCr6xZSg8GMRjCm71V183UQViRsbuBZdtwGR//sCl9ura4q7HdBZrE4m/K7a5CC8hbtTATeWSUEJtWnbe18LC7oEeddDsmEVQqRFKLBmQH6XWXf7we8zhHzcepceS/eL2SgMrXrc7O0NQjJEEhRCW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFEz1uyy3KJXgwKV/+MXZvrHwrUkOQnXieOgIqFxJz4=;
 b=JtcHJRYzZmW0PqLbex1oL/+ab6HkCXHhbAQHexfhjphlQ12sYI+/ZDrYpUIGrNZorKfpEurwnPocWdx96BLApaqC0S+H1zmcY2X6WlP5SYrts+aC29AYOWx8ftrDRNAep36f9CsRBNDcX2Nfs+msR4s9ZRuLwSWmu/1ZtcYc2zrXgMiLAOHdOWuoqLOEfnyF14XmA5NFWNvbYbXS1H/cC8Amv+3LF24apmZmqAx4osrdyVgIERs7Qn9zCOQ0HRvyUrMRZ7Z4uMiY88L4PobBfJuOdrulatsYe5qL4f/sezbvLwPAub8qLvMqKXjUAAGMK+amHUBFjE8U48KLUfznZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cae.com; dmarc=pass action=none header.from=cae.com; dkim=pass
 header.d=cae.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cae.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFEz1uyy3KJXgwKV/+MXZvrHwrUkOQnXieOgIqFxJz4=;
 b=nAs2a5PZSMHtIBUMZGY5ICixsoLOqNQCi0xWDqHlCk9bvi4p1ZsIpnrO27+lJo0F4vibdd+bBQQEyfpHgvAzjlTvI/NniIS6oaQcnmE2pWHZFFTd/Gr7hPvBOiBCj0wt6eWx9xXcPBnvZc6qw3TC/6HZwPUSKsJhxCdZmPkwdvSsmRbENQeniOdGqpBVdHV9ZxezAzpzmTuThpHgkf7eCg6YTmxNocwILc+b6fNYtzbgoP7nLhCxT2mWj9ECXcjYtb0i3P5T51PcGtLEKBkITd/AGZ66I/XJWjVvvo6dp1na8pnQqGKRDy/SEtUd6eAr/pKoogJCLQ5IVTiopU2yFw==
Received: from DB9PR09MB6032.eurprd09.prod.outlook.com (2603:10a6:10:3d8::14)
 by AS4PR09MB5790.eurprd09.prod.outlook.com (2603:10a6:20b:581::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 18:08:49 +0000
Received: from DB9PR09MB6032.eurprd09.prod.outlook.com
 ([fe80::bcc:da34:bdeb:1158]) by DB9PR09MB6032.eurprd09.prod.outlook.com
 ([fe80::bcc:da34:bdeb:1158%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:08:49 +0000
From: Yann Le Chevoir <yann.lechevoir@cae.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Xenomai 3 and Linux Dovetail Compatibility Table
Thread-Topic: Xenomai 3 and Linux Dovetail Compatibility Table
Thread-Index: Aduej8lZIXPEjjzTT9Wdqoi1NJTa3QAAFvTAABO6sgALGFicQA==
Date: Thu, 22 May 2025 18:08:49 +0000
Message-ID:
 <DB9PR09MB6032858C6B27EDD03E9A0DC88199A@DB9PR09MB6032.eurprd09.prod.outlook.com>
References:
 <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
In-Reply-To: <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHlsY2hldm9pclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWNkZjJkMzdiLTM3MzctMTFmMC1iZWIxLWEwZTcwYjJlYzZiZVxhbWUtdGVzdFxjZGYyZDM3ZC0zNzM3LTExZjAtYmViMS1hMGU3MGIyZWM2YmVib2R5LnR4dCIgc3o9IjgwMzgiIHQ9IjEzMzkyNDEwOTI3NjYyNDgwNyIgaD0iU0ZYUUJ2VlZJY3hhbEpyemRpOUJqd0FKQ3FZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cae.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6032:EE_|AS4PR09MB5790:EE_
x-ms-office365-filtering-correlation-id: 3b952d0a-6ccb-4a2e-dc92-08dd995bb3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jsdbhqcAu3BB/5JAEmYmoRxpwMtY86Al36lPALaR2s8AdriIGmPOP/tKo5?=
 =?iso-8859-1?Q?N5fxD5rG8iKi1F7u1lqFX/h9PnoVpcoSW6aUV15u9ny0Y9QXTYfavwvFAM?=
 =?iso-8859-1?Q?Y80dO7Mx1U0aFrYGvQ+Fs0nCMKFf6WGKYC4Xixgy8gCjLVd1B4K3H/CEo3?=
 =?iso-8859-1?Q?IIiDSSUDEuco4XLMQOuH1rsdYsiYMtb2Y+1lWfviULayDSNYz1r+tEOzWl?=
 =?iso-8859-1?Q?oqdvSidYa5R8i8yQ3Opwng+DXQCqLIAq+DUioQT27UyQuBa0D2+Wjc+pWH?=
 =?iso-8859-1?Q?zayiFGCNjHis2T6Zduirip+85N6Oj6HoJ94E3XzuZxjGwZkYC+EWQCsyPB?=
 =?iso-8859-1?Q?xbu2RApWWdv4MhepMjXKDLwTYyeAvF201HIfmXIMO+TAhKQA6yXhdo+zaL?=
 =?iso-8859-1?Q?1fR/qdsCEMCo+B9oqUaqKm2nW/CCOofJ/hNdKgEu3dyH7QwqbQZkJqVv3N?=
 =?iso-8859-1?Q?gLqRSJ/Zj+SHlZ1OTnqyubghYoEMqhOogzYZDXnr6Lzw6DZCmKR2pB16bV?=
 =?iso-8859-1?Q?yX2cb+RyrtB5OEX41zd7PaEHKUGmhUbFF4vxC4yN6lRQx41RndhuXQdtIc?=
 =?iso-8859-1?Q?Lt7XNe+Yjl/Tfig0OsS2bOBfyKe1+8k2NctFE1OZKgYNaRz1cqux8lvvsl?=
 =?iso-8859-1?Q?FxXjGDzn4QbBevBNSmgG5TpJxs2eTRnLwizEu9JlZ0ol7fatMqV2dCtu/j?=
 =?iso-8859-1?Q?c2hXQ0xLFNGkcs6fsrxI5X5y0/uTFb8u8GNyYb77um1X5YNtKH1ZUW5GtK?=
 =?iso-8859-1?Q?96U4ZpKlmDpR+vLO1b5MheND8Msfe4vd8lcLf6NUR5coqb6QNaD+18HAWO?=
 =?iso-8859-1?Q?9PB0TBjwO56mMdK6ia8N90vjoQT24talRs7WcaooD9atrYntVHEQZC+JVe?=
 =?iso-8859-1?Q?7RcPC21k3GDqq3MX1RXo4P4ndm6Z+m8/IjWnP60r4YoAdfpp4o1Pn6+9+g?=
 =?iso-8859-1?Q?suy5Hq5Mgc0N9C3xqCY4/5u+RPERh4T7eSRBJTUJuMGrUYGCYnphyFvM0F?=
 =?iso-8859-1?Q?eh7Hny+5yU3GXQKc7cZzfChb6iHN336fU0ABnLxt5xDVQJLQ+uWMkuU8zq?=
 =?iso-8859-1?Q?CDlVIQs6fMDyapq5pWaH3AbRpPBsCsK4lDqt+mqGe2dEA1EQzqzF0Y5VrH?=
 =?iso-8859-1?Q?KPA3IFox5W3DBAAl+RDqlYFoEuR0QpB+Ha1jm0cWbXXqqG4nsAb8xj/jnL?=
 =?iso-8859-1?Q?+bxhuBP0GYVXLPo29stcSMppGE2fVU+wLuIrCYENzK/hcMdgxp+ng5RgSI?=
 =?iso-8859-1?Q?d/H3VzTNkaOxhKGb086aih87tctgSEC/vRvhf2JfJUDT561yuynup5ipCX?=
 =?iso-8859-1?Q?DtsFfJpe6SM8kzIWvN3Bvl1RToTzc4IgS+wyKRm7JwKdcwGkQ/lgb0/96s?=
 =?iso-8859-1?Q?JzCXp83iVfutexc6EN+r6C2j19ENxuFsRRqERgxnrV6I5RPNgfaOAKYrFS?=
 =?iso-8859-1?Q?WxSQrMSSeLY3v1OXctwlYyn9jvzXCoR8MzZ0bP4Jz7nPTMU2B/B9LjQGsH?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR09MB6032.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZYIQY3upIYWK/oBALD6vG5ZRFjBklPKRaOOBGsZJocOCKkeRK4Yn400+7j?=
 =?iso-8859-1?Q?+HRBd+keRuF8B4VG1es+TdeKrKC75YSQAYusEeM/IQc8+1t3Zbx8Q+3+6d?=
 =?iso-8859-1?Q?rpyZjvXcdb3EUfTwdP3KNjqNaj0WVVex5A1eAO9te2oA8lCXEb4n8iqSit?=
 =?iso-8859-1?Q?qa4Sxyxy+kVbbibUWtguZA6PinfT9uVl2GDUGe/Q4AxD0xYO5n05Vidhak?=
 =?iso-8859-1?Q?M9XdgiIP6MqSGJlCucLFPV6s+nt4Ty3YAP1aZyQkCF51XfkQFTOFX+jzcc?=
 =?iso-8859-1?Q?Ued5Lr8Fvd90Eh4uNdkw14zJRrjkAxYcSyzTM4+LS/ZcbknKcqmJGvqORy?=
 =?iso-8859-1?Q?+3Dte6Sra9xOhVQvcrzspIoD79MCGua3s2iACCUWTlmFBmnYTcJLupI02o?=
 =?iso-8859-1?Q?POFIOvnO4tHPyRlDPeq6oeXi3dmBFslQT8UscQrB9+fKBc3zK97Ky569Mz?=
 =?iso-8859-1?Q?Z69u15BBHt7Rh2HdCfYXctt2Ook6XGmv0FBcr2TP7c9IKiaIOOhIs6n0pu?=
 =?iso-8859-1?Q?cLfrps5yIe/hzY7iQorWMx0kzERhmf4N82TEZVSspKpw3laGVKAxrPgfjv?=
 =?iso-8859-1?Q?jlxexufVlgSScelLsqrjvK4gb+E8GwwJnPrQJS5LfaIZsbyEWMOXR/buef?=
 =?iso-8859-1?Q?K2ZQDjyM3ICbE9xN5KIGeI85gyLu3SXR1MwWQmXf6Wa8Wqm9SiZwvvqc0I?=
 =?iso-8859-1?Q?rimuni4iOoWaYMnhnPkHpRN6nIIlEho2pQMY4iHuJp2b66adGciuiuJ/Zn?=
 =?iso-8859-1?Q?JF3srn4+PBG3eHu28T6ScTJeA6Eh9RjvIZ4WZjZ1HzMBpvi4jHuC2UiDtA?=
 =?iso-8859-1?Q?0lD3kF6fHNdFyMrk1RF7LtW2497IwqDp+8E/rR78ywiRE279P4bRSpYSeO?=
 =?iso-8859-1?Q?FFSR0JnqaEe7XAN+wfdMsj0l8IZAgMvS9JDSlmWEGl0kuYHiZFOp/tVULM?=
 =?iso-8859-1?Q?eSscbQp07AdTjFNKHhFSJ+eLUS2YJN7FhokevbSDiJhmkmUmjDqPFf9shb?=
 =?iso-8859-1?Q?qvvhXOUWUaM8IelYirkjQEXLeC8f5P1q5sglKgihpVfe9IxqwGBtyIF3Er?=
 =?iso-8859-1?Q?GUOLs3b/HL6aOvZETMCFcs3VOohsMAiJcZJV+jFakh/l8a4UUyGokL/9gz?=
 =?iso-8859-1?Q?CD6SnT+td9xVySHULscfxx152uKLCNRuHc1fy58amj+VJ7ElCsWdFrkSi6?=
 =?iso-8859-1?Q?gnjMLX47JeYyAOhoXCXCYlmbp3sicoGQTv4SdEmZ+yRxhZatxTuP1hojyt?=
 =?iso-8859-1?Q?folSV48vtznLFxmjo8L5A/y3eIAnDz96qxeWrlUiHoqCVFpqx5aOimySuL?=
 =?iso-8859-1?Q?VdB+Ql1k15RwPqRAdlnEMs6uCvXNoHxBM7yR76x2Bm41umuEp00cdzNk79?=
 =?iso-8859-1?Q?9mzWpGOZjBHihZG1yarE9jyu5uaDwv8Qx1sXmSKJHIvfcE+BSIhCcCgFrN?=
 =?iso-8859-1?Q?7zuRQbKY5TA5SqBPChGoPJwM9+x3EUs9Woo/p1vLfNNAY42uQHmFu8EyQA?=
 =?iso-8859-1?Q?/AwWM/ukdDxt3dzY7HhqKZH+S4FtMb4rSHLixKacXt4zGnu1CQNV+v0Uh9?=
 =?iso-8859-1?Q?FxBm9jAmKgO+wYC+EzLvo3yAHPBJiLrYm49Ee9zOBhhSyYKtp+jEoEV00k?=
 =?iso-8859-1?Q?j0dAJCYn7Md60=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cae.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6032.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b952d0a-6ccb-4a2e-dc92-08dd995bb3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 18:08:49.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 006c1e48-e342-47e9-ab5d-0dd9ff89bd96
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSnFwDfUXvb3E/dTEEYAM/liKSD0NqFWo9o0xbepkmlFpdcZp5jUc8GgaY/tOxXY7bPmJ1DqVHX9C3XJYXpYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB5790

Dear Jan, all,

Thank you for your previous answer, it is always appreciated.

I have started evaluating Xenomai 3.3 with Dovetail 6.6 (not what you recom=
mended, but it was our starting point with the NXP kernel).
The next step was to move to Kernel 6.12, as you suggested.
Following that, I plan to evaluate Xenomai 4.

Xenomai 3.3 with Dovetail 6.6 looks promising on our IMX8MP.
I also wanted to test it on the IMX8QM. It boots and "works," but I realize=
d that Dovetail 6.6 does not fully support the device tree for the IMX8QM (=
no PCIe).
The same issue exists with 6.12. It appears that support was merged in Dove=
tail 6.14.
Unless I am mistaken about the support for IMX8QM in kernels 6.6 and 6.12, =
please correct me.

I need more guidance on the Xenomai philosophy.

In the past, with I-Pipe, I applied the patch to our NXP kernel. I did not =
use the Xenomai fork but rather the NXP fork with the I-Pipe patch applied.
I am wondering: instead of using Dovetail, could I create a patch and apply=
 the Dovetail diff on top of the NXP fork? I haven't tried this yet and I a=
m wondering if the task would be insurmountable.

I am now attempting to get Dovetail 6.14 working to see how it goes. I want=
ed to ask my question at the same time.
Do you have any other suggestions for achieving full support for a recent N=
XP evaluation board when using a kernel from the Xenomai community?

Thanks!

Yann

-----Message d'origine-----
De : Jan Kiszka <jan.kiszka@siemens.com>
Envoy=E9 : 27 mars 2025 02:11
=C0 : Yann Le Chevoir <yann.lechevoir@cae.com>; xenomai@lists.linux.dev
Objet : Re: Xenomai 3 and Linux Dovetail Compatibility Table

[Vous ne recevez pas souvent de courriers de jan.kiszka@siemens.com. D=E9co=
uvrez pourquoi ceci est important =E0 https://aka.ms/LearnAboutSenderIdenti=
fication ]

ATTENTION : Ce courriel provient de l'ext=E9rieur de l'organisation. Ne cli=
quez pas sur les liens ni sur les pi=E8ces jointes =E0 moins que vous recon=
naissiez l'exp=E9diteur et que vous sachiez que le contenu est s=FBr.
CAUTION : This email originated from outside the organization. Do not click=
 links or open attachments unless you recognize the sender and know the con=
tent is safe.

On 26.03.25 21:47, Yann Le Chevoir wrote:
> Hello everyone,
>
> We previously discussed when I installed Xenomai 3.0.9 on an imx6q with L=
inux 4.9 + I-Pipe.
> It's working well!
>
> I am now trying to migrate this work to our imx8 with Linux 6.6.23 + Dove=
tail + Xenomai 3.2.6 (?).
> I also plan to try Xenomai 4 after becoming familiar with the latest Xeno=
mai 3.
>
> At first glance, I find it difficult to determine which versions are supp=
osed to work together.
> Did I miss a compatibility table somewhere?
>

The only table we have are our CI and image configurations, see e.g https:/=
/source.denx.de/Xenomai/xenomai-images.

> After successfully preparing the kernel
> linux-dovetail-v6.6.23-dovetail2 + Xenomai 3.2.6 (using the tarball
> associated with the tag), I encountered a redefinition issue with DEFINE_=
SEMAPHORE in rtcan_dev.c, which does not compile, along with other compilat=
ion issues when fixing this one.

You need 3.3 for kernels > 6.1.

>
> Should I try Xenomai 3.3?
> Any other recommendations for this migration?

Unless your hardware (and some unfortunate vendor kernel) puts constraints =
on you, always start with latest stable version. That is 3.3, and that is 6=
.12. 6.6 is no longer maintained as dovetail series.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center
