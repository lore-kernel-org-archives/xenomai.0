Message-ID: <46C2BB52.5090508@domain.hid>
Date: Wed, 15 Aug 2007 10:37:38 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid>	<46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>	<46C1B498.8060600@domain.hid>	<Pine.LNX.4.64.0708141629570.18303@domain.hid>
	<46C1EE69.3020301@domain.hid> <46C1FFDA.4070709@domain.hid>
	<46C298FD.8070300@domain.hid> <46C2B842.1080501@domain.hid>
In-Reply-To: <46C2B842.1080501@domain.hid>
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

> Hmm, this doesn't convince me yet. Such skews during startup may as well
> be triggered by unusual load during runtime (non-RT activity or new RT
> components). Did you put your system under adequate non-RT load as well
> while measuring the outputs?
could you please just remind me how to do this again? OR can i just run 
the latency test, it has dummy loading in it does it not?

>> Sorry for the pragmatic qualifications here but in the end its the
>> stability of the outputs that will determine the behaviour of the
>> machine so its not a bad way to assess the software. :)
> 
> A problem isn't solved until it is also understood.
You are so right. :(


> 
>>> If the problem persists (or your _really_ want to understand what
>>> happens), you could try to put an xntrace_user_freeze(0, 1) before the
>>> line which emits that EML warning, turn on the I-pipe tracer, set a
>>> large back_trace_points value (a few thousand), enable verbose mode, and
>>> grab what /proc/ipipe/trace/frozen reports after the hick-up. See [1]
>>> for more howtos.
>> Done this before so it should not be a problem. Don't think it is
> 
> In that case, I would even more suggest to collect the data, maybe now
> about the fragile startup case.

Have got it on my todo list. :)

Roland.


> 
>> necessary quite yet as the behaviour at the moment looks good.
> 
> Jan
> 

