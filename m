Message-ID: <2ff1a98a0712030922y7b32f299p3110192a1d0eebad@domain.hid>
Date: Mon, 3 Dec 2007 18:22:28 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7289437c0712030905p62cec8ebt769a03fbdd9d1a9a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0712030216y5bd7d9f1p6af2a9cd4870d813@domain.hid>
	<2ff1a98a0712030253h6c9e6053q8143777cc37d9cdc@domain.hid>
	<7289437c0712030905p62cec8ebt769a03fbdd9d1a9a@domain.hid>
Subject: Re: [Xenomai-help] RTDM : Event wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 3, 2007 6:05 PM, Perrine Martignoni <perrmart@domain.hid> wrote:
> Ok, Thanks.
> I'll do it with RT User-space Task. So, how can I include rtdm_driver.h in
> my user application to use by example rtdm_event_wait ?
> I have this error : "This header is for kernel space usage only. You are
> likely looking for rtdm/rtdm.h"

What you are supposed to do is implement the read or ioctl method of a
driver using rtdm_event_wait, then call rt_dev_read/rt_dev_ioctl (or
read/ioctl if using the posix skin) from a user-space application.

-- 
                                               Gilles Chanteperdrix

