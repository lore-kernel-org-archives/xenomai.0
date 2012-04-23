Message-ID: <4F951555.2070403@domain.hid>
Date: Mon, 23 Apr 2012 10:39:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKvQZ_2H38BtL++2LMhnh_1YOFcia4tR-5FyuQ1SskO3er2RrA@mail.gmail.com>
In-Reply-To: <CAKvQZ_2H38BtL++2LMhnh_1YOFcia4tR-5FyuQ1SskO3er2RrA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Smi workaround on ICH8M
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

On 04/23/2012 03:51 AM, Willy Lambert wrote:
> Hi,
>
> I have a message  in dmesg about SMI workaround :
> Xenomai: SMI-enabled chipset found, but SMI workaround disabled
>           (check CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter
>           high interrupt latencies!
>
> My kernel should be configured properly and following the "In case of
> high latencies" of
> http://www.xenomai.org/index.php/Configuring_x86_kernels thread, I did
> some tests.
>
> Latency test is here (if it is us it should be ok no ?):
>

Yes, this looks ok, but you need to run this test longer, and try a few 
usual suspects like plugging in/out USB devices while doing so (e.g. 
mouse, netdev).

The point of this message is to tell you that your chipset is known to 
create latency issues in some cases (like most Intel chipset these 
days), but you did not enable the Xenomai code which works around such 
issues by shutting down problematic SMI sources. That may be right, or 
even required to leave all the SMI sources enabled (e.g. thermal 
control), but this might also lead to unacceptable latency spots. YMMV.

This is basically a heads up message.

-- 
Philippe.

