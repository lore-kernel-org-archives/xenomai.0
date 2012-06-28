MIME-Version: 1.0
Date: Thu, 28 Jun 2012 10:05:25 +0200
Message-ID: <CANKLDmuw2sM5PD0G1YvObij1dZvdm743hEMMP=6Ljg+k2ZSOQQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] How setup receive-timeout for rt_dev_recvfrom?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Xenomai-list,

I am using the native API and RTDM to read from a RTNet realtime interface.
This all works, however, I need a timeout on the rt_dev_recvfrom.

As there is no rt_dev_select function, I tried to setup a receive
timeout, similar to how the XDDP examples do:

        {
                struct timeval tv;
                tv.tv_sec = 1;
                tv.tv_usec = 0;
                ret = rt_dev_setsockopt(s, SOL_SOCKET, SO_RCVTIMEO,
                                 &tv, sizeof(tv));
                if (ret)
                        fprintf(stderr, "rt_dev_setsockopt: %s\n",
strerror(-ret));
        }

Unfortunately this results in "No such device".

Does anyone know how to properly setup a receive timeout?

Thanks,
Henri

