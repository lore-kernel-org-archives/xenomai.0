From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17532.12451.531937.588552@domain.hid>
Date: Tue, 30 May 2006 13:46:43 +0200
Subject: Re: [Xenomai-help] shm_open undefined
In-Reply-To: <1148934297-13365.00013.03267-smmsdV2.1.4@domain.hid>
References: <1148934297-13365.00013.03267-smmsdV2.1.4@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel.J.Villaume@domain.hid
Cc: xenomai@xenomai.org

Nathaniel J Villaume wrote:
 > Hi, 
 > 
 > I'm trying to create a shared memory region using posix i/f. 
 > I hijacked the example on the opengroup webpage. My problem is
 > that when I try to link, there is no shm_open symbol defined in
 > the libraries xeno has built. (although there is a
 > __wrap_shm_open in libpthread_rt.a) Which library do I link against?

You should link against libpthread_rt.a, but with a bunch of --wrap
options. xeno-config provide an automated way of getting these options:

xeno-config --posix-cflags give the flags to be used when compiling,
xeno-config --posix-ldflags give the flags to be used when linking.

For an example of Makefile using xeno-config, see
ksrc/skins/posix/demos/Makefile

-- 


					    Gilles Chanteperdrix.

