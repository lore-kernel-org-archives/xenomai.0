Message-ID: <4D239301.80803@domain.hid>
Date: Tue, 04 Jan 2011 16:37:05 -0500
From: Tamas Szklenar <tszklenar@domain.hid>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid>
	<4D23785B.5050108@domain.hid> <4D2379EF.5@domain.hid>
	<4D237A89.3010205@domain.hid> <4D237CA9.2090408@domain.hid>
	<4D237F62.2030609@domain.hid> <4D2381B6.80304@domain.hid>
	<4D238C56.40906@domain.hid> <4D238EA1.7020409@domain.hid>
	<4D239001.9050604@domain.hid>
In-Reply-To: <4D239001.9050604@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Sure here is the output:

~$ cat /proc/timer_list

Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 2
now at 292297967595 nsecs

cpu: 0
  clock 0:
   .base:       ffff880001a0e838
   .index:      0
   .resolution: 4000250 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 1:
   .base:       ffff880001a0e870
   .index:      1
   .resolution: 4000250 nsecs
   .get_time:   ktime_get
active timers:
  #0: <ffff88020a665ac8>, hrtimer_wakeup, S:01
  # expires at 308624130994-308654130993 nsecs [in 16326163399 to 
16356163398 nsecs]

cpu: 1
  clock 0:
   .base:       ffff880001a4e838
   .index:      0
   .resolution: 4000250 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 1:
   .base:       ffff880001a4e870
   .index:      1
   .resolution: 4000250 nsecs
   .get_time:   ktime_get
active timers:
  #0: <ffffffff81750bf8>, sched_rt_period_timer, S:01
  # expires at 293000000000-293000000000 nsecs [in 702032405 to 
702032405 nsecs]
  #1: <ffff8802086af9a8>, hrtimer_wakeup, S:01
  # expires at 293173168132-293174168131 nsecs [in 875200537 to 
876200536 nsecs]
  #2: <ffff8802086559a8>, hrtimer_wakeup, S:01
  # expires at 1013712348906-1013812348906 nsecs [in 721414381311 to 
721514381311 nsecs]

cpu: 2
  clock 0:
   .base:       ffff880001a8e838
   .index:      0
   .resolution: 4000250 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 1:
   .base:       ffff880001a8e870
   .index:      1
   .resolution: 4000250 nsecs
   .get_time:   ktime_get
active timers:
  #0: <ffff88020a771ac8>, hrtimer_wakeup, S:01
  # expires at 292503107490-292503637489 nsecs [in 205139895 to 
205669894 nsecs]
  #1: <ffff88020fc8b9a8>, hrtimer_wakeup, S:01
  # expires at 292524960948-292529960947 nsecs [in 226993353 to 
231993352 nsecs]
  #2: <ffff88020e888958>, posix_timer_fn, S:01
  # expires at 293134262249-293134262249 nsecs [in 836294654 to 
836294654 nsecs]
  #3: <ffff88020d1e39a8>, hrtimer_wakeup, S:01
  # expires at 315876197364-315906197363 nsecs [in 23578229769 to 
23608229768 nsecs]
  #4: <ffff88020857fed8>, hrtimer_wakeup, S:01
  # expires at 338648664865-338648714865 nsecs [in 46350697270 to 
46350747270 nsecs]
  #5: <ffff88020d192470>, it_real_fn, S:01
  # expires at 1816696421423-1816696421423 nsecs [in 1524398453828 to 
1524398453828 nsecs]
  #6: <ffff88020a761ed8>, hrtimer_wakeup, S:01
  # expires at 3613091023499-3613091073499 nsecs [in 3320793055904 to 
3320793105904 nsecs]
  #7: <ffff88020a63b9a8>, hrtimer_wakeup, S:01
  # expires at 86411067787013-86411167787013 nsecs [in 86118769819418 to 
86118869819418 nsecs]

cpu: 3
  clock 0:
   .base:       ffff880001ace838
   .index:      0
   .resolution: 4000250 nsecs
   .get_time:   ktime_get_real
active timers:
  #0: <ffff88020d00fd68>, hrtimer_wakeup, S:01
  # expires at 1294176961287775295-1294176961287825295 nsecs [in 
1294176668989807700 to 1294176668989857700 nsecs]
  clock 1:
   .base:       ffff880001ace870
   .index:      1
   .resolution: 4000250 nsecs
   .get_time:   ktime_get
active timers:
  #0: <ffff8802085999a8>, hrtimer_wakeup, S:01
  # expires at 293101174531-293102174530 nsecs [in 803206936 to 
804206935 nsecs]
  #1: <ffff88020a7299a8>, hrtimer_wakeup, S:01
  # expires at 293165117088-293166117087 nsecs [in 867149493 to 
868149492 nsecs]
  #2: <ffff88020e95b9a8>, hrtimer_wakeup, S:01
  # expires at 296121072213-296126072212 nsecs [in 3823104618 to 
3828104617 nsecs]


Tick Device: mode:     0
Broadcast device
Clock Event Device: pit
  max_delta_ns:   27461866
  min_delta_ns:   12571
  mult:           5124677
  shift:          32
  mode:           2
  next_event:     9223372036854775807 nsecs
  set_next_event: pit_next_event
  set_mode:       init_pit_timer
  event_handler:  tick_handle_periodic_broadcast
  retries:        0
tick_broadcast_mask: 0000000f


Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: lapic
  max_delta_ns:   668154819
  min_delta_ns:   1194
  mult:           53922821
  shift:          32
  mode:           1
  next_event:     9223372036854775807 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  tick_handle_periodic
  retries:        0

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: lapic
  max_delta_ns:   668154819
  min_delta_ns:   1194
  mult:           53922821
  shift:          32
  mode:           1
  next_event:     9223372036854775807 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  tick_handle_periodic
  retries:        0

Tick Device: mode:     0
Per CPU device: 2
Clock Event Device: lapic
  max_delta_ns:   668154819
  min_delta_ns:   1194
  mult:           53922821
  shift:          32
  mode:           1
  next_event:     9223372036854775807 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  tick_handle_periodic
  retries:        0

Tick Device: mode:     0
Per CPU device: 3
Clock Event Device: lapic
  max_delta_ns:   668154819
  min_delta_ns:   1194
  mult:           53922821
  shift:          32
  mode:           1
  next_event:     9223372036854775807 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  tick_handle_periodic
  retries:        0


