Date: Wed, 16 Apr 2014 14:22:26 +0200
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
References: <20140415144247.9126D1A5@centrum.cz> <534E4885.3060400@xenomai.org>
In-Reply-To: <534E4885.3060400@xenomai.org>
MIME-Version: 1.0
Message-Id: <20140416142226.659BA9DF@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] =?utf-8?q?non-blocking_rt=5Ftask=5Fsuspend=28NULL=29?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
> CC: "Xenomai" <xenomai@xenomai.org>
>On 04/15/2014 02:42 PM, Petr Cervenka wrote:
>> Hello I have a problem with the rt_task_suspend(NULL) call. I'm using
>> it for synchronization of two (producer / consumer like) tasks. 1)
>> When the consumer task has no work to do, it stops itself by calling
>> of the rt_task_suspend(NULL). 2) When the producer creates new work
>> for consumer, it wakes it up by calling of
>> rt_task_resume(&consumerTask). The problem is, that consumer seldom
>> switches to a state, that it sleeps by rt_task_suspend no more. And
>> the task then takes all the CPU time. The return code is 0. But I
>> already have seen couple of -4 (-EINTR) values in the past also.
>> Consumer task status was 00300380 before and 00300184 (if there is
>> small safety sleep present). I can use for example RT_EVENT variable
>> instead, but I'm curious if you by chance don't know, what is
>> happening? Xenomai 2.6.3, Linux 3.5.7
>
>Could you post the example of code you are using to get this issue?
>

It's and application with many threads, mutexes and others. It's also special measuring HW dependent. I can post here some simplified example. But I don't think it would be possible to reproduce the same behavior easily. It happens in my configuration only probably once per day and very unpredictably.
But I have more details. I replaced rt_task_suspend / rt_task_resume by rt_event_wait / rt_event_signal. It failed similar way, but this time the result of wait was -4 (-EINTR). And (after several millions of invocations) it recovered itself.

// consumer task -----------------------------------------------------------------------------
void CAsyncReaderWriter::taskCycle() {
    unsigned long eventMask;
    while (!terminated) {
        // wait for new data !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //int res = rt_task_suspend(NULL);
        int res = rt_event_wait(&event, EVENT_READ | EVENT_WRITE | EVENT_END, &eventMask, EV_ANY, TM_INFINITE);

        if (res < 0) {
            LOG_PRINT("wait result: %d (%s)\n", res, strerror(-res));
        }

        rt_event_clear(&event, EVENT_READ | EVENT_WRITE | EVENT_END, NULL);

        // synchronized data processing with checking of the "terminated" flag
        rt_mutex_acquire(&mutex, TM_INFINITE);
        while (!terminated && !dataQueue.empty()) {
            TDataElement *dataElement = dataQueue.pop_front();
            rt_mutex_release(&mutex);

            // slow work including hard disk usage
            ...

            rt_mutex_acquire(&mutex, TM_INFINITE);
            // return free data element
            freeData.push_back(dataElement);
        }
        rt_mutex_release(&mutex);
        
        // safety sleep added after some freezes caused by 100% CPU load
        rt_task_sleep(rt_timer_ns2ticks(100000));
    }
}

// called from producer -------------------------------------------------------------------------
void CAsyncReaderWriter::write(const TParams &params) {
    TDataElement *dataElement = NULL;

    // get free element
    rt_mutex_acquire(&mutex, TM_INFINITE);
    if (freeData.empty()) {
        rt_mutex_release(&mutex);
        throw std::runtime_error(ERRORMSG("no free data elements"));
    }
    dataElement = freeData.back();
    freeData.pop_back();
    rt_mutex_release(&mutex);

    // copy params
    dataElement->params = params;

    // add to circle buffer
    rt_mutex_acquire(&mutex, TM_INFINITE);
    if (dataQueue.full()) {
        freeData.push_back(dataElement);
        rt_mutex_release(&mutex);
        throw std::runtime_error(ERRORMSG("data queue is full"));
    }
    dataQueue.push_back(dataElement);
    rt_mutex_release(&mutex);

    // wake-up task !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //rt_task_resume(&task);
    rt_event_signal(&event, EVENT_WRITE);
}

