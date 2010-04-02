Message-ID: <4BB5BA2D.1080604@domain.hid>
Date: Fri, 02 Apr 2010 11:34:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>	
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>	
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>	
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
In-Reply-To: <k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Henri Roosen wrote:
> Ok, I might give Jan's proposal a try and could be sufficient for us:a
> Xenomai thread with non-RT scheduling class (didn't know that was
> possible).
> 
> We just need the thread in the Xenomai domain for being able to access
> Xenomai resources, but want it to be scheduled together with the Linux
> nice levels. A near IDLE nice level should be ok. We just don't want
> that our Xenomai 'idle' thread with a while(1) would prevent Linux to
> run.

That will happen with SCHED_OTHER if while(1) occurs while running in
primary mode.

-- 
					    Gilles.

