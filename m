MIME-Version: 1.0
Date: Thu, 17 Apr 2014 13:14:40 +0200
Message-ID: <CACKc53+X9XQ1tqJXrcW8qLrmBVoCfDvqozjVwMDWEQUabHL2oA@mail.gmail.com>
From: Wojciech Domski <wojciech.domski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Configuring analog subdevice via analogy interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear all,

I have question concerning analog subdevice support in Analogy.

I have signal Sensoray 626 which is capable of setting range
for analog input to +/-5V or +/-10V. During writing the driver
for Sensoray 626 I have ported a function which address
is put into field of subdevice structure do_cmd.

This function can configure multiple channels of analog
subdevice separately. However, what should I use from
User Space interface to invoke this function (do_cmd)
in kernel space?

I have tried using a4l_snd_command but this one
seems to be dedicated for digital subdevices.
Is there a way to do what I want to?

Best regards,
Wojciech Domski

Domski.pl
