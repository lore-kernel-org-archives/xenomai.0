Message-ID: <4BCB3EE7.8040801@domain.hid>
Date: Sun, 18 Apr 2010 19:18:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
	<ef0950a3fd1a8df178c2cf683187895ec74c45b7.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <ef0950a3fd1a8df178c2cf683187895ec74c45b7.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 23/24] RTDM: Early fd release with
 poll-free context reference tracking
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <"Jan Kiszka jan.kiszka"@web.de>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@domain.hid>
> 
> Two changes in one as they are tightly related: Once close is called,
> remove the file descriptor from open table, allowing its reuse while
> close for the previous user proceeds.
> 
> The second and major part of the patch avoids time-based polling while
> waiting for context references to be dropped. This specifically helps in
> scenarios where references can be held for a longer time beyond the
> first close.

A few set_bit and clear_bit with an xnlock locked. Could not these been
replaced with __set_bit/__clear_bit in UP?

-- 
					    Gilles.

