From: Wolfgang Denk <wd@denx.de>
Subject: Re: Is it possible to implement a real-time API to read the files on
 the disk?
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
In-reply-to: <CAAvDm6ZsQwrFoLfjnespyx65cmzWgYXGk=dyUE_UD5-dAUKaNQ@mail.gmail.com>
References: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
 <20210106000413.GA28404@linux.intel.com>
 <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com>
 <119111.1610018046@gemini.denx.de>
 <CAAvDm6ZsQwrFoLfjnespyx65cmzWgYXGk=dyUE_UD5-dAUKaNQ@mail.gmail.com>
Date: Thu, 14 Jan 2021 17:55:33 +0100
Message-ID: <212749.1610643333@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmcgdmlhIFhlbm9tYWk=?= <xenomai@xenomai.org>, Fino Meng <fino.meng@linux.intel.com>

Dear 孙世龙 sunshilong,

In message <CAAvDm6ZsQwrFoLfjnespyx65cmzWgYXGk=dyUE_UD5-dAUKaNQ@mail.gmail.com> you wrote:
>
> >You can guarantee _average_ data for I/O to storage devices, like a
> >guaranteed sustained throughput (*), but you will not be able to
> >guarantee any hard real-time behaviour (like latencies or such).
> It seems that real-time OS could not guarantee a hard real-time
> behaviour for reading files.
>
> Two more questions arise:
> 1. A lot of real-time applications based on Xenomai have to meet this
>  problem (i.e reading files), how do you solve it?
> Reading files by non-rt thread and sending the data(or the pointer to
> the data) to the rt thread by XDDP?

Yes, use another task (process or thread).

> 2.Can I draw the conclusion that there is no real-time OS that could
> guarantee a hard real-time behaviour for reading?

Thisis correct, assuming "reading" means reading from conventional
rotating hard disks, SSD drives or any other kind of NAND flash
based storage devices (USB sticks, eMMC, SDCard, CompactFlash
etc.).  None of these devices guarantee any RT capabilites (*).

(*) As far as I can tell; there may be special models with
alternative firmware which is tailored for RT responses -
technically that would be possible, but I have never seen any such
thing, and a quick search on your favorite search engine comes up
empty.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It may be bad manners to talk with your mouth full, but it isn't  too
good either if you speak when your head is empty.

