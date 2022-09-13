Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C753C3F
	for <xenomai@lists.linux.dev>; Tue, 13 Sep 2022 21:13:47 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIFHAZ004132;
	Tue, 13 Sep 2022 14:13:41 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0183.outbound.protection.office365.us [23.103.199.183])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3jjxyv0jbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Sep 2022 14:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=eres5UiLF+dgtJiQBcBAxUubJqodbMqwvH3KXb3DR60kDPdfbpslbq1NvVWIrAbZZH+9cDuyaiu1wF+MTOygeHsXbXUmzi4nDF87hUTi0WRVLkbSc9ELMqlHCwRInHHJo3AidoWej4R3X5pngrYA6X6LJ/ee89St+qvAu+CdBo+l57tF34B+EzytBC5ZRGOWHBuJSfLTcVfOILLhlUGtM9sZ6p5Y6TXlL34Ra8zNPhsM3rcPqFrG4GbDiHASFUUfmt0arvFJCjYVk0zo6kBGAX04XA+P8C6+13S+JxPZXSFQrFVmJGllxgUfRJC1MEaiS7OFcka6tjnN71CZ/TYPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZzXTo78BUkBaHj44joKYP/DIeg7tZwbNLG7gcIX3MM=;
 b=ZKVi2fL9ieL0b9YkmTqu1TtDafPXorTVWEXNqG62CiUcdQxnM+2PEJTy7DbUdfOlUDccjundjBAF9CFPEuizO8/un5eY7okA26FpacZR8s09uBMDO+KHTSzkEB0tbHRwloNiPUUkiuJhR6kij0mC0dSBnkfrO5j06by4w7/m5JTxrRvo3/EkCYwfG09mUoRfTDNXfkFo4K9jnLr0DidXeMfV7zFnVTdnSHeyEH8beOKHuLYPqwsRBbRP1xKCnP4pvNnhc+5BlXcgpNISt6q9YBSQuESy4dHtFkQMpQ+Qs7moIbnn3U5P00UubDKAMOdQbYlNMEUqmNAjQ5vWsO1Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZzXTo78BUkBaHj44joKYP/DIeg7tZwbNLG7gcIX3MM=;
 b=I4apCC6oe7Ne4DQy6geic8tSRvNSyybqA7d5vd+o1SNJ48f03GvlIOeFkLo807TXZHP8oAcE8mBvMruIW2qMr3k2ezhfmUDbEvST8avSRG7zJtBlDIuSO3+hvxS322CB8H6/nPxKW66ypJaIwF0cnQE6zL17j3IdWLeB7Fva5s1i9rVsTKgD2rkDdxwNhClrr4JjjyLBGbt5h48buk7urnkKNGHqzZmrEYO7zEYCXwunTK2cddW31mL3GRXZ69pIVv52EIcMEO4cni8fRtiWJGB+SbSOiWtLFWV1Y6erGXxrB4SoCWoSiA7VSE6E0CDamaBTnSpoKITApvWNYEbyJw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1554.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:13:38 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::bc81:551d:80cb:1173]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::bc81:551d:80cb:1173%4]) with mapi id 15.20.5588.023; Tue, 13 Sep 2022
 21:13:38 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [External] - Re: SIGDEBUG signal received on oob_ioctl() call in
 EVL thread
Thread-Topic: [External] - Re: SIGDEBUG signal received on oob_ioctl() call in
 EVL thread
Thread-Index: AdjB/1D09BBuHnMXSAWqz0TOosIQ1wAiCkCAAIQ/y1AAF2dngACvQv7A
Date: Tue, 13 Sep 2022 21:13:38 +0000
Message-ID: 
 <PH1P110MB10508528C08270B6B63187B2E2479@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10503EB7CC57455924221392E27E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmg7ll5k.fsf@xenomai.org>
 <PH1P110MB1050FA42497EBD1CE9F2ECDDE2439@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgf7zgte.fsf@xenomai.org>
