From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] task not being scheduled
Date: Tue, 27 Feb 2007 15:09:33 -0600
References: <45E494AC.5050603@domain.hid>
In-Reply-To: <45E494AC.5050603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702271509.33805.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

I will try the CONFIG_XENO_OPT_TIMER_LIST.  I have about 18 RT tasks,
of which only a few are ever runnable at the same time.

	Jeff

On Tuesday 27 February 2007 14:29, Jan Kiszka wrote:
> Jeff Weber wrote:
> > trace and .config attached.
>
> OK. Sorry for not believing in the first place :), but there are
> actually timer events missing for your 10-ms-period task.
>
> I saw in the .config that you are using the heap timer list. Already
> tried the classic linked list as well? Maybe we see in issue related to
> this queue implementation.

