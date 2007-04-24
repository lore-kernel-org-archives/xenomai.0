Message-ID: <462DFBBC.2030408@domain.hid>
Date: Tue, 24 Apr 2007 14:44:44 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid> <460BECFD.2030003@domain.hid>	
	<460C0C7D.7000001@domain.hid>	
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	
	<17964.64208.463335.611234@domain.hid>	
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>	
	<462DC874.20303@domain.hid>	
	<bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>	
	<462DE28F.5010400@domain.hid>	
	<bc4264770704240517p2d4298d2n2c6260fac983edcf@domain.hid>
	<bc4264770704240519yc5558e8y869cdc44f9d0e3fa@domain.hid>
In-Reply-To: <bc4264770704240519yc5558e8y869cdc44f9d0e3fa@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

roland Tollenaar wrote:
> damn was not finished with this mail, silly webinterface.
> 
>> > warming up...
>> > RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>> > RTH|--lat min|---lat avg|-----lat max|-overrun|----lat best|---lat 
>> worst
>> > RTD|   24.304|    35.199|      65.371|       0|      24.304|      
>> 65.371
>>
>> Mind you this is slightly higher than when I run with a kernel without
>> i-pipe tracing enabled. Then it is more like
>>
> 20    30   50 etc
> 
> 
> 
>>
>> >
>> > Can the TSC cause such high delays?
>> >
>> > And what is the output of "/proc/xenomai/latency"?
> 
> 5866
> 
> Does that make sense to you? What does it mean?

That just means that you have to add this figure to the measured 
latencies. It looks to me, that the TSC emulation is the cause of the 
problem.

Wolfgang.

