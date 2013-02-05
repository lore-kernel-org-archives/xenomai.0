Message-ID: <51112C29.1030903@xenomai.org>
Date: Tue, 05 Feb 2013 16:58:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu> <51111CC2.3040204@xenomai.org>
	<51111DB6.4030809@icid.cu> <51111E46.4070706@xenomai.org>
	<511122D3.8000501@icid.cu> <51112476.2030500@xenomai.org>
	<511125B9.7020403@icid.cu> <5111260A.2000609@xenomai.org>
	<5111275D.2030807@icid.cu>
In-Reply-To: <5111275D.2030807@icid.cu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: raespi <raespi@icid.cu>
Cc: xenomai@xenomai.org

On 02/05/2013 04:38 PM, raespi wrote:

> So you're saying that I'm correctly passing the CFLAGS and LDFLAGS for 
> all the other packages on my system ( kernel, busybox, dbus, my apps, 
> etc ... ) but not to the Xenomai build ?? I fail to understand your 
> point ...
> 
> On Buildroot I have:
> 1- BR2_GCC_TARGET_ARCH="armv4t"
> 2- BR2_SOFT_FLOAT=y
> 
> Both translated in to good old GCC parameters are "-march=arm4vt 
> -msoft-float". So ???


So, there is probably a problem in Xenomai build system, which has
nothing to do with buildroot, but is related to the (deprecated) way
buildroot passes the CFLAGS and LDFLAGS to the build system.

-- 
                                                                Gilles.

