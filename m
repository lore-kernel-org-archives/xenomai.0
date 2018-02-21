From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com>
Date: Wed, 21 Feb 2018 19:33:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Winter^W y2038 is coming
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

likely due to some platform oddities (still has to be analyzed in more
details), we are running into the situation that xntimer_grab_hardware
on a x86-64 host tunes nkclock.wallclock_offset to a value that is not
compatible with the 32-bit time_t ABI of compat applications. If you do
a pattern like

    abs_timeout = clock_gettime(CLOCK_REALTIME) + rel_timeout
    some_abs_wait(abs_timeout)

that abs_wait will practically wait forever. The same bug can also be
triggered by doing a

    clock_settime(CLOCK_REALTIME, -negative_date)

I'm now wondering if we should take measures that detect or even prevent
the setting of invalid dates in the presence of 32-bit ABIs. Or if we
should suggest/demand the setting of -D_TIME_BITS=64 already. The clock
is ticking... Thoughts?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

