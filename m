Message-ID: <48B4075B.4060709@domain.hid>
Date: Tue, 26 Aug 2008 15:38:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B313B5.9050308@domain.hid>	<48B32E0C.7000105@domain.hid>	<48B33926.9060808@domain.hid>	<48B3B999.6000707@domain.hid>	<48B3BE60.4020709@domain.hid>	<48B3C1B3.2050404@domain.hid>
	<48B3C443.9000704@domain.hid>	<48B3FBBE.4050204@domain.hid>
	<48B40037.1030708@domain.hid> <48B4017A.906@domain.hid>
	<48B4029A.4070103@domain.hid> <48B405D5.2050305@domain.hid>
In-Reply-To: <48B405D5.2050305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnregistry_fetch & friends
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
> OK, this all sounds like fast-lock awareness would have to be taught
> to xnsynch first. But that would also open the chance to teach it
> that handles are stored inside the lock word, no pointers.

That could be done too... But that would be really a critical change,
with updates in all skins.

> However, that's stuff for a second round.

Ok. No problem, but keep the pitfall in mind.

> I will have to focus on getting the native skin straight. Well, maybe
> this will already
> introduce thread handles to the POSIX skin (due to common 
> __xn_sys_current)...

Please, yes, do it, avoid implementing an __xn_sys_current_bis that
would return handles instead of pointers.

-- 
                                                 Gilles.

