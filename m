From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: pthread_setschedprio and __SCHED_CURRENT
Message-ID: <350537f4-4d38-d2d0-e9fc-4d5e7ffaf97d@siemens.com>
Date: Wed, 27 Nov 2019 17:13:04 +0100
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Philippe,

fortunately before we set the new ABI into stone, I just discovered flaw 
in my pthread_setschedparam_ex(__SCHED_CURRENT) approach for modelling 
pthread_setschedprio: It breaks over non-trivial policies like SCHED_QUOTA.

Userspace would have to query all current policy parameters of the 
target thread first in order to just update the priority in param_ex. 
Currently, it sends down bogus values via the setschedparam_ex call.

I could work around this by handling __SCHED_CURRENT even more special 
in the kernel or - which I'm leaning to ATM - introduce a real 
setschedprio syscall.

What do you think?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

