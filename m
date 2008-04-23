Message-ID: <2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
Date: Wed, 23 Apr 2008 15:58:47 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, Apr 23, 2008 at 3:47 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>
>
>
>
> Gilles,

Please keep sending copies to the mailing list, other might be
interested by your questions.

>
>  thank you for responding to my query.  What would be the right method for
> reading byte-at-a-time using the Xenomai drivers?

I do not pretend to know a "right" method. However, what looks simpler
is to call rt_dev_read in a loop.

> Do I even need an RT task to read from the serial driver?

Yes, if the task needs to be suspended (because there is no byte ready
yet), it has to be a real-time task.

Regards.

-- 
 Gilles

