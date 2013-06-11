MIME-Version: 1.0
In-Reply-To: <CAMJ=MEfF8HUhDmyGAWwUToD73eUNqp_aJ5_221=RtBxd1URUeA@mail.gmail.com>
References: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
	<51AEF0A5.6010402@xenomai.org>
	<CAMJ=MEe-gaqb-wUeVPnx-9O+bL+LyCBsndrBucji5c9vqwiJDQ@mail.gmail.com>
	<51AEF87A.8060506@xenomai.org>
	<CAONLcG0x0GWn0PQN3_5S6LfUbf8fMXzRVR82Udt9=C4yHZEJhg@mail.gmail.com>
	<51AF0C0D.5060307@xenomai.org>
	<CAMJ=MEcJN=Sbtz_kw9JUKR_ckQwzMprAdYgcinZvR7SrjmetmQ@mail.gmail.com>
	<51AF120C.6070603@xenomai.org> <51AFA49A.3070604@xenomai.org>
	<CAMJ=MEfF8HUhDmyGAWwUToD73eUNqp_aJ5_221=RtBxd1URUeA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 11 Jun 2013 12:10:41 +0200
Message-ID: <CAMJ=MEfrszg=nwE8zZ1MWJGhhysRm3BZsSgJFdkADE5XSJ8e-A@mail.gmail.com>
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
> I used following test:
> ulimit -s 128 ; taskset 2 ./event_stress  -t 3 -b 80 -o 1
>
> It has run now for more than 1 hour without issues.
> I will also start a test during the weekend.
>

During the weekend I executed following test on 7 cores:
ulimit -s 128 ; taskset 0xfe ./event_stress  -t 3 -b 80 -o 1 &
(this command was executed 7 times).

No issues were observed so I think the code changes are OK.

---
Ronny
