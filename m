From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17610.4667.583352.696361@domain.hid>
Date: Fri, 28 Jul 2006 15:33:47 +0200
Subject: Re: [Xenomai-help] configuration of pentium III 1GHz
In-Reply-To: <e325d110607280523n40b51f9frb07cd2e8447c0fe1@domain.hid>
References: <e325d110607280158w436c5d53k5f0e3cee4b6015d9@domain.hid>
	<44C9D75C.8000906@domain.hid>
	<e325d110607280523n40b51f9frb07cd2e8447c0fe1@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Kim Chuan Lim wrote:
 > > Looks to me like you patched a SuSE kernel with I-pipe, did you? I'm
 > > also running SuSE, but I always use a vanilla kernel as platform for
 > I'm using SuSE as the base platform to compile a vanilla kernel. :)
 > 
 > > Time to upgrade, 2.2 is out :). BTW, there is one potentially relevant
 > > fix even post 2.2: if you have CONFIG_DEBUG_SPINLOCK on, switch it off
 > > or upgrade to I-pipe 1.3-08.
 > My vanilla kernel source is located at the same directory as xenomai..
 > 
 > I downloaded the latest version of Xenomai from trunk just now ...

You do not have to, the 2.2 version is available as a tarball.

 > 
 > ./prepare-kernel.sh --linux=../../linux-2.6.17
 > Target architecture [default i686]:
 > 
 > I think something wrong with the prepare-kernel.sh scripts.. can
 > someone fix it please?
 > I think that is the reason why i get the following compilation errors.
 > 
 > In file included from include/asm/xenomai/hal.h:107,
 >                  from kernel/xenomai/arch/generic/hal.c:43:
 > include/asm-generic/xenomai/hal.h:60:2: #error "Adeos kernel support
 > is required to run this software."
 > include/asm-generic/xenomai/hal.h:61:2: #error "See
 > http://download.gna.org/adeos/patches/"

I tried to compile xenomai trunk in the same conditions as you, and
could not reproduce your problem. Even if I manually edit the .config
file to enable xenomai without enabling the interrupt pipeline, the
.config file get corrected when make is run.

So, we need to know more about the conditions of the bug you found in
order to be able to help you.

-- 


					    Gilles Chanteperdrix.

