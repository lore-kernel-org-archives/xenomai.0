From: "Steven Seeger" <sseeger@mpl.com>
References: <01f101cdce3c$5dd719f0$19854dd0$@mpl.com>
	<021b01cdce3f$a9972990$fcc57cb0$@mpl.com>
In-Reply-To: <021b01cdce3f$a9972990$fcc57cb0$@mpl.com>
Date: Thu, 29 Nov 2012 11:21:33 -0500
Message-ID: <028401cdce4d$9a2f30c0$ce8d9240$@mpl.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] xenomai in vmware smp crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Disregard my email. I did search before posting, but found nothing. I did
another search after posting for "ipipe.c:592" and found it.

This patch solved my problem:

http://www.mail-archive.com/xenomai@xenomai.org/msg01010.html

Thanks,
Steven


-----Original Message-----
From: Steven Seeger [mailto:sseeger@mpl.com] 
Sent: Thursday, November 29, 2012 9:42 AM
To: xenomai@xenomai.org
Subject: Re: [Xenomai] xenomai in vmware smp crash

I should mention that this is 3.2.31 and it's using the ipipe 3.2.21-x86-1
patch.



_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


