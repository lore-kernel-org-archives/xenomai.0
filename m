Message-ID: <5318A1DF.9010502@xenomai.org>
Date: Thu, 06 Mar 2014 17:27:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
In-Reply-To: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] process behaviour when running xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2014 10:46 AM, Huub Van Niekerk wrote:
> Hi,
> 
> I'm running Xenomai 2.6.3 with kernel 3.10.18 now on BeagleBoard-Xm
> Rev. C and experience this behaviour: when I try to install packages
> from commandline, the installation manager starts quick and reads the
> package(s), but after that it stays dead quiet like it's frozen. ps
> -ef shows it's just going on, no defunc or anything like that. Also,
> when I want to watch the processes using top, it starts, but nothing
> shows. When I want to end it, Ctl-C gives no response giving me no
> other option than to use kill. Is this a known behaviour when running
> Xenomai ?

No, obviously not. What does "dmesg" say when you are in that state?
-- 
                                                                Gilles.

