Received: from mx0b-0019b802.pphosted.com (mx0b-0019b802.pphosted.com [205.220.174.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F263208
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 18:59:57 +0000 (UTC)
Received: from pps.filterd (m0240896.ppops.net [127.0.0.1])
	by mx0b-0019b802.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEIlm0K014238
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 13:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps1; bh=50aQI6SOXSYehkD0I4u1FOpLhAjJKargYyr2o6gtkFQ=;
 b=op6Rs8M1Mv0OFlloWQAg8woQKteVqs6Z0uujIswIcLhLIPv7jN2tgsw+Mcah73pzTwQB
 Go/EH4c6fA24EbvSxiknr3rYqhVIFzDAAe4FlL0VsL/VGbmwrsztLLqgX2yUc/rmz7uY
 HrtPZzM3rTvm9rOHfY+om8R4wIlhjvawbVwxJ0K9UwSCWlFNl5+mjcHciLh2dQYnM20i
 MDpdy1cHn6JGanF7chOdrXC1KBIQwzCN8z1G6+3VILkeJwudtwDQohPSrP7XcB8avvfM
 s50bShuT/htEuQZpIC4qOkYQGTf+ARjApz0B0rEi3RzXgt69zr+EN3UWm/qpuGOD6+SC hg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
	by mx0b-0019b802.pphosted.com (PPS) with ESMTPS id 3mf6qa0d32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 13:59:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOQYpyfyCZqniniK80d975a4+86+KAAMa3NTz6XuMd31JOLmMEqm9bgoDLzX32IoK19vErufWwX2efC2SYvv8eTJj7XnvXJkLL8erpv7Jx2QvcTc6P/oBhMb94rkTU6lEDJf+wQy1siEJKR+yI6gD1GZA7+a5MniRsjIE6/sI9Rr+RlRyZttpDMcLxW+rVTt3A6VcOW8csu0jZPezMcgN7G7X16yT3Li96W8ZovlOe0P/7LYAUpF/9CmWI/yuYWnZppxTBZG1nDo6wh7TfOEJySgZESaQC42RXVMl5LywdGFzdGlbzVlcmJXdvy8mARiNPGB1XOwGD62vpigVZh8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50aQI6SOXSYehkD0I4u1FOpLhAjJKargYyr2o6gtkFQ=;
 b=Fe4/gjl0ITdEn9JbN10dXTcm7U141rlmfsv1j11oHKKUvw1usKxG0KxspTXBIW78oCFD0bA95nISKhYZn1LBI+yxYnlXzYZVoqrj7XYDKoQGB9/JBrUabCNwAfhhuqDSUkGji1vGpCAugBXmFQVDoBO4aw8mzsjEDkuP9FKHBlNibiEg8TkixGZsG6F9BEcnl+Zxnzfnpt0nMSc3EgxmCpK5iXprFcqV0EbDsPorYJLNo8Kw1AjD+661bngEx0LFKolvk++yHyCDsVB/JcDWo92FaIMyUsCgiCaG7Nh58jUCokutr20udbM/LZd6EPHT5ArSb6D3UoWkN30CS92skQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=3dsystems.onmicrosoft.com; s=selector2-3dsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50aQI6SOXSYehkD0I4u1FOpLhAjJKargYyr2o6gtkFQ=;
 b=m9xqAKTdftBHWR2UOVV0T1dMhCr3qL/FuGPEPvXyeOeE/32b+1zWrZyGkgI+i48EF2UrIJShdNqvqkhYV86b0kedKmHSFO8Xoqg3TVmwoklvSM0PLxuy48hyMH5/aUCAGWt5RjOM1JSTsgexTD8Wi1ZajpqjvikQW0Ge/fLUABs=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 18:59:48 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 18:59:48 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Patching Dovetail with xenomai-3
Thread-Topic: Patching Dovetail with xenomai-3
Thread-Index: AdkP7SY9DaB3hxUOTbuGgf6/6oEF7A==
Date: Wed, 14 Dec 2022 18:59:47 +0000
Message-ID: 
 <MW3PR12MB4460A675E6117835996906F0C2E09@MW3PR12MB4460.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4460:EE_|BY5PR12MB4068:EE_
x-ms-office365-filtering-correlation-id: e3911572-cb2b-46c9-85d0-08dade055f35
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 G2Y9OFahl52kNUDNLAbPQWuwGipq1ugjE/ARBCcGP9Ol7AgVU4Bp5NyUAr3SBHq9PRLNdwFF/Bdy6GYl/uaFOZZL8LdPZlDq40A5Gw+e6QUpVRybSFN4bIXkNcbz1Ybve28PMw9sDHcrkFouCoThbNR49ejsXCBHIWOxymXYmREjvMsSoPs7R3sabMmzE93uxcP7h0PusMVzPI80hcMfnU54Nr1IorKbbYuN4MefCZtKzzgkeislMIxa1VCKIhRK7wht+Y1/FmX8lsX8G+AaGJXmiqc/HPJNn4M12GlPCRAzlQLGHE/prd96zWyXXYUf66F2oHXAQ/yQxjPdz5zJNXpgH8RXgHdPTTx2Pu7elNflnNKEpKmSpvi7M3VZaDjdBd/unRuOSNnJWBJg9Jr7paYgr3JU3zlgW6455rIQwdf8LhFa4s6baK4aif2WiTEbqDxdA3STMMSouwCvXTTRIdozrHmQW20he5wP7VDu0Ab6+yQlw0LIzmJQeyyZLbO8eJjhXG+XkJyPjthpYh/UTOwruUBX9+DSgPm3OGBsX9N9sy288l4qMZMen2auY3ofnSVSmsu7rheSq+bdBxWlSkpaVh04+2xjR9aWpyDZl8AwhaOX7fE3qqze15lLCj5ynciT8bu8PUnC+76Nr73eLTxbPq0aqqRVqWOHfYt+Aeajeiu1vo4U5TsmtvpzmtGxa0rQuzAz6FZF4yyD4hOWjw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39850400004)(396003)(376002)(451199015)(316002)(33656002)(122000001)(38100700002)(55016003)(26005)(38070700005)(9686003)(86362001)(478600001)(8936002)(6916009)(6506007)(7696005)(71200400001)(4744005)(66446008)(52536014)(5660300002)(2906002)(76116006)(64756008)(41300700001)(186003)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YbAf3900jzcLWV2m5c1bzU8g+DQ08pLxGQTUifE95T8hDyQ7DvFBtB9ihf4U?=
 =?us-ascii?Q?V/Ydd8BQTLOYwQWFWiwcRXrMjxNjiLX7TzJ5cUhha7nmDjUQYIrVz+i31UNT?=
 =?us-ascii?Q?l5RRz+GjaVbMKwVFEtUXlxRVs80bJ3Ph3EB0A1K+sotrBXdUaSr/C+5pToMd?=
 =?us-ascii?Q?6xTfc3g/If1cWMjx8w/M6SG1aB9bK8KEPo8HBDJS2XEmXH0n9DTKwoDdz1T5?=
 =?us-ascii?Q?+cHIuYXhPd1ORlsL2eHLMT0CCDvukAV6f+Fw00sjnBjlAA+UYANIHEDrwc2L?=
 =?us-ascii?Q?XknQhD1ufoiN01lwIosFrOroafWQjzkZvLx8R/DrSNRqXq0iPMCcQ54RbpWt?=
 =?us-ascii?Q?NlD9hu8tU7Y2uWrp+z+I2TzwrgCWATzW22GgqglLIuFo9wQF0EJDruJsQmYT?=
 =?us-ascii?Q?+b+fBrsF2MdpIm/6QJllQI5JC/ek1L6tMwqQMj893SbBBGF78nCcSJAY1Ut+?=
 =?us-ascii?Q?feoBte3ZAfTEyi47EqcnVxLfkCF3Dk9BnIPl0pn+53w29nn0CRX5rLfatjbw?=
 =?us-ascii?Q?n8IcLekl2XIKB80uQKlkjUwurzQMl8+7JTa24g/yQQl+XvN5MrWB2uyNmd55?=
 =?us-ascii?Q?YJg3/ThBLrZMpmIdQH8SwiJkqcqsYJAWB16iZT3UyTj900idIr9ZEYYF/jd5?=
 =?us-ascii?Q?UFDpck7tGAcy/WzAxTnjKwAzOfa5iozeJml2m2TxnEt9bZbMJlUNO10wRpym?=
 =?us-ascii?Q?3S+YusrFBEiBEebQLzYkHHFS3WKyY5S934mISE4wR/RN6guh0e7LvKQVkj+Y?=
 =?us-ascii?Q?5L2IrnshbbuXXlpAzq5WVyrViV4fMPWrGCtnChSU4NCVkfeDJXsnhlc/uO1z?=
 =?us-ascii?Q?TV4upefPitvAGmQ/kSDgVkAuzHuZpIKq5L4P65bKeLBuskqrSJHGTD+WJIzh?=
 =?us-ascii?Q?FhiLzdiMoNLyVMLVrXrV1VWzBisCKlKc+79N7E6R00QC3vL2BRFL1fNr1RJC?=
 =?us-ascii?Q?C/Qn31Zm2OVsXVP74hGz065CFnbGzc8aZ7jU+kyCn6e5E2YNiX8SexURuX25?=
 =?us-ascii?Q?wDWH4tS1yfk9i0GeS983ZgVeSDUCis7oIh5qMhsgrslqu+VKYQqRZI1Yk0vF?=
 =?us-ascii?Q?7DR9w5VaY5lCK+zL33lzjEt6teI648V64HTHiJBhtsHjHWRihRoK+E7Qp61B?=
 =?us-ascii?Q?CUnyUL6GFeEH7Sd9aGCXhkjN0tSw0nqK+PeB7yFDEEZB/Ux8MROq8mB1hfmi?=
 =?us-ascii?Q?8qjJfo4/JOpgk4SSGPHe+HfH0VkWYDxeDuBjXcyU9ZR8W1eveL00V3xxJKcJ?=
 =?us-ascii?Q?BGkQFgbfSK3GBNT3si4f1n6shobMhW+fLpCBHmlGDwogb2aU8WnN/TmUctik?=
 =?us-ascii?Q?eKXpf5Gkt+p7QXboaSVJJsiI3hRotVwVgAHLFvVKoA4wVcrglVoioY4yz9m7?=
 =?us-ascii?Q?SyCSNImxqexizrlD4HdxIZ9tC6YdRdFI6uxJCGT2XHj47/6X6Xy9D+aJyDET?=
 =?us-ascii?Q?G/U1K0sQRUEn7AAC/a6NzHNlrpzQmm/+UcSg3wvS57wD2WPpT1nF98kOh9I3?=
 =?us-ascii?Q?+4nvSEf9CAd/sCjZq5MzQvV8N7GUJlePJ6iKEYJG5atD73Q1MhgnhYtV3qRu?=
 =?us-ascii?Q?ZJPrhEi3MKl9en39H3mgGvFvZ7vhrNQRO2+hcOVa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3911572-cb2b-46c9-85d0-08dade055f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 18:59:47.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Fp9NEp958UGTWf3ZDbJPT+MidhMAlytz/JMoYJmt3xk7v6byfQMYfzlj897f+GsTS0+9erNav0NOUPZGE20Fly/v8KlrlZsxSDarstplFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
X-Proofpoint-GUID: eThhzVUWjV0u5R86jUZzSgrkUpj0i8Cc
X-Proofpoint-ORIG-GUID: eThhzVUWjV0u5R86jUZzSgrkUpj0i8Cc

For months I have been using the xenomai-3 v3.2.2 tag when patching
the linux-dovetail kernel source from there. Today I turned on the debug
options in the kernel (specifically looking for relaxes) and got the
VM_DENYWRITE error reported about a year ago. Comparing the
v3.2.2 tag with master I see that the ipipe code has been removed
along with other structural changes.

So my question is: what version of xenomai-3 is best for patching the
5.15.77 Dovetail kernel (for example)? I don't see any tags or branch
versions that are obvious for Cobalt on Dovetail. Should I simply go
with master?

Thanks!
Kendall Auel
3D Systems, Inc.

