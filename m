MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Sat, 13 Jan 2018 16:34:34 +0100
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
In-Reply-To: <44tvwmwd0u.fsf@lowell-desk.lan>
References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
 <44y3lywp2s.fsf@lowell-desk.lan>
 <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
 <44tvwmwd0u.fsf@lowell-desk.lan>
Message-ID: <83268fef807a6af61181eb55cac6ce4f@smile.fr>
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

Hi,

I did a meta-xenomai layer for Yocto (Morty) and Pi 3.

https://github.com/pficheux/meta-xenomai/tree/morty

regards

-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                              http://www.smile.fr
                              https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source 
code

Le 2017-12-19 23:47, Lowell Gilbert a écrit :
> Steve Pavao <stevep@korgrd.com> writes:
> 
>> Thanks for that tip.  That’s what I was thinking I might need to do.
>> 
>> I guess the solution in Yocto terms is to rework my I-PIPE patch
>> recipe to not directly apply the I-PIPE patch, but rather to call
>> prepare-kernel.sh and allow it to apply the patch, plus do the other
>> things it needs to do.  I guess that should happen in a 
>> do_configure()
>> {} block.
> 
> That's very much the sort of workflow towards which I was planning to 
> move.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

