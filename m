MIME-Version: 1.0
In-Reply-To: <52270CC9.1090102@siemens.com>
References: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
	<52270CC9.1090102@siemens.com>
Date: Wed, 4 Sep 2013 06:39:50 -0400
Message-ID: <CAC3AHr+NOAqPNAFnxGvcMxuJRorotv0O0WrGHCUGuV0zBZYEhw@mail.gmail.com>
From: Adam Jacobvitz <jacobvi123@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] unmapping and remapping /dev/rtheap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Yeah...I suppose that's the fundamental issue. I'm brand new to xenomai and
I'm not really familiar to what state xenomai maintains for an application.

Do you know what state I would need to checkpoint and if its even possible
to checkpoint it?

Thanks,

Adam
On Sep 4, 2013 6:34 AM, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:

> On 2013-09-04 12:04, Adam Jacobvitz wrote:
> > Hi, I need to take a checkpoint using criu of an application compiled
> using
> > xenomai's posix skin. The problem is that criu doesn't know what to do
> with
> > the /dev/rtheap mapping. Is there a way to either manually unmap
> > /dev/rtheap from the process and then remap it when restored, or is
> there a
> > way to compile my xenomai application without using rtheap?
>
> Err, how does your CRIU version deal with all the Xenomai-internal
> state? I guess you didn't patch the Xenomai core and skins to
> export/import it, did you?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
