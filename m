Content-Type: text/plain; charset="us-ascii"
Date: Wed, 14 May 2008 16:49:00 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <48276703.2020005@domain.hid>
Message-ID: <20080514144900.216230@domain.hid>
MIME-Version: 1.0
References: <200805112104.56166.karl-trampe@domain.hid> <48276703.2020005@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Ideas how to measure delays with
 RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtnet-users@domain.hid
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Karl Reichert wrote:
> > Hello,
> > 
> > I have two stations running RTnet, one as a master and one as a slave. I
> want 
> > to measure the time, which a message, sent from master to slave, takes.
> But, 
> > I don't want the time of the transmission only, but the complete time of
> all 
> > software layers this data is processed through.
> > 
> > _______________	_______________
> > |		A		  |	|		D		  |
> > |______________|	|______________|
> > |		B		  |	|		C		  |
> > |______________|	|______________|
> > |   RTnet (Master)	  |	|    RTnet (Slave)	  |
> > |______________|	|______________|
> > 		|				  |
> > 		|______________|
> > 
> > So, I create the data, that should be send, in Layer A (Master) and send
> it 
> > over RTnet to Layer D (Slave).
> > 
> > I want to take the time when the data leaves A and when it arrives D
> with 
> > rtdm_clock_read(). If I have the offset between master and slave, I can 
> > calculate the time it took to pass A, B, both RTnet stacks, C and D.
> > 
> > As RTnet keeps track of the offset in it's stack, I want to use this
> value. Is 
> > it possible via the API? I didn't found anything. Or do I have to
> manipulate 
> > the stack to pass the offset to the higher layers (C and D)?
> 
> If RTmac/TDMA is in use, you can obtain the clock offset via
> RTMAC_RTIOC_TIMEOFFSET from the RTDM device "TDMA<x>" (where "<x>"
> corresponds to "rteth<x>").
> 
> Jan
> 

When I try to compile my application (xenomai native skin, user task), I get an error, saying rtdm_driver.h (which contains the prototype for rtdm_clock_read()) is for kernel mode tasks only.

How can I get a timestamp in a xenomai native user task? Is there sth equivalent to rtdm_clock_read()? Or do I have to write a kernel task?

Thanks
Karl
-- 
von Karl Reichert


