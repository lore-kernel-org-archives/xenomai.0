Date: Wed, 3 Jun 2015 15:02:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150603130217.GQ27570@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] Problem with RTNET Packet Socket (or RTDM in general)
 in Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: xenomai@xenomai.org

On Wed, Jun 03, 2015 at 02:56:07PM +0200, Marc Strämke wrote:
> Hello everyone,
> 
> I am experiencing an issue with using packet sockets in Xenomai 3. I am at the 
> moment trying to replicate it on a minimal testcase but struggling.
> What I've found so far is that when a packet socket is read non-blocking with 
> MSG_DONTWAIT the socket sometimes cannot be closed afterwards. 
> I inserted a rt_printk into rt_packet_socket(fd,proto) and rt_packet_close(fd) 
> in af_packet.c, sometimes rt_packet_close never gets called and so any further 
> communication on this interface is effectively impossible.
> 
> Any hints on where I should start looking? 

Look at the reference counts.

> I assume the socket should be closed by Xenomai in any case, even if the 
> application abnormally terminates without calling close? If that is not the 
> case how do I make sure to clean up after the application in case the 
> application terminates abnormally?

Yes, xenomai cleans up file descriptors automatically upon process
termination.

-- 
					    Gilles.

