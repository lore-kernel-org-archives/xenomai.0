Message-ID: <4975E491.1040506@domain.hid>
Date: Tue, 20 Jan 2009 14:49:53 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I can do that. I have to be careful where I use printk, though. I
> noticed my board freezes if I try to do a printk in
> __xnpod_fault_init_fpu() so that makes it harder. I am not exactly sure
> what to look for because I've never done any assembler with the 387. Any
> pointers would be helpful!

You should not need any assembler at all. The header I have sent you
implements two functions save_fp to save the fp environment, and dump_fp
to dump a saved fp environment. If your cpu has no fxsr support (which
you can check in /proc/cpuinfo), you should use old_save_fp and
dump_old_fp instead.

-- 
                                                 Gilles.

