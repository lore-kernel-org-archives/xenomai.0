Subject: Re: open XDDP from nrt thread
References: <fea9dfd7-d28e-da96-f230-2a585da5cc84@iit.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bffef7ff-f2a3-b8ec-5f8a-958f688b36a5@siemens.com>
Date: Wed, 2 Oct 2019 11:40:37 +0200
MIME-Version: 1.0
In-Reply-To: <fea9dfd7-d28e-da96-f230-2a585da5cc84@iit.it>
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
To: alessio margan <alessio.margan@iit.it>, xenomai@xenomai.org

On 02.10.19 10:08, alessio margan via Xenomai wrote:
> Hi all,
> 
> it seems that at some point ( following branch next up to rc1) something is 
> changed regarding XDDP .
> 
> I've got a process that spawn 2 rt-thread and a nrt-thread, one of the 2rt  
> produce data that the nrt consume using an XDDP
> 
> Since 4.14.89-xeno-ipipe-stableVx everything works, now on rc1 I can not open 
> the pipes as usual.

These are two things: the kernel/ipipe version and the Xenomai version. Can you 
narrow this down a bit? Does it work for you with 3.0.9 and/or stable/3.0.x? Was 
there an older revision in master (3.1.x) that worked?

Alternatively, please provide a test case that we can try. Might be based on 
testsuite/smokey/xddp/xddp.c, but maybe already looking at that explains the 
problem.

Jan

> 
> There is something I have missed ?
> 
> These are the pipes
> 
> ls -la /proc/xenomai/registry/rtipc/xddp/
> total 0
> dr-xr-xr-x 2 root root 0 ott  2 09:06 .
> dr-xr-xr-x 3 root root 0 ott  2 09:06 ..
> lrwxrwxrwx 1 root root 9 ott  2 09:06 debugOut -> /dev/rtp3
> lrwxrwxrwx 1 root root 9 ott  2 09:06 emergency -> /dev/rtp0
> lrwxrwxrwx 1 root root 9 ott  2 09:06 NoNe@Motor_id_1 -> /dev/rtp4
> lrwxrwxrwx 1 root root 9 ott  2 09:06 repl_in -> /dev/rtp1
> lrwxrwxrwx 1 root root 9 ott  2 09:06 repl_out -> /dev/rtp2
> 
> TIA
> 
> Alessio
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

