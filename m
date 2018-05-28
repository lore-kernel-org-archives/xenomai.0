From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9c717071-fc03-1ba8-f6ff-9d6f131bd52d@siemens.com>
Date: Mon, 28 May 2018 20:51:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] syncobj_wait_grant vs. signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

struggling with an internal implementation on top of copperplate's
syncobj_wait_grant, I was wondering if that function is supposed to
return -EINTR on signal interruptions. It's mercury variant will not
because it used pthread_cond_wait internally. The cobalt version does,
and now I need to decide where to handle that best.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

