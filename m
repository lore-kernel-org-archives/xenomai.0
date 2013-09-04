Message-ID: <52270CC9.1090102@siemens.com>
Date: Wed, 04 Sep 2013 12:34:49 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
In-Reply-To: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
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

On 2013-09-04 12:04, Adam Jacobvitz wrote:
> Hi, I need to take a checkpoint using criu of an application compiled using
> xenomai's posix skin. The problem is that criu doesn't know what to do with
> the /dev/rtheap mapping. Is there a way to either manually unmap
> /dev/rtheap from the process and then remap it when restored, or is there a
> way to compile my xenomai application without using rtheap?

Err, how does your CRIU version deal with all the Xenomai-internal
state? I guess you didn't patch the Xenomai core and skins to
export/import it, did you?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

