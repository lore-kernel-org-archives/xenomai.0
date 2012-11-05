Message-ID: <50980A35.8090607@xenomai.org>
Date: Mon, 05 Nov 2012 19:49:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-P+pXRT0ECC-0CPtZyR8f4cmMt+ZkbzHvJU_9sgWtD9g@mail.gmail.com>
In-Reply-To: <CANzNmi-P+pXRT0ECC-0CPtZyR8f4cmMt+ZkbzHvJU_9sgWtD9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling the Xenomai examples 2.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/05/2012 04:09 PM, Sebastian Pavez wrote:

> make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE=

> (...)

> 
> What should I do??


Read the documentation? Documentation/kbuild/modules.txt in the kernel
sources for starters. The above line can not work.

-- 
                                                                Gilles.

