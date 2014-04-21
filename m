Message-ID: <535539E6.90306@xenomai.org>
Date: Mon, 21 Apr 2014 17:31:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5352BA1D.7070707@xenomai.org>
 <1398061722.33492.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <5354D3AB.3020009@xenomai.org>
 <1398083901.18170.YahooMailNeo@web163905.mail.gq1.yahoo.com>
In-Reply-To: <1398083901.18170.YahooMailNeo@web163905.mail.gq1.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Pre/Post patches
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

On 04/21/2014 02:38 PM, Huub Van Niekerk wrote:
> On Monday, April 21, 2014 10:15 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
> Le 21/04/2014 08:28, Huub Van Niekerk a écrit :
>>> On Saturday, April 19, 2014 8:07 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> 
>>> Hi all,
>> 
>>> I am currently validating the I-pipe patch for Linux 3.14 on
>>> armv4 and armv5, but it should already work for armv6 and armv7
>>> processors, it is available as a branch for-ipipe-3.14.0 in
>>> ipipe-gch git. Could you have a look at it on BeagleBone,
>>> Raspberry and Zynq? For the SOCs supported by mainline, please
>>> simply send patches to the for-ipipe-3.14.0 branch.
>> 
>> Hi,
>> 
>> When looking at
>> http://git.xenomai.org/ipipe-gch.git/?h=for-ipipe-3.14.0 , I think
>> I see several patches but I'm not sure how to act to get a patch
>> for the armv7 (armhf / beagle-xm).
> 
>> Note that the mail was intended for BeagleBone, Raspberry and Zynq.
>> For beagleboard, the kernel should already work, and you can wait
>> for the final I-pipe patch to be released. But if you want to
>> validate the kernel early, please go ahead, it will not hurt.
> 
>> Simply checkout this tree, and use it with the "prepare-kernel.sh" 
>> script, it will detect that the tree already contains the I-pipe 
>> changes, and will not try and apply an I-pipe patch.
> 
> Ok, I think I will wait for the final I-pipe patch then (assuming it
> won't be a long wait). BTW, with this be for version 2.6.3 or a new
> version ?

We will have to release 2.6.4.

-- 
                                                                Gilles.

