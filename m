References: <CALLqZ8ScsrUwM2H5WvoY_6iH5r42fx1AKkT807iri1KS=RV2Pw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <88a0b5c8-1033-f6a0-266a-69210190b27b@xenomai.org>
Date: Thu, 7 Dec 2017 11:38:55 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8ScsrUwM2H5WvoY_6iH5r42fx1AKkT807iri1KS=RV2Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Contributing Doc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>


Hi,

On 12/06/2017 06:00 AM, Greg Gallagher wrote:
> Hi,
>    I'm putting together a doc on how to contribute.  I've pasted it
> below, if anyone has some time to review and let me know what I've
> missed that would be great.
>   I wasn't sure if all development should take place against the next
> branch or not.

The current scheme is to only push bug fixes and maybe new drivers to
the stable-* branch, excluding any change that would prevent
applications based on earlier releases from the same branch from running
on later ones.

e.g. for the 3.0.x series, an app built for 3.0.2 must build with no
change on 3.0.6. Regarding ABI stability, the same app must run over a
3.0.6 kernel support without rebuilding.

The next branch is where new core features, new CPU architecture ports,
or large scale changes may go, breaking the ABI between applications and
the Cobalt core if need be.

  I'm also not sure if I linked the documents correctly
> or not in the getting setup section.
>   Once it's ready should this be sent to the mailing list as a patch
> against xenomai-kbase repo?

Patches may be easier for reviewing changes.

> 
> Thanks
> 
> Greg
> 
> 
> 
> How To Contribute
> =================
> 
> If you are interested in contributing to Xenomai here are some helpful hints on
> how to get started.
>

Start small, then progress as you get your feet wet. There is no such
thing as a minor contribution, there is no shame in making mistakes. A
contributor who submits a perfectible one-liner surely advances the
project further than any smart lurker.

> Things you will need:
>     - Git
>     - GCC for your platform

autotools too.

>     - Xenomai source code
>     - Linux tree patched with Ipipe
>     - Access to the Xenomai mailing list (xenomai@xenomai.org)
> 
> Getting Setup:
> --------------
> Before starting to contribute you should have read the following documents:
>     -link:Start_Here.adoc[]

the syntax is:

	link:<public-name-of-page>[text displayed as the active link]

	The page name is relative to the site root; for instance, a link
displayed as "foo" in the text, pointing at the "start here" page, would
be expressed as:

	link:start-here[foo]

You can figure out page names either by looking at the last part of an
existing page URL in your browser, or at the title line (first one,
underlined by '===') from each .adoc file. In the latter case, the title
string is converted to all lowercase, replacing non-alphanumeric chars
by a dash.

>     -link:Getting_Xenomai.adoc[]
>     -link:Installing_Xenomai_3.x.adoc[]
> 
> Workflow
> --------
> The above mentioned documents will guide you through acquiring the
> source code, getting the development environment set up, and building
> Xenomai.  If you are having issues getting your development
> environment setup or built please review the documents or consult the
> Xenomai mailing list.
> 
> To contribute to Xenomai, switch to the branch you'd like to make your
> changes on (next branch?).

Depends on the purpose as mentioned earlier.

  After you make your changes, one thing to
> keep in mind is that when you submit your patches to the the mailing
> list each patch should address exactly one issue.  You may want to
> make one commit for every patch you wish to generate.  This may
> be a good workflow if you are addressing more than one issue during development.
> 
> Once you are done development and testing you are ready to generate
> patches.  Use git format-patch to create a patch (or patch set) that
> you can submit for review.
> 
> Once we have generated our patch (or patches) we need to send them off
> the the mailing list for review. This can be done using git
> send-email.  This may be slightly tricky to set up, I suggest googling
> for the best way to set this up in your gitconfig file that best suits
> your email provider and authentication method. Once it is configured
> you can submit your patch to the mailing list.
> 

Generally speaking, the kernel part of Xenomai - aka Cobalt core - aims
at following the standard kernel coding style (i.e.
Documentation/CodingStyle).

-- 
Philippe.

