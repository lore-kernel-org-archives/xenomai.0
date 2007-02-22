Message-ID: <45DD9A4E.9070709@domain.hid>
Date: Thu, 22 Feb 2007 14:27:42 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>	<45CC68F3.1000003@domain.hid>	
	<45D1C033.9010002@domain.hid>	<45D1C61B.7030503@domain.hid>	
	<1171376742.885.3.camel@domain.hid>	<45D1CAFA.6050408@domain.hid>	
	<1171385716.885.17.camel@domain.hid>	<45D200C3.1030001@domain.hid>	
	<1171393088.885.37.camel@domain.hid>	<45D59F98.8020006@domain.hid>	
	<45D5E493.4080405@domain.hid> <45D5F0AD.9010404@domain.hid>	
	<1171649724.10479.12.camel@domain.hid> <45D5F71F.60509@domain.hid>	
	<1171650868.10479.21.camel@domain.hid> <45D5FA33.3030503@domain.hid>
	<1171651639.10479.24.camel@domain.hid>
In-Reply-To: <1171651639.10479.24.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Philippe Gerum schrieb:
> On Fri, 2007-02-16 at 19:38 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2007-02-16 at 19:25 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2007-02-16 at 18:58 +0100, Jan Kiszka wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> ...
>>>>>>> /me now watching what happens at 10 kHz...
>>>>>> Bad news are sometimes good news:
>>>>>>
>>>>>> # ./main
>>>>>> # rmmod xeno_native
>>>>>> # modprobe xeno_native
>>>>>> # ./main
>>>>>>
>>>>>>> [  629.916921] Xenomai: stopping RTDM services.
>>>>>>> [  632.954058] Xenomai: stopping native API services.
>>>>>>> [  641.763276] Xenomai: starting native API services.
>>>>>>> [  643.849294] BUG: unable to handle kernel paging request at virtual address c484eb58
>>>>>>> [  643.857099]  printing eip:
>>>>>>> [  643.859835] c013a173
>>>>>>> [  643.862050] *pde = 03fdb067
>>>>>>> [  643.864868] *pte = 00000000
>>>>>>> [  643.867696] Oops: 0000 [#1]
>>>>>>> [  643.870517] PREEMPT
>>>>>>> [  643.872747] Modules linked in: xeno_native 8139too eepro100 sd_mod scsi_mod
>>>>>>> [  643.879873] CPU:    0
>>>>>>> [  643.879884] EIP:    0060:[<c013a173>]    Not tainted VLI
>>>>>>> [  643.879904] EFLAGS: 00013046   (2.6.19.3 #28)
>>>>>>> [  643.891932] EIP is at xnheap_init_mapped+0x144/0x1a8
>>>>> I've just found an issue which caused rt_queue_delete() to leave
>>>>> dandling mmapped segments when attempting to remove a busy queue (i.e.
>>>>> still bound to another descriptor in user-space).
>>>>>
>>>>> Could you resync with v2.3.x (or trunk) head revision and try again?
>>>>> TIA,
>>>>>
>>>> After resync and running main once:
>>>>
>>>>> [   90.782016] Xenomai: stopping native API services.
>>>>> [   90.987985] BUG: unable to handle kernel paging request at virtual address c4813808
>>>>> [   90.996022]  printing eip:
>>>>> [   90.998921] c01965d9
>>>>> [   91.001290] *pde = 03fd4067
>>>>> [   91.004267] *pte = 00000000
>>>>> [   91.007267] Oops: 0000 [#1]
>>>>> [   91.010246] PREEMPT
>>>>> [   91.012693] Modules linked in: xeno_native 8139too eepro100 sd_mod scsi_mod
>>>>> [   91.020385] CPU:    0
>>>>> [   91.020430] EIP:    0060:[<c01965d9>]    Not tainted VLI
>>>>> [   91.020515] EFLAGS: 00010286   (2.6.19.3 #29)
>>>>> [   91.032862] EIP is at remove_proc_entry+0x33/0x26a
>>>>> [   91.037892] eax: 00000000   ebx: c484c620   ecx: ffffffff   edx: c2c961e0
>>>>> [   91.044944] esi: 00000038   edi: c4813808   ebp: c1351f20   esp: c1351ef4
>>>>> [   91.051984] ds: 007b   es: 007b   ss: 0068
>>>>> [   91.056297] Process rmmod (pid: 906, ti=c1350000 task=c3422a70 task.ti=c1350000)
>>>>> [   91.063761] Stack: 00002245 00000282 00000000 00000000 6f6e6578 c1351f20 c2c961e0 c4813808
>>>>> [   91.073076]        c484c620 00000038 00000000 c1351f34 c01458f7 00000000 00000000 6f6e6578
>>>>> [   91.082388]        c1351f44 c013e20b c48f2e80 00000000 c1351f4c c0144163 c1351f58 c48e3055
>>>>> [   91.091724] Call Trace:
>>>>> [   91.094659]  [<c01458f7>] xnregistry_cleanup+0x34/0x10f
>>>>> [   91.100310]  [<c013e20b>] xnpod_shutdown+0x118/0x167
>>>>> [   91.105710]  [<c0144163>] xncore_detach+0x1f/0x21
>>>>> [   91.110816]  [<c48e3055>] cleanup_module+0x55/0x57 [xeno_native]
>>>>> [   91.117352]  [<c0130c53>] sys_delete_module+0x16a/0x193
>>>>> [   91.123008]  [<c0102df6>] syscall_call+0x7/0xb
>>>>> [   91.127878]  [<b7e504c2>] 0xb7e504c2
>>>>> [   91.131770]  =======================
>>>>> [   91.135540] Code: 20 e8 04 3c f7 ff 85 d2 89 55 ec 89 45 f0 75 13 8d 4d f0 8d 55 ec e8 16 ff ff ff 85 c0 0f 85 37
>>>>> 02 00 00 8b 7d f0 31 c0 83 c9 ff <f2> ae f7 d1 49 81 3d 00 d2 2e c0 80 ae 2e c0 89 4d e4 75 07 b0
>>>>> [   91.159520] EIP: [<c01965d9>] remove_proc_entry+0x33/0x26a SS:ESP 0068:c1351ef4
>>>> I'm going to re-check that my build was clean, but I think so.
>>>>
>>> Ok, it's not impossible that the initial fix caused a regression on the
>>> registry's /proc unexport code. I'm going to check that on my side too.
>>>
>> Looks more like some unrelated, forgotten-to-rebuild RT module now.
>> Things run smoothly at the moment, I'm unable to reproduce any of the
>> earlier issues.
>>
> 
> Ok thanks, so far, no reproducible issue here too, but I will leave the
> test running for a few hours just in case.
> 

Hm, updated my machines to 2.6.20 and 2.3.0 rev 2222. I still see ( less
frequent?) some backtraces occuring on my console, either during reboot
or sometimes when running the testprogram and reloading the modules.(see
dmesg snippet below) The Celeron M still crashes often totally.

My main-application still freezes the SMP mashines if I have 'priority
coupling' enabled in kernel-config. Using trunk makes things even worse.
The pc will crash during startup of my app, the testapp I sendt you
works, but i can not shutdown the pc afterwards, because it freezes
completely when terminating kdm.

Stephan



dmesg tells me the following (2.3.0.2222, 2.6.20, SMP):

--snip--
Bad page state in process 'kswapd0'
page:c17f3060 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f3ae0 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f10c0 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f0960 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f08c0 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f01a0 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142ce2>] __pagevec_release_nonlru+0x46/0x51
  [<c0143d78>] shrink_page_list+0x2a6/0x3a1
  [<c0143fbe>] shrink_inactive_list+0x9e/0x253
  [<c01445cd>] shrink_zone+0xb9/0xd7
  [<c0144aba>] balance_pgdat+0x246/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f2e20 flags:0x8001040c mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c46>] release_pages+0xfd/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f1480 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c77>] release_pages+0x12e/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f0e00 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c46>] release_pages+0xfd/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f0e40 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c46>] release_pages+0xfd/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f1e80 flags:0x8001040c mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c77>] release_pages+0x12e/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f21a0 flags:0x8001040c mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c77>] release_pages+0x12e/0x136
  [<c0145705>] __dec_zone_page_state+0x1c/0x74
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c02c9084>] _spin_lock+0x2b/0xc5
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f3960 flags:0x8001040c mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c46>] release_pages+0xfd/0x136
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f2240 flags:0x8001040c mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c77>] release_pages+0x12e/0x136
  [<c0145705>] __dec_zone_page_state+0x1c/0x74
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c02c9084>] _spin_lock+0x2b/0xc5
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================
Bad page state in process 'kswapd0'
page:c17f05c0 flags:0x80010408 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
  [<c013f774>] bad_page+0x5c/0x85
  [<c0140079>] free_hot_cold_page+0x63/0x1cf
  [<c01408c7>] __pagevec_free+0x15/0x1b
  [<c0142c77>] release_pages+0x12e/0x136
  [<c01d18b2>] debug_smp_processor_id+0x22/0x128
  [<c0145705>] __dec_zone_page_state+0x1c/0x74
  [<c0142c94>] __pagevec_release+0x15/0x1d
  [<c0143337>] invalidate_mapping_pages+0x89/0xb7
  [<c01740b8>] remove_inode_buffers+0x16/0xbe
  [<c02c9084>] _spin_lock+0x2b/0xc5
  [<c016847b>] prune_icache+0xc9/0x18e
  [<c0168554>] shrink_icache_memory+0x14/0x2b
  [<c01437a0>] shrink_slab+0x139/0x219
  [<c0144ada>] balance_pgdat+0x266/0x370
  [<c0144cbd>] kswapd+0xd9/0xdb
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c012ca64>] autoremove_wake_function+0x0/0x33
  [<c0144be4>] kswapd+0x0/0xdb
  [<c012c724>] kthread+0x74/0x98
  [<c012c6b0>] kthread+0x0/0x98
  [<c01039fb>] kernel_thread_helper+0x7/0x10
  =======================

--snap--



