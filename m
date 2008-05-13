Message-ID: <4829613B.3000500@domain.hid>
Date: Tue, 13 May 2008 11:36:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>
In-Reply-To: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb + multi-threaded application + Intel dual
 core	processor + Xenomai => frozen system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Cc: xenomai@xenomai.org

Kaeppeler, Oliver wrote:
> Hello,
>  
> we get an frozen system, if we start a multi-threaded posix-skin
> application within the GNU-Debugger (gdb) on an Intel dual core
> processor. Precisely, the system freezes when threads are being created.
> Often the problem occurs when the third or fourth thread is being
> created.
>  
> Some further remarks:
> o We use OpenSUSE Linux 10.3 and Xenomai 2.4.3 over Linux Vanilla
> 2.6.24.5. Xenomai 2.4.0 over 2.6.23.9 shows simular behavier.
> o Toolchain SUSE 10.3 as is.  
> o We run "init 3", so no x-server
> o We tested some gdb-Versions (6.3, 6.6, 6.8), but the result remains
> the same.
> o The system does NOT freeze, if the dual core feature is deactivated in
> the BIOS (so the processor works just with ONE core)!
> o Without gdb the program runs as expected.
>  
> We attached a very small example program that creates 50 threads via
> pthread_create(). Each thread prints "Hello world", sleeps a few seconds
> and exits. We also attached the result of xeno-test (xeno-test.log.bz2)
> and /proc/config.gz.
>  
> To start the application "test1" within the debugger, just type the
> following:
> # gdb test1
> (gdb) run
>  
> Does anybody know, why the system freezes?

Yep. Known issue. Already fixed in latest SVN trunk and 2.4.x.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

