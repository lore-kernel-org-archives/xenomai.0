Message-ID: <4FE38513.2080607@xenomai.org>
Date: Thu, 21 Jun 2012 22:33:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+K6ZL0db_K0NsuEcKrQO9rcJ4myrx6QVge6i7HyMEkDhkwWww@mail.gmail.com>
In-Reply-To: <CA+K6ZL0db_K0NsuEcKrQO9rcJ4myrx6QVge6i7HyMEkDhkwWww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM I-pipe patch for 3.1+ kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Remco den Breeje <remco@vioco.nl>
Cc: xenomai@xenomai.org

On 06/21/2012 10:14 PM, Remco den Breeje wrote:
> Hi Gilles et.al.,
> 
> I'm interested in running a Xenomai patched system on a Raspberry Pi
> computer[1] that compromises a ARM11 CPU (ARMv6 architecture). The Linux
> kernels supported on the Raspberry are either Linux 3.1 or 3.2 [2,3], while
> the most recent ARM ipipe patch is written for a 3.0 kernel. Looking at
> your ipipe git[4], there hasn't been ARM related work for more recent
> kernels.
> What are the changes of a forward port, rebased on 3.1 or 3.2 kernels? Are
> there underlying technical difficulties?
> 
> I'm aware that even if there was a >3.0 ARM patch available, the Raspberry
> specific code needs to be ported. However, being a ARM-newby, porting board
> specific code together with porting the ipipe code is one step too far ;)

The ipipe branch core-3.2 supports kernel 3.2 on arm. Note however that
a lot of things have changed in this patch version, so the I-pipe
porting guide is completely helpless.

More generally, the git repository with the current work on the arm
architecture is:
http://git.xenomai.org/ipipe-gch.git

The branch for kernel x.y is for-ipipe-x.y-arm

-- 
                                                                Gilles.

