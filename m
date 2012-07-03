MIME-Version: 1.0
Date: Tue, 3 Jul 2012 15:30:31 +0200
Message-ID: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai and normal linux application - Wait time with
	select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I have a normal linux application running. Application waits in
following loop normally about 8 ms. Delay time of 8ms is reliable.

do
   {
      remain(&remainTime);

      if ((remainTime.tv_sec != 0L) || (remainTime.tv_usec != 0L))
         result = select(0, NULL, NULL, NULL, &remainTime);
      else
         break;
   }
   while ((result == -1) && (errno == EINTR));

If there is running in parallel a Xenomai application the wait time
could be up to 40 ms accidentally. What could be the reason?

Thanks and regards,
Jens

