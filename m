Date: Fri, 17 Jul 2009 13:50:14 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4A5F9E8A.3010906@domain.hid>
Message-ID: <Pine.LNX.4.62.0907171349580.28491@domain.hid>
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
	<4A5D88E9.2010305@domain.hid>
	<Pine.LNX.4.62.0907151048370.24398@domain.hid>
	<Pine.LNX.4.62.0907151610090.24888@domain.hid> <4A5F9E8A.3010906@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> they will become two in the end), see below. Please check if it works
> for you.

Aah, I was checking too hastily and missed a compile error. Sorry!
Actually, there's a typo in the get_unmapped_area (filp <-> file), and
it does _not_ work this way, unless the address to map is specified as
the offset when calling do_mmap:

     user_ptr = (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
                        MAP_SHARED, mmap_data->src_vaddr);

Otherwise pptr will simply remain zero.

Kolja


