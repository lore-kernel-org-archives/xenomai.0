Message-ID: <2ff1a98a0804010059y16b1297ra24117f38ffe2cef@domain.hid>
Date: Tue, 1 Apr 2008 09:59:23 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <18417.52630.8850.939898@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47ED5DE3.60202@domain.hid>
	<18413.32341.751841.753799@domain.hid>
	<18413.34914.638951.575098@domain.hid>
	<47ED9D05.7060707@domain.hid>
	<18415.63399.305120.344817@domain.hid>
	<47F062DE.5000709@domain.hid>
	<18417.18371.183857.809430@domain.hid>
	<18417.18921.588809.645062@domain.hid>
	<47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, Apr 1, 2008 at 7:52 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Tomas Kalibera wrote:
>   >
>   > I added a missing underscore and re-tried, and none of the debug
>   > messages was printed. I added another one to make sure that there is not
>   > a problem with getting printk messages to the serial console. The
>   > resulting highmem_32.c and the output is attached.
>   >
>   > T
>
>  The interesting part of the output is the printk which occurs right
>  before the first bug, what happens afterwards is of little use. Do you
>  get any output before the first bug ?

There are other kmap_atomic calls in copy_pte_range than the
kmap_atomic taking place in cow_user_page, they use KM_PTE0 and
KM_PTE1 as the type value. So, we should track these types as well in
highmem_32.c.

-- 
 Gilles

