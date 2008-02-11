Message-ID: <2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
Date: Mon, 11 Feb 2008 17:10:00 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
	<47B053A2.9010503@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] overhead
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, Feb 11, 2008 at 4:20 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> The overhead was measured by only comparing cpu usage between tasks from
>  the statistics collection stuff. There are some userland tasks running
>  at 8khz, so apparently this is a problem for Xenomai on this board. I
>  had no problem at all with these tasks in kernel space under rtai.

user-space adds some overhead compared to kernel-space. Enabling the
T_FPU bis for a task which does not need also adds the useless
overhead of saving/restoring FPU upon context switch.

-- 
                                               Gilles Chanteperdrix

