MIME-Version: 1.0
In-Reply-To: <20131017150012.GM13097@csclub.uwaterloo.ca>
References: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
	<525EC963.2000005@xenomai.org>
	<CAEk6gTC7=6NJVJJTATHApcf8G13bX=68ZOAR4XdEmhiAgf3ZoQ@mail.gmail.com>
	<20131017150012.GM13097@csclub.uwaterloo.ca>
Date: Thu, 17 Oct 2013 17:08:09 +0200
Message-ID: <CAEk6gTCTeCd7M-gUuQZhvDSi0pvC5Nwo7NTrkNiDKJW5Gbdprw@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Hardware I/O from Userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 17, 2013 at 5:00 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Thu, Oct 17, 2013 at 04:57:43PM +0200, Drasko DRASKOVIC wrote:
>> I will most probably have only one application who access these regs.
>>
>> Is not putting this application into the user-space safer - if it
>> breaks it will not block system?
>> Did i misunderstand something, or RTDM kernel module is like standard
>> kernel module - if it has a bug it can break the whole kernel.
>
> What do you think using /dev/mem can do?

I guess it opens the file for reading... right? Is there more than
meets the eye? Can it do much harm when file is opened from userspace
and how?

BR,
Drasko

