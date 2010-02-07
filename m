Message-ID: <4B6ECD24.60801@domain.hid>
Date: Sun, 07 Feb 2010 15:24:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>
In-Reply-To: <4B6E8167.6010907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

Roland Stigge wrote:
> Hi,
> 
> I'm just working on the Xenomai 2.5.1 Debian package and encountered 
> non-PIC code (evil! ;-) in the shared libraries (skins libraries).
> 
> You can see it with e.g.
> 
> $ readelf -d src/skins/native/.libs/libnative.so.3.0.0
> 
> The "TEXTREL" tag indicates non-PIC code.
> 
> $ scanelf -qT src/skins/native/.libs/libnative.so.3.0.0
> 
> Shows the function and code offset of the relocation.
> 
> With
> 
> $ objdump -d src/skins/native/.libs/libnative.so.3.0.0
> 
> I found the actual location of the relocation.
> 
> I prepared a patch (attached) that fixes it: First, the relocation 
> itself by letting GCC create the address in PIC style. Second, "extern 
> inline" looks a bit counterintuitive at first, but according to the GCC 
> manual, it seems to be what we want (macro behaviour).
> 
> Thanks Jan for reminding me!

Glad to hear that debian work on Xenomai has resumed. Merged, thanks.

-- 
					    Gilles.

