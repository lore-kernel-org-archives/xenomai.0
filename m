Message-ID: <53FFADFD.7030407@nta-inc.net>
Date: Thu, 28 Aug 2014 17:32:29 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <53FE1832.7080808@nta-inc.net> <53FF292E.2010507@xenomai.org>
In-Reply-To: <53FF292E.2010507@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3: RTDM with Mercury?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 08/28/2014 08:05 AM, Philippe Gerum wrote:
> On 08/27/2014 07:41 PM, Jeff Webb wrote:
>>  From the recent traffic on the mailing list, and the website makeover,
>> it sounds like Xenomai 3 is close to maturity, so I am trying to become
>> familiar with the new technology.  I am very interested in the idea of
>> having one code base that can be used in Linux, PREEMPT-RT, and
>> dual-kernel applications.  Even with Xenomai 2, I have moved close to
>> this goal by using the POSIX skin and using compiler directives to build
>> my code as a standard linux application, or a real-time Xenomai version.
>>
>> The main thing I am missing now is a unified interface to hardware
>> devices, and it sounds like Xenomai 3 might be able to provide that.
>>  From the introduction on the web site (
>> http://xenomai.org/introducing-xenomai-3/ ), it sounds like I should be
>> able to use RTDM drivers with the standard linux kernel through the
>> Mercury core.  How does this work?  Figure 3 shows a "native RTDM"
>> block.  Is this block a kernel module that translates RTDM-specific
>> calls into standard linux calls?
>
> Yes, basically.
>
>    Does the translation happen at compile
>> time or run-time?
>
> Compile-time.
>
>    Is there documentation on how I can write an RTDM
>> driver that will work with both the Cobalt and Mercury cores?
>
> Not yet, but the rule of thumb is to avoid the legacy
> RTDM_EXECUTE_ATOMICALLY() construct (or the newest
> cobalt_atomic_enter/leave the same way) to keep compatibility.
>
> rtdm_waitqueues have been introduced to support the patterns where
> RTDM_EXECUTE_ATOMICALLY() was usually involved in.
> This is discussed at
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Driver_API
>
>    For
>> starters, can I access the 16550 RTDM driver from mercury?
>>
>
> 16550 should be mercury-ready, I don't see any non-portable pattern in
> this code. But I never tried it in a single kernel configuration, see below.
>
>> I apologize if all of this is documented, and I've just missed it.  I
>> also realize that Xenomai 3 is a work in progress and you haven't gotten
>> to everything yet.  The documentation you have is very good, and I
>> appreciate all the work you have put into it.
>>
>
> Thanks. Regarding RTDM over Mercury, Wolfgang (Grandegger) published a
> proof-of-concept implementation which dates back to 2008 or so, but
> since we never received any feedback, I'm assuming that the current user
> base of this code is either small, reserved or terribly shy.
>
> In any case, it has not been reworked over Xenomai 3 yet, at the very
> least for supporting the latest RTDM API changes/features. However, this
> is certainly high on the todo list now, as we direly need this component
> to close the loop.
>

Thanks, Philippe.  That explanation clears things up.  I think Xenomai is headed in a great direction.

-Jeff


