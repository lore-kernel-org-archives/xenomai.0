Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
Date: Wed, 24 Apr 2019 07:46:55 +0200
MIME-Version: 1.0
In-Reply-To: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
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
To: Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>

On 22.04.19 15:36, Alexander Sharabanov via Xenomai wrote:
> Hi All,
> 
> I am upgrading the linux kernel from linix kernel v2.6.30 to linux 3.16.61 (long tern support). Also I have upgraded the Xenomai and ipipe. I upgraded the xenomai to stable /v3.0.x (instead the Xenomai-2.4.10 that I used in old kernel), and ipipe-core-3.16-powerpc-1.patch. I have got the next error:  Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled. (modprobe xeno_native?). I do not see this options in new Xenomai. Could you please help me to resolve that.

The primary error seems that your userspace is still on 2.5 while the kernel 
part is now on 3.0.

Regarding the kernel and ppc: 3.16 will be dead soon as well (early next year), 
and we do not test against such old kernels anymore. We do not have an official 
ppc ipipe release newer than 4.4.71 or 4.9.51. The 4.9 kernel is no longer 
regularly updated, but 4.4 is - specifically via the STLS CIP kernel - and will 
continue to be.

However, ppc is not tested by me, not even build-tested anymore. If you validate 
ipipe-4.4.y[-cip] from https://gitlab.denx.de/Xenomai/ipipe/branches, I can do 
the tagging also for ppc (like I'm doing for arm if users report it works).

Steven, are you planning to refresh the kernel patches beyond that? How about 
adding CI build for ppc? We would need support on that topic. Otherwise, it's 
likely time to bury that arch, like it's happening all around.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

