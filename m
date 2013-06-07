MIME-Version: 1.0
In-Reply-To: <51AFA49A.3070604@xenomai.org>
References: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
	<51AEF0A5.6010402@xenomai.org>
	<CAMJ=MEe-gaqb-wUeVPnx-9O+bL+LyCBsndrBucji5c9vqwiJDQ@mail.gmail.com>
	<51AEF87A.8060506@xenomai.org>
	<CAONLcG0x0GWn0PQN3_5S6LfUbf8fMXzRVR82Udt9=C4yHZEJhg@mail.gmail.com>
	<51AF0C0D.5060307@xenomai.org>
	<CAMJ=MEcJN=Sbtz_kw9JUKR_ckQwzMprAdYgcinZvR7SrjmetmQ@mail.gmail.com>
	<51AF120C.6070603@xenomai.org> <51AFA49A.3070604@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 7 Jun 2013 12:39:35 +0200
Message-ID: <CAMJ=MEfF8HUhDmyGAWwUToD73eUNqp_aJ5_221=RtBxd1URUeA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [xenomai-forge] psos: crash while stressing event
	timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

>
>
>>
> Please pull the last 6 commits from the "next" branch, referring to the
> pSOS emulator and copperplate libraries. These fixes make the test case you
> sent me stable, including on a 8-way machine running 50 batches. Feedback
> welcome.
>
> Thanks for the heads up on this issue, and for the test case as well.
>
>
>
Philippe,

I did some testing with your patches applied. The system looks very stable.
Thanks for solving the issue.

I used following test:
ulimit -s 128 ; taskset 2 ./event_stress  -t 3 -b 80 -o 1

It has run now for more than 1 hour without issues.
I will also start a test during the weekend.

Best regards,
Ronny
