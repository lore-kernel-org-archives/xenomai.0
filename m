Message-Id: <3FAF043F-FCDB-4DE4-8068-53561B8E329B@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B8F602.9090808@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 12 Mar 2009 07:50:59 -0400
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>	<49B8EE0A.3050708@domain.hid>
	<E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
	<49B8F602.9090808@domain.hid>
Subject: Re: [Xenomai-core] rtdm timer questions
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

> Not explicitly specified, but the existing timer will be stopped first
> and then newly started.

I should see if we are doing that, then. We are loading bytes into a  
buffer and calling start if we need to call it. Perhaps the logic is  
incorrect.

> "...start ... in 2 ms" sounds a bit like TIMERMODE_RELATIVE, no? :)

Yes I made this same mistake when I first wrote the driver. The  
version we are having issues with does say RELATIVE. I am still  
adjusting to a new time zone, so I use that as my excuse. :)

Steven

