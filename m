MIME-Version: 1.0
In-Reply-To: <49A67901.60506@domain.hid>
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
	<49A4209F.60502@domain.hid>
	<a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
	<49A51C3D.1020705@domain.hid>
	<a0e7fce50902252221x28c4b394j56803eaab0460f7b@domain.hid>
	<49A66CF6.7050405@domain.hid>
	<a0e7fce50902260256o49ab88fcmbe6269b67b92aa5f@domain.hid>
	<49A67901.60506@domain.hid>
Date: Fri, 27 Feb 2009 18:02:32 +0800
Message-ID: <a0e7fce50902270202l66bf8686j57057478897fe082@domain.hid>
From: yi li <liyi.dev@domain.hid>
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
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Thanks. This makes sense to me.

-Yi

On Thu, Feb 26, 2009 at 7:12 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> This is why we are talking about "two-phase" link for static mode. In fact,
> fixing the issue your reported would require to implement two-phase link
> conditionally in our Makefiles producing POSIX binaries, to be used when FLAT
> format is wanted. This is doable, but requires a bit more work than just
> reordering or removing dependencies on libpthread.

