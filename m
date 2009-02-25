Message-ID: <49A51C3D.1020705@domain.hid>
Date: Wed, 25 Feb 2009 11:23:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>	<49A4209F.60502@domain.hid>
	<a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
In-Reply-To: <a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] blackfin: build xenomai in FLAT format
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yi li <liyi.dev@domain.hid>
Cc: Xenomai-core@domain.hid

yi li wrote:
> On Wed, Feb 25, 2009 at 12:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> 2.  libpthread_rt.la should not depend on "lpthread".
>>>
>> Nak. In flat mode, turning the link dependencies order upside down will not buy
>> us anything. Two-phase link is the only way to prevent circular/invalid
>> dependencies with a static only format when symbol wrapping is involved.
>>
> 
> Agree. But "libpthread_rt_la_LDFLAGS" should not include "-lpthread",
> otherwise libtool will think libpthread_rt.a depends on libpthread.
> I don't think there is such a dependency, isn't it?

Look at libpthread_rt code.

-- 
                                                 Gilles.

