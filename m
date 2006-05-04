From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17497.61987.796134.162769@domain.hid>
Date: Thu, 4 May 2006 14:22:59 +0200
Subject: Re: [Xenomai-core] linker: undefined reference to `nktickdef'
In-Reply-To: <20060504113947.98923.qmail@domain.hid>
References: <20060504113947.98923.qmail@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles mendes <mendesgilles@domain.hid>
Cc: xenomai@xenomai.org

gilles mendes wrote:
 > (...)
 > gcc -L/usr/xenomai/lib --uvm-ldflags -otest2 ./Util.o ./main_hpci.o ./rtai_util.o -luvm -lnucleus -lpthread -lvxworks
 > (...)

You likely have a problem with the makefile: the parameter --uvm-ldflags
should be passed to xeno-config, not to gcc.

You should try first with a simple Makefile, such as 
ksrc/skins/vxworks/demos/Makefile

Once it works with this simple makefile, you can try with a complex one.

-- 


					    Gilles Chanteperdrix.

