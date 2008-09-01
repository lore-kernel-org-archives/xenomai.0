Message-ID: <48BBBD51.9080508@domain.hid>
Date: Mon, 01 Sep 2008 12:00:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAE63.8010008@domain.hid>
In-Reply-To: <48BBAE63.8010008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 6/9] Add XNSYNCH_FWDROB
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Intermediate helper as long as skins implement fast locking and related
> owner tracking on their own: Add 'forward XN_ROBBED state' to the caller
> of xnsynch_sleep_on so that the correct owner can be looked up there.

Nak. We already discussed this with Philippe, XNROBBED is an internal
thing for xnsynch and should not leak to skins code. I actually happen
to find the current workaround cleaner.

-- 
                                                 Gilles.

