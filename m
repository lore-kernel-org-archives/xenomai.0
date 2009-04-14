Message-ID: <49E4B8B1.5020907@domain.hid>
Date: Tue, 14 Apr 2009 18:24:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49E4B5CC.1050902@domain.hid>
In-Reply-To: <49E4B5CC.1050902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] posix: Avoid double declarations
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
> Please pull from git://git.xenomai.org/xenomai-jki.git for-upstream
> and run bootstrap.
> 
> ---------->
> 
> Recent glibc versions come with support for
> pthread_mutexattr_get/setprotocol and pthread_condattr_get/setclock.
> Make sure we don't declare those prototypes in Xenomai's pthread.h a
> second time as this can cause g++ warnings and even errors.

You need to declare the __real variants too, as well as the wrappers.

-- 
                                                 Gilles.

