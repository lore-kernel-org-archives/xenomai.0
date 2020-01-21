Subject: Re: Cobalt deadlock for no apparent reason
References: <VI1PR05MB5917D1906A1A32505BFE5168F6320@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d46517cf-88fb-2449-1a0c-5d4b87cb6e3d@siemens.com>
Date: Tue, 21 Jan 2020 18:45:56 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917D1906A1A32505BFE5168F6320@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 20.01.20 19:03, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I got a deadlock while running through gdbserver, this is an implementation of a synchronized queue,
> Fup side waits via condition variable, main wants to push data, but main fails to acquire the mutex.
> The mutex is an errorchecking type, without priority inheritance, and not used elsewhere.
> 
> 
> The task are as following:
> 
> CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
>    1  1686   rt     cobalt      4   -             Wt         main
>    3  1690   rt     cobalt      2   -             Wt         fup.medium
> 
> main is stuck in this function
> 
> int mutex_lock(struct mutex_data *pData)
> {
>      pthread_t threadId = pthread_self();
>      // assert(pthread_equal(threadId, pData->m_LockId) == 0);
> ->    int r = pthread_mutex_lock(&pData->m_Mutex);
>      assert(r == 0);
>      pData->m_LockId = threadId;
>      return r;
> }
> 
> In libcobalt:
>    do
>      ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
>    while (ret == -EINTR);
> 
> fup.medium is stuck in:
> 
> int conditionvar_wait(struct conditionvar_data *pData, struct mutex_data *pMutex)
> {
>      pthread_t sid = pthread_self();
>      assert(pthread_equal(sid, pMutex->m_LockId) != 0);
>      pMutex->m_LockId = 0;
> ->    int r = pthread_cond_wait(&pData->m_CondVar, &pMutex->m_Mutex);
>      assert(r == 0);
>      pMutex->m_LockId = sid;
>      return r;
> }
> 
> In libcobalt:
>    while (err == -EINTR)
>      err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);
> 

This is likely tricky to debug by just looking at things. Can you factor 
out a reproducer?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

