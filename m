Message-ID: <4BB37E0A.1020507@domain.hid>
Date: Wed, 31 Mar 2010 18:53:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BB3532D.2070305@domain.hid>
In-Reply-To: <4BB3532D.2070305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] FYI: CONFIG_PERF_EVENTS conflicts with Xenomai
	shadows
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Hi,
> 
> just ran into an ugly warning of I-pipe as I happened to have
> CONFIG_PERF_EVENTS enabled in 2.6.32 kernel. That pulls some plain Linux
> spinlock into the finish_task_switch path.
> 
> We should either disable this feature at I-pipe level or patch it
> properly. Haven't checked yet if the latter is feasible with moderate
> effort, though.
> 

At least this one is now explainable: There is no problem related to
CONFIG_PERF_EVENTS. finish_task_switch is not part of the critical
shadow task switch, and the oops I saw finally turned out to be caused
by my buggy virtual hardware (IOW: an unrelated hypervisor bug). Nothing
to worry about for Xenomai or I-pipe.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

