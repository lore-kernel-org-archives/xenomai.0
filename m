Date: Thu, 22 Dec 2005 10:57:59 -0500
From: Kent Borg <kentborg@domain.hid>
Subject: Re: [Xenomai-help] Shared Memory, check. Fifos...
Message-ID: <20051222105758.Z16178@domain.hid>
References: <20051221151012.W16178@domain.hid> <43AA5FBE.2070501@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AA5FBE.2070501@domain.hid>;
	from rpm@xenomai.org on Thu, Dec 22, 2005 at 09:11:42AM +0100
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Dec 22, 2005 at 09:11:42AM +0100, Philippe Gerum wrote:
> RT-side: rt_pipe_create(&pipe,"this_pipe",0)
> 	opens the RT side, and creates /proc/xenomai/registry/pipes/this_pipe
> 	use rt_pipe_write()/rt_pipe_read() to exchange data through this channel.
> 
> non RT-side: open("/proc/xenomai/registry/pipes/this_pipe",...)
> 	use write()/read() to exchange data with the RT-side.
> [...]

OK, I think I have that working. 


Thanks!

-kb

