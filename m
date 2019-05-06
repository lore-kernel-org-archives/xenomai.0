From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: rtdm_task_init vs. supported_cpus
Message-ID: <e57c2c94-b593-ecee-6108-097929a96ee7@siemens.com>
Date: Mon, 6 May 2019 17:02:45 +0200
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

while playing with maxcpus on x86, I ran into one issue again that I think I saw 
already but forgot to dig into back then: When an RTDM driver happens to create 
a kernel task (rtdm_task_init) on a support outside of xenomai.supported_cpus, 
we will crash. That may happen because that command is run over module_init, or 
any other context that is not a Xenomai-blessed Linux task with therefore 
constraint affinity mask.

Any suggestions how to resolve that best? Restrict the affinity of the 
rtdm_task_init caller? Permanently or maybe just temporarily? Or is there some 
way to resolve that deeper inside xnthread_* APIs?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

