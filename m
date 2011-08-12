Message-ID: <0418d479ba74e1d8c47f00d4477f82f2.squirrel@domain.hid>
In-Reply-To: <CAKvQZ_201P0vHGH0QFyGGqmOHFugbEfcZ=-vspNJU+F9Z+1dqw@domain.hid>
References: <CAKvQZ_201P0vHGH0QFyGGqmOHFugbEfcZ=-vspNJU+F9Z+1dqw@domain.hid>
Date: Fri, 12 Aug 2011 13:32:22 +0200 (CEST)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] depracated use case of xeno-config,
 how to update ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org, canfestival-devel@domain.hid


Willy Lambert wrote:
> Now, as xeno-config depracated messages suggest I should not use "
> $XENO_CONFIG --xeno-ldflags" but "$XENO_CONFIG --skin=native --ldflags"
> without adding -lnative.
> My problem is that I have both -lnative and -lrtdm so I wonder why skin is
> only accepting one at a time.
> Is it forbidden now to do such mixes ?
> Did CanFestival code should be separated into 2 pieces one with
> skin=native
> the other with skin=rtdm ?
> Should I only add -lrtdm "brutally"

No, nothing is forbidden. You should call xeno-config twice. Once with
--skin=native, once with --skin=rtdm. At least, this is the way it is
supposed to be used.

-- 
                    Gilles.


