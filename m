MIME-Version: 1.0
From: Jayadev Kumaran <jayadevk123@gmail.com>
Date: Thu, 1 Dec 2016 20:13:39 +0530
Message-ID: <CAOG0fenP6pEaXF=OM0aA9eDo3opzcqgO6ueWN2JojFRC0H1_Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Unable to mount shared folder from the host.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello ,

I'm very new to Xenomai and currently trying to mount a shared folder from
my host onto Xenomai running on qemu emulator (arm64 platform).
1. I have verified that 9P options are enabled in the kernel configuration.
2. I'm running the qemu emulator with the below command;

*qemu-system-aarch64 -M virt -cpu cortex-a57 -kernel Image -initrd
rootfs.img.gz -nographic -append "console=ttyAMA0 root=/dev/ram
rootfstype=ramfs init=/bin/sh" -snapshot -fsdev
local,id=test_dev,path=/home/jayadev.kumaran/Documents/arm/ltp,security_model=passthrough
-device virtio-9p-pci,fsdev=test_dev,mount_tag=test_mount*

3. I'm trying to mount the folder using


*mount -t 9p -o trans=virtio test_mount /tmp/shared/
-oversion=9p2000.L,posixacl,cache=loose*
However I m seeing the below log:
9pnet_virtio: no channels available
mount: mounting test_mount on /tmp/shared/ failed: No such file or directory

*QUERY: Am I doing it the right way ? Is there any other method by
which I can share/copy a folder on my host system to the Qemu
platform.*

Thanks and Regards,

Jayadev
