From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: alchemy: *_timed API all wrongly documented?
Message-ID: <7bfa02a9-b59b-2457-06cb-2a6aae7457c4@siemens.com>
Date: Mon, 11 Oct 2021 12:22:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

it looks to me like all those *_timed functions are at least confusingly
documented - or broken. They all carry

 * @param abs_timeout An absolute date expressed in clock ticks,

and

 * @note @a abs_timeout is interpreted as a multiple of the Alchemy
 * clock resolution (see --alchemy-clock-resolution option, defaults
 * to 1 nanosecond).

However, they also all take a timespec argument as argument, means
seconds and nanoseconds, not "ticks" that will be multiplied by some
resolution. What was the intended API here? Or what should actually be
written here? "Absolute timeout in nanoseconds based on
CLOCK_COPPERPLATE, to be rounded according to that clock's resolution"?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

