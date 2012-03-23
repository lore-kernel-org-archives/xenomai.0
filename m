Message-ID: <4F6C3D32.70801@domain.hid>
Date: Fri, 23 Mar 2012 10:06:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F6A065E.9030309@domain.hid> <4F6B45B3.7080904@domain.hid>
	<4F6B554A.4080008@domain.hid>
In-Reply-To: <4F6B554A.4080008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using xenomai with standard ethernet driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-03-22 17:37, Roberto Bielli wrote:
> I explain better the problem.
> 
> I want to use ethernet driver raw without using all the abstract layer 
> (tcp, socket etc....)
> and my xenomai application must link to the raw driver without enter in 
> secondary mode.
> 
> Have i change the driver interface with xenomai calls (rtdm_......) or 
> is there another chance ?

Did you check if RTnet already has support for your NIC? Then you are
fine with a stack of rtnet.ko, rtpacket.ko, and <your-nic>.ko.

If not, there are two options
 - add an RTnet driver for you hardware
 - implement some home-brewed stack

The second option may only look different on first sight. But,
specifically if your application is not kernel-hosted but a proper
userspace app, RTnet provides quite a few useful building blocks for
your scenario.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

