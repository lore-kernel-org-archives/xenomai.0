References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org> <55DC87AB.2040306@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DC940C.4000408@siemens.com>
Date: Tue, 25 Aug 2015 18:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <55DC87AB.2040306@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, xenomai@xenomai.org

On 2015-08-25 17:20, Jorge Ramirez Ortiz wrote:
> On 08/25/2015 10:08 AM, Philippe Gerum wrote:
>> On 08/25/2015 02:13 AM, Don Mahurin wrote:
>>> Hi all,
>>>
>>> We would like to submit our current work on the arm64 port of
>>> ipipe/xenomai. We hope that this contribution will encourage further
>>> development of arm64 support in ipipe/xenomai.
>>>
>>
>> arm64 support is definitely a high priority item. Thanks for tackling this.
> 
> There are a numbers of cheap (<100USD) and well documented aarch64 boards [1]
> that could be used as a reference platform (different SoC vendors)
> I'd suggest we use Qualcomm's Dragon 410c.

The Qualcomm thing is pretty ugly beast, using a proprietary interrupt
controller instead of the standard GIC as strongly recommended by ARM.
As an ARM kernel developer recently put it when I asked about this
board: "I prefer the Raspberry Pi2 over that one." And the Pi2 is
already broken in its design.

The HiKey looks better in this regard, but one has to check which of the
mentioned boards are already upstream (or very close to this). Same for
uboot support. No one should hack on vendor trees any more.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

