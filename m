Message-ID: <b647ffbd0705030306i38b9abfdlb6740fdbf6b39b28@domain.hid>
Date: Thu, 3 May 2007 12:06:26 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <164351.60035.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <461F1A14.9090609@domain.hid>
	<164351.60035.qm@domain.hid>
Subject: Re: [Xenomai-core] Xenomai module poblem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

Hi,

> I came across Dmitry Adamushko doing the same work,
> may if any pointers you have will help us.

That was my intention and I started to implement some bits.. but
shortly after that you announced an "alsmost-completed" port (as I
recall it was estimated to be released somewhere in April) so I
decided not to duplicate efforts (as it was just for fun, not any
need-for-work necessity) but rather help with reviewing and
straightening of the code once it gets released.


>  May 12 is the date to where we think of giving the
> final release.

> [...] now we are left with only one problem the xenomai
> module doesnt work for us, it fails in start_thread
> for module. same context switch will be used for
> xenomai module also [...]

sorry, but this looks like a mess and one should guess really hard to
extract some relevant bits (if any).

start_thread() == xnpod_start_thread? for module? what kind of
"context switch" term can used for module (== kernel module)? and you
claim that "all User RT Applications are working fine" and "the
xenomai module doesnt work for us".

I think noone is able to help you unless (1) you do release code
publicly or (2) you are really very specific (technically-wise)
describing your problem. (2) is not that easy as it would require
looking at other parts of the code and we are, well, kind of "blind"
here.


-- 
Best regards,
Dmitry Adamushko

