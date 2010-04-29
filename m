MIME-Version: 1.0
In-Reply-To: <4BD99F8C.3090800@domain.hid>
References: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
	<4BD99F8C.3090800@domain.hid>
Date: Thu, 29 Apr 2010 23:20:15 +0800
Message-ID: <p2y48abf2c21004290820g1dabc981y5a1dbd141f64059e@domain.hid>
From: Peter Pan <pppeterpppan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] cyclictest gives out segmentation fault with
	xenomai 2.5.2 in powerpc arch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I searched through the archive, some one says that there is a git
commit to sole the problem. I downloaded the latest xenomai-2.5 git,
the problem is gone.

But I found another problem. When I use the "latency" test, all the
min latency time gives out a minus value. Is that normal?

2010/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Peter Pan wrote:
>> I downloaded the ipipe-2.6 from git.denx.de, head =A0 =A0 is
>> "ipipe-2.6.32-powerpc". Then I downloaded xenomai-2.5.2 and patch the
>> kernel. Then I install the xenomai applications into our rootfs. I
>> just run cyclictest in /usr/xenomai/share/xenomai/testsuit/cyclic/run,
>> it gives out following line:
>>
>> *
>> *
>> * Type ^C to stop this application.
>> *
>> *
>> 0.00 0.05 0.03 2/24 1010
>>
>> T: 0 ( =A0 =A00) P:99 I: 1000000 C: =A0 =A0 =A0 0 Min: 1000000 Act: =A0 =
=A0 =A0 0 Avg:
>> =A0 =A0 =A0 0 Max:-1000000
>> Segmentation fault
>
> Probably a stack overflow. Could you run the application inside gdb to
> check that?
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

