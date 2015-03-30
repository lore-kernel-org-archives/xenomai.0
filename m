Message-ID: <55195485.9070302@xenomai.org>
Date: Mon, 30 Mar 2015 15:49:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7615c5d3d380485499b229435e14ee65@MUC-S-EX13B.advaoptical.com>
In-Reply-To: <7615c5d3d380485499b229435e14ee65@MUC-S-EX13B.advaoptical.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX
 routines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/30/2015 03:40 PM, Sagi Maimon wrote:
> Hi,
> 
> Until now I have created RT xenomai threads, by using the skin native API:
> kernel/xenomai/skins/native/task.c  (rt_task_create routine)
> 
> and for creating Linux threads, I have used the "pthread_create" routine (.../powerpc-e300c3-linux-gnu/usr/lib/libpthread.so)
> 
> xenomai also implements POSIX API:
> kernel/xenomai/skins/posix/thread.c
> And by looking at the code (and according to documentation), by calling "pthread_create" routine , xenomai creates RT threads.
> 
> 
> My question:
> I want to use the xenomai POSIX API, so How can I use the xenomai  "pthread_create" routine, instead of the one from (.../powerpc-e300c3-linux-gnu/usr/lib/libpthread.so)?
> should I add something to my Makefile?
> Should I remove "-lpthread" parameter from my application Makefile?
> 

This document explains how to create real-time POSIX applications with
Xenomai:

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Compilation_for_the_Xenomai_POSIX_skin

-- 
Philippe.

