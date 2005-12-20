Date: Tue, 20 Dec 2005 18:52:10 -0500
From: Kent Borg <kentborg@domain.hid>
Subject: Re: [Xenomai-help] Shared Memory?
Message-ID: <20051220185210.U16178@domain.hid>
References: <20051220183927.T16178@domain.hid> <43A89841.1070407@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A89841.1070407@domain.hid>;
	from jan.kiszka@domain.hid on Wed, Dec 21, 2005 at 12:48:17AM +0100
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

On Wed, Dec 21, 2005 at 12:48:17AM +0100, Jan Kiszka wrote:
> Use mixed RT/non-RT threads and you will have shared mem for free, use
> processes and you only have to ask linux for some shared fragments. In
> any case don't forget to mlockall() your RT-processes!

So does that mean regular shmget() to set up the shared memory, and
mlockall() in the RT process?  I was thinking mlock(), but you have a
point that mlockall() would be better!

I haven't done shared memroy before, but it looks pretty easy.


Thanks,

-kb

