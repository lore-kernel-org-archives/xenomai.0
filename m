MIME-Version: 1.0
From: "Paul S." <bronetemkinponosec@gmail.com>
Date: Wed, 7 May 2014 22:09:23 +0300
Message-ID: <CAP=r9tPMi_paK7iEmeqHt6z_yHJ14xnHqxiLtrxpkSyazyBfDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  Testing on Freescale i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello there. I'm running Xenomai 2.6.3 on a developer board with imx6q, and
it seems to work perfectly fine for me. I've used ipipe-gch.git from
git.xenomai.org, then checked out to ipipe-3.0-imx6q branch, then I've had
some rough time porting some board-specific code from my 3.0.36 kernel to
3.0.43 from that branch, but besides that everything seems to be working.
I've run LinuxCNC on that, and now I'm stuck writing GPIO driver for
LinuxCNC, but, again, besides that everything seems to be in order.


-- 
sincerely, Paul
