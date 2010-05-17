Message-ID: <4BF1D7CF.7040300@domain.hid>
Date: Tue, 18 May 2010 01:57:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>	
	<4BF18A00.706@domain.hid>	
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>	
	<4BF192A6.6080508@domain.hid>
	<AANLkTikwsGEOg6tDNA-ZiaX9P362egUat7lVthR1gzIU@mail.gmail.com>
In-Reply-To: <AANLkTikwsGEOg6tDNA-ZiaX9P362egUat7lVthR1gzIU@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error building userspace: "selected processor
 does not support `rsc r7, r7, #0'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Brown <jhbrown@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jeremy Brown wrote:
>>>         .syntax unified
>> That is the key: I presume this means your compiler generates syntax
>> which works both with ARM and thumb2, and rsc does not exist with
>> thumb2. Note that from a performance point of view, this may not be a win.
> 
> Ah, success --- based on your note, a colleague of mine determined
> that arranging to pass gcc the (undocumented) "-marm" flag enables the
> compiler to build the unpatched Xenomai 2.5.3 sources from beginning
> to end.  For posterity, I recompiled your example code with -O2 -marm,
> and appended it below.

Ok. Does it solve the ICE too?

-- 
					    Gilles.

