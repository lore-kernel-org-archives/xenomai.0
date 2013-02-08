Message-ID: <5114C05B.7040507@hilscher.com>
Date: Fri, 08 Feb 2013 10:07:39 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIExPUw==?= <slos@hilscher.com>
MIME-Version: 1.0
References: <5113BFD0.7050501@hilscher.com> <5113D225.8030900@xenomai.org>
In-Reply-To: <5113D225.8030900@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 07/02/2013 17:11, Gilles Chanteperdrix a écrit :
> On 02/07/2013 03:53 PM, Stéphane LOS wrote:
>
>> Hello Sirs,
>>
>> Hilscher is offering a Linux driver based on UIO for cifX boards.
>>
>> In my understanding, down to 1ms cycle time, a PREEMPT RT solution
>> should be enough.
>>
>> The cifX boards can manage with bus cycle times down to 250µs like with
>> EtherCAT or Sercos III firmwares.
>>
>> So it seems in that cases that using Xenomai would be the way to go.
>> I suppose that it would be needed to modify or change the existing
>> driver but I can't figure out how things (Xenomai / RTDM / UIO) fit
>> together.
>>
>> UIO is the kernel module that allows the mapping of the board memory to
>> user space.
>>
>> The cifX driver uses the libpciaccess to pick up the board and retrieve
>> some board information from UIO before the mapping.
>> Then it uses pthread and rt functions when accessing the board.
>>
>> Since UIO and libpciaccess are only used during the initialization, is
>> it a problem for a Xenomai application ?
>>
>> We have setup a Xenomai system and tried to compile the user land
>> library with Xenomai options and flags and it seems we have been successful.
>> The driver should be using the POSIX skin of Xenomai if we have been lucky.
>>
>> I can't see why we would need RTDM. Any hint please ?
>>
>> I am an absolute beginner in the Xenomai arena, don't throw me to the
>> lions...
>>
>
> If UIO is used to register an interrupt handler for instance, the
> interrupt handler will not be called in real-time context when used with
> Xenomai, so, you would have to use the (deprecated) native or posix skin
> services to register a user-space interrupt handler, or more likely
> write an RTDM driver. On the other hand, if what you need is simply
> accessing the board registers through MMIO, then you do not need RTDM.
>
> While accessing registers from user-space may be tempting, there is a
> risk of ending up with an application where the driver code is not
> clearly separated. Writing a driver separated from the application is
> preferable, as it provides a sane isolation between the two. If you
> change the hardware, you just have to rewrite a driver which follows the
> same profile, if you want to write another application using the same
> driver, you can keep the driver.
>

Thank you for your kind support Gilles.

The cifX Device Driver is Hilscher's library to deal with cifX boards 
and is available for the major OSes.
Additionally it is available to anybody as source code, the cifX Driver 
Toolkit when one has to create a driver for his own OS.

This driver library accesses the board interface which is a Dual Port 
Memory.

So the user application shall use this layer and gets independence from 
the target OS.

I understand that we should create an RTDM driver instead of a UIO 
driver and adapt the user library so that it uses the RTDM driver.

Am I right ?

I have seen also the Xenomai Solo project and the upcoming Xenomai 3 
that would be using vanilla kernel with PREEMPT RT.

When this happens, would our RTDM based cifX driver still be an option 
or would the UIO based driver suffice ?

Best Regards,
Cordialement,

Stéphane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35ème Régiment d'Aviation
Miniparc du Chêne
69500 BRON
France
Tél. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


