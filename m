Message-ID: <2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
Date: Mon, 14 Jan 2008 14:25:00 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47891672.4050409@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47891672.4050409@domain.hid>
Subject: Re: [Xenomai-help] Xenomai problems on pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernhard Michael <michael.bernhard@domain.hid>
Cc: xenomai@xenomai.org

On Jan 12, 2008 8:35 PM, Bernhard Michael <michael.bernhard@domain.hid> wrote:
> Hello,
>
> I've been successfully using xenomai on a PXA270 board (Colibri from
> Toradex) with a custom 2.6.15 kernel and a gcc-3.3.2 toolchain. The
> xenomai version was 2.3.1 with adeos arm patch 1.5-08.
>
> Now I try to upgrade the system to a 2.6.20 kernel compiled with a
> gcc-4.2.1 toolchain (from CodeSourcery). I want to use xenomai 2.4.1
> with adeos arm patch 1.8-03.
>
> Unfortunately xenomai fails partially to run. As I do not know where to
> start debugging, I'm going to describe the current behavior. For testing
> purpose I use xenomai-trunk (svn 3409). Xenomai is compiled as a module.

I have not yet tried to compile Xenomai for ARM in the same conditions
as you, however I see an option that could be the source of problems:
it's the "optimize for size" option. Could you try disabling it ?

-- 
                                               Gilles Chanteperdrix

