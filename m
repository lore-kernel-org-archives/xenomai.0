From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 13:37:07 -0500
References: <200706071049.32906.ngustavson@domain.hid>
	<200706071311.09891.ngustavson@domain.hid>
	<46684CCB.8010806@domain.hid>
In-Reply-To: <46684CCB.8010806@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071337.07691.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot allocate
	memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> > Write does stop throwing errors with a pool of 16384.
>
> Just repeating for confirmation: rt_pipe_create with smaller, but
> non-zero pool sizes doesn't report some error? 
Incorrect, if it's created with smaller it does report an error. If it's 
created with 0 however, it seems ok. (at least it doesn't throw an error)

> Pipes are asymmetric: RT<->NRT only.
RT<->NRT is my goal.
essentially I 
1. spawn off a real time task which creates a  pipe to receive commands
2. throw commands at it from the user space thread which spawned the real time 
process (which is still NRT correct? I'm fuzzy on this).

NZG

