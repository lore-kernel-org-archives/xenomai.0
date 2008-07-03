Message-ID: <486CF261.5010804@domain.hid>
Date: Thu, 03 Jul 2008 17:38:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <486CE4C5.8050309@domain.hid> <486CEF87.6060504@domain.hid>
	<486CF1C5.9020704@domain.hid>
In-Reply-To: <486CF1C5.9020704@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Michael Galea wrote:
>>> I wonder if someone can suggest an approach to the following problem.
>>>
>>> We need to use xenomai to manage devices on the mii bus.  The mii bus 
>>> has PHYs managed by linux. What is the best way of providing access to 
>>> both linux and xenomai?
>>>
>>> I know that before xenomai "loads", I can simply access the mii bus from 
>>> linux.  But after xenomai loads, is the right answer to make the linux 
>>> function that reads the phy migrate into the xenomai domain and contend 
>>> for the bus there?
>> What protects this access to the bus, is this a mutex or a spinlock ? If 
>> a spinlock, then simply make it an ipipe_spinlock, it will provide 
>> mutual exclusion between all domains.
>>
> 
> It's a spinlock_bh, but you can't tell actually, since there is a callback
> mechanism to perform the actual read depending on the bus implementation.
> Additionally, genphy_read may trigger an update from the link status and so on.
> I'm afraid this kind of sport may well resemble playing Russian roulette with a
> fully loaded gun. This said, if all executed code paths can be identified and
> fixed, why not (having fun).

I was talking about the actual implementation by the hardware driver, 
not the generic part. This probably depends on the driver.


-- 
                                                  Gilles.

