Subject: Re: [RFC PATCH 0/4] Export mqueues to procfs
References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <88684359-fe65-3f5a-362c-a5dd30584860@siemens.com>
Date: Wed, 18 Aug 2021 13:41:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210818112407.12264-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 18.08.21 13:24, Florian Bezdeka wrote:
> Hi,
> 
> this is another try to make registered mqueues visible. This time by
> exporting them to the procfs, namely to
> /proc/xenomai/registry/mqueue/<name>
> 
> Let me know what you think... 
> 
> I had to rework the existing export machinery a bit to get rid of the so
> called "root" directory which is normally created. See patch
> descriptions for details.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (4):
>   cobalt/registry: Make the root directory for proc exports optional
>   cobalt/registry: Share xnregistry_vfreg_ops with other compile units
>   cobalt/registry: Initialize refcnt of exported virtual proc files
>   cobalt/mqueue: Export created mqueues to procfs
> 
>  include/cobalt/kernel/registry.h |  2 ++
>  kernel/cobalt/posix/mqueue.c     | 35 +++++++++++++++++++++++++++++++-
>  kernel/cobalt/registry.c         | 13 ++++++------
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 

Will have a look.

We likely then also want the same for pshared semaphores, right?
Anything else that could get a name (which may collide or become orphaned)?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

