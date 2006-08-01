Subject: Re: [Xenomai-help] mq_send /mq_receive problem
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668D1@domain.hid>
References: <02AA386EB831044F8537A696BA785C78A668D1@domain.hid>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 16:34:21 +0200
Message-Id: <1154442862.4963.24.camel@domain.hid>
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
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-08-01 at 17:27 +0300, Landau, Bracha wrote:
> I have a low priority thread running in the kernel which receives to a message queue and writes to the same message queue after it processes the message. The message queue is opened for reading and writing.
> Without a delay (with nanosleep) between the reading (mq_receive) and writing (mq_send), the kernel hangs.
> If I put in a small delay between the mq_send and mq_receive, the mechanism works fine.
> Why is this?

The normal (i.e. non-RT) kernel operations need some cycles to run too.
Does your application enter an infinite loop receiving and sending
messages?

> ***********************************************************************************
> This email message and any attachments thereto are intended only for use by the addressee(s) named above, and may contain legally privileged and/or confidential information. If the reader of this message is not the intended recipient, or the employee or agent responsible to deliver it to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the postmaster@domain.hid and destroy the original message.
> ***********************************************************************************
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



