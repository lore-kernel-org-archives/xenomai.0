Message-ID: <517A2BCF.6020609@xenomai.org>
Date: Fri, 26 Apr 2013 09:25:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.252.1366321778.1444.xenomai@xenomai.org>	<00f801ce3fcb$30850ce0$918f26a0$@com>	<51763D6E.6090407@xenomai.org>	<016901ce4043$7b54e1f0$71fea5d0$@com>	<5176D40E.7060607@xenomai.org>	<019a01ce40a5$95325b90$bf9712b0$@com>
	<51777F8C.9000700@xenomai.org> <51778229.1050109@xenomai.org>
	<01c601ce4249$27a8e8f0$76fabad0$@com>
In-Reply-To: <01c601ce4249$27a8e8f0$76fabad0$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/26/2013 08:42 AM, George Pontis wrote:

> Hello Gilles,
> 
> I was experimenting with this and found that the problem is some kind
> of interaction between my other patches, and the 3.8 ipipe patch. The
> other patches were to add i.MX53 support for LCD, framebuffer, and
> IPU ( image processing unit ). Those patches are newer versions of
> the ones in staging from Sascha Hauer. Eventually I do need to get it
> all playing together.
> 
> So as far as Xenomai-current, I am seeing it build and boot on
> i.MX53, but have not done any more testing yet. I thought that I
> tried the exact kernel that you had on git without success. Possibly
> the kernel config file in my buildroot has some different IPIPE
> options. This is what I have in the working .config:


Hi Georges,

I am currently testing Xenomai on imx53, there were a few missing
pieces, but it seems to be running now, I am running the
"xeno-regression-test" test.

Please make the patches you are talking about available, I will test them.

> CONFIG_IPIPE=y CONFIG_IPIPE_LEGACY=y > <--- is this needed ?


Yes.

Regards.

-- 
                                                                Gilles.

