References: <ce09c464-b17f-a977-2638-c0fb1f3bcdf4@yeah.net>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [CXP] some questions about "Common Xenomai Platform"
In-reply-to: <ce09c464-b17f-a977-2638-c0fb1f3bcdf4@yeah.net>
Date: Sun, 03 Jan 2021 18:38:04 +0100
Message-ID: <874kjxrkeb.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hailongliu <hailongliiu@yeah.net>
Cc: xenomai@xenomai.org


Hailongliu via Xenomai <xenomai@xenomai.org> writes:

> Hi,
>
> I learned the "Common Xenomai Platform" program from this mail-list and wiki
> of project Xenomai. This is a very attractive plan, as it will port Xenomai for
> recent LTS kernel(v5.10).
>
> I noticed that  March 31, 2021 is the deadline for "CXP", dose that mean we
> can expect the new features at Xenomai-3.3 ?

Yes, that is the plan. Xenomai 3.3 is going to be the first release
fully implementing the CXP. Xenomai 4 which is going to use a different
real-time core will be developed in parallel to Xenomai 3.3, aiming at
CXP-compliance too. It should be clear that March 31, 2021 is the date
for completing the CXP specification, not that of any release
implementing it, which can only happen later by definition.

> I also concern about that how long Xenomai-3.3 will be live? And if there
> will be a long term version with kernel-v5.10 for Xenomai?
>

Xenomai will run v5.10 LTS as soon as release 3.2, based on the ongoing
port of the Cobalt core to Dovetail.

How long a particular Xenomai release is maintained for a particular
kernel version currently depends on a few individuals and companies
having a specific requirement to keep such port alive, and contributing
to this task directly (doing the work) or indirectly (funding someone
else's work).

Although there is a commitment to run Xenomai 3.x on top of kernel v5.10
asap, I'm not aware of any formal commitment of any current contributor
to maintain this port for a pre-defined period of time. One may only
assume that by picking a LTS kernel like v5.10, we are likely going to
maintain it "for some time".

-- 
Philippe.

