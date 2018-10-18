Date: Thu, 18 Oct 2018 20:15:26 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <2142626899.12326395.1539893726025@mail.yahoo.com>
In-Reply-To: <a74daedf-fd85-e6b6-0d3b-ecc279b0f837@gmail.com>
References: <0320e06c-4014-9294-0ff6-8cd6515fba24@gmail.com>
 <6e5a44b3-2ad4-ee3f-cd89-247b0b0ad7ac@gmail.com>
 <CALLqZ8T+5WSdTYGMiJr8S6x8gFaAN8tmp8Dtri8Fu+uxPwXUMw@mail.gmail.com>
 <f735d7fe-da3f-da95-0aac-a5a77430dac9@gmail.com>
 <6fc75021-86b5-0120-a59e-fd81ba6f40f6@gmail.com>
 <a74daedf-fd85-e6b6-0d3b-ecc279b0f837@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai v.3.0.7 on Ubuntu 18.04 and kernel 4.9.90
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I would suggest building the kernel without an initial ramdisk, and using only the vmlinuz image itself. Adding earlyprintk=vga to the kernel params may help as well to get some valuable input.

Disable initramfs support in your kernel config, don't use dracut or anything, then try again.

Alec

