Message-ID: <61532.205.250.209.80.1143236098.squirrel@domain.hid>
Date: Fri, 24 Mar 2006 13:34:58 -0800 (GMT+8)
From: "Igor Cheifot" <icheifot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Compilation errors
Reply-To: icheifot@domain.hid
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

Hi
I get the following compilation errors when trying to compile 2.6.15 with
Xenomai support

Please let me know if you have any ideas how to fix this

I'm using GCC-4.1.0

kernel/xenomai/skins/rtai/built-in.o: In function `rt_task_delete':
: multiple definition of `rt_task_delete'
kernel/xenomai/skins/native/built-in.o:: first defined here
ld: Warning: size of symbol `rt_task_delete' changed from 289 in
kernel/xenomai/skins/native/built-in.o to 262 in
kernel/xenomai/skins/rtai/built-in.o
kernel/xenomai/skins/rtai/built-in.o: In function `rt_task_suspend':
: multiple definition of `rt_task_suspend'
kernel/xenomai/skins/native/built-in.o:: first defined here
ld: Warning: size of symbol `rt_task_suspend' changed from 360 in
kernel/xenomai/skins/native/built-in.o to 316 in
kernel/xenomai/skins/rtai/built-in.o
kernel/xenomai/skins/rtai/built-in.o: In function `rt_task_resume':
: multiple definition of `rt_task_resume'
kernel/xenomai/skins/native/built-in.o:: first defined here
kernel/xenomai/skins/rtai/built-in.o: In function `rt_sem_delete':
: multiple definition of `rt_sem_delete'
kernel/xenomai/skins/native/built-in.o:: first defined here
ld: Warning: size of symbol `rt_sem_delete' changed from 256 in
kernel/xenomai/skins/native/built-in.o to 229 in
kernel/xenomai/skins/rtai/built-in.o
kernel/xenomai/skins/rtai/built-in.o: In function `rt_task_wait_period':
: multiple definition of `rt_task_wait_period'
kernel/xenomai/skins/native/built-in.o:: first defined here
ld: Warning: size of symbol `rt_task_wait_period' changed from 47 in
kernel/xenomai/skins/native/built-in.o to 9 in
kernel/xenomai/skins/rtai/built-in.o
make[3]: *** [kernel/xenomai/skins/built-in.o] Error 1
make[2]: *** [kernel/xenomai/skins] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2


thanx a lot

-- 
Igor Cheifot
President/CEO
Concept17 Studios
tel: 604-377-4901



