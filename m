MIME-Version: 1.0
Date: Tue, 31 Mar 2015 23:01:56 +0200
Message-ID: <CAL5YyVYCeiRSCOQCrx+UkiLj+jqTL2tBUpziisaiSyEV9WAg7w@mail.gmail.com>
From: ACO31 <alain.cordat@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] latency : low_init(): mlockall: Cannot allocate memory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi all,

I've built xenomai 3 rc4 on 3.16.7 kernel. no problem.
see hereafter an extract of the result of "xeno-config --info"
I-pipe release # detected
Cobalt core 3.0-rc4 detected
Build args: --with-core=cobalt ....  --enable-debug=partial
   --enable-registry CFLAGS="-m32" LDFLAGS="-m32".
(No error during make)
But when I launch  "latency -p 100", I have the message
Xenomai/cobalt: low_init(): mlockall: Cannot allocate memory

Could you help me?
Thanks


-- 
Cordialement.

A.Cordat
