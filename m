MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17615.30334.299891.689120@domain.hid>
Date: Tue, 1 Aug 2006 17:42:54 +0200
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668D5@domain.hid>
References: <17615.28311.703965.598653@domain.hid>
	<02AA386EB831044F8537A696BA785C78A668D5@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
 > The queue is opened with O_CREAT | O_RDWR.
 > Please note that I sent an updated version of the code that causes the crash - the queue in both the mq_send and mq_receive is "link_rq_mq".

I should have said "a self-contained example", what are the priorities
of the two tasks ?

-- 


					    Gilles Chanteperdrix.

