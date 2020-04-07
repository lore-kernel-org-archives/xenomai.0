Subject: =?UTF-8?Q?Re=3a_Does_the_function_malloc=28=29_uses_the_real_malloc?=
 =?UTF-8?Q?_or_the_wrap_one_in_heapobj=5fpkg=5finit=5fprivate=28=ef=bc=89=2e?=
References: <CAAvDm6bD0n33+qGDny57N54SABDaMBSU+4PyY05moy3Yxn+7yQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f110409a-3042-4ca7-c6ec-1633090a9dc6@siemens.com>
Date: Tue, 7 Apr 2020 11:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bD0n33+qGDny57N54SABDaMBSU+4PyY05moy3Yxn+7yQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai@xenomai.org

On 07.04.20 11:13, 孙世龙 via Xenomai wrote:
> The source code url is
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/lib/copperplate/
> heapobj-heapmem.c  line:107
> 
> In the source code listed above, function heapobj_pkg_init_private()  calls
> malloc().
> I hope to know whether it calls the wrapper function or
> the real malloc function which provides by the glibc?
> 
> How could I distinguish a function directs to the wrapper function or
> the real one which provides by the glibc?
> 

(Transparent) wrapping only happens when an object is linked with the 
related options (-Wl,XXX.wrappers). Internal libs are not built like 
that (you can always check the build log), so the original malloc is called.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

