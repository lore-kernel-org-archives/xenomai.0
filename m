From: Yuan Dai <yuan.dai24@icloud.com>
Message-id: <B4C4C988-263B-479A-92A8-71C47B8CA7A1@icloud.com>
Date: Tue, 24 Apr 2018 16:30:24 -0700
MIME-version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] question on installing xenomai 3 on raspberry pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi=20

I am trying to install xenomai 3 on raspberry pi 3B and would like to =
know where exactly should I put the compiled kernel image on the SD =
card.=20

I have downloaded xenomai v.3.0.2
compiled the kernel by=20
make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtbs
Now I just need to copy the zImage and the device tree to the microSD =
card.=20

But whether I copied to=20
	sudo cp arch/arm/boot/zImage /boot/
or I tried to copy to=20
	 sudo cp arch/arm/boot/zImage /media/${USER}/boot
I cannot get a successful reboot from the new Kernel image.=20

I will either get a black screen after I restart the computer or get a =
warning after sometime for a normal boot.=20
The error code is like this=20
	end kernel panic : attempted to kill init! Exitcode =
=3D0x000000b=E2=80=93not syncing   =20

I believe this is not a xenomai problem but rather a kernel compiling =
issue or even a SD issue. But I have tried several ways by searching =
online and have not had any luck yet. Please let me know if you have any =
suggestions or webpage that I can refer to. Thank you so much for your =
time!

Best,
Yuan


