MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18387.2283.891303.192919@domain.hid>
Date: Sat, 8 Mar 2008 22:45:15 +0100
In-Reply-To: <e39c9190803081255i6888ce44yd0a14f0b90e57b0b@domain.hid>
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
	<47D27C0A.2010507@domain.hid>
	<e39c9190803080624sf49293bwff20317788ad28f7@domain.hid>
	<e39c9190803080942k302e66a6m75ed94dccd55aaac@domain.hid>
	<47D2D537.7020106@domain.hid>
	<e39c9190803081026s88acfe1h7dbef2f26ec7acc5@domain.hid>
	<18386.63663.282453.578916@domain.hid>
	<e39c9190803081255i6888ce44yd0a14f0b90e57b0b@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Posix skin and message queues operation mode
	misunderstanding
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

juanba romance wrote:
 > >
 > > Xenomai posix skin signals cause the target thread to switch to
 > >
 > secondary mode, so, it may not be a good idea to use them.
 > >                                            Gilles Chanteperdrix.
 > 
 > 
 > I understand that since the first callback instruction up to call the
 > mq_receive xenomai system call, isn't it ?

Yes, it is.

 > 
 > We were thinking to customize the real-time operative passing some
 > parameters only under a controlled application state. So at same time we
 > need to connect the real time operative to any "secondary" object, maybe
 > other approaches are preferred..
 > 
 > If the mq_receive returns to the primary domain we can assume the hole along
 > the configuration process timing.
 > 

I do not understand what you mean. But from my point of view, using
message queues notification through SIGEV_THREAD or SIGEV_SIGNAL will
never be nearly as fast as a server thread calling mq_receive in a
loop.

-- 


					    Gilles Chanteperdrix.

