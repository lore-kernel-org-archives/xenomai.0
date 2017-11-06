From: Jan Melcher <mail@jan-melcher.de>
Message-ID: <0c161e7a-7bc3-1a06-4ccc-2386440a51d2@jan-melcher.de>
Date: Tue, 7 Nov 2017 00:10:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Xenomai] Docker / PID Namespaces in Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm trying to get Xenomai with Cobalt working with Docker. I think it
should be possible because processes in Docker containers are regular
Linux processes, with a few extras.

I specified the group set in xenomai.allowed_group via --group-add and
mounted the /dev/rtdm directory via |--device=/dev/rtdm:/dev/rtdm. (I
also needed to ignore the EWINCH signal, but that may be due to my
setup.) After doing this, I'm able to use the Xenomai/Cobalt APIs like
|rt_task_create.

However, rt_task_set_periodic/rt_task_wait_period does not work
(rt_task_wait_period just never returns). I figured this is because
Cobalt does not support PID namespaces. Can someone confirm this? Some
log outputs I added suggest that Cobalt is confusing namespace-local and
global PIDs.

My question is if you think that fixing PID namespaces would be
sufficent to support Docker with Cobalt.

Thanks in advance,
Jan


