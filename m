Message-ID: <4E8AED21.7010709@domain.hid>
Date: Tue, 04 Oct 2011 13:25:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E8981F9.9090105@domain.hid> <4E89AA0F.8020104@domain.hid>
	<4E89D5E7.8050106@domain.hid>
In-Reply-To: <4E89D5E7.8050106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SIGILL when calling pthread_cleanup_push()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Bernhard <michael.bernhard@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/03/2011 05:33 PM, Gilles Chanteperdrix wrote:
> On 10/03/2011 02:26 PM, Gilles Chanteperdrix wrote:
>> On 10/03/2011 11:35 AM, Michael Bernhard wrote:
>>> Hi
>>>
>>> We are using Xenomai-2.5.6 together with Linux-2.6.35 on a PXA270 
>>> processor. Xenomai works fine so far. However we get SIGILL when using 
>>> pthread_cleanup_push() in a RT-thread. I now tried the same over 
>>> Xenomai-2.6 and the behavior is still the same.
>>>
>>> Here's a simple example which shows the problem (for Xenomai-2.6):
>>
>> Ok. Thanks for testing xenomai 2.6 by the way. I will try the test
>> program on an ARMv5 I have tonight. However, could you tell us a bit
>> more about your setup? What toolchain do you use? What threading library?
> 
> And also: is your libc built with iwmmxt support?
> 

Hi Michael,

I can not reproduce this issue on another armv5 I have, but it does not
support iwmmxt. So, in order to see if the problem you have comes from
iwmmxt, you should try and build a root filesystem with a soft-float
toolchain, such as, for instance, the codesourcery toolchain.

Currently, iwmmxt floats are not supported with Xenomai, so, if you want
to get them working, something will have to be done.

Regards.

-- 
                                                                Gilles.

