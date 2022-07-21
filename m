Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9A4680
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 15:40:38 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LEFH6X023884;
	Thu, 21 Jul 2022 08:40:30 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0175.outbound.protection.office365.us [23.103.199.175])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3hbvgbda91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Jul 2022 08:40:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=CLjFFOJa75CjJjACgZx1vK4tMtkfkHshPq2tj1xZmipI8CWBl7LsypoGbycSQ9SwP0qUApMIUinc1T104ev1XV1U9dx6w32uL/LgSEhKnRigleAyAEhpALkxTN2SbQcWeB26L8vonyghSX91ABThPJvtFP2RaRjUcy5k9YlfZ7tEkwtFL87Wym3T0djPSwV27wogDs63Nme8TBYxYvXFuZYeflnJ/J1j+BlldYL/XQ1AjCRjX1CsmaaUpJ/6D+5G0s1gcs6OmaCrwu7NAyWa8BI6ePOLm1oSjJHw483k6h2JULJPXX4y1TzpzDqNTeDBggVmdGKe2vdXYooKEJkuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYOFzkP9PWn7m7qF2bvLhLESZzCT8eEoeSWJSEhscKY=;
 b=JJMNNs8pZRNrBsYSH6dpUrR4B8bdb2sBqE7XYR7fDjkULOSoApvnD1hlZXusNKpjpkJ29Ba6RR+exw+7JGJGT/pCzJVxZqteaJjcPeJMm4mHpf0n80MRBrs5hgwZshNJrg9dlgVcB51Gmqt8vk+YgEHXKidR2F4bpEI6bgo5BcL+NVDg3rYKO+piWXdpnAQLVGHdJydgxlQQ7Ej3JgqvJnqwQ62xKgHLIHWzJUfonbPij3JDGudDiMqlhOFV6nGbygsym6Slhf3k+f/BdgVEfn8ninxqUM5hxNd0ayz3ziaSM4jLOsxapkEUW4e3TdmCS0EIf2Ydb83nw+p5eLYXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYOFzkP9PWn7m7qF2bvLhLESZzCT8eEoeSWJSEhscKY=;
 b=jvocYRBUUau4BSbHc3KSc6C002akb1nszxl/j2xpBYjLouKEnlmAVuptZ0YJdUbx0Oot/aPrt0KMYkAYH0Lzy2sJ8FCcw0ZCDw04Rkr9KEqao3qJso071wNhBXa6p8YJGTvHg3nbyIv5YNScg1a35ks1HAOhOJ4MuX/+9N+8tAi9udJKDYGGyNY1p9S03JobwP7A1ijezvo8DM4jYGDUICfPPziZwd6cQNgtYqJ1Ky/oBzCI1sN0t1kzTyHzYYlVjqS4pmKHzusmLpft7hOu7fFIoxrXHVJOF9tJ2s6PxkxiIrQr16c1DUZHh6RMUEhAZwTzEMK5nm4u+HeHf6vITQ==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1114.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 15:40:28 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d127:a49b:525b:bc1d]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d127:a49b:525b:bc1d%5]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 15:40:28 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Weird debugger behavior with events
Thread-Topic: Weird debugger behavior with events
Thread-Index: AdidFtonnyCY/4ynT5OfFHOWXurEfw==
Date: Thu, 21 Jul 2022 15:40:28 +0000
Message-ID: 
 <PH1P110MB105042C5A2262DF250224C69E2919@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4300703-95fb-4e55-d922-08da6b2f56a5
