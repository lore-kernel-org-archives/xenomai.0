Message-ID: <4BF519D8.5010302@domain.hid>
Date: Thu, 20 May 2010 13:15:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A26D@alpine.pivotalsys.com>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A26D@alpine.pivotalsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai, skins, design and a practical approach
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vera Snowball <vera.snowball@domain.hid>
Cc: xenomai@xenomai.org, haknick@domain.hid

Vera Snowball wrote:
> Sounds good to me. Does it include by any chance a chapter on how to
> work with Xenosim simulator? Looks like it is the only simulator which
> can be used for debugging with valgrind. If you made it work, it would
> be great to know how.

Xenosim requires an old 32 bits installation to be compiled, so, it may
not be straightforward to use it.

If what you want to debug with valgrind is your application and not
Xenomai, you can arrange to compile your application for Linux pthreads,
and you will be able to debug it. If you are using the POSIX skin, it
should be easy. If you are using a legacy skin, such as vxworks, psos,
uitron, etc... we already have support for running them on plain linux
with the xenomai-solo package. Only if you are using the native skin it
will be a little harder.

-- 
					    Gilles.

