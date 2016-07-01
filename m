Date: Fri, 1 Jul 2016 16:37:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160701143719.GP18662@hermes.click-hack.org>
References: <3137778ca215b6db6061de83fa64dcae@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3137778ca215b6db6061de83fa64dcae@smile.fr>
Subject: Re: [Xenomai] RTnet - List corruption when creating packet socket
 two consecutive times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Geoffrey BONNEVILLE <geoffrey.bonneville@smile.fr>
Cc: xenomai@xenomai.org

On Fri, Jul 01, 2016 at 04:31:58PM +0200, Geoffrey BONNEVILLE wrote:
>  
> 
> Hi, 
> 
> Tested with Xenomai 3.0.2 (Cobalt) on a 4.1 kernel. Both on a
> 32-bits ARM and a 32 bits x86 platform. 
> 
> I get a list corruption
> warning when I try to open()/close() one packet socket, two (or more)
> consecutive times. 
> 
> I think the problem is not limited to packet
> sockets. 
> 
> Steps to reproduce: 
> 
> - Use a kernel with CONFIG_DEBUG_LIST=y
> 
> 
> - Load rtnet.ko and rtpacket.ko 
> 
> - Execute a program which open() and
> close() a packet socket. (see test_socket.c below)

I am afraid I still not had time to work on rtnet. So, if you have
patch that fixes the issue, I will merge it, but I can not do more
before some time.

-- 
					    Gilles.
https://click-hack.org

