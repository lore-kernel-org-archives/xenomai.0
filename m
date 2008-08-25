Message-ID: <48B2A0A3.5030308@domain.hid>
Date: Mon, 25 Aug 2008 14:08:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B2994A.1050708@domain.hid>
In-Reply-To: <48B2994A.1050708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Native skin: user space handles sharable between
 processes?
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
> Hi,
> 
> what is the policy for the user space handles the native skin generates:
> Can the user share them between processes via putting them into shared
> memory (like it is allowed for some POSIX objects)?
> 
> I'm wondering if I have to use the POSIX pattern to resolve the address
> of a fast mutex: If shared, look to global heap, otherwise use
> process-local heap.

The posix skin does only this only the first time. If the address is
local, it is computed and stored locally and never recomputed again.

-- 
                                                 Gilles.

