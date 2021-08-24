Subject: Re: [PATCH 3/6] cobalt/registry: Adding a new xnptree for exporting
 posix entries
References: <20210823150031.78791-1-florian.bezdeka@siemens.com>
 <20210823150031.78791-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <748e9fd5-1e84-ac49-32aa-2a368f8a880e@siemens.com>
Date: Tue, 24 Aug 2021 07:47:42 +0200
MIME-Version: 1.0
In-Reply-To: <20210823150031.78791-4-florian.bezdeka@siemens.com>
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

On 23.08.21 17:00, Florian Bezdeka wrote:
> Will be used later for exporting named semaphores as well as mqueues
> to /proc/xenomai/registry/posix/{mqueue,sem}
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/registry.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
> index 211e0f76f..3c67b64e6 100644
> --- a/kernel/cobalt/registry.c
> +++ b/kernel/cobalt/registry.c
> @@ -73,6 +73,8 @@ static int proc_virq;
>  
>  static struct xnvfile_directory registry_vfroot;
>  
> +DEFINE_XNPTREE(posix_ptree, "posix");
> +
>  static int usage_vfile_show(struct xnvfile_regular_iterator *it, void *data)
>  {
>  	xnvfile_printf(it, "%u/%u\n",
> 

Better let kernel/cobalt/posix/process.c carry this.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

