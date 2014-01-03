Message-ID: <52C68FC4.70004@denx.de>
Date: Fri, 03 Jan 2014 11:24:04 +0100
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
References: <1388416530-5865-1-git-send-email-sr@denx.de>
 <52C1EA3B.2030009@xenomai.org> <52C2608E.2030609@denx.de>
 <52C2813E.3040106@xenomai.org>
In-Reply-To: <52C2813E.3040106@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal/arm: Add Zynq v3.5.7 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 31.12.2013 09:33, Gilles Chanteperdrix wrote:
>> Its the other way around. The Xilinx code is based on Linux v3.5. And
>> the i-pipe patch is based on v3.5.7. So the pre-patch also includes the
>> move for the xilinx code from v3.5 to v3.5.7.
>>
>>> - they contain a defconfig file, if you want to make that file
>>> available, please put it to some ftp or http server somewhere and put
>>> the URL in the readme;
>>
>> Okay.
>>
>>> Really, the pre and post patches should be short, here they are enormous.
>>
>> Mostly because of the v3.5 -> v3.5.7 move for the Xilinx code. Should I
>> post this v3.5 -> v3.5.7 diff as a separate patch?
>>
> 
> One solution would be to dig the 3.5.0 patches from the I-pipe git, but
> that would mean backporting changes that were done later, and having to
> retest with 3.5 instead of 3.5.7.

Hmmm. I really would not want to move from an already well tested
"stable" 3.5.7 version back to v3.5.

> Another solution would be to get the Xilinx tree updated, and send
> patches to that updated tree.

Its very unlikely that this will happen. As Xilinx is not actively
maintaining older Linux versions once development has switched to a
newer one. So I don't expect them to accept patches to v3.5.

> If you can publish your updated git tree
> for the Xilinx tree, then base your pre- and post- patches on that
> updated git tree (it simply means that the README will contain
> references to the git tree you publish instead of Xilinx tree, so, it
> will not be much more complicated for users, they already have to use
> git anyway).

That's something I could do. Publish a git repository with the Xilinx
v3.5 sources and the v3.5 -> v3.5.7 patch on-top. And re-base my pre-
and post-patches (trimmed down, without the defconfig) for this git
repository. I'll try to send an updated patch next week.

Thanks,
Stefan

