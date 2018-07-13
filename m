From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a59535aa-62e7-7b74-c334-92b72d674558@siemens.com>
Date: Fri, 13 Jul 2018 19:48:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] pthread_setschedparam(invalid_thread)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

this pattern causes a kernel crash:

int main()
{
	struct sched_param schedpar;

	schedpar.sched_priority = 1;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &schedpar);
	pthread_setschedparam(0x1234, SCHED_FIFO, &schedpar);
	return 0;
}

The second, invalid setschedparam makes the core try to shadow the
current thread - which is already shadowed - and that fails and then
causes a failure in the error cleanup path. But one after the other.

The semantic of pthread_setschedparam(unknown_remote_thread) should be
to just invoke the plain glibc function for that thread. But right now
the core's pthread_setschedparam_ex has no chance to tell a request to
promote the current thread to a shadow apart from a request on an
unknown (or invalid) remote thread ID. We would need to extend the
syscall ABI for that, I'm afraid (pass down pthread_self() as well). Any
better ideas?

The actual crash I'm seeing is related to cobalt_thread_shadow() running
over primary mode, failing with cobalt_map_user() (obviously), and then
calling pthread_discard() -> __xnthread_discard() which finally detects
the wrong caller mode. I guess we want secondary_mode_only() also in
cobalt_map_user() or cobalt_thread_shadow().

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

