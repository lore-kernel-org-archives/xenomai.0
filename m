Message-ID: <48AC4A2A.8080304@domain.hid>
Date: Wed, 20 Aug 2008 18:45:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>	<488A073F.1090403@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170BF3DB1DB6@domain.hid>	<48ABDA75.70901@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170E9BD4FF66@domain.hid>
	<48AC23B6.3030902@domain.hid>
In-Reply-To: <48AC23B6.3030902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BARRE Sebastien <sbarre@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> BARRE Sebastien wrote:
>> I tryed Xenomai 2.4.5 (linux 2.6.26) : The test program
>> "testTimer12_corrected" still froze the system without any kernel
>> message on the console. Then I need to reboot.
>>
>> Would it be interresting to apply one of the patches you sent me
>> before, "xeno-fix-harden-bug.diff" or
>> "ipipe-longer-atomicswitch.diff", on the 2.4.5 ? Xenomai 2.4.4 (linux
>> 2.6.25) with these two patches applied seems to work correctly...
> 
> One of the patches is the real fix and is already included in the I-pipe
> patch. The other was a quick attempt to check if we had found the real
> culprit and there is no way this patch could be merged, it was just a
> quick attempt.
> 
> Now, we have to find out why the fix we commited does not work.

Well, it looks like I screwed up. The patch which is supposed to be
included in the I-pipe patch does not seem to be.

So, could you try to apply the patch "ipipe_long_atomicswitch.diff", and
only this one, and tell us if you still get the bug ?

-- 
                                                 Gilles.

