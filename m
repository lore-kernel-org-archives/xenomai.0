Message-ID: <50F3F296.5000008@xenomai.org>
Date: Mon, 14 Jan 2013 12:57:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
In-Reply-To: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] universal application binary: how to
 auto-detect	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/14/2013 09:29 AM, Michael Haberler wrote:

> Hi,


Hi,

> 
> thanks to patience on this list we were able to build linuxcnc such
> that it runs on Xenomai, besides RT-PREEMPT, vanilla kernels (in a
> simulator/non-RT mode) and RTAI
> 
> 
> I'm planning to adapt linuxcnc such that a universal binary can be
> built which runs under Xenomai, RT-PREEMPT and vanilla kernels as
> this will simplify logistics quite a bit; what I'd like have is
> reliable auto-detection of the kernel type and 'do the right thing'
> (RTAI will remain a separate build).


I have no idea about preempt_rt, however, in order to detect xenomai,
you can check for /dev/rtheap. If it does not exist, xenomai programs
will not start anyway. Also, I guess for a universal binary, you would
dlopen xenomai libraries (native or posix, depending on the one you want
to use), if you want to do that, you have to pass --enable-dlopen-skins
to xenomai configure script.

Regards.

-- 
                                                                Gilles.

