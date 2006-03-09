From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17424.29105.766869.638173@domain.hid>
Date: Thu, 9 Mar 2006 19:19:29 +0100
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
In-Reply-To: <44106DA5.5070405@domain.hid>
References: <006f01c64312$a28ab730$a10a10ac@domain.hid>
	<44106DA5.5070405@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
 > (snip)
 > Since my mind is on POSIX...  Is there a way to set up an RT_PIPE
 > such that I could use fprintf from a real-time thread, or maybe even
 > redirect the standard output so I could use printf from real-time?
 > This would greatly ease the porting of non-rt code to xenomai.  Maybe
 > this idea is impossible or I'm very naive in my thinking.

You can use a POSIX message queue for that purpose, the producer working
exclusively in primary mode, and the consumer oscillating between
primary mode when pending on the queue, and secondary mode when issuing
the calls to fprintf. It is a bit what the "satch" example does, except
that the producer runs in kernel-space.

-- 


					    Gilles Chanteperdrix.

