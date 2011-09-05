Message-ID: <4E65075C.4060502@domain.hid>
Date: Mon, 05 Sep 2011 19:31:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E63E503.8090206@domain.hid>
	<CANKLDmvQ-q6nBXSRWs_R4RC_c7kmzM0tMmFbCBw59cbyPdSyzA@mail.gmail.com>
In-Reply-To: <CANKLDmvQ-q6nBXSRWs_R4RC_c7kmzM0tMmFbCBw59cbyPdSyzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai 2.6.0-rc1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

On 09/05/2011 07:14 PM, Henri Roosen wrote:
> Hi Gilles,
> 
> Unfortunately I didn't find the time to test this release yet. I'm
> just wondering if there is a fix for this problem in the 2.6.0
> release: https://mail.gna.org/public/xenomai-core/2011-05/msg00028.html

This one is fixed, a bit differently, since we fixed the ppd handling so
that the ppd is valid up to the end of a process.

> 
> We are using the auto-relax patches on top of 2.5.6 for a long time
> now. We found issues with it regarding auto-relax tasks that were not
> being auto-relaxed anymore. Philippe made patches for that, see
> https://mail.gna.org/public/xenomai-help/2011-03/msg00161.html.

Philippe's patches for rt_task_send/receive/reply should have been
merged too.

> However, locally I reverted those two patches because these introduced
> a memory leak in xnheap; I could only do rt_task_create()
> rt_task_delete() for 1024 times ;-). I thought that was the discussion
> of
> https://mail.gna.org/public/xenomai-core/2011-05/msg00028.html at that
> time and I don't recall a proper fix for it was provided. But I might
> have missed it...

This looks related to the ppd issue as well, in which case, it should
have been fixed too.

It would be nice if you could test the release and tell us whether you
still have these issues.


-- 
                                                                Gilles.

