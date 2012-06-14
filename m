Message-ID: <4FD98E9C.1040908@xenomai.org>
Date: Thu, 14 Jun 2012 09:11:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJywn_UgeKtEpHaTs5Cn+x+GYE19bpPoh+jVb3dz-R8RAZA@mail.gmail.com>
In-Reply-To: <CAHyVJywn_UgeKtEpHaTs5Cn+x+GYE19bpPoh+jVb3dz-R8RAZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error while compiling I-pipe for exynos4210
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 06/14/2012 08:30 AM, Mohit Jandwani wrote:
> *H**ey I am trying to compile i-pipe core 3.2 for exynos 4210 board.When I
> try to compile the code , this is what happens
> **

exynos 420 is not supported by any I-pipe patch. You have to adapt the
I-pipe kernel to get it working. The good news is, since it seems to be
cortex a9 based, not much work is needed. Use omap4 as an example.

For documentation on how compiling xenomai works, see README.INSTALL in
xenomai sources. An online copy is available here:

http://www.xenomai.org/documentation/xenomai-2.6/README.INSTALL


-- 
                                                                Gilles.

