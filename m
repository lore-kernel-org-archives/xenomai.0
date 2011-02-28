Date: Mon, 28 Feb 2011 12:44:44 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] More blackfin kernel oops under heavy load
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I currently can have a look again at the problems I initially described in

http://mail.gna.org/public/xenomai-help/2011-01/msg00091.html

In short, I get various exceptions (Illegal use of supervisor access, NULL pointer
etc.) in a setup involving a RTDM driver using interrupts, some RT tasks, and network
communication over normal (non-RT) sockets. The exceptions appear to occur in either
gatekeeper/0 or in the thread that serves the network requests, not in the thread
talking to the driver. It occurs only with the driver open however. It even
appears in exactly the same way if the application accessing the RTDM driver
and the webserver are started as separate processes. All other "normal"
(non-RT) processes run stable.  I guess there is some problem with interrupts
during system calls.

Initially I titled the posting with "...under heavy load". But now we know the
problem always occurs after some time, just more often the higher the load. I
probably have to go back to the previous bfin dist release (with older kernel
and Xenomai 2.4.x) if there's no fix.

Now I'm quite unable to further investigate within the ipipe/xenomai kernel code but
would like to create at least an example as small as possible but able to trigger the
problem, so others may reproduce it more easily. It seems I need a RTDM (dummy?)
driver that triggers some hardware interrupts, a thread talking to it, and another
thread making system calls such as select() etc...  If you have any thoughts on
existing example code that I could use as a base, or generally some guess about
what kind of simple test code could trigger such a problem, I'd appreciate your
input. For a RTDM test driver, I could use timers or UART as a commonly available
source for interrupts? My system is based on a BF537, somewhat similar to the STAMP.

Thanks,
Kolja


