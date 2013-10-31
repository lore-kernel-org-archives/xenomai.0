MIME-Version: 1.0
In-Reply-To: <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
 <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
 <CAKS01om0rP3i3eAux+SC1Zt4-0-NdqOwLhg_8HQP4yjCiX2t2A@mail.gmail.com>
 <CADVgf9mprWu-s+1gNzhrHtXQf6d3u87P7AQ3eNd0=cdg6zWnvQ@mail.gmail.com>
 <CAKS01okXjCV9v6vJ9W8UoqJ6d57h1rQvkPSbGOUugc5gymhyjg@mail.gmail.com>
 <CADVgf9kPw+q77x30UU=bRiZ039NsKd+83Mdv2iMZvHNxKb-hAA@mail.gmail.com>
Date: Thu, 31 Oct 2013 14:36:19 +0100
Message-ID: <CAKS01oncDWRS8rfyrBw2ctRSR=WX6Jyqp4=+jyRNPgpwqq_91g@mail.gmail.com>
From: Anup Kini <akini@synapticon.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai - zynq - linux-xlxn14.5 - booting halted !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks a lot for correcting me Matt.

I would like to confirm one more thing regarding the ipipe xenomai patch.
which ipipe patch should i use ?
1 - ipipe-core-3.8.13-arm-3.patch - this is availabe in the xenomai patches
folder.
2 - ipipe-core-3.8-arm-1.patch - this is availabe from
http://download.gna.org/adeos/patches/v3.x/arm/

I cross checked the two patches and there are many additions in [1] related
to debug and other things i could not understand.




On 31 October 2013 12:27, Matthew Fornero <mfornero.lists@gmail.com> wrote:

> On Thu, Oct 31, 2013 at 5:37 AM, Anup Kini <akini@synapticon.com> wrote:
> > Hi Matt,
> >
> > Here is a pastebin link for the entire defconfig =
> > http://pastebin.com/4GeT1wRA
> > and this is the link to the .config generated =
> http://pastebin.com/UFXZzEdL
>
> CONFIG_CPU_FREQ needs to be cleared, at a minimum. There's even a
> warning in your .config about it (line 216); though maybe this gets
> missed if you make defconfig and then build
>
> If you're still having issues after that, you might check this thread
> for a few other .config changes you could try (though I don't think
> they mattered in the end)
>
> http://www.mail-archive.com/xenomai@xenomai.org/msg02455.html
>
> -Matt
>



-- 

*Anup Kini
*Systems Engineer****
*
------------------------------
*

*Synapticon** * |  Cyber-Physical System Solutions ****

Mobile:

Direct:

+49 151 / 638 646 73

+49 7335 / 186 999 21

Fax:****
+49 7335 / 186 999 1


 **

 ****

synapticon.com <http://www.synapticon.com/>  |
@synapticon_co<https://twitter.com/#!/synapticon_co>
****

Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
Registry Court Ulm HRB 725114  |  USt-ID DE271647127****

This message and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are addressed.
Please notify the sender immediately if you have received this e-mail by
mistake and delete it from your system.
