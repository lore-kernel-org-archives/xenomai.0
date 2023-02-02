Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B838F7D
	for <xenomai@lists.linux.dev>; Thu,  2 Feb 2023 22:24:13 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312Hm4VL004295;
	Thu, 2 Feb 2023 09:58:43 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0184.outbound.protection.office365.us [23.103.199.184])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3nfnybdjmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Feb 2023 09:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=FqJkR1Ksh3bV8++yYU2SJH92p3WUKI/J+T/Kq9mlBY4wkB7rg+Pkle12KIJuWRYu9MwOOBfaBY6LfbwbtfDVMurGFbzmo9YzeZDNNf5C5bitK6KdUICG5w7vMqela2Ss/0BJ+RgnDMyM5cx08DMy9bDl231V2lxAD6W6avXqj+kduOEacenY2vlXJHRtNu05UsoRjiHjcRbrQ+0t9BGmYo4t9pLgSye/PgOg+TyFKiqzI3GCtwbDVtwICKR4UOK7VSIK4+EGr7IV8/lOR9xUqgKKTCYCMj3mE8e3U9g1f7XTgGy3kEqFNO4yme72UlgzsibcAi0P1ZVYu3i0c0gcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk1hdsc+xiZcyKm0hIca8iV8yyJsGY0R6MgsLTGuyWQ=;
 b=GFkcTDb2/Oaldn4rHJcO2TcfP+7ZGgCf//+dgi8rmu9cczcDfIvAxZO6/8edJkhbsd98zWU3CoTBXqcuF+dewgWGqFTrtVkQKgjtG1oID8U2bP4mfy8Q0ddAUTIjL82hcaDEzgXGz7bj2DwBIXLZ+aMWD5CH+DvX4tZSZpmzoLCCBMfBjiOiO7zIcABrHAL4k5+iN+PuDLmDhoolwsSXtNppjdlWgPy/Sw9VgXO41ibX97s7joMyOSn/yQ+ccx3SUnhITCsXrCK2EIFw9RH/tBdwWxzza7zL6iTsVafkjLJLx1Fk435MbJX/OsZb84YaHlysLVpBTWmJ6wYm9Lnrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk1hdsc+xiZcyKm0hIca8iV8yyJsGY0R6MgsLTGuyWQ=;
 b=Kjx9KkI+FUUP64PuqU1cyykaNJOFCOsvphau/q6FORp+GIUpDfX7ZWVtwaniyTK8IqD55HXDewMaHveJSl8jfIBHWdtFAI8Ry4SbBjrP2lW6mm8PI+XpzqOL1svHXAzwoY3uBZP2E+EWJ6fY8YVhxqNiorGlGPnhDcqy7ZE33cn14gYrFrCQX/tEwf5q5SeCqQ4qX8DakOHnISiqOMTeOS4ci4V1r0OHxGn/mA+e/jC8U+ogEwfL7i2eLxbh5xHwpkaKga6hXR5txGkSDs1VTSU/7wnZdBbRJIq7l5TAPFC/wSJJzXqDneh435gBwGTToylh/aD34GRvFmw7ZB273g==
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::9)
 by BN2P110MB1352.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.39; Thu, 2 Feb
 2023 17:58:41 +0000
Received: from BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::87a:49d1:4c83:fc71]) by BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
 ([fe80::87a:49d1:4c83:fc71%5]) with mapi id 15.20.6043.043; Thu, 2 Feb 2023
 17:58:41 +0000
From: Bryan Butler <Bryan.Butler@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [External] - Re: Conflicting EVL Processing Loops
Thread-Topic: [External] - Re: Conflicting EVL Processing Loops
Thread-Index: Adkgi+LtPmHGHADoTpO4vPcK7ox9NgFSNX3AAAHH/gAAB7P/wAAr+3wABCEwY8A=
Date: Thu, 2 Feb 2023 17:58:41 +0000
Message-ID: 
 <BN2P110MB1288186F36BDACCC717BABAA8FD69@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507C980109C793A20E6910E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87fscfboox.fsf@xenomai.org>
