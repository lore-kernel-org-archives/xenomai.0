From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18350.7135.108901.491437@domain.hid>
Date: Sat, 9 Feb 2008 22:32:15 +0100
Subject: [Xenomai-core] [patch 0/4] Support for select-like services.
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


Hi,

here comes a third edition of the patchset adding support for select. 

The core support now depends on a CONFIG_XENO_OPT_SELECT option, whereas the
posix support depends on a CONFIG_XENO_OPT_POSIX_SELECT option.

The support for using rtdm_event_t and rtdm_sem_t objects is now built-in to
these objects without creating new objects types (only if
CONFIG_XENO_OPT_SELECT is enabled).

The rtdm_context_get modification, allowing to check that the caller of a service
belongs to the same process as the file descriptor it uses, is now made in
__rtdm_context_get while rtdm_context_get passes a NULL first argument to this
new service.

When implementing these modifications, a few questions arise:
- RTDM support currently depends on the CONFIG_XENO_OPT_SELECT option, should we
add an RTDM specific option ?
- in order to avoid numerous #ifdefs, and especially in drivers code, the new
callback added to device operations for binding RTDM file descriptors to
selector blocks is always there even if CONFIG_XENO_OPT_SELECT is disabled. Is
it the right thing to do ?

Regards.


-- 


					    Gilles Chanteperdrix.

