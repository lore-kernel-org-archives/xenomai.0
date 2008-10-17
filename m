Message-ID: <48F884EE.2030801@domain.hid>
Date: Fri, 17 Oct 2008 14:28:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>
In-Reply-To: <20081016154620.320953568@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 00/12] Generic fast xnsynch support & more
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
> Here comes a significantly reworked patch series to improve fast mutex
> support of Xenomai.
> 
> This approach now introduces a generic fast xnsynch core and converts
> the existing POSIX implementation over. It also comes with a second
> user, the Native skin. Additionally, it improves xeno_get_current via
> a TLS variable and addresses the issue that threads in secondary mode
> acquiring an uncontended mutex need to be migrated first.
> 
> At this chance, the TLS optimization is also applied on self-lookups of
> task handles (Native, VRTX and VxWorks). And I included my
> SMP-by-default patch for user libs which is highly recommended to reduce
> the risk of accidental code breakage on SMP with the new mutex code.

A minor remark. This is the third round of patches for fast mutexes, and
 each round, you submit even more changes to review than the previous
round. If I doubted of your honesty, I could think that you are trying
to dilute some questionable changes into more changes so that they get
unnoticed.

Could we focus on a small set of changes, reach consensus, merge them,
and then move to the next set of changes?

-- 
                                                 Gilles.

