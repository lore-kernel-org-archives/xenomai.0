MIME-Version: 1.0
Date: Sun, 6 Mar 2011 14:05:16 +0800
Message-ID: <AANLkTikq49CMPG=-nFDOhc+Qc1iuK3kHyMpsJ+NCzFUX@mail.gmail.com>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-core] Whether can Xenomai bypass the cache?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hello:
    As known, cache can accelerate the memory access, but
unfortunately, it would decrease the predictability of real-time tasks'
temporal behaviour. Many tasks of our application prefer
predictability to the speed of execution. Intel's processors after P6
include MTRR and PAT, both the two units can be used to bypass the
cache.
    I wonder whether Xenomai can bypass the cache, and whether Xenomai
can manage the MTRR or PAT? If the answers are true, how to use the
function?
3x
arethe

