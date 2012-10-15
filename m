Message-ID: <507C2A38.4030308@xenomai.org>
Date: Mon, 15 Oct 2012 17:22:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507C2940.7000005@gmail.com>
In-Reply-To: <507C2940.7000005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem Compiling/Building UserSpace Support for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Videv <videvstefan@gmail.com>
Cc: xenomai@xenomai.org

On 10/15/2012 05:18 PM, Stefan Videv wrote:
> Hello!
> 
> I've been trying to compile the user-space support for the latest 
> version of Xenomai for ARM but failing.
> 
> After downloading the source files, and running
> 
> ./configure --build=i686-pc-linux-gnu --host=arm-linux-gnueabi 
> CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a"

That is because your toolchain compiles by default for thumb. Add -marm
to CFLAGS, thumb user-space are currently unsupported.

-- 
					    Gilles.

