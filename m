MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18228.56053.802522.212925@domain.hid>
Date: Fri, 9 Nov 2007 23:11:01 +0100
In-Reply-To: <e4ef24880711091357n2256afa2p8aeae76018bc7993@domain.hid>
References: <e4ef24880711091329g3dd27f0ds6fe033ef79993022@domain.hid>
	<e4ef24880711091357n2256afa2p8aeae76018bc7993@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Synchronizing CLOCK_REALTIME between
	networked	computers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

Robert Gubler wrote:
 > OK, I dug through some code.  It looks like it is possible to set
 > CLOCK_REALTIME?  I tried to trace clock_settime().  There are a bunch of
 > different calls that seem to happen.  Some that get translated through
 > syscall. 

No, every call to clock_settime is translated into one system
call. That's all.

-- 


					    Gilles Chanteperdrix.

