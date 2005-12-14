Message-ID: <43A082F1.1060902@domain.hid>
Date: Wed, 14 Dec 2005 21:39:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Moving from 2.0 to 2.1
References: <43A0701F.5090205@domain.hid>
In-Reply-To: <43A0701F.5090205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
> 
> I have recently updated my source tree from 2.0.1 to the latest from 
> trunk. I have run the prepare scripts and xconfig. (I am building a 
> vanilla 2.6.12 kernel) I can see the new options in the kernel .config 
> file. I can make and install my new kernel no problem. I then run 
> configure and rebuild Xenomai, again no problem. After installing 
> Xenomai I try to build my test application. Here I get link errors.
> 
> I am using the rt_task_send() / rt_task_receive() functions. I see that 
> I need the CONFIG_XENO_OPT_NATIVE_MPS options in the Xenomai build to 
> include the task send/recv function. After looking through the source I 
> see that none of my NATIVE options appear in the xeno_config.h file. 
> These options are enabled in the kernel .config file.
> 
> What am I missing? I am not an autoconf expert so any advice is appreciated.
> 

Nothing, my mistake. The user-space code may not depend on any kernel 
switch anymore. Fixed in the trunk (resync src/skins/native/task.c). Thanks.

-- 

Philippe.

