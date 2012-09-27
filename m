Message-ID: <50645D6E.2030809@xenomai.org>
Date: Thu, 27 Sep 2012 16:06:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1280469939.3985122.1348754869513.JavaMail.root@zmail.sgconsulting.it>
In-Reply-To: <1280469939.3985122.1348754869513.JavaMail.root@zmail.sgconsulting.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 -
 Kernel compilation fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Forconi <forconi@wavecomm.it>
Cc: xenomai@xenomai.org

On 09/27/2012 04:07 PM, Forconi wrote:
> Thanks for this suggestion, replacing ldm sp,{r0-r3} with ldmia sp,{r0-r3} does the trick!
> Now, the kernel compiles fine, so the problem was the ldm instruction was not recognised from the cross-as.

I would say the cross-as is broken, as it works for everyone else. But
we have to cope with broken toolchains...

-- 
					    Gilles.

