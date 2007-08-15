Message-ID: <46C2D5C4.2010407@domain.hid>
Date: Wed, 15 Aug 2007 12:30:28 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>	<46C05690.2010108@domain.hid>	<46C063E0.1010809@domain.hid>	<46C07005.8000504@domain.hid>	<46C1B498.8060600@domain.hid>	<Pine.LNX.4.64.0708141629570.18303@domain.hid>	<46C1EE69.3020301@domain.hid>
	<46C1FFDA.4070709@domain.hid>	<46C298FD.8070300@domain.hid>
	<46C2B842.1080501@domain.hid> <46C2CC73.9080807@domain.hid>
In-Reply-To: <46C2CC73.9080807@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, rtnet-users <rtnet-users@domain.hid>

Roland Tollenaar wrote:
> Hi,
> 
> Some more interesting findings (no i-pipe trace yet though).
> 
>> Hmm, this doesn't convince me yet. Such skews during startup may as well
>> be triggered by unusual load during runtime (non-RT activity or new RT
>> components). Did you put your system under adequate non-RT load as well
>> while measuring the outputs?
> Running latencytest with my application shows an average latency of 
> about 40 and a max of 200ns. This was rather shocking so I turned off 
> rtcan in my application. Now the max latecy is 60ns. Turn off EML and 
> turn on rtcan, max latecy is 230ns. How is that for strange? But since I 
> can see the scope output bobbing with 200ns during the latency test, I 
> can also see that if I run my application without the latency test the 
> huge max latency disappears entirely. Maybe it is time for the trace but 
> then again I am still using CAN over the parallel port so will see what 
> it does on a machine with a PCI CAN adaptor first. Because I think I 
> know what happens: Due to the external loading the CAN recv interrupt 
> triggers the Rx ISR briefly before the 1ms task period ends. Due to the 
> priority of the ISR (huge debate over this) and its atomicness (if I 
> remember correctly) the reading out of the slow hardware delays the 
> start of the new task period.
> 
> Just thought it was interesting to mention. Btw when the latency appears 
> there are no overflow messages or anything like that which support the 
> theory I have about the cause.
> 
> Btw2 the 200ns latency spikes do not cause the scope to loose lock on 
> the saw-tooth so whatever causes that problem is of a different nature 
> still.

s/ns/us/ ?

Wolfgang.

