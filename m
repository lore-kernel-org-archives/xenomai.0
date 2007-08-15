Message-ID: <46C298FD.8070300@domain.hid>
Date: Wed, 15 Aug 2007 08:11:09 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid>	<46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>	<46C1B498.8060600@domain.hid>	<Pine.LNX.4.64.0708141629570.18303@domain.hid>
	<46C1EE69.3020301@domain.hid> <46C1FFDA.4070709@domain.hid>
In-Reply-To: <46C1FFDA.4070709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>, Xenomai-help@domain.hid

Hi,

> Check the /proc output again, there should be also RTnet's stack manager
> at prio 98. Maybe that is too low for your scenario and causes prio
> inversions (note: every incoming Ethernet frame goes through its hands).
> Try lowering the prio of your rt_task1 beneath 98.

Thanks. This seems to have made a big improvement. I have so far not 
once detected the scope to loose lock on the sawtooth when the 
index_check in eml is still disabled. Before lowering the priority of my 
task (to 97) I could still invoke what I suspect to be a latency spike.

If the index_check is enabled I now mostly have less problems too. There 
is a chance in start-up of the application that there is a latency spike 
and then the warning kicks in. Due to the fact that the shift is 
permanent, the error is persistent and this then destabilizes the 
sawtooth a bit.

I will keep the check disabled but for the EML chaps I do think this is 
a point of interest. I would be very interested how this index shift 
occurs and why it is persistent after occurring once.

Sorry for the pragmatic qualifications here but in the end its the 
stability of the outputs that will determine the behaviour of the 
machine so its not a bad way to assess the software. :)

> If the problem persists (or your _really_ want to understand what
> happens), you could try to put an xntrace_user_freeze(0, 1) before the
> line which emits that EML warning, turn on the I-pipe tracer, set a
> large back_trace_points value (a few thousand), enable verbose mode, and
> grab what /proc/ipipe/trace/frozen reports after the hick-up. See [1]
> for more howtos.

Done this before so it should not be a problem. Don't think it is 
necessary quite yet as the behaviour at the moment looks good.


Regards,

Roland.

> 
> If you post the dump, we may be able to analyse what the system is doing
> before the problem report, if there are long delays due to high-prio
> tasks e.g.
> 
> Jan
> 
> [1] http://www.xenomai.org/index.php/I-pipe:Tracer
> 