In-Reply-To: <87fscfboox.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1288:EE_|BN2P110MB1352:EE_
x-ms-office365-filtering-correlation-id: aa27b913-faf7-49a7-6038-08db05471e61
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Osjzn/XHbJ/8R2l/w6o9V9ihVL4L64Lkt8rs/Bkpd2H+shW3XFV7P7sHoziZCOo1cLrmiEnFmwhfsFAxRbcswtaNCTJPLDdO5XeEuLdoIy4wWOCWpOtbZ+JvRzuTAm5KqmrUzwHXc5jboyIN1hY7GotXiTtPI1IgOjN+8YC+9b4y5wuzQoOeIXpq/bliZmW+Sp3DEOYlpHbEuT/jx4vFfARAF/cmWvURLX5926Ont5yzMGuvnm0f1b3roBfC+Ns4qntRlfZRC95Yk1qGbgMJGuUYctjVMKbKyJ0+soR2Wohv5Tk4prXydWiELa2x0wBMdxiB0XMXOvyycJY8kyRCX05Iv14lG9+tyS9fICRkF7F+tDsUT9LLY9C6aWrPOTMte9uqRlyxu3logyyc7YTx1hoFtFMs3Ldr+bas3R7jGRua5m/fOv8jok655oxl1SKfMwxjUEAxfWPmyJwd/xA6Dy2/3gaUfpC8v+I8KGQ/5zYrxn5HBmjXUHMax8Hp+K9t0LhQ5wjVFpGS51uxt5uhfJpUcAMsT2jsp5h0NZ24GiySCUD1Emtx/wFIDjiiQUuLU5FyG48iT3AS7MlGYOzUP/8wZD2cz52pOq9rJIBQEU3LQbkQrHKiwlagj62vORIf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39830400003)(366004)(451199018)(2906002)(26005)(83380400001)(9686003)(186003)(38100700002)(6506007)(122000001)(41300700001)(76116006)(86362001)(66946007)(33656002)(52536014)(4326008)(5660300002)(64756008)(38070700005)(55016003)(66476007)(66556008)(8676002)(6636002)(8936002)(71200400001)(7696005)(110136005)(508600001)(66446008)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 PaYy14GBWD/Nc1tNFYEL/m6e8YDKdJs7k1YWxiOGbO1TJYiFu2BE5ltfKt9IBEKu5JJsrWcDVwzBUzxNeONojdj5++EYYvIC71orRZuydZ2vkuqITMr0GnyjRzmVFAFjkbOP9+O1FPvhpY4HO9vpDfm1Mo2kuPcoMYsY4g8tzDaYh5slbrAFhFWzU3KQE8daVhOyVQzCe/mRoi1Stp9iPziA+QE2vQAMc12ZKz+DqpjtfFfSDjvMleFYLH1tXg1l/U1bMCxiYI8fnuHH95PlrvRoni+xNxTcZlZZHSckUsozzn8XBN1Se8BVbY4wKBtRGrt2LXQWWzWI8LTKCUMjIR/+gmlCKw17xEOK3pYkm6kdokkNrO3li1lJ91xgGlC6AEEmQkSCvbH6bHVc61F1/MS867HVpiD0zG53byXx2gU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ePnjsWyWdOUMiWb6Yd5jAEazIC6apheYBfUaaK7zaO2aL4luni/8C0ClQq8V09mwecvMY5r0zIuH1pVC6mfcO3ZtLI0X1oWSamNEhJbusAWzljW0g/7JDX5oIMuldjzWU3tcHmyfBQfp+APzN4xm73yxz5s03c3TRAFqLnNgHzFTW4X+xo+DWgpn24hB/WuzVpQoiqv1V8Q5oQxsVKnF8HyR4y79VzTpHTBoNzuBVyX4SHw4CqhFkB7m/cFDyMFKdYyYFV4zxgYfqIyYycmzYNZpE4KCl4pjM1o3tU/zVcPaolWXyd4DX5WJFU/ip9qU+V/wH+lrDEgaxylSaaFQTZ4oCCKACuSDgoEDlXtCIbiCJN0mMFKeIFpSZiVkwsScYu8AymPM1om3H6Aega0ALeMJjTrF9Uc5KRfc1QusNv886Yx27cbhvJqTigdz63oPFxzqZEAuDAUrBbhC3knmCF7/9MM4wDPY6YkKZOG/1lYnXGn15Pg/dTHL2RlPMXGe3IsYuqYOHKbf84T/mkbGGlZ0TYTYP3f8DFvKyo7f/qcLRb5WbLUBeQ7LWVe8lXVH978Z5YU2MVrK+X1ED3fE4+Gu6Cz/L+I0v+DU7BCBzaDKZBr2j2mQ4CFi4GDctvQXyL7h9OfZQRuVaG7pEuyOmYAbW+4jckmhIcStz7zmZ7M4GugCP72O5HfrWKI0NDj6Ed1Y8ryoEMuvpuucSfjR5X244EgHOqO+o7CG5xn4UhirmitUi59B2PG9LHEYnvfw6BE3zqSF5WRS5lWG27jbUVeDtos43HKfuNJ1qbhKrikfJ0biBgmjg8ORHRzdgE0S
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa27b913-faf7-49a7-6038-08db05471e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 17:58:41.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1352
X-Proofpoint-GUID: Y_0UsD1KWb5DE5duIbAfxX3fULYy39R0
X-Proofpoint-ORIG-GUID: Y_0UsD1KWb5DE5duIbAfxX3fULYy39R0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020160

