Message-ID: <4BD99F8C.3090800@domain.hid>
Date: Thu, 29 Apr 2010 17:02:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
In-Reply-To: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Peter Pan <pppeterpppan@domain.hid>
Cc: xenomai@xenomai.org

Peter Pan wrote:
> I downloaded the ipipe-2.6 from git.denx.de, head	is
> "ipipe-2.6.32-powerpc". Then I downloaded xenomai-2.5.2 and patch the
> kernel. Then I install the xenomai applications into our rootfs. I
> just run cyclictest in /usr/xenomai/share/xenomai/testsuit/cyclic/run,
> it gives out following line:
> 
> *
> *
> * Type ^C to stop this application.
> *
> *
> 0.00 0.05 0.03 2/24 1010
> 
> T: 0 (    0) P:99 I: 1000000 C:       0 Min: 1000000 Act:       0 Avg:
>       0 Max:-1000000
> Segmentation fault

Probably a stack overflow. Could you run the application inside gdb to
check that?

-- 
					    Gilles.

