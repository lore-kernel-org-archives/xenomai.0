Content-Type: text/plain; charset="us-ascii"
Date: Tue, 01 Jul 2008 09:45:58 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <4868E463.5080103@domain.hid>
Message-ID: <20080701074558.317840@domain.hid>
MIME-Version: 1.0
References: <20080626100340.308320@domain.hid> <20080630084032.317850@domain.hid>
	<4868E463.5080103@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with Threads and RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> > Forgot to close the socket when program finishes, this is why the
> > second run always failed. Now it works :)
> > 
> > I thought that the socket will be closed automatically when the
> > program exits, as this is the case in POSIX?! Is there a reason why
> > this is not done in RTnet?
> 
> RTDM should do it with Xenomai 2.4. Are you sure you are not using an 
> older version of the kernel-space support ?

No, I'm using Xenomai 2.4.3 without any additional patches, so there is no older version of kernel-space support installed.
-- 
von Karl Reichert


