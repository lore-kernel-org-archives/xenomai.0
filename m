Message-Id: <s5e1d71e.043@domain.hid>
Date: Sun, 25 Feb 2007 18:35:41 +0100
From: "Marc LE DOUARAIN" <m.ledouarain@domain.hid>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20Re:=20[Xenomai-core]=20rtdm,=20rtc?=
	=?ISO-8859-1?Q?=20and=20printk=20driver.?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 23/02/07 15:55
>>>

>>>>> Jan Kiszka <jan.kiszka@domain.hid> 23.02 14:47 >>>
>>>Nicolas BLANCHARD wrote:
>>> Hello,
>>>  
>>> I've write a little rtdm driver to r/w RealTimeClock on rtc146818
>>> chipset.
>>
>>/me not having done much with rtc (hmm, a lot of years back on PCs, I
>>think): can this chip be found in normal PC hardware? Or is it only
on
>>specific embedded boards? (Means: can I actually play with your
driver? :) )
 
>Motorola 146818 circuit is a 6800 peripheral CMOS device,
>it's often used with processors 6800 and 8085.
>I think it's used on a lot of x86 board.

First nice work Nicolas ! (he is my coworker)
Time usage for us is really important in our field activity, and more
important without too much drift. And this real-time driver let us to
have direct access to the RTC values instead of the Linux system one
that generally drift a lot per day...(it was already the same problem
under RTLinux) And without a secondary mode switch...

Nowadays, you will generally not find directly a 146818 chip or
compatible (like the Dallas ones). Many CPUs (for example the SIS
Vortex86 we use on our embedded cards) have integrated in themself, on a
single chip, many antique PC peripherals like this RTC compatible
146818, a 8254 system timer, the dual 8259 interrupt controller. Also
sometimes the serials 16550 UART are included !!!

So yes, for sure on many computers you will be able to use it !


>>> I also use this driver to write kernel message from user-space
>>> (printk).
>>>  
>>> In attachment you can find an archive with the driver and an example
of
>>> use (just code).
>>> to compil, you must change kernel sources directory
(KERNELSOURCEDIR
>> flag).
>>>  
>>> It Based on code of Jan Kiszka found in http://www.captain.at/ 
>>>  
>>> I hope it could be interesting.
>>> All feedback are welcome.
>>>  
>>
>>You will get it. Thanks for sharing your code!
>>

It seems normal to us to share some possible usefull stuff like this
one, keeping the free software spirit!




