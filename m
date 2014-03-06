Message-ID: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Date: Thu, 6 Mar 2014 01:46:42 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] process behaviour when running xenomai
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm running Xenomai 2.6.3 with kernel 3.10.18 now on BeagleBoard-Xm Rev. C and experience this behaviour: when I try to install packages from commandline, the installation manager starts quick and reads the package(s), but after that it stays dead quiet like it's frozen. ps -ef shows it's just going on, no defunc or anything like that. Also, when I want to watch the processes using top, it starts, but nothing shows. When I want to end it, Ctl-C gives no response giving me no other option than to use kill. Is this a known behaviour when running Xenomai ?


Thanks,

hvn
