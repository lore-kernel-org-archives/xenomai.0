Message-ID: <51E97310.3060103@xenomai.org>
Date: Fri, 19 Jul 2013 19:10:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51E92C74.4000207@spesonline.com>
In-Reply-To: <51E92C74.4000207@spesonline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] help for cyclictest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Luca Bolli SPES <luca.bolli@spesonline.com>
Cc: xenomai@xenomai.org

On 07/19/2013 02:09 PM, Luca Bolli SPES wrote:

>
> Good morning at all, I'm new in this mailing list so in first time I
> will apologize for any mistake that
> I'll do. Recently I realized a toolchain for an ARM9 AT91 based (kernel
> 3.0.36, gcc 4.6.3, libc 2.13)
> and I successfully ported the latest version of Xenomai (2.6.2.1).
> The cross-compiled kernel (and patched with
> adeos-ipipe-3.0.36-arm-1.18-11.patch) starts without
> errors. After this, I'll try to run some tests with cyclictest that I
> compiled, with the same toolchain
> and with this options (passed to configure tool):
> configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t"
> --build=i686-pc-linux-gnu
> --host=arm-<vendor>-linux-gnueabi-
>
> When I started to carry out my tests, I noticed a strange behavior of
> cyclictest software and
> I used this option for launch the tests: cyclictest -t 2 - p 80 -n -i
> 10000 -l 10000 -v


Hi,

cyclictest is not a xenomai specific tool, and hence not maintained by 
the Xenomai project. If a more recent version has important fixes you 
need, we will simply update cyclictest. If you are interesting in 
measuring the jitter of your system, you may use the "latency" test instead.

Regards.

-- 
                                                                 Gilles.

