MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17615.28311.703965.598653@domain.hid>
Date: Tue, 1 Aug 2006 17:09:11 +0200
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668D3@domain.hid>
References: <17615.26137.595343.554692@domain.hid>
	<02AA386EB831044F8537A696BA785C78A668D3@domain.hid>
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
 > //*********************************************************
 > // The following is a snippet from the kernel module:
 > // (If the delay is put in, it works fine.)
 > //**********************************************************
 > 
 > static void *LinkThread (struct net_device *dev)
 > {
 > 	int status;
 > 	link_request linkr;
 > struct timespec ttt,xxx;
 > ttt.tv_sec = 2;
 > ttt.tv_nsec = 0;
 > 
 > 	while (1)
 > 	{
 > 		if ((status=mq_receive (link_rq_mq, (char *)&linkr, sizeof (linkr), 0)) > 0)
 > 		{
 > //nanosleep (&ttt, &xxx);
 > 			status = mq_send (link_rq_mq_out, (char *)&linkr, sizeof (linkr), 0);
 > 		}
 > 	}
 > 	return 0;
 > }

What are the flags passed to mq_open ? If for example O_NONBLOCK is set,
then the behaviour you observe is normal.

-- 


					    Gilles Chanteperdrix.

