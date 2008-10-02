Message-ID: <48E47C34.5070908@domain.hid>
Date: Thu, 02 Oct 2008 09:45:56 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <894886ec0810012230j57e2f87n343a5b07bbdbd46@domain.hid>	
	<48E45E3C.30605@domain.hid>
	<894886ec0810012258o67da00d7x2e3d54c7e601b470@domain.hid>
	<48E4649B.6090506@domain.hid>
In-Reply-To: <48E4649B.6090506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Rob Wheeler wrote:
>> Gilles,
> 
> Rob,
> 
> please do not drop the list from the CC, the conversation may interest
> other people.

Yes indeed!

> 
>> Thanks for the FAST response.  I'm currently calling gettimeofday()
>> and clock_settime() one time just prior to creating my realtime
>> thread.
>>
>> My goal is to have a thread that wakes up every 1ms and performs some
>> work and goes back to sleep until the next 1ms interval.  My current
>> implementation calls clock_gettime() initially, and then sits in a
>> while (1) loop that does some work and then calls
>> clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, ...) with a timespec
>> exactly 1ms since the last sleep.
>>
>> Given my application, is your recommendation that I switch to using
>> the CLOCK_MONOTONIC in my realtime loop and then have a non-realtime
>> thread which basically does:
>>
>> while (1) {
>>   gettimeofday()
>>   clock_settime(CLOCK_REALTIME)
>>   sleep for a bit
>> }
>>
>> so that I can get close to synchronized time in my realtime code?
> 
> Yes.
> 
>> Also, just for my education, is 50us/s a typical clock drift value?
>> What exactly is the source of this drift and can anything be done to
>> reduce the amount of drift?
> 
> I have no idea if this is normal. Xenomai uses the tsc as a clock
> source. Linux may choose to use something else than the tsc (you should
> see messages in the logs if it does), it may correct the tsc clock drift
> if you use NTP, and since Xenomai does not correct the drift, you
> observe a difference.

I generally get 152us/s on one system (Asus P4PE/GE) and also 152us/s on
another system (MSI 945P). For the first system I remember (years ago)
seeing the same drift under RTLinux. On a laptop (Fusitsu-Siemens S7110)
the drift somehow converges to zero. I don't use NTP, just ntpdate once
at night.

May ask a (probably silly) question. Does clock_get/settime(clock_id) in
/usr/include/time.h and in .../xenomai/include/posix/time.h refer to exactly
the same clock? Or do these interfaces just refer to similar clocks.

Theo


