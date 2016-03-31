Date: Thu, 31 Mar 2016 12:44:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160331104409.GC4744@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 31, 2016 at 10:33:09AM +0000, Matti Suominen wrote:
> Hi,
> 
> I have case where we use rtnet's tcp socket in server application to 
> communicate with real time and non-real time tcp clients. To get 
> communication work between client and server I had to do some changes to 
> stack/ipv4/tcp/tcp.c file.
> 
> First. Original tcp flag enumeration didn't work at all in this case. This 
> was verified by using Wireshark to track communication which didn't show 
> me any flags in tcp packets. This was solved by replacing flags assigning 
> TCP_FLAG_ prefixed enums with TCPHDR_ prefixed defines from <net/tcp.h> in 
> stack/ipv4/tcp/tcp.c file. The original code only works in case of little 
> endian machine, as rt_tcp_set_flags function places assumption that flags 
> are located in the least-significant 8bits of the 32bit flag variable. 
> This approach is similar to what regular TCP is using: 
> https://github.com/torvalds/linux/blob/master/net/ipv4/tcp.c
> 
> Second. Server was able to receive messages from client but was unable to 
> reply messages. I was able to trace function calls by adding debug prints 
> to tcp.c functions and noticed that accepted socket wasn't signaled for 
> "ready to send" at all and server was unable to reply messages. This seems 
> to work properly if the send signal is posted in the end of the accept 
> function, which also would seem the logical way to initialize it once 
> connection has been established.
> 
> Third. In our case we have regular Linux tcp sockets and rtnet tcp sockets 
> working parallel, serving different services. Referred to this I noticed 
> that *rt_tcp_dest_socket() may cause problem when real time stack 
> processes a message targeted to a regular Linux socket and does not find a 
> rttcp socket for it. The rttcp stack then  tries to send RST|ACK to client 
> to terminate the connection. This is temporarily disabled by setting 
> "if (!th->rst)" clause into #ifdef YET_UNUSED. This should be corrected 
> for example by implementing layer which is able to loop also non real time 
> sockets. Or is it really a desired rttcp design principle to unsupport the 
> usage of regular Linux tcp sockets in parallel?
> 
> ---------------------------------------------------------------------------
> 
> We noticed also that Windows client causes assertion in pool balance at 
> end of transmission.
> 
> Assertion failed! /src/stack/socket.c:rt_socket_cleanup:199 
> (&sock->skb_pool)->pool_balance == 0

The pool_balance assertions do not work: they are updated outside of
critical sections, and thus are subject to race conditions.

> 
> Call Trace:
> [cbe97db0] [c00087e0] show_stack+0x48/0x150 (unreliable)
> [cbe97df0] [d3830414] rt_socket_cleanup+0x13c/0x140 [rtnet]
> [cbe97e10] [d38a1f00] rt_tcp_close+0x2b0/0x3a8 [rttcp]
> [cbe97e50] [c009d3c0] __rt_dev_close+0x174/0x368
> [cbe97e80] [c0071588] hisyscall_event+0x18c/0x35c
> [cbe97ec0] [c00615c0] __ipipe_dispatch_event+0xac/0x1ec
> [cbe97f20] [c000ea5c] __ipipe_syscall_root+0x5c/0x140
> [cbe97f40] [c000fe60] DoSyscall+0x20/0x5c
> --- Exception: c01 at 0x4899ba08
> 
> This is still unsolved but it seems not to cause harms.
> 
> ---------------------------------------------------------------------------
> 
> Difference between Xenomai 3 tcp.c and our tcp.c additions at end of 
> message. Our fixes is based to rtnet 0.9.13, but this is how we could do 
> fix if we use Xenomai 3's rtnet.

TCP is disabled in Xenomai 3 rtnet. The main problem is that
creating a socket in Xenomai 3 requires switching to secondary mode,
so the "accept" service seems hard to implement without leaving
primary mode. Given the fact that TCP can not be a deterministic
protocol, I planned to drop TCP support in the next RTnet iteration.
If you require to send messages over TCP from a thread running in
primary mode, you should rather pass the message using an XDDP
socket to a thread running in secondary mode and using plain linux
TCP sockets. You will not get more determinism with TCP in RTnet.

-- 
					    Gilles.
https://click-hack.org

