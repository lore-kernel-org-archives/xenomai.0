Message-ID: <ec0d4873-ffbe-e679-4f1e-18ed862fcdb5@siemens.com>
Date: Tue, 1 Mar 2022 08:40:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] libtraceevent: Add Add xenomai_schedparams plugin for
 libtraceevent
Content-Language: en-US
References: <20220228054055.16112-1-hongzhan.chen@intel.com>
 <20220228054055.16112-5-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220228054055.16112-5-hongzhan.chen@intel.com>
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

On 28.02.22 06:40, Hongzhan Chen wrote:
> For cobalt thread, there is special struct param_ex data stored in
> data record, we need to parse and print its content out correctly
> to hint user when using libtraceevent.
> 

While libtraceevent can be used along with KernelShark, it's not bound
to it. You can also perfectly use it with pure command line tooling
(trace-cmd). That would make it interesting for your UI-free demo images
(xenomai-images). So I would recommand controlling its build
independently of KernelShark.

> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  configure.ac                                  |   1 +
>  kernel-shark/Makefile.am                      |   6 +-

Maybe call the top-level directory "tracing" instead.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

