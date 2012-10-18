Message-ID: <507F8379.3070505@xenomai.org>
Date: Thu, 18 Oct 2012 06:20:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1350468001.6812.xenomai@xenomai.org>
	<507F2930.9020709@gmail.com>
In-Reply-To: <507F2930.9020709@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM kernel issue
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

On 10/17/2012 11:54 PM, Stefan Videv wrote:

> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.31-psp24 (stefan@stefan-VirtualBox) 
> (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 Wed Oct 17 
> 17:09:40 BST 2012
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
> cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
> instruction cache
> [    0.000000] Machine: am335xevm


You are trying to run Xenomai on a machine for which the I-pipe patch
does not contain the support. There is no miracle:
- either you add that support yourself
- or you use a patch provided by the original user, which adds this support.

-- 
                                                                Gilles.

