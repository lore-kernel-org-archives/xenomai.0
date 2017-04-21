References: <6131f754.4617.15b894b92f8.Coremail.dreamtale90@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3683be1c-4616-bda9-a7aa-d8ebf94aeecc@xenomai.org>
Date: Fri, 21 Apr 2017 16:47:32 +0200
MIME-Version: 1.0
In-Reply-To: <6131f754.4617.15b894b92f8.Coremail.dreamtale90@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] About the use of rt_task_delete API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "dreamtale90@163.com" <dreamtale90@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/20/2017 04:58 AM, dreamtale90@163.com wrote:
> *I'm now manually memset task variable,  but I still want to do it in
> the xenomai library
> to make more people less detours.


No, you are wrongly assuming that a task descriptor should still contain
consistent data after a cancellation request is applied to it; such
guarantee does not exist. This means that using rt_task_inquire() to
figure out whether a task was deleted is wrong as well. A task
descriptor is deemed consistent after a successful call to
rt_task_create/spawn(), until that task exits, for whatever reason,
voluntarily or not.

The same goes with the POSIX nptl interface, which may recycle the
memory which the pthread_t handle refers to at some point after a
cancellation request is issued with this handle. That memory is managed
into an internal cache, part of which may even be unmapped from the
process's address space in order to shrink an overpopulated cache.
Therefore, using a stale handle in requests would at best cause the
process to crash when referring to invalid memory, or return
inconsistent data pulled from reused memory.

-- 
Philippe.

