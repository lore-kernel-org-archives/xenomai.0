Subject: Re: [PATCH 0/8] Assorted fixes
References: <20200131152713.1811748-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
Date: Fri, 31 Jan 2020 16:55:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 31.01.20 16:27, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The first four commits fix the doc generation which has been broken
> for some time, the rest addresses runtime issues detected in the
> field. See commit logs for details.

Thanks for the fixes. Patch 3 needs folding - or we simply drop it.

For the other issues: I suppose we need more torture tests...

Jan

> 
> These patches are on top of the master branch.
> 
> Philippe Gerum (8):
>    doc: fix assorted Doxygen warnings
>    doc: do not discard pdflatex output
>    build: fix make distcheck
>    doc: fix asciidoc generation
>    cobalt/registry: fix export/unexport race on object deletion
>    cobalt/registry: prevent use-after-free triggered by object removal
>    drivers/ipc: bufp: fix rd/rd and wr/wr races
>    boilerplate: setup: fix infinite loop in CPU list parser
> 
>   Makefile.am                                   | 13 ++++-
>   configure.ac                                  |  2 +-
>   doc/asciidoc/Makefile.am                      |  8 ++--
>   doc/doxygen/Makefile.am                       |  2 +-
>   doc/doxygen/xeno3prm-common.conf.in           | 13 ++---
>   include/cobalt/kernel/registry.h              |  5 +-
>   .../cobalt/kernel/rtdm/analogy/subdevice.h    |  2 -
>   include/cobalt/kernel/rtdm/driver.h           |  6 +--
>   include/cobalt/kernel/stat.h                  |  2 +-
>   include/cobalt/kernel/timer.h                 |  2 -
>   include/rtdm/uapi/can.h                       |  4 +-
>   kernel/cobalt/registry.c                      | 48 ++++++++++++-------
>   kernel/cobalt/rtdm/device.c                   |  2 +-
>   kernel/cobalt/timer.c                         |  3 ++
>   kernel/drivers/ipc/bufp.c                     | 26 ++++++----
>   lib/boilerplate/setup.c                       |  3 +-
>   16 files changed, 84 insertions(+), 57 deletions(-)
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

