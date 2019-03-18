Date: Mon, 18 Mar 2019 23:42:09 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Reply-To: Alec Ari <neotheuser@ymail.com>
Message-ID: <346474268.7105385.1552952529231@mail.yahoo.com>
In-Reply-To: <7125eb31-9429-bcd1-2821-ca78ed2e0755@gmail.com>
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
 <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
 <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
 <544217707.857557.1552467189711.JavaMail.zimbra@wolfram.com>
 <1283d7c0-b719-8c63-6c7f-abbefe269a7a@gmail.com>
 <192645678.5721329.1552685329163@mail.yahoo.com>
 <cece8f69-d8c5-7165-e918-444398bea154@gmail.com>
 <990066230.5891305.1552722294814@mail.yahoo.com>
 <79b82a59-788d-e7b5-8465-8fb1d37bc20c@gmail.com>
 <1723459381.6926353.1552936352861@mail.yahoo.com>
 <697763087.6947921.1552936385419@mail.yahoo.com>
 <7125eb31-9429-bcd1-2821-ca78ed2e0755@gmail.com>
Subject: Re: Cobalt compatible distribution
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Newbold <d.o.newbold@gmail.com>, Xenomai--- via Xenomai <xenomai@xenomai.org>

Oh boy, just when I thought I understood your question.

Xenomai git sources currently supports the 4.4 series, 4.9 series, and 4.14.


If you want 4.14 support, use this one:
https://gitlab.denx.de/Xenomai/ipipe-x86

Then follow this guide, starting at "Installing the Cobalt core:"

https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_3

Basically the steps are, for 4.14:

$ git clone https://gitlab.denx.de/Xenomai/ipipe-x86
$ git clone https://gitlab.denx.de/Xenomai/xenomai


$ cd ipipe-x86 && bash ../xenomai/scripts/prepare-kernel.sh --arch=x86
$ make menuconfig

Enable IPIPE, Cobalt core, etc. configure to your needs. I'm going off memory here but I'm pretty sure that's it, kernel side anyway.

When you're done:

$ cd xenomai && ./scripts/bootstrap && ./configure && make && sudo make install

For configure parameters:

$ ./configure --help


Alright, am I missing anything?


Alec

