Message-ID: <2ff1a98a0803280845s73e4081qf1262f9cb8313702@domain.hid>
Date: Fri, 28 Mar 2008 16:45:20 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803280842p2b86e144xf03e372bb92dcad4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
	<2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
	<d6c8ef150803280646y4fd12734v862b4f399727a5b5@domain.hid>
	<2ff1a98a0803280654u35f2da13t16a145ac22c1714f@domain.hid>
	<2ff1a98a0803280655r665412f5qfa8ada46f630536a@domain.hid>
	<d6c8ef150803280828v59f764en6bbb543fd6b7b8f7@domain.hid>
	<2ff1a98a0803280834t38a195eey3fce0bb0c5ef9831@domain.hid>
	<d6c8ef150803280842p2b86e144xf03e372bb92dcad4@domain.hid>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

<bosko.radivojevic@domain.hid> wrote:
> Ok, but Im using native (xeno) skin, both in kernel thread and in user
>  space app. O_CREAT is flag for shm_open & other posix functions,
>  right? And, yes, send me your patch please.

You have exactly the same problem with the native skin: you do not
create the heap.

-- 
 Gilles

