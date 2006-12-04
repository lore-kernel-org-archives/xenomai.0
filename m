Message-ID: <4573E056.8070201@domain.hid>
Date: Mon, 04 Dec 2006 09:46:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] libnative versioning
References: <45704CAB.5060502@domain.hid> <1164992204.4952.109.camel@domain.hid>	
	<45706A0E.9050400@domain.hid> <1164996055.4952.141.camel@domain.hid>
In-Reply-To: <1164996055.4952.141.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> There is one for the nucleus already, so maybe we could extend the
> feature. This said, the point ABI revs is basically to detect potential
> mismatches; would an old POSIX app run improperly over the new library,
> or would it choke at startup?

The mismatch would occur if running the new library with an old kernel
or an old library with a new kernel, the pthread_cond_wait and
pthread_cond_timedwait syscalls have been replaced with
pthread_cond_wait_prologue/pthread_cond_wait_epilogue.

-- 
                                                 Gilles Chanteperdrix

