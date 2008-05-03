From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18460.47778.279800.704316@domain.hid>
Date: Sat, 3 May 2008 21:18:58 +0200
In-Reply-To: <18459.38249.462320.715909@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
Subject: Re: [Xenomai-core] [Patch 0/7] Posix skin user-space mutexes,
	second take.
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

Gilles Chanteperdrix wrote:
 > 
 > Hi,
 > 
 > here comes a second attempt of implementing user-space mutexes for the posix
 > skin.
 > 
 > Only differences with the first implementation are explained in the following
 > mails.
 > 
 > Thanks in advance for your review.

After extensive testing, except for bugs in condition variables system
calls, the new implementation seems to work fine.

Of course, it is well known that the one who makes the test should not be
the same as the one who makes the code...

-- 


					    Gilles.

