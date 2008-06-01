Message-ID: <4842F62D.6010008@domain.hid>
Date: Sun, 01 Jun 2008 21:19:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18498.60991.572819.581076@domain.hid>	<4842F10D.7060601@domain.hid>
	<18498.62016.697156.829501@domain.hid>
In-Reply-To: <18498.62016.697156.829501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] enum rtdm_selecttype
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Hi Jan,
>  > > 
>  > > when compiling xenomai v2.4.x for ARM with gcc 4.2.1, I get plenty of
>  > > warnings like:
>  > > xenomai-arm/kernel/xenomai/skins/posix/syscall.c:38:
>  > > xenomai-arm/include/xenomai/rtdm/rtdm_driver.h:206: warning: parameter has incomplete type
>  > > 
>  > > So it seems gcc 4.2.1 does not like the enum being used in function
>  > > prototypes without being defines. So, could we move the enum definition
>  > > before the functions using it ?
>  > > 
>  > 
>  > We can sort this out with a simple forward declaration.
> 
> That is the way it is done today, but gcc 4.2.1 seems not to like
> it. Maybe recent C standards allow the compiler to pick the smallest type
> for the enum as C++ does ?
> 

Or any integral type the implementation sees fit actually. Well, yes, maybe it
is indeed bits of the C++ standard dripping on the C implementation of GCC,
especially if forward decl of enums is not explicitly defined by the C standard.

-- 
Philippe.

