Message-ID: <45CD44EF.6080807@domain.hid>
Date: Sat, 10 Feb 2007 06:07:11 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange deadlock.
References: <45CCCD10.9000008@domain.hid>
In-Reply-To: <45CCCD10.9000008@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi!

I added some logging to mutex log operation and serial port operations 
(executed in secondary mode):

--- skipped ---
#ifdef _DEBUG_
struct log_mutex_opers
{
     RT_TASK_INFO task_info_before;
     RT_TASK_INFO task_info_after;
     RT_MUTEX_INFO mutex_info;
     unsigned char oper;
     RTIME oper_in;
     RTIME oper_out;
     int ser_trans_count;
     RTIME ser_trans_in[128];
     RTIME ser_trans_out[128];
};
#endif /* _DEBUG_ */
--- skipped ---
#ifdef _DEBUG_
#define lock_history_lenght 1000
     struct log_mutex_opers logs[2*lock_history_lenght];
     unsigned long logs_c1;
     unsigned long logs_c2;
#endif /* _DEBUG_ */
--- skipped ---
#define SER_TRANS_LOG(C, T1, T2)                                \
{                                                               \
     int __i = C->logs[0].ser_trans_count;                       \
     C->logs[0].ser_trans_in[__i] = T1;                          \
     C->logs[0].ser_trans_out[__i] = T2;                         \
     C->logs[0].ser_trans_count++;                               \
}
#define _SAVE_STATE_COLLECTION(C, T, O, S)                      \
{                                                               \
     RTIME __t2 = rt_timer_tsc();                                \
     int __i;                                                    \
     for(__i = (2*lock_history_lenght - 1); __i > 0; __i--)      \
         C->logs[__i] = C->logs[__i - 1];                        \
     memset(&C->logs[0], 0, sizeof(struct log_mutex_opers));     \
     rt_task_inquire(NULL, &C->logs[0].task_info_after);         \
     rt_mutex_inquire(&C->lock, &C->logs[0].mutex_info);         \
     C->logs[0].oper = O;                                        \
     C->logs[0].oper_out = __t2;                                 \
     C->logs[0].oper_in = T;                                     \
     C->logs[0].task_info_before = S;                            \
}

#define _LOCK_COLLECTION(C, I)                                  \
{                                                               \
     RTIME __t1 = rt_timer_tsc();                                \
     RT_TASK_INFO __s;                                           \
     rt_task_inquire(NULL, &__s);                                \
     RT_MUTEX_INFO __lock_state;                                 \
     rt_mutex_inquire(&C->lock, &__lock_state);                  \
     rt_mutex_lock(&C->lock ,TM_INFINITE );                      \
     _SAVE_STATE_COLLECTION(C, __t1, 'L', __s);                  \
     I++;                                                        \
};

#define LOCK_COLLECTION_NR(C)                                   \
     _LOCK_COLLECTION(C, C->logs_c1)

#define LOCK_COLLECTION(C, R)                                   \
     _LOCK_COLLECTION(C, C->logs_c2)

#define UNLOCK_COLLECTION(C)                                    \
{                                                               \
     RT_TASK_INFO __s;                                           \
     rt_task_inquire(NULL, &__s);                                \
     _SAVE_STATE_COLLECTION(C, 0, 'U', __s);                     \
     rt_mutex_unlock(&C->lock);                                  \
};
--- skipped ---

After deadlock reached, array has entries ( i listed here last 6 entries 
- one pair is lock/unlock registration):

------------------------------------------------------------------

