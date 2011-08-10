Message-ID: <4E42A892.6080203@domain.hid>
Date: Wed, 10 Aug 2011 17:49:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1312989511.75315.YahooMailClassic@domain.hid>
In-Reply-To: <1312989511.75315.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: Xenomai-help@domain.hid

On 08/10/2011 05:18 PM, Philip Ha wrote:
> 
>> The question remains: are you sure the UART does not introduce the
>> delay, have you checked the datasheet?
>>
> Hi Gilles,
> 
> I apologize for the delay in responding the last message.
> 
> I measured the latency of the UART by pulsing the DTR pin on the 
> serial port as soon as the ISR is called. Using an oscilloscope 
> I monitored the DSR input signal from the function generator and 
> the DTR signal from the serial port. The time difference between 
> signals was 6-9 us. Therefore the latency of the UART is < 10 us 
> at all times.
> 
> As long as the UART latency is consistent the size of it does not
> matter for the test I am performing. An input signal that comes in 
> every 1000000 us should result in the 16550 ISR being called every 
> 1000000 us.
> 
> The function generator is accurate to 1us, the UART ISR latency 
> jitter is approximately 3 us. Therefore I would not expect to see
> 100 us of timing measurement inacurracy using OS time stamps. It 
> is also strange that this timing measurement inaccuracy changes 
> every time the system is rebooted.
> 
> Any thoughts? 

Could you try measuring the jitter in cpu cycles with rdtscll, in
kernel-space? If the inaccuracy persists, check that cpufreq is not
enabled, and that if running on a multicore system, tscs are
synchronized. Apart from that no, no idea.

-- 
					    Gilles.

