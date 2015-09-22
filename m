References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5600F8DE.30705@xenomai.org>
Date: Tue, 22 Sep 2015 08:44:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>, xenomai@xenomai.org

On 09/21/2015 02:15 PM, vibnwis wrote:
> Having managed to compile Xenomai apps and libs, I went to install them on
> target. The way I installed is by creating a xenomai directory in /usr and
> set PATH to /usr/xenomai/bin, /usr/xenomai/lib etc.
> However, when I ran latency I got this error message
>   0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory
> 
> and when I ran xeno latency -T 25, I got these error messages,
> 
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
>

/dev/rtheap is specific to Xenomai 2.x, it is irrelevant to Xenomai 3.x.
Looking at the log messages, you are definitely mixing 3.x kernel
support with 2.x libraries and executables. You may want to start from a
fresh and clean installation.

> In the installed directory, it does not have dev direcotry but bin, etc,
> sbin, lib, share, demo, include. The target does not have rtheap dev as
> well. Where and how it is created?
> 
> The dmesg | grep -i xenomai produced
> 
> [    0.666100] [Xenomai] scheduling class idle registered.
> [    0.666112] [Xenomai] scheduling class rt registered.
> [    0.666309] I-pipe: head domain Xenomai registered.
> [    0.668400] [Xenomai] Cobalt v3.0-rc7 (Exact Zero)
> 
> 
> Appreciate any comments, please.
> 
> thank you
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

