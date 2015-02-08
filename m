Date: Sun, 8 Feb 2015 18:38:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150208173849.GA2014@hermes.click-hack.org>
References: <6740-54d79d80-97-750d4f00@265280780>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6740-54d79d80-97-750d4f00@265280780>
Subject: Re: [Xenomai] The latency test hangs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dauphin Alexandre <alexandre.dauphin@ecole.ensicaen.fr>
Cc: xenomai@xenomai.org

On Sun, Feb 08, 2015 at 06:30:43PM +0100, Dauphin Alexandre wrote:
> 
> Hello,
> 
> My probleme is that i can't launch any latency tests , they always hang .
> I work with a Imx6 quad core board ( arm architecture ) , my kernel version is :
> 
> # cat /proc/version
> Linux version 3.0.43 (root@modx6sdk) (gcc version 4.7.1 20120402 (prerelease) (crosstool-NG linaro-1.13.1-2012.04-20120426 - Linaro GCC 2012.04) )
> 
> there , is the xenomai configuration i used :
> # /usr/xenomai/bin/xeno-config
> xeno-config --verbose
>         --version="2.6.4"
>         --cc="arm-linux-gnueabi-gcc"
>         --arch="arm"
>         --prefix="/usr/xenomai"
>         --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
>         --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread -lrt "
>         --posix-cflags=""
>         --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
>         --library-dir="/usr/xenomai/lib"
> 
> Whene i run some latency test , it always hangs after "warming up..." and nothing append then..
> 
> # /usr/xenomai/bin/latency -p 1000
> == Sampling period: 120000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...

I do not see how this is possible, if you pass -p 1000, you should
read: Sampling period: 1000 us.

> 
> I tried to change the periode ,but it doesn't make any changes.
> 
> # /usr/xenomai/bin/latency -p 120000 -T 600

with -p 120000 you request for a 2 minutes sampling period. I am not
sure this can even work, I would say latency can not work with a
period larger than 1s.

-- 
					    Gilles.

