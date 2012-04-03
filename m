Message-ID: <4F7B40DD.2030904@domain.hid>
Date: Tue, 03 Apr 2012 20:26:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
	<4F7A133E.7000505@domain.hid> <4F7A2039.2040409@domain.hid>
	<4F7A211F.1080809@domain.hid> <4F7AACC1.6080500@domain.hid>
	<4F7AADFD.3060506@domain.hid> <4F7AD9BD.1070201@domain.hid>
	<4F7B35AA.3020604@domain.hid> <4F7B3ED4.3080003@domain.hid>
In-Reply-To: <4F7B3ED4.3080003@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 2012-04-03 20:17, Gilles Chanteperdrix wrote:
> Ok, I get it, I need -net nic -net user. The first is for the nic in the
> guest, the second configures by what means the physical network will be
> emulated. I would have liked the qemu guest to appear on my LAN, but
> that will do.

That requires a bridge on the host and a tap device backend. Upcoming
qemu-1.1 will even have a helper daemon to create those tap devices with
raised privileges and allow unprivileged QEMU instances to use them.

In fact, the new style configuration is "-netdev user,id=mynet -device
e1000,netdev=mynet". That avoids the internal vlans and allows for more
efficient networking (virtio frontend + vhost backend).

Well, there is more, and you can easily get lost on the documentation of
old and new features...

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