x-ms-traffictypediagnostic: PH1P110MB1114:EE_
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c/C1BVqSjsIr96W4Ru2vJBnCxz0NnAAbt5S7rQWKSZ40PUlvIPvtFcH75hCrQPcsJ5eyvh+ag5Ob5055lZ+00A/olrIHHdWsDwVcdJYt6RSb8SEUc9ivguo2RRrHT63YmuFLJ7lmHyQEQEEkmNzrNHNA8Ud/TsCqav7qfV51zta7OqB0lj7snlVsDREH5H5WbzygmLdvRXcBADCTYIpW10tIcegVm6BTvwqCtqL/jvgjM/jV4t+f1oigew211dJ8bQPVp48haXDVyaEzLaWFf9WKYFNbXSdhT+neWzCJn0Dv+W2/jmIodtrlXdLz5iWScZOrO8w4/u2w55axFQNjdcB7ZCI9D9/OPNWrszqLYboZcnwG7zjRe8aDkdZrmn4IkOkja6w+jkr75TDTdH+pgkXmkJnoQSjygxc7InDO63y5S7ans2HRt/LKDyobg3ltAeuYaWynyM9sURUYCz06kdI+erIqmvieCxwDQ9heLVrxXnjaFZ+k+nfAhquy8Wqip/VATPitewetZ/MfILvRU6HlbxnXzKDBXXuhgBAosxlZ6jaSvhTNSrAbLBqP4zrUyWfrVs6k0BeKykkRLxA3a1Lnsg71QEvSKsCoVhnpVTVzAN9NngMTf0En9Cd+0u3xSHnFiXVE7xODKnV9oce/0+n0+gWLonH61wqEyg5OuTLrh9Ad0+Y3R9+GWIVEeN1xX/BzapkNjGudWpAwsndq9EIoUFzDF+ybdOWVEnsAQ1o=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(186003)(9686003)(38100700002)(122000001)(83380400001)(5660300002)(52536014)(44832011)(8936002)(2906002)(55016003)(71200400001)(498600001)(6506007)(7696005)(6916009)(8676002)(76116006)(66946007)(66446008)(4326008)(86362001)(33656002)(66476007)(99936003)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 BdnSnF7XpZ35yKi6N9zxK3RTudZQMMc7iWQ9SP9xJ01k64x6QK97BpHJHGLqYOfB6WqJrMtqYWnbtuQRePXGrP7iYNztT/wEe/Mu865H+y1Kp/rmd2EsDYrJ2C1A9HYRWcK30lxkUkfwM++Fd53OTaPOar82xoEgA645Aae7G0MC0/5CCezDcjWPl/vZEfc6Xv12qfhL6eEGOYiuTVSk/UO5ojTEbArZLhJuMdwyIah7FgBzxpbc4dLvEqcrCPi8FPDZMIms/XBUy5VHB2MAIaIDaTcvhd1fOP/ZqPGQCZXmZUC2cKYBqP+wDuYAZ+x4cEUv2u3yebXsWLPwyeAYyo2foANgLBYvuyTSh/0g1/+jkaRHWd6n/tq8Vyepe/GLo5UVikFyLViHXYCunN72EgLHlAuyfvLX1mnXsCqAVhzc6GBLM/IBNcjLUT6kz60naVvjjT+9Pka8Erh1By6+6L6UTaEWZJF4RujUxay3mHA=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0083_01D89CE5.E822ACA0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4300703-95fb-4e55-d922-08da6b2f56a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:40:28.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1114
X-Proofpoint-GUID: tNkcK2ZIlsnwWqYqhAtmXqytdMsp7--r
X-Proofpoint-ORIG-GUID: tNkcK2ZIlsnwWqYqhAtmXqytdMsp7--r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210062

------=_NextPart_000_0083_01D89CE5.E822ACA0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

I ended up adding an xbuf and another thread to better replicate what I was 
seeing and exacerbate the issue. I can verify that all 3 threads show up as 
expected under "evl ps -l". You can just run the debugger with no breakpoints, 
and you should see the "-1 error occurred" message printed to the console at 
least once. You can also put a breakpoint on that print after the 
evl_timedwait_event call, and the breakpoint should get hit just about every 
time. Lastly, you can run the compiled app outside of gdb, and see that the 
error message is never printed out.


// g++ -Wall -g -o test 
test.cpp -I/opt/evl/include -L/opt/evl/lib -levl -lpthread

#include <evl/evl.h>
#include <evl/thread.h>
#include <evl/mutex.h>
#include <evl/event.h>
#include <evl/clock.h>
#include <evl/xbuf.h>
#include <thread>
#include <unistd.h>
#include <vector>
#include <errno.h>

namespace
{
    struct evl_mutex mutex;
    struct evl_event event;

    int xbuf_fd = -1;
};

void Test_Event()
{
    cpu_set_t tkcpu;
    CPU_ZERO(&tkcpu);
    CPU_SET(4, &tkcpu);
    sched_setaffinity(0, sizeof(cpu_set_t), &tkcpu);

    struct sched_param sparam;
    sparam.sched_priority = 97;
    sched_setscheduler(0, SCHED_FIFO, &sparam);
    pthread_setname_np(pthread_self(), "Test_Event");

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, 
"Test_Event");
    if (fd < 0)
    {
        evl_printf("Failed to attach to thread\n");
        return;
    }

    evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, NULL);

    while(true)
    {
        evl_lock_mutex(&mutex);
        struct timespec tnow;
        evl_read_clock(EVL_CLOCK_MONOTONIC, &tnow);
        tnow.tv_sec += 1;
        int rv = evl_timedwait_event(&event, &mutex, &tnow);
        if ((rv < 0) && (rv != -ETIMEDOUT))
        {
            evl_printf("-1 error ocurred\n");
        }
        evl_unlock_mutex(&mutex);

        // Sleep
        evl_usleep(1000);
    }
}

