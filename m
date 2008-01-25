From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18330.24340.328727.760936@domain.hid>
Date: Fri, 25 Jan 2008 23:13:40 +0100
Subject: [Xenomai-core] [PATCH 0/4] Support for select-like services.
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

the following patchset adds core support to Xenomai for select-like
services, modifies the rtdm skin to allow running easily these services
for rtdm file descriptors and implement the select service for the posix
skin. select is an important service on low-end platform where it allows
more efficient implementation of network server than with a threaded
approach.


It was only compile-tested for now, and will be tested around next week,
so is submitted here for review only.

Regards.

-- 


					    Gilles Chanteperdrix.

