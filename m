References: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
 <28fd59c00f574c5a987ff73d72ffbc4c@andritz.com>
 <4078e730-9293-12b4-e3c2-843f0de5f637@alaxarxa.net>
 <285343492.3950889.1536911128629.JavaMail.zimbra@wolfram.com>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <32e5ed98-652a-bd2b-8b46-2424c42b9f7a@alaxarxa.net>
Date: Fri, 14 Sep 2018 15:54:51 +0200
MIME-Version: 1.0
In-Reply-To: <285343492.3950889.1536911128629.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 14/09/18 09:45, Per Oberg wrote:

[...]

> 
> Being able to use the same code, without patches or a lot of defines including other files is a very clean way of debugging your software. I often set up Simulations where I use my laptop running or our controller, possibly connected to remote hardware to debug stuff. For these cases  the POSIX skin is very useful.
> 
>>> As noted by Henning, please look at https://github.com/nolange/cmake_xenomai,
>>> could use some feedback =).
>>> Particularly look at the patchset which also removes some headaches with linking
>>> precompiled object file for bootstrapping (but needs some upstream changes).
> 
>> Norbert, I have followed your emails and your project. You did a good
>> job, but I don't agree with your approach. My points are:
> 
>> - You are trying to convert Xenomai a CMake project and this probably
>> will not happen because Upstream is very happy with the autotools. I
>> don't like to touch anything from upstream. Maybe some patch, but
>> incorporated in Upstream.
> 
> What do you mean with "convert Xenomai a CMake project"? I feel that I am missing something...
> Is it simply that  the "xeno-config" way of doing things isn't cmak-onic enough for a "real" CMake project or is there something deeper?

well, I'm sorry I have been not clear. I'm saying the Norbert is trying to
generate the config files that normally are generating by cmake.

Leopold
-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

