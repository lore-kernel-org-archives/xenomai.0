Message-ID: <101092e1-5a8c-e1c8-294f-74bbb7c8a7b7@siemens.com>
Date: Tue, 15 Mar 2022 07:37:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v8 0/4] Kernel-Shark and libtraceevent plugins
Content-Language: en-US
References: <cover.1647252062.git.jan.kiszka@siemens.com>
 <MN2PR11MB4285978C7FA1A7D44A044D90F2109@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285978C7FA1A7D44A044D90F2109@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15.03.22 02:32, Chen, Hongzhan wrote:
> Looks good to me. Thanks for your help.
> 

Thanks for your effort! The last "few percentages" to get
autoconf/automake integration were indeed tougher than I thought.

Jan

> Regards
> 
> Hongzhan Chen
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Monday, March 14, 2022 6:01 PM
> To: xenomai@xenomai.org
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>
> Subject: [PATCH v8 0/4] Kernel-Shark and libtraceevent plugins
> 
> Changes in v8:
>  - drop explicit deps again - no longer unneeded after refreshing local
>    libtracecmd installation
> 
> Changes in v7:
>  - reworked installation
>  - fixed build of kernelshark plugin (missing dep)
>  - dropped applied first patch
> 
> Jan
> 
> 
> CC: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> Hongzhan Chen (3):
>   build: add options to build plugins of kernelshark and libtraceevent
>   KernelShark: Add xenomai_cobalt_switch_events plugin for KernelShark
>   libtraceevent: Add xenomai_schedparams plugin for libtraceevent
> 
> Jan Kiszka (1):
>   libs: Silence installation output of libtool
> 
>  Makefile.am                                   |   4 +
>  configure.ac                                  |  35 ++++
>  lib/alchemy/Makefile.am                       |   2 +
>  lib/analogy/Makefile.am                       |   2 +
>  lib/cobalt/Makefile.am                        |   2 +
>  lib/copperplate/Makefile.am                   |   2 +
>  lib/mercury/Makefile.am                       |   3 +-
>  lib/psos/Makefile.am                          |   2 +
>  lib/smokey/Makefile.am                        |   2 +
>  lib/trank/Makefile.am                         |   3 +-
>  lib/vxworks/Makefile.am                       |   2 +
>  tracing/Makefile.am                           |  13 ++
>  tracing/README                                |  84 +++++++++
>  tracing/kernelshark/CobaltSwitchEvents.cpp    | 156 ++++++++++++++++
>  tracing/kernelshark/Makefile.am               |  20 ++
>  .../xenomai_cobalt_switch_events.c            | 174 ++++++++++++++++++
>  .../xenomai_cobalt_switch_events.h            |  58 ++++++
>  tracing/libtraceevent/Makefile.am             |  19 ++
>  .../plugin_xenomai_schedparams.c              | 158 ++++++++++++++++
>  19 files changed, 739 insertions(+), 2 deletions(-)
>  create mode 100644 tracing/Makefile.am
>  create mode 100644 tracing/README
>  create mode 100644 tracing/kernelshark/CobaltSwitchEvents.cpp
>  create mode 100644 tracing/kernelshark/Makefile.am
>  create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.c
>  create mode 100644 tracing/kernelshark/xenomai_cobalt_switch_events.h
>  create mode 100644 tracing/libtraceevent/Makefile.am
>  create mode 100644 tracing/libtraceevent/plugin_xenomai_schedparams.c
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

