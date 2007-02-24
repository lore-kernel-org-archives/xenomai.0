From: Paul <paul_c@domain.hid>
Date: Sat, 24 Feb 2007 00:10:56 +0000
References: <45DF7933.6090803@domain.hid>
In-Reply-To: <45DF7933.6090803@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702240010.57003.paul_c@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] [RFT] RTnet on x86_64
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: rtnet-developers <rtnet-developers@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, rtnet-users <rtnet-users@domain.hid>


Hi Jan

On Friday 23 February 2007 23:30, Jan Kiszka wrote:
> recent development on Xenomai and the underlying I-pipe patch [1]
> reached a point where real experiments on yet another architecture for
> RTnet are starting to make sense.
>
> In fact, RTnet has been enabled to build over x86_64 already two weeks
> back, including a necessary fix to the RTDM layer. I just checked again:
> it still compiles fine. 8)
>
> I'm lacking a test platform, so _you_ have the unique chance to be the
> first person running RTnet on 64 bits! Grab a 2.6.19 kernel and the
> latest I-pipe patch [2], checkout Xenomai [3] and RTnet trunk [4]. Put
> everything on some native 64-bit Linux installation and give it hell.

As you probably know, I've already committed to running tests over the weekend 
on real hardware - Not being familiar with RTnet, are there any test suites 
that can be used on say i386<->AMD64<->ppc ?

> Ah, and don't forget to report your findings!

/me is good at breaking "stuff" and reporting the results ;)


Regards, Paul.

