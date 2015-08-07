MIME-Version: 1.0
Sender: jpromerob@unal.edu.co
Date: Fri, 7 Aug 2015 16:33:51 +0200
Message-ID: <CANccXAOs9RNb7+a=CSZV_Qk9HyOsorH0C=PnFMk3HF1vuakzug@mail.gmail.com>
From: Juan Pablo Romero Bermudez <jpromerob@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTnet: Unsupported Xenomai version 3.0-rc5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I installed xenomai-3.0-rc5 on linux kernel 3.18.12. Now I'm trying to
install RTnet-0.9.13 ...

I do:

/configure --with-rtext=/usr/xenomai
--with-linux=/path_to_linux_with_xenomai_extension

and I get:
...
...
...

checking for RT-extension... /usr/xenomai (Xenomai 2.0.x)
checking for Xenomai version... configure: error: *** Unsupported Xenomai
version 3.0-rc5 in /usr/xenomai


does anybody know how to get around this problem?

Regards,

Juan
