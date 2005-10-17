From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.13470.692381.730895@domain.hid>
Date: Tue, 18 Oct 2005 01:32:46 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <43540BB5.9040401@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid>
	<435409AD.6060705@domain.hid>
	<43540BB5.9040401@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Probably grabbing more stuff from the kernel cflags into XENO_ARCH_FLAGS (e.g. 
 > -m[0-9]* to start with). Gilles, would this be ok?

Probably, but last time I checked that, the ppc-compiled version of the
dummy program used at configuration time to extract the arch flags from
Kbuild was not work here, because of ahem, quoting issues. There are
some -m arguments we do not want (such as for example the -msoft-float
used in ppc kernel space).

-- 


					    Gilles Chanteperdrix.

