Message-ID: <50460BCE.8010505@xenomai.org>
Date: Tue, 04 Sep 2012 16:10:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
In-Reply-To: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/04/2012 03:42 PM, Henri Roosen wrote:
> Hi,
> 
> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and Ipipe
> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
> I reserved one cpu (kernel param isolcpus=1).
> 
> Our application triggers the following NULL pointer dereference when I
> set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
> The application does not trigger this when all tasks have the same
> affinity (set via /proc/xenomai/affinity).
> 
> I was able to reproduce this also under QEMU and will do some
> debugging, but maybe someone knows what is wrong already by seeing the
> stacktrace below:

Could you try to reduce the bug to a simple testcase which we would try
and run to reproduce?

> [  108.013023] BUG: unable to handle kernel NULL pointer dereference
at 00000294
> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3

Or send us a disassembly of the function __lock_task_sighand?

-- 
					    Gilles.

