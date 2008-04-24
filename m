From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.9649.956656.531081@domain.hid>
Date: Thu, 24 Apr 2008 08:16:17 +0200
Subject: [Xenomai-core] [0/9] Posix skin user-space mutexes
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

the patch series to come for review adds support for user-space mutexes to the
posix skin. Since I wanted this support to be available on my AT91RM9200, the
patch series start with patches which are mainly for the ARM architecture, to
end with reimplementation of the kernel-space and user-space mutex services for
the posix skin.

Some patches brought some questions when making them, questions which will be
discussed in the mail accompanying the patch.

Since I do not use quilt, some patches will inevitably mix several
modifications, especially the patch to ksrc/skins/posix/syscall.c. I promise,
next time I will use quilt.

The result has only be tested in the fast (no syscall) case, to evaluate its
performance, I will start tests trying to cover the syscall case now, and keep
you informed.

Thanks in advance for your review.

-- 


					    Gilles.

