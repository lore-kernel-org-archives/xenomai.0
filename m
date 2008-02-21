Date: Thu, 21 Feb 2008 09:44:56 -0500
References: <200802202358.25792.ngustavson@domain.hid>
	<47BD316D.3070801@domain.hid>
In-Reply-To: <47BD316D.3070801@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802210944.56033.ngustavson@domain.hid>
From: NZG <metalninjadragon@domain.hid>
Subject: Re: [Xenomai-help] writing from user space through fifo problems
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

> Are you sure it is EINTR? A first glance at the possible code path,
> specifically at xnpipe_recv, suggests that you cannot reach the line
> returning this error code if TM_NONBLOCK was passed.
Your right, my mistake sorry.
It's returning EAGAIN , which is the same thing as  EWOULDBLOCK in my kernel 
headers, which corresponds to the correct value when data i s not available, 
but doesn't explain why data is never received.

> What Xenomai version are we talking about BTW? 
2.3.1 (blackfin 537 build)

> And, as usual: 
> self-contained simple test cases are always appreciated. :)
I'll try to put something together tonight.

thx,
NZG




