MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Wed, 27 Feb 2019 21:00:51 +0530
Message-ID: <CAFUnMkkGg9R8fVBVg7Jd9nSExnGM3HW=+CXH_yC6_8v1NED8pA@mail.gmail.com>
Subject: (rteth0): failed to find device 4 'rteth0' with udev device
 (rteth0-mac): failed to find device 5 'rteth0-mac' with udev
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "J. Kiszka" <jan.kiszka@siemens.com>

Hi,
while starting rtnet I found the below message and I am not able to rtping
(rteth0): failed to find device 4 'rteth0' with udev   device (rteth0-mac):
failed to find device 5 'rteth0-mac' with udev

start running ordered scripts...
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.223795] RTnet:
registered rteth0
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.223797] rt_e1000e: (PCI
Express:2.5GT/s:Width x1) 00:1b:21:63:5e:5b
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.223797] rt_e1000e:
Intel(R) PRO/1000 Network Connection
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.223809] rt_e1000e: MAC:
3, PHY: 8, PBA No: E25867-006
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.232336] initializing
loopback...
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.232345] RTnet:
registered rtlo
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <warn>
[1551281088.7894] device (rteth0): failed to find device 4 'rteth0' with
udev
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7894] device (rteth0): driver '(null)' does not support carrier
detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7896] device (rteth0): driver 'unknown' does not support
carrier detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.235327] RTcap:
real-time capturing interface
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7903] manager: (rteth0): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/3)
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <warn>
[1551281088.7906] device (rteth0-mac): failed to find device 5 'rteth0-mac'
with udev
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7907] device (rteth0-mac): driver '(null)' does not support
carrier detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7908] device (rteth0-mac): driver 'unknown' does not support
carrier detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7915] manager: (rteth0-mac): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/4)
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <warn>
[1551281088.7918] device (rtlo): failed to find device 6 'rtlo' with udev
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7918] device (rtlo): driver '(null)' does not support carrier
detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7920] device (rtlo): driver 'unknown' does not support carrier
detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.7928] manager: (rtlo): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/5)
Feb 27 20:54:48 texsonics-AmITX-SL-G whoopsie[1956]: [20:54:48] Cannot
reach: https://daisy.ubuntu.com
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2624]: Process
'bridge-network-interface' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2625]: Process
'bridge-network-interface' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2624]: Process
'/lib/resolvconf/net-interface-handler start' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2625]: Process
'/lib/resolvconf/net-interface-handler start' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2623]: Process
'bridge-network-interface' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2623]: Process
'/lib/resolvconf/net-interface-handler start' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G ifupdown-hotplug[2646]: Bad ifupdown
udev helper invocation: $INTERFACE is not set
Feb 27 20:54:48 texsonics-AmITX-SL-G ifupdown-hotplug[2645]: Bad ifupdown
udev helper invocation: $INTERFACE is not set
Feb 27 20:54:48 texsonics-AmITX-SL-G ifupdown-hotplug[2650]: Bad ifupdown
udev helper invocation: $INTERFACE is not set
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2625]: Process
'ifupdown-hotplug' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2624]: Process
'ifupdown-hotplug' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2623]: Process
'ifupdown-hotplug' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.247081] RTcfg: init
real-time configuration distribution protocol
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.252087] RTmac: init
realtime media access control
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.255033] RTmac/TDMA:
init time division multiple access control mechanism
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.255956] RTcfg:
rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_SERVER, state=RTCFG_MAIN_OFF
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.255957] RTcfg: next
main state=RTCFG_MAIN_SERVER_RUNNING
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <warn>
[1551281088.8792] device (vnic0): failed to find device 7 'vnic0' with udev
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.8793] device (vnic0): driver '(null)' does not support carrier
detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.8794] device (vnic0): driver 'unknown' does not support carrier
detection.
Feb 27 20:54:48 texsonics-AmITX-SL-G NetworkManager[967]: <info>
[1551281088.8802] manager: (vnic0): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/6)
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2671]: Process
'bridge-network-interface' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2671]: Process
'/lib/resolvconf/net-interface-handler start' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G ifupdown-hotplug[2677]: Bad ifupdown
udev helper invocation: $INTERFACE is not set
Feb 27 20:54:48 texsonics-AmITX-SL-G systemd-udevd[2671]: Process
'ifupdown-hotplug' failed with exit code 1.
Feb 27 20:54:48 texsonics-AmITX-SL-G whoopsie[1956]: [20:54:48] Cannot
reach: https://daisy.ubuntu.com
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.354228] RTcfg:
rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_ADD,
state=RTCFG_MAIN_SERVER_RUNNING
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.354709] RTcfg:
rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_ADD,
state=RTCFG_MAIN_SERVER_RUNNING
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.355134] RTcfg:
rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_ADD,
state=RTCFG_MAIN_SERVER_RUNNING
Feb 27 20:54:48 texsonics-AmITX-SL-G kernel: [   63.356391] RTcfg:
rtcfg_do_main_event() rtdev=1, event=RTCFG_CMD_WAIT,
state=RTCFG_MAIN_SERVER_RUNNING
Feb 27 20:54:49 texsonics-AmITX-SL-G kernel: [   63.518258] TDMA: Failed to
transmit sync frame!
