Message-ID: <49076E08.5060708@domain.hid>
Date: Tue, 28 Oct 2008 20:54:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] llimd.
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
Cc: Xenomai core <Xenomai-core@domain.hid>


Hi Jan,

I see that the implementation of rthal_llmulshft seems to account for
the first argument sign. Does it work ? Namely, in the generic
implementation will __rthal_u96shift propagate the sign bit ?

If yes, do you see a way llimd could be made to work the same way ? This
way we would avoid inline ullimd twice in llimd code.

Regards.

-- 
					    Gilles.

