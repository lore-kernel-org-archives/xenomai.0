Message-ID: <43CEB291.4020609@domain.hid>
Date: Wed, 18 Jan 2006 22:26:41 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601181204g4c86f778x@domain.hid>
	<43CEA323.7000701@domain.hid> <43CEAF25.6010705@domain.hid>
In-Reply-To: <43CEAF25.6010705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
[...]
> Do you (or anybody else) have a running 2.0.x installation? If so,
> please test that setup as well.

Sure :-)

# uname -r
2.6.13.4-adeos-xenomai
# cat /proc/xenomai/version
2.0
# ./mutex
Running for 2.15 seconds.
ALERT: No lock! (lockcnt=0) Offending task: task0
ALERT: No lock! (lockcnt=0) Offending task: task0
ALERT: No lock! (lockcnt=0) Offending task: task0
ALERT: No lock! (lockcnt=0) Offending task: task0
L121: Connection timed out.
# cat dump.txt
1010010010101010110001000010001[...]

# ./sem
Running for 2.15 seconds.
L119: Connection timed out.
# cat dump.txt
101001muon:/home/xenomai/atomic#

More tests ?

Best regards,
Hannes.

