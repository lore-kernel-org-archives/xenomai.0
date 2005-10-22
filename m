From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17242.38814.357830.552592@domain.hid>
Date: Sat, 22 Oct 2005 21:48:46 +0200
Subject: Re: [Xenomai-core] [Fwd: Re: [Xenomai-help] timeout in native API
	calls (cond, sem, mutex, etc).]
In-Reply-To: <435A6DA3.1030506@domain.hid>
References: <435926CE.1090201@domain.hid>
	<200510221551.25114.dmitry.adamushko@domain.hid>
	<435A594D.2060608@domain.hid> <435A6DA3.1030506@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
 > I don't see an urgent need to go and change the whole code to kernel
 > coding style, I only see the need to keep one consistent style across
 > the code. This just may require a bit more iterations for "third-party"
 > contributed patches.
 > 
 > Ok, the ipipe patch as the part being integrated in the kernel, that one
 > should conform to kernel style to make it easier readable for inflexible
 > kernel hackers. But for the rest (which will very likely never made it
 > into the kernel), we should decide based on a broader basis than just
 > "follow the kernel herd".
 > 
 > Personally, I don't like hard-tabs (think they are too often misused to
 > format text alignment instead of just indenting code blocks), but I can
 > live with any style - as long as it is consistent and comprehensible.
 > Now as we already have such a style, why to change it right now? I would
 > say: just enforce it.

I don't like hard-tabs either, I guess kernel people are using them to
save disk space, but since Xenomai sources are not large, we have no
reason to use them.

As for braces placement, I used to dislike Xenomai style (where
does it come from anyway, BSD ?), but got accustomed to it; after all,
it is readable. Anyway, I prefer the kernel style, except for the 8
spaces "c-basic-offset" to talk in emacs cc-mode language...

I would also prefer avoiding the stupid naming rules I had to follow in
some companies.

-- 


					    Gilles Chanteperdrix.

