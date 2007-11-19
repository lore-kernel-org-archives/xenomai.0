Message-ID: <4741AFCF.7070103@domain.hid>
Date: Mon, 19 Nov 2007 16:46:23 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <47415786.6040208@domain.hid>
	<2ff1a98a0711190725j78fbdc85j852cda9621a067be@domain.hid>
In-Reply-To: <2ff1a98a0711190725j78fbdc85j852cda9621a067be@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] accuracy of system clock
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
Cc: Xenomai <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Nov 19, 2007 10:29 AM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
>> Hi all,
>>
>> I'm using clock_gettime(REALTIME,&t) in a kernel module (posix skin) to
>> timestamp something. I know accessing this clock from user space yields
>> values different from those returned by the xenomai posix skin due to
>> ntpdate.
> 
> Well, you can use the posix skin in user-space as well.
> 
>> But my concern is that the difference in pace is too much.
>> On one system it is about 90us/s wrong on another it is 160us/s.
> 
>> I assume the speed of the ntp corrected clock is more or less correct.
>> Is there some calibration procedure I can run to tweak xenomai to make
>> sure in xenomai I get 1e9 ticks per *true* second?
>> I have enabled CONFIG_X86_UP_APIC.
> 
> There is currently no way to calibrate Xenomai, but there is a known
> issue about the APIC frequency specifically. I do not know if some
> quick fixes have been posted, but there is a (rather large) series of
> patches fixing it.

Can you suggest a different timing source? I thought using the APIC
was preferred over using the TSC. What do other users do if they want
1 ms to last 1 ms?

If the drift appears to be constant on each system I can problably account
for it and apply a correction. I'll try that.

Theo





