From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <92812.74331.qm@domain.hid>
References: <92812.74331.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Feb 2010 15:50:09 +0100
Message-ID: <1266504609.26785.104.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] XDDP / IDDP Protocol Documentation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: Xenomai-help@domain.hid

On Thu, 2010-02-18 at 06:15 -0800, Guvenc Gulce wrote:
> Hi 
> Starting with Xenomai 2.5.x, there are couple of protocols which can be used by the rt threads for IPC 
> purposes. I am playing with the xddp protocol. Apart from the examples in xenomai source tree and an 
> e-mail from Philippe in xenomai-core mailing list, I couldnt find any further documentation. Do I overlook 
> smt here ? Are there any other pointers which document these protocols with further details ?
> 
> The API is actually Posix - Socket based so the usage is pretty straightforward but it would be nice 
> to have a list of accepted parameters for setsockopt call and what they are doing and maybe the accepted 
> values of "flags" parameter which can be used for example with recvfrom() call ? It would be more comfortable 
> then digging in the xenomai source code.

Likely yes. But no doc avail yet, aside of the demo code from
examples/rtdm/profiles/ipc.

> 
> And in order to ask a particular question:
> 
> Any idea how to make recvfrom() call non-blocking in xddp context ? seems to be blocking per default.
> 

MSG_DONTWAIT should be set in flags.

> Thanks & Regards
> 
> Guvenc
> 
> 
>       
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



