Message-ID: <2ff1a98a0803030206j52d5c1eeja568e346fe058213@domain.hid>
Date: Mon, 3 Mar 2008 11:06:16 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47CACD33.5000107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47CA8934.3060405@domain.hid>
	<18378.50046.906228.646119@domain.hid>
	<47CACD33.5000107@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/6] Fix, refactor,
	and optimize xnlock services, v2
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

On Sun, Mar 2, 2008 at 4:52 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>  >
>  > Well, I am still not convinced, I still find the debugging version harder
>  > to read. Is there a problem with implementing the two versions
>  > separately with a unique #ifdef?
>
>  Well, everything is possible. But we would start to duplicate LOC again,
>  namely both the lock implementations and the debugging services. Just
>  look at the final system.h and pod.h after applying all patches.
>
>  I could try this, but only if it is _really_ desired. I'm convinced it
>  is the wrong way because I consider the readability and consistency of
>  the lock implementation more important than its debug code.

Well, it may happen that we have to debug the debug code. But Ok, I
agree with your changes.

-- 
                                               Gilles Chanteperdrix

