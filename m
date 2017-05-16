References: <CALC3Xwp-pSsQ+hF6bZFyT7BCrTOE2o0G4A3_hgD7o4i=9hdO7Q@mail.gmail.com>
 <8ddcffac-78ab-3933-f5bf-1352f1af6a1d@xenomai.org>
 <CALC3Xwp0soSABRS12_3V8OEfNY_18eR5mB_qZqR9MTsdfq5WMA@mail.gmail.com>
 <CALC3XwoXJ2f6btgkOt2nJ4z1KGf=bB4g=0bE6w7jZfQD42jkRA@mail.gmail.com>
 <CALC3XwoytMPBagjtb8eHd7HxVmbqPE4ck1woX8sWNwR_rXfz5A@mail.gmail.com>
 <da41a276-60bc-7672-947d-2aa931c79606@xenomai.org>
 <CALC3XwrU04LeWBCWnuaHhEfgwakMeXAJ2OkRi+LgmUEdP5zPqQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <72f2aa94-733d-76cb-d40b-1f4c9cd97720@xenomai.org>
Date: Tue, 16 May 2017 11:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <CALC3XwrU04LeWBCWnuaHhEfgwakMeXAJ2OkRi+LgmUEdP5zPqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Problem with the priority of the task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Aur=c3=a9lien_Le_Floc'h?= <le.floch.aurelien94@gmail.com>, xenomai@xenomai.org

On 05/15/2017 11:37 AM, Aurélien Le Floc'h wrote:
> Thanks for your answer.
> I stock the output result in a string but the results are exactly the
> same. I attached my code.
> Do you have an idea to solve this problem ?

Any improvement with this patch in?

diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
index 2549ab0..1d96526 100644
--- a/lib/copperplate/internal.c
+++ b/lib/copperplate/internal.c
@@ -239,14 +239,14 @@ static void *thread_trampoline(void *arg)
 	 * with the cleanup code the client may run whenever
 	 * copperplate_create_thread() fails.
 	 */
-	prepare_wait_corespec();
-	__RT(sem_post(&cta->__reserved.warm));
-	thread_spawn_wait(&released);
-	__RT(sem_destroy(&released));
 	ret = __bt(copperplate_renice_local_thread(pthread_self(),
 			   _cta.policy, &_cta.param_ex));
 	if (ret)
 		warning("cannot renice core thread, %s", symerror(ret));
+	prepare_wait_corespec();
+	__RT(sem_post(&cta->__reserved.warm));
+	thread_spawn_wait(&released);
+	__RT(sem_destroy(&released));
 
 	return _cta.run(_cta.arg);
 fail:

-- 
Philippe.

