Date: Sun, 3 Apr 2016 21:09:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160403190948.GC20399@hermes.click-hack.org>
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

I am going to merge your patch for the time being. However, I have a
question about using rttcp in parallel with Linux tcp: are you using
the rtnetproxy module? If yes, then testing for
CONFIG_XENO_DRIVERS_NET_ADDON_PROXY and the rt_ip_fallback_handler
pointer would be the way to go.

-- 
					    Gilles.
https://click-hack.org

