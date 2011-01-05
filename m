Message-ID: <4D247B80.3040503@domain.hid>
Date: Wed, 05 Jan 2011 15:09:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <003001cbacde$f43fa500$dcbeef00$@com>
	<4D2476A5.5080908@domain.hid>
	<003601cbace1$5a56fb20$0f04f160$@com>
In-Reply-To: <003601cbace1$5a56fb20$0f04f160$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] R:  XDDP socket problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gianni Perugini <gperugini@domain.hid>
Cc: xenomai@xenomai.org

Gianni Perugini wrote:
> Hi Gilles,
> 
> Attached is the log with the result of the command you asked for.

(...)

0804a6a8 B rt
         U rt_print_auto_init
         U rt_printf
         U sendto@domain.hid
         U setsockopt@domain.hid
         U sigaddset@domain.hid
         U sigemptyset@domain.hid
         U signal@domain.hid
         U sigsuspend@domain.hid
         U socket@domain.hid
         U strlen@domain.hid
         U write@domain.hid

Here, this binary is using glibc symbols, not Xenomai symbols, if it was
using Xenomai symbols, you would see:

U __wrap_pthread_create
U __wrap_sendto
U __wrap_setsockopt
U __wrap_socket
U __wrap_write

etc...

In order to compile it correctly, see:
http://www.xenomai.org/index.php/Examples
If you want to understand how this works, see:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags.

-- 
					    Gilles.

