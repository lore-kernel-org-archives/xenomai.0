References: <a01aeee1-306e-ba93-2a57-02a744f0e818@utpvision.it>
 <24f99f30-49c9-c4e7-5409-ac64b0f2894b@alaxarxa.net>
 <21c4631c-0003-0490-6ea7-c3afa6741ada@utpvision.it>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <e2e995ad-c134-828a-341e-b60ee7e4fef1@alaxarxa.net>
Date: Wed, 10 Jan 2018 15:03:51 +0100
MIME-Version: 1.0
In-Reply-To: <21c4631c-0003-0490-6ea7-c3afa6741ada@utpvision.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.6 doesn't build the patched kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Simone M. Zucchi" <simone.zucchi@utpvision.it>, xenomai@xenomai.org

Hi Smone,

I think that we have missed something in our mails.

On 10/01/18 14:04, Simone M. Zucchi wrote:
> Hello,
> thank you.
> I cloned that git and proceeded the standard way (prepare-kernel.sh) but it
> fails anyway:

then, you have to create the debian packages. debuild would be fine. You must
ensure that the patches are applied, specially:

0005-do-not-require-SYS3264-when-reading-syscall-defs.patch

after build the packages install them with dpkg -i.

Then, following the classical documentation, run the prepare-kernel.sh and build
the kernel.

[...]
> 
> 
> I'm using kernel 4.9.51 with its relative ipipe patch...
> Am I doing something wrong?

I think that you are using a version of xenomai not patched for this issue.


Best regards,

Leopold


> Thanks,
> 
> Simone
> 
> On 01/09/2018 10:24 AM, Leopold Palomo-Avellaneda wrote:
>> On 09/01/18 09:33, Simone M. Zucchi wrote:
>>> Hello everybody,
>>> I've looked up at
>>> https://xenomai.org/pipermail/xenomai/2017-November/037941.html and got the same
>>> situation.
>>> I was wondering if something has moved since November about Debian and 3.0.6.
>>> Thanks,
>> Please,
>>
>> check this repo
>>
>> https://anonscm.debian.org/gitweb/?p=collab-maint/xenomai.git
>>
>> that has the patches to solve this issue
>>
>> Leopold
>>
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

