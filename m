MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17553.19318.594505.328322@domain.hid>
Date: Thu, 15 Jun 2006 13:58:46 +0200
In-Reply-To: <44912ABF.1040300@domain.hid>
References: <44912ABF.1040300@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: gcc-4.1 warnings in switchtest
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Hi Gilles,
 > 
 > I'm seeing this with gcc-4.1:
 > 
 > src/testsuite/switchtest/switch.c: In function 'main':
 > src/testsuite/switchtest/switch.c:620: warning: 'params.swt.flags' is
 > used uninitialized in this function
 > src/testsuite/switchtest/switch.c:620: warning: 'params.swt.index' is
 > used uninitialized in this function
 > src/testsuite/switchtest/switch.c:620: warning: 'params.thread' is used
 > uninitialized in this function
 > 
 > Real issues or just finickiness?

No, the compiler is right, but it has no consequence, the values of the
swt structure are overriden by an ioctl later on. Anyway, I can set all
this to zero to please the compiler.

-- 


					    Gilles Chanteperdrix.

