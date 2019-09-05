Subject: Re: Kernel compilation error
References: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9344a542-3ca7-ea83-4b4a-a744d1d48b39@siemens.com>
Date: Thu, 5 Sep 2019 18:23:18 +0200
MIME-Version: 1.0
In-Reply-To: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
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
To: davy.regneau@univ-grenoble-alpes.fr, xenomai@xenomai.org
Cc: frederic.cazenave@ird.fr

On 05.09.19 18:07, Davy via Xenomai wrote:
> Hi,
> 
> we have 4.9.90 linux kernel patched with xenomai 3.0.9 and patched with
> ipipe  V4.x.

There is no "ipipe V4.x" - what exactly do you mean?

> 
> When we try to compile a simple module we have lot of errors. the first
> one is :
> error: 'struct ipipe_threadinfo' has no member named 'ptd'
> 
> As mentioned by Paolo in response to a similary issue, we tryed to set
> CONFIG_IPIPE_LEGACY=y in kernel config but now we are not able to compile
> the kernel. we have the following message :
> 
> IPIPE_ROOT_NPTDKEYS not define in sched.h
> 
> Could you give us some clues to fix our problem?

Is the build error with the kernel or with an out-of-tree kernel module?

Note that 4.9 no longer receives official I-pipe updates. Current LTS kernels 
are 4.4 and 4.19. But even then your are on a suboptimal version with .90 
because the last release was ipipe-core-4.9.146-x86-8 (assuming we are talking 
about x86, not some other arch).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

