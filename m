Message-ID: <500150A5.3080204@xenomai.org>
Date: Sat, 14 Jul 2012 12:57:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1342263328.84866.YahooMailNeo@web120605.mail.ne1.yahoo.com>
In-Reply-To: <1342263328.84866.YahooMailNeo@web120605.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.0 example run error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jignesh Patel <jigneshj.patel@yahoo.com>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/14/2012 12:55 PM, Jignesh Patel wrote:
> Hi,
> 
> Thank you very much gilles for your kind support to solve my xenomai adeos patching error.
> 
> Now Xenomai installed and i can boot ubuntu with xenomai 2.6.0

You should install xenomai 2.6.1 now.

> 
> But when I trying to run example given in xenomai root it gives bellow error: 
> 
> 
> root@new-desktop:/usr/src/xenomai-2.6.0/examples/native# ./trivial-periodic 
> 
> 
> Error:   Xenomai: /dev/rtheap is missing (chardev, major=10 minor=254) 

Did you run "make install" as root ?

-- 
                                                                Gilles.