void Test_Sleep()
{
    cpu_set_t tkcpu;
    CPU_ZERO(&tkcpu);
    CPU_SET(3, &tkcpu);
    sched_setaffinity(0, sizeof(cpu_set_t), &tkcpu);

    struct sched_param sparam;
    sparam.sched_priority = 97;
    sched_setscheduler(0, SCHED_FIFO, &sparam);
    pthread_setname_np(pthread_self(), "Test_Sleep");

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, 
"Test_Sleep");
    if (fd < 0)
    {
        evl_printf("Failed to attach to thread\n");
        return;
    }

    evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, NULL);

    while(true)
    {
        // Sleep
        evl_usleep(1000);
    }
}

void Test_Xbuf_OOB()
{
    // Not really used since no data goes into the xbuf
    size_t count = 10;
    std::vector<uint8_t> buffer(count);

    cpu_set_t tkcpu;
    CPU_ZERO(&tkcpu);
    CPU_SET(5, &tkcpu);
    sched_setaffinity(0, sizeof(cpu_set_t), &tkcpu);

    struct sched_param sparam;
    sparam.sched_priority = 97;
    sched_setscheduler(0, SCHED_FIFO, &sparam);
    pthread_setname_np(pthread_self(), "Test_Xbuf_OOB");

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, 
"Test_Xbuf_OOB");
    if (fd < 0)
    {
        evl_printf("Failed to attach to thread\n");
        return;
    }

    evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, NULL);

    while(true)
    {
        evl_usleep(100);

        ssize_t ret = oob_read(xbuf_fd, buffer.data(), count);
        if (ret < 0)
        {
            // Not enough data
            if (errno == EAGAIN)
            {
                continue;
            }

            evl_printf("%d error occured while oob reading\n", errno);
            break;
        }
        else
        {
            evl_printf("Successful oob read\n");
        }
    }
}

int main(int argc, char *argv[])
{
    // Init EVL
    int ret = evl_init();
    if (ret != 0)
    {
        printf("EVL Init failed with error: %d\n", ret);
        return -1;
    }

    int res = evl_create_mutex(&mutex, EVL_CLOCK_MONOTONIC, 0, 
EVL_MUTEX_NORMAL|EVL_CLONE_PRIVATE, "test_mutex");
    if (res < 0)
    {
        printf("Failed to create mutex\n");
    }

    // event
    res = evl_create_event(&event, EVL_CLOCK_MONOTONIC, EVL_CLONE_PRIVATE, 
"test_event");
    if (res < 0)
    {
        printf("Failed to create event\n");
    }

    // xbuf
    xbuf_fd = evl_create_xbuf(1024, 1024, EVL_CLONE_NONBLOCK | 
EVL_CLONE_PRIVATE, "test_xbuf");
    if (xbuf_fd < 0)
    {
        printf("Failed to create xbuf\n");
    }

    // thread 1 (EVL) - call evl_timedwait_event over and over and expect to 
timeout
    std::thread t1([&]{Test_Event();});

    // thread 2 (EVL) - call evl_usleep over and over
    std::thread t2([&]{Test_Sleep();});

    // thread 3 (EVL) - out-of-band read on the xbuf
    std::thread t3([&]{Test_Xbuf_OOB();});

    // Do not exit so we can see stats
    while(true)
    {
        sleep(1);
    }

    return 0;
}

------=_NextPart_000_0083_01D89CE5.E822ACA0
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
9w0BCQUxDxcNMjIwNzIxMTU0MDI2WjAvBgkqhkiG9w0BCQQxIgQggpa0/pwEeCFiGS2RlsyhLKX/
tlRtUdNGTP9jCIxqhU8wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCC
4EL1X9Ik2VU7kMnC+NjVSqZBc1SeF2rHWNQF53X/JCSxfUutPX205S52YGQNtXxuQmL3d344issE
lAVtC0WVbdFT2yMq2EF9tauxnbsVVWd/J1+PZG6j0RKAX0EB2mybABWLKSBM1k/kkmmnyX8RQPpm
XJEJcTOv3XI6v/tDSylDo0SQX9gm7Y92PWlSlFh4SxSplBC90kL/XpD6XeYo9euoqe0hq6QcNJF1
2c2pQ0kBPE7XC18RJUi+tRgUMwbRl1mcz3OvB2EGYBmr8wQhvxgWlrc53zWZLago+qk93yQ0lehj
XoMuQ+FxmgXp+Wd4iXh1/ZTnDXu9/pDRlQYZAAAAAAAA

------=_NextPart_000_0083_01D89CE5.E822ACA0--
