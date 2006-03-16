MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17433.32628.931757.165635@domain.hid>
Date: Thu, 16 Mar 2006 16:08:36 +0100
In-Reply-To: <44195924.9090709@domain.hid>
References: <44195924.9090709@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: POSIX include problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi Gilles,
 > 
 > don't know yet what's going wrong, but the following demo code doesn't
 > compile against the POSIX skin due to unresolved SIG_BLOCK:
 > 
 > #include <pthread.h>
 > #include <signal.h>
 > 
 > int main()
 > {
 >         return SIG_BLOCK;
 > }
 > 
 > Comment out the pthread include, and it will work again. Any ideas?

Maybe pthread.h includes signal.h for a side effect, in such a case, you
should #include_next <signal.h> twice in Xeno signal.h

-- 


					    Gilles Chanteperdrix.

