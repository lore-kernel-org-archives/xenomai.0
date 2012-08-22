Message-ID: <5034C308.3010108@xenomai.org>
Date: Wed, 22 Aug 2012 13:31:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtei-4S1A_AyhAifj+HxuGcVCuNRsDUeytX=21=bB9UwbQ@mail.gmail.com>	<50349F8D.3080102@xenomai.org>
	<CAKKWdtdwdAmcvzJcKCVoc+8QDYOpHtvq_r5QOwoQ5UXyhfqc7Q@mail.gmail.com>
In-Reply-To: <CAKKWdtdwdAmcvzJcKCVoc+8QDYOpHtvq_r5QOwoQ5UXyhfqc7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Can we have nested interrupt handling in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 08/22/2012 11:48 AM, ali hagigat wrote:

> Dear Gilles,
> 
> Would you please explain when a pipeline stage is stalled/unstalled? I
> wonder if you can explain it in more details.
> Regards


See __ipipe_dispatch_irq there:
http://git.denx.de/?p=ipipe.git;a=blob;f=kernel/ipipe/core.c;h=182b61c5c294044dde712884a9d3123e393c54a9;hb=refs/heads/core-3.4

Around line 1166.
-- 
                                                                Gilles.

