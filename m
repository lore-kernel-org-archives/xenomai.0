References: <c18d4353-ec28-fcd3-884f-92cad7cf376e@siemens.com>
 <CALLqZ8SOcRyv2CFebVmNNLkQV_ZhpuVHw5+7V7kLSWTYH3ELJw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a40d275c-2745-a89a-0438-c9d8cbd610b5@siemens.com>
Date: Wed, 5 Sep 2018 09:21:18 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8SOcRyv2CFebVmNNLkQV_ZhpuVHw5+7V7kLSWTYH3ELJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [RFC][PATCH] Add CONTRIBUTING guide and workflow
 explanation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-09-05 06:26, Greg Gallagher wrote:
> 
> On Tue, Sep 4, 2018 at 1:31 PM Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     Shall both help new comers to understand in which form patches are
>     requested and what will happen to them normally after submitting them.
> 
>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>     ---
> 
>     I'm looking for honest feedback on this! Is it too much? Is something
>     missing? Is something seen differently?
> 
>     Basically, I took what I once created for Jailhouse and what we are also
>     using elsewhere now, slightly adjusting it for Xenomai. Shall be a
>     living document as we evolve workflows.
> 
>       CONTRIBUTING.md | 113
>     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>       1 file changed, 113 insertions(+)
>       create mode 100644 CONTRIBUTING.md
> 
>     diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
>     new file mode 100644
>     index 0000000000..4ee8b7cc1f
>     --- /dev/null
>     +++ b/CONTRIBUTING.md
>     @@ -0,0 +1,113 @@
>     +Contributing to Xenomai
>     +=======================
>     +
>     +Contributions to Xenomai are always welcome. This document explains
>     the general
>     +requirements on contributions and the recommended preparation
>     steps. It also
>     +sketches the typical integration process of patches.
>     +
>     +
>     +Contribution Checklist
>     +----------------------
>     +
>     +- use git to manage your changes [*recomended*]
>     +
>     +- follow Linux Kernel coding style, see also
>     +  [Linux kernel coding
>     style](https://www.kernel.org/doc/html/latest/process/coding-style.html)
>     [**required**]
>     +
>     +- add the required copyright header to each new file introduced
>     [**required**]
>     +
>     +- structure patches logically, in small steps [**required**]
>     +    - one separable functionality/fix/refactoring = one patch
>     +    - do not mix those there in a single patch
>     +    - after each patch, the tree still has to build and work, i.e.
>     do not add
>     +      even temporary breakages inside a patch series (helps when
>     tracking down
>     +      bugs)
>     +    - use `git rebase -i` to restructure a patch series
>     +
>     +- base patches on top of latest master or - if there are
>     dependencies - on next
>     +  (note: next is an integration branch that may change non-linearly)
>     +
>     +- test patches sufficiently AFTER the last edit (obvious, but...)
>     [**required**]
>     +
>     +- add signed-off to all patches [**required**]
>     +    - to certify the "Developer's Certificate of Origin", see below
>     +    - check with your employer when not working on your own!
>     +
>     +- indicate if you think a patch fixes a bug present in a stable
>     branch as well,
>     +  either in the cover letter of the patch series of after the "---"
>     separator
>     +  of the patch itself
>     +
>     +- post patches to mailing list [**required**]
>     +    - use `git format-patch/send-email` if possible
>     +    - send patches inline, do not append them
>     +    - no HTML emails!
>     +    - CC people who you think should look at the patches, e.g.
>     +      - affected maintainers
>     +      - someone who wrote a change that is fixed or reverted by you now
>     +      - who commented on related changes in the recent past
>     +      - who otherwise has expertise and is interested in the topic
>     +    - pull requests on gitlab are only optional
>     +
>     +- post follow-up version(s) if feedback requires this
>     +
>     +- send reminder if nothing happened after about two weeks
>     +
>     +
>     +Developer's Certificate of Origin 1.1
>     +-------------------------------------
>     +
>     +When signing-off a patch for this project like this
>     +
>     +    Signed-off-by: Random J Developer <random@developer.example.org
>     <mailto:random@developer.example.org>>
>     +
>     +using your real name (no pseudonyms or anonymous contributions),
>     you declare the
>     +following:
>     +
>     +    By making a contribution to this project, I certify that:
>     +
>     +        (a) The contribution was created in whole or in part by me
>     and I
>     +            have the right to submit it under the open source license
>     +            indicated in the file; or
>     +
>     +        (b) The contribution is based upon previous work that, to
>     the best
>     +            of my knowledge, is covered under an appropriate open
>     source
>     +            license and I have the right under that license to
>     submit that
>     +            work with modifications, whether created in whole or in
>     part
>     +            by me, under the same open source license (unless I am
>     +            permitted to submit under a different license), as
>     indicated
>     +            in the file; or
>     +
>     +        (c) The contribution was provided directly to me by some other
>     +            person who certified (a), (b) or (c) and I have not
>     modified
>     +            it.
>     +
>     +        (d) I understand and agree that this project and the
>     contribution
>     +            are public and that a record of the contribution
>     (including all
>     +            personal information I submit with it, including my
>     sign-off) is
>     +            maintained indefinitely and may be redistributed
>     consistent with
>     +            this project or the open source license(s) involved.
>     +
>     +See also [Sign your work - the Developer’s Certificate of
>     Origin](https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin)
>     +for further background on this process which was adopted from the
>     Linux kernel.
>     +
>     +
>     +Contribution Integration Process
>     +--------------------------------
>     +
>     +1. patch reviews performed on mailing list
>     +    * at least by maintainers, but everyone is invited
>     +    * feedback has to consider design, functionality and style
>     +    * simpler and clearer code preferred, even if original code
>     works fine
>     +
>     +2. accepted patches merged into next branch
>     +
>     +3. further testing done by community, including CI build tests,
>     code analyzer
>     +   runs, on-target tests
>     +
>     +4. if no new problems or discussions showed up, acceptance into master
>     +    * grace period for master: about 3 days
>     +    * urgent fixes may be applied sooner
>     +
>     +gitlab facilities are not used for the review process so that
>     people can follow
>     +all changes and related discussions at a single stop, the mailing
>     list. This
>     +may change in the future if gitlab should improve their email
>     integration.
>     -- 
>     2.16.4
> 
>     _______________________________________________
>     Xenomai mailing list
>     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>     https://xenomai.org/mailman/listinfo/xenomai
> 
> I like this, it puts us more inline with the mainline kernel work flow.  
>   Is there any benefit to creating a maintainers file?

For the Xenomai core, we do not really have a structure of 
submaintainers at this point, and I didn't want to mix up I-pipe with 
Xenomai in this document (where we do have role splits). If we want to 
cover I-pipe as well, that should be clearly identified.

>  Should we ask 
> that checkpatch.pl <http://checkpatch.pl> be run against patches as well?

We can add that as recommendation to he coding style section.

I'm not a fan of requiring to pass such checks literally. In the end, 
humans need to be happy with a consistent style, not scripts. But if 
someone has no clue how to achieve that, the script can be helpful.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

