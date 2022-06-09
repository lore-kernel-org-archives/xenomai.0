MIME-Version: 1.0
From: Davide Valeri <engineervalide@gmail.com>
Date: Thu, 9 Jun 2022 12:52:56 +0200
Message-ID: <CAA09Y8RZo_QUN_ncm7UighfkC9imE68FsnZx=M__pQbX9K_j=A@mail.gmail.com>
Subject: SPI
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Roberto Ferri <ironsnetwork@gmail.com>, xenomai@xenomai.org

Hi!
We need your help once more.
We cannot enable SPI in the built kernel. Neither "sudo raspi-config"
nor manually editing "config.txt" worked.

Using "raspi-config" results in
"mount: /config/device-tree: mount point does not exist
* Failed to mount configfs - 2"

Commit linux-evl: 81e5b7be.

We're using the bcm2711_defconfig provided by [1].
We tried the kernel from the repository in [1] and we were able to enable SPI.

Do you experience something like this?

Davide Valeri

[1] https://github.com/raspberrypi/linux/blob/rpi-5.15.y/arch/arm64/configs/bcm2711_defconfig
(commit: 9b573727)

