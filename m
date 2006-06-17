Message-ID: <44945B9C.3020906@domain.hid>
Date: Sat, 17 Jun 2006 13:44:28 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44906584.60503@domain.hid> <449115E6.7040202@domain.hid>
In-Reply-To: <449115E6.7040202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: GPIO and RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jim Cromie wrote:
>   
>> hi Jan, everyone,
>>
>> Ive worked up a patchset to add a GPIO driver for the chip on my mobo.
>> I adapted an existing one, drivers/char/scx200_gpio,
>> and created drivers/char/pc8736x_gpio
>>
>> When doing this, I _oversimplified_ my problem by disregarding RTDM,
>> and Im hoping I can just _retrofit_ as needed.
>>     
>
> From a short glance at scx200_gpio: the only minor difference between
> registering and handling a Linux GPIO char-device and doing the same
> under RTDM will be the different naming. RTDM has no direct support for
> major/minor identification, it uses clear-text names for its devices. So
> you would have to create the device names on your own. Well, and some
> locking might be required (full preemptibility!), but this seems to
> apply to the Linux driver as well under certain kernel configs.
>
> But I wonder if it is clever for GPIO devices with a significant number
> of I/O lines to create a device node for each and every bit! Consider
> the usage scenario where you want to talk to some n-bit bus using GPIO
> lines. Would you like to open n devices and issue n writes just to put
> some n-bit value on that bus?
>
>   

That same Q had occurred to me.  There are likely apps which can already 
do their own
bit-masking, so dont need kernel support for single bits.  It would be a 
trivial to
allow either/both ports & bits via a mod-param. 

The bit-centrism is also a legacy of the device-file interface - the 
vintage driver has
*no* port access support, unlike at least 1 out-of-tree driver (which 
has /proc iface)


> At this chance: Did you have a look at the comedi interface as well? It
> typically covers far more complexes data acquisition devices, but it
> should also be usable for simple digital I/O interfaces. Moreover,
> comedi is available for Linux for quite a while, and a RTDM port is on
> the way.
>
>   
I did look briefly, its device model felt more complex than I needed.
A re-review is in order, now that I comprehend more than when I saw it last.

> If comedi means too much overhead for trivial I/O line manipulation, I
> would welcome any suggestion for a generic GPIO device profile - both
> mappable on RTDM and normal Linux character devices!
>
>   
>> the chip is on an ISA bus, a user-space C program can read the pins at
>> (this) rate:
>>
>> Wed Jun 14 13:24:13 MDT 2006
>> Linux soekris 2.6.17-rc6-gpio-sk #4 Sun Jun 11 20:43:10 MDT 2006 i586
>> GNU/Linux
>> opened /dev/gpio-17, for 1 loops, 1000000 samples
>> read 1000000 samples in 7.8434 sec, rate: 127494.9460 samples/sec
>> opened /dev/led, for 1 loops, 1000000 samples
>> read 1000000 samples in 5.4116 sec, rate: 184788.5056 samples/sec
>>
>> (obviously speed isnt latency, but theres some correlation ..)
>>
>> I dont actually have a Real Question, to I'll throw out a placeholder -
>>
>> What are the top 3-5 things to do or look at
>> in order to check the compatibility of my patches with RTDM ?
>>
>>
>>
>>
>> Separately..
>>
>> In this GPIO work, I concluded that I needed to add a sysfs interface
>> to my driver, in order to better fit with LKML expectations.
>>     
>
> Err, sorry for not seeing this immediately even after (cross-)reading
> your second mail, but what will the sysfs interface be for? 

Heh - Im sure its not you, but the un-clarity..

> Information,
> configuration? 

config - output_enable / tristate,   pullup/no,  totempole/opendrain, etc.
both reading & writing,  for bits, and for ports.
current pin values,  RW.

Basically, Im imitating the way things are done by LM-sensors,
where raw sensors are exposed via sysfs to a user-lib, which then does
the (floating-point) conversion to units that are more meaningful to users.


> Do you see concrete usage scenarios for this?
>   

WRT the sysfs interface itself, no, not per-se.  The device-file 
interface works fine,
and is basically interchangable.  The whole exersize was to anticipate
whatever push-back might come from LKML.
(I sent patch-set there today, so we'll see)


My 'concrete' app/hobby is to strap a cheap 'embedded-pc' to a RC-car
(radio-remote-control), have it read the PWM signals from the in-car 
receiver,
and to duplicate them to a pair of pins wired to the servos.
Once that works, the computer can train itself to the course driven by the
remote-control user, then try to repeat the manuver.

In order to 'read' the input, I *need* to use interrupts - polling the 
pins is ridiculous
if the computer is to do anything else.  Further, to 'follow' the input, 
I'll have to
invert the triggering edge in the handler, so it can see both rising and 
falling edges
of the 1-3 mS pulse, on 20 ms cycle.

( this could be handled by a $50 servo-controller, but wheres the fun in 
that !)

Even if following the inputs is too hard, xenomai should be able to generate
these signals.  Presuming 256 discrete pulse widths in 1-3 ms range, 
each unit-time diff
is ~ 8uS.    On my board, this is less than peak latency jitter, approx 
equal
the RMS jitter.  It will be interesting to see if the servos are 'twitchy'.


With my gpio driver in a usable state, I can focus more on the RT parts 
now :-D
Will be trolling the demos dir RSN, and probably Capt. Hannes' 
xenoamai/rtai website.
(whats that URL again ?)

>   
>> What I did so far works, and seems to hang together coherently, but
>> insofar as it
>> is the 1st time (to my knowledge) that a uniform treatment has been tried,
>> I might have painted myself / all-of-us into a corner.
>>
>> Hopefully not, but you folks have a keener perception of these things.
>> Ill send shortly.
>>
>> tia
>> jimc
>>     
>
> Jan
>
>   
thanks Jan
-jimc

