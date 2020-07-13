Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
 <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2bca51d7-9d10-18f5-e454-88a50e4e0354@siemens.com>
Date: Mon, 13 Jul 2020 19:08:46 +0200
MIME-Version: 1.0
In-Reply-To: <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <xenomai.list@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.07.20 01:04, Robert Berger via Xenomai wrote:
> It looks like either we hit a glibc issue, or something is not clear to 
> me in the xenomai test case.
> 
> The glibc has a fallback for the unknown syscall. clock_nanosleep_time64
> 
> Is this what the xenomai testcase tries to tell us?
> 
> Than that is not an error, but fine;)
> 

If glibc is probing the existence of the new syscall by calling it, we 
may silence the warning path. To my current reading, it must have been 
triggered from a Xenomai thread in primary domain - are we sure that 
this is correct behavior? Could you set a breakpoint on glibc call and 
provide a backtrace?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

