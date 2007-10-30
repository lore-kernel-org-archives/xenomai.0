Message-ID: <47274A14.6060500@domain.hid>
Date: Tue, 30 Oct 2007 07:13:24 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <47266BC6.7060807@domain.hid> <4726EB6E.8020207@domain.hid>
	<4726F05F.3060105@domain.hid> <472741E2.9040206@domain.hid>
In-Reply-To: <472741E2.9040206@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build kernel missing  System.map, vmlinuz,
 initrd when using $xenomai_root/configure --enable-x86-sep
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
Cc: xenomai-help <xenomai@xenomai.org>

Thanks Jan,
It worked,
I need to use the $xenomai_root/configure in a build directory which 
separated from $kernel_tree.
Regards,
Dennis

Jan Kiszka wrote:
> Dennis Nguyen wrote:
>   
>> Yes, I used make install after run $xenomai/configure --enable-x86-sep. 
>> Sorry, I forgot to mention in the previous email
>> I could not get the System.map. vxlimux, and initrd.
>> Also make clean, make menuconfig would not work after that.
>> The message was: make: *** No rule to make target 'clean'. Stop.
>> I have to remove the kernel and start over.
>>     
>
> You need to run make install in the kernel directory. The other
> "install" is for user land libs, tools, etc.
>
> Jan
>   

