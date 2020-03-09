Date: Mon, 09 Mar 2020 15:58:30 +0100
Message-ID: <20200309155830.Horde.qT5DihtwzbpuZDudGbUV2U3@webmail.b-tu.de>
From: Benji <miethben@b-tu.de>
Subject: [RTnet] RTcfg: error -11
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

i try to get RTnet up and running, but there are some issues with setup.

Two system are connected via a switch. Both have 2 network interface,
Intel i210 and Intel 82574L. Only Intel i210 is used by Xenomai/ RTnet.
One system is configured as master in 'rtnet.conf', the other one as a
slave. If 'rtnet start' is executed following outputs appears.

Master:

> Waiting for all slaves...

Slave:

> Stage 1: searching for master...

RT interface came up as 'rtifconfig' is shown, but both hang on there stages.

At master the dmesg output are floated with messages like:

> [  323.903321] rt_igb: rteth0: Reset adapter
> [  323.905082] TDMA: Failed to transmit sync frame!
> [  323.910082] TDMA: Failed to transmit sync frame!
> [  323.915083] TDMA: Failed to transmit sync frame!
> [  323.920083] TDMA: Failed to transmit sync frame!
> [  323.932087] RTcfg: error -11 while sending stage 1 frame

Anybody knows that error -11 means? I can't find any information on
this error code.

Thanks
Benji


