References: <CAD5jUk-DyMgNffkgzvvmbm3+LtceXBnRSoFL0=YwYw7_BCk6yA@mail.gmail.com>
 <CALLqZ8REcWEpxdAg8V5DxAgOrrofpnb-moAHg46Epv5DvBY1+w@mail.gmail.com>
 <3286435f-71ae-874d-72a5-5a7cbef0d550@siemens.com>
 <CAD5jUk-CijJ=LhouoHwwS2ZX=gmqjR7a_fWczYWFu9ze6PLqrQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <98ffbeee-f346-69ba-0f15-41d617d31a3c@xenomai.org>
Date: Tue, 19 Jun 2018 16:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAD5jUk-CijJ=LhouoHwwS2ZX=gmqjR7a_fWczYWFu9ze6PLqrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe-4.4.y LTS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Radu Rendec <radu.rendec@gmail.com>, jan.kiszka@siemens.com
Cc: xenomai@xenomai.org

On 06/19/2018 03:55 PM, Radu Rendec wrote:
> On Tue, Jun 19, 2018 at 3:09 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 2018-06-18 15:59, Greg Gallagher wrote:
>>> Are there still plans to have a ipipe patch for the CIP kernel?  I
>>> think this was brought up at the last meet up?  Maybe the bigger
>>> question (which is a lot more work) is do we plan on maintaining ipipe
>>> for 4.4, 4.9 and older?
>>
>> Yes, there are plans to go over 4.4-CIP. So far, I'm only maintaining
>> based on 4.4-LTS, just tested on x86, pushed to
>> https://lab.xenomai.org/ipipe-jki.git/log/?h=for-upstream/4.4-update.
>> Would be happy to receive contributions in form of tests on other
>> architectures!
> 
> That's great news! Thanks for the hard work! I'm targeting powerpc, so I
> will probably get back with some test results during the next couple of
> weeks.
> 
> Looking at the history in Jan's tree, it seems "for-upstream/4.4-update"
> is updated quite often. Perhaps it would be a good idea to keep the
> ipipe-4.4.y branch in sync or at least advertise Jan's tree on the
> Xenomai website. It would be useful for people like me who are interested
> in a recent 4.4-LTS version of ipipe.

Jan as Master mode access to [1], a 4.4 LTS branch may be maintained
directly there.

[1] https://gitlab.denx.de/Xenomai/ipipe.git

-- 
Philippe.

