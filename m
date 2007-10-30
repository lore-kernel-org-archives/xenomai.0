Message-ID: <4726F05F.3060105@domain.hid>
Date: Tue, 30 Oct 2007 00:50:39 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <47266BC6.7060807@domain.hid> <4726EB6E.8020207@domain.hid>
In-Reply-To: <4726EB6E.8020207@domain.hid>
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

Yes, I used make install after run $xenomai/configure --enable-x86-sep.  
Sorry, I forgot to mention in the previous email
I could not get the System.map. vxlimux, and initrd.
Also make clean, make menuconfig would not work after that.
The message was: make: *** No rule to make target 'clean'. Stop.
I have to remove the kernel and start over.
Thanks,
Dennis

Jan Kiszka wrote:
> Dennis Nguyen wrote:
>   
>> I followed the README from xenomai to build kernel+xenomai:
>> -prepare-kernel.sh ...
>> cd $linux_tree
>> make menuconfig
>> make bzImage modules
>> make modules_install
>>     
>
> make install?
>
>   
>> When ever I used $xenomai_root/configure --enable-x86-sep, It won't 
>> create System.map vmlinux, and initrd under/boot.
>>
>> I used different combo kernel linux-2.6.20.10 with xenomai-2.3.4.
>> kernel linux-2.6.22.10 with xenomai-2.4-rc4.
>> kernel linux-2.6.22.10 with xenomai 2.4-rc5.
>> The result for the System.map vmlinux, and initrd under /boot are the 
>> same.  If I do not used the configure --enable-x86-sep then the files 
>> built under /boot.
>>
>> Any suggestion please,
>> Thanks
>> Dennis
>>     
>
> Jan
>
>   

