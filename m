References: <HJ4i9nFdcaCaLnqZ6kJFqc-lsGhWGbI-ASP8PqZmkpGGD7FSSWYRIGgwLiVYMs-PiaD4SlaygjbJBCaGS8oZb3iZOS8XQzXw4kt2zzTgGyk=@protonmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Compiling xenomai-linux 5.10.83
Date: Wed, 23 Feb 2022 09:07:11 +0100
In-reply-to: <HJ4i9nFdcaCaLnqZ6kJFqc-lsGhWGbI-ASP8PqZmkpGGD7FSSWYRIGgwLiVYMs-PiaD4SlaygjbJBCaGS8oZb3iZOS8XQzXw4kt2zzTgGyk=@protonmail.com>
Message-ID: <87ley2f1f8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrew <andrew.penner@protonmail.com>
Cc: xenomai@xenomai.org


Andrew via Xenomai <xenomai@xenomai.org> writes:

> Hi,
>
> I am trying to work on a project that is easiest to accomplish if I base my changes on a product that is based on the mainline linux kernel 5.10.83.
>
> I will explain the steps I took to get to the version I am interested in:
>
> - I checkout the v5.10.y-evl-rebase branch of https://source.denx.de/Xenomai/xenomai4/linux-evl.git
>
> - I look in Makefile to see the kernel version is at 5.10.99
> - I run make menuconfig to see what options I need to set to enable the EVL kernel
>
> - Processor types and features ---> EVL real time core
> - I then look at git log to find the hash just before the integration of 5.10.84
>
> - e6edaf2677939a8cf57e9152b1ab07b80f83fa11
> - I assume this would be the latest set of changes that allow xenomai to work with the mainline kernel 5.10.83
> - I run make menuconfig
>
> - We no longer have any options (that I can see) to configure the EVL core
>
> Does my approach make sense to get the xenomai version that was compatible with the mainline kernel 5.10.83?
>

That won't work because this is a rebase branch, meaning that EVL sits
on top of the mainline tip, therefore #e6edaf26 is below the first
commit introducing the EVL code.

> I understand you are all busy, but any advice/direction/web pages that describe what I need to do would be appreciated.
>

There are several ways to do this, but in your case, the easiest would
be to check out this tag: v5.10.83-evl1-rebase. There is no additional
EVL code between v5.10.83-evl1-rebase and v5.10.99-evl1-rebase.

-- 
Philippe.

