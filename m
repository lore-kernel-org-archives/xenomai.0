Message-ID: <517E5A11.7040206@xenomai.org>
Date: Mon, 29 Apr 2013 13:31:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EFC670@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664EFC670@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai : incompatible feature set (APF27)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/29/2013 12:05 PM, Younes CHALABI wrote:

> Hi all,
> 
> I'm using xenomai-2.6.2.1 with the APF27 board using the following configuration :
> 
> - Buildroot : 2013.02
> - gcc : 4.4.7
> - libc : uClibc 0.9.33.2
> - busybox : 1.21.0
> - U-boot : 2012.04
> - Linux : 2.6.29.6
> - Adeos_patch : adeos-ipipe-2.6.29-arm-1.13-05.patch
> 
> The installation and the deployment were done correctly, and after transfered the images on the target. I checked the correct installation of Xenomai on the board with : # dmesg | grep Xenomai and have this display :
> 
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/arm started.
> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> Xenomai: real-time nucleus v2.6.2.1 (Day At The Beach) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> 
> Now I want to use the tests proposed by Xenomai with : # xeno-test but have this following error message :
> 
> Started child 472: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-test
> + echo 0
> + /usr/bin/arith
> Xenomai: incompatible feature set
> (userland requires "kuser_tsc fastsynch", kernel provides "sa1100 eabi fastsynch nosmp", missing="kuser_tsc").
> 
> Searching in troubleshooting, I found that I have to --enable-arm-tsc option which I did by : ./configure --enable-arm-tsc=imx          


Could you show us the messages printed by configure when running it with
this option?

Also note that this happens because you are using the I-pipe patch for
Linux 2.6.29 which is pretty old, and we have not been testing this
configuration for a long time. Linux 2.6.29 was released in 2009. That
is 4 years ago.


-- 
                                                                Gilles.

