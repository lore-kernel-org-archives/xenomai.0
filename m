From: Wolfgang Denk <wd@denx.de>
Subject: Re: [CXP][RFC] Pick RTDM for the common kernel interface
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <CALLqZ8TdQLXAxAfDgFUZb9YhhkqZxxmrOOJ83gKYvAokJss9fg@mail.gmail.com>
References: <87pn3mzxeh.fsf@xenomai.org>
 <5700bc80-fb99-0420-a386-13c0cab91c6e@siemens.com>
 <CALLqZ8TdQLXAxAfDgFUZb9YhhkqZxxmrOOJ83gKYvAokJss9fg@mail.gmail.com>
Date: Tue, 15 Dec 2020 13:30:15 +0100
Message-ID: <491348.1608035415@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Greg Gallagher via Xenomai <xenomai@xenomai.org>

Dear Greg,

In message <CALLqZ8TdQLXAxAfDgFUZb9YhhkqZxxmrOOJ83gKYvAokJss9fg@mail.gmail.com> you wrote:
>
> The compatibility with RTDM I think makes a lot of sense.  I think the goal
> should be if someone as a current RTDM driver there would be minimal change
> to move it to a new version of Xenomai 3.x or 4.  As we start on this work
> it may be a great time for people to get involved and help maintain some of
> the existing drivers.

...or obsolete them by providing the needed functionality in mainline
drivers, ACK.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If the facts don't fit the theory, change the facts.
                                                   -- Albert Einstein

