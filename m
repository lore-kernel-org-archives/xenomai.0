Date: Tue, 15 Dec 2015 16:46:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215154621.GA2927@hermes.click-hack.org>
References: <2004286.fnOG18ZY9A@soho> <3314665.2OtX88jxTl@soho>
 <20151211163114.GE24775@hermes.click-hack.org>
 <1972107.aCc7hAvxek@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1972107.aCc7hAvxek@soho>
Subject: Re: [Xenomai] Porting a library to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai list <xenomai@xenomai.org>

On Tue, Dec 15, 2015 at 04:16:23PM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 11 de desembre de 2015, a les 17:31:14, Gilles Chanteperdrix va 
> escriure:
> [...]
> 
> > 
> > The fact that wrapping may be a problem for large applications where
> > you only want a small part of the application to use xenomai
> > services is the reason why Xenomai 3.x gives you another choice: do
> > not wrap xenomai services, but specify you want to use them with the
> > __RT() macro.
> 
>  ... following this thread. There's a point that I'm still confused: the rtnet 
> part.
> 
> Since 2.6.4, rtnet was another project, that installed its includes (rtnet.h 
> and rtmac.h) in its own place. From 3.x rtnet is integrated.
> 
> Looking the rtnet.h file, there are declared some #define and some include 
> protected by __KERNEL__
> 
> My question is:
> 
> Using the POSIX wrapper, all the socket functions are wrap. But, how does it 
> affect the rtnet part of the code? 
> 
> I mean, if I have a rtnet device, what is the difference of manually change all 
> the network functions with a -DRTNET protected Realtime versions functions or 
> use the wrap?
> 
> I understand that if I open a device that it's not rtnet, I lose the Realtime, 
> although I open the device with a POSIX wrapped function. That's correct?

There is no difference whatsoever between 2.6 and 3.x in the way to
use RTnet through the POSIX wrapped interface or through the
native/alchemy skin.

If you decide to use RTnet through the POSIX skin, then the wrapped
socket function will create RTnet sockets, and the wrapped sendto
and recvfrom will send and receive data from that socket. No need
for -DRTNET (or -D__XENO__ more likely, as this gets defined by
xeno-config).

If you decide to use RTnet through the alchemy skin, then you would
use the rt_dev or rt_ variant (never can recall what they are
called). Here you would probably use the ugly -D__XENO__.

Now, the difference between 2.6 and 3.x, is that there is a third
way to the POSIX interface: without the wrapping. In that case, if
you call socket(), you get an Linux socket, and if you use
_RT(socket()), you get an RTnet socket (if RTnet stack is compiled
and loaded), of course, you then need to use _RT(sendto()) and
_RT(recvfrom()) to send/receive from that socket.

-- 
					    Gilles.
https://click-hack.org

