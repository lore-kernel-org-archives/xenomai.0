Message-ID: <4AD9E5E1.2020808@domain.hid>
Date: Sat, 17 Oct 2009 17:42:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <702460.16116.qm@domain.hid>
In-Reply-To: <702460.16116.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not
	implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org, eldk@domain.hid

Yigal Goldberger wrote:
> Hi Again Gilles,
> I've also sent this mail to the DENX mailing list , since the toolchain is suplied by DENX.
> Our board was ported some two months ago by DENX software based on the MPC8272 (freescale) .
> I'd like to add the support for shared memory , but as I said I'd like to keep the system as untouched as possible - as I said It's been tested and is running stable and with good performance .
> Since I know that these things are delicate, I'd appreciate your guidance as to which files I need replaced (by which files) , and which configurations need be changed .
> Best Regards,
> Yigal Goldberger .

Could you show me the config.log file extracted from xenomai build
directory? After all, your glibc may support posix shared memories, but
something prevent them from working. In order for the posix shared
memories to work you must have:
- tmpfs support in the kernel configuration
- something like a script or a line in /etc/fstab which mounts a tmpfs
filesystem on /dev/shm (a drectory that must exist, too).

Otherwise, to enable shared memories in xenomai posix skin, you simply
have to enable the option in the kernel configuration, menu "Real-time
subsystem", Nucleus, Interfaces, POSIX API, then Option "shared memory".

-- 
					    Gilles.