In-Reply-To: <87zgf7zgte.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4e3c6c0-ccf2-47d5-182f-08da95ccd3e1
x-ms-traffictypediagnostic: PH1P110MB1554:EE_
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rGa7Wyepo2hYZHO2n1YRVp+tONerIUQU0LdhY0EC0A8FNVJoHq1zoC2po3OWbh1FoelyHPSFWGVvXU2e+P2d78KV1t7pwSNB2Zo3EgIl84l6LlcxRA2twM/8lEu3rmWxm5CVmMkXAfRZLIRwylSfMx6omnaO6MCScHquizHNWFW/SFz4Ath39LzHOb0nNQA7rIzUeJaOCdfUEmorp0LhKPmSBMV0/awXqsj3zSjYAHK4+QPFvy4YiXe3FiH1BRDS1PPPL50FqHAC9UTbbLCL8RUoyWEq1O/UBzJbjvxW9TXp5S+tD5rqxpz+tj2tBlG6uFXY1+dZxrb2K9D52cQj0qBZik3ocJx3+KAZG9019v+iP3atBvIZsDw1jT9oiefFqYDteu2b2kfqS5Q+JaV2ZD0DQ/ZZ7bbmPgSklUGuMhRcTuqIB7PvCKS1f3kpF5ItfAqbR8r/ruWZjj1rOUIQmmP/vfpLtPIOUQzrwNa4CB+iGMGyAEZ5WPasdhgISY3/ZXgTlc/jO98a5ytX1+TBtuzBp8ya0zjBovNIsBN7hiAFWBnUQNJLCQvDeajsdsjmBNvjEvFwLQnEfon4dc6v9mVYZBPpNJhvof7I3OMq82rOAhRRjaPVvZ86avPXDkUWKchYiwCn5FvyaP7izFaaq83plxLNd9r0Q6qWq2MQEECUMYX3vgpy6ODy1QBge5IS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(64756008)(6916009)(8936002)(498600001)(83380400001)(71200400001)(52536014)(9686003)(66556008)(38100700002)(2906002)(7696005)(86362001)(186003)(6506007)(4326008)(44832011)(66946007)(122000001)(99936003)(38070700005)(33656002)(5660300002)(66446008)(76116006)(66476007)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 UO5RZWdqwMhQIeyfUEmtvOhCrP7gL//zlxWG1z9BnOXkrKqg8Lj3k2/YSEJdU336SUl2E2pUL/hSR5q/OxiRs7U6+ojaCkLJfmKGY6kAsyoeIpo3EIa/OwTKwcGtXssDMg9n2+uQgFYM6PM54e0KiNgFilAQDf5DeO9ddHG4UQM2Wv3ORye8d9yZFylp8s4nuOB8WxjraE/1hjVNLAZFhJlb9nyLdVNiQwmUDf7xbVt16IXD2dVQeEjmVpvsavWx3VWrT5QKA05X3xUlGKPjHT79OfNYDQKu2mMkehun9jLHvbbf8LxfBHoFelkm8V0UMbBHp3zOCf7W1ypxp0ezsUwnzMSX8I1TsjlHm/G9vt3HzThQhP8+M8A8sGie06nft7nuul+1M5AgrqElPB8YRB0RqRXfQeYuoI8KEhtryRV3BMYZHmobsC2LCyyQ2wYumkdTvb+UB2ZpSChDo0ixaSdBadDsqP0zS6nnS2aq50Q=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_00B3_01D8C783.65A428D0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e3c6c0-ccf2-47d5-182f-08da95ccd3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 21:13:38.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1554
X-Proofpoint-ORIG-GUID: n1v9A52QVmRD_s87X9DoljwW0Vi8O146
X-Proofpoint-GUID: n1v9A52QVmRD_s87X9DoljwW0Vi8O146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130097

------=_NextPart_000_00B3_01D8C783.65A428D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

>The core tells the app about the exact cause in the siginfo 
>data passed to the signal handler, which can be queried by 
>sigdebug_cause().
>PF reports in dmesg also give the $PC register value (in user 
>space) at the time of the fault, can you try matching this 
>address to some portion of user code using gdb? Knowing 
>the general location of this code, and a disassembly output 
>starting 20 lines before, ending 20 lines after this spot may 
>help understanding what is going on.

In this case I am actually running the app in gdb which is successfully
receiving the SIGDEBUG signal on a page fault and breaking in the code where
it happens. I have seen it break on a direct oob_ioctl call and an
evl_read_clock() call as well. Unfortunately, gdb will not step into those
calls any farther, so I am not sure what specifically in there is leading to
an alloc and page fault. 

>Is there any pattern regarding the other syscalls affected by 
>this, or does this seem to affect any syscall randomly, 
>whatever the application?
>Or is it a particular set of calls which is affected and/or a 
>particular application?

So far, I have seen page faults occur on the same oob_ioctl() call into one
of my drivers. It happens at random intervals however. I have also seen an
occasional page fault on the evl_read_clock() call in one of my EVL threads
(calculates an absolute timeout value every interval). I will keep running
and collecting more data points to see if I am seeing page faults with other
EVL syscalls as well.  

>This tuning would not protect the app from unwanted mode 
>switches, the malloc() arena is guarded by a common mutex, 
>which might or might not be contented at the time of the call, 
>leading to a regular futex syscall or not. So one never knows 
>whether malloc()/free() would actually cause a stage switch.

I figured with the prefaulting of the EVL heap, that there wouldn't be any
page faults. We are currently experimenting with breaking up our app into
both a realtime and non-realtime process. The realtime process uses solely
EVL threads and the EVL heap, there are no linux threads running that are
doing any realtime work, and the Linux heap is not being used. We have also
experimented with overriding the global new/delete for the realtime app to
make sure that all dynamic memory allocation is done on the EVL heap rather
than the Linux heap. Are there issues you see with these approaches that
could be causing us issues? Is there a better way to avoid page faults when
using EVL?

>Do you think it would be possible to reproduce this issue for 
>one of these syscalls in a standalone test case?

I will think about this and see if I can manage to re-create a page fault
scenario in a standalone app.


Thanks,

Russell

------=_NextPart_000_00B3_01D8C783.65A428D0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwOTEzMjExMzM2WjAvBgkqhkiG9w0BCQQxIgQgpotrp1zLXgeg5nwarMJ4fXnE
7wBwvK2LXYpCLCpqTkAwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCy
At4kGwwaW9JOFxAPRYrDm6lworWZ+z6qLx/4npsvSz0+Jry3xiPPssY69Z40Yhs2jabHcu7i/oXT
evOtb3BBC7ML3ZF7+kOyHXRyXWoCXUzwrqNpaRT0VmvKm/DM/FKqRLi0r9TfH2mW1onKuIanuIb3
fKM+L4guyMo5Y8S5Mkj6EtGfuuWRSd26w6pTgHhjj/zqhMCiK+RS/y5qPhNoVj0K0ubc9YZs0awN
8lC2iTI/kbs2Sc28YuNnpM+qlW3Nb2Lv6rrKO0CX1nTzn9vqQ9PzKgl16Wv5Tx2p8lcfQfCSQGPj
+jtjkU4JeYuuVe0fJeQWPu90p8z7m42/Ba6rAAAAAAAA

------=_NextPart_000_00B3_01D8C783.65A428D0--
