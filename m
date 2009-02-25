Message-ID: <49A517B1.8000409@domain.hid>
Date: Wed, 25 Feb 2009 11:04:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090217170418.1425.56126.stgit@domain.hid>
In-Reply-To: <20090217170418.1425.56126.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 0/4] Various fixes and cleanups
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> This is a rework/rebase of the patch series I sent last December,
> addressing the concerns and suggestions brought up during our discussion
> in January.
> 
> 
> Find the patches also at git://git.kiszka.org/xenomai.git queues/assorted
> 
> Jan Kiszka (4):
>       POSIX: Fix SCHED_RR thread creation
>       Mark libs nodlopen on initial-exec TLS
>       Add --enable-dlopen-skins configure switch
>       POSIX: Do not auto-shadow main with dlopen enabled

What is the schedule for these patches? 2..4 shouldn't be controversial
anymore (find them rebased as patch 1..3 under queues/assorted). And for
the first one I already sent a rework (now patch 4 in that queue) that
still looks fine to me. But I can also repost some/all of them if preferred.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

