Message-ID: <47266BC6.7060807@domain.hid>
Date: Mon, 29 Oct 2007 16:24:54 -0700
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] build kernel missing  System.map, vmlinuz,
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
To: xenomai-help <xenomai@xenomai.org>

I followed the README from xenomai to build kernel+xenomai:
-prepare-kernel.sh ...
cd $linux_tree
make menuconfig
make bzImage modules
make modules_install

When ever I used $xenomai_root/configure --enable-x86-sep, It won't 
create System.map vmlinux, and initrd under/boot.

I used different combo kernel linux-2.6.20.10 with xenomai-2.3.4.
kernel linux-2.6.22.10 with xenomai-2.4-rc4.
kernel linux-2.6.22.10 with xenomai 2.4-rc5.
The result for the System.map vmlinux, and initrd under /boot are the 
same.  If I do not used the configure --enable-x86-sep then the files 
built under /boot.

Any suggestion please,
Thanks
Dennis

