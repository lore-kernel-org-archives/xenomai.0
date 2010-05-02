Message-ID: <4BDD7A73.2020403@domain.hid>
Date: Sun, 02 May 2010 15:13:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <z2t634720cc1005020214n3ce3543dhf272c998fb9ed48d@domain.hid>
In-Reply-To: <z2t634720cc1005020214n3ce3543dhf272c998fb9ed48d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] User space build problems with Xeno 2.5.2 and
 ARM	integrator
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gildas Bayard <gildas.bayard@domain.hid>
Cc: xenomai@xenomai.org

Gildas Bayard wrote:
> (...)
> checking for ARM architecture version... configure: error: Invalid
> architecture choose, only 4, 5, xscale3, 6 and 7 are supported
> (...)
> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `mmap64'
> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to
> `ftruncate64'

Both issues should be fixed in Xenomai 2.5 repository. Could you give it
a test?

-- 
					    Gilles.

