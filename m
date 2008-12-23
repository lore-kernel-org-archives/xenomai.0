Message-ID: <49513A4F.2060700@domain.hid>
Date: Tue, 23 Dec 2008 20:21:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081223190649.26094.61372.stgit@domain.hid>
In-Reply-To: <20081223190649.26094.61372.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 0/5] NMI watchdog fixes / enhancements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Changes since last round:
>  - Fix build breakage of trunk against 2.6.27
>  - Make rthal_nmi_release more robust (additional patch)
>  - Fix issue of last patch on 32 bit (untested last-minute changes...)
> 
> All patches are also available at
> git://git.kiszka.org/xenomai.git nmi-wd-queue

I remind you that trunk is currently broken for the posix skin on arm, a
regression introduced by your FASTSYNCH patches. From my point of view,
fixing this regression is more important than fixing an option that
almost nobody uses with untested patches...

-- 
					    Gilles.

