Message-ID: <2ff1a98a0711260632x6d29f12dr7dd3ac3eecf4cdba@domain.hid>
Date: Mon, 26 Nov 2007 15:32:04 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200711261415.lAQEFdoD028307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0711260528nd5b56b1he0a41f0239b2236e@domain.hid>
	<200711261415.lAQEFdoD028307@domain.hid>
Subject: Re: [Xenomai-help] RTDM blocking non RT task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On Nov 26, 2007 3:15 PM, Patrick <kpa_info@domain.hid> wrote:
> Hi,
>
> I have a non-RT task (from user space) reading an RTDM driver (nrt_read).
> I would like to block the task on read as long as RTDM doesn't have data to
> read.
> For the moment I use rt_event_wait but it doesn't work with non-RT task (it
> works only with a RT task).
>
> Do you have any idea?

Since the context is not real-time, you can use any Linux services, as
you would do with a non real-time driver, such as *sleep_on* or
wait_event*, provided that you call wake_up* from an nrt signal
handler.

-- 
                                               Gilles Chanteperdrix

