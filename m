Message-ID: <486CF3AB.6050103@domain.hid>
Date: Thu, 03 Jul 2008 17:43:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <486CE4C5.8050309@domain.hid> <486CEF87.6060504@domain.hid>
	<486CF31B.2040100@domain.hid>
In-Reply-To: <486CF31B.2040100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How can I make Xenomai share a mii bus with the
 kernel?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> Gilles Chanteperdrix wrote:
>> Michael Galea wrote:
>>> I wonder if someone can suggest an approach to the following problem.
>>>
>>> We need to use xenomai to manage devices on the mii bus.  The mii bus 
>>> has PHYs managed by linux. What is the best way of providing access to 
>>> both linux and xenomai?
>>>
>>> I know that before xenomai "loads", I can simply access the mii bus 
>>> from linux.  But after xenomai loads, is the right answer to make the 
>>> linux function that reads the phy migrate into the xenomai domain and 
>>> contend for the bus there?
>> What protects this access to the bus, is this a mutex or a spinlock ? If 
>> a spinlock, then simply make it an ipipe_spinlock, it will provide 
>> mutual exclusion between all domains.
>>
>> I do not think it can be a mutex anyway, since it may certainly possible 
>> for a driver to have a function that reads the mii status in a timer 
>> handler to maintain the IFF_RUNNING bit state of the ethernet interface.
>>
> Thanks, access to the bus is provided by a spinlock in 
> drivers/net/phy/phy.c, so I will try ipipe_spinlock (when I get hardware 
> :-)).
> 
> I assume that I can make it an ipipe_spinlock and use that from linux 
> even before xenomai is loaded.

No, this is not the spinlock I am talking about. I am talking about the 
spinlock (if it exists) used by the driver's mii read method.

-- 
                                                  Gilles.

