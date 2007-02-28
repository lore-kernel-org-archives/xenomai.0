From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] task not being scheduled
Date: Wed, 28 Feb 2007 07:50:24 -0600
References: <45E494AC.5050603@domain.hid>
In-Reply-To: <45E494AC.5050603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702280750.24918.jweber@domain.hid>
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

Switching to the linked timer list from the heap list fixed it.

	thanks,
	Jeff

On Tuesday 27 February 2007 14:29, Jan Kiszka wrote:
> I saw in the .config that you are using the heap timer list. Already
> tried the classic linked list as well? Maybe we see in issue related to
> this queue implementation.

