Message-ID: <50EC7615.6060205@xenomai.org>
Date: Tue, 08 Jan 2013 20:40:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50ebff2e488690.18102992@wp.pl> <50EC2047.1060304@siemens.com>
In-Reply-To: <50EC2047.1060304@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/08/2013 02:33 PM, Jan Kiszka wrote:

> On 2013-01-08 12:12, Mariusz Janiak wrote:
>> Hi GIlles,
>>
>> As you suggested, I have prepared simple test case that demonstrate how Xenomai is utilized by OROCOS. This test case behaves exactly the same like helloword example. Scheduler is chosen before any mutex are processed, so in my opinion it is not the case which you defined. What is really surprising is that the replacing TM_NONBLOCK with TM_INFINITE, in one before last line, do magic and suppress signal generation. Furthermore, there is no call to 'rt_task_set_mode(0, T_WARNSW, NULL);' so why 
>> signal is generated? If we enable T_WARNSW in the thread, SIGXCPU is generated when mutex is locked first time in the thread. 
> 
> This should cure the issue (there was a check for XNTRAPSW missing):


No, the check is unconditional because if this happens this is a serious
bug which should be signalled to the user. This patches cures nothing.

-- 
                                                                Gilles.

