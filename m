Message-ID: <4AC28DF9.30900@domain.hid>
Date: Wed, 30 Sep 2009 00:45:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460C477B17@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460C477B17@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supressing kernel ring messages on standard
	output
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> I am running a program with Xenomai and using the POSIX skin.  When the
> program exits, I get messages from the kernel ring buffer on the
> terminal, such as:
> "Xenomai: Posix: destroying mutex df9c1000".
>  
> This is interfering with data the program is also printing.  Is there a
> way to disable or redirect this?
>  
> I am using an embedded PowerPC evaluation board with kernel 2.6.24.6 and
> Xenomai 2.4.9.1 and the terminal is through a serial port if that makes
> a difference.

These messages are posix skin debug messages, so, simply disabling
debugging for the posix skin in kernel configuration should be enough.
Also note that since these messages appear on the kernel console, you
can separate them from the program output: if you redirect the program
output, kernel console messages will not be redirected.

-- 
					    Gilles.

