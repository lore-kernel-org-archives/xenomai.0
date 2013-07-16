Message-ID: <51E558CC.1060107@siemens.com>
Date: Tue, 16 Jul 2013 16:29:32 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAMDpcBFBhM6yevqd002zqkmmYM1ER-roFLmjZNfOOu1=DETjmQ@mail.gmail.com>
In-Reply-To: <CAMDpcBFBhM6yevqd002zqkmmYM1ER-roFLmjZNfOOu1=DETjmQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CLOCK_HOST_REALTIME
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kunming yang <yangkunming99@gmail.com>
Cc: xenomai@xenomai.org

On 2013-07-16 15:06, kunming yang wrote:
> Hello,
> 
> I failed to read host time by using do_clock_host_realtime, so I tried
> clock_gettime(CLOCK_HOST_REALTIME) by executing "clocktest -C 2", but I got:
> 
> == Tested clock: 2 (<unknown>)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  0.0            0.000          0            0.0
> clock_gettime failed for clock id 2
> 
> Anyone knows what's the problem?

As we know, the answer to all questions is 42, also to this one:

#define CLOCK_HOST_REALTIME 42

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

