From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <1243529533.22173.6.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243529533.22173.6.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2009 13:58:50 -0400
Message-Id: <1243533530.898.36.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On Thu, 2009-05-28 at 18:52 +0200, Philippe Gerum wrote:
> On Thu, 2009-05-28 at 11:59 -0400, Andreas Glatz wrote:
> > Hi,
> > 
> > We have to start 40+ Xenomai tasks in kernel space.
> 
> Why subjecting yourself to the pain of running a complex application in
> kernel space? The difference between kernel and userland latencies on an
> mpc836x should not be worth it.
> 

We see a 70us difference between running exactly the same
application in kernel-space and user-space. The application
registers the rx and tx interrupt of one UEC and replaces
the buffer descriptor rings allocated by Linux, and 
takes care of the buffer handling. During the
test we send out an Ethernet frame from the MPC8360, the
frame gets processed on the other end of the wire and 
eventually we receive the response from the other device. 
The total round trip time (function call send() to 
return of function call receive() measured with __xn_rdtsc()) 
is 230us in kernel-space and 300us in user-space.

FYI: Another device which used direct SMI instead of Ethernet
to talk to the device on the other end of the wire showed a
round trip time of 40us... 


Andreas

