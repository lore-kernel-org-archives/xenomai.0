Resent-Message-ID: <20141219105200.GC2012@hermes.click-hack.org>
Resent-To: xenomai@xenomai.org
Date: Fri, 19 Dec 2014 11:31:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141219103133.GY2012@hermes.click-hack.org>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141218140529.GM2012@hermes.click-hack.org>
 <1193017267.99526.1418920886509.JavaMail.zimbra@wandercraft.eu>
 <20141218174347.GU2012@hermes.click-hack.org>
 <1886500835.102755.1418982478388.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1886500835.102755.1418982478388.JavaMail.zimbra@wandercraft.eu>
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

On Fri, Dec 19, 2014 at 10:47:58AM +0100, Huy Cong Vu wrote:
> ----- Mail original -----
> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> > Cc: xenomai@xenomai.org
> > Envoyé: Jeudi 18 Décembre 2014 18:43:47
> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> 
> > On Thu, Dec 18, 2014 at 05:41:26PM +0100, Huy Cong Vu wrote:
> >> > Unknown reason is suspicious, if you have used the sigdebug example,
> >> > you should not that there is now an additional reason for receiving
> >> > SIGXCPU.
> >> > 
> >> 
> >> You are right, the error I got is error 7, i.e
> >> SIGDEBUG_RESCNT_IMBALANCE, knowing that I don't use a mutex in my
> >> app, so maybe it's still an unknown issue?
> > 
> > That is impossible, you can not get this error if you do not use
> > mutexes. Maybe the library you use uses mutexes .
> > 
> 
> You are right, I'm able to spot some mutexes in my library,
> however, the call which cause the mode switch is not included in
> mutex zone. I tried to disable all mutexes but the error still
> occurs.

As I said, the SIGDEBUG_RESCNT_IMBALANCE should only happen when
using a mutex. The relax upon send should be unrelated though.

> 
> >> 
> >> >> ./testcase_posix[0x401570]
> >> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f40ddb7acb0]
> >> >> /usr/xenomai/lib/librtdm.so.1(rt_dev_sendmsg+0x16)[0x7f40dd5598f6]
> >> >> 
> >> >> These 2 programs use the same functions call, compiled with same
> >> >> flags (rtdm, native & posix mixed):
> >> > 
> >> > Most likely, rt_dev_sendmsg is passed a non real-time socket. You
> >> > can use either native or posix services to create and handle
> >> > sockets, but you can not mix the call. It meansa socket created with
> >> > rt_dev_socket (the native service) should be passed to
> >> > rt_dev_sendmsg, whereas socket created with the posix service
> >> > (socket) can only be passed to posix services (sendmsg). Is not it
> >> > what is happening here?
> >> > 
> >> 
> >> So, does that means that my test in posix skin should not calls
> >> rt_dev_sendmsg?
> > 
> > No. Once again, that means that you should not use rt_dev_sendmsg
> > with a socket obtained with the "socket" service, but as long as you
> > obtain the socket with rt_dev_socket, you can use rt_devn_sendmsg.
> > 
> 
> I changed the call to posix wrap function, error now occur at
> __wrap_send, I made a dig in posix/rtdm.c itself and it seems that
> mode switch come from this line:
> 
> 		ret = set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid,
> 						  __rtdm_sendmsg,
> 						  fd - __pse51_rtdm_fd_start,
> 						  &msg, flags));
> 
> Before that, my library wanted to send a frame to an rtnet port
> that was already setup-ed with socket service. Is there something
> wrong with the fact that I'm trying to access to rtnet port with
> posix wrapped service?

I am not sure I understand what you mean. So, I am going to try and
explain a third time what I mean.

- This works:
int fd = socket

send(fd, buffer, n);

- This works:
int fd = rd_dev_socket

rt_dev_send(fd, buffer, n);

- This DOES NOT work:

int fd = rt_dev socket

send(fd, buffer, n);

- This DOES NOT work either:

int fd = socket

rt_dev_send(fd, buffer, n);

Once again, as long as you do not send us a testcase allowing us to
reproduce the problem, it is difficult to make any progress in
understanding the issue you have.

-- 
					    Gilles.

