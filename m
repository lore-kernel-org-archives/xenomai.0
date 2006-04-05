Message-ID: <44344E6C.3070305@domain.hid>
Date: Wed, 05 Apr 2006 19:10:36 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Doxygen fails to document rt_task_send() and friends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I just noticed that doxygen doesn't seem to document rt_task_send(), 
rt_task_receive() and rt_task_reply() anymore (e.g. 
http://www.xenomai.org/documentation/branches/v2.1.x/html/api/group__task.html).

The problem seems to be due to a "#ifdef CONFIG_XENO_OPT_NATIVE_MPS" 
command in "/ksrc/skins/native/task.c". Sorry, no patch for now...

Vincent Levesque
vleves@domain.hid




