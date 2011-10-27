Message-ID: <4EA9B774.1020401@domain.hid>
Date: Thu, 27 Oct 2011 21:56:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ba98230140e2190e763c418428e3198d.squirrel@domain.hid>
In-Reply-To: <ba98230140e2190e763c418428e3198d.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 10/27/2011 11:05 AM, Gilles Chanteperdrix wrote:
> 
> 
> Robert wrote:
>> Ok, so now latency test looks good, but board still hangs up on xeno-test.
>>
> 
> Please try, as I suggested in a previous mail, to get the kernel console
> output on the serial port, and see if the hang is not due to a kernel
> oops.
> 
> And I am also asking again: are you compiling user-space support for thumb?
> 

Hi Robert,

I tried the same configuration as you. As expected, the bug is a oops,
and the serial console helped. The problem is CONFIG_CC_STACKPROTECTOR,
it is currently not implemented for xenomai on ARM.

This configuration will cause a compilation error in the next release.

Regards.

-- 
                                                                Gilles.

