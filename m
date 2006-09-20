Subject: Re: [Xenomai-help] Xenomai v2.2.3
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451153D5.2080200@domain.hid>
References: <1158564530.5020.5.camel@domain.hid> <450F1686.3010304@domain.hid>
	<451068AD.6080000@domain.hid> <1158744278.5544.42.camel@domain.hid>
	<451153D5.2080200@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 17:22:08 +0200
Message-Id: <1158765729.5043.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-20 at 09:44 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-09-19 at 17:01 -0500, Jeff Webb wrote:
> >> Jeff Webb wrote:
> >>> Philippe Gerum wrote:
> >>>> Here is the third maintenance release for the v2.2.x branch.
> >>>> ...
> >>> This release works fine on my 2.6 kernel x86 machine, with the exception 
> >>> of the FPU problems noted elsewhere.
> >>>
> >>> I have the following problems with my 2.4 kernel x86 machine:
> >>>  * The latency and switchtest test programs yield segmentation faults.
> >>>  * My own user-space test programs seg fault.
> >>>
> >>> Things that work:
> >>>  * The kernel boots and runs fine.
> >>>  * xeno_native, _posix, _rtai all insert and remove without problems.
> >>>  * Some simple kernel module test programs work fine.
> >>>
> >>> I am using the same config as I was for 2.2.2 (which worked fine), but I 
> >>> am running a slightly newer kernel version (2.4.33.3 as opposed to 2.4.32).
> >> I was able to build a working xenomai-2.2.3 by using linux-2.4.32 and adeos-ipipe-2.4.32-i386-1.2-07.patch.  The latency and switchtest programs seem to work now.  My problematic build used linux-2.4.33.3 and the adeos-ipipe-2.4.33-i386-1.3-00.patch.  I used the same kernel config for both builds.  
> >>
> >> So, does this mean the problem is with the ipipe patch?
> >>
> > 
> > The problem also occurs with older patches, and it looks like extremely
> > volatile, depending on various parameters, including the CPU
> > generation/brand, so I tend to think that this issue is not directly
> > related to the recent Adeos changes, but might trigger more easily with
> > the latest patch on your box. Could you try the following patch against
> > vanilla 2.2.3, on all your failing configs so far, and let us know of
> > the outcome? TIA,
> 
> Sorry for not being more clear.  This appears to be a separate problem from the FPU issue.  At least the symptoms are different...  I have only seen this problem on my xenomai-2.2.3/linux-2.4.33.3 (ipipe-1.3) build.  The symptom is that xeno-load gives a segmentation fault in the latency program (switchtest suffers the exact same problem).  A couple of my own userspace RT test programs seg fault as well.  Look at the latency output near the bottom of my original email to see what I mean:
> 
>   https://mail.gna.org/public/xenomai-help/2006-09/msg00152.html
> 
> Switching to xenomai-2.2.3/linux-2.4.32 (ipipe-1.2) fixed this problem.
> Do you agree that this appears to be a different bug?

Ah, ok. Yes, clearly, this sounds different.

>   Sorry for the confusion... I am trying to debug two or three different problems at the same time. 
> Maybe I should have waited until the FPU bug was solved to report this.

No problem, I mistakenly made the connection between both issues. I'm
going to fire up a test box with 2.4.33.3 over Adeos 1-3.00 + v2.2.3 and
see what happens. More later.

> 
> I have not experienced the FPU-related switchtest error on my 2.4 machine.
> My 2.6 machine exhibits the problem, so I will certainly test your patch on that machine to see the effect.
> 

TIA,

> Thanks!
> 
> -Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



