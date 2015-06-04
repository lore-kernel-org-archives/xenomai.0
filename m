Date: Thu, 4 Jun 2015 12:56:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150604105616.GS27570@hermes.click-hack.org>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150603130217.GQ27570@hermes.click-hack.org>
 <30507154.J7D5WlzkQ8@eltrolinux48.eltroad.eltropuls>
 <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8492059.5Osop05oYh@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] rtnet locking/socket SKBs
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

On Thu, Jun 04, 2015 at 12:41:47PM +0200, Marc Strämke wrote:
> Am Mittwoch, 3. Juni 2015, 19:09:36 schrieb Marc Strämke:
> > How is the reference count maintained for the rtdm devices, is that the
> > refcount in the rtdm_fd structure (fd->refs). There is also a driver
> > refcount, I am actually somewhat confused how this is maintained...
> 
> So I got mostly down to the issue but I need some input from someone more 
> knowledged in rtnets design: 
> The reference count of an open AF_PACKET socket is not dropping to zero 
> because there are still skb in the sockets skb pool and 
> rtskb_socket_pool_trylock increments the fds reference 
> count. rt_socket_cleanup would release the skb pool but never gets called.
> 
> What I do not really understand at this moment is why the fd
> reference count gets incremented at all when the socket gets a skb
> in its pool? Is there any reason to not close a socket while it
> still has associated skbs in the pool?

The previous rtnet design was converted to reference counts globally
when integrating into xenomai 3, some details may still need fixing.
The old design was different but lead to the close syscall looping
for ever and blocking your application if anything went wrong, so,
this is an attempt to avoid this issue.

> They will never get cleared if the application crashes If I am 
> not mistaken.

Once again: when an application crashes, the file descriptors are
automatically closed by Xenomai, you do not need to care about this
case.

-- 
					    Gilles.

