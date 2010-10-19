Message-ID: <4CBD5495.4000402@domain.hid>
Date: Tue, 19 Oct 2010 10:19:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinwg1Z9p2LSE_2-1BYTVqzvk4dfOZe345ajGUXZ@mail.gmail.com>
In-Reply-To: <AANLkTinwg1Z9p2LSE_2-1BYTVqzvk4dfOZe345ajGUXZ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Reg: serial Driver Compilation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter Warner wrote:
> Hi Everyone,
> 
> I found the xenomai real time serial driver but I found it was compiled
> with the kernel itself so every time when I will modify the driver code
> I need to recompile the whole kernel.
> Is there any way so that I can skip this and will compile and generate
> the serial driver only.

You do not need to recompile the whole kernel. You can type "make" and
only what has changed will be recompiled. Furthermore, if you selected
the serial driver as a module, you can simply run "make modules" and
"make modules_install".

-- 
					    Gilles.

