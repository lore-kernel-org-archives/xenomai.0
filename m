Message-ID: <4E08CCF3.1070403@domain.hid>
Date: Mon, 27 Jun 2011 11:33:23 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <BANLkTim0Maz-yjXtG90j-=RtLCesRE=hCg@domain.hid>	<4E04C614.6000101@domain.hid>
	<4E06A4B7.2050906@domain.hid> <4E074D6D.8070606@domain.hid>
	<4E07DF44.1060204@domain.hid> <4E0863D8.2090402@domain.hid>
In-Reply-To: <4E0863D8.2090402@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] more questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11-06-27 04:04 AM, Gilles Chanteperdrix wrote:
> On 06/27/2011 03:39 AM, David Wiebe wrote:
>> I'm trying to get an spi port on the beagleboard to work in realtime.
>> I didn't know there were other ioctl's. I wrote a program with ioctl,
>> tested it to make sure it worked, which it did, then changed ioctl's to
>> rt_dev_ioctl's in hopes that doing so would enable real time behaviour.
>> The program with rt_dev_ioctl's did not run as desired(no spi). I guess
>> I can't simply change ioctl's with rt_dev_ioctl's to enable real time
>> functionality? Do I have to patch xenomai to enable spi or something?
> Hi,
>
> What you have to do is to write a driver for whatever SPI controller you
> are using, using the RTDM API.
>
So, I've got to write a driver for the SPI controller using the RTDM API.
OK, thanks.

>>> - which driver you have written/loaded to implement this ioctl
>> I thought changing ioctl for rt_dev_ioctl was all that was required to
>> implement this device in realtime mode. This device is an spi port.
> No.
>
That would be too easy wouldn't it?
>>> - what you mean by "my program does not perform as it should", what is
>>> the return value of this rt_dev_ioctl which is supposed to work?
>>>
>> I watch my oscilloscope for activity on the spi port. regular ioctl
>> worked, rt_dev_ioctl did not. Both programs ran but only one worked.
> There are other ways to debug software than an oscilloscope. Looking at
> the functions return values when they have one is a good start.
>
Fair enough.
>>>> #2. rtnet. I wrote a test snippet of code to test the ethernet part.
>>>> Prepended the appropriate functions with rt_dev_ and same results as in #1.
>>>>
>>>> I assume that if something wasn't in the library I would get compiler
>>>> errors and if the code running on the beagleboard  was bad, I would get
>>>> run time errors. I have seen neither.
>>> Again, what driver are you trying to use? What happens when you try and
>>> configure it?
>>>
>> So I have to patch the ethernet driver in order for it to work? I though
>> that was taken care of when I patched the kernel with xenomai.
> You do not have to patch anything. Again, what you lack is probably an
> ethernet driver, or simply to load and configure the rtnet driver for
> the hardware you have, exactly like you do with Linux.
>
> If you are going to write drivers, I really suggest you read "Linux
> device drivers", then read the RTDM skin documentation to understand the
> RTDM API. Note that most of the time, you can "port" a Linux driver to
> RTDM or Rtnet, there is even a guide on how to do so for network drivers
> in rtnet sources.
>
I've got a copy of the book.

Thanks for the info.



