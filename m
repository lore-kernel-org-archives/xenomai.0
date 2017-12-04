References: <b440d689-399e-32f1-c981-c66e655d955a@alaxarxa.net>
 <20171201161312.4b07fac3@md1em3qc>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <ffa39a0b-359c-1657-12e7-4fcfdb23d32b@alaxarxa.net>
Date: Mon, 4 Dec 2017 11:34:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171201161312.4b07fac3@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packages for Xenomai 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai List <xenomai@xenomai.org>

Hi,

On 01/12/17 16:13, Henning Schild wrote:
> Am Thu, 30 Nov 2017 12:27:22 +0100
> schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:
> 
>> Hi,
>>
>>
>> if someone is interested I have been working a bit with the debian
>> directory in xenomai3.
>>
>> I have changed the approach to the libraries. I think that now it has
>> not sense to have a libxenomai1 so I have changed it to xenomai3-libs.
>>
>> The source, and the patches applied are here:
>>
>> https://anonscm.debian.org/cgit/collab-maint/xenomai.git/
>>
>> In case there's some interest, I can try to push it again to the
>> official Debian repositories.
> 
> Publishing them to Debian would be the ideal case. 

Ok, so first go for it ;-)


But how about you
> send those patches to this list? After all we have the debian-subdir
> and people are using it!

Who? I think that current debian directory doesn't work for Xenomai 3. Did you try?

I'm from the opinion that the debian directory, to generate debian packages
doesn't belongs to upstream. But, I'm open to send any patch. Just I would like
to know if there are some critical mass.

> I am using it and i was wondering about the names, but never had a big
> enough issue to actually review what is going on in there.
> So please prepare a patchq and send it here.

Are you using it with Xenomai3?

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

