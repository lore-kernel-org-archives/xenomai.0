Message-ID: <4D89A334.4090802@domain.hid>
Date: Wed, 23 Mar 2011 08:37:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
In-Reply-To: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> I need to timetag events from a realtime context with a NPT-synchronized
> system clock.  This topic comes up periodically on the mailing list.  Last I
> recall, there was talk of adding the capability via an alternate
> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?

The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
2.6 branch, soon). It requires modifications of the I-pipe patch which
are available, at least, on x86, but are probably not really hard to
implement on other platforms.

-- 
                                                                Gilles.

