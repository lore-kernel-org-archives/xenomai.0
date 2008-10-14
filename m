Message-ID: <48F4B453.9050700@domain.hid>
Date: Tue, 14 Oct 2008 17:01:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F3B4D7.7070109@domain.hid>
In-Reply-To: <48F3B4D7.7070109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnpipe: what's up with xnpipe_setup?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> xnpipe_setup and the callbacks it sets is dead code for in-tree Xenomai
> users. Going back to, well, fusion-0.6.9 (the oldest version we have in
> LXR), it used to be dead meat already at that time. Can we remove it?
> 

We can and should emulate the close handler using the input one, so we may get
rid of the former.

We need some way to fire a callback in a skin implementation when userland
connects, this is what the open handler was for; this may be required for
implementing more complex data channels over the generic message pipe code. Ok,
we could also divert the input handler for that purpose as well, and it makes
little sense to keep a full interface just for that case.

Go ahead, remove that code, but if a skin developer ever comes and complains
about the terminal ugliness of our input handler looking like a kitchen sink in
a near future, I will ruthlessly direct him to YOU. Ah! Fair enough?

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.


