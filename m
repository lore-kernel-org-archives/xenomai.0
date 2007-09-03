From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46DC149F.80307@domain.hid>
References: <46DC149F.80307@domain.hid>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 20:32:24 +0200
Message-Id: <1188844344.28092.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] VxWorks skin is missing new VxWorks headers
	for	RTP
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-09-03 at 17:05 +0300, Ravid Baruch Naali wrote:
> Hello again,
> 
> 
> Preface:
> 
> As of VxWorks 6.x vxworks implement RTP which is an implementation of
> user space processes with real time capabilities, which of course
> include an extended API, which from my testings I discovered that we do
> not support yet.
> 
> 
> Currently extending the VxWorks API is not in Xenomai task list, does it
> have any demand?
> 
> If I'll take it as a my task, do we have any legal issues with using
> Wind River's headers?

This matter is muddy; fair use, interoperability, and copyrights of
header files and/or their contents is a legal mess.

Our policy is simple: paste-copy of any portion of any proprietary
licensed header is unwanted and will be systematically rejected. You
need to implement your own header, defining what you need for satisfying
all the references within the emulator your are writing from scratch.

You should also explicitly mention in the copyright notice that the
resulting software is an emulator. We claim to mimick the original
software as correctly as possible, according to the API specs which have
been made publically available by the copyright holder of the original
work, with all the limitations inherent to such exercise. In any case,
we don't claim to produce a copy of the original software we only
emulate. In short, Xenomai is a Chameleon, not a clone.

> 
> 
> If any of my assumptions is false or if you have any comment/answers
> please reply.
> 
> 
> thanks
> 
> Ravid
> 
-- 
Philippe.



