Message-ID: <518A677A.8010808@xenomai.org>
Date: Wed, 08 May 2013 16:55:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOx=Z6E+C4z5TgtwnpNe-C_F0o8gN5hJcj_ZMN56YYdxvxHV=w@mail.gmail.com>
In-Reply-To: <CAOx=Z6E+C4z5TgtwnpNe-C_F0o8gN5hJcj_ZMN56YYdxvxHV=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Some Help Required (ARM port)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Smith <salerio@gmail.com>
Cc: xenomai@xenomai.org

On 05/08/2013 04:50 PM, Peter Smith wrote:

> I am new to Xenomai!
> 
> I want to experiment with Xenomai on an Altera Cyclone V (dual ARM Cortex
> A9) device for which 3.7 and 3.8 based Linux kernels are available. I have
> read about an experimental 3.8 patch but have no idea how to start the
> process of applying the patch (and any other patches first) to the kernel
> source. So the questions are 1) is this even possible and 2) can someone
> give me a clue please.


Hi,

Xenomai installation instructions are available here:
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/

In the case of the 3.8 kernel, there is no patch yet, the patched kernel
is available as a git tree:
git://git.xenomai.org/ipipe-gch.git, branch for-core-3.8

If the kernel you want to use is a fork of the Linux kernel, the
simplest way to get an I-pipe kernel for it is to merge the git branch
above with the git branch likely provided by Altera, if you are lucky
and they provide their kernel as a git branch.

Now, the last issue is about modifying the I-pipe kernel to support your
ARM SOC, for this you should follow the instructions here:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

Regards.

-- 
                                                                Gilles.

