From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17567.58763.26681.956728@domain.hid>
Date: Mon, 26 Jun 2006 15:47:55 +0200
In-Reply-To: <1151314462.6626.2.camel@domain.hid>
References: <1151314462.6626.2.camel@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Xenomai v2.2-rc3
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
 > (...) POSIX skin updates (...)

An important note about the POSIX skin updates: whereas the "pshared"
attribute was unsupported in previous releases, it is now not only
supported, but its use is mandatory if you do not want objects shared
between processes (namely mutexes, condition variables and semaphores)
to be automatically destroyed when the process that created them
terminates. Fortunately, since past versions ignored this attribute,
setting it works for both past and future versions.

-- 


					    Gilles Chanteperdrix.

