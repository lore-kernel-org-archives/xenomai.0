From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.14506.253668.653150@domain.hid>
Date: Thu, 30 Mar 2006 21:59:38 +0200
Subject: Re: [Xenomai-core] cyclictest.c
In-Reply-To: <442C24D1.2080607@domain.hid>
References: <442C24D1.2080607@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > The new testsuite program cyclictest.c breaks compilation of Xenomai on 
 > Linux 2.4 because SIGEV_THREAD_ID does not exist. Is it only suitable 
 > for Linux 2.6 (with NTPL threads)?

Fixed by revision 823.


-- 


					    Gilles Chanteperdrix.

