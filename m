Message-ID: <4B1E6B1B.5080306@domain.hid>
Date: Tue, 08 Dec 2009 16:04:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1260281665.792922.9257.nullmailer@domain.hid>
In-Reply-To: <1260281665.792922.9257.nullmailer@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai 2.4.10 - invalid opcode: 0000
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Petr Cervenka wrote:
> Hello,
> I tried to upgrade linux kernel and xenomai and now I have problems with
> freezing computer because of "invalid opcode: 0000".
> It happens without any real-time app. running. Most often when I run X
> with KDE and netbeans (almost 100% probability), but it can freeze also
> during the boot.
> It perhaps depends on system load (CPU, disk, IO, ...?).
> 
> My configuration:
> SW:
> linux kernel 2.6.30.9, arch: x86_64
> xenomai-2.4.10, smp
> 
> also:
> rtnet-0.9.11 - no driver loaded
> peak-linux-driver-6.11 - no device connected
> 
> HW:
> CPU: Intel Core2Duo  E7400
> chipset: Intel 3210
> system partition is on CF (compact flash) mounted in CF-SATA converter.
> 
> Do you have any advices or tips? Thanks in advice.
> I can provide you by any needed information (.config of linux kernel,
> full systemlog, ...), just ask me.

Yes, please. I assume your system is otherwise stable (without
Xenomai/I-pipe enabled).

It would also be nice if you could retry over 2.6.31.x with latest ipipe
patch. And try to switch on CONFIG_IPIPE_DEBUG_TRACE_MCOUNT. That may
give a function back-trace on oops, maybe providing more pointers where
we come from (but it may also make the issue disappear).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

