Message-Id: <54FD7EBF0200005500018D0E@iwesmail-ks.iwes.fraunhofer.de>
Date: Mon, 09 Mar 2015 11:06:39 +0100
From: <jonas.platte@iwes.fraunhofer.de>
References: <54FD770A0200005500018D03@iwesmail-ks.iwes.fraunhofer.de>
 <54FD7EBF0200005500018D0E@iwesmail-ks.iwes.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtnet: could not insert 'rtudp': Invalid argument
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 I have managed to set up rtnet with Xenomai 3.0 with the help of Gilles now, but I am running
running into a problem that I haven't had with Xenomai 2.6: When trying to start rtnet,
"modprobe rtudp" fails. Rebinding the driver for the ethernet card that's supposed to do the
realtime communication works, so the setup isn't completely broken.

I can reproduce the same error message by manually calling "sudo modprobe rtudp" or
"sudo insmod /lib/modules/3.14.28/kernel/drivers/xenomai/net/stack/ipv4/udp/rtudp.ko".

dmesg and /var/log/kern.log sadly don't show anything directly related, but I still attached
the dmesg output generated when executing "rtnet start", maybe it can give a hint.

If someone could give me a tip on where to find more debug info, that would be nice.

Thanks,
Jonas

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: dmesg-output.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150309/2758ce5a/attachment.txt>
