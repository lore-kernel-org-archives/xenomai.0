MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18498.62016.697156.829501@domain.hid>
Date: Sun, 1 Jun 2008 21:02:24 +0200
In-Reply-To: <4842F10D.7060601@domain.hid>
References: <18498.60991.572819.581076@domain.hid>
	<4842F10D.7060601@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] enum rtdm_selecttype
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi Jan,
 > > 
 > > when compiling xenomai v2.4.x for ARM with gcc 4.2.1, I get plenty of
 > > warnings like:
 > > xenomai-arm/kernel/xenomai/skins/posix/syscall.c:38:
 > > xenomai-arm/include/xenomai/rtdm/rtdm_driver.h:206: warning: parameter has incomplete type
 > > 
 > > So it seems gcc 4.2.1 does not like the enum being used in function
 > > prototypes without being defines. So, could we move the enum definition
 > > before the functions using it ?
 > > 
 > 
 > We can sort this out with a simple forward declaration.

That is the way it is done today, but gcc 4.2.1 seems not to like
it. Maybe recent C standards allow the compiler to pick the smallest type
for the enum as C++ does ?

-- 


					    Gilles.

