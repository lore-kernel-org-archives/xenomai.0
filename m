Date: Thu, 18 Dec 2014 18:43:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141218174347.GU2012@hermes.click-hack.org>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141218140529.GM2012@hermes.click-hack.org>
 <1193017267.99526.1418920886509.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1193017267.99526.1418920886509.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Thu, Dec 18, 2014 at 05:41:26PM +0100, Huy Cong Vu wrote:
> > Unknown reason is suspicious, if you have used the sigdebug example,
> > you should not that there is now an additional reason for receiving
> > SIGXCPU.
> > 
> 
> You are right, the error I got is error 7, i.e
> SIGDEBUG_RESCNT_IMBALANCE, knowing that I don't use a mutex in my
> app, so maybe it's still an unknown issue?

That is impossible, you can not get this error if you do not use
mutexes. Maybe the library you use uses mutexes .

> 
> >> ./testcase_posix[0x401570]
> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f40ddb7acb0]
> >> /usr/xenomai/lib/librtdm.so.1(rt_dev_sendmsg+0x16)[0x7f40dd5598f6]
> >> 
> >> These 2 programs use the same functions call, compiled with same
> >> flags (rtdm, native & posix mixed):
> > 
> > Most likely, rt_dev_sendmsg is passed a non real-time socket. You
> > can use either native or posix services to create and handle
> > sockets, but you can not mix the call. It meansa socket created with
> > rt_dev_socket (the native service) should be passed to
> > rt_dev_sendmsg, whereas socket created with the posix service
> > (socket) can only be passed to posix services (sendmsg). Is not it
> > what is happening here?
> > 
> 
> So, does that means that my test in posix skin should not calls
> rt_dev_sendmsg?

No. Once again, that means that you should not use rt_dev_sendmsg
with a socket obtained with the "socket" service, but as long as you
obtain the socket with rt_dev_socket, you can use rt_devn_sendmsg.

> 
> 
> >> The only different is the portion I mentioned above.
> > 
> > Compiling for the xenomai skin causes changes in the services called
> > even without changing the code. So, for instance, if you use the
> > "socket" service, when compiling for the native skin, it will create
> > a plain linux socket, whereas when compiled for the posix skin, it
> > will try and create an RTDM socket.
> > 
> 
> Even after removing native c & ld flags, it keeps calling this
> native function, which is a strange behavior, no?

No, the calls to native functions are explicit, there is not trick.
The trick is for the posix calls. As explained here:
https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Under_the_hood_the_8211wrap_flag


> 
> > To help you more, we would need more details, such as for instance a
> > reduced, self-contained test case allowing us to reproduce the issue
> > you observe.
> > 
> 
> I'm working on that one, will post it asap. Thanks for your help.

Waiting for this.

-- 
					    Gilles.

