From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: I-pipe maintenance for 4.4 and 4.9
Message-ID: <0a8de54f-1534-8bd6-fed6-ff0bdb7fc77c@siemens.com>
Date: Tue, 30 Oct 2018 14:38:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

to clarify the current and planned maintenance situation for I-pipe on kernels 
*prior* to 4.14, I'd like explain a couple of things and also ask for support.


4.4
---
As we (Siemens) have a couple of products with Xenomai on 4.4 now, we plan to 
maintain the ipipe-4.4.y branch as LTS for "some more time" (very likely in 
order of years). That means, either I or Henning will push merges of Linux 
stable to [1] that have been tested on x86-64 and will also release new stable 
x86 versions.

4.4-LTS as maintained by Greg KH has a remaining life time of 3.5 years now. 
Therefore, I will eventually open up ipipe-4.4.y-cip based on the SLTS kernel 
from CIP [2] and switch the maintenance effort over to that kernel which will 
give us another 4 years at least. This will be announced separately soonish.

Along the merges, we will try hard to keep other arch working as well, but we 
will not test them. If you are interested in stable 4.4 releases for another 
arch, we will need testing feedback. Whenever there is a reasonably confident 
"works for me" report, we can also tag releases for non-x86 archs. I already 
received a commitment for ARM (32-bit) at ELC-E last week.


4.9
---
I've just also pushed another 4.9 stable merge to [3], and I'm planning to issue 
another x86 stable release for it. However, this may be the last or last-but-one 
release on this version: Once 4.14 is out also for 4.14-x86, the plan is to 
retire 4.9. If you have any deployments on 4.9 AND cannot migrate to 4.14 AND 
are willing to support maintenance of this branch with AT LEAST regular testing, 
speak up, and we can discuss options. But given our limited resources, I would 
really prefer to focus on at most 2 major versions, head (currently 4.14) and 
one (S)LTS (4.4 for now). This situation may improve as build and maybe even 
test automation evolves (topics of their own).


In general, if you are benefiting from these maintenance efforts, you should 
consider contributing to it. A rather easy way to do that is providing test 
feedback on updates. Of course, patches to address issues like regressions after 
updates or backports of ipipe changes in head that should go into stable as well 
are very welcome, too!

Jan

[1] https://gitlab.denx.de/Xenomai/ipipe/commits/ipipe-4.4.y
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
[3] https://gitlab.denx.de/Xenomai/ipipe/commits/ipipe-4.9.y

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

