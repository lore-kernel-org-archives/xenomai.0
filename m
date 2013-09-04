Message-ID: <52271128.9010401@siemens.com>
Date: Wed, 04 Sep 2013 12:53:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
	<52270CC9.1090102@siemens.com>
	<CAC3AHr+NOAqPNAFnxGvcMxuJRorotv0O0WrGHCUGuV0zBZYEhw@mail.gmail.com>
In-Reply-To: <CAC3AHr+NOAqPNAFnxGvcMxuJRorotv0O0WrGHCUGuV0zBZYEhw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] unmapping and remapping /dev/rtheap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Jacobvitz <jacobvi123@gmail.com>
Cc: xenomai@xenomai.org

On 2013-09-04 12:39, Adam Jacobvitz wrote:
> Yeah...I suppose that's the fundamental issue. I'm brand new to xenomai and
> I'm not really familiar to what state xenomai maintains for an application.
> 
> Do you know what state I would need to checkpoint and if its even possible
> to checkpoint it?

There is a lot, starting with core thread objects, sync objects etc.,
then there are skin-specific extensions of those and also objects that
are shared between processes. But even if you export all this, Xenomai
wasn't designed with this use case in mind. So you may find many tricky
corner cases around checkpoint/restart - just like in Linux...

What overall use case are you aiming at with CRIU for your RT
process(es)? What states would your processes be in when
saving/restoring? And what Xenomai version do you consider for this, 2.6
or upcoming 3.0?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

