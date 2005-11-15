Message-ID: <437996A2.1090808@domain.hid>
Date: Tue, 15 Nov 2005 09:04:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
	<4378CBA6.6000708@domain.hid>
	<200511141933.26292.dmitry.adamushko@domain.hid>
In-Reply-To: <200511141933.26292.dmitry.adamushko@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> On Monday 14 November 2005 18:38, Philippe Gerum wrote:
> 
>>xenomai@xenomai.org
> 
> 
>>>If you want to have some fun (and you have some time and desire for 
>>>that) then go ahead :) Otherwise, no problem, I'll do that.
>>>
>>
>>Please make sure to implement this at the nucleus level, and if using a 
>>bitmap to locate free/busy slots, it should be large enough to handle 
>>FDSETSIZE  channels, not BITS_PER_LONG.
> 
> 
> We have xnpipe_states[XNPIPE_DEVS] array of pipe objects. Choosing a minor 
> value is about choosing a free slot (minor == id of that slot) so there are 
> XNPIPE_DEVS possible values. The bitmap must contain at least XNPIPE_DEVS 
> bits. I don't understand what FDSETSIZE has to do here (if you mean the one 
> that is used to configure select() behaviour).

The point is about not being limited to the number of bits in a long, because I 
know of configurations with more than 32 active channels. IOW,
#define XNPIPE_DEVS FDSETSIZE should be possible.

> 
> 
>>-- 
>>
>>Philippe.
> 
> 
> ---
> 
> Dmitry
> 


-- 

Philippe.

