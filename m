Date: Mon, 29 Oct 2007 22:22:44 -0700 (PDT)
From: DENNIS NGUYEN <dennisnguy@domain.hid>
In-Reply-To: <47266BC6.7060807@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1565005967-1193721764=:68052"
Content-Transfer-Encoding: 8bit
Message-ID: <780725.68052.qm@domain.hid>
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
To: xenomai-help <xenomai@xenomai.org>

--0-1565005967-1193721764=:68052
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Similar issue, after I used $xenomai_root/configure --enable-x86-sep for a i386, and make install.  I can't do any make, such as make clean, make menuconfig.
The message was: make: *** No rule to make target 'clean'. Stop.
I had to remove the build and start over.
This issue happened regardless to different combination of kernel and xenomai.
The question is: Do I need to enable-x86-sep for i386.  If yes, how can I get vmlinux, initrd, System.map under /boot? Any suggestion to resolve the build problem? 
Thanks,
Dennis

PS: I used make install after the $xenomai/configure --enable-x86-sep.

Dennis Nguyen <dennisnguy@domain.hid> wrote: I followed the README from xenomai to build kernel+xenomai:
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


--0-1565005967-1193721764=:68052
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Similar issue, after I used $xenomai_root/configure --enable-x86-sep for a i386, and make install.&nbsp; I can't do any make, such as make clean, make menuconfig.<br>The message was: make: *** No rule to make target 'clean'. Stop.<br>I had to remove the build and start over.<br>This issue happened regardless to different combination of kernel and xenomai.<br>The question is: Do I need to enable-x86-sep for i386.&nbsp; If yes, how can I get vmlinux, initrd, System.map under /boot? Any suggestion to resolve the build problem? <br>Thanks,<br>Dennis<br><br>PS: I used make install after the $xenomai/configure --enable-x86-sep.<br><br><b><i>Dennis Nguyen &lt;dennisnguy@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> I followed the README from xenomai to build kernel+xenomai:<br>-prepare-kernel.sh ...<br>cd $linux_tree<br>make menuconfig<br>make bzImage modules<br>make
 modules_install<br><br>When ever I used $xenomai_root/configure --enable-x86-sep, It won't <br>create System.map vmlinux, and initrd under/boot.<br><br>I used different combo kernel linux-2.6.20.10 with xenomai-2.3.4.<br>kernel linux-2.6.22.10 with xenomai-2.4-rc4.<br>kernel linux-2.6.22.10 with xenomai 2.4-rc5.<br>The result for the System.map vmlinux, and initrd under /boot are the <br>same.  If I do not used the configure --enable-x86-sep then the files <br>built under /boot.<br><br>Any suggestion please,<br>Thanks<br>Dennis<br></blockquote><br>
--0-1565005967-1193721764=:68052--

