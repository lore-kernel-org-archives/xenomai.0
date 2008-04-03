Message-ID: <2ff1a98a0804030908g55e907d9xefb2e5a502c6783d@domain.hid>
Date: Thu, 3 Apr 2008 18:08:58 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <f45855d10804030904w28c5ea4bm1c4a71f7b37d5ca6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
	<18417.28104.771421.524613@domain.hid>
	<f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
	<18417.53680.5061.752392@domain.hid>
	<f45855d10804022023n5094eb41g477071cc3a280840@domain.hid>
	<2ff1a98a0804030207sa7a3c44s83fa08db7d0ab3db@domain.hid>
	<f45855d10804030904w28c5ea4bm1c4a71f7b37d5ca6@domain.hid>
Subject: Re: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <levesquev@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 3, 2008 at 6:04 PM, Vincent Levesque <levesquev@domain.hid> wrote:
> Hi Gilles,
>
> I tried the patch on both linux-2.6.24.4+xeno-2.4.2 and
> linux2.6.24.3+xeno-2.4.2 (like Tomas). In both cases I get errors messages
> when patching:
>
> root@domain.hid# patch -p1 < 6.patch
>  patching file include/linux/mm.h
> Hunk #1 FAILED at 104.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/mm.h.rej
> patching file mm/memory.c
> Hunk #1 FAILED at 584.
> 1 out of 1 hunk FAILED -- saving rejects to file mm/memory.c.rej
>
> Am I using the right version of linux and xenomai? Was I supposed to apply
> other patches first? I had to fix the patch a bit (line endings were mangled
> in the email) but I don't think I broke anything.

What do the rejects look like ?

>
> Out of curiosity, can you reproduce the bug?

I have not tried yet.

-- 
 Gilles

