Message-ID: <51F2B719.1000007@siemens.com>
Date: Fri, 26 Jul 2013 19:51:21 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51B73421.3050506@siemens.com> <51EA7539.3000805@xenomai.org>
	<51F2A6AC.1060408@siemens.com>
In-Reply-To: <51F2A6AC.1060408@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Stable update for ipipe-3.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-07-26 18:41, Jan Kiszka wrote:
> Right now I'm debugging a failing cond-torture-posix test which prevents
> the completion if the run. Likely unrelated.

That turned out to be a local issue, caused by the improper addition of
a tracepoint.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

