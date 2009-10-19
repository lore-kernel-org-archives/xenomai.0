Message-ID: <4ADCAB36.8080103@domain.hid>
Date: Mon, 19 Oct 2009 20:08:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>
	<20091019171611.3332.58812.stgit@domain.hid>
In-Reply-To: <20091019171611.3332.58812.stgit@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 1/3] nucleus: Use Linux spin lock for
 heap	list management
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> No need for hard nklock protection of kheapq and the map counter, a
> normal spin lock suffices as all users must run over the root thread
> anyway.

At the very least, this should use rthal_spin_lock, in order to seem to
respect the layering.

Anyway, do we really want to change this now?

-- 
					    Gilles.

