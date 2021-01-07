From: Wolfgang Denk <wd@denx.de>
Subject: Re: Is it possible to implement a real-time API to read the files on
 the disk?
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
In-reply-to: <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com>
References: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
 <20210106000413.GA28404@linux.intel.com>
 <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com>
Date: Thu, 07 Jan 2021 12:14:06 +0100
Message-ID: <119111.1610018046@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= via Xenomai <xenomai@xenomai.org>

Dear 孙世龙 sunshilong,

In message <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com> you wrote:
> >depends on your use case, maybe possible to add a raw disk, only used by
> >the time critical code?
> It seems a good solution.
> It's possible to add a raw disk.

This will not help you at all.  The key problem here is that common
storage devices (conventional rotating hard disk drives, SSD,
SDCards, eMMC, USB sticks, CF Cards, ....) are all not real-time
capable itself.

They all contain controllers to manage the storage device, and
strict real-time behaviour has never been a design criteria for the
firmware running on these controllers.

Rotating harddisks can do all kind of maintainance tasks, including
retries when they detect positioning and/or I/O errors,
re-allocation of defective sectores, recalibration, etc. Not to
mention that - depending on your configuration - they may even spin
down to save power and will need many seconds to spin up when waking
up.

All other storage devices are flash based, so the controller will
have to take care of wear levelling, trimming, garbage collection
etc.

Try to get any guaranteed data for response times from any of the
vendors of your prefereed sotage data (i. e. ask: what is the
_guaranteed_ maximum time between sending a read request for a
specific block of data and receiving this data on the interface?)
I would not expect any precise technical answers.


You can guarantee _average_ data for I/O to storage devices, like a
guaranteed sustained throughput (*), but you will not be able to
guarantee any hard real-time behaviour (like latencies or such).

(*) And this guarantee will hold only as long as you do not
encounter any errors on the storage device, which can _always_
happen, so your real-time processes should better not depend on it
if they control any critical equipment.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As long as we're going to reinvent the wheel again, we might as  well
try making it round this time.                        - Mike Dennison

