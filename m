Date: Tue, 27 Jan 2015 16:39:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150127153903.GD16502@hermes.click-hack.org>
References: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1942863149.11150.1422371568908.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Patch rtnet support Intel i217/i218 Ethernet
	Controller
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Jan 27, 2015 at 04:12:48PM +0100, Huy Cong Vu wrote:
> Hello Xenomai group, 
> I recently run a test of rtnet on xenomai-3-next on my Intel NUC D54250WYK with the Intel I218V Ethernet Controller. 
> It is patched on linux 3.14.17. Here I attached the patch to make rtnet work with i217/i218 Intel family. 
> Also, I found out that in rtpacket module, the declaration of packet_proto_drv lack of .device_count attribute, which makes the rtpacket & rtcap modules unable to loaded ( -EINVAL is returned), so I merge it in my patch too. 
> I test on my system and all the following command is now working: 
> modprobe rtnet 
> modprobe rt_e1000e 
> modprobe rtpacket 
> modprobe rtcap 
> rtifconfig rteth0 up 
> ifconfig rteth0 up 
> ifconfig rteth0-mac up 
> But if I used the rteth0 interface, I can't unload rt_e1000e. 
> Could you take a look and see if anything is wrong, and if you find it useful, merge it in your git repository. 
> Best regards, 

In Xenomai 3, you need to deconfigure the interface before you try
to unload it.

-- 
					    Gilles.

