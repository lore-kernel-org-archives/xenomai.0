Message-ID: <4B9985C3.4060100@domain.hid>
Date: Fri, 12 Mar 2010 01:07:31 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B990EF1.1000400@domain.hid>
In-Reply-To: <4B990EF1.1000400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Experimenting with Analogy. Bugs
	found?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

> 1. I setup an asynchronous acquisition. I then use a loop to
> a4l_sys_read() the acquired data. When the acquisition command is over,
> as configured with the .stop_src and .stop_arg in the command data
> structure, the a4l_sys_read() returns an ENOENT error. The comedi way of
> signaling the acquisition command end is to return 0, as is done for
> files to signal the end of file. I think this is an API deficiency but I
> haven't looked at how much work is to fix it.

Looks like this has already been solved in the Alex's git tree. Thanks
Simon for the suggestion of looking there for fixes.

> 2. Looks like it is not possible to setup an endless acquisition. If I
> set .stop_src = TRIG_NONE and .stop_arg = 0, the command submission goes
> fine, but I obtain an ENOENT error at the first a4l_sys_read(). I have
> no idea on where to look to track down this issue.

This is still a problem.

Thanks. Cheers,
-- 
Daniele


