MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Tue, 23 Feb 2021 12:36:09 +0100
Message-ID: <CAFZ-hKhxmHDYOqQT_TWJaCLoFTiXB7d0Py_9XXLZehMshMBR-A@mail.gmail.com>
Subject: rebuild kernel
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, I'm new to Linux and xenomai. I installed xenomai on raspberry and it
works great. However, some kernel modules are missing. If I want to
recompile the kernel with the missing modules, what I need to do is:
$ make clean
$ make menuconfig (and insert the modules)
$ make
$ make modules_install
$ make install

reboot the system.
Is this correct?
