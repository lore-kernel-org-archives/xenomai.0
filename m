Message-ID: <4D6B9032.5060907@domain.hid>
Date: Mon, 28 Feb 2011 13:08:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
> Hi,
> 
> I currently can have a look again at the problems I initially described in
> 
> http://mail.gna.org/public/xenomai-help/2011-01/msg00091.html
> 
> In short, I get various exceptions (Illegal use of supervisor access, NULL pointer
> etc.) in a setup involving a RTDM driver using interrupts, some RT tasks, and network
> communication over normal (non-RT) sockets. The exceptions appear to occur in either
> gatekeeper/0 or in the thread that serves the network requests, not in the thread
> talking to the driver. It occurs only with the driver open however. It even
> appears in exactly the same way if the application accessing the RTDM driver
> and the webserver are started as separate processes. All other "normal"
> (non-RT) processes run stable.  I guess there is some problem with interrupts
> during system calls.
> 
> Initially I titled the posting with "...under heavy load". But now we know the
> problem always occurs after some time, just more often the higher the load. I
> probably have to go back to the previous bfin dist release (with older kernel
> and Xenomai 2.4.x) if there's no fix.
> 
> Now I'm quite unable to further investigate within the ipipe/xenomai kernel code but
> would like to create at least an example as small as possible but able to trigger the
> problem, so others may reproduce it more easily. It seems I need a RTDM (dummy?)
> driver that triggers some hardware interrupts, a thread talking to it, and another
> thread making system calls such as select() etc...

Does it happen if you use other system calls than select?

-- 
                                                                Gilles.

