Message-ID: <4F1DBC6B.3070502@domain.hid>
Date: Mon, 23 Jan 2012 21:00:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
	<4F173B1C.3000300@domain.hid>
	<CA+vRzy+ezWaWjp3mnGgD5VGaHqzcrK7MN47sww48y6xqT1NT9A@mail.gmail.com>
	<4F187F9B.4070203@domain.hid>
	<CA+vRzyLS2gMFBWCVZqv2oeSENvxacUugVViMXN+yGAMz5ubrxg@domain.hid>
In-Reply-To: <CA+vRzyLS2gMFBWCVZqv2oeSENvxacUugVViMXN+yGAMz5ubrxg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "Inappropriate ioctl for device" with
 xeno_16550A on Xenomai 2.6, not Xenomai 2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manuel Vonthron <manuel.vonthron@domain.hid>
Cc: xenomai@xenomai.org

On 01/23/2012 08:53 PM, Manuel Vonthron wrote:
> On Thu, Jan 19, 2012 at 3:39 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> gcc 4.6.2 definitely needs -fno-omit-frame-pointer. Stupid suggestion:
>> if you re-used the same build directory for xenomai user-space, did you
>> think about running "make clean" after reconfiguring?
>>
> 
> I wasn't using the same build directory. And as far as my own program is
> concerned, I "make clean" before each compilation.
> However I just saw one difference on the kernel configuration,
> RT/drivers/Serial
>   - on the working (2.5) machine, access mode is set to "any"
>   - on the other one (2.6), access mode is set to "port-based" only
> 
> Can this setting be the cause of my problem ?

I guess you would get some error message if the driver was not working,
did you check the kernel logs?

> 
> Thanks
> 
> 
> 


-- 
                                                                Gilles.

