Message-ID: <44047837.7050500@domain.hid>
Date: Tue, 28 Feb 2006 17:20:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C029ACE2.257E%steve@domain.hid>
In-Reply-To: <C029ACE2.257E%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Steven Seeger wrote:
> Right, so if a thread is suspended voluntarily it should just ignore the
> clock tick.

Precisely not, it should be aware that time keeps advancing regardless of its own 
status, suspended or not.

  I think I will read more about RTOSs and see if I change my
> mind, but for now I think that this is a poor design on our part. However,
> xenomai is what I fought hard to use for these projects, so I guess I'll
> have to stick with it. :)
> 
> Steven
> 
> On 2/28/06 7:29 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
> 
> 
>>Because set_periodic/wait_period are about defining a series of absolute dates
>>forming a continuous timeline, the fact that a thread goes suspending instead
>>of 
>>waiting for the next work cycle does not change the fact that the clock is
>>still 
>>ticking.
> 
> 
> 


-- 

Philippe.

