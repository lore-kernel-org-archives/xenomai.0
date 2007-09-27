Message-ID: <2ff1a98a0709270216w7c37247cx996612a3cd75b55c@domain.hid>
Date: Thu, 27 Sep 2007 11:16:40 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46FA44C9.8050506@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46FA44C9.8050506@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix attribute reference in
	__wrap_pthread_create
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
Cc: Xenomai-core@domain.hid

On 9/26/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Hi Gilles,
>
> my rt-cap changes to the posix lib caused another regression. I don't
> understand what my intention of changing the attribute reference once
> was (probably an intermediate change), but it was wrong. The attached
> patch now makes all programs happy that create pthreads without
> attributes (clocktest e.g.).
>
> Patch against 2.3.x, should be applied to trunk as well.

Applied on both branches, thanks.

-- 
                                               Gilles Chanteperdrix

