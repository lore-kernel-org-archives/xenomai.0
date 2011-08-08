Message-ID: <4E402433.4090103@domain.hid>
Date: Mon, 08 Aug 2011 20:00:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1312821858.88556.YahooMailClassic@domain.hid>
In-Reply-To: <1312821858.88556.YahooMailClassic@domain.hid>
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

On 08/08/2011 06:44 PM, Philip Ha wrote:
>> Hi Gilles,
>>
>> Sorry for the formatting, I am new to mailing lists.
>>
>> I have looked at the latency in the 16550A driver. The first thing 
>> the driver does in its ISR is to call rtdm_clock_read and store the 
>> resulting timestamp in a "struct rtser_event". The code I posted 
>> grabs this structure. If I use this as my timestamp I get the exact
>> same timing results.
> 
>>> are you sure that the interrupt triggers as soon as you receive a
>>> character, and not upon timeout when not receiving characters for some
>>> time? After all, 100us is approximately the time to transmit one
>>> character at 115200 bauds on the serial line.
>>>
>>> -- 
>>>                                           Gilles.
> 
> Hi Gilles,
> 
> I am not sending characters, I am sending a pulse from a 
> function generator into the DSR pin and looking for the rising
> edge event ( RTSER_EVENT_MODEMHI ). Any latency in the system
> should be similar for every pulse it receives, therefore the
> time between pulses should still be 1000000us.

The question remains: are you sure the UART does not introduce the
delay, have you checked the datasheet?

-- 
                                                                Gilles.

