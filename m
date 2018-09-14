Message-ID: <5aa5d267d8b80535427998f2bf4c9d9eceaae2c4.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Fri, 14 Sep 2018 10:22:18 +0200
In-Reply-To: <285343492.3950889.1536911128629.JavaMail.zimbra@wolfram.com>
References: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
 <28fd59c00f574c5a987ff73d72ffbc4c@andritz.com>
 <4078e730-9293-12b4-e3c2-843f0de5f637@alaxarxa.net>
 <285343492.3950889.1536911128629.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Order options to build a Xenomai program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

Le vendredi 14 septembre 2018 à 02:45 -0500, Per Oberg a écrit :
> 
> This! 
> 
> Being able to use the same code, without patches or a lot of defines
> including other files is a very clean way of debugging your software.
> I often set up Simulations where I use my laptop running or our
> controller, possibly connected to remote hardware to debug stuff. For
> these cases  the POSIX skin is very useful.

I thought that was the purpose of the mercury core.

For a full xenomai application, the wrapping mechanism is nice. For a
mixed rt / non-rt executable, this tends to be full of pitfalls. The
__RT and __STD macros are of a great help in this regard. 

I also still wonder if there’s a way to make std::thread work in such a
mixed environment.

> What do you mean with "convert Xenomai a CMake project"? I feel that
> I am missing something...

I think it means "build xenomai with cmake" (which is unlikely to
happen afaik).

Regards,

Julien

