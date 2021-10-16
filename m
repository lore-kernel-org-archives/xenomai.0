MIME-Version: 1.0
References: <CAK6DXL2cWYOuFMHkm6tdzxcRzKehgnKyzTF1iid63QOVBQgLNw@mail.gmail.com>
 <31054073-d935-3218-9985-9b68aac0ebf7@siemens.com>
 <CAK6DXL385hOFto37fCFNmYyU7kDqWVoK970p5z6Fp3P9zi4w1Q@mail.gmail.com>
 <e451fe75-ce20-1362-54b5-6463da7ee1bf@siemens.com>
 <CAK6DXL2miYAm12sgcj-8UWKSj4m5=-p0tWdD9CY8_3ZGc-2+5A@mail.gmail.com>
In-Reply-To: <CAK6DXL2miYAm12sgcj-8UWKSj4m5=-p0tWdD9CY8_3ZGc-2+5A@mail.gmail.com>
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Sat, 16 Oct 2021 12:16:40 +0200
Message-ID: <CAK6DXL2WfyKMAHFBKHK0oVOMCofoZOkH8a9itWv2nTxGi8C+RQ@mail.gmail.com>
Subject: Re: RTnet failed setup
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

I reached a workaround for the ones interested in. For some reasons there
was something wrong with last protocol stages (from the second
configuration frame on, don't know exactly where). Anyway I tried to
comment wait, ready and announcement commands in the rtnet script in order
to not complete setup, and it works fine. The idea came from the fact that
a little after ready stage on slave side no sync frame was received any
more. Of course it is just a workaround since the master node periodically
tries to send setup 2 stage packets and never reaches the ready states,
this is not an ideal state ... . Anyway slaves correctly send in their time
slots. Maybe is something with heatbeat send ...

Il giorno dom 10 ott 2021 alle ore 10:24 Marco Barletta <
barlettamarco8@gmail.com> ha scritto:

> IRQ seem to be enabled since this --->
>
>   IRQ         CPU0        CPU1        CPU2        CPU3        CPU4
>  CPU5        CPU6        CPU7
>    28:           0           0           0         753           0
>   0           0           0         rteth0
>  4352:           0           0           0           0           0
>   0           0           0         [sync]
>  4353:           0         617           0           7           1
>   1         485           2         [reschedule]
>  4354:           1           1           1           0           1
>   1           1           1         [timer-ipi]
>  4355:      179750      183487      162880      203563      175508
>  170059      165975      194426         [timer/0]
>  4419:           4           4           1           4           1
>  19           1           2         [virtual]
>
> is the output on both sides (it just changes the core interrupted) before
> and after the setup.
> I attach the pcap as seen by the slave that after the ready packet doesn't
> recive anything.
> The kernel log of master is reported below
>
> [  352.755904] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [  352.755906] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [  352.756123] e1000e 0000:00:19.0
> : Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [  352.832017] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized):
> registered PHC clock
> [  352.897692] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1)
> 8c:dc:d4:27:ce:88
> [  352.897700] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network
> Connection
> [  352.897736] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No:
> FFFFFF-0FF
> [  352.899952] e1000e 0000:00:19.0 eno1: renamed from eth0
> [  356.503412] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: None
> [  356.503441] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
> [  564.397332] e1000e: eno1 NIC Link is Down
> [  714.064090] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: None
> [  752.585318] e1000e: eno1 NIC Link is Down
> [  768.904270] e1000e: eno1 NIC Link is Up 100 Mbps Full Duplex, Flow
> Control: None
> [  768.904273] e1000e 0000:00:19.0 eno1: 10/100 speed: disabling TSO
> [  815.779634] e1000e 0000:00:19.0 eno1: removed PHC
> [  815.859405] e1000e: eno1 NIC Link is Down
> [  821.696493] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
> [  821.696494] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> [  821.858114] RTnet: registered rteth0
> [  821.858117] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 8c:dc:d4:27:ce:88
> [  821.858118] rt_e1000e: Intel(R) PRO/1000 Network Connection
> [  821.858154] rt_e1000e: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
> [  821.864043] rt_loopback: initializing loopback interface...
> [  821.864605] RTnet: registered rtlo
> [  821.866537] RTcap: real-time capturing interface
> [  821.877083] RTcfg: init real-time configuration distribution protocol
> [  821.879436] RTmac: init realtime media access control
> [  821.882169] RTmac/TDMA: init time division multiple access control
> mechanism
> [  821.883197] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_CMD_SERVER, state=RTCFG_MAIN_OFF
> [  821.883199] RTcfg: next main state=RTCFG_MAIN_SERVER_RUNNING
> [  822.090721] RTcfg: rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_ADD,
> state=RTCFG_MAIN_SERVER_RUNNING
> [  822.092346] RTcfg: rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_WAIT,
> state=RTCFG_MAIN_SERVER_RUNNING
> [  822.883162] RTcfg: error -11 while sending stage 1 frame
> [  823.622164] e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow
> Control: None
> [  823.622165] rt_e1000e: 10/100 speed: disabling TSO
> [  826.902214] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_ANNOUNCE_NEW, state=RTCFG_MAIN_SERVER_RUNNING
> [  826.902216] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_FRM_ANNOUNCE_NEW, state=RTCFG_CONN_SEARCHING
> [  826.902216] RTcfg: next connection state=RTCFG_CONN_STAGE_1
> [  826.912211] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_ACK_CFG, state=RTCFG_MAIN_SERVER_RUNNING
> [  826.912212] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_FRM_ACK_CFG, state=RTCFG_CONN_STAGE_1
> [  826.912213] RTcfg: next connection state=RTCFG_CONN_STAGE_2
> [  826.912944] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_CMD_READY, state=RTCFG_MAIN_SERVER_RUNNING
> [  826.922175] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_READY, state=RTCFG_MAIN_SERVER_RUNNING
> [  826.922176] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_FRM_READY, state=RTCFG_CONN_STAGE_2
> [  826.922177] RTcfg: next connection state=RTCFG_CONN_READY
> [  827.883005] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  828.882973] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  829.882943] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  830.882912] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  831.882881] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  832.882850] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  833.882819] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  834.882788] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  835.882757] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  836.882726] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  837.882695] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  838.882665] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  839.882633] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  840.882603] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  841.882572] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  842.882541] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  843.882510] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  844.882478] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  845.882448] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  846.882417] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  847.882386] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  848.882355] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  849.882325] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  850.882293] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  851.882263] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  852.882231] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  853.882202] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  854.882169] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  855.882139] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  856.882108] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  857.882078] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  858.882046] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  859.882016] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  860.881984] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  861.881954] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  862.881923] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  863.881892] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  864.881860] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  865.881830] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  866.881799] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  867.881768] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  868.881739] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  869.881707] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  870.881676] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  871.881644] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  872.881614] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  873.881583] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  874.881552] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  875.881521] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  876.881490] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  877.881458] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  878.881428] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  879.881397] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  880.881366] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  881.881335] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  882.881304] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  883.881274] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  884.881243] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  885.881212] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  886.881180] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  887.881149] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  888.881118] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  889.881088] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  890.881057] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  891.881026] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  892.880996] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  893.880965] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  894.880933] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  895.880903] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  896.880872] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  897.880840] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  898.880810] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  899.880779] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  900.880748] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  901.880717] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  902.880687] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  903.880655] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  904.880625] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  905.880593] RTcfg: rtcfg_do_conn_event() conn=00000000a1916cd0,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [  906.239475] RTmac/TDMA: unloaded
> [  906.261282] RTmac: unloaded
> [  906.321212] RTcfg: unloaded
> [  906.413270] RTcap: unloaded
> [  906.437268] rt_loopback: removing loopback interface...
> [  906.437288] RTnet: unregistered rtlo
> [ 1026.134067] rt_loopback: initializing loopback interface...
> [ 1026.134774] RTnet: registered rtlo
> [ 1026.136697] RTcap: real-time capturing interface
> [ 1026.144772] RTcfg: init real-time configuration distribution protocol
> [ 1026.148299] RTmac: init realtime media access control
> [ 1026.150938] RTmac/TDMA: init time division multiple access control
> mechanism
> [ 1026.151747] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_CMD_SERVER, state=RTCFG_MAIN_OFF
> [ 1026.151748] RTcfg: next main state=RTCFG_MAIN_SERVER_RUNNING
> [ 1026.358769] RTcfg: rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_ADD,
> state=RTCFG_MAIN_SERVER_RUNNING
> [ 1026.360406] RTcfg: rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_WAIT,
> state=RTCFG_MAIN_SERVER_RUNNING
> [ 1027.151717] RTcfg: error -11 while sending stage 1 frame
> [ 1027.914150] e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow
> Control: None
> [ 1027.914151] rt_e1000e: 10/100 speed: disabling TSO
> [ 1030.170223] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_ANNOUNCE_NEW, state=RTCFG_MAIN_SERVER_RUNNING
> [ 1030.170225] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_FRM_ANNOUNCE_NEW, state=RTCFG_CONN_SEARCHING
> [ 1030.170226] RTcfg: next connection state=RTCFG_CONN_STAGE_1
> [ 1030.180220] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_ACK_CFG, state=RTCFG_MAIN_SERVER_RUNNING
> [ 1030.180221] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_FRM_ACK_CFG, state=RTCFG_CONN_STAGE_1
> [ 1030.180221] RTcfg: next connection state=RTCFG_CONN_STAGE_2
> [ 1030.180926] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_CMD_READY, state=RTCFG_MAIN_SERVER_RUNNING
> [ 1030.190186] RTcfg: rtcfg_do_main_event() rtdev=1,
> event=RTCFG_FRM_READY, state=RTCFG_MAIN_SERVER_RUNNING
> [ 1030.190189] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_FRM_READY, state=RTCFG_CONN_STAGE_2
> [ 1030.190189] RTcfg: next connection state=RTCFG_CONN_READY
> [ 1031.151590] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [ 1032.151558] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [ 1033.151529] RTcfg: rtcfg_do_conn_event() conn=00000000a6cb24c6,
> event=RTCFG_TIMER, state=RTCFG_CONN_READY
> [ 1033.151530] RTcfg: next connection state=RTCFG_CONN_DEAD
> [ 1051.476442] skb:: 0000000000000000
> [ 1051.476444] Failed rtskb_pool_dequeue
> [ 1051.476445] TDMA: Failed to transmit sync frame! alloc_rtskb
> [ 1051.486439] skb:: 0000000000000000
> [ 1051.486440] Failed rtskb_pool_dequeue
> [ 1051.486441] TDMA: Failed to transmit sync frame! alloc_rtskb
> [ 1051.496439] skb:: 0000000000000000
> [ 1051.496440] Failed rtskb_pool_dequeue
> [ 1051.496441] TDMA: Failed to transmit sync frame! alloc_rtskb
> [ 1051.506439] skb:: 0000000000000000
> [ 1051.506440] Failed rtskb_pool_dequeue
> [ 1051.506440] TDMA: Failed to transmit sync frame! alloc_rtskb
> ...
> [ 1067.735938] Failed rtskb_pool_dequeue
> [ 1067.735939] TDMA: Failed to transmit sync frame! alloc_rtskb
> [ 1067.741254] skb:: 0000000000000000
> [ 1067.741256] Failed rtskb_pool_dequeue
> [ 1067.741256] TDMA: Failed to transmit sync frame! alloc_rtskb
> [ 1067.943422] RTmac/TDMA: unloaded
> [ 1067.961273] RTmac: unloaded
> [ 1068.025197] RTcfg: unloaded
> [ 1068.153254] RTcap: unloaded
> [ 1068.165264] rt_loopback: removing loopback interface...
> [ 1068.165290] RTnet: unregistered rtlo
>
> I cut the part were the messages repeat for the sync frame. The original
> print was only  " TDMA: Failed to transmit sync frame! ". I modified the
> print to understand which is the call to fail. In the kernel log are
> reported two attemps, with no heartbeat the first and with default
> heartbeat the second.
> Up to now the closest setup to work is with two e100 cards instead of the
> e1000e that hang during the rtcfg setup since the slave doesn't answer with
> the announcement, anyway the slave can receive the ping but can't answer
> since the device is busy to setup. Anyway i have no clue on what is going
> on with these e1000e, on the slave side I can just notice a few complains
> for the rtmac version after the end of the setup, anyway it doesn't happen
> always.
>
>
> Il giorno mer 6 ott 2021 alle ore 12:29 Jan Kiszka <jan.kiszka@siemens.com>
> ha scritto:
>
>> On 05.10.21 17:33, Marco Barletta wrote:
>> > I changed my setup to avoid time problems: I went bare metal with two
>> > machines with e1000e driver (I217-LM controller) with linux 5.4.77,
>> > xenomai 3.1.1. I managed to got a RTcfg handshake between the two
>> > machines, however I got that after the "ready" packet from both master
>> > and slave, no more sync frame are received and after 30-40 seconds it
>> > starts logging "failed to transmit sync frame", because of full rtskbs.
>> > It seems buffers become full of sync packet never transmitted. It also
>> > seems to detect a connection dead (anyway no connection dead packet is
>> > detected in wireshark) end in wireshark there is no heartbeat packet.
>> > May be a related problem that after the ready stage the TX IRQ come
>> > disabled? I tried also with a e100 card and with the e100 as master the
>>
>> Do you get interrupts for the card at all? See /proc/xenomai/irq. Does
>> the kernel console (dmesg) report any errors, IRQ problems?
>>
>> Jan
>>
>> > handshake is not completed, while with the card as a slave I see an arp
>> > reply packet that I couldn't see with the e1000e. Anyaway after the
>> > ready in both cases no packet is received. I saw on the mailing list
>> > someone had a similar problems with RTAI a few years ago, but the
>> > resolution was not clear. Moreover I sometime can read that the slave
>> > receives a wrong version RTmac packet (0x2 expected 0x0, or viceversa).
>> > You will encounter similar mails from mine in the mailing list, just
>> > trash it, this is the up to date state.
>> > Thanks a lot for helping
>> >
>> > Il giorno mar 5 ott 2021 alle ore 16:15 Jan Kiszka
>> > <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> ha scritto:
>> >
>> >     On 18.09.21 16:55, Marco Barletta via Xenomai wrote:
>> >     > Hi everyone;
>> >     > since my NIC is not supported by rt_e1000e I wanted to test the
>> >     RTnet setup
>> >     > on a couple of VMs talking to each other. I created a NAT network
>> (
>> >     > 10.0.2.0/24 <http://10.0.2.0/24>) and I attached the two VMs on
>> >     it. Emulated controller is a
>> >     > Intel 82540EM with e1000. The test with the loopback device works
>> >     fine,
>> >     > but when I try to make the multi node test something fails. The
>> rteth0
>> >     > device is correctly brought up on both the VMs, however the rtnet
>> >     start
>> >     > command stucks at  "waiting for slaves..." master side and
>> >     "searching for
>> >     > master" on slave side. Obviously they can't exchange packets but I
>> >     don't
>> >     > know why. In dmesg I get
>> >     > [ 1652.922885] RTnet: registered rteth0
>> >     > [ 1652.922888] e1000: rteth0: e1000_probe: Intel(R) PRO/1000
>> Network
>> >     > Connection
>> >     > [ 1652.930730] rt_loopback: initializing loopback interface...
>> >     > [ 1652.930764] RTnet: registered rtlo
>> >     > [ 1652.935057] RTcfg: init real-time configuration distribution
>> >     protocol
>> >     > [ 1652.938784] RTmac: init realtime media access control
>> >     > [ 1652.942199] RTmac/TDMA: init time division multiple access
>> control
>> >     > mechanism
>> >     > [ 1654.983533] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000
>> >     Mbps Full
>> >     > Duplex
>> >     > [ 1730.758684] TDMA: Failed to transmit sync frame!
>> >     > [ 1730.758848] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723757] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723774] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723777] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723779] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723781] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723783] TDMA: Failed to transmit sync frame!
>> >     > [ 1805.723785] TDMA: Failed to transmit sync frame!
>> >     >
>> >     > and on the other side I noticed in dmesg
>> >     > [ 1625.966260] RTnet: dropping packet in rtnetif_rx()
>> >     > [ 1625.966262] RTnet: dropping packet in rtnetif_rx()
>> >     > [ 1625.966263] RTnet: dropping packet in rtnetif_rx()
>> >     > [ 1625.966265] RTnet: dropping packet in rtnetif_rx()
>> >     >
>> >     > If I try a manual rtping after the rtroute I get "ioctl: Resource
>> >     > temporarily unavailable" and in dmesg
>> >     > [   72.314451] hard_start_xmit returned -11.
>> >     > Can someone help me to understand what is going on?
>> >     >
>> >
>> >     A common cause for such an error pattern is that the (TX) IRQ is not
>> >     working, thus packets are not released after submission. Check that
>> >     first. What's your Xenomai/kernel version?
>> >
>> >     Jan
>> >
>> >     > rtconf files are:
>> >     >
>> >     > RT_DRIVER="rt_e1000"
>> >     > RT_DRIVER_OPTIONS=""
>> >     > REBIND_RT_NICS="0000:00:03.0"
>> >     > IPADDR="10.0.2.4"
>> >     > NETMASK="255.255.255.0"
>> >     > RT_LOOPBACK="yes"
>> >     > RT_PROTOCOLS="udp packet"
>> >     > RTCAP="no"
>> >     > STAGE_2_SRC=""
>> >     > STAGE_2_DST=""
>> >     > STAGE_2_CMDS=""
>> >     > TDMA_MODE="master"
>> >     > TDMA_SLAVES="10.0.2.15"
>> >     > TDMA_CYCLE="5000"
>> >     > TDMA_OFFSET="200"
>> >     >
>> >     > for master and the same with slave instead of master and
>> >     ipaddr=10.0.2.15
>> >     > for slave. VMs run Linux mint 20.1 5.4.77 patched with 3.1
>> >     > Thank you for helping.
>> >     >
>> >
>> >     --
>> >     Siemens AG, T RDA IOT
>> >     Corporate Competence Center Embedded Linux
>> >
>> >
>> >
>> > --
>> > Marco Barletta
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
>
> --
> Marco Barletta
>


-- 
Marco Barletta
