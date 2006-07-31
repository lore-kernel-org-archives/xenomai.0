Message-ID: <44CDF156.9090205@domain.hid>
Date: Mon, 31 Jul 2006 14:02:30 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] two questions about using rtdm
References: <02AA386EB831044F8537A696BA785C78A668C0@domain.hid>
	<44CDEF6D.3030403@domain.hid>
In-Reply-To: <44CDEF6D.3030403@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "Landau, Bracha" <BLandau@domain.hid>

Jan Kiszka wrote:
> Landau, Bracha wrote:
>> -----Original Message-----
>> From: xenomai-help-bounces@domain.hid
>> [mailto:xenomai-help-bounces@domain.hid Behalf Of
>> xenomai-help-request@domain.hid
> 
> <snip>
> 
> Could you please avoid re-using posted mails for new threads? Thanks.
> 
>> Two questions regarding rtdm:
>>
>> 1) I would like to use the real-time system calls (bind,socket,send,recv, etc) that are included in the API (i.e., rt_dev_socket, rt_dev_bind...).
>> I tried to replace the calls to their rt equivalents (e.g., socket becomes rt_dev_socket). But apparently that is not enough, because when I do a call to rt_dev_socket, I get an error.
>> Are there any examples of how to use the r/t sockets?
> 
> RTnet for real-time networking over Ethernet, Firewire (eth1394 together
> with the RT-FireWire package), or WLAN (experimental rt2x00). Soon to
> come: RT-CAN via socket interface (patch is working, Wolfgang is
> currently cleaning up). Ah, and the special-purpose protocol driver TiMS
> (Tiny Messaging Service) that comes with RACK
> (developer.berlios.de/projects/rack).
> 
> If you are missing something, feel free to write and register your own
> RTDM protocol driver. ;)
> 
>> 2) I am running on an MPC8247 with two CPM serial ports. Can I use the 16650A driver provided by xenomai to "impersonate" the CPM serial driver? If not, can you instruct me how to do this?
> 
> That's one for the PPC experts, but I bet the UART is not compatible
> with the 16550A controller, is it?

It is _not_ compatible and it requires porting to RTDM.

Wolfgang.