Philippe,

An update and question for you.

First, as you know, we found that the built-in heap management in Xenomai 4=
/EVL was causing us substantial performance problems, due to the need to pe=
rform locking on all memory allocations. The nolock API is not an option fo=
r us since we perform memory operations in most of our threads. We also tri=
ed the TLSF manager, but saw similar performance issues.

The good news is that we've adapted the mimalloc memory management library,=
 which I believe implements something like the fast bins you mention in you=
r earlier email. The performance of mimalloc looks to be very good, and we =
are able to get our dual processing loop system running within our real-tim=
e constraints. The current implementation is still a bit "hackish", and we'=
re continuing to test it and clean it up. I am hoping to get you the specif=
ics about what we had to do to implement it, since I think it could be a go=
od option for other X4/EVL users. At a high level, it is essentially a "go-=
between" with the Xenomai heap management at the bottom layer, replacing th=
e low-level sbrk() used to get memory in a Linux run-time environment.

One nagging problem is that we're still plagued by occasional page faults. =
We have tried to prefault everything we can think of, but we're obviously m=
issing something. I go through each accessible section in the /proc/self/ma=
ps file, prefaulting each one (this includes all code and data segments). I=
 have also added a hack to the kernel so that when the "switched inband (fa=
ult)" occurs, the faulting address is displayed in dmesg. So far, all of th=
e runtime page faults we see are in the heap section, which I have attempte=
d to prefault completely, even doing it multiple times during startup, sinc=
e the heap section seems to be growing as we start up our real time threads=
.=20

So, I'm looking at one of 2 possibilities:
1. My prefaulting code, which touches one memory location in each page, is =
not actually doing what it is supposed to. I've declared variables in the p=
refaulting function to be "volatile" so that they don't get optimized out. =
But I don't know any way to really verify that the pages are being mapped i=
n and locked.
2. A kernel bug, where the pages are not, in fact, being locked into memory=
. We're calling "mlockall(MCL_CURRENT | MCL_FUTURE)", so, even if the heap =
is growing, I don't understand why any future pages are not being populated=
 and locked into memory at the very beginning. And, the kernel should not b=
e unmapping any of our pages, but perhaps it is?

I know this isn't likely a problem with the EVL code, but we're just about =
out of ideas for how to find and kill this problem. I'm not much of a kerne=
l expert. If you have any ideas for how to isolate this problem, especially=
 if there's a way to verify whether our process pages are really locked or =
not, they would be greatly appreciated.

