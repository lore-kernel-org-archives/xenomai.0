Subject: Re: [Xenomai-help] Needed files/device nodes for Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54b161f50611121034y2f81e293k9d78c3dce9760f1e@domain.hid>
References: <54b161f50611121034y2f81e293k9d78c3dce9760f1e@domain.hid>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 19:43:14 +0100
Message-Id: <1163356995.12206.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-11-12 at 19:34 +0100, Frits de Klark wrote:
> Hello everyone,
> 
> are there, besides the rtp* and rtheap device nodes, any files or
> nodes Xenomai relies on to load correctly?

None. The system would even load correctly without those, only the
applications using the pipes or the features involving shared memory
support (e.g. queues with Q_SHARED attribute and heaps with H_MAPPABLE
attribute) would choke on this.

>  I'm getting a -19 error (No such file of directory) on startup using
> a custom built Linux configuration.
> 

-ENODEV likely means that you try to load a skin requiring periodic
timing support (e.g. VxWorks) without having switched it on in the
Xenomai configuration.

> I could provide some more detailed information, but not at the moment,
> since I don't have access to the system right now.
> 
> Thanks in advance.
> 
> Best regards,
> 
> Frits
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



