MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.3213.277969.291800@domain.hid>
Date: Sun, 3 Feb 2008 19:48:45 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768AE@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768AD@slcmail.slc.mew.int>
	<18342.2341.145336.903743@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3768AE@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] periodic task question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
 > This is the relevant code. In aperiodic mode, it works fine. In periodic
 > mode (125us timebase) then when I activate this task by sending data to
 > /dev/dsp the sound plays very fast and then the watchdog kills the
 > thread. If I change this to set the period only after rt_cond_wait()
 > returns, it works fine.

Please send a self-contained test, that we can compile and run on our
boxes to observe the behaviour that you are observing.

-- 


					    Gilles Chanteperdrix.

