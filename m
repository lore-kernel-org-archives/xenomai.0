From: "Bradley Valdenebro Peter (DC-AE/EHP2)"
 <Peter.BradleyValdenebro@boschrexroth.nl>
Date: Wed, 20 Jun 2018 13:47:57 +0000
Message-ID: <c585031876064cb6af24535985b55b8c@boschrexroth.nl>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai system tick
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

First off, thanks to all the Xenomai community for making it possible to have a real-time framework in Linux.

We are a group of engineers at Bosch-Rexroth which use Linux on one of our motion control products. Since we have real-time constraints within the control loops Xenomai is also used.

We recently moved from a DSP based design to a more generic CPU/Linux design.
We are using a Zynq Z-7020 SoC (2x ARM Cortex-A9 processors (ARM v7)) running Linux 4.4/Xenomai 3.0.6. We patch the linux kernel with  ipipe-core-4.4.43-arm-8 patch. Currently we are running Linux on one CPU and Xenomai on the other.

Our high-level control loop runs at 8kHz (125us) and we must make sure deadlines are met.
We are using ftrace to study the behaviour of our system. Linux is configured with a 1000Hz (1ms) system tick. We were expecting Xenomai to use this same tick.
By looking at a recorded trace we can see that for every Linux tick there are 6-7 Xenomai ticks. Each Xenomai ISR tick takes around 15us-20us. This means that for every 1ms we are using around 10% to 15% to handle these interrupts. Find attached a screenshot of  the trace using kernelshark.

We believe our 8kHz control loop is being impacted by this. If we change the interrupt tick affinity to the Linux CPU we see on average a 20us performance improvement on the loop. When the Xenomai tick takes place on the Linux CPU we experience problems on our Ethernet/PTP network (handled by Linux).

At this point we are not looking for a workaround or a change in our system's architecture. We want to understand Xenomai's behaviour. For that we have some questions we were hoping you could help us with:


*         Why is the Xenomai system tick running at such a "high" frequency?

*         How is this frequency established and can we modify it?

*         How does Xenomai/ipipe make sure the Linux system tick is delivered accurately every 1ms?

Thanks and best regards,
Peter Bradley
-------------- next part --------------
A non-text attachment was scrubbed...
Name: VirtualBox_einx922v_20_06_2018_15_36_05.png
Type: image/png
Size: 269197 bytes
Desc: VirtualBox_einx922v_20_06_2018_15_36_05.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180620/ad77f920/attachment.png>
