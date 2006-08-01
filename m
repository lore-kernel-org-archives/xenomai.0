From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17615.26137.595343.554692@domain.hid>
Date: Tue, 1 Aug 2006 16:32:57 +0200
Subject: Re: [Xenomai-help] mq_send /mq_receive problem
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668D1@domain.hid>
References: <200608011001.k71A1RPp024916@domain.hid>
	<02AA386EB831044F8537A696BA785C78A668D1@domain.hid>
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

Landau, Bracha wrote:
 > I have a low priority thread running in the kernel which receives to a message queue and writes to the same message queue after it processes the message. The message queue is opened for reading and writing.
 > Without a delay (with nanosleep) between the reading (mq_receive) and writing (mq_send), the kernel hangs.
 > If I put in a small delay between the mq_send and mq_receive, the mechanism works fine.
 > Why is this?

You probably found a bug, could you send us a small example allowing us
to reproduce this bug ?

-- 


					    Gilles Chanteperdrix.

