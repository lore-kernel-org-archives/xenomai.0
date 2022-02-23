Message-ID: <15f28a0f-c4bd-b737-5ba7-0aaf3d603456@siemens.com>
Date: Wed, 23 Feb 2022 07:51:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kernel-shark related patches
Content-Language: en-US
References: <20220222023101.31013-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220222023101.31013-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org
Cc: y.karadz@gmail.com

On 22.02.22 03:30, Hongzhan Chen wrote:
> 1. Add kernel-shark plugin to visualize OOB state of xenomai realtime
>    thread.
> 2. Add libtraceevent plugin to parse xenomai_schedparams correctly.
> 
> With the help of Yordan Karadzhov <y.karadz@gmail.com>, we finally
> create xenomai plugin and can build standalone. Thanks for his help
> again.
> 

So these build targets can basically live "anywhere" and are not
connected with our autoconf/automake build system of Xenomai.
Intentionally due to the more complex preparation steps?

Jan

> Hongzhan Chen (2):
>   Add xenomai_cobalt_switch_events plugin for kernel-shark
>   Add xenomai_schedparams plugin for libtraceevent
> 
>  kernel-shark/CobaltSwitchEvents.cpp         | 156 +++++++++++++++
>  kernel-shark/Makefile                       |  20 ++
>  kernel-shark/README                         |  81 ++++++++
>  kernel-shark/xenomai_cobalt_switch_events.c | 174 +++++++++++++++++
>  kernel-shark/xenomai_cobalt_switch_events.h |  58 ++++++
>  libtraceevent/Makefile                      |  31 +++
>  libtraceevent/README                        |  30 +++
>  libtraceevent/plugin_xenomai_schedparams.c  | 201 ++++++++++++++++++++
>  8 files changed, 751 insertions(+)
>  create mode 100644 kernel-shark/CobaltSwitchEvents.cpp
>  create mode 100644 kernel-shark/Makefile
>  create mode 100644 kernel-shark/README
>  create mode 100644 kernel-shark/xenomai_cobalt_switch_events.c
>  create mode 100644 kernel-shark/xenomai_cobalt_switch_events.h
>  create mode 100644 libtraceevent/Makefile
>  create mode 100644 libtraceevent/README
>  create mode 100644 libtraceevent/plugin_xenomai_schedparams.c
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

