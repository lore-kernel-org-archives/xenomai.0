References: <1998054025.14191234.1534328240874.JavaMail.zimbra@wolfram.com>
From: greg gallagher <greg@embeddedgreg.com>
Message-ID: <82841edd-ef01-5b5f-89f8-88305c0b1be1@embeddedgreg.com>
Date: Wed, 15 Aug 2018 09:59:37 -0400
MIME-Version: 1.0
In-Reply-To: <1998054025.14191234.1534328240874.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Build instructions for Xenomai outdated?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 2018-08-15 06:17 AM, Per Oberg wrote:
> I find that the build instructions on the wiki seems outdated:
>
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_3
>
> I'm not completely sure about this however. It suggests in several places building using mainline kernel and a ipipe-patch. I haven't downloaded any tarballs since I couldn't get in to the repo but I remembered something about the patching being deprecated in favor of using the git version instead.
>
> Should this be reflected on the wiki?
>
> Per Öberg
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
HI,
   The ipipe patch is always needed. You do have the option to use the 
ipipe trees directly in which case you don't need to patch mainline 
Linux because it's already done for you in the ipipe trees.
   The tarballs are different, those are just the Xenomai bits.  We are 
encouraging everyone to use the stable branch in git instead since it 
contains all the latest fixes.  I'll look at the installing instructions 
and update them accordingly.

Thanks very much for the feedback,

-Greg

