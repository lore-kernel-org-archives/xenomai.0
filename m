From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Wed, 4 Nov 2009 16:19:24 -0700
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310307D6@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Sharing Semaphores in Kernel and User Space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

All,

I am writing a driver that needs to wake up a user space thread on a hardwa=
re interrupt.  I am reading about the Xenomai APIs semaphores and want to k=
now if I create a semaphore in my kernel module with a given name using rt_=
sem_create, can I call rt_sem_bind in user space to bind to that same semap=
hore?

I am sure hoping the answer is yes!

Thanks,

Jonathan




