Message-ID: <5064A428.70003@xenomai.org>
Date: Thu, 27 Sep 2012 21:08:24 +0200
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


The error suggests, as has been told you on the rt-users mailing list,
that you are using a very old toolchain. It is not really recommended.
I would recommend using for instance CodeSourcery toolchain or Denx
ELDK. If you absolutely want to stay with the oldish 2.6.38, with
CodeSourcery, do not use anything newer than 2010q1.

-- 
                                                                Gilles.

