MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Mon, 2 Jul 2018 20:42:14 +0530
Message-ID: <CAFUnMkkRqbz9FDt6xAhN679vA4rSF-Q7c=fBqyDc89Fz2gH4-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] xeno_nucleus.xenomai_gid=125 crashkernel=384M-:128M
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

hi,

when I did

dmesg | grep -i crash

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.14.17-xenomai-2.6.4
root=UUID=813858f4-8e1e-4ace-8f8f-ceac0a0ca164 ro
xeno_nucleus.xenomai_gid=125 crashkernel=384M-:128M

I got this above message
will this create problem in rtdm
