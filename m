Message-ID: <54D1E2AA.40000@xenomai.org>
Date: Wed, 04 Feb 2015 10:13:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3 - no skin detected in program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>, xenomai@xenomai.org

On 02/04/2015 09:55 AM, Huy Cong Vu wrote:
> Hello everyone, 
> I recently try to run an application compiled in native skin of Xenomai 3. When trying to run the binary, these line appeared: 
> WARNING: [main] no skin detected in program 
> BUG: [main] initialization failed, EINVAL 
> I know that this is a cooperplate_init() warning when trying to initialize native skin, but I don't understand the reason why: 
> if (pvlist_empty(&skins)){ 
> warning("no skin detected in program"); 
> ret = -EINVAL; 
> goto fail; 
> } 

It seems that your application was not linked against libalchemy.so.
When API libraries are properly linked in, internal constructor routines
populate this list. POSIX support is built-in within the Cobalt
interface, so it won't appear here though.

You may want to check this with ldd.

> In my main(), there are still native API calls: 
> rt_print_auto_init(1); 
> rt_task_spawn(...); 
> rt_task_join(...); 
> rt_task_delete(...); 
> with mlockall also just to make sure, even I know that is pre-initialize since Xenomai 2.6. 
> I have xenomai-3-next patched on linux-3.14.17, here are my compilation flags: 
> cflags: 
> xeno-config --alchemy --cflags 
> xeno-config --rtdm --cflags 
> ldflags: 
> xeno-config --alchemy --ldflags 
> xeno-config --rtdm --ldflags 

You should not mention --rtdm for userland apps, this is useless for
Xenomai 3. This has been kept for compatibility purpose with existing
application Makefiles targeting Xenomai 2.x.

> 
> This issue is not reproduced with posix skin, I know that there are a mechanism change in the way Xenomai invoke function calls other than POSIX (alchemy, vxworks...): 
> https://xenomai.org//migrating-from-xenomai-2-x-to-3-x/#Copperplate_auto-initialization 
> Is this related with my issue? Is there anything I should add to my initialization process that I didn't know about? 
> Thanks for your time, 
> 

Check lib/alchemy/testsuite for a working Makefile you could derive
yours from.

-- 
Philippe.

