MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17548.3547.509492.233932@domain.hid>
Date: Sun, 11 Jun 2006 14:34:35 +0200
Subject: Re: [Xenomai-core] [PATCH] Add fptest for powerpc
In-Reply-To: <448B3001.9020502@domain.hid>
References: <448AF791.8080707@domain.hid>
	<17547.1818.52887.185464@domain.hid>
	<448B3001.9020502@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > > Task 0 is the "idle" taks, an ordinary Linux task
 > > Task 10 is of type "rtup_ufpp" here, which means that it is a real-time
 > > task in primary mode using the FPU in primary mode.
 > 
 > I probably don't have time for debugging for some days now, but if any 
 > of the code goes through sigreturn path, it might be a kernel bug that's 
 > fixed in 2.6.16.

Anyway, the patch is applied, thanks.

-- 


					    Gilles Chanteperdrix.