{{task_info_before = {bprio = 80, cprio = 80, status = 3146624, relpoint 
= 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
task_info_after = {bprio = 80,
       cprio = 80, status = 3146624, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
mutex_info = {lockcnt = 1,
       nwaiters = 1, name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H\037H?4?\020?"}, oper = 
85 'U', oper_in = 0,
     oper_out = 5397829215210, ser_trans_count = 0, ser_trans_in = {0 
<repeats 128 times>}, ser_trans_out = {
       0 <repeats 128 times>}},

{task_info_before = {bprio = 80, cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
task_info_after = {bprio = 80,
       cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
mutex_info = {lockcnt = 1,
       nwaiters = 0, name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H\037H?4?\020?"}, oper = 
76 'L',
     oper_in = 5397792126988, oper_out = 5397792191552, ser_trans_count 
= 1, ser_trans_in = {5397810469917,
       0 <repeats 127 times>}, ser_trans_out = {5397828986260, 0 
<repeats 127 times>}},



{task_info_before = {bprio = 50,
       cprio = 50, status = 3146112, relpoint = 0, name = 
"bus_monitor_proc[0]\000?8N?\202\002\000\000H_??"},
     task_info_after = {bprio = 50, cprio = 50, status = 3146112, 
relpoint = 0,
       name = "bus_monitor_proc[0]\000?8N?\202\002\000\000H_??"}, 
mutex_info = {lockcnt = 1, nwaiters = 0,
       name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H_??4?\020?"}, oper = 85 
'U', oper_in = 0,
     oper_out = 5397750468006, ser_trans_count = 1, ser_trans_in = 
{5397718529990, 0 <repeats 127 times>}, ser_trans_out = {
       5397770396236, 0 <repeats 127 times>}},

{task_info_before = {bprio = 50, cprio = 50, status = 3146112, relpoint = 0,
       name = "bus_monitor_proc[0]\000?8N?\202\002\000\000H_??"}, 
task_info_after = {bprio = 50, cprio = 50,
       status = 3146112, relpoint = 0, name = 
"bus_monitor_proc[0]\000?8N?\202\002\000\000H_??"}, mutex_info = 
{lockcnt = 1,
       nwaiters = 0, name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H_??4?\020?"}, oper = 76 'L',
     oper_in = 5397732302828, oper_out = 5397732320388, ser_trans_count 
= 0, ser_trans_in = {0 <repeats 128 times>},
     ser_trans_out = {0 <repeats 128 times>}},




{task_info_before = {bprio = 80, cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
task_info_after = {bprio = 80,
       cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
mutex_info = {lockcnt = 1,
       nwaiters = 0, name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H\037H?4?\020?"}, oper = 
85 'U', oper_in = 0,
     oper_out = 5397682575612, ser_trans_count = 1, ser_trans_in = 
{5397701107940, 0 <repeats 127 times>}, ser_trans_out = {
       5397718501300, 0 <repeats 127 times>}},

{task_info_before = {bprio = 80, cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
task_info_after = {bprio = 80,
       cprio = 80, status = 3146112, relpoint = 0,
       name = 
"vdcp[0030]m\000\226\002\000\000\231?\023??8N?\202\002\000\000H\037H?"}, 
mutex_info = {lockcnt = 1,
       nwaiters = 0, name = 
"coll_VDCP_1\000\231?\023??8N?\202\002\000\000H\037H?4?\020?"}, oper = 
76 'L',
     oper_in = 5397664238700, oper_out = 5397664304073, ser_trans_count 
= 0, ser_trans_in = {0 <repeats 128 times>},
     ser_trans_out = {0 <repeats 128 times>}},

--- skipped ---

------------------------------------------------------------------

I tried to summarize this info and build time sorted table of actions 
(task B - "bus_monitor_proc[0]", task V - "vdcp[0030]m"):

V	5397829215210	rt_mutex_unlock:ENTER
V	5397828986260	serial_transact:EXIT
V	5397810469917	serial_transact:ENTER
V	5397792191552	rt_mutex_lock:EXIT
V	5397792126988	rt_mutex_lock:ENTER
V	5397770396236	serial_transact:EXIT
B	5397750468006	rt_mutex_unlock:ENTER
B	5397732320388	rt_mutex_lock:EXIT
B	5397732302828	rt_mutex_lock:ENTER
V	5397718529990	serial_transact:ENTER
V	5397718501300	serial_transact:EXIT
V	5397701107940	serial_transact:ENTER
V	5397682575612	rt_mutex_unlock:ENTER
V	5397664304073	rt_mutex_lock:EXIT
V	5397664238700	rt_mutex_lock:ENTER
V	5397618710764	rt_mutex_unlock:ENTER
V	5397600363677	rt_mutex_lock:EXIT
V	5397600295612	rt_mutex_lock:ENTER

As i mentioned early task B was executed during serial operation in task 
V, and may be it could cause switching status of task V from 3146112 
(0x00300180) to 3146624 (0x00300380) - rised bit 0x00000200 (XNRELAX 
0x00000200 Relaxed shadow thread (blocking bit) )

I am not specialist in Xenomai architecture, but it's not looks like 
stack corruption in my program.

I rather going to rewrite some code part to use rtserX instead of /dev/ttyXX


________________________________________
Maksym Veremeyenko


