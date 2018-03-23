MIME-Version: 1.0
In-Reply-To: <20180323124215.53d92406@mmd1pvb1c.ad001.siemens.net>
References: <CAOuPNLh0inmNY6Vi6CDDranrF3iRv8zKeokfppbZCnoAVz=ZBQ@mail.gmail.com>
 <20180323124215.53d92406@mmd1pvb1c.ad001.siemens.net>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 23 Mar 2018 18:55:27 +0530
Message-ID: <CAOuPNLhr5GAznXwfSEke1Z8jAa0CCXgK2aCD1_N1HYo57mjMWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] FUSE package error while doing configure for xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Mar 23, 2018 at 5:12 PM, Henning Schild
<henning.schild@siemens.com> wrote:
> Am Fri, 23 Mar 2018 11:36:48 +0530
> schrieb Pintu Kumar <pintu.ping@gmail.com>:
>
>> Hi,
>>
>> I am trying to install xenomai-3 again.
>> # ./script/bootstrap
>>
>> After this, when I do configure, it is stopped at FUSE
>> # ./configure
>> ....
>> ....
>> checking whether the registry should be enabled... no
>> ./configure: line 13838: syntax error near unexpected token `FUSE,'
>> ./configure: line 13838: `      PKG_CHECK_MODULES(FUSE, fuse)'
>>
>> How to solve this problem ?
>> If anybody have come across this problem?
>
> Yes, it is known. You will have to install "pkg-config", or the
> equivalent if you are not on Debian.
>

Yes, I already installed it.
pkg-config is already the newest version (0.29.1-u.4.0.0.2).
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.

Looks like some problem with fuse.

# apt-get install fuse
Reading package lists... Done
Building dependency tree
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 fuse : Depends: libfuse2 (= 2.9.3-u.4.0.0.1) but 2.9.7-u.4.0.0.2 is
to be installed
E: Unable to correct problems, you have held broken packages.




> Henning
>
>> I tried installing : fuse, libfuse2, but it did not help.
>>
>> Please help!
>>
>>
>> Thanks,
>> Pintu
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>

